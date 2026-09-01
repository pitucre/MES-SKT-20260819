<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="StationTestCountView.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationTestCountView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                工序名称
            </td>
            <td class="Field1">
                <asp:Label ID="lblStation" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.ItemCode%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblItemCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                最大通过次数(Pass次数)
            </td>
            <td class="Field1">
                <asp:Label ID="lblPassTimes" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                最大失败次数(Fail次数)
            </td>
            <td class="Field1">
                <asp:Label ID="lblFailTimes" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationTestCountEdit.aspx?name=Station_StationTestCountEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
