<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLightColorEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLightColorEdit" Title="Edit WarehouseLightColor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label2"><%= Resources.lang.WarehouseLocationLightColorfunction%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtFunctionName" runat="server" CssClass="TextBox"  IsRequired='1'  MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
        
            <td class="Label2"><%= Resources.lang.WarehouseLocationLightColor%><em>*</em></td>
            <td class="Field1">
                <asp:DropDownList ID="ddlColorCode" runat="server" ClientIDMode="Static" Width="100">
                </asp:DropDownList>
            </td>
        </tr>
        
    </table>

     <script type="text/javascript">
         var functionId = '<%=Request.QueryString["ID"]%>';
         var strError = "";
         /*保存数据*/
         function Save() {
             var txtFunctionName = $("#<%=this.txtFunctionName.ClientID%>").val().trim();
             var ddlColorCode = $("#<%=this.ddlColorCode.ClientID %>").val();
             txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
             txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

             if (!isNull(strError)) {
                 alert(strError.toString());
                 return false;
             }

             var entity = {};
             entity.FunctionId = functionId;
             entity.FunctionName = txtFunctionName;
             entity.ColorCode = ddlColorCode;
             entity.CreateBy = txtCreateBy;
             entity.ModifyBy = txtModifyBy;

             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.WarehouseLightColorEdit(entity);
             if (ajax.error == null) {
                 alert('<%=Resources.Messages.SaveInSuccess%>')
                 parent.window.UpdateList();
             } else {
                 alert(ajax.error.Message);
                 return false;
             }


         }
    </script>

</asp:Content>