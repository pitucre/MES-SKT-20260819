<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="LoadingListTableView.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.LoadingListTableView" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.LoadingListTable%></td>
            <td class="Field2">
                <asp:Label ID="lblTableName" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.LoadingListTableDesc%></td>
            <td class="Field2">
                <asp:Label ID="lblTableDesc" runat="server"></asp:Label>
            </td>
        </tr>        
        <tr>
            <td class="Label2"><%= Resources.lang.Remark%></td>
            <td class="Field2">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.IsActive%></td>
            <td class="Field2">
                <asp:Label ID="lblEnableFlag" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingListTableEdit.aspx?name=LoadingListTableEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
