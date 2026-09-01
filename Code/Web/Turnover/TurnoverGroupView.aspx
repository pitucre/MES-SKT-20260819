<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurnoverGroupView.aspx.cs" Inherits="SKT.LeanMES.Web.Turnover.TurnoverGroupView" MasterPageFile="~/Masters/ViewMaster.master"%>
<asp:Content runat="server" ContentPlaceHolderID="viewcontent">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.TurnoverGroupName%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblTurnoverGroupName" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.TurnoverTypeName%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblTurnoverTypeName" runat="server" ></asp:Label>
            </td>

        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.ItemsName%></td>
            <td class="Field1">
                 <asp:Label ID="lblItemName" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MinStowQty%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblMinStowQty" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxStowQty%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblMaxStowQty" runat="server" ></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverGroupEdit.aspx?name=Turnover_TurnoverGroupEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
             window.location.href = openWinUrl;
        }
    </script>
</asp:Content>
