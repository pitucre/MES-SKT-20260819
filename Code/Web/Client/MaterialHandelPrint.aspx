<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialHandelPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Client.MaterialHandelPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">工单号<em>*</em>
            </td>
            <td class="Field2">
                <asp:Label ID="txtOrderNo" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnOrderId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">产品名称
            </td>
            <td class="Field2">
                <label id="txtProductName"></label>
            </td>
        </tr>
        <tr hidden>
            <td class="Label2">料把编码<em>*</em>
            </td>
            <td class="Field2">
                <label id="txtMHItemId" style="display: none;"></label>
                <label id="txtMHCode"></label>
            </td>
            <td class="Label2">料把名称
            </td>
            <td class="Field2">
                <label id="txtMHName"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">资源
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtResName" runat="server" Enabled="false"></asp:TextBox>

                <asp:HiddenField ID="hdnResId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">线别
            </td>
            <td class="Field2">
                <label id="lblLineName"></label>
            </td>
        </tr>
        <tr>
            <%--      <td class="Label2">工单数量
            </td>
            <td class="Field2">
                <label id="txtOrderNumber"></label>
            </td>--%>
            <td class="Label2">工序<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStationName" runat="server" Enabled="false"></asp:TextBox>

                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>

            <td class="Label2">打印数量<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtNumbers" class="TextBox" isrequired='1' />
            </td>
        </tr>
        <tr>
            <td class="Label2">备注
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" ClientIDMode="Static" TextMode="MultiLine" MaxLength="50"
                    Height="80px" Width="235px">
                </asp:TextBox>
            </td>
        </tr>
    </table>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnHasCopy" runat="server" Value="-1" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.ElectronicEquipment.js" type="text/javascript"></script>
    <script type="text/javascript">
        var isMultiple = true;
        var openWinUrl = "";
        var myItemID = -1;
        var lineName = getQueryString("LineId");
        var orderNo = getQueryString("OrderNo");
        var orderId = "";
        var stationId = getQueryString("StationId");
        var productName = getQueryString("ProductName");
        var itemId = getQueryString("ItemID");;
        var resourceId = getQueryString("resourceId");
        var flag = -1;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        var Sn = "";
        var Qty = getQueryString("Qty");
        var printname = getQueryString("printname");
        $("#txtProductName").text(productName);
        $(document).ready(function () {
            /*  bindPrinters('selPrintersList');*/
            //加载线别信息
            getLineInfo();
            //加载工序信息
            getStationInfo();
            getOrderInfo();

            //加载料把
            //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetMaterialHandle", JSON.stringify({}));
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}
            //var data = JSON.parse(ajax.value).data[0];
            //console.log(data)
            //$("#txtMHItemId").text(data.ItemID);
            //$("#txtMHCode").text(data.ItemCode);
            //$("#txtMHName").text(data.ItemName);

        });

        function openChoosePage(flags) {
            var condition = "";
            var myOrderNo = $("#<%=this.txtOrderNo.ClientID %>").text();
            /*如果是选择工序，并且已经选好工单号，则根据工单路由过滤工序*/
            if (flags == 8 && myOrderNo != "") {
                var info = { OrderNo: myOrderNo };
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetOrderRouterStationInfo", JSON.stringify(info));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var list = JSON.parse(ajax.value);
                var listOrder = list.data;
                var myStationIDStr = listOrder[0].StationID;
                condition = " StationId in(SELECT strvalue FROM dbo.Fn_convertstringtotablestring3('" + myStationIDStr + "',','))";
            }

            flag = flags;
            if (flags == 114) {
                flags = 113;
                condition = "Category = '缺陷品'";
            } else if (flags == "113") {
                condition = "Category = '失败品'";
            }

            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&SearchCondition=" +
                    condition +
                    "&rnd=" +
                    Math.random(),
                width: 650,
                height: 350
            });
        }

        function getChooseValue(list) {
            //工单
            if (flag == 44) {
                $("#<%=this.txtOrderNo.ClientID %>").text(list[0][1]);
                $("#<%=this.hdnOrderId.ClientID %>").val(list[0][0]);
                $("#txtMHItemId").text(list[0][7]);
            }
            //线别
            if (flag == 6) {
                $("#<%=this.txtResName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnResId.ClientID %>").val(list[0][0]);
                resourceId = list[0][0];
                getLineInfo();
            }
            //工序
            if (flag == 8) {
                $("#<%=this.txtStationName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
            }
        }


        function getLineInfo() {
            var info = { FieldValue: resourceId, IsByID: 1 };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Basal_Resource_GetInfo", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var lineList = list.data;
            $("#<%=this.txtResName.ClientID %>").val(lineList[0].ResName);
            $("#lblLineName").text(lineList[0].LineName);
            $("#<%=this.hdnResId.ClientID %>").val(lineList[0].ResourceId);
        }


        function getStationInfo() {
            var info = { StationId: stationId };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetStationInfo", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var lineList = list.data;
            $("#<%=this.txtStationName.ClientID %>").val(lineList[0].Station);
            $("#<%=this.hdnStationId.ClientID %>").val(lineList[0].StationId);
        }

        function getOrderInfo() {
            var info = { OrderNo: orderNo };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetProd_OrderInfo", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var list = JSON.parse(ajax.value);

            var orderList = list.data;

            if (orderList.length > 0) {
                $("#<%=this.txtOrderNo.ClientID %>").text(orderList[0].OrderNO);
                $("#<%=this.hdnOrderId.ClientID %>").val(orderList[0].ProdOrderID);
                $("#txtOrderNumber").text(orderList[0].Qty_to_Build);
                orderId = orderList[0].ProdOrderID;
                myItemID = orderList[0].ItemId;
            }

        }

        //保存并打印
        function Save() {

            var prodOrderId = $("#hdnOrderId").val();
            var stationId = $("#hdnStationId").val();
            var ngQty = $.trim($("#txtNumbers").val());
            var remark = $.trim($("#txtRemark").val());
            //var itemId = $.trim($("#txtMHItemId").text());

            if (prodOrderId == "" || prodOrderId == "-1") {
                alert("请选择工单");
                return false;
            }

            if (ngQty == "" || parseInt(ngQty) == 0) {
                alert("请输入打印数量");
                return false;
            }
            //if (parseInt(Qty) < parseInt(ngQty)) {
            //    alert("不良的打印数据不能大于可打印数量");
            //    return false;
            //}

            var entity =
            {
                ProdOrderId: parseInt(prodOrderId),
                ItemId: -1,//itemId,//料棒型号
                GRNQty: parseFloat(ngQty),
                UserName: userName,
                ResId: parseInt(resourceId),
                OpeId: parseInt(stationId),
                Remark: remark,
            }
            debugger
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.GenerateLineMaterialSN(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var data = $.parseJSON(ajax.value);
            var sn = data.GRNString;
            var itemId = data.ItemId;
            lablabItem = itemId;
            alert("保存成功");
            var Qty = $("#txtNumbers").val();
            window.parent.MaterialHandelPrintCallBack(sn, Qty, itemId);
            window.parent.closeDialog();
        }

        function SavePrint() {
            var prodOrderId = $("#hdnOrderId").val();
            var stationId = $("#hdnStationId").val();
            var ngQty = $.trim($("#txtNumbers").val());
            var remark = $.trim($("#txtRemark").val());
            //var itemId = $.trim($("#txtMHItemId").text());

            if (prodOrderId == "" || prodOrderId == "-1") {
                alert("请选择工单");
                return false;
            }

            if (ngQty == "" || parseInt(ngQty) == 0) {
                alert("请输入打印数量");
                return false;
            }
            //if (parseInt(Qty) < parseInt(ngQty)) {
            //    alert("不良的打印数据不能大于可打印数量");
            //    return false;
            //}

            var entity =
            {
                ProdOrderId: parseInt(prodOrderId),
                ItemId: -1,//itemId,//料棒型号
                GRNQty: parseFloat(ngQty),
                UserName: userName,
                ResId: parseInt(resourceId),
                OpeId: parseInt(stationId),
                Remark: remark,
            }
            debugger
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.GenerateLineMaterialSN(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var data = $.parseJSON(ajax.value);
            var sn = data.GRNString;
            var itemId = data.ItemId;
            lablabItem = itemId;
            alert("保存成功");
            var Qty = $("#txtNumbers").val();
            window.parent.MaterialHandelPrintCallBack(sn, Qty, itemId);
            //window.parent.closeDialog();
            getDocumentInfo();
            ////获取标签信息
            SNInfo = {
                SNList: [sn]
            }

            PrintLabContent();
            //window.parent.closeDialog();
        }



        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -38;          //标签类型 (-2：SN，-3：GRN)
        var labelSequence = 2;      //标签序号 (1产品，2GRN, 3单号......)
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径
        var lablabItem = "";

        //根据打印方式决定 调用ZPL还是Lab打印
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                //获取打印机名称值
                printName = printname;
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                alert(ajax.error.Message);
                return false;
            }
        }

        var printCount = 1;
        function PrintLabContent() {
            try {
                printCount = 1;
                lableArr = SNInfo.SNList;
                labItemList = SNInfo.ItemList;
                var printdata = [];
                for (var i = 0; i < lableArr.length; i++) {
                    var labelStr = lableArr[i];

                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, lablabItem, -1);
                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        var page = { LabelContent: [] };

                        for (var j = 0; j < list.length; j++) {

                            //xiang.yan 2024-06-28 物料编码10501.000410被认定为浮点数，打印时打印为10501.00041
                            if (isNumberVal(list[j].LabelValue) && list[j].LabelName != "物料编码") {
                                page.LabelContent.push({ name: list[j].LabelName, value: parseFloat(list[j].LabelValue) });
                            }
                            else {
                                page.LabelContent.push({ name: list[j].LabelName, value: list[j].LabelValue });

                            }


                        }
                        printdata.push(page);
                    }
                }
                if (printdata.length == 0)
                    return;
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
        }

        //判断是否为数字
        function isNumberVal(val) {
            var regPos = /^\d+(\.\d+)?$/; //非负浮点数
            var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
            if (val.substring(0, 1) == "0") {
                if (val.substring(1, 1) != ".") {
                    return false;
                }
            }
            if (regPos.test(val) || regNeg.test(val)) {
                return true;
            } else {
                return false;
            }
        }

        /*
        *写入系统操作日志
        */
        function creatservicelog(logtype, modulename, pagename, oederno, logcontent) {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxErrorLog.CreateOperationLog(logtype, modulename, pagename, oederno, logcontent);
            if (ajax.error != null) {
                return false;
            }
        }
        function creatematerialhistorylog(logtype, operateorder, actiondesc, logcontent) {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxErrorLog.CreateMaterialHistoryLog(logtype, operateorder, actiondesc, logcontent);
            if (ajax.error != null) {
                return false;
            }
        }
        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/


    </script>
</asp:Content>
