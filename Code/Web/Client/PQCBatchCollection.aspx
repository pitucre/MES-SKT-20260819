<%@ Page Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true"
    CodeBehind="PQCBatchCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PQCBatchCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">
                            <%=Resources.lang.AC_OBA_ScanSN %>/不良代码</span> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <%-- < input type="checkbox" id="cbxInspectionSheet" value="yes" />
                        送检单&nbsp;--%>
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked="checked" />
                        <%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" />&nbsp;&nbsp;<input type="button"
                            id="btnConfirm" value=" 确定过站 " style="display: none;" onclick="confirmPass()" />
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
            <div class="leftmenu-new-header">
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="width: 250px;">
                            批次号：<label id="batch"></label>
                        </td>
                        <td style="width: 250px;">
                            SN数量：<label id="total"></label>
                        </td>
                        <td>
                            <input type="button" value="加载批次号" id="btnEquInit" style="width: 80px;" />&nbsp;
                            <input type="button" value="确认送检" id="btnInspect" style="width: 80px;" />
                        </td>
                    </tr>
                </table>
            </div>
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td valign="top" style="width: 50%">
                        <div id="divNCCode" class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %>
                            </div>
                            <table width="100%" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 10%">
                                            <%=Resources.lang.Sequence%>
                                        </th>
                                        <th style="width: 80%">
                                            <%=Resources.lang.SerialNumber %>
                                        </th>
                                        <th style="width: 10%">
                                            <%=Resources.lang.Status %>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlist">
                                </tbody>
                            </table>
                        </div>
                        <div id="condivPanel" class="dds-panel" style="display: none;">
                            <div class="leftmenu-new-header">
                                拼版列表
                            </div>
                            <div>
                                <div id="divPanel" style="width: 100%">
                                </div>
                            </div>
                        </div>
                    </td>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                不良明细表
                            </div>
                            <div class="data-statistic-relinfo">
                                <div>
                                    <div id="packingTree">
                                        <table width="100%" class="ListTable" id="nccodeList">
                                            <tr id="NCCodeDetailHeader" class="ListTableHeader">
                                                <th width="20%" style="text-align: center">
                                                    不良代码
                                                </th>
                                                <th width="70%" style="text-align: center;">
                                                    不良描述
                                                </th>
                                                <th width="10%">
                                                    操作
                                                </th>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area">
            </div>
        </div>
    </div>
    <input type="hidden" id="hdnCurrLineId" value="-1"/>
    <script language="javascript" type="text/javascript">
        var panelSN = "";
        var isPanel = -1;
        var panelSNArr = [];
        var ncCodeArr = [];
        var scanType = 0; //scanType :0、默认 1、拼版条码 2、拼版子条吗
        var panelId = 0;
        var scanSN = "";
        var isSN = 0;
        var IsMuiltOrder = 1; //是否多工单送检（1：是，0：否）,如果选择工单，则只能同工单批次送检；不选择工单，则可以相同产品（不同工单）一起批次送检.
        $(document).ready(function () {
            //投入过站必须选择工单后才可以进行扫描动作
            //$("#txtSN").attr("disabled", "disabled");
            //SelectProOrder();
            //加载按钮
            setTimeout(function () { loadClientButton('PQCBatchCollection'); }, 10);
            GetLineInfo();
            
           
            //加载批次信息
            $("#btnEquInit").click(function () {
                var batchNo = $("#batch").text();
                if (batchNo.length < 1) {
                    showAreaMessge('没有待送检确认的批次号', "messageRed");
                    return false;
                }
                loadInsPQCBatch("",$("#hdnCurrLineId").val());
            });

            //批次送检
            $("#btnInspect").click(function () {
                var batchNo = $("#batch").text();
                if (batchNo.length < 1) { alert('批次号为空，不能送检！'); return false; }

                if (!confirm('是否送检批次[' + batchNo + ']?')) {
                    return false;
                }
                var resId = parseInt($("#hdnCurrResourceId").val());
                var opeId = parseInt($("#hdnCurrStationId").val());
                var lineId = parseInt($("#hdnCurrLineId").val());

                //送检 
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQualityInspection.Inspect(batchNo, lineId, opeId, resId);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    return false;
                }
                showAreaMessge(batchNo + ':' + "送检成功。", "messageGreen");
                $("#batch").text("");
                $("#total").text("");
                $("#txtSN").val("").focus();
                IsMuiltOrder = 1;

                var id = prodOrderId;
                var orderNo = $.trim($("#span-pi-ShopOrderNo").text());
                if (prodOrderId == -1 && orderNo) {
                    //根据工单号获取工单Id
                    var ajax = SKT.AjaxCommon.DBService.GetAll(0, 1, "ProdOrderID", { ExtensionCondition: "OrderNO = '" + orderNo + "'" }, "Prod_Order", "");
                    if (ajax.value && ajax.value.Tables && ajax.value.Tables[0].Rows[0]) {
                        id = ajax.value.Tables[0].Rows[0]["ProdOrderID"];
                    }
                }
                refreshProInfoByProOrderId(id);
            });
        });

         /**
        *选择工单
        */
        function SelectProOrder() {
            chooseFlag = 1;
           // var searchCondition = "1=1"; // "Status=1"; 
            var searchCondition = "";

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&CallBackFunc=getChangeOrderValue&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /**
        *返回值
        */
        function getChangeOrderValue(list) {        
            if (chooseFlag == 1) {
                //---选择工单后动作：1、路由获取；2、相关动态信息获取；3、根据当前工序及路由获取前后工序信息并回显
                $("#hdnCurrProOrderId").val(list[0][0]);
                IsMuiltOrder = 0;

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
                    //$("#txtSN").removeAttr("disabled");
                }
                $("#txtSN").removeAttr("disabled");

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

        function GetLineInfo() {
            var LineName = $("#hdCurProLine").val();
            if (LineName != "") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceResource.GetLineInfo(LineName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    return null;
                }
                $("#hdnCurrLineId").val(ajax.value);
            }
        }

        //我是不良代码
        var ConstNCCode = "";
        function afterScan() {
            //$("#batch").text("");
            //$("#total").text("");
            if ($.trim($("#txtSN").val()) == "") { return false; }

            //**开始对投入SN进行验证
            if ($("#cbxforceuppercase").prop("checked")) {
                $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
            }
            //1.查看是否有RouteId及工单Id
            routeId = $("#hdnCurrRouteId").val();
            prodOrderId = $("#hdnCurrProOrderId").val();
            resourceId = $("#hdnCurrResourceId").val();
            stationId = $("#hdnCurrStationId").val();
            lineId = $("#hdnCurrLineId").val();
            scanSN = $.trim($("#txtSN").val()); //扫描Sn


            //是否不良代码
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.GetNCCodeInfo(scanSN, stationId);
            if (ajax.error != null) {
                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            if (ajax.value[0] != "") { //当前扫码的SN为不良代码
                ConstNCCode = scanSN;

                //验证不良代码是否重复扫描
                ncCodeArr.push({
                    NCCode: scanSN,
                    NCDesc: ajax.value[1]
                });
                loadingNCTable(ncCodeArr, -1);
                $("#txtSN").val("").focus();
                return false;
            }

            //通用验证SN信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId, false);
            if (ajax.error != null) {
                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }

            if (ConstNCCode != "") {

                //验证SN(不能使用已入批次的SN采集不良)
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxQualityInspection.ValidPQCSN(scanSN, lineId);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    return false;
                }

                var xml = "<PanelSN>";
                xml += "<NCCode SN=\"" + scanSN + "\" CODE=\"" + ConstNCCode + "\" ></NCCode>";
                xml += "</PanelSN>";
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.CollectPassStation(panelId, scanSN, resourceId, stationId, xml);
                if (ajax.error != null) {
                    updateCollectionList(scanSN, 'NG');
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }

                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':采集不良成功！', "messageGreen");
                ncCodeArr = [];
                loadingNCTable(ncCodeArr, -1);
                ConstNCCode = "";
                $("#txtSN").val("").focus();
                return false;
            }

            //加载批次号
            if (loadInsPQCBatch(scanSN, lineId) == true) {
                var batchNo = $("#batch").text();
                //加入批次
                if (!PushSN(batchNo, scanSN, lineId, stationId, resourceId)) { return false; }

                //根据SN刷新侧边栏动态信息
                refreshProInfoBySN(scanSN);
                loadInsPQCBatch(scanSN, lineId);
                $("#txtSN").val("").focus();
            }
        }

        function loadInsPQCBatch(scanSN, lineId) {
            //$("#batch").text("");
            //$("#total").text("");
            var MuiltBatchNo = $.trim($("#batch").text());
            if (MuiltBatchNo.length < 1) {
                MuiltBatchNo = "";
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQualityInspection.GetOrGeneratePQCBatch(scanSN, lineId, prodOrderId, IsMuiltOrder, MuiltBatchNo);
            if (ajax.error != null) {
                $("#txtSN").val("").focus();
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                return false;
            }

            if (IsMuiltOrder == 1)//多工单
            {
                prodOrderId = -1;

            } else {
                prodOrderId = ajax.value.ProdOrderId;
            }

            //显示批次号
            $("#batch").text(ajax.value.PQCBatchNo);
            $("#total").text(ajax.value.Total);
            return true;
        }

        function PushSN(batchNo, sn, lineId, opeId, resId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQualityInspection.PQCBatchPushSN(batchNo, lineId, sn, opeId, resId);
            if (ajax.error != null) {
                $("#txtSN").val("").focus();
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                return false;
            }
            updateCollectionList(scanSN, 'OK');
            showAreaMessge(scanSN + ':通过', "messageGreen");
            return true;
        }

        /*
        *确定拼版采集不良过站
        */
        function confirmPass() {
            if (confirm("是否确认当前拼版下的子板不良都已采集完成，并进行过站操作？")) {
                //采集过站
                collectionPass();

                //传递不良数组和SN，进行过站操作，重置全局参数
                $("#btnConfirm").hide();
                $("#txtSN").css("width", "100%");

                //使用SN扫描模式
                $("#divNCCode").show();
                $("#condivPanel").hide();
            }
        }

        /*
        *采集过站
        */
        function collectionPass() {
            var xml = resultToXml();
            var isNc = 0;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.CollectPassStation(panelId, scanSN, resourceId, stationId, xml);
            if (ajax.error != null) {
                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }

            for (var i = 0; i < panelSNArr.length; i++) {
                if (panelSNArr[i].NCObj.length > 0) {
                    isNc = 1;
                    break;
                }
            }
            if (isNc == 1) {
                if (panelId > 0) {
                    scanSN = panelSN;
                }
                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':采集不良成功！', "messageGreen");
            }
            else {
                updateCollectionList(scanSN, 'OK');
                showAreaMessge(scanSN + ':通过', "messageGreen");
                //自动打印 updata huangliang 2017-11-20
                AutoPrint(stationId, scanSN);
            }

            isPanel = -1;
            panelSNArr = [];
            scanType = 0;
            panelId = 0;
            ncCodeArr = [];
            loadingNCTable(ncCodeArr, -1);
            //refreshProInfoByProOrderId(prodOrderId);
            refreshProInfoBySN(scanSN);
        }

        /*
        *拼接不良信为XML字符串
        */
        function resultToXml() {
            var xml = "<PanelSN>";

            if (Rejects.SN != "") {

            }
            //            for (var i = 0; i < panelSNArr.length; i++) {
            //                var ncCodeArr = panelSNArr[i].NCObj;
            //                for (var j = 0; j < ncCodeArr.length; j++) {
            //                    xml += "<NCCode SN=\"" + panelSNArr[i].SN + "\" CODE=\"" + ncCodeArr[j].NCCode + "\" ></NCCode>";
            //                }
            //            }
            xml += "</PanelSN>";
            return xml;
        }
        /**
        *加载拼版列表信息
        **/
        function loadingPanelTable(panelRow, panelCol) {
            var panelHtml = "";
            var current = 0;
            var panelSNStr = "";
            var styleCss = "";

            for (var i = 0; i < panelRow; i++) {
                panelHtml += "<ul>";

                for (var j = 0; j < panelCol; j++) {
                    if (panelSNArr[current] != null && panelSNArr[current] != undefined) {
                        panelSNStr = panelSNArr[current].SN;
                        if (panelSNStr == "XXXXXX") {
                            styleCss = "background-color:#8B8989;";
                        }
                        else {
                            styleCss = "background-color:#FFF5BB;";
                        }
                    }
                    else {
                        panelSNStr = "";
                        styleCss = "background-color:#fff;";
                    }
                    panelHtml += "<li id='panel" + current + "' title='" + panelSNStr + "' style= 'cursor:pointer;" + styleCss + "'  onclick='loadingNCCode(this," + current + ")' >";
                    panelHtml += ("<div   style='position:relative;top:5px;right:2px;float:right;line-height:3px;' ><div style=' width:16px; height:16px; background-color:#fff; border: 1px solid #B6AF89; border-radius:8px;'><span id=\'nccode" + current + "\' style='color:#000;height:16px; line-height:16px; display:block; text-align:center'>" + (current + 1) + "</span></div></div><span id=\'panelSN" + (current + 1) + "\'>" + panelSNStr + "</span>");
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
        *点击子板加载不良列表信息
        *update by weixia on 2018.5.18如果为XXXXXX,不允许打不良
        **/
        function loadingNCCode(obj, index) {
            var onclickSN = $(obj).attr("title");
            if (onclickSN == "XXXXXX") {
                showAreaMessge("打X板不能打不良", "messageRed");
                return false;
            }
            if ($("#panelSN" + (index + 1)).text() == "") {
                $(obj).css("border", "").css("background-color", "#fff");
                return false;
            }

            /*  $("#divPanel ul li").each(
            function (i) {
            if ($("#panelSN" + (i + 1)).text() != "") {
            if ($(this).css("background-color") != "rgb(253, 52, 32)") {
            $(this).css("border", "").css({ "background-color": "#FFF5BB", "color": "#000" });
            }
            }
            }
            );*/

            $(obj).css({ "background-color": "#1CA01C", "color": "#fff" });

            if (panelSNArr[index] != null && panelSNArr[index] != undefined) {
                for (var i = 0; i < panelSNArr[index].NCObj.length; i++) {
                    for (var j = 0; j < ncCodeArr.length; j++) {
                        if (panelSNArr[index].NCObj[i].NCCode == ncCodeArr[j].NCCode) {
                            panelSNArr[index].NCObj.splice(i, 1);
                        }
                    }
                }
                $.merge(panelSNArr[index].NCObj, ncCodeArr);

                ncCodeArr = [];
                if (panelSNArr[index].NCObj.length > 0) {
                    loadingNCTable(panelSNArr[index].NCObj, index);
                }
                else {

                    $("#nccodeList tr:gt(0)").remove();
                }
            }
            else {
                $("#nccodeList tr:gt(0)").remove();
            }
            $("#txtSN").val("").focus();
        }

        /**
        *加载不良列表信息
        **/
        function loadingNCTable(list, index) {
            var row, cell;
            var setTable = document.getElementById("nccodeList");

            $("#nccodeList tr:gt(0)").remove();
            if (list.length > 0) {
                $("#panel" + index).css({ "background-color": "#FD3420", "color": "#fff" });
                //$("#nccode" + index).parent().css({ ""border": "1px solid #B6AF89", "color": "#000" });
            }
            else {
                $("#panel" + index).css({ "background-color": "#FFF5BB", "border": "1px solid #B6AF89", "color": "#000" });
                //$("#nccode" + index).parent().css({ "background-color": "#FFF5BB","border": "1px solid #B6AF89", "color": "#000" });
            }
            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = list[i].NCCode;

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = list[i].NCDesc;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = "<img src='../Content/images/icon/close.gif' onclick=cancelNCCode(" + i + "," + index + ") style='cursor:pointer;' title='点击将会删除采集的不良' alt='X' />";
            }
        }


        /**
        *取消不良信息
        **/
        function cancelNCCode(i, index) {
            /*  if (panelSNArr.length > 0) {//有拼版的情况删除不良
            panelSNArr[index].NCObj.splice(i, 1);
            //重新加载不良信息
            if (panelSNArr[index] != null && panelSNArr[index] != undefined) {
            loadingNCTable(panelSNArr[index].NCObj, index);
            }
            }
            else {}*/
            ncCodeArr.splice(i, 1);
            loadingNCTable(ncCodeArr, index);

            $("#txtSN").val("").focus();
        }
    </script>
</asp:Content>
