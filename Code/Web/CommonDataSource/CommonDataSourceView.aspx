<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="CommonDataSourceView.aspx.cs" Inherits="SKT.LeanMES.Web.CommonDataSource.CommonDataSourceView"
    Title="View DataSource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                数据源名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblDataSourceName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                数据源作用类型
            </td>
            <td class="Field2">
                <asp:Label ID="lblDataSourceType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                数据源类型
            </td>
            <td class="Field2">
                <asp:Label ID="lblSQLType" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                使用范围
            </td>
            <td class="Field2">
                <asp:Label ID="lblUseType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                创建人
            </td>
            <td class="Field2">
                <asp:Label ID="lblCreateBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                创建时间
            </td>
            <td class="Field2">
                <asp:Label ID="lblCreateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                修改人
            </td>
            <td class="Field2">
                <asp:Label ID="lblModifyBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                修改时间
            </td>
            <td class="Field2">
                <asp:Label ID="lblModifyTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                描述
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblDataSourceDesc" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2" >
                正文
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblSQLInfo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                参数
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblParamters" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                列名
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblTabColumn" runat="server"></asp:Label>
            </td>
        </tr>

    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CommonDataSource/CommonDataSourceEdit.aspx?name=CommonDataSourceEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
