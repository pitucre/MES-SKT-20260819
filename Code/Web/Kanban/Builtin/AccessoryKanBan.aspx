<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessoryKanBan.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.AccessoryKanBan" %>


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
        html, body, form {
            width: 100%;
            height: 100%;
            margin: 0px;
            padding: 0px;
            border: 0px;
            font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif;
            color: #fff;
            background-color: #041622;
            font-size: 14px;
            overflow: hidden;
        }

        ul, li {
            margin: 0px;
            padding: 0px;
            list-style: none;
            text-align: center; /*border: 1px solid #38FFFF;*/
        }

        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat 15px center;
            background-size: 94%; /*background-color: #0D213A;*/
        }

        .logo_cus2 {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat 15px center;
            background-size: 90%;
        }

        .table {
            display: table;
            height: 100%;
            width: 100%;
            position: relative;
        }

        .cell {
            display: table-cell;
            width: 100%;
            height: 100%;
            vertical-align: middle;
        }

        th {
            height: 35px;
            line-height: 35px;
            text-align: center;
            font-size: 20px;
            color: #1ab2c7;
        }

        tr {
            height: 22px;
            line-height: 22px;
            text-align: center;
            font-size: 18px;
            color: #38FFFF;
        }

        .thTitle {
            font-size: 20px;
            color: #fff;
        }

        .chart-tit {
            font-size: 20px;
            color: #fff;
            font-weight: bold;
            text-align: center;
            text-shadow: 3px 2px 8px #5a5af7;
        }

        #div1 {
            display: black;
            width: 110px;
            height: 50px;
            line-height: 50px;
            white-space: nowrap;
            overflow: hidden;
            background-color: #a2a2a2;
            margin: 15px;
            padding: 5px 15px;
        }

        span {
            display: inline-block;
            color: #fff;
            padding-right: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 8%;">
                <li style="height: 100%;">
                    <span class="logo_cus2 cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 57%;">
                        <span class="cell" style="font-size: 36px; color: #38FFFF; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">辅料管理看板</span>
                    </div>
                    <div class="table" style="float: right; width: 19%;">
                        <span class="cell" style="font-size: 18px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>
            <ul style="height: 84%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000;">
                <li style="height: 80%;">
                    <table style="width: 100%; table-layout: fixed;">
                        <tr class="rows">
                            <th style="width: 5%" class="thTitle">序号</th>
                            <th style="width: 10%" class="thTitle">系列号</th>
                            <th style="width: 10%" class="thTitle">辅料编码</th>
                            <th style="width: 10%" class="thTitle">辅料类别名称</th>
                            <th style="width: 10%" class="thTitle">工单</th>
                            <th style="width: 7%" class="thTitle">状态</th>
                            <th style="width: 7%" class="thTitle">使用时长</th>
                            <th style="width: 10%" class="thTitle">解冻时间</th>
                            <th style="width: 15%" class="thTitle">失效时间</th>
                            <th style="width: 15%" class="thTitle">发料时间</th>
                            <th style="width: 7%" class="thTitle">生产日期</th>
                        </tr>
                    </table>
                    <div id="_layout_left_data_div_tbody">
                        <div id="_layout_left_data_div2_tbody">
                            <table id="data_tbody" style="width: 100%; font-size: 22px; color: #4EC9CE; table-layout: fixed;">
                                <tbody id="dataList">
                                </tbody>
                            </table>
                        </div>
                    </div>
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
            var chartToday = null;
            var chartMonth = null;

            $(document).ready(function () {
                ResizeAll();
                //绑定表格数据
                bulidDataTb();
                //获取时间
                GetNowTime();
            });

            function GetNowTime() {
                $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
                setTimeout("GetNowTime()", 1000);
            }

            $(window).resize(function () {
                ResizeAll();
                if (chartToday != null) { chartToday.resize(); }
                if (chartMonth != null) { chartMonth.resize(); }
            });

            function ResizeAll() {
                //某些浏览器不兼容div自适应高度
                var _contentHeight = $(window).height() * 1 * 0.80;
                $(".rows").height(_contentHeight * 0.08)
                if ($(".rows").length * _contentHeight * 0.085 > _contentHeight) {
                    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                    isScroll = true;
                }
            }

            //判断时间是否过期
            function IsExpired(time) {
                var strtime = time.replace("/-/g", "/");//时间转换
                //时间
                var date1 = new Date(strtime);
                //现在时间
                var date2 = new Date();
                //判断时间是否过期
                return date1 < date2 ? true : false;
            }

            function getHour(s1) {
                s1 = new Date(s1.replace(/-/g, '/'));
                var s2 = new Date();
                var ms = Math.abs(s1.getTime() - s2.getTime());
                return ms / 1000 / 60 / 60;
            }

            //绑定表格数据
            function bulidDataTb() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/WareHouseInOperation.ashx',
                    data: { "api": "GetAccessoryList" },
                    dataType: "json",
                    //contentType: "application/json; charset=utf-8",                    
                    success: function (data) {
                        var html = "";
                        var j = 1;
                        if (data != null && data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                var StartThawTime = fmtDate(data[i].StartThawTime);//解冻时间
                                var LoseTime = fmtDate(data[i].LoseTime);//失效时间
                                var UnsealTime = fmtDate(data[i].UnsealTime);//发料时间
                                var ProdDateTime = fmtDate(data[i].ProdDateTime);//生产日期
                                if (StartThawTime == "1900-01-01" || StartThawTime == "9999-12-31")
                                    StartThawTime = "";
                                else
                                    StartThawTime = data[i].StartThawTime;

                                if (LoseTime == "1900-01-01" || LoseTime == "9999-12-31")
                                    LoseTime = "";
                                else
                                    LoseTime = data[i].LoseTime;

                                if (UnsealTime == "1900-01-01" || UnsealTime == "9999-12-31")
                                    UnsealTime = "";
                                else
                                    UnsealTime = data[i].UnsealTime;

                                if (ProdDateTime == "1900-01-01" || ProdDateTime == "9999-12-31")
                                    ProdDateTime = "";
                                var style = "";
                                //style="color:red;background-color:yellow;"
                                if (LoseTime != "") {
                                    if (IsExpired(LoseTime)) {//已失效
                                        style = "style='color:red;'";
                                    } else { //即将失效
                                        if (getHour(LoseTime) <= 48) {
                                            style = "style='color:yellow;'";
                                        }
                                    }
                                }
                                html += "<tr class=\"rows\" " + style + ">" +
                                    "<td style=\"width:5%\">" + j + "</td>" +
                                    "<td style=\"width:10%\">" + data[i].SerialNumber + "</td>" +
                                    "<td style=\"width:10%\">" + data[i].AccessoryCodoe + "</td>" +
                                    "<td style=\"width:10%\">" + data[i].AccessoryTypeName + "</td>" +
                                    "<td style=\"width:10%\">" + data[i].OrderNO + "</td>" +
                                    "<td style=\"width:7%\">" + data[i].pStatusName + "</td>" +
                                    "<td style=\"width:7%\">" + data[i].UserTime + "&nbsp;H</td>" +
                                    "<td style=\"width:10%\">" + StartThawTime + "</td>" +
                                    "<td style=\"width:15%\">" + LoseTime + "</td>" +
                                    "<td style=\"width:15%\">" + UnsealTime + "</td>" +
                                    "<td style=\"width:7%\">" + ProdDateTime + "</td>" +
                                    "</tr>";
                                j++;
                            }
                        }
                        document.getElementById("dataList").innerHTML = html;
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

        </script>
    </form>
</body>
</html>
