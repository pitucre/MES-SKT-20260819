<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="ExpirationDateView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ExpirationDateView"
    Title="View MaintenanceDemo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintenanceDemoNO%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDemoCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.MaintenanceDemoName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDemoName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50" Width="99%" Height="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceDemoEdit.aspx?name=Maintenance_MaintenanceDemoEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
