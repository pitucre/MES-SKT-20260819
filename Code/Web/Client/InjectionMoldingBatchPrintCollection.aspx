<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="InjectionMoldingBatchPrintCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.InjectionMoldingBatchPrintCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- 本页专用紧凑排版：压缩顶部信息区/提示条的行距，使一屏能显示更多内容 --%>
    <style type="text/css">
        .scan-center
        {
            margin: 6px 25px 2px 5px;
        }

        #scancenter td
        {
            padding-bottom: 2px;
            padding-top: 1px;
        }

        #scancenter .scan-center-title
        {
            padding-top: 6px;
            padding-bottom: 6px;
        }

        #batchWarnBar
        {
            padding: 3px 10px;
            margin: 0;
            font-size: 14px;
            line-height: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td colspan="2">
                        <table width="100%">
                            <tr>
                                <td style="width: 22%; white-space: nowrap;">工单号<em style="color: red;">*</em>
                                    <input type="text" id="txtOrderNo" style="height: 24px; width: 170px;" disabled="disabled" /><input type="button" id="btnSelectOrder" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(44);" />
                                    <asp:HiddenField ID="hdnOrderId" runat="server" Value="-1" ClientIDMode="Static" />
                                </td>
                                <td style="width: 36%; white-space: nowrap;">打印机列表：
                                    <select id="selPrintersList" style="width: 230px; height: 24px;">
                                    </select>
                                    <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机</a>
                                </td>
                                <td>产品名称：
                                    <label id="labItemName"></label>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" style="margin-top: 2px; line-height: 24px;">
                            <tr>
                                <td style="width: 20%; white-space: nowrap;">工单数量：
                                    <label id="labOrderQty"></label>
                                </td>
                                <td style="width: 20%; white-space: nowrap;">已打印数量：
                                    <label id="labPrintedQty"></label>
                                </td>
                                <td style="width: 20%; white-space: nowrap;">可打印数量：
                                    <label id="labQty"></label>
                                </td>
                                <td style="white-space: nowrap;">每批次数量：
                                    <label id="labBatchQty"></label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%--批次预警提示条：黑底红字（快到工单数量时由JS显示）--%>
                <tr>
                    <td colspan="2">
                        <div id="batchWarnBar" style="display: none; background-color: #000; color: #ff3b30; font-weight: bold;">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle" style="float: left;">请输入打印数量</span><div id="divCurrentWeight" style="padding: 18px 0px 0px; font-size: 14px; margin-left: 40px; float: left; display: none;">当前重量：<span id="lblCurrentWeight" style="font-weight: bold;">0</span> 称重状态：<span id="lblCurrentState" style="font-weight: bold;"></span></div>
                        &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                        </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtBatchQty" class="scan-center-sn" onchange="checkBatchWarning();" />
                    </td>
                </tr>
                <tr>
                    <td class="Label3 " style="text-align: left;" colspan="2">&nbsp;&nbsp;打印张数:&nbsp;&nbsp;
                        <input type="text" id="txtPrintNumber" style="height: 26px;" readonly="readonly" disabled="disabled"/>
                    </td>

                </tr>
                <tr>
                    <td colspan="2">
                        <table width="100%">
                            <tr>
                                <td align="center">
                                    <input type="button" value=" 良品标签打印 " id="btnGoodLabel" onclick="SavePrint()" />&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="button" value=" 不良登记 " id="DefectiveLabel" onclick="NcDataPrint()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="button" value=" 料把打印 " id="btnMaterialHandelLabel" onclick="MaterialHandelPrint()" />&nbsp;&nbsp;&nbsp;&nbsp;
                              <%--      <input type="button" value=" 打印批次号 " id="btnPersonPass" onclick="SavePrint()" />--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.LastStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="laststationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="right">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.NextStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="nextstationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center; color: #3e9c3e"><span id="printMessage"></span></td>
                </tr>
            </table>
        </div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td valign="top" style="width: 100%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %>
                            </div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 50px;">
                                            <%=Resources.lang.Sequence%>
                                        </th>
                                        <th style="width: 300px;">
                                            <%=Resources.lang.SerialNumber %>
                                        </th>
                                        <th style="width: 100px;">
                                            <%=Resources.lang.Status %>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlist">
                                </tbody>
                            </table>
                        </div>
                        <%--不良现象明细（改造新增）：每列 5 条，数量默认 0，可 -/+ 或直接输入 --%>
                        <div class="dds-panel" id="ncPanel" style="margin-top: 5px;">
                            <div class="leftmenu-new-header" style="font-size: 17px; font-weight: bold;">
                                不良现象（数量）<span style="font-size: 12px; font-weight: normal; color: #888;"></span>
                            </div>
                            <div id="ncList" style="padding: 10px 12px; min-height: 42px;">
                            </div>
                        </div>
                    </td>
                    <%--<td valign="top" style="width:50%">
                        
                    </td>--%>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.ElectronicEquipment.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        var myItemID = -1;
        var myItemName = "";       //纯产品名称（不带规格），供不良登记/料把打印等接口使用

        /******************** 批次预警（快到工单数量：界面黑底红字提醒 + 钉钉群推送） 开始 ********************/
        var WARN_LEVEL_NONE = 0;   //正常
        var WARN_LEVEL_TWO = 1;    //再打 2 个批次即达工单数量
        var WARN_LEVEL_ONE = 2;    //再打 1 个批次即达工单数量（或已达到）

        //取当前每批次数量（优先取输入框，其次工单批次量）
        function getBatchQtyValue() {
            var v = parseInt($("#txtBatchQty").val(), 10);
            if (isNaN(v) || v <= 0) { v = parseInt($("#labBatchQty").text(), 10); }
            return (isNaN(v) || v <= 0) ? 0 : v;
        }

        //隐藏预警条
        function hideBatchWarning() {
            $("#batchWarnBar").hide().text("");
        }

        //批次预警检测：已打印数量再打 2 个 / 1 个批次即达工单数量时提醒
        function checkBatchWarning() {
            var orderNo = $("#txtOrderNo").val();
            var orderQty = parseInt($("#labOrderQty").text(), 10);
            var printedQty = parseInt($("#labPrintedQty").text(), 10);
            var batchQty = getBatchQtyValue();

            if (orderNo == "" || isNaN(orderQty) || orderQty <= 0 || isNaN(printedQty) || batchQty <= 0) {
                hideBatchWarning();
                return;
            }

            var remainQty = orderQty - printedQty;
            var leftBatches = Math.floor(remainQty / batchQty);   //还能打印的整批次数
            var level = WARN_LEVEL_NONE;
            var text = "";
            if (remainQty <= 0) {
                level = WARN_LEVEL_ONE;
                text = "【注塑批次打印报工预警】超量：工单" + orderNo + "已打印数量已达工单数量（已打印 " + printedQty + " / 工单 " + orderQty + "，每批次 " + batchQty + "），请停止打印并确认工单是否需要补单！";
            } else if (leftBatches <= 1) {
                level = WARN_LEVEL_ONE;
                text = "【注塑批次打印报工预警】工单" + orderNo + "已打印 " + printedQty + " / 工单数量 " + orderQty + "，每批次 " + batchQty + "，再打印 1 个批次即达工单数量，请注意！";
            } else if (leftBatches <= 2) {
                level = WARN_LEVEL_TWO;
                text = "【注塑批次打印报工预警】工单" + orderNo + "已打印 " + printedQty + " / 工单数量 " + orderQty + "，每批次 " + batchQty + "，再打印 2 个批次即达工单数量，请注意！";
            }

            if (level == WARN_LEVEL_NONE) {
                hideBatchWarning();
                return;
            }

            //黑底红字提醒
            $("#batchWarnBar").text(text).show();
            //钉钉群推送：同一工单、同一预警级别只推一次，避免重复刷屏
            pushDingTalkWarning(orderNo, level, text);
        }

        //钉钉群预警推送
        function pushDingTalkWarning(orderNo, level, text) {
            var storageKey = "InjectionMoldingBatchWarn_" + orderNo + "_" + level;
            try {
                if (localStorage.getItem(storageKey) == "1") { return; }   //该工单该级别已推送过
                localStorage.setItem(storageKey, "1");
            } catch (e) { }

            try {
                SKT.LeanMES.Web.AjaxServices.AjaxDingTalk.SendGroupMsg(text, function (res) {
                    var result = res.value;
                    if (result != "OK") {
                        $("#activeinfoarea").append('<div style="color:red;">钉钉预警推送失败：' + result + '</div>');
                    }
                });
            } catch (e) {
                $("#activeinfoarea").append('<div style="color:red;">钉钉预警推送失败：' + e.message + '</div>');
            }
        }
        /******************** 批次预警 结束 ********************/

        var OrderNo = '<%=Request.QueryString["OrderNo"]%>';
        var ProdOrderId = '<%=Request.QueryString["ProdOrderId"]%>';
        var prodline = '<%=Request.QueryString["prodline"]%>';
        $(document).ready(function () {
            $('#txtPrintNumber').val('1');
            // 注塑班长可编辑打印张数
            try {
                var isTL = SKT.LeanMES.Web.AjaxServices.AjaxAccount.CheckUserRole('注塑班长').value;
                if (isTL) {
                    $('#txtPrintNumber').prop('disabled', false).prop('readonly', false);
                }
            } catch(e) {}

            //初始化称重插件
            initElectronic();
            bindPrinters('selPrintersList');
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('InjectionMoldingBatchPrintCollection');
                },
                10
            );

            /*从注塑机台跳转*/
            if (OrderNo != "" && ProdOrderId != "") {
                var list = [[ProdOrderId, OrderNo]];
                getItemChoose(list);
            }

            isByPass = 1;

            //加载不良现象明细（改造新增）
            loadNcCodeList();
        });

        function SendEmail(errmessage) {
                debugger
                var entity = {}
                entity.EquipmentCode = prodline;
            entity.OrderNo = $("#txtOrderNo").val();
                entity.ModelName = '';
                entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                entity.ErrMessage = errmessage;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspInjectionMoldingProductionSendEmail_NEW250914", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
      
        }

        function CollectErrMessage(errmessage) {
            var entity = {}
            entity.EquipmentCode = prodline;
            entity.OrderNo = $("#txtOrderNo").val()
            entity.ErrMessage = errmessage;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspProErrMessageDataCollect", JSON.stringify(entity));
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return;
                    }

                }



        function containsStringCompat(str, substring) {
            return str.indexOf(substring) !== -1;
        }

        function SavePrint() {
            // ========== 注塑班长角色跳过100秒限制 ==========
            var isTeamLeader = SKT.LeanMES.Web.AjaxServices.AjaxAccount.CheckUserRole('注塑班长').value;
            if (!isTeamLeader) {
            // ========== 持久化100秒防重复（刷新页面不失效）Start ==========
            const limitSecond = 100; // 限制间隔100秒
            const storageKey = "LastGoodPrintClickTime";
            let lastClickTs = parseInt(localStorage.getItem(storageKey) || "0");
            const nowTime = new Date().getTime();
            const diffSecond = (nowTime - lastClickTs) / 1000;

            if (diffSecond < limitSecond) {
                const remainSec = Math.ceil(limitSecond - diffSecond);

                // 获取当前时间
                let now = new Date();
                let timeStr = now.getFullYear() + "年" + (now.getMonth() + 1).toString().padStart(2, "0") + now.getDate().toString().padStart(2, "0") + " "
                    + now.getHours().toString().padStart(2, "0") + ":" + now.getMinutes().toString().padStart(2, "0") + ":" + now.getSeconds().toString().padStart(2, "0");
                // 拼接提示文本，红色
                let tipText = `[${timeStr}] 操作间隔限制，还需等待${remainSec}秒才能再次打印良品标签！`;
                // 追加到页面底部日志区，换行
                $("#activeinfoarea").append(`<div style="color:red;">${tipText}</div>`);
                // 清空中间printMessage避免残留
                $("#printMessage").text("");

                return false;
            }
            // 记录本次点击时间到本地存储
            localStorage.setItem(storageKey, nowTime.toString());
            // 按钮锁定
            $("#btnGoodLabel").attr("disabled", true);
            // 倒计时结束：解锁按钮 + 清除存储记录
            setTimeout(function () {
                $("#btnGoodLabel").removeAttr("disabled");
                localStorage.removeItem(storageKey);
                $("#printMessage").text("");
            }, limitSecond * 1000);
            // ========== 持久化防重复 End ==========
            } // end if (!isTeamLeader)

            //1.获取当前基本信息                 
            var resourceId = $("#hdnCurrResourceId").val(); //资源Id
            var stationId = $("#hdnCurrStationId").val(); //工位Id

            if (!stationId > 0) {
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
            //if (canReleaseQty < (parseInt($("#txtPrintNumber").val()) * parseInt(BatchQty))) { alert("本次打印批次数量不能大于工单可打印数量！"); return false; }
            printName = $("#selPrintersList").val();
            var orderId = $("#<%=this.hdnOrderId.ClientID %>").val();
            if (orderId == -1 || orderId == "") {
                alert("请先选择工单！");
                return false;
            }

            $("#lblMessage").html("正在释放工单，请不要关闭窗口耐心等稍...");
            $("#btnGoodLabel").attr("disabled", true)
           
            setTimeout(function () {
                /*begin release*/
                var itemids = myItemID;
                debugger
                var ReleaseQty = $("#txtPrintNumber").val();
                var myBatchQty = BatchQty;
                var myajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.ReleaseBatchSOAndPass(parseInt(ReleaseQty), parseFloat(myBatchQty), orderId, itemids, stationId, resourceId);
                if (myajax.error != null) {
                    showAreaMessge(myajax.error.Message, "messageRed");
                    RemoveDisable();
                    CollectErrMessage(myajax.error.Message);
                    if (containsStringCompat(myajax.error.Message, '模具') || containsStringCompat(myajax.error.Message, '上模')) {
                        SendEmail(myajax.error.Message);
                    }
                    return false;
                }

                labelType = -36;
                labelItemId = itemids;
                labelStationId = stationId;
                labelProdOrderId = orderId;

                getDocumentInfo();
                // 注塑班长：用手工输入的打印张数覆盖模板默认值
                if (isTeamLeader) {
                    var manualCount = parseInt($('#txtPrintNumber').val());
                    if (!isNaN(manualCount) && manualCount > 0) {
                        printCount = manualCount;
                    }
                }
                //获取标签信息
                SNInfo = myajax.value;
                LoadOrderInfo($("#txtOrderNo").val());
                setTimeout(function () {
                    try {
                        for (var i = 0; i < printCount; i++) {
                            MymesLabLabelPrint(SNInfo.SNList);
                        }
                    }
                    catch (e) {
                        showAreaMessge(e, "messageRed");
                        RemoveDisable();
                    }
                }, 30);
            }, 30);
        }

        function RemoveDisable() {
            if ($("#btnGoodLabel").is(":disabled")) {
                $("#btnGoodLabel").removeAttr("disabled");
            }
        }

        function getItemChoose(list) {
            var newOrderNo = list[0][1];
            $("#txtOrderNo").val(newOrderNo);
            $("#<%=this.hdnOrderId.ClientID %>").val(list[0][0]);
            LoadOrderInfo(newOrderNo);
            //改造：换了工单 → 旧的不良现象数量作废（清零并清缓存）；同一工单 → 恢复缓存数量
            if (ncStorageOrderNo != "" && ncStorageOrderNo != newOrderNo) {
                for (var i = 0; i < ncItems.length; i++) { ncItems[i].qty = 0; }
                ncRenderQtyValues();
                ncClearStorage();
            }
            ncApplyStorage(newOrderNo);
        }

        function LoadOrderInfo(myno) {
            var stationId = $("#hdnCurrStationId").val(); //工位Id
            var info = { OrderNo: myno, StationID: stationId };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetProdBatchOrderInfo", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtOrderNo").val("");
                $("#<%=this.hdnOrderId.ClientID %>").val(-1);
                $("#labQty").text("");
                myItemID = -1;
                myItemName = "";
                $("#labOrderQty").text("");
                $("#labPrintedQty").text("");
                $("#labBatchQty").text("");
                $("#labItemName").text("");
                $("#txtBatchQty").val("");
                checkBatchWarning();
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#labQty").text(listOrder[0].NotReleasedQty);
            myItemID = listOrder[0].ItemID;
            $("#labBatchQty").text(listOrder[0].LotSize);
            //工单数量、已打印数量（可打印数量 = 工单数量 - 已打印数量）
            $("#labOrderQty").text(listOrder[0].OrderQty);
            $("#labPrintedQty").text(listOrder[0].PrintedQty);
            //产品名称后面附上产品规格
            myItemName = "(" + listOrder[0].ItemCode + ")" + listOrder[0].ItemName;
            var itemNameText = myItemName;
            var itemSpec = listOrder[0].ItemSpec;
            if (itemSpec != null && $.trim(String(itemSpec)) != "") {
                itemNameText += " [规格：" + $.trim(String(itemSpec)) + "]";
            }
            $("#labItemName").text(itemNameText);
            if ($("#txtBatchQty").val() == "") {
                $("#txtBatchQty").val(listOrder[0].LotSize);
            }

            //批次预警检测（工单数量/已打印数量更新后）
            checkBatchWarning();

        }

        /*是否是数字*/
        function isNumber(s) {
            var regu = "^[0-9]+$";
            var re = new RegExp(regu);
            if (s.search(re) != -1) {
                return true;
            } else {
                return false;
            }
        }

        function openChoosePage(flags) {
            var condition = " Status NOT IN (2,4,6,7)";
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&CallBackFunc=getItemChoose&SearchCondition=" +
                    condition +
                    "&rnd=" +
                    Math.random(),
                width: 650,
                height: 350
            });
        }


        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '<%=Request.QueryString["ItemID"] %>';    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
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
                RemoveDisable();
                return false;
            }

            //初始化打印插件
            //InityPrintingPlugin();
        }


        //codesoft打印  Lab模板方式
        function MymesLabLabelPrint(list,submit=1) {
            if (list.length == 0) {
                ibs = 3 * printCount;
                setInterval(function () { $("#lblPt").html("打印条码完成！"); ibs-- }, 1000)
                if (submit == 1) {
                    setTimeout(function () {
                        document.forms[0].submit();
                    }, 3000);
                }
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
                    RemoveDisable();
                    return;
                }
            } else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                RemoveDisable();
                return;
            }
            $("#lblPt").html("发送条码【" + list.join() + "】打印指令到打印机,请勿关闭窗口！<br/> 当前剩余打印数量【" + newlist.length + "】");
            //sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, null,<%=ConfigurationManager.AppSettings["PrintType"]%>);
            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, function (success, ws, msg) {
                if (!success) {
                    if (ws && ws.readyState != 1) {
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                        RemoveDisable();
                        return;
                    }
                }

                //最后一个PDF的时候提示
                if (newlist.length == 0) {
                    var data = JSON.parse(msg.data);
                    if (data.Result) {
                        layer.open({ title: "打印机脱机", content: "如需预览请复制以下地址到浏览器地址栏并回车。<textarea style='width:100%;height:100%;border:none;overflow:hidden;color:red;'>" + data.Result + "</textarea>" });
                    }
                }

                MymesLabLabelPrint(newlist, submit);
            },<%=ConfigurationManager.AppSettings["PrintType"]%>);

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

        //不良标签打印
        function NcDataPrint() {

            var labQty = parseInt($("#labQty").text());
            //if (labQty < 1) {
            //    alert("本次打印不良登记数量不能大于工单可打印数量！");
            //    return false;
            //}
            var stationId = $("#hdnCurrStationId").val(); //工位Id
            var prodline = $("#hdCurProLine").val();
            var productName = myItemName != "" ? myItemName : $("#labItemName").text();
            var orderId = $("#hdnOrderId").val();
            var OrderNo = $("#txtOrderNo").val();
            var itemId = '<%=Request.QueryString["ItemID"] %>';
            var resourceId = $("#hdnCurrResourceId").val(); //资源Id
            var Qty = parseInt($("#labQty").text());

            if (OrderNo == "") {
                alert("请选择工单号！");
                return false;
            }
            //改造：所有不良现象数量都是 0 时，弹窗报错并阻止继续登记
            if (ncItems.length == 0) {
                alert("不良现象明细未加载成功，无法登记不良！\r\n请刷新页面重试；若仍不行，请联系管理员检查存储过程 uspGetInjectionMoldingNcCode_Program。");
                return false;
            }
            if (ncSumQty() <= 0) {
                alert("所有不良现象的数量都是 0，无法登记不良！\r\n请先填写不良现象的数量，再点「不良登记」。");
                return false;
            }
            //var idStr = getOneRecordId();
            //if (idStr === "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Client/DefectiveProductLabel.aspx?name=DefectiveProductLabel&ID=1&OrderNo=" + escape(OrderNo) + "&OrderId=" + orderId + "&LineId=" + escape(prodline) + "&StationId=" + stationId + "&ProductName=" + escape(productName.replaceAll("#", "")) + "&ItemID=" + itemId + "&resourceId=" + resourceId + "&Qty=" + Qty + "&NcSum=" + ncSumQty() + "&NcPayload=" + escape(ncPayloadStr());
            dialog({ title: "不良登记", src: openWinUrl, width: 750, height: 450 });
        }

        function MaterialHandelPrint() {

            var stationId = $("#hdnCurrStationId").val(); //工位Id
            var prodline = $("#hdCurProLine").val();
            var productName = myItemName != "" ? myItemName : $("#labItemName").text();
            var orderId = $("#hdnOrderId").val();
            var OrderNo = $("#txtOrderNo").val();
            var itemId = myItemID;
            var resourceId = $("#hdnCurrResourceId").val(); //资源Id
            var Qty = parseInt($("#labQty").text());

            if (OrderNo == "") {
                alert("请选择工单号！");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Client/MaterialHandelPrint.aspx?name=DefectiveProductLabel&ID=1&OrderNo=" + escape(OrderNo) + "&OrderId=" + orderId + "&LineId=" + escape(prodline) + "&StationId=" + stationId + "&ProductName=" + escape(productName.replaceAll("#", "")) + "&ItemID=" + itemId + "&resourceId=" + resourceId + "&Qty=" + Qty + "&printname=" + $("#selPrintersList").val();
            dialog({ title: "料把打印", src: openWinUrl, width: 750, height: 450 });
        }

        //本地扣减可打印数量时，同步累加已打印数量，保持 工单数量 - 已打印数量 = 可打印数量
        function syncPrintedQty(qty) {
            var printed = parseInt($("#labPrintedQty").text(), 10);
            if (isNaN(printed)) { printed = 0; }
            var addQty = parseInt(qty, 10);
            if (isNaN(addQty) || addQty < 0) { addQty = 0; }
            $("#labPrintedQty").text(printed + addQty);
        }

        function UpdateList(Sn, Qty) {
            var lagQty = parseInt($("#labQty").text());
            var newQyt = lagQty - parseInt(Qty);
            $("#labQty").text(newQyt);
            syncPrintedQty(Qty);
            updateCollectionList(Sn, 'NG');

            labelType = -39;
            labelItemId = myItemID;
            labelStationId = $("#hdnCurrStationId").val();
            labelProdOrderId = $("#hdnOrderId").val();

            getDocumentInfo();
            //获取标签信息
            SNInfo = {
                SNList: [Sn]
            }
            //LoadOrderInfo($("#txtOrderNo").val());
            setTimeout(function () {
                try {
                    for (var i = 0; i < printCount; i++) {
                        MymesLabLabelPrint(SNInfo.SNList,0);
                    }
                }
                catch (e) {
                    showAreaMessge(e, "messageRed");
                    RemoveDisable();
                }
            }, 30);
        }

        function UpdateListNG(Sn, Qty) {
            var lagQty = parseInt($("#labQty").text());
            var newQyt = lagQty - parseInt(Qty);
            $("#labQty").text(newQyt);
            syncPrintedQty(Qty);
            updateCollectionList(Sn, 'NG');
        }


        function MaterialHandelPrintCallBack(Sn, Qty,itemid) {
            //var lagQty = parseInt($("#labQty").text());
            //var newQyt = lagQty - parseInt(Qty);
            //$("#labQty").text(newQyt);
            updateCollectionList(Sn, 'OK');

            labelType = -38;
            labelItemId = itemid;
            labelStationId = $("#hdnCurrStationId").val();
            labelProdOrderId = $("#hdnOrderId").val();

            //getDocumentInfo();
            ////获取标签信息
            //SNInfo = {
            //    SNList:[Sn]
            //}

            //MymesLabLabelPrint(SNInfo.SNList,0);
        }

        /************************ 不良现象明细（改造新增） 开始 ************************/
        var ncItems = [];           //[{ id: NCCodeId, code: 代码, name: 名称, qty: 数量 }]
        var NC_ROWS_PER_COL = 5;    //每列 5 条

        //加载不良现象（数据库 Basal_NCCode 中 Category='Failure' 失败品、Status='Enabled'）
        //界面显示「名称」（Description，空则回退显示代码 NCCode）
        function loadNcCodeList() {
            ncItems = [];
            var entity = { Category: "Failure" };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetInjectionMoldingNcCode_Program", JSON.stringify(entity));
            if (ajax.error != null) {
                $("#activeinfoarea").append('<div style="color:red;">加载不良现象失败：' + ajax.error.Message + '</div>');
                return false;
            }
            var list = [];
            try { list = JSON.parse(ajax.value).data || []; } catch (e) { list = []; }
            for (var i = 0; i < list.length; i++) {
                var code = list[i].NCCode || "";
                var name = list[i].NcName || list[i].Description || "";
                if (name == "") { name = code; }        //名称为空时回退显示代码
                ncItems.push({ id: list[i].NCCodeId, code: code, name: name, qty: 0 });
            }
            renderNcList();
            ncApplyStorage($("#txtOrderNo").val());   //改造：按工单恢复本机缓存的数量
        }

        //按每列 5 条渲染：不良现象名称 [-] [数量] [+]
        function renderNcList() {
            var colCount = Math.ceil(ncItems.length / NC_ROWS_PER_COL);
            if (colCount < 1) { colCount = 1; }
            var html = '<table cellpadding="0" cellspacing="0" border="0"><tr>';
            for (var c = 0; c < colCount; c++) {
                html += '<td valign="top" style="padding-right: 26px;">';
                for (var r = 0; r < NC_ROWS_PER_COL; r++) {
                    var idx = c * NC_ROWS_PER_COL + r;
                    if (idx >= ncItems.length) { break; }
                    html += '<div style="line-height: 40px; white-space: nowrap;">'
                        + '<span style="display: inline-block; min-width: 140px; font-size: 18px; font-weight: bold;" title="' + ncItems[idx].code + '">' + ncItems[idx].name + '</span>'
                        + '<input type="button" class="ButtonBox" style="width: 42px; height: 34px; font-size: 22px; font-weight: bold; line-height: 32px; cursor: pointer;" value="－" onclick="ncStep(' + idx + ',-1);" />'
                        + '<input type="text" id="ncQty' + idx + '" value="0" style="width: 76px; height: 32px; font-size: 18px; font-weight: bold; text-align: center; vertical-align: middle;" onkeyup="ncTyping(' + idx + ',this);" onchange="ncTyping(' + idx + ',this);" />'
                        + '<input type="button" class="ButtonBox" style="width: 42px; height: 34px; font-size: 22px; font-weight: bold; line-height: 32px; cursor: pointer;" value="＋" onclick="ncStep(' + idx + ',1);" />'
                        + '</div>';
                }
                html += '</td>';
            }
            html += '</tr></table>';
            $("#ncList").html(html);
        }

        //减号/加号：步进 1，不允许负数
        function ncStep(idx, delta) {
            var v = parseInt(ncItems[idx].qty, 10);
            if (isNaN(v)) { v = 0; }
            v = v + delta;
            if (v < 0) { v = 0; }
            ncItems[idx].qty = v;
            $("#ncQty" + idx).val(v);
            ncSaveStorage();                 //改造：暂存到本机缓存，刷新不丢
        }

        //文本框直接输入：只允许非负整数
        function ncTyping(idx, el) {
            var v = parseInt($(el).val(), 10);
            if (isNaN(v) || v < 0) { v = 0; }
            if (v > 999999) { v = 999999; }
            ncItems[idx].qty = v;
            $(el).val(v);
            ncSaveStorage();                 //改造：暂存到本机缓存，刷新不丢
        }

        //把所有不良现象数量清零（不良登记保存成功后由弹窗回调，改造新增）
        function clearNcQty() {
            for (var i = 0; i < ncItems.length; i++) {
                ncItems[i].qty = 0;
                $("#ncQty" + i).val(0);
            }
            ncSaveStorage();                     //清零后的状态也写回缓存，刷新后仍是 0
        }

        /******************** 不良现象数量本机缓存（刷新不丢） 开始 ********************/
        var NC_STORAGE_KEY = "InjectionMoldingNcQty";    //缓存键
        var ncStorageOrderNo = "";                       //缓存对应的工单号

        //把模型里的数量刷到界面输入框
        function ncRenderQtyValues() {
            for (var i = 0; i < ncItems.length; i++) {
                $("#ncQty" + i).val(parseInt(ncItems[i].qty, 10) || 0);
            }
        }

        //读取缓存内容
        function ncReadStorage() {
            try {
                var s = localStorage.getItem(NC_STORAGE_KEY);
                return s ? JSON.parse(s) : null;
            } catch (e) { return null; }
        }

        //写入缓存：{ orderNo: 工单号, items: { 不良现象ID: 数量 } }
        function ncSaveStorage() {
            try {
                var obj = { orderNo: ncStorageOrderNo || "", items: {} };
                for (var i = 0; i < ncItems.length; i++) {
                    obj.items[ncItems[i].id] = parseInt(ncItems[i].qty, 10) || 0;
                }
                localStorage.setItem(NC_STORAGE_KEY, JSON.stringify(obj));
            } catch (e) { }
        }

        //清掉缓存（换工单时旧数量作废）
        function ncClearStorage() {
            try { localStorage.removeItem(NC_STORAGE_KEY); } catch (e) { }
        }

        //按工单号恢复数量：只恢复同一个工单的缓存，其它工单的缓存不套用
        function ncApplyStorage(orderNo) {
            ncStorageOrderNo = orderNo || "";
            var data = ncReadStorage();
            if (!data || !data.items) { return; }
            if ((data.orderNo || "") != ncStorageOrderNo) { return; }
            for (var i = 0; i < ncItems.length; i++) {
                var q = parseInt(data.items[ncItems[i].id], 10);
                if (isNaN(q) || q < 0) { q = 0; }
                ncItems[i].qty = q;
            }
            ncRenderQtyValues();
        }
        /******************** 不良现象数量本机缓存（刷新不丢） 结束 ********************/

        //所有不良现象数量之和
        function ncSumQty() {
            var s = 0;
            for (var i = 0; i < ncItems.length; i++) {
                s += parseInt(ncItems[i].qty, 10) || 0;
            }
            return s;
        }

        //数量不为 0 的不良现象
        function ncNonZero() {
            var arr = [];
            for (var i = 0; i < ncItems.length; i++) {
                var q = parseInt(ncItems[i].qty, 10) || 0;
                if (q > 0) { arr.push({ id: ncItems[i].id, code: ncItems[i].code, name: ncItems[i].name, qty: q }); }
            }
            return arr;
        }

        //传给不良登记窗口的明细串：id|代码|名称|数量;id|代码|名称|数量
        function ncPayloadStr() {
            var arr = ncNonZero();
            var parts = [];
            for (var i = 0; i < arr.length; i++) {
                var code = (arr[i].code || "").replace(/[|;]/g, " ");
                var name = (arr[i].name || "").replace(/[|;]/g, " ");
                parts.push(arr[i].id + "|" + code + "|" + name + "|" + arr[i].qty);
            }
            return parts.join(";");
        }
        /************************ 不良现象明细（改造新增） 结束 ************************/
    </script>
</asp:Content>
