<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CpInStock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.CpInStock" %>

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
    <title>成品入库</title>
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

        img {
            -webkit-filter: grayscale(100%);
            -moz-filter: grayscale(100%);
            -ms-filter: grayscale(100%);
            -o-filter: grayscale(100%);
            filter: grayscale(100%);
            filter: gray;
        }

        .ui-title {
            line-height: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;" style="width: 100%">
        <div data-role="page" id="pageOne" style="width: 100%">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label id="lbltitle" style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">成品入库</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar">
                    <ul>
                        <li><a href="#pageOne" data-theme="c">成品入库</a></li>
                        <li><a href="#Search" data-transition="none" data-theme="c">查询</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <div style="width: 100%">
                    <table style="width: 100%">
                        <tr>
                            <td>
                                <label for="storage-no">入库单号</label>
                            </td>
                            <td>
                                <input id="storage-no" type="text" disabled value="" />
                            </td>
                            <td>
                                <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button" onclick="getStorageNo()">选择单据</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#myPopup" id="scanType" data-rel="popup" class="ui-link-inherit" data-position-to="window">SN</a>
                            </td>
                            <td colspan="3">
                                <input id="serial-number" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    库位</label>
                            </td>
                            <td>
                                <input id="cwhCode" type="text" />
                            </td>
                            <td>
                                <label>
                                    &nbsp;总数</label>
                            </td>
                            <td>
                                <span id="storage-sum"></span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="msg" style="text-align: center"></div>
                <div>
                    <div style="margin-top: 3px">
                        <table data-role="table" id="storage-order" data-mode="columntoggle:none" class="ui-responsive table-stroke"
                            style="width: 100%">
                            <thead>
                                <tr>
                                    <th>工单
                                    </th>
                                    <th>物料编码
                                    </th>
                                    <th>客户料号
                                    </th>
                                    <th>扫描数量
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div style="margin-top: 3px">
                    <strong>扫描列表</strong>
                    <table data-role="table" id="storage-scan" data-mode="columntoggle:none" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>条码
                                </th>
                                <th>客户料号
                                </th>
                                <th>数量
                                </th>
                                <th>操作
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
                            <input type="button" id="Savebtn" data-theme="f" value="确认入库" onclick="Save()" /></li>
                    </ul>
                </div>
            </div>
            <div data-role="popup" id="myPopup" style="min-width: 220px" data-theme="f">
                <div class="ui-controlgroup-controls" data-theme="f">
                    <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(1)">SN</a>
                    <%--<a href="#" data-theme="f" data-role="button" onclick="chooseScanType(2)">客户SN</a>--%>
                    <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(3)">卡通箱</a>
                    <%--  <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(4)">栈板</a>
                    <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(5)">检验批次号</a>--%>
                </div>
            </div>

            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>

        <div data-role="page" id="Search">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label id="lbltitle" style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">成品入库</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar">
                    <ul>
                        <li><a href="#pageOne" data-theme="c">成品入库</a></li>
                        <li><a href="#Search" data-transition="none" data-theme="c">查询</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <div>
                    <table style="width: 100%">
                        <%--<tr>
                            <td>
                                <label for="txtSearch">SN、客户SN、箱号、栈板号</label>
                            </td>                            
                        </tr>--%>
                        <tr>
                            <td>
                                <input id="txtSearch" type="text" placeholder="扫描SN、箱号" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="searchMsg" style="text-align: center; color: red;">
                </div>
                <table id="stockSNList" data-role="table" data-mode="columntoggle:none" class="table-stripe ui-responsive" style="width: 100%; margin-top: 20px; table-layout: fixed; word-break: break-all;">
                    <thead>
                        <tr>
                            <th>工单号</th>
                            <th>产品编码</th>
                            <th>产品名称</th>
                            <th>主序号</th>
                            <th>客户条码</th>
                            <th>包装箱号</th>
                            <th>栈板号</th>
                            <%--<th data-priority="3">工单号</th>
                            <th data-priority="4">产品编码</th>
                            <th data-priority="5">产品名称</th>
                            <th data-priority="6">主序号</th>
                            <th>客户条码</th>
                            <th data-priority="1">包装箱号</th>
                            <th data-priority="2">栈板号</th>--%>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>

        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var isOpenPDA = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.GetConfigType("1").value;
            var scanType = 1; //扫描类型
            var viewModel = {   //存放页面共享数据对象
                listOrder: [],              //物料产品列表
                isSetDefault: false         //是否设置默认的库位
            };;

            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("#serial-number,#cwhCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() }).focus();

                if (isOpenPDA == 1) {
                    $("input,button").attr("readonly", "readonly");
                    $("#Savebtn").closest("div.ui-footer").hide();
                    showMsg("当前未启用PDA备货扫描，请检查成品出入库配置", 0);
                    return false;
                }
                //初始化默认库位
                //initcBarCode();

                //输入入库单号并进行筛选
                $("#listviews").on("filterablebeforefilter", function (e, data) {
                    val = $.trim($(data.input).val());
                    if (!val || val.length <= 2) {
                        return false;
                    }
                    searchStorageNo(val);
                });

                //筛选入库单号
                $("#btnFilter").on("click", function () {
                    val = $.trim($("#fpanel input[data-type='search']").first().val());
                    searchStorageNo(val);
                });

                //SN扫描回车事件
                $("#serial-number").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        showMsg("", 1);
                        var sn = $.trim($(this).val());
                        var len = $("#storage-scan tr[SerialNumber=\"sn\"]").length;
                        if (len > 0) {
                            showMsg("[" + sn + "]已存在列表中", 0);
                            $("#serial-number").val("").focus();
                            return false;
                        }

                        var storageNo = $.trim($("#storage-no").val());
                        var entity =
                        {
                            StorageNo: storageNo,
                            SerialNumber: sn,
                            ScanType: scanType,
                            ModifyBy: userName,
                        };
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFinishProductInStorageScan", JSON.stringify(entity));
                        if (ajax.error != null) {
                            showMsg(ajax.error.Message, 0);
                            if (containsStringCompat(ajax.error.Message, '未完成生产')) {
                                SendEmail(ajax.error.Message);
                            }
                            $("#serial-number").val("").focus();
                            return false;
                        }
                        //debugger;
                        var list = JSON.parse(ajax.value).data;
                        var entity = list[0];
                        var flag = entity.HistoryDataFlag;
                        if (flag == 1 || storageNo == "") {
                            //历史扫描的条码或者新生成的入库单，根据入库单号，获取数据
                            $("#storage-no").val(entity.StorageNo);
                            getStorageInfo({ StorageNumber: entity.StorageNo }, 1);
                            return false;
                        } else {
                            //追加到产品列表
                            viewModel.listOrder = viewModel.listOrder ? viewModel.listOrder : [];
                            for (var i = 0; i < entity.length; i++) {
                                viewModel.listOrder.push(entity[i]);
                            }
                            //设置物料默认库位，多个则默认第一个
                            if (viewModel.listOrder && viewModel.listOrder.length > 0) {
                                setWarehouseLocationMaterial(viewModel.listOrder[0].ItemCode);
                            }

                            /*
                            //已有入库单号，更新工单列表数据
                            var qtyObj = $("#storage-order tbody tr.order-item[OrderNo=\"" + entity.OrderNo + "\"]").find("td.Qty");
                            if (qtyObj.length == 0) {
                                //追加到工单列表中                                
                                appendStorageOrderNo(list);
                            } else {
                                //更新扫描总数、工单列表中工单扫描数量                            
                                qtyObj.text(parseFloat($.trim(qtyObj.text())).add(entity.Qty));
                            }
                            */
                            //重新加载工单信息
                            getStorageInfo({ StorageNumber: storageNo }, 0);

                            //更新扫描条码列表
                            var listSN = [];
                            if (list.length > 1) {
                                //同一SN对应多个工单时，数量汇总
                                var totalQty = 0;
                                for (var i = 0; i < list.length; i++) {
                                    totalQty = totalQty.add(list[i].Qty);
                                }
                                listSN.push({ SerialNumber: list[0].SerialNumber, Qty: totalQty });
                            } else {
                                listSN = list;
                            }
                            appendStorageScan(listSN);
                            $("#serial-number").val("").focus();
                        }
                    }
                });

                //库位扫描
                $("#cwhCode").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        showMsg("", 1);
                        var cBarCode = $.trim($("#cwhCode").val());
                        if (cBarCode == "") {
                            showMsg("请扫描库位条码", 0);
                            $("#cwhCode").val("").focus();
                            return false;
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(cBarCode);
                        if (ajax.error != null) {
                            showMsg(ajax.error.Message, 0);
                            $("#cwhCode").val("").focus();
                            return false;
                        }
                        var en = $.parseJSON(ajax.value);
                        if (!en.BarCode) {
                            showMsg("库位条码不存在", 0);
                            $("#cwhCode").val("").focus();
                            return false;
                        }
                        //校验货位产品唯一
                        if (!verifyProductOnly(cBarCode)) return false;
                        showMsg("扫描库位条码成功", 1);
                    }
                });

                //删除
                $("#storage-scan tbody").on("click", ".delete-item", function () {
                    var tr = $(this).closest("tr");
                    var storageNumber = $.trim($("#storage-no").val());
                    var serialNumber = $.trim(tr.find(".SerialNumber").text());
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFinishProductInStorageDeleteSN", JSON.stringify({ StorageNo: storageNumber, SerialNumber: serialNumber, ModifyBy: userName }));
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message, 0);
                        return false;
                    }
                    //var qty = parseFloat($.trim(tr.find("td.Qty").text()));
                    //var orderNo = tr.attr("OrderNo");

                    tr.remove();

                    /*
                    //如果条码列表中没有此工单数据，则移除工单列表数据
                    var len = $("#storage-scan tbody tr[OrderNo=\"" + orderNo + "\"]").length;
                    if (len == 0) {
                        $("#storage-order tbody tr[OrderNo=\"" + orderNo + "\"]").remove();
                    } else {
                        //更新工单已扫描数量
                        var orderQtyObj = $("#storage-order tbody tr[OrderNo=\"" + orderNo + "\"] td.Qty");
                        orderQtyObj.text(parseFloat($.trim(orderQtyObj.text())).subtract(qty));
                    }
                    */
                    //重新加载工单信息
                    getStorageInfo({ StorageNumber: storageNumber }, 0);

                    //更新总数
                    refreshStorageSumQty();

                    showMsg("删除[" + serialNumber + "]成功", 1);
                })

                //查询栏—入库单号回车事件
                $("#txtSearch").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        $("#searchMsg").html("");
                        var sn = $.trim($("#txtSearch").val());
                        if (sn == "") {
                            $("#searchMsg").html("请输入入库单号!");
                            $("#txtSearch").val("").focus();
                            return;
                        }
                        var entity = { SerialNumber: sn, ModifyBy: userName };
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetStorageInfo", JSON.stringify(entity));
                        if (ajax.error != null) {
                            $("#searchMsg").html(ajax.error.Message);
                            $("#txtSearch").val("").focus();
                            return;
                        }
                        var list = JSON.parse(ajax.value).data;
                        if (!list || list.length <= 0) {
                            $("#searchMsg").html("[" + sn + "]不存在");
                            $("#txtSearch").val("").focus();
                            $("#stockSNList tbody").html("");
                            $("#stockSNList").table("refresh");
                            return;
                        }
                        var hl = "";
                        for (var i = 0; i < list.length; i++) {
                            hl += "<tr><td>" + list[i].OrderNo + "</td>"
                                + "<td>" + list[i].ItemCode + "</td>"
                                + "<td>" + list[i].ItemName + "</td>"
                                + "<td>" + list[i].SerialNumber + "</td>"
                                + " <td>" + list[i].CustomerSN + "</td>"
                                + " <td>" + list[i].CartonNo + "</td>"
                                + " <td>" + list[i].PalletNo + "</td></tr>";
                        }
                        $("#txtSearch").val("").focus();
                        $("#stockSNList tbody").html(hl);
                        $("#stockSNList").table("refresh");
                    }
                });

                $("#serial-number").focus();
            });

            function containsStringCompat(str, substring) {
                return str.indexOf(substring) !== -1;
            }

            function SendEmail(errmessage) {
                debugger
                var entity = {}
                entity.SN = $("#serial-number").val("");
                entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                entity.ErrMessage = errmessage;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspInjectionMoldingProductionSendEmail_NEW260715", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }

            }

            //初始化默认库位
            function initcBarCode() {
                $("#cwhCode").val(SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.GetConfigType("6").value);
            }

            //点击选择单据，弹出选择单据面板
            function getStorageNo() {
                $("#listviews").listview("refresh");
                searchStorageNo("");
            }


            //搜索、筛选入库单号
            function searchStorageNo(storageNoNo) {
                $("#listviews").html("");

                var where = "Status = 1";
                if (storageNoNo != "") {
                    where += " AND StorageNumber LIKE '" + storageNoNo + "%'";
                }
                var searchSettings =
                {
                    ExtensionCondition: where,
                };
                var ajax = SKT.AjaxCommon.DBService.GetAll(-1, 20, "StorageID", searchSettings, "Prod_Storage", "");
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return false;
                }

                var list = ajax.value.Tables[0].Rows;
                var hl = "";
                for (var i = 0; i < list.length; i++) {
                    hl += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getStorageInfo(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].StorageNumber + "</a></li>";
                }
                $("#listviews").html(hl).listview("refresh");
            }


            //获取入库单明细信息 flag（0：获取工单信息 1：获取工单及条码信息）
            function getStorageInfo(entity, flag) {
                showMsg("", 1);

                var info = { StorageNo: entity.StorageNumber, ModifyBy: userName };
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetFinishProductInStorageInfo", JSON.stringify(info));
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return false;
                }
                var list = JSON.parse(ajax.value);
                var listOrder = list.data;
                viewModel.listOrder = listOrder;

                //设置物料默认库位，多个则默认第一个
                if (flag == 1 && listOrder && listOrder.length > 0) {
                    setWarehouseLocationMaterial(listOrder[0].ItemCode);
                }

                $("#storage-order tbody").html("");

                //入库单按工单+产品编码汇总信息
                appendStorageOrderNo(listOrder);

                if (flag == 1) {
                    $("#storage-scan tbody").html("");
                    //入库单扫描栈板、包装箱、SN等信息
                    var listSN = list.data1;
                    appendStorageScan(listSN);

                    $("#storage-no").val(entity.StorageNumber);
                    $("input[data-type=\"search\"]").val("");
                    $("#listviews").html("");
                    $("#fpanel").panel("close");
                    $("#serial-number").val("").focus();
                }
            }


            //添加工单汇总信息
            function appendStorageOrderNo(list) {
                var hl = "";
                for (var i = 0; i < list.length; i++) {
                    hl += "<tr style=\"background-color:#7FFF00\" class=\"order-item\" OrderNo=\"" + list[i].OrderNo + "\"><td class=\"OrderNo\">" + list[i].OrderNo + "</td><td class=\"ItemCode\">" + list[i].ItemCode + "</td><td class=\"CPN\">" + list[i].CPN + "</td><td class=\"Qty\">" + list[i].Qty + "</td></tr>";
                }
                $("#storage-order tbody tr").css("background-color", "");
                $("#storage-order tbody").prepend(hl);
                $("#storage-order").table("refresh");
            }


            //添加条码扫描记录
            function appendStorageScan(list) {
                var hl = "";
                for (var i = 0; i < list.length; i++) {
                    hl += "<tr style=\"background-color:#7FFF00\" SerialNumber=\"" + list[i].SerialNumber + "\"><td class=\"SerialNumber\">" + list[i].SerialNumber + "</td><td class=\"CPN\">" + list[i].CPN + "</td><td class=\"Qty\">" + list[i].Qty + "</td><td><a href=\"#\" class=\"delete-item\">删除</a></td></tr>";
                }
                $("#storage-scan tbody tr").css("background-color", "");
                $("#storage-scan tbody").prepend(hl);
                $("#storage-scan").table("refresh");
                refreshStorageSumQty();
            }

            //更新总数
            function refreshStorageSumQty() {
                var qty = 0;
                $("#storage-order tbody tr td.Qty").each(function () {
                    qty = qty.add($.trim($(this).text()));
                });
                $("#storage-sum").text(qty);
            }

            //保存
            function Save() {
                showMsg("", 1);
                //扫描
                var storageNo = $.trim($("#storage-no").val());
                if (storageNo == "") {
                    showMsg("请选择入库单号", 0);
                    return;
                }
                var len = $("#storage-scan tbody tr").length;
                if (len == 0) {
                    showMsg("请扫描条码", 0);
                    return false;
                }
                var cBarCode = $.trim($("#cwhCode").val());
                if (cBarCode == "") {
                    showMsg("请扫描库位", 0);
                    $("#cwhCode").val("").focus();
                    return false;
                }
                //校验货位产品唯一
                if (!verifyProductOnly(cBarCode)) return false;

                var entity = { StorageNo: storageNo, cBarCode: cBarCode };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.FinishProductInStorage(entity);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return false;
                }

                var listStr = ajax.value;
                var tipMsg = listStr[1];

                if (tipMsg != "") {
                    alert("MES成功，但ERP 返回[" + tipMsg + "]错误，请及时处理ERP异常");
                }

                clear();
                showMsg("入库成功！", 1);
            }

            //选择扫描方式 
            function chooseScanType(data) {
                var htmls = "";
                scanType = data;
                switch (data) {
                    case 1:
                        htmls = "SN";
                        break;
                    case 2:
                        htmls = "客户SN";
                        break;
                    case 3:
                        htmls = "卡通箱";
                        break;
                    case 4:
                        htmls = "栈板";
                        break;
                    case 5:
                        htmls = "检验批次号";
                        break;
                }
                $("#scanType").html(htmls);
                $("#myPopup").popup("close");
                setTimeout('$("#serial-number").val("").focus()', 100);
            }

            function clear() {
                //scanType = 3;//扫描类型
                //chooseScanType(scanType);
                $("#storage-sum").text("");
                $("#storage-no").val("");
                $("#serial-number").val("");
                $("#storage-order tbody").html("");
                $("#storage-order").table("refresh");
                $("#storage-scan tbody").html("");
                $("#storage-scan").table("refresh");
                $("#cwhCode").val("");
                viewModel.listOrder = [];
                viewModel.isSetDefault = false;
                //初始化默认库位
                //initcBarCode();
            }

            //浮点型加法运算
            Number.prototype.add = function (val) {
                var len = getPointLen(this, val);
                return ((this * len) + (val * len)) / len;
            }

            //浮点型减法运算
            Number.prototype.subtract = function (val) {
                var len = getPointLen(this, val);
                return ((this * len) - (val * len)) / len;
            }

            //获取小数点最大长度
            function getPointLen(val1, val2) {
                var len1, len2;
                try {
                    len1 = val1.toString().split(".")[1].length;
                } catch (e) {
                    len1 = 0;
                }
                try {
                    len2 = val2.toString().split(".")[1].length;
                } catch (e) {
                    len2 = 0;
                }
                return Math.pow(10, Math.max(len1, len2));
            }

            //显示消息 type 1:成功 0：失败
            function showMsg(msg, type) {
                $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
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

            //校验货位产品唯一
            function verifyProductOnly(cBarCode) {
                var listOrder = viewModel.listOrder;
                if (listOrder && listOrder.length > 0) {
                    var array = []; //去重
                    for (var i = 0; i < listOrder.length; i++) {
                        if (array.indexOf(listOrder[i].ItemCode) === -1) {
                            array.push(listOrder[i].ItemCode)
                        }
                    }
                    if (array.length == 1) {
                        var result = isItemCanPlacedInWarehouseLocation("", array[0], cBarCode);
                        if (result == -1) {
                            return false;
                        }
                        if (result == 0) {
                            showMsg("当前库位不支持存放多种产品，请扫描其他库位！", 0);
                            $("#cwhCode").val("").focus();
                            return false;
                        }
                    }
                    else {
                        var isProductOnly = isItemCanPlacedInWarehouseLocation("", "", cBarCode);
                        if (isProductOnly == -1) {
                            return false;
                        }
                        if (isProductOnly == 1) {
                            showMsg("当前库位不支持存放多种产品，请扫描其他库位！", 0);
                            $("#cwhCode").val("").focus();
                            return false;
                        }
                    }
                }
                return true;
            }



            //设置物料默认库位
            function setWarehouseLocationMaterial(itemCode) {
                if (!viewModel.isSetDefault) {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseLocationMaterial.GetInfo(itemCode);
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message, 0);
                        return false;
                    }
                    var entity = ajax.value;
                    if (entity) {
                        $("#cwhCode").val(entity.CBarCode);
                        viewModel.isSetDefault = true;
                    }
                }
            }

        </script>

    </form>
</body>
</html>
