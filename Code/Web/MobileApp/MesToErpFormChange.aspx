<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MesToErpFormChange.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MesToErpFormChange" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js?v=2" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>ERP形态转换接口</title>
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
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 3px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">形态转换接口</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label>转换前物料</label>
                        </td>
                        <td colspan="2">
                            <input class="orderno" data-corners="false" type="text" data-mini="true" value="" androidscan="true" id="chBeforItem" />
                        </td>
                        <td>
                            <label></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>转换前库位</label>
                        </td>
                        <td colspan="2">
                            <input class="orderno" data-corners="false" type="text" data-mini="true" value="" androidscan="true" id="chBeforWar" />
                        </td>
                        <td>
                            <label></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>转换数量</label>
                        </td>
                        <td colspan="2">
                            <input class="orderno" data-corners="false" type="text" data-mini="true" value="" androidscan="true" id="chQty" />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <label>转换后物料</label>
                        </td>
                        <td colspan="2">
                            <input class="orderno" data-corners="false" type="text" data-mini="true" value="" androidscan="true" id="chAfterItem" />
                        </td>
                        <td>
                            <label></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>转换后库位</label>
                        </td>
                        <td colspan="2">
                            <input class="orderno" data-corners="false" type="text" data-mini="true" value="" androidscan="true" id="chAfWar" />
                        </td>
                        <td>
                            <label></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label></label>
                        </td>
                        <td colspan="2">
                            <input class="ButtonBox" type="button" onclick="sendPost()" value="确认" />
                        </td>
                        <td>
                            <label></label>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;"></div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {

        });
        function showMsg(msg, type) {
            $("#msg").text(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }

        function sendPost() {

            debugger;
            var beitem = $("#chBeforItem").val();
            var afitem = $("#chAfterItem").val();
            var num = $("#chQty").val();
            var bewar = $("#chBeforWar").val();
            var afwar = $("#chAfWar").val();
            if (beitem == "" || beitem == null) {
                alert("请输入转换前物料编码！");
                return false;
            }
            if (bewar == "" || bewar == null) {
                alert("请输入转换前库位编码！");
                return false;
            }
            if (afitem == "" || afitem == null) {
                alert("请输入转换后物料编码！");
                return false;
            }
            if (afwar == "" || afwar == null) {
                alert("请输入转换后库位编码！");
                return false;
            }
            if (num == "" || num == null) {
                alert("请输入转换数量！");
                return false;
            }

            showMsg("", 1);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxFormChangePDA.SubFormChangeToERP(beitem, afitem, num, bewar, afwar);
            if (ajax.error != null) {
                showMsg("提交失败：" + ajax.error.Message, 0);
                return false;
            }
            showMsg(ajax.value, 1);

        }






    </script>
</body>
</html>
