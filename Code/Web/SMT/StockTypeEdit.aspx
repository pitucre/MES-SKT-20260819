<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StockTypeEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.SMT.StockTypeEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%=Resources.lang.StockTypeCode %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTurnoverTypeCode" runat="server" IsRequired='1' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.StockTypeName %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTurnoverTypeName" runat="server" IsRequired='1' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">

        var Id = '<%= Request.QueryString["Id"]%>';

        function Save() {
            var txtTurnoverTypeCode = $("#<%=this.txtTurnoverTypeCode.ClientID %>").val();
            var txtTurnoverTypeName = $("#<%=this.txtTurnoverTypeName.ClientID %>").val();

            var entity = {};
            entity.StockTypeId = Id;
            entity.StockTypeCode = txtTurnoverTypeCode;
            entity.StockTypeName = txtTurnoverTypeName;

            var ajax_Turnover = SKT.LeanMES.Web.AjaxServices.AjaxStock.EditStockType(entity);
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
