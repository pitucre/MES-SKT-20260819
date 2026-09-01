<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="MaterialIQCReturnList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialIQCReturnList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <div id="divListPageHeader" style="height: 110px;">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">退货单号
                </td>
                <td class="Field3">
                    <input type="text" id="txtReturnNo" class="TextBox" runat="server" />
                </td>
                <td class="Label3">送货单号
                </td>
                <td class="Field3">
                    <input type="text" id="txtReveivedNO" class="TextBox" runat="server" />
                </td>
                <td class="Label3">采购单号
                </td>
                <td class="Field3">
                    <input type="text" id="txtPoCode" class="TextBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="Label3">物料编码
                </td>
                <td class="Field3">
                    <input type="text" id="txtItemCope" class="TextBox" runat="server" />
                </td>
                <td class="Label3">供应商代码
                </td>
                <td class="Field3">
                    <input type="text" id="txtVendorCode" class="TextBox" runat="server" />
                </td>
                <td class="Label3">供应商名称
                </td>
                <td class="Field3">
                    <input type="text" id="txtVendorName" class="TextBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="Label3">采购员
                </td>
                <td class="Field3">
                    <input type="text" id="txtLoweredUserName" class="TextBox" runat="server" />
                </td>
                <td class="Label3">退货时间
                </td>
                <td class="Field3">
                    <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" readonly="readonly" />
                    -
                    <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" readonly="readonly" />
                </td>
                <td class="Label3">实物退货确认
                </td>
                <td class="Field3">
                    <select name="selStatus" id="selStatus" runat="server">
                        <option value="" selected="selected">所有</option>
                        <option value="0">未退货</option>
                        <option value="1">已退货</option>
                    </select>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <!--wenshun 2017-10-26 退货时间修改-->
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="CreateDateStr" HeaderText="退货时间" SortExpression="CreateDateStr"
                HeaderStyle-Width="145px" />
            <asp:BoundField DataField="ReturnFormNo" HeaderText="退货单号" SortExpression="ReturnFormNo"
                HeaderStyle-Width="100px" />
            <asp:BoundField DataField="InspectionNo" HeaderText="IQC检验单号" SortExpression="InspectionNo"
                HeaderStyle-Width="100px" />
            <asp:BoundField DataField="DeliverNo" HeaderText="送货单号" SortExpression="DeliverNo"
                HeaderStyle-Width="100px" />
            <asp:BoundField DataField="POCode" HeaderText="采购单号" SortExpression="POCode" HeaderStyle-Width="90px" />
            <asp:BoundField DataField="LoweredUserName" HeaderText="采购员" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode"
                HeaderStyle-Width="110px" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" HeaderStyle-Width="250px" />
            <asp:BoundField DataField="VendorCode" HeaderText="供应商代码" SortExpression="VendorCode"
                HeaderStyle-Width="100px" />
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" HeaderStyle-Width="220px" />
            <asp:TemplateField HeaderText="收货数量" SortExpression="InspectionQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("InspectionQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="合格数量" SortExpression="OkQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("OkQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="退货数量" SortExpression="NgQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("NgQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DelDatatime" HeaderText="收货时间" SortExpression="DelDatatime"
                HeaderStyle-Width="110px" />
            <asp:BoundField DataField="CreateBy" HeaderText="退料人" HeaderStyle-Width="110px" />
            <asp:BoundField DataField="SureReturn" HeaderText="实物退货确认" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Remark" HeaderText="退货单说明" HeaderStyle-Width="150px" />
            <asp:BoundField DataField="NgReson" HeaderText="不良原因" HeaderStyle-Width="150px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialIQC"
        SelectMethod="GetIqcReturnList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIdString" runat="server" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ClientIDMode="Static" ID="hfGrnCheckFlag" />
    <script type="text/javascript">
        isMultiple = false;
        _maxDate = 0;
        var divHeight = 0;
        var grnCheck = $("#hfGrnCheckFlag").val();
        //$("#MultipleDiv").hide();
        $(function () {
            $(document).ready(function () {
                divHeight = window.innerHeight;
                divHeight = divHeight - 190;
                $("#divList").css('height', divHeight + 'px');
                $("#ckbMultipleSelected").parent().hide();
            });
            gridCellsChangeNo = true;
        });
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function RePrint() {
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值,按钮功能已去掉
            // 3 改为 InspectionNo
            var idStr = getRecordCellTextsByFiled("InspectionNo"); 
            if (idStr == "") return false;
            var enPrint = {};
            enPrint.InspectionNo = idStr;
            enPrint.UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName%>';
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/PDFFilePrint.aspx?strJson=" + JSON.stringify(enPrint)
                + "&SPC=uspGetIqcReturnpPrint&XML=IQCReturnForm.xml&rnd=" + Math.random());
        }

        //导出PDF
        function PdfPrint() {
            debugger
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 16 改为 SureReturn
            var status = getRecordCellTextsByFiled("SureReturn"); 
            if (status == "已退货") {
                alert("该退货单已退货，不能重复退货");
                return;
            }
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值,
            // 3 改为 InspectionNo
            var iqcNo = getRecordCellTextsByFiled("InspectionNo"); 
            if (!confirm('是否确定退货确认?')) {
                return;
            }
            if (grnCheck === '1') {
                dialog({
                    title: "扫描确认",
                    src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialIqcReturnCheck.aspx?IQCBatchId=" +
                        idStr + "&ReturnMode=0&iqcNo=" + iqcNo,
                    width: 800,
                    height: 300
                });
                return false;
            } else {
                var entity = {};
                entity.ReturnFormId = parseInt(idStr);
                entity.ConfirmBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                entity.ReturnMode = 0; //0 直接退供应商
                //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_MateIQCReturnForm_Status", JSON.stringify(entity));
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.ConfirmIqcReturn(entity, 0);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                pdfReturnOrder();
                updatelist();

            }

        }

        //导出
        function Export() {
            var idStr = getRecordIdString();
            hdnIdString.val(idStr);
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        //退货确认,退到不良仓
        function ReturnToNgWarehouse() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 16 改为 SureReturn
            var status = getRecordCellTextsByFiled("SureReturn"); 
            if (status == "已退货") {
                alert("该退货单已退货，不能重复退货");
                return;
            }
            if (!confirm('是否确定退货确认?')) {
                return;
            }
            if (grnCheck === '1') {
                dialog({
                    title: "扫描确认",
                    src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialIqcReturnCheck.aspx?IQCBatchId=" +
                        idStr + "&ReturnMode=1",
                    width: 800,
                    height: 300
                });
                return false;
            } else {
                var entity = {};
                entity.ReturnFormId = parseInt(idStr);
                entity.ConfirmBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                entity.ReturnMode = 1;  //1 退不良仓库
                //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_MateIQCReturnForm_Status", JSON.stringify(entity));
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.ConfirmIqcReturn(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                else {
                    alert("退货成功!");
                }
            }

            document.forms[0].submit();
        }

        //查看不良描述
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            dialog({ title: mesLang("查看窗口"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialIQCReturnView.aspx?IQCBatchId=" + idStr, width: 800, height: 300 });
        }

        function updatelist() {
            document.forms[0].submit();
        }

        //生成PDF
        function pdfReturnOrder(isReprint) {
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值,
            // 3 改为 InspectionNo
            var idStr = getRecordCellTextsByFiled("InspectionNo"); 
            if (idStr == "") return false;
            var enPrint = {};
            enPrint.InspectionNo = idStr;
            enPrint.UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName%>';
            //hdnOperate.val("PdfPrint");
            //hdnIdString.val(JSON.stringify(enPrint));
            //document.forms[0].submit();
            //hdnOperate.val("");
            if (isReprint === 1) {
                //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
                // 16 改为 SureReturn
                var status = getRecordCellTextsByFiled("SureReturn"); 
                if (status !== "已退货") {
                    alert("该退货单未确认退货");
                    return false;
                }
            }
            var spJson = JSON.stringify(enPrint);
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/IqcReturnPrint.aspx?spJson=" + spJson);

        }


    </script>
</asp:Content>

