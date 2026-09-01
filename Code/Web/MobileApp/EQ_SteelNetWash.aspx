<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EQ_SteelNetWash.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.EQ_SteelNetWash" %>


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
    <title>仓库收料</title>
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
        }    .ui-title {
            line-height: 30px;
            
        }
    </style>
</head>
<body>
    <form runat="server">
        <div data-role="page" id="pageOne">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                     <div>
                          钢网/刮刀下线清洗
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar" data-theme="c">
                    <ul>
                        <li><a href="#pageOne" data-transition="none" class="ui-btn-active" data-theme="c">钢网/刮刀下线</a></li>
                        <li><a href="#pageTwo" data-transition="none" data-theme="c">钢网/刮刀清洗</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label>
                                钢网/刮刀条码</label>
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
                                <th>类型
                                </th>
                                <th>钢网/刮刀条码
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
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Save" onclick="Save(1)" data-role="button" data-fullscreen="true"
                            data-theme="f">下线</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div data-role="page" id="pageTwo">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                     <div>
                          钢网/刮刀下线清洗
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar" data-theme="c">
                    <ul>
                        <li><a href="#pageOne" data-transition="none"  data-theme="c">钢网/刮刀下线</a></li>
                        <li><a href="#pageTwo" data-transition="none" class="ui-btn-active" data-theme="c">钢网/刮刀清洗</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label>
                                钢网/刮刀条码</label>
                        </td>
                        <td>
                            <input id="steelid2" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                张力</label>
                        </td>
                        <td>
                            <input id="Tension" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                外观</label>
                        </td>
                        <td>
                            <input id="CheckResult" />
                        </td>
                    </tr>
                </table>
                <div id="msg2" style="text-align: center;">
                </div>
            </div>
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Wash" onclick="Wash()" data-role="button" data-fullscreen="true"
                            data-theme="a">清洗</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $(document).on("pageshow", function (event) {
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
        $("#steelid").on("keydown", function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                Save(0);
            }
        });
        function OrderList(EquipmentCode) {
            $("#msg").html("");
            ////$("#Steeltab tbody").html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.GetOrderDownLineList(EquipmentCode);
            data = ajax.value;
            for (var i = 0; i < data.length; i++) {
                $("#Steeltab tbody").append("<tr><td>" + data[i].SteelTypeName + "</td><td>" + data[i].SteelCode +
                    "</td><td> <a href='javascript:void(0);' data-rel='popup' data-mini='true' data-position-to='window' data-role='button' style='margin-top: 22px' onclick='OrderDelClick(this)'>清除</a></td></tr>");
                $("#" + data[i].EQID).button();
            }
            $("#Steeltab").table("refresh");
            $("#msg").html("");
        }
        function OrderDelClick(obj) {
            $(obj).parent().parent().remove();
        }
        function Save(operateType) {
            var EquipmentCode = $.trim($("#steelid").val());
            var ajax = null;
            if (operateType == 0) {//只扫描
                if ($.trim($("#steelid").val()) == "") {
                    confirmDialogFocus("请扫描钢网/刮刀", function () {
                        $("#steelid").val("").focus();
                    });
                    return false;
                }
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.SteelNetLineDownNew($.trim($("#steelid").val()), userName,0);
            }else if (operateType == 1) {//下线
                //循环列表
                EquipmentCode = "";
                $("#Steeltab tbody tr").each(function () {
                    if (EquipmentCode == "") {
                        EquipmentCode = $.trim($(this).find("td").eq(1).html());
                    } else {
                        EquipmentCode = EquipmentCode + "," + $.trim($(this).find("td").eq(1).html());
                    }
                });
                if (!EquipmentCode) {
                    $("#msg").html("未检测到设备编码!").css("color", "red");
                    return false;
                }
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.SteelNetLineDownNew(EquipmentCode, userName, 1);
            }
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message).css("color", "red");
                $("#steelid").focus().select().val("");
                return false;
            } else {
                $("#steelid").focus().select().val("");
                if (operateType == 1) {
                    $("#msg").html(EquipmentCode + "下线成功").css("color", "#7FFF00");
                    $("#steelid").focus().val("");
                    $("#Steeltab tbody").html("");
                } else if (operateType == 0) {
                    //展示要扫描的信息
                    OrderList(EquipmentCode);
                }
            }
        }
        function clears() {
            $("#steelid2").val("");
            $("#Tension").val("");
            $("#CheckResult").val("");
        }
        $(function () {
            $("#steelid2").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() }).focus();
            $("#Tension").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
            $("#CheckResult").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
        });
        $("#steelid2").on("keydown", function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#msg").html("");
                $("#Tension").focus();
            }
        });
        $("#Tension").on("keydown", function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#CheckResult").focus();
            }
        });
        $("#CheckResult").on("keydown", function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                //$("#steelid").focus();
            }
        });
        function Wash() {
            if ($.trim($("#steelid2").val()) == "") {
                confirmDialogFocus("请扫描钢网/刮刀", function () {
                    $("#steelid2").val("").focus();
                });
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.SteelWashNew($.trim($("#steelid2").val()), $("#Tension").val(), $("#CheckResult").val(), userName, 1);
            if (ajax.error != null) {
                $("#msg2").html(ajax.error.Message).css("color", "red");
                $(this).focus().select();
                return false;
            } else {
                $("#msg2").html($.trim($("#steelid2").val())+"清洗成功").css("color", "#7FFF00");
                clears();
                $("#steelid2").focus();
            }
        }
        $(function () {
            $("a.ui-table-columntoggle-btn").hide();
        });
    </script>

</body>
</html>
