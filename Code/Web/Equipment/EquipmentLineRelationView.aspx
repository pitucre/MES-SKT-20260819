<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentLineRelationView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentLineRelationView" Title="View EquipmentLineRelation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentLineType %></td>
            <td class="Field2">
                <asp:Label ID="lblEquipmentLineType" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.EquipmentLineDisplayName %></td>
            <td class="Field2">
                <asp:Label ID="lblEquipmentLineDisplayName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Line %></td>
            <td class="Field2">
                <asp:Label ID="lblLineId" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.CreateBy %></td>
            <td class="Field2">
                <asp:Label ID="lblCreateBy" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.CreateDateTime %></td>
            <td class="Field2">
                <asp:Label ID="lblCreateDateTime" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.UpdateBy %></td>
            <td class="Field2">
                <asp:Label ID="lblUpdateBy" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentLineRelationEdit.aspx?name=EquipmentLineRelationEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>