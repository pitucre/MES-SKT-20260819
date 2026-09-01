<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="OffLineBarCodeCollectionBatch.aspx.cs" Inherits="SKT.LeanMES.Web.Client.OffLineBarCodeCollection" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        #divPanel {
            width: 100%;
            height: 280px;
            background-color: White;
        }

            #divPanel ul li {
                width: 100%;
                float: left;
                border: 1px solid #ccc;
                margin: 2px 1px 2px 1px;
                text-align: center;
                white-space: nowrap;
                text-overflow: ellipsis;
                -o-text-overflow: ellipsis;
                overflow: hidden;
                list-style-type: none;
            }

                #divPanel ul li:hover {
                    width: 100%;
                    float: left;
                    border: 1px solid green;
                    margin: 2px 1px 2px 1px;
                }
    </style>
    <table id="tabTmplContent" class="EditeContentTable" style="width: 99%; margin: 0 auto; margin-top: 5px; margin-bottom: 5px;">
        <tr>
            <td align="left">
                <span class="scan-center-title" id="labqty">
                    <span id="lblQty">输入条码数量</span> <span id="lblQty" style="color: Green;"></span></span>
            </td>
            <tr>
                <td align="left">
                    <input type="text" id="txtSNQty" class="scan-center-sn" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                     onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                </td>
            </tr>

        </tr>
        <tr>
            <td align="left">
                <span class="scan-center-title" id="labscancentertitle">
                    <span id="lblScanType">扫描离线条码</span> <span id="lblGrnQty" style="color: Green;"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                    </div>
            </td>
            <td align="right" style="padding-right: 20px;">
                <input type="checkbox" id="cbxforceuppercase" value="yes" checked />
                <%=Resources.lang.ForcingUpperCase %>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <input type="text" id="txtSN" class="scan-center-sn" />
            </td>
        </tr>

    </table>
    <div class="client-center">
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic" style="display: block;">
            <table cellpadding="0" cellspacing="0" border="0" width="99%">

               <%-- <tr>
                    <td class="leftmenu-new-header">选择打X板,点击锁定X板位置;
                        <span id="showXLocation"></span>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <input type="button" value="锁定X板位置" onclick="SaveXLocation()" />&nbsp;&nbsp;
                        <input type="button" value="批量取消X板" onclick="CancelX()" />&nbsp;&nbsp;
                        <input type="button" value="强制注册" onclick="SavePass()" style="display: none;" />
                    </td>
                </tr>--%>
                <tr>
                    <td valign="top" style="width: 100%;">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                离线条码注册：
                            </div>
                            <div>
                                <div id="divPanel" style="min-height: 300px; overflow: auto;">
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
        var prodOrderId = -1;
        var scanSN = "";
        var panelScanCount = 0;
        var LocationXStr = ""; //X板位置




        $(document).ready(function () {
            $("#txtSN").attr("disabled", "disabled");
            SelectProOrder();
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('OffLineBarCodeCollectionBatch');
                },
                10
            );

        });


        /**
        *选择工单
        */
        function SelectProOrder() {
            chooseFlag = 1;
            // var searchCondition = "1=1"; // "Status=1"; 
            var searchCondition = "AcquisitionMode = 2";

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&CallBackFunc=getProOrderValue&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /**
      *返回值
      */
        function getProOrderValue(list) {

            if (chooseFlag == 1) {
                //---选择工单后动作：1、路由获取；2、相关动态信息获取；3、根据当前工序及路由获取前后工序信息并回显
                $("#hdnCurrProOrderId").val(list[0][0]);
                prodOrderId = list[0][0];
                //1、获取路由
                var routeId = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetRouteIdByProOrderId(list[0][0]);
                if (routeId.error != null) {
                    alert(routeId.error.Message);
                    SaveUserUILog("一般", stationId, resourceId, "", routeId.error.Message);
                    return false;
                }
                var routeId = routeId.value;

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
                GetExpression();

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
                    $("#txtSNQty").focus();
                },
                10
            );
        }
        //选择工单后，验证工单信息
        var ItemType = -1;//-1:子板
        var panelRow = 1;
        var panelCol = 1;
        var IsPanelPrint = 0;//是否拼板打印
        function checkProdOrderId() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOffLineBarCode.CheckProdOrderIdAndGetInfo(prodOrderId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //ItemType = ajax.value.PanelType;
            //IsPanelPrint = ajax.value.IsPrintPanel;
            //if (ItemType != -1) {
            //    $("#datastatistic").show();
            //    panelRow = ajax.value.PanelRow;
            //    panelCol = ajax.value.PanelCol;
            //    //加载拼版的行与列

            //    loadingPanelTable(panelRow, panelCol);
            //}
            //else {
            //    $("#datastatistic").hide();
            //}

            $("#datastatistic").hide();
        }

        //根据工单，工序获取设定的掩码规则
        var expession = "";
        function GetExpression() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOffLineBarCode.CheckOffLineBarCode(stationId, prodOrderId);
            if (ajax.error != null) {
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                alert(ajax.error.Message);
                return false;
            }
            else {
                expession = ajax.value;
                checkProdOrderId();
            }
        }

        /**
       *扫描触发事件
       */
        function afterScan() {
            scanSN = $.trim($("#txtSN").val());
            if (scanSN != "") {
                scanSN = ($.trim($("#txtSN").val()).toUpperCase());
            }
            //扫描的离线条码验证掩码规则
            if (expession == "") {
                showAreaMessge("该产品,工序还没设置掩码规则,请先设置掩码规则!", "messageRed");
                $("#txtSN").val("").focus();
            }
            else {
                //验证掩码规则
                var regularArr = expession.split(';');
                var reg;
                if (regularArr != undefined && regularArr.length > 0 && scanSN != "") {
                    for (var i = 0; i < regularArr.length; i++) {
                        reg = new RegExp(regularArr[i]);
                        if (!reg.test(scanSN)) {
                            updateCollectionList(scanSN, 'NG');
                            showAreaMessge(scanSN + "不符合掩码规则", "messageRed");
                            $("#txtSN").val("");
                            $("#txtSN").focus();
                            return false;
                        }
                    }
                }
                //扫描的SN信息checkOffLineSN(int stationId, int prodOrderId,string SN)
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOffLineBarCode.checkOffLineSN(stationId, prodOrderId, scanSN);
                if (ajax.error != null) {
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    updateCollectionList(scanSN, 'NG');
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    return false;
                } else if (ajax.json == undefined) {

                    showAreaMessge(scanSN + ':' + "扫描出错。原因可能有 1:数据异常 2：网络异常", "messageRed");
                    $("#txtSN").val("").focus();
                    return false;
                }
                //显示在拼板中：
                //if (ItemType == -1) {
                //    savePanel();
                //} else {
                //    if (IsPanelPrint) {
                //        PassSaveOffLine();
                //    }
                //    else {
                //        scanPanelTable(scanSN);
                //    }
                //}
                savePanel();
            }
        }

        function PassSaveOffLine() {
            //SavePassByOffLineSN
            $("#divPanel ul li").each(
                function (index) {
                    if ($("#" + (index + 1) + "").attr("title") == "XXXXXX") {
                        allScanStr += (index + 1) + ",";
                    }
                });
            allScanStr = allScanStr.substring(0, allScanStr.length - 1);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOffLineBarCode.SavePassByOffLineSN(allScanStr, scanSN, prodOrderId, stationId, resourceId, userId);
            if (ajax.error != null) {
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                return false;
            } else if (ajax.json == undefined) {
                //updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':' + "扫描出错。原因可能有 1:数据异常 2：网络异常", "messageRed");
                $("#txtSN").val("").focus();
                return false;
            }
            showAreaMessge(scanSN + ':离线条码注册成功！', "messageGreen");
            //根据SN刷新侧边栏动态信息
            refreshProInfoBySN(scanSN);
            refreshProInfoByProOrderId(prodOrderId);
            panelScanCount = 0;
            scanStr = "";
            scanSN = "";
            allScanStr = "";
            loadingPanelTable(panelRow, panelCol);
            $("#txtSN").val("").focus();
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
                    panelHtml += "<li id='panel" + current + "' style='text-align:center; list-style-type:none;min-height:70px;min-width:70px;'>";
                    panelHtml += ("<div   style='position:relative;top:5px;right:2px;float:left;line-height:3px;' ><div style=' width:16px; height:16px; background-color:#fff; border: 1px solid #B6AF89; border-radius:8px;'><span id=\'nccode" + current + "\' style='color:#000;height:16px; line-height:16px; display:block; text-align:center'>" + (current + 1) + "</span></div></div>");
                    panelHtml += "<input type='checkbox' value ='" + (current + 1) + "'  onclick='CheckSNX(this," + (current + 1) + ")' id='checkBox" + (current) + "' /><span id=" + (current + 1) + "></span>";
                    //panelHtml += ("序号" + (current + 1));
                    panelHtml += "</li>";
                    current++;
                }
                panelHtml += "</ul>";

            }
            current = 0;
            $("#divPanel").html(panelHtml);
            $("#divPanel ul").width(($("#divPanel").width()));
            //通过选择的位置
            OnLoadXLocation();

            var height = ($("#divPanel").height() - (panelRow * 6)) / panelRow;
            var width = ($("#divPanel ul").width() - (panelCol * 4)) / panelCol;
            $("#divPanel ul li").width(width).height(height).css("line-height", height + "px");
        }

        function OnLoadXLocation() {
            if (LocationXStr != "") {
                $("#divPanel ul li").each(function (index) {
                    var strs = new Array(); //定义一数组 
                    strs = LocationXStr.split(","); //字符分割 
                    for (i = 0; i < strs.length; i++) {
                        if ((index + 1) == strs[i]) {
                            $("#" + (index + 1) + "").html("<img src='../Content/images/icon/close.gif' onclick=delPanel(this,'XXXXXX'," + (index + 1) + ") style='cursor:pointer; position:relative;top:2px;right:2px;float:right;' title='点击将会清除序号' alt='X' />" + "XXXXXX").attr("title", "XXXXXX");
                            $("#panel" + (index) + "").css("background-color", "#8B8989");
                            panelScanCount++;
                        }
                    }
                });
            }
        }

        //下拉框选中事件
        function CheckSNX(obj, currentId) {
            //判断checkBox是否被选中
            if (obj.checked) {
                $("#" + (currentId) + "").html("<img src='../Content/images/icon/close.gif' onclick=delPanel(this,'XXXXXX'," + (currentId) + ") style='cursor:pointer; position:relative;top:2px;right:2px;float:right;' title='点击将会清除序号' alt='X' />" + "XXXXXX").attr("title", "XXXXXX");
                // $(this).css("background-color", "#FFF5BB");
                $("#panel" + (currentId - 1) + "").css("background-color", "#8B8989");
                panelScanCount++;
                var totalPanel = $("#divPanel ul li").length;
                if (panelScanCount == totalPanel) {
                    //拼版扫描完毕，过站
                    savePanel();
                }
            }
            else {
                $("#" + currentId + "").html("");
                $("#panel" + (currentId - 1) + "").css("background-color", "#fff");
                $("#" + (currentId) + "").attr("title", "");
                panelScanCount--;
            }
        }

        var scanStr = "";
        function scanPanelTable(scanSN) {
            if (scanSN != "") {
                if (scanStr.indexOf(scanSN) >= 0) {
                    alert("该SN条码已扫描!");
                    $("#txtSN").val("").focus();
                    return false;
                }
            }
            scanStr += scanSN + ",";
            $("#divPanel ul li").each(
                function (index) {
                    if ($("#" + (index + 1) + "").html() == "") {
                        $("#" + (index + 1) + "").html("<img src='../Content/images/icon/close.gif' onclick=delPanel(this,'" + scanSN + "'," + (index + 1) + ") style='cursor:pointer; position:relative;top:2px;right:2px;float:right;' title='点击将会清除序号' alt='X' />" + scanSN).attr("title", scanSN);
                        $("#checkBox" + (index) + "").hide();
                        $(this).css("background-color", "#FFF5BB");
                        panelScanCount++;
                        return false;
                    }
                }
            );

            $("#txtSN").val("");
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
        function delPanel(obj, scanSn, index) {
            if (scanSn == "XXXXXX") {
                $("#checkBox" + (index - 1) + "").attr("checked", false);
                $("#" + (index) + "").attr("title", "");
            } else {
                $("#checkBox" + (index - 1) + "").show();
            }
            $("#" + index + "").html("");
            $("#panel" + (index - 1) + "").css("background-color", "#fff").attr("title", "");
            scanStr = scanStr.replace(scanSn + ",", "");
            panelScanCount--;
            $("#txtSN").val("").focus();
        }

        //保存拼板/子板保存信息
        /**
       *扫描完成保存拼版信息并过站
       **/
        var allScanStr = "";
        function savePanel() {
            allScanStr = "";
            if (ItemType != -1) {
                $("#divPanel ul li").each(
                    function (index) {
                        if ($("#" + (index + 1) + "").attr("title") != undefined && $("#" + (index + 1) + "").attr("title") != "") {
                            allScanStr = allScanStr + $("#" + (index + 1) + "").attr("title") + ",";
                        }
                    });
            }
            else {
                allScanStr = scanSN + ",";
            }
            allScanStr = allScanStr.substring(0, allScanStr.length - 1);
            if (allScanStr == "") {
                showAreaMessge('请先扫描离线条码！', "messageRed");
                return false;
            }
            var SnQty = $.trim($("#txtSNQty").val());

            if (!/^[0-9]*[1-9][0-9]*$/.test(SnQty)) {
                alert('请输入正确的条码数量!')
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOffLineBarCode.SaveOffLineBarCodBatch(allScanStr, SnQty, prodOrderId, stationId, resourceId, userId);
            if (ajax.error != null) {
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                //验证失败                
                showAreaMessge(ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                return false;
            } else if (ajax.json == undefined) {
                //updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':' + "扫描出错。原因可能有 1:数据异常 2：网络异常", "messageRed");
                $("#txtSN").val("").focus();
                return false;
            }
            showAreaMessge(scanSN + ':离线条码注册成功！', "messageGreen");
            //根据SN刷新侧边栏动态信息
            refreshProInfoBySN(scanSN);
            panelScanCount = 0;
            scanStr = "";
            loadingPanelTable(panelRow, panelCol);
            scanSN = "";
            $("#txtSN").val("").focus();
        }

        //取消全部的打X板
        function CancelX() {
            $("#divPanel ul li").each(
                function (index) {
                    if ($("#" + (index + 1) + "").attr("title") == "XXXXXX") {
                        $("#" + (index + 1) + "").html("");
                        $("#" + (index + 1) + "").attr("title", "");
                        $("#checkBox" + index + "").attr("checked", false);
                        $("#panel" + index + "").css("background-color", "#fff");
                        panelScanCount--;
                    }
                });
        }

        //强制注册
        function SavePass() {
            savePanel();
        }

        //锁定X板位置
        function SaveXLocation() {
            LocationXStr = "";
            $("#divPanel ul li").each(
                function (index) {
                    if ($("#" + (index + 1) + "").attr("title") == "XXXXXX") {
                        LocationXStr += (index + 1) + ",";
                    }
                });
            //显示当前X板位置：
            $("#showXLocation").html("当前打X板位置为" + LocationXStr + "");
        }
    </script>
</asp:Content>

