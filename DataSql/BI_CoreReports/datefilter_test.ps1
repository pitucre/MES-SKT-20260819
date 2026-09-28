$ErrorActionPreference = 'Stop'
$enc = New-Object System.Text.UTF8Encoding($false)
$cs = 'Data Source=172.16.5.144;Initial Catalog=LeanMes;User Id=sa;Password=SAsa123;Connect Timeout=30'
$cn = New-Object System.Data.SqlClient.SqlConnection $cs
$cn.Open()
$out = New-Object System.Text.StringBuilder
function Run($sp, $params, $label) {
  $cmd = $script:cn.CreateCommand()
  $cmd.CommandText = $sp
  $cmd.CommandType = [System.Data.CommandType]::StoredProcedure
  foreach ($k in $params.Keys) { [void]$cmd.Parameters.AddWithValue($k, $params[$k]) }
  $r = $cmd.ExecuteReader()
  $n = 0; $months = @()
  while ($r.Read() -and $n -lt 4) { $months += [string]$r.GetValue(0); $n++ }
  $rest = 0; while ($r.Read()) { $rest++ }
  $r.Close()
  [void]$script:out.AppendLine(('{0}: rows={1} sample={2}' -f $label, ($n + $rest), ($months -join ',')))
}
try {
  $p1 = @{ '@StartDate' = '2026-09-01'; '@EndDate' = '2026-09-30'; '@EquipmentCode' = '' }
  Run 'uspBI_MonthlyProductionReport' $p1 'P90 Sep only'
  $p2 = @{ '@StartDate' = '2026-01-01'; '@EndDate' = '2026-03-31'; '@EquipmentCode' = '' }
  Run 'uspBI_MonthlyProductionReport' $p2 'P90 Jan-Mar'
  $p3 = @{ '@StartDate' = '2026-09-01'; '@EndDate' = '2026-09-30' }
  Run 'uspBI_MonthlyQualityReport' $p3 'Q90 Sep only'
  $p4 = @{ '@StartDate' = '2026-09-24'; '@EndDate' = '2026-09-25'; '@Shift' = '' }
  Run 'uspBI_DailyWorkReport' $p4 'P91 2 days'
} finally { $cn.Close() }
[IO.File]::WriteAllText('C:\Users\Administrator\AppData\Local\Temp\opencode\datefilter_test.txt', $out.ToString(), $enc)
Write-Output 'DONE'
