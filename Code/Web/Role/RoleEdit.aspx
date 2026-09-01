<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="RoleEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Role.RoleEdit" Title="Edit Role" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr class="addRole">
            <td class="Label1">角色名<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRoleName" runat="server" CssClass="TextBox" MaxLength="20" IsRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr class="editRole">
            <td class="Label1">角色名
            </td>
            <td class="Field1">
                <asp:Label ID="lblRoleName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">描述
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var roleId = '<%=Request.QueryString["ID"]%>';
        var IsGroup = parseInt('<%=Request.QueryString["IsGroup"]%>') == 1 ? "1" : "0";
        $(document).ready(function () {
            if (parseInt(roleId) == -1) {
                $(".addRole").show();
                $(".editRole").hide();
            }
            else {
                $(".addRole").hide();
                $(".editRole").show();
            }
        });
        /*保存数据*/
        function Save() {
            var txtRoleName = $.trim($("#<%=this.txtRoleName.ClientID%>").val());
            var txtDescription = $.trim($("#<%=this.txtDescription.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            if (parseInt(roleId) == -1) {
                /*表单验证*/
                if (isNull(txtRoleName)) {
                    alert("角色名不能为空！");
                    $("#<%=this.txtRoleName.ClientID%>").focus();
                    return false;
                }
            }
            var entity = {};
            entity.RoleID = roleId
            entity.RoleName = txtRoleName;
            entity.Description = txtDescription;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Remark = "";
            entity.IsSupper = false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.RoleEdit(entity, IsGroup);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Role/RoleEdit.aspx?name=Account_RoleEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
      
    </script>
</asp:Content>
