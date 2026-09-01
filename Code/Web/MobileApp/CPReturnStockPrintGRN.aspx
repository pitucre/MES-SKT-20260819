<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="CPReturnStockPrintGRN.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.CPReturnStockPrintGRN" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js?v=2" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <title>成品退货条码打印</title>
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

        img {
            -webkit-filter: grayscale(100%);
            -moz-filter: grayscale(100%);
            -ms-filter: grayscale(100%);
            -o-filter: grayscale(100%);
            filter: grayscale(100%);
            filter: gray;
        }    
        .ui-title {
            line-height: 30px;            
        }
        div.ui-body-c { background-color: #fff; }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" id="pageone">
            <div data-role="header" data-position="fixed" >
                <h5 style="padding: 4px; margin: 0px;">
               <%--     <div>
                        <img src="images/icon/fljl_white.png"/>
                        <img style="width: 60px; height: 50px;" src="data:image/png;base64,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0p8zAAA6MGlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgICAgICAgICB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIgogICAgICAgICAgICB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iCiAgICAgICAgICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTctMDUtMjJUMTE6MzM6NDMrMDg6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1ldGFkYXRhRGF0ZT4yMDE3LTA1LTIyVDExOjMzOjQzKzA4OjAwPC94bXA6TWV0YWRhdGFEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNy0wNS0yMlQxMTozMzo0MyswODowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6YmVjYjQ1NGItM2FhNC1lZDRkLWE5NzItMzNmNTZhMTAzNzEzPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6NzQ5ZTczNjEtM2U5Zi0xMWU3LWJmYTAtZTgxNmFlMjJmOGRiPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6Y2VjMDcxNzUtZGY4MS02ZTQyLWI3NjAtOTZhM2ZhMDExZjA0PC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOmNlYzA3MTc1LWRmODEtNmU0Mi1iNzYwLTk2YTNmYTAxMWYwNDwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNy0wNS0yMlQxMTozMzo0MyswODowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpiZWNiNDU0Yi0zYWE0LWVkNGQtYTk3Mi0zM2Y1NmExMDM3MTM8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTctMDUtMjJUMTE6MzM6NDMrMDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL3BuZzwvZGM6Zm9ybWF0PgogICAgICAgICA8cGhvdG9zaG9wOkNvbG9yTW9kZT4zPC9waG90b3Nob3A6Q29sb3JNb2RlPgogICAgICAgICA8cGhvdG9zaG9wOklDQ1Byb2ZpbGU+c1JHQiBJRUM2MTk2Ni0yLjE8L3Bob3Rvc2hvcDpJQ0NQcm9maWxlPgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpYUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WFJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOllSZXNvbHV0aW9uPjcyMDAwMC8xMDAwMDwvdGlmZjpZUmVzb2x1dGlvbj4KICAgICAgICAgPHRpZmY6UmVzb2x1dGlvblVuaXQ+MjwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICAgICAgICAgPGV4aWY6Q29sb3JTcGFjZT4xPC9leGlmOkNvbG9yU3BhY2U+CiAgICAgICAgIDxleGlmOlBpeGVsWERpbWVuc2lvbj42NDwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj42NDwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo8P3hwYWNrZXQgZW5kPSJ3Ij8+rlwqFQAAACBjSFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAABy0lEQVR42uzbvUoDQRSG4XfjxhgFo2IpaKNYeAW2djbWXoJ3Jt6ApYqd4AVYCcGfRhRBTcjPrkU2IMtmM+OGJDP7nS6TKZZnz5wz2Z0EcRxjGPvAJVD5M/YDHAEvOBqhxdwasJMa6wJVHI6KxdwYiFJjnWS8FABehgAEYB5BxvwF1wFsukAEtFIILdeLYGCxD6gB2xmd4RHolQHAywiTzY1vxfA1WZ5GGfAMrHsGcAxcm2bAClD3DMC4O1WAvodLO7YBCClxhMCn4xua5WST9m+AQ4e7wCpwBWwWAXhy/O73iy4B01gCdlPpFgEPDB6MzCIWi6S/LcAecJ9aLt/AAdAsw4+hrPnOdxDb4heN+ew9gHchAAEIQAACEIAABCAAAQhAAAIQgAAEIAABCEAAAhCAAKyi5zJA0VdbAYNX0+0pX3cH+DK8vkbOjY6LAtSBG6b/iuwCOGP8UZjh9W2N+P5jEhmwNoPMbVhm6MaI76uuFkGbQxF5Napbhi6Qd4AisAGozFHbtDnXmPeXnqpNDXgHzucE4dZwXhs4YXC8J3MJ2AA0gVOH0ntYK+60ExSAAAQgAAEIwFuA8B/7g4k9D5h1xMDbiOcFRvE7AE3ORmRESGzsAAAAAElFTkSuQmCC" />
                    </div>
                    <div>
                        分料截料
                    </div>--%>
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">成品退货条码打印</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table width="100%">
                    <tr>
                        <td>
                            <label>退货单号</label>
                        </td>
                        <td>
                            <input id="txtSaleReturnNo" androidScan="true" />
                         
                        </td>
                        <td>
                        <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" style="" onclick="getSaleReturnOrder()">选择单据</a>
                    </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Print">
                                打印物料</label>
                        </td>
                        <td colspan="2">
                            <select id="selItemList" data-mini="true" class="perparelist">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>本次退货数量</label>
                        </td>
                        <td colspan="2">
                            <input id="txtGRNQty" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>最小包装数量</label>
                        </td>
                        <td colspan="2">
                            <input id="txtQty" />
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3" style="padding: 0;">
                            <div style="display: flex;width: 100%;">
                                <label style="flex: 1; text-align: left;">退货总数量</label>
                                <span id="POQty" style="flex: 1; text-align: center;"></span>
                                <label style="flex: 1; text-align: left;">已打数量</label>
                                <span id="PrintQty" style="flex: 1; text-align: center;"></span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Print">打印机</label>
                        </td>
                        <td colspan="2">
                            <select id="PDAselPrintersList" data-mini="true" class="perparelist">
                            </select>
                        </td>
                    </tr>
                    <%--<tr>
                        <td>
                            <label>打印原GRN</label></td>
                        <td>
                            <input id="PrintOld" type="checkbox" value="PrintOld" /></td>
                    </tr>--%>
                </table>
                <input id="lblLotCode" type="hidden"/>
                <input id="txtProdDate" type="hidden"/>
                <input id="textDateCode" type="hidden"/>
                <input id="hdnVendorCode" type="hidden"/>
                

                <div id="msg" style="text-align: center"></div>
                <div>
                    <table data-role="table" id="infotab" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>GRN
                                </th>
                                <th>数量
                                </th>
                                <th>打印时间
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%--<tr>
                                <td>GRN260306048434</td>
                                <td>3</td>
                                <td>2025-01-01 11:10</td>
                            </tr>--%>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed"  data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" onclick="Save()" data-theme="a" value="条码打印" /></li>
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
        <script type="text/javascript">
            var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            //定义参数：
            var enterGrn = "";
            var itemAllQty;
            var alreadyQty;
            var factoryCode;
            var selIqcOrder = "";
            $(function () {
               
                //获取打印机名称
                $(document).ready(function () {
                    bindPrinters('PDAselPrintersList', function () {
                        if ($("#PDAselPrintersList").val()) {
                            $("#PDAselPrintersList-button span").text($("#PDAselPrintersList").find("option:selected").text());
                        }
                    });
                    GetLabelDocumentList();
                    //切换备料位置
                    $("#selItemList").change(function () {
                        $("#selItemList-button span").text($("#selItemList").find("option:selected").text());
                        currentDtlData = DtlData.filter(x => x.SaleReturnDtlId == $("#selItemList").val())[0];
                        $("#POQty").text(currentDtlData.SaleReturnQty);
                        $("#PrintQty").text(currentDtlData.PrintQty);                        
                        //factoryCode = currentDtlData.FactoryCode;
                    });

                    //获取批次号
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetLotCode();
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    $("#lblLotCode").val(ajax.value);

                    $("#txtProdDate").val(GetDateStr(0));
                    $("#textDateCode").val(Math.abs((((new Date(GetDateStr(0))) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1));

                    //筛选
                    $("#btnFilter").on("click", function () {
                        $("#listviews").html("");
                        var $ul = $(this),
                            value = $.trim($("input[data-type='search']:eq(0)").val());
                        searchSaleReturnNo(value);
                    });

                });
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $(".ui-body-c").css("background", "#fff");
                //$("#GRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                //$("#SQty").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });

                //扫描退货单事件
                $("#txtSaleReturnNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        getSaleReturnNoDetailInfo(null, 0);
                    }
                });
            });

            //根据字符串模糊查询采购单
            function getSaleReturnOrder() {
                searchSaleReturnNo("");
                $("#listviews").listview("refresh");
            }

            //搜索、筛选退货单号
            function searchSaleReturnNo(saleReturnNo) {
                $("#listviews").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnList({ SaleReturnNo: saleReturnNo });
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtSaleReturnNo").val("").focus();
                    return false;
                }
                var list = ajax.value;
                var ulhtml = "";
                for (var i = 0; i < list.length; i++) {
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getSaleReturnNoDetailInfo(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].SaleReturnNo + "</a></li>";
                }
                $("#listviews").html(ulhtml);
                $("#listviews").listview("refresh");
            }

            var DtlData = [];
            var currentDtlData = null;
            //获取退货单明细信息  type 0：扫描 1：选择单据
            function getSaleReturnNoDetailInfo(entity, type) {
                showMsg("", 1);
                var saleReturnNo = "";
                if (type == 0) {
                    //扫描
                    saleReturnNo = $.trim($("#txtSaleReturnNo").val());
                    if (saleReturnNo == "") {
                        showMsg("请输入退货单号", 0);
                        $("#txtSaleReturnNo").val("").focus();
                        return;
                    }
                } else {
                    //选择单据后，获取换货明细信息
                    saleReturnNo = entity.SaleReturnNo;
                    $("#txtSaleReturnNo").val(saleReturnNo);
                    $("input[data-type='search']").val('');
                    $("#listviews").html('');
                    $("#fpanel").panel("close");
                    $("#txtSN").focus();
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnDetail({ SaleReturnNo: saleReturnNo });
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var list = ajax.value.filter(x => x.SaleReturnQty > x.PrintQty);
                DtlData = list;
                if (!list || !list[0].SaleReturnDtlId) {
                    alert("未获取到退货信息");
                    return false;
                }

                $("#txtGRNQty").val("");
                $("#txtQty").val("");
                $("#infotab tbody").empty();

                $("#selItemList option").remove();
                for (var i = 0; i < list.length; i++) {
                    $("#selItemList").append(`<option value="${list[i].SaleReturnDtlId}">${list[i].ItemCode}</option>`);
                }

                if (list.length > 0) {
                    $('#selItemList option:first').prop('selected', true);
                    $("#selItemList-button span").text($("#selItemList").find("option:first").text());
                    currentDtlData = DtlData[0];
                    $("#POQty").text(currentDtlData.SaleReturnQty);
                    $("#PrintQty").text(currentDtlData.PrintQty);
                }
                
            }



            function Save() {
                var POorder = $("#txtSaleReturnNo").val();    //采购单号
                //var POInStockNo = "";    //到货单号  //2017-09-09 ,wenshun ,到货单打印功能，创维专利，正式版本不需要
                labelItemId = currentDtlData.ItemId;
                var txtGRNQty = $("#txtGRNQty").val().replace(/,/g, ""); //打印条码数量，送货总数
                var txtQty = $("#txtQty").val().replace(/,/g, ""); //最小包装数量
                bigCartonQty = 0; //最外包装数量
                var txtLotCode = $("#lblLotCode").val();
                <%--var txtLotCode = $("#<%=this.lblLotCode.ClientID %>").text();--%>
                var txtVendorCode = currentDtlData.CustomerCode;
                var errStr = "";
                var txtDateCode = $("#txtProdDate").val();
                var remark = "";//$("#txtRemark").val();
                var rowId = currentDtlData.SaleReturnRowId;// $("#hdnRowId").val();
                factoryCode = currentDtlData.FactoryCode || "";
                itemAllQty = currentDtlData.SaleReturnQty;
                alreadyQty = currentDtlData.PrintQty;

                var textDateCode = $("#textDateCode").val();//DateCode
                var textMPN = ""; $("#textMPN").val();//MPN
                if (txtQty * 1 > txtGRNQty * 1) {
                    alert('最小包装数不能大于本次退货总数');
                    return false;
                }
                if (txtQty * 1 > bigCartonQty * 1 && bigCartonQty * 1 > 0) {
                    alert('最小包装数量不能大于外包装数量');
                    return false;
                }

                if (POorder == "") {
                    alert("退货单号不能为空！");
                    return;
                }
                //2017-09-09 ,wenshun ,到货单打印功能，创维专利，正式版本不需要
                //if (printChoosePageId * 1 != 104) {//到货单不检查批次号，可以自动生成
                if (txtLotCode == "") {
                    alert("批次号不能为空！");
                    return;
                }
                //}
                //else {
                //    POInStockNo = $("#txtShowPOCode").val();    //到货单号
                //}

                if (txtVendorCode == "") {
                    errStr += "<%=Resources.Messages.SelectVendorCode %>\n";
                }
                if (labelItemId == -1) {
                    errStr += "<%=Resources.Messages.SelectMaterial %>\n";
                }
                if (txtGRNQty == "" || txtGRNQty == "0" || parseFloat(txtQty) <= 0 || txtQty == "") {
                    errStr += "<%=Resources.Messages.GRNQtyIsInvalid %>\n";
                }
                if (txtDateCode == "") {
                    errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>\n";
                }
                var cDate = txtDateCode;
                var reg = new RegExp("-", "g"); /*创建正则表达式*/
                cDate = cDate.replace(reg, "/");
                var iDate = new Date(cDate);
                var toDay = new Date();
                if (Date.parse(iDate) - Date.parse(toDay) > 0) {
                    errStr += "生产日期需要小于今天日期\n";
                }

                if (errStr != "") {
                    alert(errStr);
                    return false;
                }

                if (!window.confirm("<%=Resources.Messages.ConfirmPrintTheseGRNs %>")) {
                    return false;
                }
                var isSupplyPrint = 0; //1:由供应商打印  0：不是由供应商打印
                //$("#lblMessage").html("正在生成GRN，请稍候...");
                //showAreaMessge("物料编码:" + $("#txtItemName").val() + "开始生成GRN，请稍候...", "messageGreen"); //messageRed,messageGreen

                setTimeout(function () {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaleReturnGenerateGRN(parseInt(labelItemId), parseFloat(txtGRNQty),
                    parseFloat(txtQty), parseFloat(bigCartonQty), parseFloat(itemAllQty), parseFloat(alreadyQty), txtLotCode, txtDateCode, txtVendorCode, POorder, factoryCode, remark, rowId, Boolean(isSupplyPrint), textDateCode, textMPN, selIqcOrder);//, POInStockNo
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message,0);
                        //$("#lblMessage").html(ajax.error.Message);
                        //$("#lblMessage").css("color", "red");
                        //showAreaMessge(ajax.error.Message, "messageRed");
                        return false;
                    }
                    $("#PrintQty").text(parseFloat($("#PrintQty").text()) + parseFloat($("#txtGRNQty").val()));
                    var arr = ajax.value;
                    if (arr != null) {
                        //$("#lblMessage").html("<%=Resources.Messages.GenGrnFinishAndPrintInProcess %>");
                        setTimeout(function () {
                            try {
                                //printGRN(arr);
                                arr[0] = arr[0].substring(0, arr[0].lastIndexOf(","));
                                //NewFLgrnStr = arr[0].split(","); //物料条码
                                Print(arr[0].split(","))
                            }
                            catch (e) {
                                alert(e);
                                //$("#lblMessage").html(e);
                                showMsg(e, 0);
                            }
                        }, 100);
                    }
                }, 100);
                        }

           
           <%-- var NewFLgrnStr = "";
            //分料截料
            function Save() {
                var txtQty = $("#SQty").val();
                var txtGRN = $.trim($("#GRN").val());

                if ($.trim(txtGRN) == "") {
                    confirmDialog("<%=Resources.Messages.RequiredGRN %>");
                    $("#txtGRN").focus();
                    return false;
                }
                if ($.trim(txtQty) == "" || parseFloat(txtQty) <= 0) {
                    confirmDialog("<%=Resources.Messages.SplitQtyInvalid %>");
                    $("#txtQty").focus();
                    return false;
                }
                confirmDialog("<%=Resources.Messages.ConfirmToSplit %>",function () {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SplitMaterial(txtQty, txtGRN);
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        return false;
                    }
                    var list = ajax.value;
                    confirmDialog("<%=Resources.Messages.SplitMaterialSuccessed %>");
                    GetSubGrn(txtGRN, list);
                    NewFLgrnStr = list[0].DetailContent;
                    Print();
                    $("#msg").html("分料截料成功").css("color", "#7FFF00");
                    $("#Qty").html(parseFloat(($("#Qty").html()) - parseFloat(txtQty)).toFixed(6));
                    $("#Qty").html(parseFloat($("#lblGRNQty").html()));
                });
            }--%>
          
            var NewFLgrnStr = "";
            function Print(grnArray) {
                //var grn = NewFLgrnStr;
                //if (grn == "" || grn == null || NewFLgrnStr.length == 0) {
                //    return;
                //}
                //var grnArray = grn.split(",");
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
                    var d = ajax.value;
                    //添加打印的条码信息
                    $("#infotab tbody").append(`
                        <tr>
                            <td>${d.SerialNumber}</td>
                            <td>${d.Quantity}</td>
                            <td>${getCurrentTime()}</td>
                        </tr>`);
                    

                    try {
                        labelItemId = ajax.value.PartId;
                        //是否供应商打印调用不同的模板
                        var IsSupper = ajax.value.IsSuplySerialNumber;

                        //如果工单号不为空则调用批次产品条码
                        if (ajax.value.SupplierOrderNumber != "" || labelType==-36) {
                            labelType=-36
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

                if (!$("#PrintOld").prop('checked')) {
                    var grnTemp = $("#GRN").val();
                    var grnIndex=$.inArray(grnTemp, SNInfo.SNList);
                    if (grnIndex != -1) {
                        SNInfo.SNList.splice(grnIndex, 1);
                    }
                }

                PrintLabContent();
            }

            var labelDocumentList = [];
            //获取标签模板
            function GetLabelDocumentList(name) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentListByName("成品退料标签");
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (!ajax.value || ajax.value.length == 0) {
                    alert("未获取到成品退料标签数据,请先配置!");
                    return false;
                }
                labelDocumentList = ajax.value;
                return labelDocumentList;
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

                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
                //if (ajax.error == null) {
                //    var entity = ajax.value;
                //    labelDocumentId = entity.LabelDocumentId;
                //    lableTypeQty = entity.PlateQty;
                //    //获取打印机名称值
                //    printName = $("#PDAselPrintersList").val();
                //    labelPrintWayId = entity.PrintWayId;
                //    tempatePath = entity.TemplatePath.replace("\\", "\\\\");

                //}
                //else {
                //    $("#msg").html(ajax.error.Message).css("color", "red");
                //    return false;
                //}

                var entity = labelDocumentList[0];
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //获取打印机名称值
                printName = $("#PDAselPrintersList").val();
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
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
                    debugger
                    sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
                } catch (e) {
                    $("#msg").html(e).css("color", "red");
                    return false;
                }
            }

            //加法 
            function accAdd(arg1, arg2) {
                var r1, r2, m;
                try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
                try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
                m = Math.pow(10, Math.max(r1, r2))
                return (arg1 * m + arg2 * m) / m
            }
            //数组之和 (小数)
            function NumsAdd(arr)
            {
                var result = 0;
                for (var i = 0; i <arr.length; i++) {
                    result = accAdd(result, accAdd(0, arr[i]));
                }
                return result;
            }
            //显示消息 type 1:成功 0：失败
            function showMsg(msg, type) {
                $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
            }
            /*
            document.write("前天："+GetDateStr(-2)); 
            document.write("<br />昨天："+GetDateStr(-1)); 
            document.write("<br />今天："+GetDateStr(0)); 
            document.write("<br />明天："+GetDateStr(1)); 
            document.write("<br />后天："+GetDateStr(2)); 
            document.write("<br />大后天："+GetDateStr(3)); 
            */
            function GetDateStr(AddDayCount) {
                var dd = new Date();
                dd.setDate(dd.getDate() + AddDayCount); //获取AddDayCount天后的日期
                var y = dd.getFullYear();
                var m = dd.getMonth() + 1; //获取当前月份的日期 
                var d = dd.getDate();
                m = m < 10 ? "0" + m : m;
                d = d < 10 ? "0" + d : d;
                return y + "-" + m + "-" + d;
            }

            function getCurrentTime() {
                const now = new Date();

                const year = now.getFullYear();
                const month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始
                const day = String(now.getDate()).padStart(2, '0');
                const hours = String(now.getHours()).padStart(2, '0');
                const minutes = String(now.getMinutes()).padStart(2, '0');

                return `${year}-${month}-${day} ${hours}:${minutes}`;
            }

        </script>
    </form>
</body>
</html>
