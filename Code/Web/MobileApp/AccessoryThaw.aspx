<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessoryThaw.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.AccessoryThaw" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>辅料解冻</title>
    <style type="text/css">
        body {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        table {
            font-size: 12px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
        <div data-role="page" id="accessoryThawPage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <label style="font-size: 17px !important; font-weight: bold; color: #fff">辅料解冻</label>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width:100%">
                    <tr>
                        <td>
                            <b>GRN</b>
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
        <asp:HiddenField ID="hdFIFO" runat="server" Value="-1" ClientIDMode="Static"/>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
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
                    confirmDialogFocus("请扫描GRN!", function () {
                        $("#txtGrn").val("").select();
                    });
                    return false;
                }

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

        </script>
    </form>
</body>
</html>
