<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StockCarEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.StockCarEdit"
    MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                备料车编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTurnoverTypeCode" runat="server" IsRequired='1' CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                备料车类型<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlStockType" runat="server" ClientIDMode="Static" Width="100"
                    IsRequired='1'>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                最小数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMinQty" runat="server" IsRequired='1' onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" CssClass="NumericBox50"
                    Width="60px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                最大数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxQty" runat="server" IsRequired='1' onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" CssClass="NumericBox50"
                    Width="60px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">

        var Id = '<%= Request.QueryString["Id"]%>';

        function Save() {
            var txtTurnoverTypeCode = $("#<%=this.txtTurnoverTypeCode.ClientID %>").val();
            var ddlStockTypeId = $("#ddlStockType").val();
            var txtMinQty = $("#<%=this.txtMinQty.ClientID %>").val();
            var txtMaxQty = $("#<%=this.txtMaxQty.ClientID %>").val();
            var txtRemark = $("#<%=this.txtRemark.ClientID %>").val();

            if (ddlStockTypeId == "") {
                alert("请选择备料车类型!");
                return false;
            }
            if (parseInt(txtMinQty) > parseInt(txtMaxQty)) {
                alert("最小数量不能大于最大数量！");
                $("#<%= this.txtMaxQty.ClientID %>").focus();
                return false;
            }

            var entity = {};
            entity.StockCarId = Id;
            entity.StockCarNumber = txtTurnoverTypeCode;
            entity.StockTypeId = ddlStockTypeId;
            entity.MinQty = txtMinQty;
            entity.MaxQty = txtMaxQty;
            entity.Remark = txtRemark;


            var ajax_Turnover = SKT.LeanMES.Web.AjaxServices.AjaxStock.EditStockCar(entity);
            if (ajax_Turnover.error != null) {
                alert(ajax_Turnover.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveSuccess %>");
            }

            parent.window.UpdateList(txtTurnoverTypeCode)

        }
    </script>
</asp:Content>
