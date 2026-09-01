<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierExameTypeView.aspx.cs" MasterPageFile="~/Masters/ViewMaster.master" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameTypeView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.SupplierExameTypeName%></td>
            <td class="Field2">
                <asp:Label ID="lblExameType" runat="server"></asp:Label>
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameTypeEdit.aspx?name=Warehouse_SupplierExameTypeEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
