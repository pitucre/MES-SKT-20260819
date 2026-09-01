<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" 
CodeBehind="ShipmentEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Shipment.ShipmentEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
  <table id="ShipmentTable" width="100%" class="EditeContentTable">
     
        <tr>
            <td class="Label2"> <%= Resources.lang.ShippingOrderNumber%></td>
            <td class="Field2">
                <asp:Label ID="lbOrderNO" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2"> <%= Resources.lang.Status%></td>
            <td class="Field2">
                <asp:Label ID="lbState" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ItemName%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false"></asp:TextBox>
                 <input id="button2" class="ButtonBox" type="button" onclick="selectItems()" value="..." IsRequired='1' title="选择产品" /> 
                <asp:HiddenField ID="hdItemId" runat="server" Value="0" />
            </td>
            <td class="Label2"><%= Resources.lang.Qty%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" IsRequired='1' IsNumber='1' MinValue='1'></asp:TextBox>
                 &nbsp;<asp:Label ID="lbUnit" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ShipDate%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtShipDate" runat="server" CssClass="DateTimeBox"  IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.Remark%></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var shipmentId = '<%=Request.QueryString["ID"]%>';
        $(function () {
            if (parseInt(shipmentId) == -1) {
                var trObj = $("#ShipmentTable").find("tr");
                $(trObj[0]).css("display", "none");
            }
        });

        /*保存数据*/
        function Save() {
            var txtItemId = $("#<%=this.hdItemId.ClientID %>").val();
            var txtQty = $("#<%=this.txtQty.ClientID%>").val();
            var txtShipDate = $("#<%=this.txtShipDate.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};
            entity.OrderNO = "";
            entity.ShipmentId = shipmentId
            entity.ItemId = txtItemId;
            entity.QtyStr = txtQty;
            entity.ShipDateStr = txtShipDate;
            entity.Remark = txtRemark;
            entity.AuditBy = "";
            entity.RejectBy = "";
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShipment.ShipmentEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else if (parseInt(ajax.value) == -1) {
                alert('<%=Resources.Messages.AuditOrShipmentNotDelete %>')
            }
            else if (parseInt(ajax.value) > 0) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
            }
            parent.window.Refresh();
        }

        function selectItems() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValueItems&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValueItems(list) {
            $("#<%=this.hdItemId.ClientID %>").val(list[0][0]);
            $("#<%=this.txtItemName.ClientID %>").val(list[0][1]);
            $("#<%=this.lbUnit.ClientID %>").html(list[0][5]);
        }

    </script>

</asp:Content>
