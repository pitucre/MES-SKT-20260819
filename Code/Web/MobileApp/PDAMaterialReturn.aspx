<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="PDAMaterialReturn.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAMaterialReturn" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>料塔-清空</title>
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
        th.need-qty, td.need-qty { display: none; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="page">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">料塔-清空</label>
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
                                <%--<option value="1">料塔清空</option>--%>
                                <option value="2">设备</option>
                            </select>
                        </td>
                    </tr>
                    <tr class="tr-return">
                        <td>
                            <label for="txtReturnOrder">
                                退料单</label>
                        </td>
                        <td>
                            <input id="txtReturnOrder" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="showReturnOrderPanel()">选择单据</a>
                        </td>
                    </tr>
                    <tr class="tr-apply" style="display: none;">
                        <td>
                            <label for="txtEquipmentCode">设备编码</label>
                        </td>
                        <td>
                            <input type="text" id="txtEquipmentCode" />
                        </td>
                        <td>
                            <a href="#fpanelEquipmentCode" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="showEquipmentCodePanel()">选择设备</a>
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
                        <li><a id="btn-query" onclick="Query()" data-corners="false" data-role="button" data-fullscreen="false" data-theme="a" class="ui-link ui-btn ui-btn-f ui-btn-inline ui-shadow">查询</a></li>
                        <li></li>
                        <li><a id="btn-canel" onclick="Cancel()" data-corners="false" data-role="button" data-fullscreen="false" data-theme="a" class="ui-link ui-btn ui-btn-f ui-btn-inline ui-shadow">取消</a></li>
                        <li></li>
                    </ul>
                </div>
                <table data-role="table" id="preparetab" data-mode="columntoggle:none" class="ui-responsive table-stroke" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>选择</th>
                            <th>物料编码</th>
                            <th class="need-qty">需求量</th>
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
                        <li><a onclick="Save()" data-role="button" data-fullscreen="true" data-theme="a">确认退料</a></li>
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
            <div data-role="panel" id="fpanelEquipmentCode" data-display="overlay">
                <a href="#" id="btnFilterEquipmentCode" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviewsEquipmentCode" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
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
            $("#txtReturnOrder,#txtItemCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
            $("#txtEquipmentCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
           
            //单据类型切换
            $("#perparelist").change(function () {                
                chageBill();
            });

            //扫描物料编码
            $("#txtItemCode").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Query(2);
                }
            });

            //扫描排程单事件
            $("#txtReturnOrder").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    getReturnOrderDetailInfo(null, 0);
                }
            });

            //输入退料单并进行筛选
            $("#listviews").on("filterablebeforefilter", function (e, data) {
                val = $(data.input).val();
                if (!val || val.length <= 2) {
                    return false;
                }
                searchReturnOrder(val);
            });

            //筛选退料单
            $("#btnFilter").on("click", function () {
                val = $.trim($("#fpanel input[data-type='search']").first().val());
                searchReturnOrder(val);
            });


            //扫描设备
            $("#txtEquipmentCode").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    getEquipmentCodeDetailInfo(null, 0);
                }
            });

            //输入设备并进行筛选
            $("#listviewsEquipmentCode").on("filterablebeforefilter", function (e, data) {
                val = $(data.input).val();
                if (!val || val.length <= 2) {
                    return false;
                }
                searchEquipmentCode(val);
            });

            //筛选设备
            $("#btnFilterEquipmentCode").on("click", function () {
                val = $.trim($("#fpanelEquipmentCode input[data-type='search']").first().val());
                searchEquipmentCode(val);
            });

            chageBill();
        });

        //下拉框改变事件
        function chageBill() {
            var val = $("#perparelist").val();
            if (val == "1") {
                $(".tr-return").hide();
                $(".tr-apply").hide();//临时隐藏
                $("#txtReturnOrder").val("").focus();
            } else {
                $(".tr-return").hide();
                $(".tr-apply").show();
                $("#txtEquipmentCode").val("").focus();
            }
            $("#preparetab tbody").html("");
        }

        //根据字符串模糊查询退料单
        function showReturnOrderPanel() {
            $("#listviews").listview("refresh");
        }

        //搜索、筛选退料单
        function searchReturnOrder(planNo) {
            $("#listviews").html("");
            var entity = {
                FBILLNO: planNo
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.GetMaterialTowerEquipmentCodeList(entity);
            if (ajax.error != null) {
                showMsg("获取排程单信息失败：" + ajax.error.Message, 0);
                return;
            }
            var list = ajax.value;
            var ulhtml = "";
            var entity = {};
            for (var i = 0; i < list.length; i++) {
                ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getReturnOrderDetailInfo(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].FBILLNO + "</a></li>";
            }
            $("#listviews").html(ulhtml);
            $("#listviews").listview("refresh");
        }

        //获取扫描明细信息  type 0：扫描 1：选择单据
        function getReturnOrderDetailInfo(entity, type) {
            showMsg("", 1);
            if (type == 0) {
                //扫描
                var planNo = $.trim($("#txtReturnOrder").val());
                if (planNo == "") {
                    showMsg("请输入退料单", 0);
                    $("#txtReturnOrder").val("").focus();
                    return;
                }
                entity = {
                    FBILLNO: planNo
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.GetMaterialTowerEquipmentCodeList(entity);
                if (ajax.error != null) {
                    showMsg("获取排程单信息失败：" + ajax.error.Message, 0);
                    return;
                }
                var list = ajax.value;
                if (!list || !list[0] || !list[0].FBILLNO) {
                    showMsg("排程单不存在或不是投产中状态", 0);
                    $("#txtReturnOrder").val("").focus();
                    return;
                }
                entity = list[0];
            } else {
                //选择单据后，获取txtItemCode信息
                $("#txtReturnOrder").val(entity.FBILLNO);
                $("input[data-type='search']").val('');
                $("#listviews").html('');
                $("#fpanel").panel("close");
                $("#txtGRN").focus();
            }
            $("#txtItemCode").focus();
        }

        //根据字符串模糊查询设备编码
        function showEquipmentCodePanel() {
            $("#listviewsEquipmentCode").listview("refresh");
        }

        //搜索、筛选设备编码
        function searchEquipmentCode(equipmentCode) {
            $("#listviewsEquipmentCode").html("");
            var entity = {
                EquipmentCode: equipmentCode
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.GetMaterialTowerEquipmentCodeList(entity);
            if (ajax.error != null) {
                showMsg("获取设备编码信息失败：" + ajax.error.Message, 0);
                return;
            }
            var list = ajax.value;
            var ulhtml = "";
            var entity = {};
            for (var i = 0; i < list.length; i++) {
                ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getEquipmentCodeDetailInfo(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].EquipmentCode + "</a></li>";
            }
            $("#listviewsEquipmentCode").html(ulhtml);
            $("#listviewsEquipmentCode").listview("refresh");
        }

        //获取扫描明细信息  type 0：扫描 1：选择单据
        function getEquipmentCodeDetailInfo(entity, type) {
            showMsg("", 1);

            var itemCode = $.trim($("#txtItemCode").val());

            if (type == 0) {
                //扫描
                var equipmentCode = $.trim($("#txtEquipmentCode").val());
                if (equipmentCode == "") {
                    showMsg("请输入设备编码", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return;
                }
                entity = {
                    EquipmentCode: equipmentCode,
                    ItemCode: itemCode
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.GetMaterialTowerEquipmentCodeList(entity);
                if (ajax.error != null) {
                    showMsg("获取设备信息失败：" + ajax.error.Message, 0);
                    return;
                }
                var list = ajax.value;
                if (!list || !list[0] || !list[0].EquipmentCode) {
                    showMsg("设备编码不存在或未上料", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return;
                }
                entity = list[0];
            } else {
                //选择单据后，获取txtItemCode信息
                $("#txtEquipmentCode").val(entity.EquipmentCode);
                $("input[data-type='search']").val('');
                $("#listviewsEquipmentCode").html('');
                $("#fpanelEquipmentCode").panel("close");

            }
            $("#txtItemCode").focus();
        }

        //查询
        function Query() {
            showMsg("");
            $("#preparetab tbody").html("");

            var billType = $("#perparelist").val();
            var itemCode = $.trim($("#txtItemCode").val());

            if (billType == "1") {
                ////清空料塔
                //var planNo = $.trim($("#txtReturnOrder").val());
                //if (planNo == "") {
                //    showMsg("请输入退料单", 0);
                //    $("#txtReturnOrder").val("").focus();
                //    return;
                //}
                //var entity =
                //{
                //    FBILLNO: planNo,
                //    ItemCode: itemCode
                //};
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.MaterialTowerGetPlanWarnGRN(entity);
                //if (ajax.error != null) {
                //    showMsg("获取数据失败：" + ajax.error.Message, 0);
                //    return;
                //}
                //var list = ajax.value;
                //if (list == null || list.length <= 0) {
                //    showMsg("没有需要取出的物料，请查看续料看板", 0);
                //    return false;
                //}
                //initDetail(list);
            } else {
                //设备
                var equipmentCode = $.trim($("#txtEquipmentCode").val());
                if (equipmentCode == "") {
                    showMsg("请输入设备编码", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return;
                }
                var entity =
                {
                    EquipmentCode: equipmentCode,
                    ItemCode: itemCode
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.GetMaterialTowerGRN(entity);
                if (ajax.error != null) {
                    showMsg("获取数据失败：" + ajax.error.Message, 0);
                    return;
                }
                var list = ajax.value;
                if (list == null || list.length <= 0) {
                    showMsg("未获取到GRN信息", 0);
                    return false;
                }
                initDetail(list);
            }
        }

        //加载明细数据
        function initDetail(list) {
            var hl = "";
            for (var i = 0; i < list.length; i++) {
                hl += "<tr grn=\"" + list[i].GRN + "\">" +
                    "<td><input type=\"checkbox\" class=\"check-grn\"></input></td>" +
                    "<td>" + list[i].ItemCode + "</td>" +
                    "<td class=\"need-qty\"></td>" +
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
            var arrCheckGRN = [];
            $("#preparetab tbody tr").each(function () {
                var grn = $(this).attr("grn");
                if ($(this).find(".check-grn").prop("checked")) {
                    arrCheckGRN.push(grn);
                }
                arrGRN.push(grn);
            });

            //如果有勾选，则只取勾选的GRN
            if (arrCheckGRN.length > 0) {
                arrGRN = arrCheckGRN;
            }
            if (arrGRN.length <= 0) {
                showMsg("没有需要取出的GRN", 0);
                return false;
            }

            var entity =
            {
                GRN: arrGRN.join(",")
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
