<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="PanelBindProCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PanelBindProCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        #divPanel {
            width: 100%;
            height: 180px;
            background-color: White;
        }

            #divPanel ul li {
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

                #divPanel ul li:hover {
                    width: 31%;
                    float: left;
                    border: 1px solid green;
                    margin: 2px 1px 2px 1px;
                }
    </style>
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle"><span id="lblScanType">
                            <%=Resources.lang.AC_OBA_ScanSN%></span> <span id="lblGrnQty" style="color: Green;"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
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
            </table>
        </div>
        <div style="text-align: left;" class="leftmenu-new-header">打X板请用XXXXXX扫描！</div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %>
                            </div>
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
                            <div>
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
    <script language="javascript" type="text/javascript">
        var panelScanUnitId = ""; //扫描的拼版序号ID
        var panelScanCount = 0;
        var routeId;
        var prodOrderId;
        var resourceId;
        var stationId;
        var panelSN;
        $(document).ready(function () {
            //投入过站必须选择工单后才可以进行扫描动作
            $("#txtSN").attr("disabled", "disabled");
            SelectProOrder();

            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('PanelBindUI');
                },
                10
            );
            loadingPanelTable(1, 1);

        });

        /**
        *选择工单
        */
        function SelectProOrder() {
            chooseFlag = 1;
            //var searchCondition = "1=1"; // "Status=1";          
            var searchCondition = "";   
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&CallBackFunc=getProOrderValue&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /**
        *返回值
        */
        function getProOrderValue(list) {

            if (chooseFlag == 1) {
                $("#divPanel ul").remove();
                panelScanUnitId = "";
                panelScanCount = 0;
                //---选择工单后动作：1、路由获取；2、相关动态信息获取；3、根据当前工序及路由获取前后工序信息并回显
                $("#hdnCurrProOrderId").val(list[0][0]);

                //1、获取路由
                var routeIdInfo = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetRouteIdByProOrderId(list[0][0]);
                if (routeIdInfo.error != null) {
                    alert(routeIdInfo.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", routeIdInfo.error.Message);
                    return false;
                }
                routeId = routeIdInfo.value;

                if (routeId == "-1") {
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
            if (scanSN != 'XXXXXX' && (panelSN == "" || panelSN == null)) {
                panelSN = scanSN;
            }

            if (scanSN != "") {
                if ($("#cbxforceuppercase").prop("checked")) {
                    scanSN = ($.trim($("#txtSN").val()).toUpperCase());
                }
                //1.查看是否有RouteId及工单Id               
                prodOrderId = $("#hdnCurrProOrderId").val();
                resourceId = $("#hdnCurrResourceId").val();
                stationId = $("#hdnCurrStationId").val();
                routeId = $("#hdnCurrRouteId").val();

                if (routeId === "-1") {
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
                    else if (!stationId > 0) {
                        alert("请先在操作菜单列表进行切换工位操作！");
                        return;
                    }
                //如果是X板不判断
                if (scanSN.toUpperCase() != "XXXXXX") {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.CheckPanelBindSN(scanSN, prodOrderId);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtSN").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }


                    var unitId = -1;

                    if (ajax.value != null) {
                        //获取扫描SN是否为离线条码，及相关的验证规则
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
                    else {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':获取拼板信息错误！', "messageRed");
                    }
                } else {
                    //如果扫描的是X板,unitID = -1
                    if (panelScanCount == 0) {
                        //获取拼板数量
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.GetPanelInfoByOrderId(prodOrderId);
                        if (ajax.error != null) {
                            updateCollectionList(scanSN, 'NG');
                            showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                            $("#txtSN").val("").focus();
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                            return false;
                        }
                        var panelRow = ajax.value.PanelRow;
                        var panelCol = ajax.value.PanelCol;

                        //加载拼版的行与列
                        loadingPanelTable(panelRow, panelCol);
                    }
                    scanPanelTable(-1, scanSN);
                }
                $("#txtSN").val("");
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
            if (unitId != -1) {
                if (panelScanUnitId.indexOf(unitId) >= 0) {
                    alert("该SN条码已扫描!");
                    return false;
                }
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
            $("#txtSN").focus();
        }

        /**
        *扫描完成保存拼版信息并过站
        **/
        function savePanel() {
            panelScanUnitId = panelScanUnitId.substring(0, panelScanUnitId.length - 1);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.CollectPanelBindSN(panelScanUnitId, stationId, resourceId);
            if (ajax.error != null) {
                //验证失败                
                showAreaMessge(ajax.error.Message, "messageRed");
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            if (panelScanCount > 1) {
                showAreaMessge(panelSN + ':拼板绑定成功！', "messageGreen");
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
    </script>
</asp:Content>
