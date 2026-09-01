<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WarehouseMaterialPrepare.aspx.cs"
    Inherits="SKT.LeanMES.Web.MobileApp.WarehouseMaterialPrepare" %>

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
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <title>仓库备料</title>
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
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <%--        <div>
                        <img src="images/icon/bl_white.png" />
                        <img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7pmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjRUMTk6MDQ6MzErMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1NDoyMCswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTQ6MjArMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6NTM1YjEzMTgtMzU1MS1iNzRlLTlmM2YtNTYzNTY0ZDRkYzhmPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6M2Y3NDUxYzgtMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6ZGI5NGNhYTMtNTQ4OS1lNDRiLWI3NzctMWRjODQzOWRmYTUyPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOmRiOTRjYWEzLTU0ODktZTQ0Yi1iNzc3LTFkYzg0MzlkZmE1Mjwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNFQxOTowNDozMSswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpmZmViZDU2Zi1lMzYxLTc5NDAtOThlNC1jOTNiNDkzYTNlNzQ8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjdUMDk6MDU6NDIrMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6NTM1YjEzMTgtMzU1MS1iNzRlLTlmM2YtNTYzNTY0ZDRkYzhmPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU0OjIwKzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz7t+uXKAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAaFSURBVHja1FrrWeNIECxFgC4CRAQrIkBEsCYCIII1EcBGsBABdgTYEawdASKCkyNYEYHux/Vw7brp0ehhYeb7+ABbj6nqV3VLSdM0OML1HUABIJefFEANoARQAVgB2Mpng1ZyZARcA3gAkEUcWwN4BPA0hIhjISAD8CLW7rpqAJfiHV+SgBzAb3Fzvbbi6iUdW0iI8LoFsPhqBPjArwHMJdatlYr7X9PnlwA2X4UAH/iuVpzJ8ScqHM5byDsKAsYAr6/1qv5fAbg6ZgLGBO/WHMCvPqEwNQGHAO9WBeBU/l4CuDk2Ag4Jnr2gAnB2TAQcGrzTEn+r/89jtMEUBEwB3q2max44NAFTgocAvuhyn0MSMDV4SAhkx+ABnwH+aELgs8CzIDqLUYRjE2A1NjpGR+3n1XoE8EP+fovtLMckoA38Qfp5owTeybUnI6Ar+NH6eVkv0hgBwLsQUk9FwKf28/h3gnSv/v8pn03SDH12P38D4JlIL6acB+i62yn2RujnGfxODFJPRQC7ns+Fc3L3UjxkaD/P4N/F8p3zSF8CUrF+arSfuXRmhdG23pKrd+nnRwM/hAC9Cc66sRXhSqzdpZ8fFfwQAlbKtXmznBfeBFyqGhUX72eKuLZ+3gJfAfim9EAl35WHJKAxLMmb5KQ4k5rt1pMAb+vn+bqQfJMHFF8t+1qGKssYBGjNrT3DKklasrKlfc2MD3wfj73zVZc+BBQS4x/XMPpxS5DEnn8rv2PB7wTgRcAjrtgb+hDArtqVALZoYuSPTYuoeZcwWHjiPZNwm6vE6i3XY4SAjlV273OPMPmtgK2VhufrhlaM2rRK7N6e+xKgS5ZOdOwdpXjBWpLVPQHW1mBBZK3okTfpkg0pzjMAdV8CFkrHbyRh+ZJcaHHPHnNeH/BWBfoJ4KEvAXwxVm4LT6PD4AsVHuw5Y4P37asGcDakFyiVACmFhJqS3Vwd4zL1QqxdG/38ocA7Cf9Ha5ghBHA520iZqY1jS+O75xZwY4H3qtih7TC7eikkVJHWeJ7I8lZV2I4xEdp4xMeDbL4ydMS1bCSdGDx7bnQVyARk5gG/DSS9Sv1kAjiPuF+tSmst9ygPQECrDnCWyiPiKpGLn+AwqxKih06RNQE7i4CZxEnWI8Hs5PzTFhnrQifteI9aQuxphEmWNwfcGxp+R+4Mo/Go1EgrJxJrceVSrJAbGsEd584/NRLwbQ8CXtV9n5gAnxpbyuelkclnQtgpAb0MnMPgLX2gc9AN9meQPhXatZHb0wG+icsM8WPqB9qg1Qy9Evi13LuOBLAicaWHKm1LN2I7AJkjIJONpYZU1etChUNbq8uljDszq9Q5t3/z7CEVEi4CUjymK7wFsHAE6DLmGzQWYt3CM3K6o02yJ7jNpdifJHMrnEr43VDeKCU0lnTsRnlCWyiwYT4asaRpGtbHPMiwkmIo3nW7vFbDiV+K5EwRlwaSopX0WIrzlDkU2rnz4KRpGn0Abyx2HvfRX3vOqwH8xdmX4vY1UiDxeboh84WTD/yedydN0+w1B+oi7LI7ublz5zlVDD73D1nnxZgi8SbX4nGlqjA66ekhrPaqCvsD1lbwjgAeRC6MC/heO9Nl01na1yNsKWklgeMKT9KrlMLUXsBhkHQB7wiw3qvZU0zGgJLrqraORQBPgpqIOA7thUf0BTo8PYolYG20rezq+nxdWXYqKYYAWOUsloAlNWWtj86Spml0xtYb4PjyiRp2taRHCOj7W6JGCxida0KjtKjnhpwDdAnkiy+o5ufYfwjKXqJn/E+UMHWosPzmMPiB/cdrOk/xbLITeEeA3kAplrYmPpUck3pygvaeHP9/Za1UiUyDyOg75z21fJf7BExg+NrpiXHSNA1vVgNhxWUtFk96Y27T+jMuWZYlQ8BYvncGrwciPOE9p0T3aEx83iVmFwGF5qzNn/OT40KO87W+W7mPBsaT5F7vCjgCeHO+XjuTG6bKiitKjD7xlBkTWUtbzMjNV55jout8LAG+zXUdOORilSyQ0Djea7nHqsN9OCmO9oqML95LcdVQq+m6OJ7yWm+M+eJ94ekqfaLrmZLv6K/IWEmvlM/ZmgWFReyQwmqyVnIfbsVnnmZpMHhrKpyKRb73uJ4vKYZCZtNzivwmpFQYuEJj8UJc+FvktZYCvu5wf9dVziOJ2Em5XWCkFfNgJBeX5QntVk2FVhg2q0+Vqzvxc4L/3vbyheAo658BAOTYLNxJ/mCnAAAAAElFTkSuQmCC" />
                    </div>
                    <div>
                        仓库备料
                    </div>--%>
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">仓库备料</label>
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
                                领料单</label>
                        </td>
                        <td>
                            <input type="text" id="listno" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择单据</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="workorderlist">
                                工单</label>
                        </td>
                        <td colspan="2">
                            <select name="select-custom-20" id="workorderlist" data-mini="true" class="workorderlist">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="perparelist">
                                备料到</label>
                        </td>
                        <td colspan="2">
                            <select name="select-custom-20" id="perparelist" data-mini="true" class="perparelist">
                                <option value="2">产线</option>
                                <option value="1">线边仓</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Print">
                                打印机</label>
                        </td>
                        <td colspan="2">
                            <select id="PDAselPrintersList" data-mini="true" class="perparelist">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="GRN">
                                GRN</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="GRN"  androidScan="true"/>
                        </td>
                    </tr>
                    <tr id="iframeGrnList">
                        <td>
                            <label for="barcodes">
                                库位：</label>
                        </td>
                        <td id="barcodes"></td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <div>
                    <table data-role="table" id="preparetab" <%--data-mode="reflow"--%> data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%;">
                        <thead>
                            <tr>
                                <th>物料编码
                                </th>
                                <th>领料数量
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <%--                <div class="jpage">
                    <ul id="jyjpage" style="text-align: center;" class="pagination pagination4">
                    </ul>
                    <p id="demo4-text">
                    </p>
                </div>--%>
                <div data-role="popup" id="myPopup" class="ui-content" data-position-to="#myId" data-overlay-theme="b">
                    <ul data-role="listview" id="worklist" style="margin-top:-265px;align-content:center">
                    </ul>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="StartCheck" onclick="Save()" data-role="button"
                            data-fullscreen="true" data-theme="a">确认备料</a></li>
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
        var whList = [];
        var requestOrder = 0; //领料单号
        var itemStr = ""; //存储领料单对应的ItemId
        var grnStr = ""; //存储扫描的Grn
        var FLgrnStr = ""; //存储分料截料GRN
        var NewFLgrnStr = "";//分料截料成功备料完成之后返回的新GRN，用于打印
        var itemAllQty = 0; //领料单总数量
        var requtestQty = 0;   //备料数量
        var flage = 0; //为true可取消先进先出推荐
        var requestId = 0;
        var selItemId = "";
        var rowCount = 0;//总记录数
        var pageSize = 4;//最大显示行数
        var UserId = 0;
        var FIFO = "-1";
        var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
        var GrnArr = [];//每次扫描的GRN存入进来
        $(function () {
            $(".ui-body-c").css("background", "#fff");
            UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>";
            getmaterialsysconfig();
            var mark = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckUserIsWarrantted(UserId).value;
            if (mark) {
                FIFO = "1";
            }
            else {
                //没权限
                FIFO = "-1";
            }
            //切换备料位置
            $("#perparelist").change(function () {
                setPickingList($("#workorderlist").find(":selected").val());
            });
            //获取打印机名称
            $(document).ready(function () {
                bindPrinters('PDAselPrintersList', function () {
                    if ($("#PDAselPrintersList").val()) {
                        $("#PDAselPrintersList-button span").text($("#PDAselPrintersList").find("option:selected").text());
                    }
                });
            });
            //bindPrinters('PDAselPrintersList');
            //$("#PDAselPrintersList").selectmenu('refresh', true);
            //$("#jyjpage").jqPaginator({
            //    //totalPages: 0,    //总页数
            //    totalCounts: 1, //分页的总条目数
            //    visiblePages: 1,
            //    pageSize: pageSize,     //每一页的条目数 注意：要么设置totalPages，要么设置totalCounts + pageSize，否则报错；设置了totalCounts和pageSize后，会自动计算出totalPages。
            //    currentPage: 1, //	设置当前的页码
            //    first: '<li class="prev"><a href="javascript:void(0);">第一页<\/a><\/li>',
            //    prev: '<li class="prev"><a href="javascript:void(0);">前一页<\/a><\/li>',
            //    next: '<li class="next"><a href="javascript:void(0);">后一页<\/a><\/li>',
            //    page: '<li class="page"><a href="javascript:void(0);"> {{page}} / {{totalPages}} <\/a><\/li>'
            //});
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#listno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
            $("#listno").focus();
            $("#GRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });
            initLocSel();

            //扫描领料单
            $('#listno').on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html("");
                    $("#iframeGrnList").css("display", "none");

                    if ($.trim($(this).val()) == "") {
                        $("#msg").html("领料单不能为空！").css("color", "red");
                        $(this).val('').focus();
                        return false;
                    }
                    $("#preparetab tbody").html('');
                    requestOrder = $.trim($(this).val());
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetWorkOrderInfo(requestOrder);
                    if (ajax.error != null) {
                        //confirmDialogFocus(ajax.error.Message, function () {
                        //    $(this).val('').focus();
                        //});
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        $(this).val('').focus();
                    }


                    $("#workorderlist").html('');
                    $("#worklist").html('');
                    var result = ajax.value;
                    if (result.length < 1) {
                        $("#msg").html("领料单输入错误！").css("color", "red");
                        return false;
                    }
                    if (result.length == 1) {
                        $("#workorderlist").append("<option value='" + result[0].MOCode + "'>" + result[0].MOCode + "</option>");
                        $("#workorderlist").prop("selected", "selected");
                        setPickingList($("#workorderlist").find(":selected").val());
                    }
                    else {
                        for (var i = 0; i < result.length; i++) {
                            $("#workorderlist").append("<option value='" + result[i].MOCode + "'>" + result[i].MOCode + "</option>");
                            $("#worklist").append("<li><a id='" + result[i].MOCode + "' onclick='bind(this)'>" + result[i].MOCode + "</a></li>");
                        }
                        $("#myPopup").popup('open');
                    }
                    $("#workorderlist").selectmenu('refresh', true);
                    $("#worklist").listview('refresh');
                }
            });
            /*扫描物料条码*/
            $("#GRN").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    SendMaterial();
                    $(document).scrollTop(240);
                }
            });

            //筛选
            $("#btnFilter").on("click", function () {
                $("#listviews").html("");
                var $ul = $(this),
                value = $.trim($("input[data-type='search']:eq(0)").val());

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetListStatuePlus(value);
                if (ajax.error != null) {
                    $("#showGrn").html(ajax.error.Message);
                    $("#showGrn").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }

                var entity = ajax.value;
                if (entity.error != null) {
                    confirmDialogFocus(entity.error, function () {
                        $("#orderno").focus();
                    });
                };
                var ulhtml = "";
                for (var i = 0; i < entity.length; i++) {
                    if (ulhtml.indexOf(entity[i].ApplyNo) == -1) {
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' title=\"" + entity[i].ApplyNo + "\"><a onclick='SetPOCode(this)' style='font-size:80%;'>" + entity[i].ApplyNo + "</a></li>";
                    }
                }
                $("#listviews").html(ulhtml);
                $("#listviews").listview("refresh");
            });
        });

        var IsSeparateCutting = 2;//仓库备料是否自动分料：1：需要 2：不需要 默认不需要
        function getmaterialsysconfig() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(22);
            if (ajax.error == null) {
                var entity = $.parseJSON(ajax.value).data[0];
                IsSeparateCutting = entity.ChoosePageId;
            }
        }


        //选择工单弹窗
        function bind(data) {
            $("#myPopup").popup("close");
            $("#workorderlist option[value='" + $(data).attr('id') + "']").prop("selected", "selected");
            $("#workorderlist").selectmenu('refresh', true);
            setPickingList($("#workorderlist").find(":selected").val());
        };
        //选择工单下拉
        $("#workorderlist").on("change", function () {
            //工单号
            setPickingList($(this).find(":selected").val());
        });

        //浮点数相加

        function dcmAdd(arg1, arg2)
        {
            var r1, r2, m;
            try { r1 = arg1.toString().split(".")[1].length; } catch (e) { r1 = 0; }
            try { r2 = arg2.toString().split(".")[1].length; } catch (e) { r2 = 0; }
            m = Math.pow(10, Math.max(r1, r2));
            return (accMul(arg1, m) + accMul(arg2, m)) / m;
        }

        //浮点数相减  
        /*
         * 说明同上面的加法
         * */
        function dcmSub(arg1, arg2)
        {
            return dcmAdd(arg1, -arg2);
        }

        function accMul(arg1, arg2)
        {
            var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
            try { m += s1.split(".")[1].length } catch (e) { }
            try { m += s2.split(".")[1].length } catch (e) { }
            return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
        }


        //扫描GRN
        function SendMaterial() {
            //删除高亮
            $("#preparetab tr").css('background-color', '');
            if ($.trim($("#GRN").val()) == "") {
                $("#msg").html("物料条码不能为空!").css("color", "red");
                $("body").scrollTop(0);
                $("#GRN").focus();
                $("#GRN").select();
                return false;
            }
            if (requestOrder == 0) {
                $("#msg").html("请先选择对应的领料单!").css("color", "red");
                $("body").scrollTop(0);
                $("#listno").focus();
                $("#listno").select();
                return false;
            }
            //xiang.yan 2024-06-27 将扫描的条码转成大写,防止大小写不一致时无法匹配，多次扫描
            var grn = $.trim($("#GRN").val()).toUpperCase();

            //包装判断
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IsPack(grn);
            if (ajax.value != "" && ajax.value != null) {
                //if (!window.confirm("该物料【" + grn + "】已存在包装【" + ajax.value + "】，是否解除包装!")) {
                //    return false;
                //}
                grn = ajax.value;
            }

            if (GrnArr.length > 0) {
                var grnInfo = null;
                $.each(GrnArr, function (i, o) {
                    
                    if (grn == o.GRN) {
                        grnInfo = o;
                        return false;
                    }
                });
                if (grnInfo) {
                    if (confirm("该条码已经扫描完成,是否清除?")) {
                        ClearGrn(grn, grnInfo.BalanceQty, grnInfo.partid);
                    } else {
                        $("#msg").html("该条码已经扫描完成，不能重复扫描!");
                        $("#msg").css("color", "red");
                        $("#GRN").focus();
                        $("#GRN").select();
                    }
                    return false;
                }
            }

            //包装判断
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IsPack(grn);
            if (ajax.value != "" && ajax.value != null) {
                if (!window.confirm("该物料【" + grn + "】已存在包装【" + ajax.value + "】，是否解除包装!")) {
                    return  false;
                }
            }

            flage = 0; //默认需要遵循先进先出，没有遵循则提示用户
            //校验GRN
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckGrnMaterialPrepare(itemStr, grn, flage, grnStr);

            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message).css("color", "red");
                $("body").scrollTop(0);
                $("#GRN").focus();
                $("#GRN").select();
                return false;
            } else {

                var list = ajax.value[0];
                //                if (list.Flage == 0 && $("#chkR" + list.PartId).is(":checked")) {
                if (list.Flage == 0) {
                    if (FIFO !== "1") {//没有取消FIFO的权限
                        alert("请按照先进先出原则备料");
                        $("#GRN").focus();
                        $("#GRN").select();
                        return false;
                    } else {
                        var configType = "";
                        if (list.ConfigType == "createdate") {
                            configType = "生产日期";
                        } else if (list.ConfigType == "indate") {
                            configType = "入库日期";
                        }
                        var data = list.MinData;
                        var msg = "";
                        if (configType != "") {
                            msg = "该物料有更早[" + configType + "]为[" + data + "]的[" + list.MinGrn + "]在库[" + list.CBarCode + "]物料可用";
                            //$("#GRN").focus();
                            //$("#GRN").select()
                            //$("#msg").html(msg).css("color", "red");
                            //return false;
                        }
                        if (!confirm("您没有遵循先进先出原则，是否确认操作？\r\n" + msg)) {
                            $("#GRN").focus();
                            $("#GRN").select();
                            return false;
                        }
                    }
                }
                var ctrl = $("#td" + list.PartId);
                /*判断扫描数量总和不能大于申请数量*/
                var appCount = $.trim($("#qty" + list.PartId).text().replace("领料申请数量", "")); //申请数量
                var requestCount = $.trim($("#td" + list.PartId).text().replace("备料数量", "")); //已备料数量

                var IssueWay = list.IssueWay; //发料方式： 1.正常发料 2.最小包装发料
                if (IssueWay == "2") { //最小批次发货
                    //如果已备料数量>申请数量，不可以继续扫描发料
                    if (parseFloat(requestCount) >= parseFloat(appCount)) {
                        $("#msg").html("备料数量已经大于领料申请数量!").css("color", "red");
                        $("#GRN").focus();
                        $("#GRN").select();
                        return false;
                    }
                }
                
                //产线不允许超发，超发后还继续扫描物料，则报错
                if ($('#perparelist option:selected').val() == "2" && IssueWay == "1") {
                    if (parseFloat(parseFloat(requestCount)) >= parseFloat(appCount)) {
                        $("#msg").html("备料数量不能大于领料申请数量!").css("color", "red");
                        //$("#GRN").val("");
                        $("#GRN").focus();
                        $("#GRN").select();
                        return false;
                    }
                }
                //当前扫描条码加已备数量，超过申请数量，则启用分料截料，记录当前GRN
                if (parseFloat(parseFloat(requestCount) + list.BalanceQty) > parseFloat(appCount)) {
                    var FLQty = dcmSub(list.BalanceQty, dcmSub(parseFloat(appCount), parseFloat(requestCount)));
                    FLgrnStr += grn + ":" + FLQty + ",";
                }

                //                var ht = "<b class='ui-table-cell-label'>  备料数量  </b>" + (parseInt($.trim(ctrl.text().replace("备料数量", ""))) + list.BalanceQty);
                var ht = dcmAdd(parseFloat($.trim(ctrl.text().replace("备料数量", ""))), parseFloat(list.BalanceQty)); //(parseFloat($.trim(ctrl.text().replace("备料数量", ""))) + list.BalanceQty);
                ctrl.html(ht);

                ctrl.parent().parent().css("background-color", "#7FFF00");//高亮
                $("#preparetab").prepend(ctrl.parent().parent());

                $("#preparetab").table("refresh");
                requtestQty += list.BalanceQty;
                //添加到集合
                grnStr += grn + ',';
                var isExist = false;
                $.each(GrnArr, function (i, o) {
                    if (o.GRN == grn) {
                        isExist = true;
                        return false;
                    }
                });
                if (!isExist) GrnArr.push({
                    GRN: grn,
                    BalanceQty: list.BalanceQty,
                    partid: list.PartId
                });
                $("#msg").html("扫描完成!").css("color", "green");
                $("#GRN").val("");
                $("#GRN").focus();
                $("#GRN").select();
            }
        }
        //根据投料单获取物料信息
        function setPickingList(forNumber) {
            //清空数据
            //$("#listno").val('');
            //$("#orderlist").val('');
            //$("#iframeGrnList").attr("src", "");
            $("#iframeGrnList").css("display", "none");
            $("#preparetab tbody").html('');
            $("#GRNinfotab tbody").html('');
            $("#msg").html('');

            itemStr = ""; //存储领料单对应的ItemId
            grnStr = ""; //存储扫描的Grn
            GrnArr = [];
            FLgrnStr = ""; //存储扫描需要分料截料的Grn
            itemAllQty = 0; //领料单总申请数量
            requtestQty = 0;   //本次备料数量

            //var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyDtlLists($.trim(forNumber), n);
            requestOrder = requestOrder == 0 ? "0" : requestOrder;
            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetMaterialPrepareInfo($.trim(forNumber), requestOrder);

            if (ajax1.error != null) {
                $("#msg").html(ajax1.error.Message);
                $("#msg").css("color", "red");
                $("#listno").focus().select();
                return false;
            }
            //var ajax = jQuery.parseJSON(ajax1.value);
            var ajax = ajax1.value;
            //rowCount = ajax[0].rowCount;//获取总条数
            //ajax.shift();//删除总条数
            var list = ajax;
            var htmlstr = "<tr>";
            if (list == null || list.length == 0) {
                $("#preparetab tr:gt(0)").remove();
                $("#preparetab tbody").append('<tr class="ListTableOddRow"><td colspan="10" style="text-align: center;"><font color="red">暂无数据</font></td></tr>');
                $("#preparetab").table("refresh");
                return false;
            }
            for (var i = 0; i < list.length; i++) {
                requestId = list[0].ApplyId;
                itemStr += list[i].ItemId + ',';
                itemAllQty += list[i].ApplyQty; //领料单申请数量
                htmlstr += "<td>" + list[i].ItemCode + "(" + list[i].ItemName + ")" + "</td>";

                htmlstr += "<td><span id='td" + list[i].ItemId + "' stockqty=" + list[i].StockQty + ">" + list[i].StockQty+ "</span>/";
                htmlstr += "<span id='qty" + list[i].ItemId + "' applyqty="+ list[i].ApplyQty +">" + list[i].ApplyQty + "</span>";
                htmlstr += "   <span align='center'><a href='#' onclick ='SearchRule(this)'>记录</a><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></span>";
                htmlstr += "   <span align='center'><a href='#' onclick ='ClearItemGrn(" + list[i].ItemId + "," + list[i].StockQty + ")'>清除</a></span>";

                htmlstr += "</td>";

                //                        htmlstr += "<td id='qty" + list[i].ItemId + "'>" + list[i].ApplyQty + "</td>";
                //                        htmlstr += "<td  id='td" + list[i].ItemId + "'>" + list[i].StockQty + "</td>";
                // htmlstr += "<td align='center'><a href='#' onclick ='SearchRule(this)'>记录</a><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>";
                // htmlstr += "<td align='center'><a href='#' onclick ='SearchRule(this)'></a><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>";
                htmlstr += "</tr>";
            }
            $("#preparetab tr:gt(0)").remove();
            $("#preparetab tbody").append(htmlstr);
            $("#preparetab").table("refresh");
            $("#GRN").focus();
            return true;
        }

        var itemId = -1; //获取选中的ItemId
        //先进先出列表显示
        function SearchRule(obj) {
            $("#iframeGrnList").css("display", "");
            var $obj = $(obj);
            var isAsc = 0;
            if ($obj.is("input")) {
                //$obj = $obj.next();
                //isAsc = 1;
                return false;
            }
            itemId = $obj.next().val();
<%--            $("#iframeGrnList").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialPrepareView.aspx?ID=" + itemId + "");--%>
            var entity = {};
            entity.ItemId = itemId;
            //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetMaterialPrepareGRN", JSON.stringify(entity));
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialPrepareGRN("uspGetMaterialPrepareGRN", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);

            var List = en.data;
            var str = "";
            for (var i = 0; i < List.length; i++) {
                if (str.indexOf(List[i].cBarCode) == -1) {
                    str += List[i].cBarCode + ',';
                }
            }
            str = str.replace(/,$/g, "");
            $("#barcodes").html("").append("<tr><td>" + str.trimRight(',') + "</td></tr>").css("display", "");
        }
        function Save() {
            /*选择的是线别仓还是产线*/
            var selLocation = $('#perparelist option:selected').val();
            var locDesc = $("#selLocation").find("option:selected").text();
            if (requestOrder == 0) {
                confirmDialog("请选择领料单!");
                return false;
            }
            if (parseFloat(itemAllQty) == "0") {
                confirmDialog("申请数量为0,不能备料!");
                return false;
            }
           
            if (confirm('是否确定该领料单备料?')) {

                if (IsSeparateCutting == 2) {
                    var iscf = false;
                    var cfitem = "";
                    $("#preparetab tbody tr").each(function (i, e) {
                        if (!$(e).hasClass("ListTableHeader")) {
                            var applyqty = $.trim($(e).find("td:eq(1)").find("span").attr("applyqty"));
                            var stockqty = $.trim($(e).find("td:eq(1)").find("span").attr("stockqty"));
                            if (stockqty != "" && applyqty != "") {
                                if (parseFloat(stockqty) > parseFloat(applyqty)) {
                                    iscf = true;
                                    cfitem = $.trim($(e).find("td:eq(0)").text());
                                    return false;
                                }
                            }
                        }
                    });
                    var cfsend = false;
                    //modify by yz.xiong 只有备料到产线时，进行超发控制
                    if (iscf && selLocation == "2") {
                        if (confirm("当前料号【" + cfitem + "】数量已超发，是否确认超发备料?")) {
                            cfsend = true;
                        }
                        if (!cfsend)
                            return false;
                    }
                }
                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

                var materialStorageNo = ""; //备料单号
                var ajaxNo = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetMaterialStorageNo(-10);
                if (ajaxNo.error != null) {
                    confirmDialog(ajaxNo.error.Message);
                    return;
                } else {
                    if (ajaxNo.value == "") {
                        confirmDialog("备料单号获取失败");
                        return;
                    }
                    materialStorageNo = ajaxNo.value;
                }

                var entity = {};
                entity.RequestId = requestId;
                entity.userName = userName;
                entity.PrepareMaterialNo = materialStorageNo;
                entity.tbDtl = JSON.stringify(whList);

                //requestId:领料申请单ID,selLocation:线别仓还是产线,grnStr:GRN集合,entity 无GRN项 备料列表
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveMaterialPrepare(materialStorageNo, requestId, selLocation, grnStr, userName, JSON.stringify(entity));
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveMaterialPrepare(materialStorageNo, requestId, selLocation, locDesc, grnStr, userName, JSON.stringify(entity), FLgrnStr);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                else {
                    /*清空数据*/
                    if ($("#tblRecHistory tr").length > 1) {
                        $("#tblRecHistory tr:not(:first)").remove();
                    }
                    $("#msg").html("备料成功!");
                    $("#iframeGrnList").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialPrepareView.aspx?ID=-1");

                    $("#listno").val('');
                    $("#GRN").val('');
                    $("#preparetab tbody").html('');
                    $("#GRNinfotab tbody").html('');
                    $("#listno").val("");
                    //$("#woNo").html("");
                    //$("#iframeGrnList").attr("src", "");
                    $("#iframeGrnList").css("display", "none");
                    requestOrder = 0;
                    NewFLgrnStr = ajax.value;
                    if (NewFLgrnStr != "") {
                        //执行打印  有分料截料情况下执行打印
                        Print();
                    }
                    //打印完成清空分料截料数据
                    FLgrnStr = "";
                    NewFLgrnStr = "";
                }
            }
        }

        //根据字符串模糊查询采购单
        $("#listviews").on("filterablebeforefilter", function (e, data) {
            return false;
            var $ul = $(this)
            $input = $(data.input)
            value = $input.val()
            $("#listviews").html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetListStatue();
            if (ajax.error != null) {
                $("#showGrn").html(ajax.error.Message);
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            var entity = ajax.value;
            if (entity.error != null) {
                confirmDialogFocus(entity.error, function () {
                    $("#orderno").focus();
                });
            };
            var ulhtml = "";
            for (var i = 0; i < entity.length; i++) {
                if (ulhtml.indexOf(entity[i].ApplyNo) == -1) {
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].ApplyNo + "</a></li>";
                }
            }
            $("#listviews").append(ulhtml);
            $("#listviews").listview("refresh");
        });
        function SetPOCode(Code) {
            $("#msg").html("");
            requestOrder = $(Code).html();
            $("#listno").val(requestOrder);

            //切换领料单时清除GRN信息
            $("#GRN").val("");

            $("#iframeGrnList").css("display", "none");

            if (requestOrder == "") {
                $("#msg").html("领料单不能为空！").css("color", "red");
                $(this).val('').focus();
                return false;
            }
            $("#preparetab tbody").html('');
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetWorkOrderInfo(requestOrder);
            if (ajax.error != null) {
                //confirmDialogFocus(ajax.error.Message, function () {
                //    //$(this).val('').focus();
                //});
                $("#msg").html(ajax.error.Message).css("color", "red");
            }


            $("#workorderlist").html('');
            $("#worklist").html('');
            var result = ajax.value;
            if (result.length < 1) {
                $("#msg").html("领料单输入错误！").css("color", "red");
                return false;
            }
            if (result.length == 1) {
                $("#workorderlist").append("<option value='" + result[0].MOCode + "'>" + result[0].MOCode + "</option>");
                $("#workorderlist").prop("selected", "selected");
                setPickingList($("#workorderlist").find(":selected").val());
            }
            else {
                for (var i = 0; i < result.length; i++) {
                    $("#workorderlist").append("<option value='" + result[i].MOCode + "'>" + result[i].MOCode + "</option>");
                    $("#worklist").append("<li><a id='" + result[i].MOCode + "' onclick='bind(this)'>" + result[i].MOCode + "</a></li>");
                }
                $("#myPopup").popup('open');
            }
            $("#workorderlist").selectmenu('refresh', true);
            $("#worklist").listview('refresh');


            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#fpanel").panel("close");
            $("#GRN").focus();


        }
        function initLocSel() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetPrepareLoc();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var dataList = JSON.parse(ajax.value).data;
            var strHtml = '';
            for (var i = 0; i < dataList.length; i++) {
                strHtml += '<option value="' + dataList[i].RID + '">' + dataList[i].PrepareDesc + '</option>';
            }
            $("#perparelist").append(strHtml);

        }

        //清除单个GRN
        function ClearGrn(GRN, qty, partid) {
            //更新UI
            var ctrl = $("#td" + partid);
            var grnCount = ctrl.text();
            var newNumber = dcmSub(parseFloat(grnCount), parseFloat(qty));
            requtestQty = dcmSub(parseFloat(requtestQty), parseFloat(qty));
            ctrl.text(newNumber);
            //取消高亮
            if (newNumber == 0) {
                ctrl.parent().parent().css("background-color", "white");
            }
            //更新全局变量
            var grnStrArr = grnStr.split(',');
            grnStrArr = $.grep(grnStrArr, function (item, index) {
                return item != GRN;
            });
            grnStr = grnStrArr.join(',');
            //
            var index = -1;
            $.each(GrnArr, function (i, o) {
                if (GRN == o.GRN) {
                    index = i;
                    return false;
                }
            });
            if (index > -1) GrnArr.splice(index, 1);
        }
        //清除指定产品的下的GRN
        function ClearItemGrn(ItemId, StockQty) {

            var ctrl = $("#td" + ItemId);
            var grnCount = ctrl.text();
            if (grnCount == 0) {
                return false;
            }
            if (grnCount == StockQty) {
                confirmDialog("当前数据没有扫描GRN!");
                return false;
            }
            if (confirm("确认清除?")) {
                //更新UI
                ctrl.parent().parent().css("background-color", "white");
                ctrl.text(StockQty);
                //更新全局变量
                grnStr = '';
                for (var i = GrnArr.length - 1; i >= 0; i--) {
                    if (GrnArr[i].partid == ItemId) {
                        GrnArr.splice(i, 1);
                    }
                }
                for (var i = 0; i < GrnArr.length; i++) {
                    grnStr += GrnArr[i].GRN + ',';
                }
                requtestQty = 0;
                confirmDialog("清除完成!");
            }
        }

        function Print() {
            grn = NewFLgrnStr;
            if (grn == "" || grn == null || NewFLgrnStr.length == 0) {
                return;
            }
            var grnArray = grn.split(",");
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.ItemList = [];
            for (var i = 0; i < grnArray.length; i++) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grnArray[i]);

                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                if (ajax.value == null || ajax.value.SerialNumber == null) {
                    $("#msg").html("无效的GRN或者该GRN对应的Item不存在！").css("color", "red");
                    return false;
                }

                try {
                    labelItemId = ajax.value.PartId;
                    //是否供应商打印调用不同的模板
                    var IsSupper = ajax.value.IsSuplySerialNumber;
                    if (IsSupper) {
                        labelType = -24; //调用供应商模板
                    }
                    else {
                        labelType = -3;
                    }
                    //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                    getDocumentInfo();

                    //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                    SNInfo.SNList.push(grnArray[i]);
                    SNInfo.ItemList.push(ajax.value.PartId);
                }
                catch (e) {
                    $("#msg").html(e).css("color", "red");
                }

            }
            PrintLabContent();
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型 (-2：SN，-3：GRN)
        var labelSequence = 2;      //标签序号 (1产品，2GRN, 3单号......)
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        //根据打印方式决定 调用ZPL还是Lab打印
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                //获取打印机名称值
                printName = $("#PDAselPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
        }

        var printCount = 1;


        var labelJsonData = "";
        function PrintLabContent() {
            try {
                var printdata = [];
                printCount = 1;
                lableArr = SNInfo.SNList;
                labItemList = SNInfo.ItemList;

                labelJsonData = "[";
                for (var i = 0; i < lableArr.length; i++) {
                    var labelStr = lableArr[i];
                    var lablabItem = labItemList[i];
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, lablabItem, -1);

                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }
                    }
                }
                if (printdata.length == 0)
                    return;
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            } catch (e) {
                $("#msg").html(e).css("color", "red");
                return false;
            }
        }
    </script>
</body>
</html>
