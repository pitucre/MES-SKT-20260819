<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="SMTPackingCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.SMTPackingCollection" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle" ><%=Resources.lang.AC_OBA_ScanSN %></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox"></div>
                    </td>
                    <td align="right" style=" padding-right:20px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked/><%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" style="width:80%;" />
                        &nbsp;&nbsp;<input type="button"
                            id="btnConfirm" value=" 关闭包装箱 " onclick="ClosePack()" />&nbsp;&nbsp;
                            <input type="button"
                            id="Button1" value=" 打开包装箱 " onclick="OpenPack()" />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <table>
                            <tr>
                                <td>
                                   <span class="scan-center-title"><%=Resources.lang.LastStation %>：</span> 
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
                                   <span class="scan-center-title"><%=Resources.lang.NextStation %>：</span>
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
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %></div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 100px;">
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
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td style="width: 33%">
                                        </td>
                                        <td style="width: 33%; font-size: 12px !important;" align="center">
                                            包装明细表:
                                        </td>
                                        <td id="tdPackNo" align="left" style="width: 33%">
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="data-statistic-relinfo">
                                <div id="packingTree">
                                    <table width="100%" id="packingList" class="ListTable">
                                        <tr id="PackingDetailHeader" class="ListTableHeader">
                                            <th style="display: none">
                                                ContainerId
                                            </th>
                                            <th width="45%">
                                                包装箱号
                                            </th>
                                            <th width="55%">
                                                SN
                                            </th>
                                        </tr>
                                    </table>
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
        var resourceId = 0;
        var stationId = 0;
        var packSN = "";
        var scanType = 0; //0、包装箱 1、SN
        var ncCodeArr = [];
        $(document).ready(function () {            
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('SMTPackingCollection');
                },
                10
            );

            resourceId = $("#hdnCurrResourceId").val(); //资源Id
            stationId = $("#hdnCurrStationId").val(); //工位Id

            if (!stationId > 0) {
                alert("请先在操作菜单列表进行切换工位操作！");
                return;
            }
        });

        function afterScan() {
            if ($("#txtSN").val() != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
                //1.获取当前基本信息

                var scanSN = $.trim($("#txtSN").val()); //扫描Sn

                if (scanType == 0) {//如果扫描的为包装箱 带出包装箱信息
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetSMTPackInfo(scanSN);
                    if (ajax.error != null) {
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtSN").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    packSN = ajax.value[0];
                    var packStatusId = ajax.value[1];
                    var packQty = parseInt(ajax.value[2]);
                    var maxPackQty = parseInt(ajax.value[3]);

                    var msg = '';

                    if (packQty > 0) {
                        msg = "(" + packQty + "/" + maxPackQty + ")";
                    }
                    
                    if (packStatusId == "2") {
                        msg = '包装箱[' + packSN + ']'+msg+'已关闭！ ';
                        updateCollectionList(scanSN, 'NG');
                        showAreaMessge(msg, "messageRed");
                        scanType = 0;
                    }
                    else {
                        msg += '包装箱[' + packSN + ']'+msg+'已打开！ ';
                        updateCollectionList(scanSN, 'OK');
                        showAreaMessge(msg, "messageGreen");
                        scanType = 1;
                    }
                    getPackingPalletDetail(packSN, 1); //1为包装Level,2为栈板Level

                }
                else {
                    //检查当前扫码SN是否为不良代码
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
                        if ($.inArray(scanSN, ncCodeArr) == -1) {
                            ncCodeArr.push(scanSN);
                        }
                        updateCollectionList(scanSN, 'OK');
                        $("#txtSN").val("").focus();
                        return false;
                    }
                    //查看当前SN是否为拼板，并且拼板中已经有小板采集过不良信息。有的话则不再验证此SN（为了支持多个小板采集不良信息）
                    var isValidate = 1;
                    if (ncCodeArr.length > 0) {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetSMTPackPanelCollectNCCode(scanSN, stationId);
                        if (ajax.error != null) {
                            updateCollectionList(scanSN, 'NG');
                            showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                            $("#txtSN").val("").focus();
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                            return false;
                        }
                        isValidate = ajax.value;
                    }

                    if (isValidate == 1) {                       
                        //通用验证SN
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
                   
                    if (ncCodeArr.length > 0)//存在不良信息
                    {
                       var nccodeStr = ncCodeArr.join(",");
                       var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CollectSMTPackNCCode(scanSN, stationId, resourceId, nccodeStr, isValidate);
                       if (ajax.error != null) {
                           updateCollectionList(scanSN, 'NG');
                           showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                           $("#txtSN").val("").focus();
                           //写入日志
                           SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                           return false;
                       }
                       updateCollectionList(scanSN, 'NG');
                       showAreaMessge(scanSN + ':' + "采集不良成功！", "messageGreen");
                       ncCodeArr = [];
                       $("#txtSN").val("").focus();
                    }
                    else {
                        //扫描SN建立与包装箱的关系
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CollectSMTPackInfo(scanSN, packSN, stationId, resourceId);
                        if (ajax.error != null) {
                            updateCollectionList(scanSN, 'NG');
                            showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                            $("#txtSN").val("").focus();
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                            return false;
                        }
                        var packQty = parseInt(ajax.value[0]);
                        var maxPackQty = parseInt(ajax.value[1]);

                        refreshProInfoBySN(scanSN);
                        updateCollectionList(scanSN, 'OK');
                        getPackingPalletDetail(packSN, 1); //1为包装Level,2为栈板Level
                        showAreaMessge(scanSN + ':包装成功！包装箱[' + packSN + '](' + packQty + '/' + maxPackQty + ')', "messageGreen");
                        if (packQty == maxPackQty) {
                            showAreaMessge('自动关闭包装箱[' + packSN + ']！', "messageGreen");
                            packSN = "";
                            packQty = 0;
                            maxPackQty = 0;
                            scanType = 0;
                        }
                    }  
                }
                $("#txtSN").val("").focus();
            }
        }

        function OpenPack() {
            if (packSN == "") {
                alert("未找到包装箱信息！");
                $("#txtSN").val("").focus();
                return false;
            }
            if (confirm("是否确定打开包装箱[" + packSN + "]?")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.ChangeSMTPackStatus(packSN, 1, stationId, resourceId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, packSN, ajax.error.Message);
                    return false;
                }
                setMessageBox("打开包装箱[" + packSN + "]成功！", "messageGreen");
                showAreaMessge("打开包装箱[" + packSN + "]成功！", "messageGreen");
                packQty = 0;
                maxPackQty = 0;
                scanType = 1;
                $("#txtSN").val("").focus();
            }
        }

        function ClosePack() {
            if (packSN == "") {
                alert("未找到包装箱信息！");
                $("#txtSN").val("").focus();
                return false;
            }
            if (confirm("是否确定关闭包装箱[" + packSN + "]?")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.ChangeSMTPackStatus(packSN, 2, stationId, resourceId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, packSN, ajax.error.Message);
                    return false;
                }
                setMessageBox("关闭包装箱[" + packSN + "]成功！", "messageGreen"); 
                showAreaMessge("关闭包装箱[" + packSN + "]成功！", "messageGreen");               
                packQty = 0;
                maxPackQty = 0;
                scanType = 0;
                $("#txtSN").val("").focus();
            }
        }

        function UnBindPack() {
            if (packSN == "") {
                alert("未找到包装箱信息！");
                $("#txtSN").val("").focus();
                return false;
            }
            if (confirm("是否确定解绑包装箱[" + packSN + "]?")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.ChangeSMTPackStatus(packSN, 3, stationId, resourceId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, packSN, ajax.error.Message);
                    return false;
                }
                setMessageBox("解绑包装箱[" + packSN + "]成功！", "messageGreen");
                showAreaMessge("解绑包装箱[" + packSN + "]成功！", "messageGreen");
                getPackingPalletDetail(packSN, 1);
                packQty = 0;
                maxPackQty = 0;
                scanType = 0;
                $("#txtSN").val("").focus();
            }
        }
    </script>
</asp:Content>

