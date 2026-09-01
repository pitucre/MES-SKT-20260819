<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProducationQuality.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.ProducationQuality" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 14px; overflow: hidden; }

        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; /*border: 1px solid #38FFFF;*/ }

        .logo_cus { background: url('../../Content/images/logo/logo.png') no-repeat 15px center; background-size: 94%; /*background-color: #0D213A;*/ }
        .logo_cus2 {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat 15px center;
            background-size: 90%;
        }

        .table { display: table; height: 100%; width: 100%; position: relative; }

        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }

        th { height: 22px; line-height: 22px; text-align: center; font-size: 20px; color: #FFffff; }

        tr { height: 22px; line-height: 22px; text-align: center; font-size: 18px; color: #FFffff; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 10%;">
                <li style="height: 100%;">
                    <span class="logo_cus2 cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 59%;">
                        <span class="cell" style="font-size: 40px; color: #FFffff; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">车间品质监控看板</span>
                    </div>
                    <div class="table" style="float: right; width: 19%;">
                        <span class="cell" style="font-size: 18px; color: #FFffff; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>
            <ul style="height: 35%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000;">
                <li style="height: 35%;">
                    <table style="width: 100%;">
                        <tr class="rows">
                            <th style="width: 5%">序号</th>
                            <th style="width: 10%">线别</th>
                            <th style="width: 17%">产品编码</th>
                            <th style="width: 15%">产品名称</th>
                            <th style="width: 12%">批次号</th>
                            <th style="width: 5%">送检数</th>
                            <th style="width: 5%">不良数</th>
                            <th style="width: 5%">抽检数</th>
                            <th style="width: 8%">检验结果</th>
                            <th style="width: 19%">检验时间</th>


                        </tr>
                    </table>
                    <div id="_layout_left_data_div_tbody">
                        <div id="_layout_left_data_div2_tbody">
                            <table id="data_tbody" style="width: 100%; font-size: 22px; color: #4EC9CE; margin: 0 auto; height: 16%;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </li>
            </ul>

            <ul style="height: 50%;">
                <li style="height: 99%; margin-top: 10px;">
                    <div style="height: 100%; width: 49%; float: left; border-right: 5px solid #000000;" class="gauge" id="echarts_gauge1"></div>
                    <div style="height: 100%; width: 49%; float: right;">
                        <div style="height: 100%;">
                            <ul style="height: 50%;">
                                <li style="height: 100%;">
                                    <div id="echarts_gauge2" class="gauge" style="width: 100%; height: 95%;"></div>
                                </li>
                            </ul>
                            <ul style="height: 50%;">
                                <li style="height: 100%;">
                                    <div id="echarts_gauge3" class="gauge" style="width: 100%; height: 95%;"></div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul>
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
                    bulidDataTb();
                }
            }
        </script>

        <script type="text/javascript">
            var workshopId;

            var echart1, echart2, echart3;
            var _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            $(document).ready(function () {
                workshopId = getQueryString("workshopId");
                if (!workshopId) {
                    workshopId = -1;
                }

                ResizeAll();
                bulidDataTb();
                bulidNCCharts();
                bulidNCByWeek();
                bulidNCByRate();
                GetNowTime();

                //能连接到服务器时，2小时整页刷新
                setInterval(function () {
                    getServerTime(1);
                }, 1000 * 60 * 60 * 2);


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
                    data: { "api": "GetServerTime", "fmt": "yyyy-MM-dd HH:mm:ss" },
                    dataType: 'text',
                    success: function (data) {
                        if (flag == 0) {
                            $("#dateAndWeek").html(data);
                        } else {
                            window.location.reload();
                        }
                    },
                    error: function (e) {
                        //console.log(e);
                    }
                });
            }

            function GetNowTime() {

                //$("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));

                getServerTime(0);

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

                var _contentHeight = $(window).height() * 1 * 0.3;

                $("#_layout_left_data_div_tbody").css("height", "auto");

                $(".rows").height(_contentHeight * 0.1)

                if ($(".rows").length * _contentHeight * 0.14 > _contentHeight) {
                    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                    isScroll = true;
                }
            }

            /*
            **获取品质不良原因图
            */
            function bulidNCCharts() {
                //add by weixia on 2018.4.17
                var orderDetial = [];
                var orderNcQty = [];
                var arr = [];
                $.ajax({
                    type: 'POST',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/ProducationQuality.ashx',
                    data: { "Type": "NcQuanlity", "WorkshopId": workshopId },
                    dataType: "Json",
                    success: function (result) {
                        if (result == null) { return false; }
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                orderDetial.push(result[i].NCDesc)
                                arr.push({ name: result[i].NCDesc, value: result[i].NcQty })
                            }
                        }

                        var option = {
                            title: {
                                text: '品质不良原因（周）',
                                x: 'center',
                                textStyle: {
                                    fontSize: 16,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    //textBorderColor: '#447DFE',
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 20,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 15
                            },
                            tooltip: {
                                trigger: 'item',
                                formatter: "{b} : {c} ({d}%)"
                            },
                            legend: {
                                x: 'center',
                                y: 'bottom',
                                padding: [0, 0, 20, 0],
                                textStyle: {
                                    fontSize: 13,
                                    color: '#58B2D4'
                                },
                                data: orderDetial
                                //  data: ['功能不良', '外观不良', '实物与图纸不符', '漏工序', '尺寸不良', '其他', '少焊', '歪脚', '错位', '缺角']
                            },
                            toolbox: {
                                show: false
                            },
                            calculable: true,
                            series: [
                                {
                                    type: 'pie',
                                    radius: ['30%', '55%'],
                                    center: ['50%', '50%'],
                                    //roseType: 'radius',                            
                                    label: {
                                        normal: {
                                            show: true,
                                            color: "#58B2D3",
                                            fontSize: 16,
                                            fontWeight: 'bold',
                                            formatter: "{b}：{d}%"
                                        },
                                        emphasis: {
                                            show: true,
                                            fontSize: 16,
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
                                                var colorList = ['#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#32E0E7', '#826A4F', '#51DE8A', '#25851D', '#ADC7B8',];
                                                var index = p.dataIndex;
                                                return colorList[index];
                                            }
                                        }
                                    },

                                    /* data: [{ value: 10, name: '功能不良' },{ value: 5, name: '外观不良' },{ value: 15, name: '实物与图纸不符' },{ value: 25, name: '漏工序' },
                                          /*{ value: 20, name: '尺寸不良' },
                                          { value: 35, name: '其他' },
                                          { value: 15, name: '少焊' },
                                          { value: 25, name: '歪脚' },
                                          { value: 38, name: '错位' },
                                          { value: 38, name: '缺角' },
                                     ]*/
                                    data: arr
                                }
                            ]
                        };
                        /*注册ECHARTS*/
                        echart1 = echarts.init(document.getElementById('echarts_gauge1'));
                        echart1.setOption(option, true);
                    }
                });
            }

            /*
           **获取一周内每天品质不良图
           */
            function bulidNCByWeek() {
                var dataTimeArr = [];
                var orderNcQty = [];
                $.ajax({
                    type: 'POST',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/ProducationQuality.ashx',
                    data: { "Type": "NCQty", "WorkshopId": workshopId },
                    dataType: "Json",
                    success: function (result) {
                        if (result == null) { return false; }
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                dataTimeArr.push(result[i].DataTime);
                                orderNcQty.push(result[i].NcQty);
                            }
                        }

                        var option = {
                            title: {
                                text: "最近一周不良数",
                                textStyle: {
                                    fontSize: 16,
                                    color: '#F1F1F2',          // 主标题文字颜色                            
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 20,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
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
                                    // data: ['12/25', '12/26', '12/27', '12/28', '12/29', '12/30', '12/31'],
                                    data: dataTimeArr,
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
                                    name: '不良数',
                                    type: 'bar',
                                    barWidth: '60%',
                                    barMaxWidth: 50,
                                    itemStyle: {
                                        normal: {
                                            color: function (p) {
                                                var colorList = ['#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#32E0E7', '#826A4F', '#51DE8A', '#25851D', '#ADC7B8',];
                                                var index = p.dataIndex;
                                                return colorList[index];
                                            }
                                        }
                                    },
                                    // data: [110, 52, 100, 134, 100, 120, 70]
                                    data: orderNcQty
                                }
                            ]
                        };

                        /*注册ECHARTS*/
                        echart2 = echarts.init(document.getElementById('echarts_gauge2'));
                        echart2.setOption(option, true);
                    }
                });
            }
            //var colorList = ["#63eaff", "#41fdd0", "#e5ea3c", "#5ae09f", "#83c0ff"];
            var colorList = ["#37a2da", "#9fe6b8", "#ffdb5c", "#ff9f7f", "#e062af"];
            /*
           **获取一周内每天品质不良原因图
           */
            function bulidNCByRate() {
                var option = {
                    title: {
                        text: "最近一周TOP5机种允收率",
                        textStyle: {
                            fontSize: 16,
                            color: '#F1F1F2',          // 主标题文字颜色                            
                            textShadowColor: '#5a5af7',
                            textShadowBlur: 20,
                            textShadowOffsetX: 2,
                            textShadowOffsetY: 2,
                        },
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            type: 'line'        // 默认为直线，可选为：'line' | 'shadow'
                        },
                        formatter: '{b}<br/>{c} %'
                    }, legend: {
                        left: 180,
                        //left: 'right',
                        textStyle: {
                            color: "#F1F1F2",
                        },
                        //padding: [0, 30, 0, 0],
                        //  data: ['KP001', 'KP002', 'KP003']
                        data: (function () {
                            var arr = [];
                            $.ajax({
                                type: "post",
                                async: false, //同步执行
                                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/ProducationQuality.ashx',
                                data: { "Type": "NCPassItemCode", "WorkshopId": workshopId },
                                dataType: "json", //返回数据形式为json
                                success: function (result) {
                                    if (result) {
                                        for (var i = 0; i < result.length; i++) {
                                            arr.push(result[i].ItemCode);
                                        }
                                    }

                                },
                                error: function (errorMsg) {
                                }
                            })
                            return arr;
                        })(),
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
                            // data: ['12/25', '12/26', '12/27', '12/28', '12/29', '12/30', '12/31'],
                            data: (function () {
                                var arr = [];
                                $.ajax({
                                    type: "post",
                                    async: false, //同步执行
                                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/ProducationQuality.ashx',
                                    data: { "Type": "NCPassTime", "WorkshopId": workshopId },
                                    dataType: "json", //返回数据形式为json
                                    success: function (result) {
                                        if (result) {
                                            for (var i = 0; i < result.length; i++) {
                                                arr.push(result[i].DataTime);
                                            }
                                        }

                                    },
                                    error: function (errorMsg) {
                                    }
                                })
                                return arr;
                            })(),


                            axisTick: {
                                alignWithLabel: true
                            },
                            axisLabel: {
                                textStyle: {
                                    color: '#378DBD',//坐标值得具体的颜色
                                    fontSize: 15,
                                }
                            },
                            axisLine: {
                                lineStyle: {
                                    color: '#378DBD',
                                }
                            }
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
                            },
                            axisLabel: {
                                show: true,
                                interval: 'auto',
                                formatter: '{value} %'
                            },
                        }
                    ],
                    series: (function () {
                        var arrItemCode = [];
                        $.ajax({
                            type: "post",
                            async: false, //同步执行
                            url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/ProducationQuality.ashx',
                            data: { "Type": "NCPassItemCode", "WorkshopId": workshopId },
                            dataType: "json", //返回数据形式为json
                            success: function (result) {
                                if (result) {
                                    for (var i = 0; i < result.length; i++) {
                                        arrItemCode.push({
                                            name: result[i].ItemCode,
                                            type: 'line',
                                            barWidth: '60%',
                                            itemStyle: {
                                                normal: {
                                                    color: colorList[i],//'#95CA13',
                                                    label: {
                                                        show: true,
                                                        formatter: '{c}%',
                                                        textStyle: {
                                                            color: '#F1F1F2'
                                                        }
                                                    }
                                                }
                                            },
                                            //data: [80, 82, 99, 83, 83, 95, 99]
                                            data: (function () {
                                                var arr = [];
                                                var itemCode = result[i].ItemCode;
                                                $.ajax({
                                                    type: "post",
                                                    async: false, //同步执行
                                                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/ProducationQuality.ashx',
                                                    data: { "Type": "NCPassPer", "ItemCode": itemCode, "WorkshopId": workshopId },
                                                    dataType: "json", //返回数据形式为json
                                                    success: function (result) {
                                                        if (result) {
                                                            for (var i = 0; i < result.length; i++) {
                                                                arr.push(result[i].PassPer);
                                                            }
                                                        }

                                                    },
                                                    error: function (errorMsg) {
                                                    }
                                                })
                                                return arr;
                                            })(),
                                        })
                                    }
                                }

                            },
                            error: function (errorMsg) {
                            }
                        })
                        return arrItemCode;
                    })()
                    /* series: [
                         {
                             name: 'KP001',
                             type: 'line',
                             barWidth: '60%',
                             itemStyle: {
                                 normal: {
                                     color: '#95CA13',
                                     label: {
                                         show: true,
                                         formatter: '{c}%',
                                         textStyle: {
                                             color: '#F1F1F2'
                                         }
                                     }
                                 }
                             },
                             data: [80, 82, 99, 83, 83, 95, 99]
                         },
                         {
                             name: 'KP002',
                             type: 'line',
                             barWidth: '60%',
                             itemStyle: {
                                 normal: {
                                     color: '#32E0E7',
                                     label: {
                                         show: true,
                                         formatter: '{c}%',
                                         textStyle: {
                                             color: '#F1F1F2'
                                         }
                                     }
                                 }
                             },
                             data: [90, 92, 83, 94, 95, 78, 80]
                         },
                         ,
                         {
                             name: 'KP003',
                             type: 'line',
                             barWidth: '60%',
                             itemStyle: {
                                 normal: {
                                     color: '#447DFE',
                                     label: {
                                         show: true,
                                         formatter: '{c}%',
                                         textStyle: {
                                             color: '#F1F1F2'
                                         }
                                     }
                                 }
                             },
                             data: [98, 72, 90, 76, 95, 86, 87]
                         }
                     ]*/
                };

                /*注册ECHARTS*/
                echart3 = echarts.init(document.getElementById('echarts_gauge3'));
                echart3.setOption(option, true);
            }

            /*
            **创建  获取OQC检验数据
            */

            function initProductionData() {
                $("#data_tbody tbody").html("");

                $.ajax({
                    type: 'POST',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SMTLineProduction.ashx',
                    data: { 'Type': 'ProductionData', 'LineId': lineId, "WorkshopId": workshopId },
                    dataType: 'json',
                    success: function (data) {
                        if (data == null) { return false; }
                        $.each(data.List, function () {
                            $("<tr class='rows'>" +
                                "<td width='9%'>" + this.LineName + "</td>" +
                                "<td width='14%'>" + this.OrderNo + "</td>" +
                                "<td width='15%'>" + this.ItemCode + "</td>" +
                                "<td width='20%'>" + this.ItemName + "</td>" +
                                "<td width='7%'>" + this.Surface + "</td>" +
                                "<td width='7%'>" + this.Designed + "</td>" +
                                "<td width='7%'>" + this.Input + "</td>" +
                                "<td width='7%'>" + this.Output + "</td>" +
                                "<td width='7%'>" + this.Defects + "</td>" +
                                "<td  width='7%'>" + this.Status + "</td></tr>").appendTo($("#data_tbody tbody"));
                        });

                        ResizeAll();
                    }
                });
            }


            function bulidDataTb() {
                var html = "";
                $.ajax({
                    type: "POST",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/ProducationQuality.ashx',
                    data: { "Type": "SearchOQC", "WorkshopId": workshopId },
                    dataType: "Json",
                    success: function (data) {
                        if (data == null) { return false; }
                        $.each(data, function (i, n) {

                            html += '<tr class="rows" >' +
                                '<td style="width: 5%">' + n["RowID"] + '</td>' +
                                '<td style="width: 10%">' + n["LineName"] + '</td>' +
                                '<td style="width: 17%">' + n["ItemCode"] + '</td>' +
                                '<td style="width: 15%">' + n["ItemName"] + '</td>' +
                                '<td style="width: 12%">' + n["LotNo"] + '</td>' +
                                '<td style="width: 5%">' + n["SendQty"] + '</td>' +
                                '<td style="width: 5%">' + n["NcQty"] + '</td>' +
                                '<td style="width: 5%">' + n["SamplingQty"] + '</td>' +
                                '<td style="width: 8%">' + n["CheckResult"] + '</td>' +
                                '<td style="width: 19%">' + n["CheckTime"] + '</td>' +
                                '</tr>'
                        })
                        $(html).appendTo($("#data_tbody tbody"));
                        ResizeAll();
                    }
                });
            }
        </script>
    </form>
</body>
</html>
