<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="SubSystemsEdit.aspx.cs" Inherits="SKT.LeanMES.Web.CustomMenu.SubSystemsEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                序号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSequence" runat="server" CssClass="NumericBox50" Text="1" IsRequired="1" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                一级菜单名称(中文)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtKeyCNValues" MaxLength="20" runat="server" IsRequired="1"  CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                一级菜单名称(英文)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtKeyENValues" MaxLength="20" runat="server" IsRequired="1"  CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" MaxLength="20" runat="server"  CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var FatherKey = '<%=Request.QueryString["ID"]%>';
        function Save() {
            var KeyCNValues = $("#<%=this.txtKeyCNValues.ClientID %>").val();
            var KeyENValues = $("#<%=this.txtKeyENValues.ClientID %>").val();
            var seq = $("#<%=this.txtSequence.ClientID %>").val();
            var Remark = $("#<%=this.txtRemark.ClientID %>").val();
            var error = "";
            if ($.trim(seq) == "") {
                error += "菜单序号不能为空，且只能为数字。\n";
             }
            if ($.trim(KeyCNValues) == "") {
                error += "请输入菜单中文名称\n";
            }
            if ($.trim(KeyCNValues) == "") {
                error += "请输入菜单英文名称\n";
            }
            if (!isNumber(seq)) {
                error += "序号只能输入数字\n";
            }
            if (error != "") {
                alert(error);
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCustomMenu.EditCustomMenu(KeyCNValues, KeyENValues, seq, FatherKey, Remark);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("保存成功！(因系统权限需要,请重新刷新'网页'或者重新登陆系统查看新增的一级菜单)");

            parent.UpdateList(KeyCNValues);
        }
    </script>
</asp:Content>

