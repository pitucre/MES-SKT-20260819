<%@ Page Language="C#" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.Framework.VerifyError"
    CodeBehind="VerifyError.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <title>
        <%=Resources.lang.LicenseError%></title>
    <link href="../Content/Common.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: #eeeeee;">
    <div style="width: 350px; height: 210px; background: #faf9f9; border: 1px solid #cccccc;
        padding: 0px; font-size: 12px; position: absolute; top: 50%; left: 50%; margin-top: -100px;
        margin-left: -175px;">
        <div class="divHeader">
            <b>
                <asp:Label ID="Label2" runat="server" Text="<%$ Resources:Common, SystemMessage %>"></asp:Label></b>
        </div>
        <div style="border-top: 1px solid #cccccc; border-bottom: 0px solid #cccccc; padding: 20px 0 20px 0;
            line-height: 22px;">
            <table cellpadding="0" cellspacing="0" border="0" style="height: 100px;">
                <tr>
                    <td style="width: 60px; text-align: center;" valign="top">
                        <img src="<%= SKT.LeanMES.Web.WebHelper.ImageRoot %>msg_warning.gif" alt="" style="border: 0px;" />
                    </td>
                    <td valign="top" id="licenseInvalide">
                        <%= Request.QueryString["errorCode"] == null ? Resources.Messages.InvalidAccessPage : MsgInfo(Request.QueryString["errorCode"])%>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script src="../Content/js/skt.utility.checkmobile.js" type="text/javascript"></script>
    <script type="text/javascript">
        checkMobile();
        function checkMobile() {
            if (isMobile.any()) {
                location.href = "../MobileApp/VerifyError.aspx?errorCode=" + '<%=Request.QueryString["errorCode"] %>';
            }
        }
    </script>
</body>
</html>
