<%@ Page Language="C#" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.Framework.Expired"
    CodeBehind="Expired.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        <%=Resources.lang.Expired %></title>
    <link href="../Content/Common.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <style type="text/css">
        html, body
        {
            background: #eeeeee;
        }
        .wrap
        {
            width: 350px;
            height: 240px;
            background: #faf9f9;
            border: 1px solid #cccccc;
            padding: 0px;
            font-size: 12px; /*position: absolute;
            top: 45%;
            left: 50%;*/
            margin-top: 100px;
            margin-left: auto;
            margin-right: auto; /* Gecko browsers */
            -moz-border-radius-topleft: 4px;
            -moz-border-radius-topright: 4px;
            -moz-border-radius-bottomleft: 4px;
            -moz-border-radius-bottomright: 4px; /* Webkit browsers */
            -webkit-border-top-left-radius: 4px;
            -webkit-border-top-right-radius: 4px;
            -webkit-border-bottom-left-radius: 4px;
            -webkit-border-bottom-right-radius: 4px; /* W3C syntax */
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
            border-bottom-right-radius: 4px;
            border-bottom-left-radius: 4px;
        }
        .expiredBox
        {
            border-top: 1px solid #cccccc;
            border-bottom: 0px solid #cccccc;
            padding: 20px 0 20px 0;
            line-height: 22px;
        }
    </style>
</head>
<body>
    <div class="wrap">
        <div class="divHeader">
            <b>
                <img src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/info.png' style="vertical-align: middle;
                    float: none; margin-right: 5px;" /><asp:Label ID="Label1" runat="server" Text="<%$ Resources:Common, SystemMessage %>"></asp:Label></b>
        </div>
        <div class="expiredBox">
            <table cellpadding="3" cellspacing="2" border="0">
                <tr>
                    <td style="width: 60px; text-align: center;" valign="top">
                        <img src="<%= SKT.LeanMES.Web.WebHelper.ImageRoot %>msg_information.gif" alt="" style="border: 0px;" />
                    </td>
                    <td valign="top">
                        <%= Resources.Messages.Expired %>
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; padding: 0px 0px 0px 0px; margin-top: 10px;">
            <span id="t" style="color: Red;">5</span> 秒后自动跳转到登录页面</div>
        <div style="text-align: center; padding: 0px 0px 0px 0px; margin-top: 10px;">
            <input id="Button1" type="button" onclick="closeWin();" class="Button" runat="server"
                value="<%$ Resources:Buttons, COM_Ok %>" />
        </div>
    </div>
    <script src="../Content/js/skt.utility.checkmobile.js" type="text/javascript"></script>
    <script type="text/javascript">
        checkMobile();
        function checkMobile() {
            if (isMobile.any()) {
                location.href = "../MobileApp/Expired.aspx";
            }
        }

        function closeWin() {
            if (!isMobile.any()) {
                top.location.href = "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Login.aspx?Action=Expired&expiredPath=" +encodeURIComponent('<%=Request.QueryString["expiredPath"] %>');
            } else {
                top.location.href = "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Mobile/Login.aspx?Action=Expired&expiredPath=" + encodeURIComponent('<%=Request.QueryString["expiredPath"] %>');
            }
        }
        $(document).ready(function () {
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
    </script>
</body>
</html>
