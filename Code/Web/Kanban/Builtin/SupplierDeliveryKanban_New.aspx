<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierDeliveryKanban_New.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.SupplierDeliveryKanban_New" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
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
            text-align: center;
            /*border: 1px solid #38FFFF;*/
        }

        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat 15px center;
            background-size: 94%;
            /*background-color: #0D213A;*/
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
            color: #1AB2C7;
        }

        tr {
            height: 22px;
            line-height: 22px;
            text-align: center;
            font-size: 18px;
            color: #1AB2C7;
        }

        .tdFont {
            font-size: 28px;
            color: #38FFFF;
            font-weight: bold;
        }

        .tdFont1 {
            font-size: 26px;
            color: #FFFFFF;
            font-weight: bold;
            text-align: left;
        }

        .thTitle {
            font-size: 18px;
            color: #FFFFFF;
            font-weight: bold;
        }

        .thTitle1 {
            font-size: 16px;
            color: #38FFFF;
        }

        .thTitle2 {
            font-size: 16px;
            color: red;
            /*text-shadow: 3px 2px 8px #5a5af7;*/
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 10%;">
                <li style="height: 100%;">
                    <span class="logo_cus2 cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 57%;">
                        <span class="cell" style="font-size: 36px; color: #FFFFFf; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">供应商送货看板</span>
                    </div>
                    <div class="table" style="float: right; width: 19%;">
                        <span class="cell" style="font-size: 18px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>
            <ul style="height: 42%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000;">
                <li style="height: 42%;">
                    <table style="width: 100%;">
                        <tr class="rows">
                            <th style="width: 5%" class="thTitle">序号</th>
                            <th style="width: 10%" class="thTitle">采购单</th>
                            <th style="width: 10%" class="thTitle">送货单</th>
                            <th style="width: 10%" class="thTitle">物料编码</th>
                            <th style="width: 14%" class="thTitle">物料名称</th>
                            <th style="width: 9%" class="thTitle">送货数量</th>
                            <th style="width: 7%" class="thTitle">导入状态</th>
                            <th style="width: 11%" class="thTitle">送出日期</th>
                            <th style="width: 7%" class="thTitle">送出状态</th>
                            <th style="width: 25%" class="thTitle">供应商</th>
                        </tr>
                    </table>
                    <div id="_layout_left_data_div_tbody">
                        <div id="_layout_left_data_div2_tbody">
                            <table id="data_tbody" style="width: 100%; font-size: 22px; color: #4EC9CE; margin: 0 auto; height: 16%;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </li>
            </ul>
            <ul style="height: 38%;">
                <li style="height: 99%; margin-top: 10px;">
                    <div style="height: 100%; width: 20%; float: left; border-right: 5px solid #000000;" id="echarts_gauge3">
                        <div style="height: 10%; font-size: 20px; color: #F1F1F2; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold; text-align: left;">
                            &nbsp;&nbsp;
                        </div>
                        <table style="height: 90%; width: 100%">
                            <tr style="border-bottom: 5px solid #000000;">
                                <td class="tdFont">当天计划数量</td>
                                <td class="tdFont1">
                                    <label id="lblPlanQty">0</label></td>
                            </tr>
                            <tr style="border-bottom: 5px solid #000000;">
                                <td class="tdFont">当天计划项次</td>
                                <td class="tdFont1">
                                    <label id="lblItemCount">0</label></td>
                            </tr>
                            <tr>
                                <td class="tdFont">实际到货数量</td>
                                <td class="tdFont1">
                                    <label id="lblActualQtyTotal">0</label></td>
                            </tr>
                            <tr>
                                <td class="tdFont">实际到货项次</td>
                                <td class="tdFont1">
                                    <label id="lblActualItemCount">0</label></td>
                            </tr>
                            <tr>
                                <td class="tdFont">到货率(项次)</td>
                                <td class="tdFont1">
                                    <label id="lblArrivalRate">0</label>%</td>
                            </tr>
                        </table>
                    </div>


                    <div style="height: 100%; width: 79%; float: left; border-right: 5px solid #000000;" class="gauge" id="echarts_gauge1"></div>

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
                                     <%--   热烈欢迎各位领导莅临参观指导--%>
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
            $("#_left_top_welcome_text").html(welcomeMsg);
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
            var echart1, echart2, echart3;
            $(document).ready(function () {
                ResizeAll();
                bulidDataTb();
                PlanActualData();
                GetInfo();
                GetNowTime();
            });

            function GetNowTime() {
                $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
                setTimeout("GetNowTime()", 1000);
            }

            function getWelcome() {
                $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
                clearTimeout(gwTimeout);
                var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 10);
            }

            $(window).resize(function () {
                ResizeAll();
                if (echart1 != null) { echart1.resize(); }
                if (echart2 != null) { echart2.resize(); }
                if (echart3 != null) { echart3.resize(); }
            });

            function ResizeAll() {
                //某些浏览器不兼容div自适应高度
                //$(".gauge").height($(window).height() * 0.9 * 0.27);

                var _contentHeight = $(window).height() * 1 * 0.4;

                $("#_layout_left_data_div_tbody").css("height", "auto");

                $(".rows").height(_contentHeight * 0.1)

                if ($(".rows").length * _contentHeight * 0.14 > _contentHeight) {
                    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                    isScroll = true;
                }
            }

            function GetInfo() {
                $.ajax({
                    type: 'POST',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SupplierDeliveryKanban_New.ashx',
                    data: { 'Type': 'GetSummaryInfo' },
                    dataType: "Json",
                    success: function (result) {
                        if (result == null) {
                            return false;
                        }
                        if (result) {
                            $("#lblPlanQty").text(result["PlanQty"]);
                            $("#lblItemCount").text(result["ItemCount"]);
                            $("#lblActualQtyTotal").text(result["ActualQtyTotal"]);
                            $("#lblActualItemCount").text(result["ActualItemCount"]);
                            $("#lblArrivalRate").text(result["ArrivalRate"]);
                        }
                    }
                });
                setTimeout("GetInfo()", 1000 * 60 * 3);
            }

            //当天供应商计划到货数与实际到货数比较 
            function PlanActualData() {
                $.ajax({
                    type: 'post',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SupplierDeliveryKanban_New.ashx',
                    data: { 'Type': 'GetDeliveryData' },
                    dataType: "json",
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        var yData2 = [];
                        $.each(data, function (i, item) {
                            xData.push(item.SupplierName);
                            yData.push(item.PlanQty);
                            yData2.push(item.ActualQty);
                        });

                        // 初始化echarts实例
                        chartToday = echarts.init(document.getElementById('echarts_gauge1'));

                        var option = {
                            title: {
                                text: '供应商计划送货数量与实际送货数量对比图',
                                textStyle: {

                                    fontSize: 16,
                                    color: '#FFFFFF',          // 主标题文字颜色
                                },
                                left: '40%'
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            color: ['#447DFE', '#95CA13'],
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'shadow'
                                }
                            },
                            calculable: true,
                            xAxis: [
                                {
                                    type: 'category',
                                    axisTick: { show: false },
                                    axisLabel: {
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                            interval: 0,//横轴信息全部显示
                                            rotate: 0,//度角倾斜显示    
                                        }
                                    },
                                    data: xData
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        linestyle: {
                                            color: '#378dbd',
                                        }
                                    },
                                    splitline: {
                                        linestyle: {
                                            color: '#1f1529',
                                        }
                                    },
                                    axisLabel: {
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        },
                                        formatter:'{value} K'                                      
                                    },
                                }
                            ],
                            series: [
                                {
                                    name: '计划数',
                                    type: 'bar',
                                    barGap: 0,
                                    data: yData,
                                    itemStyle: {        //上方显示数值
                                        normal: {
                                            label: {
                                                show: true, //开启显示
                                                position: 'top', //在上方显示
                                                textStyle: { //数值样式
                                                    color: '#378DBD',
                                                    fontSize: 14
                                                }
                                            }
                                        }
                                    }
                                },
                                {
                                    name: '实际数',
                                    type: 'bar',
                                    data: yData2,
                                    itemStyle: {        //上方显示数值
                                        normal: {
                                            label: {
                                                show: true, //开启显示
                                                position: 'top', //在上方显示
                                                textStyle: { //数值样式
                                                    color: '#378DBD',
                                                    fontSize: 14
                                                }
                                            }
                                        }
                                    }
                                }
                            ]
                        };
                        // 使用刚指定的配置项和数据显示图表。
                        chartToday.setOption(option);
                    }
                });

                setTimeout("PlanActualData()", 1000 * 60 * 5);
            }


            function bulidDataTb() {
                var html = "";
                $.ajax({
                    type: 'POST',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SupplierDeliveryKanban_New.ashx',
                    data: { 'Type': 'SupplierDelivery' },
                    dataType: "Json",
                    success: function (data) {
                        if (data == null) { return false; }
                        $.each(data, function (i, n) {

                            if (n["ImportState"] == "Y") {
                                html += '<tr class="rows" >' +
                                 '<td style="width: 5%" class="thTitle1">' + n["RowId"] + '</td>' +
                                 '<td style="width: 10%" class="thTitle1">' + n["POCode"] + '</td>' +
                                 '<td style="width: 10%" class="thTitle1">' + n["DeliverNo"] + '</td>' +
                                 '<td style="width: 10%" class="thTitle1">' + n["ItemCode"] + '</td>' +
                                 '<td style="width: 14%" class="thTitle1">' + n["ItemName"] + '</td>' +
                                 '<td style="width: 9%" class="thTitle1">' + n["SentQty"] + '</td>' +
                                 '<td style="width: 7%" class="thTitle1">' + n["ImportState"] + '</td>' +
                                 //'<td style="width: 10%" class="thTitle1">' + dateFtt('MM-dd hh:mm', n["CreateDateTime"]) + '</td>' +
                                 '<td style="width: 11%" class="thTitle1">' + n["CreateDateTime"] + '</td>' +
                                 '<td style="width: 7%" class="thTitle1">' + n["DeliState"] + '</td>' +
                                 '<td style="width: 25%" class="thTitle1">' + n["VendorName"] + '</td>' +
                                 '</tr>';
                            }
                            else {
                                html += '<tr class="rows" >' +
                                 '<td style="width: 5%" class="thTitle2">' + n["RowId"] + '</td>' +
                                 '<td style="width: 10%" class="thTitle2">' + n["POCode"] + '</td>' +
                                 '<td style="width: 10%" class="thTitle2">' + n["DeliverNo"] + '</td>' +
                                 '<td style="width: 10%" class="thTitle2">' + n["ItemCode"] + '</td>' +
                                 '<td style="width: 14%" class="thTitle2">' + n["ItemName"] + '</td>' +
                                 '<td style="width: 9%" class="thTitle2">' + n["SentQty"] + '</td>' +
                                 '<td style="width: 7%" class="thTitle2">' + n["ImportState"] + '</td>' +
                                 //'<td style="width: 10%" class="thTitle1">' + dateFtt('MM-dd hh:mm', n["CreateDateTime"]) + '</td>' +
                                 '<td style="width: 11%" class="thTitle2">' + n["CreateDateTime"] + '</td>' +
                                 '<td style="width: 7%" class="thTitle2">' + n["DeliState"] + '</td>' +
                                 '<td style="width: 25%" class="thTitle2">' + n["VendorName"] + '</td>' +
                                 '</tr>';
                            }
                          
                        })
                        $(html).appendTo($("#data_tbody tbody"));
                        ResizeAll();
                    }
                });


            }
            function dateFtt(fmt, date) { //author: meizz   
                date = date.replace(/-/g, "/"); //为了兼容IE
                date = new Date(date);
                var o = {
                    "M+": date.getMonth() + 1,                 //月份   
                    "d+": date.getDate(),                    //日   
                    "h+": date.getHours(),                   //小时   
                    "m+": date.getMinutes(),                 //分   
                    "s+": date.getSeconds(),                 //秒   
                    "q+": Math.floor((date.getMonth() + 3) / 3), //季度   
                    "S": date.getMilliseconds()             //毫秒   
                };
                if (/(y+)/.test(fmt))
                    fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
                for (var k in o)
                    if (new RegExp("(" + k + ")").test(fmt))
                        fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                return fmt;
            }
        </script>
    </form>
</body>
</html>
