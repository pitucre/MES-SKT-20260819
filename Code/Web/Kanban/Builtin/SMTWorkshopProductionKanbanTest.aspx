<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTWorkshopProductionKanbanTest.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.SMTWorkshopProductionKanbanTest" %>


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
            font-size: 12px;
            overflow: hidden;
        }

       html {
            overflow-y: auto;
        }

        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat 15px center;
            background-size: 95%;
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
           /*border-collapse: collapse;*/
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

        .content_padding div {
            margin: 5%;
            color: rgb(42,203,251);
            white-space: nowrap;
        }

       /* .xiaofang img {
            margin: 0 15%;
        }*/

       /* .xiaofang {
            margin-top: 20px;
        }*/

        .algin_margin div {
           /*margin: 0 5%;*/
            white-space: nowrap;
        }

        .logo_skt {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center center;
            background-size: 50%;
            background-color: #0D213A;
        }

        .msg p {
            background-image: linear-gradient(rgb(17,173,255),rgb(26,205,255),rgb(37,237,255));
            -webkit-background-clip: text;
            color: transparent;
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



            if (echart1 != null) { echart1.resize(); }
            if (echart2 != null) { echart2.resize(); }
            if (echart3 != null) { echart3.resize(); }

            if (echart4 != null) { echart4.resize(); }
            if (echart5 != null) { echart5.resize(); }
            if (echart6 != null) { echart6.resize(); }
            if (echart7 != null) { echart6.resize(); }
        });

        function ResizeAll() {
            //某些浏览器不兼容div自适应高度
            $(".gauge").height(150);

           /* var _contentHeight = $(window).height() * 0.9 * 0.3;

            $("#_layout_left_data_div_tbody").css("height", "auto");

            $(".rows").height(_contentHeight * 0.16)

            if ($(".rows").length * _contentHeight * 0.16 > _contentHeight) {
                $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);
                _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 150, 1000 * 6);
                isScroll = true;
            }*/
        }


    </script>
    <script type="text/javascript">
        /*echarts*/
        option1 = {
            series: [
            {
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '100%',
                min: 0,
                max: 100,
                axisTick: false,//是否显示刻度
                splitNumber: 4,
                splitLine: {
                    length: 20
                  
                },
                axisLine: {            // 坐标轴线 

                    lineStyle: {       // 属性lineStyle控制线条样式  
                        color: [[0.2, 'rgb(2,106,255)'], [0.8, 'rgb(65,25,212)'], [1, 'rgb(94,199,255)']],
                        width: 20,
                        shadowColor: '#fff', //默认透明
                        shadowBlur: 2
                    }
                },
                axisLabel: {
                    show: true,
                    formatter: function (value) {
                        return parseInt(value) + "%";
                    }
                },
                detail: {
                    formatter: "抛料率{value}‰",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#fff',
                        fontSize: 12
                    }
                },
                data: [{ value: 0 }]
            }],
            tooltip: {

                position: ['5%', '50%']
            }
        };

        option2 = {
            series: [
            {
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '100%',
                min: 0,
                max: 100,
                axisTick: false,//是否显示刻度
                splitNumber: 4,
                splitLine: {
                    length: 20

                },
                axisLine: {            // 坐标轴线  
                    lineStyle: {       // 属性lineStyle控制线条样式  
                        color: [[0.2, 'rgb(2,106,255)'], [0.8, 'rgb(65,25,212)'], [1, 'rgb(94,199,255)']],
                        width: 20,
                        shadowColor: '#fff', //默认透明
                        shadowBlur: 2
                    }
                },
                axisLabel: {
                    show: true,
                    formatter: function (value) {
                        return parseInt(value) + "%";
                    }
                },
                detail: {
                    formatter: "设备综合效率{value}%",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#fff',
                        fontSize: 12
                    }
                },
                data: [{ value: 0 }]
            }],
            tooltip: {

                position: ['5%', '50%']
            }
        };


        option3 = {
            series: [
            {
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '100%',
                min: 0,
                max: 100,
                axisTick: false,//是否显示刻度
                splitNumber: 4,
                splitLine: {
                    length: 20

                },
                axisLine: {            // 坐标轴线  
                    lineStyle: {       // 属性lineStyle控制线条样式  
                        color: [[0.2, 'rgb(2,106,255)'], [0.8, 'rgb(65,25,212)'], [1, 'rgb(94,199,255)']],
                        width: 20,
                        shadowColor: '#fff', //默认透明
                        shadowBlur: 2
                    }
                },
                axisLabel: {
                    show: true,
                    formatter: function (value) {
                        return parseInt(value) + "%";
                    }
                },
                detail: {
                    formatter: "生产达成率{value}%",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#fff',
                        fontSize: 12
                    }
                },
                data: [{ value: 0 }]
            }],
            tooltip: {

                position: ['5%', '50%']
            }
        };



        option4 = {
            title: {
                text: '防抖数据',
                textStyle: {
                    color: '#fff'
                }

            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {

                type: 'value',
                boundaryGap: [0, 0.01],
                splitLine: { show: true },
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: function (value) {
                        return "";
                    }
                },

                axisTick: {
                    show: false
                }

            },
            yAxis: {
                type: 'category',
                data: ['3-2', '3-26', '3-12', '2-10', '5-6', '2-17'],
                splitLine: { show: true },
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                }
            },
            series: [
                {
                    showBackground: true,
                    type: 'bar',
                    itemStyle: {
                        color: new echarts.graphic.LinearGradient(
                            0, 0, 0, 1,
                            [
                                { offset: 0, color: '#83bff6' },
                                { offset: 0.5, color: '#188df0' },
                                { offset: 1, color: '#188df0' }
                            ]
                        )
                    },
                    emphasis: {
                        itemStyle: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    { offset: 0, color: '#2378f7' },
                                    { offset: 0.7, color: '#2378f7' },
                                    { offset: 1, color: '#83bff6' }
                                ]
                            )
                        }
                    },
                    data: [18203, 23489, 29034, 104970, 131744, 630230]
                }

            ]
        };


        option5 = {
            title: {
                text: '设备稼动率',
                textStyle: {
                    color: '#fff'
                }

            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {

                type: 'category',
                boundaryGap: [0, 0.01],

                splitLine: {
                    show: true,
                    color: ['#fff', '#fff']
                },
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },

                data: ['', '', '', '', '', '', '', '']

            },
            yAxis: {
                type: 'value',
                splitLine: {
                    show: true,
                    color: ['#fff', '#fff']
                },
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                }
            },
            series: [
                {
                    showBackground: true,
                    backgroundStyle: {
                        color: 'rgba(228, 57, 97, 0.5)'
                    },
                    type: 'bar',
                    barWidth: 20,
                    barGap: '10%',
                    itemStyle: {
                        color: new echarts.graphic.LinearGradient(
                            0, 0, 0, 1,
                            [
                                { offset: 0, color: '#83bff6' },
                                { offset: 0.5, color: '#188df0' },
                                { offset: 1, color: '#188df0' }
                            ]
                        ),

                    },
                    emphasis: {
                        itemStyle: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    { offset: 0, color: '#2378f7' },
                                    { offset: 0.7, color: '#2378f7' },
                                    { offset: 1, color: '#83bff6' }
                                ]
                            )
                        }
                    },
                    label: {
                        normal: {
                            show: true,
                            //  formatter: '{c}%',
                            position: "top",
                            textStyle: {
                                color: "#fff",
                                fontSize: 14
                            }
                        }
                    },
                    data: [0, 0, 0, 20, 35, 85]
                }

            ]
        };

        option6 = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            /* title: {
                 text: 'UPH产能',
                 textStyle: {
                     color: '#fff'
                 }
 
             },*/
            legend: {
                data: ['控制面板低配组件', 'D-AD主板半成品', 'S-AD主板SMT产品', '达成率'],
                textStyle: {
                    color: '#fff'
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
                    boundaryGap: [0, 0.01],

                    splitLine: {
                        show: false,
                        color: ['#fff', '#fff']
                    },
                    axisLabel: {
                        textStyle: {
                            color: '#fff'
                        }
                    },
                    data: ['08时', '09时', '10时', '11时', '12时', '13时', '014时', '015时', '016时']
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    splitLine: {

                        color: ['#fff', '#fff']
                    },
                    nameTextStyle: {

                        color: '#fff'

                    },
                    axisLine: {
                        show: true

                    },
                    name: 'UPH产能',

                    interval: 20,
                    axisLabel: {
                        formatter: '{value}',
                        textStyle: {
                            color: '#fff'
                        }
                    }
                },
                 {
                     type: 'value',


                     axisLine: {
                         show: true

                     },
                     nameTextStyle: {

                         color: '#fff'

                     },
                     name: '达成率',

                     interval: 20,
                     axisLabel: {
                         formatter: '{value}%',
                         textStyle: {
                             color: '#fff'
                         }
                     }


                 }
            ],
            series: [
                {
                    name: '控制面板低配组件',

                    type: 'bar',
                    barWidth: 10,
                    itemStyle: {
                        color: new echarts.graphic.LinearGradient(
                            0, 0, 0, 1,
                            [
                                { offset: 0, color: '#83bff6' },
                                { offset: 0.5, color: '#188df0' },
                                { offset: 1, color: '#188df0' }
                            ]
                        )



                    },
                    label: {
                        normal: {
                            show: true,
                            //  formatter: '{c}%',
                            position: "inside",
                            textStyle: {
                                color: "#fff",
                                fontSize: 12
                            }
                        }
                    },

                    data: [94, 105, 89, 100, 96, 105, 100, 89, 98]
                },
                {
                    name: 'D-AD主板半成品',
                    type: 'bar',
                    barWidth: 10,
                    itemStyle: {
                        color: new echarts.graphic.LinearGradient(
                            0, 0, 0, 1,
                            [
                                { offset: 0, color: 'rgba(135,123,255)' },
                                { offset: 0.5, color: 'rgba(153,131,255)' },
                                { offset: 1, color: 'rgba(182,157,255)' }
                            ]
                        ),

                    },

                    label: {
                        normal: {
                            show: true,
                            //  formatter: '{c}%',
                            position: "inside",
                            textStyle: {
                                color: "#fff",
                                fontSize: 12
                            }
                        }
                    },
                    data: [94, 105, 89, 100, 96, 105, 100, 89, 98]
                },
                {
                    name: 'S-AD主板SMT产品',
                    type: 'bar',
                    barWidth: 10,
                    itemStyle: {
                        color: new echarts.graphic.LinearGradient(
                           0, 0, 0, 1,
                           [
                               { offset: 0, color: 'rgba(213,234,109)' },
                               { offset: 0.5, color: 'rgba(213,234,109)' },
                               { offset: 1, color: 'rgba(213,234,109)' }
                           ]
                       )
                    },

                    label: {
                        normal: {
                            show: true,
                            //  formatter: '{c}%',
                            position: "inside",
                            textStyle: {
                                color: "#fff",
                                fontSize: 12
                            }
                        }
                    },
                    data: [94, 105, 89, 100, 96, 105, 100, 89, 98]
                },
                  {
                      name: '达成率',
                      type: 'line',

                      yAxisIndex: 1,
                      itemStyle: {
                          color: 'rgba(89,252,255)'
                      },

                      label: {
                          normal: {
                              show: true,
                              formatter: '{c}%',
                              position: "inside",
                              textStyle: {
                                  color: "#fff",
                                  fontSize: 12
                              }
                          }
                      },
                      data: [94, 105, 89, 100, 96, 105, 100, 89, 98]
                  }
            ]
        };


        option7 = {

            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            /*grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },*/
            xAxis: {

                type: 'category',
                boundaryGap: [0, 0.01],

                /* splitLine: {
                     show: true,
                     color: ['#fff', '#fff']
                 },*/
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },

                data: ['反向', '侧立', '反件', '假焊', '错键']

            },
            yAxis: {
                type: 'value',
                splitLine: {
                    show: true,
                    color: ['#fff', '#fff']
                },
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                }
            },
            series: [
                {
                    showBackground: true,
                    backgroundStyle: {
                        color: 'rgba(228, 57, 97, 0.5)'
                    },
                    type: 'bar',
                    barWidth: 40,
                    barGap: '10%',
                    itemStyle: {
                        color: new echarts.graphic.LinearGradient(
                            0, 0, 0, 1,
                            [
                                { offset: 0, color: '#83bff6' },
                                { offset: 0.5, color: '#188df0' },
                                { offset: 1, color: '#188df0' }
                            ]
                        ),

                    },
                    emphasis: {
                        itemStyle: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    { offset: 0, color: '#2378f7' },
                                    { offset: 0.7, color: '#2378f7' },
                                    { offset: 1, color: '#83bff6' }
                                ]
                            )
                        }
                    },
                    label: {
                        normal: {
                            show: true,
                            //  formatter: '{c}%',
                            position: "top",
                            textStyle: {
                                color: "#fff",
                                fontSize: 14
                            }
                        }
                    },
                    data: [10, 5, 3, 2, 1]
                }

            ]
        };

        function getGaugeMaxVal(value) {
            value = parseFloat(value);
            var maxValue = 100;
            if (value > maxValue) {
                var temp = parseInt(value);
                if (temp > value) {
                    return temp;
                }
                maxValue = value + 1;
            }
            return maxValue;
        }
        function initEcharts() {

            var value1 = 5;
            var value2 = 64;
            var value3 = 98.72;
            option1.series[0].max = getGaugeMaxVal(value1);
            option1.series[0].data[0].value = value1;
            echart1.setOption(option1, true);

            option2.series[0].max = getGaugeMaxVal(value2);
            option2.series[0].data[0].value = value2;
            echart2.setOption(option2, true);


            option3.series[0].max = getGaugeMaxVal(value3);
            option3.series[0].data[0].value = value3;
            echart3.setOption(option3, true);

            echart4.setOption(option4, true);
            echart5.setOption(option5, true);
            echart6.setOption(option6, true);
            echart7.setOption(option7, true);

        }
    </script>
    <script type="text/javascript">
        var welcomeMsg;
        $(document).ready(function () {

            ResizeAll();

            //var line_height = $("#dateAndWeek").parent().height() + "px";
           // $("#dateAndWeek").css("line-height", line_height);
            welcomeMsg = getQueryString("welcomeMsg");
            $(".msg p").text(welcomeMsg);
            getWelcome();

            /*注册ECHARTS*/
            echart1 = echarts.init(document.getElementById('echarts_gauge1'));
            echart2 = echarts.init(document.getElementById('echarts_gauge2'));
            echart3 = echarts.init(document.getElementById('echarts_gauge3'));
            echart4 = echarts.init(document.getElementById('echarts_gauge4'));
            echart5 = echarts.init(document.getElementById('echarts_gauge5'));
            echart6 = echarts.init(document.getElementById('echarts_gauge6'));
            echart7 = echarts.init(document.getElementById('echarts_gauge7'));


            initEcharts();
        });

        function getWelcome() {

            $("#dateAndWeek").text($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value));

            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 1);
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
    <div>
        <form id="form1" runat="server">
            <table id="_layout" style="">
                <tr style="height: 100%;">
                    <td style="height: 100%;">
                        <table id="_layout_left_table">
                            <tr style="height: 10%;">
                                <td style="height: 10%; vertical-align: top;">
                                    <table style="background-color: #0D213A;">
                                        <tr>
                                            <td style="width: 25%; height: 100px;padding-left:10px;padding-top:4px">
                                                <div class="xiaofang" style="height: 100px;">
                                                    <img style="width: 100px; height: 100%" src="../../Content/images/img1.png" />
                                                </div>
                                                <div class="algin_margin" style="width: 100%; height: 40px;">
                                                    <div>生产组长:张小凡</div>
                                                    <div>电话号码:134XXXXX097</div>
                                                </div>
                                            </td>
                                            <td style="width: 25%; height: 100%;padding-left:10px;padding-top:4px">
                                                <div class="xiaofang" style="height: 100px;">
                                                    <img style="width: 100px; height: 100%" src="../../Content/images/img3.png" />
                                                </div>
                                                <div class="algin_margin" style="width: 100%; height: 40px;">
                                                    <div>品质组长:王末</div>
                                                    <div>电话号码:159XXXXX285</div>
                                                </div>
                                            </td>
                                            <td style="width: 25%; height: 100%;padding-left:10px;padding-top:4px">
                                                <div class="xiaofang" style="height: 100px;">
                                                    <img style="width: 100px; height: 100%" src="../../Content/images/xiaofangs.png" />
                                                </div>
                                                <div class="algin_margin" style="width: 100%; height: 40px;">
                                                    <div>设备组长:黄莉</div>
                                                    <div>电话号码:189XXXXX478</div>
                                                </div>
                                            </td>
                                            <td class="content_padding" style="width: 25%; height: 100%;">
                                                <div>标准人数：3</div>
                                                <div>实到人数：3</div>
                                                <div>UPPH:66.3</div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 80%;">

                                <td style="height: 80%">

                                    <table style="">
                                        <tr style="height: 60px;">
                                            <td style="height: 60px; vertical-align: top; color: #3CA2B0;font-weight:bold;font-size:20px;">
                                                <div style="width: 33%; height: 60px;line-height:60px; float: left; color: #3CA2B0; text-align: center;">
                                                    SKTMAX
                                                </div>
                                                <div style="width: 33%; height: 60px;line-height:60px;  float: left; color: #3CA2B0;text-align: center;">
                                                    SMT 线看板
                                                </div>
                                                <div id="dateAndWeek" style="width: 33%; height: 60px; line-height:60px; float: left; color: #3CA2B0; white-space: nowrap; text-align: center;">
                                                   
                                                </div>

                                            </td>
                                        </tr>
                                        <tr style="height: 15%;">
                                            <td style="height: 15%; text-align: center; background-color: #0E223B;">
                                                <div style="  /*border: 1px solid rgb(134, 174, 228);*/">
                                                    <div style="float: left;" class="gauge" id="echarts_gauge1">
                                                    </div>
                                                    <div style="float: left;" class="gauge" id="echarts_gauge2">
                                                    </div>
                                                    <div style="float: right;" class="gauge" id="echarts_gauge3">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="height: 20%;">
                                            <td style="height: 20%; text-align: center; background-color: #0E223B;">
                                                <table style="/*border: 1px solid rgb(134, 174, 228);*/">
                                                    <thead style="">
                                                        <tr>
                                                            <th>线体</th>
                                                            <th>工单</th>
                                                            <th>产品编码</th>
                                                            <th>产品名称</th>
                                                            <th>面别</th>
                                                            <th>计划数</th>
                                                            <th>投入</th>
                                                            <th>产出</th>
                                                            <th>不良数</th>
                                                            <th>生产状态</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody style="color: rgb(147,246,255);">
                                                        <tr>
                                                            <td>SMT1</td>
                                                            <td>SR37048</td>
                                                            <td>Q-017-00102-0</td>
                                                            <td>膜片</td>
                                                            <td>T</td>
                                                            <td>500</td>
                                                            <td>500</td>
                                                            <td>490</td>
                                                            <td>5</td>
                                                            <td>正在生产</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SMT2</td>
                                                            <td>SR37049</td>
                                                            <td>P-017-01022-0</td>
                                                            <td>阀支架</td>
                                                            <td>B</td>
                                                            <td>500</td>
                                                            <td>0</td>
                                                            <td>0</td>
                                                            <td>0</td>
                                                            <td>正在生产</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SMT3</td>
                                                            <td>SR37050</td>
                                                            <td>P-017-00900-0</td>
                                                            <td>连杆</td>
                                                            <td>T</td>
                                                            <td>800</td>
                                                            <td>100</td>
                                                            <td>100</td>
                                                            <td>0</td>
                                                            <td>正在生产</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SMT4</td>
                                                            <td>SR37051</td>
                                                            <td>P-017-00800-0</td>
                                                            <td>曲柄</td>
                                                            <td>B</td>
                                                            <td>800</td>
                                                            <td>0</td>
                                                            <td>0</td>
                                                            <td>0</td>
                                                            <td>正在生产</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SMT5</td>
                                                            <td>SR37052</td>
                                                            <td>P-017-00702-0</td>
                                                            <td>膜片支架</td>
                                                            <td>T</td>
                                                            <td>1000</td>
                                                            <td>1000</td>
                                                            <td>1000</td>
                                                            <td>10</td>
                                                            <td>已完成</td>
                                                        </tr>


                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr style="height: 25%;">
                                            <td>
                                                <div style="height: 100%;">
                                                    <div class="gauge1" style="width: 50%; float: left;height:200px;" id="echarts_gauge4">
                                                    </div>
                                                    <div class="gauge1" style="width: 50%; float: left;height:200px;" id="echarts_gauge5">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="height: 25%;">
                                            <td>
                                                <div style="height: 100%;">
                                                    <div class="gauge1" style="width: 100%; float: left; height:200px;" id="echarts_gauge6">
                                                    </div>

                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="height: 25%;">
                                            <td>
                                                <div style="height: 100%;">
                                                    <div class="gauge1" style="width: 49%; float: left;height:200px;" id="echarts_gauge7">
                                                    </div>
                                                    <div class="gauge1" style="width: 49%; float: left; border: solid 1px rgb(134,174,228)">
                                                        <p style="font-weight: bold; text-align: left; margin: 10px 5px; height: 10%">预警信息</p>
                                                        <p style="font-weight: bold; text-align: left; margin: 5px 5px; height: 10%">1、</p>
                                                        <p style="font-weight: bold; text-align: left; margin: 5px 5px; height: 10%">2、</p>
                                                        <p style="font-weight: bold; text-align: left; margin: 5px 5px; height: 10%">3、</p>
                                                        <p style="font-weight: bold; text-align: left; margin: 5px 5px; height: 10%">4、</p>
                                                        <p style="font-weight: bold; text-align: left; margin: 5px 5px; height: 10%">5、</p>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="height: 10%; text-align: center">
                                            <td>
                                                <h3 class="msg">
                                                    <p>欢迎领导莅临指导！</p>
                                                </h3>
                                            </td>
                                        </tr>
                                        <%--       <tr style="height: 43%;">
                                        <td style="height: 43%;">
                                            <table style="border-top: 1px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                <tr>
                                                    <td style="height: 100%; width: 60%;  border-right: 5px solid #041622;">
                                                        <div id="echarts_uph" style="height: 100%; padding-bottom:10px;">
                                                        </div>
                                                    </td>
                                                    <td style="height: 100%; width: 40%;">
                                                        <div id="echarts_top5nc" style="height: 100%;padding-bottom:10px;">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>--%>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
