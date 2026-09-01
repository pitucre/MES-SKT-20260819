<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AccessoryLoading.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.AccessoryLoading" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>辅料上料校验</title>
    <style type="text/css">
        .clear {
            clear: both;
            height: 2px;
        }

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
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" id="pageOne">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/Acc_w.png" />
                    </div>
                    <div>
                        辅料校验
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>

                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-theme="c">设置</a></li>
                        <li><a href="#pageTwo" data-transition="none" data-theme="c">上料</a></li>
                        <li><a href="#Search" data-transition="none" data-theme="c" onclick="Search();">查询</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <label for="showOrderNo">工单</label>
                    <a href="#OrderPanel" data-transition="none" data-role="button"  data-ajax="false" id="showOrderNo" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>
                    <label for="showRes" class="Field">线别</label>
                    <a href="#LinePanel" data-transition="none" data-role="button"  data-ajax="false" id="showMachie" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>
                    <label for="showRes" class="Field">工序</label>
                     <a href="#StationPanel" data-transition="none" data-role="button"  data-ajax="false" id="showStation" data-theme="c">请选择</a>
                </div>
            </div>
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-transition="none" data-theme="f" onclick="next()">下一步</a></li>
                    </ul>
                </div>
            </div>

            <div data-role="panel" id="OrderPanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">查 询</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="Orderlistview" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>

            <div data-role="panel" id="LinePanel" style="background: #f9f9f9">
                <a href="#" id="btnLineFilter" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">查 询</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="Linelistview" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
            <div data-role="panel" id="StationPanel" style="background: #f9f9f9">
                <a href="#" id="btnStationFilter" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">查 询</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="Stationlistview" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>
        <div data-role="page" id="pageTwo">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/Acc_w.png" />
                    </div>
                    <div>
                        辅料校验
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>

                <div data-role="navbar">
                    <ul>
                        <li><a href="#pageOne" data-theme="c">设置</a></li>
                        <li><a href="#" data-transition="none" data-theme="c">上料</a></li>
                        <li><a href="#Search" data-transition="none" data-theme="c" onclick="Search();">查询</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <table style="width: 100%" id="loadingtab">
                        <tr>
                            <td>
                                <label for="txtGRN">
                                    GRN</label></td>
                            <td>
                                <input type="text" name="fGRN" id="txtGRN" /></td>
                        </tr>
                    </table>
                    <div id="msg" style="text-align: center"></div>
                    <div style="display: none" id="showCheck">
                        <label for="lblMItemCode">
                            物料代码</label>
                        <span id="lblMItemCode"></span>
                        <label>
                            可用数量</label>
                        <span id="lblQty"></span>
                        <label for="lblMItemName">
                            物料名称</label>
                        <span id="lblMItemName"></span>
                    </div>
                    <label id="showMaterialMsg">
                    </label>
                </div>
            </div>
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-transition="none" data-theme="f" onclick="Check();">上料检验</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div data-role="page" id="Search">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/Acc_w.png" />
                    </div>
                    <div>
                        辅料校验
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>

                <div data-role="navbar" data-theme="c">
                    <ul>
                        <li><a href="#pageOne" data-transition="none" data-theme="c">设置</a></li>
                        <li><a href="#pageTwo" data-transition="none" data-theme="c">上料</a></li>
                        <li><a href="#" data-transition="none" data-theme="c" onclick="Search();">查询</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <table id="Infotab" data-role="table" class="ui-responsive" style="width: 100%">
                    <thead>
                        <tr>
                            <th>辅料条码
                            </th>
                            <th>辅料数量
                            </th>
                            <th>辅料单位
                            </th>
                            <th>辅料编码
                            </th>
                            <th>辅料名称
                            </th>
                            <th>工单号
                            </th>
                            <th>工单数量
                            </th>
                            <th>产品编码
                            </th>
                            <th>产品名称
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div data-role="panel" id="SOrderPanel" style="background: #f9f9f9">
                <div data-role="content">
                    <ul data-role="listview" id="SOrderlistview" data-inset="true" data-filter="true" data-filter-placeholder="搜索"
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var OrderNo = "";
            var Line = -99;
            var Station = -99;
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() }).focus();
            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("body>[data-role='listview']").listview();
                $(".ui-select").css({ "margin": 0 });
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                //chooseOrder();

                //筛选
                $("#btnFilter").on("click", function () {
                    $("#listviews").html("");
                    var $ul = $(this),
                        value = $.trim($("input[data-type='search']:eq(0)").val());
                    if (value.length == 0) {
                        return;
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.GetOrderListBySearch(value);
                    var htmlstr = "";
                    var data = ajax.value;
                    $('#Orderlistview').html('');
                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].ProdOrderID + "' onclick=OrderList(this)>" + data[i].OrderNO + "</li>";
                    }
                    $("#Orderlistview").append(htmlstr);
                    $('#Orderlistview').listview('refresh');
                });
                //线别刷选 add by peter on 2021-2-3
                $("#btnLineFilter").on("click", function () {
                    if ($("#showOrderNo").html() == "") {
                        confirmDialog("工单不能为空");
                        return false;
                    }
                    $("#listviews").html("");
                    var $ul = $(this),
                        value = $.trim($("input[data-type='search']:eq(1)").val());
                    
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.GetLineListBySearch(value);
                    var htmlstr = "";
                    var data = ajax.value;
                    $('#Linelistview').html('');
                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].LineId + "' onclick=LineList(this)>" + data[i].LineName + "</li>";
                    }
                    $("#Linelistview").append(htmlstr);
                    $('#Linelistview').listview('refresh');
                });

                //工序刷选 add by peter on 2021-2-3
                $("#btnStationFilter").on("click", function () {
                    if ($("#showOrderNo").html() == "") {
                        confirmDialog("工单不能为空");
                        return false;
                    }
                    $("#listviews").html("");
                    var $ul = $(this),
                        value = $.trim($("input[data-type='search']:eq(2)").val());
                    
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.GetStationListBySearch(value);
                    var htmlstr = "";
                    var data = ajax.value;
                    $('#Stationlistview').html('');
                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].StationId + "' onclick=StationList(this)>" + data[i].Station + "</li>";
                    }
                    $("#Stationlistview").append(htmlstr);
                    $('#Stationlistview').listview('refresh');
                });
            });

            $("#Orderlistview").on("filterablebeforefilter", function (e, data) {
                return false;
            });

            $(document).bind("mobileinit", function () {
                $.mobile.ajaxEnabled = false;
            });
            //选择工单
            function chooseOrder() {
                $("#OrderPanel").panel("open");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.GetPlanOrderList();
                if (ajax.error != null) {
                    confirmDialog(ajax.error);
                }
                var data = ajax.value;
                var htmlstr = "";
                $('#Orderlistview').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].Code + "' onclick=OrderList(this)>" + data[i].Name + "</li> ";
                }
                $("#Orderlistview").append(htmlstr);
                $('#Orderlistview').listview('refresh');
            }
            function OrderList(ID) {
                $("#showMachie").html("请选择");
                $("#showOrderNo").html($(ID).html());
                OrderNo = $(ID).html();
                $("input[data-type='search']").val('');
                $("#OrderPanel").panel("close");
                $("#showMachie")[0].click();
            }
            /*选择线别 update by peter on 2021-2-3
            function chooseLine() {
                $("#LinePanel").panel("open");
                if ($("#showOrderNo").html() == "") {
                    confirmDialog("工单不能为空");
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.GetLineList();
                if (ajax.error != null) {
                    confirmDialog(ajax.error);
                }
                var data = ajax.value;
                var htmlstr = "";
                $('#Linelistview').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'  id='" + data[i].Code + "'  onclick=LineList(this)>" + data[i].Name + "</li> ";
                }
                $("#Linelistview").append(htmlstr);
                $('#Linelistview').listview('refresh');
            }*/
            
            function LineList(ID) {
                $("#showMachie").html($(ID).html());
                Line = $(ID).attr("id");
                $("input[data-type='search']").val('');
                $("#LinePanel").panel("close");
                $("#showStation")[0].click();
            }

            /*选择工序 update by peter on 2021-2-3
            function chooseStation() {
                $("#StationPanel").panel("open");
                if ($("#showOrderNo").html() == "") {
                    confirmDialog("工单不能为空");
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.GetStationList();
                if (ajax.error != null) {
                    confirmDialog(ajax.error);
                }
                var data = ajax.value;
                var htmlstr = "";
                $('#Stationlistview').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'  id='" + data[i].Code + "'   onclick=StationList(this)>" + data[i].Name + "</li> ";
                }
                $("#Stationlistview").append(htmlstr);
                $('#Stationlistview').listview('refresh');
            }*/

            function StationList(ID) {
                $("#showStation").html($(ID).html());
                Station = $(ID).attr("id");
                $("input[data-type='search']").val('');
                $("#StationPanel").panel("close");
            }
            //跳转  下一步
            function next() {
                if ($("#showOrderNo").html() == "请选择") {
                    confirmDialog("请选择工单");
                    return false;
                }
                if ($("#showMachie").html() == "请选择") {
                    confirmDialog("请选择线别");
                    return false;
                }
                if ($("#showStation").html() == "请选择") {
                    confirmDialog("请选择工序");
                    return false;
                }
                $.mobile.changePage("#pageTwo", { transition: 'none' });
            }
            $(document).on("pageshow", "#pageTwo", function (event) {
                $("#txtGRN").focus();
            });
            $(document).on("pageshow", "#Search", function (event) {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
            });
            $("#txtGRN").on("keydown", function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Check();
                }
            });
            function Check() {
                $("#msg").html("");
                if ($("#txtGRN").val() == "") {
                    confirmDialogFocus("条码不能为空", function () {
                        $("#txtGRN").val("").focus();
                        return false;
                    });
                    return false;
                }
                if (OrderNo == "") {
                    confirmDialog("请选择工单")
                    return false;
                }
                if (Line == -99) {
                    confirmDialog("请选择线别")
                    return false;
                }
                if (Station == -99) {
                    confirmDialog("请选择工序")
                    return false;
                }
                var SN = $("#txtGRN").val();

                //2018.06.06
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryThawValidate(SN);
                if (ajax.value != null && ajax.value != "") {
                    //提示：该辅料已达到设定的最大使用次数，是否现在报废？ 或者 该辅料已达到设定的最大解冻次数，是否现在报废？
                    if (confirm(ajax.value)) {
                        ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(SN, 6, userName);
                        if (ajax.error != null) {
                            confirmDialog(ajax.error.Message);
                            return false;
                        }
                        $("#msg").html("报废成功").css('color', "#2ecc71");
                        $("#txtGRN").val("").focus();
                        return false;
                    } else {
                        return false;
                    }
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.Check(SN, OrderNo, Line, Station, userName);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css('color','red');
                    $("#txtGRN").val("").focus();
                    return false;
                    //confirmDialogFocus(ajax.error.Message, function () {
                    //    $("#txtGRN").val("").focus();
                    //});
                }
                $("#msg").html(SN+" 条码扫描成功。").css("color", "#2ecc71");
                $("#txtGRN").val("").focus();
                SerialNumberShow(SN);
            }
            function SerialNumberShow(SN) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.PDASearch(SN, OrderNo);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                }
                $("#Infotab tbody").html("");
                var html = "";
                for (var i = 0; i < ajax.value.length; i++) {
                    $("#Infotab tbody").append("<tr><td>" + ajax.value[0].SerialNumber + "</td><td>" + ajax.value[0].InStockQty + "</td>"
                        + "<td>" + ajax.value[0].UnitName + "</td>" + "<td>" + ajax.value[0].AccessoryCodoe + "</td>"
                        + "<td>" + ajax.value[0].AccessoryName + "</td>" + "<td>" + ajax.value[0].OrderNO + "</td>"
                        + "<td>" + ajax.value[0].OrderQty + "</td>" + "<td>" + ajax.value[0].ItemCode + "</td>"
                        + "<td>" + ajax.value[0].ItemName + "</td></tr>");
                }
                $("#Infotab").table("refresh");
            }
        </script>
    </form>
</body>
</html>
