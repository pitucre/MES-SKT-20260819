<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="CurrentUserChangePwd.aspx.cs" Inherits="SKT.LeanMES.Web.User.CurrentUserChangePwd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">

        <tr>
            <td class="Label1">
                <%=Resources.lang.OldPwd%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtOldPwd" TextMode="Password" IsRequired="1" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.NewPwd %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtNewPwd" TextMode="Password" IsRequired="1" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.ConfirmNewPwd %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtCfmNewPwd" TextMode="Password" IsRequired="1" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var IsGroup = parseInt('<%=Request.QueryString["IsGroup"]%>') == 1 ? "1" : "0";

        function Save() {
            var txtOldPwd = $("#<%=this.txtOldPwd.ClientID %>").val();
            var txtNewPwd = $("#<%=this.txtNewPwd.ClientID %>").val();
            var txtCfmNewPwd = $("#<%=this.txtCfmNewPwd.ClientID %>").val();

            var err = "";

            if (txtOldPwd == "" && userId == -1) {
                err += "<%=Resources.Messages.OldPwdIsRequired %>\n";
            }
            if (txtNewPwd == "") {
                err += "<%=Resources.Messages.NewPwdIsRequired %>\n";
            }
            if (txtCfmNewPwd == "") {
                err += "<%=Resources.Messages.ConfirmNewPwd %>\n";
            }
            //启用密码强度
            if ("<%=WindowsPWDStrength%>" == "1") {
                if (!/^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/.test(txtNewPwd)) {
                    err += "密码必须由字母和数字组成,至少有一个大写,一个小写,长度最少是8位\n";
               }     
            }else if ("<%=MandatoryPassword%>" == "1") {
                if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/.test(txtNewPwd)) {
                    err += "密码必须由字母和数字组成长度6到16位\n";
                }
            }
            if (txtNewPwd != txtCfmNewPwd) {
                err += "<%=Resources.Messages.EnterPasswordsDiffer %>\n";
            }
            if (err != "") {
                alert(err.toString());
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.ChangeCurrentUserPwd(JsDesEncrypt(txtOldPwd), JsDesEncrypt(txtNewPwd), IsGroup);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.ChangePwdSuccessed %>\n您需要重新登录系统");
            window.parent.location = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Login";
            
        }
    </script>
</asp:Content>
