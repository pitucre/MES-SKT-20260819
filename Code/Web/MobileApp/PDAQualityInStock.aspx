<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDAQualityInStock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAQualityInStock" %>

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
    <title>品质入库确认</title>
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
        }

        .ui-title {
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">品质入库确认</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar" data-theme="c">
                    <ul>
                        <li><a href="#" data-transition="none" class="ui-btn-active" data-theme="c">品质入库确认</a></li>
                        <li><a href="#pageTwo" data-transition="none" data-theme="c">Agv托运入库查看</a></li>
                    </ul>
                </div>
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
                    <div id="msg" style="text-align: center;"></div>
                    <div>
                        <label for="ItemCode">
                            条码编码</label>
                        <label id="lblItemCode"></label>
                    </div>
                    <div>
                        <label for="Qty">
                            条码数量</label>
                        <label id="lblQty"></label>
                    </div>
                    <div>
                        <label for="BoxSN">
                            包装箱号</label>
                        <label id="lblBoxSN"></label>
                    </div>
                    <div class="clear">
                    </div>
                    <div>
                        <label for="Inspection">
                            检验结果</label>
                        <div style="display: flex">
                            <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                <input name="checkResult" type="radio" checked="checked" value="1" />合格
                            </label>
                            <label style="background: #fff; color: #1d1007; border-color: #fff">
                                <input name="checkResult" type="radio" value="0" />不合格
                            </label>
                        </div>
                    </div>
                    <div>
                        <label for="NcDesc">
                            不合格描述</label>
                        <input type="text" name="txtNcDesc" id="txtNcDesc" />
                    </div>
                    <div>
                        <label for="ty">
                            AGV托运</label>
                        <div style="display: flex">
                            <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                <input name="IsTy" type="radio" value="0" />是
                            </label>
                            <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                <input name="IsTy" type="radio" checked="checked" value="1" />否
                            </label>
                        </div>
                    </div>
                    <div>
                        <label for="TcType">
                            托运类型</label>
                        <div style="display: flex">
                            <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                <input name="IsTcType" type="radio" checked="checked" value="0" />台车
                            </label>
                            <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                <input name="IsTcType" type="radio" value="1" />托盘
                            </label>
                        </div>
                    </div>
                    <div>
                        <label for="TcType">
                            运送区域</label>
                        <div style="display: flex">
                            <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                <input name="IsYsQy" type="radio" checked="checked" value="1" />立体仓
                            </label>
                            <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                <input name="IsYsQy" type="radio" value="3" />暂存区
                            </label>
                            <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                <input name="IsYsQy" type="radio" value="2" />待检区
                            </label>
                        </div>
                    </div>
                    <div>
                        <label for="StatrAgv">起点位置</label>
                        <input type="text" name="txtStatrAgv" id="txtStatrAgv" />
                    </div>
                    <div>
                        <label for="AgvEnd">目标点位</label>
                        <input type="text" name="txtAgvEnd" id="txtAgvEnd" />
                    </div>

                    <%--<table data-role="table" id="tbItem" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%">--%>
                    <%--<tr>
                            <td>
                                <label style="font-weight: 500;">
                                    检验结果
                                </label>
                            </td>
                            <td></td>
                        </tr>--%>
                    <%-- <tr>
                            <td style="text-align: center; line-height: 3.5em">不合格描述
                            </td>
                            <td>
                                <input type="text" name="txtRemark" id="txtRemark" /></td>
                        </tr>--%>
                    <%-- <tr style="height: 5em;">
                            <td style="line-height: 5em; font-size: 1.2em; font-weight: 500">AGV托运
                            </td>
                            <td style="line-height: 5em;">
                                <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                    <input name="IsTy" type="radio" checked="checked" value="0" />是
                                </label>
                            </td>
                            <td>
                                <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                    <input name="IsTy" type="radio" checked="checked" value="1" />否
                                </label>
                            </td>
                            <td style="line-height: 5em; font-size: 1.2em; font-weight: 500">托运类型
                            </td>
                            <td style="line-height: 5em;">
                                <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                    <input name="IsTcType" type="radio" checked="checked" value="0" />台车
                                </label>
                            </td>
                            <td>
                                <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                    <input name="IsTcType" type="radio" checked="checked" value="1" />托盘
                                </label>
                            </td>
                        </tr>--%>
                    <%-- <tr>
                            <td style="line-height: 5em; font-size: 1.2em; font-weight: 500">运送区域
                            </td>
                            <td style="line-height: 5em;">
                                <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                    <input name="IsYsQy" type="radio" checked="checked" value="0" />立体仓
                                </label>
                            </td>
                            <td>
                                <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                    <input name="IsYsQy" type="radio" checked="checked" value="1" />暂存区
                                </label>
                            </td>
                            <td>
                                <label style="background: #fff; color: #1d1007; border-color: #fff;">
                                    <input name="IsYsQy" type="radio" checked="checked" value="1" />待检区
                                </label>
                            </td>
                        </tr>--%>
                    <%-- <tr>
                            <td colspan="2">
                                <label for="fGRN">
                                    请扫描AVG起始地标码</label>
                                <input type="text" name="txtSN" id="txtAVGSN" /></td>
                            <td colspan="2">紧急等级<select name="warn" data-mini="true" id="warn" class="warn">
                                <option value="1">紧急</option>
                                <option value="2" selected>正常</option>
                            </select></td>
                        </tr>--%>
                    <%--</table>--%>
                    <div>
                    </div>
                    <div>
                    </div>
                    <div>
                        <label>上一工位：<span id="LastStation"></span></label>
                        <label>下一工位：<span id="NextStation"></span></label>
                        <label>工单：<span id="ProdOrderNo"></span></label>
                        <label>产品编码：<span id="labItemCode"></span></label>
                        <label>过站数量：<span id="labQtyStr"></span></label>
                    </div>
                </div>
                <div id="hein">
                    <table data-role="table" id="tbTransferItem" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%">
                        <thead>
                            <tr>
                                <th>序号
                                </th>
                                <th>产品条码
                                </th>
                                <th>数量
                                </th>
                            </tr>
                        </thead>
                        <tr id="trNoInfo" class="ListTableOddRow">
                            <td colspan="3" style="text-align: center;">暂无数据
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-transition="none" onclick="Pass()">确认</a></li>
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
        <div data-role="page" id="pageTwo">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <%--<img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7l2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjZUMjI6MjQrMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1NyswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTcrMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6MmFlNTFmYzItYzhhZS0wMDRhLTkyMmItYWUyMDNmYTg4MTQ3PC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6OWY3MTQyMTQtMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6YTc0OGJlODMtOGIwOS02YjRiLThhMGYtMDcwNDQyMDRlZGNkPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOmE3NDhiZTgzLThiMDktNmI0Yi04YTBmLTA3MDQ0MjA0ZWRjZDwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNlQyMjoyNCswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTQgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpjNjdmYjI3Yy1jMDQ0LTEzNGEtOTk2Ni1lODBlMDJhOTVmOTY8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjZUMjI6Mjk6MjErMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE0IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6MmFlNTFmYzItYzhhZS0wMDRhLTkyMmItYWUyMDNmYTg4MTQ3PC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU3KzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz5y+z4+AAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAATrSURBVHja7Jv9VepAEMWvFaAVGCswVkCsQKwAXgViBUIFYAVKBWIFhgoeViBWYKyA98/seeM9u5vNxwZQ9xyPgcCS+e3szJ3JydF2u8VPHke/AH4BdAJgAOAOQKreywFM5f+3BjAGMPOcv9wlhC4AvAFIPOdXALLvDED/wBLAvWwHY3QB4OSnADgDsAHQJ7c/OlQAKYAri0vnDgDG0GMAHx4AmUCC8pJngbc3AEYAHhznbgHMPQB87z/I3DwKCZjrfQDAK2gbF3KxVQAMADx55tzINto5AF79tayQjuZTAJNAACYVPgIYklZIKIu0mjbrAtC5XUfxv0rsmPRWBYD+/hLAtRj/ts8AcrkoSHqbkLu6ALwojzFGbcnLFhYtsXcA9L7k9HbiifYMoBAP4Bji8padAsjEADbM5q4vgQASiivms6eU/s7aTId1AbChCYB3Of6QLGHS4SwAwB+Z404F1QuHV7UqmprogC15xMpi2IKiugvAlMTPo0CBCK2lHL+X1BWdAtiIe5qYcC/HM3ltMkE/QPBMBZQxbiLvcWBtvXAqAzAk4oWsaiFu2bdc8FBW0Pp76lgbNlXuzx6lgT6LWOoEwIuDtpGkIwA3llTY90TpUAA60PFWmXQBoKyJkcsK3VkAcHyoA0B/TosjXWNEBZDT3l1IMDoOTHGuJogLgI4VPpitd49CAMyFPOf+e7UFTIH0KcdPsmoJzXkZAEBngJ5sOZs46gyAjvDaHQvyCB247hzxQwPQsULPpQNq9MZJCAC9cje0Bz9llVi7X6nIHQIADpBaA3wS8KgA5g735j7AypEKE0ezJATAiXL7qBrAB4D3u17dJ0cuNuWrTqNlAJa0qrq0ZgCta4AyHVAo99bGabdESZDL6PyUAEzw9WbJmuaIqgHKAOjuDK/Mh2XlQJ+5shj3rF6nMj9/5nZfAHB/bqAMmMHeuDwhA0/V63dLChuQ3liRd0XVAGUAOODN1eqkjj0+UBEcltV1gdZxBA0ApGrbgq6lVjG0xP++v+78GE2QUHU4DvnRwFFFAwwk6xxb4ticYk8lAFwTpABelSYYUcxY7wDACO77E1q1jusA4M6PzvXH1OxYh7pd4AjRACHGe7dQSENkDeDc0qoyEM6r7LkWAdiMX6o6YkwV5sIWuEMATGgi3f+LObhcnpQYr4soWxq1elEIgBRf29W6ONoFgFDjuTtVGwD3/1jydgFgI3v4xhLMXMazbG8EYO6p/bsA4FOrLuO5N2mtJUIBsCrUxVGskcgeTmoYfy4RX+uCa1sNU6Utrosj3493AcHXG7QZv3BI90oAfMVR7JFRWi4qGP8q3y+aAuDom7Wc95uOysZXBeArjg7S+KoATFOj7yiODs74OgB8xdHBGV8HABdHXanCKMbXAVBWHB2U8XUBsCrsOhu0ZnxdAFwcdSWKWje+LgDOBl15wZXAbs34JgBYFK3lQmIVSDcW6dvY+CYAbF4QYyv0ZN5BDOObAkgFQo8gjFvyBJvLm7J21IbxTQG4ujMbeb9uTDgXd88s55zd3V0BcEEw3vBYAcRQ5rIZ/innlm0Hl7aeGBnJqvUcwimXv43s377KHhn8t71bdflYAIxMfqTA2GS8irvnMXNrjGeGRvJXF8RCQEY1PCYAnSWMeyf4egPFjJVKqTl28Pzg76OzvwB+OIB/AwDb01qfQq6nbwAAAABJRU5ErkJggg==" />--%>
                    </div>
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">品质入库确认</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar" data-theme="c">
                    <ul>
                        <li><a href="#pageOne" data-transition="none" data-theme="c">品质入库确认</a></li>
                        <li><a href="#" data-transition="none" class="ui-btn-active" data-theme="c">Agv托运入库查看</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <div style="text-align: center; font-size: 14px" id="rmsg" class="msg">
                    </div>
                    <table data-role="table" id="AGVInfo" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%">
                        <thead>
                            <tr>
                                <th>地表码名称
                                </th>
                                <th>AGV地表码
                                </th>
                                <th>状态
                                </th>
                                <th>时间
                                </th>
                            </tr>
                        </thead>
                        <tr id="trNCInfo" class="ListTableOddRow">
                            <td colspan="4" style="text-align: center;">暂无数据
                            </td>
                        </tr>
                    </table>
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
            var UIid = 80012700 + ',' + 80012701;
            var USTid = "0";
            var SN = "";
            var Rack = "";
            var Number = 0;
            var EndAgvCode = "";
            var IsPass = 1;
            $(document).bind("mobileinit", function () {
                $.mobile.ajaxEnabled = false;
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
            });

            $('input[name="checkResult"]').on("click", function () {
                if ($(this).val() == 0) {
                    //移除其他选项的选中状态
                    $("input[name='IsYsQy']").prop('checked', false);
                    $("input[name='IsYsQy'][value='2']").prop('checked', true);
                } else {
                    $("input[name='IsYsQy']").prop('checked', false);
                    $("input[name='IsYsQy'][value='1']").prop('checked', true);
                }
            });

            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("body>[data-role='listview']").listview();
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                //$("#OKOrNg").hide();
                $("#Remark").hide();
            });


            //查询页隐藏columntoggle列表按钮
            $(document).on("pageshow", "#Search,#pageTwo", function (event) {
                $(".ui-body-c").css("background", "#fff");
                $(".ui-table-columntoggle-btn").css("display", "none");
            });


            $("input[name='receivingMethod']").on("click", function () {
                var receiveChoosePageId = $("input[name='receivingMethod']:checked").val();

                if (receiveChoosePageId == "1") {
                    IsPass = 0;
                } else {
                    IsPass = 1;
                }
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
                if (_id == "#pageTwo") {
                    /*查询AGV托运入库*/
                }
            });

            $("#txtSN").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    afterScan();
                }
            });


            function afterScan() {
                if (sltStationId == -1) {
                    showAreaMessge("请选择工序", "messageRed");
                    return false;
                }
                if (sltResId == -1) {
                    showAreaMessge("请选择资源", "messageRed");
                    return false;
                }
                SN = $("#txtSN").val();
                if (SN === "") {
                    showAreaMessge("请扫描SN", "messageRed");
                    return false;
                }
                //zhiman.yuan 2017-8-16 修改通用过站验证
                var data = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(SN, sltResId, sltStationId, false);
                if (data.error != null) {
                    var myMsg = data.error.Message;
                    myMsg = myMsg.replace("DBCC 执行完毕。如果 DBCC 输出了错误信息，请与系统管理员联系。", "");
                    showAreaMessge(SN + ":" + myMsg, "messageRed");

                    $("#txtSN").select();
                    //写入日志
                    SaveUserUILog("一般", sltStationId, sltResId, SN, data.error.Message);
                    return false;
                }

                //带出条码编码与数量 
                var entity = {};
                entity.SerialNumber = SN;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetCollectionCheckBySN", JSON.stringify(entity));

                if (ajax.error != null) {
                    $("#txtSN").val("").focus();
                    showAreaMessge(SN + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, SN, ajax.error.Message);
                    return false;
                }

                var list = JSON.parse(ajax.value).data;
                if (list.length > 0) {
                    $("#lblItemCode").html(list[0].ItemCode);
                    $("#lblQty").html(list[0].SNqty);
                    $("#lblBoxSN").html(list[0].BoxSN);
                }

                $("#txtSN").val("");

                /**/

            }

            //function afterScanAgv() {
            //    if (sltStationId == -1) {
            //        showAreaMessge("请选择工序", "messageRed");
            //        return false;
            //    }
            //    if (sltResId == -1) {
            //        showAreaMessge("请选择资源", "messageRed");
            //        return false;
            //    }
            //    SN = $("#txtSN").val();

            //    if (SN === "") {
            //        showAreaMessge("请扫描SN", "messageRed");
            //        return false;
            //    }

            //    //zhiman.yuan 2017-8-16 修改通用过站验证
            //    var data = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(SN, sltResId, sltStationId, false);
            //    if (data.error != null) {
            //        var myMsg = data.error.Message;
            //        myMsg = myMsg.replace("DBCC 执行完毕。如果 DBCC 输出了错误信息，请与系统管理员联系。", "");
            //        showAreaMessge(SN + ":" + myMsg, "messageRed");

            //        $("#txtSN").select();
            //        //写入日志
            //        SaveUserUILog("一般", sltStationId, sltResId, SN, data.error.Message);
            //        return false;
            //    }

            //    var AgvCode = $("#txtAVGSN").val();
            //    /*验证AVG,并获取终点Agv*/
            //    var entity = {};
            //    entity.GRN = SN;
            //    entity.Agv = AgvCode;
            //    entity.TurnoverPackaging = $("#TurnoverPackaging").prop('checked');
            //    var AgvData = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetEndAgv", JSON.stringify(entity));
            //    if (AgvData.error != null) {
            //        showAreaMessge(AgvData.error.Message, "messageRed");
            //        return false;
            //    }
            //    $("#msg").html("");
            //    EndAgvCode = JSON.parse(AgvData.value).data[0].EndAgv;
            //}

            function Pass() {

                if (sltStationId == -1) {
                    showAreaMessge("请选择工序", "messageRed");
                    return false;
                }
                if (sltResId == -1) {
                    showAreaMessge("请选择资源", "messageRed");
                    return false;
                }

                var scanSN = $("#lblItemCode").html();
                if (scanSN == "") {
                    $("#txtSN").val("").focus();
                    showAreaMessge("请扫描条码！", "messageRed");
                    return false;
                }

                //if (EndAgvCode === "") {
                //    showAreaMessge("未获取到AGV终点地表码,请重新扫描起始AVG获取!", "messageRed");
                //    return
                //}

                //if (IsPass = 0 && $("#txtRemark").val() === "") {
                //    $("#txtRemark").focus();
                //    showAreaMessge("请填写备注!", "messageRed");
                //    return;
                //}

                /*调用AGV接口下达任务*/

                //2.开始对当前sn进行校验及执行activity**********待确定流程
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId, false);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }

                var checkResult = $('input[name="checkResult"]:checked').val();
                var txtNcDesc = $.trim($('#txtNcDesc').val());

                if (checkResult == 0 && txtNcDesc == "") {
                    showAreaMessge("请输入不良描述信息!", "messageRed");
                    $('#txtNcDesc').val("").focus().select();
                    return false;
                }


                var isTy = $('input[name="IsTy"]:checked').val();  //是否托运
                if (isTy == 1) {

                    var txtStatrAgv = $.trim($("#txtStatrAgv").val());
                    if (txtStatrAgv == "") {
                        showAreaMessge("起点AGV地标码不能为空！", "messageRed");
                        $("#txtStatrAgv").val("").focus().select();
                        return false;
                    }
                    var txEndtAgv = $.trim($("#txtAgvEnd").val());
                    if (txEndtAgv == "") {
                        showAreaMessge("终点AGV地标码不能为空！", "messageRed");
                        $("#txtAgvEnd").val("").focus().select();
                        return false;
                    }
                    if (txtStatrAgv === txEndtAgv) {
                        showAreaMessge("起点终点不可相同！", "messageRed");
                        $("#txtAgvEnd").val("").focus().select();
                        return false;
                    }
                }

                var entity = {};
                entity.OpenId = stationId;
                entity.SerialNumber = scanSN;
                entity.ResId = resourceId;
                entity.NcDesc = txtNcDesc;
                entity.CheckResult = checkResult;
                entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("usptCollectionCheckPass", JSON.stringify(entity));
                if (ajax.error != null) {
                    updateCollectionList(scanSN, 'NG');
                    $("#txtSN").val("").focus();
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }


                if (isTy == 1) {


                    var AgvCheckType = $('input[name="IsTcType"]:checked').val();
                    var AgvTransportType = $('input[name="IsYsQy"]:checked').val();
                    if (AgvTransportType == 1) {
                        AgvTransportType = "立体库";
                    } else if (AgvTransportType == 3) {
                        AgvTransportType = "暂存区";
                    } else if (AgvTransportType == 2) {
                        AgvTransportType = "待检区";
                    }

                    var uniqueCode = AgvCheckType == 1 ? "X" : "T" + generateUniqueCode();
                    let req =
                    {
                        "msgType": "creatTask",
                        "taskEnd": txEndtAgv,
                        "taskID": uniqueCode,
                        "taskStart": txtStatrAgv
                    }
                    let reqUrl = 'http://172.16.15.216:9123/agvs'
                    //发送agv指令，然后保存数据到数据库
                    let listStr = "";
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.SendAgv(req, reqUrl, listStr, "检验完工", AgvCheckType == 1 ? "台车" : "托盘", AgvTransportType);
                    if (ajax.error != null) {
                        showAreaMessge(ajax.error.Message, "messageRed");
                        return false;

                    }
                }
                clear();
                //refreshProInfoBySN(scanSN);
                showAreaMessge(scanSN + ':通过 ！', 'messageGreen');
                //updateCollectionList(scanSN, 'OK');
                ////过站操作
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.UnitComplete(SN, sltStationId, sltResId, true);
                //if (ajax.error != null) {
                //    var myMsg2 = ajax.error.Message;
                //    myMsg2 = myMsg2.replace("DBCC 执行完毕。如果 DBCC 输出了错误信息，请与系统管理员联系。", "");
                //    showAreaMessge(SN + ":" + myMsg2, "messageRed");
                //    $("#txtSN").val("").focus();
                //    //写入日志
                //    SaveUserUILog("一般", sltStationId, sltResId, SN, ajax.error.Message);
                //    return false;
                //}
                //else if (ajax.json == undefined) {
                //    showAreaMessge(SN + '：' + "未接收到系统返回信息，请检查是否登录已超时或网络中断！", "messageRed");
                //    $("#txtSN").val("");
                //    $("#txtSN").focus();
                //    return false;
                //}
                //showAreaMessge(SN + ":扫描过站成功", "messageGreen");

                ///*记录 */
                //var entity = {};
                //entity.SN = SN;
                //entity.Pass = IsPass;
                //entity.Remark = $.trim($("#txtRemark").val());
                //entity.WarnType = $("#warn").val();
                //entity.CreateBy = userName;
                //entity.IsTurnoverPackaging = $("#TurnoverPackaging").prop('checked');
                //SKT.AjaxCommon.DBService.ExecuteSpc("uspInsertQualityInStockHistory", JSON.stringify(entity));


                //SN Check
                stationRefreshBySN(SN);
                //加载前五条扫描记录
                SetOrderCode(sltStationId);
                $("#txtSN").val("");
                $("#txtSN").focus();
            }

            var tab = document.getElementById("tbTransferItem");
            function SetOrderCode(StationId) {
                $("#tbTransferItem  tr:not(:first)").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetPassStationBySN(StationId);

                if (ajax.error != null) {
                    showAreaMessge(ajax.error.Message, "messageRed");
                    return false;
                }
                var List = $.parseJSON(ajax.value).data;
                for (var i = 0; i < List.length; i++) {
                    addDetail(List[i], i);
                }
            }

            function clear() {
                $("#lblItemCode").html("");
                $("#lblQty").html("");
                $("#lblBoxSN").html("");
                $('#txtNcDesc').val("");
                $("input[name='IsYsQy']").prop('checked', false);
                $("input[name='checkResult']").prop('checked', false);
                $("input[name='checkResult'][value='1']").prop('checked', true);
                $("input[name='IsYsQy'][value='2']").prop('checked', true);
            }


            function addDetail(entity, i) {
                if (entity == null) {
                    return;
                }
                i += 1;
                $("#trNoInfo").remove();
                var row, cell;
                rowNewIdx = tab.rows.length;
                row = tab.insertRow(rowNewIdx);
                row.className = "ListTableOddRow";

                cell = row.insertCell(0);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = entity.ID;

                cell = row.insertCell(1);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = entity.SN;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = parseFloat(entity.BatchQty);

            }


            /*
            *根据sn获取前后工序信息并回显
            */
            function stationRefreshBySN(serialNumber) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetLastNextStationBySNPDA(sltStationId, serialNumber);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                $("#LastStation").html(ajax.value[0]);
                $("#NextStation").html(ajax.value[1]);
                orderNo = ajax.value[2];
                $('#ProdOrderNo').html(ajax.value[2]);
                $('#labItemCode').html(ajax.value[3]);
                $('#labQtyStr').html(ajax.value[4]);
                prodOrderId = ajax.value[5];
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


            function chooseStation() {

                /*根据用户获取所有的工位类型*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetStationsByFixedUI('Common_ProCollectionUI,NC_ProCollectionUI');
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
                for (var i = 0; i < list.length; i++) {
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
            //显示消息
            function RshowAreaMessge(msg, type) {
                $("#rmsg").html(msg).css("color", type == "messageGreen" ? "#99FF33" : "#ff0000");

            }
            //显示消息
            function ScraphowAreaMessge(msg, type) {
                $("#Scrapmsg").html(msg).css("color", type == "messageGreen" ? "#99FF33" : "#ff0000");

            }

            /*
        *采集过站
        */
            function collectionPass() {
                if (NcSNArr.length < 1) {
                    RshowAreaMessge('无不良采集信息，请扫描！', "messageRed");
                    $("#txtNcCode").select().focus();
                    return false;
                }
                var xml = resultToXml();
                var isNc = 0;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.CollectPassStationNEW(panelId, NcSNArr[0].SN, sltResId, sltStationId, xml);
                if (ajax.error != null) {
                    RshowAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    return false;
                }

                RshowAreaMessge('采集不良成功！', "messageGreen");
                Clear();
            }

            function Clear() {
                $("#NCInfo  tr:not(:first)").html("");
                $("#txtNcCode").val("").select().focus();
                $("#txtSCANSN").val("");
                $("#txtNcQty").val("");
                $("#txtNcPosition").val("");
                isPanel = 0;
                NcSNArr = [];
                panelId = -1;
                panelSNList = [];
                ScanNCCode = "";
                NCDesc = "";
                mySCANSN = "";
                isBatch = 0;
                panelSN = '';
                panelSNStr = "";
                OrderNo = "";
                BatchQty = 1;
            }

        </script>
    </form>
</body>
