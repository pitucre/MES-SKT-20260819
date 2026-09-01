<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialDetailInfo.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MaterialDetailInfo" %>

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
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>仓库查询</title>
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

        .table-stroke tbody td {
            border: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/steelnetsearch_white.png" />
                    </div>
                    <div>
                        仓库查询
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" id="content1">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 20%">
                            <select id="ddltype" data-mini="true">
                                <option value="0">物料条码</option>
                                <option value="1">物料包装箱</option>
                                <option value="3">成品条码</option>
                                <option value="2">成品包装箱</option>
                            </select>
                        </td>
                        <td style="width: 60%">
                            <input id="txtGRN" style="width" />

                        </td>
                        <td>
                            <button id="enterGrn" style="line-height: 0.5" type="button">确认</button>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <div style="position: absolute; height: 2px; background-color: Black; width: 100%;">
                </div>
                <div>
                    <div style="margin: 10px 5px;">
                        <b>信息</b>
                    </div>
                    <table data-role="table" id="infotb" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            $(function () {
                $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $("#enterGrn").on('click', function () {
                    Search();
                    return false;
                });
                $("#txtGRN").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13 || curKey == 16) {
                        Search();
                    }
                });
            });
            function timeStamp2String(time) {
                var datetime = new Date();
                datetime.setTime(time);
                var year = datetime.getFullYear();
                var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
                var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
                var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
                var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
                var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
                return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
            }


           


            function Search() {
                
                var val = $.trim($("#txtGRN").val());
                if (val == "" && $("#ddltype").val() == "3") {
                    confirmDialogFocus("请输入产品条码或客户条码");
                    return false;
                }
                if (val == "") {
                    confirmDialogFocus("GRN不能为空");
                    return false;
                }
                var type = $("#ddltype").val();


                if (type != '3') {
                    //获取物料条码数据
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SearchWarehouseInfo(type, val);

                    if (ajax.error != null) {
                        confirmDialogFocus(ajax.error.Message);
                        $("#infotb tbody").html("");
                        $("#txtGRN").val("").focus();
                        return false;
                    }
                  
                    var list = ajax.value.Rows;

                    var htmlCode = "";
                    if (type == "0") {
                        var names = ["库存数量", "在产线数量", "在边线仓数量", "最初数量", "可用数量"];
                        for (var i = 0; i < list.length; i++) {
                            if ($.inArray(list[i].ColumnName, names) >= 0) {
                                var nameStr = "";

                                switch (list[i].ColumnName) {
                                    case "库存数量":
                                        nameStr = "在库数量";
                                        break;
                                    case "在边线仓数量":
                                        nameStr = "在线边仓数量";
                                        break;

                                    default:
                                        nameStr = list[i].ColumnName;

                                }

                                htmlCode += "<tr><td>" + nameStr + "</td><td>" + (list[i].ColumnValue == null ? "" : parseFloat(list[i].ColumnValue)) + "</td></tr>";

                            }
                            else {
                                htmlCode += "<tr><td>" + list[i].ColumnName + "</td><td>" + (list[i].ColumnValue == null ? "" : list[i].ColumnValue) + "</td></tr>";

                            }
                        }
                    } else if (type == "1") {
                        if (!list || list.length == 0) {
                            confirmDialogFocus('【'+val + "】物料包装箱不存在");
                        }
                        else if (list.length > 0) {
                            var sum = 0;
                            var dtlstr = "";
                            for (var i = 0; i < list.length; i++) {
                                sum += list[i].Quantity;
                                dtlstr += "<tr><td style='border:none;'>物料条码" + (i + 1) + ":" + list[i].DtlSN + "</td><td style='border:none;'>数量:" + list[i].BalanceQty + "</td></tr>";
                                dtlstr += "<tr><td style='border:none;'>采购单号:" + list[i].POrder + "</td><td style='border:none;'>批次号:" + list[i].LotCode + "</td></tr>";
                                dtlstr += "<tr><td>生成时间:" + list[i].CreateDateTime + "</td><td>状态:" + list[i].MaterialStatus + "</td></tr>";
                            }
                            htmlCode += "<tr><td>包装箱条码:" + list[0].SerialNumber + "</td><td>包装总数量:" + sum + "</td></tr>";
                            htmlCode += "<tr><td>产品编码:" + list[0].ItemCode + "</td><td>产品名称:" + list[0].ItemName + "</td></tr>";
                            htmlCode += "<tr><td colspan='2'>产品规格:" + list[0].ItemSpec + "</td></tr>";
                            htmlCode += "<tr><td>仓库编码:" + list[0].CWhCode + "</td><td>货位编码:" + list[0].cBarCode + "</td></tr>";
                            htmlCode += "<tr><td colspan='2'>供应商:" + list[0].VendorName + "</td></tr>";
                            htmlCode += "<tr><td>明细:" + list[0].CWhCode + "</td><td>GRN个数:" + list.length + "</td></tr>";
                            htmlCode += dtlstr;
                        }
                    } else {
                        if (list.length == 1 && list[0].OrderNo) {
                            if (!list[0].SNS)
                                list[0].SNS = "";
                            var dtlstr = "";
                            var array = list[0].SNS.split("，");
                            for (var i = 0; i < array.length; i++) {
                                dtlstr += "<tr><td>" + array[i] + "</td><td></td></tr>";
                            }
                            htmlCode += "<tr><td>包装箱条码:" + list[0].CartonNo + "</td><td>状态:" + list[0].Status + "</td></tr>";
                            htmlCode += "<tr><td>工单号:" + list[0].OrderNo + "</td><td>包装日期:" + list[0].CreateTime + "</td></tr>";
                            htmlCode += "<tr><td>产品编码:" + list[0].ItemCode + "</td><td>产品名称:" + list[0].ItemName + "</td></tr>";
                            htmlCode += "<tr><td colspan='2'>产品规格:" + list[0].ItemSpec + "</td></tr>";
                            htmlCode += "<tr><td>入库人:" + list[0].CreateBy + "</td><td>入库时间:" + list[0].CreateDateTime + "</td></tr>";
                            htmlCode += "<tr><td>仓库编码:" + list[0].CWhCode + "</td><td>货位编码:" + list[0].cBarCode + "</td></tr>";
                            htmlCode += "<tr><td>包装产品明细</td><td>包装总数量:" + array.length + "</td></tr>";
                            htmlCode += dtlstr;
                        } else {
                            confirmDialogFocus('【'+val + "】成品包装箱不存在");
                        }
                    }
                    $("#infotb tbody").html(htmlCode);
                    $("#infotb").table("refresh");
                }
                if (type == '3')//成品条码
                {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SearchFinishProdInfo(val);
                  
                    if (ajax.error != null) {
                        $("#infotb tbody").html("");
                        confirmDialogFocus(ajax.error.Message);
                        $("#txtGRN").val("").focus();
                        return false;
                    }
                    var outStockInfo = ajax.value.outStockInfo;
                    var storageInfo = ajax.value.storageInfo;

                    var productInfo = ajax.value.productInfo;
                    if (outStockInfo.DNCode != null && storageInfo.BarCode != null) {
                        var state = outStockInfo.CName != "" ? "已出货" : "已入库";
                        var htmlstr = "<tr><td>成品条码：" + val + "</td><td>状态：" + state + "</td></tr>";
                        htmlstr += "<tr><td>工单号：" + storageInfo.WorkOrderNo + "</td><td>产品编码：" + storageInfo.ItemCode + "</td></tr>";
                        htmlstr += "<tr><td colspan='2'>产品规格：" + storageInfo.ItemModel + "</td></tr>";
                        htmlstr += "<tr><td>产品名称：" + storageInfo.ItemName + "</td><td>入库单号：" + storageInfo.InStockNo + "</td></tr>";
                        htmlstr += "<tr><td>入库人：" + storageInfo.CreateBy + "</td><td>入库时间：" + timeStamp2String(storageInfo.CreateDateTime) + "</td></tr>";
                        htmlstr += "<tr><td>仓库编码：" + storageInfo.CWhCode + "/" + storageInfo.CWhName + "</td><td>库位条码：" + storageInfo.BarCode + "</td></tr>";
                        htmlstr += "<tr><td>出货人：" + outStockInfo.CName + "</td><td>出货单号：" + outStockInfo.DNCode + "</td></tr>";
                        htmlstr += "<tr><td colspan='2'>出货时间：" + timeStamp2String(outStockInfo.FinishDateTime) + "</td></tr>";
                        $("#infotb tbody").html(htmlstr);
                        $("#infotb").table("refresh");
                    }
                    else if (outStockInfo.DNCode == null && storageInfo.BarCode != null) {
                        var state = "已入库";
                        var htmlstr = "<tr><td>成品条码：" + val + "</td><td>状态：" + state + "</td></tr>";
                        htmlstr += "<tr><td>工单号：" + storageInfo.WorkOrderNo + "</td><td>产品编码：" + storageInfo.ItemCode + "</td></tr>";
                        htmlstr += "<tr><td colspan='2'>产品规格：" + storageInfo.ItemModel + "</td></tr>";
                        htmlstr += "<tr><td>产品名称：" + storageInfo.ItemName + "</td><td>入库单号：" + storageInfo.InStockNo + "</td></tr>";
                        htmlstr += "<tr><td>入库人：" + storageInfo.CreateBy + "</td><td>入库时间：" + timeStamp2String(storageInfo.CreateDateTime) + "</td></tr>";
                        htmlstr += "<tr><td>仓库编码：" + storageInfo.CWhCode + "/" + storageInfo.CWhName + "</td><td>库位条码：" + storageInfo.BarCode + "</td></tr>";
                        htmlstr += "<tr><td>出货人：</td><td>出货单号：</td></tr>";
                        htmlstr += "<tr><td colspan='2'>出货时间：</td></tr>";
                        $("#infotb tbody").html(htmlstr);
                        $("#infotb").table("refresh");
                    }
                    else {
                        console.log(productInfo);
                        var htmlstr = "<tr><td>成品条码：" + val + "</td><td>状态：</td></tr>";
                        htmlstr += "<tr><td>工单号：" + productInfo.ProductionOrder + "</td><td>产品编码：" + productInfo.ITEM + "</td></tr>";
                        htmlstr += "<tr><td colspan='2'>产品规格：" + productInfo.ItemModel + "</td></tr>";
                        htmlstr += "<tr><td>产品名称：" + productInfo.ItemName + "</td><td>入库单号：</td></tr>";
                        htmlstr += "<tr><td>入库人：</td><td>入库时间：</td></tr>";
                        htmlstr += "<tr><td>仓库编码：</td><td>库位条码：</td></tr>";
                        htmlstr += "<tr><td>出货人：</td><td>出货单号：</td></tr>";
                        htmlstr += "<tr><td colspan='2'>出货时间：</td></tr>";
                        $("#infotb tbody").html(htmlstr);

                        $("#infotb").table("refresh");
                    }

                }

                $("#txtGRN").val("").focus();
            }

        </script>
    </form>
</body>
</html>
