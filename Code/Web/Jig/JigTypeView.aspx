<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="JigTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.Jig.JigTypeView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
<table width="100%" class="ContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.FeederTypeName%></td>
            <td class="Field2">
                <asp:Label ID="lblTypeName" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.JigTypeCode%></td>
            <td class="Field2">
                <asp:Label ID="lblTypeCode" runat="server"></asp:Label>
            </td>
        </tr>
        
        <tr>
            <td class="Label2"><%= Resources.lang.Remark%></td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigTypeEdit.aspx?name=JigTypeEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
