<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuList.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MenuList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">

    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link href="css/Index.css?v=11122" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.cookies.js" type="text/javascript"></script>
    <title>深科特LeanMES移动客户端</title>
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

        .noDisplay {
            display: none;
            /*border: 1px solid #00bfff;*/
        }

        .ui-title {
            line-height: 35px;
        }

        a {
            font-family: 'Microsoft YaHei';
            font-size: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="vertical-align: bottom">
                <h5 style="padding: 3px; margin: 0px;">
                    <div>
                        <label style="font-size: 16px !important; font-weight: bold; color: #FFFFFF; margin-bottom: 3px">
                            <span id="lbltitle" style="margin-bottom: 10px">管理</span>
                        </label>
                        <%--<img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7pmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjRUMTk6MDk6NDkrMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1NzozMSswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTc6MzErMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6NDlmZDM4NmQtMzU0Yy1kZDQxLWI5ZWQtYjFlYmJhMmI5YTZhPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6YjEyNGM0NzctMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6MjY4YzMxNzUtYjRhNC1mMDRiLWFiNGItMjQ3NTJhMDRhZjJmPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOjI2OGMzMTc1LWI0YTQtZjA0Yi1hYjRiLTI0NzUyYTA0YWYyZjwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNFQxOTowOTo0OSswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDo0YTIxNTE3Ny00ZjQ3LTY5NDYtOTVkNS02NjlhOGMwMWY5NjY8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjdUMDg6NDU6NDYrMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6NDlmZDM4NmQtMzU0Yy1kZDQxLWI5ZWQtYjFlYmJhMmI5YTZhPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU3OjMxKzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz6mFtciAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAJ9SURBVHja7NvRTdxAEIDhfyuAVJBcB/CUx5AKQmggh3jKU0gFOQqIgCekSAjTQEIqgA5IKoCr4JwKJg9Zo82y9tm7a7Dlmac7I915vrNnZtfCiAhTDqMACqAACqAAzxPHwK59XQBHUwNYAZv29T0wmxqA/8VGARRAARRAARRgmADHwNzp252/JxIg9tcpgVNgkQNg0w4tSdBPDFDFC4uRBDAHLkYKsG/H7CSAW2BrpAC/gO0UgFfAnXdsaY8PsQjeAy+9YzN7PArgBPjUQ/J9dgEf4RQ4jAVYeZX/qE1lfWaABfDFA5nFAOwCP7pcTgMBCN2274GrrgBXwDvn/U9nA2Pog9AN8KbNudcBhHr/2pYyIIBQ6w7OBHUAh3b6q+JP5BTYtO3VBJBju6wENpz3n21RbwVw51X7S6vaNfwiWtgr6SLweXV/ayxiDVEAH9bNBCGALTv8uLFtPyD1V6hObN5w0vNMc0erPEIAvtzvhEnQb0kxkdJ6/Zng0ZUcAvAv2+C9k3ApdonYW6+ulpW2GNYCtK6eT4CQmnyrbuYDXAM7PfX+Lgg5km81z7gAnSaoHhFyJr92onUB/IKVc+HTFiF38nXd6KGwugB+729cRfWA0FfyoVXtw2xRAezY+9+PPhEWTsJFxlXmuuSreAvcGBF5DXxMaFWVaOzIGhPVqJxyi14CZ0ZEzoE94nd8U0fWmFhlON8S+G5EJMeH9bGi67KSjEYwkvfJyNgAUADJ/2zMjCX5vgBGFQqgAArwH4CZSN6iAAqgAAqgAAqgADoIKYCIlDx+gDmVWBoR+QocTBBhCXyrtsVP+LdFvTGh5Atgof81pgAKoACTBvg7AJgqdJy41wqpAAAAAElFTkSuQmCC" />--%>
                    </div>
                    <%--  <div>
                    <label id="lbltitle" style="font-weight: bold; color: #FFFFFF">管理</label>
                </div>--%>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" class="ui-btn" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" class="ui-btn" data-ajax="false">主页</a>
            </div>

            <ul data-role="listview" data-inset="false" data-theme="c" class="listview" id="ulType4" style="display: none; font-size: 17px;">

                <li class="noDisplay" style="display: none;" id="PDA_WareHouseInOperation"><a href="#" onclick="Check(2);" data-transition="none" class="ui-btn" class="ui-btn">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/仓库收料.png" alt="仓库收料" style="margin-bottom: -8px; margin-right: 24px;" /></span>仓库收料</a>

                </li>


                <li class="noDisplay" style="display: none;" id="PDA_InStock"><a href="#" onclick="Check(3);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/物料入库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料入库 </a></li>

                <%--<li class="noDisplay" style="display: none;" id="PDA_InStorage"><a href="#" onclick="Check(49);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品入库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    上架入库 </a></li>--%>


                <li class="noDisplay" style="display: none;" id="PDA_WarehouseMaterialPrepare"><a href="#" onclick="Check(5);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/仓库备料.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    仓库备料 </a></li>

                <%--                <li class="noDisplay" style="display: none;" id="PDA_JITStockList"><a href="#" onclick="Check(22);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/JIT.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    JIT发料</a></li>--%>

                <%--<li class="noDisplay" style="display: none;" id="PDA_TakeMaterial"><a href="#" onclick="Check(52);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/仓库备料.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料备料 </a></li>--%>


                <li class="noDisplay" style="display: none;" id="PDA_MaterialSplit"><a href="#" onclick="Check(12);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/分料截图.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    分料截料 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_MaterialUnPack"><a href="#" onclick="Check(108);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/分料截图.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料拆箱 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_FormChange"><a href="#" onclick="Check(106);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/分料截图.png" alt="形态转换" style="margin-bottom: -8px; margin-right: 21px;" /></span>形态转换</a>            </li>

                <li class="noDisplay" style="display: none;" id="PDA_FormChangeByMes"><a href="#" onclick="Check(166);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/分料截图.png" alt="形态转换" style="margin-bottom: -8px; margin-right: 21px;" /></span>形态转换MES</a>            </li>

                <li class="noDisplay" style="display: none;" id="PDA_MesToErpChange"><a href="#" onclick="Check(118);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/分料截图.png" alt="ERP形态转换接口" style="margin-bottom: -8px; margin-right: 21px;" /></span>ERP形态转换接口</a>            </li>

                <%-- <li class="noDisplay" style="display: none;" id="PDA_SplitMaterial"><a href="#" onclick="Check(38);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/分料截图.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    拆分物料</a> </li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_MaterialCombine"><a href="#" onclick="Check(48);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/仓库收料.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料合并 </a></li>

                <%--  <li class="noDisplay" style="display: none;" id="PDA_GRNTransfer"><a href="#" onclick="Check(47);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    GRN转移 </a></li>--%>


                <li class="noDisplay" style="display: none;" id="PDA_MoveLocation"><a href="#" onclick="Check(4);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料库位转移 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_MoveLocationProd"><a href="#" onclick="Check(60);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    成品库位转移 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_WarehouseReturnToSupplier"><a href="#" onclick="Check(34);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/过期物料送检.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    仓库退供应商</a> </li>

                <li class="noDisplay" style="display: none;" id="PDA_WarehouseCheck"><a href="#" onclick="Check(1);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/盘点管理.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    仓库初盘 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_WarehouseCheckReplay"><a href="#" onclick="Check(11);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/仓库复盘.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    仓库复盘 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_WarehouseCheckEdit"><a href="#" onclick="Check(8);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/盘点修改.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    仓库平账 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_MaterialDetailInfo"><a href="#" onclick="Check(32);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/过期物料送检.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    仓库查询</a> </li>

                <%--<li class="noDisplay" style="display: none;" id="PDA_FeederBindMaterial"><a href="#" onclick="Check(13);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/飞达绑定GRN.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    飞达绑定GRN </a></li>--%>

                <%--<li class="noDisplay" style="display: none;" id="PDA_EncapsulationManager"><a href="#" onclick="Check(24);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/MSD管理.png" style="margin-bottom: -8px; margin-right: 21px;" />
                    </span>
                    MSD管理</a> </li>--%>

                <%--<li class="noDisplay" style="display: none;" id="PDA_Reinspection"><a href="#" onclick="Check(25);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/过期物料送检.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    过期物料送检</a> </li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_ExpiredMaterial"><a href="#" onclick="Check(50);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/过期物料送检.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    超期物料</a> </li>

                <li class="noDisplay" style="display: none;" id="PDA_TransferOut"><a href="#" onclick="Check(41);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    调拨出库 </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_TransferIn"><a href="#" onclick="Check(63);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    调拨入库 </a></li>

                <%-- <li class="noDisplay" style="display: none;" id="PDA_TransferOutNoBill"><a href="#" onclick="Check(42);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    无单调拨出库 </a></li>--%>

                <%--<li class="noDisplay" style="display: none;" id="PDA_ScrapOut"><a href="#" onclick="Check(43);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    报废出库 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_ScrapOutNoBill"><a href="#" onclick="Check(44);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    无单报废出库 </a></li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_CpInStock"><a href="#" onclick="Check(6);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品入库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    成品入库 </a></li>


                <li class="noDisplay" style="display: none;" id="PDA_CpOutStock"><a href="#" onclick="Check(7);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    成品出库 </a></li>

                <%--<li class="noDisplay" style="display: none;" id="PDA_PackingPallet"><a href="#" onclick="Check(46);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/过期物料送检.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    包装栈板</a> </li>

                <li class="noDisplay" style="display: none;" id="PDA_RepackingOutBox"><a href="#" onclick="Check(37);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/过期物料送检.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    重新包装-外箱</a> </li>

                <li class="noDisplay" style="display: none;" id="PDA_RepackingPallet"><a href="#" onclick="Check(36);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/过期物料送检.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    重新包装-栈板</a> </li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_ReturnMaterial"><a href="#" onclick="Check(39);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    生产退料申请</a> </li>
                <%--<li class="noDisplay" style="display: none;" id="PDA_ReturnMaterialFast"><a href="#" onclick="Check(65);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    生产快捷退料</a> </li>--%>
                <li class="noDisplay" style="display: none;" id="PDA_MaterialWhReturnToPDA"><a href="#" onclick="Check(66);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    生产退料入库</a> </li>
                <li class="noDisplay" style="display: none;" id="PDA_ConfirmReturnMaterial"><a href="#" onclick="Check(40);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/盘点修改.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    仓库确认退料</a> </li>
                <li class="noDisplay" style="display: none;" id="PDA_PackGRNSuply"><a href="#" onclick="Check(61);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品入库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    供应商包装物料条码</a> </li>
                <%--<li class="noDisplay" style="display: none;" id="PDA_MaterialDeliver"><a href="#" onclick="Check(62);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    生成送货单</a> </li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_TransferOutSN"><a href="#" onclick="Check(67);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    成品调拨 </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_CPReturnStockPrintGRN"><a href="#" onclick="Check(120);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    成品退货条码打印 </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_CPReturnStock"><a href="#" onclick="Check(96);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    成品退货 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_CpPrepare"><a href="#" onclick="Check(87);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/成品出库.png" alt="产成品领料出库" style="margin-bottom: -8px; margin-right: 21px;" /></span>产成品领料出库</a></li>

                <%--  电子货架--%>
                <%--<li class="noDisplay" style="display: none;" id="PDA_SWMSInStorage"><a href="#" onclick="Check(69);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品入库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    上架入库（智能货架） </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_SWMSAgeOfStorage"><a href="#" onclick="Check(70);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/仓库复盘.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料库龄（智能货架） </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_SWMSExpiredMaterial"><a href="#" onclick="Check(71);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/过期物料送检.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    超期物料（智能货架） </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_SWMSCheckMaterial"><a href="#" onclick="Check(72);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/盘点管理.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料盘点（智能货架） </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_SWMSTakeMaterial"><a href="#" onclick="Check(73);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/仓库备料.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料备料（智能货架） </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_SWMSMoveMaterial"><a href="#" onclick="Check(74);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料移库（智能货架） </a></li>
                <li class="noDisplay" style="display: none;" id="PDA_SWMSQueryMaterial"><a href="#" onclick="Check(75);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/仓库复盘.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    物料查询（智能货架） </a></li>--%>
                <%--  电子货架--%>


                <li class="noDisplay" style="display: none;" id="PDA_GRNPrint"><a href="#" onclick="Check(88);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    GRN补打 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_AGVCheck"><a href="#" onclick="Check(103);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" />AGV拖运</span> </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_TransferInAGV"><a href="#" onclick="Check(104);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/库位转移.png" style="margin-bottom: -8px; margin-right: 21px;" />调拨入库-AGV</span> </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_CpOutStockAGV"><a href="#" onclick="Check(105);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    成品出库-AGV </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_AGVCpOutStock"><a href="#" onclick="Check(109);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    AGV拖用-成品出库 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_AGVEmptyTray"><a href="#" onclick="Check(110);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    AGV拖运-空拖 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_AGVCpInstock"><a href="#" onclick="Check(111);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    AGV拖运-成品入库 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_AGVTaskList"><a href="#" onclick="Check(112);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/成品出库.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    AGV任务列表 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_AGVUnbind"><a href="#" onclick="Check(116);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/盘点修改.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    托盘入库暂存区条码解除 </a></li>

                <li class="noDisplay" style="display: none;" id="PDA_MaterialSearch"><a href="#" onclick="Check(113);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="库存查询" style="margin-bottom: -8px; margin-right: 21px;" /></span>库存查询</a>
                </li>

                <li class="noDisplay" style="display: none;" id="PDA_CbarCodeSearch"><a href="#" onclick="Check(117);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="库位查询" style="margin-bottom: -8px; margin-right: 21px;" /></span>库位查询</a>
                </li>
            </ul>
            <ul data-role="listview" data-inset="false" data-theme="c" class="listview" id="ulType5" style="display: none; font-size: 16px;">

                <%--<li class="noDisplay" style="display: none;" id="PDA_SMTCheckMaterial"><a href="#" onclick="Check(15);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/SMT上料.png" alt="SMT上料" style="margin-bottom: -8px; margin-right: 21px;" /></span>SMT上料</a></li>--%>

                <%--<li class="noDisplay" style="display: none;" id="PDA_StationMaterialPrepar"><a href="#" onclick="Check(92);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/仓库备料.png" alt="站位备料" style="margin-bottom: -8px; margin-right: 21px;" /></span>站位备料</a></li>--%>


                <li class="noDisplay" style="display: none;" id="PDA_HandLoadingMaterial"><a href="#" onclick="Check(9);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/手插上料.png" alt="组装上料" style="margin-bottom: -8px; margin-right: 21px;" /></span>组装上料</a>            </li>

                <li class="noDisplay" style="display: none;" id="PDA_InjectionLoadingMaterial"><a href="#" onclick="Check(114);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/手插上料.png" alt="注塑上料" style="margin-bottom: -8px; margin-right: 21px;" /></span>注塑上料</a>            </li>

                <li class="noDisplay" style="display: none;" id="PDA_FeedingHopperCrusher"><a href="#" onclick="Check(119);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/手插上料.png" alt="粉碎机上料" style="margin-bottom: -8px; margin-right: 21px;" /></span>粉碎机上料</a>            </li>

                <li class="noDisplay" style="display: none;" id="PDA_CustomerSNBind"><a href="#" onclick="Check(115);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/手插上料.png" alt="客户条码绑定" style="margin-bottom: -8px; margin-right: 21px;" /></span>客户条码绑定</a>            </li>



                <%--<li class="noDisplay" style="display: none;" id="PDA_PrepLoadingMaterial"><a href="#" onclick="Check(10);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/前置加工上料.png" alt="前置加工上料" style="margin-bottom: -8px; margin-right: 21px;" /></span>前置加工上料</a> </li>--%>

                <%--<li class="noDisplay" style="display: none;" id="PDA_LineWarehouseReceive"><a href="#" onclick="Check(35);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="线边仓接收" style="margin-bottom: -8px; margin-right: 21px;" /></span>线边仓接收</a></li>

                <li class="noDisplay" style="display: none;" id="PDA_ProductionReceive"><a href="#" onclick="Check(23);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="生产接收" style="margin-bottom: -8px; margin-right: 21px;" /></span>生产接收</a></li>--%>

                <%-- <li class="noDisplay" style="display: none;" id="PDA_AccessoryStir"><a href="#" onclick="Check(55);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="辅料搅拌" style="margin-bottom: -8px; margin-right: 21px;" /></span>辅料搅拌</a></li>


                <li class="noDisplay" style="display: none;" id="PDA_AccessoryThaw"><a href="#" onclick="Check(27);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="辅料回温" style="margin-bottom: -8px; margin-right: 21px;" /></span>辅料解冻</a></li>
                <li class="noDisplay" style="display: none;" id="PDA_AccessoryOperation"><a href="#" onclick="Check(29);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="辅料作业" style="margin-bottom: -8px; margin-right: 21px;" /></span>辅料作业</a></li>

                <li class="noDisplay" style="display: none;" id="PDA_AccessoryLoading"><a href="#" onclick="Check(21);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="辅料上料校验" style="margin-bottom: -8px; margin-right: 21px;" /></span>辅料上料校验</a></li>--%>

                <%-- <li class="noDisplay" style="display: none;" id="PDA_AccessoryReturn"><a href="#" onclick="Check(30);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="辅料退回" style="margin-bottom: -8px; margin-right: 21px;" /></span>辅料退回</a></li>

                <li class="noDisplay" style="display: none;" id="PDA_AccessoryFinish"><a href="#" onclick="Check(31);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="辅料空瓶管理" style="margin-bottom: -8px; margin-right: 21px;" /></span>辅料空瓶管理</a></li>

                <li class="noDisplay" style="display: none;" id="PDA_SMTTransferMaterial"><a href="#" onclick="Check(45);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="工单转料" style="margin-bottom: -8px; margin-right: 21px;" /></span>SMT工单转料</a></li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_ProductionCollection"><a href="#" onclick="Check(94);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="生产采集" style="margin-bottom: -8px; margin-right: 21px;" /></span>生产采集</a></li>

                <%--<li class="noDisplay" style="display: none;" id="PDA_BatchSNChangMaterialGRN"><a href="#" onclick="Check(95);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="批次生成物料条码" style="margin-bottom: -8px; margin-right: 21px;" /></span>批次生成物料条码</a></li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_ProdDetailInfo"><a href="#" onclick="Check(33);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="生产查询" style="margin-bottom: -8px; margin-right: 21px;" /></span>生产查询</a></li>

                <%--<li class="noDisplay" style="display: none;" id="PDA_FeederBindMaterial"><a href="#" onclick="Check(13);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/飞达绑定GRN.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    飞达绑定GRN </a></li>
               <li class="noDisplay" style="display: none;" id="PDA_FeederChangeBind"><a href="#" onclick="Check(84);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/飞达绑定GRN.png" style="margin-bottom: -8px; margin-right: 21px;" /></span>
                    飞达替换 </a></li>--%>
                <li class="noDisplay" style="display: none;" id="PDA_NineInOneKanbanVertical"><a href="#" onclick="Check(93);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="辅料发料" style="margin-bottom: -8px; margin-right: 21px;" /></span>手机九合一看板</a></li>
                <li class="noDisplay" style="display: none;" id="PDA_AccessorySendMaterial"><a href="#" onclick="Check(28);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="辅料发料" style="margin-bottom: -8px; margin-right: 21px;" /></span>辅料发料</a></li>

                <%-- <li class="noDisplay" style="display: none;" id="PDA_MaterialInStock"><a href="#" onclick="Check(89);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="料塔-物料入库" style="margin-bottom: -8px; margin-right: 21px;" /></span>料塔-物料入库</a></li>

                <li class="noDisplay" style="display: none;" id="PDA_MaterialPrepare"><a href="#" onclick="Check(90);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="料塔-工单取料" style="margin-bottom: -8px; margin-right: 21px;" /></span>料塔-工单取料</a></li>

                <li class="noDisplay" style="display: none;" id="PDA_MaterialReturn"><a href="#" onclick="Check(91);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="料塔-清空" style="margin-bottom: -8px; margin-right: 21px;" /></span>料塔-清空</a></li>--%>

                <li class="noDisplay" style="display: none;" id="PDAFirstArticleInspection"><a href="#" onclick="Check(101);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="首件送检" style="margin-bottom: -8px; margin-right: 21px;" /></span>首件送检</a></li>
            </ul>
            <ul data-role="listview" data-inset="false" data-theme="c" class="listview" id="ulType6" style="display: none; font-size: 16px;">
                <%--<li class="noDisplay" style="display: none;" id="PDA_EQ_InOUTInstock"><a href="#" onclick="Check(59);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀上下线.png" alt="钢网刮刀出入库" style="margin-bottom: -8px; margin-right: 21px;" /></span>钢网刮刀出入库</a></li>


                <li class="noDisplay" style="display: none;" id="PDA_EQ_SteelNet"><a href="#" onclick="Check(16);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀上下线.png" alt="钢网/刮刀上线" style="margin-bottom: -8px; margin-right: 21px;" /></span>钢网/刮刀上线</a></li>


                <li class="noDisplay" style="display: none;" id="PDA_EQ_SteelNetWash"><a href="#" onclick="Check(17);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀清洗.png" alt="钢网/刮刀下线清洗" style="margin-bottom: -8px; margin-right: 21px;" /></span>钢网/刮刀下线清洗</a></li>


                <li class="noDisplay" style="display: none;" id="PDA_EQ_SteelSearch"><a href="#" onclick="Check(18);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="钢网/刮刀查询" style="margin-bottom: -8px; margin-right: 21px;" /></span>钢网/刮刀查询</a></li>--%>


                <li class="noDisplay" style="display: none;" id="PDA_BurningBaseOnLine"><a href="#" onclick="Check(56);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="底座上线" style="margin-bottom: -8px; margin-right: 21px;" /></span>IC底座上线</a></li>
                <li class="noDisplay" style="display: none;" id="PDA_BurningBaseOutLine"><a href="#" onclick="Check(57);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/辅料校验.png" alt="底座下线" style="margin-bottom: -8px; margin-right: 21px;" /></span>IC底座下线</a></li>
                <li class="noDisplay" style="display: none;" id="PDA_EquipmentCollection"><a href="#" onclick="Check(58);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="设备状态采集" style="margin-bottom: -8px; margin-right: 21px;" /></span>设备状态采集</a></li>

                <%--<li class="noDisplay" style="display: none;" id="PDA_AgeingCollection"><a href="#" onclick="Check(53);" data-transition="none" class="ui-btn" class="ui-btn">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/盘点管理.png" alt="老化开始" style="margin-bottom: -8px; margin-right: 24px;" /></span>老化开始</a>

                </li>
                <li class="noDisplay" style="display: none;" id="PDA_AgeingBadCollection"><a href="#" onclick="Check(54);" data-transition="none" class="ui-btn" class="ui-btn">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/盘点管理.png" alt="老化结束" style="margin-bottom: -8px; margin-right: 24px;" /></span>老化结束</a>
                </li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_SparePartsInOutStock"><a href="#" onclick="Check(64);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="工装治具出入库" style="margin-bottom: -8px; margin-right: 21px;" /></span>工装治具出入库</a></li>


                <li class="noDisplay" style="display: none;" id="PDA_EquipmentSendRepair"><a href="#" onclick="Check(80);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="PDA设备报修" style="margin-bottom: -8px; margin-right: 21px;" /></span>PDA设备报修</a>
                </li>

                <li class="noDisplay" style="display: none;" id="PDA_EquipmentRepair"><a href="#" onclick="Check(81);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="PDA设备维修" style="margin-bottom: -8px; margin-right: 21px;" /></span>PDA设备维修</a>
                </li>

                <li class="noDisplay" style="display: none;" id="PDA_EquipmentAccept"><a href="#" onclick="Check(82);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="PDA设备验收" style="margin-bottom: -8px; margin-right: 21px;" /></span>PDA设备验收</a>
                </li>

                <li class="noDisplay" style="display: none;" id="PDA_EquipmentSendRepairList"><a href="#" onclick="Check(83);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="PDA设备报修列表" style="margin-bottom: -8px; margin-right: 21px;" /></span>PDA设备报修列表</a>

                </li>
                <%--模治具上下线--%>
                <li class="noDisplay" style="display: none;" id="PDA_MoldFixtureUpOrDown"><a href="#" onclick="Check(97);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="PDA模治具上下线" style="margin-bottom: -8px; margin-right: 21px;" /></span>PDA模治具上下线</a>

                </li>
                <%--模治具出入库--%>
                <li class="noDisplay" style="display: none;" id="PDA_MoldFixtureInOutStock"><a href="#" onclick="Check(98);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="PDA模治具出入库" style="margin-bottom: -8px; margin-right: 21px;" /></span>PDA模治具出入库</a>
                </li>

                <li class="noDisplay" style="display: none;" id="PDA_MaintenanceHistory"><a href="#" onclick="Check(99);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="维修履历" style="margin-bottom: -8px; margin-right: 21px;" /></span>维修履历</a>
                </li>

                <li class="noDisplay" style="display: none;" id="PDA_MaintenanceEquiment"><a href="#" onclick="Check(100);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="PDA保养" style="margin-bottom: -8px; margin-right: 21px;" /></span>PDA保养</a>
                </li>

                <li class="noDisplay" style="display: none;" id="PDA_MouldOperateRecord"><a href="#" onclick="Check(107);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/钢网刮刀查询.png" alt="模具保养" style="margin-bottom: -8px; margin-right: 21px;" /></span>模具保养</a>
                </li>
            </ul>

            <ul data-role="listview" data-inset="false" data-theme="c" class="listview" id="ulType7" style="display: none; font-size: 16px;">

                <%-- <li class="noDisplay" style="display: none;" id="PDA_CheckSMTLoadingMaterial"><a href="#" onclick="Check(85);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/SMT上料.png" alt="SMT物料核对" style="margin-bottom: -8px; margin-right: 21px;" /></span>SMT物料核对</a></li>

                <li class="noDisplay" style="display: none;" id="PDA_CheckDIPLoadingMaterial"><a href="#" onclick="Check(86);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="newImages/icon/SMT上料.png" alt="DIP物料核对" style="margin-bottom: -8px; margin-right: 21px;" /></span>DIP物料核对</a></li>--%>

                <li class="noDisplay" style="display: none;" id="PDA_QualityInStock"><a href="#" onclick="Check(102);" data-transition="none" class="ui-btn" data-ajax="false">
                    <span style="height: 14px; width: 14px; vertical-align: middle">
                        <img src="images/NEW/SecondMenuList/物料入库.png" alt="品质入库确认" style="margin-bottom: -8px; margin-right: 21px;" /></span>品质入库确认</a></li>

            </ul>
        </div>
    </form>
    <script type="text/javascript">
        var lblTitle = "";
        var srcVal = "";
        $(function () {
            var type = '<%= Request.QueryString["type"] == null ? -1 : Convert.ToInt32(Request.QueryString["type"].ToString())%>';
            $("#ulType" + type).show();

            switch (type) {
                case "4":
                    lblTitle = "仓库管理";
                    srcVal = "newImages/WarehouseManager.png";
                    break;
                case "5":
                    lblTitle = "生产管理";
                    srcVal = "newImages/productionManager.png";
                    break;
                case "6":
                    lblTitle = "设备管理";
                    srcVal = "newImages/EquimentManager.png";
                    break;
                case "7":
                    lblTitle = "品质管理";
                    srcVal = "newImages/EquimentManager.png";
                    break;
                default:
            }
            $("#imgSrc").attr("src", srcVal);
            $("#lbltitle").text(lblTitle);
            getModulesByUserId();
        });

        //$(function () {
        //    $(".ui-btn-left").hide();
        //    if (!window.nativeMethod) {
        //        $(".appconfig").hide();
        //    }
        //    //
        //});

        function configServer() {
            if (confirm("是否确定要更改服务信息，【确定】将会退出当前系统？")) {
                try {
                    window.nativeMethod.toActivity("configact");
                }
                catch (ex) {
                    alert("此功能只针对LEAN MES的移动APP客户端(Android版)有效。\n详细错误信息：" + ex);
                }
            }
        }

        var idArr = ["PDA_WarehouseCheck", "PDA_WareHouseInOperation", "PDA_InStock", "PDA_MoveLocation", "PDA_WarehouseMaterialPrepare",
            "PDA_CpInStock", "PDA_CpOutStock", "PDA_WarehouseCheckEdit", "PDA_HandLoadingMaterial", "PDA_PrepLoadingMaterial",
            "PDA_WarehouseCheckReplay", "PDA_MaterialSplit", "PDA_FeederBindMaterial", "PDA_FeederChangeBind", "PDA_SMTCheckMaterial",
            "PDA_EQ_SteelNet", "PDA_EQ_SteelNetWash", "PDA_EQ_SteelSearch", "PDA_AgeingCollection", "PDA_AgeingBadCollection", "PDA_BurningBaseOnLine", "PDA_BurningBaseOutLine", "PDA_EquipmentCollection",
            "PDA_JITStockList", "PDA_ProductionReceive", "PDA_EncapsulationManager", "PDA_Reinspection", "PDA_OrderAgingRpt",
            "PDA_AccessoryThaw", "PDA_AccessorySendMaterial", "PDA_AccessoryLoading", "PDA_AccessoryReturn", "PDA_AccessoryFinish", "PDA_AccessoryStir",
            "PDA_MaterialDetailInfo", "PDA_ProdDetailInfo", "PDA_SMTTransferMaterial", "PDA_WarehouseReturnToSupplier", "PDA_LineWarehouseReceive", "PDA_PackingPallet", "PDA_RepackingPallet",
            "PDA_RepackingOutBox", "PDA_SplitMaterial", "PDA_ReturnMaterial", "PDA_ConfirmReturnMaterial",
            "PDA_TransferOut", "PDA_TransferOutNoBill", "PDA_ScrapOut", "PDA_ScrapOutNoBill", "PDA_PackingPallet", "PDA_GRNTransfer", "PDA_MaterialCombine", "PDA_InStorage", "PDA_ExpiredMaterial",
            "PDA_TakeMaterial", "PDA_MoveMaterial", "PDA_EQ_InOUTInstock", "PDA_MoveLocationProd", 'PDA_PackGRNSuply',
            'PDA_MaterialDeliver', 'PDA_TransferOutSN', 'PDA_CPReturnStock', 'PDA_AccessoryOperation', "PDA_TransferIn", "PDA_SparePartsInOutStock",
            "PDA_ReturnMaterialFast", "PDA_MaterialWhReturnToPDA", "PDA_EquipmentSendRepair", "PDA_EquipmentRepair", "PDA_EquipmentAccept", "PDA_EquipmentSendRepairList",
            'PDA_SWMSInStorage', 'PDA_SWMSAgeOfStorage', 'PDA_SWMSExpiredMaterial', 'PDA_AGVCpOutStock', 'PDA_AGVEmptyTray', 'PDA_AGVCpInstock', 'PDA_AGVTaskList',
            'PDA_SWMSCheckMaterial', 'PDA_SWMSTakeMaterial', 'PDA_SWMSMoveMaterial', 'PDA_SWMSQueryMaterial', 'PDA_CheckSMTLoadingMaterial', 'PDA_GRNPrint', 'PDA_MaterialUnPack',
            'PDA_CheckDIPLoadingMaterial', 'PDA_CpPrepare', 'PDA_MaterialInStock', 'PDA_MaterialPrepare', 'PDA_MaterialReturn', 'PDA_StationMaterialPrepar', 'PDA_NineInOneKanbanVertical', "PDA_ProductionCollection", "PDA_BatchSNChangMaterialGRN", "PDA_CPReturnStock", "PDA_CbarCodeSearch"
            , "PDA_MoldFixtureInOutStock", "PDA_MoldFixtureUpOrDown", "PDA_MaintenanceHistory", "PDA_MaintenanceEquiment", "PDAFirstArticleInspection", "PDA_QualityInStock", "PDA_AGVCheck", "PDA_TransferInAGV", "PDA_CpOutStockAGV", 'PDA_FormChange', 'PDA_MouldOperateRecord', 'PDA_MaterialSearch', 'PDA_InjectionLoadingMaterial', 'PDA_CustomerSNBind', 'PDA_AGVUnbind', 'PDA_MesToErpChange',
            "PDA_FeedingHopperCrusher","PDA_FormChangeByMes","PDA_CPReturnStockPrintGRN"
        ];

        function getModulesByUserId() {

            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetPopedomNameByUserId(parseInt(userId), "LeanMES_PDA");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var result = ajax.value.toLowerCase();
            for (var i = 0; i < idArr.length; i++) {
                if (result.indexOf(idArr[i].toLowerCase()) != -1) {
                    if (idArr[i] != "PDA_AccessorySendMaterial" && idArr[i] != "PDA_ConfirmReturnMaterial" && idArr[i] != "PDA_ReturnMaterial") {//辅料发料已经不用,,仓库确认退料已经不用
                        $("#" + idArr[i]).show();
                    }

                }
            }

        }


        function Check(data) {
            if (data == 1) {
                window.location.href = "WarehouseCheck.aspx";
            } else if (data == 2) {
                window.location.href = "WareHouseInOperation.aspx";
            } else if (data == 3) {
                window.location.href = "InStock.aspx";
            } else if (data == 4) {
                window.location.href = "MoveLocation.aspx";
            } else if (data == 5) {
                window.location.href = "WarehouseMaterialPrepare.aspx";
            } else if (data == 6) {
                window.location.href = "CpInStock.aspx";
            } else if (data == 7) {
                window.location.href = "CpOutStock.aspx";
            } else if (data == 8) {
                window.location.href = "WarehouseCheckEdit.aspx";
            } else if (data == 9) {
                window.location.href = "HandLoadingMaterial.aspx";
            } else if (data == 10) {
                window.location.href = "PrepLoadingMaterial.aspx";
            } else if (data == 11) {
                window.location.href = "WarehouseCheckReplay.aspx";
            } else if (data == 12) {
                window.location.href = "MaterialSplit.aspx";
            } else if (data == 13) {
                window.location.href = "FeederBindMaterial.aspx";
            } else if (data == 14) {
                window.location.href = "FeederAndMaterialInfo.aspx";
            } else if (data == 15) {
                window.location.href = "SMTCheckMaterial.aspx";
            } else if (data == 16) {
                window.location.href = "EQ_SteelNet.aspx";
            } else if (data == 17) {
                window.location.href = "EQ_SteelNetWash.aspx";
            } else if (data == 18) {
                window.location.href = "EQ_SteelSearch.aspx";
            } else if (data == 16) {
                window.location.href = "CpPrepare.aspx";
            } else if (data == 21) {//辅料上料校验
                window.location.href = "AccessoryLoading.aspx";
            } else if (data == 22) {//JIT发料
                window.location.href = "JITStockList.aspx";
            } else if (data == 23) {//产线接收
                window.location.href = "ProductionReceive.aspx";
            } else if (data == 24) {//MSD管理
                window.location.href = "EncapsulationManager.aspx";
            } else if (data == 25) {//送检
                window.location.href = "Reinspection.aspx";
            } else if (data == 26) {
                window.location.href = "OrderAgingRpt.aspx";
            } else if (data == 27) {
                window.location.href = "AccessoryThaw.aspx";//辅料解冻
            } else if (data == 28) {
                window.location.href = "AccessorySendMaterial.aspx";//辅料发料
            } else if (data == 29) {
                window.location.href = "AccessoryOperation.aspx";//辅料作业
            } else if (data == 30) {
                window.location.href = "AccessoryReturn.aspx";//辅料退回
            } else if (data == 31) {
                window.location.href = "AccessoryFinish.aspx";//辅料空瓶管理
            } else if (data == 32) {
                window.location.href = "MaterialDetailInfo.aspx";//仓库查询
            } else if (data == 33) {
                window.location.href = "ProdDetailInfo.aspx";//生产查询
            } else if (data == 34) {
                window.location.href = "WarehouseReturnToSupplier.aspx";//仓库退供应商
            } else if (data == 35) {
                window.location.href = "LineWarehouseReceive.aspx";//线边仓接收
            } else if (data == 36) {
                window.location.href = "RepackingPallet.aspx";//重新包装栈板
            } else if (data == 37) {
                window.location.href = "RepackingOutBox.aspx";//重新包装外箱
            } else if (data == 38) {
                window.location.href = "MaterialPartition.aspx";//拆分物料
            } else if (data == 39) {
                window.location.href = "ReturnMaterial.aspx";//生产退料申请
            } else if (data == 40) {
                window.location.href = "ConfirmReturnMaterial.aspx";//仓库确认退料
            } else if (data == 41) {
                window.location.href = "TransferOut.aspx";//调拨出库
            } else if (data == 42) {
                window.location.href = "TransferOutNoBill.aspx";//无单调拨出库
            } else if (data == 43) {
                window.location.href = "ScrapOut.aspx";//报废出库
            } else if (data == 44) {
                window.location.href = "ScrapOutNoBill.aspx";//无单报废出库
            } else if (data == 45) {
                window.location.href = "SMTTransferMaterial.aspx";//SMT工单转产
            } else if (data == 46) {
                window.location.href = "PackingPallet.aspx";//包装栈板
            } else if (data == 47) {
                window.location.href = "GRNTransfer.aspx";//GRN转移
            } else if (data == 48) {
                window.location.href = "MaterialCombine.aspx";//物料合并
            } else if (data == 49) {
                window.location.href = "InStorage.aspx";//上架入库
            } else if (data == 50) {
                window.location.href = "ExpiredMaterial.aspx";//超期物料
            } else if (data == 51) {
                window.location.href = "MoveMaterial.aspx";//物料移库
            } else if (data == 52) {
                window.location.href = "TakeMaterial.aspx";//物料备料
            } else if (data == 53) {
                window.location.href = "PDAAgeingCollection.aspx";//老化开始
            } else if (data == 54) {
                window.location.href = "PDAAgeingBadCollection.aspx";//老化结果
            } else if (data == 55) {
                window.location.href = "AccessoryStir.aspx";//辅料搅拌
            } else if (data == 56) {
                window.location.href = "BurningBaseOnLine.aspx";//底座上线
            } else if (data == 57) {
                window.location.href = "BurningBaseOutLine.aspx";//底座下线
            } else if (data == 58) {
                window.location.href = "EquipmentCollection.aspx";//设备状态采集
            } else if (data == 59) {
                window.location.href = "EQ_InOUTInstock.aspx";//钢网刮刀出入库
            } else if (data == 60) {
                window.location.href = "MoveLocationProd.aspx";//成品库位转移
            } else if (data == 61) {
                window.location.href = "PDAPackGRNSuply.aspx";//供应商包装物料条码
            } else if (data == 62) {
                window.location.href = "PDAMaterialDeliver.aspx";//生成送货单
            } else if (data == 63) {
                window.location.href = "TransferIn.aspx";//调拨入库
            }
            else if (data == 64) {
                window.location.href = "SparePartsInOutStock.aspx";//工装治具出入库
            }
            else if (data == 65) {
                window.location.href = "ReturnMaterialFast.aspx";//生产便捷退料
            }
            else if (data == 66) {
                window.location.href = "MaterialWhReturnToPDA.aspx";//生产退料入库
            }
            else if (data == 67) {
                window.location.href = "TransferOutSN.aspx";//成品调拨
            }
            else if (data == 69) {
                window.location.href = "SWMSInStorage.aspx";//电子货架---上架入库
            }
            else if (data == 70) {
                window.location.href = "SWMSAgeOfStorage.aspx";//电子货架---物料库龄
            }
            else if (data == 71) {
                window.location.href = "SWMSExpiredMaterial.aspx";//电子货架---超期物料
            }
            else if (data == 72) {
                window.location.href = "SWMSCheckMaterial.aspx";//电子货架---物料盘点
            }
            else if (data == 73) {
                window.location.href = "SWMSTakeMaterial.aspx";//电子货架---物料备料
            }
            else if (data == 74) {
                window.location.href = "SWMSMoveMaterial.aspx";//电子货架---物料移库
            }
            else if (data == 75) {
                window.location.href = "SWMSQueryMaterial.aspx";//电子货架---物料查询
            }
            else if (data == 80) {
                window.location.href = "EquipmentSendRepair.aspx";//设备报修
            }
            else if (data == 81) {
                window.location.href = "EquipmentRepair.aspx";//设备维修
            }
            else if (data == 82) {
                window.location.href = "EquipmentAccept.aspx";//设备验收
            }
            else if (data == 83) {
                window.location.href = "EquipmentSendRepairList.aspx";//设备维修列表
            }
            else if (data == 84) {
                window.location.href = "FeederChangeBind.aspx";//飞达换绑

            }
            else if (data == 85) {
                window.location.href = "CheckSMTLoadingMaterial.aspx";//SMT上料核对
            }
            else if (data == 86) {
                window.location.href = "CheckDIPLoadingMaterial.aspx";//DIP上料核对
            }
            else if (data == 87) {
                window.location.href = "CpPrepare.aspx";//半成品领料
            }
            else if (data == 88) {
                window.location.href = "GRNRePrint.aspx";//GRN补打
            }
            else if (data == 89) {
                window.location.href = "PDAMaterialInStock.aspx";//生产物料入库
            } else if (data == 90) {
                window.location.href = "PDAMaterialPrepare.aspx";//生产物料备料
            } else if (data == 91) {
                window.location.href = "PDAMaterialReturn.aspx";//生产退料
            }
            else if (data == 92) {
                window.location.href = "StationMaterialPrepar.aspx";//站位备料
            }
            else if (data == 93) {
                window.location.href = "NineInOneKanbanVertical.aspx";//九一看板-竖屏
            }
            else if (data == 94) {
                window.location.href = "PDAProductionCollection.aspx";//生产采集
            }
            else if (data == 95) {
                window.location.href = "PDABatchSNChangMaterialGRN.aspx";//批次生成物料条码
            }
            else if (data == 96) {
                window.location.href = "CPReturnStock.aspx";//成品退货
                //window.location.href = "CPReturnStockEx.aspx";//成品退货
            }
            else if (data == 97) {
                window.location.href = "MoldFixtureUpOrDown.aspx";//模治具上下线
            }
            else if (data == 98) {
                window.location.href = "MoldFixtureInOutStock.aspx";//模治具出入库
            }
            else if (data == 99) {
                window.location.href = "MaintenanceHistory.aspx?name=PDA_MaintenanceHistory"; // 维修履历
            }
            else if (data == 100) {
                window.location.href = "MaintenanceEquiment.aspx?name=PDA_MaintenanceEquiment"; // PDA保养
            }
            else if (data == 101) {
                window.location.href = "PDAFirstArticleInspection.aspx?name=PDAFirstArticleInspection";//首件送检
            }
            else if (data == 102) {
                window.location.href = "PDAQualityInStock.aspx?name=PDA_QualityInStock";//品质入库确认
            }
            else if (data == 103) {
                window.location.href = "PDAAGVCheck.aspx?name=PDA_AGVCheck";//AVG托运
            }
            else if (data == 104) {
                window.location.href = "TransferInAGV.aspx?name=PDA_TransferInAGV";//调拨入库-AGV
            }
            else if (data == 105) {
                window.location.href = "CpOutStockAGV.aspx?name=PDA_CpOutStockAGV";//成品出库-AGV
            }
            else if (data == 106) {
                window.location.href = "FormChangeByMES.aspx";//形态转换
            } else if (data == 166) {
                window.location.href = "FormChangeByMES.aspx";//形态转换mes
            }
            else if (data == 107) {
                window.location.href = "PDAMouldOperateRecord.aspx?name=PDA_MouldOperateRecord";//PDA模具保养
            } else if (data == 108) {
                window.location.href = "MaterialUnPack.aspx?name=PDA_MaterialUnPack";//PDA物料拆箱
            }
            else if (data == 109) {
                window.location.href = "AGVCpOutStock.aspx?name=PDA_AGVCpOutStock";//PDA
            }
            else if (data == 110) {
                window.location.href = "AGVEmptyTray.aspx?name=PDA_AGVEmptyTray";//PDA
            }
            else if (data == 111) {
                window.location.href = "AGVCpInstock.aspx?name=PDA_AGVCpInstock";//PDA
            }
            else if (data == 112) {
                window.location.href = "AGVTaskList.aspx?name=PDA_AGVTaskList";//PDA
            }
            else if (data == 113) {
                window.location.href = "MaterialSearch.aspx?name=PDA_MaterialSearch";//PDA库存查询
            }
            else if (data == 114) {
                window.location.href = "InjectionLoadingMaterial.aspx?name=PDA_InjectionLoadingMaterial";//PDA
            }
            else if (data == 115) {
                window.location.href = "CustomerSNBind.aspx?name=PDA_CustomerSNBind";//PDA
            }
            else if (data == 116) {
                window.location.href = "AGVUnbind.aspx?name=PDA_AGVUnbind";//PDA
            }
            else if (data == 117) {
                window.location.href = "CbarCodeSearch.aspx?name=PDA_CbarCodeSearch";//PDA
            }
            else if (data == 118) {
                window.location.href = "MesToErpFormChange.aspx";//PDA
            } else if (data == 119) {
                window.location.href = "FeedingHopperCrusher.aspx";//PDA粉碎机上料
            }
            else if (data == 120) {
                window.location.href = "CPReturnStockPrintGRN.aspx";//PDA
            }
            


        }
    </script>
</body>


</html>





