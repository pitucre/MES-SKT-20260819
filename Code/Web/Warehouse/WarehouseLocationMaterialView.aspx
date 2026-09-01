<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLocationMaterialView.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLocationMaterialView"
    Title="WarehouseLocationMaterial View Warehouse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.ItemCode%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblItemCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.WarehouseCode%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblCWhCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.WarehouseGoodsCode%>
            </td>
            <td class="Field1" colspan="3">
                <asp:Label ID="lblCBarCode" runat="server"></asp:Label>
            </td>
        </tr>
         <tr>
            <td class="Label1">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field1" colspan="3">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseLocationMaterialEdit.aspx?name=Warehouse_WarehouseLocationMaterialEdit&ID="+<%= Request.QueryString["ID"] %>;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
