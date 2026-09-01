<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WarehouseReturnToSupplier.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.WarehouseReturnToSupplier" %>

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
    <title>仓库退供应商</title>
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
                        仓库退供应商
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
                            <label for="listno">退料单</label>
                        </td>
                        <td>
                            <input type="text" id="listno" />
                        </td>
                        <td>
<%--                            <a href="#fpanel" data-transition="none" data-role="button" data-ajax="false" data-position-to="window" data-mini="true"
                                id="showOrderNo" data-theme="c">请选择</a>--%>
                            <a href="#fpanel" id="showOrderNo" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">请选择</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                物料条码/包装箱条码</label>
                        </td>
                        <td  colspan="2">
                            <input id="txtGRN" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <table data-role="table" id="tbRtvItem" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%">
                    <thead>
                        <tr>
                             <th>
                                采购单
                            </th>
                            <th>物料编码
                            </th>
                            <th>物料名称
                            </th>
                            <th>申请数量
                            </th>
                            <th>已退数量
                            </th>
                        </tr>
                    </thead>
                    <tr id="trNoInfo" class="ListTableOddRow">
                        <td colspan="5" style="text-align: center;">暂无数据
                        </td>
                    </tr>
                </table>
                <div style="width: 100%">
                    <table data-role="table" id="tbGrnLog" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%">
                        <thead>
                            <tr>
                                <th>GRN
                                </th>
                                <th>物料编码
                                </th>
                                <th>数量
                                </th>
                                <th></th>
                            </tr>
                        </thead>
                        <tr id="trNoGrn" class="ListTableOddRow">
                            <td colspan="4" style="text-align: center;">暂无数据
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtn" data-theme="f" value="确认退料" /></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="选择退料单"
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            //var GrnStr = ""; //grnstr
            var returnId = -1;
            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("#orderno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");

                //$("#showOrderNo").on("click", function () {
                //    if (!$("#fpanel").hasClass("ui-panel-open")) {
                //        debugger
                //        GetRtvOrderList("");
                //    }
                //});

                //根据字符串模糊查询采购单
                $("#listviews").on("filterablebeforefilter", function (e, data) {
                    //var $ul = $(this)
                    $input = $(data.input);
                    value = $input.val();
                    if (value.length >= 2) {
                        GetRtvOrderList(value);
                    }
                });

                $("#btnFilter").on("click", function () {
                    $("#listviews").html("");
                    receiveChoosePageId = $("#receivingMethod").val();
                    var $ul = $(this),
                    value = $.trim($("input[data-type='search']:eq(0)").val());
                    GetRtvOrderList(value);
                });

                $("#listno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
                $("#listno").focus();


                //扫描领料单
                $('#listno').on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        requestOrder = $.trim($(this).val());
                        $("#msg").html("").removeClass("Bg-Red");
                        $("#listno").val($.trim($(this).val()));                        
                        ListNo = $.trim($(this).val());;//退料单号
                        //returnId = $(obj).attr("id");
                        $("#txtGRN").val("").focus();
                        
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetInfoRTV(requestOrder,"false");
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return false;
                        } else {
                            var dataList = JSON.parse(ajax.value);
                            arrReturnItem = dataList;
                            if (dataList[0].FinishStatus == "0") { //0表示未完成退货 1已完成 dl.liang 20230828
                                showRoDetail(dataList);  
                            }
                            else {
                                confirmDialog("该单据已完成退料，禁止再次退料！");
                            }
                            returnId = dataList[0].ReturnToVendorID;
                        }
                    }
                });
            });

            //获取退料单
            function GetRtvOrderList(value) {
                $("#listviews").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetRtvOrderList(value);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message).css("color", "red");
                    return false;
                }
                var list = ajax.value;
                var ulhtml = "";
                var rtvArr = [];
                var ro;//退料单号
                for (var i = 0; i < list.length; i++) {
                    ro = list[i].ReturnOrder;
                    if (rtvArr.indexOf(ro) <= -1) {
                        rtvArr.push(ro);
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetOrderCode(this)' id='" + list[i].ReturnToVendorID + "'>" + ro + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            }

            //扫描GRN
            $("#txtGRN").on("keydown", function (e) {
                var c = curkey = 0, e = e || window.event;
                curkey = e.keyCode || e.which || e.charCode;
                var GRN = $.trim($("#txtGRN").val());
                if (curkey == 13) {
                    $("#msg").html("").removeClass("Bg-Red");
                    if (ListNo == "") {
                        confirmDialog("请选择退料单！");
                        return false;
                    }
                    if (GRN == "") {
                        confirmDialog("物料编码不能为空！");
                        return false;
                    }
                    //验证是否重复扫描
                    if (checkGrnExist($.trim($("#txtGRN").val())) === true) return false;
                    //检查是否可退
                    var grnResult = checkGrn($.trim($("#txtGRN").val())) || false;
                    if (grnResult) {
                        //验证包装箱是否重复扫描 dl.liang 20230828 见具体方法
                        if (checkBoxGrnExistList(grnResult)) {
                            alert("当前扫描的【" + $.trim($("#txtGRN").val()) + "】条码已扫描，请勿重复扫描！");
                            return false;
                        }
                        showGrnList(grnResult);
                        //更新已扫描数量
                        updateReQty();
                    } else {
                        //alert('未能获取此GRN关联信息');
                    }
                    $("#txtGRN").focus();
                }
            });
            //确认退料
            $("#Savebtn").on("click", function () {
                Save();
            });
            function SetOrderCode(obj) {
                $("#msg").html("").removeClass("Bg-Red");
                //$("#showOrderNo").html($(obj).text());
                $("#listno").val($(obj).text());                
                ListNo = $(obj).text();//退料单号
                var ReturnToVendorID = $(obj).attr("id");
                returnId = $(obj).attr("id");
                $("#txtGRN").val("").focus();
                $("#fpanel").panel("close");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetInfoRTV(ReturnToVendorID);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                } else {
                    var dataList = JSON.parse(ajax.value);
                    arrReturnItem = dataList;
                    showRoDetail(dataList);
                }
                showRoDetail(dataList);
            }
            //扫描GRN，检查GRN
            function checkGrn(grn) {
                //var returnId = $("#hfReturnOrderId").val();
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckGrnReturn(returnId, grn);
                if (ajax.value === '') return false;
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var grnResult = JSON.parse(ajax.value);
                return grnResult;
            }
            //显示退料单明细信息表格
            function showRoDetail(dataList) {
                if (!dataList[0]) return false;
                var html = '';
                var listNum = dataList.length || 0;
                for (var i = 0; i < listNum; i++) {
                    var RtvDtlID = dataList[i].RtvDtlID || '0';
                    var itemCode = dataList[i].ItemCode || '';
                    var itemName = dataList[i].ItemName || '';
                    var quantity = dataList[i].Quantity || '0';
                    var reQty = dataList[i].ReQty || '0';
                    var po = dataList[i].SourceBillNo || '';
                    html += "<tr class='ListTableOddRow ItemRow'>";
                    html += "<td class='RtvDtlID' style='display:none;'>" + RtvDtlID + "</td>";
                    html += "<td class=' '>" + po + "</td>";
                    html += "<td class=' ROItem'>" + itemCode + "</td>";
                    html += "<td>" + itemName + "</td>";
                    html += "<td class='Qty'>" + quantity + "</td>";
                    html += "<td class='reQty'>" + reQty + "</td>";
                    html += "</tr>";
                }
                $("#trNoInfo").remove();
                $(".ItemRow").remove();
                if ($("#tbRtvItem tr").length === 1) {
                    $("#tbRtvItem tr:eq(0)").after(html);
                }
                else {
                    $("#tbRtvItem tr:eq(1)").before(html);
                }
            }
            //显示GRN扫描记录表
            function showGrnList(grnObj) {
                if (grnObj.length <= 0) return false;
                for (var i = 0; i < grnObj.length; i++) {
                    if (!grnObj[i]) return false;
                    var balanceQty = grnObj[i].BalanceQty;
                    var itemCode = grnObj[i].ItemCode;
                    var SerialNumber = grnObj[i].SerialNumber;
                    var Porder = grnObj[i].POorder;
                    var autoId = grnObj[i].AutoId;

                    var r = "<tr class='ListTableOddRow GrnRow'>";
                    r += "<td class='GrnData'>" + SerialNumber + "</td>";
                    r += "<td class='GrnType' data-porder='" + Porder + "' data-autoid='" + autoId + "'>" + itemCode + "</td>";
                    r += "<td class='QtyData'>" + balanceQty + "</td>";
                    r += "<td style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"delGrnRec(this)\">删除</td>";
                    r += "</tr>";

                    $("#trNoGrn").remove();
                    if ($("#tbGrnLog tr").length === 1) {
                        $("#tbGrnLog tr:eq(0)").after(r);
                    }
                    else {
                        $("#tbGrnLog tr:eq(1)").before(r);
                    }
                }               
            }
            //退料数量变更，数量验证，超出变红
            function updateReQty() {
                //console.log(arrReturnItem);
                var itemLen = arrReturnItem.length;//Item种类
                var str = JSON.stringify(arrReturnItem);
                var newEntity = JSON.parse(str);   //复制一个ItemObj                

                $(".GrnType").each(function () {
                    var grnQty = $(this).next().html();
                    var _itemCode = $(this).html();
                    var _porder = $(this).data("porder");
                    var _autoId = $(this).data("autoid");

                    for (var i = 0; i < itemLen; i++) {
                        if (_porder === newEntity[i].SourceBillNo && _itemCode == newEntity[i].ItemCode && _autoId == newEntity[i].SourceEntryID) {
                            newEntity[i].ReQty += grnQty * 1
                        }
                    }
                })

                //用新实体更新Item table
                showRoDetail(newEntity);
                //数量验证
                var unLimit = 0;
                $(".reQty").each(function (i,v) {
                    var qty = $(this).prev().html() || 0;
                    if ($(this).html() * 1 > qty * 1) {
                        $(this).addClass("Bg-Red");
                        unLimit = i+1;
                    } else {
                        $(this).removeClass("Bg-Red");
                    }
                });
                if (unLimit > 0) {
                    qtyLimit = false;
                }
                else {
                    qtyLimit = true;
                }
            } 
            //显示退料单明细信息表格
            //function showRoDetail(dataList) {
            //    if (!dataList[0]) return false;
            //    var html = '';
            //    var listNum = dataList.length || 0;
            //    for (var i = 0; i < listNum; i++) {
            //        var itemCode = dataList[i].ItemCode || '';
            //        var itemName = dataList[i].ItemName || '';
            //        var quantity = dataList[i].Quantity || '0';
            //        var reQty = dataList[i].ReQty || '0';
            //        var po = dataList[i].SourceBillNo || '';
            //        html += "<tr class='ListTableOddRow ItemRow'>";
            //        html += "<td class=' ROItem'>" + itemCode + "</td>";
            //        html += "<td>" + itemName + "</td>";
            //        html += "<td class='Qty'>" + quantity + "</td>";
            //        html += "<td class='reQty'>" + reQty + "</td>";
            //        html += "</tr>";
            //    }
            //    $("#trNoInfo").remove();
            //    $(".ItemRow").remove();
            //    if ($("#tbRtvItem tr").length === 1) {
            //        $("#tbRtvItem tr:eq(0)").after(html);
            //    }
            //    else {
            //        $("#tbRtvItem tr:eq(1)").before(html);
            //    }
            //}
            //删除已扫描的GRN
            function delGrnRec(obj) {
                var table = document.getElementById("tbGrnLog");
                table.deleteRow(obj.parentElement.rowIndex);
                if ($("#tbGrnLog tr").length === 1) {
                    $("#tbGrnLog tr:eq(0)").after('<tr id="trNoGrn" class="ListTableOddRow">' +
                        '<td colspan="4" style="text-align: center;">暂无数据</td>' +
                        '</tr>');
                }
                //更新数量
                updateReQty();
            }
            function checkGrnExist(grn) {

                var exist = false;
                $(".GrnData").each(function () {
                    if ($(this).html() === grn) {
                        $(this).addClass("Bg-Red");
                        $("#msg").html("GRN已扫描").css("color", "red");
                        exist = true;
                    } else {
                        $(this).removeClass("Bg-Red");
                    }
                });
                return exist;
            }
            //确认退料
            function Save() {
                var arrGrn = [];

                $(".GrnData").each(function () {
                    arrGrn.push($(this).html());
                })             

                if (arrGrn.length === 0) {
                    confirmDialogFocus('请扫描要退的GRN', function () {
                        $("#txtGRN").focus();
                    });
                    return false;
                }
                if (qtyLimit === false) {
                    confirmDialog("当前扫描数量超出申请退货数量，请进行修改");
                    return false;
                }
                if (!confirm('是否确认退料?')) {
                    return false;
                }

                var reTurnDetails = [];
                $(".RtvDtlID").each(function () {
                    var detail = {};
                    detail.RtvDtlID = $(this).text();
                    detail.ReQty = $(this).siblings(".reQty").text();
                    reTurnDetails.push(detail);

                })

                var strGrns = arrGrn.join(",");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveRTV(returnId, strGrns, reTurnDetails);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                confirmDialog("退料成功");
                $(".ItemRow").remove();
                $(".GrnRow").remove();
                $("#tbGrnLog").append('<tr id="trNoGrn" class="ListTableOddRow"><td colspan="4" style="text-align: center;">暂无数据</td></tr>');
                $("#tbRtvItem").append('<tr id="trNoInfo" class="ListTableOddRow"><td colspan="5" style="text-align: center;">暂无数据</td></tr>');
                $("#txtROrder").val('');
                $("#txtGRN").val('');

            }
            function checkBoxGrnExistList(grnObj) {
                var exist = false;
                if (grnObj.length <= 0) return false;
                var arrGrn = [];
                $(".GrnData").each(function () {
                    arrGrn.push($(this).html());
                })
                for (var i = 0; i < grnObj.length; i++) {
                    var SerialNumber = grnObj[i].SerialNumber;
                    if (arrGrn.includes(SerialNumber)) {
                        exist = true
                    }
                }
                return exist;
            }
        </script>
    </form>
</body>
</html>
