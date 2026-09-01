<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InStock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.InStock" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/jquery.mobile.datepicker.css">
    <link rel="stylesheet" href="css/jquery.mobile.datepicker.theme.css">
    <link rel="Stylesheet" href="css/bootstrap.min.css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>物料入库</title>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }

        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }

        .ui-title { line-height: 30px; }

        a.link-disable { background-color: #c3c3c3; border-color: #999; }

        #slider2 { display: none; }
        .button-label { position: relative; display: inline-block; width: 80px; height: 25px; background-color: #ccc; box-shadow: #ccc 0px 0px 0px 2px; border-radius: 30px; overflow: hidden; }
        .circle { position: absolute; top: 0; left: 0; width: 30px; height: 25px; border-radius: 50%; background-color: #fff; }
        .button-label .text { line-height: 25px; font-size: 13px; text-shadow: 0 0 2px #ddd; }
        .on { color: #fff; display: none; text-indent: 10px; }
        .off { color: #fff; display: inline-block; text-indent: 50px; }
        .button-label .circle { left: 0; transition: all 0.3s; }
        #slider2:checked + label.button-label .circle { left: 50px; }
        #slider2:checked + label.button-label .on { display: inline-block; }
        #slider2:checked + label.button-label .off { display: none; }
        #slider2:checked + label.button-label { background-color: #51ccee; }
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false;">
        <sdpui>
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           <div data-role="header" data-position="fixed">
                <h5 style="padding: 3px; margin: 0px;">
                    <%--      <div>
                        <img src="images/icon/inwh_white.png" />
                        <img style="width: 60px; height: 50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAA7pmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDMtMjRUMTk6MDk6NDkrMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0wNFQxNjo1NzozMSswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTctMDUtMDRUMTY6NTc6MzErMDg6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6NDlmZDM4NmQtMzU0Yy1kZDQxLWI5ZWQtYjFlYmJhMmI5YTZhPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6YjEyNGM0NzctMzBhNy0xMWU3LTljNzYtYTEwMDEzNzhhMzYzPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6MjY4YzMxNzUtYjRhNC1mMDRiLWFiNGItMjQ3NTJhMDRhZjJmPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOjI2OGMzMTc1LWI0YTQtZjA0Yi1hYjRiLTI0NzUyYTA0YWYyZjwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wMy0yNFQxOTowOTo0OSswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDo0YTIxNTE3Ny00ZjQ3LTY5NDYtOTVkNS02NjlhOGMwMWY5NjY8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDMtMjdUMDg6NDU6NDYrMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6NDlmZDM4NmQtMzU0Yy1kZDQxLWI5ZWQtYjFlYmJhMmI5YTZhPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE3LTA1LTA0VDE2OjU3OjMxKzA4OjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjY0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz6mFtciAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAJ9SURBVHja7NvRTdxAEIDhfyuAVJBcB/CUx5AKQmggh3jKU0gFOQqIgCekSAjTQEIqgA5IKoCr4JwKJg9Zo82y9tm7a7Dlmac7I915vrNnZtfCiAhTDqMACqAACqAAzxPHwK59XQBHUwNYAZv29T0wmxqA/8VGARRAARRAARRgmADHwNzp252/JxIg9tcpgVNgkQNg0w4tSdBPDFDFC4uRBDAHLkYKsG/H7CSAW2BrpAC/gO0UgFfAnXdsaY8PsQjeAy+9YzN7PArgBPjUQ/J9dgEf4RQ4jAVYeZX/qE1lfWaABfDFA5nFAOwCP7pcTgMBCN2274GrrgBXwDvn/U9nA2Pog9AN8KbNudcBhHr/2pYyIIBQ6w7OBHUAh3b6q+JP5BTYtO3VBJBju6wENpz3n21RbwVw51X7S6vaNfwiWtgr6SLweXV/ayxiDVEAH9bNBCGALTv8uLFtPyD1V6hObN5w0vNMc0erPEIAvtzvhEnQb0kxkdJ6/Zng0ZUcAvAv2+C9k3ApdonYW6+ulpW2GNYCtK6eT4CQmnyrbuYDXAM7PfX+Lgg5km81z7gAnSaoHhFyJr92onUB/IKVc+HTFiF38nXd6KGwugB+729cRfWA0FfyoVXtw2xRAezY+9+PPhEWTsJFxlXmuuSreAvcGBF5DXxMaFWVaOzIGhPVqJxyi14CZ0ZEzoE94nd8U0fWmFhlON8S+G5EJMeH9bGi67KSjEYwkvfJyNgAUADJ/2zMjCX5vgBGFQqgAArwH4CZSN6iAAqgAAqgAAqgADoIKYCIlDx+gDmVWBoR+QocTBBhCXyrtsVP+LdFvTGh5Atgof81pgAKoACTBvg7AJgqdJy41wqpAAAAAElFTkSuQmCC" />
                    </div>
                    <div>
                        物料入库
                    </div>--%>

                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">物料入库</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label>
                                全部入库</label>
                        </td>
                        <td colspan="3">
                            <%--data-role="slider"--%>
                          <%--  <label for="slider2" class="ui-hidden-accessible">开关</label>
                            <select name="slider2" id="slider2" data-role="flipswitch">
                                <option value="off">关</option>
                                <option value="on">开</option>
                            </select>--%>

                            <!-- 注意：label的for属性 要与其对应的input的id相对应，div包裹的内容需一行显示！-->
                            <div class="slider2-wrapper" data-role="none"><input type="checkbox" id="slider2" name="switch" data-role="none"><label for="slider2" class="button-label" data-role="none"><span class="circle" data-role="none"></span><span class="text off" data-role="none">关</span><span class="text on" data-role="none">开</span></label></div>

                            <%--<select name="slider2" id="slider2" data-mini="true">
                                <option value="off">关</option>
                                <option value="on">开</option>
                            </select>--%>
                        </td>
                    </tr>                    
                    <tr>
                        <td>
                            <label for="station" class="tip-cbarcode">
                                库位</label>
                        </td>
                        <td colspan="3">
                            <input class="station" id="station" data-corners="false" type="text" data-mini="true" androidScan="true"
                                value="" />
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label for="material">
                                GRN/箱号</label>
                        </td>
                        <td colspan="3">
                            <input class="material" id="material" data-corners="false" type="text" data-mini="true" androidScan="true"
                                value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%--<label for="orderno">
                                IQC/采购单号:</label>--%>
                            <label>IQC/采购单</label>
                        </td>
                        <td colspan="3">
                            <span id="orderno"></span><span id="split-char"></span><span id="po-code"></span>
                        </td>
                        <%--<td colspan="2">
                            <input class="orderno" id="orderno" data-corners="false" type="text" data-mini="true"
                                value="" />
                        </td>
                        <td>
                            <a href="#fpanel" id="selectBill" data-rel="popup" data-mini="true" data-position-to="window" data-role="button">选择单据</a>
                        </td>--%>
                    </tr>
                </table>
                <div id="msg" style="width: 100%; text-align: center;">
                </div>
                <div id="testtab" style="margin-top: 3px; position: relative">
                    <table data-role="table" id="instocktable" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>物料编码
                                </th>
                                <th>物料名称
                                </th>
                                <th>入库量
                                </th>
                                <th>操作
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
                 <div data-role="popup" id="popupGrnLog">
                    <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">关闭</a>
                    <table data-role="table" id="Table1" data-mode="columntoggle" class="ui-responsive table-stroke">
                        <thead style="background-color:#2FC1FF">
                            <tr>
                                <th>序号
                                </th>
                                <th>GRN
                                </th>
                                <th style="min-width:40px">数量
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
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a data-corners="false" id="Save" data-role="button" data-fullscreen="true" data-theme="a">物料条码入库</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">

                <div data-role="main" data-theme="a" class="ui-content">
                    <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入采购单、IQC单 "
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>
    
    <script type="text/javascript" src="js/jqPaginator.js"></script>
    <script type="text/javascript" src="js/jquery.nicescroll.js"></script>
    <sdpscript>
    <script type="text/javascript">
        var List =[];//IQC单下 GRN信息
        var InsId;
        var StorageQty = 0;
        var InspectionIQC = []; //记录数据 IQC单信息
        var rowCount = 0;
        var pageSize = 4; //最大显示行数
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        //var GRNStrWithBarCode = ""; //批量保存GRN，一个GRN与对应库位用逗号隔开组成一组,各组之前用‘|’隔开
        $(document).ready(function () {
            $(".ui-body-c").css("background", "#fff");
            $("body>[data-role='listview']").listview();
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            //聚焦 失焦事件
            $("#station").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
            $("#material").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });

            //检验单号不能为空
            InsId = $("input[name='favcolor']:checked").attr("value");
            $("#jyorder").val($("input[name='favcolor']:checked").attr("id"));

            //是否全部入库
            $("#slider2").on("change", function (e) {
                var checked = $(this).prop("checked");

                if (confirm("是否切换入库模式，会清除所有数据")) {
                    $("#orderno").text("");
                    $("#split-char").text("");
                    $("#po-code").text("");
                    $("#station").val("");
                    $("#material").val("");
                    $("#instocktable tbody").html("");
                    $("#Table1 tbody").html("");
                    $("msg").html("");
                    List = [];
                    StorageQty = 0;
                    if (checked) {
                        $("#selectBill").attr({ "style": "background-color: #c3c3c3;border-color: #999;", "href": "#" });
                    } else {
                        $("material").focus();
                        $("#selectBill").attr("style", "").attr("href", "#fpanel");
                    }
                } else {
                    if (checked) {
                        $(this).prop("checked", false);
                    } else {
                        $(this).prop("checked", true);
                    }
                }
                $("#station").focus();
                return false;
            });


            //单据扫描事件
            //$("#orderno").on("keydown", function (e) {
            //    var curKey = 0, e = e || window.event;
            //    curKey = e.keyCode || e.which || e.charCode;
            //    if (curKey == 13) {
            //        $("#msg").html('');
            //        $("#station").html('');
            //        $("#material").html('');
            //        if (Select(0)) {
            //            $("#station").focus();
            //        }
            //        else {
            //            $("#orderno").focus();
            //        }
            //    }
            //});

            //库位扫描事件绑定
            $("#station").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html('');
                    changeBarCode();
                    $("#material").focus();
                }
            });
            //物料扫描事件绑定
            $("#material").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var putOnShelf = 1;                             //是否直接入库位
                    var grn = $.trim($("#material").val());         //GRN
                    var posCode =  $.trim($("#station").val());     //库位条码
                    var iqcNo = $.trim($("#orderno").text());       //IQC单号

                    //包装判断
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IsPack(grn);
                    if (ajax.value != "" && ajax.value != null) {
                        if (!window.confirm("该物料【" + grn + "】已存在包装【" + ajax.value + "】，是否解除包装!")) {
                            return "";
                        }
                    }

                    //全部入库模式
                    if ($("#slider2").prop("checked")) {
                        showMsg("", 1);
                        $("#Table1 tbody").html("");
                        //扫描sn带出IQC信息 直接入库
                        if (posCode == "") {
                            showMsg($("label.tip-cbarcode").text() + "不能为空", 0);
                            $("#material").val("").focus();
                            return false;
                        }
                        if (grn == "") {
                            showMsg("GRN不能为空", 0);
                            $("#material").val("").focus();
                            return false;
                        }
                        
                        var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SelectByGRN(grn);
                        if (data.error != null) {
                            $("#msg").html(data.error.Message).css("color", "red");
                            $("#material").val("").focus();
                            return false;
                        }
                        //校验货位产品唯一
                        if (!verifyProductOnly(putOnShelf, grn, "", posCode)) return false;
                        
                        //检验单
                        var entity1 = $.parseJSON(data.value);
                        rowCount = entity1[0].rowCount; //获取总条数
                        entity1.shift(); //删除总条数信息(第一条)
                        if (entity1.length <= 0) {
                            $("#msg").html("GRN对应单据状态不能进行入库操作");
                            return false;
                        }
                        var IQCId = entity1[0].InspectionId;
                        var IQCNo = entity1[0].InspectionNo;
                        var poCode = entity1[0].POCode;
                        var itemCode = entity1[0].ItemCode;
                        $("#orderno").text(IQCNo);
                        $("#split-char").text("/");
                        $("#po-code").text(poCode);
                        
                        //物料
                        AddItemRow(entity1, true);
                        //GRN
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIQCScanGRNInfo(IQCId, "", 1);
                        if (ajax.error != null) {
                            showMsg(ajax.error.Message);
                            $("#material").val("").focus();
                            return false;
                        }
                        var en = $.parseJSON(ajax.value);
                        List = new Array(1);
                        for (var i = 0; i < entity1.length; i++) {
                            List[i] = new Array();
                        }
                        e = {};
                        e.InspectionId = IQCId;
                        e.InspectionNo = IQCNo;
                        e.CBarCode = posCode;
                        e.StorageQty = entity1[0].StorageQty;
                        e.OldStorageQty = entity1[0].StorageQty;
                        e.ItemCode = itemCode;
                        InspectionIQC = []
                        InspectionIQC.push(e);
                        var hl = "";
                        for (var i = 0; i < en.data.length; i++) {
                            var en1 = {};
                            en1.GRN = en.data[i].GRN;
                            en1.StorageQty = en.data[i].StorageQty;
                            en1.BarCode = "";
                            List[0].push(en1);
                        }
                        
                    } else {//正常模式
                        if (posCode == "") {
                            showMsg($("label.tip-cbarcode").text() + "不能为空", 0);
                            $("#station").val("").focus();
                            return false;
                        }
                        if (grn == "") {
                            showMsg("GRN不能为空", 0);
                            $("#material").val("").focus();
                            return false;
                        }
                        
                        //GRN校验
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IsGRN(iqcNo, grn, posCode, putOnShelf);
                        if (ajax.error != null) {
                            $("#msg").html(ajax.error.Message).css("color", "red");
                            if (ajax.error.Message.indexOf(($("label.tip-cbarcode").text() + "[" + posCode + "]")) >= 0) {
                                $("#station").val("").focus();
                            } else {
                                $("#material").val("").focus();
                            }
                            return false;
                        }
                        //判断条码是否已扫描
                        var data = ajax.value;
                        for (var i = 0; i < List.length; i++) {
                            for (var j = 0; j < List[i].length; j++) {
                                for (var k = 0; k < data.length; k++) {
                                    if (data[k].GRN == List[i][j].GRN) {
                                        showMsg("该条码" + grn + "已扫描", 0);
                                        $("#material").val("").focus();
                                        return false;
                                    }
                                }
                            }
                        }
                        //校验货位产品唯一
                        if (!verifyProductOnly(putOnShelf, grn, "", posCode)) return false;
                        //检验单
                        if (iqcNo == "") {
                            $("#orderno").text(data[0].InspectionNo);
                            $("#split-char").text("/");
                            $("#po-code").text(data[0].POrder);
                            if (!Select(grn)) {
                                return false;
                            }
                        }
                        //GRN
                        var mark = true;
                        var displayqty = 0;//GRN数量 、包装箱数量
                        var grnArr = [];
                        for (var j = 0; j < data.length; j++) {
                            displayqty = displayqty.add(data[j].StorageQty);
                            for (var i = 0; i < InspectionIQC.length; i++) {
                                if (InspectionIQC[i].InspectionNo == data[j].InspectionNo) {
                                    InspectionIQC[i].CBarCode = posCode;
                                    InspectionIQC[i].StorageQty = InspectionIQC[i].StorageQty.add(parseFloat(data[j].StorageQty));
                                    var en = {};
                                    en.GRN = data[j].GRN;
                                    en.StorageQty = data[j].StorageQty;
                                    en.BarCode = "";
                                    List[i].push(en);
                                    mark = false;
                                    grnArr.push(data[j].GRN);

                                }
                            }
                        }
                        if (mark) {
                            $("#msg").html("GRN不属于该单据！").css("color", "red");
                            $("#material").val("").focus();
                            return false;
                        }
                        var $tr = $('#' + ajax.value[0].ItemId).parent();
                        var a = parseFloat($tr.find("span").html());//入库数量
                        var b = parseFloat(displayqty);//GRN数量
                        //$tr.find("span:eq(0)").html(a + b); //入库数量 
                        $tr.find("span:eq(0)").html(a.add(b)); //入库数量
                        $("#instocktable tbody tr").removeAttr("style");//移除高亮
                        $tr.fadeOut(300).fadeIn(300);//闪动一次
                        $("#instocktable").prepend($tr);
                        $tr.css("background-color", "#7FFF00");
                        $("#instocktable").table("refresh");
                        $(document).scrollTop(200);
                    }
                    //扫描成功
                    $("#msg").html('');
                    $("#material").val("").focus();
                }
            });
            //清理按钮
            $("#cleanbut").on("click", function () {
                $("#station").val("");
                $("#material").val("");
                $("#Table1 tbody").html("");
                List = [];
                StorageQty = 0;
            });
            $("#Save").on("click", function () { Save(); });
            //$("#btnFilter").on("click", function () {
            //    $("#listviews").html("");
            //    var value = $.trim($("input[data-type='search']:eq(0)").val());
            //    var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.Select(value, 0);
            //    if (data.error != null) {
            //        $("#msg").html(data.error.Message).css("color", "red");
            //        return false;
            //    }
            //    var Count = 0;//只显示20条
            //    var ulhtml = "";
            //    entity = $.parseJSON(data.value);
            //    rowCount = entity[0].rowCount; //获取总条数
            //    entity.shift(); //删除总条数信息(第一条)
            //    for (var i = 0; i < entity.length; i++) {
            //        if (ulhtml.indexOf(entity[i].POCode) == -1 && entity[i].POCode.indexOf(value) != -1) {
            //            ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].POCode + "</a></li>";
            //            Count = Count + 1;
            //        }
            //    }
            //    for (var i = 0; i < entity.length; i++) {
            //        if (Count >= 20) {
            //            break;
            //        }
            //        if (ulhtml.indexOf(entity[i].InspectionNo) == -1 && entity[i].InspectionNo.indexOf(value) != -1) {
            //            ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].InspectionNo + "</a></li>";
            //            Count = Count + 1;
            //        }
            //    }
            //    $("#listviews").append(ulhtml);
            //    $("#listviews").listview("refresh");
            //});
            //根据字符串模糊查询采购单
            $("#listviews").on("filterablebeforefilter", function (e, data) {
                //var $ul = $(this)
                //$input = $(data.input)
                //value = $input.val();

                //if (value && value.length > 2) {
                //    $("#listviews").html("");
                //    var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.Select(value, 0);
                //    if (data.error != null) {
                //        $("#msg").html(data.error.Message).css("color", "red");
                //        return false;
                //    }
                //    var ulhtml = "";
                //    entity = $.parseJSON(data.value);
                //    rowCount = entity[0].rowCount; //获取总条数
                //    entity.shift(); //删除总条数信息(第一条)
                //    for (var i = 0; i < entity.length; i++) {
                //        if (ulhtml.indexOf(entity[i].POCode) == -1) {
                //            ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].POCode + "</a></li>";
                //        }
                //    }
                //    for (var i = 0; i < entity.length; i++) {
                //        if (ulhtml.indexOf(entity[i].InspectionNo) == -1) {
                //            ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].InspectionNo + "</a></li>";
                //        }
                //    }
                //    $("#listviews").append(ulhtml);
                //    $("#listviews").listview("refresh");
                //}
                //$("#listviews").trigger("updatelayout");
            });
        });
        function SetPOCode(code) {
            $("#orderno").val($(code).html());
            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#fpanel").panel("close");
            Select(0);
            $("#station").focus();


        };
        //单据信息查询
        function Select(grn) {
            var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SelectByGRN(grn);
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            var list = $.parseJSON(data.value);
            rowCount = list[0].rowCount; //获取总条数
            list.shift();
            e = {};
            e.InspectionId = list[0].InspectionId;
            e.InspectionNo = list[0].InspectionNo;
            e.CBarCode = $.trim($("").val());
            e.StorageQty = list[0].StorageQty;
            e.OldStorageQty = list[0].StorageQty;
            e.ItemCode = list[0].ItemCode;
            InspectionIQC = [];
            InspectionIQC.push(e); 
            //
            var htmlstr = "<tr>";
            if (InspectionIQC.length == 0) {
                $("#msg").html("单据不包含可入库信息").css("color", "red");
               
                return false;
            }
            AddItemRow(list, true);
            //checkbox 单选
            $("input[name='favcolor']").on("click", function () {
                $("input[name='favcolor']").prop("checked", false);
                $(this).prop("checked", "checked").checkboxradio("refresh");
            });
            //清理GRN信息
            $("#Table1 tbody").html("");
            List = new Array();
            for (var i = 0; i < InspectionIQC.length; i++) {
                List[i] = new Array();
            }
            StorageQty = 0;
            return true;
        }
        //验证库位
        function changeBarCode() {
            //验证库位
            $.post("../Handler/InStock.ashx?api=GetBarCode", { "station": $.trim($("#station").val()) }, function (ajax) {
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message, function () {
                        $("#station").val('').focus();
                    });
                    return false;
                }
                var en = $.parseJSON(ajax);
                if (!en.BarCode) {
                    $("#station").val("");
                    $("#msg").html("库位不存在!").css("color", "red");
                    $("#station").focus();
                    return false;
                }
                else {
                    $("#msg").html("库位扫描成功").css("color", "#2ecc71");
                    $("#material").focus();
                    return true;
                }
            });
        }

        function Save() {
            if ($.trim($("#orderno").text()) == "") {
                $("#msg").html("未获取到IQC检验单信息").css("color", "red");
                return false;
            }
            if ($.trim($("#station").val()) == "") {
                $("#msg").html("请扫描库位").css("color", "red");
                return false;
            }
            if (List.length == 0 || List[0].length == 0) {
                $("#msg").html("请扫描GRN！").css("color", "red");
                return false;
            }
            //校验货位产品唯一
            for (var j = 0; j < InspectionIQC.length; j++) {
                var itemCode = InspectionIQC[j].ItemCode;
                var cBarCode = $.trim($("#station").val());
                if (!verifyProductOnly(1, "", itemCode, cBarCode)) return false;
            }

            for (var l = 0; l < List.length; l++) {
                var CBarCode = InspectionIQC[l].CBarCode = null ? "" : InspectionIQC[l].CBarCode;
                for (var s = 0; s < List[l].length; s++) {
                    List[l][s].BarCode = CBarCode;
                }
            }
            $(".ui-footer").hide();

            setTimeout(execProc, 100);
        }

        Cleans = function () {
            $("#station").val('').focus();
        }

        function execProc() {
            var re = /^[0-9]*[0-9][0-9]*$/;
            for (var j = 0; j < InspectionIQC.length; j++) {

                var entity1 = {};
                var Sum = 0;//IQC检验单扫描数量（GRN累加得出） 
                for (var q = 0; q < List[j].length; q++) {
                    Sum = Sum.add(parseFloat(List[j][q].StorageQty));
                }
              
                if (re.test(List[j][0].StorageQty)) {
                    List[j][0].StorageQty = List[j][0].StorageQty.toFixed(6);
                }
                entity1.InspectionId = InspectionIQC[j].InspectionId;
                entity1.StorageQty = Sum;
                entity1.tbDtl = JSON.stringify(List[j]);
                entity1.PutOnShelf = 1;
                entity1.CreateBy = userName;
                //如果这个IQC单没有GRN不进行入库操作
                if (entity1.tbDtl == "" || entity1.tbDtl == null) {
                    continue;
                }

               
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspPDASaveIQCGRNStorage", JSON.stringify(entity1));
                //if (ajax.error != null) {
                //    showMsg(ajax.error.Message,0);
                //    $(".ui-footer").show();
                //    return false;
                //}
                //else {
                //    $(".ui-footer").show();
                //}
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.PDASaveIQCGRNStorage(entity1);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $(".ui-footer").show();
                    return false;
                }
                else {
                    $(".ui-footer").show();
                    //if (ajax.value) {
                    //    erpNo += "ERP入库单号：" + ajax.value;
                    //}
                }
            }
            $(".ui-footer").show();

            $("#msg").html("入库成功！").css("color", "#2ecc71");
            $("#station").val("").focus();
            $("#material").val("");
            $("#Table1 tbody").html("");
            $("#instocktable tbody").html("");
            $("#orderno").text("");
            $("#split-char").text("");
            $("#po-code").text("");
            List = [];
            InspectionIQC = [];//wenshun 2018-02-07 BUG:第二次入库没有反应. 原因:entity是集合,这里赋值错误
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        }

        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }

        //浮点型加法运算（js浮点型运算精确有误）
        Number.prototype.add = function (val) {
            var len = getPointLen(this, val);
            return ((this * len) + (val * len)) / len;
        }

        //浮点型减法运算（js浮点型运算精确有误）
        Number.prototype.subtract = function (val) {
            var len = getPointLen(this, val);
            return ((this * len) - (val * len)) / len;
        }

        //获取小数点最大长度
        function getPointLen(val1, val2) {
            var len1, len2;
            try {
                len1 = val1.toString().split(".")[1].length;
            } catch (e) {
                len1 = 0;
            }
            try {
                len2 = val2.toString().split(".")[1].length;
            } catch (e) {
                len2 = 0;
            }
            return Math.pow(10, Math.max(len1, len2));
        }

        
        //校验货位产品唯一
        function verifyProductOnly(isputon, grn, itemCode, cBarCode) {
            if (isputon == 1) {
                var result = isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
                if (result == -1) {
                    return false;
                }
                if (result == 0) {
                    showMsg("当前库位不支持存放多种产品，请扫描其他库位！");
                    setTimeout(function () {
                        $("#station").val("").focus();
                    }, 100);
                    return false;
                }
            }
            return true;
        }

        //判断产品是否能放入当前库位
        function isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                return -1;
            }
            return ajax.value ? 1 : 0;
        }

        //显示GRN扫描记录表
        function showGrnList(el) {
            var $tr = $(el).closest("tr");
            var inspectionNo = $tr.attr("InspectionNo");
            //获取扫描的物料GRN
            var listGRN = [];
            for (var i = 0; i < InspectionIQC.length; i++) {
                if (InspectionIQC[i].InspectionNo == inspectionNo) {
                    listGRN = List[i];
                }
            }
            var htmlstr = "";
            if (listGRN.length == 0) {
                htmlstr += '<tr class="ListTableOddRow"><td colspan="10" style="text-align: center;">暂无数据</td></tr>';
            }
            else {
                for (var i = 0; i < listGRN.length; i++) {
                    htmlstr += "<tr>";
                    htmlstr += "<td>" + (i + 1) + "</td>";
                    htmlstr += "<td>" + listGRN[i].GRN + "</td>";
                    htmlstr += "<td>" + parseFloat(listGRN[i].StorageQty) + "</td>";
                    htmlstr += "</tr>";
                }
            }
            $("#Table1 tbody").html("");
            $("#Table1 tbody").append(htmlstr);
        }
        //移除当前物料
        function deleteItem(el) {
            var $tr = $(el).closest("tr");
            var inspectionNo = $tr.attr("InspectionNo");
            var qty = 0;
            //移除物料对应的条码
            for (var i = 0; i < InspectionIQC.length; i++) {
                if (InspectionIQC[i].InspectionNo == inspectionNo) {
                    InspectionIQC[i].StorageQty = InspectionIQC[i].OldStorageQty;
                    List[i] = [];
                    qty = InspectionIQC[i].OldStorageQty;
                    break;
                }
            }
            //更新数量
            $tr.find("#qty").text(qty);
            $tr.fadeOut(300).fadeIn(300);//闪动一次
        }

        //新增物料行
        function AddItemRow(listItem, isReload) {
            isReload = isReload ? true : false;
            //是否重新加载
            if (isReload === true) {
                $("#instocktable tbody").html("");
            }
            var htmlstr = "";
            if (!listItem || listItem.length == 0) {    //无数据
                if (isReload === false) {
                    return;
                }
                htmlstr += '<tr class="ListTableOddRow"><td colspan="10" style="text-align: center;">暂无数据</td></tr>';
            }
            else {
                for (var i = 0; i < listItem.length; i++) {
                    htmlstr += "<tr ItemId='" + listItem[i].ItemId + "' InspectionNo='" + listItem[i].InspectionNo + "'>";
                    htmlstr += "<td id='" + listItem[i].ItemId + "'>" + listItem[i].ItemCode + "</td>";
                    htmlstr += "<td>" + listItem[i].ItemName + "</td>";
                    htmlstr += "<td><span  id='qty'>" + ($("#slider2").prop("checked") ? parseFloat(listItem[i].InspectionQty) : parseFloat(listItem[i].StorageQty)) + "</span>/<span>" + parseFloat(listItem[i].InspectionQty)
                        + "</span><span align='center'>&nbsp;<a href='#popupGrnLog' data-rel='popup' data-position-to='window' onclick='showGrnList(this)'>记录</a></span></td>";
                    htmlstr += "<td><a href='javascript:void(0);' onclick='deleteItem(this)'>删除</a></td>";
                    htmlstr += "</tr>";
                }
            }
            $("#instocktable tbody").append(htmlstr);
            $("#instocktable").table("refresh");
        }
    </script>
    </sdpscript>
    </sdpui>
    </form>
</body>
</html>
