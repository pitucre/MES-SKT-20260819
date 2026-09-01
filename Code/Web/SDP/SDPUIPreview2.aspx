<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SDPUIPreview2.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.SDPUIPreview2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <title></title>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            var data = $("#<%=this.hdnValue.ClientID %>").val();
            if (!data)
                data = store.get("SDPCookie");
            $("#sdpUI").css("textAlign", "left").html(decodeURI(data));
        });
    </script>
    <style type="text/css">
        html, body {
            padding: 0;
            margin: 0;
        }
    </style>
</head>
<body>
    <form runat="server">
        <div id="sdpUI" style="width: 100%; text-align: center;">
            <div style="width: 100%; height: 200px; display: table;">
                <span style="width: 100%; color: rgb(33, 173, 247); margin-right: auto; margin-left: auto; vertical-align: middle; display: table-cell;">正在加载数据...<br />
                    <img src="../Content/plugin/dialog/skin/default/images/loadinga.gif" /></span>
            </div>
        </div>
        <asp:HiddenField ID="hdnValue" runat="server" Value="" />
    </form>
</body>
</html>
