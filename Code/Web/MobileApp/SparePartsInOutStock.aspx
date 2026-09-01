<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SparePartsInOutStock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.SparePartsInOutStock" %>


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
    <title>工装治具出入库</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">工装治具出入库</label>
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
                                <option id="Out">出库</option>
                                <option id="In">入库</option>
                            </select>
                        </td>
                    </tr>
                    <tr id="SaveItem">
                        <td>
                            <label for="showOrderNo">
                                使用产品</label>
                        </td>
                        <td>
                            <a href="#OrderPanel" data-transition="none" data-role="button" data-mini="true" data-ajax="false"
                                id="showOrderNo" data-theme="c">请选择</a>
                        </td>
                    </tr>
                    <tr id="SaveStock">
                        <td>
                            <label>
                                存放库位</label>
                        </td>
                        <td>
                            <input id="txtStockNo" />
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
                    <tr>
                        <td>
                            <label>
                                数量</label>
                        </td>
                        <td>
                            <input id="txtSpareQty" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
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
            $(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");

                $(".ui-body-c").css("background", "#fff");
                $("#SaveStock").hide();
                $('#ddlOptionType').change(function () {
                    var type = $("#ddlOptionType option:selected").attr("id");
                    if (type == "Out") {
                        $("#SaveStock").hide();
                        $("#SaveItem").show();
                    }
                    else {
                        $("#SaveStock").show();
                        $("#SaveItem").hide();
                    }
                });

                //筛选
                $("#btnFilter").on("click", function () {
                    $("#listviews").html("");
                    var $ul = $(this),
                        value = $.trim($("input[data-type='search']:eq(0)").val());
                    var entity = {};
                    entity.ItemCode = value;
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetItemListInfo", JSON.stringify(entity));

                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        return false;
                    }
                    var htmlstr = "";
                    var mydata = JSON.parse(ajax.value);
                    $('#Orderlistview').html('');
                    for (var i = 0; i < mydata.data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + mydata.data[i].ItemID + "' onclick=OrderList(this)>" + mydata.data[i].ItemCode + "</li>";
                    }
                    $("#Orderlistview").append(htmlstr);
                    $('#Orderlistview').listview('refresh');

                });
            });

            function OrderList(ID) {
                $("#msg").html("");
                $("#steel").html("");
                $("#Steeltab tbody").html("");
                $("#showOrderNo").html($(ID).html());
                $("#OrderPanel").panel("close");
                $("#msg").html("");
                $("#steelid").focus().select();
            }

            $("#steelid").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var type = $("#ddlOptionType option:selected").attr("id");
                    //出库扫描工具编码校验工具编码与产品
                    if (type == "Out") {
                        if ($("#showOrderNo").html() == "" || $("#showOrderNo").html() == "请选择") {
                            $("#msg").html("请先选择产品信息在扫描工具编码").css("color", "red");
                            return;
                        }
                        if (!SaveCheck()) return;

                        if (OutStockQty == 1) {
                            $("#txtSpareQty").val(1);
                            Save();
                            return;
                        }
                        $("#txtSpareQty").val('').focus();
                        $("#msg").html("扫描成功！").css("color", "#2ecc71");
                    }
                    //入库扫描工具编码校验
                    else {
                        if (!SaveCheck()) return;

                        if (OnLineQty == 1) {
                            $("#txtSpareQty").val(1);
                            Save();
                            return;
                        }
                        $("#txtSpareQty").val('').focus();
                        $("#msg").html("扫描成功！").css("color", "#2ecc71");
                    }
                }
            });

            $("#txtStockNo").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#steelid").focus().select();
                }
            });

            //确认
            function Save() {
                var type = $("#ddlOptionType option:selected").attr("id");
                if (type == "Out") {
                    Out();
                }
                else {
                    In();
                }
            }

            //出库
            function Out() {

                if (!SaveCheck()) return;

                var PartNickName = $("#steelid").val();
                var OutQty = $("#txtSpareQty").val();

                if (PartNickName == "") {
                    $("#msg").html("请扫描工具编码").css("color", "red");
                    return;
                }
                if (parseInt(OutStockQty) == 0) {
                    $("#msg").html("当前工具条码在库数量为0！").css("color", "red");
                    return;
                }
                if (OutQty > parseInt(OutStockQty)) {
                    $("#msg").html("出库数量大于库存数量！").css("color", "red");
                    return;
                }

                var ItemCode = $("#showOrderNo").html();
                var entity = {};
                entity.PartNickName = PartNickName;
                entity.ItemCode = ItemCode;
                entity.OutQty = OutQty;
                entity.UserName = userName;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSparePartOutStock_PDA", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#steelid").val("").focus();
                    $("#txtSpareQty").val("");
                    return false;
                }
                $("#msg").html("出库成功！").css("color", "#2ecc71");
                $("#steelid").val("").focus();
                $("#txtSpareQty").val("");
                OutStockQty = 0;
            }
            //入库
            function In() {
                if (!SaveCheck()) return;

                var PartNickName = $("#steelid").val();
                var InQty = $("#txtSpareQty").val();
                if (PartNickName == "") {
                    $("#msg").html("请扫描工具编码").css("color", "red");
                    return;
                }
                if (OnLineQty == 0) {
                    $("#msg").html("当前工具条码在线数量为0！").css("color", "red");
                    return;
                }
                if (InQty > OnLineQty) {
                    $("#msg").html("入库数量大于在线数量！").css("color", "red");
                    return;
                }
                var PositionName = $("#txtStockNo").val();
                var entity = {};
                entity.PartNickName = PartNickName;
                entity.PositionName = PositionName;
                entity.InQty = InQty;
                entity.UserName = userName;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSparePartInStock_PDA", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                $("#msg").html("入库成功！").css("color", "#2ecc71");
                $("#steelid").val("").focus();
                //$("#txtStockNo").val("");
                $("#txtSpareQty").val("");
                OnLineQty = 0;
            }

            //modify by kqq 2024-09-20 实现SaveCheck方法
            function SaveCheck() {
                var PartNickName = $("#steelid").val();
                var ItemCode = $("#showOrderNo").html();
                var entity = {};
                entity.PartNickName = PartNickName;
                entity.ItemCode = ItemCode;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSparePartItemCodeIsCheck", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                var data = JSON.parse(ajax.value).data[0]
                OnLineQty = data.OnLineQty
                OutStockQty = data.InStockQty;
                return true;
            }
        </script>
    </form>
</body>
</html>
