<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="EditProfile.aspx.cs" Inherits="SKT.LeanMES.Web.User.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <%--<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.UserName %>
            </td>
            <td class="Field1">
                <label id="lblUserName">
                </label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.CName %>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtCName" name="txtCName" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.EName %>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtEName" name="txtEName" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                性别
            </td>
            <td class="Field1">
                <SKTControl:SexDropDownList runat="server" ID="ddlSex">
                </SKTControl:SexDropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                电话
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtPhone" name="txtPhone" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                Email
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtEmail" name="txtEmail" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                列表分页记录
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtLinage" name="txtLinage" class="NumericBox50" />
                <span class="Tips">列表每页显示的记录条数，默认为15条/页</span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                消息刷新频率
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtRemindInterval" name="txtRemindInterval" class="NumericBox"
                    style="width: 70px;" />
                <span class="Tips">单位：毫秒，1秒=1000毫秒</span>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var userId = -1;
        $(document).ready(function () {
            initProfile();
            /*问题优化：
            Wesley:2023-10-23
            Bug:1333
            问题:修改资料无法显示数据
            原因:是系统编辑时把当前注释也带上了，导致界面里的代码也一起注释掉了
            处理：下面的单行注释修改为多行注释，保存子界面的代码不会受到影响即可*/
           /*// initPageLang();*/
        });

        /*获取个人资料*/
        function initProfile() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetByName("<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var userInfo = ajax.value;

            if (userInfo != null) {
                userId = userInfo.UserId;
                $("#lblUserName").text(userInfo.UserName);
                $("#txtCName").val(userInfo.EmployeeCName);
                $("#txtEName").val(userInfo.EmployeeEName);
                $("#<%=this.ddlSex.ClientID %>").val(userInfo.Sex);
                $("#txtPhone").val(userInfo.Phone);
                $("#txtEmail").val(userInfo.Email);
                $("#txtLinage").val(userInfo.Linage);
                $("#txtRemindInterval").val(userInfo.RemindInterval);
            }
        }

        /*保存个人资料*/
        function Save() {
            var UserName = $.trim($("#lblUserName").text());
            var EmployeeCName = $.trim($("#txtCName").val());
            var EmployeeEName = $.trim($("#txtEName").val());
            var Sex = $.trim($("#<%=this.ddlSex.ClientID %>").val());
            var Phone = $.trim($("#txtPhone").val());
            var Email = $.trim($("#txtEmail").val());
            var Linage = $.trim($("#txtLinage").val());
            var RemindInterval = $.trim($("#txtRemindInterval").val());

            /*验证电话号码*/
            if (!isNull(Phone) && !checkPhone(Phone)) {
                styleErrorControl($("#txtPhone"));
                return false;
            }
            /*验证邮箱*/
            if (!isNull(Email) && !checkEmail(Email)) {
                styleErrorControl($("#txtEmail"));
                return false;
            }

            var userInfo = {};

            userInfo.UserId = userId;
            userInfo.UserName = UserName;
            userInfo.EmployeeCName = EmployeeCName;
            userInfo.EmployeeEName = EmployeeEName;
            userInfo.Sex = Sex;
            userInfo.Phone = Phone;
            userInfo.Email = Email;
            userInfo.Linage = Linage;
            userInfo.RemindInterval = RemindInterval;           
            userInfo.ModifyBy = UserName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.EditProfile2(userInfo);
            if (handleAjaxError(ajax.error)) {
                alert("数据保存成功；\n【列表分页记录】和【消息刷新频率】需要重新登录才能生效；");
            }
        }
    </script>
</asp:Content>
