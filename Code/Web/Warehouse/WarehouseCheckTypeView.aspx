<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCheckTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCheckTypeView" Title="View WarehouseCheckType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.ErpCode %></td>
            <td class="Field2">
                <asp:Label ID="lblErpCode" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.WarehouseCheckTypeName%></td>
            <td class="Field2">
                <asp:Label ID="lblWarehouseCheckTypeName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Describe%></td>
            <td class="Field2">
                <asp:Label ID="lblDescribe" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.CreateBy%></td>
            <td class="Field2">
                <asp:Label ID="lblCreateBy" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.CreateDateTime%></td>
            <td class="Field2">
                <asp:Label ID="lblCreateDateTime" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.ModifyBy%></td>
            <td class="Field2">
                <asp:Label ID="lblModifyBy" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ModifyDateTime%></td>
            <td class="Field2">
                <asp:Label ID="lblModifyDateTime" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseCheckTypeEdit.aspx?name=WarehouseCheckTypeEdit&ID=" + <%= Request.QueryString["ID"] %>;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>