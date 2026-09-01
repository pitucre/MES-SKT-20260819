<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="TransfersStorage.aspx.cs" Inherits="SKT.LeanMES.Web.Transfers.TransfersStorage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr style="height: 30px;">
            <td align="left"></td>
            <td></td>
            <td></td>
            <td align="right">
                <a href="#" onclick="openSplitMaterial();" style="margin-right: 10px;">分料截料</a>
            </td>
        </tr>
        <tr>
            <td class="Label2">调拨单号<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" value="" id="txtReuestOrder" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                <input type="button" id="btnReuestOrder" class="ButtonBox" value="..." style="height: 27px; font-weight: bold; text-transform: uppercase;"
                    onclick="selectPickingList()" />
            </td>
            <td class="Label2">来源单号
            </td>
            <td class="Field2">
                <label id="woNo">
                </label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div style="width: 49%; overflow: auto; float: left" id="leftApplication">
        <table class="ListTable" width="100%" id="tblRecHistory">
            <tr class="ListTableHeader">
                <th>序号
                </th>
                <th>物料名称
                </th>
                <th>调入仓库
                </th>
                <th>调出仓库
                </th>
                <th>调拨数量
                </th>
                <th>已调数量
                </th>
                <th>出库数量
                </th>
                <th>扫描数量
                </th>
                <th style="width: 50px;">先进先出
                </th>
                 <th>操作
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="10" style="text-align: center;">暂无数据
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 49%; float: right" id="rightRequest">
        <table style="width: 100%;" class="EditeContentTable">
            <tr>
                <td colspan="2">
                    <div class="ListTableTitle" style="border: 0px;">
                        <span>调拨出库扫描</span>
                    </div>
                </td>
            </tr>
            <tr id="grntr">
                <td class="Label1">扫描GRN条码
                </td>
                <td class="Field1">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 90%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                    <input type="text" id="txtPosCode" class="TextBox" style="width: 90%; font-size: 16px; font-weight: bold; text-transform: uppercase; display: none;" />
                </td>
            </tr>
        </table>
        <div style="text-align: center; margin-top: 1px;" class="Tips" id="showGrn">
        </div>
        <div style="width: 100%; overflow: auto; float: left" id="divGrnList">
            <table class="ListTable" width="100%" id="tableGrnList">
                <tr class="ListTableHeader">
                    <th>GRN条码
                    </th>
                    <th>数量
                    </th>
                    <th>库位
                    </th>
                    <th>入库日期
                    </th>
                    <th>生产日期
                    </th>
                </tr>
                <tr id="tr1" class="ListTableOddRow">
                    <td colspan="6" style="text-align: center;"><span>暂无数据</span>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">

        var viewModel = {
            userId: "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>",
            userName: "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>",
            isEnableTransfersStorage: true,             //是否启用调拨出库，默认启用
            FIFO: "-1",                                 //是否启用先进先出
            curIndex:0,                                 

            transfer: {                                 //调拨单主表
                TransfersId: -1,
                TransfersNo: "",
                TransfersType: -1,
                SourceNo: "",
                InWhouseName: "",
                OutWhouseName: "",
            },
            transferDtl: [],                            //调拨单明细
            curTransferDtl: null,
            curScanGRNList: [],                          //当前扫描的GRN列表
            transferDtlMaterial: [],                    //调拨单明细物料对应
            transferDtlMaterialNew: [],                 //新增的
            scanGrns: [],//已扫GRN
           
        };

        var Msg_Enable_TransfersStorage = "不需要调拨出库,请知悉!";

        $(function () {
            //初始化UI
            $("#txtReuestOrder").focus();
            $("#leftApplication").height($(window).height() - 130);
            $("#divGrnList").height($(window).height() - 230);
            //是否启用调拨出库
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfigByConfigType("23");
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            else {
                var entity = ajax.value;
                if (entity && entity.ConfigResult == "2") {
                    viewModel.isEnableTransfersStorage = false;
                }
            }
            //是否启用调拨出库
            if (!viewModel.isEnableTransfersStorage) {
                alert(Msg_Enable_TransfersStorage);
                $("#txtReuestOrder").prop("disabled", true);
                $("#btnReuestOrder").prop("disabled", true);
                return false;
            }
            //扫描调拨单
            $("#txtReuestOrder").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtReuestOrder").val()) != "") {
                        setPickingList($.trim($("#txtReuestOrder").val()));
                        ScanMaterialGrn();
                    }
                }
            });
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    GetPosCode(); 
                }
            });
            //是否配置先进先出
            var mark = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.CheckUserIsWarrantted(viewModel.userId).value;
            if (mark) {
                viewModel.FIFO = "1";
            }
            //阻止表单提交
            $("form").submit(function (e) {
                if (e && e.preventDefault) {
                    e.preventDefault();
                }
                else {
                    window.event.returnValue = false;
                }
                return false;
            });
        });
       
        //扫描GRN带出库位信息
        function GetPosCode() {
            var grn = $.trim($("#txtGRN").val());
            if (viewModel.transfer.TransfersId == -1) {
                alert("请先选择对应的调拨单!");
                $("#txtReuestOrder").focus();
                $("#txtReuestOrder").select();
                return;
            }
            if (!viewModel.curTransferDtl) {
                alert("请选择调拨明细!");
                return;
            }
            if (grn == "") {
                $("#showGrn").html("物料条码不能为空!").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return;
            }
            //获取GRN的仓库信息
            var entity = {};
            entity.GRN = grn;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetMaterialInfoByGRN", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var listGrnInfo = $.parseJSON(ajax.value).data;
            if (!listGrnInfo || listGrnInfo.length == 0) {
                $("#showGrn").html("未找到GRN信息！").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            viewModel.curScanGRNList = listGrnInfo;
            //是否已调拨
            if (isTransferOutGRN(listGrnInfo[0].GRN)) {
                $("#showGrn").html("[" + grn + "]该条码已经调拨出库，不能重复调拨！").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            //是否已扫描
            if (isScanGRN(listGrnInfo[0].GRN)) {
                if (confirm("该物料条码【" + grn + "】已扫描，是否清除重新扫描？")) {
                    clearGrnList(listGrnInfo);
                    $("#showGrn").html("该物料条码[" + grn + "]清理完成！").css("color", "green");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                }
                else {
                    $("#showGrn").html("该物料条码[" + grn + "]已扫描！").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                }
                return false;
            }
            //校验GRN的调出仓库
            var whCode = listGrnInfo[0].CWhCode;
            if (whCode != viewModel.curTransferDtl.ValidOutWhouse) {
                $("#showGrn").html("物料当前所在仓库为[" + whCode + "]，与调拨单明细的调出仓库[" + viewModel.curTransferDtl.ValidOutWhouse + "]不符！").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            //校验GRN
            var grnStr = "";
            var list = [];
            list = list.concat(viewModel.transferDtlMaterial);
            list = list.concat(viewModel.transferDtlMaterialNew);
            $.each(list, function (i, o) {
                grnStr += o.GRN + ",";
            });
            if (list.length > 1) {
                grnStr = grnStr.substring(0, grnStr.length - 1);
            }
            var entity = {};
            entity.TransfersId = viewModel.curTransferDtl.TransfersId; //调拨单ID
            entity.TransfersDtlId = viewModel.curTransferDtl.TransfersDtlId;
            entity.Grn = grn;
            entity.GrnStr = grnStr;
            entity.IsTransferIn = false;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckTransfersGrn", JSON.stringify(entity));
            if (ajax.error != null) {
                $("#showGrn").html(ajax.error.Message);
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var grnResult = $.parseJSON(ajax.value).data;
            if (grnResult[0].Flage == 0) {
                if (viewModel.FIFO !== "1") {     //配置了先进先出
                    alert(grnResult[0].Msg + "。请按照先进先出原则备料！");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    return false;
                } else {
                    if (!confirm(grnResult[0].Msg + "。是否确认操作？")) {
                        $("#txtGRN").val("");
                        $("#txtGRN").focus();
                        return false;
                    }
                }
            }
            //获取GRN或包装箱数量
            var sumQty = 0;
            for (var i = 0; i < grnResult.length; i++) {
                sumQty = sumQty + grnResult[i].BalanceQty * 1;
            }
            //判断扫描数量总和不能大于申请数量
            var applyQty = viewModel.curTransferDtl.ApplyQty * 1;    //申请数量
            var finishQty = viewModel.curTransferDtl.FinishQty * 1;  //调拨数量
            if (finishQty + sumQty > applyQty) {
                $("#showGrn").html("调拨数量不能大于申请数量!");
                $("#showGrn").css("color", "red");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                return false;
            }
            //自动解除包装
            if (grnResult && grnResult.length > 0) {
                if (grnResult[0].IsGrnInBox) {
                    if (!confirm("扫描的GRN在包装箱中,是否自动从包装箱中移除？")) {
                        $("#txtGRN").val("");
                        $("#txtGRN").focus();
                        return false;
                    }
                    else {
                        //解除包装
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.RemoveGRNAuto(grnResult[0].PGRN, grnResult[0].SerialNumber);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            $("#txtGRN").focus();
                            $("#txtGRN").select();
                            return false;
                        }
                    }
                }
            }

            //记录已扫GRN
            var entity = {};
            entity.Type=0; //插入
            entity.TransfersId = viewModel.curTransferDtl.TransfersId; //调拨单ID
            entity.TransfersNo = $("#txtReuestOrder").val();
            entity.TransfersDtlId = viewModel.curTransferDtl.TransfersDtlId;
            entity.Grn = grn;
            entity.QTY = sumQty;
            entity.InWhouse = viewModel.curTransferDtl.ValidInWhouse;
            entity.OutWhouse = viewModel.curTransferDtl.ValidOutWhouse;
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspTransferGRNTemp", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //更新已扫GRN数量
            var scan = $("#ScanQty" + viewModel.curTransferDtl.TransfersDtlId);
            scan.text(parseFloat(scan.text()) + sumQty);

            //更新实体
            $.each(grnResult, function (i, o) {
                viewModel.transferDtlMaterialNew.push({
                    TransfersId: viewModel.curTransferDtl.TransfersId,
                    TransfersDtlId: viewModel.curTransferDtl.TransfersDtlId,
                    GRN: grnResult[i].SerialNumber,
                    IsOnShelf: false,
                    BalanceQty: grnResult[i].BalanceQty * 1,
                    ValidInWhouse: viewModel.curTransferDtl.ValidInWhouse,
                    ValidOutWhouse: viewModel.curTransferDtl.ValidOutWhouse
                });
            });

            //自动计算调拨明细数量
            autoComputeTranferDtlQty(viewModel.curTransferDtl);
            //更新UI
            //var ctrl = $("#td" + viewModel.curTransferDtl.TransfersDtlId);
            //var onPosQty = $("#onPosQty" + viewModel.curTransferDtl.TransfersDtlId);
            //ctrl.text(viewModel.curTransferDtl.FinishQty);
            //onPosQty.text(viewModel.curTransferDtl.OnPosQty);
            //setFirstItem(ctrl);
            //刷新先进先出
            SearchRule(); 
            $("#showGrn").html("【" + grn + "】扫描完成");
            $("#showGrn").css("color", "green");
            $("#txtGRN").val("");
            $("#txtGRN").focus();
            return true;
        }
        //选择调拨单
        function selectPickingList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=801&Multiple=false&CallBackFunc=getChooseValue&rnd=" + Math.random(), width: 600, height: 380 });
        }
        function getChooseValue(list) {
            if (list[0][1] == "") {
                initTransfer();
            }
            else {
                $("#txtReuestOrder").val(list[0][1]);
                setPickingList(list[0][1]);
            }
        }

        

        //根据调拨单获取物料信息
        function setPickingList(forNumber) {
            initTransfer();
            if (forNumber != "") {
                var entity = {};
                entity.TransfersNo = forNumber;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetTransfersItemByNo", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    var result = $.parseJSON(ajax.value);
                    var list = result.data;
                    var r = "";
                    if (list == null || list.length == 0) {
                        r += "<tr class='ListTableEmptyDataRow'><td colspan='10' >暂无数据</td></tr>";
                        $(r).appendTo($("#tblRecHistory"));
                        return false;
                    }
                    viewModel.transfer.TransfersId = list[0]["TransfersId"];
                    viewModel.transfer.TransfersNo = list[0]["TransfersNo"];
                    viewModel.transfer.TransfersType = list[0]["TransfersType"];
                    viewModel.transfer.SourceNo = list[0]["SourceNo"];
                    viewModel.transfer.InWhouseName = list[0]["InWhouse"];
                    viewModel.transfer.OutWhouseName = list[0]["OutWhouse"];
                    viewModel.transferDtl = list;
                    viewModel.curTransferDtl = null;
                    viewModel.curScanGRNList = [];
                    viewModel.transferDtlMaterial = result.data1;
                    viewModel.scanGrns = result.data2;
                    //绑定UI
                    $("#woNo").text(viewModel.transfer.SourceNo);
                    $("#txtGRN").focus();
                    //加载调拨明细
                    loadingItem();
                }
            }
        }

        $("#leftApplication").scroll(function () {
            var scrollTop = $("#leftApplication").scrollTop();
            var scrollHeight = $("#tblRecHistory").height() - 850;

            if (scrollTop >= scrollHeight) {
                if (viewModel.transferDtl.length >= viewModel.curIndex) {
                    setTimeout(loadingItem(),800);
                }  
            }
        });

        //加载调拨明细项
        function loadingItem() {
            //是否重新加载
            if (viewModel.curIndex == 0) {
                $("#tblRecHistory .ListTableOddRow").remove();
            }
            var list = viewModel.transferDtl;
            var count = (viewModel.curIndex + 30 > list.length) ? list.length : viewModel.curIndex + 30;
            var r = "";
            for (var i = viewModel.curIndex; i < count; i++) {

                r += "<tr class='ListTableOddRow' data-id=" + list[i].TransfersDtlId + "><td></td>";
                r += "<td>" + list[i].ItemCode + "(" + list[i].ItemName + ")" + "</td>";
                r += "<td>" + list[i].ValidInWhouseName + "</td>";
                r += "<td>" + list[i].ValidOutWhouseName + "</td>";
                r += "<td id='qty" + list[i].TransfersDtlId + "' name='applyqty'>" + list[i].ApplyQty + "</td>";
                r += "<td  id='td" + list[i].TransfersDtlId + "' name='stockqty'>" + list[i].FinishQty + "</td>";
                r += "<td  id='onPosQty" + list[i].TransfersDtlId + "' name='onPosQty'>" + list[i].OnPosQty + "</td>";
                r += "<td  id='ScanQty" + list[i].TransfersDtlId + "' name='ScanQty'>" + list[i].ScanQty  + "</td>";
                r += "<td align='center'><a href='#' name='alist' onclick ='SearchRule(" + list[i].TransfersDtlId + ")'>先进先出</a><input type='hidden' value='" + list[i].ItemCode + "' name='itemcode' /></td>";
                r += "<td><input type=\"button\" value=\"清除\" onclick=\"clearItemGrnList(" + list[i].TransfersDtlId + ")\"></td>"
                r += "</tr>";

                viewModel.curIndex++;
            }
            if ($("#tblRecHistory tr").length == 1) {
                $("#tblRecHistory tr:eq(0)").after(r);
            }
            else {
                $("#tblRecHistory tr:eq("+($("#tblRecHistory tr").length-1)+")").before(r);
            }
            var j = 0;
            $("#tblRecHistory tr").each(function () {
                $(this).children("td:eq(0)").html(j.toString());
                j++;
            });
            //设置默认选中的调拨明细
            if (list.length > 0) {
                viewModel.curTransferDtl = list[0];
            }
            //默认选中第一行
            selectedTransferDtlRow(list[0].TransfersDtlId);
        }

        //先进先出列表显示
        function SearchRule(id) {
            if (id) {
                selectedTransferDtlRow(id);
            }
            if (!viewModel.curTransferDtl) {
                alert("请选择调拨明细！")
                return false;
            }
            $("#showGrn").html("");
            $("#txtGRN").val("");
            //清空先进先出列表
            if ($("#tableGrnList tr").length > 1) {
                $("#tableGrnList tr:not(:first)").remove();
            }
            //根据物料ID获取GRN信息
            var entity = {};
            entity.TransfersDtlId = viewModel.curTransferDtl.TransfersDtlId;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetTransfersFIFOGRN", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            var GrnList = en.data;
            var r = "";
            if (GrnList == null || GrnList.length == 0) {
                r += "<tr class='ListTableEmptyDataRow'><td colspan='6' >暂无数据</td></tr>";
                $(r).appendTo($("#tableGrnList"));
                return false;
            }
            for (var i = 0; i < GrnList.length; i++) {
                if (isScanGRN(GrnList[i].GRN) || isTransferOutGRN(GrnList[i].GRN)) {

                }
                else {
                    r += "<tr class='ListTableEvenRow'>"
                    r += "<td>" + GrnList[i].GRN + "</td><td>" + parseFloat(GrnList[i].StorageQty) + "</td><td>" + GrnList[i].cBarCode + "</td><td>" + GrnList[i].StorageDate + "</td><td>" + GrnList[i].DateCode + "</td>";
                    r += "</tr>";
                }
            }
            $("#tableGrnList tr:eq(0)").after(r);
        }
        //初始化调拨单
        function initTransfer() {
            //清空物料明细数据
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
            }
            //清空先进先出列表
            if ($("#tableGrnList tr").length > 1) {
                $("#tableGrnList tr:not(:first)").remove();
            }
            $("#showGrn").html("");
            $("#txtGRN").val("");
            $("#msg").html("");
            $("#woNo").text("");
            
            viewModel.curIndex =0;
            viewModel.transfer = {                                
                TransfersId: -1,
                TransfersNo: "",
                TransfersType: -1,
                SourceNo: "",
                InWhouseName: "",
                OutWhouseName: "",
            }
            viewModel.transferDtl =[];
            viewModel.curTransferDtl = null;
            viewModel.curScanGRNList = [];
            viewModel.transferDtlMaterial =[];
            viewModel.transferDtlMaterialNew = [];
            viewModel.scanGrns = [];
        }

        function setFirstItem(tdObj) {
            $("table").find("tr").css('background-color', '	#FFFFFF');
            $(tdObj).parent().insertAfter($("#tblRecHistory tr:eq(0)")).css('background-color', '#00FFFF');

            $("#tblRecHistory tr:gt(0)").each(function (j, obj) {
                $(this).children("td:eq(0)").html((j + 1));

            });
        }

        function Save() {
            if (!viewModel.isEnableTransfersStorage) {
                alert(Msg_Enable_TransfersStorage);
                return false;
            }
            if (viewModel.transferDtlMaterialNew.length ==0) {
                alert("请扫描要调拨的GRN!");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (viewModel.transfer.TransfersId ==-1) {
                alert("请先选择调拨单号!");
                return false;
            }

            if (confirm('是否确定调拨?')) {
                //保存记录
                var entity = {};
                entity.TransfersId = viewModel.transfer.TransfersId;
                entity.UserName = viewModel.userName;
                entity.EmployeeCName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
                entity.OpSource = 1;
                entity.TransferDtlMaterial = JSON.stringify(viewModel.transferDtlMaterialNew);
                //return;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveTransfer", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //获取最新的调拨GRN信息（用于并发控制）
                    if (!updateTransfersDtlMaterial()) return false;
                    //自动计算调拨明细数量
                    $.each(viewModel.transferDtl, function (i, o) {
                        autoComputeTranferDtlQty(o);
                    });
                    //更新UI
                    viewModel.curIndex = 0;
                    loadingItem();
                } else {
                    alert("调拨成功");
                    //清空界面
                    $("#txtReuestOrder").val("");
                    initTransfer();
                }
            }
        }
        //分料截料
        function openSplitMaterial() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialSplit.aspx?name=Material_MaterialSplit";
            dialog({ title: "分料截料", src: openWinUrl, width: 750, height: 400 });
        }

        //获取对应的调拨明细
        function getTransferDtl(id) {
            var entity = null;
            $.each(viewModel.transferDtl, function (i, o) {
                if (o.TransfersDtlId == id) {
                    entity = o;
                    return false;
                }
            });
            return entity;
        }

        //是否已扫描
        function isScanGRN(grn) {
            var result = false;
            $.each(viewModel.transferDtlMaterialNew, function (i, o) {
                if (grn == o.GRN) {
                    result = true;
                    return false;
                }
            });
            return result;
        }

        //是否已调拨出库
        function isTransferOutGRN(grn) {
            var result = false;
            $.each(viewModel.transferDtlMaterial, function (i, o) {
                if (grn == o.GRN) {
                    result = true;
                    return false;
                }
            });
            return result;
        }

        //选中明细行
        function selectedTransferDtlRow(id) {
            //设置当前行
            viewModel.curTransferDtl = getTransferDtl(id);
            //重置所有行样式
            var $tr = $("#tblRecHistory tr[data-id='" + viewModel.curTransferDtl.TransfersDtlId + "']");
            $("#tblRecHistory").find("[name='alist']").css("color", "blue");
            $("#tblRecHistory").find("tr").css('background-color', '#FFFFFF');
            //设置选中行样式
            $tr.find("[name='alist']").css("color", "red");
            $tr.css('background-color', '#00FFFF');
        }
        //清除当前调拨明细扫描的GRN
        function clearItemGrnList(id) {
            if (!confirm("确认清除?")) {
                return;
            }
            var tranferDtl = getTransferDtl(id);
            //处理实体
            for (var i = viewModel.transferDtlMaterialNew.length - 1; i >= 0; i--) {
                if (viewModel.transferDtlMaterialNew[i].TransfersDtlId == id) {
                    viewModel.transferDtlMaterialNew.splice(i, 1);
                }
            }

            if (tranferDtl != null) {
                //清除整行物料
                var entity = {};
                entity.Type = 1; //删除整行物料GRN
                entity.TransfersId = 0;
                entity.TransfersNo = "";
                entity.TransfersDtlId = id;
                entity.Grn = "";
                entity.QTY = 0;
                entity.InWhouse = "";
                entity.OutWhouse = "";
                entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspTransferGRNTemp", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                //更新UI
                var scan = $("#ScanQty" + tranferDtl.TransfersDtlId);
                scan.text("0");
            }


            //自动计算调拨明细数量
            autoComputeTranferDtlQty(tranferDtl);
            //更新UI
            //var ctrl = $("#td" + tranferDtl.TransfersDtlId);
            //var onPosQty = $("#onPosQty" + tranferDtl.TransfersDtlId);
            //ctrl.text(tranferDtl.FinishQty);
            //onPosQty.text(tranferDtl.OnPosQty);
            //setFirstItem(ctrl);
            //刷新先进先出
            SearchRule();
        }
        //清除指定的Grn集合
        function clearGrnList(list) {
            if (list && list.length > 0) {
                //处理实体
                var tranferDtl = null;
                for (var j = 0; j < list.length; j++) {
                    for (var i = viewModel.transferDtlMaterialNew.length - 1; i >= 0; i--) {
                        if (viewModel.transferDtlMaterialNew[i].GRN == list[j].GRN) {
                            if (!tranferDtl) {
                                tranferDtl = getTransferDtl(viewModel.transferDtlMaterialNew[i].TransfersDtlId);
                            }
                            viewModel.transferDtlMaterialNew.splice(i, 1);
                        }
                    }
                }

                if (tranferDtl != null) {
                    //清除已扫GRN
                    var entity = {};
                    entity.Type = 3; //删除GRN
                    entity.TransfersId = 0;
                    entity.TransfersNo = "";
                    entity.TransfersDtlId = 0;
                    entity.Grn = list[0].GRN;
                    entity.QTY = 0;
                    entity.InWhouse = "";
                    entity.OutWhouse = "";
                    entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspTransferGRNTemp", JSON.stringify(entity));
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    //更新UI
                    var scan = $("#ScanQty" + tranferDtl.TransfersDtlId);
                    scan.text(parseFloat(scan.text()) - list[0].BalanceQty);
                }

                //自动计算调拨明细数量
                autoComputeTranferDtlQty(tranferDtl);
                //更新UI
                //var ctrl = $("#td" + tranferDtl.TransfersDtlId);
                //var onPosQty = $("#onPosQty" + tranferDtl.TransfersDtlId);
                //ctrl.text(tranferDtl.FinishQty);
                //onPosQty.text(tranferDtl.OnPosQty);
                //setFirstItem(ctrl);
                //刷新先进先出
                SearchRule();
            }
        }

        //自动计算调拨明细数量
        function autoComputeTranferDtlQty(transferDtl) {
            var finishQty = 0;
            var onPosQty = 0;
            var arrGrn = [];
            $.each(viewModel.transferDtlMaterial, function (i, o) {
                if (arrGrn.indexOf(o.GRN) == -1 && o.TransfersDtlId == transferDtl.TransfersDtlId) {
                    if (o.IsOnShelf) {
                        onPosQty = onPosQty + o.BalanceQty * 1;
                    }
                    finishQty = finishQty + o.BalanceQty * 1;
                }
                arrGrn.push(o.GRN);
            });
            $.each(viewModel.transferDtlMaterialNew, function (i, o) {
                if (arrGrn.indexOf(o.GRN) == -1 && o.TransfersDtlId == transferDtl.TransfersDtlId) {
                    if (o.IsOnShelf) {
                        onPosQty = onPosQty + o.BalanceQty * 1;
                    }
                    finishQty = finishQty + o.BalanceQty * 1;
                }
                arrGrn.push(o.GRN);
            });
            transferDtl.FinishQty = finishQty;
            transferDtl.OnPosQty = onPosQty;
        }

        //获取最新的调拨GRN信息（用于并发控制）
        function updateTransfersDtlMaterial() {
            var entity = {};
            entity.TransfersNo = viewModel.transfer.TransfersNo;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetTransfersDtlMaterialByNo", JSON.stringify(entity));
            if (ajax.error != null) {
                confirmDialog(ajax.error.Message);
                return false;
            } else {
                viewModel.transferDtlMaterial = $.parseJSON(ajax.value).data;
                //同步已扫描的信息
                for (var i = viewModel.transferDtlMaterialNew.length - 1; i >= 0; i--) {
                    var transferDtlMaterial = getTransferDtlMaterial(viewModel.transferDtlMaterialNew[i].GRN);
                    if (transferDtlMaterial) {
                        viewModel.transferDtlMaterialNew.splice(i, 1);
                    }
                };
            }
            return true;
        }

        //获取已调拨的GRN
        function getTransferDtlMaterial(grn) {
            var entity = null;
            $.each(viewModel.transferDtlMaterial, function (i, o) {
                if (o.GRN == grn) {
                    entity = o;
                    return false;
                }
            });
            return entity;
        }


        //已扫描GRN
        function ScanMaterialGrn() {
            $.each(viewModel.scanGrns, function (i, o) {
                viewModel.transferDtlMaterialNew.push({
                    TransfersId: o.TransfersId,
                    TransfersDtlId: o.TransfersDtlId,
                    GRN: o.GRN,
                    IsOnShelf: false,
                    BalanceQty: o.QTY,
                    ValidInWhouse: o.InWhouse,
                    ValidOutWhouse: o.OutWhouse
                });

                //更新UI
                var ctrl = $("#td" + o.TransfersDtlId);
                ctrl.text(parseFloat(ctrl.text()) + o.QTY);
            });
        }

    </script>
</asp:Content>
