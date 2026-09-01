<%@ Page Language="C#" MasterPageFile="~/Masters/CustomMenu.master"
    AutoEventWireup="true" CodeBehind="CustomMenuPage.aspx.cs" Inherits="SKT.LeanMES.Web.CustomMenu.CustomMenuPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContentReport" runat="server">
<%=InitPage() %>
    <script type="text/javascript">
        var userName = "";
        $(document).ready(function () {           
            userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        });
    </script>
</asp:Content>