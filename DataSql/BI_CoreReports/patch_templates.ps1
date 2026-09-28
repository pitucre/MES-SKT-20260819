param([string]$LogFile = "C:\Users\Administrator\AppData\Local\Temp\opencode\patch_templates_log.txt")
$ErrorActionPreference = 'Stop'
$dir = 'E:\source\MES\SKT\20260819\DataSql\BI_CoreReports\templates'
$enc = New-Object System.Text.UTF8Encoding($false)
$log = New-Object System.Text.StringBuilder
function W($s) { [void]$log.AppendLine($s) }

$cnTotal = -join ([char]0x5408, [char]0x8BA1, [char]0x4EA7, [char]0x91CF)
$cnShots = -join ([char]0x5F00, [char]0x5173, [char]0x6A21, [char]0x6B21, [char]0x6570)

$oldLine = "        var ds = getChartDataSource({ source: biSpName, dataAction: 'PROC', paramters: getParamStr() });"
$newLine = "        var ds = biFetchRows();"

$helper = @'
    function biFetchRows() {
        var tries = [true, false], k;
        for (k = 0; k < tries.length; k++) {
            var isProc = tries[k];
            biFetchRows.ok = false;
            biFetchRows.data = null;
            biFetchRows.msg = "";
            var req = {
                type: "post",
                url: "../Handler/ReportingServer.ashx?gridviewname=" + biSpName + "&rnd=" + Math.random(),
                data: { dataAction: "PROC", paramters: getParamStr() },
                dataType: "json",
                async: false,
                success: function (data) {
                    biFetchRows.ok = true;
                    biFetchRows.data = data;
                },
                error: function (xhr) {
                    biFetchRows.ok = false;
                    biFetchRows.msg = (xhr && xhr.status ? xhr.status + " " : "")
                        + (xhr && xhr.responseText ? xhr.responseText : "");
                }
            };
            if (isProc) {
                req.data.isProcPage = "true";
                req.data.page = "1";
                req.data.pagesize = "100000";
                req.data.conditions = "1=1";
            }
            $.ajax(req);
            if (biFetchRows.ok && biFetchRows.data && typeof biFetchRows.data === "object") {
                return biFetchRows.data;
            }
        }
        alert("Get Data Error: " + (biFetchRows.msg || "no response").substring(0, 400));
        return { Rows: [] };
    }

'@

$anchor = "    function getParamStr() {"
$p90Old = "                { display: '" + $cnTotal + "', name: '" + $cnTotal + "', align: 'right', width: 110, minWidth: 60 },"
$p90New = $p90Old + "`r`n" + "                { display: '" + $cnShots + "', name: '" + $cnShots + "', align: 'right', width: 110, minWidth: 60 },"

$failed = 0
$files = @(Get-ChildItem -LiteralPath $dir -Filter '*.html' | Sort-Object Name)
foreach ($f in $files) {
  try {
    $html = [IO.File]::ReadAllText($f.FullName, $enc)
    $changed = $false

    if ($html.Contains('function biFetchRows')) {
      W ("SKIP {0}: biFetchRows already present" -f $f.Name)
    } else {
      if (-not $html.Contains($oldLine)) { throw 'chart call line not found' }
      if (-not $html.Contains($anchor)) { throw 'getParamStr anchor not found' }
      $html = $html.Replace($oldLine, $newLine).Replace($anchor, $helper + $anchor)
      $changed = $true
      W ("CHART {0}: patched" -f $f.Name)
    }

    if ($f.Name -eq 'P90_monthly_production.html') {
      if ($html.Contains($cnShots)) {
        W ("SKIP {0}: column already present" -f $f.Name)
      } else {
        if (-not $html.Contains($p90Old)) { throw 'P90 total column line not found' }
        $html = [regex]::Replace($html, [regex]::Escape($p90Old), $p90New)
        $changed = $true
        W ("COL {0}: inserted" -f $f.Name)
      }
    }

    if ($changed) {
      [IO.File]::WriteAllText($f.FullName, $html, $enc)
      W ("WRITE {0} len={1}" -f $f.Name, $html.Length)
    }
  } catch {
    $failed++
    W ("FAIL {0}: {1}" -f $f.Name, $_.Exception.Message)
  }
}
W ("patch end failed={0}" -f $failed)
[IO.File]::WriteAllText($LogFile, $log.ToString(), $enc)
Write-Output ('failed=' + $failed)
if ($failed -gt 0) { exit 1 }
