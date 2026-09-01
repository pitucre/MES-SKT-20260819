<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AGVTaskList.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.AGVTaskList" %>

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

    <title>AGV拖运 - 任务列表</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">AGV拖运- 任务列表</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">

                <table id="infotab" data-role='table' data-mode='columntoggle' class='ui-responsive table-stroke' style='width: 100%'>
                    <thead>
                        <tr>

                            <th>运送类型</th>
                            <th>托运类型</th>
                            <th>运送区域</th>
                            <th>起点</th>
                            <th>终点</th>
                            <th>状态</th>
                        </tr>
                    </thead>
                    <tbody id="scanIfo">
                    </tbody>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var grnArr = [];
            var scanArr = [];

            $().ready(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                loadScanInfo();
            });

            function loadScanInfo() {
                var entity = {};
                entity.AGVCode = "";
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetAvgTaskList", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                var list = JSON.parse(ajax.value).data;
                if (list.length > 0) {
                    var html = "";
                    $("#scanIfo").html(html);
                    for (var i = 0; i < list.length; i++) {
                        html += "<tr><td>" + list[i].ShippingType + "</td><td>" + list[i].CheckType + "</td><td>" + list[i].TransportType + "</td><td>" + list[i].AgvStartCode + "</td><td>" + list[i].AgvEndCode + "</td><td>" + list[i].Status + "</td></tr>";
                    }
                    $("#scanIfo").html(html);

                }
            }
        </script>

    </form>
</body>
</html>
