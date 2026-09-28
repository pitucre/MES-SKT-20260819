param([string]$OutFile = "C:\Users\Administrator\AppData\Local\Temp\opencode\extract_script.txt")
$ErrorActionPreference = 'Stop'
$dir = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports\templates'
$enc = New-Object System.Text.UTF8Encoding($false)
$rx = [regex]'(?s)<script type="text/javascript">(.*?)</script>'
$f = Join-Path $dir 'P90_monthly_production.html'
$t = [System.IO.File]::ReadAllText($f, $enc)
$m = $rx.Match($t)
$lines = $m.Groups[1].Value -split "`r?`n"
$sb = New-Object System.Text.StringBuilder
for ($i = 0; $i -lt $lines.Count; $i++) {
  [void]$sb.AppendLine(('{0,4}: {1}' -f ($i + 1), $lines[$i]))
}
[System.IO.File]::WriteAllText($OutFile, $sb.ToString(), $enc)
Write-Output ('lines=' + $lines.Count)
