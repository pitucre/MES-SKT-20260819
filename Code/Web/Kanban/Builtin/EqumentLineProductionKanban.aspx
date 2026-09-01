<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EqumentLineProductionKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.EqumentLineProductionKanban" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>注塑机台看板</title>
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
            font-size: 20px;
            overflow: hidden;
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

        /* 轮播容器样式 */
        .carousel-wrapper {
            position: relative;
            background-color: #0E223B;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            height: 100%;
            overflow: hidden;
        }

        #dataCarousel {
            position: relative;
            height: 100%;
        }

        /* 数据行幻灯片样式 */
        .data-slide {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            transform: translateX(100%);
            transition: all 0.5s ease-in-out;
        }

            .data-slide.active {
                opacity: 1;
                transform: translateX(0);
                z-index: 10;
            }

            .data-slide.prev {
                opacity: 0;
                transform: translateX(-100%);
            }

        /* 数据网格样式 */
        .data-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
            height: 100%;
        }

        @media (max-width: 768px) {
            .data-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .data-grid {
                grid-template-columns: 1fr;
            }
        }

        .data-item {
            padding: 10px;
            text-align: center;
            white-space: nowrap;
        }

        .data-label {
            font-size: 0.8em;
            margin-top: 25px;
        }

        .data-value {
            font-size: 1em;
            font-weight: 500;
        }

        .performance {
            grid-column: 1 / -1;
            padding: 10px;
        }

        .performance-value {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 500;
        }

        .performance-excellent {
            background-color: #e6f4ea;
            color: #137333;
        }

        .performance-good {
            background-color: #e8f0fe;
            color: #0d47a1;
        }

        /* 控制按钮样式 */
        .control-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            transition: background-color 0.3s;
            z-index: 20;
        }

            .control-btn:hover {
                background-color: #0056b3;
            }

        /* 指示器样式 */
        .indicators {
            position: absolute;
            bottom: 15px;
            left: 0;
            right: 0;
            display: flex;
            justify-content: center;
            gap: 8px;
            z-index: 20;
        }

        .indicator-btn {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: #ccc;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }

            .indicator-btn.active {
                background-color: #007bff;
                width: 24px;
            }

        .hide {
            display: none;
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
        var option1, option2, option3, option4, echart1, echart2, echart3;
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
                        formatter: "工单生产进度 {value}%",
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
                        formatter: "生产良率 {value}%",
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
                        formatter: "稼动率 {value}%",
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
        function isInArray2(arr, value) {
            var index = $.inArray(value, arr);
            if (index >= 0) {
                return true;
            }
            return false;
        }
        function formatterTip(params) {


            var tip = '';
            for (var i = 0; i < params.length; i++) {//这里是自己定义样式， params[i].marker 表示是否显示左边的那个小圆圈


                if (isInArray2(legends, params[i].seriesName)) {
                    var lineType = params[i].seriesType;

                    if (lineType == 'line') {
                        tip = tip + params[i].marker + params[i].seriesName + ':' + params[i].value + '(达成率)<br/>----------------------<br/>';
                    }
                    else {
                        tip = tip + params[i].marker + params[i].seriesName + ':' + params[i].value + '(当前产能)<br/>';
                    }


                }
            }

            return tip;
        }


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
            value = data.length > 0 ? data[0].myProdRate1 : 0;
            option1.series[0].max = getGaugeMaxVal(value);
            option1.series[0].data[0].value = value;
            echart1.setOption(option1, true);

            /*IE效率(总瓶颈工时*产出/(生产总时-异常工时)*100%)*/
            //value = data.SumDiffSecond - data.SumAbnormalTime;
            //value = (value > 0 ? data.SumBottleneckHours * data.SumOutput / value * 100 : 0).toFixed(2);

            value = data.length > 0 ? data[0].myProdRate2 : 0;
            option2.series[0].max = getGaugeMaxVal(value);
            option2.series[0].data[0].value = value;
            echart2.setOption(option2, true);

            /*直通率(白板数/总产出*100%)*/
            //value = (data.SumOutput > 0 ? data.NoDefects / data.SumOutput * 100 : 0).toFixed(2);
            value = data.length > 0 ? data[0].myProdRate3 : 0;
            option3.series[0].max = getGaugeMaxVal(value);
            option3.series[0].data[0].value = value;
            echart3.setOption(option3, true);
        }



        var lineId, lineName, welcomeMsg;
        $(document).ready(function () {
            /*设置title*/
            lineId = getQueryString("lineId");
            lineName = getQueryString("lineName");
            welcomeMsg = "";
            $("#_left_top_title").html(lineName + "机台看板");

            getWelcome();
            getLineInfo();
            initProductionData();
        });

        function getWelcome() {
            //if (welcomeMsg == "") {
            welcomeMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(-1, -1, 31).value;
            //}

            $("#dateAndWeek").html(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value);
            $("#_left_top_welcome_text").html(welcomeMsg);

            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 1);
        }

        function getLineInfo() {

            //var ajaxResult = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetLineInfoLineID(lineId);
            //if (ajaxResult.error != null) { return false; }
            var info = { LineID: lineId };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetLineUserImgInfo", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#tdLineName").html(listOrder[0].LineName);
            $("#tdPrincipal").html(listOrder[0].PrincipalNameB);
            $("#tdPrincipal2").html(listOrder[0].PrincipalNameW);
            //$("#tdStandardHuman").html(ajaxResult.value.StandardHuman);
            $("#lblLineUserCount").text(listOrder[0].StandardHuman);
            //$("#tdActualNumber").html(ajaxResult.value.ActualNumber);
            $.ajax({
                type: 'GET',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                data: { 'Type': 'Refresh', 'UserId': listOrder[0].PrincipaB },
                dataType: 'text',
                success: function (data) {
                    $("#imgPortraits").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                },
                error: function () {
                    return false;
                }
            });
            $.ajax({
                type: 'GET',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                data: { 'Type': 'Refresh', 'UserId': listOrder[0].PrincipaW },
                dataType: 'text',
                success: function (data) {
                    $("#imgPortraits2").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                },
                error: function () {
                    return false;
                }
            });
            clearTimeout(lineInfoTimeout);
            var lineInfoTimeout = setTimeout("getLineInfo()", timeInterval);
        }

        function initProductionData() {
            $("#data_tbody tbody").html("");
            var info = { LineID: lineId };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetLinkoEqumentLineProductionKanbanApplyInfo", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            if (typeof (list.data1) !== "undefined") {
                Slide(list.data1);
            }
            for (var i = 0; i < listOrder.length; i++) {
                var myi = i + 1;
                $("<tr class='rows'>" +
                    "<td width='5%'>" + myi + "</td>" +
                    "<td width='20%'>" + listOrder[i].GRN + "</td>" +
                    "<td width='5%'>" + listOrder[i].BalanceQty + "</td>" +
                    "<td width='20%'>" + listOrder[i].MaterialBucketCode + "</td>" +
                    "<td width='25%'>" + listOrder[i].ItemCode + "</td>" +
                    "<td width='30%'>" + listOrder[i].ItemName + "</td></tr>").appendTo($("#data_tbody tbody"));
            }
            if (listOrder.length > 0) {
                $("#lblOrderNo").text(listOrder[0].myOrderNo);
                $("#lblMouldCode").text(listOrder[0].myMouldCode);
                $("#lblItemCode").text(listOrder[0].ItemCode);
                //$("#lblDrawingNo").text(listOrder[0].myDrawingNo);
                $("#lblItemName").text(listOrder[0].ItemName);
                //$("#lblProdCycle").text(listOrder[0].myProdCycle);
                $("#lblMouldCavity").text(listOrder[0].Cavity);
                $("#lblOrderQty").text(listOrder[0].myOrderQty);
                $("#lblNowDoneQty").text(listOrder[0].myNowDoneQty);
                //$("#lblProdCycle2").text(listOrder[0].myProdCycle);
                $("#lblOrderNotQty").text(listOrder[0].myOrderNotQty);
                $("#lblOrderDoneQty").text(listOrder[0].myOrderDoneQty);
                //$("#lblNextOrderNo").text(listOrder[0].NextOrderNo);
                //$("#lblNextMouldCode").text(listOrder[0].NextMouldCode);
                //$("#lblNextOrderQty").text(listOrder[0].NextOrderQty);
                //$("#lblNextMouldColor").text(listOrder[0].NextMouldColor);
                //$("#lblNextMouldYLCZ").text(listOrder[0].NextMouldYLCZ);
            }
            ResizeAll();
            initEcharts(listOrder);
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
    <script type="text/javascript">

        function Slide(rowData) {

            const carousel = document.getElementById('dataCarousel');
            let currentIndex = 0;
            let isPlaying = true;
            let interval;
            const slideCount = rowData.length;

            // 初始化轮播
            function initCarousel() {
                // 清空容器
                carousel.innerHTML = '';

                // 动态生成数据行和指示器
                rowData.forEach((item, index) => {
                    // 创建数据行幻灯片
                    const slide = document.createElement('div');
                    slide.className = 'data-slide' + (index === 0 ? ' active' : '');

                    // 构建数据网格
                    slide.innerHTML = `
                     <div class="data-grid">
                         <div class="data-item">
                             <div class="data-label">工单号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: forestgreen;">${item.OrderNO}</span></div>
                         </div>
                         <div class="data-item">
                             <div class="data-label">产品编码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: forestgreen;">${item.ItemCode}</span></div>
                         </div>
                         <div class="data-item">
                             <div class="data-label">产品名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: forestgreen;">${item.ItemName}</span></div>
                         </div>
                         <div class="data-item">
                             <div class="data-label">工单计划开始时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: forestgreen;">${item.Planned_Start_Time}</span></div>
                         </div>
                         <div class="data-item">
                             <div class="data-label">工单计划生产数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: forestgreen;">${item.Qty_to_Build}</span></div>
                         </div>
                     </div>
                 `;
                    carousel.appendChild(slide);
                });

                // 启动自动播放
                startAutoPlay();
            }

            // 切换到指定幻灯片
            function goToSlide(index) {
                // 移除所有幻灯片的活动状态
                const slides = document.querySelectorAll('.data-slide');
                slides.forEach(slide => {
                    slide.classList.remove('active', 'prev');
                });

                // 更新当前索引
                currentIndex = (index + slideCount) % slideCount;

                // 设置当前幻灯片为活动状态
                slides[currentIndex].classList.add('active');

                // 设置上一张幻灯片的状态（用于动画效果）
                const prevIndex = (currentIndex - 1 + slideCount) % slideCount;
                slides[prevIndex].classList.add('prev');

                // 更新指示器状态
                const indicatorBtns = document.querySelectorAll('.indicator-btn');
                indicatorBtns.forEach((btn, i) => {
                    btn.classList.toggle('active', i === currentIndex);
                });
            }

            // 下一张幻灯片
            function nextSlide() {
                if (slideCount > 1) {
                    goToSlide(currentIndex + 1);
                }
            }

            // 上一张幻灯片
            function prevSlide() {
                if (slideCount > 1) {
                    goToSlide(currentIndex - 1);
                }
            }

            // 开始自动播放
            function startAutoPlay() {
                interval = setInterval(nextSlide, 5000); // 每5秒切换一次
            }

            // 停止自动播放
            function stopAutoPlay() {
                clearInterval(interval);
            }

            // 鼠标悬停时暂停，离开时继续
            carousel.addEventListener('mouseenter', () => {
                if (isPlaying) {
                    stopAutoPlay();
                }
            });

            carousel.addEventListener('mouseleave', () => {
                if (isPlaying) {
                    startAutoPlay();
                }
            });

            // 初始化轮播
            if (slideCount > 0) {
                initCarousel();
            }
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
                                                <div id="_left_top_welcome_text" style="padding-top: 5px; padding-bottom: 5px;">
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
                                    <div style="height: 15%; clear: both; background-color: #0E223B; border-top: 1px solid #041622;">
                                        <div style="width: 100%;">
                                            <table style="width: 98%; height: 16%; margin: 0 auto; font-size: 21px;">
                                                <tr>
                                                    <td colspan="8" style="height: 20px;"></td>
                                                </tr>
                                                <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                    <td style="width: 8%;">工单号</td>
                                                    <td style="color: forestgreen; width: 18%;">
                                                        <label id="lblOrderNo"></label>
                                                    </td>
                                                    <td style="width: 8%;">模具编码</td>
                                                    <td style="color: forestgreen; width: 20%;">
                                                        <label id="lblMouldCode"></label>
                                                    </td>
                                                    <td style="width: 8%; display: none">旧料号</td>
                                                    <td style="color: forestgreen; width: 20%; display: none">
                                                        <label id="lblDrawingNo"></label>
                                                    </td>
                                                    <td style="width: 5%;">工序</td>
                                                    <td style="color: forestgreen; width: 8%;">注塑</td>
                                                    <td style="width: 5%; display: none">损耗率</td>
                                                    <td style="color: forestgreen; width: 8%; display: none">3%</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="8" style="height: 20px;"></td>
                                                </tr>
                                                <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                    <td>产品编码</td>
                                                    <td style="color: forestgreen;">
                                                        <label id="lblItemCode"></label>
                                                    </td>
                                                    <td>产品名称</td>
                                                    <td style="color: forestgreen;" colspan="8">
                                                        <label id="lblItemName"></label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div style="height: 25%; background-color: #0E223B; display: table; width: 100%;">
                                        <div style="display: table-cell; width: 100%; vertical-align: middle;">
                                            <table id="data_thead" style="width: 98%; height: 16%; margin: 0 auto; font-size: 21px;">
                                                <tbody>
                                                    <%-- <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                        <th width="5%">序号
                                                        </th>
                                                        <th width="40%">物料编码
                                                        </th>
                                                        <th width="55%">物料名称
                                                        </th>
                                                    </tr>--%>
                                                    <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                        <th width="5%">序号
                                                        </th>
                                                        <th width="20%">物料条码
                                                        </th>
                                                        <th width="5%">物料余量
                                                        </th>
                                                        <th width="20%">关联料桶
                                                        </th>
                                                        <th width="25%">物料编号
                                                        </th>
                                                        <th width="30%">物料名称
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
                                        </div>
                                    </div>
                                    <div style="height: 20%; clear: both; background-color: #0E223B; border-top: 1px solid #041622;">
                                        <div style="width: 100%; vertical-align: middle;">
                                            <table style="width: 98%; height: 16%; margin: 0 auto; font-size: 21px;">
                                                <tr>
                                                    <td colspan="8" style="height: 20px;"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="8" style="font-size: 25px;">生产信息</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="8" style="height: 20px;"></td>
                                                </tr>
                                                <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                    <td style="width: 8%; display: none">标准周期</td>
                                                    <td style="color: forestgreen; width: 17%; display: none">
                                                        <label id="lblProdCycle"></label>
                                                    </td>
                                                    <td style="width: 8%;">标准模穴数</td>
                                                    <td style="color: forestgreen; width: 17%;">
                                                        <label id="lblMouldCavity"></label>
                                                    </td>
                                                    <td style="width: 8%;">工单总数量</td>
                                                    <td style="color: forestgreen; width: 17%;">
                                                        <label id="lblOrderQty"></label>
                                                    </td>
                                                    <td style="width: 8%;">当天生产数</td>
                                                    <td style="color: forestgreen; width: 17%;">
                                                        <label id="lblNowDoneQty"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="8" style="height: 20px;"></td>
                                                </tr>
                                                <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                    <td style="display: none">实际周期</td>
                                                    <td style="color: forestgreen; display: none">
                                                        <label id="lblProdCycle2"></label>
                                                    </td>
                                                    <td style="display: none">标准人力</td>
                                                    <td style="color: forestgreen; display: none">
                                                        <label id="lblLineUserCount"></label>
                                                    </td>
                                                    <td>工单欠数</td>
                                                    <td style="color: forestgreen;">
                                                        <label id="lblOrderNotQty"></label>
                                                    </td>
                                                    <td>累计生产数</td>
                                                    <td style="color: forestgreen;">
                                                        <label id="lblOrderDoneQty"></label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div style="height: 28%; background-color: #0E223B; padding-top: 15px; border-top: 5px solid #041622;">
                                        <div style="float: left;" id="echarts_gauge1" class="gauge">
                                        </div>
                                        <div style="float: left;" id="echarts_gauge2" class="gauge">
                                        </div>
                                        <div style="float: right;" id="echarts_gauge3" class="gauge">
                                        </div>
                                    </div>
                                    <div style="height: 8%; clear: both; background-color: #0E223B; border-top: 1px solid #041622;">
                                        <%--<table style="width: 98%; height: 16%; margin: 0 auto; font-size: 21px;">
                                                <tr>
                                                    <td colspan="8" style="height: 20px;"></td>
                                                </tr>
                                                <tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">
                                                    <td style="width: 10%;">下一计划>></td>
                                                    <td style="width: 25%;">工单号：<label style="color: forestgreen;" id="lblNextOrderNo"></label></td>
                                                    <td style="width: 25%;">模具编码：<label style="color: forestgreen;" id="lblNextMouldCode"></label></td>
                                                    <td style="width: 12%;">数量：<label style="color: forestgreen;" id="lblNextOrderQty"></label></td>
                                                    <td style="width: 13%;">颜色：<label style="color: forestgreen;" id="lblNextMouldColor"></label></td>
                                                    <td style="width: 15%;">原料材质：<label style="color: forestgreen;" id="lblNextMouldYLCZ"></label></td>
                                                </tr>
                                            </table>--%>
                                        <div class="carousel-wrapper">
                                            <div id="dataCarousel">
                                                <!-- 数据行将通过JS动态生成 -->
                                            </div>

                                            <!-- 指示器 -->
                                            <div class="indicators hide" id="indicators">
                                                <!-- 指示器将通过JS动态生成 -->
                                            </div>
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
                                <div class="logo_cus" style="height: 100%;"></div>
                            </td>
                        </tr>
                        <tr style="height: 90%;">
                            <td valign="top">
                                <div style="width: 100%; height: 40px; padding-top: 3px; padding-bottom: 3px; line-height: 36px; background-color: #0E223B; text-align: center; font-weight: bold; color: #3CA2B0; font-size: 19px; border-bottom: 1px solid #265171; border-top: 5px solid #041622; white-space: nowrap;" id="dateAndWeek"></div>
                                <div id="lineInfo" style="background-color: #0E223B; height: 5%;">
                              <%--      <ul>
                                        <li>工序段</li>
                                        <li id="tdLineName"></li>
                                    </ul>--%>
                                    <%--<ul>
                                        <li>标准人数</li>
                                        <li id="tdStandardHuman"></li>
                                    </ul>
                                    <ul>
                                        <li>实到人数</li>
                                        <li id="tdActualNumber"></li>
                                    </ul>--%>
                                </div>
                                <div id="picInfo" style="clear: both; height: 37.5%; background-color: #0E223B; border-top: 5px solid #041622;">
                                    <table>
                                        <tr style="height: 55px">
                                            <td style="text-align: center;">A班负责人(<span id="tdPrincipal"></span>)</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100%; text-align: center;">
                                                <img src="../../Content/images/portraits/508.jpg" id="imgPortraits" style="width: 90%; height: 92%; max-height: 250px"
                                                    alt="头像" title="头像" /></td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="picInfo2" style="clear: both; height: 37%; background-color: #0E223B; border-top: 5px solid #041622;">
                                    <table>
                                        <tr style="height: 55px">
                                            <td style="text-align: center;">B班负责人(<span id="tdPrincipal2"></span>)</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100%; text-align: center;">
                                                <img src="../../Content/images/portraits/508.jpg" id="imgPortraits2" style="width: 90%; height: 92%; max-height: 250px"
                                                    alt="头像" title="头像" /></td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="clear: both; height: 13%;" class="logo_skt">
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
