<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransferOutSN.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.TransferOutSN" %>

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
    <title>成品调拨</title>
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
            font-weight: bolder;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/Acc_w.png" />
                    </div>
                    <div>
                        成品调拨
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
                            <label>调拨单</label></td>
                        <td>
                            <input type="text" id="listno" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择单据</a>
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
                    <tr id="grntr1"><%--style="display:none;">--%>
                        <td>
                            <label>调入库位</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtGoalPos" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                        </td>
                    </tr>
                    <tr id="grntr2">
                        <td>
                            <label>扫描条码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtGRN" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                            <div style="display: none">
                                <input type="text" id="txtPosCode" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase; display: none;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>移除条码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtDeleteGRN" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <table data-role="table" id="tbTransferItem" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%">
                    <thead>
                        <tr>
                            <th style="padding-left: 11px">产品编码
                            </th>
                            <th>产品名称
                            </th>
                            <th>申请数量
                            </th>
                            <th>已调数量
                            </th>
                        </tr>
                    </thead>
                    <tr id="trNoInfo" class="ListTableOddRow">
                        <td colspan="4" style="text-align: center;">暂无数据
                        </td>
                    </tr>
                </table>

                <%--<table data-role="table" id="tbGrnLog" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%">
                    <thead>
                        <tr>
                            <th>已扫描条码
                            </th>
                            <th>库位条码
                            </th>
                            <th>产品编码
                            </th>
                            <th>可调数量
                            </th>
                            <th></th>
                        </tr>
                    </thead>
                    <tr id="tr1" class="ListTableOddRow">
                        <td colspan="5" style="text-align: center;">暂无数据
                        </td>
                    </tr>
                </table>--%>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtn" data-theme="f" value="确认调拨" /></li>
                    </ul>
                </div>
            </div>
            <%--<div data-role="panel" id="fpanel" data-display="overlay">
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="选择调拨单"
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>--%>
            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            //var GrnStr = ""; //grnstr
            var transfersId = -1;
            var inWhouseName = "";
            var inBarCode = "";
            var outWhouseName = "";
            var ListNo = "";

            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("#orderno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");

                $("#showOrderNo").on("click", function () {
                    if (!$("#fpanel").hasClass("ui-panel-open")) {
                        GetTransfesrOrderList();
                    }
                });
            });

            //根据字符串模糊查询调拨单
            $("#listviews").on("filterablebeforefilter", function (e, data) {
                return false;
                GetTransfesrOrderList();
            });

            $('#listno').on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($(this).val()) == "") {
                        $("#msg").html("调拨单单不能为空！").css("color", "red");
                        $(this).val('').focus();
                        return false;
                    }
                    requestOrder = $.trim($(this).val());
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.GetTransfesOrderList(requestOrder);
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message).css("color", "red");
                        return false;
                    }
                    var list = ajax.value;
                    var ulhtml = "";
                    var transferArr = [];
                    var ro;//调拨单号
                    for (var i = 0; i < list.length; i++) {
                        ro = list[i].TransfersNo;
                        if (transferArr.indexOf(ro) <= -1) {
                            transferArr.push(list[i].TransfersNo);
                            ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetOrderCode(this)' id='" + list[i].TransfersId + "' data-SourceNo='" + list[i].SourceNo + "' data-InWhouseName='" + list[i].InWhouseName + "' data-OutWhouseName='" + list[i].OutWhouseName + "' data-BWhPos='" + list[i].BWhPos + "'>" + ro + "</a></li>";
                            $("#listviews").append(ulhtml);
                            SetOrderCode($("#" + list[i].TransfersId + ""));
                        }
                    }
                    $("#listviews").html("");
                }
            });
            //获取调拨单
            $("#btnFilter").on("click", function () {
                $("#listviews").html("");
                var $ul = $(this),
                value = $.trim($("input[data-type='search']:eq(0)").val());
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.GetTransfesOrderList(value);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message).css("color", "red");
                    return false;
                }
                var list = ajax.value;
                var ulhtml = "";
                var transferArr = [];
                var ro;//调拨单号
                for (var i = 0; i < list.length; i++) {
                    ro = list[i].TransfersNo;
                    if (transferArr.indexOf(ro) <= -1) {
                        transferArr.push(list[i].TransfersNo);
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetOrderCode(this)' id='" + list[i].TransfersId + "' data-SourceNo='" + list[i].SourceNo + "' data-InWhouseName='" + list[i].InWhouseName + "' data-OutWhouseName='" + list[i].OutWhouseName + "' data-BWhPos='" + list[i].BWhPos + "'>" + ro + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            });

            var isBWhPos
            var itemLen = "";//Item种类
            var str = "";
            var newEntity = "";
            function SetOrderCode(obj) {
                $("#msg").html("").removeClass("Bg-Red");
                $("#showOrderNo").html($(obj).text());
                ListNo = $(obj).text();//调拨单号
                var TransfersId = $(obj).attr("id");
                transfersId = $(obj).attr("id");
                requestOrder = $(obj).html();
                $("#listno").val(requestOrder);
                $("#txtSourceNo").val($(obj).attr("data-SourceNo"));//源单号
                $("#txtInWhouseName").val($(obj).attr("data-inWhouseName"));//调入仓库
                inWhouseName = $(obj).attr("data-inWhouseName");
                $("#txtOutWhouseName").val($(obj).attr("data-OutWhouseName"));//调出仓库
                outWhouseName = $(obj).attr("data-OutWhouseName");
                isBWhPos = $(obj).attr("data-BWhPos");//是否货位管理
                //是货位的就要求输入货位
                //if (isBWhPos == "true") {
                //    $("#grntr1").show();
                //    $("#txtGoalPos").val("").focus();
                //}
                //else {
                //    $("#grntr1").hide();
                //    $("#txtGRN").val("").focus();
                //}
                $("#txtGoalPos").val("").focus();

                $("#fpanel").panel("close");
                var entity = {};
                entity.TransfersNo = ListNo;

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetTransfersItemByNo", JSON.stringify(entity));

                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                } else {
                    var dataList = JSON.parse(ajax.value);
                    arrReturnItem = dataList;
                    itemLen = arrReturnItem.data.length;//Item种类
                    str = JSON.stringify(arrReturnItem);
                    newEntity = JSON.parse(str); //全局变量
                    showRoDetail(dataList);
                }
                showRoDetail(dataList);
            }

            /*扫描库位条码*/
            $("#txtGoalPos").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    //验证库位条码是否正确
                    if (!changeBarCode($.trim($("#txtGoalPos").val()), inWhouseName)) {
                        $("#txtGoalPos").val("");
                        $("#txtGoalPos").focus();
                        $("#txtGoalPos").select();
                        return false;
                    }

                    $("#txtGRN").focus();
                    $("#msg").html("【" + $("#txtGoalPos").val() + "】调入库位条码扫描成功！");
                    $("#msg").css("color", "green");

                }
            });

            //验证库位
            function changeBarCode(wh, whouseName) {
                if (ListNo == "") {
                    alert("请先选择调拨单号!");
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode2(wh, whouseName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var en = $.parseJSON(ajax.value);
                if (!en.BarCode) {
                    $("#msg").html(inWhouseName + "不存在调入库位条码【" + wh + "】！");
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    return true;
                    $("#txtGRN").focus();

                }
            }

            //扫描GRN
            $("#txtGRN").on("keydown", function (e) {
                var c = curkey = 0, e = e || window.event;
                curkey = e.keyCode || e.which || e.charCode;
                var GRN = $.trim($("#txtGRN").val());
                if (curkey == 13) {
                    $("#msg").html("").removeClass("Bg-Red");
                    if (ListNo == "") {
                        confirmDialog("请选择调拨单！");
                        return false;
                    }

                    if (isBWhPos == "true") {
                        if ($("#txtGoalPos").val() == "") {
                            confirmDialog("调入库位条码不能为空！");
                            return false;
                        }
                    }
                    if (GRN == "") {
                        confirmDialog("GRN不能为空！");
                        return false;
                    }
                    //删除移除条码，可以继续扫描调拨
                    var index = deleteArrGRN.indexOf($.trim($("#txtGRN").val()));
                    if (index > -1) {
                        deleteArrGRN.splice(index, 1);
                    }
                    //验证是否重复扫描
                    if (checkGrnExist($.trim($("#txtGRN").val())) === true) return false;
                    //检查是否可调拨
                    var grnResult = checkGrn($.trim($("#txtGRN").val())) || false;
                    if (grnResult) {
                        showGrnList(grnResult);
                        //更新已扫描数量
                        updateTransferQty(grnResult,"add");
                        $("#txtGRN").val('');
                    } else {
                        //alert('未能获取此GRN关联信息');
                    }
                    $("#txtGRN").focus();
                }
            });
            var deleteArrGRN = [];//记录移除条码，确认调拨时用于排除在外不做调拨
            //移除条码扫描
            $("#txtDeleteGRN").on("keydown", function (e) {
                var c = curkey = 0, e = e || window.event;
                curkey = e.keyCode || e.which || e.charCode;
                var deleteGRN = $.trim($("#txtDeleteGRN").val());
                if (curkey == 13) {
                    $("#msg").html("").removeClass("Bg-Red");
                    if (deleteGRN == "") {
                        confirmDialog("条码不能为空！");
                        return false;
                    }
                    var mygrnQty = "";
                    var myitemCode = "";
                    //检查是否可调拨
                    var grnResult = checkGrn($.trim($("#txtDeleteGRN").val())) || false;
                    if (grnResult) {
                        if (arrGrn.length === 0) {
                            confirmDialogFocus('未扫描需要挑拨的条码，无法移除', function () {
                                $("#txtGRN").focus();
                            });
                            return false;
                        }
                        if (grnResult != "") {
                            mygrnQty = grnResult[0].BalanceQty;
                            myitemCode = grnResult[0].ItemCode;
                        }
                        for (var i = 0; i < itemLen; i++) {
                            if (myitemCode == newEntity.data[i].ItemCode) {
                                newEntity.data[i].StockQty = newEntity.data[i].StockQty * 1;
                                newEntity.data[i].StockQty -= mygrnQty * 1;
                            }
                        }
                        //用新实体更新Item table
                        showRoDetail(newEntity);
                        deleteArrGRN.push(deleteGRN);
                        //删除已扫描条码，防止后续误操作条码移除，可以继续扫描
                        var index = arrGrn.indexOf(deleteGRN);
                        if (index > -1) {
                            arrGrn.splice(index, 1);
                        }
                        $("#txtDeleteGRN").val('');
                        $("#msg").html("条码移除成功").css("color", "#2ecc71");
                    } else {
                        confirmDialog("未能获取此条码关联信息！");
                    }
                    $("#txtDeleteGRN").focus();
                }
            });
            //确认调拨
            $("#Savebtn").on("click", function () {
                Save();
            });

            //检查GRN
            function checkGrn(grn) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.CheckSNTransfer(transfersId, grn)
                //$("#txtPosCode").val(ajax.data[0].cBarCode);
                if (ajax.value === '') return false;
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                var grnResult = JSON.parse(ajax.value);
                return grnResult;
            }

            //显示GRN扫描记录表
            //update snake.lu 取消显示已扫描列表
            function showGrnList(grnObj) {
                //console.log(grnObj)
                if (!grnObj[0]) return false;
                arrGrn.push(grnObj[0].SerialNumber);
                //var serialNumber = grnObj[0].SerialNumber;
                //var itemCode = grnObj[0].ItemCode;
                //var cBarCode = grnObj[0].CBarCode;
                //var balanceQty = grnObj[0].BalanceQty;

                //var r = "<tr class='ListTableOddRow GrnRow'>";
                //r += "<td class='SerialNumberData'>" + serialNumber + "</td>";
                //r += "<td class='CBarCodeData'>" + cBarCode + "</td>";
                //r += "<td class='ItemCodeData'>" + itemCode + "</td>";
                //r += "<td class='BalanceQtyData'>" + balanceQty + "</td>";
                //r += "<td style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"delGrnRec(this)\">删除</td>";
                //r += "</tr>";

                //$("#trNoGrn").remove();
                //$("#tr1").remove();
                //if ($("#tbGrnLog tr").length === 1) {
                //    $("#tbGrnLog tr:eq(0)").after(r);
                //}
                //else {
                //    $("#tbGrnLog tr:eq(1)").before(r);
                //}
            }
            //调拨数量变更，数量验证，超出变红
            var grnQty = "";
            var _itemCode = "";
            function updateTransferQty(grnItemList,type) {         
                if (type == "add") {
                    if (grnItemList != "") {
                        grnQty = grnItemList[0].BalanceQty;
                        _itemCode = grnItemList[0].ItemCode;
                    }
                    for (var i = 0; i < itemLen; i++) {
                        if (_itemCode == newEntity.data[i].ItemCode) {
                            newEntity.data[i].StockQty = newEntity.data[i].StockQty * 1;
                            newEntity.data[i].StockQty += grnQty * 1;
                        }
                    }
                } else {
                    //删除数据
                    grnQty = grnItemList.split("|^|")[1];
                    _itemCode = grnItemList.split("|^|")[0];
                    for (var i = 0; i < itemLen; i++) {
                        if (_itemCode == newEntity.data[i].ItemCode) {
                            newEntity.data[i].StockQty = newEntity.data[i].StockQty * 1;
                            newEntity.data[i].StockQty =  newEntity.data[i].StockQty  - grnQty * 1;
                        }
                    }
                }

                //用新实体更新Item table
                showRoDetail(newEntity);
                //数量验证
                for (var i = 0; i < newEntity.data.length; i++) {
                    var myi=i+1;
                    var qty = $(".stockQty" + myi + "").prev().html();
                    if ($(".stockQty" + myi + "").html() * 1 > qty * 1) {
                        $(".stockQty" + myi + "").addClass("Bg-Red");
                        qtyLimit = false;
                    } else {
                        qtyLimit = true;
                        $(".stockQty" + myi + "").removeClass("Bg-Red");
                    }
                }
                //数量验证
                //$(".stockQty").each(function () {
                //    var qty = $(".stockQty").prev().html();
                //    if ($(".stockQty").html() * 1 > qty * 1) {
                //        $(".stockQty").addClass("Bg-Red");
                //        qtyLimit = false;
                //    } else {
                //        qtyLimit = true;
                //        $(".stockQty").removeClass("Bg-Red");
                //    }
                //});
            }
            //显示调拨单明细信息表格
            function showRoDetail(dataList) {
                if (!dataList.data[0]) return false;
                var html = '';
                var listNum = dataList.data.length || 0;
                for (var i = 0; i < listNum; i++) {
                    var myi = i + 1;
                    var itemCode = dataList.data[i].ItemCode || '';
                    var itemName = dataList.data[i].ItemName || '';
                    var applyQty = dataList.data[i].ApplyQty || '0';
                    var stockQty = dataList.data[i].StockQty || '0';
                    html += "<tr class='ListTableOddRow ItemRow'>";
                    html += "<td class='itemCode'>" + itemCode + "</td>";
                    html += "<td>" + itemName + "</td>";
                    html += "<td class='applyQty'>" + applyQty + "</td>";
                    html += "<td class='stockQty" + myi + "'>" + stockQty + "</td>";
                    html += "</tr>";
                }
                $("#trNoInfo").remove();
                $(".ItemRow").remove();
                if ($("#tbTransferItem tr").length === 1) {
                    $("#tbTransferItem tr:eq(0)").after(html);
                }
                else {
                    $("#tbTransferItem tr:eq(1)").before(html);
                }
            }

            //删除已扫描的GRN
            //function delGrnRec(obj) {
            //    var table = document.getElementById("tbGrnLog");
            //    table.deleteRow(obj.parentElement.rowIndex);
            //    if ($("#tbGrnLog tr").length === 1) {
            //        $("#tbGrnLog tr:eq(0)").after('<tr id="trNoGrn" class="ListTableOddRow">' +
            //            '<td colspan="4" style="text-align: center;">暂无数据</td>' +
            //            '</tr>');
            //    }
            //    //更新数量
            //    var deleteItemCode = $(obj).parent().find("td:eq(2)").text();
            //    var deleteGRNQty = $(obj).parent().find("td:eq(3)").text();
            //    var grnStr = deleteItemCode + "|^|" + deleteGRNQty;
            //    updateTransferQty(grnStr, "delete");
            //}
            function checkGrnExist(grn) {
                var exist = false;
                for (var i = 0; i < arrGrn.length; i++) {
                    if (arrGrn[i] === grn) {
                        $(this).addClass("Bg-Red");
                        $("#msg").html("GRN已扫描").css("color", "red");
                        $("#txtGRN").val("").focus();
                        exist = true;
                    }
                }
                return exist;
            }
            var arrGrn = [];
            //确认调拨
            function Save() {
                
                if (arrGrn.length === 0) {
                    confirmDialogFocus('请扫描要调拨的条码', function () {
                        $("#txtGRN").focus();
                    });
                    return false;
                }
                //数量不等验证
                for (var i = 0; i < newEntity.data.length; i++) {
                    var myi = i + 1;
                    var qty = $(".stockQty" + myi + "").prev().html();
                    var myqty = $(".stockQty" + myi + "").html();
                    if ($(".stockQty" + myi + "").html() * 1 != qty * 1) {
                        $(".stockQty" + myi + "").addClass("Bg-Red");
                        qtyLimit = false;
                    }
                    else {
                        qtyLimit = true;
                    }
                }
                if (qtyLimit === false) {
                    confirmDialog("扫描数量与计划调拨数量不一致！");
                    return false;
                }
                if (!confirm('是否确认调拨?')) {
                    return false;
                }

                inBarCode = $("#txtGoalPos").val();
                var strGrns = arrGrn.join(",");
                var strDeleteGrn = deleteArrGRN.join(',');
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.SaveTransferSN(transfersId, strGrns, strDeleteGrn, inWhouseName, outWhouseName, inBarCode, ListNo);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $("#msg").html("调拨成功！").css("color", "#2ecc71");
                $(".ItemRow").remove();
                $(".GrnRow").remove();
                //$("#tbGrnLog").append('<tr id="trNoGrn" class="ListTableOddRow"><td colspan="4" style="text-align: center;">暂无数据</td></tr>');
                $("#tbTransferItem").append('<tr id="trNoInfo" class="ListTableOddRow"><td colspan="5" style="text-align: center;">暂无数据</td></tr>');
                $("#txtGRN").val('');
                $("#txtSourceNo").val('');
                $("#txtInWhouseName").val('');
                $("#txtOutWhouseName").val('');
                $("#txtGoalPos").val('');
                $("#showOrderNo").html("请选择");
                isBWhPos = "";
                deleteArrGRN = [];
            }
        </script>
    </form>
</body>
</html>