<#
.SYNOPSIS
  深科特 MES 数据库助手：export / apply / test（配合 .opencode/skills/mes-workflow 使用）
.DESCRIPTION
  固化的历史教训：
  - export: OBJECT_DEFINITION 不带类型码参数（OBJECT_ID(N'dbo.x', N'C') 会因类型码非法报错）
  - apply : 以 UTF-8 读脚本、按 GO 分批执行、整体包事务（默认 COMMIT，-NoTransaction 可关）
  - test  : 显式 SqlParameter 绑定（禁止字符串拼 EXEC），默认包事务且必 ROLLBACK（-Commit 才提交）
  - 输出 : 控制台切 UTF-8，结果打 ASCII 标签辅助定位
.EXAMPLE
  # 导出 179 上的存储过程定义为备份（输出 bak_<名>_<时间戳>.sql）
  Tools\sqlhelper.ps1 export -ObjectName uspBatchSNSplitCheckSN -Env 179 -OutDir DataSql\bugfix_20261010

  # 应用修改脚本到 179（整体事务，默认提交）
  Tools\sqlhelper.ps1 apply -File DataSql\bugfix_20261010\fix_uspBatchSNSplitCheckSN_Program.sql -Env 179

  # 带参干跑（强制事务回滚，安全测拦截路径）
  Tools\sqlhelper.ps1 test -File .\checksn.sql -Params @("@Mode=0","@SN=SNPC261016000004") -Env 179
  Tools\sqlhelper.ps1 test -Query "SELECT BatchQty FROM Prod_Unit WHERE SN=@SN" -Params @("@SN=xxx") -Env 179
.NOTES
  环境预设：179=PROD_TEST_MES(开发测试)  144=LeanMes(生产，只读分析/发布窗口)
  其它库用 -ConnString 覆盖。
#>
[CmdletBinding()]
param(
  [Parameter(Position = 0, Mandatory = $true)]
  [ValidateSet('export', 'apply', 'test')]
  [string]$Command,

  [ValidateSet('179', '144')]
  [string]$Env = '179',

  [string]$ConnString,

  # export 参数
  [string]$ObjectName,
  [string]$OutDir = '.',

  # apply / test 参数
  [string]$File,
  [string]$Query,
  [string[]]$Params = @(),
  [switch]$NoTransaction,   # apply: 不包事务
  [switch]$Commit           # test: 允许提交（默认强制 ROLLBACK）
)

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$OutputEncoding = [Text.Encoding]::UTF8

$PRESET = @{
  '179' = 'server=172.16.5.179;uid=sa;pwd=SAsa123;database=PROD_TEST_MES;Connect Timeout=60;Pooling=False'
  '144' = 'server=172.16.5.144;uid=sa;pwd=SAsa123;database=LeanMes;Connect Timeout=60;Pooling=False'
}
if (-not $ConnString) { $ConnString = $PRESET[$Env] }

function Get-SqlConnection {
  $csb = New-Object System.Data.SqlClient.SqlConnectionStringBuilder $ConnString
  $conn = New-Object System.Data.SqlClient.SqlConnection $csb.ConnectionString
  $conn.Open()
  Write-Host ("[CONN] {0} / {1}" -f $csb.DataSource, $csb.InitialCatalog)
  return $conn
}

function Add-SqlParams {
  param([System.Data.SqlClient.SqlCommand]$Cmd, [string[]]$ParamSpecs)
  foreach ($spec in $ParamSpecs) {
    if ($spec -notmatch '^(@\w+)\s*=\s*(.*)$') { throw ("[ERR] bad param spec (use @name=value): {0}" -f $spec) }
    $name = $Matches[1]; $raw = $Matches[2].Trim()
    if ($raw -eq 'NULL' -or $raw -eq '') {
      $p = $Cmd.Parameters.AddWithValue($name, [DBNull]::Value)
    }
    elseif ($raw -match '^\d+$')          { $p = $Cmd.Parameters.AddWithValue($name, [int]$raw) }
    elseif ($raw -match '^\d+\.\d+$')     { $p = $Cmd.Parameters.AddWithValue($name, [decimal]$raw) }
    elseif ($raw -match '^\d{4}-\d{2}-\d{2}') { $p = $Cmd.Parameters.AddWithValue($name, [datetime]$raw) }
    else {
      $p = $Cmd.Parameters.AddWithValue($name, [string]$raw.Trim("'"))
    }
    Write-Host ("[PARAM] {0} = {1}" -f $name, $(if ($p.Value -is [DBNull]) { 'NULL' } else { $p.Value }))
  }
}

function Write-ResultTables {
  param([System.Data.SqlClient.SqlDataReader]$Reader)
  # 注意：不能用 DataTable.Load（它会关闭 reader，后续 NextResult 抛错）；手工读取
  do {
    $colCount = $Reader.FieldCount
    if ($colCount -eq 0) { continue }
    $heads = @(); for ($i = 0; $i -lt $colCount; $i++) { $heads += $Reader.GetName($i) }
    Write-Host ('[TBL] ' + ($heads -join ' | '))
    $rowCount = 0
    while ($Reader.Read()) {
      $rowCount++
      $cells = @(); for ($i = 0; $i -lt $colCount; $i++) {
        $val = $Reader.GetValue($i)
        if ($null -eq $val -or $val -is [DBNull]) { $val = 'NULL' }
        $cells += ("{0}" -f $val)
      }
      Write-Host ('[ROW] ' + ($cells -join ' | '))
    }
    Write-Host ("[ROWS] {0}" -f $rowCount)
  } while ($Reader.NextResult())
}

