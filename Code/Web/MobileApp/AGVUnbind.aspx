<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AGVUnbind.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.AGVUnbind" %>

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
    <title>托盘入库暂存区条码解除</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">托盘入库暂存区条码解除</label>
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
                            <label for="txtStatrAgv">
                                AGV地标码:</label>
                        </td>
                        <td>
                            <select id="sltStartAgv" data-mini="true" >
                                <option></option>
                            </select>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
           
            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" onclick="Send()" data-theme="f" value="解 除" /></li>
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var grnArr = [];
            var scanArr = [];

            $().ready(function () {
                GetTC();
             
            });

            function GetTC() {
                var entity = {};
                entity.AgvCheckType = 3;
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
            function Send() {

                var txtStatrAgv = $.trim($("#sltStartAgv").val());
                if (txtStatrAgv === "") {
                    $("#msg").html("AGV地标码不能为空！").css("color", "red");
                    $("#txtStatrAgv").focus().select();
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.WarehouseAGVMarkUnbind(txtStatrAgv);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                $("#msg").html("解除成功！").css("color", "green");
                //$("#sltStartAgv").html("<option value='-1'></option>");
                //$('#sltStartAgv').selectmenu('refresh', true);
                GetTC();
            }

        </script>

    </form>
</body>
</html>
