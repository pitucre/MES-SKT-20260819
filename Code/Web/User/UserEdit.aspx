<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="UserEdit.aspx.cs" Inherits="SKT.LeanMES.Web.User.UserEdit" Title="Edit Membership" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .rbl tr td {
            padding: 5px;
            margin: 3px;
            cursor: pointer;
            border: 1px solid #ffffff;
            vertical-align: middle;
        }

            .rbl tr td:hover {
                padding: 5px;
                margin: 3px;
                cursor: pointer;
                border: 1px solid #d3d3d3;
                background: #f1f1f1;
                vertical-align: middle;
            }
    </style>
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">用户信息</li>
            <li>分配角色</li>
        </ul>
        <!--用户信息-->
        <div class="tb_c" id="userInfo_tb">
            <div class="infoTips">
                带<em>*</em>为必填项
            </div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label2">用户类型
                    </td>
                    <td class="Field2" colspan="3">
                        <span style="float: left; margin-right: 5px;">
                            <asp:RadioButtonList ID="rblUserType" runat="server" RepeatDirection="Horizontal"
                                CssClass="rbl" CellSpacing="5" CellPadding="3">
                                <asp:ListItem Selected="True" Text="系统用户" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="供应商" Value="1"></asp:ListItem>
                            </asp:RadioButtonList>
                            <%--<a href="BatchCreateUser.aspx">快速批量创建供应商用户</a>--%>
                        </span>
                    </td>
                </tr>
                <tr id="isVendor">
                    <td class="Label2">供应商
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:HiddenField ID="hdnVendorId" runat="server" Value="-1" />
                        <asp:TextBox ID="txtVendorCode" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                            type="button" value="..." class="ButtonBox" title="选择供应商" onclick="chooseVendor()" />
                    </td>
                </tr>
                <tr class="edituser">
                    <td class="Label2">用户名
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr class="adduser">
                    <td class="Label2">用户名<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="20" ToolTip="最多只能输入20个字符"></asp:TextBox><span
                            class="Tips">用户名可由字母、数字、下划线组成；最多不能超过20位，最少4位。</span>
                    </td>
                </tr>
                <tr class="adduser">
                    <td class="Label2">密码<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtPassword1" runat="server" TextMode="Password" IsRequired="1" CssClass="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr class="adduser">
                    <td class="Label2"> <%=Resources.lang.ConfirmPassword %><em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtPassword2" runat="server" CssClass="Password" IsRequired="1" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">中文名
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtCName" runat="server" CssClass="TextBox" MaxLength="20" ToolTip="最多只能输入20个字符"></asp:TextBox>
                    </td>
                    <td class="Label2">英文名
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtEName" runat="server" CssClass="TextBox" MaxLength="50" ToolTip="最多只能输入50个英文字符"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">性别
                    </td>
                    <td class="Field2">
                        <asp:DropDownList ID="ddlSex" runat="server">
                            <asp:ListItem Text="<%$ Resources:lang,Male %>" Value="1"></asp:ListItem>
                            <asp:ListItem Text="<%$ Resources:lang,Female %>" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="Label2"><%=Resources.lang.WechatNumber %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtWechatNumber" runat="server" CssClass="TextBox" MaxLength="20" ToolTip="最多只能输入20个字符"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">钉钉Id</td>
                    <td class="Field2">
                        <asp:TextBox runat="server" ID="DingTalkUserId" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="Label2"></td>
                    <td class="Field2">
                    </td>
                </tr>
                <tr>
                    <td class="Label2">电话
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                    <td class="Label2">邮箱
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr id="issysuser">
                    <td class="Label2">工号<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtEmployeeNo" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="20" ToolTip="最多只能输入20个字符"></asp:TextBox>
                    </td>
                    <td class="Label2">部门<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:HiddenField ID="hdnDepartId" runat="server" Value="-1" />
                        <asp:HiddenField ID="hdnDepartNo" runat="server" Value="" />
                        <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox" IsRequired="1" Enabled="false"></asp:TextBox><input
                            type="button" value="..." class="ButtonBox" title="选择部门" onclick="chooseParentDepart()" />
                    </td>
                </tr>  
                <tr>
                    <td class="Label2">帐号状态
                    </td>
                    <td class="Field2" ">
                        <asp:DropDownList ID="ddlUserStatus" runat="server">
                            <asp:ListItem Text="<%$ Resources:lang,Normal %>" Value="1"></asp:ListItem>
                            <asp:ListItem Text="<%$ Resources:lang,Resign %>" Value="2"></asp:ListItem>
                            <asp:ListItem Text="<%$ Resources:lang,Hold %>" Value="3"></asp:ListItem>
                            <asp:ListItem Text="<%$ Resources:lang,Deactivate %>" Value="4"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                     <td class="Label2">是否应急联系人<em>*</em>
                     </td>
                     <td class="Field2">
                        <asp:CheckBox ID="chkIsHandle" runat="server" ClientIDMode="Static" />
                     </td>
                </tr>
            </table>
        </div>
        <div id="userRole_tb">
            <table class="ListTable" width="100%" id="roleList">
                <tr class="ListTableHeader">
                    <th width="5%"></th>
                    <th>角色名称
                    </th>
                    <th>描述
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hdnUserRolesIdStr" Value="" />
    <script type="text/javascript" src="../Content/js/Convert_Pinyin.js"></script>
    <script type="text/javascript">
        var userId = parseInt('<%=Request.QueryString["ID"]%>');
        var IsGroup = parseInt('<%=Request.QueryString["IsGroup"]%>') == 1 ? "1" : "0";
        var userType = -1
        $(document).ready(function () {
            if (userId > -1) {
                $(".edituser").show();
                $(".adduser").hide();
                $(".infoTips").hide();
                $(".adduser").find("input").removeAttr("IsRequired");
                userType = parseInt('<%=membershipInfo.UserType%>')==0?-1:parseInt('<%=membershipInfo.UserType%>');
            }
            else {
                $(".edituser").hide();
                $(".adduser").show();

            }
            if (userType != -1) {
                $("#issysuser").hide();
                $("#<%=this.txtEmployeeNo.ClientID %>").attr("isrequired", 0);
                $("#<%=this.txtDepartName.ClientID %>").attr("isrequired",0);
            }


            getRoleList(userId);


            if ($("#<%=this.rblUserType.ClientID %> :checked").val() == "-1") {
                $("#isVendor").hide();
            }
            else {
                $("#isVendor").show();
            }

            $("#<%=this.rblUserType.ClientID %>").change(function () {
                if ($("#<%=this.rblUserType.ClientID %> :checked").val() == "-1") {
                    $("#isVendor").hide();
                    $("#issysuser").show();
                    $("#<%=this.txtEmployeeNo.ClientID %>").attr("isrequired", 1);
                    $("#<%=this.txtDepartName.ClientID %>").attr("isrequired",1);
                }
                else {
                    $("#isVendor").show();
                    $("#issysuser").hide();
                    $("#<%=this.txtEmployeeNo.ClientID %>").attr("isrequired", 0);
                    $("#<%=this.txtDepartName.ClientID %>").attr("isrequired",0);
                }
            });

            $("#<%=this.txtCName.ClientID %>").change(function () {
                if (userId == -1) {
                    if ($.trim($(this).val()) != "") {
                        //获取全写拼音（调用js中方法）        
                        var fullName = pinyin.getFullChars($(this).val());
                        //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.CharacterToPinyin($(this).val());
                        //if (ajax.error != null) {
                        //    alert(ajax.error.Message);
                        //    return false;
                        //}
                        $("#<%=this.txtEName.ClientID %>").val(fullName);
                    }
                }
            });
            var winH = $(window).height();
            $("#userInfo_tb,#userRole_tb").css({ 'overflow': 'auto' });
            $("#userInfo_tb").height(winH - 65);
            $("#userRole_tb").height(winH - 65);
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
            var txtWechatNumber = $("#<%=this.txtWechatNumber.ClientID %>").val();
            var dingTalkUserId = $.trim($("#DingTalkUserId").val());
           
            if ($("#<%=this.rblUserType.ClientID %> :checked").val() == "-1") {
                userType = -1;
            }
            else {
                if ($("#<%=this.hdnVendorId.ClientID %>").val() == "-1") {
                    alert("请选择一个供应商！");
                    return false;
                }
                userType = $("#<%=this.hdnVendorId.ClientID %>").val();
            }


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
                if (txtUserName.length < 4 || txtUserName.length > 20) {
                    errorStr += "用户名最多不能超过20位，最少4位！\n";
                    $("#<%=this.txtUserName.ClientID %>").addClass("inputerror");
                }
                if (isNull(txtPassword1)) {
                    errorStr += "密码不能为空！\n";
                    $("#<%=this.txtPassword1.ClientID %>").addClass("inputerror");
                }
                //启用密码强度
                if ("<%=WindowsPWDStrength%>" == "1") {
                    if (!/^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/.test(txtPassword1)) {
                        errorStr += "密码必须由字母和数字组成,至少有一个大写,一个小写,长度最少是8位\n";
                        $("#<%=this.txtPassword1.ClientID %>").addClass("inputerror");
                    }
                }else if ("<%=MandatoryPassword%>" == "1") {
                    if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/.test(txtPassword1)) {
                        errorStr += "密码必须由字母和数字组成长度6到16位\n";
                        $("#<%=this.txtPassword1.ClientID %>").addClass("inputerror");
                    }
                }
                if (!isNull(txtPassword1) && txtPassword1 != txtPassword2) {
                    errorStr += "两次输入的密码不一致！\n";
                    $("#<%=this.txtPassword1.ClientID %>").addClass("inputerror");
                    $("#<%=this.txtPassword2.ClientID %>").addClass("inputerror");
                }
                txtPassword1 = JsDesEncrypt(txtPassword1);
                if (userType == -1) {
                    if (isNull(txtEmployeeNo)) {
                        errorStr += "工号不能为空！\n";
                        $("#<%=this.txtEmployeeNo.ClientID %>").addClass("inputerror");
                    }
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
            entity.WechatNumber = txtWechatNumber;
            entity.DingTalkUserId = dingTalkUserId;
            entity.IsHandle = $("#<%=this.chkIsHandle.ClientID%>").is(":checked");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.UserEdit(entity, roleIdStr, $("#<%=this.hdnUserRolesIdStr.ClientID %>").val(), IsGroup);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var userId1 = ajax.value;
            alert('<%=Resources.Messages.SaveInSuccess%>');

            //            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
            //                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + userId1;
            //                location.href = openWinUrl;
            //            }
            //            else {
            parent.window.Refresh();
            //            }
        }

        function chooseParentDepart() {
            dialog({ title: "选择部门", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Organization/OrganizationTree.aspx?rnd=" + Math.random(), width: 300, height: 300 });
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
            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetRoleList("", IsGroup);
            
            if (ajax1.error != null) {
                alert(ajax1.error.Message);
                return false;
            }
            var list1 = ajax1.value;

            var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetRoleListByUserId(userId, IsGroup);
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

            $("#roleList input[type=checkbox]").each(function () {
                for (var j = 0; j < list2.length; j++) {
                    if ($(this).val() == list2[j].RoleID) {
                        $(this)[0].checked = true;
                        break;
                    }
                }
            });
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
            if (IsGroup == "1") {
                dialog({ title: "选择供应商", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=820&Multiple=false&CallBackFunc=setVendor&rnd=" + Math.random(), width: 550, height: 300 });
            } else {
                dialog({ title: "选择供应商", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&CallBackFunc=setVendor&rnd=" + Math.random(), width: 550, height: 300 });
            }
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
