<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDAAgeingBadCollection.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAAgeingBadCollection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>

    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>老化结束</title>
    <style type="text/css">
        .clear {
            clear: both;
            height: 2px;
        }

        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        table {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px !important;
            color: #1d1007;
        }
        .clear {
            clear: both;
            height: 2px;
        }

        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        table {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px !important;
            color: #1d1007;
        }    .ui-title {
            line-height: 30px;
            
        }
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false">
        <div data-role="page" id="pageOne">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <%--<img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7l2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjZUMjI6MjQrMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1NyswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTcrMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6MmFlNTFmYzItYzhhZS0wMDRhLTkyMmItYWUyMDNmYTg4MTQ3PC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6OWY3MTQyMTQtMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6YTc0OGJlODMtOGIwOS02YjRiLThhMGYtMDcwNDQyMDRlZGNkPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOmE3NDhiZTgzLThiMDktNmI0Yi04YTBmLTA3MDQ0MjA0ZWRjZDwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNlQyMjoyNCswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTQgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpjNjdmYjI3Yy1jMDQ0LTEzNGEtOTk2Ni1lODBlMDJhOTVmOTY8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjZUMjI6Mjk6MjErMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE0IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6MmFlNTFmYzItYzhhZS0wMDRhLTkyMmItYWUyMDNmYTg4MTQ3PC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU3KzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz5y+z4+AAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAATrSURBVHja7Jv9VepAEMWvFaAVGCswVkCsQKwAXgViBUIFYAVKBWIFhgoeViBWYKyA98/seeM9u5vNxwZQ9xyPgcCS+e3szJ3JydF2u8VPHke/AH4BdAJgAOAOQKreywFM5f+3BjAGMPOcv9wlhC4AvAFIPOdXALLvDED/wBLAvWwHY3QB4OSnADgDsAHQJ7c/OlQAKYAri0vnDgDG0GMAHx4AmUCC8pJngbc3AEYAHhznbgHMPQB87z/I3DwKCZjrfQDAK2gbF3KxVQAMADx55tzINto5AF79tayQjuZTAJNAACYVPgIYklZIKIu0mjbrAtC5XUfxv0rsmPRWBYD+/hLAtRj/ts8AcrkoSHqbkLu6ALwojzFGbcnLFhYtsXcA9L7k9HbiifYMoBAP4Bji8padAsjEADbM5q4vgQASiivms6eU/s7aTId1AbChCYB3Of6QLGHS4SwAwB+Z404F1QuHV7UqmprogC15xMpi2IKiugvAlMTPo0CBCK2lHL+X1BWdAtiIe5qYcC/HM3ltMkE/QPBMBZQxbiLvcWBtvXAqAzAk4oWsaiFu2bdc8FBW0Pp76lgbNlXuzx6lgT6LWOoEwIuDtpGkIwA3llTY90TpUAA60PFWmXQBoKyJkcsK3VkAcHyoA0B/TosjXWNEBZDT3l1IMDoOTHGuJogLgI4VPpitd49CAMyFPOf+e7UFTIH0KcdPsmoJzXkZAEBngJ5sOZs46gyAjvDaHQvyCB247hzxQwPQsULPpQNq9MZJCAC9cje0Bz9llVi7X6nIHQIADpBaA3wS8KgA5g735j7AypEKE0ezJATAiXL7qBrAB4D3u17dJ0cuNuWrTqNlAJa0qrq0ZgCta4AyHVAo99bGabdESZDL6PyUAEzw9WbJmuaIqgHKAOjuDK/Mh2XlQJ+5shj3rF6nMj9/5nZfAHB/bqAMmMHeuDwhA0/V63dLChuQ3liRd0XVAGUAOODN1eqkjj0+UBEcltV1gdZxBA0ApGrbgq6lVjG0xP++v+78GE2QUHU4DvnRwFFFAwwk6xxb4ticYk8lAFwTpABelSYYUcxY7wDACO77E1q1jusA4M6PzvXH1OxYh7pd4AjRACHGe7dQSENkDeDc0qoyEM6r7LkWAdiMX6o6YkwV5sIWuEMATGgi3f+LObhcnpQYr4soWxq1elEIgBRf29W6ONoFgFDjuTtVGwD3/1jydgFgI3v4xhLMXMazbG8EYO6p/bsA4FOrLuO5N2mtJUIBsCrUxVGskcgeTmoYfy4RX+uCa1sNU6Utrosj3493AcHXG7QZv3BI90oAfMVR7JFRWi4qGP8q3y+aAuDom7Wc95uOysZXBeArjg7S+KoATFOj7yiODs74OgB8xdHBGV8HABdHXanCKMbXAVBWHB2U8XUBsCrsOhu0ZnxdAFwcdSWKWje+LgDOBl15wZXAbs34JgBYFK3lQmIVSDcW6dvY+CYAbF4QYyv0ZN5BDOObAkgFQo8gjFvyBJvLm7J21IbxTQG4ujMbeb9uTDgXd88s55zd3V0BcEEw3vBYAcRQ5rIZ/innlm0Hl7aeGBnJqvUcwimXv43s377KHhn8t71bdflYAIxMfqTA2GS8irvnMXNrjGeGRvJXF8RCQEY1PCYAnSWMeyf4egPFjJVKqTl28Pzg76OzvwB+OIB/AwDb01qfQq6nbwAAAABJRU5ErkJggg==" />--%>
                    </div>
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">老化结束</label>                        
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <label for="fStation">
                        工序</label>
                    <a data-transition="none" data-role="button" data-mini="true" onclick="chooseStation();" data-ajax="false"
                        id="showStation" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>
                    <label for="fRes">
                        资源</label>
                    <a data-transition="none" data-role="button" data-mini="true" onclick="chooseResource();" data-ajax="false"
                        id="showRes" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>
                     <div>
                        <label for="fGRN">
                            请扫描SN条码</label>
                        <input type="text" name="txtSN" id="txtSN" />
                    </div>
                     <div>
                        <label>上一工位：<span id="LastStation"></span></label>
                        <label>下一工位：<span id="NextStation"></span></label>
                        <label>工单：<span id="ProdOrderNo"></span></label>
                        <label> <span class="scan-center-title" >已经老化数量/需要老化总数:</span>&nbsp;&nbsp
                        <span class="scan-center-title" id="HavAgeing"></span>
                        <span class="scan-center-title" >/</span>
                        <span class="scan-center-title" id="NeedAgeing"></span></label>
                    </div>
                </div>
                <div id="msg" style="text-align: center;"></div>
                <div id="hein">
                <table id="Infotab" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%">
                    <thead>
                        <tr>
                        <th>序号
                        </th>
                        <th>序列号
                        </th>
                        <th>操作结果
                        </th>
                        </tr>
                    </thead>
                    <tbody id="collectionlist1" >
                    </tbody>
                </table>
                 </div>
            </div>
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-transition="none" id="Start" onclick="AgeEnd()">结束老化</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="OrderPanel" style="background: #f9f9f9">
                <div data-role="content">
                    <ul data-role="listview" id="listview" data-inset="false" data-filter="true" data-filter-placeholder="搜索"
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>
        </div>
        

        <script type="text/javascript">
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var prodOrderId = "-1"; //选择的工单
            var routeId = "-1";
            var orderNo = "";
            var sltStationId = -1;
            var sltResId = -1;
            var pickListId = 0; //手插 工单线别 ID
            var pStatus = 2; //手插 工单线别 状态
            var scanSN = ""; //GRN条码
            var UIid = 80014807 + ',' +80012800;
            var USTid = "0";
            var SN = "";
            var Rack = "";
            var Flag = 0;
            var Number =0;
            $(document).bind("mobileinit", function () {
                $.mobile.ajaxEnabled = false;
            });

            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("body>[data-role='listview']").listview();
                $("#Infotab").parent().find("a").css("display", "none");
                getStationByUid();

            });
            

            //查询页隐藏columntoggle列表按钮
            $(document).on("pageshow", "#Search,#pageTwo", function (event) {
                $(".ui-body-c").css("background", "#fff");
                $(".ui-table-columntoggle-btn").css("display", "none");
            });

            $(document).on("pageshow", function (event) {
                var _id = location.hash;
                if (_id == "") {
                    $("#pageOne div ul li a").each(function () {
                        if ($(this).attr("href") == "#pageOne") {
                            $(this).addClass("ui-btn-active");
                            return;
                        }
                    });
                    return false;
                }
                $(_id + " div ul li a").each(function () {

                    if ($(this).attr("href") == _id) {
                        $(this).addClass("ui-btn-active");
                        return;
                    }
                })
            });
          
            $("#txtSN").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    afterScan();
                }
            });

            $("#txtRack").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    afterRackScan();
                }
            });

            function afterScan() {
                if(sltStationId == -1){
                    showAreaMessge("请选择工序", "messageRed");
                    return false;
                }
                if(sltResId == -1){
                    showAreaMessge("请选择资源", "messageRed");
                    return false;
                }
                SN = $("#txtSN").val();

                //判断是否是NCCode，如果是  跳到textSN  ，如果不是  执行 产品或者老化架的老化结束逻辑
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.IsNCCode($("#txtSN").val());
                if (data.error != null) {
                  
                    showAreaMessge(data.error.Message, "messageRed");
                
                    $("#txtSN").select();
                    //写入日志
                    SaveUserUILog("一般", sltStationId, sltResId, $("#txtSN").val(), data.error.Message);
                    return false;
                }
                if (Flag == 1) {
                    NCCodeScan(NCCode, $("#txtSN").val());
                    Flag = 0;
                    NCCode = "";
                    $("#txtSN").val("").focus();
                    return false;
                }
                Flag = data.value;

                if (Flag == 1) {//不良代码
                    NCCode = $("#txtSN").val();
                    showAreaMessge($("#txtSN").val() + ":不良代码扫描成功", "messageGreen");
                
                    $("#txtSN").val("").focus();
                    return false;
                } else if (Flag == 3) {//SN
                    //SN Check
                    var SN = $("#txtSN").val();
                    //zhiman.yuan 2017-8-16 修改通用过站验证
                    var data = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(SN, sltResId, sltStationId, false);
                    if (data.error != null) {
                        showAreaMessge(SN + ":" + data.error.Message, "messageRed");

                        $("#txtSN").select();
                        //写入日志
                        SaveUserUILog("一般", sltStationId, sltResId, SN, data.error.Message);
                        return false;
                    }
                    /*Modify By Alen 2018-01-30 增加老化结束UI的上下站位信息显示*/
                    stationRefreshBySN(SN);
                    orderRefreshBySN(SN);
                    getPercentageagingRefresh(SN);
                   
                }
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.AgeingEnd($("#txtSN").val(), sltStationId, sltResId, routeId, prodOrderId, "", userId, "1");
                if (data.error != null) {
                   
                    showAreaMessge($("#txtSN").val() + ":" + data.error.Message, "messageRed");
               
                    $("#txtSN").select();
                    //写入日志
                    SaveUserUILog("一般", sltStationId, sltResId, $("#txtSN").val(), data.error.Message);
                    return false;
                }
            
                showAreaMessge($("#txtSN").val() + ":老化结束成功", "messageGreen");
             
               
                Show($("#txtSN").val(), "green");
             
                $("#txtSN").val("").focus();
            }

            //采集不良
            function NCCodeScan(NC, SN) {
                //SN Check
                //zhiman.yuan 2017-8-16 修改通用过站验证
                var data = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(SN, sltResId, sltStationId, false);
                if (data.error != null) {
                    showAreaMessge(SN + ":" + data.error.Message, "messageRed");
                   
                    $("#txtSN").select();
                    //写入日志
                    SaveUserUILog("一般", sltStationId, sltResId, SN, data.error.Message);
                    return false;
                }
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.NCCodecollect(SN, sltStationId, sltResId, routeId, prodOrderId, NC, userId);
                if (data.error != null) {
                    
                    showAreaMessge(data.error.Message, "messageRed");
               
                    $("#txtSN").select();
                    //写入日志
                    SaveUserUILog("一般", sltStationId, sltResId, SN, data.error.Message);
                    return false;
                }
              
                showAreaMessge(SN + ":不良代码采集完成", "messageGreen");
           
                Show(SN, "red");
                stationRefreshBySN(SN);
                $("#textSN").val("").focus();
            }

            /*
            *根据sn获取前后工序信息并回显
            */
            function stationRefreshBySN(serialNumber) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetLastNextStationBySN(sltStationId, serialNumber);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                $("#LastStation").html(ajax.value[0]);
                $("#NextStation").html(ajax.value[1]);
            }

            /*
         *根据sn获取工单信息
         */
            function orderRefreshBySN(serialNumber) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.GetorderRefreshBySN(serialNumber);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                if (ajax.value == "") {
                    $("#msg").html("获取SN工单信息为空").css("color", "red");
                    return false;
                }
                var res = JSON.parse(ajax.value);
                if (res.length == 0) {
                    $("#msg").html("获取SN工单信息为空").css("color", "red");
                    return false;
                }
                prodOrderId = '' + res[0].ProdOrderID + ''; //选择的工单
                routeId = '' + res[0].RouterId + '';
                 orderNo = res[0].OrderNO;
                 $('#ProdOrderNo').html(res[0].OrderNO);
            }

            //强制结束老化
            function AgeEnd() {
                if (confirm("是否强制结束老化")) {
                    if ($.trim($("#txtSN").val()) == "") {
                        showAreaMessge("请扫描SN或老化架", "messageRed");
                        $("#txtSN").focus();
                        return false;
                    }
                    var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.GetGetAgeingEndBySN($("#txtSN").val());

                    var sn = JSON.parse(data.value).SN;
                    if (typeof (sn) != 'undefined') {
                        stationRefreshBySN(SN);//获取上下工序信息
                    }

                    var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.AgeingEnd($("#txtSN").val(), sltStationId, sltResId, routeId, prodOrderId, "", userId, "2");
                    if (data.error != null) {
                       
                        showAreaMessge($("#txtSN").val() + ":" + data.error.Message, "messageRed");
                     
                        $("#txtSN").select();
                        //写入日志
                        SaveUserUILog("一般", sltStationId, sltResId, $("#txtSN").val(), data.error.Message);
                        return false;
                    }
                
                    Show($("#txtSN").val(), "green");
                
                    showAreaMessge($("#txtSN").val() + ":强制结束老化成功", "messageGreen");
                 
                    $("#txtSN").val("").focus();
                }
            }

            function Show(itemcode, sn, colors) {
                var Number = $("#collectionlist1 tr").length + 1;
                $("#txtsum").html(Number);
                var Status = colors == "red" ? "NG" : "OK";
                if (Number == 1) {
                    $("#collectionlist1").append("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td>" + Number + "</td><td>" + itemcode + "</td><td>" + sn + "</td><td>" + Status + "</td></tr>");
                } else {
                    if (Number % 2 == 0) {
                        $("#collectionlist1 tr:eq(0)").before("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td>" + Number + "</td><td>" + itemcode + "</td><td>" + sn + "</td><td>" + Status + "</td></tr>");
                    } else {
                        $("#collectionlist1 tr:eq(0)").before("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td>" + Number + "</td><td>" + itemcode + "</td><td>" + sn + "</td><td>" + Status + "</td></tr>");
                    }
                }
            }

            function getPercentageagingRefresh(obj) {
                if (obj != '') {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.getPercentAgeaging(obj, prodOrderId, sltStationId, sltResId);
                    if (ajax.error != null) {
                        showAreaMessge(ajax.error.Message, "messageRed"); 
                        return;
                    }
                    var obj = JSON.parse(ajax.value)[0];
                    if (obj != '') {
                        $('#HavAgeing').html(obj.HavAgeingNum);
                        $('#NeedAgeing').html(obj.NeedAgeingNum);
                    }
                }
            }
         

            function getStationByUid() {
               
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.getStationByUid(UIid);;
                if (ajax.error != null) {
                    USTid ="0";
                }
                if (ajax.value == "") {
                    USTid = "0";

                } else {
                    var res = JSON.parse(ajax.value);
                    if (res.length != 0) {
                        USTid = res;
                    }
                }
               
            }

            function chooseStation() {
        
                /*根据用户获取所有的工位类型*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetOperationTypeByUser('<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>', -1, false);
                if (ajax.error != null) {
                    showAreaMessge(ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog(orderNo, ajax.error.Message);
                    return false;
                }
                var list = ajax.value;
                if (list.error != null) {
                    confirmDialogFocus(list.error, function () {
                        ///$("#listno").focus();
                    });
                };
                if (list.length == 0) {
                    confirmDialog("未找到用户权限工序！");
                    return false;
                }
                var htmlstr = "";
                $('#listview').html('');
                for (var i = 0 ; i < list.length; i++) {
                    if (USTid != "0") {
                        if (USTid.length > 0) {
                            for (var j = 0; j < USTid.length; j++) {
                                if (USTid[j].StationId == list[i].StationId) {
                                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + list[i].StationId + "' onclick=StationList('" + list[i].StationId + "')>" + list[i].Station + "</li>";
                                }
                            }
                        }
                    } else {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + list[i].StationId + "' onclick=StationList('" + list[i].StationId + "')>" + list[i].Station + "</li>";
                    }
                   
                }
                $("#listview").append(htmlstr);
                $('#listview').listview('refresh');
                $("#OrderPanel").panel("open");
            }

            function StationList(ID) {
                sltStationId = ID;
                $("#showStation,#sshowStation").html($("#" + ID).html());
                $("input[data-type='search']").val('');
                $("#OrderPanel").panel("close");
                $("#showRes").html("请选择");
                sltResId = -1;
                chooseResource();
            }

            //资源
            function chooseResource() {
                if ($("#showStation").html() == "请选择") {
                    confirmDialog("请先选择工序！");
                    chooseStation();
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetResourcesByOprId(sltStationId, userName);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    //写入日志
                    SaveUserUILog(sltStationId, ajax.error.Message);
                    return false;
                }

                $("#OrderPanel").panel("open");

                var htmlstr = "";
                var data = ajax.value;
                $('#listview').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].ResourceId + "' onclick=ResList('" + data[i].ResourceId + "')>" + data[i].ResName + "</li>";
                }
                $("#listview").append(htmlstr);
                $('#listview').listview('refresh');
            }

            function ResList(ID) {
                sltResId = ID;
                $("#showRes,#sshowRes").html($("#" + ID).html());
                $("input[data-type='search']").val('');
                $("#OrderPanel").panel("close");
            }

          

            /*
            *写入用户操作日志
            */
            function SaveUserUILog(OederNo, LogContent) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.SaveUserUILog("一般", -1, -1, OederNo, LogContent);
                if (ajax.error != null) {
                    return false;
                }
            }

            //显示消息
            function showAreaMessge(msg, type) {
                $("#msg").html(msg).css("color", type == "messageGreen" ? "#99FF33" : "#ff0000");
            }
        </script>
    </form>
</body>