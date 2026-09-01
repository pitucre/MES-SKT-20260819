<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransferOut.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.TransferOut" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <title>调拨出库</title>
    <style type="text/css">
        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        table {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px !important;
            color: #1d1007;
        }

        .Bg-Red {
            background: red;
        }
        .Bg-Green2 {
            background:#99FF33;
        }
    </style>
</head>
<body <%--onscroll="alert(1);"--%>>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" class="receivepage" id="receivepage" style="overflow-x:hidden;overflow-y:auto;">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/Acc_w.png" />
                    </div>
                    <div>
                        调拨出库
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" id="content1">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label for="txtTransferNo">
                                调拨单号</label>
                        </td>
                        <td>
                            <input id="txtTransferNo" data-corners="false" type="text" data-mini="true"
                                value="" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="getTransferNo()">选择单据</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>来源单号</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtSourceNo" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" disabled="disabled" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>调入仓库</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtInWhouseName" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" disabled="disabled" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>调出仓库</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtOutWhouseName" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" disabled="disabled" />
                        </td>
                    </tr>
                    <tr id="grntr2">
                        <td>
                            <label>GRN条码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtGRN" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                            <div style="display: none">
                                <input type="text" id="txtPosCode" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase; display: none;" />
                            </div>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <table data-role="table" id="tbTransferItem" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%; word-break: break-all;">
                    <thead>
                        <tr>
                            <th style="padding-left: 11px">物料编码
                            </th>
                            <th>物料名称
                            </th>
                            <th>调入仓
                            </th>
                            <th>调出仓
                            </th>
                            <th>调拨数量
                            </th>
                            <th>已调拨数量
                            </th>
                            <th>扫描数量
                            </th>
                            <th>操作
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                 <div data-role="popup" id="popupGrnLog">
                    <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">关闭</a>
                    <table data-role="table" id="tbGrnLog" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="word-break: break-all;">
                        <thead style="background-color:#2FC1FF">
                            <tr>
                                <th>序号
                                </th>
                                <th>物料条码
                                </th>
                                <th style="min-width:40px">数量
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtn" data-theme="f" value="确认调拨" /></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">
                  <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="选择调拨单"
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            
            var viewModel = {
                userId: "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>",
                userName: "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>",
                isEnableTransfersStorage: true,             //是否启用调拨出库，默认启用
                FIFO: "-1",                                 //是否启用先进先出
                curIndex: 0,

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
                curScanGRNList:[],                          //当前扫描的GRN列表
                transferDtlMaterial: [],                    //调拨单明细物料对应
                transferDtlMaterialNew: [],                 //新增的
                trGrnNoData: '<tr class="ListTableOddRow"><td colspan="3" style="text-align: center;">暂无数据</td></tr>',
                trItemNoData: '<tr class="ListTableOddRow"><td colspan="7" style="text-align: center;">暂无数据</td></tr>',
                scanGrns: [],//已扫GRN
            };
            var Msg_Enable_TransfersStorage = "不需要调拨出库,请知悉!";

            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("#orderno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                $("#txtTransferNo,#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                //是否启用调拨出库
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfigByConfigType("23");
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                }
                else {
                    var entity = ajax.value;
                    if (entity && entity.ConfigResult == "2") {
                        viewModel.isEnableTransfersStorage = false;
                    }
                }
                //是否启用调拨出库
                if (!viewModel.isEnableTransfersStorage) {
                    $("#showOrderNo").text(Msg_Enable_TransfersStorage).css("color", "red");
                    $("#showOrderNo").attr("href", "javascript:void(0);");
                    return false;
                }
                //是否配置先进先出
                var mark = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.CheckUserIsWarranttedPda(viewModel.userId).value;
                if (mark) {
                    viewModel.FIFO = "1";
                }
                //筛选调拨单号
                $("#btnFilter").on("click", function () {
                    val = $.trim($("#fpanel input[data-type='search']").first().val());
                    if (val == "") {
                        confirmDialogFocus("请输入单据！", function () { $("input[data-type='search']:eq(0)").select(); });
                        return false;
                    }
                    searchTransfer(val);
                });

                //扫描调拨单事件
                $("#txtTransferNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        getTransferDetailInfo(null, 0);
                        ScanMaterialGrn();
                    }
                });
                //滚动加载数据
                $(document).scroll(function () {
                    var scrollTop = $(document).scrollTop() + $(window).height() + 100;
                    var scrollHeight = $(document).height();

                    if (scrollTop >= scrollHeight) {
                        showRoDetail();
                    }
                });
            });

            //搜索、筛选调拨单号
            function searchTransfer(transferNo) {
                $("#listviews").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.GetTransfesOrderList(transferNo, 1);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message).css("color", "red");
                    return false;
                }
                var list = ajax.value;
                var ulhtml = "";
                var ro;//调拨单号
                for (var i = 0; i < list.length; i++) {
                    ro = list[i].TransfersNo;
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getTransferDetailInfo(" + (JSON.stringify(list[i])) + ",1)' id='" + list[i].TransfersId + "' data-SourceNo='" + list[i].SourceNo + "' data-InWhouseName='" + list[i].InWhouseName + "' data-OutWhouseName='" + list[i].OutWhouseName + "' >" + ro + "</a></li>";
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            }

            //获取扫描明细信息  type 0：扫描 1：选择单据
            function getTransferDetailInfo(entity, type) {
                showMsg("", 1);
                if (type == 0) {
                    //扫描
                    var transferNo = $.trim($("#txtTransferNo").val());
                    if (transferNo == "") {
                        showMsg("请输入调拨单号", 0);
                        $("#txtTransferNo").val("").focus();
                        return;
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.GetTransfesOrderList(transferNo, 0);
                    if (ajax.error != null) {
                        showMsg("获取调拨单信息失败：" + ajax.error.Message, 0);
                        return;
                    }
                    var list = ajax.value;
                    if (!list || !list[0] || !list[0].TransfersNo) {
                        showMsg("未获取到待调拨的调拨单信息", 0);
                        return;
                    }
                    entity = list[0];
                } else {
                    //选择单据后，获取GRN信息
                    $("input[data-type='search']").val('');
                    $("#listviews").html('');
                    $("#fpanel").panel("close");
                }

                //加载已扫GRN信息
                SetOrderCode(entity);
                $("#txtGRN").focus();
            }

            function SetOrderCode(entity) {
                //初始化数据
                init();
                //选中的调拨单
                viewModel.transfer.TransfersId = entity.TransfersId;
                viewModel.transfer.TransfersNo = entity.TransfersNo;
                viewModel.transfer.SourceNo = entity.SourceNo;
                viewModel.transfer.InWhouseName = entity.InWhouseName;
                viewModel.transfer.OutWhouseName = entity.OutWhouseName;
                //绑定调拨单
                $("#txtTransferNo").val(entity.TransfersNo);
                $("#msg").html("").removeClass("Bg-Red");
                $("#showOrderNo").html(viewModel.transfer.TransfersNo);
                $("#txtSourceNo").val(viewModel.transfer.SourceNo);//源单号
                $("#txtInWhouseName").val(viewModel.transfer.InWhouseName);//调入仓库
                $("#txtOutWhouseName").val(viewModel.transfer.OutWhouseName);//调出仓库
                $("#fpanel").panel("close");
                //调拨单明细
                var entity = {};
                entity.TransfersNo = viewModel.transfer.TransfersNo;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetTransfersItemByNo", JSON.stringify(entity));

                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                } else {
                    var dataList = JSON.parse(ajax.value);
                    viewModel.transferDtl = dataList.data;
                    viewModel.transferDtlMaterial = dataList.data1;
                    viewModel.scanGrns = dataList.data2;
                    showRoDetail();
                }
            }

            //扫描GRN
            $("#txtGRN").on("keydown", function (e) {
                var c = curkey = 0, e = e || window.event;
                curkey = e.keyCode || e.which || e.charCode;
                var grn = $.trim($("#txtGRN").val());
                if (curkey == 13) {
                    $("#msg").html("").removeClass("Bg-Red");
                    if (viewModel.transfer.TransfersNo == "") {
                        confirmDialog("请选择调拨单！");
                        return false;
                    }

                    if (grn == "") {
                        confirmDialog("GRN不能为空！");
                        return false;
                    }
                    debugger
                    //获取GRN的仓库信息
                    var entity = {};
                    entity.GRN = grn;
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetMaterialInfoByGRN", JSON.stringify(entity));
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        return false;
                    }
                    var listGrnInfo = $.parseJSON(ajax.value).data;
                    if (!listGrnInfo || listGrnInfo.length == 0) {
                        $("#msg").html("未找到GRN信息！").css("color", "red");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                    viewModel.curScanGRNList = listGrnInfo;
                    //是否已调拨
                    if (isTransferOutGRN(listGrnInfo[0].GRN)) {
                        $("#msg").html("[" + grn + "]该条码已经调拨出库，不能重复调拨！").css("color", "red");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                    //是否已扫描
                    if (isScanGRN(listGrnInfo[0].GRN)) {
                        if (confirm("该物料条码【" + grn + "】已扫描，是否清除重新扫描？")) {
                            clearGrnList(listGrnInfo);
                            $("#msg").html("该物料条码[" + grn + "]清理完成！").css("color", "green");
                            $("#txtGRN").val("");
                            $("#txtGRN").focus();
                        }
                        else {
                            $("#msg").html("该物料条码[" + grn + "]已扫描！").css("color", "red");
                            $("#txtGRN").focus();
                            $("#txtGRN").select();
                        }
                        return false;
                    }
                    //自动匹配调拨单明细
                    if (!autoMatchTransferDtl(grn)) return false;

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
                    entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckTransfersGrn", JSON.stringify(entity));
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                    //先进先出
                    if (grnResult != undefined && grnResult.length > 0 && grnResult[0].Flage == 0) {
                        if (viewModel.FIFO !== "1") {     //配置了先进先出
                            confirmDialog(grnResult[0].Msg + "。请按照先进先出原则备料！");
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
                    var grnResult = $.parseJSON(ajax.value).data;
                    if (!grnResult || grnResult.length == 0) {
                        confirmDialog("数据异常,请稍后再试！");
                        return false;
                    }
                    //自动解除包装
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

                    //获取GRN或包装箱数量
                    var sumQty = 0;
                    for (var i = 0; i < grnResult.length; i++) {
                        sumQty = sumQty + grnResult[i].BalanceQty * 1;
                    }

                    //记录已扫GRN
                    var entity = {};
                    entity.Type = 0; //插入
                    entity.TransfersId = viewModel.curTransferDtl.TransfersId; //调拨单ID
                    entity.TransfersNo = $("#txtTransferNo").val();
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
                            GRN: o.SerialNumber,
                            IsOnShelf: false,
                            BalanceQty: o.BalanceQty * 1,
                            ValidInWhouse: viewModel.curTransferDtl.ValidInWhouse,
                            ValidOutWhouse: viewModel.curTransferDtl.ValidOutWhouse
                        });
                    });
                    
                    //获取最新的调拨GRN信息（用于并发控制）
                    if (!updateTransfersDtlMaterial()) return false;
                    //更新数量
                    if (!updateTransferQty()) return false;
                    //设置选中行
                    selectedTransferDtlRow(viewModel.curTransferDtl.TransfersDtlId);
                    $("#msg").html("该GRN[" + grn + "]扫描成功！").css("color", "green");
                    $("#txtGRN").val('')
                    $("#txtGRN").focus();
                    return true;
                }
            });
            //确认调拨
            $("#Savebtn").on("click", function () {
                Save();
            });

            //检查GRN
            function checkGrn(grn) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.CheckGrnTransfer(viewModel.transfer.TransfersId, viewModel.curTransferDtl.TransfersDtlId, grn);
                if (ajax.value === '') return false;
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }

                var grnResult = JSON.parse(ajax.value);
                return grnResult;
            }

            //显示GRN扫描记录表
            function showGrnList(element) {
                var id = $(element).parents("tr.ItemRow").attr("data-id");
                //设置选中
                selectedTransferDtlRow(id);
                //调拨单关联的GRN列表
                var list = [];
                var listGRN = [];
                $.each(viewModel.transferDtlMaterial, function (i, o) {
                    if (o.TransfersDtlId == id) {
                        list.push(o);
                        listGRN.push(o.GRN)
                    }
                });
                $.each(viewModel.transferDtlMaterialNew, function (i, o) {
                    if (o.TransfersDtlId == id && listGRN.indexOf(o.GRN) == -1) {
                        list.push(o);
                        listGRN.push(o.GRN);
                    }
                });
                //重置UI
                $("#tbGrnLog tbody tr").remove();
                //显示UI
                if (!list || list.length == 0) {
                    $("#tbGrnLog tbody").append(viewModel.trGrnNoData);
                    return false;
                }
                //显示UI
                if (!list || list.length == 0) {
                    return false;
                }
                var html = "";
                for (var i = 0; i < list.length; i++) {
                    var grn = list[i].GRN;
                    var itemCode = list[i].ItemCode;

                    html += "<tr class='ListTableOddRow GrnRow Bg-Green2'>";
                    html += "<td class=''>" + (i + 1) + "</td>";
                    html += "<td class=''>" + grn + "</td>";
                    html += "<td class=''>" + parseInt(list[i].BalanceQty) + "</td>";
                    html += "</tr>";
                }
                $("#tbGrnLog tbody").append(html);
            }

            //显示调拨单明细信息表格
            function showRoDetail() {
                //是否重新加载
                if (viewModel.curIndex == 0) {
                    $("#tbTransferItem tbody tr").remove();
                }
                var listDetail = viewModel.transferDtl;
                if (!listDetail || listDetail.length == 0) {
                    $("#tbTransferItem tbody").append(viewModel.trItemNoData);
                    return false;
                }

                var html = '';
                var listNum = (viewModel.curIndex + 30 > listDetail.length) ? listDetail.length : viewModel.curIndex + 30;
                 
                for (var i = viewModel.curIndex; i < listNum; i++) {

                    var itemCode = listDetail[i].ItemCode || '';
                    var itemName = listDetail[i].ItemName || '';
                    var applyQty = listDetail[i].ApplyQty || '0';
                    var finishQty = listDetail[i].FinishQty || '0';
                    html += "<tr class='ListTableOddRow ItemRow' data-id='" + listDetail[i].TransfersDtlId + "'>";
                    html += "<td class='itemCode'>" + itemCode + "</td>";
                    html += "<td>" + itemName + "</td>";
                    html += "<td>" + listDetail[i].InWhouse + "</td>";
                    html += "<td>" + listDetail[i].OutWhouse + "</td>";
                    html += "<td class='applyQty'><span>" + applyQty + "</span></td>";
                    html += "<td class='finishQty'><span id='td" + listDetail[i].TransfersDtlId + "'>" + finishQty + "</span><span align='center'>&nbsp;<a href='#popupGrnLog' data-rel='popup' data-position-to='window' onclick='showGrnList(this)'>记录</a></span></td>";
                    html += "<td  id='ScanQty" + listDetail[i].TransfersDtlId + "' name='ScanQty'>" + listDetail[i].ScanQty + "</td>";
                    html += "<td><a href='javascript:void(0)' onclick='clearItemGrnList(" + listDetail[i].TransfersDtlId + ")'>清除</a></td>";
                    html += "</tr>";

                    viewModel.curIndex++;
                }
                if ($("#tbTransferItem tbody tr").length === 0) {
                    $("#tbTransferItem tbody").append(html);
                }
                else {
                    $("#tbTransferItem tbody tr:last").after(html);
                }
            }

            //确认调拨
            function Save() {
                //是否启用调拨出库
                if (!viewModel.isEnableTransfersStorage) {
                    confirmDialog(Msg_Enable_TransfersStorage);
                    return false;
                }
                if (viewModel.transfer.TransfersId == -1) {
                    confirmDialog("请先选择调拨单号!");
                    return false;
                }
                if (viewModel.transferDtlMaterialNew.length == 0) {
                    confirmDialog("请扫描要调拨的GRN!");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                if (!confirm('是否确认调拨?')) {
                    return false;
                }
                var entity = {};
                entity.TransfersId = viewModel.transfer.TransfersId;
                entity.UserName = viewModel.userName;
                entity.EmployeeCName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
                entity.OpSource = 2;    //操作来源（1:PC 2:PDA）
                entity.TransferDtlMaterial = JSON.stringify(viewModel.transferDtlMaterialNew);
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveTransfer", JSON.stringify(entity));
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    //获取最新的调拨GRN信息（用于并发控制）
                    if (!updateTransfersDtlMaterial()) return false;
                    //自动计算调拨明细数量
                    $.each(viewModel.transferDtl, function (i, o) {
                        autoComputeTranferDtlQty(o);
                    });
                    //重新更新UI
                    viewModel.curIndex = 0;
                    showRoDetail();
                    return false;
                }
                $("#msg").html("调拨成功！").css("color", "#2ecc71");
                init();
                return true;
            }
            //获取对应的调拨明细列表
            function getTransferDtlList(itemCode) {
                var list = [];
                $.each(viewModel.transferDtl, function (i, o) {
                    if (o.ItemCode == itemCode) {
                        list.push(o);
                    }
                });
                return list;
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

            //自动匹配调拨单明细
            function autoMatchTransferDtl(grn) {

                var listGrnInfo = viewModel.curScanGRNList;
                //验证调拨明细仓库
                var list = getTransferDtlList(listGrnInfo[0].ItemCode);
                var listOut = [];
                if (!list || list.length == 0) {
                    $("#msg").html("该GRN的物料编码[" + listGrnInfo[0].ItemCode + "]，不在本次调拨中！").css("color", "red");
                    return false;
                }
                //匹配调出仓库
                $.each(list, function (i, o) {
                    if (listGrnInfo[0].CWhCode == o.ValidOutWhouse) {
                        listOut.push(o);
                    }
                });
                if (!listGrnInfo[0].CWhCode) {
                    $("#msg").html("只能扫描在仓库的物料").css("color", "red");
                    return false;
                }
                if (listOut.length == 0) {
                    $("#msg").html("扫描的GRN[" + grn + "],所在仓库为[" + listGrnInfo[0].CWhCode + "]，与调出仓不一致，请重新扫描").css("color", "red");
                    return false;
                }
                //数量验证
                var msg = "";
                var grnQty = 0;

                $.each(listGrnInfo, function (i, o) {
                    grnQty += o.BalanceQty * 1;
                });

                viewModel.curTransferDtl = null;
                if (listOut.length == 0) {
                    confirmDialog('未找到当前扫描的GRN对应的调拨明细！');
                    return false;
                }
                for (var i = 0; i < listOut.length; i++) {
                    msg = checkScanQty(listOut[i], grnQty);
                    if (msg == "") {
                        viewModel.curTransferDtl = listOut[i];
                        break;
                    }
                }
                if (msg != "") {
                    $("#msg").html(msg).css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                return true;
            }

            //选中当前明细行
            function selectedTransferDtlRow(id) {
                //设置当前行
                viewModel.curTransferDtl = getTransferDtl(id);
                //设置样式
                $("#tbTransferItem tr.ItemRow").each(function (i, o) {
                    var transferDtlId = $(o).attr("data-id");
                    if (transferDtlId == viewModel.curTransferDtl.TransfersDtlId) {
                        $(o).addClass("Bg-Green2");
                    }
                    else {
                        $(o).removeClass("Bg-Green2");
                    }
                });
            }

            //校验扫描GRN数量
            function checkScanQty(transferDtl, grnQty) {
                var msg = "";
                grnQty = grnQty * 1;                        //GRN物料的数量
                var applyQty = transferDtl.ApplyQty * 1;    //申请数量
                var finishQty = transferDtl.FinishQty * 1;  //调拨数量
                var itemCode = transferDtl.itemCode;

                if (finishQty + grnQty > applyQty) {
                    msg = "该物料[" + transferDtl.ItemCode + "]调拨出库扫描的数量[" + (finishQty + grnQty) + "]不能大于申请数量[" + applyQty + "]！";
                }
                return msg;
            }

            //更新数量
            function updateTransferQty() {
                //自动计算调拨明细数量
                autoComputeTranferDtlQty(viewModel.curTransferDtl);
                //更新UI
                updateItemUI(viewModel.curTransferDtl);
                return true;
            }

            //初始化
            function init() {
                //UI初始化
                $("#tbGrnLog tbody tr").remove();
                $("#tbGrnLog tbody").append(viewModel.trGrnNoData);
                $("#tbTransferItem tbody tr").remove();
                $("#tbTransferItem tbody").append(viewModel.trItemNoData);
                $("#txtGRN").val('');
                $("#txtSourceNo").val('');
                $("#txtInWhouseName").val('');
                $("#txtOutWhouseName").val('');
                $("#txtTransferNo").val("").focus();
                //数据初始化
                viewModel.transfer = {
                    TransfersId: -1,
                    TransfersNo: "",
                    SourceNo: "",
                    InWhouseName: "",
                    OutWhouseName: "",
                };
                viewModel.transferDtl = [];
                viewModel.transferDtlMaterial = [];
                viewModel.transferDtlMaterialNew = [];
                viewModel.transferInShelfGRN = [];
                viewModel.curTransferDtl = null;
                viewModel.curScanGRNList = [];
                viewModel.curIndex = 0;
                viewModel.scanGrns = [];
            }

            //清除当前调拨明细扫描的GRN
            function clearItemGrnList(id) {
                if (!confirm("确认清除?")) {
                    return;
                }
                //设置选中
                selectedTransferDtlRow(id);
                //处理实体
                var tranferDtl = getTransferDtl(id);
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
                updateItemUI(tranferDtl);
                //
                $("#msg").html("清理完成！").css("color", "green");
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
                    updateItemUI(tranferDtl);
                }
            }

            //更新明细项UI
            function updateItemUI(tranferDtl) {
                return false;
                var applyQty = tranferDtl.ApplyQty || '0';
                var finishQty = tranferDtl.FinishQty || '0';
                var $row = null;
                $.each($("#tbTransferItem tr.ItemRow"), function (i, o) {
                    var id = $(o).attr("data-id");
                    if (id == tranferDtl.TransfersDtlId) {
                        $row = $(o);
                        return false;
                    }
                });
                if ($row) {
                    $row.children(".finishQty").children(":eq(0)").text(finishQty + "\/" + applyQty);
                    $row.fadeOut(500).fadeIn(500);
                }
            }

            //显示消息 type 1:成功 0：失败
            function showMsg(msg, type) {
                $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
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
                   // var ctrl = $("#td" + o.TransfersDtlId);
                   // ctrl.text(parseFloat(ctrl.text()) + o.QTY);
                });
            }

        </script>
    </form>
</body>
</html>
