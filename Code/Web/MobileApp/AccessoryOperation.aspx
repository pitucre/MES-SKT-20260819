<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessoryOperation.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.AccessoryOperation" %>

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
    <title>辅料作业</title>
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
                        辅料作业
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>

                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-theme="c" onclick="setOperationType(2)">解冻</a></li>
                        <li><a href="#" data-transition="none" data-theme="c" onclick="setOperationType(7)">搅拌</a></li>
                        <li><a href="#" data-transition="none" data-theme="c" onclick="setOperationType(5)">退回</a></li>
                        <li><a href="#" data-transition="none" data-theme="c" onclick="setOperationType(8)">空瓶管理</a></li>
                        <li><a href="#" data-transition="none" data-theme="c" onclick="setOperationType(9)">下线</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <b>辅料条码</b>
                        </td>
                        <td>
                            <input id="txtGrn" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Save" onclick="Save()" data-role="button" data-fullscreen="true"
                            data-theme="none">辅料解冻</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdFIFO" runat="server" Value="-1" ClientIDMode="Static" />
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var opType = 2;

            function setOperationType(type) {
                opType = type;

                var confirmBtn = "";
                switch (type) {
                    case 2:
                        confirmBtn = "辅料解冻";
                        break;
                    case 7:
                        confirmBtn = "辅料搅拌";
                        break;
                    case 5:
                        confirmBtn = "辅料退回";
                        break;
                    case 9:
                        confirmBtn = "辅料下线";
                        break;
                    default:
                        confirmBtn = "确 认";
                        break;
                }
                $("#msg").html("");
                $("#Save").html(confirmBtn);
                $("#txtGrn").val("").select();
            }

            $(function () {
                $("#txtGrn").blur(function () { $(this).css("background-color", "#fff") }).focus(function () { $(this).css("background-color", "#ffffcc").select() }).focus();
            });
            $("#txtGrn").on("keydown", function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html("");
                    Save();
                }
            });

            function Save() {
                var grn = $.trim($("#txtGrn").val());
                if (grn == "") {
                    confirmDialogFocus("请扫描辅料条码!", function () {
                        $("#txtGrn").val("").select();
                    });
                    return false;
                }

                if (opType == 2) {
                    accessoryThaw(grn);
                }
                else if (opType == 7) {
                    accessoryStir(grn);
                }
                else if (opType == 5) {
                    accessoryReturn(grn);
                }
                else if (opType == 8) {
                    accessoryFinish(grn);
                }
                else if (opType == 9) {
                    accessoryOffline(grn);
                }
            }

            /**
             * 辅料解冻
             * */
            function accessoryThaw(grn) {
                //权限管控，若无权限则需遵循FIFO原则
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.CheckGrnAccessoryPrepare(grn);//辅料FIFO规则校验
                if (ajax.error != null) {
                    //异常时提示
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#txtGrn").val("").select();
                    return false;
                }
                else {
                    var list = ajax.value[0];
                    if (list.Flage == 0) {
                        if ($("#hdFIFO").val() !== "1") {//没有取消FIFO的权限
                            $("#msg").html("请遵循先进先出或优先使用退回的辅料原则，请先使用GRN为'" + list.SerialNumber + "'的辅料").css("color", "red");
                            $("#txtGrn").val("").select();
                            return false;
                        }
                        if (!confirm("您没有遵循先进先出或优先使用退回的辅料原则，该物料有更早的GRN为'" + list.SerialNumber + "'的辅料，是否确认操作？")) {
                            return false;
                        }
                    }
                }

                //锡膏解冻时校验
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryThawValidate(grn);
                if (ajax.value != null && ajax.value != "") {
                    //提示：该辅料已达到设定的最大使用次数，是否现在报废？ 或者 该辅料已达到设定的最大解冻次数，是否现在报废？
                    if (confirm(ajax.value)) {
                        ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(grn, 6, userName);
                        if (ajax.error != null) {
                            //alert(ajax.error.Message);
                            $("#msg").html(ajax.error.Message).css("color", "red");
                            return false;
                        }
                        //alert("报废成功");
                        //document.forms[0].submit();
                        $("#msg").html(grn + " 报废成功").css("color", "green");
                        $("#txtGrn").val("").select();
                        return false;
                    } else {
                        return false;
                    }
                }
                //2解冻
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(grn, 2, userName);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#txtGrn").select();
                    return false;
                } else {
                    $("#msg").html($.trim($("#txtGrn").val()) + " 条码解冻成功").css("color", "green");
                    $("#txtGrn").val("").select();
                }
            }

            /**
             * 辅料搅拌
             * */
            function accessoryStir(grn) {
                //锡膏搅拌时校验
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryThawValidate(grn);
                if (ajax.value != null && ajax.value != "") {
                    //提示：该辅料已达到设定的最大使用次数，是否现在报废？ 或者 该辅料已达到设定的最大搅拌次数，是否现在报废？
                    if (confirm(ajax.value)) {
                        ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(grn, 6, userName);
                        if (ajax.error != null) {
                            //alert(ajax.error.Message);
                            $("#msg").html(ajax.error.Message).css("color", "red");
                            return false;
                        }
                        //alert("报废成功");
                        //document.forms[0].submit();
                        $("#msg").html(grn + " 报废成功").css("color", "green");
                        $("#txtGrn").val("").select();
                        return false;
                    } else {
                        return false;
                    }
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(grn, 7, userName);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#txtGrn").select();
                    return false;
                } else {
                    $("#msg").html($.trim($("#txtGrn").val()) + " 搅拌成功").css("color", "green");
                    $("#txtGrn").val("").select();
                }
            }

            /**
             * 辅料退回
             * */
            function accessoryReturn(grn) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(grn, 5, userName);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#txtGrn").select();
                    return false;
                } else {
                    $("#msg").html($.trim($("#txtGrn").val()) + " 退回成功").css("color", "green");
                    $("#txtGrn").val("").select();
                }
            }

            /**
            * 空瓶管理
            * */
            function accessoryFinish(grn) {
                var result = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.Finish(grn);
                if (result.error != null) {
                    $("#msg").html(result.error.Message).css("color", "red");
                    return false;
                }
                $("#msg").html("辅料用完成功").css("color", "#7FFF00");
                $("#txtGrn").val("").focus();
            }


            /**
           * 下线管理
           * */
            function accessoryOffline(grn) {
                var result = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOffline(grn);
                if (result.error != null) {
                    $("#msg").html(result.error.Message).css("color", "red");
                    return false;
                }
                $("#msg").html("辅料下线成功").css("color", "#7FFF00");
                $("#txtGrn").val("").focus();
            }
        </script>
    </form>
</body>
</html>
