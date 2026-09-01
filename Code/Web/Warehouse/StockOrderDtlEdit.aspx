<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" 
    AutoEventWireup="true" CodeBehind="StockOrderDtlEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.StockOrderDtlEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
 <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired %></div>
   <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                销售单号<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtSalOrderNo" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
            <td class="Label2">
                产品编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" IsRequired='1'></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." title="Select" onclick="selectItem();" />
                <asp:HiddenField id="hdnItemId" runat="server" ClientIDMode="Static" Value="-1"/>
            </td>
        </tr>
       <tr>
            <td class="Label2">
                订单号
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtCustomerOrder" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
            <td class="Label2">
                项次
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtSalorderItem" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                计划出货量<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtPlanQty" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
            <td class="Label2">
                当前备货量
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtCurrentQty" CssClass="TextBox" Text="0" ClientIDMode="Static" Width="80%" Enabled="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                车牌号
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtCarNo" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
            <td class="Label2">
                货柜号
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtContainerNo" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                封条号
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtSealNo" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
            <td class="Label2">
                备注
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtRemark" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
        </tr>
       
    </table>
   
    <script type="text/javascript">
        var SalOrderID = '<%=Request.QueryString["SalOrderID"]%>';
        var SalOrderDtlID = '<%=Request.QueryString["ID"]%>';
        function selectItem() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 660, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtItemCode").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
        }

        function Save() {
            var SalOrderNo = $("#txtSalOrderNo").val();
            var ItemCode = $("#txtItemCode").val();
            var ItemID = $("#hdnItemId").val();
            var PlanQty = $("#txtPlanQty").val();
            var CurrentQty = $("#txtCurrentQty").val();
            var CarNo = $("#txtCarNo").val();
            var ContainerNo = $("#txtContainerNo").val();
            var SealNo = $("#txtSealNo").val();
            var Remark = $("#txtRemark").val();
            var CustomerOrder = $("#txtCustomerOrder").val();
            var SalorderItem = $("#txtSalorderItem").val();
            if (!PlanQty) {
                alert("请填写计划出货量！");
                return false;
            }
            
            var entity = {};
            entity.SalOrderDtlID = SalOrderDtlID;
            entity.SalOrderID = SalOrderID;
            entity.SalOrderNo = SalOrderNo;
            entity.ItemCode = ItemCode;
            entity.ItemID = ItemID;
            entity.PlanQty = parseFloat(PlanQty);
            entity.CurrentQty = parseFloat(CurrentQty);
            entity.CarNo = CarNo;
            entity.ContainerNo = ContainerNo;
            entity.SealNo = SealNo;
            entity.Remark = Remark;
            entity.CustomerOrder = CustomerOrder;
            entity.SalorderItem = SalorderItem;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.StockOrderDtlEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('保存成功！')
            parent.window.Refresh();
        }
    </script>
</asp:Content>