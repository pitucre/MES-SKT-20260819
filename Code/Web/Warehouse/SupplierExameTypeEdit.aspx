<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierExameTypeEdit.aspx.cs" MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.SupplierExameTypeName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtExameType" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50" Width="235"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" MaxLength="50"
                    Height="80px" Width="235px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var supplierExameTypeId = '<%=Request.QueryString["ID"]%>';
        var strError = "";
        /*保存数据*/
        function Save() {
            txtExameType = $.trim($("#<%=this.txtExameType.ClientID%>").val());
            txtRemark = $("#<%=this.txtRemark.ClientID%>").val();
            if (!isNull(strError)) {
                alert(strError.toString());
                return false;
            }

            var entity = {};

            entity.SupplierExameTypeId = supplierExameTypeId;
            entity.ExameType = txtExameType;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.SupplierExameTypeEdit(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
                parent.window.UpdateList(txtExameType);
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
    </script>
</asp:Content>

