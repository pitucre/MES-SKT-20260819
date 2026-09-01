<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyError.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.VerifyError" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <title><%=Resources.lang.LicenseError%></title>
</head>
<body>
     <div data-role="page">
        <div data-role="header" data-position="fixed">
            <h1>
                Lean MES</h1>
                <a data-iconpos="notext" href="Login.aspx" data-role="button" data-icon="carat-l"></a>
        </div>
        <div data-role="content">
            <%= Request.QueryString["errorCode"] == null ? Resources.Messages.InvalidAccessPage : MsgInfo(Request.QueryString["errorCode"])%>
        </div>
        <div data-role="footer"  data-position="fixed" style="text-align:center; font-size:12px;">
        <div>深科特信息技术有限公司</div>
        <div>&copy;<%=DateTime.Now.Year.ToString() %> 版权所有</div>
        </div>
    </div>
</body>
</html>
