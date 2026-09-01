<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkshopQualityKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.WorkshopQualityKanban" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/v4.9/echarts.min.js" type="text/javascript"></script>
    <title></title>

    <style type="text/css">
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 14px; overflow: hidden; }
        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; }
        .logo_cus { background: url('../../Content/images/logo/skt-logo.png') no-repeat 20px center; background-size: 90%; }
        .logo_skt { background: url('../../Content/images/logo/skt-logo.png') no-repeat center center; background-size: 90%; }
        .table { display: table; height: 100%; width: 100%; position: relative; }
        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }
        th { height: 35px; line-height: 35px; text-align: center; font-size: 21px; color: #fff; }
        tr { height: 22px; line-height: 28px; text-align: center; font-size: 21px; color: #fff; }
        .chart-tit { font-size: 20px; color: #fff; font-weight: bold; text-align: center; text-shadow: 3px 2px 8px #5a5af7; }
        #div1 { display: black; width: 110px; height: 50px; line-height: 50px; white-space: nowrap; overflow: hidden; background-color: #a2a2a2; margin: 15px; padding: 5px 15px; }
        span { display: inline-block; color: #fff; }

        #dataList tr { color: #38FFFF; }

        td.info-left { color: #38ffff; width: 70%; }
        td.info-right { text-align: left; }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 10%;" class="kanban-head">
                <li style="height: 100%;">
                    <span class="logo_cus cell" style="width: 270px; display: block; float: left;"></span>
                    <div class="table kanban-name" style="float: left;">
                        <span class="cell" style="font-size: 42px; color: #fff; font-weight: bold;">车间品质看板</span>
                    </div>
                    <div class="table date-skt-logo" style="float: right; width: 270px;">
                        <span class="cell" style="font-size: 19px; color: #fff; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>
            <ul style="height: 90%; border-bottom: 5px solid #0c0c0c; border-top: 5px solid #0c0c0c;">
                <li style="height: 100%;">
                    <%--上--%>
                    <div class="chart-middle" style="height: 49%; width: 100%; border-bottom: 5px solid #0c0c0c;">
                        <%--首检不良类型--%>
                        <div style="width: 33%; height: 100%; float: left;">
                            <div id="chart-first" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                        <%--机型首检次数--%>
                        <div style="width: 33%; height: 100%; float: left; border-right: 5px solid #0c0c0c; border-left: 5px solid #0c0c0c;">
                            <div id="chart-first-item" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                        <%--首检直通率--%>
                        <div style="width: 32.5%; height: 100%; float: left;">
                            <div id="chart-first-fpy" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <%--下--%>
                    <div class="chart-middle" style="height: 49%; width: 100%;">
                        <%--巡检不良类型--%>
                        <div style="width: 33%; height: 100%; float: left;">
                            <div id="chart-ipqc" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                        <%--机型巡检次数--%>
                        <div style="width: 33%; height: 100%; float: left; border-right: 5px solid #0c0c0c; border-left: 5px solid #0c0c0c;">
                            <div id="chart-ipqc-item" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                        <%--末检直通率--%>
                        <div style="width: 32.5%; height: 100%; float: left;">
                            <div id="chart-ipqc-fpy" style="width: 100%; height: 100%;">
                            </div>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                </li>
            </ul>
            <%-- <ul style="height: 10%;">
                <li style="height: 100%;">
                    <div class="table">
                        <table style="width: 100%; height: 100%;" cellpadding="5" cellspacing="5" border="0">
                            <tr>
                                <td id="_left_top_welcome">
                                    <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                        scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                        <div id="_left_top_welcome_text" style="padding-top: 5px; padding-bottom: 5px; font-size: 30px; color: red; font-weight: bold;">
                                            热烈欢迎各位领导莅临参观指导
                                        </div>
                                    </marquee>
                                </td>
                            </tr>
                        </table>
                    </div>
                </li>
            </ul>--%>
        </div>
    </form>
</body>
</html>

<script>
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

        getBasalInfo();

        setInterval(function () {
            getBasalInfo();

            //获取服务器时间
            getServerTime(0);
        }, 1000 * 60 * 5);
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
            data: { "api": "GetServerTime", "fmt": "0" },
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


        ResizeChart();
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

    var chartFirst = echarts.init(document.getElementById('chart-first'));//首检不良类型			
    var chartIPQC = echarts.init(document.getElementById('chart-ipqc'));//巡检不良类型

    var chartFirstItem = echarts.init(document.getElementById('chart-first-item'));//机型首检次数			
    var chartIPQCItem = echarts.init(document.getElementById('chart-ipqc-item'));//机型巡检次数

    var chartFirstFPY = echarts.init(document.getElementById('chart-first-fpy'));//首检直通率			
    var chartIPQCFPY = echarts.init(document.getElementById('chart-ipqc-fpy'));//末检直通率	

    var colorList = ["#229eb1", "#0ebe94", "#9b9f07", "#187e4d", "#1f84ec"];
    var colorList2 = ["#2bbed5", "#12dfae", "#b5ba09", "#1fa062", "#228dfb"];
    var colorList3 = ["#63eaff", "#41fdd0", "#e5ea3c", "#5ae09f", "#83c0ff"];

    var dayCompleteRate = [];//检验完成率

    function ResizeChart() {
        if (chartFirst != null) { chartFirst.resize(); }
        if (chartIPQC != null) { chartIPQC.resize(); }

        if (chartFirstItem != null) { chartFirstItem.resize(); }
        if (chartIPQCItem != null) { chartIPQCItem.resize(); }

        if (chartFirstFPY != null) { chartFirstFPY.resize(); }
        if (chartIPQCFPY != null) { chartIPQCFPY.resize(); }
    }

    //扇形图
    function getBottomOption(title, type, chartData) {
        var option = {
            title:
            {
                text: title,
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 10,
                left: "50%"
            },
            //grid: {
            //    left: '5%',
            //    top: '20%',
            //    bottom: '10%',
            //},
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            series: [
                {
                    name: type,
                    type: 'pie',
                    //radius: '70%',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: chartData,
                    label: {
                        //position: 'inside',
                        fontSize: 12,
                        //formatter: (type == "供应商" ? '{b}\n{d}%' : '{b}: {d}%'),
                        formatter: '{b}\n{d}%',
                    },
                    labelLine: {
                        normal: {
                            length: 10   //饼图连接线长度
                        }
                    },
                }
            ],
            color: ["#229eb1", "#0ebe94", "#9b9f07", "#187e4d", "#1f84ec", "#63eaff", "#41fdd0", "#e5ea3c"]
        };

        return option;
    }

    //获取基础信息
    function getBasalInfo() {
        //获取检验基本信息
        var ajax = SKT.AjaxCommon.DBService.SearchList("uspGetWorkshopQualityKanban", JSON.stringify({}));
        if (ajax.error != null) {
            //console.log(ajax.error.Message);
            return false;
        }
        var kanbanData = JSON.parse(ajax.value);

        //首检不良类型		
        var firstNcData = [];
        var firstNcList = kanbanData.data;
        if (firstNcList) {
            for (var i = 0; i < firstNcList.length; i++) {
                firstNcData.push({ value: firstNcList[i].Qty, name: firstNcList[i].NcCode });
            }
        }

        var optionFirstNC = getBottomOption("首检不良类型", "首检", firstNcData);
        chartFirst.setOption(optionFirstNC, true);

        //巡检不良类型		
        var ipqcNcData = [];
        var ipqcNcList = kanbanData.data3;
        if (ipqcNcList) {
            for (var i = 0; i < ipqcNcList.length; i++) {
                ipqcNcData.push({ value: ipqcNcList[i].Qty, name: ipqcNcList[i].NcCode });
            }
        }
        var optionNcIPQC = getBottomOption("巡检不良类型", "巡检", ipqcNcData);
        chartIPQC.setOption(optionNcIPQC, true);


        //机型首检次数
        var optionFirstItem = getInspectionItemQty(kanbanData.data1, "机型首检次数");
        chartFirstItem.setOption(optionFirstItem, true);

        //机型巡检次数
        var optionIPQCItem = getInspectionItemQty(kanbanData.data4, "机型巡检次数");
        chartIPQCItem.setOption(optionIPQCItem, true);

        //首检直通率
        var optionFirstFPY = getInspectionFPY(kanbanData.data2, "首检直通率");
        chartFirstFPY.setOption(optionFirstFPY, true);

        //末检直通率
        var optionIPQCFPY = getInspectionFPY(kanbanData.data5, "末检直通率");
        chartIPQCFPY.setOption(optionIPQCFPY, true);


    }


    //机型首检次数、机型巡检次数
    function getInspectionItemQty(list, title) {
        var xAxisItemName = [];
        var qtyData = [];//故障类型
        //var anormalTypeNameRate = [];//故障类型占当月所有故障类型的百分比
        if (list) {
            for (var i = 0; i < list.length; i++) {
                xAxisItemName.push(list[i].ItemName);
                qtyData.push(list[i].Qty);
            }
        }
        var optionQty = {
            title:
            {
                text: title,
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 10,
                left: "50%"
            },
            grid: {
                left: '10%',
                top: '10%',
                //bottom: '13%',
                bottom: '25%',
                right: '5%',
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'line'
                }
            },
            xAxis: {
                type: 'category',
                data: xAxisItemName,//['12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07'],
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
                        name: '次数',

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
                            lineStyle: {
                                color: '#45576F',
                            }
                        },
                    }
                ],
            series: [
                {
                    data: qtyData,//[80, 70, 60, 50, 90, 100, 85],
                    type: 'bar',
                    barWidth: 20,
                    barMaxWidth: 40,
                    //yAxisIndex: 1,
                    label: {
                        show: true,
                        formatter: function (v) {
                            return qtyData[v.dataIndex];
                        },
                    },
                },
            ],
            color: ["#16bcda"]
        };
        return optionQty;
    }

    //首检直通率、末检直通率
    function getInspectionFPY(list, title) {
        var xAxisDate = [];
        var ngData = [];//不良数
        var okData = [];//总数量
        var FPYRate = [];//直通率
        if (list) {
            for (var i = 0; i < list.length; i++) {
                xAxisDate.push(list[i].InspectionDate);
                FPYRate.push(list[i].FPY);
                ngData.push(list[i].NGQty);
                okData.push(list[i].OKQty);
            }
        }
        var optionFPY = {
            title:
            {
                text: title,
                textAlign: "center",
                textStyle:
                {
                    color: "#fff"
                },
                top: 10,
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
                data: xAxisDate,//['12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07'],
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
                        name: "直通率",
                        nameLocation: 'end',
                        nameTextStyle: {
                            align: 'center',
                            verticalAlign: 'middle',
                        },
                        type: 'value',
                        max: 100,
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
                    name: '合格数',
                    stack: '直通率及数量',
                    data: okData,//[80, 70, 60, 50, 90, 100, 85],
                    type: 'bar',
                    barWidth: 20,
                    barMaxWidth: 40,
                    yAxisIndex: 1,
                    label: {
                        show: true,
                        ////formatter: '{c}',
                        //formatter: function (v) {
                        //    //debugger;
                        //    //var val = v.data;
                        //    //return percentData.get(val);
                        //    return dayCompleteRate[v.dataIndex];
                        //},
                    },
                    //showBackground: true,
                    //backgroundStyle: {
                    //    color: ["#fff"]
                    //},
                },
                {
                    name: '不合格数',
                    stack: '直通率及数量',
                    data: ngData,//[80, 70, 60, 50, 90, 100, 85],
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
                    name: '直通率',
                    type: 'line',
                    max: 120,
                    data: FPYRate,//[50, 90, 70, 60, 100, 70, 80],
                    smooth: 0.6, //使折线图平滑
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
            color: ["#00b0f0", "#fff"]
        };
        return optionFPY;
    }

</script>
