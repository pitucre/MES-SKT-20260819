<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessoryFinish.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.AccessoryFinish" %>

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
    <title>空瓶管理</title>
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
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/Acc_w.png" />
                    </div>
                    <div>
                        空瓶管理
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
                            <label>
                                辅料编码</label>
                        </td>
                        <td>
                            <input id="txtval" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            $(function () {
                $("#txtval").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
            });

            $("#txtval").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var id = $.trim($("#txtval").val());
                    if (id == "") {
                        $("#msg").html("编码不能为空")
                        return false;
                    }
                    $("#msg").html("");
                    result = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.Finish(id);
                    if (result.error != null) {
                        $("#msg").html(result.error.Message).css("color", "red");
                        return false;
                    }
                    $("#msg").html("辅料用完成功").css("color", "#7FFF00");
                    $("#txtval").val("").focus();
                }
            });
        </script>
    </form>
</body>
</html>
