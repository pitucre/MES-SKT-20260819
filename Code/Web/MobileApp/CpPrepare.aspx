<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CpPrepare.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.CpPrepare" %>


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
    <title>产成品领料出库</title>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }

        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }

        .ui-title { line-height: 30px; }

        div.ui-input-search { background-color: #fff; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="page">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <%--<div>
                        <img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7pmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjRUMTk6MDQ6MzErMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1NDoyMCswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTQ6MjArMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6NTM1YjEzMTgtMzU1MS1iNzRlLTlmM2YtNTYzNTY0ZDRkYzhmPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6M2Y3NDUxYzgtMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6ZGI5NGNhYTMtNTQ4OS1lNDRiLWI3NzctMWRjODQzOWRmYTUyPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOmRiOTRjYWEzLTU0ODktZTQ0Yi1iNzc3LTFkYzg0MzlkZmE1Mjwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNFQxOTowNDozMSswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpmZmViZDU2Zi1lMzYxLTc5NDAtOThlNC1jOTNiNDkzYTNlNzQ8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjdUMDk6MDU6NDIrMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6NTM1YjEzMTgtMzU1MS1iNzRlLTlmM2YtNTYzNTY0ZDRkYzhmPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU0OjIwKzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg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" />
                    </div>
                    <div>
                        半/成品出库
                    </div>--%>
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">产成品领料出库</label>
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
                            <select name="select-custom-20" data-corners="false" id="workorderlist" class="workorderlist">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="#myPopupType" id="ScanType" data-rel="popup" class="ui-link-inherit" data-position-to="window">卡通箱</a>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtGRN" />
                        </td>
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

                <iframe id="iframeGrnList" name="iframeGrnList" style="width: 100%; overflow: auto; margin: auto 0px; height: 100%"
                    frameborder="0" marginwidth="0" marginheight="0"></iframe>
                <div data-role="popup" id="myPopup" class="ui-content" data-position-to="#myId" data-overlay-theme="b">
                    <ul data-role="listview" id="worklist">
                    </ul>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed; bottom: 0px">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="StartCheck" onclick="Save()" data-corners="false" data-role="button"
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

            <div data-role="popup" id="myPopupType" style="min-width: 220px" data-theme="f">
                <div class="ui-controlgroup-controls" data-theme="f">
                    <a href="#" data-theme="f" data-role="button" onclick="ChooseScanType(1)">SN</a>
                    <a href="#" data-theme="f" data-role="button" onclick="ChooseScanType(2)">客户SN</a>
                    <a href="#" data-theme="f" data-role="button" onclick="ChooseScanType(3)">卡通箱</a>
                    <a href="#" data-theme="f" data-role="button" onclick="ChooseScanType(4)">栈板</a>
                </div>
            </div>
        </div>
    </form>
    <script src="js/jqPaginator.js"></script>
    <script type="text/javascript">
        var requestOrder = 0; //领料单号
        var itemStr = ""; //存储领料单对应的ItemId
        var grnStr = ""; //存储扫描的Grn
        var itemAllQty = 0; //领料单总数量
        var requtestQty = 0;   //备料数量
        var flage = 0; //为true可取消先进先出推荐
        var requestId = 0;
        var selItemId = "";
        var ScanType = 3;
        var ItemList = [];
        $(function () {
            UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>";
            var mark = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckUserIsWarrantted(UserId).value;

            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#listno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
            $("#listno").focus();
            $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });

            //扫描领料单
            $('#listno').on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    showMsg("");
                    if ($.trim($(this).val()) == "") {
                        $("#msg").html("领料单不能为空！").css("color", "red");
                        $(this).val('').focus();
                        return false;
                    }
                    $("#preparetab tbody").html('');
                    requestOrder = $.trim($(this).val());
                    SetApplyNo(requestOrder, 1);
                }
            });
            /*扫描物料条码*/
            $("#txtGRN").on("keydown", function (e) {
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
                var $ul = $(this);
                value = $.trim($("input[data-type='search']:eq(0)").val());

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetListStatuePlus(value);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
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
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' title=\"" + entity[i].ApplyNo + "\"><a onclick='SetApplyNo(\"" + entity[i].ApplyNo + "\",2)' style='font-size:80%;'>" + entity[i].ApplyNo + "</a></li>";
                    }
                }
                $("#listviews").html(ulhtml);
                $("#listviews").listview("refresh");
            });

            //根据字符串模糊查询采购单
            $("#listviews").on("filterablebeforefilter", function (e, data) {
                return false;
                var $ul = $(this)
                $input = $(data.input)
                value = $input.val()
                $("#listviews").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetListStatue();
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
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
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetApplyNo(\"" + entity[i].ApplyNo + "\",2)'>" + entity[i].ApplyNo + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            });

        });

        function SetApplyNo(applyNo, type) {
            showMsg("");
            requestOrder = $.trim(applyNo);
            //requestOrder = $(Code).html();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetWorkOrderInfo(requestOrder);
            if (ajax.error != null) {
                confirmDialogFocus(ajax.error, function () {
                    $(this).val('').focus();
                });
            }


            $("#workorderlist").html('');
            $("#worklist").html('');
            var result = ajax.value;
            if (result.length < 1) {
                $("#msg").html("领料单查询错误，请检查是否已经完成备料！").css("color", "red");
                return false;
            }
            if (result.length == 1) {
                $("#workorderlist").append("<option value='" + result[0].MOCode + "'>" + result[0].MOCode + "</option>");
                $("#workorderlist").prop("selected", "selected");
                var orderNo = $("#workorderlist").find(":selected").val();
                setPickingList(orderNo);
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
            if (type == 2) {
                $("input[data-type='search']").val('');
                $("#listviews").html('');
                $("#fpanel").panel("close");
                $("#listno").val(applyNo);
            }
        }

        //选择工单弹窗
        function bind(data) {
            $("#myPopup").popup("close");
            $("#workorderlist option[value='" + $(data).attr('id') + "']").prop("selected", "selected");
            $("#workorderlist").selectmenu('refresh', true);
            var orderNo = $("#workorderlist").find(":selected").val();
            setPickingList(orderNo);
        };
        //选择工单下拉
        $("#workorderlist").on("change", function () {
            //工单号
            var orderNo = $(this).find(":selected").val();
            setPickingList(orderNo);
        });
        //扫描GRN
        function SendMaterial() {
            $("#msg").html("");
            if ($.trim($("#txtGRN").val()) == "") {
                $("#msg").html("物料条码不能为空!");
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (requestOrder == 0) {
                $("#msg").html("请先选择对应的领料单!");
                $("#msg").css("color", "red");
                $("#txtReuestOrder").focus();
                $("#txtReuestOrder").select();
                return false;
            }
            var grn = $.trim($("#txtGRN").val());


            // var scanType = $("input[type='radio']:checked").val();
            //校验GRN
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckCPrepareBySN(ScanType, grn);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var data = ajax.value;
            //条码是否匹配领料单
            if ($.inArray(data[0].ItemId, ItemList) == -1) {
                confirmDialogFocus("条码不在领料单中");
                return false;
            }
            for (var i = 0; i < data.length; i++) {
                if (grnStr.indexOf(data[i].GRN) >= 0) {
                    $("#msg").html("该条码已经扫描完成，不能重复扫描!");
                    $("#msg").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
            }
            var SNQty = 0;//扫描的条码总数
            for (var i = 0; i < data.length; i++) {
                if (grnStr == "") {
                    grnStr += data[i].GRN;
                } else {
                    grnStr += ',' + data[i].GRN;
                }
                SNQty += parseFloat(data[i].BalanceQty);
            }
            var hasqty = parseInt($("#td" + data[0].ItemId).html());
            var needqty = parseInt($("#qty" + data[0].ItemId).html());
           //if ((hasqty + data.length) > needqty)
            if ((hasqty + SNQty) > needqty)
            {
                $("#msg").html("扫描数量不能大于需求数量!");
                $("#msg").css("color", "red");
                $("#txtGRN").val();
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            //$("#td" + data[0].ItemId).html(parseInt($("#td" + data[0].ItemId).html()) + data.length);
            $("#td" + data[0].ItemId).html(parseInt($("#td" + data[0].ItemId).html()) + SNQty);
            var $tr = $("#td" + data[0].ItemId).parent().parent();
            $tr.fadeOut(500).fadeIn(500).css("background-color", "#7CFC00");
            $("#tblRecHistory tbody:gt(0)").prepend($tr);//置顶
            $("#txtGRN").val("").focus();
        }

        //根据投料单获取物料信息
        function setPickingList(forNumber) {
            //清空数据
            //$("#listno").val('');
            //$("#orderlist").val('');
            $("#iframeGrnList").attr("src", "");
            $("#preparetab tbody").html('');
            $("#GRNinfotab tbody").html('');
            $("#msg").html('');

            itemStr = ""; //存储领料单对应的ItemId
            grnStr = ""; //存储扫描的Grn
            itemAllQty = 0; //领料单总申请数量
            requtestQty = 0;   //本次备料数量

            //var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyDtlLists($.trim(forNumber), n);
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
            ItemList = [];
            for (var i = 0; i < list.length; i++) {
                requestId = list[0].ApplyId;
                itemStr += list[i].ItemId + ',';
                itemAllQty += list[i].ApplyQty; //领料单申请数量
                htmlstr += "<td>" + list[i].ItemCode + "(" + list[i].ItemName + ")" + "</td>";

                htmlstr += "<td><span id='td" + list[i].ItemId + "' class='sqty'>" + list[i].StockQty + "</span>/";
                htmlstr += "<span id='qty" + list[i].ItemId + "' class='aqty'>" + list[i].ApplyQty + "</span>";
                htmlstr += "</td>";
                htmlstr += "</tr>";
                ItemList.push(list[i].ItemId);
            }
            $("#preparetab tr:gt(0)").remove();
            $("#preparetab tbody").append(htmlstr);
            $("#preparetab").table("refresh");
            $("#txtGRN").focus();
            return true;
        }
        //选择扫描方式 
        function ChooseScanType(data) {
            var htmls = "";
            ScanType = data;
            switch (data) {
                case 1:
                    htmls = "SN";
                    break;
                case 2:
                    htmls = "客户SN";
                    break;
                case 3:
                    htmls = "卡通箱";
                    break;
                case 4:
                    htmls = "栈板";
                    break;
                case 5:
                    htmls = "检验批次号";
                    break;
            }
            $("#ScanType").html(htmls);
            $("#myPopupType").popup("close");
            setTimeout('$("#prodid").val("").focus()', 100);
        }
        var itemId = -1; //获取选中的ItemId
        var whList = [];
        function Save() {
            /*选择的是线别仓还是产线*/
            var selLocation = $("#selLocation").val();
            var locDesc = $("#selLocation").find("option:selected").text();

            if (requestOrder == 0) {
                confirmDialogFocus("请选择领料单!");
                return false;
            }
            //if (parseFloat(itemAllQty) == "0") {
            //    confirmDialogFocus("申请数量为0,不能备料!");
            //    return false;
            //}
            //if (parseFloat(requtestQty) == "0") {
            //    confirmDialogFocus("备料数量为0,不能备料!");
            //    return false;
            //}
            if (grnStr.length <= 0) {
                confirmDialogFocus("备料数量为0,不能备料!");
                return false;
            }
            if (confirm('是否确定该领料单备料?')) {
                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

                //校验数据是否重复
                var isCF = false;
                $("#preparetab tbody tr").each(function () {

                    var hasqty =0;
                    var needqty =0;
                    if ($(this).find(".sqty").html() != undefined)
                        hasqty = parseInt($(this).find(".sqty").html());
                    if ($(this).find(".aqty").html() != undefined)
                        needqty = parseInt($(this).find(".aqty").html());

                    if (hasqty != 0 && needqty != 0){
                        if (hasqty> needqty) {
                            isCF = true;
                        }
                    }
                   
                });
                if (isCF) {
                    $("#msg").html("备料数据中存在扫描数量大于需求数量!");
                    $("#msg").css("color", "red");
                    $("#txtGRN").val();
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }

                var materialStorageNo = ""; //备料单号
                var ajaxNo = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetMaterialStorageNo(-10);
                if (ajaxNo.error != null) {
                    confirmDialogFocus(ajaxNo.error.Message);
                    return;
                } else {
                    if (ajaxNo.value == "") {
                        confirmDialogFocus("备料单号获取失败");
                        return;
                    }
                    materialStorageNo = ajaxNo.value;
                }
                var entity = {};
                entity.RequestId = requestId;
                entity.userName = userName;
                entity.tbDtl = JSON.stringify(whList);

                var model = [];
                var arr = grnStr.split(",");
                for (var i = 0; i < arr.length; i++) {
                    var arrVal = {};
                    arrVal.VAL = arr[i];
                    model.push(arrVal);
                }

                //requestId:领料申请单ID,selLocation:线别仓还是产线,grnStr:GRN集合,entity 无GRN项 备料列表
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SavePrepareBySN(requestId, JSON.stringify(model), userName);
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message);
                    return false;
                }
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveMaterialPrepare(materialStorageNo, requestId, selLocation, locDesc, grnStr, userName, JSON.stringify(entity));
                //if (ajax.error != null) {
                //    confirmDialogFocus(ajax.error.Message);
                //    return false;
                //}
                else {
                    /*清空数据*/
                    if ($("#tblRecHistory tr").length > 1) {
                        $("#tblRecHistory tr:not(:first)").remove();
                    }
                    confirmDialogFocus("备料成功!");

                    clearWaitGrnTable();
                    $("#txtReuestOrder").val("");
                    $("#woNo").html("");

                    requestOrder = 0;
                    var str = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='7' style='text-align:center;'>暂无数据</td></tr>";
                    $(str).appendTo($("#tblRecHistory"));
                }
            }
        }
        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
            }
            $("#msg").html("");
            $("#preparetab tbody").html("");
            ItemList = [];
            $("#listno").val("");
            $("#txtGRN").val("");
            itemStr = ""; //存储领料单对应的ItemId
            grnStr = ""; //存储扫描的Grn
            itemAllQty = 0; //领料单总申请数量
            requtestQty = 0;   //本次备料数量
        }

        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }

    </script>
</body>
</html>
