<%@ Page Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
     AutoEventWireup="true" CodeBehind="PackingProCollectionBatchList.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PackingProCollectionBatchList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        input[type='button'].ButtonBox1 {
            border: solid 1px #aaaaaa;
            border-left-width: 0;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 11px;
            color: #000000;
            height: 22px;
            line-height: 22px;
            width: 60px;
            background: #f7f7f7;
            vertical-align: middle;
            text-align: center;
            padding: 0px 4px 3px 4px;
            margin-left: -40px;
        }

            input[type='button'].ButtonBox1:hover {
                border: solid 1px #aaaaaa;
                border-left-width: 0;
                font-family: Verdana, 微软雅黑,黑体, 宋体;
                font-size: 11px;
                height: 22px;
                line-height: 22px;
                width: 60px;
                color: #000000;
                background: #d3d3d3;
                vertical-align: middle;
                text-align: center;
                padding: 0px 4px 3px 4px;
                margin-left: -40px;
                cursor: pointer;
                border-top-left-radius: 0;
                border-top-right-radius: 4px;
                border-bottom-right-radius: 4px;
                border-bottom-left-radius: 0;
            }
            input[type="checkbox"] {
                width:15px;
                height:15px;
            }
    </style>
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">

                <tr>
                    <td align="left">                         
                             <span class="scan-center-title" id="labscancentertitle" style="float:left;">
                            <%=Resources.lang.AC_OBA_ScanSN %></span><div id="divCurrentWeight" style="padding: 18px 0px 0px; font-size: 14px; margin-left: 40px; float:left;display:none;">当前重量：<span id="lblCurrentWeight" style="font-weight: bold;">0</span> 称重状态：<span id="lblCurrentState" style="font-weight: bold;"></span></div> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right"> 
                        <div style="float:right;">
                            <%--<input type="checkbox" id="cbxCheckSeq" />&nbsp;&nbsp;启用顺序检查&nbsp;--%>
                         <input type="checkbox" id="cbxSetBox" />&nbsp;启用自定义箱号&nbsp;&nbsp; 
                       工单号：<input type="text" id="txtProdOrder" readonly="readonly" class="ui-textbox" /><input class="ButtonBox" id="btnCustomerOrder" type="button" style="height:27px;" onclick="openChoosePage(44)"
                           value="..." title="选择工单" disabled="disabled" /><input id="hdnProdOrderId" type="hidden" value="-1" />
                            &nbsp;第
                            <select id="sltBoxSeq"  style="height: 24px; font-size: 12px;" disabled="disabled">
                                <option value="">--请选择--</option>
                            </select>箱
                        </div>
                        <div>
                            <input type="checkbox" id="chkRePrint" title="如果您的包装标签需要重打，点击选择此复选框" value="0" />
                            重印&nbsp;&nbsp;
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked />
                            <%=Resources.lang.ForcingUpperCase %>
                        </div>
                    </td>
                </tr>
                <tr style="display:none">
                    <td align="left" colspan="2">
                        <input  type="text" id="txtSN" class="scan-center-sn" />
                    </td>
                </tr>
                <tr>
                     <td align="left">  
                        <span class="scan-center-title" id="labscancentertitle2">
                            批量扫描：
                        </span>
                     </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <textarea rows="10" type="text" id="txtSN1" class="scan-center-sn" style="height: 80px;"></textarea>
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
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %>
                            </div>
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
                                        <td style="width: 33%"></td>
                                        <td style="width: 33%; font-size: 12px !important;" align="center">包装明细表:
                                        </td>
                                        <td id="tdPackNo" align="left" style="width: 33%"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="data-statistic-relinfo">
                                <div id="packingTree">
                                    <table width="100%" id="packingList" class="ListTable" style="overflow: scroll;">
                                        <tr id="PackingDetailHeader" class="ListTableHeader">
                                            <th style="display: none">ContainerId
                                            </th>
                                            <th width="45%">包装箱号
                                            </th>
                                            <th width="55%">SN
                                            </th>
                                        </tr>
                                        <tr id="PackingDetailHeaderBox" class="ListTableHeader" style="display: none;">
                                            <th style="display: none">ContainerId
                                            </th>
                                            <th width="30%">包装箱号
                                            </th>
                                            <th width="30%">中箱号
                                            </th>
                                            <th width="40%">SN
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
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>
    <input type="hidden" id="hidIsScaning" value="0" />
    <input type="hidden" id="hidScanOrderId" value="0" />
    <input type="hidden" id="hidSNCode" value="0" />
    <%--   <script src="../Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>--%>
    <script src="../Content/js/skt.client.print.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.ElectronicEquipment.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script language="javascript" type="text/javascript">
        var scanSN = "";
        var packSN = "";
        var boxSN = "";
        var packType = "";
        var packQty = 0;
        var maxPackQty = 0;
        var resourceId = 0;
        var stationId = 0;
        var portName = "";//串口名称
        var boundRate = "";//波特率  
        var itemMinWeight = 0;
        var itemMaxWeight = 0;
        var itemUnit = "";
        var containerMinWeight = 0;
        var containerMaxWeight = 0;
        var containerUnit = "";
        var Isflag = 0;// 1指卡通称重标志
        var boxFlag = 1 // 是否需要包装中箱标识 0、不需要 1、需要
        var isScanOffline = 0;
        var lastScanSN = "";//上一个扫描的SN信息
        var isCheckSeq = 0; //是否启用顺序包装
        var isWeight = true;
        var resultWeigh = 0;

        $(document).ready(function () {
            //初始化称重插件
            initElectronic();

            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('Packing_ProCollectionUI');
                },
                10
            );

            $("#cbxSetBox").click(function () {
                if (this.checked) {
                    $("#btnCustomerOrder,#sltBoxSeq").removeAttr("disabled");                                   
                }
                else {
                    $("#txtProdOrder").val("");
                    $("#sltBoxSeq").html("<option value=''>--请选择--</option>");
                    $("#btnCustomerOrder,#sltBoxSeq").attr("disabled", "disabled");
                }
            });

            lableType = -4; //包装打印
            lableSequence = 3//序号       

            $("#txtSN1").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {

                    if ($("#txtSN1").val() != "") {
                   
                        if ($("#cbxforceuppercase").prop("checked")) {
                            $("#txtSN1").val($.trim($("#txtSN1").val()).toUpperCase());
                        }

					    //afterSubmit() 
                        //根据SN刷新侧边栏动态信息
                        //refreshProInfoBySN(scanSN1);
                        var scanSN1 = $.trim($("#txtSN1").val()); //扫描Sn
                        var ResID = $("#hdnCurrResourceId").val();
                        var OpeID = $("#hdnCurrStationId").val();
                  
                        //exec
                        var entity0 = {};
                        entity0.Barcode = scanSN1;
                        entity0.UserID = userId;
                        entity0.OpeID = OpeID;
                        entity0.ResID = ResID;
                        entity0.ErrorMsg = "";
                    
                        var ajax0 = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetBoxNumberBySNList", JSON.stringify(entity0));
                    
                        if (ajax0.error != null) {
                            updateCollectionList(scanSN1, 'NG');
                            showAreaMessge(scanSN1 + ':' + ajax0.error.Message, "messageRed");
                            $("#txtSN1").val("").focus();
                            return false;
                        }
                     
                        var param1 = ajax0.value[0];
                        updateCollectionList(scanSN1, 'OK');
             	        showAreaMessge($("#txtSN1").val() +"："+ param1, "messageGreen");
            	        setMessageBox($("#txtSN1").val() +"："+ param1, 'messageGreen');
            	        
            	        var arrs = scanSN1.split(',');
            	        var arrp = param1.split(';');
            	        if (param1.split(';')[0] == "1") {
            	            
            	            refreshProInfoBySN(arrs[arrs.length - 1]);
            	            checkPackPrint(arrp[1]);
            	            getPackingPalletDetailNew(arrp[1], 1);
            	            showAreaMessge('自动关闭包装箱[' + arrp[1] + ']！', "messageGreen");

            	            var nextSeq = $("#sltBoxSeq option:selected").next().val();
            	            if (nextSeq != "") {
            	                $("#sltBoxSeq option:selected").remove();
            	                $("#sltBoxSeq").val(nextSeq);
            	            }

            	            //根据SN刷新侧边栏动态信息
            	            refreshProInfoBySN(scanSN);
            	            packSN = "";
            	            lastScanSN = "";
            	            packQty = 0;
            	            maxPackQty = 0;
            	        } else {
            	            refreshProInfoBySN(arrs[arrs.length - 1]);
            	            getPackingPalletDetailNew(arrp[1], 1);
            	        }
            	        $("#txtSN1").val("")
                        afterClean();

                    } else {
                        $("#txtSN1").focus();
                        $("#txtSN1").val("");
                    }
                }
                if (curKey == 46) {
                    $("#txtSN1").val("");
                }
            });
        });

        /**
        *扫描触发事件
        **/
        function afterScan() {           
            if ($("#txtSN").val() != "") {

                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
                resourceId = $("#hdnCurrResourceId").val();
                stationId = $("#hdnCurrStationId").val();
                scanSN = $.trim($("#txtSN").val()); //扫描Sn

                $("#hidSNCode").val(scanSN);//保存SN,手动关箱操作使用

                //称重检验
                checkWeight2(scanSN, 1, function (isOK) {
                    if (!isOK)
                        return false;

                    //var isCheckSeq = $("#cbxCheckSeq").prop("checked");//是否检查扫描序号顺序
                    var isCheckBox = $("#cbxSetBox").prop("checked");//是否检查箱号顺序
                    var currentBoxSeq = $("#sltBoxSeq").val();//当前包装箱的顺序号

                    if (isCheckBox) {//根据选择的包装箱顺序号验证是否正确顺序
                        if (currentBoxSeq == "") {
                            updateCollectionList(scanSN, 'NG');
                            showAreaMessge(scanSN + ':已启用自定义箱号，当前箱号顺序为空！', "messageRed");
                            return false;
                        }
                    }
                    else {
                        currentBoxSeq = 0;
                    }
                    boxFlag = checkIsBoxPack(scanSN);
                    stationRefreshBySN(scanSN);
                    if (!boxFlag) {//保留没有中箱包装逻辑
                        if (packSN == "") {//如果未扫描过包装箱
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPackNumberBySN(scanSN, stationId, resourceId, currentBoxSeq);
                            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPackNumberBySNToMK(scanSN, stationId, resourceId, currentBoxSeq);//增加码垛记录保存
                            if (ajax.error != null) {
                                updateCollectionList(scanSN, 'NG');
                                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                                //写入日志
                                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                                $("#txtSN").val("").focus();
                                return false;
                            }
                            packSN = ajax.value[0];
                            packQty = parseInt(ajax.value[1]);
                            maxPackQty = parseInt(ajax.value[2]);
                            lastScanSN = ajax.value[3];
                            isCheckSeq = ajax.value[4];
                            lableItemId = parseInt(ajax.value[5]);
                            updateCollectionList(scanSN, 'OK');
                            showAreaMessge(scanSN + ':' + "已打开包装箱[" + packSN + "](" + packQty + "/" + maxPackQty + ")！" + (prodWeight > 0 ? "当前产品重量为：" + prodWeight + " " + units : ""), "messageGreen");
                            $("#hidSNCode").val(scanSN);//保存SN，手动关箱操作使用
                            getPackingPalletDetailNew(packSN, 1); //1为包装Level,2为栈板Level
                            if (packQty == maxPackQty) {
                                if (maxPackQty == 1) {
                                    checkPackPrint(); //检查是否需要打印包装箱条码信息
                                    showAreaMessge('自动关闭包装箱[' + packSN + ']！', "messageGreen");
                                    //根据SN刷新侧边栏动态信息
                                    refreshProInfoBySN(scanSN);

                                }
                                packSN = "";
                            }
                        }
                        else {//已获取到包装箱号

                            if (isCheckSeq.toUpperCase() == "TRUE") {//根据扫描的条码做扫描顺序判断
                                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CheckBoxSeq(lastScanSN, scanSN, packSN);
                                if (ajax.error != null) {
                                    updateCollectionList(scanSN, 'NG');
                                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                                    $("#txtSN").val("").focus();
                                    return false;
                                }
                            }

                            //验证产品条码，将产品SN包装到包装箱内
                            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CollectPackSN(scanSN, packSN, stationId, resourceId, currentBoxSeq);
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CollectPackSNToMK(scanSN, packSN, stationId, resourceId, currentBoxSeq);//增加码垛记录保存
                            if (ajax.error != null) {
                                updateCollectionList(scanSN, 'NG');
                                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                                //写入日志
                                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                                $("#txtSN").val("").focus();
                                return false;
                            }
                            packQty = parseInt(ajax.value[0]);
                            maxPackQty = parseInt(ajax.value[1]);
                            refreshProInfoBySN(scanSN);
                            updateCollectionList(scanSN, 'OK');
                            showAreaMessge(scanSN + ':包装成功！包装箱[' + packSN + '](' + packQty + '/' + maxPackQty + ')' + (prodWeight > 0 ? "当前产品重量为：" + prodWeight + " " + units : ""), "messageGreen");
                            $("#hidSNCode").val(scanSN);//保存SN，手动关箱操作使用
                            lastScanSN = scanSN;
                            lableItemId = parseInt(ajax.value[2]);
                            getPackingPalletDetailNew(packSN, 1); //1为包装Level,2为栈板Level
                            if (packQty == maxPackQty) {
                                checkPackPrint(); //检查是否需要打印包装箱条码信息
                                showAreaMessge('自动关闭包装箱[' + packSN + ']！', "messageGreen");

                                var nextSeq = $("#sltBoxSeq option:selected").next().val();
                                if (nextSeq != "") {
                                    $("#sltBoxSeq option:selected").remove();
                                    $("#sltBoxSeq").val(nextSeq);
                                }

                                //根据SN刷新侧边栏动态信息
                                refreshProInfoBySN(scanSN);
                                packSN = "";
                                lastScanSN = "";
                                packQty = 0;
                                maxPackQty = 0;
                            }
                        }
                    }
                    else//新增有中箱包装逻辑
                    {
                        $("#PackingDetailHeader").hide();
                        $("#PackingDetailHeaderBox").show();
                        if (!isScanOffline) {//在线打印包装条码逻辑
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetBoxNumberBySN(scanSN, boxSN, stationId, resourceId);
                            if (ajax.error != null) {
                                updateCollectionList(scanSN, 'NG');
                                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                                //写入日志
                                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                                $("#txtSN").val("").focus();
                                return false;
                            }

                            boxSN = ajax.value[0];
                            packQty = parseInt(ajax.value[1]);
                            maxPackQty = parseInt(ajax.value[2]);
                            packType = ajax.value[3];
                            lableItemId = parseInt(ajax.value[4]);
                            if (packType.indexOf("Offline") == -1) {
                                refreshProInfoBySN(scanSN);
                                updateCollectionList(scanSN, 'OK');

                                getPackingPalletDetailNew(boxSN == "" ? packSN : boxSN, 1); //1为包装Level,2为栈板Level

                                if (packType == "Container") {
                                    packSN = boxSN;
                                    boxSN = "";
                                    showAreaMessge(scanSN + ':' + "包装箱[" + packSN + "](" + packQty + "/" + maxPackQty + ")", "messageGreen");
                                }
                                else {
                                    showAreaMessge(scanSN + ':' + "包装中箱[" + boxSN + "](" + packQty + "/" + maxPackQty + ")", "messageGreen");
                                }
                                if (packQty == maxPackQty && packType != "Container") {//中箱包入大箱   

                                    showAreaMessge('自动关闭包装中箱[' + boxSN + ']！', "messageGreen");
                                    lableType = -22;
                                    lableSequence = 8;//序号
                                    checkPackPrint(boxSN);
                                    //包装中箱打印完成，类型还原成包装箱
                                    lableType = -4; //包装打印
                                    lableSequence = 3//序号  
                                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CollectBoxSN(boxSN, packSN, stationId, resourceId);
                                    if (ajax.error != null) {
                                        updateCollectionList(scanSN, 'NG');
                                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                                        //写入日志
                                        SaveUserUILog("一般", stationId, resourceId, boxSN, ajax.error.Message);
                                        $("#txtSN").val("").focus();
                                        return false;
                                    }
                                    packSN = ajax.value[0];
                                    packQty = parseInt(ajax.value[1]);
                                    maxPackQty = parseInt(ajax.value[2]);
                                    packType = "Box";
                                    boxSN = "";
                                    getPackingPalletDetailNew(packSN == "" ? boxSN : packSN, 1); //1为包装Level,2为栈板Level
                                    //showAreaMessge(scanSN + ':' + "包装箱[" + packSN + "](" + packQty + "/" + maxPackQty + ")", "messageGreen");

                                    if (packQty == maxPackQty) {
                                        lableType = -4;
                                        lableSequence = 3;//序号
                                        checkPackPrint(packSN);
                                        getPackingPalletDetailNew(packSN, 1); //1为包装Level,2为栈板Level
                                        showAreaMessge('自动关闭包装箱[' + packSN + ']！', "messageGreen");
                                        //根据SN刷新侧边栏动态信息
                                        refreshProInfoBySN(scanSN);
                                        packSN = "";
                                    }
                                }
                            }
                            else {
                                isScanOffline = 1;
                                updateCollectionList(boxSN, 'OK');
                                showAreaMessge("包装箱[" + boxSN + "](" + packQty + "/" + maxPackQty + "),请扫描中箱条码！", "messageGreen");
                                packSN = boxSN;
                                getPackingPalletDetailNew(packSN, 1); //1为包装Level,2为栈板Level
                                boxSN = "";
                            }
                        }
                        else {//离线打印包装条码逻辑
                            //扫描中箱                        
                            if (boxSN == "") {
                                boxSN = scanSN;
                                scanSN = "";
                            }
                            var showSN = (scanSN == "" ? boxSN : scanSN);
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CollectOfflinePackSN(scanSN, boxSN, packSN, stationId, resourceId);
                            if (ajax.error != null) {
                                updateCollectionList(showSN, 'NG');
                                showAreaMessge(showSN + ':' + ajax.error.Message, "messageRed");
                                //写入日志
                                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                                if (scanSN == "") {
                                    boxSN = "";
                                }
                                $("#txtSN").val("").focus();
                                return false;
                            }

                            packQty = parseInt(ajax.value[0]);
                            maxPackQty = parseInt(ajax.value[1]);
                            packType = ajax.value[2];
                            lableItemId = parseInt(ajax.value[3]);
                            if (scanSN != "") {
                                refreshProInfoBySN(scanSN);
                            }

                            updateCollectionList(showSN, 'OK');
                            showAreaMessge(showSN + ":包装中箱[" + boxSN + "](" + packQty + "/" + maxPackQty + "),请扫描产品条码！", "messageGreen");
                            getPackingPalletDetailNew(packSN, 1); //1为包装Level,2为栈板Level
                            if (packQty == maxPackQty) {
                                if (packType == "Box") {
                                    showAreaMessge("自动关闭包装中箱[" + boxSN + "]！", "messageGreen");

                                } else {
                                    showAreaMessge("自动关闭包装中箱[" + boxSN + "]！", "messageGreen");
                                    showAreaMessge("自动关闭包装箱[" + packSN + "]！", "messageGreen");
                                    //根据SN刷新侧边栏动态信息
                                    refreshProInfoBySN(scanSN);
                                    packSN = "";
                                    isScanOffline = 0;
                                }
                                boxSN = "";
                            }
                        }
                    }
                    $("#txtSN").val("");
                });
            }
        }

        function checkWeight2(scanSN, weightType, callback) {//称重类型：1为通用过站称重SN、2为包装称重SN（包装称重SN重量不足时不能强制过站）
            if (isWeight) {//需要称重操作
                GetWeight(function () {
                    resultWeigh = prodWeight;  //获取重量结果

                    //验证重量范围
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainerWeight.CheckSNWeight(scanSN, parseFloat(resultWeigh), stationId, resourceId, weightType);
                    if (ajax.error != null) {
                        // alert(ajax.error.Message);
                        $("#lblMsg").css("color", "red").text(ajax.error.Message)
                        $("#txtSN").select();
                        //写入日志
                        //SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        callback(false);
                        return;
                    }
                    callback(true);
                });
            }
            else {
                callback(true);
            }
        }
        /*
        *检查是否需要中箱包装
        */
        function checkIsBoxPack(sn) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetIsBoxPack(sn);
            if (ajax.error != null) {
                updateCollectionList(sn, 'NG');
                showAreaMessge(sn + ':' + ajax.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, sn, ajax.error.Message);
                $("#txtSN").val("").focus();
                return false;
            }
            return ajax.value;
        }
        /*
        *检查是否需要打印包装箱条码
        */
        function checkPackPrint(boxSN) {
            labelStr = (boxSN == undefined ? packSN : boxSN);
            var printSN = labelStr;
            //如果勾选了重印复选框，则必定会调动打印功能。
            if ($("#chkRePrint").prop("checked")) {
                print();
                lableItemId = -1;
            }
            else {
                //查询当前工单所跑路由在当前工序是否需要打印包装箱条码。
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CheckIsPrintSN(printSN, 1, stationId);
                if (ajax.error != null) {
                    showAreaMessge(packSN + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, printSN, ajax.error.Message);
                    $("#txtSN").val("").focus();
                    return false;
                }
                if (ajax.value == true) {
                    print();
                    lableItemId = -1;
                }
            }
        }

        function getPackingPalletDetailNew(sn, containerType) {
            if (sn == "") {
                return;
            }
            //将明细刷新掉.
            //$("#tdPackNo").html(SN);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPackIngPalletDetailByContainerSN(sn, containerType);
            if (ajax.error == null) {
                $("#packingList  tr:gt(1)").remove();
                if (ajax.value.Rows.length > 0) {
                    loadTableNew(ajax.value);
                    return true;
                }
                return false;
            }
            else {
                alert(ajax.error.Message);
                return false;
            }
        }

        function loadTableNew(list) {
            var row, cell;
            var setTable = document.getElementById("packingList");

            /***动态创建表***/
            for (var i = 0; i < list.Rows.length; i++) {
                entity = list[i];
                if (i == 0) {
                    PackSN = list.Rows[i].ContainerSN;
                    packStatusId = list.Rows[i].StatusId;
                }
                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                if (boxFlag) {

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.style.display = "none";
                    cell.innerHTML = list.Rows[i].CCDataId;

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = list.Rows[i].ContainerSN;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = list.Rows[i].BoxSN;

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = list.Rows[i].SerialNumber;
                }
                else {
                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.style.display = "none";
                    cell.innerHTML = list.Rows[i].CCDataId;

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = list.Rows[i].ContainerSN;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = list.Rows[i].SerialNumber;
                }
            }
        }

        //异常重量变色提醒
        function colorWarning(itemMinWeight, itemMaxWeight) {
            setInterval(function () {
                var txtCurrentWeight = $("#txtCurrentWeight").val().split(' ')[0];
                if (parseInt(txtCurrentWeight) > itemMinWeight && parseInt(txtCurrentWeight) < itemMaxWeight) {
                    $("#txtCurrentWeight").css('background-color', 'Chartreuse');
                } else {
                    $("#txtCurrentWeight").css('background-color', 'Red');
                }
            }, 500);
        }

        function UpdateList(strName) {
            document.forms[0].submit();
        }

        //手动关闭包装中箱（离线）
        function HandCloseCatainer() {
            debugger
            //扫描中箱                        
            if (boxSN == "") {
                boxSN = scanSN;
                scanSN = "";
            }
            var showSN = (scanSN == "" ? boxSN : scanSN);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CollectHandOfflinePackSN(scanSN, boxSN, packSN, stationId, resourceId);
            if (ajax.error != null) {
                updateCollectionList(showSN, 'NG');
                showAreaMessge(showSN + ':' + ajax.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                $("#txtSN").val("").focus();
                return false;
            }

            packQty = parseInt(ajax.value[0]);
            maxPackQty = parseInt(ajax.value[1]);
            packType = ajax.value[2];

            if (scanSN != "") {
                refreshProInfoBySN(scanSN);
            }

            updateCollectionList(showSN, 'OK');
            getPackingPalletDetailNew(packSN, 1); //1为包装Level,2为栈板Level
            showAreaMessge("手工关闭包装中箱[" + boxSN + "]！", "messageGreen");
            boxSN = "";
            if (packQty == maxPackQty) {
                showAreaMessge("手工关闭包装箱[" + packSN + "]！", "messageGreen");
                //根据SN刷新侧边栏动态信息
                refreshProInfoBySN(scanSN);
                packSN = "";
                isScanOffline = 0;
                boxSN = "";
            }
        }

        //手动关闭包装中箱（在线）
        function HandCloseOnLineBox() {
            debugger
            if (!isScanOffline) {//在线打印包装条码逻辑
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.HandCollectBoxSN(scanSN, boxSN, stationId, resourceId, packSN);
                if (ajax.error != null) {
                    updateCollectionList(scanSN, 'NG');
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    $("#txtSN").val("").focus();
                    return false;
                }

                boxSN = ajax.value[0];
                packQty = parseInt(ajax.value[1]);
                maxPackQty = parseInt(ajax.value[2]);
                packType = ajax.value[3];
                packSN = ajax.value[4];
                if (packType.indexOf("Offline") == -1) {
                    refreshProInfoBySN(scanSN);
                    updateCollectionList(scanSN, 'OK');

                    getPackingPalletDetailNew(boxSN == "" ? packSN : boxSN, 1); //1为包装Level,2为栈板Level

                    if (packType == "Container") {
                        packSN = boxSN;
                        boxSN = "";
                        showAreaMessge("手工关闭包装箱[" + packSN + "](" + packQty + "/" + maxPackQty + ")", "messageGreen");
                    }
                    else {
                        showAreaMessge("手工关闭包装中箱[" + boxSN + "](" + packQty + "/" + maxPackQty + ")", "messageGreen");
                        lableType = -22;
                        lableSequence = 8;//序号
                        checkPackPrint(boxSN);
                        //包装中箱打印完成，类型还原成包装箱
                        lableType = -4; //包装打印
                        lableSequence = 3//序号 
                        boxSN = "";

                    }
                    if (packQty == maxPackQty) {
                        lableType = -4;
                        lableSequence = 3;//序号
                        checkPackPrint(packSN);
                        getPackingPalletDetailNew(packSN, 1); //1为包装Level,2为栈板Level
                        showAreaMessge('手工关闭包装箱[' + packSN + ']！', "messageGreen");
                        //根据SN刷新侧边栏动态信息
                        refreshProInfoBySN(scanSN);
                        packSN = "";
                        isScanOffline = 0;
                        boxSN = "";
                    }
                }
            }
        }

        function openChoosePage(flags) {
            var condition = "";
            globalFlag = flags;
            
            dialog({
                title: "选择工单",
                src: webroot + "/Framework/ChoosePage.aspx?PageId=" + flags +
                    "&Multiple=false&PageCondition=" +
                    escape(condition) +"&callBackFunc=getChooseValue1"+
                    "&rnd=" +
                    Math.random(),
                width: 700,
                height: 300
            });
         }

        function getChooseValue1(list) {             
            if (globalFlag = 44) {
                $("#hdnProdOrderId").val(list[0][0]);
                 $("#txtProdOrder").val(list[0][1]);
                 bindBoxSelect(list[0][0]);
             }
         }

        function bindBoxSelect(prodOrderId) {
             //获取当前需要加载的箱数
             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetBoxSeq(prodOrderId);
             if (ajax.error != null) {                
                 showAreaMessge(ajax.error.Message, "messageRed");                  
                 return false;
             }
             var seqList = ajax.value;
             var html = "<option value=''>--请选择--</option>";
             for (var i = 0; i < seqList.length; i++) {                 
                 html += "<option value='" + seqList[i] + "'>" + seqList[i] + "</option>";
             }
             $("#sltBoxSeq").html(html);
         }

    </script>
   
</asp:Content>

