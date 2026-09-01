<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="FinishedGoodsInput.aspx.cs" Inherits="SKT.LeanMES.Web.Client.FinishedGoodsInput" %>

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
                            <span id="lblScanType">请扫描产品条码</span> <span id="lblGrnQty" style="color: Green;"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
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
                    <td valign="top" style="width: 100%">
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
    <script language="javascript" type="text/javascript">
        var dipSN = "";
        var cusSN1 = "";
        var cusSN2 = "";

        $(document).ready(function () {
            //投入过站必须选择工单后才可以进行扫描动作
            $("#txtSN").attr("disabled", "disabled");
            SelectProOrder();
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('FinishedGoodsInput');
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
            var searchCondition = ""; 
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

            if (scanSN != "") {
                if ($("#cbxforceuppercase").prop("checked")) {
                    scanSN = ($.trim($("#txtSN").val()).toUpperCase());
                }
                //1.查看是否有RouteId及工单Id
                var routeId = $("#hdnCurrRouteId").val();
                var prodOrderId = $("#hdnCurrProOrderId").val();
                var resourceId = $("#hdnCurrResourceId").val();
                var stationId = $("#hdnCurrStationId").val();

                if (routeId === "-1") {
                    alert("Error:" + "<%=Resources.Messages.CreateSN_Router_Invalid %>");
                    $("#txtSN").val("");
                    $("#txtSN").focus();
                    return false;
                }

                if (prodOrderId === "-1") {
                    alert("Error:" + "<%=Resources.Messages.OrderEmptyWei %>");
                    SelectProOrder();
                    return false;
                }

                if (!stationId > 0) {
                    alert("请先在操作菜单列表进行切换工位操作！");
                    return;
                }

                var ajaxAnew = SKT.LeanMES.Web.AjaxServices.AjaxInput.CheckSNAnew(scanSN, prodOrderId, 3, stationId, resourceId);
                if (ajaxAnew.error != null) {
                    updateCollectionList(scanSN, 'NG');
                    showAreaMessge(scanSN + ':' + ajaxAnew.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajaxAnew.error.Message);
                    return false;
                }
                var value = ajaxAnew.value;
                if (value == "1") {
                    updateCollectionList(scanSN, 'OK');
                    showAreaMessge("[产品条码：" + scanSN + "] 整机投入成功！", "messageGreen");
                    dipSN = "";
                    cusSN1 = "";
                    cusSN2 = "";
                    $("#labscancentertitle").html("请扫描产品条码");
                    $("#txtSN").val("").focus();
                    return false;
                }
                var ajax;
                if (dipSN == "") {//验证DIP条码-- 1、验证升级工单逻辑  
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.CheckFinishedGoodsInput(scanSN, prodOrderId, 1, stationId, resourceId);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtSN").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    dipSN = scanSN;
                    updateCollectionList(scanSN, 'OK');
                    showAreaMessge(scanSN + ':' + "产品条码扫描成功，请扫描SN条码", "messageGreen");
                    $("#labscancentertitle").html("请扫描SN条码");

                }
                else if (cusSN1 == "") {//验证SN(客户条码1)2、验证SN（客户条码1）
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.CheckFinishedGoodsInput(scanSN, prodOrderId, 2, stationId, resourceId);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtSN").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    cusSN1 = scanSN;
                    updateCollectionList(scanSN, 'OK');
                    showAreaMessge(scanSN + ':' + "SN条码扫描成功，请扫描MAC条码", "messageGreen");
                    $("#labscancentertitle").html("请扫描MAC条码");

                }
                else if (cusSN2 == "") {//验证MACSN（客户条码2）3、验证Mac(客户条码2)
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.CheckFinishedGoodsInput(scanSN, prodOrderId, 3, stationId, resourceId);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtSN").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    cusSN2 = scanSN;
                    showAreaMessge(scanSN + ':' + "MAC条码扫描成功，开始整机投入！", "messageGreen");

                    //三个条码都已经验证完成，进行过站操作
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInput.FinishedGoodsInput(dipSN, prodOrderId, cusSN1, cusSN2, stationId, resourceId);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtSN").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    else if (ajax.json == undefined) {
                        showAreaMessge(scanSN + '：' + "未接收到系统返回信息，请检查是否登录已超时或网络中断！", "messageRed");
                        $("#txtSN").val("");
                        $("#txtSN").focus();
                        return false;
                    }
                    updateCollectionList(scanSN, 'OK');
                    showAreaMessge("[产品条码：" + dipSN + ",SN条码：" + cusSN1 + ",MAC条码：" + cusSN2 + "] 整机投入成功！", "messageGreen");
                    dipSN = "";
                    cusSN1 = "";
                    cusSN2 = "";
                    $("#labscancentertitle").html("请扫描产品条码");
                }


            }

            $("#txtSN").val("");
        }


    </script>
</asp:Content>
