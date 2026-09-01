<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="LabelZPLView.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelZPLView" Title="View LabelZPL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ZPLType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblZplType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ZPLName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblZplName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelZPLEdit.aspx?name=Labels_LabelZPLEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
