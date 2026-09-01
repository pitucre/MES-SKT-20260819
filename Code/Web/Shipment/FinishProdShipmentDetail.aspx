<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="FinishProdShipmentDetail.aspx.cs" Inherits="SKT.LeanMES.Web.Shipment.FinishProdShipmentDetail" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <div class="divHeader">
        出货基本信息<label class="jslblProduct lblprompt"></label></div>
    <table class="EditeContentTable" width="100%">
        <tr>
         <td class="Label3">
                出货单号
            </td>
            <td class="Field3">
                <asp:Label ID="txtCode" runat="server"></asp:Label>
            </td>

            <td class="Label3">
                销售出货单
            </td>
            <td class="Field3">
                <asp:Label ID="txtSOCode" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                客户
            </td>
            <td class="Field3">
                <asp:Label ID="txtCusCode" runat="server"></asp:Label>
            </td>
           
        </tr>
        <tr>
             <td class="Label3">
                计划出货时间
            </td>
            <td class="Field3">
                <asp:Label ID="txtDate" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                计划出货数量
            </td>
            <td class="Field3">
                <asp:Label ID="txtPlanQty" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                已出货数量
            </td>
            <td class="Field3">
                <asp:Label ID="txtOutStorageQty" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%--<asp:BoundField DataField="SOCode" HeaderText="销售订单号" />--%>
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="PlanQty" HeaderText="计划出货数量" />
           <asp:BoundField DataField="OutStorageQty" HeaderText="已出货数量" />
            <asp:BoundField DataField="ShipDate" HeaderText="出货时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Shipment.BLL.ShipmentRecord"
        SelectMethod="GetAllDetail" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $("#ckbMultipleSelected").parent().hide();
            $("#Button1").parent().hide();
            $("#searchSubmit").parent().hide();
            $("#chkMatchWholeWord").parent().hide();                        
        })
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (idStr < 0) {
                alert("没有出货明细相关的条码信息！");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Shipment/FinishProdShipView.aspx?name=Production_FinishProdShipView&ID=" + idStr;
            dialog({ title: "查看出货明细相关条码信息", src: openWinUrl, width: 900, height: 400 });
        }
          
    </script>
</asp:Content>
