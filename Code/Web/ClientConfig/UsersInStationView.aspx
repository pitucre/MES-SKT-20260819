<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="UsersInStationView.aspx.cs" Inherits="SKT.LeanMES.Web.ClientConfig.UsersInStationView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        
        <tr>
            <td class="Label1">
                用户名<em>*</em>
            </td>
            <td class="Field1">
                <label id="lblUserName" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Station %><em>*</em>
            </td>
            <td class="Field1">
                <label id="lblStation" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Line%><em>*</em>
            </td>
            <td class="Field2">
                <label id="lblLineName" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                资源<em>*</em>
            </td>
            <td class="Field2">
                <label id="lblResource" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                默认资源
            </td>
            <td class="Field2">
                <label id="lblIsDefault" runat="server"></label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/UsersInStationEdit.aspx?name=Client_UsersStationEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
