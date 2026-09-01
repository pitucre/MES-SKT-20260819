<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="ResourceTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceTypeView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.ResTypeName %>
            </td>
            <td class="Field1">
                <asp:Label ID="txtResTypeName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field1">
                <asp:Label ID="txtResTypeDesc" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceTypeEdit.aspx?name=Resource_ResourceTypeEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
