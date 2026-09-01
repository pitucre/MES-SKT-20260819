<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="PackRelationList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PackRelationList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                工单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="bnOper" class="ButtonBox" onclick="openChoosePage()" value="..." />
            </td>
            <td class="Label2">
                订单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
            </td>          
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="NumberType" HeaderText="号码类型" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CustomerOrder" HeaderText="订单号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Prefix" HeaderText="条码前缀" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="Suffix" HeaderText="条码后缀" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="SerialBegin" HeaderText="起始流水号" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="SerialEnd" HeaderText="结束流水号" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="SerialLength" HeaderText="流水号长度" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Qty" HeaderText="数量" HeaderStyle-Width="50px" />
            <asp:BoundField DataField="NumberBegin" HeaderText="完整起始号码" HeaderStyle-Width="280px" />
            <asp:BoundField DataField="NumberEnd" HeaderText="完整结束号码" HeaderStyle-Width="280px" />
<%--            <asp:BoundField DataField="CreateBy" HeaderText="建立人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="建立时间" HeaderStyle-Width="140px" />--%>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" HeaderStyle-Width="140px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdUnit.BLL.BarCodeScope"
        SelectMethod="GetPackRelationAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/PackRelationEdit.aspx?name=PackRelationAdd&ID=-1";
            dialog({ title: mesLang("新增包装对应关系"), src: openWinUrl, width: 850, height: 700 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var OrderNo = "";
            for (var i = 0; i < $("input[name='chkSelect']").length; i++) {
                var $_input = $($("input[name='chkSelect']")[i]);
                if ($_input.val() == idStr) {
                    OrderNo = $_input.parent().parent().find("td:eq(2)").html();
                }
            }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/PackRelationEdit.aspx?name=PackRelationEdit&ID=" + idStr + "&OrderNo=" + OrderNo;
            dialog({ title: mesLang("编辑包装对应关系"), src: openWinUrl, width: 850, height: 700 });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=44&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtOrderNo").val(list[0][1]);
        }

        function Print() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var OrderNo = "";
            var BarType = "";
            for (var i = 0; i < $("input[name='chkSelect']:checked").length; i++) {
                var $_input = $($("input[name='chkSelect']:checked")[i]);
                //if ($_input.val() == idStr) {
                //    OrderNo = $_input.parent().parent().find("td:eq(2)").html();
                //}
                BarType = $_input.parent().parent().find("td:eq(1)").html();
                OrderNo = $_input.parent().parent().find("td:eq(2)").html();
            }
            if (BarType != "客户号码") {
                alert("只能打印客户条码！");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.QueryPackBarCodeList(OrderNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if(entity.length==0){
                alert("工单下没有包装的产品条码");
                return false;
            }

            SNInfo = [];
            for (var i = 0; i < entity.length; i++) {
                labelItemId = entity[i].ItemId;
                SNInfo.push(entity[i].SerialNumber);
            }

            if (getDocumentInfo()) {
                mesLabLabelPrint(SNInfo);
                setTimeout(function () {
                    $("div.noInstallPrintPlugin").remove();
                }, 2000);
            }
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelProdOrderId = -1;
        var labelStationId = -1;    //工位Id
        var labelType = -16;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 5;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径
        var templateGroup=1;


        //获取文档模板基础信息
        function getDocumentInfo() {
            var entity;
            if (labelType == -4 || labelType == -5 || labelType == -22) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPackLabelDocumentInfo(SNInfo[0]);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                entity = ajax.value[0];
            }
            else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#lblMessage").html(ajax.error.Message);
                    return false;
                }
                entity = ajax.value;
            }

            if (entity == null) {
                alert("未找到模板信息！");
                return false;
            }
            labelDocumentId = entity.LabelDocumentId;
            templateGroup = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintTemplateGroup(labelDocumentId).value;
            lableTypeQty = entity.PlateQty;
            printName = entity.PrinterName;
            labelPrintWayId = entity.PrintWayId;
            tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            return true;
        }

         function mesLabLabelPrint(list) {
            if (list.length == 0) {
                ibs = 3;
                return;
            }
            var sendQty = <%=ConfigurationManager.AppSettings["PrintSendQty"]%>;
            while (sendQty % templateGroup != 0) {
                sendQty++;
            }
            //从list中取出 sendQty 作为打印的数量，并且list截取掉sendQty
            var newlist = list.splice(sendQty);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfo(labelDocumentId, list, -1, -1, -1, labelItemId, labelProdOrderId);
            if (ajax.error == null) {
                if (ajax.value.length == 0) {
                    alert("没有找到该产品关联的模板信息");
                    return;
                }
            } else {
                alert(ajax.error.Message);
                return;
            }
            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, function (success, ws) {
                if (!success) {
                    if (ws && ws.readyState != 1)
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    return;
                }
                recordPrint(list);
                mesLabLabelPrint(newlist);
            },<%=ConfigurationManager.AppSettings["PrintType"]%>);
        }
    </script>
</asp:Content>