function Invoke-Batches {
  param(
    [System.Data.SqlClient.SqlConnection]$Conn,
    [string]$SqlText,
    [System.Data.SqlClient.SqlTransaction]$Tx
  )
  # 按 GO 分批（支持 "GO 3"），兼容 OBJECT_DEFINITION 导出的标准格式
  $parts = [regex]::Split($SqlText, '(?im)^\s*GO\s*(\d+)?\s*$')
  # Split with capture group yields [batch, count, batch, count, ...]; reassemble honoring counts
  $batches = New-Object System.Collections.Generic.List[string]
  for ($i = 0; $i -lt $parts.Count; $i += 2) {
    $sql = $parts[$i]
    $repeat = 1
    if (($i + 1) -lt $parts.Count -and $parts[$i + 1] -match '^\d+$') { $repeat = [int]$parts[$i + 1] }
    if ([string]::IsNullOrWhiteSpace($sql)) { continue }
    for ($r = 0; $r -lt $repeat; $r++) { $batches.Add($sql) }
  }
  $n = 0
  foreach ($batch in $batches) {
    $n++
    $cmd = $Conn.CreateCommand()
    $cmd.CommandText = $batch
    if ($Tx) { $cmd.Transaction = $Tx }
    $null = $cmd.ExecuteNonQuery()
    Write-Host ("[BATCH] {0}/{1} ok ({2} chars)" -f $n, $batches.Count, $batch.Length)
  }
  return $batches.Count
}

$conn = $null; $tx = $null
try {
  $conn = Get-SqlConnection

  switch ($Command) {
    'export' {
      if (-not $ObjectName) { throw '[ERR] export requires -ObjectName' }
      $cmd = $conn.CreateCommand()
      # 故意不传类型码：OBJECT_ID(N'dbo.x', N'C') 这类写法在旧脚本里踩过坑
      $cmd.CommandText = 'SELECT OBJECT_DEFINITION(OBJECT_ID(@p))'
      $null = $cmd.Parameters.Add('@p', [Data.SqlDbType]::NVarChar, 256).Value = 'dbo.' + $ObjectName
      $def = $cmd.ExecuteScalar()
      if ($null -eq $def -or $def -is [DBNull]) { throw ("[ERR] object not found on server: {0}" -f $ObjectName) }
      $ts = Get-Date -Format 'yyyyMMddHHmmss'
      $fileName = 'bak_{0}_{1}.sql' -f $ObjectName, $ts
      if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }
      $path = Join-Path $OutDir $fileName
      $header = "-- BACKUP by sqlhelper export`r`n-- env={0} object={1} time={2}`r`n-- source={3}`r`n`r`n" -f $Env, $ObjectName, (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $ConnString.Split(';')[0]
      [IO.File]::WriteAllText($path, $header + $def, (New-Object Text.UTF8Encoding $true))
      Write-Host ("[OK] exported {0} bytes -> {1}" -f $def.Length, $path)
    }

    'apply' {
      if (-not $File) { throw '[ERR] apply requires -File' }
      $sqlText = [IO.File]::ReadAllText((Resolve-Path $File), [Text.Encoding]::UTF8)
      Write-Host ("[APPLY] file={0} chars={1}" -f $File, $sqlText.Length)
      if (-not $NoTransaction) { $tx = $conn.BeginTransaction() }
      $count = Invoke-Batches -Conn $conn -SqlText $sqlText -Tx $tx
      if ($tx) { $tx.Commit(); $tx = $null; Write-Host '[TX] COMMIT' }
      Write-Host ("[OK] applied {0} batch(es)" -f $count)
      Write-Host '[TODO] now verify via sys.sql_modules marker LIKE (see mes-workflow skill)'
    }

    'test' {
      if (-not $File -and -not $Query) { throw '[ERR] test requires -File or -Query' }
      $sqlText = if ($File) { [IO.File]::ReadAllText((Resolve-Path $File), [Text.Encoding]::UTF8) } else { $Query }
      $tx = $conn.BeginTransaction()  # test 永远包事务
      $cmd = $conn.CreateCommand()
      $cmd.Transaction = $tx
      # 单批：test 场景优先整段执行；含 GO 的脚本用批次执行
      if ($sqlText -match '(?im)^\s*GO\s*(\d+)?\s*$') {
        $null = Invoke-Batches -Conn $conn -SqlText $sqlText -Tx $tx
      } else {
        $cmd.CommandText = $sqlText
        Add-SqlParams -Cmd $cmd -ParamSpecs $Params
        $reader = $cmd.ExecuteReader()
        Write-ResultTables -Reader $reader
        $reader.Close()
      }
      if ($Commit) { $tx.Commit(); Write-Host '[TX] COMMIT (-Commit)' }
      else { $tx.Rollback(); Write-Host '[TX] ROLLBACK (default; test is non-destructive)' }
    }
  }
}
catch {
  if ($tx) { try { $tx.Rollback(); Write-Host '[TX] ROLLBACK (error path)' } catch { } }
  Write-Host ("[ERR] {0}" -f $_.Exception.Message)
  exit 1
}
finally {
  if ($conn) { $conn.Close() }
}
