<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WarehouseCheckEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.WarehouseCheckEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>仓库平账</title>
    <style type="text/css">
        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }
        html .ui-body-c, html .ui-page-theme-c .ui-body-inherit, html .ui-bar-c .ui-body-inherit, html .ui-body-c .ui-body-inherit, html body .ui-group-theme-c .ui-body-inherit, html .ui-panel-page-container-c{
            background:none !important;
        }
        .ui-title {
            line-height: 30px;
        }
        /*.changeQty{
           background:none;  
	outline:none;  
	border:none;
        }
        .changeQty:focus{   
	border:none;
}*/
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <%--修改面板--%>
        <div data-role="page" data-url="editpage" class="editpage" id="editpage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <%--            <div>
                        <img src="images/icon/pdxg_white.png"/>
                        <img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7pmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjZUMjE6NTc6MDQrMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1Njo0NyswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTY6NDcrMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6Mzg1NmYwMDQtZThhNS0xNjRmLWFkMTAtNzcwYWU1N2QzYWFhPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6OTg0ZjcwODktMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6MjNjNjg4NjktMTA3Yi1jODQxLWExZjMtYTRhM2QyZTllNTdhPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOjIzYzY4ODY5LTEwN2ItYzg0MS1hMWYzLWE0YTNkMmU5ZTU3YTwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNlQyMTo1NzowNCswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTQgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDo3OWQ2NjIwYS04ZjZjLWJlNDItYTc1Yi1lMDhkMjEzZTVhNjE8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjZUMjI6MjM6MjErMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE0IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6Mzg1NmYwMDQtZThhNS0xNjRmLWFkMTAtNzcwYWU1N2QzYWFhPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU2OjQ3KzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz7qM9fPAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAALJSURBVHja7JvvedowEIffTBBvUDNBnQniTJBuEDJB0wlKJyiZoGaCkgmaTBAyQckENRPQL+enrtDJMlBHLnfPwwesA1uv/v3uLJ1tt1tO2c4MgAEwAAagw26AKVCOpE4roAIWQH0IgBz4DhQjbdwauBIgvQFkwLNAGLN1QtAAVNL1NXuJ6V4D2mWg7FEgRAPIgF8e3w0wl0+dYGtPgRnwzlN2ofUCH4AS+OGpfNk1nhKwTFr8vXP9i8CJAnAHfHWuXckfj8FyaajzfQHMgM/OeB/bSjAHPh4LQPvHhawOKc72F8Bavn+QJfzoANyylOyTtLxvHjsJAO3nNACnCGCQIZC3JpqU7Z8BGIsZAANgAIYDUADXre9r4CEQMe7jfymBTqP6Hjom48EAaMviSgKoOiLQaio18fi7klaTvm8GYK3E31oE+RhIXtxKIqZtS6e3EPlcgwEIZVT7AvDdp6+/ATAAAwMIjdGJZ5Kq0JOtvrxdKPbwzRmDA8jkITJPRmap+M/ZTbdXSmUyuXfh6RkzE0IGIB0leO5cewr45x7tEHrR0td/UACaslvJpEakstOUo1sRU4KmAwyAARiNEvQpu77+c/5+xZWcEiykrF2pV7lWBZSj618p92j8y9ZS+yog70wIGYC3B5CJb+GIlHv8+wkyGdOl479QgqdGbF17gqdFCgC0SU1Tan3DYU1paqvM4ABqTxyw7zLYfrdnOsAAjATAMYeAT9gkD0BTahuJ4+vIHN9GVhJ30pwC35R7TwLhsBt2HwRAi+3bD+nL8a2P5F+yu1E75O9rmJPbJ/gzdrjE7hStidh5nYBl8uzFIQAy/HuFa+la96S5V/hGKplHiiwVQJdia1Jh64RavQiUPxE47BE6L7BCz/eNxTo3eXedGFmyu/P6v6l8F4D2sjUlfCghJXvhz6u2zrnKTo0ZAANgAAzAKdvvAQBlW0Cfsk2ExwAAAABJRU5ErkJggg==" />
                    </div>
                    <div>
                        盘点调整
                    </div>--%>
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">仓库平账</label>
                    </div>
                </h5>
                <a href="" data-rel="back" class="ui-btn-left" data-icon="back" data-transition="none"
                    data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right" data-icon="home"
                        data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%" id="Table1">
                       <tr>
                        <td>
                            <label for="orders">
                                盘点处理方式	:</label>
                        </td>
                        <td>
                            <select name="select-custom-20" data-mini="true" id="ddlChangeHandle" class="orders">
                                <option value="1">盘亏，数量为0处理</option>
                                <option value="2">正常，盘点后数量为系统数量处理</option>
                            </select>
                        </td>
                    </tr>
                   <%-- <tr>
                        <td>
                            <label for="warehouse">
                                仓库:<span id="ckmc"></span></label>
                            <input type="hidden" id="ckid" />
                        </td>
                        <td>
                         

                            <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" style="margin-top: 22px" onclick="selectOrder()">选择仓库</a>
                        </td>
                    </tr>--%>

                    <tr>
                        <td>
                            <label for="orders">
                                盘点单:</label>
                        </td>
                        <td>
                            <select name="select-custom-20" data-mini="true" id="orders" class="orders">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                 
               <%--     <tr>
                        <td>
                            <label for="txtGRN">
                                GRN:</label>
                        </td>
                        <td>
                            <input class="txtGRN" id="txtGRN" type="text" data-mini="true"
                                value="" data-theme="e" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtQty">
                                实际数量:</label>
                        </td>
                        <td>
                            <input class="txtQty" id="txtQty" type="text" data-mini="true"
                                value="" data-theme="e" />
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <label for="txtRemark">
                                备注:</label></td>
                        <td>
                            <input type="text" id="txtRemark" class="TextBox" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center; font-size: 14px"></div>
                <table id="infotab" data-role='table' data-mode='columntoggle' class='ui-responsive table-stroke' style='width: 100%'>
                    <thead>
                        <tr>
                            <th>GRN</th>
                            <th>系统数量</th>
                            <th>盘点数量</th>
                            <th>盈亏</th>
                            <th>复盘数量</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" onclick="SavePlus()" data-theme="f" value="确认平账" /></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选仓库</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
            <%--            <div data-role="footer" data-position="fixed" data-theme="d">
                <div data-role="navbar">
                    <ul>
                        <li><a onclick="SavePlus()" data-role="button" data-theme="none">确认</a></li>
                    </ul>
                </div>
                </div>--%>
        </div>
    </form>
    <script type="text/javascript">
        var CheckListNo;//盘点单
        var handleStyle = 1;//盘点处理方式 1:盘亏  2正常
        var OrderDetailList = []; //盘点单明细
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $(function () {
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");

            $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
            $("#txtQty").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });
            $("#txtRemark").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });
            //仓库下拉
           /* $.ajax({
                type: "POST",
                url: "../Handler/WarehouseCheck.ashx?api=GetWarehouseInfo",
                async: false,
                dataType: "json",
                success: function (data) {
                    $.each(data, function (a, b) {
                        $("#warehouse").append("<option value='" + b.CWhCode + "'>" + b.CWhName + "</option>");
                    });
                },
                error: function (err) {
                    return;
                }
            });
            $("#warehouse").select("refresh");*/
            Orderselect();
            CheckListNo = "";
            $("#ddlChangeHandle").change(function () {
                handleStyle = $("#ddlChangeHandle").find(":selected").val();
                if (CheckListNo != "") {
                    CheckDifferenceList(CheckListNo);
                }
            });
        });
        //盘点单change事件
        $("#orders").on("change", function () {
            showMsg("", 1);
            CheckListNo = $("#orders option:selected").html();
            CheckDifferenceList(CheckListNo);
        });
        //仓库 盘点单联动
        // $("#warehouse").on('change', function () { Orderselect(); })

        //盘点单下拉
        function Orderselect() {
            showMsg("", 1);
            $("#orders").html(' <option></option>');
            $.ajax({
                type: "POST",
                url: "../Handler/WarehouseCheck.ashx?api=GetWarehouseCheckListInfo",
                async: false,
                dataType: "json",
                data: { "warehouseid": 0, "flag": 3 },
                success: function (data) {
                    $.each(data, function (a, b) {
                        ProdWarehouseCheckId = b.ProdWarehouseCheckId;
                        var iddd = b.CheckType + "_" + b.StatusDesc + "_" + b.BeginDate + "_" + b.Remark;
                        $("#orders").append("<option value='" + b.CheckType + "_" + b.StatusDesc + "_" + b.BeginDate + "_" + b.Remark + "'>" + b.CheckOrder + "</option>");
                    });
                },
                error: function (err) {
                    return;
                }
            });
            $("#orders").selectmenu('refresh', true);
            $(".type").val('');
            $(".status").val('');
            $(".datetime").val('');
            $(".remark").val('');
        };
        //货架扫描绑定事件
        $("#hjcode").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                //验证库位
                $.post("../Handler/InStock.ashx?api=GetBarCode", { "station": $.trim($("#hjcode").val()) }, function (ajax) {
                    if (ajax.error != null) {
                        confirmDialogFocus(ajax.error.Message, function () {
                            $('#jhcode').val('').focus();
                        });
                        return false;
                    }
                    var en = $.parseJSON(ajax);
                    if (!en.BarCode) {
                        confirmDialogFocus("库位条码不存在!", function () {
                            $('#hjcode').val('').focus();
                        });
                        return false;
                    }
                    else {
                        $("#msg").html("库位扫描成功").css("color", "#2ecc71");
                        $("#grn").focus();
                        return true;
                    }
                });
            }
        });

        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                showMsg("", 1);
                var grn = $.trim($("#txtGRN").val());
                if (grn == "") {
                    showMsg("请扫描GRN", 0);
                    return false;
                }
                var exists = false;
                var qty = "";
                $("#infotab tbody tr td.grn").each(function () {
                    if ($(this).attr("grn").toLocaleLowerCase() == grn.toLocaleLowerCase()) {
                        exists = true;
                        qty = $(this).siblings(".NowQty").text()
                        return false;
                    }
                })
                if (!exists) {
                    showMsg("GRN不存在此盘点单中", 0);
                } else
                {
                    console.log(111);

                    $("#infotab tbody tr td.grn").each(function () {
                        if ($(this).attr("grn").toLocaleLowerCase() == grn.toLocaleLowerCase()) {
                          
                            $(this).siblings(".changeQtys").children(".changeQty").val(qty);
                       
                        }
                    })
                    $("#txtQty").val(qty).focus();
                }
            }
        });
        $("#txtQty").blur(function () {
            showMsg("", 1);
            if ($("#txtGRN").val() == '') {
                showMsg("请先扫描GRN", 1);
                $("#txtGRN").focus();
                return false;
            }
            var qty = $.trim($(this).val());
            if (!isGreaterThanOrEqualZero(qty)) {
                showMsg("数量[" + qty + "]格式不正确", 0);
                $(this).val("").focus();
                return false;
            };

            $("#infotab tbody tr td.grn").each(function () {
                if ($(this).attr("grn").toLocaleLowerCase() == $.trim($("#txtGRN").val()).toLocaleLowerCase()) {

                    $(this).siblings(".changeQtys").children(".changeQty").val(qty);

                }
            })

            $("#txtRemark").focus();

        });
        $("#txtQty").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                showMsg("", 1);
                if ($("#txtGRN").val() == '') {
                    showMsg("请先扫描GRN", 1);
                    $("#txtGRN").focus();
                    return false;
                }
                var qty = $.trim($(this).val());
                if (!isGreaterThanOrEqualZero(qty)) {
                    showMsg("数量[" + qty + "]格式不正确", 0);
                    $(this).val("").focus();
                    return false;
                };
                
                $("#infotab tbody tr td.grn").each(function () {
                    if ($(this).attr("grn").toLocaleLowerCase() == $.trim($("#txtGRN").val()).toLocaleLowerCase()) {

                        $(this).siblings(".changeQtys").children(".changeQty").val(qty);

                    }
                })

                $("#txtRemark").focus();
                //SavePlus();
            }
        });
   
        function SavePlus() {
            if (confirm("是否完成平帐?")) {

                showMsg("", 1);
                if (CheckListNo == '' || typeof (CheckListNo) == 'undefined') {
                    confirmDialog("请选择盘点单");
                    return false;
                }
               /* if ($("#txtGRN").val() == '') {
                    confirmDialog("请扫描GRN");
                    return false;
                    $("#txtGRN").focus();
                }
                if ($("#txtQty").val() == '') {
                    confirmDialog("请输入数量");
                    return false;
                    $("#txtQty").focus();
                }*/
                var grn = $("#txtGRN").val();

                
               /* $("#infotab tbody tr td.ProfitAndLoss").each(function () {
                    if($(this).text()!=0)
                    {
                        handleStyle = 1;//盘亏
                    }

                });*/
                $("#infotab tbody tr td.grn").each(function () {

                    //获取盘点单明细信息
                    OrderDetailList.push({ "GRN": $(this).attr("grn"), "NowQty": $(this).siblings(".changeQtys").children(".changeQty").val() });

                });
               
                var entity = {};
                entity.CheckOrder = CheckListNo;
                entity.UpdateBy = userName + "||" + handleStyle; //平帐时 通过更新人截取
                entity.Flag = 2; //平帐
                entity.Remark = $("#txtRemark").val();
                entity.TbDtl = JSON.stringify(OrderDetailList);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.SaveCheckOrder(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                confirmDialogFocus("平帐完成", function () {
                   // $("#txtGRN").focus();
                    //平账后刷新盘点单列表
                    Orderselect();

                    $("#infotab tbody").empty();
                });
              
                // OrderDetailList = [];
                /*
                var flag = true;
                for (var i = 0; i < $("#infotab tbody tr").length; i++) {
                    if (grn == $($("#infotab tbody tr")[i]).find("td:eq(0)").html()) {
                        flag = false;
                    }
                }
                if (flag) {
                    confirmDialog("GRN错误或不在差异清单中");
                    return;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Edit(CheckListNo, $("#txtGRN").val(), $("#txtQty").val(), $("#txtRemark").val(), userName);
                if (ajax.error = null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                $("#txtGRN").val('');
                $("#txtQty").val('');
                $("#txtRemark").val('');*/
               
                //CheckDifferenceList(CheckListNo);
             
            }

        }
        function CheckDifferenceList(CheckListNo) {
            console.log(CheckListNo);
            if (CheckListNo == "")
            {
                showMsg("请选择盘点单",0);
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.CheckDifferenceList(CheckListNo);
            if (ajax.error != null) {
                confirmDialog(ajax.error.Message);
            }
            var htmlstr = "<table width='100% ' class='ContentTabl'><thead><tr class='ListTableHeader'><th>GRN</th><th>系统数量</th><th>盘点数量</th><th>复盘数量</th></th><th>盈亏</th><th>平帐数量</th>"
                              + "</tr></thead>";
            var list = ajax.value;


            //排序
            list = list.sort(function (a, b) {
                return (a.NowQty - a.StockQty) - (b.NowQty - b.StockQty);
            });
            for (var i = 0; i < list.length; i++) {
                //if (list[i].PZBy != null || (list[i].BalanceQty - list[i].NowQty)==0) {
                //    continue;
                //}
                var value = 0;//盈亏数量
                var grnResultQty = 0; //平帐数量
                var firstQty = list[i].StockQty; //初盘数量
                var repeatQty = list[i].NowQty;//复盘数量
                handleStyle = $("#ddlChangeHandle").find(":selected").val();
                if (firstQty == 0 && repeatQty == 0) {
                    if (handleStyle == 1) { //盘亏处理
                        grnResultQty = 0
                        value = grnResultQty - list[i].BalanceQty;
                    } else {
                        grnResultQty = list[i].BalanceQty;
                        value = grnResultQty - list[i].BalanceQty;
                    }
                } else {
                    if (repeatQty == 0) {
                        grnResultQty = firstQty;
                        value = grnResultQty - list[i].BalanceQty;
                    } else {
                        grnResultQty = repeatQty;
                        value = grnResultQty - list[i].BalanceQty;
                    }
                }
                //获取盘点单明细信息
                //OrderDetailList.push({ "GRN": list[i].GRN, "NowQty": grnResultQty });
                if (i % 2 == 0) {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td class=\"grn\" grn=\"" + list[i].GRN + "\">" + list[i].GRN + "</td>"
                        + "<td>" + list[i].BalanceQty + "</td>"
                        + "<td>" + list[i].StockQty + "</td>"
                        + "<td class=\"NowQty\">" + list[i].NowQty + "</td>"
                        + (value >= 0 ? "<td class='ProfitAndLoss' style='background:#7FFF00'>" + value + "</td>" : "<td class='ProfitAndLoss' style='background:red'>" + value + "</td>")
                        + "<td class='changeQtys' ><input type='text' class='changeQty' id='ChangeQty'  value=" + grnResultQty + " /></td>"
                        + "</tr>";
            }
            $("#infotab").html(htmlstr + "</table>");
            $("#txtGRN").val("").focus();
        }

        //验证是否为数字（小数部分支持6位小数）
        function isGreaterThanOrEqualZero(val) {
            var reg = /^[0-9]+(.[0-9]{1,6})?$/;
            if (!reg.test(val)) {
                return false;
            }
            return true;
        }

        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }

        //根据字符串模糊查询采购单
        function selectOrder() {
            $("#listviews").listview("refresh");
           
            $("#listviews").on("filterablebeforefilter", function (e, data) {
                var $ul = $(this)
                $input = $(data.input)
                value = $input.val()


            });
        }
        $("#btnFilter").on("click", function () {
            $("#listviews").html("");
            var $ul = $(this),
            value = $.trim($("input[data-type='search']:eq(0)").val());
            var ulhtml = "";
            // var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetShowOrder(receiveChoosePageId, value);
            $.ajax({
                type: "POST",
                url: "../Handler/WarehouseCheck.ashx?api=GetWarehouseInfo",
                async: false,
                dataType: "json",
                success: function (data) {
                    $.each(data, function (a, b) {
       
                       
                   
                       
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'  title=\"" + b.CWhName + "\"><a  data-code=\"" + b.CWhCode + "\" onclick='SetPOCode(this)'>" + b.CWhName + "</a></li>";
                            
                        
                     
                    });
                },
                error: function (err) {
                    return;
                }
            });
            $("#listviews").html(ulhtml);
            $("#listviews").listview("refresh");
         
        });

        function SetPOCode(Code) {
         
            $("#ckid").val($(Code).data("code"));
            $("#ckmc").text($(Code).text());
            Orderselect();
            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#listviews").listview("refresh");
            $("#fpanel").panel("close");
 

        }
    </script>
</body>
</html>
