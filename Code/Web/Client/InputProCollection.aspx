<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="InputProCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.InputProCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #divPanel
        {
            width: 100%;
            height: 180px;  
            background-color:White;          
        }
        #divPanel ul li
        {
            width: 31%;
            float: left;
            border: 1px solid #ccc;
            margin: 2px 1px 2px 1px;
            text-align: center;
            white-space: nowrap;
            text-overflow: ellipsis;
            -o-text-overflow: ellipsis;
            overflow: hidden;
        }
        
        #divPanel ul li:hover
        {
            width: 31%;
            float: left;
            border: 1px solid green;
            margin: 2px 1px 2px 1px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">
                            <%--AC_OBA_ScanSN--%>
                            <span id="lblScanType">
                                <%=Resources.lang.AC_ScanGRN%></span> <span id="lblGrnQty" style="color: Green;">
                            </span></span>&nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <div style="visibility: hidden">
                            <input type="checkbox" id="chkOnLineSN" value="yes" />
                            <%=Resources.lang.OnLineSN %>&nbsp;&nbsp;
                            <input type="checkbox" id="chkOffLineSN" value="yes" />
                            <%=Resources.lang.OffLineSN %>&nbsp;&nbsp;</div>
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked />
                        <%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" style="width: 90%; margin-right: 5px;" />
                        <input type="button" onclick="forceClose()" value=" 强制关闭 " />
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
            </table>
        </div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %></div>
                            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 60px;">
                                            <%=Resources.lang.Sequence%>
                                        </th>
                                        <th>
                                            <%=Resources.lang.SerialNumber %>
                                        </th>
                                        <th style="width: 70px;">
                                            <%=Resources.lang.Status %>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlist">
                                </tbody>
                            </table>
                        </div>
                    </td>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                拼版列表
                            </div>
                            <div >
                                <div id="divPanel" style="width: 100%">
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <%--<script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3"
        type="text/javascript"></script>--%>
    <script language="javascript" type="text/javascript">
        var regexp = "";
        var panelScanUnitId = ""; //扫描的拼版序号ID
        var panelScanCount = 0;
        var routeId = -1;
        var prodOrderId = -1;
        var resourceId = -1;
        var stationId = -1;
        var panelSN = "";

        $(document).ready(function () {
            //投入过站必须选择工单后才可以进行扫描动作
            $("#txtSN").attr("disabled", "disabled");
            SelectProOrder();
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('Input_ProCollectionUI');
                },
                10
            );
            loadingPanelTable(1, 1);

            $("#chkOnLineSN").bind("click", function () {
                if (this.checked == true) {
                    $("#chkOffLineSN").attr("checked", false);
                    regexp = "";
                }
            });
            $("#chkOffLineSN").bind("click", function (item) {
                if (this.checked == true) {
                    $("#chkOnLineSN").attr("checked", false);
                    //获取离线条码规则
                    regexp = getRegExpStr();
                }
            });
        });

        var chooseFlag = 0;
        var scanType = 1; //扫描类型：1、GRN  2、SN
        var grnQty = 0; //GRN包装数量
        var grn = "";
        var totalQty = 0; //总数量
        /**
        *选择工单
        */
        function SelectProOrder() {
            chooseFlag = 1;
           // var searchCondition = "1=1"; // "Status=1"; 
            var searchCondition = ""; // "Status=1"; 

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&CallBackFunc=getProOrderValue&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /**
        *返回值
        */
        function getProOrderValue(list) {

            if (chooseFlag == 1) {
                //---选择工单后动作：1、路由获取；2、相关动态信息获取；3、根据当前工序及路由获取前后工序信息并回显
                $("#hdnCurrProOrderId").val(list[0][0]);
                //1、获取路由
                var routeId = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetRouteIdByProOrderId(list[0][0]);
                if (routeId.error != null) {
                    alert(routeId.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", routeId.error.Message);
                    return false;
                }
                var routeId = routeId.value;

                if (routeId === "-1") {
                    //获取路由失败
                    alert("Error:" + "<%=Resources.Messages.CreateSN_Router_Invalid %>");
                    return false;
                } else {

                    //获取路由成功
                    $("#hdnCurrRouteId").val(routeId);
                    $("#txtSN").removeAttr("disabled");
                }
                //2、相关动态信息获取
                refreshProInfoByProOrderId(list[0][0]);

                //3、根据当前工序及路由获取前后工序信息并回显
                stationRefresh();

                //end、重新绘制窗口
                setContentHeight();
                setLeftMenuHeight();
                setActiveInfoHeight();


            }
            chooseFlag = 0;
            //焦点
            setTimeout(
                function () {
                    $("#txtSN").focus();
                },
                10
            );
        }

        /**
        *扫描触发事件
        */
        function afterScan() {
            var scanSN = $.trim($("#txtSN").val());
            var isOffLineSN = $("#chkOffLineSN").is(":checked") == true ? 1 : 0; //是否是外来条码 
            var isOnLineSN = $("#chkOnLineSN").is(":checked") == true ? 1 : 0; //是否是在线打印条码

            isOffLineSN = 0;
            isOnLineSN = 0; //考虑拼版情况，先隐藏外来条码和在线打印条码功能

            if (scanSN != "") {
                if ($("#cbxforceuppercase").prop("checked")) {
                    scanSN = ($.trim($("#txtSN").val()).toUpperCase());
                }
                //1.查看是否有RouteId及工单Id
                routeId = $("#hdnCurrRouteId").val();
                prodOrderId = $("#hdnCurrProOrderId").val();
                resourceId = $("#hdnCurrResourceId").val();
                stationId = $("#hdnCurrStationId").val();

                if (routeId == "-1") {
                    alert("Error:" + "<%=Resources.Messages.CreateSN_Router_Invalid %>");
                    $("#txtSN").val("");
                    $("#txtSN").focus();
                    return false;
                }
                else if (prodOrderId === "-1") {
                    alert("Error:" + "<%=Resources.Messages.OrderEmptyWei %>");
                    SelectProOrder();
                    return false;
                }

                if (scanType == 1) {//1、GRN扫描
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.CheckInputGRN(scanSN, prodOrderId, stationId);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ":" + ajax.error.Message, "messageRed");
                        $("#txtSN").val("");
                        $("#txtSN").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    grnQty = parseFloat(ajax.value[0]);
                    var itemId = ajax.value[1];
                    totalQty = parseFloat(ajax.value[2]);
                    grn = scanSN;

                    //打印参数初始化
                    labelStationId = stationId;
                    labelItemId = itemId;
                    labelProdOrderId = prodOrderId;

                    scanType = 2; //需扫描SN
                    $("#lblScanType").text('<%=Resources.lang.AC_OBA_ScanSN%>');
                    $("#lblGrnQty").html(" 过板数量：" + grnQty + "/" + totalQty);
                    $("#txtSN").val("");
                    $("#txtSN").focus();
                    updateCollectionList(scanSN, 'OK');
                    showAreaMessge(scanSN + ':通过', "messageGreen");

                    //在线打印条码
                    if (isOnLineSN) {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.ReleaseSO(grnQty, prodOrderId, itemId);
                        if (ajax.error != null) {
                            showAreaMessge(scanSN + ":" + ajax.error.Message, "messageRed");
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                            return false;
                        }

                        //获取标签信息
                        SNInfo = ajax.value;
                        scanSN = "";
                        $.each(SNInfo.SNList, function (index, item) {
                            scanSN += item + ",";
                        });

                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CheckSNInputOrder(scanSN, prodOrderId, routeId, 0, grn, resourceId, stationId, 1);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            $("#txtSN").val("");
                            $("#txtSN").focus();
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                            return false;
                        }

                        showAreaMessge(scanSN.substring(0, scanSN.length - 1) + ':条码生成成功！', "messageGreen");

                        scanType = 1;
                        grn = "";
                        totalQty = 0;
                        $("#lblScanType").text('<%=Resources.lang.AC_ScanGRN%>');
                        $("#lblGrnQty").text('');

                        setTimeout(function () {
                            try {
                                if (getDocumentInfo()) {
                                    usePrinMethod();
                                }
                            }
                            catch (e) {
                                alert(e);
                                showAreaMessge(e, "messageRed");
                            }
                        }, 30);
                    }

                }
                else {
                    if (grnQty > 0) {
                        
                        //**开始对投入SN进行验证

                        //2.对当前扫描的产品条码进行工单验证，验证选择的工单是否与扫描的条码工单一致。
                        if (isOffLineSN == 1 && regexp != "") {
                            //验证离线条码规则
                            var regularArr = regexp.split(';');
                            var reg;
                            if (regularArr != undefined && regularArr.length > 0) {
                                for (var j = 0; j < regularArr.length; j++) {
                                    if (regularArr[j] != "") {
                                        reg = new RegExp(regularArr[j]);
                                        if (!reg.test(scanSN)) {
                                            isValid = false;
                                        }
                                        else {
                                            isValid = true;
                                            break;
                                        }
                                    }
                                }
                                if (!isValid) {//错误的条码规则                                 
                                    showAreaMessge("[" + scanSN + "]不符合离线条码规则！", "messageRed");
                                    updateCollectionList(scanSN, 'NG');
                                    $("#txtSN").val("");
                                    $("#txtSN").focus();
                                    return false;
                                }
                            }
                        }
                        
                        //检查SN信息
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.CheckMatInputSN(scanSN, prodOrderId, stationId, resourceId, panelScanCount);
                        if (ajax.error != null) {
                            updateCollectionList(scanSN, 'NG');
                            showAreaMessge(scanSN + ":" + ajax.error.Message, "messageRed");
                            $("#txtSN").val("");
                            $("#txtSN").focus();
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                            return false;
                        }
                        var unitId = -1;
                        if (ajax.value != null) {
                            unitId = ajax.value.UID;
                            var panelRow = ajax.value.PanelRow;
                            var panelCol = ajax.value.PanelCol;
                            if (panelScanCount == 0) {
                                //加载拼版的行与列
                                loadingPanelTable(panelRow, panelCol);
                                panelSN = scanSN;
                            }
                            scanPanelTable(unitId, scanSN);
                        }
                    }
                    $("#txtSN").val("");
                }

            }
        }

        /**
        *加载拼版列表信息
        **/
        function loadingPanelTable(panelRow, panelCol) {
            var panelHtml = "";
            var current = 0;
            for (var i = 0; i < panelRow; i++) {
                panelHtml += "<ul>";

                for (var j = 0; j < panelCol; j++) {
                    panelHtml += "<li id='panel" + current + "'>";
                    //panelHtml += ("序号" + (current + 1));
                    panelHtml += "</li>";
                    current++;
                }
                panelHtml += "</ul>";

            }
            current = 0;
            $("#divPanel").html(panelHtml);
            $("#divPanel ul").width(($("#divPanel").width()));
            var height = ($("#divPanel").height() - (panelRow * 6)) / panelRow;
            var width = ($("#divPanel ul").width() - (panelCol * 4)) / panelCol;
            $("#divPanel ul li").width(width).height(height).css("line-height", height + "px");
        }

        /**
        *扫描条码添加拼版信息
        **/
        function scanPanelTable(unitId, scanSN) {
            if (panelScanUnitId.indexOf(unitId) >= 0) {
                alert("该SN条码已扫描!");
                return false;
            }
            panelScanUnitId += unitId + ",";
            $("#divPanel ul li").each(
            function (index) {
                if ($(this).html() == "") {
                    $(this).html("<img src='../Content/images/icon/close.gif' onclick='delPanel(this," + unitId + ")' style='cursor:pointer; position:relative;top:2px;right:2px;float:right;' title='点击将会清除序号' alt='X' />" + scanSN).attr("title", scanSN);
                    $(this).css("background-color", "#FFF5BB");
                    panelScanCount++;
                    return false;
                }
            }
            );

            updateCollectionList(scanSN, 'OK');
            showAreaMessge(scanSN + ':通过', "messageGreen");
            grnQty--;
            $("#lblGrnQty").html(" 过板数量：" + grnQty + "/" + totalQty);
            var totalPanel = $("#divPanel ul li").length;
            if (panelScanCount == totalPanel) {
                //拼版扫描完毕，过站
                savePanel();
            }

        }

        /**
        *删除拼版列表信息
        **/
        function delPanel(obj, unitId) {
            var panelObj = ($(obj).parent().attr("id"));
            $("#" + panelObj).html("").css("background-color", "#fff").attr("title", "");
            panelScanUnitId = panelScanUnitId.replace(unitId + ",", "");
            panelScanCount--;
            grnQty++;
            $("#lblGrnQty").html(" 过板数量：" + grnQty + "/" + totalQty);
            $("#txtSN").focus();
        }

        /**
        *扫描完成保存拼版信息并过站
        **/
        function savePanel() {
            panelScanUnitId = panelScanUnitId.substring(0, panelScanUnitId.length - 1);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.CollectMatInputSN(panelScanUnitId, stationId, resourceId, grn);
            if (ajax.error != null) {
                //验证失败                
                showAreaMessge(ajax.error.Message, "messageRed");
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, grn, ajax.error.Message);
                return false;
            }
            if (panelScanCount > 1) {
                showAreaMessge(panelSN + ':拼板绑定成功！', "messageGreen");
            }

            grnQty = parseFloat(ajax.value);

            $("#lblGrnQty").html(" 过板数量：" + grnQty + "/" + totalQty);

            if (grnQty == 0) {
                scanType = 1;
                grn = "";
                totalQty = 0;
                $("#lblScanType").text('<%=Resources.lang.AC_ScanGRN%>');
                $("#lblGrnQty").text('');
            }

            //根据SN刷新侧边栏动态信息
            refreshProInfoBySN(panelSN);
            panelScanCount = 0;
            panelScanUnitId = "";
            loadingPanelTable(1, 1);
            panelSN = "";
            $("#txtSN").focus();
        }

        /**
        *强制关闭保存拼版信息并过站
        **/
        function forceClose() {
            if (panelScanCount == 0) {
                alert("该拼板还没扫描,不能进行强制关闭操作！");
                $("#txtSN").focus();
                return false;
            }
            if (confirm("确定需要强制关闭吗?")) {
                savePanel();
            }
        }

        /**
        *获取工单离线条码规则
        */
        function getRegExpStr() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.GetRegExpByOrderId($("#hdnCurrProOrderId").val());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            return ajax.value;
        }
        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelProdOrderId = -1;
        var labelStationId = -1;    //工位Id
        var labelType = -2;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 1;      //标签序号
        var labelPrintWayId = -1;   //文档打印方式 78、Label标签方式打印 79、ZPL方式打印

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径



        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return true;
            }
            else {
                alert(ajax.error.Message);
                showAreaMessge(ajax.error.Message, "messageRed");
                return false;
            }


            //初始化打印插件
            //InityPrintingPlugin();
        }

        //根据打印方式决定 调用ZPL还是Lab打印
        function usePrinMethod() {
            //根据文档使用的打印方式，决定调用Lab模板方式，还是指令方式。
            if (labelPrintWayId == 78) {
                //codesoft打印  Lab模板方式
                mesLabLabelPrint();
            }
            else if (labelPrintWayId == 79) {
                //指令方式
                mesZPLPrintLabel();
            }
        }

        //codesoft打印  Lab模板方式
        function mesLabLabelPrint() {
            //从已释放的标签信息集合中，获取SN序列号集合。
            lableArr = SNInfo.SNList;

            for (var i = 0; i < lableArr.length; ) {
                //lableArr[i]
                //找到doucumentId打印文档id
                var labelStr = "";

                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            //根据联板数，拼接SN字符串。 
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }

                i = i + lableTypeQty;

                //每发送一次打印指令 初始化标签内容变量。
                labelContent = "";

                //获取标签模板中的标签值 集合
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);

                if (ajaxLabContent.error == null) {
                    //接收打印的ZPL标签  
                    try {
                        var list = ajaxLabContent.value;

                        if (list.length > 0) {

                            for (var h = 0; h < list.length; h++) {
                                labelContent += '{name:"' + list[h].LabelName + '",value:"' + list[h].LabelValue + '"}' + ",";
                            }

                            labelContent = labelContent.substring(0, labelContent.length - 1);
                            labelJsonData = "[{LabelContent:[" + labelContent + "]}]";

                            //labelPrintingPlugin.PrintLabel(tempatePath, labelJsonData);
                            printLabel(tempatePath, labelJsonData, printName, "lab");
                            //条码打印记录
                            var labelSNArr;
                            if (lableTypeQty == 1) { //单板
                                labelSNArr = labelStr.split(",")[0];
                                recordPrint(labelSNArr);
                            } else { //连板
                                labelSNArr = labelStr.split(",");
                                for (var k = 0; k < labelSNArr.length - 1; k++) {
                                    recordPrint(labelSNArr[k]);
                                }
                            }
                        }
                    } catch (e) {
                        alert(e);
                        showAreaMessge(e, "messageRed");
                        return false;
                    }
                }
                else {
                    alert(ajaxLabContent.error.Message);
                    showAreaMessge(ajaxLabContent.error.Message, "messageRed");
                    return false;
                }
            }
        }

        //指令方式
        function mesZPLPrintLabel() {
            lableArr = SNInfo.SNList;
            for (var i = 0; i < lableArr.length; ) {

                //lableArr[i]
                //找到doucumentId打印文档id
                var labelStr = "";
                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }

                i = i + lableTypeQty;

                //获取此标签的zpl指令
                var ajaxZplContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnZplContent(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);
                if (ajaxZplContent.error == null) {
                    zplStr = ajaxZplContent.value;
                    try {

                        //labelPrintingPlugin.DoPrint(zplStr, printName);
                        printLabel("", zplStr, printName, "zpl");

                        //条码打印记录
                        var labelSNArr;
                        if (lableTypeQty == 1) { //单板
                            labelSNArr = labelStr.split(",")[0];
                            recordPrint(labelSNArr);
                        } else { //连板
                            labelSNArr = labelStr.split(",");
                            for (var k = 0; k < labelSNArr.length - 1; k++) {
                                recordPrint(labelSNArr[k]);
                            }
                        }
                    } catch (e) {
                        alert(e);
                        showAreaMessge(e, "messageRed");
                        return false;
                    }
                } else {
                    alert(ajaxZplContent.error.Message);
                    showAreaMessge(ajaxZplContent.error.Message, "messageRed");
                    return false;
                }
            }
        }

        function recordPrint(sn) {
            var printRecodeEntity = {};
            printRecodeEntity.RecordId = -1;
            printRecodeEntity.ActionType = 1;
            printRecodeEntity.PrintType = -2;
            printRecodeEntity.PrintKey = sn;
            printRecodeEntity.StationId = -1;
            printRecodeEntity.ResourceId = -1;
            var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
            if (ajaxPrintRecodes.error != null) {
                alert(ajaxPrintRecodes.error.Message);
                showAreaMessge(ajaxPrintRecodes.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPrintRecodes.error.Message);
                return false;
            }
            showAreaMessge(sn + ':条码打印成功！', "messageGreen");
        }
        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/

        
    </script>
</asp:Content>
