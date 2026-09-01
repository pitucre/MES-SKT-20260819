<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EQ_InOUTInstock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.EQ_InOUTInstock" %>


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
    <title>钢网刮刀出入库</title>
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
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                     <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">钢网刮刀出入库</label>
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
                    <tr id="SaveStock">
                        <td>
                            <label>
                                存放位置</label>
                        </td>
                        <td>
                            <input id="txtStockNo" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                设备编号</label>
                        </td>
                        <td>
                            <input id="steelid" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
            </div>
            <%--<div data-role="footer" data-position="fixed" style="position: fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Save" onclick="Save()" data-role="button" data-fullscreen="true"
                            data-theme="f">确认</a></li>
                    </ul>
                </div>
            </div>--%>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            $(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");

                $(".ui-body-c").css("background", "#fff");
                $("#SaveStock").hide();
                $('#ddlOptionType').change(function () {
                    var type = $("#ddlOptionType option:selected").attr("id");
                    if (type == "Out") {
                        $("#SaveStock").hide();
                    }
                    else {
                        $("#SaveStock").show();
                    }
                });

            });
            


            $("#steelid").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var EquipmentCode = $("#steelid").val();
                    var entity = {};
                    entity.EquipmentCode = EquipmentCode;
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentCodeIsCheck", JSON.stringify(entity));
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        $(this).focus().select().val("");
                        return false;
                    }
                    $("#msg").html("扫描成功！").css("color", "#2ecc71");
                    Save();
                }
            });

            $("#txtStockNo").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var PositionName = $("#txtStockNo").val();
                    var entity = {};
                    entity.PositionName = PositionName;
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentStockIsCheck", JSON.stringify(entity));
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        $(this).focus().select().val("");
                        return false;
                    }
                    $("#steelid").focus();
                    $("#msg").html("扫描成功！").css("color", "#2ecc71");
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
                var EquipmentCode = $("#steelid").val();
                var entity = {};
                entity.EquipmentCode = EquipmentCode;
                entity.UserName = userName;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentOutStock_PDA", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                $("#msg").html(EquipmentCode + "出库成功！").css("color", "#2ecc71");
                $("#steelid").val("");
                $("#txtStockNo").val("");
            }
            //入库
            function In() {
                var EquipmentCode = $("#steelid").val();
                var PositionName = $("#txtStockNo").val();
                if (PositionName=="") {
                    $("#msg").html("请扫描库位条码！").css("color", "red");
                    return false;
                }
                var entity = {};
                entity.EquipmentCode = EquipmentCode;
                entity.PositionName = PositionName;
                entity.UserName = userName;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentInStock_PDA", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                $("#msg").html(EquipmentCode+"入库成功！").css("color", "#2ecc71");
                $("#steelid").val("");
                $("#txtStockNo").val("");
            }
        </script>
    </form>
</body>
</html>
