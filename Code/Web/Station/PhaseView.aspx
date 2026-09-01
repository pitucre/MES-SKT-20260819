<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="PhaseView.aspx.cs" Inherits="SKT.LeanMES.Web.Station.PhaseView" Title="View Phase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                生产阶段
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblPhaseName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.CreateBy %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCreateBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.CreateDateTime %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCreateDateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ModifyBy%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblModifyBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.ModifyDateTime%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblModifyDateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/PhaseEdit.aspx?name=Station_PhaseEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
