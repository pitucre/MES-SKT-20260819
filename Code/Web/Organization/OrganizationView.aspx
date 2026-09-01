<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="OrganizationView.aspx.cs" Inherits="SKT.LeanMES.Web.Organization.OrganizationView" Title="View Organization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">上级部门</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblParenDepartName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">部门名称</td>
            <td class="Field2">
                <asp:Label ID="lblDepartName" runat="server"></asp:Label>
            </td>
            <td class="Label2">部门编号</td>
            <td class="Field2">
                <asp:Label ID="lblDepartNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">部门主管</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblSupervisor" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">描述</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblDesc" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Organization/OrganizationEdit.aspx?name=Account_OrganizationEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;       
        }
    </script>
</asp:Content>