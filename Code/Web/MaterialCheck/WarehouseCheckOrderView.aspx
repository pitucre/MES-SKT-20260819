<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCheckOrderView.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckOrderView"
    Title="View WarehouseCheckOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td colspan="2" class="Label">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <%--      <tr>
            <td class="Label2"><%= Resources.lang.CheckOrder %></td>
            <td class="Field2">
                <asp:TextBox ID="txtCheckOrder" runat="server" CssClass="TextBox"  MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.CheckTypeId %></td>
            <td class="Field2">
                <asp:TextBox ID="txtCheckTypeId" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.WarehouseId %></td>
            <td class="Field2">
                <asp:TextBox ID="txtWarehouseId" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.BeginDate %></td>
            <td class="Field2">
                <asp:TextBox ID="txtBeginDate" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.CheckOrderStatus %></td>
            <td class="Field2">
                <asp:TextBox ID="txtCheckOrderStatus" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox>
            </td>
        </tr>--%>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/WarehouseCheckOrderEdit.aspx?name=WarehouseCheckOrderEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
