param([string]$OutFile = "C:\Users\Administrator\AppData\Local\Temp\opencode\js_syntax_check.txt")
$ErrorActionPreference = 'Stop'
$dir = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports\templates'
$tmp = 'C:\Users\Administrator\AppData\Local\Temp\opencode'
$encBom = New-Object System.Text.UnicodeEncoding($false, $true)
$sb = New-Object System.Text.StringBuilder
$rx = [regex]'(?s)<script type="text/javascript">(.*?)</script>'

foreach ($f in Get-ChildItem -LiteralPath $dir -Filter *.html) {
  $t = [System.IO.File]::ReadAllText($f.FullName, (New-Object System.Text.UTF8Encoding($false)))
  $m = $rx.Match($t)
  if (-not $m.Success) { [void]$sb.AppendLine($f.Name + ' NO SCRIPT FOUND'); continue }
  $js = "if (false) {`r`n" + $m.Groups[1].Value + "`r`n}`r`n"
  $jsFile = Join-Path $tmp 'chk_syntax.js'
  [System.IO.File]::WriteAllText($jsFile, $js, $encBom)
  $out = ''
  $code = -1
  $old = $ErrorActionPreference
  $ErrorActionPreference = 'Continue'
  try {
    $lines = & cscript //nologo $jsFile 2>&1
    $code = $LASTEXITCODE
    $out = ($lines | Out-String)
  } finally { $ErrorActionPreference = $old }
  $verdict = if ($code -eq 0) { 'SYNTAX_OK' } else { 'SYNTAX_FAIL' }
  [void]$sb.AppendLine(('--- {0} exit={1} => {2}' -f $f.Name, $code, $verdict))
  foreach ($l in (($out -split "`r?`n") | Where-Object { $_ -ne '' } | Select-Object -First 6)) {
    [void]$sb.AppendLine('    ' + $l)
  }
}
[System.IO.File]::WriteAllText($OutFile, $sb.ToString(), (New-Object System.Text.UTF8Encoding($false)))
Write-Output 'DONE'
