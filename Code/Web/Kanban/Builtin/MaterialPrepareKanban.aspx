<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialPrepareKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.MaterialPrepareKanban" %>


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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <%--<div style="height: 8%; position: relative;">
                <span class="logo_cus cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                <div class="table" style="float: left; width: 240px; position: absolute; left: 40%;">
                    <span class="cell" style="font-size: 36px; color: #38FFFF; text-align: center; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">仓库备料看板</span>
                </div>
                <span class="logo_cus2 cell" style="position: absolute; width: 260px; right: 0%; display: block; float: right;"></span>
                <div class="table" style="width: 300px; position: absolute; right:0px; float: right;">
                    <span class="cell" style="font-size: 18px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                </div>
            </div>--%>
            <ul style="height: 8%;">
                <li style="height: 100%;">
                    <span class="logo_cus2 cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 57%;">
                        <span class="cell" style="font-size: 36px; color: #38FFFF; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">仓库备料看板</span>
                    </div>
                    <div class="table" style="float: right; width: 19%;">
                        <span class="cell" style="font-size: 18px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>
            <ul style="height: 44%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000;">
                <li style="height: 42%;">
                    <table style="width: 100%; table-layout: fixed;">
                        <tr class="rows">
                            <th style="width: 5%" class="thTitle">序号</th>
                            <th style="width: 12%" class="thTitle">领料单号</th>
                           <%-- <th style="width: 11%" class="thTitle">订单</th>--%>
                            <th style="width: 13%" class="thTitle">调出仓库</th>
                            <th style="width: 13%" class="thTitle">物料编码</th>
                            <th style="width: 13%" class="thTitle">物料名称</th>
                            <th style="width: 7%" class="thTitle">数量</th>
                            <th style="width: 10%" class="thTitle">申请人</th>
                            <th style="width: 8%" class="thTitle">使用日期</th>
                            <th style="width: 8%" class="thTitle">发料状态</th>
                            <%--<th style="width: 8%" class="thTitle">备注</th>--%>
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
            <div style="height: 38%;">
                <ul style="height: 100%;">
                    <li style="height: 99%; margin-top: 10px; position: relative;">
                        <div style="height: 100%; width: 48%; border-right: 5px solid #000000; position: absolute; left: 0px;">
                            <%--<div class="chart-tit" style=" height: 10%">
                                今日发料统计
                            </div>--%>
                            <div style="width: 100%; height: 100%">
                                <div id="prepareToday" style="width: 100%; height: 100%"></div>
                            </div>
                        </div>
                        <div style="height: 100%; width: 48%; position: absolute; right: 0px;">
                            <%--<div class="chart-tit" style=" height: 10%">
                                近一月发料统计
                            </div>--%>
                            <div style="width: 100%; height: 100%;">
                                <div id="prepareMonth" style="width: 100%; height: 112%"></div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
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
            <%--<div style="height: 10%; border-top: 5px solid #000000;">
                <div class="marquee-info" style="height: 100%; width: 100%; padding-top: 10px;">
                    <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;" scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                        <div id="_left_top_welcome_text" style="font-size: 30px; color: red; font-weight: bold; ">
                            热烈欢迎各位领导莅临参观指导
                        </div>
                    </marquee>
                </div>
            </div>--%>
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
                //今日发料统计
                TodayData();
                //近一月发料统计
                MonthData();
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
                var _contentHeight = $(window).height() * 1 * 0.44;
                $("#_layout_left_data_div_tbody").css("height", "auto");
                $(".rows").height(_contentHeight * 0.1)
                if ($(".rows").length * _contentHeight * 0.14 > _contentHeight) {
                    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                    isScroll = true;
                }
                //var parentHeight = $(".marquee-info").height();
                //var marqueeHeight = $("#_left_top_welcome_text").height();
                //var top = (parentHeight - marqueeHeight) / 2;
                //top = top + "px";
                //$("#_left_top_welcome_text").css({ "margin-top": top });
            }

            //绑定表格数据
            function bulidDataTb() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/WareHouseInOperation.ashx',
                    data: { "api": "GetMaterialPrepare" },
                    dataType: "json",
                    //contentType: "application/json; charset=utf-8",                    
                    success: function (data) {
                        var html = "";
                        var j = 1;
                        if (data != null && data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                html += "<tr class=\"rows\">" +
                                    "<td style=\"width:5%\">" + j + "</td>" +
                                    "<td style=\"width:12%\">" + data[i].ApplyNo + "</td>" +
                                   /* "<td style=\"width:11%\">" + data[i].SourceBillNo + "</td>" +*/
                                    "<td style=\"width:13%\">" + data[i].MOCode + "</td>" +
                                    "<td style=\"width:13%\">" + data[i].ItemCode + "</td>" +
                                    "<td style=\"width:13%\">" + data[i].ItemName + "</td>" +
                                    "<td style=\"width:7%\">" + data[i].ApplyQty + "</td>" +
                                    "<td style=\"width:10%\">" + data[i].DepName + "</td>" +
                                    "<td style=\"width:8%\">" + fmtDate(data[i].UseDateTime) + "</td>" +
                                    "<td style=\"width:8%\">" + data[i].StatueDesc + "</td>" +
                                    //"<td style=\"width:8%\">" + data[i].Remark + "</td>" +
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

            //今日发料统计 
            function TodayData() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/WareHouseInOperation.ashx',
                    data: { "api": "GetMaterialPrepareStatistics", "type": "0" },
                    dataType: "json",
                    //contentType: "application/json; charset=utf-8",                    
                    success: function (data) {
                        //今日发料统计
                        var xData = [];
                        var yData = [];
                        $.each(data, function (i, item) {
                            xData.push(item.CreateBy);
                            //yData.push(item.SendQty);
                            yData.push(item.GRNQty);
                        });

                        // 初始化echarts实例
                        chartToday = echarts.init(document.getElementById('prepareToday'));

                        // 指定图表的配置项和数据
                        //var option = {
                        //    tooltip: {},
                        //    xAxis: {
                        //        data: xData,
                        //        axisLabel: {
                        //            fontSize: 16,
                        //            color: '#1ab2c7'
                        //        }
                        //    },
                        //    yAxis: {
                        //        axisLabel: {
                        //            fontSize: 16,
                        //            color: '#1ab2c7'
                        //        }
                        //    },
                        //    series: [{
                        //        name: '发料项次',
                        //        type: 'bar',
                        //        data: yData,
                        //        itemStyle: {
                        //            normal: {
                        //                color: function (params) {
                        //                    var colorList = ['#37A2DA', '#32C5E9', '#67E0E3', '#9FE6B8', '#FFDB5C', '#ff9f7f', '#fb7293', '#E062AE', '#E690D1', '#e7bcf3', '#9d96f5', '#8378EA', '#96BFFF'];
                        //                    return colorList[params.dataIndex];
                        //                }
                        //            }
                        //        }
                        //    }]
                        //};

                        var option = {
                            title: {
                                text: "今日发料统计",
                                x: 'center',
                                textStyle: {
                                    fontSize: 20,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 20,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 5
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
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: 'GRN数量',
                                    type: 'bar',
                                    barWidth: '60%',
                                    itemStyle: {
                                        normal: {
                                            color: function (p) {
                                                var colorList = ['#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#32E0E7', '#826A4F', '#51DE8A', '#25851D', '#ADC7B8', ];
                                                var index = p.dataIndex;
                                                return colorList[index];
                                            }, label: {
                                                show: true, //开启显示
                                                position: 'top', //在上方显示
                                                textStyle: { //数值样式										
                                                    color: '#378DBD',
                                                    fontSize: 16
                                                }
                                            }
                                        }
                                    },
                                    data: yData
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartToday.setOption(option);
                    }
                });

                setTimeout("TodayData()", 1000 * 60 * 5);
            }


            //近一月发料统计
            function MonthData() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/WareHouseInOperation.ashx',
                    data: { "api": "GetMaterialPrepareStatistics", "type": "1" },
                    dataType: "json",
                    //contentType: "application/json; charset=utf-8",                    
                    success: function (data) {
                        //近一月发料统计
                        var legendData = [];
                        var seriesData = [];

                        //$.each(data, function (i, item) {
                        //    count += parseInt(item.GRNQty);
                        //});

                        $.each(data, function (i, item) {
                            legendData.push(item.CreateBy);
                            seriesData.push({
                                //value: item.SendQty,
                                value: item.GRNQty,
                                name: item.CreateBy
                            });
                        });

                        // 初始化echarts实例
                        chartMonth = echarts.init(document.getElementById('prepareMonth'));

                        var option = {
                            title: {
                                text: '近一月发料统计',
                                x: 'center',
                                textStyle: {
                                    fontSize: 20,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 20,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 5
                            },
                            tooltip: {
                                trigger: 'item',
                                formatter: "{b} : {c} ({d}%)"
                            },
                            //legend: {
                            //    x: 'center',
                            //    y: 'bottom',
                            //    padding: [0, 0, 20, 0],
                            //    textStyle: {
                            //        fontSize: 13,
                            //        color: '#58B2D4'
                            //    },
                            //    data: legendData
                            //},
                            toolbox: {
                                show: false
                            },
                            calculable: true,
                            series: [
                                {
                                    type: 'pie',
                                    radius: ['30%', '55%'],
                                    center: ['50%', '50%'],
                                    label: {
                                        normal: {
                                            show: true,
                                            color: "#58B2D3",
                                            fontSize: 18,
                                            fontWeight: 'bold',
                                            //formatter: "{b}：{d}%"
                                            formatter: "{b}：{c} 占 {d}%"
                                        },
                                        emphasis: {
                                            show: true,
                                            fontSize: 20,
                                            shadowBlur: 10,
                                            shadowOffsetX: 0,
                                            shadowColor: '#fff'
                                        }
                                    },
                                    lableLine: {
                                        normal: {
                                            show: true,
                                        },
                                        emphasis: {
                                            show: true
                                        }
                                    },
                                    itemStyle: {
                                        normal: {
                                            color: function (p) {
                                                var colorList = ['#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#32E0E7', '#826A4F', '#51DE8A', '#25851D', '#ADC7B8', ];
                                                var index = p.dataIndex;
                                                return colorList[index];
                                            }
                                        }
                                    },
                                    data: seriesData
                                }
                            ]
                        };
                        /*注册ECHARTS*/
                        chartMonth.setOption(option, true);

                        //option = {
                        //    color: ['#91c7ae', '#eedd78', '#546570', '#61a0a8', '#d48265', '#749f83', '#ca8622', '#91ca8c', '#f49f42', '#8dc1a9', '#ea7e53', '#c23531', '#2f4554', '#bda29a', '#6e7074', '#c4ccd3'],
                        //    tooltip: {
                        //        formatter: "{b} : {c} ({d}%)"
                        //    },
                        //    series: [{
                        //        type: 'pie',
                        //        data: seriesData,
                        //        label: {
                        //            normal: {
                        //                formatter: '{b|{b}：} {per|{d}%}  ',
                        //                rich: {
                        //                    b: {
                        //                        fontSize: 16,
                        //                        lineHeight: 33
                        //                    }
                        //                }
                        //            }
                        //        },
                        //        itemStyle: {
                        //            emphasis: {
                        //                shadowBlur: 10,
                        //                shadowOffsetX: 0,
                        //                shadowColor: 'rgba(0, 0, 0, 0.5)'
                        //            }
                        //        }
                        //    }]
                        //};

                        //// 使用刚指定的配置项和数据显示图表。
                        //chartMonth.setOption(option);
                    }
                });

                setTimeout("MonthData()", 1000 * 60 * 5);
            }
        </script>
    </form>
</body>
</html>
