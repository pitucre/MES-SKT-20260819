<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MoldFixtureInOutStock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MoldFixtureInOutStock" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <title>模治具出入库</title>
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

        .ui-title {
            line-height: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">模治具出入库</label>
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
                            <label for="showOrderNo">
                                操作</label>
                        </td>
                        <td>
                            <select id="ddlOptionType" data-mini="true">
                                <option value="Out">出库</option>
                                <option value="In">入库</option>
                            </select>
                        </td>
                    </tr>
                    <tr class="OutStock">
                        <td>
                            <label>
                                出库类型</label>
                        </td>
                        <td>
                            <select id="ddlOutStockType" data-mini="true">
                                <option value="1">产线</option>
                                <option value="2">供应商</option>
                            </select>
                        </td>
                    </tr>
                    <tr class="OutStock Supplier">
                        <td>
                            <label for="showOrderNo">
                                供应商</label>
                        </td>
                        <td>
                            <a href="#OrderPanel" data-transition="none" data-role="button" data-mini="true" data-ajax="false"
                                id="txtSupplierNo" data-theme="c">请选择</a>
                            <input type="hidden" value="0" id="hdnSupplierId" />
                        </td>
                    </tr>
                    <tr class="InStock">
                        <td>
                            <label>
                                存放库位</label>
                        </td>
                        <td>
                            <input id="cbarcode" />
                            <input type="hidden" id="hdnCbarcode" value="-1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                工具编码</label>
                        </td>
                        <td>
                            <input id="steelid" />
                        </td>
                    </tr>
                    <tr class="InStock">
                        <td>
                            <label>
                                历史库位</label>
                        </td>
                        <td>
                            <label id="historyCbarcode"></label>
                        </td>
                    </tr>

                </table>
                <div id="msg" style="text-align: center;">
                </div>
            </div>
            <div style="margin-top: 8px">
                <table data-role="table" id="arrivaltable" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%">
                    <thead>
                        <tr>
                            <th>模治具名称</th>
                            <th>模治具编码</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Save" onclick="Save()" data-role="button" data-fullscreen="true"
                            data-theme="f">确认</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="OrderPanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="Orderlistview" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var OutStockQty = 0;//可出库数量
            var OnLineQty = 0;//入库数量-在线数量
            var Items = []
            $(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");

                $(".ui-body-c").css("background", "#fff");
                $(".InStock").hide();
                $(".OutStock.Supplier").hide();
                $('#ddlOptionType').change(function () {
                    var type = $("#ddlOptionType").val();
                    Items = []
                    showDetail(Items)
                    if (type == "Out") {
                        $(".InStock").hide();
                        $(".OutStock").show();
                        var OutStockType = $("#ddlOutStockType").val()
                        if (OutStockType == '2') {
                            $(".OutStock.Supplier").show();
                        } else {
                            $(".OutStock.Supplier").hide();
                        }
                    }
                    else {
                        $(".InStock").show();
                        $(".OutStock").hide();
                        $("#cbarcode").val('').focus()
                    }
                });

                $('#ddlOutStockType').change(function () {
                    var OutStockType = $("#ddlOutStockType").val()
                    Items = []
                    showDetail(Items)
                    $("#txtSupplierNo").html('');
                    $("#hdnSupplierId").val(0);
                    if (OutStockType == '2') {
                        $(".OutStock.Supplier").show();
                    } else {
                        $(".OutStock.Supplier").hide();
                    }

                })


                //筛选
                $("#btnFilter").on("click", function () {
                    $("#listviews").html("");
                    var $ul = $(this),
                        value = $.trim($("input[data-type='search']:eq(0)").val());
                    var entity = {}
                    entity.FiledValue = value
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetSupplierList", JSON.stringify(entity));

                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        return false;
                    }
                    var htmlstr = "";
                    var mydata = JSON.parse(ajax.value);
                    $('#Orderlistview').html('');
                    for (var i = 0; i < mydata.data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + mydata.data[i].SupplierId + "' onclick=\"OrderList('" + mydata.data[i].VendorCode + "', " + mydata.data[i].SupplierId + ")\">" + mydata.data[i].VendorCode + "(" + mydata.data[i].VendorName + ")</li>";
                    }
                    $("#Orderlistview").append(htmlstr);
                    $('#Orderlistview').listview('refresh');

                });
            });

            function OrderList(VendorCode, SupplierId) {
                $("#msg").html("");
                $("#steel").html("");
                $("#Steeltab tbody").html("");
                $("#txtSupplierNo").html(VendorCode);
                $("#hdnSupplierId").val(SupplierId);
                $("#OrderPanel").panel("close");
                $("#msg").html("");
                $("#steelid").focus().select();
            }

            $("#steelid").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var code = $("#steelid").val()
                    if (Items.some(item => item.EquipmentCode === code)) {
                        $("#msg").html("治具【" + code + "】已扫描").css("color", "red");
                        return;
                    }
                    var type = $("#ddlOptionType").val()
                    var entity = {}
                    //出库扫描工具编码校验工具编码与产品
                    if (type == "Out") {
                        entity.EquipmentCode = code,
                            entity.Type = 2
                    }
                    //入库扫描工具编码校验
                    else {
                        entity.EquipmentCode = code,
                            entity.Type = 1
                    }

                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspMoldFixtureInOrOutScanCheck", JSON.stringify(entity))
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        return
                    }
                    var json = JSON.parse(ajax.value)
                    Items.push({
                        EquipmentId: json.data[0].EquipmentId,
                        EquipmentName: json.data[0].EquipmentName,
                        EquipmentCode: json.data[0].EquipmentCode
                    })
                    showDetail(Items)

                    $("#steelid").val('').focus();
                    $("#msg").html("扫描成功！").css("color", "#2ecc71");
                }
            });


            $("#cbarcode").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var barcode = $.trim($("#cbarcode").val())
                    var entity = {
                        cBarCode: barcode
                    }
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Basal_WarehouseLocation_GetInfo_Mold", JSON.stringify(entity))
                    if (ajax.error) {
                        $("#cbarcode").val('').focus()
                        alert(ajax.error.Message)
                        return
                    }
                    var data = JSON.parse(ajax.value).data[0]
                    $("#hdnCbarcode").val(data.WarehouseLocationId)
                    $("#steelid").val('').focus();
                    $("#msg").html("库位扫描成功！").css("color", "#2ecc71");
                }
            })


            $("#txtStockNo").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#steelid").focus().select();
                }
            });

            //确认
            function Save() {

                var type = $("#ddlOptionType").val();
                var mouldId = Items.map(item => item.EquipmentId).join(',');
                var SupplierId = $("#hdnSupplierId").val();
                var cbarcodeId = $("#hdnCbarcode").val()
                if (type == "Out") {
                    var outStockType = $("#ddlOutStockType").val()
                    if (outStockType == '1') {
                        SupplierId = -1
                    }
                    if (outStockType == '2') {
                        if (SupplierId == -1) {
                            alert('请选择供应商')
                        }
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.UpdateStock(mouldId, 2, -1, outStockType == "1" ? "产线" : "供应商", SupplierId);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    confirmDialogFocus('出库成功', function () {
                        window.location.reload()
                    });

                }
                else {
                    if (cbarcodeId == -1) {
                        alert('请扫描库位')
                        return
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.UpdateStock(mouldId, 1, cbarcodeId, type, -1);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    confirmDialogFocus('入库成功', function () {
                        window.location.reload()
                    });
                    return
                }
            }

            function showDetail(m) {
                var htmlstr = "";
                if (m.length == 0) {
                    htmlstr += '<tr class="ListTableOddRow"><td colspan="3" style="text-align: center;">暂无数据</td></tr>';
                }
                else {
                    for (var i = 0; i < m.length; i++) {
                        htmlstr += "<tr class='ListTableOddRow'>";
                        htmlstr += "<td >" + m[i].EquipmentCode + "</td>";
                        htmlstr += "<td >" + m[i].EquipmentName + "</td>";
                        htmlstr += "<td ><a href='#' onclick='RemoveCode(\"" + m[i].EquipmentCode + "\")'>清除</a></td >"
                        htmlstr += "</tr>";
                    }
                }
                $("#arrivaltable tbody").html("");
                $("#arrivaltable tbody").append(htmlstr);
            }

            function RemoveCode(EquipmentCode) {
                Items = Items.filter(item => item.EquipmentCode !== EquipmentCode);
                showDetail(Items)
            }

        </script>
    </form>
</body>
</html>
