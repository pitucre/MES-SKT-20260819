<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MoldFixtureUpOrDown.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MoldFixtureUpOrDown" %>


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
    <title>模治具上下线</title>
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
    <form runat="server">
        <div data-role="page" id="pageOne">
            <div data-role="header" id="header1" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        模治具上下线
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar" data-theme="c">
                    <ul>
                        <li><a href="#pageOne" data-transition="none" class="ui-btn-active" data-theme="c">模治具上线</a></li>
                        <li><a href="#pageTwo" data-transition="none" data-theme="c">模治具下线</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <table style="width: 100%">

                    <%--<tr>
                        <td>
                            <label>
                                线别</label>
                        </td>
                        <td>
                            <select id="lineid" data-mini="true" onchange="changeLine()">
                                <option></option>
                            </select>
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <label for="showOrderNo">
                                机台</label>
                        </td>
                        <td>
                            <a href="#" data-transition="none" data-role="button" data-mini="true" onclick="schooseEqu();" data-ajax="false"
                                id="showEqu" data-theme="c">请选择</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="showOrderNo">
                                工单</label>
                        </td>
                        <td>
                            <a href="#" data-transition="none" data-role="button" data-mini="true" onclick="chooseOrder();" data-ajax="false"
                                id="showOrderNo" data-theme="c">请选择</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                模治具条码</label>
                        </td>
                        <td>
                            <input id="steelid" maxlength="50" />
                        </td>
                    </tr>


                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <div style="margin-top: 15px">
                    <table data-role="table" id="Steeltab" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>模治具编码</th>
                                <th>模治具名称</th>
                                <th>厂家模具编码</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Save" onclick="UpLine()" data-role="button" data-fullscreen="true"
                            data-theme="f">上线</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="OrderPanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listview" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>




        </div>
        <div data-role="page" id="pageTwo">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        模治具上下线
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar" data-theme="c">
                    <ul>
                        <li><a href="#pageOne" data-transition="none" data-theme="c">模治具上线</a></li>
                        <li><a href="#pageTwo" data-transition="none" class="ui-btn-active" data-theme="c">模治具下线</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label>
                                模治具条码</label>
                        </td>
                        <td>
                            <input id="steelid2" />
                        </td>
                    </tr>
                </table>
                <div id="msg2" style="text-align: center;">
                </div>
            </div>
            <div data-role="footer" data-position="fixed">
                <%-- <div data-role="navbar">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Wash" onclick="Wash()" data-role="button" data-fullscreen="true"
                            data-theme="a"></a></li>
                    </ul>
                </div>--%>
            </div>

        </div>

    </form>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var orderid = 0;
        var Items = []
        var flag = "";
        $(function () {

            $(".ui-body-c").css("background", "#fff");
            $(".ui-table-columntoggle-btn").css("display", "none");

            $("#lineid").html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.GetLineList();
            for (var i = 0; i < ajax.value.length; i++) {
                $("#lineid").append(" <option id='" + ajax.value[i].LineId + "'>" + ajax.value[i].LineName + "</option>");
            }
            $('#lineid').selectmenu('refresh', true);

            //筛选
            $("#btnFilter").on("click", function () {
                $("#listviews").html("");
                var $ul = $(this),
                    value = $.trim($("input[data-type='search']:eq(0)").val());

                if (flag == "Equ") {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.SearchMachine(value);
                    var htmlstr = "";
                    var data = ajax.value;
                    $('#listview').html('');
                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].EquipmentId + "' onclick=OrderListEqu(this)>" + data[i].EquipmentCode + "</li>";
                    }
                } else if (flag == "order") {
                    var equCode = $("#showEqu").html();
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.GetInjectMoudlLinePlanAll(equCode, value);
                    var htmlstr = "";
                    var data = ajax.value;
                    $('#listview').html('');
                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].ProdOrderID + "' onclick=OrderList('" + data[i].ProdOrderID + "','" + data[i].OrderNO + "')>" + data[i].OrderNO + "</li>";

                    }
                }

                $("#listview").append(htmlstr);
                $('#listview').listview('refresh');
            });

        })
        $(document).on("pageshow", function (event) {
            $(".ui-body-c").css("background", "#fff");
            $(".ui-table-columntoggle-btn").css("display", "none");
            var _id = location.hash;
            if (_id == "") {
                $("#pageOne div ul li a").each(function () {
                    if ($(this).attr("href") == "#pageOne") {
                        $(this).addClass("ui-btn-active");
                        return;
                    }
                });
                return false;
            }
            $(_id + " div ul li a").each(function () {

                if ($(this).attr("href") == _id) {
                    $(this).addClass("ui-btn-active");
                    return;
                }
            })
        });

        function OrderListEqu(ID) {
            $("#msg").html("");
            $("#steel").html("");
            $("#Steeltab tbody").html("");
            $("#showEqu").html($(ID).html());
            //var lineId = $("#lineid option:selected").attr("id");
            //var side = $("#table1 option:selected").attr("id");
            if ($(ID).attr("id")) { orderid = $(ID).attr("id") } else { orderid = ID; }
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMoldFixture.GetUpLineList(orderid, lineId, side);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMoldFixture.GetUpLineListByMoudle(orderid);
            data = JSON.parse(ajax.value).data;
            Items = data
            showDetail(Items)
            $("#OrderPanel").panel("close");
            $("#Steeltab").table("refresh");
            $("#msg").html("");
        }

        function OrderList(ID, OrderNo) {
            $("#showOrderNo").html(OrderNo);
            prodOrderId = ID;
            $("input[data-type='search']").val('');
            $("#OrderPanel").panel("close");

        }

        function changeLine() {
            OrderList(orderid);
        }


        //选择工单
        function chooseOrder() {

            var equCode = $("#showEqu").text()
            if (!equCode || equCode == '请选择') {
                confirmDialog("请先选择机台!")
                return
            }

            $("#OrderPanel").panel("open");
            flag = "order";
            $('#listview').html('');
            $("#listview").on("filterablebeforefilter", function (e, data) {

            });
        }

        function schooseEqu() {
            $("#OrderPanel").panel("open");
            flag = "Equ";
            $('#listview').html('');
            $("#listview").on("filterablebeforefilter", function (e, data) {

            });
        }



        $("#steelid").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                var code = $("#steelid").val()
                var showEqu = $("#showEqu").text()
                if (!showEqu || showEqu == '请选择') {
                    confirmDialog("请先选择机台!")
                    return
                }
                if (Items.some(item => item.EquipmentCode === code)) {
                    $("#msg").html("治具【" + code + "】已扫描").css("color", "red");
                    return;
                }

                var entity = {
                    OrderNo: showEqu,
                    EquipmentCode: code,
                    Type: 1
                }

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspMoldFixtureUpOrDownScan", JSON.stringify(entity))
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return
                }
                var json = JSON.parse(ajax.value)
                Items.push({
                    EquipmentId: json.data[0].EquipmentId,
                    EquipmentName: json.data[0].EquipmenName,
                    EquipmentCode: json.data[0].EquipmentCode,
                    FactoryMouldCode: json.data[0].FactoryMouldCode,
                })
                showDetail(Items)

                $("#steelid").val('').focus();
                $("#msg").html("扫描成功！").css("color", "#2ecc71");
            }
        });

        $("#steelid2").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                var code = $("#steelid2").val()

                if (!code) {
                    confirmDialog("扫描有效的模治具条码")
                }

                var entity = {
                    EquipmentCode: code,
                    UserName: userName
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMoldFixture.DownLine(JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg2").html("下线失败" + ajax.error.Message).css("color", "red");
                    $("#steelid2").val('').focus();
                    return false;
                }

                $("#steelid2").val('').focus();
                $("#msg2").html("下线成功！").css("color", "#2ecc71");
            }
        });

        function UpLine() {
            var EquipmentCodes = Items.filter(item => item.IsUp !== 1)
                .map(item => item.EquipmentCode)
                .join(',');

            //var lineId = $("#lineid option:selected").attr("id");
            if (EquipmentCodes.length <= 0) {
                confirmDialog("请扫描模治具");
                return
            }


            var mouldCode = $.trim($("#showEqu").html())
            if (mouldCode == "" || mouldCode == "请选择") {
                confirmDialog("请选择机台");
                return false;
            }
            var orderNo = $.trim($("#showOrderNo").html())
            if (orderNo == "" || orderNo == "请选择") {
                confirmDialog("请选择工单");
                return false;
            }

            var entity = {
                EquipmentCode: EquipmentCodes,   //模具
                MouldCode: mouldCode,
                ProdOrderCode: orderNo,
                UserName: userName
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMoldFixture.UpLine(JSON.stringify(entity));
            if (ajax.error != null) {
                confirmDialog(ajax.error.Message);
                return false;
            }
            confirmDialogFocus('上线成功', function () {
                window.location.reload()
            });
            return
        }
        function clears() {
            $("#steelid2").val("");
            $("#Tension").val("");
            $("#CheckResult").val("");
        }

        function showDetail(m) {
            var htmlstr = "";
            if (m.length == 0) {
                htmlstr += '<tr class="ListTableOddRow"><td colspan="3" style="text-align: center;">暂无数据</td></tr>';
            }
            else {
                for (var i = 0; i < m.length; i++) {
                    var status = m[i].IsUp == 1 ? '已上线' : '未上线'
                    htmlstr += "<tr class='ListTableOddRow'>";
                    htmlstr += "<td >" + m[i].EquipmentCode + "</td>";
                    htmlstr += "<td >" + m[i].EquipmentName + "</td>";
                    htmlstr += "<td >" + m[i].FactoryMouldCode + "</td>";
                    htmlstr += "<td >" + status + "</td>";
                    // 已上线的数据不能移除
                    if (!m[i].IsUp || m[i].IsUp == 0) {
                        htmlstr += "<td ><a href='#' onclick='RemoveCode(\"" + m[i].EquipmentCode + "\")'>清除</a></td >"
                    } else {
                        htmlstr += "<td ></td >"
                    }
                    htmlstr += "</tr>";
                }
            }
            $("#Steeltab tbody").html("");
            $("#Steeltab tbody").append(htmlstr);
        }

        function RemoveCode(EquipmentCode) {
            Items = Items.filter(item => item.EquipmentCode !== EquipmentCode);
            showDetail(Items)
        }

    </script>

</body>
</html>
