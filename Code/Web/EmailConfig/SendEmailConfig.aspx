<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendEmailConfig.aspx.cs"
    Inherits="SKT.LeanMES.Web.EmailConfig.SendEmailConfig" MasterPageFile="~/Masters/EditMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table style="width: 100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                邮箱服务器地址<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMailServerName" runat="server" ClientIDMode="Static" CssClass="TextBox"
                    Width="160px" IsRequired='1'></asp:TextBox>
                <span class="Tips">例如：SMTP.sina.com</span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                邮箱服务器类型<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMailServertype" runat="server" ClientIDMode="Static" CssClass="TextBox"
                    Width="160px" IsRequired='1'></asp:TextBox>
                <span class="Tips">例如：SMTP</span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                邮箱服务器端口<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPort" runat="server" ClientIDMode="Static" CssClass="TextBox"
                    Width="160px" IsRequired='1' IsNumber='1'></asp:TextBox>
                <span class="Tips">例如：25</span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                邮箱登录用户名<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtUserName" runat="server" ClientIDMode="Static" CssClass="TextBox"
                    Width="160px" IsRequired='1'></asp:TextBox>
                <span class="Tips">例如：test@sina.com</span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                邮箱登录密码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPassWord" runat="server" ClientIDMode="Static" CssClass="TextBox"
                    TextMode="Password" Width="160px" IsRequired='1'></asp:TextBox><input type="text" id="txtPwd" class="TextBox" value="" style="display: none; width:160px;" /> <span class="Tips"><a href="javascript:void(0)"
                        onclick="showPwd(this)" >显示密码</a></span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                邮箱地址<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMailAddress" runat="server" ClientIDMode="Static" CssClass="TextBox"
                    Width="160px" IsRequired='1'></asp:TextBox>
                <span class="Tips">例如：test@sina.com</span>
            </td>
        </tr>
    </table>
    <script type="text/javascript" language="javascript">
        var isCP = '<%=isCP %>';
        var Id = '<%=id%>';

        $(document).ready(function () {
            $("#txtPwd").val($("#<%=this.txtPassWord.ClientID %>").val());
        });

        $(function () {
            $("#<%=this.txtPassWord.ClientID %>").keyup(function () {
                $("#txtPwd").val($(this).val());
            });

            $("#txtPwd").keyup(function () {
                $("#<%=this.txtPassWord.ClientID %>").val($(this).val());
            });

            $("#<%=this.txtPort.ClientID %>").live("focusout", function () {
                checkNumber(document.getElementById("<%=this.txtPort.ClientID %>"));
            });

            $("#<%=this.txtMailAddress.ClientID %>").live("focusout", function () {
                checkeEmail(document.getElementById("<%=this.txtMailAddress.ClientID %>"));
            });
        });

        //验证只能为数字
        function checkNumber(obj) {
            var reg = /^[0-9]+$/;
            if (obj.value != "" && !reg.test(obj.value)) {
                alert('<%= Resources.Messages.AC_NumberOnly %>');
                obj.value = "";
                obj.focus();
                return false;
            }
        }

        function checkeEmail(obj) {
            var str = obj.value;
            var reg = /^[a-zA-Z0-9_-]+(\.([a-zA-Z0-9_-])+)*@[a-zA-Z0-9_-]+[.][a-zA-Z0-9_-]+([.][a-zA-Z0-9_-]+)*$/;
            if (obj.value != "" && !reg.test(obj.value)) {
                alert('<%= Resources.Messages.EmailServerError %>');
                obj.value = "";
                obj.focus();
                return false;
            }
        }

        function Save() {
            var txtMailServerName = $.trim($("#txtMailServerName").val());
            var txtMailServertype = $.trim($("#txtMailServertype").val());
            var txtPort =$.trim($("#txtPort").val());
            var txtUserName = $.trim($("#txtUserName").val());
            var txtPassWord = $.trim($("#txtPassWord").val());
            var txtMailAddress = $.trim($("#txtMailAddress").val());

            if (isCP == 0 && isNull(txtPassWord)) {
                alert('请输入密码！')
                $("#txtPassWord").css('background-color', 'yellow').focus();
                return false;
            }

            if (!checkEmail(txtMailAddress)) {                
                $("#txtMailAddress").css('background-color', 'yellow').focus();
                return false;
            }

            var entity = {};
            entity.Id = Id;
            entity.MailServerName = txtMailServerName;
            entity.MailServertype = txtMailServertype;
            entity.Port = txtPort;
            entity.UserName = txtUserName;
            entity.PWD = txtPassWord;
            entity.MailAddress = txtMailAddress;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEmailConfig.EmailServerEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert("保存成功！");

            }
        }

        function showPwd(obj) {
            $("#<%=this.txtPassWord.ClientID %>").toggle();
            $("#txtPwd").toggle();
            if ($(obj).html() == "显示密码") {
                $(obj).html("隐藏密码");
            }
            else {
                $(obj).html("显示密码");
            }
        }
    </script>
</asp:Content>
