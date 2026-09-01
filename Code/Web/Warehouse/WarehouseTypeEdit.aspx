<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseTypeEdit"
    Title="Edit WarehouseType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseTypeName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarehouseType" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
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
        var warehouseTypeId = '<%=Request.QueryString["ID"]%>';
        var strError = "";
        /*保存数据*/
        function Save() {
            txtWarehouseType = $.trim($("#<%=this.txtWarehouseType.ClientID%>").val());
            txtRemark = $("#<%=this.txtRemark.ClientID%>").val();
            /* textbox中已经做出限制  chenglong.zhu 2016-11-23 */
//            if (checkStrLen(txtWarehouseType, 50, false)) {
//                strError += "库类型名称不能超过50字符！\n";
//            }
//            //验证备注
//            if (checkStrLen(txtRemark, 50, false)) {
//                strError += "备注不能超过50字符！\n";
//            }
            if (!isNull(strError)) {
                alert(strError.toString());
                return false;
            }

            var entity = {};

            entity.WarehouseTypeId = warehouseTypeId
            entity.WarehouseType = txtWarehouseType;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.WarehouseTypeEdit(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
                parent.window.UpdateList(txtWarehouseType);
            } else {
                alert(ajax.error.Message);
                return false;
            }

        }
    </script>
</asp:Content>
