<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="AnormalGroupEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalGroupEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                异常类型名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtGroupName" runat="server" IsRequired='1' MaxLength="20"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                异常类型代码
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtGroupCode" CssClass="TextBox" runat="server" MaxLength="20"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var AnormalGroupId = '<%= Request.QueryString["ID"] %>';
        function Save() {
            var txtGroupName = $.trim($("#<%=this.txtGroupName.ClientID %>").val());
            var txtGroupCode = $("#<%=this.txtGroupCode.ClientID %>").val();

            txtGroupName = $.trim(txtGroupName);
            txtGroupCode = $.trim(txtGroupCode);

            var entity = {};
            entity.AnormalGroupId = AnormalGroupId;
            entity.AnormalGroupCode = txtGroupCode;
            entity.AnormalGroupName = txtGroupName;
            entity.ControlShow = "";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAnormal.EditAnormalGroup(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%= Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtGroupName);
        }
    </script>
</asp:Content>
