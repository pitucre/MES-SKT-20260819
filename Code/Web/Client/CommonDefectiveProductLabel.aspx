<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="CommonDefectiveProductLabel.aspx.cs" Inherits="SKT.LeanMES.Web.Client.CommonDefectiveProductLabel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">条码<em>*</em>
            </td>
            <td class="Field2">
                 <input type="text" id="txtNGSN" IsRequired='1' class="scan-center-sn" style="width: 90%" />
            </td>
            <td colspan="2">请扫描条码</td>
        </tr>
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
            <td class="Label2">工单数量
            </td>
            <td class="Field2">
                <label id="txtOrderNumber"></label>
            </td>
            <td class="Label2">工序<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStationName" runat="server" Enabled="false"></asp:TextBox>

                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>

        </tr>
        <tr>
            <td class="Label2">不良数量<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtNumbers" class="TextBox" disabled="disabled" />
            </td>

            <td class="Label2">不良现象<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNcCode" runat="server" IsRequired='1'></asp:TextBox>
                <input type="button" id="btnSelectNcCode" class="ButtonBox" value="..." title="Select"
                    onclick="openChoosePage(113);" />
                <asp:HiddenField ID="hdntxtNcCode" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <%-- <td class="Label2">不良原因<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtReason" runat="server" IsRequired='1'></asp:TextBox>
                <input type="button" id="btnSelectReason" class="ButtonBox" value="..." title="Select"
                    onclick="openChoosePage(114);" />
                <asp:HiddenField ID="hdnReasonId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>--%>
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
        <%-- <tr>
            <td class="Label2">打印机列表
            </td>
            <td class="Field2" colspan="3">
                <select id="selPrintersList" style="width: 250px; height: 26px;">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机</a>
            </td>
        </tr>--%>
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
        var lineName = -1;
        var orderNo = "";
        var orderId = "";
        var stationId =-1;
        var productName = "";
        var itemId = -1;
        var resourceId = -1;
        var flag = -1;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        var Sn = "";
        //var Qty = getQueryString("Qty");
        $("#txtProductName").text(productName);
        $(document).ready(function () {
            /*  bindPrinters('selPrintersList');*/
          

        });


        $("#txtNGSN").keydown(function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                debugger
                var sn = $.trim($("#txtNGSN").val());
                if (sn == "") {
                    clearData();
                    alert("请扫描SN!");
                    $("#txtNGSN").val("").focus().select();
                    return false;
                }
                var entity = {};
                entity.SN = sn;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetUnitSNNGInfo", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtNGSN").val("").focus().select();
                    clearData();
                    return false;
                }
                var list = JSON.parse(ajax.value).data;
                lineName = list[0].LineID;
                orderNo = list[0].OrderNO;
                
                stationId = list[0].StationId; 
                productName = list[0].ItemName;
                itemId = list[0].ItemId;
                resourceId = list[0].ResID;
                $("#txtNumbers").val(list[0].BatchQty)
                //加载线别信息
                getLineInfo();
                //加载工序信息
                getStationInfo();
                getOrderInfo();
            }
        });

        function clearData() {
            lineName = -1;
            orderNo = "";

            stationId =-1;
            productName = "";
            itemId = -1;
            resourceId = -1;

            $("#<%=this.txtResName.ClientID %>").val("");
            $("#lblLineName").text("");
            $("#<%=this.hdnResId.ClientID %>").val(-1);

            $("#<%=this.txtStationName.ClientID %>").val("");
            $("#<%=this.hdnStationId.ClientID %>").val(-1);

            $("#<%=this.txtOrderNo.ClientID %>").text("");
            $("#<%=this.hdnOrderId.ClientID %>").val(-1);
            $("#txtOrderNumber").text("");
            orderId = -1;
            myItemID = -1;
            $("#txtNumbers").val("")
        }

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
            if (flag == 113) {
                $("#<%=this.txtNcCode.ClientID %>").val(list[0][1]);
                $("#<%=this.hdntxtNcCode.ClientID %>").val(list[0][0]);
            }
            <%--if (flag == 114) {
                $("#<%=this.txtReason.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnReasonId.ClientID %>").val(list[0][0]);
            }--%>
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
            var sn = $.trim($("#txtNGSN").val());
            if (sn == "") {
                alert("请扫描条码!");
                $("#txtNGSN").val("").focus().select();
                return false;
            }
            var prodOrderId = $("#hdnOrderId").val();
            var stationId = $("#hdnStationId").val();
            var nCCodeIdFailure = $("#hdntxtNcCode").val();
            var nCCodeIdDefect = -1;
            var ngQty = $.trim($("#txtNumbers").val());
            var remark = $.trim($("#txtRemark").val());

            if (prodOrderId == "" || prodOrderId == "-1") {
                alert("请选择工单");
                return false;
            }

            //if (parseInt(Qty) < parseInt(ngQty)) {
            //    alert("不良的打印数据不能大于可打印数量");
            //    return false;
            //}

            var entity =
            {
                ProdOrderId: parseInt(prodOrderId),
                ResId: parseInt(resourceId),
                StationId: parseInt(stationId),
                NCCodeIdFailure: parseInt(nCCodeIdFailure),
                NCCodeIdDefect: parseInt(nCCodeIdDefect),
                NgQty: parseInt(ngQty),
                Remark: remark,
                UserName: userName,
                SN:sn,
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.CommonNcPrintCollection(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var listStr = ajax.value;
            //var sn = listStr[0];
            //updateCollectionList(sn, 'OK');
            alert("保存成功");
            //var Qty = $("#txtNumbers").val();
            //window.parent.UpdateList(sn, Qty);
            window.parent.closeDialog();



        }

        function SavePrint(ReleaseQty, myBatchQty, orderId, itemids) {
        //1.获取当前基本信息
        //var resourceId = $("#hdnCurrResourceId").val(); //资源Id
        //var stationId = $("#hdnCurrStationId").val(); //工位Id

<%--            if (!stationId > 0) {
                alert("请先在操作菜单列表进行切换工位操作！");
                return;
            }

            var OrderNo = $("#txtOrderNo").val();
            if (OrderNo == "") {
                alert("请先选择工单！");
                return false;
            }
            var BatchQty = $("#txtBatchQty").val();
            if (BatchQty == "") {
                alert("请输入需要打印的批次数量！");
                return false;
            }
            var canReleaseQty = parseInt($("#labQty").text());
            if (!isNumber($("#txtPrintNumber").val())) { alert("打印批次数量只能为整型数字！"); return false; }
            if (parseInt($("#txtPrintNumber").val()) <= 0) { alert("打印批次数量必须大于0！"); return false; }
            if (canReleaseQty < parseInt($("#txtPrintNumber").val())) { alert("本次打印批次数量不能大于工单可打印数量！"); return false; }
            printName = $("#selPrintersList").val();
            var orderId = $("#<%=this.hdnOrderId.ClientID %>").val();
            if (orderId == -1 || orderId == "") {
                alert("请先选择工单！");
                return false;
            }--%>

            /*begin release*/
            var itemids = myItemID;
            //var ReleaseQty = $("#txtPrintNumber").val();
            //var myBatchQty = BatchQty;
            var myajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.ReleaseBatchSO(parseInt(ReleaseQty), parseFloat(myBatchQty), orderId, itemids);
            if (myajax.error != null) {
                showAreaMessge(myajax.error.Message, "messageRed");
                return false;
            }

            labelType = -36;
            labelItemId = itemids;
            labelStationId = stationId;
            labelProdOrderId = orderId;

            getDocumentInfo();
            //获取标签信息
            SNInfo = myajax.value;
            Sn = SNInfo.SNList[0];
            for (var i = 0; i < SNInfo.SNList.length; i++) {
                //过站操作
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.UnitComplete(SNInfo.SNList[i], stationId, resourceId, false);
                if (ajax.error != null) {

                    updateCollectionList(SNInfo.SNList[i], 'NG');
                    showAreaMessge(SNInfo.SNList[i] + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, SNInfo.SNList[i], ajax.error.Message);
                    return false;
                }
                else if (ajax.json == undefined) {
                    showAreaMessge(SNInfo.SNList[i] + '：' + "未接收到系统返回信息，请检查是否登录已超时或网络中断！", "messageRed");
                    return false;
                }
                updateCollectionList(SNInfo.SNList[i], 'OK');
                //setMessageBox(SNInfo.SNList[i] + ':打印完成，通过', "messageGreen");
                //showAreaMessge(SNInfo.SNList[i] + ':打印完成，通过 ！' + (prodWeight > 0 ? "当前产品重量为：" + prodWeight + " " + units : ""), 'messageGreen');
                //根据SN刷新侧边栏动态信息
                //refreshProInfoBySN(SNInfo.SNList[i]);
            }

            var Qty = $("#txtNumbers").val();
            window.parent.UpdateList(Sn, Qty);
            window.parent.closeDialog();
            //LoadOrderInfo($("#txtOrderNo").val());
            //setTimeout(function () {
            //    try {
            //        for (var i = 0; i < printCount; i++) {
            //            MymesLabLabelPrint(SNInfo.SNList);
            //        }
            //    }
            //    catch (e) {
            //        showAreaMessge(e, "messageRed");
            //    }
            //}, 30);
        }



        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = itemId;    //ItemId
        var labelProdOrderId = orderId;
        var labelStationId = -1;    //工位Id
        var labelType = -36;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单-36:批次产品条码)
        var labelSequence = 1;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径
        var printCount = 1;        //打印份数：默认一次
        var templateGroup = 1;//新打印连板数
        //获取文档模板基础信息
        function getDocumentInfo() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                templateGroup = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintTemplateGroup(labelDocumentId).value;
                lableTypeQty = entity.PlateQty;
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                printCount = entity.Print_Qty;

            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }

            //初始化打印插件
            //InityPrintingPlugin();
        }


        //codesoft打印  Lab模板方式
        function MymesLabLabelPrint(list) {
            if (list.length == 0) {
                ibs = 3 * printCount;
                setInterval(function () { $("#lblPt").html("打印条码完成！"); ibs-- }, 1000)
                setTimeout(function () {
                    document.forms[0].submit();
                }, 3000);
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
                    $("#lblPt").html("没有找到该产品关联的模板信息");
                    return;
                }
            } else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return;
            }
            $("#lblPt").html("发送条码【" + list.join() + "】打印指令到打印机,请勿关闭窗口！<br/> 当前剩余打印数量【" + newlist.length + "】");
            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, null,<%=ConfigurationManager.AppSettings["PrintType"]%>);

        }

        function recordPrint(list) {
            setTimeout(function () {
                for (var r = 0; r < list.length; r++) {
                    var printRecodeEntity = {};
                    printRecodeEntity.RecordId = -1;
                    printRecodeEntity.ActionType = 1;
                    printRecodeEntity.PrintType = -2;
                    printRecodeEntity.PrintKey = list[r];
                    printRecodeEntity.StationId = -1;
                    printRecodeEntity.ResourceId = -1;
                    var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
                    if (ajaxPrintRecodes.error != null) {
                        alert(ajaxPrintRecodes.error.Message);
                        $("#lblMessage").html(ajaxPrintRecodes.error.Message);
                        return false;
                    }
                }
            }, 10);
        }
        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/


    </script>
</asp:Content>
