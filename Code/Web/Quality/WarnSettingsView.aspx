<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WarnSettingsView.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.WarnSettingsView" Title="View WarnSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">产品</td>
            <td class="Field2">
                <asp:Label ID="lblItemCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">线别</td>
            <td class="Field2">
                <asp:Label ID="lblLineName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">操作工位</td>
            <td class="Field2">
                <asp:Label ID="lblStationName" runat="server"></asp:Label>
            </td>
            <td class="Label2">预警类型</td>
            <td class="Field2">
                <asp:Label ID="lblWarnType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">预警级别</td>
            <td class="Field2">
                <asp:Label ID="lblWarnLevel" runat="server"></asp:Label>
            </td>
            <td class="Label2">良品率</td>
            <td class="Field2">
                <asp:Label ID="lblYield" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">通知接收人</td>
            <td class="Field2">
                <asp:Label ID="lblReciveUsers" runat="server"></asp:Label>
            </td>
            <td class="Label2">备注</td>
            <td class="Field2">
                <asp:Label ID="lblContents" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/WarnSettingsEdit.aspx?name=WarnSettings_YieldEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>