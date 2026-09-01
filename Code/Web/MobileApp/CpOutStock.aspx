<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CpOutStock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.CpOutStock" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-9" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/jquery.mobile.datepicker.css">
    <link rel="stylesheet" href="css/jquery.mobile.datepicker.theme.css">
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <title>成品出库</title>
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
    <form runat="server" onsubmit="return false;">
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <%--  <div>
                        <img src="images/icon/cpck_white.png"/>
                        <img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7pmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjZUMjE6NDM6NDYrMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1NToyNSswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTU6MjUrMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6ZDY1ZTk2MjAtODY4YS1kNDRiLWI5OGUtN2FkMmM5MmExYTVmPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6NjExOWYwZGUtMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6MWU3NWEwNDMtNDhhMi0zNzQ0LThiZTgtNmQ1NzBhMjVlYjcxPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOjFlNzVhMDQzLTQ4YTItMzc0NC04YmU4LTZkNTcwYTI1ZWI3MTwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNlQyMTo0Mzo0NiswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTQgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDo1MmFkNmRlOS1jYjYxLTM1NDAtYWQ3YS02MjY0ZDQ3ZjcxOTU8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjZUMjI6MzQ6MjIrMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE0IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6ZDY1ZTk2MjAtODY4YS1kNDRiLWI5OGUtN2FkMmM5MmExYTVmPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU1OjI1KzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz7Da7HpAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAARESURBVHja5JvdVeMwEIVvKkBbwYYK1qkApwKSCjAVECogVLBJBTEVYCoAKsBUQFLBOhVkHxgvQquRJcuW7WTO4QGbONKn+bkjmdHhcMAp26hDABGAOwAFgDWA/JQA3ABYKdeuAaTHDkAA2ACYMfdTALfkFUcHIALwCGBc8Xc5eUN+TAB0Lm+ygjwhHToAk8u/A0gALAFcMp9fEYhBAjC5/BrAQvo9ocmeMSExB7AdEgDO5fc02YwBlgL4xYTENfO5XgGocvlZxUoKCombUCHRJACTyz+Qy9uWtxl5gy4kXigkij4BMLn8omY2H5PLcyExJxidArDJ8r71fEmSmbt33xWAJl2+ymLyBl1IZJQgi5AA2nB5G29LGc2wpZDI2wYQwuWrbAHgt+Heui0AIV3eZiwZgJ++DZUtgC5c3sYbVwCufBqqKgB9cPkq42S0VUNlAtAnl7cJCU5Gp+QNTgBM7eutY2sb0laMjGYbKhWAyeV3dD1Hv42T0dqGSgZQtWNzT8prCDYG8GHTUJUAElp5kw0JAACYsnsOYAqgKAF8oHqv7pgAlIk8KQFsFVHxTtcujwjAXskLrwDiEoDcbDxRSCyULkwHYMaUHhtbt1xGVQA/aI4XkHam1CoQSz32sgKAKdHY2BP484E2AIykZJ/bCKEqAILC5KxjAEIaiw0AayW4tAiBmH7qWNaApkioMxQaxSfntR2X5H0BdGmCQlAwsjeSxrvkYA8ZQAzg2VX7nwIAp7EeEwC1zlsdt/sCsNUB72j+VEcFMKES7gTBB4CrDpg03EmqAEaU+JwghNQBIQCAgTBpqwrY6oC8wRAYU32PlfGMDHAK6v7yoSVBQdq9BB2ZwlkjkjZVEPoKIMbnbm/i8JkRoxSNEPoGIKbv1IXVK8V2ThN5cZDLG91mSJ8ACNL0iWbSKeUPn9aZhdBEErzwrPcRDS5SJr5ouGqoEDIAc98yqDYjruUuomwtJDWXtCCaOAjnbegAWwDq5EOdNOWSep00rQNs672gyUfS5GO0f9Ike8AOwLirJPgo7QbtafJtr7wqjqYAXroAMCMApc1bjHku3P71B10AkM8gHizEzoWkAgWjEaYGXcBOvgsAcgzuCUTRgBLkAKiTV99QDQ5AXn3d867o2tjwjB1VHyFlcx0ANdFqvS0kADX2z/G1la0TQ6WXZPjaQd4ySU0FYDX50ABSfL3OIp8J3Gme+4rPU9zMMqvLAJxKbEgAf5RElGn0/46+I3UsazKAZylRVuqLUAB0+3eqy7u+dqMDsJGAmpJscADys3YA3vD9WKzOP0ypAK6UyVuJq1AAMujf8PRpfmQAueRNTsoyFIA3ZjtrivpvfKthVcubQgE4+A6UETlvvs8MAUBQBZDtP0XWQGtbC2gIAOpKNdn6lr3Btm43aQKwwPe3sn0ONvIK2dqZmQAIWvGIBuzbB8x8VqoLACdhfwcA3e9V7wkubLoAAAAASUVORK5CYII=" />
                    </div>
                    <div>
                        成品出库
                    </div>--%>

                    <div>
                        <label id="lbltitle" style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">成品出库</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar" data-theme="c">
                        <ul>
                            <li><a href="#pageTwo" data-transition="none" class="ui-btn-active" data-theme="c" onclick="getMaterialList()">成品出库</a></li>
                            <li><a href="#AddMaterial" data-transition="none"  onclick="MaterialUnPack()" data-theme="c">物料拆箱</a></li>
                           
                        </ul>
              </div>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label for="DNNo">备货单号</label>
                        </td>
                        <td>
                            <input id="DNNo" />
                        </td>
                        <td>
                            <a href="#mypanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择单据</a>
                            <%--<a href="#mypanel" data-rel="popup" class="ui-btn" data-position-to="window" data-role="button">查询</a>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">客户名</label>
                        </td>
                        <td colspan="2">
                            <label id="cusname"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">出货地</label>
                        </td>
                        <td colspan="2">
                            <label id="address"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">状态</label>
                        </td>
                        <td colspan="2">
                            <label id="status"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="#scantypepopup" data-rel="popup" data-position-to="window" id="scantype">GRN</a>
                        </td>
                        <td colspan="2">
                            <input id="Number" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Print">
                                打印机</label>
                        </td>
                        <td>
                            <select id="PDAselPrintersList" data-mini="true" class="perparelist">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>打印原GRN</label></td>
                        <td>
                            <input id="PrintOld" type="checkbox" value="PrintOld" /></td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center; margin-top: 3px">
                </div>
                <div>
                    <table id="DNInfotab" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%">
                        <thead>
                            <tr>
                                <th>项次
                                </th>
                                <th>物料编码
                                </th>
                                <%--<th>物料名称
                                </th>--%>
                                <th>客户料号
                                </th>
                                <th>仓库
                                </th>
                                <th>出货数量
                                </th>
                                <th>操作
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

                <div data-role="popup" id="popupGrnLog">
                    <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">关闭</a>
                    <table data-role="table" id="Table1" data-mode="columntoggle" class="ui-responsive table-stroke">
                        <thead style="background-color: #2FC1FF">
                            <tr>
                                <th>序号
                                </th>
                                <th>序列号
                                </th>
                                <th style="min-width: 40px">数量
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="ListTableOddRow">
                                <td colspan="10" style="text-align: center;">暂无数据</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div data-role="popup" id="popupGrnWhcode">
                    <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">关闭</a>
                    <table data-role="table" id="GrnChwcode" data-mode="columntoggle" class="ui-responsive table-stroke">
                        <thead style="background-color: #2FC1FF">
                            <tr>
                                <th>GRN
                                </th>
                                <th>入库日期
                                </th>
                                <th>货位
                                </th>
                                <th>数量
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="ListTableOddRow">
                                <td colspan="4" style="text-align: center;">暂无数据</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a data-corners="false" id="Save" data-role="button" data-fullscreen="true" data-theme="a">确认出库</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="mypanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-theme="c" data-filter="true" data-filter-reveal="true" data-filter-placeholder="输入备货单号。。。" data-inset="true">
                    </ul>
                </div>
            </div>
            <div data-role="popup" id="scantypepopup" style="min-width: 220px">
                <ul data-role="listview">
                    <li><a onclick="Scantype(-1)">GRN</a></li>
                    <%-- <li><a onclick="Scantype(0)">SN</a></li>--%>
                    <%--<li><a onclick="Scantype(3)">客户SN</a></li>--%>
                    <li><a onclick="Scantype(1)">卡通箱</a></li>
                    <%--<li><a onclick="Scantype(2)">栈板</a></li>--%>
                </ul>
            </div>
        </div>
    </form>
    <script src="js/datepicker.js"></script>
    <%--<script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>--%>
    <script type="text/javascript">
        var ScanType = -1;//扫描类型 ，默认是栈板
        var Numberarr = [];//记录数量
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var SalOrderId = "";
        var UnPack = 0; //是否解包装
        $(document).ready(function () {

            bindPrinters('PDAselPrintersList', function () {
                if ($("#PDAselPrintersList").val()) {
                    $("#PDAselPrintersList-button span").text($("#PDAselPrintersList").find("option:selected").text());
                }
            });

            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $(".ui-body-c").css("background", "#fff");
            $("body>[data-role='listview']").listview();
            $("#DNNo").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
            $("#Number").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });
            //DN查询
            $("#DNNo").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Numberarr = [];
                    PDAGetSalOrderList($("#DNNo").val());
                    $("#Number").focus();
                }
            });
            //条码扫描事件
            $("#Number").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Scan();
                    $("#Number").focus();
                }
            });

            //筛选
            $("#btnFilter").on("click", function () {
                $("#listviews").html("");
                var $ul = $(this),
                    value = $.trim($("input[data-type='search']:eq(0)").val());

                $("#listviews").html("");
                var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.PDAGetSalOrderList(value);
                if (data.error != null) {
                    $("#msg").html(data.error.Message).css("color", "red");
                    return false;
                }
                var ulhtml = "";
                entity = data.value;
                for (var i = 0; i < entity.length; i++) {
                    if (ulhtml.indexOf(entity[i].DNCode) == -1) {
                        ulhtml += "<li><a id='" + entity[i].SalOrderID + "' onclick='CheckDNlist(this)'>" + entity[i].DNCode + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            });

            $("#Save").on("click", function () { Save(); });
        });


        function MaterialUnPack() {
            location.href="MaterialUnPack.aspx?name=PDA_MaterialUnPack";
        }

        //根据字符串模糊查询采购单
        $("#listviews").on("filterablebeforefilter", function (e, data) {
            //var $ul = $(this)
            //$input = $(data.input)
            //value = $input.val();

            //if (value && value.length > 2) {

            //    //$("#listviews").trigger("updatelayout");
            //}
        });
        /*扫描条码*/
        var Scan = function () {
            $("#msg").html('');
            if ($("#DNNo").val() == '' || $("#DNNo").val() == null) {
                confirmDialog('请选择备货单！');
                return false;
            }

            if ($("#status").html() == '备货完成') {
                $("#msg").html('当前单号备货已完成，请勿重复操作!').css('color', '#ff0000');
                return false;
            }

            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.ScanSave($("#DNNo").val(), $("#Number").val(), ScanType, userName);
            //if (ajax.error != null) {
            //    confirmDialog(ajax.error.Message);
            //    return false;
            //}

            var sn = $.trim($("#Number").val());
            if (sn == "") {
                showMsg("请扫描条码", 0);
                $("#Number").val("").focus();
                return false;
            }

            ////包装判断
            //if (ScanType == -1) {
            //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IsPack(sn);
            //    if (ajax.value != "" && ajax.value != null) {
            //        if (window.confirm("该物料【" + grn + "】已存在包装【" + ajax.value + "】，是否解除包装!")) {
            //            UnPack = 1;
            //        }
            //    }
            //}

            var entity =
            {
                DNCode: $.trim($("#DNNo").val()),
                SerialNumber: sn,
                ScanType: ScanType,
                UnPack: 0,
                ModifyBy: userName,
            };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFinishProductOutStorageScan", JSON.stringify(entity));
            if (ajax.error != null) {
                if (ajax.error.Message.indexOf("2#") > -1) {

                    var index = ajax.error.Message.lastIndexOf("?");
                    var txtQty = ajax.error.Message.slice(index + 1);

                    confirmDialog(ajax.error.Message, function () {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SplitMaterial(txtQty, sn);
                        if (ajax.error != null) {
                            confirmDialog(ajax.error.Message);
                            return false;
                        }
                        var list = ajax.value;
                        confirmDialog("<%=Resources.Messages.SplitMaterialSuccessed %>");

                        if ($("#PrintOld").prop('checked')) {
                            Print(list[0].DetailContent);
                        }

                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFinishProductOutStorageScan", JSON.stringify(entity));
                        if (ajax.error != null) {
                            showMsg(ajax.error.Message, 0);
                            $("#Number").val("").focus();
                            return false;
                        }

                        PDAGetSalOrderList($("#DNNo").val());
                        $("#Number").val("").focus();
                    });
                } else {
                    showMsg(ajax.error.Message, 0);
                    $("#Number").val("").focus();
                    return false;
                }
            }

            //刷新备货单物料详情信息
            PDAGetSalOrderList($("#DNNo").val());
            $("#msg").html('扫描成功').css('color', '#2ecc71');
            $("#Number").val("").focus();
        };


        function Save() {
            //检测是否备货完成(备货完成确认)
            var flag = true;
            //$("#DNInfotab tbody tr").each(function (i, j) {
            //    var planqty = $(j).find("span:eq(1)").html();
            //    var qty = $(j).find("span:eq(0)").html();
            //    if (planqty != qty) {
            //        flag = false;
            //    }
            //});

            if (flag && $("#status").html() == '备货中') {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.OutStockConfirmation(SalOrderId, userName);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                confirmDialogFocus('备货完成！', function () { window.location.reload(); });
            }
            else if (flag && $("#status").html() == '备货完成') {
                $("#msg").html('当前单号备货已完成，请勿重复操作!').css('color', '#ff0000');
                return false;
            }
            else {
                $("#msg").html('出货数量与计划数量不一致，请继续扫描').css('color', '#ff0000');
                return false;
            }
        }


        //弹出面板选择备货单
        function CheckDNlist(data) {
            $("#DNNo").val($(data).html());
            var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderList($(data).attr("id"));
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }

            $("#cusname").text(data.value[0].CusName);
            $("#address").text(data.value[0].Address);
            var Status = "";
            switch (data.value[0].Status) {
                case 1:
                    Status = '备货中';
                    break
                case 2:
                    Status = '备货完成';
                    break
                case 3:
                    Status = '已检验';
                    break
                case 4:
                    Status = '已出货';
                    break
            }
            $("#status").text(Status);
            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#mypanel").panel("close");
            Numberarr = [];
            debugger
            PDAGetSalOrderList($("#DNNo").val());
            $("#Number").focus();
        }
        //获取销售订单
        var PDAGetSalOrderList = function (code) {
            var data1 = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.PDAGetSalOrderList(code);
            if (data1.error != null) {
                $("#msg").html(data1.error.Message).css("color", "red");
                return false;
            }

            $("#msg").html('');

            if (data1.value.length <= 0) { return false; }
            SalOrderId = data1.value[0].SalOrderID;
            var Status = "";
            switch (data1.value[0].Status) {
                case 1:
                    Status = '备货中';
                    break
                case 2:
                    Status = '备货完成';
                    break
                case 3:
                    Status = '已检验';
                    break
                case 4:
                    Status = '已出货';
                    break
            }
            $("#status").text(Status);
            $("#cusname").text(data1.value[0].CusName);
            $("#address").text(data1.value[0].Address);
            var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderDtlList(data1.value[0].SalOrderID);
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            var m = data.value;
            $("#DNInfotab tbody").html('');
            var htmlstr = "";
            var falg = false;
            if (Numberarr.length < 1) {
                falg = true;
            }
            for (var i = 0; i < m.length; i++) {
                if (falg) {
                    Numberarr.push(m[i].CurrentQty);
                }

                //扫描类型是GRN
                if (ScanType == -1) {
                    if (Numberarr[i] != m[i].CurrentQty) {
                        htmlstr += "<tr style='background-color:#7FFF00'><td>" + m[i].SalOrderDtlID + "</td><td Whdata='" + m[i].WhCode + "'><a href='#popupGrnWhcode' data-rel='popup' data-position-to='window' onclick=\"showGrnDetail(this,'" + m[i].ItemCode + "','" + m[i].WhCode + "')\"'>" + m[i].ItemCode + "</a></td><td>" + m[i].CPN + "</td><td>" + m[i].CWhName + "</td><td><span>" + m[i].CurrentQty + "</span>/<span>" + m[i].PlanQty + "</span></td><td><a href='#popupGrnLog' data-rel='popup' data-position-to='window' onclick='showDetail(this," + m[i].SalOrderDtlID + ")'>记录</a></td></tr>";
                        Numberarr[i] = m[i].CurrentQty;
                    } else {
                        htmlstr += "<tr><td>" + m[i].SalOrderDtlID + "</td><td Whdata='" + m[i].WhCode + "'><a href='#popupGrnWhcode' data-rel='popup' data-position-to='window' onclick=\"showGrnDetail(this,'" + m[i].ItemCode + "','" + m[i].WhCode + "')\"'>" + m[i].ItemCode + "</a></td><td>" + m[i].CPN + "</td><td>" + m[i].CWhName + "</td><td><span>" + m[i].CurrentQty + "</span>/<span>" + m[i].PlanQty + "</span></td><td><a href='#popupGrnLog' data-rel='popup' data-position-to='window' onclick='showDetail(this," + m[i].SalOrderDtlID + ")'>记录</a></td></tr>"
                    }
                } else {
                    if (Numberarr[i] != m[i].CurrentQty) {
                        htmlstr += "<tr style='background-color:#7FFF00'><td Whdata='" + m[i].WhCode + "'>" + m[i].ItemCode + "</a></td><td>" + m[i].CPN + "</td><td>" + m[i].CWhName + "</td><td><span>" + m[i].CurrentQty + "</span>/<span>" + m[i].PlanQty + "</span></td><td><a href='#popupGrnLog' data-rel='popup' data-position-to='window' onclick='showDetail(this," + m[i].SalOrderDtlID + ")'>记录</a></td></tr>";
                        Numberarr[i] = m[i].CurrentQty;
                    } else {
                        htmlstr += "<tr><td>" + m[i].SalOrderDtlID + "</td><td Whdata='" + m[i].WhCode + "'>" + m[i].ItemCode + "</td><td>" + m[i].CPN + "</td><td>" + m[i].CWhName + "</td><td><span>" + m[i].CurrentQty + "</span>/<span>" + m[i].PlanQty + "</span></td><td><a href='#popupGrnLog' data-rel='popup' data-position-to='window' onclick='showDetail(this," + m[i].SalOrderDtlID + ")'>记录</a></td></tr>"
                    }
                }

            }
            $("#DNInfotab tbody").append(htmlstr);
            $("#DNInfotab").table("refresh");
        }
        //扫描类型选择事件
        var Scantype = function (code) {
            switch (code) {
                case -1:
                    ScanType = -1;
                    $("#scantype").html('扫描GRN');

                    /*加点击事件*/
                    $("#DNInfotab tbody tr").each(function (i, e) {
                        var ItemCodeStr = $($(e).find("td").eq(1)[0]).html();
                        var Whdata = $($(e).find("td").eq(1)[0])[0].getAttribute("Whdata");
                        $($(e).find("td").eq(1)[0]).html("").html("<a href='#popupGrnWhcode' data-rel='popup' data-position-to='window' onclick=\"showGrnDetail(this,'" + ItemCodeStr + "','" + Whdata + "')\"'>" + ItemCodeStr + "</a>");
                    })

                    break;
                case 0:
                    ScanType = 0;
                    $("#scantype").html('扫描SN');
                    break;
                case 1:
                    ScanType = 1;
                    $("#scantype").html('扫描卡通箱');

                    /*移除点击事件*/
                    $("#DNInfotab tbody tr").each(function (i, e) {
                        var ItemCodeStr = $($(e).find("td").eq(1)[0]).find('a').html();
                        $($(e).find("td").eq(1)[0]).html("").html(ItemCodeStr);
                    })

                    break;
                case 2:
                    ScanType = 2;
                    $("#scantype").html('扫描栈板');
                    break;
                case 3:
                    ScanType = 3;
                    $("#scantype").html('扫描客户SN');
                    break;
            }
            $("#scantypepopup").popup("close");
            setTimeout('$("#Number").val("").focus()', 100);
        };


        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }


        function showGrnDetail(objDom, itemcode, whcode) {
            var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetProductGRNMemberList(itemcode, whcode);
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            var m = data.value;
            var htmlstr = "";
            htmlstr += '<tr class="ListTableOddRow"><td colspan="4" style="text-align: center;">当前选中物料编码：<span style="color:#00f">' + itemcode + '</span></td></tr>';
            if (m.length == 0) {
                htmlstr += '<tr class="ListTableOddRow"><td colspan="4" style="text-align: center;">暂无数据</td></tr>';
            }
            else {
                for (var i = 0; i < m.length; i++) {
                    htmlstr += "<tr>";
                    htmlstr += "<td>" + m[i].GRN + "</td>";
                    htmlstr += "<td>" + m[i].ProudctData + "</td>";
                    htmlstr += "<td>" + m[i].CBarCode + "</td>";
                    htmlstr += "<td>" + m[i].Qty + "</td>";
                    htmlstr += "</tr>";
                }
            }
            $("#GrnChwcode tbody").html("");
            $("#GrnChwcode tbody").append(htmlstr);
        }


        function showDetail(objDom, salOrderDtlID) {
            var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderDtlMemberList(salOrderDtlID);
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            var m = data.value;
            var htmlstr = "";
            if (m.length == 0) {
                htmlstr += '<tr class="ListTableOddRow"><td colspan="10" style="text-align: center;">暂无数据</td></tr>';
            }
            else {
                for (var i = 0; i < m.length; i++) {
                    htmlstr += "<tr>";
                    htmlstr += "<td>" + (i + 1) + "</td>";
                    htmlstr += "<td>" + m[i].Number + "</td>";
                    htmlstr += "<td>" + m[i].Qty + "</td>";
                    htmlstr += "</tr>";
                }
            }
            $("#Table1 tbody").html("");
            $("#Table1 tbody").append(htmlstr);
        }



        function Print(NewFLgrnStr) {
            var grn = NewFLgrnStr;
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
                    //如果工单号不为空则调用批次产品条码
                    if (ajax.value.SupplierOrderNumber != "" || labelType == -36) {
                        labelType = -36
                    }
                    else if (IsSupper) {
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

            //if (!$("#PrintOld").prop('checked')) {
            //    var grnTemp = $("#GRN").val();
            //    var grnIndex = $.inArray(grnTemp, SNInfo.SNList);
            //    if (grnIndex != -1) {
            //        SNInfo.SNList.splice(grnIndex, 1);
            //    }
            //}

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

                labelJsonData = "["; PrintOld
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
                debugger
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            } catch (e) {
                $("#msg").html(e).css("color", "red");
                return false;
            }
        }


    </script>
</body>
</html>
