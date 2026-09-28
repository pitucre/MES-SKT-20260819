# ASCII only. Verify 144 vs 179 template names + SP paged-branch field aliases match.
$ErrorActionPreference = 'Stop'
$outDir = 'C:\Users\Administrator\AppData\Local\Temp\opencode'
$dll = 'E:\source\MES\SKT\20260819\Code\Lib\SKT.Common.Utility.dll'
Add-Type -Path $dll
Add-Type -AssemblyName System.Web

function Get-Info($cs, $label) {
  $conn = New-Object System.Data.SqlClient.SqlConnection($cs)
  $conn.Open()
  $cmd = $conn.CreateCommand()
  $cmd.CommandText = "SELECT TemplateContent FROM Report_Template WHERE TemplateName='615562BE-0600-48B0-B41E-720047121637'"
  $enc = $cmd.ExecuteScalar()
  $cmd.CommandText = "SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspEquipmentOEEReport'))"
  $sp = $cmd.ExecuteScalar()
  $conn.Close()

  $html = ''
  if ($enc) {
    try {
      $plain = [SKT.Common.Utility.EncryptHelper]::Decrypt($enc)
      $html = [System.Web.HttpUtility]::UrlDecode($plain)
    } catch { $html = 'DECRYPT_ERR:' + $_.Exception.Message }
  }
  $htmlPath = Join-Path $outDir "v_$label`_m03.html"
  [System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.UTF8Encoding]::new($false))
  $spPath = Join-Path $outDir "v_$label`_sp.sql"
  if ($sp) { [System.IO.File]::WriteAllText($spPath, $sp, [System.Text.UTF8Encoding]::new($false)) }

  # main grid: first 15 name:'...' before detail (heuristic: until second 日期)
  $allNames = [regex]::Matches($html, "name\s*:\s*'([^']+)'") | ForEach-Object { $_.Groups[1].Value }
  $mainNames = @()
  $dateCount = 0
  foreach ($n in $allNames) {
    if ($n -eq '日期') { $dateCount++; if ($dateCount -ge 2) { break } }
    $mainNames += $n
  }
  $allDisp = [regex]::Matches($html, "display\s*:\s*'([^']+)'") | ForEach-Object { $_.Groups[1].Value }
  $mainDisp = @()
  $d2 = 0
  foreach ($n in $allDisp) {
    if ($n -eq '日期') { $d2++; if ($d2 -ge 2) { break } }
    $mainDisp += $n
  }

  # SP aliases in single-quoted CJK
  $spAliases = @()
  if ($sp) {
    $spAliases = [regex]::Matches($sp, "[N]?'([^\x00-\x7F][^']*)'") | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
  }

  # extract @Fields blocks aliases more carefully: ''xxx'' inside SET @Fields
  $fieldAliases = @()
  if ($sp) {
    $m = [regex]::Matches($sp, "SET @Fields = '([\s\S]*?)'\s*\r?\n\s*SET @TableOrViewName")
    foreach ($mm in $m) {
      $block = $mm.Groups[1].Value
      $al = [regex]::Matches($block, "''([^\x00-\x7F][^']*)''") | ForEach-Object { $_.Groups[1].Value }
      $fieldAliases += ,@($al)
    }
  }

  return [pscustomobject]@{
    Label = $label
    MainNames = $mainNames
    MainDisplay = $mainDisp
    SpAllCjk = $spAliases
    FieldBranches = $fieldAliases
    HtmlPath = $htmlPath
    SpPath = $spPath
    SpLen = if ($sp) { $sp.Length } else { 0 }
  }
}

$a = Get-Info 'server=172.16.5.144;uid=sa;pwd=SAsa123;database=LeanMes;Connect Timeout=60' '144'
$b = Get-Info 'server=172.16.5.179;uid=sa;pwd=SAsa123;database=PROD_TEST_MES;Connect Timeout=60' '179'

$lines = @()
$lines += "144 MainNames: $($a.MainNames -join ' | ')"
$lines += "179 MainNames: $($b.MainNames -join ' | ')"
$lines += "144 MainDisp:   $($a.MainDisplay -join ' | ')"
$lines += "179 MainDisp:   $($b.MainDisplay -join ' | ')"
$only144 = @($a.MainNames | Where-Object { $b.MainNames -notcontains $_ })
$only179 = @($b.MainNames | Where-Object { $a.MainNames -notcontains $_ })
$lines += "Only144: $($only144 -join ' | ')"
$lines += "Only179: $($only179 -join ' | ')"
$lines += "MainNamesEqual: $($only144.Count -eq 0 -and $only179.Count -eq 0)"
$lines += "144 FieldBranch count: $($a.FieldBranches.Count)"
$lines += "179 FieldBranch count: $($b.FieldBranches.Count)"
for ($i=0; $i -lt [Math]::Max($a.FieldBranches.Count, $b.FieldBranches.Count); $i++) {
  $fa = if ($i -lt $a.FieldBranches.Count) { $a.FieldBranches[$i] -join ',' } else { 'MISSING' }
  $fb = if ($i -lt $b.FieldBranches.Count) { $b.FieldBranches[$i] -join ',' } else { 'MISSING' }
  $eq = ($fa -eq $fb)
  $lines += "Branch$i Equal=$eq"
  if (-not $eq) {
    $lines += "  144: $fa"
    $lines += "  179: $fb"
  }
}
# also compare full SP text hash
$h1 = [System.BitConverter]::ToString([System.Security.Cryptography.SHA256]::Create().ComputeHash([Text.Encoding]::UTF8.GetBytes(($a.SpLen.ToString()+ (Get-Content -Raw $a.SpPath)))))
# simpler: compare definitions directly
$sp144 = Get-Content -Raw $a.SpPath
$sp179 = Get-Content -Raw $b.SpPath
$norm = { param($s) ($s -replace '\s+', ' ').Trim() }
$lines += "SPNormalizedEqual: $(((& $norm $sp144) -eq (& $norm $sp179)))"

$text = $lines -join "`r`n"
[System.IO.File]::WriteAllText((Join-Path $outDir 'verify_align_cols.txt'), $text, [System.Text.UTF8Encoding]::new($false))
Write-Output 'OK'
Write-Output $text
