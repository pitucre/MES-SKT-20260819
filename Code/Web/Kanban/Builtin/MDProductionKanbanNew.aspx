<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MDProductionKanbanNew.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.MDProductionKanbanNew" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>注 塑 综 合 看 板</title>
     <meta http-equiv="refresh" content="7200">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/chalk.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <style type="text/css">
         .show {
            display: block;
            
        }

        .hidden {
            display: none;
        }
        .rowsTd1 {
            font-size: 38px;
            /*color: #32E0E7;*/
        }

        .rowsTdBlue {
            color: #32E0E7;
        }
          .rowsTdYellow {
            color: #F1CB52;
        }
        .rowsTdGray {
            color: gray;
            /*background-color:gray;*/
        }

        .div2 {
            float: left;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            text-align: center;
            line-height: 20px;
            margin: 5px;
            font-size: 22px;
            font-weight: 600;
            border: 2px solid #32E0E7;
        }

        .div1 {
            float: left;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            text-align: center;
            line-height: 40px;
            margin: 5px;
            font-size: 22px;
            font-weight: 600;
            border: 2px solid #32E0E7;
        }

        .BGreen {
            /*运行*/
            background-color: #3F9F00;
        }

        .BBlue {
            background-color: #5470c6;
        }

        .BGray {
              /*停机*/
            background-color: #C80404;
        }

        .BRed {
            /*检修*/
            background-color: #DB6200;
        }

        .BYellow {
            /*待料*/
            background-color: #FF00FF;
        }

        html,
        body {
            width: 100%;
            height: 100%;
            margin: 0px;
            padding: 0px;
            border: 0px;
            font-family: Arial, "Helvetica Neue", "Microsoft Yahei", sans-serif;
            color: #E6E6E6;
            background-color: #041622;
            font-size: 20px;
            overflow: hidden;
        }

        .logo_cus {
            background: url('../../Content/images/logo/DQClogo.png') no-repeat 28px center;
            background-size: 180px 72px;
            background-color: #0D213A;
        }

        .logo_skt {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center center;
            background-size: 93%;
            background-color: #0D213A;
        }

        #_left_top_title {
            height: 100%;
            font-size: 30px;
            text-align: center;
            color: #E6E6E6;
            margin-left: 90px;
            font-weight: 600;
            margin-top: 20px;
        }

        #_left_top_welcome {
            height: 100%;
            font-size: 1.7em;
            color: Red;
        }

        #dateAndWeek {
            width: 13%;
            height: 100%;
            font-size: 1.5em;
            text-align: center;
        }

        table {
            width: 100%;
            height: 100%;
            border-collapse: 0px;
            border-spacing: 0px;
            padding: 0px;
            margin: 0px;
        }

            table td,
            table th {
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
            border-bottom: px solid #263C54;*/
        }

        #data_thead th, #data_tbody td, #data_tfoot td {
            text-align: center;
            font-size: 0.5em;
            /*width: 7%;*/
            border-top: 1px solid #263C54;
            /*border-left: 1px solid #c5c5c5;*/
            border-bottom: 1px solid #263C54;
        }
        #data_tbody td{
            font-size:.45em;
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
    <%--滚动设置--%>
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
        var scrollIntervalId;
        function _InitScroll(_S1, _S2, _W, _H, _T) {
            if (isScroll) {
                return false;
            }
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
            init_srolltext(_T);
        }

        function init_srolltext(_T) {
            scrollElem.scrollTop = 0;
            scrollIntervalId = setInterval('scrollUp()', _T); //滚动速度
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

        var timeInterval = 1000 * 60 * 5;

        $(window).resize(function () {
            ResizeAll(150);
            if (echart1 != null) {
                echart1.resize();
            }
            if (echart2 != null) {
                echart2.resize();
            }
            if (echart3 != null) {
                echart3.resize();
            }
            // if (echart4 != null) { echart4.resize(); }
            if (echart5 != null) {
                echart5.resize();
            }
        });

        function ResizeAll(_T) {
            clearInterval(scrollIntervalId);
            //某些浏览器不兼容div自适应高度
            $(".gauge").height($(window).height() * 0.9 * 0.26);
            var _contentHeight = $(window).height() * 0.9 * 0.75;
            $("#buttomTop5").height($(window).height() * 0.9 * 0.1);
            $("#_layout_left_data_div_tbody").css("height", "auto");
            $(".rows").height(_contentHeight * 0.08)
            //alert("$(.rows).length:"+$(".rows").length +"; _contentHeight:"+_contentHeight);
            // if ($(".rows").length * 50 > _contentHeight) {
            // alert($(".rows").length);
            $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);
            if ($(".rows").length>8) {
               // $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);
                _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody",   $("#_layout_left_data_div2_tbody").width(), 150, _T);
               // isScroll = true;
            }

        }
    </script>
    <%--图表设置--%>
    <script type="text/javascript">
        var color = ["#C23531", "#E67716", "#FF69B4", "#DDA0DD", "#FF00FF", "#9400D3", "#8A2BE2"];
        option1 = {
            series: [{
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '120%',
                min: 0,
                max: 100,
                splitNumber: 4,
                axisLine: { // 坐标轴线  
                    lineStyle: { // 属性lineStyle控制线条样式  
                        color: [
                            [0.2, '#447DFF'],
                            [0.8, '#32E0E7'],
                            [1, '#447DFE']
                        ],
                        width: 20,
                        shadowColor: '#fff', //默认透明
                        shadowBlur: 2
                    }
                },
                axisLabel: {
                    show: true,
                    fontSize: 18,
                    formatter: function (value) {
                        return parseInt(value) + "%";
                    }
                },
                detail: {
                    formatter: "工单完成率：{value}%",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#E6E6E6',
                        fontSize: 22
                    }
                },
                data: [{
                    value: 0.86
                }]
            }],
            tooltip: {}
        };
        option2 = {
            series: [{
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '120%',
                min: 0,
                max: 100,
                splitNumber: 4,
                axisLine: { // 坐标轴线  
                    lineStyle: { // 属性lineStyle控制线条样式  
                        color: [
                            [0.2, '#F14842'],
                            [0.8, '#F1CB52'],
                            [1, '#1EB950']
                        ],
                        width: 20,
                        shadowColor: '#fff', //默认透明
                        shadowBlur: 2
                    }
                },
                axisLabel: {
                    show: true,
                    fontSize: 18,
                    formatter: function (value) {
                        return parseInt(value) + "%";
                    }
                },
                detail: {
                    formatter: "稼动率 {value}%",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#E6E6E6',
                        fontSize: 22
                    }
                },
                data: [{
                    value: 86
                }]
            }],
            tooltip: {

            }
        };
        option3 = {
            series: [{
                startAngle: 180,
                endAngle: 0,
                type: 'gauge',
                center: ['50%', '75%'],
                radius: '120%',
                min: 0,
                max: 100,
                splitNumber: 4,
                axisLine: { // 坐标轴线  
                    lineStyle: { // 属性lineStyle控制线条样式  
                        color: [
                            [0.2, '#447DFF'],
                            [0.8, '#32E0E7'],
                            [1, '#447DFE']
                        ],
                        width: 20,
                        shadowColor: '#fff', //默认透明
                        shadowBlur: 2
                    }
                },
                axisLabel: {
                    show: true,
                    fontSize: 18,
                    formatter: function (value) {
                        return parseInt(value) + "%";
                    }
                },
                detail: {
                    formatter: "合格率 {value}%",
                    offsetCenter: [0, '20%'],
                    textStyle: {
                        color: '#E6E6E6',
                        fontSize: 22
                    }
                },
                data: [{
                    value: 100
                }]
            }],
            tooltip: {

            }
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

        function initProductionTop5NC(Axis, Series) {




            option5 = {
                backgroundColor: '', //设置无背景色  
                xAxis: {
                    type: 'category',
                    data: Axis,//['批锋', '混色色点', '脱模不良', '尺寸问题', '缩水'],
                    axisLabel: {
                        textStyle: {
                            color: '#fff', //坐标值得具体的颜色
                            fontSize: 15,
                            fontFamily: 'Arial'
                        }
                    },
                },
                yAxis: {
                    type: 'value',
                    axisLabel: {
                        textStyle: {
                            color: '#fff', //坐标值得具体的颜色
                            fontSize: 16,
                            fontFamily: 'Arial'
                        }
                    },
                    splitLine: { //网格线
                        show: true
                    }

                },
                series: [{
                    data: Series, //[300, 200, 150, 80, 70],
                    type: 'bar',
                    barWidth: 60, //宽度
                    label: {
                        show: false,
                        color: '#fff',
                        fontSize: 22,
                        fontFamily: 'Arial'
                    },
                    itemStyle: {
                        normal: {
                            color: function (p) {
                                return color[p.dataIndex];
                            }
                        }
                    }
                }]
            };

            //echart5.clear();
            echart5.setOption(option5);

        }
    </script>
    <%--加载数据--%>
    <script type="text/javascript">
        var workshopId, workshopName, welcomeMsg;
        $(document).ready(function () {
            /*设置title*/
            workshopId = getQueryString("workshopId");
            workshopName = getQueryString("workshopName");
            welcomeMsg = "";

            // $("#_left_top_title").html(workshopName + "生产状况综合日看板");
            //$("#_left_top_title").html("INJECTION 综 合 看 板");
            ResizeAll(150);

            /*注册ECHARTS*/
            echart1 = echarts.init(document.getElementById('echarts_gauge1'));
            echart2 = echarts.init(document.getElementById('echarts_gauge2'));
            echart3 = echarts.init(document.getElementById('echarts_gauge3'));
            // echart4 = echarts.init(document.getElementById('echarts_uph'));
            echart5 = echarts.init(document.getElementById("echarts_top5nc"), "dark");

            getWelcome();
            //initProductionTop5NC();
            initProductionData();
        });

        function getWelcome() {
            //if (welcomeMsg == "") {
            //   welcomeMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(workshopId, -1,2).value;
            //}
            var NowTime = $.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value);
            // alert(NowTime);
            $("#dateAndWeek").html(NowTime);
            // $("#_welcome_text").html(welcomeMsg);

            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 1);
        }

        //加载数据
        function initProductionData() {
            //=======================加载列表数据==================================
            $("#data_tbody tbody").html("");
            try
            {
                debugger
                var entity = {};
                entity.result = '1';
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("udpKanBanData_MDProductionKanban_Data", JSON.stringify(entity));
               // console.debug(ajax);
                if (ajax.error != null) {
                    $("<tr class='rows rowsTd1'><td colspan='10' height='200px' style='font-size: 50px;color: #E6E6E6;border-bottom: 1px solid #263C54;'>" + ajax.error.Message + " </br>请联系MES运维人员!</td></tr>").appendTo($("#data_tbody tbody "));
                    //滚动
                    ResizeAll(100); echart5.resize();
                    setTimeout("initProductionData()", 1000 * 30 * 1);
                    return;
                }
                if (ajax.value.length <= 0) {
                    $("<tr class='rows rowsTd1'><td colspan='10' height='200px' style='font-size: 50px;color: #E6E6E6;border-bottom: 1px solid #263C54;'>当前没有任何数据</td></tr>").appendTo($("#data_tbody tbody "));
                    //滚动
                    ResizeAll(100); echart5.resize();
                    setTimeout("initProductionData()", 1000 * 20 * 1);
                    return;
                }

                var dataList = JSON.parse(ajax.value);
                if (dataList[0].length > 0) {
                    var classVal = "";
                    $.each(dataList[0], function () {
                        if (this.Status == "运行") {
                            classVal = " rowsTdBlue ";
                            try {
                                var CompleteDate = Date.parse(this.CompleteDate.replace(/-/g, "/"));
                                var date = new Date();
                                date.setDate(date.getDate() - 1);
                                if (date > CompleteDate) {
                                    classVal = " rowsTdYellow ";
                                }
                            } catch (E) { }
                        } else {

                            classVal = " rowsTdGray ";
                        }
                      
                        $("	<tr class='rows rowsTd1 " + classVal + "'>" +
                            "<td width = '4%' >" + this.ItemCode + "</<td>" + //<!--机台-->  
                            "<td width = '12%' >" + this.MouldCode + "</td> " + //<!--模具号--> 
                            "<td width = '10%' >" + this.PO + "</td> " + //<!--工单单号--> 
                            "<td width = '8%' >" + this.POPC + "</td> " + //<!--工单品号--> 
                        /*    "<td width = '11%' >" + this.OrderNO + "</td> " + //<!--订单单号--> */
                            "<td width = '8%' >" + this.POQty + "</td>  " + //<!--计划数-->
                            "<td width = '9%' >" + this.PassQty + "</td> " + //<!--实际产量--> 
                            "<td width = '10%' >" + this.PassRate + "</td>  " + //<!--机台合格率-->
                            "<td width = '9%' >" + this.ProductionRate + "</td>" + //<!--稼动率-->  
                            "<td width = '10%' >" + this.CompleteDate + "</td> " + //<!--计划完工日--> 
                            "<td >" + this.Status + " </td><!--当前状态-->  " +
                            "</tr> ").appendTo($("#data_tbody tbody "));

                    });

                    /*工单完成率()*/
                    option1.series[0].data[0].value = dataList[1][0].POCompleRate;
                    echart1.setOption(option1, true);
                    /*稼动率()*/
                    option2.series[0].data[0].value = dataList[1][0].CropTurnoverRate;
                    echart2.setOption(option2, true);
                    /*合格率()*/
                    option3.series[0].data[0].value = dataList[1][0].PassRate;
                    echart3.setOption(option3, true);
                } else {
                    //没有数据
                    // $("<tr class='rows rowsTd1'><td colspan='10' height='200px' style='font-size: 50px;color: #E6E6E6;border-bottom: 1px solid #263C54;'>当前没有任何数据</td></tr>").appendTo($("#data_tbody tbody "));
                }

                //================================机台状态数据=====================================
                var msg = "";
                if (dataList[2].length > 0) {
                    for (var i = 0; i < dataList[2].length; i++) {
                        if (dataList[2][i].EquipmentState == "运行")
                            msg += "<div class='div1 BGreen'>" + dataList[2][i].EquipmentName + "</div>";
                        else if (dataList[2][i].EquipmentState == "异常")
                            msg += "<div class='div1 BYellow'>" + dataList[2][i].EquipmentName + "</div>";
                        else if (dataList[2][i].EquipmentState == "保养")
                            msg += "<div class='div1 BBlue'>" + dataList[2][i].EquipmentName + "</div>";
                        else if (dataList[2][i].EquipmentState == "检修")
                            msg += "<div class='div1 BRed'>" + dataList[2][i].EquipmentName + "</div>";
                        else if (dataList[2][i].EquipmentState == "停机")
                            msg += "<div class='div1 BGray'>" + dataList[2][i].EquipmentName + "</div>";
                    }
                } else {
                    //没有机台状态数据
                }

                $("#qiji").html(msg);
                /*=========================Top5不良()=================================================*/
                var Axis = new Array();
                var Series = new Array();
                if (dataList[3].length > 0 && dataList[3][0].Title.length > 0) {
                    $("#echarts_top5nc").removeClass("hidden show");
                    $("#echarts_top5nc").addClass("show");
                    for (var i = 0; i < dataList[3].length; i++) {
                        Axis[i] = dataList[3][i].Title;
                        Series[i] = dataList[3][i].Num;
                    }
                } else {
                    $("#echarts_top5nc").removeClass("hidden show");
                    $("#echarts_top5nc").addClass("hidden");
                }
                initProductionTop5NC(Axis, Series);
                echart5.resize();
                //echart5.setOption(option5);
                if (dataList[1][0].RefreshTime > 0) {
                    setTimeout("initProductionData()", dataList[1][0].RefreshTime);
                }
                //滚动
                ResizeAll(dataList[1][0].scrollUpTime);
            } catch (E) {
                setTimeout("initProductionData()", 1000 * 30 * 1);
            }
        }
        /**
         *   获取URL参数值
         **/
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
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
                                            <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;" scrollamount="3" onmouseover="this.stop();" onmouseout="this.start();">
													<div id="_welcome_text">
													</div>
												</marquee>
                                        </td>
                                        <td id="dateAndWeek" rowspan="2" style="color: #3CA2B0; white-space: nowrap;"></td>
                                        <td class="logo_skt" style="width: 250px; height: 100%;" rowspan="2"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="_left_top_title" style="float: inherit; margin-bottom: 10px;">注 塑  综 合 看 板</div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 88%;">

                            <td style="height: 100%;">

                                <table style="">
                                    <tr style="height: 30%;">
                                        <td style="height: 30%; vertical-align: top;">

                                            <div style="height: 100%; background-color: #0E223B; display: table; width: 100%; border-top: 5px solid #041622;">
                                                <div style="display: table-cell; width: 100%; vertical-align: middle;">
                                                    <table id="data_thead" style="height: 16%; border-left: 1px solid #263C54; font-size: 21px; border-right: 1px solid #263C54; width: 98%; margin: 0 auto;">
                                                        <tbody>
                                                            <tr class="rows" style="font-size: 42px;">
                                                                <th width="4%">机台</th>
                                                                <th width="12%">模具编号</th>
                                                                <th width="10%">工单单号</th>
                                                                <th width="8%">工单品号</th>
                                                        <%--        <th width="11%">订单单号</th>--%>
                                                                <th width="8%">工单数量</th>
                                                                <th width="9%">合格数</th>
                                                                <th width="10%">机台合格率</th>
                                                                <th width="9%">稼动率</th>
                                                                <th width="10%">计划完工日</th>
                                                                <th>当前状态</th>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <div id="_layout_left_data_div_tbody">
                                                        <div id="_layout_left_data_div2_tbody">
                                                            <table id="data_tbody" style="width: 98%; font-size: 22px; color: #4EC9CE; border-left: 1px solid #263C54; border-right: 1px solid #263C54; margin: 0 auto;">
                                                                <tbody>
                                                                    <%--   <tr class='rows rowsTd1'>

                                                                        <td width="4%">M01</td>
                                                                        <!--机台-->
                                                                        <td width="10%">EQ-3TP01176</td>
                                                                        <!--模具号-->
                                                                        <td width="10%">210600456</td>
                                                                        <!--工单单号-->
                                                                        <td width="8%">123456</td>
                                                                        <!--工单品号-->
                                                                        <td width="11%">21C00001602</td>
                                                                        <!--订单单号-->
                                                                        <td width="8%">5000</td>
                                                                        <!--计划数-->
                                                                        <td width="10%">3000</td>
                                                                        <!--实际产量-->
                                                                        <td width="10%">91.1%</td>
                                                                        <!--机台合格率-->
                                                                        <td width="10%">95.2%</td>
                                                                        <!--生产效率-->
                                                                        <td width="10%">2021-09-14</td>
                                                                        <!--计划完工日-->
                                                                        <td>运行</td>
                                                                        <!--当前状态-->
                                                                    </tr>--%>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 100%; text-align: center; background-color: #0E223B; border-top: 3px solid #041622;">
                                            <div style="margin-top: -18px; height: 100%; padding-top: 0px;">
                                                <div style="float: left;" class="gauge" id="echarts_gauge1">
                                                </div>
                                                <div style="float: left;" class="gauge" id="echarts_gauge2">
                                                </div>
                                                <div style="float: right;" class="gauge" id="echarts_gauge3">
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 15%;" id="buttomTop5">
                                        <td style="height: 100%;">
                                            <table style="height: 100%; background-color: #0E223B; border-top: 3px solid #041622; margin-top: -10px;">
                                                <tr>
                                                    <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">

                                                        <div id="echarts_uph" style="height: 100%; padding-top: 15px;">
                                                            <table style="width: 80%; height: 30px; padding-left: 10px; padding-top: 10px;">
                                                                <tr>
                                                                    <td>
                                                                        <div style="padding: 0px; padding-left: 10px; font-size: 25px; font-weight: 600;">机台状态 </div>
                                                                    </td>
                                                                    <td style="text-align: right; width: 20px;">
                                                                        <div class='div2 BGreen'></div>
                                                                    </td>
                                                                    <td style="text-align: left; font-size: 22px; color: #32E0E7;">运行</td>

                                                                    <td style="text-align: right; width: 20px;">
                                                                        <div class='div2 BYellow'></div>
                                                                    </td>
                                                                    <td style="text-align: left; font-size: 22px; color: #32E0E7;">异常</td>

                                                                    <td style="text-align: right; width: 20px;">
                                                                        <div class='div2 BBlue'></div>
                                                                    </td>
                                                                    <td style="text-align: left; font-size: 22px; color: #32E0E7;">保养</td>

                                                                    <td style="text-align: right; width: 20px;">
                                                                        <div class='div2 BRed'></div>
                                                                    </td>
                                                                    <td style="text-align: left; font-size: 22px; color: #32E0E7;">检修</td>

                                                                    <td style="text-align: right; width: 20px;">
                                                                        <div class='div2 BGray'></div>
                                                                    </td>
                                                                    <td style="text-align: left; font-size: 22px; color: #32E0E7;">停机</td>
                                                                </tr>
                                                            </table>
                                                            <div style="padding-top: 10px;" id="qiji"></div>
                                                        </div>
                                                    </td>
                                                    <td style="height: 200px; width: 50%; vertical-align: top; text-align: right;">
                                                        <table style="padding: 0px; margin-top: -20px;">
                                                            <tr>
                                                                <td style="width: 20%; vertical-align: top; padding-top: 40px; text-align: left;">
                                                                    <font style="font-size: 1em; font-weight: 600; padding-left: 10px;">Top3不良</font>
                                                                </td>
                                                                <td style="width: 80%; text-align: left;padding-top:20px">
                                                                    <div id="echarts_top5nc" style="height:250px; margin-left: -30px; margin-top: -80px; width: 100%; text-align: right; padding-top:40px">
                                                                    </div>
                                  <%--                                  <div id="top5Str" style="font-size: 20px; display:none; color: #E6E6E6; text-align: center;  vertical-align: middle; margin-left:-20%">当前没有任何数据</div>--%>
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
                </td>
            </tr>
        </table>
    </form>
</body>

</html>
