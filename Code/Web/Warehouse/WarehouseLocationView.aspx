<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLocationView.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLocationView" Title="View WarehouseLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">储位编码</td>
            <td class="Field2">
                <asp:Label ID="lblcStoreCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">储位名称</td>
            <td class="Field2">
                <asp:Label ID="lblcStoreName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">货位编码</td>
            <td class="Field2">
                <asp:Label ID="lblcPosCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">货位名称</td>
            <td class="Field2">
                <asp:Label ID="lblcPosName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">仓位属性</td>
            <td class="Field2">
                <asp:Label ID="lblCProperty" runat="server"></asp:Label>
            </td>
            <td class="Label2">仓库编码</td>
            <td class="Field2">
                <asp:Label ID="lblcWhCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">发料顺序</td>
            <td class="Field2">
                <asp:Label ID="lblMOrder" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.WarehouseDeliveryOrder%></td>
            <td class="Field2">
                <asp:Label ID="lblPOrder" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.WarehouseCodeLevel%></td>
            <td class="Field2">
                <asp:Label ID="lbliPosGrade" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.WarehouseLastLevel%></td>
            <td class="Field2">
                <asp:Label ID="lblbPosEnd" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.WarehouseBarCode%></td>
            <td class="Field2" >
                <asp:Label ID="lblcBarCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">货位类型</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblLoctionType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
           <td class="Label2"><%= Resources.lang.MaximumVolume%></td>
            <td class="Field2">
                <asp:Label ID="lbliMaxCubage" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.MaximumWeight%></td>
            <td class="Field2">
                <asp:Label ID="lbliMaxWeight" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseLocationEdit.aspx?name=Warehouse_WarehouseLocationEdit&ID="+<%= Request.QueryString["ID"] %>;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>