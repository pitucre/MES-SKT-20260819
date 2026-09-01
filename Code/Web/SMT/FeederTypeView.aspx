<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.FeederTypeView" Title="Edit FeederType" CodeBehind="FeederTypeView.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.FeederTypeName%>
            </td>
            <td class="Field1">
                <asp:Label ID="txtName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Size%>
            </td>
            <td class="Field1">
                <asp:Label ID="txtSize" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Pitch%>
            </td>
            <td class="Field1">
                <asp:Label ID="txtPitch" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Attrition%>
            </td>
            <td class="Field1">
                <asp:Label ID="txtAttrition" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field1">
                <asp:Label ID="txtDescription" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/FeederTypeEdit.aspx?name=FeederTypeEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
