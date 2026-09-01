<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScrapOut.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.ScrapOut" %>

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
    <title>报废出库</title>
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
                        报废出库
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
                            <label>报废单</label></td>
                        <td>
                            <a href="#fpanel" data-transition="none" data-role="button" data-ajax="false"
                                id="showOrderNo" data-theme="c">请选择</a>
                        </td>
                    </tr>
          
                    <tr id="grntr2">
                        <td>
                            <label>扫描GRN条码</label>
                        </td>
                        <td>
                            <input type="text" id="txtGRN" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                            <div style="display: none">
                                <input type="text" id="txtPosCode" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase; display: none;" />
                            </div>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <table data-role="table" id="tbScrapItem" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%">
                    <thead>
                        <tr>
                            <th style="padding-left: 11px">物料编码
                            </th>
                            <th>物料名称
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

                <table data-role="table" id="tbGrnLog" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%">
                    <thead>
                        <tr>
                            <th>GRN条码
                            </th>
                            <th>物料编码
                            </th>
                            <th>库位条码
                            </th>
                            <th>可调数量
                            </th>
                             <th>
                            </th>
                        </tr>
                    </thead>
                    <tr id="tr1" class="ListTableOddRow">
                        <td colspan="5" style="text-align: center;">暂无数据
                        </td>
                    </tr>
                </table>

            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtn" data-theme="f" value="确认报废" /></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="选择报废单"
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            //var GrnStr = ""; //grnstr
            var scrapId = -1;
            var scrapNo = "";

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
                //根据字符串模糊查询报废单
                $("#listviews").on("filterablebeforefilter", function (e, data) {
                    GetTransfesrOrderList();
                });
            });

            //获取报废单
            function GetTransfesrOrderList() {
                $("#listviews").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.GetScrapOrderList();
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message).css("color", "red");
                    return false;
                }
                var list = ajax.value;
                var ulhtml = "";
                var transferArr = [];
                var ro;//报废单号
                for (var i = 0; i < list.length; i++) {
                    ro = list[i].ScrapNo;
                    if (transferArr.indexOf(ro) <= -1) {
                        transferArr.push(list[i].ScrapNo);
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetOrderCode(this)' id='" + list[i].ScrapId + "'>" + ro + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            }

            function SetOrderCode(obj) {
                $("#msg").html("").removeClass("Bg-Red");
                $("#showOrderNo").html($(obj).text());
                scrapNo = $(obj).text();//报废单号
                var ScrapId = $(obj).attr("id");
                scrapId = $(obj).attr("id");
               
                $("#fpanel").panel("close");
                var entity = {};
                entity.ScrapNo = scrapNo;

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetScrapItemByNo", JSON.stringify(entity));

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

            //扫描GRN
            $("#txtGRN").on("keydown", function (e) {
                var c = curkey = 0, e = e || window.event;
                curkey = e.keyCode || e.which || e.charCode;
                var GRN = $.trim($("#txtGRN").val());
                if (curkey == 13) {
                    $("#msg").html("").removeClass("Bg-Red");
                    if (scrapNo == "") {
                        confirmDialog("请选择报废单！");
                        return false;
                    }
         
                    if (GRN == "") {
                        confirmDialog("GRN不能为空！");
                        return false;
                    }
                    //验证是否重复扫描
                    if (checkGrnExist($.trim($("#txtGRN").val())) === true) return false;
                    //检查是否可报废
                    var grnResult = checkGrn($.trim($("#txtGRN").val())) || false;
                    if (grnResult) {
                        showGrnList(grnResult);
                        //更新已扫描数量
                        updateScrapQty();
                        $("#txtGRN").val('');
                    } 
                    $("#txtGRN").focus();
                }
            });
            //确认报废
            $("#Savebtn").on("click", function () {
                Save();
            });
            
            //检查GRN
            function checkGrn(grn) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.CheckGrnScrap(scrapId, grn)
                if (ajax.value === '') return false;
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }


                var itemLen = arrReturnItem.data.length;//Item种类
                var str = JSON.stringify(arrReturnItem);
                var newEntity = JSON.parse(str);   //复制一个ItemObj
                var isitem = 0;
                for (var i = 0; i < itemLen; i++) {
                    if (JSON.parse(ajax.value)[0].ItemCode === newEntity.data[i].ItemCode) {
                        isitem = 1;
                        break;
                    }
                }
                if (isitem == 0) {
                    confirmDialog("扫描的GRN不属于当前的报废的物料");
                    return false;
                }

                var grnResult = JSON.parse(ajax.value);
                return grnResult;
            }

            //显示GRN扫描记录表
            function showGrnList(grnObj) {
                //console.log(grnObj)
                if (!grnObj[0]) return false;
                var serialNumber = grnObj[0].SerialNumber;
                var itemCode = grnObj[0].ItemCode;
                var cBarCode = grnObj[0].CBarCode;
                var balanceQty = grnObj[0].BalanceQty;
              
                var r = "<tr class='ListTableOddRow GrnRow'>";
                r += "<td class='SerialNumberData'>" + serialNumber + "</td>";
                r += "<td class='CBarCodeData'>" + cBarCode + "</td>";
                r += "<td class='ItemCodeData'>" + itemCode + "</td>";
                r += "<td class='BalanceQtyData'>" + balanceQty + "</td>";
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
            //报废数量变更，数量验证，超出变红
            function updateScrapQty() {
                var itemLen = arrReturnItem.data.length;//Item种类
                var str = JSON.stringify(arrReturnItem);
                var newEntity = JSON.parse(str);   //复制一个ItemObj
                $(".ItemCodeData").each(function () {
                    var grnQty = $(".ItemCodeData").next().html();
                    var _itemCode = $(".ItemCodeData").html();
                    for (var i = 0; i < itemLen; i++) {
                        if (_itemCode === newEntity.data[i].ItemCode) {
                            newEntity.data[i].StockQty = newEntity.data[i].StockQty * 1;
                            newEntity.data[i].StockQty += grnQty * 1;
                        }
                    }
                })

                //用新实体更新Item table
                showRoDetail(newEntity);
                //数量验证
                $(".stockQty").each(function () {
                    var qty = $(".stockQty").prev().html() || 0;
                    if ($(".stockQty").html() * 1 > qty * 1) {
                        $(".stockQty").addClass("Bg-Red");
                        qtyLimit = false;
                    } else {
                        qtyLimit = true;
                        $(".stockQty").removeClass("Bg-Red");
                    }
                });
            }
            //显示报废单明细信息表格
            function showRoDetail(dataList) {
                if (!dataList.data[0]) return false;
                var html = '';
                var listNum = dataList.data.length || 0;
                for (var i = 0; i < listNum; i++) {
                    var itemCode = dataList.data[i].ItemCode || '';
                    var itemName = dataList.data[i].ItemName || '';
                    var applyQty = dataList.data[i].ApplyQty || '0';
                    var stockQty = dataList.data[i].StockQty || '0';
                    html += "<tr class='ListTableOddRow ItemRow'>";
                    html += "<td class='itemCode'>" + itemCode + "</td>";
                    html += "<td>" + itemName + "</td>";
                    html += "<td class='applyQty'>" + applyQty + "</td>";
                    html += "<td class='stockQty'>" + stockQty + "</td>";
                    html += "</tr>";
                }
                $("#trNoInfo").remove();
                $(".ItemRow").remove();
                if ($("#tbScrapItem tr").length === 1) {
                    $("#tbScrapItem tr:eq(0)").after(html);
                }
                else {
                    $("#tbScrapItem tr:eq(1)").before(html);
                }
            }

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
                updateScrapQty();
            }
            function checkGrnExist(grn) {
                var exist = false;
                $(".SerialNumberData").each(function () {
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
            //确认报废
            function Save() {
                var arrGrn = [];
                $(".SerialNumberData").each(function () {
                    arrGrn.push($(this).html());
                })
                if (arrGrn.length === 0) {
                    confirmDialogFocus('请扫描要报废的GRN', function () {
                        $("#txtGRN").focus();
                    });
                    return false;
                }
                if (qtyLimit === false) {
                    confirmDialog("当前扫描数量超出申请报废数量，请进行修改");
                    return false;
                }
                if (!confirm('是否确认报废?')) {
                    return false;
                }

       
                var strGrns = arrGrn.join(",");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.SaveScrapOut(scrapId, strGrns, scrapNo);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                confirmDialog("报废成功");
                $(".ItemRow").remove();
                $(".GrnRow").remove();
                $("#tbGrnLog").append('<tr id="trNoGrn" class="ListTableOddRow"><td colspan="4" style="text-align: center;">暂无数据</td></tr>');
                $("#tbScrapItem").append('<tr id="trNoInfo" class="ListTableOddRow"><td colspan="5" style="text-align: center;">暂无数据</td></tr>');
                $("#txtGRN").val('');
                $("#msg").html("");
 
            }
        </script>
    </form>
</body>
</html>
