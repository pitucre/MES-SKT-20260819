<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonnelEfficiencykanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.PersonnelEfficiencykanban" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>线体人员效能看板</title>
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
            font-size: 20px;
            overflow: hidden;
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
            if (echart1 != null) { echart1.resize(); }
            
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
        $(document).ready(function () {
            $("#_left_top_title").html("线体人员效率看板");
            ResizeAll();
            getWelcome();
            initProductionData();
        });
        var option,  echart1;
        function getWelcome() {
            //if (welcomeMsg == "") {
            welcomeMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(-1, -1, 7).value;
            //}
            $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value));
            $("#_welcome_text").html(welcomeMsg);

            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 1);
        }

      
        var symbols = [
    'data:image/png;base64,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'];

        var bodyMax = 100;

        var labelSetting = {
            normal: {
                show: true,
                position: 'outside',
                offset: [0, -20],
                formatter: function (param) {
                    if (param.value > 0) {
                        return (param.value).toFixed(0) + '%';
                    }
                   
                },
                textStyle: {
                    fontSize: 18,
                    fontFamily: 'Arial'
                }
            }
        };

        var markLineSetting = {
            symbol: 'none',
            lineStyle: {
                opacity: 0.3
            },
            data: [{
                type: 'max',
                label: {
                    formatter: 'max: {c}'
                }
            }, {
                type: 'min',
                label: {
                    formatter: 'min: {c}'
                }
            }]
        };

        option = {
            title: {
                text: '人员效率',
                textStyle: {
                    fontSize: 16,
                    color: '#FFFFFF',          // 主标题文字颜色

                },
                left: '10'
            },
            tooltip: {
            },
            legend: {
                data: ['人员效率1'] ,  //['人员效率1', '人员效率2']
                selectedMode: 'single',
                textStyle: {
                    fontSize: 12,
                    color: '#FFFFFF',          // 主标题文字颜色

                }
               
            },
            xAxis: {
                data: ['a', 'b'],
                axisTick: { show: false },
                axisLine: { show: false },
                axisLabel: {
                    show: false,
                }
            },
            yAxis: {
                max: bodyMax,
                offset: 20,
                splitLine: { show: false },
                axisLabel: {
                    textStyle: {
                        color: '#4EC9CE',//坐标值得具体的颜色
                        fontSize: 15,
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#4EC9CE',
                    }
                }
            },
            grid: {
                top: 'center',
                height: 230
            },
            markLine: {
                z: -100
            },
            series: [{
                name: '人员效率1',
                type: 'pictorialBar',
                symbolClip: true,
                symbolBoundingData: bodyMax,
                label: labelSetting,
                itemStyle: {
                    color: '#44cef6'
                },
                data: [{
                    value: 88,
                    symbol: symbols[0]
                }, {
                    value: 34,
                    symbol: symbols[0]
                }],
                markLine: markLineSetting,
                z: 10
            }
            , {
                name: 'full',
                type: 'pictorialBar',
                symbolBoundingData: bodyMax,
                animationDuration: 0,
                itemStyle: {
                    color: '#44b0f6'
                },
                data: [{
                    value: 100,
                    symbol: symbols[0]
                }, {
                    value: 100,
                    symbol: symbols[0]
                }]
            }]
        };

        function getGaugeMaxVal(values) {
            var gaugeMax = 0;
            $.each(values, function () {
                if (this.value > gaugeMax) {
                    gaugeMax = this.value;
                }
            })
            return gaugeMax;
        }

        function initEcharts(data) {

            var orderDetial = [];
            var arr = [];
            if (data == null) { return false; }

            for (var i = 0; i < data.length; i++) {
                orderDetial.push(data[i].LineName);
                arr.push({ name: data[i].LineName, value: data[i].Value });
            }
          
            myChartWip = echarts.init(document.getElementById('echarts_personEff'));


            var option1 = {
                title: {
                    text: '线体人员效率',
                     x: 'left',
                    textStyle: {
                        fontSize: 18,
                        textShadowColor: '#ffffff',
                        textShadowBlur: 20,
                        textShadowOffsetX: 5,
                        textShadowOffsetY: 5,
                        color: '#FFFFFF', 
                    }
                    
                },
                legend: {
                    data: orderDetial,
                    selectedMode: 'single',
                    textStyle: {
                        fontSize: 12,
                        color: '#FFFFFF',          // 主标题文字颜色
                    }
                },
                color: ['#FFFFFF'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '5%',
                    containLabel: true
                },
                xAxis: [
                    {   axisTick: { show: false },
                        axisLine: { show: false },
                        axisLabel: {
                            textStyle: {
                                color: '#ffffff',//坐标值得具体的颜色
                                fontSize: 13,
                            },
                            interval: 0,
                            rotate: 25
                        },
                        type: 'category',
                        data: orderDetial
                       
                       
                    }
                ],
                yAxis: [
                    {   max: 100,
                        offset: 20,
                        splitLine: { show: false },
                        axisLabel: {
                            textStyle: {
                                color: '#FFFFFF',//坐标值得具体的颜色
                                fontSize: 13,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#4EC9CE',
                            }
                        },
                        type: 'value',
                        axisLine: {
                            lineStyle: {
                                color: '#000000'
                            }
                        }
                    }
                ],
                series: [
                    {
                        type: 'bar',
                        barMaxWidth:"160",
                        barMinWidth: '60',
                        itemStyle: {
                            normal: {
                                //color: '#95CA13',
                                label: {
                                    show: true,
                                    position: 'top',
                                    formatter: '{c}%',
                                    textStyle: {
                                        color: '#F1F1F2'
                                    }
                                }, color: function (p) {
                                    var colorList = ['#32e0e7', '#148fe4', '#483D8B', '#556B2F', '#826A4F', '#51DE8A', '#fbfa23', '#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#25851D', '#ADC7B8'];
                                    var index = p.dataIndex;
                                    return colorList[index];
                                }
                            }
                        },
                        data: arr
                    }
                ]
            };
           
            // 使用刚指定的配置项和数据显示图表。
            myChartWip.setOption(option1, true);
            //value = data;
            //var xAxisName = [];
            //var seriesData = [];
            //var fullsData = [];
            //$.each(value, function () {
            //    var serieData = {};                
            //    serieData.value = parseInt(this.value);
            //    serieData.symbol = symbols[0];
            //    seriesData.push(serieData);

            //    var fullData = {};                
            //    fullData.value = 100;
            //    fullData.symbol = symbols[0];
            //    fullsData.push(fullData);

            //    xAxisName.push(this.LineName);
            //});
            //option.legend.data = orderDetial;
            //option.xAxis.data = orderDetial;
            ////option.series[0].max = getGaugeMaxVal(value);
            //option.series[0].data = arr;
            ////option.series[1].data = fullsData;
            //echart1.setOption(option, true);
        }

        function initProductionData() {
            $("#data_tbody tbody").html("");
            $.ajax({
                type: 'POST',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SMTLineProduction.ashx',
                data: { 'Type': 'PersonnelEffciencyData', 'LineId': -1, 'WorkshopId': -1 },
                dataType: 'json',
                success: function (data) {
                    if (data == null) { return false; }
                    var info = data.Table;
                    if (info != undefined && info != null) {
                        $.each(info, function () {
                            $("<tr class='rows'>" +
                                "<td width='6%'>" + this.LineName + "</td>" +
                                "<td width='15%'>" + this.OrderNO + "</td>" +
                                "<td width='12%'>" + this.ItemCode + "</td>" +
                                "<td width='15%'>" + this.ItemName + "</td>" +
                                "<td width='8%'>" + this.Qty_to_Build + "</td>" +
                                "<td width='6%'>" + this.Fqty + "</td>" +
                                "<td width='6%'>" + this.Input + "</td>" +
                                "<td width='6%'>" + this.OutPut + "</td>" +
                                "<td width='6%'>" + this.StandardLaborTime + "</td>" +
                                "<td width='6%'>" + this.ActualHuman + "</td>" +
                                "<td width='6%'>" + this.WorkHours + "</td>" +
                                "<td width='8%'>" + this.Status + "</td></tr>").appendTo($("#data_tbody tbody"));
                        });

                        ResizeAll();
                        initEcharts(data.Table1);
                    }                    
                },
                complete: function () {
                    clearTimeout(ProductionDataTimeout);
                    var ProductionDataTimeout = setTimeout("initProductionData()", timeInterval);
                }
            });
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
                                        <td id="_left_top_welcome">
                                            <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                                scrollamount="3" onmouseover="this.stop();" onmouseout="this.start();">
                                                <div id="_welcome_text">
                                                </div>
                                            </marquee>
                                        </td>
                                        <td id="dateAndWeek" rowspan="2" style="color: #3CA2B0; white-space: nowrap;"></td>
                                        <td class="logo_skt" style="width: 250px; height: 100%;" rowspan="2"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="_left_top_title" style="float: inherit; margin-bottom: 10px;">-</div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 88%;">

                            <td style="height: 88%;">

                                <table style="border-right: 1px solid #e3e3e3;">
                                    <tr style="height: 30%;">
                                        <td style="height: 40%; vertical-align: top;">

                                            <div style="height: 100%; background-color: #0E223B; display: table; width: 100%; border-top: 5px solid #041622;">
                                                <div style="display: table-cell; width: 100%; vertical-align: middle;">
                                                    <table id="data_thead" style="height: 16%; border-left: 1px solid #263C54; font-size: 21px; border-right: 1px solid #263C54; width: 98%; margin: 0 auto;">
                                                        <tbody>
                                                            <tr class="rows">
                                                                <th width="6%">线体
                                                                </th>                                                               
                                                                <th width="15%">工单
                                                                </th>
                                                                <th width="12%">产品编码
                                                                </th>
                                                                <th width="15%">产品名称
                                                                </th>
                                                                <th width="8%">工单数
                                                                </th>
                                                                <th width="6%">计划
                                                                </th>
                                                                <th width="6%">投入
                                                                </th>
                                                                <th width="6%">良品
                                                                </th>
                                                                <th width="6%">标准工时
                                                                </th>
                                                                <th width="6%">人员数
                                                                </th>
                                                                <th width="6%">投入总工时
                                                                </th>
                                                                <th width="8%">生产状态
                                                                </th>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <div id="_layout_left_data_div_tbody">
                                                        <div id="_layout_left_data_div2_tbody">
                                                            <table id="data_tbody" style="width: 98%; font-size: 22px; color: #4EC9CE; border-left: 1px solid #263C54; border-right: 1px solid #263C54; margin: 0 auto;">
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>  
                                                    <table id="data_tfoot" style="height: 15%; width: 98%; margin: 0 auto; font-size: 21px;">
                                                        <tbody>
                                                            <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                                <td width="6%">
                                                                </td>
                                                                <td width="15%">-
                                                                </td>
                                                                <td width="12%">-
                                                                </td>
                                                                <td width="15%">-
                                                                </td>
                                                                <td width="8%">-
                                                                </td>
                                                                <td width="6%">-
                                                                </td>
                                                                <td width="6%">-
                                                                </td>
                                                                <td width="6%">-
                                                                </td>
                                                                <td width="6%">-
                                                                </td>
                                                                <td width="6%">-
                                                                </td>
                                                                <td width="6%">-
                                                                </td>
                                                                <td width="8%">-
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>                                                  
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 60%;">
                                        <td style="height: 60%;">
                                            <table style="border-top: 1px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                <tr>                                                    
                                                    <td style="height: 100%; width: 100%;">
                                                        <div id="echarts_personEff" style="height: 100%; padding-bottom: 10px;">
                                                        </div>
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
