<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="DefectiveProductLabel.aspx.cs" Inherits="SKT.LeanMES.Web.Client.DefectiveProductLabel" %>

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
                <input type="text" id="txtNumbers" class="TextBox" isrequired='1' />
            </td>

            <td class="Label2">不良现象
            </td>
            <td class="Field2">
                <%--改造：取消「不良现象」必填（数量已由注塑报工界面的不良现象明细汇总）--%>
                <asp:TextBox ID="txtNcCode" runat="server"></asp:TextBox>
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
        //改造：注塑报工界面传来的不良现象汇总数（NcSum）与明细（NcPayload：id|名称|数量;...）
        var ncSumParam = getQueryString("NcSum");
        var ncPayloadParam = getQueryString("NcPayload");
        var ncDetailList = [];          //[{ id, code, qty }]
        $("#txtProductName").text(productName);
        $(document).ready(function () {
            /*  bindPrinters('selPrintersList');*/
            //加载线别信息
            getLineInfo();
            //加载工序信息
            getStationInfo();
            getOrderInfo();

            //改造：应用注塑报工界面传来的不良现象（自动填不良数量 + 写备注）
            initNcDetail();
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
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.NcPrintCollection(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var listStr = ajax.value;
            var sn = listStr[0];
            updateCollectionList(sn, 'OK');
            //改造：把不良现象明细写入 Prod_InjectionMoldingNcDetail（带不良条码 sn，SP 反查 Prod_Unit.UID）
            var ncSaved = saveNcDetail('保存', sn);
            alert("保存成功");
            //改造：保存成功后把主界面不良现象数量清零
            if (ncSaved) { clearParentNcQty(); }
            var Qty = $("#txtNumbers").val();
            window.parent.UpdateListNG(sn, Qty);
            window.parent.closeDialog();



        }

        function SavePrint() {
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
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.NcPrintCollection(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var listStr = ajax.value;
            var sn = listStr[0];
            updateCollectionList(sn, 'OK');
            //改造：把不良现象明细写入 Prod_InjectionMoldingNcDetail（带不良条码 sn，SP 反查 Prod_Unit.UID）
            var ncSaved = saveNcDetail('保存并打印', sn);
            alert("保存成功");
            //改造：保存成功后把主界面不良现象数量清零
            if (ncSaved) { clearParentNcQty(); }
            var Qty = $("#txtNumbers").val();
            window.parent.UpdateList(sn, Qty);
            window.parent.closeDialog();
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

        /************************ 不良现象明细（改造新增） 开始 ************************/
        //应用主界面传来的不良现象：自动填「不良数量」=各现象数量之和；不为 0 的现象写入「备注」
        function initNcDetail() {
            ncDetailList = [];
            if (ncPayloadParam) {
                var parts = ncPayloadParam.split(";");
                for (var i = 0; i < parts.length; i++) {
                    if (!parts[i]) { continue; }
                    var f = parts[i].split("|");
                    if (f.length < 3) { continue; }
                    //新格式 id|代码|名称|数量（4 段）；旧格式 id|名称|数量（3 段）也兼容
                    var item = null;
                    if (f.length >= 4) {
                        item = { id: parseInt(f[0], 10) || -1, code: f[1], name: f[2], qty: parseInt(f[3], 10) || 0 };
                    } else {
                        item = { id: parseInt(f[0], 10) || -1, code: f[1], name: f[1], qty: parseInt(f[2], 10) || 0 };
                    }
                    if (!item.name) { item.name = item.code; }
                    ncDetailList.push(item);
                }
            }
            if (ncDetailList.length == 0) { return; }

            //不良数量 = 所有不良现象数量之和
            var sum = parseInt(ncSumParam, 10);
            if (isNaN(sum) || sum < 0) { sum = 0; }
            $("#txtNumbers").val(sum);

            //不为 0 的不良现象（显示名称）写入备注（备注列限长 50，超出部分截断）
            var txt = "";
            for (var j = 0; j < ncDetailList.length; j++) {
                txt += (j > 0 ? ";" : "") + ncDetailList[j].name + ncDetailList[j].qty;
            }
            var maxLen = 50;
            if (txt.length > maxLen) { txt = txt.substring(0, maxLen - 1) + "…"; }
            $("#txtRemark").val(txt);
        }

        //把不良现象明细保存到 Prod_InjectionMoldingNcDetail（「保存」/「保存并打印」都会调用）
        //sn = 本次不良登记生成的不良条码，SP 内部按它反查 Prod_Unit.UID 存 UnitUID 列
        function saveNcDetail(saveType, sn) {
            try {
                var total = parseInt($.trim($("#txtNumbers").val()), 10);
                if (isNaN(total) || total < 0) { total = 0; }
                var rows = ncDetailList;
                if (rows.length == 0) {
                    if (total <= 0) { return true; }
                    rows = [{ id: -1, code: "", qty: 0 }];      //没有选具体现象时也留一条记录
                }
                var machineNo = $.trim($("#<%=this.txtResName.ClientID %>").val());
                for (var i = 0; i < rows.length; i++) {
                    var entity = {
                        OrderNo: $.trim($("#<%=this.txtOrderNo.ClientID %>").text()),
                        ProductName: productName || "",
                        MachineNo: machineNo,
                        ResName: machineNo,
                        ResourceId: parseInt(resourceId, 10) || 0,
                        OpeId: parseInt($("#hdnStationId").val(), 10) || 0,
                        ProdOrderId: parseInt($("#hdnOrderId").val(), 10) || 0,
                        SN: sn || "",
                        NcCodeId: parseInt(rows[i].id, 10) || -1,
                        NcCode: rows[i].code || "",
                        NcName: rows[i].name || rows[i].code || "",
                        NcQty: parseInt(rows[i].qty, 10) || 0,
                        NcTotal: total,
                        SaveType: saveType,
                        Remark: $.trim($("#txtRemark").val()),
                        UserName: userName
                    };
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveInjectionMoldingNcDetail_Program", JSON.stringify(entity));
                    if (ajax.error != null) {
                        alert("不良现象明细保存失败：" + ajax.error.Message);
                        return false;
                    }
                    //ExecuteSpc 出错时后端会静默返回 "{}"，这里校验返回值，避免"假成功"
                    var ok = false;
                    try {
                        var res = JSON.parse(ajax.value);
                        if (res && res.data && res.data.length > 0 && parseInt(res.data[0].Id, 10) > 0) { ok = true; }
                    } catch (e) { ok = false; }
                    if (!ok) {
                        alert("不良现象明细保存失败：接口没有返回记录ID。\r\n请确认数据库已执行最新的脚本（存储过程 uspSaveInjectionMoldingNcDetail_Program 需含 @SN 参数）。");
                        return false;
                    }
                }
            } catch (e) {
                alert("不良现象明细保存异常：" + e);
                return false;
            }
            return true;
        }

        //保存成功后，通知主界面（注塑报工界面）把所有不良现象数量清零
        function clearParentNcQty() {
            try {
                if (window.parent && typeof (window.parent.clearNcQty) === "function") {
                    window.parent.clearNcQty();
                }
            } catch (e) { }
        }
        /************************ 不良现象明细（改造新增） 结束 ************************/

    </script>
</asp:Content>
