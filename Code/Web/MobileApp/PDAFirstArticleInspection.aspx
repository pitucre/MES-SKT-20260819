<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDAFirstArticleInspection.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAFirstArticleInspection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>首件送检</title>
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }
        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }
        .ui-title { line-height: 30px; }
        div.ui-body-c { background-color: #fff; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #fff">首件送检</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%; z-index: 2">
                    <tr>
                        <td>
                            <label for="txtOrderNo">工单</label>
                        </td>
                        <td>
                            <input id="txtOrderNo" data-corners="false" type="text" data-mini="true" value="" androidScan="true"/>
                        </td>
                        <%-- <td>
                            <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" style="margin-top: 22px" onclick="getOrder()">选择单据</a>
                        </td>--%>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div id="msg" style="text-align: center;"></div>
                        </td>
                    </tr>
                    <%--<tr>
                        <td>
                            <label>工单</label>
                        </td>
                        <td colspan="2">
                            <span id="OrderNo"></span>
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <label>机台</label>
                        </td>
                        <td>
                            <span id="EquipmentCode"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>产品编码</label>
                        </td>
                        <td>
                            <span id="ItemCode"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>产品名称</label>
                        </td>
                        <td>
                            <span id="ItemName"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>工单数量</label>
                        </td>
                        <td>
                            <span id="Qty_to_Build"></span>
                        </td>
                    </tr>
                </table>

                <table data-role="table" id="order-info" data-mode="columntoggle:none" class="ui-responsive table-stroke" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>名称</th>
                            <th>用量</th>
                            <th>可用数量</th>
                            <th>缺料数</th>
                            <th>状态</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a onclick="Save()" data-corners="false" data-role="button"
                            data-fullscreen="true" data-theme="a">确认</a></li>
                    </ul>
                </div>
            </div>

            <%-- <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>--%>

            <script type="text/javascript">
                var modifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
                $(document).ready(function () {
                    //隐藏columntoggle列表按钮
                    $(".ui-table-columntoggle-btn").css("display", "none");
                    $(".ui-body-c").css("background", "#fff");
                    $("#txtOrderNo").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();

                    //扫描工单事件
                    $("#txtOrderNo").on("keydown", function (e) {
                        var curKey = 0, e = e || window.event;
                        curKey = e.keyCode || e.which || e.charCode;
                        if (curKey == 13) {
                            showMsg("", 1);
                            var orderNo = $.trim($("#txtOrderNo").val());
                            if (orderNo == "") {
                                showMsg("请输入工单号", 0);
                                $("#txtOrderNo").val("").focus();
                                return;
                            }
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.FirstArticleInspection({ OrderNo: orderNo }, 0);
                            if (ajax.error != null) {
                                showMsg(ajax.error.Message, 0);
                                $("#txtOrderNo").val("").focus();
                                return false;
                            }
                            //debugger;
                            var entity = ajax.value;
                            $("#EquipmentCode").text(entity.EquipmentCode);
                            $("#ItemCode").text(entity.ItemCode);
                            $("#ItemName").text(entity.ItemName);
                            $("#Qty_to_Build").text(entity.Qty_to_Build);

                            //齐套情况
                            GetOrderKitting(orderNo, 0);

                            return false;
                            //getOrderDetailInfo(null, 0);
                        }
                    });

                    ////输入工单号并进行筛选
                    //$("#listviews").on("filterablebeforefilter", function (e, data) {
                    //    var val = $(data.input).val();
                    //    if (!val || val.length <= 2) {
                    //        return false;
                    //    }
                    //    searchOrder(val);
                    //});

                    ////筛选工单号
                    //$("#btnFilter").on("click", function () {
                    //    var val = $.trim($("#fpanel input[data-type='search']").first().val());
                    //    searchOrder(val);
                    //});

                });

                //搜索、筛选工单号
                //function searchOrder(OrderNo) {
                //    $("#listviews").html("");
                //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetReleaseOrderList({ OrderNO: OrderNo }, 0);
                //    if (ajax.error != null) {
                //        showMsg(ajax.error.Message, 0);
                //        $("#txtOrderNo").val("").focus();
                //        return false;
                //    }
                //    var list = ajax.value;
                //    var ulhtml = "";
                //    for (var i = 0; i < list.length; i++) {
                //        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getOrderDetailInfo(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].OrderNO + "</a></li>";
                //    }
                //    $("#listviews").html(ulhtml);
                //    $("#listviews").listview("refresh");
                //}

                //获取工单明细信息  type 0：扫描 1：选择单据
                //function getOrderDetailInfo(entity, type) {
                //    showMsg("", 1);
                //    if (type == 0) {
                //        //扫描
                //        var orderNo = $.trim($("#txtOrderNo").val());
                //        if (orderNo == "") {
                //            showMsg("请输入工单号", 0);
                //            $("#txtOrderNo").val("").focus();
                //            return;
                //        }
                //        //获取工单明细信息
                //        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetReleaseOrderList({ OrderNO: OrderNo }, type);
                //        if (ajax.error != null) {
                //            showMsg(ajax.error.Message, 0);
                //            $("#txtOrderNo").val("").focus();
                //            return false;
                //        }
                //        entity = ajax.value;
                //        if (!entity.OrderNo) {
                //            showMsg("工单号不存在", 0);
                //            $("#txtOrderNo").val("").focus();
                //            return false;
                //        }
                //    } else {
                //        //选择单据后，获取工单明细信息
                //        $("#txtOrderNo").val(entity.OrderNo);
                //        $("input[data-type='search']").val('');
                //        $("#listviews").html('');
                //        $("#fpanel").panel("close");
                //        $("#txtGRN").focus();
                //    }
                //    //$("#OrderNo").text(entity.OrderNO);
                //    $("#EquipmentCode").text(entity.EquipmentCode);
                //    $("#ItemCode").text(entity.ItemCode);
                //    $("#ItemName").text(entity.ItemName);
                //    $("#Qty_to_Build").text(entity.Qty_to_Build);
                //}

                //确认
                function Save() {
                    showMsg("", 1);

                    var orderNo = $.trim($("#txtOrderNo").val());
                    if (orderNo == "") {
                        showMsg("请输入工单号", 0);
                        $("#txtOrderNo").val("").focus();
                        return;
                    }
                    if (confirm("请确定工单[" + orderNo + "]推送首件单")) {
                        var kittingFlag = GetOrderKitting(orderNo, 1);
                        if (!kittingFlag) {
                            if (!confirm("未齐套，请确定是否继续生产！")) {
                                return false;
                            }
                        }

                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.FirstArticleInspection({ OrderNo: orderNo }, 1);
                        if (ajax.error != null) {
                            showMsg(ajax.error.Message, 0);
                            $("#txtOrderNo").val("").focus();
                            return false;
                        }
                        $("#EquipmentCode").text("");
                        $("#ItemCode").text("");
                        $("#ItemName").text("");
                        $("#Qty_to_Build").text("");
                        $("#txtOrderNo").val("").focus();
                        showMsg("工单[" + orderNo + "]推送首件单成功！", 1);
                        $("#order-info tbody").html("");
                    }
                    return false;
                }

                //工单齐套数
                function GetOrderKitting(orderNo, type) {
                    $("#order-info tbody").html("");
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetOrderKitting(orderNo);
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message, 0);
                        $("#txtOrderNo").val("").focus();
                        return false;
                    }
                    var list = ajax.value.Rows;
                    var hl = "";
                    var kittingFlag = true;
                    for (var i = 0; i < list.length; i++) {
                        hl += "<tr>" +
                            "<td>" + list[i].ItemName + "</td>" +
                            "<td>" + list[i].PerNum + "</td>" +
                            "<td>" + list[i].BalanceQty + "</td>" +
                            "<td>" + list[i].ShortageQty + "</td>" +  //缺料数
                            "<td>" + list[i].KittingStatus + "</td>" +    //状态
                            "</tr>";
                        if (list[i].ShortageQty > 0) {
                            kittingFlag = false;
                        }
                    }
                    $("#order-info tbody").html(hl);
                    if (type == 1) {
                        return kittingFlag;
                    }
                }

                //根据字符串模糊查询采购单
                //function getOrderOrder() {
                //    $("#listviews").listview("refresh");
                //}

                //显示消息 type 1:成功 0：失败
                function showMsg(msg, type) {
                    $("#msg").text(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
                }
            </script>
    </form>
</body>
</html>
