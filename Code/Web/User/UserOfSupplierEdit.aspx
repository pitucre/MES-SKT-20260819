<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="UserOfSupplierEdit.aspx.cs" Inherits="SKT.LeanMES.Web.User.UserOfSupplierEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
<style type="text/css">
    .rbl tr td{padding:5px; margin:3px;}
</style>
    <div class="infoTabs" id="infoTabs">
        <div id="infoTabItem1" class="infoTabItem-selected" onclick="selectTab(this,1)" title="用户信息">
            用户信息
        </div>
        <div id="infoTabItem2" onclick="selectTab(this,2)" title="分配角色">
            分配角色
        </div>
    </div>
    <div id="infoTabContent" class="infoTabContent">
        <div id="infoTabContent-1" class="infoTabContent-selected">
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td colspan="4" class="Label">
                        带<em>*</em>为必填项
                    </td>
                </tr>
                <tr id="userType">
                    <td class="Label2">
                        用户类型
                    </td>
                    <td class="Field2" colspan="3">                        
                        <span style="float:left; margin-right:5px;">
                        <asp:RadioButtonList ID="rblUserType" runat="server" RepeatDirection="Horizontal" CssClass="rbl" CellSpacing="5" CellPadding="3">
                            <asp:ListItem  Text="供应商" Value="1" Selected></asp:ListItem>
                        </asp:RadioButtonList> 
                        <%--<a href="BatchCreateUser.aspx">快速批量创建供应商用户</a>--%>
                        </span>
                    </td>
                </tr>
                <tr id="isVendor">
                    <td class="Label2">供应商</td>
                    <td class="Field2" colspan="3">
                          <asp:HiddenField ID="hdnVendorId" runat="server" Value="-1" />
                        <asp:TextBox ID="txtVendorCode" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                            type="button" value="..." class="ButtonBox" title="选择供应商" onclick="chooseVendor()" />
                    </td>
                </tr>
                <tr class="edituser">
                    <td class="Label2">
                        用户名
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr class="adduser">
                    <td class="Label2">
                        用户名<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox><span
                            class="Tips">用户名可由字母、数字、下划线组成；最多不能超过20位，最少4位。</span>
                    </td>
                </tr>
                <tr class="adduser">
                    <td class="Label2">
                        密码<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtPassword1" runat="server" TextMode="Password" CssClass="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr class="adduser">
                    <td class="Label2">
                        确认密码<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtPassword2" runat="server" CssClass="Password" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        中文名
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtCName" runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                    <td class="Label2">
                        英文名
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtEName" runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        性别
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:DropDownList ID="ddlSex" runat="server">
                            <asp:ListItem Text="男" Value="1"></asp:ListItem>
                            <asp:ListItem Text="女" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        电话
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                    <td class="Label2">
                        邮箱
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        工号
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtEmployeeNo" runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                    <td class="Label2">
                        部门
                    </td>
                    <td class="Field2">
                        <asp:HiddenField ID="hdnDepartId" runat="server" Value="-1" />
                        <asp:HiddenField ID="hdnDepartNo" runat="server" Value="" />
                        <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox"></asp:TextBox><input
                            type="button" value="..." class="ButtonBox" title="选择部门" onclick="chooseParentDepart()" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        帐号状态
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:DropDownList ID="ddlUserStatus" runat="server">
                            <asp:ListItem Text="正常" Value="1"></asp:ListItem>
                            <asp:ListItem Text="离职" Value="2"></asp:ListItem>
                            <asp:ListItem Text="锁定" Value="3"></asp:ListItem>
                            <asp:ListItem Text="停用" Value="4"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div id="infoTabContent-2">
            <table class="ListTable" width="100%" id="roleList">
                <tr class="ListTableHeader">
                    <th width="5%">
                    </th>
                    <th>
                        角色名称
                    </th>
                    <th>
                        描述
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hdnUserRolesIdStr" Value="" />
    <script type="text/javascript">
        var userId = parseInt('<%=Request.QueryString["ID"]%>');
        $(document).ready(function () {
            if (userId != -1) {
                $(".edituser").show();
                $(".adduser").hide();
            }
            else {
                $(".edituser").hide();
                $(".adduser").show();
            }
            getRoleList(userId);
            //总是隐藏，因为这个指定是哪个供应商在另一个地方已有该功能
            $("#isVendor").hide();
            $("#userType").hide();
            $("#<%=this.txtCName.ClientID %>").change(function () {
                if (userId == -1) {
                    if ($.trim($(this).val()) != "") {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.CharacterToPinyin($(this).val());
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return false;
                        }
                        $("#<%=this.txtEName.ClientID %>").val(ajax.value);
                    }
                }
            });

            $(document).keydown(function (event) {
                if (event.keyCode == 37) {
                    selectTab("#infoTabItem1", 1);
                }
                if (event.keyCode == 39) {
                    selectTab("#infoTabItem2", 2);
                }
            });
        });
        /*保存数据*/
        function Save() {
            $(".inputerror").removeClass("inputerror");
            var txtUserName = "";
            var txtPassword1 = "";
            var txtPassword2 = "";
            if (userId == -1) {
                txtUserName = $.trim($("#<%=this.txtUserName.ClientID %>").val()).toString();
                txtPassword1 = $.trim($("#<%=this.txtPassword1.ClientID %>").val()).toString();
                txtPassword2 = $.trim($("#<%=this.txtPassword2.ClientID %>").val()).toString();
            }
            var txtCName = $.trim($("#<%=this.txtCName.ClientID %>").val()).toString();
            var txtEName = $.trim($("#<%=this.txtEName.ClientID %>").val()).toString();
            var ddlSex = $.trim($("#<%=this.ddlSex.ClientID %>").val());
            var txtPhone = $.trim($("#<%=this.txtPhone.ClientID %>").val()).toString();
            var txtEmail = $.trim($("#<%=this.txtEmail.ClientID %>").val()).toString();
            var txtEmployeeNo = $.trim($("#<%=this.txtEmployeeNo.ClientID %>").val()).toString();
            var txtDepartNo = $.trim($("#<%=this.hdnDepartNo.ClientID %>").val()).toString();
            var txtDepartName = $.trim($("#<%=this.txtDepartName.ClientID %>").val()).toString();
            var hdnDepartId = $("#<%=this.hdnDepartId.ClientID %>").val().toString();
            var ddlUserStatus = $("#<%=this.ddlUserStatus.ClientID %>").val();

            var userType = 1;//是供应商帐号
            /*获取选择的角色ID*/
            var roleIdStr = "";
            $("#roleList input[type=checkbox]").each(function () {
                if ($(this)[0].checked) {
                    roleIdStr += $(this).val() + ",";
                }
            });
            if (roleIdStr != "") {
                roleIdStr = roleIdStr.substring(0, roleIdStr.length - 1);
            }

            var errorStr = "";
            /*表单验证*/
            if (userId == -1) {
                if (isNull(txtUserName)) {
                    errorStr += "用户名不能为空！\n";
                    $("#<%=this.txtUserName.ClientID %>").addClass("inputerror");
                }
                if (!isNull(txtUserName) && !isNumberOr_Letter(txtUserName)) {
                    errorStr += "用户名可由字母、数字、下划线组成！\n";
                    $("#<%=this.txtUserName.ClientID %>").addClass("inputerror");
                }
                if (!isNull(txtUserName) && (txtUserName.length < 4 || txtUserName > 20)) {
                    errorStr += "用户名最多不能超过20位，最少4位！\n";
                    $("#<%=this.txtUserName.ClientID %>").addClass("inputerror");
                }
                if (isNull(txtPassword1)) {
                    errorStr += "密码不能为空！\n";
                    $("#<%=this.txtPassword1.ClientID %>").addClass("inputerror");
                }
                if (!isNull(txtPassword1) && txtPassword1 != txtPassword2) {
                    errorStr += "两次输入的密码不一致！\n";
                    $("#<%=this.txtPassword1.ClientID %>").addClass("inputerror");
                    $("#<%=this.txtPassword2.ClientID %>").addClass("inputerror");
                }
            }
            if (!isNull(txtPhone) && !checkPhone(txtPhone)) {
                $("#<%=this.txtPhone.ClientID %>").addClass("inputerror");
                return false;
            }
            if (!isNull(txtEmail) && !checkEmail(txtEmail)) {
                $("#<%=this.txtEmail.ClientID %>").addClass("inputerror");
                return false;
            }
            if (isNull(txtCName) && isNull(txtEName)) {
                errorStr += "中文名和英文名至少有一个不能为空！";
            }

            if (!isNull(errorStr)) {
                alert(errorStr);
                return false;
            }

            var entity = {};
            entity.UserId = userId;
            entity.UserName = txtUserName;
            entity.Password = txtPassword1;
            entity.EmployeeCName = txtCName;
            entity.EmployeeEName = txtEName;
            entity.EmployeeNo = txtEmployeeNo;
            entity.DepartId = hdnDepartId;
            entity.DepartNo = txtDepartNo;
            entity.DepartName = (txtDepartName.indexOf("(") > -1) ? txtDepartName.substring(0, txtDepartName.indexOf("(")) : txtDepartName;
            entity.Phone = txtPhone;
            entity.Email = txtEmail;
            entity.Sex = ddlSex;
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            entity.UserStatus = ddlUserStatus;
            entity.UserType = userType;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.UserEdit(entity, roleIdStr, $("#<%=this.hdnUserRolesIdStr.ClientID %>").val(),"");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var userId1 = ajax.value;
            alert('<%=Resources.Messages.SaveInSuccess%>');
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserOfSupplierEdit.aspx?name=UserOfSupplierEdit&ID=" + userId1;
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }

        function chooseParentDepart() {
            dialog({ title: "选择部门", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Organization/OrganizationTree.aspx?rnd=" + Math.random(), width: 250, height: 400 });
        }

        function getChooseValue(departId, departName, departNo) {
            $("#<%=this.hdnDepartId.ClientID %>").val(departId);
            $("#<%=this.hdnDepartNo.ClientID %>").val(departNo);
            if (departNo != "") {
                $("#<%=this.txtDepartName.ClientID %>").val(departName + "(" + departNo + ")");
            }
            else {
                $("#<%=this.txtDepartName.ClientID %>").val(departName);
            }
            closeDialog();
        }

        function getRoleList(userId) {
            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetRoleList("","");
            if (ajax1.error != null) {
                alert(ajax1.error.Message);
                return false;
            }
            var list1 = ajax1.value;

            var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetRoleListByUserId(userId,"");
            if (ajax2.error != null) {
                alert(ajax2.error.Message);
                return false;
            }
            var roleList = "";
            var list2 = ajax2.value;
            var rowclass = "ListTableEvenRow";

            var hdnUserRolesIdStr = "";
            for (var i = 0; i < list2.length; i++) {
                hdnUserRolesIdStr += list2[i].RoleID + ",";
            }
            if (hdnUserRolesIdStr != "") {
                hdnUserRolesIdStr = hdnUserRolesIdStr.substring(0, hdnUserRolesIdStr.length - 1);
            }

            $("#<%=this.hdnUserRolesIdStr.ClientID %>").val(hdnUserRolesIdStr);
            var chked = false;

            for (var i = 0; i < list1.length; i++) {
                if (i % 2 == 0) {
                    rowclass = "ListTableOddRow";
                }
                else {
                    rowclass = "ListTableEvenRow";
                }
                roleList += "<tr class='" + rowclass + "'>";
                roleList += "<td><input type='checkbox' value='" + list1[i].RoleID + "'/></td>";
                roleList += "<td>" + list1[i].RoleName + "</td>";
                roleList += "<td>" + list1[i].Description + "</td>";
                roleList += "</tr>";
            }
            $("#roleList tr:gt(0)").remove();
            if (list1.length == 0) {
                roleList = "<tr class='ListTableEmptyDataRow'><td colspan='3'>目前系统还没有角色</td></tr>";
            }
            $(roleList).appendTo($("#roleList"));
            //如果是管理员，默认不选择上
            if (userId!="-1")
            {
                $("#roleList input[type=checkbox]").each(function () {
                    for (var j = 0; j < list2.length; j++) {
                        if ($(this).val() == list2[j].RoleID) {
                            $(this)[0].checked = true;
                            break;
                        }
                    }
                });
            }
            mo();
        }

        /*鼠标经过时*/
        var oldBg;

        function mo() {
            $("#roleList .ListTableOddRow,#roleList .ListTableEvenRow").hover(
            function () {
                oldBg = $(this).attr("class");
                $(this).removeClass(oldBg);
                $(this).addClass("ListTableHoverRow");
            },
            function () {
                /*debug: 修正当本行被选中时鼠标移开后行颜色不能恢复的问题*/
                $(this).removeClass("ListTableHoverRow");
                $(this).addClass(oldBg);
            });
        }

        function chooseVendor() {
            dialog({ title: "选择选择供应商", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&CallBackFunc=setVendor&rnd=" + Math.random(), width: 550, height: 400 });
        }

        function setVendor(list) {
            $("#<%=this.hdnVendorId.ClientID %>").val(list[0][0]);
            $("#<%=this.txtVendorCode.ClientID %>").val(list[0][1] + "-" + list[0][2]);
            $("#<%=this.txtVendorCode.ClientID %>").attr("title", list[0][1] + "-" + list[0][2])
            if (userId == -1) {
                $("#<%=this.txtUserName.ClientID %>").val(list[0][1].replace(".", ""));
            }
        }
    </script>
</asp:Content>
