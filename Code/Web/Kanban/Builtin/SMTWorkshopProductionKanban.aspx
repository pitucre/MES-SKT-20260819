<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTWorkshopProductionKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.SMTWorkshopProductionKanban" %>


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
            font-size:20px;
            overflow:hidden;
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
            if (echart2 != null) { echart2.resize(); }
            if (echart3 != null) { echart3.resize(); }
            if (echart4 != null) { echart4.resize(); }
            if (echart5 != null) { echart5.resize(); }
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
        option1 = {
            series: [
            {
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '150%',
                min: 0,
                max: 100,
                splitNumber: 4,
                axisLine: {            // 坐标轴线  
                    lineStyle: {       // 属性lineStyle控制线条样式  
                        color: [[0.2, '#447DFF'], [0.8, '#32E0E7'], [1, '#447DFE']],
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
                    formatter: "生产进度 {value}%",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#3CA2B0',
                        fontSize: 20
                    }
                },
                data: [{ value: 0 }]
            }],
            tooltip: {
                formatter: function (p) {
                    return '<%=T1%>';
                },
                position:['5%','50%']
            }
        };
        option2 = {
            series: [
            {
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '150%',
                min: 0,
                max: 100,
                splitNumber: 4,
                axisLine: {            // 坐标轴线  
                    lineStyle: {       // 属性lineStyle控制线条样式  
                        color: [[0.2, '#F14842'], [0.8, '#F1CB52'], [1, '#1EB950']],
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
                    formatter: "IE效率 {value}%",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#3CA2B0',
                        fontSize: 20
                    }
                },
                data: [{ value: 0 }]
            }],
            tooltip: {
                formatter: function (p) {
                    return '<%=T2%>';
                },
                position: ['0%', '30%'],
                textStyle: { align: 'left' },
                trigger:'item'
            }
        };
        option3 = {
            series: [
            {
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '150%',
                min: 0,
                max: 100,
                splitNumber: 4,
                axisLine: {            // 坐标轴线  
                    lineStyle: {       // 属性lineStyle控制线条样式  
                        color: [[0.2, '#447DFF'], [0.8, '#32E0E7'], [1, '#447DFE']],
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
                    formatter: "直通率 {value}%",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#3CA2B0',
                        fontSize: 20
                    }
                },
                data: [{ value: 0 }]
            }],
            tooltip: {
                formatter: function (p) {
                    return '<%=T3%>';
                },
                position:['0%','50%']
            }
        };
        option4 = {
            color: ['#32E0E7', '#008100','#00FF00'],
            title: {
                text: '计划产出',
                textStyle: {
                    fontSize: 16,
                    color: '#FFFFFF',          // 主标题文字颜色

                },
                left: '10'
            },
            tooltip: {
                trigger: 'axis'
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            legend: {
                //selected: {
                //    '计划达成率': false
                //},
                textStyle: {
                    fontSize:15,
                    color: '#4EC9CE'
                },
                data: []
            },
            calculable: true,
            xAxis: [
            {
                type: 'category',
                data: [],
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
                },
                splitLine: {
                    show: false
                }
            }],
            yAxis: [
            {
                type: 'value',
                name: '产能',
                position: 'left',
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
                },
                splitLine: {
                    lineStyle: {
                        color: '#45576F',
                    }
                }
            },
            {
                type: 'value',
                axisLine: { onZero: true },
                name: '计划达成率',
                position: 'right',
                min: 0,
                max: 100,
                splitLine: {
                    show: false
                },
                axisLabel: {
                    formatter: '{value}%',
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
            }],
            series: []
        };
        option5 = {
            title: {
                text: '今日Top5不良',
                textStyle: {
                    fontSize: 16,
                    color: '#FFFFFF',          // 主标题文字颜色

                },
                left: '10'
            },
            tooltip: {
                trigger: 'axis'
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true,
                show: false,
            },
            legend: {
                data: []
            },
            calculable: true,
            xAxis: [
            {
                type: 'category',
                data: [],
                axisLabel: {
                    textStyle: {
                        color: '#4EC9CE',//坐标值得具体的颜色
                        fontSize: 15,
                    },
                    /*Add By Alen 2018-02-05 看板柱状图标签换行显示，默认每行8个字符*/
                    interval:0,
                    formatter: function (params) {
                        var newParamsName = "";// 最终拼接成的字符串
                        var paramsNameNumber = params.length;// 实际标签的个数
                        var provideNumber = 8;// 每行能显示的字的个数
                        var rowNumber = Math.ceil(paramsNameNumber / provideNumber);// 换行的话，需要显示几行，向上取整
                        /**
                         * 判断标签的个数是否大于规定的个数， 如果大于，则进行换行处理 如果不大于，即等于或小于，就返回原标签
                         */
                        // 条件等同于rowNumber>1
                        if (paramsNameNumber > provideNumber) {
                            /** 循环每一行,p表示行 */
                            for (var p = 0; p < rowNumber; p++) {
                                var tempStr = "";// 表示每一次截取的字符串
                                var start = p * provideNumber;// 开始截取的位置
                                var end = start + provideNumber;// 结束截取的位置
                                // 此处特殊处理最后一行的索引值
                                if (p == rowNumber - 1) {
                                    // 最后一次不换行
                                    tempStr = params.substring(start, paramsNameNumber);
                                } else {
                                    // 每一次拼接字符串并换行
                                    tempStr = params.substring(start, end) + "\n";
                                }
                                newParamsName += tempStr;// 最终拼成的字符串
                            }

                        } else {
                            // 将旧标签的值赋给新标签
                            newParamsName = params;
                        }
                        //将最终的字符串返回
                        return newParamsName
                        /*Alen End*/
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#4EC9CE',
                    }
                },
                splitLine: {
                    show: false
                }
            }],
            yAxis: [
            {
                type: 'value',
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
                },
                splitLine: {
                    lineStyle: {
                        color: '#45576F',
                    }
                }
            }],
            series: []
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

        function initEcharts(data) {

            /*生产进度(产出/计划数*100%)*/
            //value = (data.SumInput > 0 ? data.SumOutput / data.SumInput * 100 : 0).toFixed(2);
            value = data.Progress;
            option1.series[0].max = getGaugeMaxVal(value);
            option1.series[0].data[0].value = value;
            echart1.setOption(option1, true);

            /*IE效率(总瓶颈工时*产出/(生产总时-异常工时)*100%)*/
            //value = data.SumDiffSecond - data.SumAbnormalTime;
            //value = (value > 0 ? data.SumBottleneckHours * data.SumOutput / value * 100 : 0).toFixed(2);

            value = data.IEEfficiency;
            option2.series[0].max = getGaugeMaxVal(value);
            option2.series[0].data[0].value = value;
            echart2.setOption(option2, true);

            /*直通率(白板数/总产出*100%)*/
            //value = (data.SumOutput > 0 ? data.NoDefects / data.SumOutput * 100 : 0).toFixed(2);
            value = data.FPY;
            option3.series[0].max = getGaugeMaxVal(value);
            option3.series[0].data[0].value = value;
            echart3.setOption(option3, true);

            /*计划产能*/
            option4.series = [];
            if (data.Echarts != null) {
                option4.legend.data = ['计划', '产出', '计划达成率'];
                option4.xAxis[0].data = data.Echarts.Axis;
                if (typeof (data.Echarts.Series[0]) != 'undefined') {
                    option4.series.push({
                        type: 'bar',
                        name: '计划',
                        yAxisIndex: 0,
                        
                        label: {
                            normal: {
                                show: true,
                                position: 'top'
                            }
                        },
                        barWidth: '35%',
                        barMaxWidth: 80,
                        data: data.Echarts.Series[0]
                    });
                }
                if (typeof (data.Echarts.Series[1]) != 'undefined') {
                    option4.series.push({
                        type: 'bar',
                        name: '产出',
                        yAxisIndex: 0,
                        
                        label: {
                            normal: {
                                show: true,
                                position: 'top'
                            }
                        },
                        barWidth: '35%',
                        barMaxWidth: 80,
                        data: data.Echarts.Series[1]
                    });
                }

                if (typeof (data.Echarts.Series[2] != "undefined")) {

                    /*设置计划达成率最大值*/
                    var maxRate = 100;
                    var arrTipRate = new Array();
                    $.each(data.Echarts.Series[2], function () {
                        maxRate = parseInt(this) > maxRate ? parseInt(this) : maxRate;
                        arrTipRate.push(0);
                    });
                    option4.yAxis[1].max = parseInt(maxRate) >= maxRate ? parseInt(maxRate) : parseInt(maxRate) + 1;

                    option4.series.push({
                        name: '计划达成率',
                        type: 'line',
                        yAxisIndex: 1,
                        data: data.Echarts.Series[2],
                        itemStyle: {
                            normal: {
                                label: {
                                    show: true,
                                    formatter: '{c}%',
                                    
                                }
                            }
                        }
                    });

                    //option4.series.push({
                    //    name: '计划达成率',
                    //    type: 'line',
                    //    yAxisIndex: 1,
                    //    data: arrTipRate,
                    //    axis: {
                    //        axisLine: {
                    //            show: false
                    //        }
                    //    }
                    //});
                }
            }
            echart4.clear();
            echart4.setOption(option4);
        }

        function initProductionTop5NC() {
            $.ajax({
                type: 'POST',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SMTLineProduction.ashx',
                data: { 'Type': 'ProductionTop5NC', 'LineId': -1, 'WorkshopId': workshopId },
                dataType: 'json',
                success: function (data) {
                    option5.series = [];
                    if (data.Axis.length > 0) {
                        option5.xAxis[0].data = data.Axis;
                    }
                    option5.series.push({
                        type: 'bar',
                        yAxisIndex: 0,
                        label: {
                            normal: {
                                show: true,
                                position: 'top'
                            }
                        },
                        barWidth: '80%',
                        barMaxWidth: 80,
                        data: data.Series
                    });

                    echart5.clear();
                    echart5.setOption(option5);
                },
                complete: function () {
                    clearTimeout(topnc);
                    var topnc = setTimeout("initProductionTop5NC()", timeInterval);
                }
            });
        }
    </script>
    <script type="text/javascript">
        var workshopId, workshopName, welcomeMsg;
        $(document).ready(function () {
            /*设置title*/
            workshopId = getQueryString("workshopId");
            workshopName = getQueryString("workshopName");
            welcomeMsg = "";

            $("#_left_top_title").html(workshopName + "生产状况综合日看板");

            ResizeAll();

            /*注册ECHARTS*/
            echart1 = echarts.init(document.getElementById('echarts_gauge1'));
            echart2 = echarts.init(document.getElementById('echarts_gauge2'));
            echart3 = echarts.init(document.getElementById('echarts_gauge3'));
            echart4 = echarts.init(document.getElementById('echarts_uph'));
            echart5 = echarts.init(document.getElementById("echarts_top5nc"));

            getWelcome();
            initProductionTop5NC();
            initProductionData();
        });

        function getWelcome() {
            //if (welcomeMsg == "") {
                welcomeMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(workshopId, -1,2).value;
            //}
            $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value));
            $("#_welcome_text").html(welcomeMsg);

            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 1);
        }

        function initProductionData() {
            $("#data_tbody tbody").html("");
            $.ajax({
                type: 'POST',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SMTLineProduction.ashx',
                data: { 'Type': 'ProductionData', 'LineId': -1, 'WorkshopId': workshopId },
                dataType: 'json',
                success: function (data) {
                    if (data == null) { return false; }
                    $.each(data.List, function () {
                        $("<tr class='rows'>" +
                            "<td width='5%'>" + this.LineName + "</td>" +
                            "<td width='12%'>" + this.CustomerOrder + "</td>" +
                            "<td width='15%'>" + this.OrderNo + "</td>" +
                            "<td width='12%'>" + this.ItemCode + "</td>" +
                            "<td width='8%'>" + this.QtyToBuild + "</td>" +
                            "<td width='4%'>" + this.Surface + "</td>" +
                            "<td width='5%'>" + this.Designed + "</td>" +
                            "<td width='5%'>" + this.Input + "</td>" +
                            "<td width='5%'>" + this.Output + "</td>" +
                            "<td width='5%'>" + this.Defects + "</td>" +
                            "<td width='5%'>" + this.AllInput + "</td>" +
                            "<td width='5%'>" + this.AllOutput + "</td>" +
                            "<td width='5%'>" + this.AllDefects + "</td>" +
                            "<td width='6%'>" + this.Status + "</td></tr>").appendTo($("#data_tbody tbody"));
                    });
                    $("#data_tfoot tbody tr td:eq(4)").html(data.SumQtyToBuild);
                    $("#data_tfoot tbody tr td:eq(6)").html(data.SumDesigned);
                    $("#data_tfoot tbody tr td:eq(7)").html(data.SumInput);
                    $("#data_tfoot tbody tr td:eq(8)").html(data.SumOutput);
                    $("#data_tfoot tbody tr td:eq(9)").html(data.SumDefects);
                    $("#data_tfoot tbody tr td:eq(10)").html(data.AllInput);
                    $("#data_tfoot tbody tr td:eq(11)").html(data.AllOutput);
                    $("#data_tfoot tbody tr td:eq(12)").html(data.AllDefects);

                    if (parseInt($("#tdActualNumber").html()) > 0) {
                        $("#tdUPPH").html((data.SumOutput / parseInt($("#tdActualNumber").html())).toFixed(2));
                    }


                    ResizeAll();
                    initEcharts(data);
                },
                complete: function () {
                    clearTimeout(ProductionDataTimeout);
                    var ProductionDataTimeout = setTimeout("initProductionData()", timeInterval);
                }
            });
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
                                        <td id="_left_top_welcome">
                                            <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                                scrollamount="3" onmouseover="this.stop();" onmouseout="this.start();" >
                                    <div id="_welcome_text">
                                    </div>
                                </marquee>
                                        </td>
                                        <td id="dateAndWeek" rowspan="2" style="color: #3CA2B0; white-space:nowrap;"></td>
                                        <td class="logo_skt" style="width: 250px; height: 100%;" rowspan="2"></td>
                                    </tr>
                                    <tr>
                                        <td ><div id="_left_top_title" style="float: inherit; margin-bottom: 10px;">-</div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 88%;">

                            <td style="height: 88%;">

                                <table style="border-right: 1px solid #e3e3e3;">
                                    <tr style="height: 30%;">
                                        <td style="height: 30%; vertical-align: top;">

                                            <div style="height: 100%; background-color: #0E223B; display: table; width: 100%; border-top: 5px solid #041622;">
                                                <div style="display: table-cell; width: 100%; vertical-align: middle;">
                                                    <table id="data_thead" style="height: 16%; border-left: 1px solid #263C54;font-size:21px; border-right: 1px solid #263C54; width: 98%; margin: 0 auto;">
                                                        <tbody>
                                                            <tr class="rows">
                                                                <th width="5%">线体
                                                                </th>
                                                                <th width="12%">订单号
                                                                </th>
                                                                <th width="15%">工单
                                                                </th>
                                                                <th width="12%">产品编码
                                                                </th>
                                                                <th width="8%">工单数
                                                                </th>
                                                                <th width="4%">面别
                                                                </th>
                                                                <th width="5%">今日计划
                                                                </th>
                                                                <th width="5%">今日投入
                                                                </th>
                                                                <th width="5%">今日产出
                                                                </th>
                                                                <th width="5%">今日不良
                                                                </th>
                                                                <th width="5%">总投入
                                                                </th>
                                                                <th width="5%">总产出
                                                                </th>
                                                                <th width="5%">总不良
                                                                </th>
                                                                <th width="6%">生产状态
                                                                </th>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <div id="_layout_left_data_div_tbody">
                                                        <div id="_layout_left_data_div2_tbody">
                                                            <table id="data_tbody" style="width: 98%;font-size:22px; color: #4EC9CE; border-left: 1px solid #263C54; border-right: 1px solid #263C54; margin: 0 auto;">
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <table id="data_tfoot" style="height: 16%; font-size:21px; width: 98%; margin: 0 auto; border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                        <tbody>
                                                            <tr class="rows">
                                                                <td width="5%">汇总
                                                                </td>
                                                                <td width="12%">-
                                                                </td>
                                                                <td width="15%">-
                                                                </td>
                                                                <td width="12%">-
                                                                </td>
                                                                <td width="8%">0
                                                                </td>
                                                                <td width="4%">-
                                                                </td>
                                                                <td width="5%">0
                                                                </td>
                                                                <td width="5%">0
                                                                </td>
                                                                <td width="5%">0
                                                                </td>
                                                                <td width="5%">0
                                                                </td>
                                                                <td width="5%">0
                                                                </td>
                                                                <td width="5%">0
                                                                </td>
                                                                <td width="5%">0
                                                                </td>
                                                                <td width="6%">-
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 27%;">
                                        <td style="height: 27%; text-align: center;background-color: #0E223B; border-top: 5px solid #041622;">
                                            <div style="height: 100%;  padding-top: 10px;">
                                                <div style="float: left;" class="gauge" id="echarts_gauge1">
                                                </div>
                                                <div style="float: left;" class="gauge" id="echarts_gauge2">
                                                </div>
                                                <div style="float: right;" class="gauge" id="echarts_gauge3">
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 43%;">
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
