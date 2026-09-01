<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AGVEmptyTray.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.AGVEmptyTray" %>

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
    <title>AGV拖运 - 空拖</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">AGV拖运-空拖/车</label>
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
                            <label for="txtStatrAgv">
                                AGV起点:</label>
                        </td>
                        <td>
                            <select id="sltStartAgv" data-mini="true" onchange="changeLine()">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtLineName">
                                产线:</label>
                        </td>
                        <td>
                            <select id="sltLine" data-mini="true" >
                                <option></option>
                            </select>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label for="txtEndAGV">
                                AGV终点:</label>
                        </td>
                        <td>
                            <select id="sltEndAGV" data-mini="true" onchange="changeLine()">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <table id="infotab" data-role='table' data-mode='columntoggle' class='ui-responsive table-stroke' style='width: 100%'>
                    <thead>
                        <tr>
                            <th>AGV起点</th>
                            <th>产线</th>
                            <th>AGV目的地</th>
                            <th>操作</th>
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
                            <input type="button" onclick="Send()" data-theme="f" value="托运任务发出" /></li>
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
                GetLineList();
                GetTC();
                //联动
                $("#AgvCheckType").on('change', function () {
                    GetTC();
                })

                $("#sltLine").on('change', function () {
                    $("#sltEndAGV").html("");
                    var LineId = $("#sltLine").val();
                    if (LineId > 0) {
                        var entity = {};
                        entity.LineId = $("#sltLine").val();
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetLineAGVListByLineId", JSON.stringify(entity));
                        if (ajax.error != null) {
                            $("#msg").html(ajax.error.Message).css("color", "red");
                            return false;
                        }
                        var list = JSON.parse(ajax.value).data
                        for (var i = 0; i < list.length; i++) {
                            $("#sltEndAGV").append(" <option id='" + list[i].AgvCode + "'>" + list[i].AgvCode + "</option>");
                        }
                    }
                    $('#sltEndAGV').selectmenu('refresh', true);
                    
                    
                })

                function GetTC() {
                    var entity = {};
                    entity.AgvCheckType = $("#AgvCheckType").val();
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("ustGetWarehouseAGVMarkByAgvCheckType", JSON.stringify(entity));
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        return false;
                    }
                    var list = JSON.parse(ajax.value).data
                    $("#sltStartAgv").html("");
                    for (var i = 0; i < list.length; i++) {
                        $("#sltStartAgv").append(" <option id='" + list[i].AGVLandMarkCode + "'>" + list[i].AGVLandMarkCode + "</option>");
                    }
                    $('#sltStartAgv').selectmenu('refresh', true);
                }
            });

            function GetLineList() {
                entity = {};
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetLineAGVList", JSON.stringify(entity) );
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                var list = JSON.parse(ajax.value).data
                $("#sltLine").html("<option value='-1'> --请选择-- </option>");
                for (var i = 0; i < list.length; i++) {
                    $("#sltLine").append(" <option value='" + list[i].LineId + "'>" + list[i].LineName + "</option>");
                }
                $('#sltLine').selectmenu('refresh', true);
                
            }

            function loadScanInfo(uniqueCode) {
                var html = "";
                var lineName = $("#sltLine option:selected").text();
                html += '<tr><td>' + $.trim($("#sltStartAgv").val()) + '</td><td>' + lineName + '</td><td>' + $("#sltEndAGV").val() + '</td><td><a href="#" onclick ="CancelTask(\'' + uniqueCode + '\',this)">取消任务</a></td></tr>';
                $("#scanIfo").append(html);
            }


            function CancelTask(uniqueCode,obj) {
                //let req =
                //{
                //    "msgType": "cancelTask",
                //    "taskID": uniqueCode
                //}
                //let reqUrl = 'http://172.16.15.216:9123/agvs'
                ////发送agv指令，然后保存数据到数据库
                //let listStr = "";
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.CancelAgvTask(req, reqUrl);
                //if (ajax.error != null) {
                //    $("#msg").html(ajax.error.Message).css("color", "red");
                //    return false;
                //}
                $(obj).parent().parent().remove();
                $("#msg").html("任务取消成功！").css("color", "green");

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

                var txtStatrAgv = $.trim($("#sltStartAgv").val());
                if (txtStatrAgv === "") {
                    $("#msg").html("起点AGV地标码不能为空！").css("color", "red");
                    $("#txtStatrAgv").focus().select();
                    return false;
                }
                var txEndtAgv = $.trim($("#sltEndAGV").val());
                if (txEndtAgv === "") {
                    $("#msg").html("终点AGV地标码不能为空！").css("color", "red");
                    $("#txEndtAgv").focus().select();
                    return false;

                }
                if (txtStatrAgv === txEndtAgv) {

                    $("#msg").html("起点终点不可相同！").css("color", "red");
                    $("#txEndtAgv").focus().select();
                    return false;

                }
                var isCz = true;
               
                $("#scanIfo tr").each(function (i, e) {
                    debugger;
                    var startAgvCode = $.trim($(e).find("td:eq(0)").html());
                    var endAgvCode = $.trim($(e).find("td:eq(2)").html());
                    if (startAgvCode == txtStatrAgv && endAgvCode == txEndtAgv) {
                                isCz = false;
                                return false;
                        }
                });

                if (!isCz) {
                    if (confirm("存在该AGV起点到终点的任务,是否继续?")) {
                        isCz = true;
                    }
                }

                if (isCz) {
                    var uniqueCode = "N" +generateUniqueCode();
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
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.SendAgv(req, reqUrl, listStr, "空拖", "", "");
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        return false;
                    }
                    loadScanInfo(uniqueCode);
                    $("#msg").html("发送成功！").css("color", "green");
                    GetLineList();
                    $("#sltEndAGV").html("<option value='-1'></option>");
                    $('#sltEndAGV').selectmenu('refresh', true);
                }
            }

        </script>

    </form>
</body>
</html>
