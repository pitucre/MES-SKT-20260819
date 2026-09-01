<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseView.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseView"
    Title="View Warehouse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseCode%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCWhCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarehouseName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCWhName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseAttributes%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCWhType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Principal%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCWhPerson" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.DepartmentName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCDepCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Telephone%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCcWhPhone" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseIsGoods%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="cbStorage" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseAddress%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCWhAddress" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseEdit.aspx?name=Warehouse_WarehouseEdit&ID="+<%= Request.QueryString["ID"] %>;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
