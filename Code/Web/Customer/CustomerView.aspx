<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master"
    CodeBehind="CustomerView.aspx.cs" Inherits="SKT.LeanMES.Web.Customer.CustomerView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                客户全称
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCustomerRemarke" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.CustomerName%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCustomerName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                客户编码
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCustomerCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                客户地址1
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCustomerAddress1" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                客户地址2
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCustomerAddress2" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                国籍
            </td>
            <td class="Field2">
                <asp:Label ID="lblCountry" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                省
            </td>
            <td class="Field2">
                <asp:Label ID="lblProvince" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.City%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCity" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                邮箱地址
            </td>
            <td class="Field2">
                <asp:Label ID="lblEmail" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                邮编
            </td>
            <td class="Field2">
                <asp:Label ID="lblPostal" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerEdit.aspx?name=Customer_CustomerEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
