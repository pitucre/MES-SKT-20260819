<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.EquipmentKanban" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
     <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <title></title>

    <style type="text/css">
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 14px; overflow: hidden; }
        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; }
        /*.logo_cus { background: url('../../Content/images/logo/customer-logo.png') no-repeat 20px center; background-size: 45%; }*/
        .logo_skt { background: url('../../Content/images/logo/skt-logo.png') no-repeat center center; background-size: 90%; }
        .table { display: table; height: 100%; width: 100%; position: relative; }
        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }
        th { height: 35px; line-height: 35px; text-align: center; font-size: 21px; color: #fff; }
        tr { height: 22px; line-height: 28px; text-align: center; font-size: 21px; color: #fff; }
        .chart-tit { font-size: 20px; color: #fff; font-weight: bold; text-align: center; text-shadow: 3px 2px 8px #5a5af7; }
        #div1 { display: black; width: 110px; height: 50px; line-height: 50px; white-space: nowrap; overflow: hidden; background-color: #a2a2a2; margin: 15px; padding: 5px 15px; }
        span { display: inline-block; color: #fff; }

        #dataList tr { color: #38FFFF;  }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 10%;" class="kanban-head">
                <li style="height: 100%;">
                    <span class="logo_cus cell" style="width: 270px; display: block; float: left;"></span>
                    <div class="table kanban-name" style="float: left;">
                        <span class="cell" style="font-size: 42px; color: #fff; font-weight: bold;">设备看板</span>
                    </div>
                    <div class="table date-skt-logo" style="float: right; width: 270px;">
                        <span class="cell" style="font-size: 19px; color: #fff; font-weight: bold;" id="dateAndWeek"></span>
                        <%--<span class="logo_skt" style="width: 150px; height: 100%;"></span>--%>
                    </div>
                </li>
            </ul>
            <ul style="height: 80%; border-bottom: 5px solid #0c0c0c; border-top: 5px solid #0c0c0c;">
                <li style="height: 100%;">
                    <%--上--%>
                    <div class="chart-middle" style="height: 49.5%; width: 100%; border-bottom: 5px solid #0c0c0c;">
                        <%--设备日保养完成率--%>
                     <%--   <div style="width: 33%; height: 100%; float: left;">
                            <div id="chart-complete" style="width: 100%; height: 100%;">
                            </div>
                        </div>--%>
                        <%--设备故障停机时间月趋势图--%>
                        <div style="width: 49%; height: 100%; float: left; border-right: 5px solid #0c0c0c; border-left: 5px solid #0c0c0c;">
                            <div id="chart-stop-month" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                        <%--月度设备故障停机时间分析（按故障类型）--%>
                        <div style="width: 49%; height: 100%; float: left;">
                            <%--<div id="chart-stop-time" style="width: 100%; height: 100%;">
                            </div>--%>
                            <div id="chart-reapir-avg" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <%--下--%>
                    <div class="chart-middle" style="height: 49.5%; width: 100%;">
                        <%--设备维修平均响应时间月趋势图--%>
                     <%--   <div style="width: 33%; height: 100%; float: left;">
                            <div id="chart-reapir-avg" style="width: 100%; height: 100%;">
                            </div>
                        </div>--%>
                        <%--设备重复维修月趋势图--%>
                        <div style="width: 49%; height: 100%; float: left; border-right: 5px solid #0c0c0c; border-left: 5px solid #0c0c0c;">
                            <div id="chart-one-pass" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                        <%--每单平均检验时间日趋势图--%>
                        <div style="width: 49%; height: 100%; float: left;">
                            <div id="chart-user-complete" style="width: 100%; height: 100%;">
                            </div>
                        </div>

                    </div>
                    <div style="clear: both;"></div>
                </li>
            </ul>
            <ul style="height: 10%;">
                <li style="height: 100%;">
                    <div class="table">
                        <table style="width: 100%; height: 100%;" cellpadding="5" cellspacing="5" border="0">
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
    </form>
</body>
</html>

<script>
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

        var welcomeMsg = $.getUrlParam('welcomeMsg');
        $("#_left_top_welcome_text").html(welcomeMsg);

    })(jQuery);

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
            //style.width = _W;
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
            //$("#data_tbody tbody").html("");
            //bulidDataTb();
            scrollElem.scrollTop = 0;
            scrollElem.scrollTop += 1;
        }
    }

    var _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";

    $(window).resize(function () {
        ResizeAll();
    });

    $(document).ready(function () {

        //获取服务器时间
        getServerTime(0);

        ResizeAll();
    });

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }

    //获取服务器时间
    function getServerTime(flag) {
        //获取服务器时间
        $.ajax({
            type: 'GET',
            url: _webRoot + "/Handler/Kanban.ashx",
            //data: { "api": "GetServerTimeNew", "fmt": "yyyy-MM-dd" },
            data: { "api": "GetServerTimeNew", "fmt": "0" },
            dataType: 'text',
            success: function (data) {
                if (flag == 0) {
                    $("#dateAndWeek").html(data);
                } else {
                    window.location.reload();
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }

    function ResizeAll() {
        var width = $(".kanban-head").width().subtract($(".logo_cus").width().add($(".date-skt-logo").width()));
        $(".kanban-name").width(width.subtract(5));

        //某些浏览器不兼容div自适应高度
        var _contentHeight = $(window).height() * 1 * 0.82;
        $("#_layout_left_data_div_tbody").css("height", "auto");

        //$(".rows").height(_contentHeight * 0.26)
        //if ($(".rows").length * _contentHeight * 0.3 > _contentHeight) {
        //    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.3 * 1 - 1);
        //    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
        //    isScroll = true;
        //}
        $(".rows").height(_contentHeight * 0.08)
        if ($(".rows").length * _contentHeight * 0.12 > _contentHeight) {
            $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.12 * 1 - 1);
            _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
            isScroll = true;
        }

        ResizeChart();

        //$("#_layout_left_data_div_tbody").css({ width: "100%" });
    }

    //浮点型加法运算
    Number.prototype.add = function (val) {
        var len = getPointLen(this, val);
        return ((this * len) + (val * len)) / len;
    }

    //浮点型减法运算
    Number.prototype.subtract = function (val) {
        var len = getPointLen(this, val);
        return ((this * len) - (val * len)) / len;
    }

    //获取小数点最大长度
    function getPointLen(val1, val2) {
        var len1, len2;
        try {
            len1 = val1.toString().split(".")[1].length;
        } catch (e) {
            len1 = 0;
        }
        try {
            len2 = val2.toString().split(".")[1].length;
        } catch (e) {
            len2 = 0;
        }
        return Math.pow(10, Math.max(len1, len2));
    }
</script>

<script type="text/javascript">

   // var chartComplete = echarts.init(document.getElementById('chart-complete'));//设备日保养完成率
    var chartStopMonth = echarts.init(document.getElementById('chart-stop-month'));//设备故障停机时间月趋势图
   // var chartStopTime = echarts.init(document.getElementById('chart-stop-time'));//月度设备故障停机时间分析（按故障类型）				

    var chartReapirAvg = echarts.init(document.getElementById('chart-reapir-avg'));//设备维修平均响应时间月趋势图
    var chartOnePass = echarts.init(document.getElementById('chart-one-pass'));//设备重复维修月趋势图
    var chartUserComplete = echarts.init(document.getElementById('chart-user-complete'));//当日维修完成率（按人员）

    var colorList = ["#229eb1", "#0ebe94", "#9b9f07", "#187e4d", "#1f84ec"];
    var colorList2 = ["#2bbed5", "#12dfae", "#b5ba09", "#1fa062", "#228dfb"];
    var colorList3 = ["#63eaff", "#41fdd0", "#e5ea3c", "#5ae09f", "#83c0ff"];

    var dayCompleteRate = [];//检验完成率
    var dayRepairCompleteQtyData = [];//当日维修完成率（按人员） — 维修完成数
    var dayRepaitInCompleteQty = [];//当日维修完成率（按人员） — 未完成数

    var dataSupplyNgTotal = echarts.util.map([20, 80, 90, 120, 150], function (item, index) {
        return {
            value: item,
            itemStyle: {
                color: colorList2[index]
            }
        };
    });

    function ResizeChart() {

       // if (chartComplete != null) { chartComplete.resize(); }
        if (chartStopMonth != null) { chartStopMonth.resize(); }
     //   if (chartStopTime != null) { chartStopTime.resize(); }

        if (chartReapirAvg != null) { chartReapirAvg.resize(); }
        if (chartOnePass != null) { chartOnePass.resize(); }
        if (chartUserComplete != null) { chartUserComplete.resize(); }
    }

    $(function () {
        ResizeChart();

        getBasalInfo();
        setInterval(function () {
            getBasalInfo();
            //获取服务器时间
            getServerTime(0);
        }, 1000 * 60 * 5);
    });

    //获取基础信息
    function getBasalInfo() {
        //获取检验基本信息
        var ajax = SKT.AjaxCommon.DBService.SearchList("uspEquipmentKanban", JSON.stringify({}));
        if (ajax.error != null) {
            //console.log(ajax.error.Message);
            return false;
        }
        var kanbanData = JSON.parse(ajax.value);

        //设备日保养完成率
        var xAxisAnormalType = [];
        var needInspectionQtyData = [];//待保养数量
        var inspectionQtyData = [];//已保养数量
        var dayOKRate = [];//检验合格率
        dayCompleteRate = [];
        var dayInfo = kanbanData.data;
        if (dayInfo) {
            for (var i = 0; i < dayInfo.length; i++) {
                xAxisAnormalType.push(dayInfo[i].Station);
                dayCompleteRate.push(dayInfo[i].CompleteRate);
                dayOKRate.push(dayInfo[i].OKRate);
                needInspectionQtyData.push(dayInfo[i].NeedInspectionQty);
                inspectionQtyData.push(dayInfo[i].InspectionQty);
            }
        }
        var optionComplete = {
            title:
            {
                text: "设备日保养完成率",
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 2,
                left: "50%"
            },
            grid: {
                left: '10%',
                top: '20%',
                bottom: '13%',
                right: '10%',
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'line'
                }
            },
            xAxis: {
                type: 'category',
                data: xAxisAnormalType,//['12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07'],
                axisLabel: {
                    textStyle: {
                        color: '#378DBD',//坐标值得具体的颜色
                        fontSize: 12,
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#378DBD',
                        interval: 0,//横轴信息全部显示
                        rotate: 0,//度角倾斜显示    
                    }
                },
            },
            yAxis:
                [
                    {
                        name: "合格率",
                        nameLocation: 'end',
                        nameTextStyle: {
                            align: 'center',
                            verticalAlign: 'middle',
                        },
                        type: 'value',
                        max: 120,
                        axisLabel: {
                            textStyle: {
                                color: '#378DBD',//坐标值得具体的颜色
                                fontSize: 12,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#378DBD',
                                interval: 0,//横轴信息全部显示
                                rotate: 0,//度角倾斜显示    
                            }
                        },
                        splitLine: {
                            lineStyle: {
                                color: '#45576F',
                            }
                        },
                    },
                    {
                        //name: "完成率",
                        //nameLocation: 'end',
                        //nameTextStyle: {
                        //    align: 'center',
                        //    verticalAlign: 'middle',
                        //},
                        type: 'value',
                        axisLabel: {
                            textStyle: {
                                color: '#378DBD',//坐标值得具体的颜色
                                fontSize: 12,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#378DBD',
                                interval: 0,//横轴信息全部显示
                                rotate: 0,//度角倾斜显示    
                            }
                        },
                        splitLine: {
                            show: false,
                            //lineStyle: {
                            //    color: '#45576F',
                            //}
                        },
                    }
                ],
            series: [
                {
                    name: '已保养数量',
                    stack: '完成率',
                    data: inspectionQtyData,//[80, 70, 60, 50, 90, 100, 85],
                    type: 'bar',
                    barWidth: 20,
                    barMaxWidth: 40,
                    yAxisIndex: 1,
                    label: {
                        show: true,
                        //formatter: '{c}',
                        formatter: function (v) {
                            //debugger;
                            //var val = v.data;
                            //return percentData.get(val);
                            return dayCompleteRate[v.dataIndex];
                        },
                    },
                    //showBackground: true,
                    //backgroundStyle: {
                    //    color: ["#fff"]
                    //},
                },
                {
                    name: '待保养数量',
                    stack: '完成率',
                    data: needInspectionQtyData,//[80, 70, 60, 50, 90, 100, 85],
                    type: 'bar',
                    barWidth: 20,
                    barMaxWidth: 40,
                    yAxisIndex: 1,
                    label: {
                        show: true,
                        formatter: '{c}',
                        color: '#ff4400',
                    },
                    //showBackground: true,
                    //backgroundStyle: {
                    //    color: ["#fff"]
                    //},
                },
                {
                    name: '每日检验合格率',
                    type: 'line',
                    max: 120,
                    data: dayOKRate,//[50, 90, 70, 60, 100, 70, 80],
                    smooth: 0.6, //使折线图平滑
                    //symbol: 'none',//不显示折线图中的“点点”
                    itemStyle: {
                        color: '#ffce39'
                    },
                    label: {
                        show: true,
                        formatter: "{c}%",
                    },
                    //markLine: {
                    //    lineStyle: {
                    //        type: 'solid',
                    //        color: "#ff4400"
                    //    },
                    //    label: {
                    //        formatter: '目标{c}%',
                    //    },
                    //    data:
                    //        [
                    //            {
                    //                name: 'Y轴基准水平线',
                    //                yAxis: iqcKanbanTargetRate,//80
                    //            }
                    //        ],
                    //},
                }
            ],
            color: ["#00b0f0", "#fff"]
        };
    //    chartComplete.setOption(optionComplete, true);


        //设备故障停机时间月趋势图	
        var xAxisStopMonth = [];
        var stopTime = [];//检验时间（分钟）
        var stopTimeInfo = kanbanData.data1;
        if (stopTimeInfo) {
            for (var i = 0; i < stopTimeInfo.length; i++) {
                xAxisStopMonth.push(stopTimeInfo[i].Mon);
                stopTime.push(stopTimeInfo[i].StopTime);
            }
        }
        var optionStopMonth = {
            title:
            {
                text: "设备故障停机时间月趋势图",
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 2,
                left: "50%"
            },
            grid: {
                left: '17%',
                top: '20%',
                bottom: '13%',
                right: '5%',
            },
            tooltip: {
                trigger: 'axis',
                formatter: '{a} <br/>{b} : {c}h',
                axisPointer: {
                    type: 'line',
                    lineStyle: {
                        color: "#0c3f4c"
                    }
                },
            },
            xAxis: {
                type: 'category',
                boundaryGap: true,
                data: xAxisStopMonth,//['12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07'],
                axisLabel: {
                    textStyle: {
                        color: '#378DBD',//坐标值得具体的颜色
                        fontSize: 12,
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#378DBD',
                        interval: 0,//横轴信息全部显示
                        rotate: 0,//度角倾斜显示    
                    }
                },
            },
            yAxis: {
                type: 'value',
                name: 'h',
                nameLocation: 'end',
                nameTextStyle: {
                    align: 'right',
                    verticalAlign: 'middle',
                },
                axisLabel: {
                    textStyle: {
                        color: '#378DBD',//坐标值得具体的颜色
                        fontSize: 12,
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#378DBD',
                        interval: 0,//横轴信息全部显示
                        rotate: 0,//度角倾斜显示    
                    }
                },
                splitLine: {
                    lineStyle: {
                        color: '#0c3f4c',
                    }
                },
            },
            series: [
                {
                    name: "设备故障停机时间月趋势图",
                    data: stopTime,//[120, 200, 79, 90, 100, 90, 312],
                    type: 'line',
                    smooth: 0.6, //使折线图平滑
                    //symbol: 'none',//不显示折线图中的“点点”
                    itemStyle: {
                        color: '#4762bd',//'#2f489b'
                    },
                    areaStyle: {
                        color: "#1c2a60",
                        //color: {
                        //    type: 'linear',
                        //    x: 0,
                        //    y: 0,
                        //    x2: 0,
                        //    y2: 1,
                        //    colorStops: [{
                        //        offset: 0, color: '#5bd5de' // 0% 处的颜色
                        //    }, {
                        //        offset: 1, color: '#06666c' // 100% 处的颜色
                        //    }],
                        //}
                    },
                    label: {
                        show: true,
                        formatter: '{c}',
                        color: "#8498f0"
                    }
                }
            ]
        };
        chartStopMonth.setOption(optionStopMonth, true);


        //月度设备故障停机时间分析（按故障类型）
        var xAxisAnormalType = [];
        var anormalTypeNameData = [];//故障类型
        var anormalTypeNameRate = [];//故障类型占当月所有故障类型的百分比
        var anormalTypeInfo = kanbanData.data2;
        if (anormalTypeInfo) {
            for (var i = 0; i < anormalTypeInfo.length; i++) {
                xAxisAnormalType.push(anormalTypeInfo[i].AnormalTypeName);
                anormalTypeNameData.push(anormalTypeInfo[i].Qty);

                var rate = parseFloat(anormalTypeInfo[i].Rate);
                for (var j = 0; j < i; j++) {
                    rate = rate.add(anormalTypeInfo[j].Rate);
                }
                if ((i + 1) == anormalTypeInfo.length) {
                    rate = 100;
                }
                anormalTypeNameRate.push(rate);
            }
        }
        var optionStopTime = {
            title:
            {
                //text: "月度设备故障停机时间分析(按故障类型)",
                text: "月度设备故障停机时间分析",
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 2,
                left: "50%"
            },
            grid: {
                left: '10%',
                top: '20%',
                //bottom: '13%',
                bottom: '20%',
                right: '10%',
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'line'
                }
            },
            xAxis: {
                type: 'category',
                data: xAxisAnormalType,//['12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07'],
                axisLabel: {
                    textStyle: {
                        color: '#378DBD',//坐标值得具体的颜色
                        fontSize: 10,
                    },
                    interval: 0,
                    formatter: function (value) {
                        return value.split("").join("\n");
                    }
                },
            },
            yAxis:
                [
                    {
                        type: 'value',
                        max: 120,
                        axisLabel: {
                            textStyle: {
                                color: '#378DBD',//坐标值得具体的颜色
                                fontSize: 12,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#378DBD',
                                interval: 0,//横轴信息全部显示
                                rotate: 0,//度角倾斜显示    
                            }
                        },
                        splitLine: {
                            lineStyle: {
                                color: '#45576F',
                            }
                        },
                    },
                    {
                        type: 'value',
                        name: 'h',
                        nameLocation: 'end',
                        nameTextStyle: {
                            align: 'left',
                            verticalAlign: 'middle',
                        },
                        axisLabel: {
                            textStyle: {
                                color: '#378DBD',//坐标值得具体的颜色
                                fontSize: 12,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#378DBD',
                                interval: 0,//横轴信息全部显示
                                rotate: 0,//度角倾斜显示    
                            }
                        },
                        splitLine: {
                            show: false,
                            //lineStyle: {
                            //    color: '#45576F',
                            //}
                        },
                    }
                ],
            series: [
                {
                    name: '故障类型',
                    data: anormalTypeNameData,//[80, 70, 60, 50, 90, 100, 85],
                    type: 'bar',
                    barWidth: 20,
                    barMaxWidth: 40,
                    yAxisIndex: 1,
                    label: {
                        show: true,
                        formatter: function (v) {
                            return anormalTypeNameData[v.dataIndex];
                        },
                    },
                },
                {
                    name: '故障类型占当月所有故障类型的百分比',
                    type: 'line',
                    data: anormalTypeNameRate,//[50, 90, 70, 60, 100, 70, 80],
                    //smooth: 0.6, //使折线图平滑
                    //symbol: 'none',//不显示折线图中的“点点”
                    itemStyle: {
                        color: '#ffce39'
                    },
                    label: {
                        show: true,
                        formatter: "{c}%",
                    },
                }
            ],
            color: ["#16bcda"]
        };
      //  chartStopTime.setOption(optionStopTime, true);


        //设备维修平均响应时间月趋势图	
        var xAxisReapirAvg = [];
        var averageRepairTime = [];//维修平均响应时间
        var averageRepairTimeInfo = kanbanData.data3;
        if (averageRepairTimeInfo) {
            for (var i = 0; i < averageRepairTimeInfo.length; i++) {
                xAxisReapirAvg.push(averageRepairTimeInfo[i].Mon);
                averageRepairTime.push(averageRepairTimeInfo[i].ResponseTime);
            }
        }
        var optionReapirAvg = {
            title:
            {
                text: "设备维修平均响应时间月趋势图",
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 2,
                left: "50%"
            },
            grid: {
                left: 45,
                top: '20%',
                bottom: '13%',
                right: '5%',
            },
            tooltip: {
                trigger: 'axis',
                formatter: '{a} <br/>{b} : {c}min',
                axisPointer: {
                    type: 'line',
                    lineStyle: {
                        color: "#0c3f4c"
                    }
                },
            },
            xAxis: {
                type: 'category',
                boundaryGap: true,
                data: xAxisReapirAvg,//['12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07'],
                axisLabel: {
                    textStyle: {
                        color: '#378DBD',//坐标值得具体的颜色
                        fontSize: 12,
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#378DBD',
                        interval: 0,//横轴信息全部显示
                        rotate: 0,//度角倾斜显示    
                    }
                },
            },
            yAxis: {
                type: 'value',
                name: 'min',
                nameLocation: 'end',
                nameTextStyle: {
                    align: 'right',
                    verticalAlign: 'middle',
                },
                axisLabel: {
                    textStyle: {
                        color: '#378DBD',//坐标值得具体的颜色
                        fontSize: 12,
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#378DBD',
                        interval: 0,//横轴信息全部显示
                        rotate: 0,//度角倾斜显示    
                    }
                },
                splitLine: {
                    lineStyle: {
                        color: '#0c3f4c',
                    }
                },
            },
            series: [
                {
                    name: "设备维修平均响应时间",
                    data: averageRepairTime,//[120, 200, 79, 90, 100, 90, 312],
                    type: 'line',
                    smooth: 0.6, //使折线图平滑
                    //symbol: 'none',//不显示折线图中的“点点”
                    itemStyle: {
                        color: '#4762bd',//'#2f489b'
                    },
                    areaStyle: {
                        color: "#1c2a60",
                        //color: {
                        //    type: 'linear',
                        //    x: 0,
                        //    y: 0,
                        //    x2: 0,
                        //    y2: 1,
                        //    colorStops: [{
                        //        offset: 0, color: '#5bd5de' // 0% 处的颜色
                        //    }, {
                        //        offset: 1, color: '#06666c' // 100% 处的颜色
                        //    }],
                        //}
                    },
                    label: {
                        show: true,
                        formatter: '{c}',
                        color: "#8498f0"
                    }
                }
            ]
        };
        chartReapirAvg.setOption(optionReapirAvg, true);


        //设备重复维修月趋势图	
        var xAxisOnePass = [];
        //var rejectionQtyData = [];//拒收单数
        //var repairOKRate = [];//每月维修合格率
        var repairQty = [];
        var onePassInfo = kanbanData.data4;
        if (onePassInfo) {
            for (var i = 0; i < onePassInfo.length; i++) {
                xAxisOnePass.push(onePassInfo[i].Mon);
                //repairOKRate.push(onePassInfo[i].RepairOKRate);
                //rejectionQtyData.push(onePassInfo[i].RejectionQty);
                repairQty.push(onePassInfo[i].Qty);
            }
        }
        var optionOnePass = {
            title:
            {
                text: "设备重复维修月趋势图",
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 2,
                left: "50%"
            },
            grid: {
                left: '10%',
                top: '20%',
                bottom: '13%',
                right: '10%',
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'line'
                }
            },
            xAxis: {
                type: 'category',
                data: xAxisOnePass,//['12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07'],
                axisLabel: {
                    textStyle: {
                        color: '#378DBD',//坐标值得具体的颜色
                        fontSize: 12,
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#378DBD',
                        interval: 0,//横轴信息全部显示
                        rotate: 0,//度角倾斜显示    
                    }
                },
            },
            yAxis:
                [
                    {
                        //name: "每月维修合格率",
                        //nameLocation: 'end',
                        //nameTextStyle: {
                        //    align: 'center',
                        //    verticalAlign: 'middle',
                        //},
                        type: 'value',
                        //max: 120,
                        axisLabel: {
                            textStyle: {
                                color: '#378DBD',//坐标值得具体的颜色
                                fontSize: 12,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#378DBD',
                                interval: 0,//横轴信息全部显示
                                rotate: 0,//度角倾斜显示    
                            }
                        },
                        splitLine: {
                            lineStyle: {
                                color: '#45576F',
                            }
                        },
                    },
                    {
                        //name: "拒收单数",
                        //nameLocation: 'end',
                        //nameTextStyle: {
                        //    align: 'center',
                        //    verticalAlign: 'middle',
                        //},
                        type: 'value',
                        axisLabel: {
                            textStyle: {
                                color: '#378DBD',//坐标值得具体的颜色
                                fontSize: 12,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#378DBD',
                                interval: 0,//横轴信息全部显示
                                rotate: 0,//度角倾斜显示    
                            }
                        },
                        splitLine: {
                            show: false,
                            //lineStyle: {
                            //    color: '#45576F',
                            //}
                        },
                    }
                ],
            series: [
                //{
                //    name: '拒收单数',
                //    data: rejectionQtyData,//[80, 70, 60, 50, 90, 100, 85],
                //    type: 'bar',
                //    barWidth: 20,
                //    barMaxWidth: 40,
                //    yAxisIndex: 1,
                //    label: {
                //        show: true,
                //        formatter: "{c}",
                //    },
                //},
                //{
                //    name: '每月维修合格率',
                //    type: 'line',
                //    data: repairOKRate,//[50, 90, 70, 60, 100, 70, 80],
                //    smooth: 0.6, //使折线图平滑
                //    //symbol: 'none',//不显示折线图中的“点点”
                //    itemStyle: {
                //        color: '#ffce39'
                //    },
                //    label: {
                //        show: true,
                //        formatter: "{c}%",
                //    },
                //}
                {
                    name: '重复维修次数',
                    type: 'line',
                    data: repairQty,//repairOKRate,//[50, 90, 70, 60, 100, 70, 80],
                    smooth: 0.6, //使折线图平滑
                    //symbol: 'none',//不显示折线图中的“点点”
                    itemStyle: {
                        color: '#ffce39'
                    },
                    label: {
                        show: true,
                        formatter: "{c}",
                    },
                }
            ],
            color: ["#16bcda"]
        };
        chartOnePass.setOption(optionOnePass, true);


        //当日维修完成率（按人员）
        var xAxisUserComplete = [];
        var totalQtyData = [];//当天派单维修单数        
        var userCompleteRate = [];//维修完成率
        dayRepairCompleteQtyData = [];//已维修完成的单数
        var dayRepaitInCompleteRate = [];//当日维修完成率（按人员） — 未完成率
        dayRepaitInCompleteQty = [];//当日维修完成率（按人员） — 未完成数        
        var userCompleteInfo = kanbanData.data5;
        if (userCompleteInfo) {
            for (var i = 0; i < userCompleteInfo.length; i++) {
                xAxisUserComplete.push(userCompleteInfo[i].CName);
                userCompleteRate.push(userCompleteInfo[i].CompleteRate);
                totalQtyData.push(userCompleteInfo[i].TotalQty);
                dayRepairCompleteQtyData.push(userCompleteInfo[i].CompleteQty);
                dayRepaitInCompleteRate.push(userCompleteInfo[i].InCompleteRate);
                dayRepaitInCompleteQty.push(userCompleteInfo[i].InCompleteQty);
            }
        }
        var optionUserComplete = {
            title:
            {
                text: "当日维修完成率(按人员)",
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 2,
                left: "50%"
            },
            grid: {
                left: '10%',
                top: '20%',
                bottom: '13%',
                right: '10%',
            },
            //tooltip: {
            //    trigger: 'axis',
            //    axisPointer: {
            //        type: 'line'
            //    }
            //},
            tooltip: {
                trigger: 'axis',
                formatter: function (params) {
                    var result = '';
                    var dataIndex = -1;
                    params.forEach(function (item) {
                        if (item.seriesName == "维修完成率") {
                            result += item.marker + " " + item.seriesName + " : " + item.value + "%</br>";
                        } else {
                            result += item.marker + " " + item.seriesName + " : " + dayRepaitInCompleteQty[item.dataIndex] + "</br>";
                        }
                        dataIndex = item.dataIndex;
                    });
                    if (dayRepairCompleteQtyData) {
                        result += "维修完成数" + " : " + dayRepairCompleteQtyData[dataIndex];
                    }
                    return result;
                },
                axisPointer: {
                    type: 'line'
                }
            },
            xAxis: {
                type: 'category',
                data: xAxisUserComplete,//['12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07'],
                axisLabel: {
                    textStyle: {
                        color: '#378DBD',//坐标值得具体的颜色
                        fontSize: 12,
                    },
                    interval: 0
                },
                axisLine: {
                    lineStyle: {
                        color: '#378DBD',
                        interval: 0,//横轴信息全部显示
                        rotate: 0,//度角倾斜显示    
                    }
                },

            },
            yAxis:
                [
                    {
                        name: "完成率",
                        nameLocation: 'end',
                        nameTextStyle: {
                            align: 'center',
                            verticalAlign: 'middle',
                        },
                        type: 'value',
                        max: 120,
                        axisLabel: {
                            textStyle: {
                                color: '#378DBD',//坐标值得具体的颜色
                                fontSize: 12,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#378DBD',
                                interval: 0,//横轴信息全部显示
                                rotate: 0,//度角倾斜显示    
                            }
                        },
                        splitLine: {
                            lineStyle: {
                                color: '#45576F',
                            }
                        },
                    },
                    //{
                    //    //name: "完成率",
                    //    //nameLocation: 'end',
                    //    //nameTextStyle: {
                    //    //    align: 'center',
                    //    //    verticalAlign: 'middle',
                    //    //},
                    //    type: 'value',
                    //    axisLabel: {
                    //        textStyle: {
                    //            color: '#378DBD',//坐标值得具体的颜色
                    //            fontSize: 12,
                    //        }
                    //    },
                    //    axisLine: {
                    //        lineStyle: {
                    //            color: '#378DBD',
                    //            interval: 0,//横轴信息全部显示
                    //            rotate: 0,//度角倾斜显示    
                    //        }
                    //    },
                    //    splitLine: {
                    //        show: false,
                    //        //lineStyle: {
                    //        //    color: '#45576F',
                    //        //}
                    //    },
                    //}
                ],
            series: [
                {
                    name: '维修完成率',
                    stack: '维修完成率及未完成数量',
                    data: userCompleteRate,//[80, 70, 60, 50, 90, 100, 85],
                    type: 'bar',
                    barWidth: 20,
                    barMaxWidth: 40,
                    //yAxisIndex: 1,
                    label: {
                        show: true,
                        formatter: '{c}%',
                        color: '#ffffff',
                        //formatter: function (v) {
                        //    //debugger;
                        //    //var val = v.data;
                        //    //return percentData.get(val);
                        //    return dayCompleteRate[v.dataIndex];
                        //},
                    },
                },
                {
                    name: '维修未完成数',
                    stack: '维修完成率及未完成数量',
                    data: dayRepaitInCompleteRate,//[80, 70, 60, 50, 90, 100, 85],
                    type: 'bar',
                    barWidth: 20,
                    barMaxWidth: 40,
                    //yAxisIndex: 1,
                    label: {
                        show: true,
                        //formatter: '{c}',
                        formatter: function (v) {
                            return dayRepaitInCompleteQty[v.dataIndex];
                        },
                        color: '#ff4400',
                    },
                },

                //{
                //    name: '维修完成数',
                //    stack: '已维修数及当日派单数',
                //    data: dayRepairCompleteQtyData,//[80, 70, 60, 50, 90, 100, 85],
                //    type: 'bar',
                //    barWidth: 20,
                //    barMaxWidth: 40,
                //    yAxisIndex: 1,
                //    label: {
                //        show: true,
                //        formatter: '{c}',
                //        //formatter: function (v) {
                //        //    //debugger;
                //        //    //var val = v.data;
                //        //    //return percentData.get(val);
                //        //    return dayCompleteRate[v.dataIndex];
                //        //},
                //    },
                //    //showBackground: true,
                //    //backgroundStyle: {
                //    //    color: ["#fff"]
                //    //},
                //},
                //{
                //    name: '已派维修单数',
                //    stack: '已维修数及当日派单数',
                //    data: totalQtyData,//[80, 70, 60, 50, 90, 100, 85],
                //    type: 'bar',
                //    barWidth: 20,
                //    barMaxWidth: 40,
                //    yAxisIndex: 1,
                //    label: {
                //        show: true,
                //        formatter: '{c}',
                //        color: '#ff4400',
                //    },
                //    //showBackground: true,
                //    //backgroundStyle: {
                //    //    color: ["#fff"]
                //    //},
                //},
                //{
                //    name: '当日维修完成率（按人员）',
                //    type: 'line',
                //    data: userCompleteRate,//[50, 90, 70, 60, 100, 70, 80],
                //    smooth: 0.6, //使折线图平滑
                //    //symbol: 'none',//不显示折线图中的“点点”
                //    itemStyle: {
                //        color: '#ffce39'
                //    },
                //    label: {
                //        show: true,
                //        formatter: "{c}%",
                //    },
                //}
            ],
            color: ["#00b0f0", "#fff"]
        };
        chartUserComplete.setOption(optionUserComplete, true);

    }

</script>
