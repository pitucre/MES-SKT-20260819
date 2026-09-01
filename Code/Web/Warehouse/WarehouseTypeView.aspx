<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseTypeView" Title="View WarehouseType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.WarehouseTypeName%></td>
            <td class="Field2">
                <asp:Label ID="lblWarehouseType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark%></td>
            <td class="Field2">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseTypeEdit.aspx?name=Warehouse_WarehouseTypeEdit&ID="+'<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>