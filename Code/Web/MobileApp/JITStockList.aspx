<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JITStockList.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.JITStockList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-9" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">
    <title>JIT发料</title>
    <style type="text/css">
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
    <form id="form1" runat="server">
        <div data-role="page">
            <div data-role="header" data-position="fixed" style="vertical-align: bottom">
                <h5 style="padding: 4px; margin: 0px;">
                <%--    <div>
                        <img src="images/icon/bl_white.png" />
                        <%--<img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7pmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjRUMTk6MDQ6MzErMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1NDoyMCswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTQ6MjArMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6NTM1YjEzMTgtMzU1MS1iNzRlLTlmM2YtNTYzNTY0ZDRkYzhmPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6M2Y3NDUxYzgtMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6ZGI5NGNhYTMtNTQ4OS1lNDRiLWI3NzctMWRjODQzOWRmYTUyPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOmRiOTRjYWEzLTU0ODktZTQ0Yi1iNzc3LTFkYzg0MzlkZmE1Mjwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNFQxOTowNDozMSswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpmZmViZDU2Zi1lMzYxLTc5NDAtOThlNC1jOTNiNDkzYTNlNzQ8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjdUMDk6MDU6NDIrMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6NTM1YjEzMTgtMzU1MS1iNzRlLTlmM2YtNTYzNTY0ZDRkYzhmPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU0OjIwKzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg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" />
                    </div>--%>
                    <div>
                          <label id="lbltitle" style="font-size:17px !important;font-weight: bold; color: #FFFFFF">JIT发料</label>
                    </div>
                   
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <label for="listno">
                                排程工单</label>
                        </td>
                        <td>
                            <input class="orderno" id="orderno" type="text" data-mini="true"
                                value="" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择工单</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="workorderlist">
                                领料单</label>
                        </td>
                        <td colspan="2">
                            <select name="select-custom-20" id="applylist" data-mini="true" class="applylist">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="perparelist">
                                设备</label>
                        </td>
                        <td colspan="2">
                            <select name="select-custom-20" id="equipmentlist" data-mini="true" class="equipmentlist">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="GRN">
                                GRN</label>
                        </td>
                        <td colspan="2">
                           <input class="GRN" id="GRN" type="text" data-mini="true"
                                value="" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <div>
                    <table data-role="table" id="jitTb" <%--data-mode="reflow"--%> data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%;">
                        <thead>
                            <tr>
                                <th>物料编码
                                </th>
                                <th>库位
                                </th>
                                <th>料站
                                </th>
                                <th>应发数量
                                </th>
                                <th>已发数量
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

                <div data-role="popup" id="myPopup" class="ui-content" data-position-to="#myId" data-overlay-theme="b">
                    <ul data-role="listview" id="worklist">
                    </ul>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="g">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="StartCheck" onclick="JITSendMaterial(1)" data-role="button"
                            data-fullscreen="true" data-theme="g">确认发料</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>
    </form>
    <script src="js/jqPaginator.js"></script>
    <script type="text/javascript">
        var itemStr = ""; //存储领料单对应的ItemId
        var flage = 0; //为true可取消先进先出推荐
        var UserId = 0;
        var FIFO = "-1";
        $(function () {
             UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>";
            var mark = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckUserIsWarrantted(UserId).value;
            if (mark) {
                FIFO = "1";
            }
            else {
                //没权限
                FIFO = "-1";
            }
            $(".ui-body-c").css("background", "#fff");
            $("body>[data-role='listview']").listview();
            $(".ui-select").css({ "margin": 0 });

            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#orderno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
            $("#orderno").focus();
            $("#GRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });

            /*扫描工单条码*/
            $("#orderno").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if (this.value == "") {
                        return false;
                    }
                    SetOrder($.trim(this.value));
                }
            });

            /*扫描物料条码*/
            $("#GRN").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if (this.value == "") {
                        return false;
                    }
                    JITSendMaterial();
                }
            });

            $("#equipmentlist").on("change", function (e) {
                GetJITList("");
                $("#GRN").select();
            });

            $("#btnFilter").on("click", function () {
                $("#listviews").html("");
                var value = $.trim($("input[data-type='search']:eq(0)").val());

                if (value == "") {
                    return false;
                }

                var data = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetLinePlanList(value);
                if (data.error != null) {
                    $("#msg").html(data.error.Message).css("color", "red");
                    return false;
                }
                var ulhtml = "";

                var entity = data.value;

                if (entity == null) {
                    return false;
                }
                for (var i = 0; i < entity.length; i++) {
                    if (ulhtml.indexOf(entity[i].PlanOrderNo) == -1) {
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' title=\"" + entity[i].PlanOrderNo + "\"><a onclick=SetOrder(\'" + entity[i].PlanOrderNo + "\') >" + entity[i].PlanOrderNo + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            });
        });

        //根据字符串模糊查询采购单
        $("#listviews").on("filterablebeforefilter", function (e, data) {
            //var $ul = $(this)
            //$input = $(data.input)
            //value = $.trim($input.val());

            //if (value && value.length > 2) {
                
            //}
        });

        /**
        *JIT发料
        **/
        function JITSendMaterial(showMessage) {
            if (showMessage) {
                $("#msg").html($("#GRN").val() + " 备料成功!");
                $("#GRN").val("").select();
                return;
            }
            var lineno = $.trim($("#orderno").val());
            var applyId = $("#applylist").find(":selected").val();
            var equipmentId = $("#equipmentlist").find(":selected").val();
            var grn = $.trim($("#GRN").val());
            if (lineno == "") {
                confirmDialogFocus("请扫描排程工单！", function () {
                    $("#orderno").select();
                });
                return false;
            }
            else if (applyId == "") {
                confirmDialogFocus("请选择领料单！", function () {
                    $("#orderno").select();
                });
                return false;
            }
            else if (equipmentId == "") {
                confirmDialogFocus("请选择设备！", function () {
                    $("#equipmentlist").select();
                });
                return false;
            }
            else if (grn == "") {
                confirmDialogFocus("请扫描GRN！", function () {
                    $("#GRN").select();
                });
                return false;
            }

            flage = 0; //默认需要遵循先进先出，没有遵循则提示用户
            //校验GRN
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckGrnMaterialPrepare(itemStr, grn, flage, "");

            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message).css("color", "red");
                $("#GRN").select();
                return false;
            } else {

                var list = ajax.value[0];

                if (list.Flage == 0) {
                    if (FIFO !== "1") {//没有取消FIFO的权限
                        alert("请按照先进先出原则备料");
                        $("#GRN").select();
                        return false;
                    } else {
                        if (!confirm("您没有遵循先进先出原则，是否确认操作？")) {
                            $("#GRN").select();
                            return false;
                        }
                    }
                }
            }
            
            var data = SKT.LeanMES.Web.AjaxServices.AjaxStockList.CollectStockListMaterial(lineno, applyId, grn, equipmentId);

            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                $("#GRN").select();
                return false;
            }
            var itemCode = data.value;
            $("#msg").html($("#GRN").val()+" 备料成功!");
            GetJITList(itemCode);                       
            $("#GRN").val("").select();
            //setTimeout(function () {
            //    $("#msg").html("");
            //}, 1500);
        }

        /**
        *设置工单信息
        **/
        function SetOrder(planNo) {           
            $("#orderno").val(planNo);
            $("#fpanel").panel("close");
            GetApply();
            GetEquipment();
            GetJITList("");
            $("#GRN").select();
        }

        /**
        *获取领料单信息
        **/
        function GetApply() {
            var data = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetApplyNo($.trim($("#orderno").val()));
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            var entity = data.value;
            if (entity == null) {
                return false;
            }
            $("#applylist").html('');
            if (entity.Rows.length == 1) {
                $("#applylist").append("<option value='" + entity.Rows[0].ApplyId + "'>" + entity.Rows[0].ApplyNo + "</option>");
                $("#applylist").prop("selected", "selected");
            }
            else {
                for (var i = 0; i < entity.Rows.length; i++) {
                    $("#applylist").append("<option value='" + entity.Rows[i].ApplyId + "'>" + entity.Rows[i].ApplyNo + "</option>");
                }                
            }
            $("#applylist").selectmenu('refresh', true);           
        }

        /**
        *获取设备信息
        **/
        function GetEquipment() {
            var data = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetPDAEquipmentList($.trim($("#orderno").val()));
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            var entity = data.value;
            if (entity == null) {
                return false;
            }
            $("#equipmentlist").html('');
            if (entity.Rows.length == 1) {
                $("#equipmentlist").append("<option value='" + entity.Rows[0].EquipmentId + "'>" + entity.Rows[0].EquipmentCode + "</option>");
                $("#equipmentlist").prop("selected", "selected");
            }
            else {
                for (var i = 0; i < entity.Rows.length; i++) {
                    $("#equipmentlist").append("<option value='" + entity.Rows[i].EquipmentId + "'>" + entity.Rows[i].EquipmentCode + "</option>");
                }
            }
            $("#equipmentlist").selectmenu('refresh', true);
        }

        /**
        *获取JIT叫料列表
        **/
        function GetJITList(itemCode) {
            var equipmentId = $("#equipmentlist").find(":selected").val();
            var data = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetJITStockList($.trim($("#orderno").val()), equipmentId);
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                $("#jitTb tbody").html("");
                $("#jitTb").table("refresh");
                return false;
            }
            list = data.value;
            
            if (list.length == 0) {
                $("#msg").html("未找到需要备料的信息！").css("color", "red");                
                $("#jitTb tbody").html("");
                $("#jitTb").table("refresh");                
                GetEquipment();             
                if ($("#equipmentlist").val() != null && $("#equipmentlist").val() != undefined) {
                    $("#equipmentlist").change();
                }
                
                return false;
            }

            var htmlstr = "";
            var css = "";
            itemStr = "";
            for (var i = 0; i < list.length; i++) {
                css = "";
                if (itemCode == list[i].ReplaceMaterial) {
                    css = "style='background-color:#6BE26B;'";
                }

                itemStr += list[i].ItemId+","
                htmlstr += "<tr " + css + " class='ItemRow'><td>" + list[i].ReplaceMaterial + "</td><td>" + list[i].CbarCode + "</td><td>" + list[i].Positon + "</td><td>" + list[i].ShouldIssue + "</td><td>" + list[i].AlreadyIssue + "</td></tr>"
            }

            $("#msg").html('');
            $("#GRN").select();
            $("#jitTb tbody").html(htmlstr);
            $("#jitTb").table("refresh");
        }
    </script>
</body>
</html>
