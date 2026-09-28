param([string]$OutFile = "C:\Users\Administrator\AppData\Local\Temp\opencode\test_p97.txt")
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
    $cmd.CommandTimeout = 120
    foreach ($kv in $bizParams.GetEnumerator()) {
      $p = $cmd.Parameters.Add($kv.Key, [System.Data.SqlDbType]::VarChar, 200)
      $p.Value = [string]$kv.Value
    }
    if ($pageSize -ge 0) {
      $pp = $cmd.Parameters.Add('@PageSize', [System.Data.SqlDbType]::Int); $pp.Value = $pageSize
      $pi = $cmd.Parameters.Add('@PageIndex', [System.Data.SqlDbType]::Int); $pi.Value = $pageIndex
    }
    $pt = $cmd.Parameters.Add('@TotalCount', [System.Data.SqlDbType]::Int)
    $pt.Direction = [System.Data.ParameterDirection]::Output
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $da = New-Object System.Data.SqlClient.SqlDataAdapter $cmd
    $ds = New-Object System.Data.DataSet
    [void]$da.Fill($ds)
    $sw.Stop()
    return @{ Rows = $ds.Tables[0]; Total = $pt.Value; Ms = $sw.ElapsedMilliseconds }
  } finally { $cn.Close() }
}

function Show($biz, $ps, $pi, $label) {
  W ('=== ' + $label + ' | PageSize=' + $ps + ' PageIndex=' + $pi)
  try {
    $r = Run-Proc 'uspBI_WorkOrderProductionReport_Program' $biz $ps $pi
    $t = $r.Rows
    W ('  cols: ' + (($t.Columns | ForEach-Object { $_.ColumnName }) -join ' | '))
    W ('  rowCount=' + $t.Rows.Count + ' TotalCount=' + $r.Total + ' ms=' + $r.Ms)
    $n = 0
    foreach ($row in $t.Rows) {
      $vals = @(); for ($i = 0; $i -lt $t.Columns.Count; $i++) { $vals += [string]$row[$i] }
      W ('  [' + $n + '] ' + ($vals -join ' | '))
      $n++
      if ($n -ge 8) { break }
    }
  } catch { W ('  ERR ' + $_.Exception.Message) }
  W ''
}

$d = New-Object System.Collections.Hashtable
$d['@StartDate'] = ''
$d['@EndDate'] = ''
$d['@OrderNo'] = ''
$d['@EquipmentCode'] = ''
Show $d -1 -1 'DEFAULT 30d full (chart path)'
Show $d 10 1 'GRID page1'
Show $d 10 999 'GRID page999 empty'

$f1 = New-Object System.Collections.Hashtable
$f1['@StartDate'] = '2026-09-01'
$f1['@EndDate'] = '2026-09-27'
$f1['@OrderNo'] = 'S260927'
$f1['@EquipmentCode'] = ''
Show $f1 -1 -1 'FILTER order prefix S260927'

$f2 = New-Object System.Collections.Hashtable
$f2['@StartDate'] = '2026-09-01'
$f2['@EndDate'] = '2026-09-27'
$f2['@OrderNo'] = ''
$f2['@EquipmentCode'] = '238456'
Show $f2 -1 -1 'FILTER legacy equip 238456'

$f3 = New-Object System.Collections.Hashtable
$f3['@StartDate'] = '2026-09-01'
$f3['@EndDate'] = '2026-09-27'
$f3['@OrderNo'] = 'NO_SUCH_ORDER_XYZ'
$f3['@EquipmentCode'] = ''
Show $f3 -1 -1 'EMPTY result'

$all = New-Object System.Collections.Hashtable
$all['@StartDate'] = '2025-08-01'
$all['@EndDate'] = '2026-09-27'
$all['@OrderNo'] = ''
$all['@EquipmentCode'] = ''
Show $all 10 1 'HISTORY 14 months page1'

[System.IO.File]::WriteAllText($OutFile, $sb.ToString(), [System.Text.UTF8Encoding]::new($false))
Write-Output 'DONE'
