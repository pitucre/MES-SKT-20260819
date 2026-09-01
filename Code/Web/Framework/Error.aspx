<%@ Page Language="C#" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.Framework.Error" Codebehind="Error.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title><%=Resources.Common.Error %></title>
    <style type="text/css">
        .errMsg{width:350px; height:210px; background:#faf9f9;border:1px solid #cccccc;padding:7px;font-size:12px; position:absolute; top:50%; left:50%; margin-top:-100px; margin-left:-175px;}
        .errMsgTitle{padding:2px 0 5px 0;}
        .errMsgContent{border-top:1px solid #cccccc;border-bottom:1px solid #cccccc;padding:20px 0 20px 0}
        .errMsgBtn{text-align:center;padding:0px 0 0 0; display:none;}
        .Button{ border:none; background:url(../content/images/btn_search.png) no-repeat; cursor:pointer; width:43px; height:23px;}
        .Button:hover{ border:none; background:url(../content/images/btn_search_hover.png) no-repeat; cursor:pointer; width:43px; height:23px;}
     </style>
</head>
<body>
    <div class="errMsg">
        <div class="errMsgTitle">
            <b><asp:Label ID="Label1" runat="server" Text="<%$ Resources:Common, MsgCaption %>"></asp:Label></b>
        </div>
        <div class="errMsgContent">
            <table cellpadding="0" cellspacing="0" border="0" style="height:120px;">
                <tr>
                    <td style="width:60px; text-align:center;">
                        <asp:Image ID="imgErrorType" runat="server" ImageUrl="~/Content/theme/Metro/images/msg_error.gif"/>
                    </td>
                    <td valign="top">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="errMsgBtn">
            <input id="Button1" type="button" onclick="back()" class="Button" runat="server" value="<%$ Resources:Buttons, COM_Ok %>" />
        </div>
    </div>
    <script type="text/javascript">
        function back() {
            /*history.back();*/
        }
    </script>
</body>
</html>
