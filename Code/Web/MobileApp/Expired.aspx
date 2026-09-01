<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Expired.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.Expired" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <title>Expired</title>
</head>
<body>
    <div data-role="page" id="home">
        <div data-role="header" id="header" data-position="fixed">
            <h3 style="padding: 10px; margin: 0px;">
                登录已超时
            </h3>
        </div>
        <div data-role="content" id="main">
            <div>
                <%= Resources.Messages.Expired %></div>
            <div>
                <button data-theme="d" onclick="closeWin();">
                    (<span id="t" style="color: white;">5</span>秒)返回登录页</button>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            setInterval(function () {
                var t = $("#t").html();
                if (parseInt(t, 10) > 0) {
                    $("#t").html(parseInt(t, 10) - 1);
                }
                else {
                }
            }, 1000);

            setTimeout(function () { closeWin(); }, 5000);
        });

        function closeWin() {
            location.href = "../MobileApp/Login.aspx";
        }
    </script>
</body>
</html>
