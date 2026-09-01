<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="MaterialUnitList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialUnitList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server" ViewStateMode="Enabled">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">物料条码
            </td>
            <td class="Field3">
                <input type="text" id="txtSerialNumber" class="TextBox" runat="server" clientidmode="Static" />
            </td>
            <td class="Label3">供应商
            </td>
            <td class="Field3">
                <input type="text" id="txtVendor" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.Status%>
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlMaterialStatus">
                </asp:DropDownList>
            </td>
            
        </tr>
        <tr>
            <%--<td class="Label3">产品编码
            </td>
            <td class="Field3">
                <input type="text" id="txtItemCode" class="TextBox" runat="server" />
            </td>--%>
            <td class="Label3">物料编码
            </td>
            <td class="Field3">
                <input type="text" id="txtItemCode" class="TextBox" runat="server" />
            </td>
            
            <td class="Label3">物料名称
            </td>
            <td class="Field3">
                <input type="text" id="txtItemName" class="TextBox" runat="server" />
            </td>

            <td class="Label3">物料规格
            </td>
            <td class="Field3">
                <input type="text" id="txtItemSpec" class="TextBox" runat="server" />
            </td>            
        </tr>
        <tr>
            <td class="Label3">生成物料条码时间
            </td>
            <td class="Field3" >
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
                <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
            <%--<td class="Label3">库位条码
            </td>
            <td class="Field3">
                <input type="text" id="txtBarCode" class="TextBox" runat="server" />
            </td>--%>
             <td class="Label3">模糊查询
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlSearch">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="msm.CName">创建人</asp:ListItem>
                    <asp:ListItem Value="D.POrder">采购单号</asp:ListItem>
                    <asp:ListItem Value="E.ApplyNo">领料单号</asp:ListItem>
                    <asp:ListItem Value="D.IQCOrder">IQC单号</asp:ListItem>
                  <%--  <asp:ListItem Value="W.CWhName">仓库</asp:ListItem>--%>
                    <asp:ListItem Value="ED.SOCode">订单号</asp:ListItem>
                    <asp:ListItem Value="D.DeliveryOrder">送货单</asp:ListItem>
                    <asp:ListItem Value="A.cBarCode">库位条码</asp:ListItem>
                    <asp:ListItem Value="A.SupplierOrderNumber">工单号</asp:ListItem>
                    <asp:ListItem Value="D.SaleReturnNo">销退单号</asp:ListItem>
                </asp:DropDownList>
                <input type="text" id="txtSearch" class="TextBox" runat="server" />
            </td>
            
            <td class="Label3">仓库
            </td>
            <td class="Field3">

                <asp:TextBox ID="txtWhCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                    value="..." title="选择仓库" />
                <input type="hidden" id="hdnWhID" name="hdnWhID" value="-1" runat="server" clientidmode="Static" />
            </td>            
        </tr>
        <tr>
            <td class="Label3">批次号
            </td>
            <td class="Field3">
                <input type="text" id="txtLotCode" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                包装箱条码
            </td>
            <td class="Field3">
                 <input type="text" id="txtBoxGRN" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
            </td>
            <td class="Field3">
                
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound"
        style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码" SortExpression="SerialNumber" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="BoxGRN" HeaderText="包装箱条码" SortExpression="BoxGRN" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="CBarCode" HeaderText="库位条码" SortExpression="CBarCode" HeaderStyle-Width="140px"/>
            <asp:TemplateField HeaderText="最初数量" SortExpression="Quantity"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("Quantity","{0:G0}").ToString().IndexOf("E")>-1?Eval("Quantity","{0:G}").ToString():Eval("Quantity","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="可用数量" SortExpression="BalanceQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("BalanceQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("BalanceQty","{0:G}").ToString():Eval("BalanceQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>            
            <asp:BoundField DataField="Statusname" HeaderText="状态"  HeaderStyle-Width="130px" />
            <asp:BoundField DataField="ShelfLife" HeaderText="质保期(天)" SortExpression="ShelfLife" HeaderStyle-Width="80px"/>
            <asp:TemplateField HeaderText="过期日期" SortExpression="ExpiredDate"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("ExpiredDate").ToString().IndexOf("9999/12/31")>-1?"":String.Format("{0:yyyy-MM-dd}",Eval("ExpiredDate")) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName" HeaderStyle-Width="240px"/>
            <asp:BoundField DataField="ItemModel" HeaderText="物料规格" SortExpression="ItemModel" HeaderStyle-Width="350px"/>
            <asp:BoundField DataField="Units" HeaderText="单位" SortExpression="Units" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="VendorCode" HeaderText="供应商" SortExpression="VendorCode" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" SortExpression="VendorName" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="POorder" HeaderText="采购单号" SortExpression="POrder" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="DeliveryOrder" HeaderText="送货单号" SortExpression="DeliverNo" HeaderStyle-Width="130px"/>
             <asp:BoundField DataField="SOCode" HeaderText="订单号" SortExpression="SOCode" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="IqcBatchNo" HeaderText="IQC单号" SortExpression="IQCOrder" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="ApplyNo" HeaderText="领料单号" SortExpression="ApplyNo" HeaderStyle-Width="130px"/>
             <asp:BoundField DataField="SupplierOrderNumber" HeaderText="工单号" SortExpression="SupplierOrderNumber" HeaderStyle-Width="130px"/>
            
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="生成物料条码时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="PackTime" HeaderText="入库时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"
                SortExpression="StorageDate" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="CWhName" HeaderText="仓库" SortExpression="CWhName" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="DateCode" HeaderText="生产日期" DataFormatString="{0:yyyy-MM-dd}"
                SortExpression="DateCode"  HeaderStyle-Width="80px"/>            
            <asp:BoundField DataField="MPN" HeaderText="MPN" SortExpression="MPN" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="WeekCode" HeaderText="生产日期(周)" SortExpression="WeekCode" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="LotCode" HeaderText="批次号" SortExpression="LotCode" HeaderStyle-Width="130px"/>        
            <asp:BoundField DataField="Remark" HeaderText="备注"  HeaderStyle-Width="130px"/>        
            <asp:BoundField DataField="SaleReturnNo" HeaderText="销退单号" SortExpression="POrder" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="SaleReturnCustomerCode" HeaderText="销退客户" SortExpression="POrder" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="SaleReturnCustomerName" HeaderText="销退客户名称" SortExpression="POrder" HeaderStyle-Width="130px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetMaterialInfoAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var PrintGrn = "";
        $(function () {
            gridCellsChangeNo = true;
            $(".DateTimeBox").datepicker({
                showOn: "both",
                buttonImageOnly: true,
                buttonText: "<%=Resources.lang.ChooseDate %>"
            });

            if ('<%=Request.Form["selStatus"] %>' != null && '<%=Request.Form["selStatus"] %>' != "") {
                $("#selStatus").val('<%=Request.Form["selStatus"] %>');
            }
            $(document).ready(function () {
                if ($("#txtSerialNumber").val() !== "") {
                    $("#txtSerialNumber").select();
                }
            });
        });
        /*生成GRN条码*/
        function GenerateGRN() {
            dialog({ title: "<%= Resources.Pages.Material_GenerateGRN %>", src: "GenerateGRN.aspx?name=Material_GenerateGRN&rnd=" + Math.random(), width: 625, height: 300, onClosed: "updatelist" });
        }

        function getCheckedValue(a) {
            var b = "", c = $("input[name='chkSelect']:checked");
            return c.length == 0 ? false : c.length > 1 ? false : b = c[0].parentElement.parentElement.cells[GetGridCellsChangNo(a)].innerText, b;
        }

        /*刷新页面*/
        function refresh() {
            document.forms[0].submit();
        }
        /*打印GRN条码*/
        function Print() {
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 SerialNumber
            var cellStr = getRecordCellTextsByFiled("SerialNumber"); 
            if (cellStr == "") {
                return false;
            }
            printGRN = cellStr;
            dialog({ title: "<%= Resources.Pages.Material_ReprintGRN %>", src: "ReprintGRN.aspx?name=Material_GenerateGRN&rnd=" + Math.random(), width: 450, height: 200 });
        }
        /*打印GRN条码*/
        function PrintSaleReturnGRN() {
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 SerialNumber
            var cellStr = getRecordCellTextsByFiled("SerialNumber");
            if (cellStr == "") {
                return false;
            }
            printGRN = cellStr;
            dialog({ title: "销退条码补打", src: "PrintSaleReturnGRN.aspx?name=Material_PrintSaleReturnGRN&rnd=" + Math.random(), width: 450, height: 200 });
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialUnitEdit.aspx?ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Material_MaterialInfo %>", src: openWinUrl, width: 750, height: 400 });
        }
        function View() {
            Edit();
        }

        function ImportToExcel() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        function EditQuantity() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //增加状态验证2017-3-17
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 16>6 改为 Statusname
            var resultState = getOneRecordCellTextByFiled("Statusname");
            if (resultState == '前置加工' || resultState == '开拉' || resultState == '手插'
                || resultState == '物料暂收' || resultState == '用完' || resultState == '报废'
                || resultState == '在供应商已生成送货单') {
                alert('不能修改此状态的物料数量');
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/GRNModify.aspx?ID=" + idStr;
            dialog({ title: mesLang("修改GRN可用数量"), src: openWinUrl, width: 400, height: 250 });
        }
        /*删除*/
        function Delete() {
            var idStr = getRecordIdString();
            if (idStr == "") return;
            if (!window.confirm(ConfirmDelete)) {
                return false;
            }
            var ajaxDelete = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.DeleteGRN(idStr, 1);
            if (ajaxDelete.error != null) {
                alert(ajaxDelete.error.Message);
                return false;
            }

            alert("<%= Resources.Messages.DeleteSuccess %>");
            document.forms[0].submit();
        }

        //修改GRN状态
        function UpdateGRNState() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/UpdateGRNState.aspx?name=UpdateGRNState&ID=-1";
            dialog({ title: mesLang("修改GRN状态"), src: openWinUrl, width: 700, height: 400 });
        }

        //报废
        function Scrap() {
            var idStr = getRecordIdString();
            if (idStr == "") return;
            var ajaxAjax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GRNCheckOperation(idStr);
            if (ajaxAjax.error != null) {
                alert(ajaxAjax.error.Message);
                return false;
            }
            if (confirm('确定报废?')) {
                debugger;
                var ajaxAjax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckGrnIsPacking(idStr);
                if (ajaxAjax.error != null) {
                    alert(ajaxAjax.error.Message);
                    return false;
                }
                if (ajaxAjax.value != null && ajaxAjax.value.Rows.length > 0) {
                    var msg = "[" + ajaxAjax.value.Rows[0]['SerialNumber'] + "]条码被包装到箱号[" + ajaxAjax.value.Rows[0]['PackingGRN'] + "]内\r\n请先确认是否移除当前条码进行报废？";
                    if (!confirm(msg)) {
                        $("#GRN").focus();
                        $("#GRN").select();
                        return false;
                    }
                }
                var ajaxDelete = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.FailGRNByVenCode(idStr);
                if (ajaxDelete.error != null) {
                    alert(ajaxDelete.error.Message);
                    return false;
                }
                alert("报废成功！");
                document.forms[0].submit();
            }
        }
        //选择仓库
        function selectWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setWhCode(list) {
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtWhCode.ClientID %>").val(whCodes);
            $("#hdnWhID").val(list[0][0]);
        }

        function clearDataTime()
        {
            $(".DateTimeBox").val("");
        }
    </script>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
</asp:Content>
