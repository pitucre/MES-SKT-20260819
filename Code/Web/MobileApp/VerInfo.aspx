<%@ Page Title="" Language="C#" MasterPageFile="~/MobileApp/MobileMaster.Master"
    AutoEventWireup="true" CodeBehind="VerInfo.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.VerInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<center>
    <div style="margin-top:2em;font-size:25px" id="strVerInfo"  runat="server">
        <%--版本：8.5.7--%>
    </div>
    </center>
    <script type="text/javascript">
        $(function () {
            //$("#backlabel").html("个人中心");
        });
    </script>
</asp:Content>
