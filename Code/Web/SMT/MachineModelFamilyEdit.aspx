<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MachineModelFamilyEdit" Title="Edit MODEL_FAMILY"
    CodeBehind="MachineModelFamilyEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.ModelFamilyName %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtModelFamilyName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field1" colspan="3">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var ModelFamilyID = '<%= Request.QueryString["ID"] %>';

        function Save() {
            var errStr = "";
            var txtModelFamilyName = $("#<%= this.txtModelFamilyName.ClientID %>").val();
            var txtDescription = $("#<%= this.txtDescription.ClientID %>").val();
            if (txtModelFamilyName.length <= 0) {
                errStr += "<%= Resources.Messages.ModelFamilyNameEmpty %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var entity = {};
            entity.ModelFamilyID = ModelFamilyID;
            entity.ModelFamilyName = txtModelFamilyName;
            entity.Description = txtDescription;
            entity.Remark = "";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceMachineModel.EditMachineModelFamily(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList(txtModelFamilyName);
        }
    </script>
</asp:Content>
