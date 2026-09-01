<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="JigView.aspx.cs" Inherits="SKT.LeanMES.Web.Jig.JigView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
<table width="100%" class="ContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.JigName %></td>
            <td class="Field2">
                <asp:Label ID="lblJigName" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.JigNickName%></td>
            <td class="Field2">
                <asp:Label ID="lblJigNickName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Category%></td>
            <td class="Field2">
                <asp:Label ID="lblJigType" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.ItemName%></td>
            <td class="Field2">
                <asp:Label ID="lblItemId" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.VendorName%></td>
            <td class="Field2">
                <asp:Label ID="lblVendorId" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.PartLocation%></td>
            <td class="Field2">
                <asp:Label ID="lblPosition" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.StandarLive%></td>
            <td class="Field2">
                <asp:Label ID="lblStandarLive" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                保养预警
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblWarningTime" runat="server"></asp:Label>
            </td>
<%--            <td class="Label2"><%= Resources.lang.StandarMain%></td>
            <td class="Field2">
                <asp:Label ID="lblStandarMaint" runat="server"></asp:Label>
            </td>--%>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.UserCount%></td>
            <td class="Field2">
                <asp:Label ID="lblUseCount" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.CreateBy%></td>
            <td class="Field2">
                <asp:Label ID="lblCreateBy" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.CreateDateTime%></td>
            <td class="Field2">
                <asp:Label ID="lblCreateDateTime" runat="server"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.ModifyBy%></td>
            <td class="Field2">
                <asp:Label ID="lblModifyBy" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ModifyDateTime%></td>
            <td class="Field2">
                <asp:Label ID="lblModifyDateTime" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                当前位置
            </td>
            <td class="Field2">
                <asp:Label ID="lblCurPosition" runat="server"  ></asp:Label>
            </td>

        </tr>

        <tr>
             <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>

        </tr>
    </table>

    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigEdit.aspx?name=JigEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>