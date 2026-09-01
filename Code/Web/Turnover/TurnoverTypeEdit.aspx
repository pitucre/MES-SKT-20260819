<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurnoverTypeEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Turnover.TurnoverTypeEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.TurnoverTypeCode%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTurnoverTypeCode" runat="server" IsRequired='1' MaxLength='50'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.TurnoverTypeName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTurnoverTypeName" runat="server" IsRequired='1'  MaxLength='50'></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">

        var Id = '<%= Request.QueryString["Id"] %>';

        function Save() {
            var txtTurnoverTypeCode = $.trim($("#<%=this.txtTurnoverTypeCode.ClientID %>").val());
            var txtTurnoverTypeName = $.trim($("#<%=this.txtTurnoverTypeName.ClientID %>").val());

            var entity = {};
            entity.TurnoverTypeId = Id;
            entity.TurnoverTypeCode = txtTurnoverTypeCode;
            entity.TurnoverTypeName = txtTurnoverTypeName;

            var ajax_Turnover = SKT.LeanMES.Web.AjaxServices.AjaxTurnover.EditTurnoverType(entity);
            if (ajax_Turnover.error != null) {
                alert(ajax_Turnover.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveSuccess %>");
            }

            parent.window.UpdateList(txtTurnoverTypeName)

        }
    </script>
</asp:Content>
