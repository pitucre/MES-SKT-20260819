<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/PDAFunctionModel.Master" AutoEventWireup="true" CodeBehind="PDAFunctionPreview.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.PDAFunctionPreview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="sdpUI" style="width:100%;" runat="server"> 
        <div style="width: 100%; height: 200px; display: table;">
            <span style="width: 100%; color: rgb(33, 173, 247); margin-right: auto; margin-left: auto; vertical-align: middle; display: table-cell;">正在加载数据...<br><img src="../Content/plugin/dialog/skin/default/images/loadinga.gif"></span>
        </div>
    </div>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "";
        $(document).ready(function () {           
            //加载页面
            //data = store.get("SDPCookie");
            //$("#sdpUI").html(decodeURI(data));
            userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        });
    </script>
</asp:Content>
