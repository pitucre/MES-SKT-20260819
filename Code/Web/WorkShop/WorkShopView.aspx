<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WorkShopView.aspx.cs" Inherits="SKT.LeanMES.Web.WorkShop.WorkShopView"
    Title="View WorkShop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.WorkShopName %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblWorkShopName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.FactoryName%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblWorkShopCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.ShiftName%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblFactoryName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/WorkShop/WorkShopEdit.aspx?name=WorkShopEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
