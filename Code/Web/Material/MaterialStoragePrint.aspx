<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MaterialStoragePrint.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialStoragePrint" %>

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
               未打印入库单
            </td>
             <td class="Field3">
                <input type="checkbox" id="chkPrint" value="1"  runat="server"/>
            </td>
        </tr>
         <tr>
          <td class="Label3">
              IQC检验结果  
            </td>
            <td class="Field3">
                 <select name="selInspectionResult" id="selInspectionResult" runat="server">
                    <option value="" selected="selected">全部</option>
                    <option value="0">不合格</option>
                    <option value="1">合格</option>
                </select>
            </td> 
             <td class="Label3">
                IQC判定结果方式
            </td>
            <td class="Field3">
                 <select name="selIQCResult" id="selIQCResult" runat="server">
                    <option value="" selected="selected">全部</option>
                    <option value="-3">待处理</option>
	                <option value="2">批量退货</option>
	                <option value="3">特采</option>
	                <option value="4">挑选</option>
                </select>
            </td>
               <td class="Label3">
            </td>
             <td class="Field3">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
            <Columns>
                <asp:BoundField DataField="ModifyDateTime" HeaderText="入库时间" SortExpression="ModifyDateTime" HeaderStyle-Width="140px" />
                <asp:BoundField DataField="MaterialStorageNo" HeaderText="入库单号" SortExpression="MaterialStorageNo"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="DeliverNo" HeaderText="送货单号"  SortExpression="DeliverNo"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="CreateDateTime" HeaderText="收料时间"  SortExpression="CreateDateTime"  HeaderStyle-Width="140px" />
                <asp:BoundField DataField="POCode" HeaderText="采购单号" SortExpression="POCode"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="POTypeName" HeaderText="采购类型" SortExpression="POType"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="InspectionNo" HeaderText="检验单号" SortExpression="InspectionNo"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编号" SortExpression="ItemCode"  HeaderStyle-Width="180px" />
                <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName"  HeaderStyle-Width="120px" />
                <asp:BoundField DataField="ItemSpec" HeaderText="物料规格" SortExpression="ItemSpec"  HeaderStyle-Width="300px" />
                <asp:BoundField DataField="SuplierCode" HeaderText="供应代码" SortExpression="SuplierCode" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="VendorName" HeaderText="供应名称" SortExpression="VendorName"  HeaderStyle-Width="180px" />
                <asp:TemplateField HeaderText="收料数量" SortExpression="InspectionQty"  HeaderStyle-Width="80px">
                    <ItemTemplate>
                       <%#Eval("InspectionQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("InspectionQty","{0:G}").ToString():Eval("InspectionQty","{0:G0}").ToString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="合格数量" SortExpression="QualifiedQty"  HeaderStyle-Width="80px">
                    <ItemTemplate>
                       <%#Eval("QualifiedQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("QualifiedQty","{0:G}").ToString():Eval("QualifiedQty","{0:G0}").ToString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="入库数量" SortExpression="StorageQty"  HeaderStyle-Width="80px">
                    <ItemTemplate>
                      <%#Eval("StorageQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("StorageQty","{0:G}").ToString():Eval("StorageQty","{0:G0}").ToString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Units" HeaderText="单位" HeaderStyle-Width="60px"/>
                <asp:BoundField DataField="CheckResult" HeaderText="IQC检验结果" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="CheckType" HeaderText="IQC判定结果方式" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="ISGRN" HeaderText="是否条码管控" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="WarehouseNo" HeaderText="入库仓编码" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="BarCode" HeaderText="库位编码" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="CreateBy" HeaderText="入库人" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="Printer" HeaderText="打印人" HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="PrintDateTime" HeaderText="打印时间"  HeaderStyle-Width="140px" />
                <asp:BoundField DataField="RePrinter" HeaderText="重新打印人"  HeaderStyle-Width="80px"/>
                <asp:BoundField DataField="RePrintDateTime" HeaderText="重新打印时间"  HeaderStyle-Width="140px" />
                <asp:BoundField DataField="PrintTimes" HeaderText="打印次数" HeaderStyle-Width="80px"/>
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
    <input type="hidden" id="hdnIdString" runat="server" name="hdnIdString" value="" />
    <script type="text/javascript">
        _isHms = false; /*日期控件开启时分秒*/
        var hdnOperate = $("#hdnOperate");
         $(function () {
            gridCellsChangeNo = true;
        });
        ///打印入库单
        function Print() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 23 改为 Printer
            var printer = getOneRecordCellTextByFiled("Printer");
            if (printer.trim() != "") {
                alert("该入库单已经打印,不能重复打印")
                return false;
            }

            MaterialPrint(idStr,1)
        }

        //重新打印入库单
        function RePrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 23 改为 Printer
            var printer = getOneRecordCellTextByFiled("Printer");
            if (printer.trim() == "") {
                alert("该入库单还未打印,不能重新打印")
                return false;
            }
            MaterialPrint(idStr,2)
        }

        //打印界面调用
        function MaterialPrint(idStr,isRePrint)
        {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.MaterialStorageEdit(idStr, isRePrint);
            if (ajax.error != null) {
                return false;
            }
            Refresh();
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialStoragePrintModel.aspx?ID=" + idStr);
        }

        //刷新 
        function Refresh() {
            document.forms[0].submit();
        }

        //导出到EXCEL
        function ImportToExcel() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

    </script>
</asp:Content>
