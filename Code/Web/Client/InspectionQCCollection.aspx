<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="InspectionQCCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.InspectionQCCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        #layermsg {
            position: absolute;
            left: 50%;
            top: 50%;
            width: 500px;
            height: 200px;
            margin-left: -250px;
            margin-top: -100px;
            display: none;
            z-index: 999;
            background-color: White;
        }

        #layerImport {
            position: absolute;
            left: 50%;
            top: 50%;
            width: 900px;
            height: 500px;
            margin-left: -450px;
            margin-top: -250px;
            display: none;
            z-index: 999;
            background-color: White;
            border: 1px solid #ccc;
            padding: 2px;
        }

        #layer {
            background-color: #F1F3F8;
            left: 0;
            opacity: 0.9;
            position: absolute;
            top: 0;
            z-index: 3;
            filter: alpha(opacity=90);
            -moz-opacity: 0.9;
            -khtml-opacity: 0.9;
            display: none;
            z-index: 100;
        }

        #divClose {
            color: #fff;
            width: 15px;
            background: red;
            text-align: center;
            cursor: pointer;
            position: absolute;
            right: 10px;
            top: 10px;
        }
    </style>
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">请扫描包装箱/栈板条码</span> &nbsp;&nbsp;&nbsp;&nbsp;<div
                            id="messageBox">
                        </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <input type="text" id="txtSN" class="scan-center-sn" style="height: 35px; line-height: 35px;" />
                    </td>
                    <td align="center">
                        <input type="button" value=" 锁 定 " id="btnLock" onclick="inspectionLock(0)" />
                        <input type="button" value=" Pass " id="btnPass" onclick="pass(0)" />
                        <input type="button" value=" Reject " id="btnReject" onclick="reject()" />
                        <input type="button" value=" 强制通过 " id="btnPersonPass" onclick="pass(2)" />
                        <input type="button" value=" 提前录入 " id="btnPreImport" onclick="preImport()" />
                        <input type="button" value=" 切 入 " id="btnImport" onclick="importItem()" />
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
            <div style="font-size: 14px; border: 1px solid #D3D3D3; line-height: 30px; margin: 0px 0px 5px 0px;">
                &nbsp;批号：<span id="lblLotNo" style="font-weight: bold;"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产品编码：<span
                    id="lblItemCode" style="font-weight: bold;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;已送检数量：<span
                        id="lblInspectionQty" style="font-weight: bold;"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：<span
                            id="lblStatus" style="font-weight: bold;"></span>
            </div>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" id="inspectionMemberTb"
                style="display: none;">
                <tr>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table cellpadding="0" cellspacing="0" border="0" class="ListTable" id="inspectionMemberItemTb">
                            <thead>
                                <tr class="ListTableHeader">
                                    <th style="width: 70px;"></th>
                                    <th>检验项
                                    </th>
                                    <th>检验水平
                                    </th>
                                    <th>AQL
                                    </th>
                                    <th>应抽数量
                                    </th>
                                    <th>已抽数量
                                    </th>
                                    <th>判断标准
                                    </th>
                                    <th>已抽不良
                                    </th>
                                    <th width="60">结果
                                    </th>
                                </tr>
                            </thead>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td valign="bottom">
                        <div style="font-size: 14px;">
                            &nbsp;包装信息：
                        </div>
                    </td>
                    <td align="center">
                        <div style="font-size: 14px;">
                            扫描序号：<input type="text" id="txtLotSN" class="scan-center-sn" style="width: 50%; height: 30px; line-height: 30px;" />
                        </div>
                        <div id="divLotSNMsg" style="color: green; font-weight: bold; margin-top: 3px;"></div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; vertical-align: top;">
                        <div style="height: 200px; overflow: auto;">
                            <table id="packSNTb" cellpadding="0" cellspacing="0" border="0" class="ListTable"
                                style="min-width: 200px;">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th>包装箱/栈板条码
                                        </th>
                                        <th style="width: 80px;">数量
                                        </th>
                                    </tr>
                                </thead>
                                <tr class="ListTableOddRow">
                                    <td align="center" colspan="2">暂无数据
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td style="vertical-align: top;" align="right">
                        <div style="height: 200px; overflow: auto;">
                            <table class="ListTable" id="inspectionMemberItemSNTb" style="width: 99%;">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th>序号
                                        </th>
                                        <th>检验项
                                        </th>
                                        <th>客户号码
                                        </th>
                                        <th width="60px;">结果
                                        </th>
                                        <th>不良代码
                                        </th>
                                        <th width="140px;">采集日期
                                        </th>
                                    </tr>
                                    <tr class="ListTableOddRow">
                                        <td align="center" colspan="6">暂无数据
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="layer">
    </div>
    <div id="layermsg">
        <div id='divClose' title='关闭'>
            X
        </div>
        <div style="width: 500px; height: 200px;">
            <table class="EditeContentTable" id="Table1" style="width: 100%;">
                <tr style="height: 30px;">
                    <td colspan="2"></td>
                </tr>
                <tr style="height: 160px;">
                    <td class="Label1">回流工序
                    </td>
                    <td class="Field1">
                        <select id="ddlStation">
                        </select>

                    </td>
                </tr>
                <tr style="height: 40px;">
                    <td class="Label1"></td>
                    <td class="Field1">&nbsp;&nbsp;<input type="button" value=" 确 定 " id="btnComfirm" onclick="rejectConfirm()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
                        type="button" id="btnCancle" value=" 取 消 " />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="layerImport">
        <div id='divClose' title='关闭'>
            X
        </div>
        <div style="width: 900px; height: 500px;">
            <table class="EditeContentTable" id="Table2" style="width: 100%;">
                <tr>
                    <td class="Label3">检验项
                    </td>
                    <td class="Field3">
                        <div id="preCheckItem"></div>
                    </td>
                    <td class="Label3">产品代码
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtItemName" runat="server" Enabled="false" ClientIDMode="Static"
                            Width="64%" Height="26px">
                        </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(1);" />
                        <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                    <td class="Label3">导入类型
                    </td>
                    <td class="Field3">
                        <select id="sltImport">
                            <option value="0">未导入</option>
                            <option value="1">已导入</option>
                        </select>
                        &nbsp;<input type="button" value=" 查 询 " onclick="loadpreImport()" />
                    </td>
                </tr>
                <tr>
                    <td class="Field3" colspan="8">&nbsp;&nbsp;序&nbsp;号&nbsp;<input type="text" id="txtPreImport" class="scan-center-sn" style="height: 26px; line-height: 26px; width: 400px;" />&nbsp;&nbsp;<input type="button" value=" 输 入 " onclick="afterScanPreImport()" />
                        &nbsp;&nbsp;&nbsp;&nbsp;总数量：<span id="lblTotalQty"></span> &nbsp;, 不良数量：<span id="lblNGQty"></span>
                    </td>
                </tr>
            </table>
            <div style="margin-top: 3px; overflow: auto; width: 900px; height: 425px;">
                <table cellpadding="0" cellspacing="0" border="0" class="ListTable" id="inspecImportTb">
                    <tr class="ListTableHeader">
                        <th>产品代码
                        </th>
                        <th>序号
                        </th>
                        <th>检验项
                        </th>
                        <th>客户号码
                        </th>
                        <th>结果
                        </th>
                        <th>不良代码
                        </th>
                        <th>扫描人员
                        </th>
                        <th>扫描日期
                        </th>
                        <th>导入日期
                        </th>
                    </tr>
                    <tr class="ListTableOddRow">
                        <td align="center" colspan="9">暂无数据</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        var inspectionLotId = 0;
        var inspectionLotMemberId = 0;
        var isNCCode = 0;
        var sn = "";
        var resourceId;
        var stationId
        var ncCodeArr = [];
        $(document).ready(function () {
            //权限加载
            loadPermissions();
            //1.获取当前基本信息

            resourceId = $("#hdnCurrResourceId").val(); //资源Id
            stationId = $("#hdnCurrStationId").val(); //工位Id
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('InspectionQC_ProCollectionUI');
                },
                10
            );

            //扫描框回车事件
            $("#txtLotSN").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    afterScanLotSN();
                    //return false;
                }
                if (curKey == 46) {
                    $("#txtLotSN").val("");
                }
            });

            //扫描框回车事件
            $("#txtPreImport").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    afterScanPreImport();
                    //return false;
                }
                if (curKey == 46) {
                    $("#txtPreImport").val("");
                }
            }
         );

        });

        function afterScan() {
            if ($("#txtSN").val() != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }

                var scanSN = $.trim($("#txtSN").val()); //扫描Sn

                //扫描SN检查是否存在包装SN与检验批次的关系，有则带出
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionInfoByPackSN(inspectionLotId, scanSN, stationId, resourceId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtSN").val("");
                    $("#txtSN").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }
                var entity = ajax.value;
                inspectionLotId = entity.InspectionLotId;

                if ($.trim(entity.InspectionLotNo) != "") {
                    $("#btnLock").attr("disabled", "disabled");
                    //加载AQL规则,OQC检验项
                    inspectionLock(0);
                }
                $("#lblLotNo").text(entity.InspectionLotNo);
                $("#lblItemCode").text(entity.ItemCode);
                $("#lblInspectionQty").text(entity.LotQty);
                $("#lblStatus").text(entity.State);
                //查询包装SN信息

                var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetPackSNByInspectionLotId(inspectionLotId, 1);
                if (ajaxPack.error != null) {
                    alert(ajaxPack.error.Message);
                    $("#txtSN").val("");
                    $("#txtSN").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                    return false;
                }
                $("#packSNTb  tr:not(:first)").remove();
                loadPackInfo(ajaxPack.value);
            }
            $("#txtSN").val("");
        }

        function loadPackInfo(list) {
            var row, cell;
            var setTable = document.getElementById("packSNTb");
            if (list == null || list == undefined) {
                return;
            }
            if (list[0].SN != null && list[0].SN != "") {
                refreshProInfoBySN(list[0].SN);
            }
            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = entity.PackSN;

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.Quantity;


            }
        }

        /**
        *  加载AQL规则,OQC检验项
        **/
        function inspectionLock(flag) {
            if (inspectionLotId <= 0) {
                alert("请扫描包装/栈板条码！");
                $("#txtSN").val("");
                $("#txtSN").focus();
                return false;
            }
            var qcType = 5; //检验类型： 1、IQC  2、IPQC 3、PQC  4、FQC 5、OQC
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionMemberByLotId(inspectionLotId, 2, qcType);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            loadInspectionMemberInfo(ajaxPack.value);

            if (flag == 0) {//首次加载
                inspectionLotMemberId = ($("#inspectionMemberItemTb tr:eq(1) td:eq(0) input[type=checkbox]").val());
                $("#inspectionMemberItemTb tr:eq(1) td:eq(0) input[type=checkbox]").attr("checked", "checked");
                $("#inspectionMemberItemTb tr:eq(1)").css("background-color", "yellow");
                getInspectionMemberSNInfo();
            }
            else {
                $("#inspectionMemberItemTb tr  td input[type=checkbox]").each(function (i, obj) {
                    if (inspectionLotMemberId == $(obj).val()) {
                        i = i + 1;
                        $("#inspectionMemberItemTb tr:eq(" + i + ") td:eq(0) input[type=checkbox]").attr("checked", "checked");
                        $("#inspectionMemberItemTb tr:eq(" + i + ")").css("background-color", "yellow");
                    }
                });
            }

            getInspectionLotInfo();

            $("#txtSN").attr("disabled", "disabled");
            $("#txtLotSN").val("").focus();
            $("#inspectionMemberTb").show();

        }
        /**
        *  OQC检验项详情
        **/
        function loadInspectionMemberInfo(list) {
            var row, cell;
            var setTable = document.getElementById("inspectionMemberItemTb");
            if (list == null || list == undefined) {
                return;
            }
            $("#inspectionMemberItemTb  tr:not(:first)").remove();
            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = "<input type='checkbox' style='height:15px;width:15px;' onclick='inspectionMemberCheck(this)' name='InspectionMemberId' value='" + entity.InspectionLotMemberId + "' />";

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.AQLSampleName;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = entity.AQLLevel;

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = entity.AQLRule;

                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = entity.InspectionQty;

                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = entity.ActualQty;

                cell = row.insertCell(6);
                cell.align = "center";
                cell.innerHTML = entity.Judgment;

                cell = row.insertCell(7);
                cell.align = "center";
                cell.innerHTML = entity.NCCodeQty;

                cell = row.insertCell(8);
                cell.align = "center";
                cell.innerHTML = entity.Result;
            }

        }

        /**
        *  点击检验项复选框查询SN
        **/
        function inspectionMemberCheck(obj) {

            var checkObj = $(obj);
            $("#inspectionMemberItemTb tr td input[type=checkbox]").attr("checked", false);
            $("#inspectionMemberItemTb tr:not(first)").css("background-color", "");
            checkObj.attr("checked", true);

            $("#txtLotSN").focus();
            checkObj.parent().parent().css("background-color", "yellow");
            inspectionLotMemberId = checkObj.val();
            sn = "";
            isNCCode = 0;
            getInspectionMemberSNInfo();
        }

        /**
        *  加载SN信息
        **/
        function getInspectionMemberSNInfo() {
            //查询检验项下SN信息
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionLotSNInfo(inspectionLotMemberId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            loadInspectionMemberSNInfo(ajaxPack.value);
        }

        /**
        *  加载SN信息
        **/
        function loadInspectionMemberSNInfo(list) {
            var row, cell;
            var setTable = document.getElementById("inspectionMemberItemSNTb");
            $("#inspectionMemberItemSNTb  tr:not(:first)").remove();
            if (list == null || list == undefined) {
                row = setTable.insertRow(setTable.rows.length);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = "6";
                cell.innerHTML = "暂无数据"
                return;
            }

            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = entity.SN

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.AQLSampleName;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = entity.CustomerSN;

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = entity.Result;

                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = entity.NCCode.substring(0, entity.NCCode.length - 1);

                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = entity.CreateDateTime;
            }
        }

        /**
        *  SN扫描信息
        **/
        function afterScanLotSN() {
            var currentSN = $.trim($("#txtLotSN").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.GetNCCodeInfo(currentSN, stationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtLotSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, currentSN, ajax.error.Message);
                return false;
            }
            //查询当前扫描的SN是否为不良代码，为不良代码则加入数组
            if (ajax.value[0] != "") { //当前扫码的SN为不良代码

                //判断当前不良是否已经扫描
                for (var j = 0; j < ncCodeArr.length; j++) {
                    if (ncCodeArr[j] == currentSN) {
                        $("#divLotSNMsg").html("不良代码[" + currentSN + "]移除成功！");
                        setTimeout(function () { $("#divLotSNMsg").html(""); }, 2000)
                        ncCodeArr.splice(j, 1);
                        $("#txtLotSN").val("").focus();
                        return false;
                    }
                }
                //验证不良代码是否重复扫描
                ncCodeArr.push(currentSN);
                $("#divLotSNMsg").html("不良代码[" + currentSN + "]采集成功！");
                setTimeout(function () { $("#divLotSNMsg").html(""); }, 2000)
                $("#txtLotSN").val("").focus();

                return false;
            }

            var ncArrStr = "";
            for (var j = 0; j < ncCodeArr.length; j++) {
                ncArrStr += (ncCodeArr[j] + "^");
            }

            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotSNInfo(inspectionLotId, inspectionLotMemberId, currentSN, stationId, resourceId, ncArrStr, '');
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtLotSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, currentSN, ajaxPack.error.Message);
                return false;
            }
            ncCodeArr = [];
            getInspectionMemberSNInfo();
            inspectionLock(1);
            $("#txtLotSN").val("").focus();
        }

        /**
        *  获取送检单信息
        **/
        function getInspectionLotInfo() {
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionInfoByLotId(inspectionLotId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            if (ajaxPack != null) {
                var entity = ajaxPack.value;
                $("#lblLotNo").text(entity.InspectionLotNo);
                $("#lblItemCode").text(entity.ItemCode);
                $("#lblInspectionQty").text(entity.LotQty);
                $("#lblStatus").text(entity.State);
            }
        }

        /**
        *通过检验
        **/
        function pass(passType) {

            var msg = passType == 0 ? "Pass" : "强制通过";
            if (confirm("是否确定进行[" + msg + "]操作?")) {
                if (inspectionLotId <= 0) {
                    alert("请扫描包装/栈板条码！");
                    $("#txtSN").val("");
                    $("#txtSN").focus();
                    return false;
                }
                var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotPass(inspectionLotId, passType, stationId, resourceId);
                if (ajaxPack.error != null) {
                    alert(ajaxPack.error.Message);
                    $("#txtLotSN").val("");
                    $("#txtLotSN").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                    return false;
                }


                alert(msg + "操作成功！");
                sn = "";
                inspectionLotId = 0;
                inspectionLotMemberId = 0;

                $("#inspectionMemberTb").hide();
                clearTable("inspectionMemberItemTb", 9);
                clearTable("packSNTb", 2);
                clearTable("inspectionMemberItemSNTb", 6);
                $("#txtSN").removeAttr("disabled");
                $("#txtSN").val("");
                $("#txtSN").focus();
                $("#lblLotNo").text("");
                $("#lblItemCode").text("");
                $("#lblInspectionQty").text("");
                $("#lblStatus").text("");
            }
        }

        /**
        *检验拒收
        **/
        function reject() {

            if (inspectionLotId <= 0) {
                alert("请扫描包装/栈板条码！");
                $("#txtSN").val("");
                $("#txtSN").focus();
                return false;
            }
            else if ($("#lblLotNo").text() == "") {
                alert("未找到送检批次信息！");
                $("#txtSN").val("");
                $("#txtSN").focus();
                return false;
            }
            if ($("#lblLotNo").text() != "") {
                loadRouter();
            }
            showPage("layermsg");
            return;
        }

        /**
        *显示相关功能窗口
        **/
        function showPage(pageContent) {
            var bodyheight = $("body").height();
            var bodywidth = $("body").width();

            $("#" + pageContent).show();
            $("#btnCancle,#divClose").bind("click", function () { $("#layer,#" + pageContent).hide(); });
            $("#layer").css({
                height: bodyheight,
                width: bodywidth,
                display: "block"
            });
        }

        /**
        *加载Reject操作时的路由工序信息
        **/
        function loadRouter() {
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionLotRouter(inspectionLotId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            $("#ddlStation").find("option").remove();
            var list = ajaxPack.value;
            if (list != null && list.length > 0) {
                $("#ddlStation").append("<option value='-1'>--请选择--</option>");
                for (var i = 0; i < list.length; i++) {
                    $("#ddlStation").append("<option value=" + list[i].StationId + ">" + list[i].Station + "</option>");
                }
            }
            else {
                $("#ddlStation").append("<option value='-1'>--请选择--</option>");
            }
        }

        /**
        *确定Reject操作
        **/
        function rejectConfirm() {
            var returnStationId = $("#ddlStation").val();
            if (returnStationId == -1) {
                alert("请选择回流工序！");
                $("#ddlStation").focus();
                return false;
            }
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotReject(inspectionLotId, stationId, returnStationId, resourceId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }

            alert("Reject操作成功！");
            sn = "";
            inspectionLotId = 0;
            inspectionLotMemberId = 0;

            $("#inspectionMemberTb").hide();
            clearTable("inspectionMemberItemTb", 9);
            clearTable("packSNTb", 2);
            clearTable("inspectionMemberItemSNTb", 6);
            $("#layermsg,#layer").hide();
            $("#txtSN").removeAttr("disabled");
            $("#txtSN").val("");
            $("#txtSN").focus();
            $("#lblLotNo").text("");
            $("#lblItemCode").text("");
            $("#lblInspectionQty").text("");
            $("#lblStatus").text("");
        }

        /**
        **加载检验项
        **/
        function getAQLSampleInfo() {
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetAQLSampleInfo();
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtPreImport").val("");
                $("#txtPreImport").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            var list = ajaxPack.value;
            if (list != null && list.length > 0) {
                var preHtml = '';
                var checkHtml = '';
                for (var i = 0; i < list.length; i++) {
                    if (i == 0) {
                        checkHtml = 'checked="checked"';
                    }
                    else {
                        checkHtml = "";
                    }
                    preHtml += '<input type="radio" id="content" name="checkItem" value="' + list[i].AQLSampleId + '" ' + checkHtml + ' /> <span>' + list[i].AQLSampleName + '</span>&nbsp;&nbsp;';
                }
                $("#preCheckItem").html(preHtml);
            }
        }
        /**
        *提前录入扫描
        **/
        function afterScanPreImport() {
            var importSN = $.trim($("#txtPreImport").val());
            var aqlSampleId = $("input[name='checkItem']:checked").val();  //获取被选中Radio的Value值
            var aqlSampleName = $.trim($("input[name='checkItem']:checked").next("span").text());  //获取被选中Radio的Value值
            if (importSN == "") {
                alert("请扫描序号条码！");
                $("#txtPreImport").focus();
                return false;
            }
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotRecords(importSN, aqlSampleId, aqlSampleName);
            if (ajaxPack.error != null) {
                if (isNCCode == 1 && ajaxPack.error.Message == "NCCODE") {
                    //记录送检产品NG信息
                    var ajaxNcCode = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectPreInspectionLotNCCodeInfo(sn, importSN, stationId, resourceId);
                    if (ajaxNcCode.error != null) {
                        alert(ajaxNcCode.error.Message);
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, sn, ajaxNcCode.error.Message);
                    }
                    loadpreImport();
                }
                else {
                    alert(ajaxPack.error.Message);
                }
                $("#txtPreImport").val("");
                $("#txtPreImport").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, importSN, ajaxPack.error.Message);
                return false;
            }
            loadpreImport();
            isNCCode = 1;
            sn = importSN;
            $("#txtPreImport").val("");
            $("#txtPreImport").focus();
        }

        /**
        *提前录入
        **/
        function preImport() {
            if (inspectionLotId > 0) {
                alert("请先完成当前批次送检，再进行提前录入操作！");
                return;
            }

            isNCCode = 0;
            sn = "";
            getAQLSampleInfo();
            loadpreImport();
            showPage("layerImport");
            $("#txtPreImport").val("").focus();
        }
        /**
        *  加载SN信息
        **/
        function loadpreImport() {
            var importType = $("#sltImport").val();
            var aqlSampleId = $("input[name='checkItem']:checked").val();
            var itemId = $("#hdnItemId").val();

            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionLotRecords(importType, aqlSampleId, itemId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtPreImport").val("");
                $("#txtPreImport").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            var list = (ajaxPack.value);
            var row, cell;
            var setTable = document.getElementById("inspecImportTb");
            $("#inspecImportTb  tr:not(:first)").remove();
            if (list == null || list == undefined) {
                row = setTable.insertRow(setTable.rows.length);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = "9";
                cell.innerHTML = "暂无数据"
                $("#lblTotalQty").text(0);
                $("#lblNGQty").text(0);
                return;
            }

            $("#lblTotalQty").text(list[0].TotalQty);
            $("#lblNGQty").text(list[0].NGQty);

            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = entity.ItemCode

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.SN;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = entity.AQLSampleName;

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = entity.CustomerSN;

                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = entity.Result;

                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = entity.NCCode.substring(0, entity.NCCode.length - 1);;

                cell = row.insertCell(6);
                cell.align = "center";
                cell.innerHTML = entity.CreateBy;

                cell = row.insertCell(7);
                cell.align = "center";
                cell.innerHTML = entity.CreateDateTime;

                cell = row.insertCell(8);
                cell.align = "center";
                cell.innerHTML = entity.ImportDateTime;
            }
        }

        function openChoosePage(flags) {
            var condition = "";

            flag = flags;
            dialog({
                title: "选择窗口",
                src: "../Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&CallBackFunc=getItemChoose" +
                "&rnd=" +
                Math.random(),
                width: 700,
                height: 400
            });
        }

        function getItemChoose(list) {
            $("#txtItemName").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
        }
        /**
        *切入
        **/
        function importItem() {
            if (inspectionLotId <= 0) {
                alert("请扫描包装/栈板条码！");
                $("#txtSN").val("");
                $("#txtSN").focus();
                return false;
            }
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.ImportInspectionLotRecords(inspectionLotId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            inspectionLock(0);
            getInspectionMemberSNInfo();
        }

        /**
        *清空表信息
        **/
        function clearTable(name, colSpan) {
            var row, cell;
            var setTable = document.getElementById(name);
            $("#" + name + "  tr:not(:first)").remove();
            row = setTable.insertRow(setTable.rows.length);
            row.className = 'ListTableOddRow';
            cell = row.insertCell(0);
            cell.align = "center";
            cell.colSpan = colSpan;
            cell.innerHTML = "暂无数据"
        }

        /*JS检查用户是否具有某一权限*/
        function IsHasPermission(userId_int, popedom_int) {
            return SKT.LeanMES.Web.AjaxServices.AjaxClientController.IsPermission(userId_int, popedom_int).value;
        }

        function loadPermissions() {
            var forceRejectPermission = IsHasPermission(userId, 80013901);      //强制通过
            var advanceEntryPermission = IsHasPermission(userId, 80013902);     //提前录入
            var cutInPermission = IsHasPermission(userId, 80013903);            //切入
            if (!forceRejectPermission) {
                $("#btnPersonPass").hide();
            }
            if (!advanceEntryPermission) {
                $("#btnPreImport").hide();
            }
            if (!cutInPermission) {
                $("#btnImport").hide();
            }
        }
    </script>
</asp:Content>
