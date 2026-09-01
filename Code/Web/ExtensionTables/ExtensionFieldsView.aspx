<%@ Page Title="ExtensionFieldsView" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="ExtensionFieldsView.aspx.cs" Inherits="SKT.LeanMES.Web.ExtensionTables.ExtensionFieldsView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <asp:HiddenField ID="extensionFieldsId" runat="server" Value="0" />
        <tr>
            <td class="Label2">
                <%= Resources.lang.TableName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblTableName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.ExtensionFieldName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblExtensionFieldName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ExtensionFieldDescription %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblExtensionFieldDescription" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.ExtensionFieldType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblExtensionFieldType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ExtensionFieldIsAllowNull %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblExtensionFieldIsAllowNull" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.Sequence %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblSequence" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td colspan="3" class="Field2">
                <asp:Label ID="lblRemark" TextMode="MultiLine" Width="500" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>

        //编辑
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ExtensionTables/ExtensionFieldsEdit.aspx?Name=ExtensionFields_ExtensionFieldsEdit&ID=" + Id;
	        $(".dlg-title.text", parent.window.document).html("<%= Resources.Pages.ExtensionFields_ExtensionFieldsEdit %>");
	        window.location.href = openWinUrl
        }
    </script>
</asp:Content>
