<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDAAGVCheck.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAAGVCheck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" href="css/bootstrap.min.css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">

    <title>AGV拖运</title>
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
    <form runat="server" onsubmit="return false;">
        <div data-role="page" data-url="setpage" class="bindpage" id="bindpage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">AGV拖运</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>

            </div>
            <div data-role="content">
                <table style="width: 100%" id="Table1">
                    <tr>
                        <td>
                            <label for="warehouse">
                                类型:</label>
                        </td>
                        <td>
                            <select name="AgvCheckType" data-mini="true" id="AgvCheckType" class="AgvCheckType">
                                <option value="-1" selected></option>
                                <option value="1">发料</option>
                                <option value="2">发货</option>
                                <option value="3">空托运送</option>
                                <option value="4">其他</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtStatrAgv">
                                起点:</label>
                        </td>
                        <td>
                            <input class="txtStatrAgv" id="txtStatrAgv" type="text" data-mini="true"
                                value="" data-theme="e" />
                        </td>
                        <td>
                            <label for="txtEndAGV">
                                终点:</label>
                        </td>
                        <td colspan="2">
                            <select name="AgvEnd" data-mini="true" id="AgvEnd" class="AgvEnd">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                </table>
                <table id="infotab" data-role='table' data-mode='columntoggle' class='ui-responsive table-stroke' style='width: 100%'>
                    <thead>
                        <tr>
                            <th>任务编号</th>
                            <th>料车编号</th>
                            <th>起点</th>
                            <th>终点</th>
                        </tr>
                    </thead>
                    <tbody id="scanIfo">
                    </tbody>
                </table>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" onclick="Send()" data-theme="f" value="确认发送" /></li>
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var grnArr = [];
            var scanArr = [];

            $().ready(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");

                //联动
                $("#AgvCheckType").on('change', function () {
                    var entity = {};
                    entity.CheckType = $("#AgvCheckType").val();
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetEndAgvByCheckType", JSON.stringify(entity));
                    if (ajax.error != null) {
                        var myMsg = data.error.Message;
                        myMsg = myMsg.replace("DBCC 执行完毕。如果 DBCC 输出了错误信息，请与系统管理员联系。", "");
                        showAreaMessge(SN + ":" + myMsg, "messageRed");
                        return false;
                    }
                    var data = JSON.parse(ajax.value).data
                    $("#AgvEnd").html("<option></option>");
                    $.each(data, function (a, b) {
                        $("#AgvEnd").append("<option value='" + b.AgvCode + "'>" + b.AgvCode + "</option>");
                    });

                    $("#txtGRN").select();
                })


                //货架扫描绑定事件
                $("#txtStatrAgv").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        var grn = $.trim($("#txtStatrAgv").val());
                        if (grn == "") {
                            return false;
                        }
                        var EndAgv = $("#AgvEnd").val();
                        if (EndAgv === "") {
                            confirmDialogFocus("请先选择终点AGV地标码！", function () { });
                        }

                        var entity = {};
                        entity.AGVCode = grn;
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckAvgStart", JSON.stringify(entity));
                        if (ajax.error != null) {
                            confirmDialogFocus(data.error.Message, function () { $("#txtStatrAgv").focus().select(); });
                        }

                        if (grn === EndAgv) {
                            confirmDialogFocus("起点终点不可相同!", function () { $("#txtStatrAgv").focus().select(); });
                        }

                        loadScanInfo();
                    }
                });
            });

            function loadScanInfo() {
                var html = "";
                $("#scanIfo").html(html);
               
                html += "<tr><td>" + generateUniqueCode() + "</td><td></td><td>" + $.trim($("#txtStatrAgv").val()) + "</td><td>" + $("#AgvEnd").val() + "</td></tr>";

                $("#scanIfo").html(html);
            }


            function generateUniqueCode() {
                // 获取当前时间戳
                const timestamp = Date.now().toString();
                // 生成一个随机数
                const randomNumber = Math.random().toString().slice(2, 10);
                // 返回时间戳和随机数的组合
                return timestamp + randomNumber;
            }

            function Send() {
                $("#scanIfo").html("");
                $("span.AgvEnd").text("");
                $("#txtStatrAgv").val("");
                alert("发送成功!")
            }

        </script>

    </form>
</body>
</html>
