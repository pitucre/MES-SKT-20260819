param([string]$OutFile = "C:\Users\Administrator\AppData\Local\Temp\opencode\verify_w12.txt")
$ErrorActionPreference = 'Stop'
$base = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports'
$enc = New-Object System.Text.UTF8Encoding($false)
Add-Type -Path 'E:\source\MES\SKT\20260819\Code\Lib\SKT.Common.Utility.dll'

$cfg = [IO.File]::ReadAllText((Join-Path $base 'register_config_w12.json'), $enc) | ConvertFrom-Json
$cs = 'Data Source=' + $cfg.server + ';Initial Catalog=' + $cfg.database + ';User Id=sa;Password=SAsa123;Connect Timeout=30'
$lines = New-Object System.Text.StringBuilder
$fail = 0

function Add-Line([string]$s) { [void]$script:lines.AppendLine($s) }
function Check([string]$name, $cond, [string]$detail) {
  if ($cond) { Add-Line ('  PASS ' + $name + ' :: ' + $detail) }
  else { $script:fail++; Add-Line ('  FAIL ' + $name + ' :: ' + $detail) }
}

foreach ($it in $cfg.items) {
  Add-Line ('==== ' + $it.cnName)
  $htmlPath = Join-Path $base ($it.templateFile -replace '/', '\')
  $srcHtml = [IO.File]::ReadAllText($htmlPath, $enc)

  $cn = New-Object System.Data.SqlClient.SqlConnection $cs
  $cn.Open()
  try {
    $q = $cn.CreateCommand()
    $q.CommandText = @"
SELECT t.TemplateId, t.TemplateName, t.TemplateContent, t.TemplateCategory, t.Report,
       p.Url, p.Module, p.Sequence, p.InMenu, p.Popedom, p.Flag,
       sp.Popedom, sp.Name, sp.PopedomGroup,
       rm.ReportCNValues, rm.ReportENValues, rm.IsKanban, rm.Flag
FROM Report_ResourcesMap rm WITH (NOLOCK)
INNER JOIN Report_Template t WITH (NOLOCK) ON LOWER(rm.ReportKey) = LOWER(t.TemplateName)
LEFT JOIN FRAMEWORK_PAGES p WITH (NOLOCK) ON LOWER(p.Name) = LOWER(t.TemplateName)
LEFT JOIN SYS_Popedom sp WITH (NOLOCK) ON LOWER(sp.Name) = LOWER(t.TemplateName)
WHERE ISNULL(rm.IsKanban, 0) = 0 AND rm.ReportCNValues = @cn
"@
    [void]$q.Parameters.AddWithValue('@cn', [string]$it.cnName)
    $r = $q.ExecuteReader()
    if (-not $r.Read()) { Add-Line '  FAIL row :: not found'; $fail++ }
    else {
      $tid = $r.GetValue(0); $tname = [string]$r.GetValue(1)
      $stored = [string]$r.GetValue(2)
      $cat = $r.GetValue(3); $rep = [string]$r.GetValue(4)
      $url = if ($r.IsDBNull(5)) { '' } else { [string]$r.GetValue(5) }
      $mod = if ($r.IsDBNull(6)) { '' } else { [string]$r.GetValue(6) }
      $pseq = if ($r.IsDBNull(7)) { -1 } else { [int]$r.GetValue(7) }
      $inmenu = if ($r.IsDBNull(8)) { -1 } else { [int]$r.GetValue(8) }
      $ppop = if ($r.IsDBNull(9)) { -1 } else { [int]$r.GetValue(9) }
      $pflag = if ($r.IsDBNull(10)) { -1 } else { [int]$r.GetValue(10) }
      $spop = if ($r.IsDBNull(11)) { -1 } else { [int]$r.GetValue(11) }
      $spname = if ($r.IsDBNull(12)) { '' } else { [string]$r.GetValue(12) }
      $spgrp = if ($r.IsDBNull(13)) { -1 } else { [int]$r.GetValue(13) }
      $cnv = [string]$r.GetValue(14); $env = [string]$r.GetValue(15)
      $iskanban = if ($r.IsDBNull(16)) { -1 } else { [int]$r.GetValue(16) }
      $rmflag = if ($r.IsDBNull(17)) { -1 } else { [int]$r.GetValue(17) }
      $r.Close()

      Add-Line ('  TemplateId=' + $tid + ' TemplateName=' + $tname)

      $decrypted = [SKT.Common.Utility.EncryptHelper]::Decrypt($stored)
      # server renders with JScript decodeURI; stored must be encodeURI(src) and decodeURI back exactly
      $wF = Join-Path $env:TEMP 'bi_vfy_src.html'
      $oF = Join-Path $env:TEMP 'bi_vfy_stored.txt'
      $jF = Join-Path $env:TEMP 'bi_vfy.js'
      [IO.File]::WriteAllText($wF, $srcHtml, (New-Object System.Text.UnicodeEncoding($false, $true)))
      [IO.File]::WriteAllText($oF, $decrypted, [Text.Encoding]::ASCII)
      $js = @'
var fso = new ActiveXObject("Scripting.FileSystemObject");
var ts = fso.OpenTextFile(WScript.Arguments(0), 1, false, -1);
var src = ts.ReadAll(); ts.Close();
var ts2 = fso.OpenTextFile(WScript.Arguments(1), 1, false, 0);
var stored = ts2.ReadAll(); ts2.Close();
var dec;
try { dec = decodeURI(stored); } catch (e) { WScript.Echo("DECODE_ERR " + e.message); WScript.Quit(2); }
if (dec !== src) { WScript.Echo("MISMATCH decLen=" + dec.length + " srcLen=" + src.length); WScript.Quit(3); }
var reenc;
try { reenc = encodeURI(src); } catch (e) { WScript.Echo("ENC_ERR " + e.message); WScript.Quit(4); }
if (reenc !== stored) { WScript.Echo("REENC_MISMATCH"); WScript.Quit(5); }
WScript.Echo("OK decLen=" + dec.length + " storedLen=" + stored.length);
'@
      [IO.File]::WriteAllText($jF, $js, [Text.Encoding]::ASCII)
      $jout = ''
      $jcode = -1
      $oldEap = $ErrorActionPreference
      $ErrorActionPreference = 'Continue'
      try {
        $jl = & cscript //nologo $jF $wF $oF
        $jcode = $LASTEXITCODE
        $jout = ($jl | Out-String).Trim()
      } finally { $ErrorActionPreference = $oldEap }
      Remove-Item -LiteralPath $wF, $oF, $jF -Force -ErrorAction SilentlyContinue
      Check 'content_decodeuri' ($jcode -eq 0) ($jout + ' html=' + $srcHtml.Length)
      Check 'category' ([int]$cat -eq 2) ('TemplateCategory=' + $cat)
      Check 'report_type' ($rep -eq $it.reportType) ('Report=' + $rep)
      $expectUrl = 'Report/ReportPage.aspx?name=' + $tname + '&Flag=1'
      Check 'page_url' ($url -ceq $expectUrl) ('Url=' + $url)
      Check 'page_module' ($mod -eq $it.reportType) ('Module=' + $mod)
      Check 'page_sequence' ($pseq -eq [int]$it.sequence) ('Sequence=' + $pseq)
      Check 'page_inmenu' ($inmenu -eq 1) ('InMenu=' + $inmenu)
      Check 'page_flag' ($pflag -eq 1) ('Flag=' + $pflag)
      Check 'page_popedom' ($ppop -gt 0) ('Popedom=' + $ppop)
      Check 'popedom_link' (($spop -eq $ppop) -and ($spname -eq $tname)) ('SYS_Popedom=' + $spop + ' Name=' + $spname)
      Check 'popedom_group' ($spgrp -gt 0) ('PopedomGroup=' + $spgrp)
      Check 'cn_name' ($cnv -ceq $it.cnName) ('ReportCNValues=' + $cnv)
      Check 'en_name' ($env -ceq $it.enName) ('ReportENValues=' + $env)
      Check 'is_kanban' ($iskanban -eq 0) ('IsKanban=' + $iskanban)
      Check 'res_flag' ($rmflag -eq 2) ('Report_ResourcesMap.Flag=' + $rmflag)

      # no duplicate page rows for same GUID
      $q2 = $cn.CreateCommand()
      $q2.CommandText = 'SELECT COUNT(*) FROM FRAMEWORK_PAGES WITH (NOLOCK) WHERE LOWER(Name)=LOWER(@n)'
      [void]$q2.Parameters.AddWithValue('@n', $tname)
      $cnt = [int]$q2.ExecuteScalar()
      Check 'page_unique' ($cnt -eq 1) ('FRAMEWORK_PAGES count=' + $cnt)

      # popedom value uniqueness across whole SYS_Popedom
      $q3 = $cn.CreateCommand()
      $q3.CommandText = 'SELECT COUNT(*) FROM SYS_Popedom WITH (NOLOCK) WHERE Popedom=@p'
      $p3 = $q3.Parameters.Add('@p', [System.Data.SqlDbType]::Int); $p3.Value = $ppop
      $cnt2 = [int]$q3.ExecuteScalar()
      Check 'popedom_unique' ($cnt2 -eq 1) ('SYS_Popedom value count=' + $cnt2)

      # full page URL for the doc
      Add-Line ('  URL=http://' + $cfg.server + '/' + $url)
    }
  } catch {
    $fail++
    Add-Line ('  EXCEPTION ' + $_.Exception.Message)
  } finally { $cn.Close() }
}

Add-Line ('RESULT fail=' + $fail)
[IO.File]::WriteAllText($OutFile, $lines.ToString(), $enc)
Write-Output ('fail=' + $fail)
if ($fail -gt 0) { exit 1 }
