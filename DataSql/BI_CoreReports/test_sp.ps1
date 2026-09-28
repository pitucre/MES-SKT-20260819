param([string]$OutFile = "C:\Users\Administrator\AppData\Local\Temp\opencode\test_sp.txt")
$ErrorActionPreference = 'Stop'
$cs = 'Data Source=172.16.5.144;Initial Catalog=LeanMes;User Id=sa;Password=SAsa123;Connect Timeout=30'
$sb = New-Object System.Text.StringBuilder
function W($s) { [void]$sb.AppendLine($s) }

function Run-Proc($proc, $bizParams, $pageSize, $pageIndex) {
  $cn = New-Object System.Data.SqlClient.SqlConnection $cs
  try {
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandType = [System.Data.CommandType]::StoredProcedure
    $cmd.CommandText = $proc
    foreach ($kv in $bizParams.GetEnumerator()) {
      $p = $cmd.Parameters.Add($kv.Key, [System.Data.SqlDbType]::VarChar, 200)
      $p.Value = [string]$kv.Value
    }
    $hasPaging = ($pageSize -ge 0)
    if ($hasPaging) {
      $pp = $cmd.Parameters.Add('@PageSize', [System.Data.SqlDbType]::Int); $pp.Value = $pageSize
      $pi = $cmd.Parameters.Add('@PageIndex', [System.Data.SqlDbType]::Int); $pi.Value = $pageIndex
    }
    $pt = $cmd.Parameters.Add('@TotalCount', [System.Data.SqlDbType]::Int)
    $pt.Direction = [System.Data.ParameterDirection]::Output
    $da = New-Object System.Data.SqlClient.SqlDataAdapter $cmd
    $ds = New-Object System.Data.DataSet
    [void]$da.Fill($ds)
    return @{ Rows = $ds.Tables[0]; Total = $pt.Value }
  } finally { $cn.Close() }
}

function Show($proc, $biz, $ps, $pi, $label) {
  W ('=== ' + $label + ' | ' + $proc + ' | PageSize=' + $ps + ' PageIndex=' + $pi)
  try {
    $r = Run-Proc $proc $biz $ps $pi
    $t = $r.Rows
    W ('  cols: ' + (($t.Columns | ForEach-Object { $_.ColumnName }) -join ' | '))
    W ('  rowCount=' + $t.Rows.Count + ' TotalCount=' + $r.Total)
    $n = 0
    foreach ($row in $t.Rows) {
      $vals = @(); for ($i = 0; $i -lt $t.Columns.Count; $i++) { $vals += [string]$row[$i] }
      W ('  [' + $n + '] ' + ($vals -join ' | '))
      $n++
      if ($n -ge 5) { break }
    }
  } catch { W ('  ERR ' + $_.Exception.Message) }
  W ''
}

$eq = New-Object System.Collections.Hashtable
$eq['@StartDate'] = '2026-03-01'
$eq['@EndDate'] = '2026-09-25'
$eq['@EquipmentCode'] = ''
Show 'uspBI_MonthlyProductionReport' $eq -1 -1 'CHART full range'
Show 'uspBI_MonthlyProductionReport' $eq 10 1 'GRID page1'
Show 'uspBI_MonthlyProductionReport' $eq 10 999 'GRID page999 empty'

$eqDef = New-Object System.Collections.Hashtable
$eqDef['@StartDate'] = ''
$eqDef['@EndDate'] = ''
$eqDef['@EquipmentCode'] = ''
Show 'uspBI_MonthlyProductionReport' $eqDef -1 -1 'DEFAULT 6 months'

$eq2 = New-Object System.Collections.Hashtable
$eq2['@StartDate'] = '2026-03-01'
$eq2['@EndDate'] = '2026-09-25'
Show 'uspBI_MonthlyQualityReport' $eq2 -1 -1 'CHART quality full'
Show 'uspBI_MonthlyQualityReport' $eq2 10 1 'GRID quality page1'

$eq2Def = New-Object System.Collections.Hashtable
$eq2Def['@StartDate'] = ''
$eq2Def['@EndDate'] = ''
Show 'uspBI_MonthlyQualityReport' $eq2Def -1 -1 'DEFAULT quality 6 months'

$d = New-Object System.Collections.Hashtable
$d['@StartDate'] = '2026-09-01'
$d['@EndDate'] = '2026-09-25'
$d['@Shift'] = ''
Show 'uspBI_DailyWorkReport' $d -1 -1 'CHART daily full (all shifts)'
Show 'uspBI_DailyWorkReport' $d 10 2 'GRID daily page2'

$day = New-Object System.Collections.Hashtable
$day['@StartDate'] = '2026-09-01'
$day['@EndDate'] = '2026-09-25'
$day['@Shift'] = ([char]0x767D).ToString() + ([char]0x73ED).ToString()
Show 'uspBI_DailyWorkReport' $day -1 -1 'FILTER day shift only'

$dDef = New-Object System.Collections.Hashtable
$dDef['@StartDate'] = ''
$dDef['@EndDate'] = ''
$dDef['@Shift'] = ''
Show 'uspBI_DailyWorkReport' $dDef -1 -1 'DEFAULT daily 30 days'

[System.IO.File]::WriteAllText($OutFile, $sb.ToString(), [System.Text.UTF8Encoding]::new($false))
Write-Output 'DONE'
