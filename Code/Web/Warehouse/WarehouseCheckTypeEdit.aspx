<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCheckTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCheckTypeEdit"
    Title="Edit WarehouseCheckType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseCheckTypeName %><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtWarehouseCheckTypeName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.Describe %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescribe" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var warehouseCheckTypeId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtWarehouseCheckTypeName = $.trim($("#<%=this.txtWarehouseCheckTypeName.ClientID%>").val());
            var txtDescribe = $.trim($("#<%=this.txtDescribe.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};
            entity.WarehouseCheckTypeId = warehouseCheckTypeId
            entity.ErpCode = 0;
            entity.WarehouseCheckTypeName = txtWarehouseCheckTypeName;
            entity.Describe = txtDescribe;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Reserved1 = "";
            entity.Reserved2 = "";
            entity.Reserved3 = "";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheckType.WarehouseCheckTypeEdit(entity);
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
