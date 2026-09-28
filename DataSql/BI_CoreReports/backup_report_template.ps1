param([string]$OutDir = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports')
$ErrorActionPreference = 'Stop'
$enc = New-Object System.Text.UTF8Encoding($false)
$base = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports'
$cfg = [IO.File]::ReadAllText((Join-Path $base 'register_config.json'), $enc) | ConvertFrom-Json
$cs = 'Data Source=' + $cfg.server + ';Initial Catalog=' + $cfg.database + ';User Id=sa;Password=SAsa123;Connect Timeout=30'
$ts = Get-Date -Format 'yyyyMMddHHmmss'

$inList = ($cfg.items | ForEach-Object { "N'" + ([string]$_.cnName).Replace("'", "''") + "'" }) -join ','
$sql = @"
SELECT rm.ReportCNValues, t.TemplateId, t.TemplateName, t.TemplateContent
FROM dbo.Report_ResourcesMap rm WITH (NOLOCK)
INNER JOIN dbo.Report_Template t WITH (NOLOCK) ON LOWER(rm.ReportKey) = LOWER(t.TemplateName)
WHERE ISNULL(rm.IsKanban, 0) = 0 AND rm.ReportCNValues IN ($inList)
ORDER BY t.TemplateId
"@

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('-- BI report templates backup ' + $ts + ' (server=' + $cs + ')')
$cn = New-Object System.Data.SqlClient.SqlConnection $cs
try {
  $cn.Open()
  $cmd = $cn.CreateCommand()
  $cmd.CommandText = $sql
  $da = New-Object System.Data.SqlClient.SqlDataAdapter $cmd
  $ds = New-Object System.Data.DataSet
  [void]$da.Fill($ds)
  $n = 0
  foreach ($row in $ds.Tables[0].Rows) {
    $n++
    [void]$sb.AppendLine(('---- {0} | TemplateId={1} | TemplateName={2} ----' -f [string]$row[0], [int]$row[1], [string]$row[2]))
    [void]$sb.AppendLine([string]$row[3])
  }
  $out = Join-Path $OutDir ('bak_Report_Template_BI' + ($cfg.items.Count) + '_' + $ts + '.sql')
  [IO.File]::WriteAllText($out, $sb.ToString(), $enc)
  Write-Output ('rows=' + $n + ' file=' + $out)
} finally { $cn.Close() }
