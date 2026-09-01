<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTLineProductionKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.SMTLineProductionKanban" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>线体看板</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/chalk.js" type="text/javascript"></script>    
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

        ul, li {
            float: left;
            margin: 0px;
            padding: 0px;
            list-style: none;
            width: 100%;
            background-color: #0E223B;
        }

        #lineInfo li {
            margin-left: 35px;
            width: 35%;
            line-height: 40px;
        }

        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat center center;
             background-size: 225px,80px;
            background-color: #0D213A;
        }

        .logo_skt {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center center;
             background-size: 225px,60px;
            background-color: #0D213A;
        }

        #_left_top_title {
            width: 90%;
            height: 100%;
            font-size: 1.5em;
            text-align: center;
            padding-left: 10px;
        }

        #_left_top_welcome {
            width: 75%;
            height: 100%;
            font-size: 1.6em;
            color: Red;
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
            /*width: 10%;*/
            border-top: 1px solid #263C54;
            /*border-left: 1px solid #263C54;*/
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

        var timeInterval = 1000 * 60 * 2;

        $(document).ready(function () {
            ResizeAll();
        });

        $(window).resize(function () {
            ResizeAll();
            if (echart1 != null) { echart1.resize(); }
            if (echart2 != null) { echart2.resize(); }
            if (echart3 != null) { echart3.resize(); }
            if (echart4 != null) { echart4.resize(); }
        });

        function ResizeAll() {

            //某些浏览器不兼容div自适应高度
            $(".gauge").height($(window).height() * 0.9 * 0.27);

            var _contentHeight = $(window).height() * 0.9 * 0.3;

            $(".rows").height(_contentHeight * 0.13)

            //$("#imgPortraits").height($(window).height() * 0.3)

            if ($(".rows").length * _contentHeight * 0.16 > _contentHeight) {
                $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);
                _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", 1000, 150, 1000 * 6);
                isScroll = true;
            }
        }
    </script>
    <script type="text/javascript">
        var option1, option2, option3, option4, echart1, echart2, echart3, echart4;
        var legends;
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
                position: ['0%', '30%']
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
                position: ['0%', '50%']
            }
        };
       /* 使用jquery的inArray方法判断元素是否存在于数组中
@param {Object} arr 数组
@param {Object} value 元素值
*/
        function isInArray2(arr,value){
            var index = $.inArray(value,arr);
            if(index >= 0){
                return true;
            }
            return false;
        }
        function formatterTip(params) {
          

            var tip = '';
            for (var i = 0; i < params.length; i++) {//这里是自己定义样式， params[i].marker 表示是否显示左边的那个小圆圈
              
             
                if (isInArray2(legends, params[i].seriesName)) {
                    var lineType = params[i].seriesType;
                   
                    if (lineType== 'line')
                    {
                        tip = tip + params[i].marker + params[i].seriesName + ':' + params[i].value + '(达成率)<br/>----------------------<br/>';
                    }
                    else
                    {
                        tip = tip + params[i].marker + params[i].seriesName + ':' + params[i].value + '(当前产能)<br/>';
                    }
                   
                   
                }
            }

            return tip;
        }
        option4 = {
            title: {
                text: 'UPH产能对标',
                textStyle: {
                    fontSize: 16,
                    color: '#FFFFFF',          // 主标题文字颜色
                   
                },                 
                left: '10'               
            },
            tooltip: {
                trigger: 'axis',
 
                formatter:function(params) {
                    
                   
                    return formatterTip(params);
                   
                }
            },
            grid: {
                left: '7%',
                right: '7%',
                bottom: '7%',
                containLabel: true,
                show: false,

            },
            legend: {
                selected: {
                    '达成率': false
                },
                textStyle: {
                    fontSize: 15,
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
                        fontSize: 16,
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
                        fontSize:15,
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
                name: '达成率',
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
            var value = 0;
            echart1 = echarts.init(document.getElementById('echarts_gauge1'));
            echart2 = echarts.init(document.getElementById('echarts_gauge2'));
            echart3 = echarts.init(document.getElementById('echarts_gauge3'));

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
        }

        function initProductionUPH() {
            echart4 = echarts.init(document.getElementById("echarts_uph"));

            $.ajax({
                type: 'POST',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SMTLineProduction.ashx',
                data: { 'Type': 'ProductionUPH', 'LineId': lineId, 'WorkshopId': -1 },
                dataType: 'json',
                success: function (data) {

                    option4.series = [];
                    option4.xAxis[0].data = data.Axis;
                    option4.xAxis[0].data[data.Axis.length - 1] =
                    {
                        value: data.Axis[data.Axis.length - 1],
                        textStyle: {
                            color: '#447DFF',
                            fontWeight: 'bold'
                        }
                    };
           
                    //设置Legen值
                    option4.legend.data = data.Legen;
                    legends = data.Legen;
                    var colorList = ['#32e0e7', '#148fe4', '#fbfa23', '#32E0E7', '#826A4F', '#51DE8A', '#fbfa23', '#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#25851D', '#ADC7B8'];
                    var legendNum = data.Legen.length;
                    //var legendColors = [];
                    //for (var i = 0; i < legendNum; i++) {
                    //    legendColors.push(colorList[i]);
                    //}
                   // console.log(legendColors);
                    option4.color = colorList;
                    /*默认插入空值显示时间段，后续有数据则清空*/
                    option4.series.push({
                        name: '',
                        type: 'bar',
                        yAxisIndex: 0,
                        data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                        stack: groupName,
                        label: {
                            normal: {
                                show: true,
                                position: 'inside',
                                textStyle: {
                                    color: '#3CA2B0',
                                    fontWeight: 'lighter',
                                    fontSize: 10
                                },
                                formatter: function (p) {
                                    if (p.value === 0) { return ""; }
                                    return p.value;
                                }
                            }
                        }
                    });

                    if (data == null || data.Series == null || data.Series.length < 1) { return false; }
                    if (data.Series[0].length > 0) { option4.series = []; }

                    /*设置UPH高度*/
                    var maxUPH = 0;
                    var SumOutput = 0;
                    $.each(data.Series, function () {
                        $.each(this, function () {
                            if (this.StandardCapacity > maxUPH) {
                                maxUPH = this.StandardCapacity;
                            }
                            if (this.SumOutput > SumOutput) {
                                SumOutput = this.SumOutput;
                            }
                        });
                    });

                    var maxRate = 0;
                    for (var i = 0; i < data.Series[0].length; i++) {
                        var arrUPH = new Array();
                        var arrRate = new Array();
                        var arrOutput = new Array();

                        for (var j = 0; j < data.Series.length; j++) {
                            arrOutput.push(data.Series[j][i].SumOutput);
                       
                            arrUPH.push(data.Series[j][i].SumOutput > 0 ? 1.2 : 0);

                            var rate = parseFloat(data.Series[j][i].SumOutput > 0 ? (data.Series[j][i].SumOutput / data.Series[j][i].StandardCapacity * 100).toFixed(2) : 0);
                            arrRate.push(rate);

                            /*找到最大'达标率'的值*/
                            maxRate = rate > maxRate ? rate : maxRate;
                        }
                       //cs
                        var groupName = "sum" + i;
                    

                        option4.series.push({
                            name: data.Series[0][i].ItemName,
                            type: 'bar',
                            yAxisIndex: 0,
                            data: arrOutput,
                            stack: groupName,
                            label: {
                                normal: {
                                    show: true,
                                    position: 'inside',
                                    textStyle: {
                                        color: '#24244f',
                                        fontWeight: 'lighter',
                                        fontSize: 10
                                    },
                                    formatter: function (p) {
                                        if (p.value === 0) { return ""; }
                                        return p.value;
                                    }
                                }
                            },
                            itemStyle: {
                                normal: {
                                    //color: function (p) {
                                    //    var colorList = ['#32e0e7', '#148fe4', '#fbfa23', '#32E0E7', '#826A4F', '#51DE8A', '#fbfa23', '#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#25851D', '#ADC7B8'];
                                    //    var index = p.seriesIndex;
                                    //    console.log(index / (data.Series[0].length + 1));
                                    //    return colorList[index / (data.Series[0].length+1)];
                                    //}
                                }
                            }
                        });
                      
                        option4.series.push({
                            name: i,
                            type: 'bar',
                            yAxisIndex: 0,
                            data: arrUPH,
                            stack: groupName,
                            label: {
                                normal: {
                                    show: true,
                                    position: 'inside',
                                    textStyle: {
                                        fontWeight: 'lighter',
                                        color: '#24244f',
                                        fontSize: 10
                                    },
                                    formatter: function (p) {
                                     
                                        if (p.value === 0) { return ""; }
                                        var uph = 0;
                                        if (data.Axis.indexOf(p.name) === -1 && data.Axis[data.Axis.length - 1].value === p.name) {
                                            uph = data.Series[data.Axis.length - 1][p.seriesName].StandardCapacity;
                                        } else {
                                            uph = data.Series[data.Axis.indexOf(p.name)][p.seriesName].StandardCapacity;
                                        }
                                    
                                        return uph;
                                    }
                                }
                            },
                            itemStyle: {
                                normal: {
                                    color: function (p) {
                                        if (p.value === 0) { return ""; }
                                        var uph, output;
                                        if (data.Axis.indexOf(p.name) === -1 && data.Axis[data.Axis.length - 1].value === p.name) {
                                            uph = data.Series[data.Axis.length - 1][p.seriesName].StandardCapacity;
                                            ouput = data.Series[data.Axis.length - 1][p.seriesName].SumOutput;
                                        } else {
                                            uph = data.Series[data.Axis.indexOf(p.name)][p.seriesName].StandardCapacity;
                                            ouput = data.Series[data.Axis.indexOf(p.name)][p.seriesName].SumOutput;
                                        }
                                        return ouput >= uph ? "#008100" : "#e13934";
                                    }
                                }
                            }
                        });
                        option4.series.push({
                            name: data.Series[0][i].ItemName,
                            type: 'line',
                            yAxisIndex: 1,
                            data: arrRate,
                            itemStyle: {
                                normal: {
                                    color: "#447DFE",
                                    label: {
                                        show: true,
                                        formatter: '{c}%',
                                        textStyle: {
                                            color: '#fff'
                                        }
                                    }
                                }
                            }
                        });
                    }
                  
                    option4.yAxis[1].max = maxRate;
                    echart4.setOption(option4);

                    clearTimeout(uphTimeout);
                    var uphTimeout = setTimeout("initProductionUPH()", timeInterval);
                }
            });
        }


        var lineId, lineName, welcomeMsg;
        $(document).ready(function () {
            /*设置title*/
            lineId = getQueryString("lineId");
            lineName = getQueryString("lineName");
            welcomeMsg = "";
            $("#_left_top_title").html(lineName + "生产日看板");

            getWelcome();
            getLineInfo();
            initProductionUPH();
            initProductionData();
        });

        function getWelcome() {
            //if (welcomeMsg == "") {
                welcomeMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(-1, lineId,1).value;
            //}

            $("#dateAndWeek").html(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value);
            $("#_left_top_welcome_text").html(welcomeMsg);

            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 1);
        }

        function getLineInfo() {

            var ajaxResult = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetLineInfoLineID(lineId);
            if (ajaxResult.error != null) { return false; }

            $("#tdLineName").html(ajaxResult.value.LineName);
            $("#tdPrincipal").html(ajaxResult.value.PrincipalName);
            $("#tdStandardHuman").html(ajaxResult.value.StandardHuman);
            $("#tdActualNumber").html(ajaxResult.value.ActualNumber);
            $.ajax({
                type: 'GET',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                data: { 'Type': 'Refresh', 'UserId': ajaxResult.value.Principal },
                dataType: 'text',
                success: function (data) {
                    $("#imgPortraits").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                    clearTimeout(lineInfoTimeout);
                    var lineInfoTimeout = setTimeout("getLineInfo()", timeInterval);
                },
                error: function () {
                    return false;
                }
            });
            }

            function initProductionData() {
                $("#data_tbody tbody").html("");

                $.ajax({
                    type: 'POST',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SMTLineProduction.ashx',
                    data: { 'Type': 'ProductionData', 'LineId': lineId, 'WorkshopId': -1 },
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

                        /*UPPH(当前实际产出/实到人数/生产总时H)*/
                        var actualNumber = parseInt($("#tdActualNumber").html());
                        //var sumDiffHour = data.SumDiffSecond * 60 * 60;
                        if (actualNumber > 0 && actualNumber != "NaN") {
                            $("#tdUPPH").html(data.UPPH);
                        } else {
                            $("#tdUPPH").html("0");
                        }

                       

                        ResizeAll();

                        initEcharts(data);
                    }
                });
                clearTimeout(ProductionDataTimeout);
                var ProductionDataTimeout = setTimeout("initProductionData()", timeInterval);
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
            <tr>
                <td valign="top" style="border-right: 5px solid #041622;">
                    <table id="_layout_left_table">
                        <tr style="height: 9%; background-color: #0D213A;">
                            <td>
                                <table style="width: 100%;" cellpadding="5" cellspacing="5" border="0">
                                    <tr>
                                        <td id="_left_top_welcome">
                                            <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                                scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                    <div id="_left_top_welcome_text" style=" padding-top:5px; padding-bottom:5px;">
                                    </div>
                                </marquee>
                                        </td>
                                    </tr>
                                    <tr style="margin-top: 2px;">
                                        <td align="center">
                                            <div id="_left_top_title" style="float: inherit; margin-bottom: 10px;">-</div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 90%;">
                            <td valign="top">
                                <div style="width: 100%; height: 100%; background-color: #041622; border-top: 5px solid #041622;">
                                    <div style="height: 30%; background-color: #0E223B; display: table; width: 100%;">
                                        <div style="display: table-cell; width: 100%; vertical-align: middle;">
                                            <table id="data_thead" style="width: 98%; height: 16%; margin: 0 auto; font-size: 21px;">
                                                <tbody>
                                                    <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
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
                                                    <table id="data_tbody" style="width: 98%; color: #4EC9CE; border-left: 1px solid #263C54; border-right: 1px solid #263C54; margin: 0 auto; font-size: 21px;">
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <table id="data_tfoot" style="height: 15%; width: 98%; margin: 0 auto; font-size: 21px;">
                                                <tbody>
                                                    <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
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
                                    <div style="height: 28%;background-color: #0E223B; padding-top: 15px; border-top: 5px solid #041622;">
                                        <div style="float: left;" id="echarts_gauge1" class="gauge">
                                        </div>
                                        <div style="float: left;" id="echarts_gauge2" class="gauge">
                                        </div>
                                        <div style="float: right;" id="echarts_gauge3" class="gauge">
                                        </div>
                                        <div style="clear:both;"></div>
                                    </div>
                                    <div style="clear: both; height: 39%; background-color: #0E223B; border-top: 5px solid #041622;">
                                        <div id="echarts_uph" style="height: 100%;">
                                        </div>
                                    </div>
                                </div>

                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="width: 250px;">
                    <table>
                        <tr style="height: 9%;">
                            <td>
                                <div class="logo_skt" style="height: 100%;"></div>
                            </td>
                        </tr>
                        <tr style="height: 90%;">
                            <td valign="top">
                                <div style="width: 100%; height: 40px; padding-top: 3px; padding-bottom: 3px; line-height: 36px; background-color: #0E223B; text-align: center; font-weight: bold; color: #3CA2B0; font-size: 19px; border-bottom: 1px solid #265171; border-top: 5px solid #041622; white-space: nowrap;" id="dateAndWeek"></div>
                                <div id="lineInfo" style="background-color: #0E223B; height: 26.5%;">
                                    <ul>
                                        <li>工序段</li>
                                        <li id="tdLineName" ></li>
                                    </ul>
                                    <ul>
                                        <li>标准人数</li>
                                        <li id="tdStandardHuman"></li>
                                    </ul>
                                    <ul>
                                        <li>实到人数</li>
                                        <li id="tdActualNumber"></li>
                                    </ul>
                                    <ul>
                                        <li>UPPH</li>
                                        <li id="tdUPPH"></li>
                                    </ul>
                                </div>
                                <div id="picInfo" style="clear: both; height: 48%; background-color: #0E223B; border-top: 5px solid #041622;">
                                    <table>
                                        <tr style="height:55px">
                                            <td style="text-align: center;">线体负责人(<span id="tdPrincipal"></span>)</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100%; text-align: center;">
                                                <img src="../../Content/images/portraits/508.jpg" id="imgPortraits" style="width: 90%;height:82%;max-height:250px"
                                                    alt="头像" title="头像" /></td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="clear: both; height: 18%; " class="logo_cus">
                                </div>
                            </td>
                        </tr>
                    </table>


                </td>
            </tr>
        </table>
        <script type="text/javascript">
           $(function () {
               scrollOverflow();
               $(window).resize(function () {
                   scrollOverflow();
               })
           });

           function scrollOverflow() {
               $('li.marquee').each(function () {
                   if (this.offsetWidth + 5 < this.scrollWidth)
                       $(this).html('<marquee style="padding:0;margin:0px; margin-bottom:-20px; " behavior="alternate" direction="left" scrolldelay="20" scrollamount="1"  onmouseover="this.stop()" onmouseout="this.start()">' + this.innerHTML + '</marquee>');

               });
           }
        </script>
    </form>
</body>
</html>
