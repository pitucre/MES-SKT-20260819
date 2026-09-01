<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AGVCpInstock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.AGVCpInstock" %>

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

    <title>AGV拖运 - 成品入库</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">AGV拖运 - 成品入库</label>
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
                                托运类型:</label>
                        </td>
                        <td>
                            <select name="AgvCheckType" data-mini="true" id="AgvCheckType" class="AgvCheckType">
                                <option value="1">台车</option>
                                <option value="2">托盘</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="warehouse">
                                运送区域:</label>
                        </td>
                        <td>
                            <select name="AgvTransportType" data-mini="true" id="AgvTransportType" class="AgvTransportType">
                                <option value="1">立体仓</option>
                                <option value="2">待检区</option>
                                <option value="3">暂存区</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtStatrAgv">
                                AGV起点:</label>
                        </td>
                        <td>
                            <input class="txtStatrAgv" id="txtStatrAgv" type="text" data-mini="true"
                                value="" data-theme="e" />
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label for="txtAgvEnd">
                                AGV终点:</label>
                        </td>
                        <td colspan="2">
                            <input class="txtAgvEnd" id="txtAgvEnd" type="text" data-mini="true" name="txtAgvEnd" value="" data-theme="e" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <%--     <table id="infotab" data-role='table' data-mode='columntoggle' class='ui-responsive table-stroke' style='width: 100%'>
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
                </table>--%>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" onclick="Send()" data-theme="f" value="发送托运任务" /></li>
                        <li>
                            <input type="button" onclick="Clare()" data-theme="f" value="清除" /></li>

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

                //货架扫描绑定事件
                $("#txtStatrAgv").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        $("#msg").html("");
                        var grn = $.trim($("#txtStatrAgv").val());
                        if (grn == "") {
                            $("#msg").html("请扫描起点地标码!").css("color", "red");
                            $("#txtStatrAgv").val("").focus().select();
                            return false;
                        }
                        var AgvCheckType = $("#AgvCheckType").val();
                        var AgvTransportType = $("#AgvTransportType").val()
                        var entity = {};
                        entity.AgvCheckType = AgvCheckType;
                        entity.AgvTransportType = AgvTransportType;
                        entity.AGVCode = grn;
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckAvgCpInStockStart", JSON.stringify(entity));
                        if (ajax.error != null) {
                            $("#msg").html(ajax.error.Message).css("color", "red");
                            $("#txtStatrAgv").val("").focus().select();
                            return false;
                        }
                        if (JSON.parse(ajax.value).data[0].AGVLandMarkCode != '') {
                            $("#txtAgvEnd").val(JSON.parse(ajax.value).data[0].AGVLandMarkCode);
                        }
                    }
                });

                $("#txtAgvEnd").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        $("#msg").html("");
                        var txtAgvEnd = $.trim($("#txtAgvEnd").val());
                        if (txtAgvEnd == "") {
                            return false;
                        }
                        var txtStatrAgv = $.trim($("#txtStatrAgv").val());
                        if (txtStatrAgv == "") {

                            $("#msg").html("请扫描AGV起点").css("color", "red");
                            $("#txtStatrAgv").val("").focus().select();
                           
                            return false;
                        }
                        var AgvCheckType = $("#AgvCheckType").val();
                        var AgvTransportType = $("#AgvTransportType").val()
                        var entity = {};
                        entity.AgvCheckType = AgvCheckType;
                        entity.AgvTransportType = AgvTransportType;
                        entity.AGVCode = grn;
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckAvgCpInStockStart", JSON.stringify(entity));
                        if (ajax.error != null) {
                            $("#msg").html(ajax.error.Message).css("color", "red");
                            $("#txtAgvEnd").val("").focus().select();
                            return false;
                        }
                        if (txtAgvEnd === txtStatrAgv) {
                            $("#msg").html("起点终点不可相同!").css("color", "red");
                            $("#txtAgvEnd").val("").focus().select();
                            return false
                           
                        }
                        $("#txtAgvEnd").focus().select();
                    }
                });

            });

            function loadScanInfo() {
                var html = "";
                $("#scanIfo").html(html);
                html += "<tr><td>" + generateUniqueCode() + "</td><td></td><td>" + $.trim($("#txtStatrAgv").val()) + "</td><td>" + $("#txtAgvEnd").val() + "</td></tr>";
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
                $("#msg").html("");
                var txtStatrAgv = $.trim($("#txtStatrAgv").val());
                if (txtStatrAgv == "") {

                    $("#msg").html("起点AGV地标码不能为空！").css("color", "red");
                    $("#txtStatrAgv").val("").focus().select();
                    return false;
                }
                var txEndtAgv = $.trim($("#txtAgvEnd").val());
                if (txEndtAgv == "") {
                    $("#msg").html("终点AGV地标码不能为空！").css("color", "red");
                    $("#txtAgvEnd").val("").focus().select();
                    return false;
                }
                if (txtStatrAgv === txEndtAgv) {

                    $("#msg").html("起点终点不可相同！").css("color", "red");
                    $("#txtAgvEnd").val("").focus().select();
                    return false;
                }

                var AgvCheckType = $("#AgvCheckType option:selected").text();
                var AgvTransportType = $("#AgvTransportType option:selected").text();

                var uniqueCode = AgvCheckType == 1 ? "X" : "T" + generateUniqueCode();
                let req =
                {
                    "msgType": "creatTask",
                    "taskEnd": txEndtAgv,
                    "taskID": uniqueCode,
                    "taskStart": txtStatrAgv
                }
                let reqUrl = 'http://172.16.15.216:9123/agvs'
                //发送agv指令，然后保存数据到数据库
                let listStr = "";
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.SendAgv(req, reqUrl, listStr, "成品入库", AgvCheckType == 1 ? "台车" : "托盘", AgvTransportType);
                if (ajax.error != null) {

                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }

                $("#msg").html("发送成功！").css("color", "green");
                $("#txtStatrAgv").val("").focus().select();;
                $("#txtAgvEnd").val("");


            }

        </script>

    </form>
</body>
</html>
