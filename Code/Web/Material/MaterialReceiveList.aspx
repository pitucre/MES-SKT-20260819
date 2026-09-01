<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialReceiveList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialReceiveList" %>

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
                <%=Resources.lang.IQCNo%>
            </td>
            <td class="Field3">
                <input type="text" id="txtIQCNo" class="TextBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.ReceiveStatus%>
            </td>
            <td class="Field3">
                <select id="Status">
                    <option value="-1">所有</option>
                    <option value="1">待检验</option>
                    <option value="2">已检验</option>
                    <option value="3">已退货</option>
                    <option value="4">已交接</option>
                    <option value="5">已入库</option>
                </select>
                <asp:HiddenField ID="hfStatus" runat="server" Value="-1" />
               <span>IQC检验结果</span> 
                <select id="CheckResult">
                    <option value="-1">所有</option>
                    <%--<option value="">待检验</option>--%>
                    <option value="不合格">不合格</option>
                    <option value="合格">合格</option>
                </select>
                <asp:HiddenField ID="hfCheckResult" runat="server" Value="" />
            </td>
            <td class="Label3">
                收料人
            </td>
            <td class="Field3">
                <input type="text" id="txtCreateBy" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.MaterialCode%>
            </td>
            <td class="Field3">
                <input type="text" id="ItemCode" class="TextBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.VendorCode%>
            </td>
            <td class="Field3">
                <input type="text" id="txtVendorCode" class="TextBox" runat="server" />
            </td>
            <td class="Label3">送货时间
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtDeliveryTimeStart" Style="width: 76px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtDeliveryTimeEnd" Style="width: 76px;" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">收料时间
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtReceiveTimeStart" Style="width: 76px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtReceiveTimeEnd" Style="width: 76px;" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
             <td class="Label3">
              订单号
            </td>
            <td class="Field3">
                <input type="text" id="txtSOCode" class="TextBox" runat="server" />
            </td>
            <td class="Label3">未打印送检单</td>
             <td class="Field3">
                 <asp:CheckBox ID="chkIsPrint" runat="server" /></td>
            <td class="Label3">IQC判定结果方式</td>
            <td class="Field3">
                <select name="selIQCResult" id="selIQCResult" runat="server">
                    <option value="" selected="selected">所有</option>
                    <option value="-3">待处理</option>
	                <option value="2">批量退货</option>
	                <option value="3">特采</option>
	                <option value="4">挑选</option>
                </select>  
            </td>
             
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">

    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="InspectionNo" HeaderText="检验单号" SortExpression="InspectionNo" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="POCode" HeaderText="采购单号" SortExpression="POCode" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="SOCode" HeaderText="订单号" SortExpression="SOCode" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="DeliverNo" HeaderText="送货单号" SortExpression="DeliverNo" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="DeliverCreateDateStr" HeaderText="送货时间" SortExpression="DeliverCreateDateStr" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="收料时间" SortExpression="CreateDateTime" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="收料人" SortExpression="CreateBy" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="StatusDesc" HeaderText="收料状态" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="CheckResult" HeaderText="IQC检验结果" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="ManageResult" HeaderText="IQC判定结果方式" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="ItemSpec" HeaderText="物料规格" SortExpression="ItemSpec" HeaderStyle-Width="240px"/>
            <asp:BoundField DataField="VendorCode" HeaderText="供应商代码" SortExpression="VendorCode" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" SortExpression="VendorName" HeaderStyle-Width="180px"/>
            
            <asp:TemplateField HeaderText="送货数量" SortExpression="SentQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("SentQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="收料数量" SortExpression="InspectionQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("InspectionQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="合格数量" SortExpression="QualifiedQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("QualifiedQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="不合格数量" SortExpression="NCQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("NCQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
           
            <%--<asp:BoundField DataField="UrgentLevel" HeaderText="紧急情况" />--%>
            <asp:BoundField DataField="IsNeedPrint" HeaderText="是否条码管控" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="PrintQty" HeaderText="打印次数" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="PrintUser" HeaderText="打印人" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="PrintTime" HeaderText="打印时间" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="RePrintUser" HeaderText="重打印人" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="RePrintTime" HeaderText="重打印时间" HeaderStyle-Width="80px"/>            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" OnValueChanged="Operate_Changed"/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        _isHms = false; /*日期控件开启时分秒*/
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        $(function () {
            gridCellsChangeNo = true;
            $("#Status").val($("#<%=this.hfStatus.ClientID %>").val());
            $("#CheckResult").val($("#<%=this.hfCheckResult.ClientID %>").val());

            $("#Status").bind("change", function () {
                $("#<%=this.hfStatus.ClientID %>").val($(this).val());
            });

            $("#CheckResult").bind("change", function () {
                $("#<%=this.hfCheckResult.ClientID %>").val($(this).val());
            });

        });
        //导出
        function Import() {
            $("#hdnOperate").val("exportExcel");
            document.forms[0].submit();
            $("#hdnOperate").val("");
        }
        function IQCOrderPdfPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            hdnOperate.val("iqcorderreportpdfprint");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //打印送检单
        function IQCRecivePdfPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.ReceivePrintRecord(idStr, 1);
            if (ajax.error != null) {
                alert(ajax.error.Message);                
                return false;
            }
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/IQCReceiveFormPrint.aspx?name=IQCRecivePdfPrint&ID=" + idStr); 
        }

        //重新打印送检单
        function IQCRecivePdfRePrint() {
            var idStr = getRecordIdString();
            
            if (idStr == "") return false;
            var idArr = idStr.split(",");
            for (var i = 0; i < idArr.length; i++) {                 
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.ReceivePrintRecord(idArr[i], 2);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }
            
           window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/IQCReceiveFormPrint.aspx?name=IQCRecivePdfPrint&ID=" + idStr); 
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialReceiveDtl.aspx?ID=" + idStr;
            dialog({ title: "收料GRN明细信息", src: openWinUrl, width: 1100, height: 500 });
           
        }
    </script>
</asp:Content>
