<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="UserOfSupplierList.aspx.cs" Inherits="SKT.LeanMES.Web.User.UserOfSupplierList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                工号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEmployeeNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                用户名
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                审核状态
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlApprovalStatus" runat="server">
                    <asp:ListItem Text="已审核" Value="1"></asp:ListItem>
                    <asp:ListItem Text="未审核" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                姓名
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                创建时间
            </td>
            <td class="Field2">
                从<asp:TextBox ID="txtCreateDateTimeStart" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                到
                <asp:TextBox ID="txtCreateDateTimeEnd" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <td class="Label2">
                用户状态
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlLockStatus" runat="server">
                    <asp:ListItem Text="" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="正常" Value="1"></asp:ListItem>
                    <asp:ListItem Text="离职" Value="2"></asp:ListItem>
                    <asp:ListItem Text="锁定" Value="3"></asp:ListItem>
                    <asp:ListItem Text="停用" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="UserName" HeaderText="用户名" SortExpression="UserName" />
            <asp:BoundField DataField="EmployeeNo" HeaderText="员工编号" />
            <asp:BoundField DataField="EmployeeCName" HeaderText="中文名" />
            <asp:BoundField DataField="EmployeeEName" HeaderText="英文名" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="DepartNo" HeaderText="部门编号" />
            <asp:BoundField DataField="DepartName" HeaderText="部门" />
            <asp:BoundField DataField="IsApproved" HeaderText="审核状态" />
            <asp:BoundField DataField="UserStatus" HeaderText="用户状态" />
            <asp:BoundField DataField="UserType" HeaderText="用户类型" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.Common.Account.BLL.Users"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(function () {
            $(".DateTimeBox").change(function () {
                if ($(this).val() == null || $(this).val() == "") return false;
                $(this).val(intToDate($(this).val()));
            });
            $(document).ready(function () {
                $("#ckbMultipleSelected").parent().hide();
            })
        });

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserOfSupplierEdit.aspx?name=UserOfSupplierAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Account_UserAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserOfSupplierEdit.aspx?name=UserOfSupplierEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_UserEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserOfSupplierView.aspx?name=UserOfSupplierView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_UserView %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function ResetPwd() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            dialog({ title: "修改用户密码", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/User/UserChangePwd.aspx?name=UserOfSupplierChangePwd&ID=" + idStr, width: 600, height: 400 });
            return false;

            if (confirm("初始化密码会将用户密码初始化为123456，确定要初始化选中用户的密码吗？")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.InitPassword(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("所选用户密码已重置为初始密码：123456");
                Refresh();
            }
        }

        function UnlockUser() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 9 改为 UserStatus
            var lock = getOneRecordCellTextByFiled("UserStatus");
            if (lock.indexOf("正常") == -1) {
                if (confirm("是否确定解锁当前选中的用户？")) {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.UnlockUser(idStr);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    alert("用户已解锁，用户可以正常登录系统了！");
                    Refresh();
                }
            }
            else {
                alert("当前用户没有被锁定，不需要解锁。");
            }
        }

        function LogoffUser() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (confirm("注销用户功能将会使用系统前台登录的用户退出系统，是否确定注销选中的用户？")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.LogoffUser(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("用户已被注销！");
                Refresh();
            }
        }
        function AssignUserToRole() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Role/RolesInUser.aspx?name=Account_RolesInUser&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_RolesInUser %>", src: openWinUrl, width: 750, height: 400 });
        }
        function ImportUser() {
        }
    </script>
</asp:Content>
