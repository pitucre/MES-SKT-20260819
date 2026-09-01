<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="UserOfSupplierView.aspx.cs" Inherits="SKT.LeanMES.Web.User.UserOfSupplierView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                用户类型
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblUserType" runat="server" Text=""></asp:Label>
                 <span style="display:none;">
                    <SKTControl:Supplier ID="uddlSupplier" runat="server">
                    </SKTControl:Supplier>
                </span> 
            </td>
        </tr>
        <tr>
            <td class="Label2">
                用户名
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblUserName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                中文名
            </td>
            <td class="Field2">
                <asp:Label ID="lblCName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                英文名
            </td>
            <td class="Field2">
                <asp:Label ID="lblEName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                工号
            </td>
            <td class="Field2">
                <asp:Label ID="lblEmployeeNo" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                部门
            </td>
            <td class="Field2">
                <asp:Label ID="lblDepartName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                性别
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblSex" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                电话
            </td>
            <td class="Field2">
                <asp:Label ID="lblPhone" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                邮箱
            </td>
            <td class="Field2">
                <asp:Label ID="lblEmail" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                审核状态
            </td>
            <td class="Field2">
                <asp:Label ID="lblIsApproved" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                锁定状态
            </td>
            <td class="Field2">
                <asp:Label ID="lblIsLockout" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                列表页面记录数
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblLinage" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                用户状态
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblUserStatus" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserOfSupplierEdit.aspx?name=UserOfSupplierEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
