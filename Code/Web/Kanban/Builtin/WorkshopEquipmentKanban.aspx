<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkshopEquipmentKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.WorkshopEquipmentKanban" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>车间看板</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/chalk.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            margin: 0px;
            padding: 0px;
            border: 0px;
            font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif;
            color: #fff;
            background-color: #041622;
            font-size: 16px;
            overflow: hidden;
        }

        .logo_cus {
           /*background: url('../../Content/images/poco_logo.png') no-repeat 15px center;*/
            background-size: 90%;
            background-color: #0D213A;
        }

        .logo_skt {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center center;
            background-size: 93%;
            background-color: #0D213A;
        }

        #_left_top_title {
            height: 100%;
            font-size: 1.5em;
            text-align: center;
        }

        #_left_top_welcome {
            height: 100%;
            font-size: 1.7em;
            color: Red;
        }

        #dateAndWeek {
            width: 13%;
            height: 100%;
            font-size: 1.0em;
            text-align: center;
        }

        table {
            width: 100%;
            height: 100%;
            border-collapse: collapse;
            border-spacing: 0px;
            padding: 0px;
            margin: 0px;
        }

            table td, table th {
                padding: 0px;
            }

        #_layout {
            position: absolute;
        }

        #_layout_right_table td {
            font-size: 1em;
            text-align: center;
            /*border-top: 1px solid #263C54;
            border-right: 1px solid #263C54;
            border-bottom: 1px solid #263C54;*/
        }

        #data_thead th, #data_tbody td, #data_tfoot td {
            text-align: center;
            font-size: 0.8em;
            /*width: 7%;*/
            border-top: 1px solid #263C54;
            /*border-left: 1px solid #c5c5c5;*/
            border-bottom: 1px solid #263C54;
        }

        #data_thead th {
            border-bottom: 0px;
            /*background: #F2F2F2;
            background-image: linear-gradient(to bottom, #f8f8f8 0%, #ececec 100%);*/
        }

        #data_tbody td, #data_tfoot td {
            border-bottom: 0px;
            /*background-color: #fff;*/
        }

        #data_tfoot td {
            border-bottom: 1px solid #263C54;
            /*background-color: #F2F2F2;*/
        }

        .gauge {
            height: 100%;
            width: 33%;
        }
    </style>
    <script type="text/javascript">
        /*
        _S1,_S2是滚动内容区域外的两个DIV的ID
        如
        <div id="_S1">
        <div id="_S2">
        _W为滚动内容的宽度
        _H为滚动内容的高度
        _T为滚动后每次停留言时间
        */
        var isScroll = false;
        function _InitScroll(_S1, _S2, _W, _H, _T) {
            if (isScroll) { return false; }
            marqueesHeight = _H;
            stopScroll = false;
            scrollElem = document.getElementById(_S1);
            scrollTable = document.getElementById('data_tbody');
            if (scrollTable.offsetHeight < marqueesHeight) {
                return;
            }
            with (scrollElem) {
                style.width = _W;
                style.height = marqueesHeight;
                style.overflow = 'hidden';
                noWrap = true;
            }
            scrollElem.onmouseover = new Function('stopScroll = true');
            scrollElem.onmouseout = new Function('stopScroll = false');
            preTop = 0;
            //currentTop = 0;
            //stopTime = 0;
            var leftElem = document.getElementById(_S2);
            var childElems = $(scrollElem).children();
            if (childElems.length > 1) {
                $(childElems[0]).nextAll().remove();
            }
            scrollElem.appendChild(leftElem.cloneNode(true));
            pauseTime = _T;
            //setTimeout('init_srolltext()', 1000);
            init_srolltext();
        }

        function init_srolltext() {
            scrollElem.scrollTop = 0;
            scrollIntervalId = setInterval('scrollUp()', 50);
        }

        function scrollUp() {
            if (stopScroll) {
                return;
            }
            preTop = scrollElem.scrollTop;
            scrollElem.scrollTop += 1;
            if (preTop == scrollElem.scrollTop) {
                scrollElem.scrollTop = 0;
                scrollElem.scrollTop += 1;
            }
        }
    </script>
    <script type="text/javascript">
        var timeInterval = 1000 * 60 * 5;

        $(window).resize(function () {
            ResizeAll();
           
        });

        function ResizeAll() {

            //某些浏览器不兼容div自适应高度
            $(".gauge").height($(window).height() * 0.9 * 0.27);

            var _contentHeight = $(window).height() * 0.9 * 0.3;

            $("#_layout_left_data_div_tbody").css("height", "auto");

            $(".rows").height(_contentHeight * 0.16)

            if ($(".rows").length * _contentHeight * 0.16 > _contentHeight) {
                $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);
                _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 150, 1000 * 6);
                isScroll = true;
            }
        }
    </script>
   
    <script type="text/javascript">
        var workshopId, workshopName, welcomeMsg;
        $(document).ready(function () {
            /*设置title*/
            workshopId = getQueryString("workshopId");
            workshopName = getQueryString("workshopName");
            welcomeMsg = "";

            $("#_left_top_title").html(workshopName+"设备看板");
            ResizeAll();
            getWelcome();
         
            initProductionData();
        });

        function getWelcome() {
            if (welcomeMsg == "") {
                welcomeMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(workshopId, -1).value;
            }
            $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value));
            $("#_welcome_text").html(welcomeMsg);

            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 10);
        }

        function GetRepariTime(min) {
            //var day=0;
            var hour = 0;
            //if (min > 1440) {
            //    day = Math.floor(min / 1440);
            //    min = min - day * 1440;
            //}
            if (min > 60) {
                hour = Math.floor(min / 60);
                min = min - hour * 60;
            }
            return hour + '小时' + min + '分钟';
        }

        function initProductionData() {
           
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetEquipmentStatusKanban(workshopId).value;
            var ajax = [{ "EquipmentId": 0, "EquipmentCode": "POCO02038-1#", "EquipmentName": "1#中频炉", "StatusDesc": "生产中", "FreeTimeRatio": 100, "SnInputCount": 0, "SnOutputCount": 0, "RepariTimeMin": 0 }, { "EquipmentId": 0, "EquipmentCode": "POCO02029-2#", "EquipmentName": "2#中频炉", "StatusDesc": "待机中", "FreeTimeRatio": 0, "SnInputCount": 0, "SnOutputCount": 0, "RepariTimeMin": 0 }, { "EquipmentId": 0, "EquipmentCode": "POCO02028-3#", "EquipmentName": "3#中频炉", "StatusDesc": "待机中", "FreeTimeRatio": 0, "SnInputCount": 0, "SnOutputCount": 0, "RepariTimeMin": 0 }, { "EquipmentId": 0, "EquipmentCode": "POCO02025-4#", "EquipmentName": "4#中频炉", "StatusDesc": "待机中", "FreeTimeRatio": 0, "SnInputCount": 0, "SnOutputCount": 0, "RepariTimeMin": 0 }, { "EquipmentId": 0, "EquipmentCode": "POCO02161-6#", "EquipmentName": "6#中频炉", "StatusDesc": "生产中", "FreeTimeRatio": 100, "SnInputCount": 0, "SnOutputCount": 0, "RepariTimeMin": 0 }, { "EquipmentId": 0, "EquipmentCode": "POCO02162-7#", "EquipmentName": "7#中频炉", "StatusDesc": "生产中", "FreeTimeRatio": 100, "SnInputCount": 0, "SnOutputCount": 0, "RepariTimeMin": 0 }]
            var html = "";
            var snInputTatol = 0;
            var snOutTatol = 0;
            var totalRatio = 0.00;
            var sc = 0;
            var dj = 0;
            var wx = 0;
            for (var i = 1; i <= 8; i++) {
                if (i <= ajax.length) {
                    $("#lblEquipmentName" + i).text(ajax[i - 1].EquipmentName);
                    if (ajax[i - 1].StatusDesc == "待机中") {
                        $("#lblStatus" + i).css("background-color", "orange");
                        dj += 1;
                    } else if (ajax[i - 1].StatusDesc == "生产中") {
                        $("#lblStatus" + i).css("background-color", "green");
                        sc += 1;
                    } else {
                        $("#lblStatus" + i).css("background-color", "red");
                        wx += 1;
                    }
                    $("#lblStatus" + i).html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + ajax[i - 1].StatusDesc + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

                    $("#lblSnInput" + i).text(ajax[i - 1].SnInputCount);
                    snInputTatol += ajax[i - 1].SnInputCount;
                    snOutTatol += ajax[i - 1].SnOutputCount;
                    totalRatio += ajax[i - 1].FreeTimeRatio;
                    $("#lblSnOut" + i).text(ajax[i - 1].SnOutputCount);
                    $("#lblRatio" + i).text(ajax[i - 1].FreeTimeRatio+"%");
                    $("#lblRepariTm" + i).text(GetRepariTime(ajax[i - 1].RepariTimeMin));
                } else {
                    $("#lblStatus" + i).css("background-color", "");
                    $("#lblStatus" + i).html("-");
                    $("#lblEquipmentName" + i).text("-");
                    $("#lblSnInput" + i).text("-");
                    $("#lblSnOut" + i).text("-");
                    $("#lblRatio" + i).text("-");
                    $("#lblRepariTm" + i).text("-");
                }

            }
            
             
            $("#lblTotalRatio").text(totalRatio==0?0:parseFloat(totalRatio / ajax.length).toFixed(2));
            $("#lblSc").text(sc);
            $("#lblDj").text(dj);
            $("#lblWx").text(wx);
            $("#lblSnInput").text(snInputTatol);
            $("#lblSnOut").text(snOutTatol);
            $("#lblNum").text(ajax.length);
          

            clearTimeout(uphTimeout);
            var uphTimeout = setTimeout("initProductionData()", timeInterval);
        }

     
        /**
*   获取URL参数值
**/
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table id="_layout">
            <tr style="height: 100%;">
                <td style="height: 100%;">
                    <table id="_layout_left_table">
                        <tr style="height: 12%;">
                            <td style="height: 12%; vertical-align: top;">
                                <table style="background-color: #0D213A;">
                                    <tr>
                                        <td class="logo_cus" style="width: 250px; height: 100%;" rowspan="2"></td>
                                        <td rowspan="2">
                                            <div id="_left_top_title" style="padding-top: 30px; font-size: 39px;">-</div>
                                        </td>
                                        <td id="dateAndWeek" rowspan="2" style="color: #3CA2B0; white-space: nowrap;"></td>
                                        <td class="logo_skt" style="width: 250px; height: 100%;" rowspan="2"></td>
                                    </tr>
                                    
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 88%;">
                            <td style="height: 88%;">
                                <table style="border-right: 1px solid #e3e3e3;">
                                    <tr>
                                        <td style="width: 75%">
                                            <table id="data_tbody" style="font-size: 35px;">
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td rowspan="6" style="height: 100%;width: 30%; text-align: center; background-image:url(../../Content/images/wh_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                                </td>
                                                                            <td style="width: 20%">设备名称</td>
                                                                            <td><label id="lblEquipmentName1">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>状态</td>
                                                                            <td><label id="lblStatus1" style="width: 110%;height: 10%">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已投入批次</td>
                                                                            <td><label id="lblSnInput1">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已完工批次</td>
                                                                            <td><label id="lblSnOut1">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td><label id="lblRatio1">-</label></td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td>维修时长</td>
                                                                            <td><label id="lblRepariTm1">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                  <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                             <td rowspan="6" style="height: 100%;width: 30%; text-align: center; background-image:url(../../Content/images/wh_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                                </td>
                                                                           <td style="width: 20%">设备名称</td>
                                                                            <td><label id="lblEquipmentName2">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>状态</td>
                                                                            <td><label id="lblStatus2" style="width: 110%;height: 10%">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已投入批次</td>
                                                                            <td><label id="lblSnInput2">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已完工批次</td>
                                                                            <td><label id="lblSnOut2">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td><label id="lblRatio2">-</label></td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td>维修时长</td>
                                                                            <td><label id="lblRepariTm2">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td rowspan="6" style="height: 100%;width: 30%; text-align: center; background-image:url(../../Content/images/wh_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                                </td>
                                                                             <td style="width: 20%">设备名称</td>
                                                                            <td><label id="lblEquipmentName3">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>状态</td>
                                                                            <td><label id="lblStatus3" style=" width: 110%;height: 10%">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已投入批次</td>
                                                                            <td><label id="lblSnInput3">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已完工批次</td>
                                                                            <td><label id="lblSnOut3">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td><label id="lblRatio3">-</label></td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td>维修时长</td>
                                                                            <td><label id="lblRepariTm3">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                  <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                             <td rowspan="6" style="height: 100%;width: 30%; text-align: center; background-image:url(../../Content/images/wh_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                                </td>
                                                                             <td style="width: 20%">设备名称</td>
                                                                            <td><label id="lblEquipmentName4">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>状态</td>
                                                                            <td><label id="lblStatus4" style=" width: 110%;height: 10%">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已投入批次</td>
                                                                            <td><label id="lblSnInput4">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已完工批次</td>
                                                                            <td><label id="lblSnOut4">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td><label id="lblRatio4">-</label></td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td>维修时长</td>
                                                                            <td><label id="lblRepariTm4">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td rowspan="6" style="height: 100%;width: 30%; text-align: center; background-image:url(../../Content/images/wh_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                                </td>
                                                                             <td style="width: 20%">设备名称</td>
                                                                            <td><label id="lblEquipmentName5">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>状态</td>
                                                                            <td><label id="lblStatus5" style="width: 110%;height: 10%">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已投入批次</td>
                                                                            <td><label id="lblSnInput5">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已完工批次</td>
                                                                            <td><label id="lblSnOut5">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td><label id="lblRatio5">-</label></td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td>维修时长</td>
                                                                            <td><label id="lblRepariTm5">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                  <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td rowspan="6" style="height: 100%;width: 30%; text-align: center; background-image:url(../../Content/images/wh_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                                </td>
                                                                             <td style="width: 20%">设备名称</td>
                                                                            <td><label id="lblEquipmentName6">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>状态</td>
                                                                            <td><label id="lblStatus6" style="width: 110%;height: 10%">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已投入批次</td>
                                                                            <td><label id="lblSnInput6">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已完工批次</td>
                                                                            <td><label id="lblSnOut6">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td><label id="lblRatio6">-</label></td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td>维修时长</td>
                                                                            <td><label id="lblRepariTm6">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td rowspan="6" style="height: 100%;width: 30%; text-align: center; background-image:url(../../Content/images/wh_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                                </td>
                                                                             <td style="width: 20%">设备名称</td>
                                                                            <td><label id="lblEquipmentName7">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>状态</td>
                                                                            <td><label id="lblStatus7" style=" width: 110%;height: 10%">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已投入批次</td>
                                                                            <td><label id="lblSnInput7">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已完工批次</td>
                                                                            <td><label id="lblSnOut7">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td><label id="lblRatio7">-</label></td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td>维修时长</td>
                                                                            <td><label id="lblRepariTm7">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                  <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td rowspan="6" style="height: 100%;width: 30%; text-align: center; background-image:url(../../Content/images/wh_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                                </td>
                                                                             <td style="width: 20%">设备名称</td>
                                                                            <td><label id="lblEquipmentName8">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>状态</td>
                                                                            <td><label id="lblStatus8" style="width: 110%;height: 10%">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已投入批次</td>
                                                                            <td><label id="lblSnInput8">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>已完工批次</td>
                                                                            <td><label id="lblSnOut8">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td><label id="lblRatio8">-</label></td>
                                                                        </tr>
                                                                         <tr>
                                                                            <td>维修时长</td>
                                                                            <td><label id="lblRepariTm8">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 25%">
                                            <table>
                                                <tr style="height: 21.4%;">
                                                    <td style="height: 21.4%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td colspan="2">设备状态</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 40%">生产中</td>
                                                                            <td style="width: 60%"><label style="background-color: green; width: 110%;height: 10%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td>
                                                                        </tr>
                                                                        <tr>

                                                                           <td>待机中</td>
                                                                            <td><label style="background-color: orange; width: 110%;height: 10%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td>

                                                                        </tr>
                                                                        <tr>

                                                                             <td>维修中</td>
                                                                            <td><label style="background-color: red; width: 110%;height: 10%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 10px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                           
                                                                             <td style="width: 40%">车间名称</td>
                                                                            <td><asp:Label runat="server" ID="lblWorkShopName"></asp:Label></td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td>车间主管</td>
                                                                            <td><asp:Label runat="server" ID="lblUserName"></asp:Label></td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td>车间班制</td>
                                                                            <td><asp:Label runat="server" ID="lblShiftName"></asp:Label></td>

                                                                        </tr>
                                                                        <tr>

                                                                            <td>熔炉数量</td>
                                                                            <td><label id="lblNum"></label>台</td>
                                                                        </tr>
                                                                    </table>
                                                                </td>



                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height: 46%;">
                                                    <td style="height: 46%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                           
                                                                            <td style="width: 40%">生产中</td>
                                                                            <td><label id="lblSc"></label>台</td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td>待机中</td>
                                                                            <td><label id="lblDj"></label>台</td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td>维修中</td>
                                                                            <td><label id="lblWx"></label>台</td>

                                                                        </tr>
                                                                        <tr>

                                                                            <td>总投入批次</td>
                                                                            <td><label id="lblSnInput"></label></td>
                                                                        </tr>
                                                                         <tr>

                                                                            <td>总完工批次</td>
                                                                            <td><label id="lblSnOut"></label></td>
                                                                        </tr>
                                                                         <tr>

                                                                            <td>总利用率</td>
                                                                            <td><label id="lblTotalRatio"></label>%</td>
                                                                        </tr>
                                                                         <tr>

                                                                            <td colspan="2">
                                                                                <img src="../../Content/images/logo/logo2.png" style="width: 90%" /><br/><br/>
                                                                                <label style="font-size: 16px"> Copyright © 2019<br />
                                                                                     深圳市深科特信息技术有限公司 版权所有</label>
                                                                            </td>
                                                                             
                                                                        </tr>
                                                                    </table>
                                                                </td>



                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
