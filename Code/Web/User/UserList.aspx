<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="UserList.aspx.cs" Inherits="SKT.LeanMES.Web.User.UserList" Title="User List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">用户类型
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlUserType" runat="server">
                    <asp:ListItem Text="所有" Value="0"></asp:ListItem>
                    <asp:ListItem Text="系统用户" Value="-1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="供应商" Value="1"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">用户名
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

            <td class="Label3">工号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEmployeeNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">中文名
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

            <td class="Label3">英文名
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">用户状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlLockStatus" runat="server">
                    <asp:ListItem Text="" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang,Normal %>" Value="1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang,Resign %>" Value="2"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang,Hold %>" Value="3"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang,Deactivate %>" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </td>

        </tr>
        <tr>
            <%-- <td class="Label3">
                审核状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlApprovalStatus" runat="server" Visible="false">
                    <asp:ListItem Text="已审核" Value="1"></asp:ListItem>
                    <asp:ListItem Text="未审核" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>--%>
            <td class="Label3">创建时间
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtCreateDateTimeStart" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                ~
                <asp:TextBox ID="txtCreateDateTimeEnd" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div class="clear5"></div>
    <div>
        <asp:Label ID="errorMsg" runat="server" Text="" ForeColor="Red"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="UserName" HeaderText="用户名" SortExpression="UserName" />
            <asp:BoundField DataField="EmployeeNo" HeaderText="工号" />
            <asp:BoundField DataField="EmployeeCName" HeaderText="中文名" />
            <asp:BoundField DataField="EmployeeEName" HeaderText="英文名" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="DepartNo" HeaderText="部门编号" />
            <asp:BoundField DataField="DepartName" HeaderText="部门" />
            <asp:BoundField DataField="UserStatus" itemStyle-CssClass="UserStatus" HeaderText="用户状态" />
            <asp:BoundField DataField="UserType" HeaderText="用户类型" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="IsApproved" HeaderText="审核状态" Visible="false" />
           
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
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script type="text/javascript">
        isMultiple = false;
        _isHms = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(document).ready(function () {
            hdnOperate.val("");

        });


        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Account_UserAdd %>", src: openWinUrl, width: 750, height: 500 });
        }

        function Edit() {

            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + idStr;
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserView.aspx?name=Account_UserView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_UserView %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function ResetPwd() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            dialog({ title: "<%=Resources.Pages.InitPassword %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/User/UserChangePwd.aspx?name=Account_ChangePwd&ID=" + idStr, width: 600, height: 400 });
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
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 9 改为 UserType
            <%--var xx = $("#<%=this.GridView1.ClientID%> tbody input[name=\"chkSelect\"]:checked").parent().siblings(".UserStatus").text();--%>
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
            dialog({ title: "<%=Resources.Pages.AssigningRoles %>", src: openWinUrl, width: 815, height: 490 });
        }

        function Import() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserImport.aspx?name=Account_UserImport";
            dialog({ title: "<%=Resources.Pages.Account_UserImport %>", src: openWinUrl, width: 850, height: 450 });
        }

        function AssignPinter() {
            var idStr = getOneRecordId();
            if (idStr == "")
                return;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetGroupName();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            if (ajax.value.length==0) {
                alert("没有打印机分组");
                return;
            }
            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetUserPrinterGroup(idStr);
            if (ajax1.error != null) {
                alert(ajax1.error.Message);
                return;
            }
            var tab = $("<table id='grouptab' style='margin:auto;'></table>");
            var tr = null;
            for (var i = 0; i < ajax.value.length; i++) {
                if (i % 3 == 0) {
                    tr = $("<tr></tr>").appendTo(tab);
                }
                if (tr != null) {
                    tr.append("<td style='width:140px;line-height:25px;'><input type='checkbox' value='" + ajax.value[i] + "' id='cb" + i + "'" + (ajax1.value.indexOf(ajax.value[i]) > -1 ? " checked='checked'" : "") + "/><label for='cb" + i + "''>" + ajax.value[i] + "</label></td>");
                }
            }
            layer.open({
                type: 1,
                area: ["450px", "300px"],
                title: "分配打印机组",
                content: tab.get(0).outerHTML,
                btn: ['确定', '取消'],
                btn1: function (index, layero) {
                    var array = [];
                    $("#grouptab").find("input[type='checkbox']:checked").each(function () {
                        array.push($(this).val());
                    });
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.EditUserPrinterGroup(idStr, array);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return;
                    }
                    layer.close(index);
                }
            });
        }
    </script>
</asp:Content>
