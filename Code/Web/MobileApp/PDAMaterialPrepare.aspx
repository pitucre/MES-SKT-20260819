<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="PDAMaterialPrepare.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAMaterialPrepare" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-9" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <script src="js/jqpaginator.js" type="text/javascript"></script>
    <script src="js/jsrender.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <title>料塔-工单取料</title>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }
        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }
        .ui-title { line-height: 30px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="page">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">料塔-工单取料</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <label for="perparelist">单据类型</label>
                        </td>
                        <td colspan="2">
                            <select name="select-custom-20" id="perparelist" data-mini="true" class="perparelist">
                                <option value="1">工单号</option>
                                <option value="2">领料单</option>
                            </select>
                        </td>
                    </tr>
                    <tr class="tr-plan">
                        <td>
                            <label for="txtPlanOrder">
                                排程单号</label>
                        </td>
                        <td>
                            <input id="txtPlanOrder" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="showPlanOrderPanel()">选择单据</a>
                        </td>
                    </tr>
                    <tr class="tr-apply" style="display: none;">
                        <td>
                            <label for="txtApplyNo">领料单号</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtApplyNo" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtItemCode">物料编码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtItemCode" androidscan="true" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;"></div>
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li></li>
                        <li><a id="btn-query" onclick="Prepare()" data-corners="false" data-role="button" data-fullscreen="false" data-theme="a" class="ui-link ui-btn ui-btn-f ui-btn-inline ui-shadow">备料</a></li>
                        <li></li>
                        <li><a id="btn-canel" onclick="Cancel()" data-corners="false" data-role="button" data-fullscreen="false" data-theme="a" class="ui-link ui-btn ui-btn-f ui-btn-inline ui-shadow">取消</a></li>
                        <li></li>
                    </ul>
                </div>
                <table data-role="table" id="preparetab" data-mode="columntoggle:none" class="ui-responsive table-stroke" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>物料编码</th>
                            <th>需求量</th>
                            <th>货位</th>
                            <th>GRN</th>
                            <th>数量</th>
                            <th>状态</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <div data-role="popup" id="myPopup" class="ui-content" data-position-to="#myId" data-overlay-theme="b">
                    <ul data-role="listview" id="worklist" style="margin-top: -265px; align-content: center">
                    </ul>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="StartCheck" onclick="Save()" data-role="button"
                            data-fullscreen="true" data-theme="a">确认备料</a></li>
                    </ul>
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
    </form>
    <script src="js/jqPaginator.js" type="text/ecmascript"></script>
    <script type="text/javascript">
        var batchNo = "";

        $(function () {
            $(".ui-body-c").css("background", "#fff");
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#txtPlanOrder,#txtItemCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
            $("#txtApplyNo").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
            $("#txtPlanOrder").val("").focus();

            //单据类型切换
            $("#perparelist").change(function () {
                var val = $(this).val();
                if (val == "1") {
                    $(".tr-plan").show();
                    $(".tr-apply").hide();
                    $("#btn-query").text("备料");
                    $("#txtPlanOrder").val("").focus();
                } else {
                    $(".tr-plan").hide();
                    $(".tr-apply").show();
                    $("#btn-query").text("查询");
                    $("#txtApplyNo").val("").focus();
                }
            });

            //扫描领料单
            $('#txtApplyNo').on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var applyNo = $.trim($("#txtApplyNo").val());
                    if (applyNo == "") {
                        showMsg("请输入领料单号", 0);
                        $("#txtApplyNo").val("").focus();
                        return;
                    }
                    Prepare(1);
                }
            });

            //扫描物料编码
            $("#txtItemCode").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Prepare(2);
                }
            });

            //扫描排程单事件
            $("#txtPlanOrder").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    getPlanOrderDetailInfo(null, 0);
                }
            });

            //输入排程单号并进行筛选
            $("#listviews").on("filterablebeforefilter", function (e, data) {
                val = $(data.input).val();
                if (!val || val.length <= 2) {
                    return false;
                }
                searchPlanOrder(val);
            });

            //筛选排程单号
            $("#btnFilter").on("click", function () {
                val = $.trim($("#fpanel input[data-type='search']").first().val());
                searchPlanOrder(val);
            });

        });

        //根据字符串模糊查询采购单
        function showPlanOrderPanel() {
            $("#listviews").listview("refresh");
        }

        //搜索、筛选排程单号
        function searchPlanOrder(planNo) {
            $("#listviews").html("");
            var entity = {
                FBILLNO: planNo
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.GetPlanOrderList(entity);
            if (ajax.error != null) {
                showMsg("获取排程单信息失败：" + ajax.error.Message, 0);
                return;
            }
            var list = ajax.value;
            var ulhtml = "";
            var entity = {};
            for (var i = 0; i < list.length; i++) {
                ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getPlanOrderDetailInfo(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].FBILLNO + "</a></li>";
            }
            $("#listviews").html(ulhtml);
            $("#listviews").listview("refresh");
        }

        //获取扫描明细信息  type 0：扫描 1：选择单据
        function getPlanOrderDetailInfo(entity, type) {
            showMsg("", 1);
            if (type == 0) {
                //扫描
                var planNo = $.trim($("#txtPlanOrder").val());
                if (planNo == "") {
                    showMsg("请输入排程单号", 0);
                    $("#txtPlanOrder").val("").focus();
                    return;
                }
                entity = {
                    FBILLNO: planNo
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.GetPlanOrderList(entity);
                if (ajax.error != null) {
                    showMsg("获取排程单信息失败：" + ajax.error.Message, 0);
                    return;
                }
                var list = ajax.value;
                if (!list || !list[0] || !list[0].FBILLNO) {
                    showMsg("排程单不存在或不是投产中状态", 0);
                    $("#txtPlanOrder").val("").focus();
                    return;
                }
                entity = list[0];
            } else {
                //选择单据后，获取txtItemCode信息
                $("#txtPlanOrder").val(entity.FBILLNO);
                $("input[data-type='search']").val('');
                $("#listviews").html('');
                $("#fpanel").panel("close");
                $("#txtGRN").focus();
            }
            $("#txtItemCode").focus();
        }

        //备料
        function Prepare(type) {
            showMsg("");
            $("#preparetab tbody").html("");

            var billType = $("#perparelist").val();
            var itemCode = $.trim($("#txtItemCode").val());

            if (billType == "1") {
                //工单
                var planNo = $.trim($("#txtPlanOrder").val());
                if (planNo == "") {
                    showMsg("请输入排程单号", 0);
                    $("#txtPlanOrder").val("").focus();
                    return;
                }
                var entity =
                {
                    FBILLNO: planNo,
                    ItemCode: itemCode
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.MaterialTowerGetPlanWarnGRN(entity);
                if (ajax.error != null) {
                    showMsg("获取数据失败：" + ajax.error.Message, 0);
                    return;
                }
                var list = ajax.value;
                if (list == null || list.length <= 0) {
                    showMsg("没有需要取出的物料，请查看续料看板", 0);
                    return false;
                }
                initDetail(list, "");
            } else {
                //领料单
                var applyNo = $.trim($("#txtApplyNo").val());
                if (applyNo == "") {
                    showMsg("请输入领料单号", 0);
                    $("#txtApplyNo").val("").focus();
                    return;
                }
                var entity =
                {
                    ApplyNo: applyNo,
                    ItemCode: itemCode
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.MaterialTowerGetApplyGRN(entity);
                if (ajax.error != null) {
                    showMsg("获取数据失败：" + ajax.error.Message, 0);
                    return;
                }
                var list = ajax.value;
                if (list == null || list.length <= 0) {
                    showMsg("未获取到领料单明细信息", 0);
                    return false;
                }
                initDetail(list, applyNo);
            }
        }

        //加载明细数据
        function initDetail(list, applyNo) {
            var hl = "";
            for (var i = 0; i < list.length; i++) {
                hl += "<tr style=\"color:" + (list[i].GRN == "" ? "#ff0000" : "") + "\" grn=\"" + list[i].GRN + "\" applyNo=\"" + applyNo + "\">" +
                    "<td>" + list[i].ItemCode + "</td>" +
                    "<td>" + list[i].NeedQty + "</td>" +
                    "<td>" + list[i].cBarCode + "</td>" +
                    "<td>" + list[i].GRN + "</td>" +
                    "<td>" + list[i].BalanceQty + "</td>" +
                    "<td></td>" +
                    "</tr>";
            }
            $("#preparetab tbody").html(hl);
        }

        //确认
        function Save() {
            showMsg("");
            batchNo = "";
            var arrGRN = [];
            var applyNo = "";
            $("#preparetab tbody tr").each(function () {
                var grn = $(this).attr("grn");
                if (grn != "" && grn != undefined) {
                    applyNo = $(this).attr("applyNo");
                    arrGRN.push($(this).attr("grn"));
                }
            });
            if (arrGRN.length <= 0) {
                showMsg("没有需要取出的GRN", 0);
                return false;
            }

            var entity =
            {
                GRN: arrGRN.join(","),
                ApplyNo: applyNo,
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.MaterialTowerOutStorage(entity);
            var list = ajax.value;
            if (ajax.error != null) {
                showMsg("取料失败：" + ajax.error.Message, 0);
                return;
            } else {
                showMsg("亮灯成功，请取出物料", 1);
            }
            batchNo = list[0].BatchNo;
            //if (list != null || list.length > 0) {
            //    $("#preparetab tbody tr[grn=\"" + list[i].GRN + "\"]");
            //    return false;
            //}
        }

        //取消
        function Cancel() {
            showMsg("");
            if (batchNo == "") {
                showMsg("未获取到需要取消取料批次", 0);
                return;
            }
            var entity = {
                BatchNo: batchNo
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.MaterialTowerCancelOutStorage(entity);
            if (ajax.error != null) {
                showMsg("取消失败：" + ajax.error.Message, 0);
                return;
            } else {
                showMsg("取消成功", 1);
                $("#preparetab tbody").html("");
            }
        }

        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").text(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }
    </script>
</body>
</html>
