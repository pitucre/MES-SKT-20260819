<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransferIn.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.TransferIn" %>

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
    <title>调拨入库</title>
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
                        调拨入库
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
                            <label>库位条码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtPosCode" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>GRN条码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtGRN" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
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
                            <th>客户料号
                            </th>
                            <th>调入仓库
                            </th>
                            <th>调出数量
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
                    <table data-role="table" id="tbGrnLog" data-mode="columntoggle" class="ui-responsive table-stroke" style="word-break: break-all;">
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
                curIndex: 0,                                 //用于加载更多的表格数据的全局下标

                transfer: {                                 //调拨单主表
                    TransfersId: -1,
                    TransfersNo: "",
                    SourceNo: "",
                    InWhouseName: "",
                    OutWhouseName: "",
                },
                transferDtl: [],                            //调拨单明细
                curTransferDtl: null,
                curScanGRNList:[],                          //当前扫描的GRN列表
                transferDtlMaterial: [],                    //调拨单明细物料对应
                transferDtlMaterialNew: [],                 //新增的
                transferInShelfGRN: [],                      //入库上架的GRN                       
                isEnableTransfersStorage: true,             //是否启用调料出库
                FIFO: -1,                                   //是否有先进先出
                trGrnNoData: '<tr class="ListTableOddRow"><td colspan="3" style="text-align: center;">暂无数据</td></tr>',
                trItemNoData: '<tr class="ListTableOddRow"><td colspan="6" style="text-align: center;">暂无数据</td></tr>',
            };

            $(function () {
                //隐藏columntoggle列表按钮
                $(".ui-body-c").css("background", "#fff");
                $(".ui-table-columntoggle-btn").css("display", "none");
                $("#txtTransferNo").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                //处理事件
                $("#txtPosCode").blur(function () {
                    $(this).css("background-color", "white")
                }).focus(function () {
                    $(this).css("background-color", "#FFFFCC").select()
                });

                $("#txtGRN").blur(function () {
                    $(this).css("background-color", "white")
                }).focus(function () {
                    $(this).css("background-color", "#FFFFCC").select()
                });
                //确认调拨
                $("#Savebtn").on("click", function () {     
                    Save();
                });
                //扫描调拨单事件
                $("#txtTransferNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        getTransferDetailInfo(null, 0);
                    }
                });
                //筛选
                $("#btnFilter").on("click", function () {
                    val = $.trim($("#fpanel input[data-type='search']").first().val());
                    if (val == "") {
                        confirmDialogFocus("请输入单据！", function () { $("input[data-type='search']:eq(0)").select(); });
                        return false;
                    }
                    searchTransfer(val);
                });
                //滚动加载更多
                $(document).scroll(function () {
                    var scrollTop = $(document).scrollTop() + $(window).height() + 100;
                    var scrollHeight = $(document).height();

                    if (scrollTop >= scrollHeight) {
                        showRoDetail();
                    }
                });
                //是否启用调料出库
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
                //是否配置了“先进先出原则”
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.CheckUserIsWarrantted(viewModel.userId);
                if (ajax.value) {
                    viewModel.FIFO = "1";
                }
                else {
                    //无
                    viewModel.FIFO = "-1";
                }
            });
            
            //根据字符串模糊查询调拨单
            function getTransferNo() {
                $("#listviews").listview("refresh");
            }
            //获取调拨单
            function searchTransfer(transferNo) {
                $("#listviews").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.GetTransfesOrderInList(transferNo, 1);
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
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.GetTransfesOrderInList(transferNo, 0);
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
                $("#txtPosCode").focus();
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
                $("#txtSourceNo").val(viewModel.transfer.SourceNo);//源单号
                $("#txtInWhouseName").val('');
                $("#fpanel").panel("close");
                //调拨单明细
                var entity = {};
                entity.TransfersNo = viewModel.transfer.TransfersNo;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetTransfersInItemByNo", JSON.stringify(entity));

                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                } else {
                    var dataList = JSON.parse(ajax.value);
                    viewModel.transferDtl = dataList.data;
                    viewModel.transferDtlMaterial = dataList.data1;
                    showRoDetail();
                }
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
                    var CPN = listDetail[i].CPN || '';
                    var InWhouseName = listDetail[i].ValidInWhouseName || '';
                    var applyQty = listDetail[i].ApplyQty || '0';
                    var finishQty = listDetail[i].FinishQty || '0';
                    var onPosQty = listDetail[i].OnPosQty || '0';
                    var stockQty = viewModel.isEnableTransfersStorage ? finishQty : applyQty;     //规则：启用调拨出库（调出数量），不启用（申请数量）
                    html += "<tr class='ListTableOddRow ItemRow' data-id='" + listDetail[i].TransfersDtlId + "'>";
                    html += "<td class='itemCode'>" + itemCode + "</td>";
                    html += "<td>" + CPN + "</td>";
                    html += "<td>" + InWhouseName + "</td>";
                    html += "<td class='storeQty'>" + onPosQty + "/" + stockQty + "</td>";
                    html += "<td class='onPosQty'><span>" + onPosQty + "</span><span align='center'>&nbsp;<a href='#popupGrnLog' data-rel='popup' data-position-to='window' onclick='showGrnList(this)'>记录</a></span></td>";
                    html += "<td class='opDel'><span align='center'><a href='javascript:void(0)' onclick='clearItemGrnList("+ listDetail[i].TransfersDtlId +")'>清除</a></span></td>";
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

            /*扫描库位条码*/
            $("#txtPosCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    //验证库位条码是否正确
                    if (!changeBarCode($.trim($("#txtPosCode").val()))) {
                        $("#txtPosCode").val("");
                        $("#txtPosCode").focus();
                        $("#txtPosCode").select();
                        return false;
                    }
                        
                    $("#txtGRN").focus();
                    $("#msg").html("【" + $("#txtPosCode").val() + "】调入库位条码扫描成功！");
                    $("#msg").css("color", "green");

                }
            });
            //扫描GRN
            $("#txtGRN").on("keydown", function (e) {
                var c = curkey = 0, e = e || window.event;
                curkey = e.keyCode || e.which || e.charCode;
                var grn = $.trim($("#txtGRN").val());
                var posCode = $.trim($("#txtPosCode").val());
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

                    if (posCode == "") {
                        confirmDialog("请先扫描库位条码！");
                        $("#txtPosCode").focus();
                        return false;
                    }
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
                    //是否启用调拨出库
                    if (viewModel.isEnableTransfersStorage) {
                        //获取已调拨的GRN
                        var transferDtlMaterial = getTransferDtlMaterial(listGrnInfo[0].GRN);
                        if (transferDtlMaterial) {
                            //校验入库上架
                            if (!checkTransferInShelf(grn, transferDtlMaterial)) return false;
                        }
                        else {
                            $("#msg").html("该物料条码[" + grn + "]未调拨出库！").css("color", "red");
                            $("#txtGRN").select();
                            return false;
                        }
                    }
                    else {
                        //获取已调拨的GRN
                        var transferDtlMaterial = getTransferDtlMaterial(listGrnInfo[0].GRN);
                        if (transferDtlMaterial) {
                            viewModel.curTransferDtl = transferDtlMaterial;
                            //校验入库上架
                            if (!checkTransferInShelf(grn, transferDtlMaterial)) return false;
                        }
                        else {
                            //校验调拨出库入库
                            if (!checkTransfer(grn)) return false;
                        }
                    }
                    //获取最新的调拨GRN信息（用于并发控制）
                    if (!updateTransfersDtlMaterial()) return false;
                    //更新数量
                    updateTransferQty();
                    //选中明细行
                    selectedTransferDtlRow(viewModel.curTransferDtl.TransfersDtlId);
                    //显示当前明细对应的调入仓库
                    $("#txtInWhouseName").val(viewModel.curTransferDtl.ValidInWhouseName);
                    
                    $("#msg").html("该物料条码[" + grn + "]扫描成功！").css("color", "green");
                    $("#txtGRN").val('');
                    $("#txtGRN").focus();
                    return true;
                }
            });

            //验证库位
            function changeBarCode(wh) {
                if (viewModel.transfer.TransfersNo == "") {
                    confirmDialog("请先选择调拨单号!");
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(wh);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                var en = $.parseJSON(ajax.value);
                if (!en.BarCode) {
                    $("#msg").html("不存在库位条码【" + wh + "】！").css("color", "red");
                    $("#txtPosCode").select();
                    return false;
                }
                else {
                    $("#txtGRN").focus();

                }
                return true;
            }

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

            //更新数量
            function updateTransferQty() {
                //自动计算调拨明细数量
                autoComputeTranferDtlQty(viewModel.curTransferDtl);
                //更新UI
                updateItemUI(viewModel.curTransferDtl);
            }

            //确认调拨
            function Save() {
                if (viewModel.transfer.TransfersId == -1) {
                    confirmDialog("请先选择调拨单号!");
                    return false;
                }
                if (viewModel.transferInShelfGRN.length === 0) {
                    confirmDialog('请扫描要调拨的GRN', function () {
                        $("#txtGRN").focus();
                    });
                    return false;
                }
                if (!confirm('是否确认调拨?')) {
                    return false;
                }
                //调拨明细表更新数量
                var transferDtlQty = [];
                $.each(viewModel.transferDtl, function (i, o) {
                    transferDtlQty.push({
                        TransfersDtlId: parseInt(o.TransfersDtlId),
                        ApplyQty: o.ApplyQty * 1,
                        FinishQty: o.FinishQty * 1,
                        OnPosQty: o.OnPosQty * 1,
                    });
                });
                var entity = {};
                entity.TransfersId = viewModel.transfer.TransfersId;
                entity.TransfersNo = viewModel.transfer.TransfersNo;
                entity.UserName = viewModel.userName;
                entity.TransferDtlMaterial = JSON.stringify(viewModel.transferDtlMaterialNew);
                entity.TransferInShelfGRN = JSON.stringify(viewModel.transferInShelfGRN);
                
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.PDASaveTransferIn(entity.TransfersId, entity.TransfersNo, entity.UserName, entity.TransferDtlMaterial, entity.TransferInShelfGRN)
                //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveTransferIn", JSON.stringify(entity));
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

            //校验货位产品唯一
            function verifyProductOnly(cBarCode, itemCode) {
                var array = []; 
                var list = viewModel.transferInShelfGRN;
                //当前正在扫描的GRN的物料编码(无该参数则校验已扫描的GRN)
                if (itemCode) {
                    array.push(itemCode);
                }
                //去重复
                if (list && list.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        //相同的库位（多个库位条码调拨时处理）
                        if (list[i].CBarCode == cBarCode) {
                            if (array.indexOf(list[i].ItemCode) === -1) {
                                array.push(list[i].ItemCode)
                            }
                        }
                    }
                }
                //校验
                if (array.length > 0) {
                    if (array.length == 1) {
                        var result = isItemCanPlacedInWarehouseLocation("", array[0], cBarCode);
                        if (result == -1) {
                            return false;
                        }
                        if (result == 0) {
                            confirmDialog("当前库位不支持存放多种产品，请扫描其他库位！");
                            $("#txtPosCode").val("").focus();
                            return false;
                        }
                    }
                    else {
                        var isProductOnly = isItemCanPlacedInWarehouseLocation("", "", cBarCode);
                        if (isProductOnly == -1) {
                            return false;
                        }
                        if (isProductOnly == 1) {
                            confirmDialog("当前库位不支持存放多种产品，请扫描其他库位！");
                            $("#txtPosCode").val("").focus();
                            return false;
                        }
                    }
                }
                return true;
            }

            //判断产品是否能放入当前库位
            function isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return -1;
                }
                return ajax.value ? 1 : 0;
            }
            
            //是否已扫描
            function isScanGRN(grn) {
                var result = false;
                $.each(viewModel.transferInShelfGRN, function (i, o) {
                    if (grn == o.GRN) {
                        result = true;
                        return false;
                    }
                });
                return result;
            }

            //校验入库上架（已调拨出库）
            function checkTransferInShelf(grn, transferDtlMaterial) {
                var posCode = $.trim($("#txtPosCode").val());
                if (transferDtlMaterial.IsOnShelf) {
                    $("#msg").html("该物料条码[" + grn + "]已入库位！").css("color", "red");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    return false;
                }
                else {
                    //校验库位条码是否有效
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(posCode);
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        return false;
                    }
                    var result = $.parseJSON(ajax.value);
                    if (!result.BarCode) {
                        $("#msg").html("不存在库位条码【" + posCode + "】！");
                        $("#msg").css("color", "red");
                        return false;
                    }
                    //校验GRN的扫描的库位条码是否符合调拨明细的调入仓库
                    viewModel.curTransferDtl = getTransferDtl(transferDtlMaterial.TransfersDtlId);
                    if (viewModel.curTransferDtl && viewModel.curTransferDtl.ValidInWhouse != result.CWhCode) {
                        $("#msg").html("扫描的库位条码[" + posCode + "],所在仓库为[" + result.CWhCode + "']，与调拨单调入仓库[" + viewModel.curTransferDtl.ValidInWhouse + "]不符!").css("color", "red");
                        $("#txtPosCode").val("");
                        $("#txtPosCode").focus();
                        return false;
                    }
                    //校验GRN
                    var entity = {};
                    entity.TransfersId = transferDtlMaterial.TransfersId; 
                    entity.TransfersDtlId = transferDtlMaterial.TransfersDtlId; 
                    entity.Grn = grn;
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckTransfersInGrn_OutOfStock", JSON.stringify(entity));
                    if (ajax.error != null) {
                        confirmDialogFocus(ajax.error.Message, function () { $("#txtGRN").focus(); });
                        return false;
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
                    //校验数量
                    var qty = 0;
                    $.each(grnResult, function (i, o) {
                        qty += o.BalanceQty * 1;
                    });
                    var msg = checkScanQty(viewModel.curTransferDtl, qty);
                    if (!msg == "") {
                        confirmDialog(msg);
                        return false;
                    }
                    //校验库位的产品唯一
                    if (!verifyProductOnly(posCode, transferDtlMaterial.ItemCode)) return false;
                    //更新实体
                    $.each(grnResult, function (i, o) {
                        var entity = getTransferDtlMaterial(o.SerialNumber);
                        if (entity) {
                            entity.IsOnShelf = true;
                        }
                        viewModel.transferInShelfGRN.push({
                            TransfersDtlId: transferDtlMaterial.TransfersDtlId,
                            GRN: o.SerialNumber,
                            CBarCode: posCode,
                            ItemCode: o.ItemCode,
                            BalanceQty: o.BalanceQty,
                            IsTransferOut: true
                        });
                    });
                }
                return true;
            }

            //校验调拨出库入库（未调拨出库）
            function checkTransfer(grn) {

                var posCode = $.trim($("#txtPosCode").val());
                //自动匹配调拨单明细
                if (!autoMatchTransferDtl(grn, posCode)) return false;
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
                entity.TransfersId = viewModel.transfer.TransfersId; 
                entity.TransfersDtlId = viewModel.curTransferDtl.TransfersDtlId; 
                entity.Grn = grn;
                entity.GrnStr = grnStr;
                entity.IsTransferIn = true;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckTransfersGrn", JSON.stringify(entity));
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message, function () { $("#txtGRN").focus(); });
                    return false;
                }
                var grnResult = $.parseJSON(ajax.value).data;
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
                //校验库位的产品唯一
                if (!verifyProductOnly(posCode, grnResult[0].ItemCode)) return false;
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
                //更新实体
                $.each(grnResult, function (i, o) {
                    //入库上架GRN
                    viewModel.transferInShelfGRN.push({
                        TransfersDtlId: viewModel.curTransferDtl.TransfersDtlId,
                        GRN: o.SerialNumber,
                        CBarCode: posCode,
                        ItemCode: o.ItemCode,
                        BalanceQty: o.BalanceQty,
                        IsTransferOut: false
                    });
                    //新增的调拨明细物料对照
                    viewModel.transferDtlMaterialNew.push({
                        TransfersId: viewModel.transfer.TransfersId,
                        TransfersDtlId: viewModel.curTransferDtl.TransfersDtlId,
                        GRN: o.SerialNumber,
                        IsOnShelf: true,
                        IsBox: o.IsBox,
                        ItemCode: o.ItemCode,
                        BalanceQty: o.BalanceQty
                    });
                });
                return true;
            }

            //显示GRN扫描记录表
            function showGrnList(element) {
                var id = $(element).parents("tr.ItemRow").attr("data-id");
                //设置选中
                selectedTransferDtlRow(id);
                //调拨单关联的GRN列表
                var list = [];
                var listGRN =[];
                $.each(viewModel.transferDtlMaterial, function (i, o) {
                    if (o.TransfersDtlId == id) {
                        list.push(o);
                        listGRN.push(o.GRN);
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
                var html = "";
                for (var i = 0; i < list.length; i++) {
                    var grn = list[i].GRN;
                    var itemCode = list[i].ItemCode;

                    html += "<tr class='ListTableOddRow GrnRow " + (list[i].IsOnShelf ? "Bg-Green2" : "Bg-Red") + "'>";
                    html += "<td class=''>" + (i + 1) + "</td>";
                    html += "<td class=''>" + grn + "</td>";
                    html += "<td class=''>" + parseInt(list[i].BalanceQty) + "</td>";
                    html += "</tr>";
                }
                $("#tbGrnLog tbody").append(html);
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
                for (var i = viewModel.transferInShelfGRN.length - 1; i >= 0; i--) {
                    if (viewModel.transferInShelfGRN[i].TransfersDtlId == id) {
                        var transferDtlMaterial = getTransferDtlMaterial(viewModel.transferInShelfGRN[i].GRN);
                        if (transferDtlMaterial) {
                            transferDtlMaterial.IsOnShelf = false;
                        }
                        viewModel.transferInShelfGRN.splice(i, 1);
                    }
                }
                //自动计算调拨明细数量
                autoComputeTranferDtlQty(tranferDtl);
                //设置UI
                updateItemUI(tranferDtl);
                //
                $("#msg").html("清理完成！").css("color", "green");

            }
            //清除指定的Grn集合
            function clearGrnList(list) {
                if (list && list.length > 0) {
                    var tranferDtl = null;
                    //处理实体
                    for (var j = 0; j < list.length; j++) {
                        for (var i = viewModel.transferDtlMaterialNew.length - 1; i >= 0; i--) {
                            if (viewModel.transferDtlMaterialNew[i].GRN == list[j].GRN) {
                                viewModel.transferDtlMaterialNew.splice(i, 1);
                                break;
                            }
                        }
                        for (var i = viewModel.transferInShelfGRN.length - 1; i >= 0; i--) {
                            if (viewModel.transferInShelfGRN[i].GRN == list[j].GRN) {
                                if (!tranferDtl) {
                                    tranferDtl = getTransferDtl(viewModel.transferInShelfGRN[i].TransfersDtlId);
                                }
                                var transferDtlMaterial = getTransferDtlMaterial(viewModel.transferInShelfGRN[i].GRN);
                                if (transferDtlMaterial) {
                                    transferDtlMaterial.IsOnShelf = false;
                                }
                                viewModel.transferInShelfGRN.splice(i, 1);
                                break;
                            }
                        }
                    }
                    //自动计算调拨明细数量
                    autoComputeTranferDtlQty(tranferDtl);
                    //设置UI
                    updateItemUI(tranferDtl);
                }
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
                $("#txtPosCode").val('');
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
                viewModel.curScanGRNList = [];
                viewModel.curTransferDtl = null;
                viewModel.curIndex = 0;
            }

            //校验扫描GRN数量
            function checkScanQty(transferDtl, grnQty) {
                var msg = "";
                grnQty = grnQty * 1;                        //GRN物料的数量
                var applyQty = transferDtl.ApplyQty * 1;    //申请数量
                var finishQty = transferDtl.FinishQty * 1;  //调拨数量
                var onPosQty = transferDtl.OnPosQty * 1;    //入库上架数量
                var itemCode = transferDtl.itemCode;

                /*   配置“是否启用调拨出库”规则：
                *       启用：入库上架扫描的数量(OnPosQty)不能大于调拨数量(FinishQty)
                *       不启用：入库上架扫描的数量(OnPosQty)不能大于申请数量(ApplyQty)
                */
                if (viewModel.isEnableTransfersStorage) {
                    if (onPosQty + grnQty > finishQty) {
                        msg = "该物料[" + transferDtl.ItemCode + "]入库上架扫描的数量[" + (onPosQty + grnQty) + "]不能大于调拨数量[" + finishQty + "]！";
                    }
                }
                else {
                    if (onPosQty + grnQty > applyQty) {
                        msg = "该物料[" + transferDtl.ItemCode + "]入库上架扫描的数量[" + (onPosQty + grnQty) + "]不能大于申请数量[" + applyQty + "]！";
                    }
                }
                return msg;
            }

            //自动匹配调拨单明细
            function autoMatchTransferDtl(grn, posCode) {
                //校验库位条码是否有效
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(posCode);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                var result = $.parseJSON(ajax.value);
                if (!result.BarCode) {
                    $("#msg").html("不存在库位条码【" + posCode + "】！");
                    $("#msg").css("color", "red");
                    return false;
                }
                
                var listGrnInfo = viewModel.curScanGRNList;
                if (!listGrnInfo && listGrnInfo.length == 0) {
                    confirmDialog("未找到GRN相关信息！");
                    return false;
                }
                //验证调拨明细仓库
                var list = getTransferDtlList(listGrnInfo[0].ItemCode);
                var listOut = [];
                var listIn = [];
                if (!list || list.length == 0) {
                    $("#msg").html("该物料条码的物料编码[" + listGrnInfo[0].ItemCode + "]，不在本次调拨中！").css("color", "red");
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
                //匹配调入仓库
                $.each(listOut, function (i, o) {
                    if (result.CWhCode == o.ValidInWhouse) {
                        listIn.push(o);
                    }
                });
                if (listIn.length == 0) {
                    $("#msg").html("扫描的库位条码[" + posCode + "],所在仓库为[" + result.CWhCode + "]，与调入仓不一致，请重新扫描").css("color", "red");
                    $("#txtPosCode").val("");
                    $("#txtPosCode").focus();
                    return false;
                }
                //数量验证
                var msg = "";
                var grnQty = 0;
                $.each(listGrnInfo, function (i, o) {
                    grnQty += o.BalanceQty * 1;
                });

                viewModel.curTransferDtl = null;
                if (listIn.length == 0) {
                    confirmDialog('未找到当前扫描的GRN对应的调拨明细！');
                    return false;
                }
                for (var i = 0; i < listIn.length; i++) {
                    msg = checkScanQty(listIn[i], grnQty);
                    if (msg == "") {
                        viewModel.curTransferDtl = listIn[i];
                        break;
                    }
                }
                if (msg != "") {
                    $("#msg").html(msg).css("color", "red");
                    $("#txtGRN").val('');
                    $("#txtGRN").focus();
                    return false;
                }
                //选中行
                selectedTransferDtlRow(viewModel.curTransferDtl.TransfersDtlId);
                return true;
            }

            //选中明细行
            function selectedTransferDtlRow(id) {
                //设置当前行
                viewModel.curTransferDtl = getTransferDtl(id);
                //设置样式

                $("#tbTransferItem tr.ItemRow").removeClass("Bg-Green2");
                $("#tbTransferItem tr.ItemRow[data-id=" + id + "]").addClass("Bg-Green2");
                var trHtml = $("#tbTransferItem tr.ItemRow[data-id=" + id + "]").prop("outerHTML")
                $("#tbTransferItem tr.ItemRow[data-id=" + id + "]").remove();
                $("#tbTransferItem tbody").prepend(trHtml);

                //$("#tbTransferItem tr.ItemRow").each(function (i, o) {
                //    var transferDtlId = $(o).attr("data-id");
                //    if (transferDtlId == id) {
                //        $(o).addClass("Bg-Green2");
                //    }
                //    else {
                //        $(o).removeClass("Bg-Green2");
                //    }
                //});
            }

            //更新明细项UI
            function updateItemUI(tranferDtl) {
                var applyQty = tranferDtl.ApplyQty || '0';
                var finishQty = tranferDtl.FinishQty || '0';
                var onPosQty = tranferDtl.OnPosQty || '0';
                var stockQty = viewModel.isEnableTransfersStorage ? finishQty : applyQty;     //规则：启用调拨出库（调出数量），不启用（申请数量）
                var $row = null;
                $.each($("#tbTransferItem tr.ItemRow"), function (i, o) {
                    var id = $(o).attr("data-id");
                    if (id == tranferDtl.TransfersDtlId) {
                        $row = $(o);
                        return false;
                    }
                });
                $row.children(".onPosQty").children(":eq(0)").text(onPosQty);
                $row.children(".storeQty").text(onPosQty + "/" + stockQty);
                $row.fadeOut(500).fadeIn(500);
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
                    for (var i = viewModel.transferInShelfGRN.length - 1; i >= 0; i--) {
                        var transferDtlMaterial = getTransferDtlMaterial(viewModel.transferInShelfGRN[i].GRN);
                        if (transferDtlMaterial) {
                            if (transferDtlMaterial.IsOnShelf) {
                                viewModel.transferInShelfGRN.splice(i, 1);
                            }
                            else {
                                transferDtlMaterial.IsOnShelf = true;
                                viewModel.transferInShelfGRN[i].IsTransferOut = true;
                            }
                        }
                    };
                    for (var i = viewModel.transferDtlMaterialNew.length - 1; i >= 0; i--) {
                        var transferDtlMaterial = getTransferDtlMaterial(viewModel.transferDtlMaterialNew[i].GRN);
                        if (transferDtlMaterial) {
                            viewModel.transferDtlMaterialNew.splice(i, 1);
                        }
                    };
                }
                return true;
            }

        </script>
    </form>
</body>
</html>
