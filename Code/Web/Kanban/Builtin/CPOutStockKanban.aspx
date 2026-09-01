<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CPOutStockKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.CPOutStockKanban" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <title>成品出货看板</title>
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
            height: 22px;
            line-height: 22px;
            text-align: center;
            font-size: 20px;
            color: #FFffff;
        }

        tr {
            height: 22px;
            line-height: 22px;
            text-align: center;
            font-size: 18px;
            color: #38FFFF;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 10%;">
                <li style="height: 100%;">
                    <span class="logo_cus2 cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 59%;">
                        <span class="cell" style="font-size: 40px; color: #FFffff; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">成品出货看板</span>
                    </div>
                    <div class="table" style="float: right; width: 19%;">
                        <span class="cell" style="font-size: 18px; color: #FFffff; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>
            <ul style="height: 40%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000;">
                <li style="height: 35%;">
                    <table style="width: 100%;border-top: 1px solid #263C54;border-left: 1px solid #263C54;border-right: 1px solid #263C54;">
                        <tr class="rows">
                            <th style="width: 10%">日期</th>
                            <th style="width: 15%">备货单号</th>
                            <th style="width: 15%">产品编码</th>
                            <th style="width: 20%">客户名称</th>
                            <th style="width: 10%">需出货数量</th>
                            <th style="width: 10%">备货数量</th>
                            <th style="width: 10%">已出货数量</th>
                        </tr>
                    </table>
                    <div id="_layout_left_data_div_tbody">
                        <div id="_layout_left_data_div2_tbody">
                            <table id="data_tbody" style="width: 100%; font-size: 22px; color: #4EC9CE; margin: 0 auto; height: 16%;border: 1px solid #263C54;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </li>
            </ul>

            <ul style="height: 45%;">
                <li style="height: 99%; margin-top: 10px;">
                    <div style="height: 100%; width: 35%; float: left; border-right: 5px solid #000000;">
                        <div style="height: 100%;">
                            <ul style="height: 100%;">
                                <li style="float: left; width: 45%; height: 100%; border-right: 5px solid #000000;">
                                    <div id="echarts_gauge2" class="gauge" style="width: 100%; height: 95%;"></div>
                                </li>
                                <li style="float: right; width: 53%; height: 100%;">
                                    <div id="echarts_gauge3" class="gauge" style="width: 100%; height: 95%;"></div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div style="height: 100%; width: 64%; float: right;" class="gauge" id="echarts_gauge1"></div>

                </li>
            </ul>
        </div>

        <script type="text/javascript">
            var refreshInterval = null;
            $(function () {
                //定时刷新页面
                if (refreshInterval) {
                    clearInterval(refreshInterval);
                };
                refreshInterval = setInterval(refreshPage, 1000 * 60 * 30);
            });

            //定时刷新页面
            function refreshPage() {
                window.location.reload();
            }

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
                scrollIntervalId = setInterval('scrollUp()', 80);
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
                    //bulidDataTb();
                }
            }
        </script>

        <script type="text/javascript">
            var echart1, echart2, echart3;
            var BackorderedPercent = 0;//当日备货完成率
            var OutPercent = 0;//当日出货完成率

            var monthData = [];
            var interval;
            $(document).ready(function () {
                ResizeAll();
                init();
                GetNowTime();

                setTimeout("init()", 90 * 1000);
            });

            function init() {
                bulidDataTb();
                bulidBackorderedCharts();
                bulidOutRate();
                bulidDayOutRate();

                if (interval != null) {
                    clearInterval(interval);
                }
                interval = setInterval("init()", 60 * 1000);
            }

            function GetNowTime() {

                $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));

                setTimeout("GetNowTime()", 1000);
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

                var _contentHeight = $(window).height() * 0.4;

                //$("#_layout_left_data_div_tbody").css("height", "auto");

                $(".rows").height(_contentHeight * 0.1)

                if ($(".rows").length * _contentHeight * 0.10 > _contentHeight) {
                    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.10 * 2 - 2);
                    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                    isScroll = true;
                }
            }

            /*
            **获取品质不良原因图
            */
            function bulidDayOutRate() {
                var month =  '<%=DateTime.Now.Month%>';
                var dayArr = [];
                var dayVal = [];
                if (monthData.length > 0) {

                    var outPer = 0;
                    for (var i = 0; i < monthData.length; i++) {

                        dayArr.push(monthData[i].SaleDate);
                        dayVal.push(monthData[i].OutPercent);
                    }
                }

                var option = {
                    title: {
                        text: '日出货完成率趋势图（' + month + '月）',
                        x: 'center',
                        textStyle: {
                            fontSize: 20,
                            color: '#F1F1F2',          // 主标题文字颜色
                            //textBorderColor: '#447DFE',
                            textShadowColor: '#5a5af7',
                            textShadowBlur: 20,
                            textShadowOffsetX: 2,
                            textShadowOffsetY: 2,
                        },
                        top: 15,
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: "{b} : {c} ({d}%)"
                    },
                    grid: {
                        top: '20%',
                        left: '2%',
                        right: '3%',
                        bottom: '5%',
                        containLabel: true
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: dayArr,
                            axisTick: {
                                alignWithLabel: true
                            },
                            axisLabel: {
                                interval: 0,//横轴信息全部显示
                                rotate: 0,//-30度角倾斜显示
                                textStyle: {
                                    color: '#37f6fe',//"#378DBD",//坐标值得具体的颜色
                                    fontSize: 15,
                                },
                                formatter: '{value}',
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
                                    color: ['#378DBD'],
                                },
                            },
                            splitLine: {
                                lineStyle: {
                                    color: '#2e2a32',//'#1f1529',
                                }
                            },
                            axisLabel: {
                                color: '#37f6fe',//"#378DBD",
                                formatter: '{value} %',
                                fontSize: 14,
                            },
                            //interval: 10,

                        }
                    ],
                    series: [{
                        data: dayVal,
                        type: 'line',
                        symbol: 'circle', // 拐点类型
                        smooth: true, // 当为true时，就是光滑的曲线（默认为true）；当为false，就是折线不是曲线的了，那这个设为true，下面的（吃饭）数据中设置smooth为false，这个就不是光滑的曲线了。
                        symbolSize: 3, // 拐点圆的大小
                        label: {
                            normal: {
                                show: true,
                                position: 'top',
                                color: '#F1CB52',
                                formatter: function (params) {
                                    return params.value == 0 ? "" : params.value + "%";
                                },
                                fontSize: 11,
                                rotate:20,//-30度角倾斜显示
                            },
                        },
                        itemStyle: {
                            normal: {
                                lineStyle: {
                                    color: '#1EB950', // 折线条的颜色                        
                                    width: 2,
                                }
                            }
                        },
                        areaStyle: {
                            normal: {
                                color: '#1EB950',
                                opacity: 0.1,
                                origin: 'start'
                            }

                        },
                    }],
                    color: ['#9d96f5', '#67e0e3', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570', '#c4ccd3']
                };
                /*注册ECHARTS*/
                echart1 = echarts.init(document.getElementById('echarts_gauge1'));
                echart1.setOption(option, true);

            }

            /*
           **获取当日备货完成率
           */
            function bulidBackorderedCharts() {

                var option = {
                    title: {
                        text: '当日备货完成率',
                        subtext: '',
                        left: 'center',
                        textStyle: {
                            fontSize: 20,
                            color: '#F1F1F2',          // 主标题文字颜色
                            //textBorderColor: '#447DFE',
                            textShadowColor: '#5a5af7',
                            textShadowBlur: 20,
                            textShadowOffsetX: 2,
                            textShadowOffsetY: 2,
                        },
                        top: 40,
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{b}: {c} ({d}%)',
                        //alwaysShowContent: true
                    },

                    series: [
                        {
                            name: '',
                            type: 'pie',
                            radius: ['50%', '75%'],
                            center: ["50%", "60%"],
                            avoidLabelOverlap: true,
                            itemStyle: {
                                normal: {
                                    color: function (params) {
                                        var colorList = ['#1EB950', '#46C4D2'];
                                        return colorList[params.dataIndex];
                                    },
                                }

                            },
                            label: {
                                normal: {
                                    show: true,
                                    position: 'center',
                                    formatter: function (params) {
                                        return params.dataIndex == 1 ? "" : params.value + " %";
                                    },
                                    color: '#1EB950',
                                    fontSize: 25,
                                    fontWeight: 'bold'
                                }

                            },

                            data: [
                                { value: BackorderedPercent, name: '备货完成率' },
                                { value: 100 - BackorderedPercent, name: '' },
                            ]
                        }
                    ]
                };

                /*注册ECHARTS*/
                echart2 = echarts.init(document.getElementById('echarts_gauge2'));
                echart2.setOption(option, true);


            }

            /*
           **获取当日出货完成率
           */
            function bulidOutRate() {
                var option = {
                    title: {
                        text: "当日出货完成率",
                        left: 'center',
                        textStyle: {
                            fontSize: 20,
                            color: '#F1F1F2',          // 主标题文字颜色                            
                            textShadowColor: '#5a5af7',
                            textShadowBlur: 20,
                            textShadowOffsetX: 2,
                            textShadowOffsetY: 2,
                        },
                        top: 40
                    },
                    series: [
                        {
                            startAngle: 180,
                            endAngle: 0,
                            type: 'gauge',
                            center: ['50%', '75%'],
                            radius: '90%',
                            min: 0,
                            max: 100,
                            splitNumber: 4,
                            axisLine: {            // 坐标轴线  
                                lineStyle: {       // 属性lineStyle控制线条样式                          
                                    color: [[0.2, '#F1F1F2'], [0.8, '#F1CB52'], [1, '#1EB950']],
                                    width: 30,
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
                                formatter: "{value}%",
                                offsetCenter: [0, '20%'],
                                textStyle: {
                                    color: '#3CA2B0',
                                    fontSize: 25,
                                    fontWeight: 'bold'
                                }
                            },
                            data: [{ value: OutPercent }]
                        }],
                    tooltip: {
                        formatter: function (p) {
                            return '1';
                        },
                        position: ['0%', '60%']
                    }
                };

                /*注册ECHARTS*/
                echart3 = echarts.init(document.getElementById('echarts_gauge3'));
                echart3.setOption(option, true);
            }

            function bulidDataTb() {
                                
                var entity = {};

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCPOutStock", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                var html = "";
                $("#data_tbody tbody").html(html);
                var data = JSON.parse(ajax.value).data;
                monthData = JSON.parse(ajax.value).data1 != undefined ? JSON.parse(ajax.value).data1 : [];

                var j = 1;

                if (data.length > 0) {
                    BackorderedPercent = data[0].BackorderedPercent;
                    OutPercent = data[0].OutPercent;
                }

                $.each(data, function (i, n) {
                    html += "<tr class=\"rows\">" +
                        "<td style=\"width:10%\">" + n["SaleDate"] + "</td>" +
                        "<td style=\"width:15%\">" + n["SaleOrderNo"] + "</td>" +
                        "<td style=\"width:15%\">" + n["ItemCode"] + "</td>" +
                        "<td style=\"width:20%\">" + n["CustomerName"] + "</td>" +
                        "<td style=\"width:10%\">" + n["PlanOutQty"] + "</td>" +
                        "<td style=\"width:10%\">" + n["BackorderedQty"] + "</td>" +
                        "<td style=\"width:10%\">" + n["OutQty"] + "</td>" +
                        "</tr>";
                    j++;
                })

                if ($("#_layout_left_data_div_tbody div").length > 1) {
                    $("#_layout_left_data_div_tbody div:eq(0)").remove();
                }

                $(html).appendTo($("#data_tbody tbody"));
                ResizeAll();
            }
        </script>
    </form>
</body>
</html>
