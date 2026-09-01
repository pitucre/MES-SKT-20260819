<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="InjectionMoldingBatchPrintCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.InjectionMoldingBatchPrintCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                                <td style="width: 18%;">工单号<em style="color: red;">*</em>
                                    <input type="text" id="txtOrderNo" style="height: 26px; width: 200px;" disabled="disabled" /><input type="button" id="btnSelectOrder" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(44);" />
                                    <asp:HiddenField ID="hdnOrderId" runat="server" Value="-1" ClientIDMode="Static" />
                                </td>
                                <td style="width: 480px;">打印机列表：
                                    <select id="selPrintersList" style="width: 250px; height: 26px;">
                                    </select>
                                    <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机</a>
                                </td>
                                <td style="width: 150px;">可打印数量：
                                    <label id="labQty"></label>
                                </td>
                                <td style="width: 150px;">每批次数量：
                                    <label id="labBatchQty"></label>
                                </td>
                                <td>产品名称：
                                    <label id="labItemName"></label>
                                </td>
                            </tr>
                        </table>
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
                        <input type="text" id="txtBatchQty" class="scan-center-sn" />
                    </td>
                </tr>
                <tr>
                    <td class="Label3 " style="text-align: left;" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;打印张数:&nbsp;&nbsp;
                        <input type="text" id="txtPrintNumber" style="height: 30px;" readonly="readonly" disabled="disabled"/>
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

        var OrderNo = '<%=Request.QueryString["OrderNo"]%>';
        var ProdOrderId = '<%=Request.QueryString["ProdOrderId"]%>';
        var prodline = '<%=Request.QueryString["prodline"]%>';
        $(document).ready(function () {
            $('#txtPrintNumber').val('1');
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
                //获取标签信息
                SNInfo = myajax.value;
                //for (var i = 0; i < SNInfo.SNList.length; i++) {
                //    updateCollectionList(SNInfo.SNList[i], 'OK');
                //    setMessageBox(SNInfo.SNList[i] + ':打印完成，通过', "messageGreen");
                //    showAreaMessge(SNInfo.SNList[i] + ':打印完成，通过 ！' + (prodWeight > 0 ? "当前产品重量为：" + prodWeight + " " + units : ""), 'messageGreen');
                //    //根据SN刷新侧边栏动态信息
                //    refreshProInfoBySN(SNInfo.SNList[i]);
                //}
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
            $("#txtOrderNo").val(list[0][1]);
            $("#<%=this.hdnOrderId.ClientID %>").val(list[0][0]);
            LoadOrderInfo($("#txtOrderNo").val());
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
                $("#labBatchQty").text("");
                $("#labItemName").text("");
                $("#txtBatchQty").val("");
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#labQty").text(listOrder[0].NotReleasedQty);
            myItemID = listOrder[0].ItemID;
            $("#labBatchQty").text(listOrder[0].LotSize);
            $("#labItemName").text("(" + listOrder[0].ItemCode + ")" + listOrder[0].ItemName);
            if ($("#txtBatchQty").val() == "") {
                $("#txtBatchQty").val(listOrder[0].LotSize);
            }


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
            var productName = $("#labItemName").text();
            var orderId = $("#hdnOrderId").val();
            var OrderNo = $("#txtOrderNo").val();
            var itemId = '<%=Request.QueryString["ItemID"] %>';
            var resourceId = $("#hdnCurrResourceId").val(); //资源Id
            var Qty = parseInt($("#labQty").text());

            if (OrderNo == "") {
                alert("请选择工单号！");
                return false;
            }
            //var idStr = getOneRecordId();
            //if (idStr === "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Client/DefectiveProductLabel.aspx?name=DefectiveProductLabel&ID=1&OrderNo=" + escape(OrderNo) + "&OrderId=" + orderId + "&LineId=" + escape(prodline) + "&StationId=" + stationId + "&ProductName=" + escape(productName.replaceAll("#", "")) + "&ItemID=" + itemId + "&resourceId=" + resourceId + "&Qty=" + Qty;
            dialog({ title: "不良登记", src: openWinUrl, width: 750, height: 450 });
        }

        function MaterialHandelPrint() {

            var stationId = $("#hdnCurrStationId").val(); //工位Id
            var prodline = $("#hdCurProLine").val();
            var productName = $("#labItemName").text();
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

        function UpdateList(Sn, Qty) {
            var lagQty = parseInt($("#labQty").text());
            var newQyt = lagQty - parseInt(Qty);
            $("#labQty").text(newQyt);
            updateCollectionList(Sn, 'NG');

            labelType = -36;
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
    </script>
</asp:Content>
