param(
  [string[]]$Names = @(),
  [string]$OutFile = 'C:\Users\Administrator\AppData\Local\Temp\opencode\deploy_new_sp_result.txt'
)
$ErrorActionPreference = 'Stop'
$cs = 'Data Source=172.16.5.144;Initial Catalog=LeanMes;User Id=sa;Password=SAsa123;Connect Timeout=60'
$dir = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports\new_reports_20260925'
$enc = New-Object System.Text.UTF8Encoding($false)
if ($Names.Count -eq 0) { $Names = @(); foreach ($f in Get-ChildItem -LiteralPath $dir -Filter '*.sql') { if ($f.BaseName -notlike 'bak_*') { $Names += $f.BaseName } } }
$log = New-Object System.Text.StringBuilder
function W($s) { [void]$log.AppendLine($s) }
$cn = New-Object System.Data.SqlClient.SqlConnection $cs
$cn.Open()
try {
  foreach ($n in $Names) {
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
    $cmd3.CommandTimeout = 120
    $cmd3.CommandText = $sqlText
    try {
      [void]$cmd3.ExecuteNonQuery()
      W ("CREATED {0}" -f $n)
    } catch {
      W ("CREATE FAILED {0}: {1}" -f $n, $_.Exception.Message)
    }
  }
} finally { $cn.Close() }

$cn2 = New-Object System.Data.SqlClient.SqlConnection $cs
$cn2.Open()
try {
  foreach ($n in $Names) {
    $cmd = $cn2.CreateCommand()
    $cmd.CommandText = 'SELECT name, create_date FROM sys.procedures WHERE name = @n'
    [void]$cmd.Parameters.AddWithValue('@n', $n)
    $r = $cmd.ExecuteReader()
    if ($r.Read()) { W ("VERIFY {0} exists create_date={1}" -f [string]$r[0], [string]$r[1]) } else { W ("VERIFY {0} MISSING" -f $n) }
    $r.Close()
  }
} finally { $cn2.Close() }

[System.IO.File]::WriteAllText($OutFile, $log.ToString(), $enc)
Write-Output 'DONE'
