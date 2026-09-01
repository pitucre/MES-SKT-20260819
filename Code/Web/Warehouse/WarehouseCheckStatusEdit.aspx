<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCheckStatusEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCheckStatusEdit"
    Title="Edit WarehouseCheckStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseCheckStatusName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarehouseCheckStatusName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var warehouseCheckStatusId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtWarehouseCheckStatusName = $.trim($("#<%=this.txtWarehouseCheckStatusName.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};
            entity.Id = warehouseCheckStatusId;
            entity.ErpCode = "";
            entity.WarehouseCheckStatusId = warehouseCheckStatusId;
            entity.WarehouseCheckStatusName = txtWarehouseCheckStatusName;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheckStatus.WarehouseCheckStatusEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
