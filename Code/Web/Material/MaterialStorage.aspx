<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MaterialStorage.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialStorage" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
     <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.DeliverNo%>
            </td>
            <td class="Field3">
                <input type="text" id="txtDeliverNo" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.PONO%>
            </td>
            <td class="Field3">
                <input type="text" id="txtPONO" class="TextBox" runat="server" />
            </td>
           <td class="Label3">
                <%=Resources.lang.InStockNo%>
            </td>
             <td class="Field3">
               <input type="text" id="txtInStockNo" class="TextBox" runat="server" />
            </td>
        </tr>
         <tr>
               <td class="Label3">
                <%=Resources.lang.InspectionOrderNo%> 
            </td>
            <td class="Field3">
                   <input type="text" id="txtInspectionNo" class="TextBox" runat="server" />
            </td>
                <td class="Label3">
                <%=Resources.lang.MaterialCode%>
            </td>
            <td class="Field3">
                 <input type="text" id="txtItemCode" class="TextBox" runat="server" />
            </td>
             <td class="Label3">
                <%=Resources.lang.VendorCode%>
            </td>
             <td class="Field3">
                <input type="text" id="txtVendorCode" class="TextBox" runat="server" />
            </td>
           
         </tr>
         
        <tr>
          <td class="Label3">
              <%=Resources.lang.InStockBy%>   
            </td>
            <td class="Field3">
                 <input type="text" id="txtInStockBy" class="TextBox" runat="server" />
            </td> 
             <td class="Label3">
                <%=Resources.lang.ReceiptTime%>
            </td>
            <td class="Field3">
                 <asp:TextBox CssClass="DateTimeBox" ID="txtReceiptTimeStart" style="width:76px;" runat="server"></asp:TextBox> - <asp:TextBox CssClass="DateTimeBox" ID="txtReceiptTimeEnd"  style="width:76px;" runat="server"></asp:TextBox>
            </td>
           <td class="Label3">
              订单号
            </td>
            <td class="Field3">
                <input type="text" id="txtSOCode" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
            <Columns>
                <asp:BoundField DataField="ModifyDateTime" HeaderText="入库时间" SortExpression="ModifyDateTime" HeaderStyle-Width="140px" />
                <asp:BoundField DataField="MaterialStorageNo" HeaderText="入库单号" SortExpression="MaterialStorageNo"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="DeliverNo" HeaderText="送货单号"  SortExpression="DeliverNo"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="CreateDateTime" HeaderText="收料时间"  SortExpression="CreateDateTime"  HeaderStyle-Width="140px" />
                <asp:BoundField DataField="POCode" HeaderText="收料单号" SortExpression="CreateDateTime"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="POCode" HeaderText="采购单号" SortExpression="POCode"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="POType" HeaderText="采购类型" SortExpression="POType"  HeaderStyle-Width="120px" />
                 <asp:BoundField DataField="SOCode" HeaderText="订单号" SortExpression="SOCode" HeaderStyle-Width="150px"/>
                <asp:BoundField DataField="InspectionNo" HeaderText="检验单号" SortExpression="InspectionNo"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编号" SortExpression="ItemCode"  HeaderStyle-Width="180px" />
                <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="ItemSpec" HeaderText="物料规格" SortExpression="ItemSpec"  HeaderStyle-Width="300px" />
                <asp:BoundField DataField="SuplierCode" HeaderText="供应代码" SortExpression="SuplierCode" />
                <asp:BoundField DataField="VendorName" HeaderText="供应名称" SortExpression="VendorName"  HeaderStyle-Width="180px" />
                <asp:BoundField DataField="InspectionQty" HeaderText="收料数量"  HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="QualifiedQty" HeaderText="合格数量"  HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="StorageQty" HeaderText="入库数量"  HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="Units" HeaderText="单位" HeaderStyle-Width="60px"/>
                <asp:BoundField DataField="InspectionResult" HeaderText="检验结果" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="ManageResult" HeaderText="处理方式" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="ISGRN" HeaderText="是否条码管控" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="WarehouseNo" HeaderText="入库仓编码"  HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="BarCode" HeaderText="库位编码"  HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="CreateBy" HeaderText="入库人"  HeaderStyle-Width="80px"/>
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
            SelectMethod="GetAll" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
   
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        _isHms = false; /*日期控件开启时分秒*/

    </script>
</asp:Content>
