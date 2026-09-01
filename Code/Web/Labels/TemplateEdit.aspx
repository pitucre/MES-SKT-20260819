<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="TemplateEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.TemplateEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable" style="min-width: 645px;">
        <tr>
            <td class="Label1">模板名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTempName" runat="server" IsRequired="1" CssClass="TextBox"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">宽度(MM)
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPanelWidth" runat="server" CssClass="NumericBox50" Text="90" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">高度(MM)
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPanelHeight" runat="server" CssClass="NumericBox50" Text="60" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <asp:HiddenField ID="txtTempSet" runat="server" Value="" />
        <asp:HiddenField ID="txtTempId" runat="server" Value="-1" />
    </table>
    <script type="text/javascript">
        /*保存数据*/
        function Save() {
            var entity = {};
            entity.TempId = $("#<%= this.txtTempId.ClientID %>").val();
            entity.TempName = $("#<%= this.txtTempName.ClientID %>").val();
            entity.PanelHeight = $("#<%= this.txtPanelHeight.ClientID %>").val();
            entity.PanelWidth = $("#<%= this.txtPanelWidth.ClientID %>").val();
            entity.TempSet = $("#<%= this.txtTempSet.ClientID %>").val();
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            entity.ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            if (entity.TempName == "")
                return;
            if (entity.PanelHeight == "")
                return;
            if (entity.PanelWidth == "")
                return;
            entity.PanelHeight = parseFloat(parseFloat(parseFloat(entity.PanelHeight) / 0.3527).toFixed(3));
            entity.PanelWidth = parseFloat(parseFloat(parseFloat(entity.PanelWidth) / 0.3527).toFixed(3));

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.TemplateEdit(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>');
                parent.window.UpdateList();
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
    </script>
</asp:Content>
