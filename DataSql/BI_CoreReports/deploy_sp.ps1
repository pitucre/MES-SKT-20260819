param(
  [string[]]$Names = @('uspBI_MonthlyProductionReport', 'uspBI_MonthlyQualityReport', 'uspBI_DailyWorkReport'),
  [string]$OutFile = "C:\Users\Administrator\AppData\Local\Temp\opencode\deploy_sp_result.txt"
)
$ErrorActionPreference = 'Stop'
$cs = 'Data Source=172.16.5.144;Initial Catalog=LeanMes;User Id=sa;Password=SAsa123;Connect Timeout=30'
$dir = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports'
$enc = New-Object System.Text.UTF8Encoding($false)
$log = New-Object System.Text.StringBuilder
function W($s) { [void]$log.AppendLine($s) }

$cn = New-Object System.Data.SqlClient.SqlConnection $cs
$cn.Open()
try {
  foreach ($n in $names) {
    $f = Join-Path $dir ($n + '.sql')
    if (-not (Test-Path -LiteralPath $f)) { W ("MISSING FILE {0}" -f $f); continue }
    $sqlText = [System.IO.File]::ReadAllText($f, $enc)

    $cmd = $cn.CreateCommand()
    $cmd.CommandText = 'SELECT OBJECT_DEFINITION(OBJECT_ID(@id))'
    [void]$cmd.Parameters.AddWithValue('@id', 'dbo.' + $n)
    $existing = $cmd.ExecuteScalar()

    if (($existing -isnot [System.DBNull]) -and $existing) {
      $ts = Get-Date -Format 'yyyyMMddHHmmss'
      $bak = Join-Path $dir ('bak_' + $n + '_' + $ts + '.sql')
      [System.IO.File]::WriteAllText($bak, [string]$existing, $enc)
      W ("BACKUP {0}" -f $bak)
      $cmd2 = $cn.CreateCommand()
      $cmd2.CommandText = 'DROP PROCEDURE [dbo].[' + $n + ']'
      [void]$cmd2.ExecuteNonQuery()
      W ("DROPPED {0}" -f $n)
    } else {
      W ("NEW {0} (no backup needed)" -f $n)
    }

    $cmd3 = $cn.CreateCommand()
    $cmd3.CommandText = $sqlText
    [void]$cmd3.ExecuteNonQuery()
    W ("CREATED {0}" -f $n)
  }
} finally { $cn.Close() }

$cn2 = New-Object System.Data.SqlClient.SqlConnection $cs
$cn2.Open()
try {
  foreach ($n in $names) {
    $cmd = $cn2.CreateCommand()
    $cmd.CommandText = "SELECT name, create_date FROM sys.procedures WHERE name = @n"
    [void]$cmd.Parameters.AddWithValue('@n', $n)
    $r = $cmd.ExecuteReader()
    if ($r.Read()) { W ("VERIFY {0} exists create_date={1}" -f [string]$r[0], [string]$r[1]) } else { W ("VERIFY {0} MISSING" -f $n) }
    $r.Close()
  }
} finally { $cn2.Close() }

[System.IO.File]::WriteAllText($OutFile, $log.ToString(), $enc)
Write-Output 'DONE'
