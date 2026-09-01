<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentSendRepairList.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.EquipmentSendRepairList" %>

<!DOCTYPE html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    <title>设备报修列表</title>
    <style type="text/css">
        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        .ui-mobile .ui-page-theme-a .ui-btn {
            background-color: #2FC1FF;
            border-color: #2FC1FF;
            color: #fff;
        }

        .ui-page-theme-a .ui-controlgroup-controls .ui-btn {
            background-color: #f6f6f6;
            border-color: #ddd;
            color: #000;
        }

        .ui-page-theme-a .ui-controlgroup-controls .ui-btn-active {
            background-color: #f6f6f6;
            border-color: #ddd;
            color: #fff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">

        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">PDA设备报修列表</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" id="content1">
                <table id="repair-list" data-role="table" data-mode="columntoggle:none" class="ui-responsive" style="width: 100%">
            <thead>
                <tr>
                    <th>设备编码
                    </th>
                    <th>维修人
                    </th>
                    <th>报修时间
                    </th>
                    <th>故障描述
                    </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
                <div id="msg" style="text-align: center; font-size: 14px;">
                </div>
            </div>
         
      


            </div>
    <script type="text/javascript">

        $(document).ready(function () {
            //隐藏columntoggle列表按钮
            $(".ui-body-c").css("background", "#fff");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentSendRepairList();
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                return false;
            }
            var list = ajax.value;
            var hl = "";
            for (var i = 0; i < list.length; i++) {
                hl += "<tr>" +
                    "<td>" + list[i].EquipmentCode + "</td>" +
                    "<td>" + list[i].RepairName + "</td>" +
                    "<td>" + getDateString(list[i].CreateDateTime) + "</td>" +
                    "<td>" + list[i].AnormalDesc + "</td>" +
                    "</tr>";
            }
            $("#repair-list tbody").html(hl);
        });

        //获取时间字符串形式
        function getDateString(date) {
            if (!date) {
                return "";
            }
            var today = new Date(date);
            return today.Format();
        }

        //时间转字符串
        Date.prototype.Format = function (fmt) {
            if (undefined == fmt || null == fmt) {
                fmt = "yyyy-MM-dd HH:mm:ss";
            }
            var t = this;
            var tf = function (str, len) {
                if (str.length < len) {
                    for (var i = 0; i < len - str.length; i++) {
                        str = "0" + str;
                    }
                }
                return str
            };
            var opt = {
                "y+": t.getFullYear().toString(),        // 年
                "M+": (t.getMonth() + 1).toString(),     // 月
                "d+": t.getDate().toString(),            // 日
                "H+": t.getHours().toString(),           // 时
                "m+": t.getMinutes().toString(),         // 分
                "s+": t.getSeconds().toString()          // 秒
                // 有其他格式化字符需求可以继续添加，必须转化成字符串
            };
            var ret;
            for (var k in opt) {
                ret = new RegExp("(" + k + ")").exec(fmt);
                if (ret) {
                    fmt = fmt.replace(ret[1], ret[1].length == 1 ? opt[k] : tf(opt[k], ret[1].length));
                }
            }
            return fmt;
        }

        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }

    </script>
     
    </form>
</body>
</html>
