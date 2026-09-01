<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MSDKanBan.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.MSDKanBan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 14px; overflow: hidden; }
        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; /*border: 1px solid #38FFFF;*/ }
        .logo_cus { background: url('../../Content/images/logo/logo.png') no-repeat center; background-size: 94%; /*background-color: #0D213A;*/ }
        .logo_cus2 { background: url('../../Content/images/logo/skt-logo.png') no-repeat center; background-size: 90%; }
        .table { display: table; height: 100%; width: 100%; position: relative; }
        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }
        th { height: 35px; line-height: 35px; text-align: center; font-size: 20px; color: #1ab2c7; }
        tr { height: 22px; line-height: 22px; text-align: center; font-size: 18px; color: #38FFFF; }
        .thTitle { font-size: 20px; color: #fff; }
        .chart-tit { font-size: 20px; color: #fff; font-weight: bold; text-align: center; text-shadow: 3px 2px 8px #5a5af7; }

        #div1 { display: black; width: 110px; height: 50px; line-height: 50px; white-space: nowrap; overflow: hidden; background-color: #a2a2a2; margin: 15px; padding: 5px 15px; }
        span { display: inline-block; color: #fff; padding-right: 20px; }
        .tb-list tr.rows th, .tb-list tr.rows td { word-break: break-all; padding: 10px 15px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 8%;">
                <li style="height: 100%;">
                    <span class="logo_cus2 cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 57%;">
                        <span class="cell" style="font-size: 36px; color: #38FFFF; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">MSD管理看板</span>
                    </div>
                    <div class="table" style="float: right; width: 19%;">
                        <span class="cell" style="font-size: 18px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>
            <ul class="tb-list" style="height: 84%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000; overflow-y: hidden;">
                <li style="height: 100%;">
                    <table class="table-kanban tb-list" style="width: 100%; font-size: 22px; color: #ff0000;">
                        <thead>
                            <tr class="rows">
                                <th style="width: 5%" class="thTitle">序号</th>
                                <th style="width: 12%" class="thTitle">GRN</th>
                                <th style="width: 11%" class="thTitle">物料编码</th>
                                <th style="width: 15%" class="thTitle">物料名称</th>
                                <th style="width: 10%" class="thTitle">当前操作</th>
                                <th style="width: 10%" class="thTitle">烘/恒箱编号</th>
                                <th style="width: 15%" class="thTitle">操作时间</th>
                                <th style="width: 10%" class="thTitle">累积暴露时长</th>
                                <th style="width: 10%" class="thTitle">剩余暴露时长</th>
                            </tr>
                        </thead>
                    </table>
                    <div id="container" style="overflow-y: hidden; height: 100%;">
                        <div>
                            <table class="table-kanban" style="width: 100%; font-size: 22px;">
                                <tbody id="container_1"></tbody>
                            </table>
                            <table id="container_2" class="table-kanban" style="width: 100%; font-size: 22px;">
                            </table>
                        </div>
                    </div>
                    <%--<table style="width: 100%; table-layout: fixed;">
                        <tr class="rows">
                            <th style="width: 5%" class="thTitle">序号</th>
                            <th style="width: 12%" class="thTitle">GRN</th>
                            <th style="width: 11%" class="thTitle">物料编码</th>
                            <th style="width: 15%" class="thTitle">物料名称</th>
                            <th style="width: 10%" class="thTitle">当前操作</th>
                            <th style="width: 10%" class="thTitle">烘/恒箱编号</th>
                            <th style="width: 15%" class="thTitle">操作时间</th>
                            <th style="width: 10%" class="thTitle">累积暴露时长</th>
                            <th style="width: 10%" class="thTitle">剩余暴露时长</th>
                        </tr>
                    </table>
                    <div id="_layout_left_data_div_tbody" >
                        <div id="_layout_left_data_div2_tbody" >
                            <table id="data_tbody" style="width: 100%; font-size: 22px; color: #4EC9CE; table-layout: fixed;" >
                                <tbody id="dataList">
                                </tbody>
                            </table>
                        </div>
                    </div>--%>
                </li>
            </ul>
            <ul style="height: 10%;">
                <li style="height: 100%;">
                    <div class="table" style="border-top: 5px solid #000000;">
                        <table style="width: 100%;" cellpadding="5" cellspacing="5" border="0">
                            <tr>
                                <td id="_left_top_welcome">
                                    <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                        scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                    <div id="_left_top_welcome_text" style=" padding-top:5px; padding-bottom:5px;font-size: 30px; color: red; font-weight: bold;">
                                        <%--热烈欢迎各位领导莅临参观指导--%>
                                    </div>
                                </marquee>
                                </td>
                            </tr>
                        </table>
                    </div>
                </li>
            </ul>
        </div>

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
            (function ($) {
                $.getUrlParam = function (name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                }
            })(jQuery);
            var welcomeMsg = $.getUrlParam('welcomeMsg');
            if (welcomeMsg != null && welcomeMsg != "" && welcomeMsg != undefined) {
                $("#_left_top_welcome_text").html(welcomeMsg);
            }
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
                    $("#data_tbody tbody").html("");
                    bulidDataTb();
                    scrollElem.scrollTop = 0;
                    scrollElem.scrollTop += 1;
                }
            }
        </script>

        <script type="text/javascript">
            var gwTimeout;

            $(document).ready(function () {
                ResizeAll();
                //绑定表格数据
                bulidDataTb();
                //获取时间
                GetNowTime();
            });

            function GetNowTime() {
                //$("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
                //setTimeout("GetNowTime()", 1000);
                //获取服务器时间
                $.ajax({
                    type: 'GET',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { 'api': 'GetServerDateAndWeek' },
                    dataType: 'text',
                    success: function (data) {
                        $("#dateAndWeek").html(data);
                    },
                    error: function (e) {
                        console.log(e);
                        return false;
                    }
                });
                if (gwTimeout) {
                    clearTimeout(gwTimeout);
                }
                gwTimeout = setTimeout("GetNowTime()", 1000 * 60 * 1);
            }

            $(window).resize(function () {
                ResizeAll();
            });

            function ResizeAll() {
                //向上滚动
                scroll(50);
                ////某些浏览器不兼容div自适应高度
                //var _contentHeight = $(window).height() * 1 * 0.80;
                //$(".rows").height(_contentHeight * 0.08)
                //if ($(".rows").length * _contentHeight * 0.085 > _contentHeight) {
                //    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                //    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                //    isScroll = true;
                //}
            }

            //绑定表格数据
            function bulidDataTb() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/WareHouseInOperation.ashx',
                    data: { "api": "GetMSDList" },
                    dataType: "json",
                    //contentType: "application/json; charset=utf-8",                    
                    success: function (data) {
                        var html = "";
                        var j = 1;
                        if (data != null && data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                //操作时间
                                var OperateTime = fmtDate(data[i].OperateTime);
                                if (OperateTime == "1900-01-01" || OperateTime == "9999-12-31")
                                    OperateTime = "";
                                else
                                    OperateTime = data[i].OperateTime;

                                //累积暴露时长
                                var TotalExposeMinute = data[i].TotalExposeMinute;
                                var pHour = parseInt(TotalExposeMinute / 60);
                                var pMinute = TotalExposeMinute % 60;
                                var pTotalExposeMinute = "";
                                if (pHour != 0)
                                    pTotalExposeMinute = pHour + "小时";
                                if (pMinute != 0)
                                    pTotalExposeMinute = pTotalExposeMinute + pMinute + "分钟";

                                //剩余暴露时长
                                var BalanceExposeMinute = data[i].BalanceExposeMinute;
                                var pBalanceHour = parseInt(BalanceExposeMinute / 60);
                                var pBalanceMinute = BalanceExposeMinute % 60;
                                var pBalanceExposeMinute = "";
                                var style = "";
                                if (pBalanceMinute < 0)
                                    style = "style='color:red;'";

                                if (pBalanceHour != 0)
                                    pBalanceExposeMinute = pBalanceHour + "小时";
                                else {
                                    if (pBalanceMinute < 0)
                                        pBalanceExposeMinute = "-" + pBalanceHour + "小时";
                                }
                                if (pBalanceMinute > 0)
                                    pBalanceExposeMinute = pBalanceExposeMinute + pBalanceMinute + "分钟";
                                else if (pBalanceMinute < 0)
                                    pBalanceExposeMinute = pBalanceExposeMinute + pBalanceMinute * (-1) + "分钟";

                                html += "<tr class=\"rows\" " + style + ">" +
                                    "<td style=\"width:5%\">" + j + "</td>" +
                                    "<td style=\"width:12%\">" + data[i].SerialNumber + "</td>" +
                                    "<td style=\"width:11%\">" + data[i].ItemCode + "</td>" +
                                    "<td style=\"width:15%\">" + data[i].ItemName + "</td>" +
                                    "<td style=\"width:10%\">" + data[i].OperateDes + "</td>" +
                                    "<td style=\"width:10%\">" + data[i].ContainerCode + "</td>" +
                                    "<td style=\"width:15%\">" + OperateTime + "</td>" +
                                    "<td style=\"width:10%\">" + pTotalExposeMinute + "</td>" +
                                    "<td style=\"width:10%\">" + pBalanceExposeMinute + "</td>" +
                                    "</tr>";
                                j++;
                            }
                        }
                        document.getElementById("container_1").innerHTML = html;
                        ResizeAll();
                    }
                });
                setTimeout("bulidDataTb()", 1000 * 60 * 5);
            }


            function fmtDate(obj) {
                obj = obj.replace(new RegExp(/-/gm), "/"); 　　//将所有的'-'转为'/'即可
                var date = new Date(obj);
                var y = date.getFullYear();
                var m = "0" + (date.getMonth() + 1);
                var d = "0" + date.getDate();
                return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
            }


            var scrollFlag = true;
            var timer;
            function scroll(speed) {
                if (timer) {
                    clearInterval(timer);
                }
                var container1 = document.getElementById("container_1");
                var container2 = document.getElementById("container_2");
                var container = document.getElementById("container");
                if ($(container1).height() < $(container).height()) {
                    scrollFlag = false;
                    return;
                }
                scrollFlag = true;
                container2.innerHTML = container1.innerHTML;
                container.scrollTop = 0; // 开始无滚动时设为0
                timer = setInterval(rollStart, speed); //speed 为滚动速度
                // 鼠标移入div时暂停滚动
                container.onmouseover = function () {
                    scrollFlag = false;
                }
                // 鼠标移出div后继续滚动
                container.onmouseout = function () {
                    scrollFlag = true;
                }
            }

            // 开始滚动
            function rollStart() {
                if (!scrollFlag) {
                    return;
                }
                var container1 = document.getElementById("container_1");
                var container2 = document.getElementById("container_2");
                var container = document.getElementById("container");
                var preTop = container.scrollTop;
                container.scrollTop += 1;
                if (preTop == container.scrollTop) {
                    container.scrollTop = 0;
                    container.scrollTop += 1;
                }
            }
        </script>
    </form>
</body>
</html>
