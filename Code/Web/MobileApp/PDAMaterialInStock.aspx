<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="PDAMaterialInStock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAMaterialInStock" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>料塔-物料入库</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #fff">料塔-物料入库</label>
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
                            <label for="txtEquipmentNo">设备编码</label>
                        </td>
                        <td>
                            <input id="txtEquipmentNo" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                        <td>
                            <input class="ButtonBox" type="button" onclick="getEquipmentDetailInfo()" value="..." title="确认" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtGRNNo">物料GRN</label>
                        </td>
                        <td>
                            <input class="status" id="txtGRNNo" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                        <td>
                            <input class="ButtonBox" type="button" onclick="getGRNDetailInfo()" value="..." title="确认" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;"></div>

                <table data-role="table" id="scanGRN" data-mode="columntoggle:none" class="ui-responsive table-stroke" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>GRN</th>
                            <th>物料编码</th>
                            <th>库位</th>
                            <th>数量</th>
                            <th>消息</th>
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
            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>

        <script type="text/javascript">

            var modifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            $(document).ready(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $(".ui-body-c").css("background", "#fff");
                $("#txtEquipmentNo").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                $("#txtGRNNo").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC"); });

                //扫描工单事件
                $("#txtEquipmentNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        getEquipmentDetailInfo();
                    }
                });

                //输入设备编码并进行筛选
                $("#listviews").on("filterablebeforefilter", function (e, data) {
                    val = $(data.input).val();
                    if (!val || val.length <= 2) {
                        return false;
                    }
                    searchEquipment(val);
                });

                //筛选设备编码
                $("#btnFilter").on("click", function () {
                    val = $.trim($("#fpanel input[data-type='search']").first().val());
                    searchEquipment(val);
                });

                //物料条码 ，绑定扫描事件
                $("#txtGRNNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        getGRNDetailInfo();
                    }
                });
            });

            var entity = {};

            //验证设备信息
            function getEquipmentDetailInfo() {
                showMsg("", 1);
                //扫描
                var equipmentNo = $.trim($("#txtEquipmentNo").val());
                if (equipmentNo == "") {
                    showMsg("请输入设备编码", 0);
                    $("#txtEquipmentNo").val("").focus();
                    return false;
                }
                //验证设备编码是否存在
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentInfo({ EquipmentCode: equipmentNo });
                if (ajax.error != null) {
                    showMsg("获取设备信息失败：" + ajax.error.Message, 0);
                    $("#txtEquipmentNo").val("").focus();
                    return false;
                }
                var entity = ajax.value;
                if (!entity || !entity.EquipmentCode) {
                    showMsg("设备编码[" + equipmentNo + "]不存在", 0);
                    $("#txtEquipmentNo").val("").focus();
                    return false;
                }

                if (!entity.EquipmentIP) {
                    showMsg("请先维护设备IP地址", 0);
                    $("#txtEquipmentNo").val("").focus();
                    return false;
                }
                if (!entity.EquipmentPort) {
                    showMsg("请先维护设备端口", 0);
                    $("#txtEquipmentNo").val("").focus();
                    return false;
                }
                $("#txtGRNNo").val("").focus();
            }

            //扫描GRN
            function getGRNDetailInfo() {
                showMsg("", 1);
                //扫描
                var equipmentNo = $.trim($("#txtEquipmentNo").val());
                if (equipmentNo == "") {
                    showMsg("请输入设备编码", 0);
                    $("#txtEquipmentNo").val("").focus();
                    return false;
                }

                var grn = $.trim($("#txtGRNNo").val());
                if (grn == "") {
                    showMsg("请输入物料GRN", 0);
                    $("#txtGRNNo").val("").focus();
                    return;
                }

                var entity =
                {
                    EquipmentCode: equipmentNo,
                    GRN: grn
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.MaterialTowerInStorage(entity);
                if (ajax.error != null) {
                    showMsg("存料失败：" + ajax.error.Message, 0);
                    $("#txtGRNNo").val("").focus();
                    return;
                }
                var entity = ajax.value;
                $("#scanGRN tbody tr[grn=\"" + entity.GRN + "\"]").remove();
                var hl = "<tr grn=\"" + entity.GRN + "\"><td>" + entity.GRN + "</td><td>" + entity.ItemCode + "</td><td>" + entity.cBarCode + "</td><td>" + parseFloat(entity.BalanceQty) + "</td><td class=\"error-msg\" grn=\"" + entity.GRN + "\" style=\"color:#ff0000\"></td></tr>";
                $("#scanGRN tbody").prepend(hl);
                $("#txtGRNNo").val("").focus();
            }

            //确认（仅查看存料结果）
            function Save() {
                showMsg("", 1);

                var arrGRN = [];
                $("#scanGRN tbody tr").each(function () {
                    arrGRN.push($(this).attr("grn"));
                });
                if (arrGRN.length <= 0) {
                    showMsg("请先存料", 0);
                    return false;
                }

                var grns = arrGRN.join(",");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialTower.MaterialTowerInStorageQueryResult(grns);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return;
                }

                var list = ajax.value;
                if (list != null && list.length > 0) {
                    var arrMsg = [];
                    for (var i = 0; i < list.length; i++) {
                        if (list[i].Msg != "") {
                            arrMsg.push(list[i].Msg);
                        }
                        $("#scanGRN tbody td.error-msg[grn=\"" + list[i].GRN + "\"]").text(list[i].Msg);
                    }
                    if (arrMsg.length <= 0) {
                        showMsg("存料成功！", 1);
                        $("#scanGRN tbody").html("");
                        $("#txtGRNNo").val("").focus();
                    }
                }
                //else {
                //    showMsg("存料成功！", 1);
                //    $("#scanGRN tbody").html("");
                //    $("#txtGRNNo").val("").focus();
                //}

                //entity.EquipmentCode = $.trim($("#txtEquipmentNo").val());
                //entity.MaterialGRN = $.trim($("#txtGRNNo").val());
                ////扫描
                //if (entity.EquipmentCode == "") {
                //    showMsg("请扫描设备编码", 0);
                //    $("#txtEquipmentNo").val("").focus();
                //    return;
                //}

                //if (entity.MaterialGRN == "") {
                //    showMsg("请扫描GRN", 0);
                //    $("#txtGRNNo").val("").focus();
                //    return;
                //}

                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialPDA.MaterialInStock(JSON.stringify(entity), 0);
                //var ajaxValue = ajax.value;
                //if (ajaxValue.error != null) {
                //    showMsg(ajaxValue.error.Message, 0);
                //    return;
                //}
                //$("#txtGRNNo").val("");

                //showMsg("上料成功！", 1);
            }

            //根据字符串模糊查询采购单
            function getEquipmentOrder() {
                $("#listviews").listview("refresh");
            }

            //显示消息 type 1:成功 0：失败
            function showMsg(msg, type) {
                $("#msg").text(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
            }
        </script>
    </form>
</body>
</html>
