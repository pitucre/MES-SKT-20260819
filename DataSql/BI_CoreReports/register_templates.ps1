param([string]$LogFile = "C:\Users\Administrator\AppData\Local\Temp\opencode\register_log.txt")
$ErrorActionPreference = 'Stop'
$base = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports'
$enc = New-Object System.Text.UTF8Encoding($false)
Add-Type -Path 'E:\source\MES\SKT\20260819\Code\Lib\SKT.Common.Utility.dll'

$cfgPath = Join-Path $base 'register_config.json'
$cfg = [IO.File]::ReadAllText($cfgPath, $enc) | ConvertFrom-Json
$cs = 'Data Source=' + $cfg.server + ';Initial Catalog=' + $cfg.database + ';User Id=sa;Password=SAsa123;Connect Timeout=30'
$log = New-Object System.Text.StringBuilder
[void]$log.AppendLine('register start ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + ' target=' + $cfg.server + '/' + $cfg.database)

$script:encSeq = 0
function Invoke-TemplateEncode([string]$html) {
  $script:encSeq++
  $w = Join-Path $env:TEMP ('bi_enc_in_' + $script:encSeq + '.html')
  $o = Join-Path $env:TEMP ('bi_enc_out_' + $script:encSeq + '.txt')
  $j = Join-Path $env:TEMP ('bi_enc_' + $script:encSeq + '.js')
  $u16 = New-Object System.Text.UnicodeEncoding($false, $true)
  [IO.File]::WriteAllText($w, $html, $u16)
  $js = @'
var fso = new ActiveXObject("Scripting.FileSystemObject");
var inPath = WScript.Arguments(0);
var outPath = WScript.Arguments(1);
var ts = fso.OpenTextFile(inPath, 1, false, -1);
var src = ts.ReadAll();
ts.Close();
var enc;
try { enc = encodeURI(src); }
catch (e) { WScript.Echo("ENCODE_ERR " + e.message); WScript.Quit(2); }
var dec;
try { dec = decodeURI(enc); }
catch (e) { WScript.Echo("DECODE_ERR " + e.message); WScript.Quit(3); }
if (dec !== src) { WScript.Echo("ROUNDTRIP_MISMATCH"); WScript.Quit(4); }
var o = fso.OpenTextFile(outPath, 2, true, 0);
o.Write(enc);
o.Close();
WScript.Echo("srcLen=" + src.length + " encLen=" + enc.length);
'@
  [IO.File]::WriteAllText($j, $js, [Text.Encoding]::ASCII)
  $out = ''
  $code = -1
  $old = $ErrorActionPreference
  $ErrorActionPreference = 'Continue'
  try {
    $lines = & cscript //nologo $j $w $o
    $code = $LASTEXITCODE
    $out = ($lines | Out-String)
  } finally { $ErrorActionPreference = $old }
  Remove-Item -LiteralPath $w -Force -ErrorAction SilentlyContinue
  Remove-Item -LiteralPath $j -Force -ErrorAction SilentlyContinue
  if ($code -ne 0) {
    Remove-Item -LiteralPath $o -Force -ErrorAction SilentlyContinue
    throw ('encodeURI failed code=' + $code + ' out=' + $out.Trim())
  }
  $res = [IO.File]::ReadAllText($o, [Text.Encoding]::ASCII)
  Remove-Item -LiteralPath $o -Force -ErrorAction SilentlyContinue
  return $res
}

$failed = 0
foreach ($it in $cfg.items) {
  try {
    $htmlPath = Join-Path $base ($it.templateFile -replace '/', '\')
    if (-not (Test-Path -LiteralPath $htmlPath)) { throw ('template file not found: ' + $htmlPath) }
    $html = [IO.File]::ReadAllText($htmlPath, $enc)
    $encoded = Invoke-TemplateEncode $html
    $cipher = [SKT.Common.Utility.EncryptHelper]::Encrypt($encoded)
    [void]$log.AppendLine(('INFO {0} htmlLen={1} encLen={2} cipherLen={3}' -f $it.cnName, $html.Length, $encoded.Length, $cipher.Length))

    $cn = New-Object System.Data.SqlClient.SqlConnection $cs
    $cn.Open()
    try {
      $q = $cn.CreateCommand()
      $q.CommandText = @"
SELECT TOP 1 t.TemplateId, t.TemplateName
FROM Report_ResourcesMap rm WITH (NOLOCK)
INNER JOIN Report_Template t WITH (NOLOCK) ON LOWER(rm.ReportKey) = LOWER(t.TemplateName)
WHERE ISNULL(rm.IsKanban, 0) = 0 AND rm.ReportCNValues = @cn
"@
      [void]$q.Parameters.AddWithValue('@cn', [string]$it.cnName)
      $reportId = -1
      $reportName = [string]$it.cnName
      $mode = 'INSERT'
      $rd = $q.ExecuteReader()
      if ($rd.Read()) {
        $reportId = [int]$rd.GetValue(0)
        $reportName = [string]$rd.GetValue(1)
        $mode = 'UPDATE'
      }
      $rd.Close()
      [void]$log.AppendLine(('INFO {0} mode={1} reportId={2} reportName={3}' -f $it.cnName, $mode, $reportId, $reportName))

      $cmd = $cn.CreateCommand()
      $cmd.CommandText = 'Report_Template_Edit'
      $cmd.CommandType = [System.Data.CommandType]::StoredProcedure
      $p = $cmd.Parameters.Add('@ReportId', [System.Data.SqlDbType]::Int); $p.Value = $reportId
      $p = $cmd.Parameters.Add('@ReportName', [System.Data.SqlDbType]::NVarChar, 100); $p.Value = $reportName
      $p = $cmd.Parameters.Add('@ReportCNName', [System.Data.SqlDbType]::NVarChar, 50); $p.Value = [string]$it.cnName
      $p = $cmd.Parameters.Add('@ReportENName', [System.Data.SqlDbType]::NVarChar, 50); $p.Value = [string]$it.enName
      $p = $cmd.Parameters.Add('@ReportIcon', [System.Data.SqlDbType]::NVarChar, 50); $p.Value = [string]$it.icon
      $p = $cmd.Parameters.Add('@ReportSequence', [System.Data.SqlDbType]::Int); $p.Value = [int]$it.sequence
      $p = $cmd.Parameters.Add('@ReportType', [System.Data.SqlDbType]::NVarChar, 50); $p.Value = [string]$it.reportType
      $p = $cmd.Parameters.Add('@TemplateCategory', [System.Data.SqlDbType]::Int); $p.Value = 2
      $p = $cmd.Parameters.Add('@ReportDes', [System.Data.SqlDbType]::NVarChar, 50); $p.Value = [string]$it.description
      $p = $cmd.Parameters.Add('@ReportContent', [System.Data.SqlDbType]::NText); $p.Value = $cipher
      $p = $cmd.Parameters.Add('@CreateBy', [System.Data.SqlDbType]::VarChar, 20); $p.Value = [string]$cfg.createBy
      $p = $cmd.Parameters.Add('@ModifyBy', [System.Data.SqlDbType]::VarChar, 20); $p.Value = [string]$cfg.modifyBy
      [void]$cmd.ExecuteNonQuery()

      $q2 = $cn.CreateCommand()
      $q2.CommandText = @"
SELECT TOP 1 t.TemplateId, t.TemplateName, t.TemplateCategory, t.Report,
       p.Url, p.Popedom, p.Sequence, p.InMenu, p.Flag,
       rm.ReportCNValues, rm.ReportENValues, rm.IsKanban
FROM Report_ResourcesMap rm WITH (NOLOCK)
INNER JOIN Report_Template t WITH (NOLOCK) ON LOWER(rm.ReportKey) = LOWER(t.TemplateName)
LEFT JOIN FRAMEWORK_PAGES p WITH (NOLOCK) ON LOWER(p.Name) = LOWER(t.TemplateName)
WHERE ISNULL(rm.IsKanban, 0) = 0 AND rm.ReportCNValues = @cn
"@
      [void]$q2.Parameters.AddWithValue('@cn', [string]$it.cnName)
      $rd2 = $q2.ExecuteReader()
      if (-not $rd2.Read()) { throw 'readback failed: row not found' }
      $tid = $rd2.GetValue(0)
      $tname = [string]$rd2.GetValue(1)
      $cat = $rd2.GetValue(2)
      $rep = [string]$rd2.GetValue(3)
      $url = if ($rd2.IsDBNull(4)) { '' } else { [string]$rd2.GetValue(4) }
      $pop = if ($rd2.IsDBNull(5)) { 'NULL' } else { [string]$rd2.GetValue(5) }
      $seq = if ($rd2.IsDBNull(6)) { 'NULL' } else { [string]$rd2.GetValue(6) }
      $inm = if ($rd2.IsDBNull(7)) { 'NULL' } else { [string]$rd2.GetValue(7) }
      $flg = if ($rd2.IsDBNull(8)) { 'NULL' } else { [string]$rd2.GetValue(8) }
      $rd2.Close()
      $pageUrl = 'http://' + $cfg.server + '/' + $url
      [void]$log.AppendLine(('OK {0} TemplateId={1} TemplateName={2} Category={3} Report={4} Seq={5} InMenu={6} Flag={7} Popedom={8}' -f $it.cnName, $tid, $tname, $cat, $rep, $seq, $inm, $flg, $pop))
      [void]$log.AppendLine(('OK {0} Url={1}' -f $it.cnName, $pageUrl))
    } finally {
      $cn.Close()
    }
  } catch {
    $failed++
    [void]$log.AppendLine(('FAIL {0}: {1}' -f $it.cnName, $_.Exception.Message))
  }
}
[void]$log.AppendLine(('register end failed={0} time={1}' -f $failed, (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')))
[IO.File]::WriteAllText($LogFile, $log.ToString(), $enc)
Write-Output ('failed=' + $failed)
if ($failed -gt 0) { exit 1 }
