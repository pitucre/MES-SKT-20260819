<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="RoleView.aspx.cs" Inherits="SKT.LeanMES.Web.Role.RoleView" Title="View Role" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label1">角色名</td>
            <td class="Field1">
                <asp:Label ID="lblRoleName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">描述</td>
            <td class="Field1">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var IsGroup = parseInt('<%=Request.QueryString["IsGroup"]%>') == 1 ? "1" : "0";
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Role/RoleEdit.aspx?name=Account_RoleEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&IsGroup=" + IsGroup;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>