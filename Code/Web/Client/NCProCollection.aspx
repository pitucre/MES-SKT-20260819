<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="NCProCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.NCProCollection" %>

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

        .ListTable .TextBox {
            height: 22px;
            line-height: 22px;
        }
    </style>
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">
                            <%=Resources.lang.AC_OBA_ScanSN %></span> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <%-- < input type="checkbox" id="cbxInspectionSheet" value="yes" />
                        送检单&nbsp;--%>
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked />
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
                                                <th width="20%" style="text-align: center">不良代码
                                                </th>
                                                <th width="40%" style="text-align: center;">不良描述
                                                </th>
                                                <th width="30%" style="text-align: center;">不良位置
                                                </th>
                                                <th width="10%">操作
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
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        var panelSN = "";
        var isPanel = -1;
        var panelSNArr = [];
        var ncCodeArr = [];
        var scanType = 0; //scanType :0、默认 1、拼版条码 2、拼版子条吗
        var panelId = 0;
        var scanSN = "";
        var isSN = 0;

        $(document).ready(function () {
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('NC_ProCollectionUI');
                },
                10
            );

            //不良位置回车事件
            $(".nc-position").live("keypress", function (event) {
                if (event.keyCode == "13") {
                    collectionPosition($(this).get(0));
                    $(this).blur();
                }
            });
        });

        //不良代码位置
        function collectionPosition(object) {
            var obj = $(object);
            var ncCode = obj.attr("nc-code");//不良代码
            var ncPosition = $.trim(obj.val());//不良位置
            //添加不良位置
            if (panelSNArr != null && panelSNArr.length > 0) {
                //拼版
                var panelIdx = obj.attr("panel-idx");
                var sn = $("#panel" + panelIdx).attr("title");//SN 
                for (var i = 0; i < panelSNArr.length; i++) {
                    var ncObj = panelSNArr[i].NCObj;
                    if (panelSNArr[i].SN == sn && ncObj != null && ncObj.length > 0) {
                        //遍历SN对应的不良代码
                        for (var j = 0; j < ncObj.length; j++) {
                            if (ncObj[j].NCCode == ncCode) {
                                ncObj[j].NCPosition = ncPosition;
                                //obj.blur();
                                return;
                            }
                        }
                    }
                }
            } else {
                //非拼版
                for (var i = 0; i < ncCodeArr.length; i++) {
                    if (ncCodeArr[i].NCCode == ncCode) {
                        ncCodeArr[i].NCPosition = ncPosition;
                        //obj.blur();
                        return;
                    }
                }
            }
        }

        /**
        *扫描触发事件         
        情况1：单独SN过站
        a、扫描SN直接过站（不采集不良）
        b、扫描不良代码（可多次扫描以，隔开），再扫描SN过站（采集不良）

        情况2：拼版过站
        a、扫描拼版直接过站（不采集不良）
        b、先扫描不良，告知系统需要采集不良。
        再扫描拼版条码带出所有的子板条码信息。
        扫描子板条码。
        扫描不良代码
        点击确定按钮拼版过站
        */
        function afterScan() {
            if ($.trim($("#txtSN").val()) != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }

                //1.查看是否有RouteId及工单Id
                routeId = $("#hdnCurrRouteId").val();
                proOrderId = $("#hdnCurrProOrderId").val();
                resourceId = $("#hdnCurrResourceId").val();
                stationId = $("#hdnCurrStationId").val();
                scanSN = $.trim($("#txtSN").val()); //扫描Sn
                var panelSNObj;

                if (isPanel = -1 && scanType == 0) {//首次扫描

                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.GetNCCodeInfo(scanSN, stationId);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtSN").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    //查询当前扫描的SN是否为不良代码，为不良代码则加入数组
                    if (ajax.value[0] != "") { //当前扫码的SN为不良代码

                        //判断当前不良是否已经扫描
                        for (var j = 0; j < ncCodeArr.length; j++) {
                            if (ncCodeArr[j].NCCode == scanSN) {
                                alert("不良[" + scanSN + "]已扫描！");
                                $("#txtSN").val("").focus();
                                return false;
                            }
                        }
                        var nccodeObj = {};
                        nccodeObj.NCCode = scanSN;
                        nccodeObj.NCDesc = ajax.value[1];
                        nccodeObj.NCPosition = "";
                        //验证不良代码是否重复扫描
                        ncCodeArr.push(nccodeObj);
                        loadingNCTable(ncCodeArr, -1);
                        $("#txtSN").val("").focus();
                        return false;

                    }
                }
              
                if (scanType == 0) { //当扫描的SN模式为拼版时 不再进行拼版查询
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.GetPanelInfoBySN(scanSN);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtSN").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }

                    panelId = ajax.value[0];
                    panelSN = ajax.value[1];
                    panelRow = ajax.value[2];
                    panelCol = ajax.value[3];
                    if (panelId > 0) {
                        isPanel = 1;
                    }
                    else {
                        isPanel = 0;
                    }
                }

                if (isPanel == 0 && scanType == 0) {//如果当前SN不是拼板条码 
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

                    panelSNObj = {};
                    panelSNObj.SN = scanSN;
                    panelSNObj.NCObj = ncCodeArr;
                    panelSNArr.push(panelSNObj);

                    collectionPass();
                }
                else { //如果当前SN是拼板条码

                    if (scanType == 0) {
                        //直接扫描拼版进行过站操作
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId, false);
                        if (ajax.error != null) {
                            updateCollectionList(scanSN, 'NG');
                            showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                            $("#txtSN").val("").focus();
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                            return false;
                        }
                    }
                    //验证当前的扫描模式
                    if (scanType == 0 && ncCodeArr.length > 0) {//当前没有扫描过拼版扫描且有扫描不良代码

                        loadingNCTable(ncCodeArr, -1);

                        var panelSNList = [];
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.GetPanelListInfoById(panelId);
                        if (ajax.error != null) {
                            updateCollectionList(scanSN, 'NG');
                            showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                            $("#txtSN").val("").focus();
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                            return false;
                        }
                        panelSNList = ajax.value;

                        for (var i = 0; i < panelSNList.length; i++) {
                            panelSNObj = {};
                            panelSNObj.SN = panelSNList[i];
                            panelSNObj.NCObj = [];

                            panelSNArr.push(panelSNObj);
                        }

                        //使用拼板扫描模式
                        $("#divNCCode").hide();
                        $("#condivPanel").show();
                        loadingPanelTable(panelRow, panelCol);
                        scanType = 1; //当前扫描模式为拼版条码
                        for (var i = 0; i < panelSNArr.length; i++) {//打不良
                            if (panelSNArr[i].SN == scanSN) {
                                $.merge(panelSNArr[i].NCObj, ncCodeArr);
                                $("#divPanel ul li ").eq(i).click();
                                ncCodeArr = [];
                                break;
                            }
                        }
                        $("#txtSN").css("width", "90%");
                        $("#btnConfirm").show();

                    }
                    else if (scanType == 0 && ncCodeArr.length == 0) { //当前没有扫描过拼版扫描且有扫描不良代码    
                        collectionPass();
                    }
                    else if (scanType == 1) {//已经扫描过不良、拼版条码
                        //验证当前扫描SN是否为不良代码，为不良代码则将其增加到拼版数组内
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.GetNCCodeInfo(scanSN, stationId);
                        if (ajax.error != null) {
                            showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                            $("#txtSN").val("").focus();
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                            return false;
                        }
                        if (ajax.value[0] != "") { //当前扫码的SN为不良代码
                            /*  $("#divPanel ul li").each(
                                  function (i) {
                                      if ($("#panelSN" + (i + 1)).text() != "") {
                                          if ($(this).css("background-color") != "rgb(253, 52, 32)") {
                                              $(this).css("border", "").css({ "background-color": "#FFF5BB", "color": "#000" });
                                          }
                                      }
                                  }
                                  );*/
                            //判断当前不良是否已经扫描
                            for (var j = 0; j < ncCodeArr.length; j++) {
                                if (ncCodeArr[j].NCCode == scanSN) {
                                    alert("不良[" + scanSN + "]已扫描！");
                                    $("#txtSN").val("").focus();
                                    return false;
                                }
                            }
                            var nccodeObj = {};
                            nccodeObj.NCCode = scanSN;
                            nccodeObj.NCDesc = ajax.value[1];
                            nccodeObj.NCPosition = "";
                            ncCodeArr.push(nccodeObj);
                            loadingNCTable(ncCodeArr, -1);
                        }
                        else {

                            //不为不良代码则检查扫描条码是否存在拼版列表中，不存在则报错，存在则选中子板条码
                            $("#divPanel ul li").each(
                                    function (i) {
                                        if ($("#panelSN" + (i + 1)).text().toUpperCase() == (scanSN.toUpperCase())) {
                                            $(this).click();
                                            isSN = 1;
                                            return;
                                        }
                                    }
                                );

                            if (isSN == 0) {
                                alert("未在拼版列表中找到当前子板条码！");

                                $("#txtSN").val("").focus();
                                return false;
                            }
                            isSN = 0;
                            for (var i = 0; i < panelSNArr.length; i++) {
                                if (panelSNArr[i].SN == scanSN) {
                                    $.merge(panelSNArr[i].NCObj, ncCodeArr);
                                    $("#divPanel ul li ").eq(i).click();
                                    ncCodeArr = [];
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            $("#txtSN").val("");
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
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.CheckPassCountStation(scanSN, stationId);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }
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
            refreshProInfoBySN(scanSN);
        }

        /*
        *拼接不良信为XML字符串
        */
        function resultToXml() {
            var xml = "<PanelSN>";
            for (var i = 0; i < panelSNArr.length; i++) {
                ncCodeArr = panelSNArr[i].NCObj;
                for (var j = 0; j < ncCodeArr.length; j++) {
                    xml += "<NCCode SN=\"" + panelSNArr[i].SN + "\" CODE=\"" + ncCodeArr[j].NCCode + "\" Position=\"" + ncCodeArr[j].NCPosition + "\"></NCCode>";
                }
            }
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
                cell.innerHTML = "<input type=\"text\" class=\"nc-position TextBox\" panel-idx=\"" + index + "\" nc-code=\"" + list[i].NCCode + "\" value=\"" + list[i].NCPosition + "\" onblur=\"collectionPosition(this)\"></input>";

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = "<img src='../Content/images/icon/close.gif' onclick=cancelNCCode(" + i + "," + index + ") style='cursor:pointer;' title='点击将会删除采集的不良' alt='X' />";
            }
        }


        /**
        *取消不良信息
        **/
        function cancelNCCode(i, index) {
            if (panelSNArr.length > 0) {//有拼版的情况删除不良
                panelSNArr[index].NCObj.splice(i, 1);
                //重新加载不良信息
                if (panelSNArr[index] != null && panelSNArr[index] != undefined) {
                    loadingNCTable(panelSNArr[index].NCObj, index);
                }
            }
            else {
                ncCodeArr.splice(i, 1);
                loadingNCTable(ncCodeArr, index);
            }
            $("#txtSN").val("").focus();
        }
    </script>
</asp:Content>
