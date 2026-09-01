<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NineInOneKanbanVertical.aspx.cs"  Inherits="SKT.LeanMES.Web.MobileApp.NineInOneKanbanVertical" %>

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
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 14px; /*overflow: hidden;*/ }
        .fontfamily { font-family: SimSun}
        .dvSub { font-family: SimSun;font-size: 20px; color: #F1F1F2; font-weight: bold;height:400px; width:100%;position:relative;}
        .divTitle { text-align:center; width:100%;height:20px;padding:5px; background-color:#215181; padding-bottom:10px;}


        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; /*border: 1px solid #38FFFF;*/ }
        * { margin:0px; padding:0%;}
        .dvMain { width:100%;height:95%; overflow: auto;}
        /*.dvMain>div{width:33%;height:33%;float:left; border:1px solid #99ccff}*/
         .dvMain>div{border:1px solid #99ccff}
        /*.dvMain>div:nth-child(2n){background: #c1dd95;}
        .dvMain>div:nth-child(2n-1){background: #9dc7e4;}*/
        .Head_li {margin: 0px; padding: 0px; list-style: none; text-align: center; display: inline; float:left; height:44px;}
        .E2_li {margin: 0px; padding: 0px; list-style: none; text-align: center; display: inline; float:left; width:33%;}
        .E2_div { margin-top:30px;}
        #E2_1 { width:98%; height:90px; background-color:#00192a;}
        #E2_2 { width:98%; height:130px; background-color:#00192a;}
        #E2_3 { width:98%; height:130px; background-color:#00192a;}
        .E2_FontColor { color:#0168ff;font-size:16px;font-weight: bold;}
         .E2_FontColor1 { color:#F1F1F2;font-size:16px;font-weight: bold;}

        .logo_cusH1 {
            background: url('../../Content/images/logo/XSS-logo.png') no-repeat 15px center;
            background-size: 80%;
        }
        .logo_cusH2 {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat 15px center;
            background-size: 75%;
        }
        /*.table { display: table; height: 100%; width: 100%; position: relative; }*/

        /*右侧时间显示有变化*/
        /*.cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }*/   
        .cellH { display: table-cell; width: 100%; height: 100%; vertical-align: middle; } 

        /*测试*/
         /*.rows>th:nth-of-type(1){flex:3}
        .rows>td:nth-of-type(1){flex:3}*/

        /*.rows{display:flex;}       
        .rows th { display:flex;justify-content: center;align-items: center;}
        .rows td { display:flex;justify-content: center;align-items: center;}*/


        
            .table-wrapper table {
               table-layout: fixed;width: 100%;text-align: center;font-size: 10px;
            }           
            .table-wrapper table tbody{
               display: inline-block;width: 100%;/*overflow: auto;*/max-height: 100px;
            }
            .table-wrapper table tr{
            	display: inline-block;width: 100%;
            }
            .table-wrapper table td, .table-wrapper table th {
                white-space:nowrap;overflow:hidden;
                word-wrap:break-word;word-break:break-all;height: 20px;line-height: 20px;
            }
            /*.table-wrapper table td:nth-child(1), .table-wrapper table th:nth-child(1) {
            	width: 30px;
            }*/
        .divClass{
            position:absolute;
            top:14%;
            right:1px;
           width:148px;
           height:20px;        
           font-size:10px;
           text-align:center;
           color:#ff1a11;
           z-index:999;
        }

        .divTitleEchart{
           position:absolute;
           width:100%;
           height:32px;        
           font-size:12px;
           text-align:center;
           color:#ff1a11;
           background-color:#215181
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align:center; background-color:#0b3034; height:44px;">
            <ul>
               <li class="Head_li" style="width:25%;"><span class="logo_cusH1 cellH" style="display: block; float: left;width:100%"></span></li>
               <li class="Head_li" style="width:50%;"><span style="font-size:17px; color:#0066ff;margin-top: 10px;display: inline-block;font-weight: bold; padding-left:10px;">工业4.0车间监控中心</span></li>
               <li class="Head_li" style="width:25%;"><span class="logo_cusH2 cellH" style="display: block; float: right; width:100%"></span></li>                
            </ul>
        </div>
        <div class="dvMain">
            <div class="dvSub" style="height:200px;">
                <div class="divTitle"><span class="cell">电机车间布局图</span></div>
                <div id="NIOecharts1" style="background-image: url(../../Content/images/XSS-WorkShop.png);background-size:100% 89%; width:100%;height:95%;"></div>                
            </div>  
            <div class="dvSub" id="NIOecharts2" style="height:300px;">
                <div class="divTitle">
                    <ul>
                         <li class="E2_li" style="width:20%"><span class="cell" style="margin-left: 15px; width: 100px; display: block; float: left; color:#215181;">_</span></li>
                         <li class="E2_li" style="width:60%"><span class="cell" >电机车间生产监控</span></li>
                        <li class="E2_li" style="width:20%"><span class="cell" style="margin-left: 15px; width: 100px; display: block; float: left; color:#215181;">_</span></li>                        
                    </ul>
                    <ul style="text-align:right;">                        
                         <li class="E2_li" style="text-align:right; padding-top:3px;  width:98%;"><span class="cell" style="font-size: 15px; color: #e5e606; font-weight: bold;" id="dateAndWeek_E2"></span></li>
                    </ul>
                </div>
                <div style="text-align:center; height:70%; margin-top:10px;">
                    <ul>
                        <li class="E2_li" style="margin-top:5px;"><span class="E2_FontColor">当日电机产出数</span><br /><div class="E2_div" id="E2_1" style="font-size:35px; padding-top:40px; color:#a0d500"></div></li>
                        <li class="E2_li" style="margin-top:5px;"><span  class="E2_FontColor">完成率</span><br /><div class="E2_div gauge" id="E2_2"></div></li>
                        <li class="E2_li" style="margin-top:5px;"><span  class="E2_FontColor">齐套率</span><br /><div class="E2_div gauge" id="E2_3"></div></li>
                    </ul>
                </div>
                <div style="text-align:center;">
                    <ul>
                        <li class="E2_li E2_FontColor1" style="width:49%;"><span>工单数：</span><span id="E2_4"></span></li>
                        <li class="E2_li E2_FontColor1" style="width:49%;"><span>生产计划数：</span><span id="E2_5"></span></li>
                    </ul>
                </div>                           
            </div>
            <div class="dvSub">
                <div class="divTitleEchart">
                </div>
                <div id="NIOecharts3" style="width:100%;height:100%;"></div>
            </div>

            <div class="dvSub" style="height:300px; ">
                <div class="divClass">
                    <table style="width:100%;">
                        <tr>
                            <td style="text-align:right;width:45%;">达成率</td>
                            <td style="text-align:center;width:55%;">产出   计划</td>
                        </tr>
                    </table>
                </div>
                <div class="divTitleEchart">
                </div>
                <div id="NIOecharts4" style="width:100%;height:100%;"></div>
            </div>
             <div class="dvSub" id="NIOecharts5">
                <div style="width: 100%; height: 100%;">
                    <div class="divTitle"><span class="cell">计划日看板</span></div>                  
                    <ul style="height: 70%;" id="E5_ul">
                        <li style="height: 80%;">
                            <table id="data_thead_JIT" style="height: 12%; width: 98%; margin: 0 auto;font-size: 14px;">                                   
                                <tr class="rows_JIT">
                                        <th style="width: 14%" class="thTitle">生产排程工单号</th>
                                        <th style="width: 19%" class="thTitle">领料单号</th>  
                                        <th style="width: 14%" class="thTitle">产品编码</th>  
                                        <th style="width: 14%" class="thTitle">产品名称</th>
                                        <th style="width: 14%" class="thTitle">产线</th>
                                        <th style="width: 7%" class="thTitle">工单数量</th>
                                        <th style="width: 6%" class="thTitle">工单状态</th>
                                        <th style="width: 6%" class="thTitle">已备料站</th>
                                        <th style="width: 6%" class="thTitle">待备料站</th>
                                    </tr>   
                            </table>
                            <div id="_layout_left_data_div_tbody_JIT">
                                <div id="_layout_left_data_div2_tbody_JIT">
                                    <table id="data_tbody_JIT" style="width: 100%;height: 12%; font-size: 10px; color: #4EC9CE;">
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <ul style="height: 10%;" class="bot">
                        <li style="height: 100%;">
                            <div id="_left_top_welcome_text" style=" padding-top:5px; padding-bottom:5px;font-size: 16px; color: red; font-weight: bold; text-align:center; display:block;">
                                               
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="dvSub">
                <div class="divTitleEchart">
                </div>
                <div id="NIOecharts6" style="width:100%;height:100%;"></div>
            </div>

            <div class="dvSub" id="NIOecharts7" style="height:400px;">
                <div class="divTitle"><span class="cell">车间品质监控看板</span></div>
                <%--<ul style="height: 41%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000;" id="E7_ul">
                    <li style="height: 35%;">
                        <table id="data_thead" style="width: 100%; font-size:12px;">       
                            <tr class="rows">
                            <th style="width: 5%" class="thTitle">序号</th>
                            <th style="width: 20%" class="thTitle">线别</th>
                            <th style="width: 19%" class="thTitle">产品编码</th>
                            <th style="width: 20%" class="thTitle">产品名称</th>
                            <th style="width: 20%" class="thTitle">产品规格</th>
                            <th style="width: 8%" class="thTitle">不良数</th>
                            <th style="width: 8%" class="thTitle">抽检数</th>
                        </tr>
                        </table>
                        <div id="_layout_left_data_div_tbody">
                            <div id="_layout_left_data_div2_tbody" style="font-size: 10px;">
                                <table id="data_tbody" style="width: 100%; color: #4EC9CE; margin: 0 auto; height: 10%;">
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </li>
                </ul>--%>

                <ul style="height: 100%;">
                    <li style="height: 100%; margin-top: 5px;">
                        <div style="height: 90%; width: 49%; float: left; border-right: 5px solid #000000;" class="gauge" id="echarts_gauge1"></div>
                        <div style="height: 90%; width: 49%; float: right;">
                            <div style="height: 100%;">
                                <ul style="height: 48%;">
                                    <li style="height: 100%;">
                                        <div id="echarts_gauge2" class="gauge" style="width: 100%; height: 95%;"></div>
                                    </li>
                                </ul>
                                <ul style="height: 52%;">
                                    <li style="height: 100%;">
                                        <div id="echarts_gauge3" class="gauge" style="width: 100%; height: 100%;"></div>
                                    </li>
                                </ul>
                            </div>
                        </div>                     
                    </li>
                </ul>
            </div>
             <div class="dvSub">
                <div class="divTitleEchart">
                </div>
                <div id="NIOecharts8" style="width:100%;height:100%;"></div>
            </div>
            <div class="dvSub">
                <div class="divTitleEchart">
                </div>
                <div id="NIOecharts9" style="width:100%;height:100%;"></div>
            </div>
        </div>

        <%--初始化--%>
        <script type="text/javascript">
            var NIOecharts1, NIOecharts2, NIOecharts3, NIOecharts4, NIOechart5, NIOechart6, NIOechart7, NIOechart8, NIOechart9, E2_2, E2_3;  //NIOechart1放一张图片，不用

            $(document).ready(function () {
                K2_GetCapacityDay();
                K3_GetLineOneUPPHDay();
                K4_GetLineStatusPercent();
                K6_GetLineUPPHAverageRateDay();
                K8_GetLineUPHDay();
                K9_GetLineQualityRateDay();
            });
        </script>

        <%--2.此看板，按照此图显示“今日产能”、“完成率”、“齐套率”、“工单数”、“生产计划数”， 今日产能：截止当前成品电机入库数。
            完成率为=当日完成数/计划数  齐套率=齐套数/计划数  批次数=入库批次合计数，按照当日一个工单为一个批次  计划数=当日排产计划数 。
            时间读秒更新，以上数据全部取当日数据--%>
        <script type="text/javascript">
            function K2_GetCapacityDay() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { "api": "K2_GetCapacityDay" },
                    dataType: "json",          
                    success: function (resultData) {
                        var pCapacity = resultData[0].Capacity;
                        var pFinishRate = resultData[0].FinishRate;
                        var pKittingRate = resultData[0].KittingRate;
                        var pOrderNoNumber = resultData[0].OrderNoNumber;
                        var pProductPlanNumber = resultData[0].ProductPlanNumber;
                        var pFinishRateX = 100 - parseFloat(resultData[0].FinishRate).toFixed(0);
                        var pKittingRateX = 100 - parseFloat(resultData[0].KittingRate).toFixed(0);
                        $("#E2_1").html(pCapacity);
                        $("#E2_4").html(pOrderNoNumber);
                        $("#E2_5").html(pProductPlanNumber);

                        var option1 = {
                            title: {
                                text: pFinishRate + "%",   //显示在中间的数值
                                left: 'center',
                                top: 'center',
                                textStyle: {
                                    fontSize: 16,
                                    color: '#f6f6f6',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                }
                            },
                            series: [
                              {
                                  type: 'pie',
                                  label: {
                                      show: false,
                                      position: 'center'
                                  },
                                  labelLine: {
                                      show: false
                                  },
                                  data: [
                                    {
                                        value: pFinishRate
                                    },
                                    {
                                        value: pFinishRateX
                                    },
                                  ],
                                  itemStyle: {
                                      normal: {
                                          color: function (p) {
                                              var colorList = ['#0dcf69', '#886aac'];
                                              var index = p.dataIndex;
                                              return colorList[index];
                                          }
                                      }
                                  },
                                  radius: ['55%', '70%']
                              }]
                        }
                        // 初始化echarts实例
                        E2_2 = echarts.init(document.getElementById('E2_2'));
                        // 使用刚指定的配置项和数据显示图表。
                        E2_2.setOption(option1);

                        var option2 = {
                            title: {
                                text: pKittingRate + "%",   //显示在中间的数值
                                left: 'center',
                                top: 'center',
                                textStyle: {
                                    fontSize: 16,
                                    color: '#f6f6f6',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                }
                            },
                            series: [
                              {
                                  type: 'pie',
                                  label: {
                                      show: false,
                                      position: 'center'
                                  },
                                  labelLine: {
                                      show: false
                                  },
                                  data: [
                                    {
                                        value: pKittingRate
                                    },
                                    {
                                        value: pKittingRateX
                                    },
                                  ],
                                  itemStyle: {
                                      normal: {
                                          color: function (p) {
                                              var colorList = ['#0dcf69', '#886aac'];
                                              var index = p.dataIndex;
                                              return colorList[index];
                                          }
                                      }
                                  },
                                  radius: ['55%', '70%']
                              }]
                        }
                        // 初始化echarts实例
                        E2_3 = echarts.init(document.getElementById('E2_3'));
                        // 使用刚指定的配置项和数据显示图表。
                        E2_3.setOption(option2);

                        setTimeout("K2_GetCapacityDay()", 1000 * 60 * 5);
                    }
                });           
            }
        </script>

        <%--3. UPPH趋势图按照绕线和装配线每天UPPH数据连线展示。绕线线体:取的是自动绕线A线、自动绕线B线、自动绕线C线以及手工绕线，这四条线的UPPH平均值。
            装配线体：取的是自动装配A线、自动装配B线、自动装配C线以及手工装配B线，这四条线的UPPH平均值。
            只有2个线体2条线，取绕线和装配线的计划达成率平均值。--%>
        <script type="text/javascript">
            function K3_GetLineOneUPPHDay() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { "api": "K3_GetLineOneUPPHDay" },
                    dataType: "json",          
                    success: function (resultData) {
                        var xData = [];  //X轴
                        var yLine1 = [];//绕线线体
                        var yLine2 = [];//装配线体
                        var YMinValue = 0;
                        var YMaxValue = 100;

                        var seriesObj = [];
                        var entity1 = {
                            name: '绕线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity2 = {
                            name: '装配',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };
                        $.each(resultData, function (i, item) {
                            xData.push(item.Day);
                            yLine1.push(item.Line1_Rate);
                            yLine2.push(item.Line2_Rate);
                            YMinValue = item.YMinValue;
                            YMaxValue = item.YMaxValue;

                            if (yLine1.length == resultData.length) {
                                entity1.data = yLine1;
                                entity2.data = yLine2;
                            }

                        });

                        seriesObj.push(entity1);
                        seriesObj.push(entity2);

                        var option = {
                            title: {
                                text: "UPPH趋势图",
                                x: 'center',
                                top: 1,
                                textStyle: {
                                    fontSize: 20,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    fontFamily: 'SimSun'
                                }
                            },
                            legend: {
                                orient: 'vertical',  //height有效，width无效
                                //orient: 'horizontal',    //width有效，height无效
                                y: 'center',
                                right: 10,
                                icon: 'line',
                                data: [
                                    {
                                        name: '绕线',
                                        textStyle: {
                                            color: '#0dcf69'
                                        },

                                    },
                                    {
                                        name: '装配',
                                        textStyle: {
                                            color: '#886aac'
                                        }
                                    }
                                ],
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    fontFamily: 'SimSun'
                                },
                            },
                            tooltip: {
                                trigger: 'item',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '1%',
                                right: '17%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    name: '日期',
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        textStyle: {
                                            color: '#e0e2e8',//"#378DBD",//坐标值得具体的颜色
                                            fontSize: 12,
                                            fontFamily: 'SimSun',
                                        },
                                        //formatter: '{value}',
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    nameTextStyle: {
                                        color: '#f6f6f8',
                                        fontSize: 12,
                                        fontFamily: 'SimSun'                                        
                                    }
                                }
                            ],
                            yAxis: [
                                {
                                    name: 'UPPH',
                                    type: 'value',
                                    min: YMinValue,
                                    max: YMaxValue,
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
                                        color: '#e0e2e8',//"#378DBD",
                                        formatter: '{value}%',
                                        fontSize: 12,
                                        fontFamily: 'SimSun',
                                    },
                                    nameTextStyle: {
                                        color: '#f6f6f8',
                                        fontSize: 12,
                                        fontFamily: 'SimSun'
                                    }

                                }
                            ],
                            series: seriesObj,
                            //color: ['#67e0e3', '#9d96f5', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570', '#c4ccd3']
                            color: ['#0dcf69', '#886aac']
                        };

                        // 初始化echarts实例
                        NIOecharts3 = echarts.init(document.getElementById('NIOecharts3'));
                        // 使用刚指定的配置项和数据显示图表。
                        NIOecharts3.setOption(option);
                    }
                });

                setTimeout("K3_GetLineOneUPPHDay()", 1000 * 60 * 5);
            }
        </script>

        <%--4.线体看板 线体看板一共8条线，前面⭕代表线体状态，绿色表示运行中，黄色表示暂停中，红色表示停机中，其中有2条手工线（我用红色方框标识的）没有PLC无法取值，默认运行中，默认显示绿色。
            一共8条线按照“自动绕线A线”、 “自动绕线B线”、 “自动绕线C线”、 “手动绕线A线”、 “自动装配A线”、 “自动装配B线”、 “自动装配C线”、 
            “手动动装配B线”，6条自动线体（我用黄色方框标识的）根据PLC状态取值，代表线体状态。（PLC有对应的3个状态）线体排列顺序按照下图显示。百分比=实际产能/计划产能。--%>
        <script type="text/javascript">
            function K4_GetLineStatusPercent() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { "api": "K4_GetLineStatusPercent" },
                    dataType: "json",          
                    success: function (resultData) {
                        var yData = [];  //y轴
                        var seriesObj = [];
                        var seriesObjLeave = [];
                        var pPlanCapacity = 1000;  //计划产能默认1000
                        var maxData = 100;

                        $.each(resultData, function (i, item) {
                            yData.push(item.Line_Name);
                            seriesObj.push(item.Line_Percent);
                            seriesObjLeave.push(item.Line_LeaveCapacity);
                            pPlanCapacity = item.Line_PlanCapacity;
                        });

                        const StatusIcons = {
                            Status1: '../../Content/images/XSS_E2-1.png',
                            Status2: '../../Content/images/XSS_E2-2.png',
                            Status3: '../../Content/images/XSS_E2-3.png'
                        };
                        const seriesLabel = {
                            show: true
                        };
                        
                        var option = {
                            title: {
                                text: "线体状态图",
                                x: 'center',
                                top: 1,
                                textStyle: {
                                    fontSize: 20,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                }
                            },
                            grid: {   // 直角坐标系内绘图网格
                                left: '20',  //grid 组件离容器左侧的距离,
                                //left的值可以是80这样具体像素值，
                                //也可以是'80%'这样相对于容器高度的百分比
                                top: '60',
                                right: '150',
                                bottom: '30',
                                containLabel: true   //gid区域是否包含坐标轴的刻度标签。为true的时候，
                                // left/right/top/bottom/width/height决定的是包括了坐标轴标签在内的
                                //所有内容所形成的矩形的位置.常用于【防止标签溢出】的场景
                            },
                            legend: {
                                icon: 'circle',
                                bottom: 15,
                                left: 'center',
                                //data: ['运行中', '暂停中', '停止中'],   //这里的data数据要跟series中的那么一致才会显示出来
                                //color: ['#00ff00', '#fcc423', '#ff0000']
                                data: [
                                    {
                                        name: '运行中',
                                        //icon: 'image://../../Content/images/XSS_E2-1.png'//格式为'image://+icon文件地址'，其中image::后的//不能省略                                        
                                    },
                                    {
                                        name: '暂停中',
                                        //icon: 'image://../../Content/images/XSS_E2-2.png'//格式为'image://+icon文件地址'，其中image::后的//不能省略                                        
                                    }
                                    ,
                                    {
                                        name: '停止中',
                                        //icon: 'image://../../Content/images/XSS_E2-3.png'//格式为'image://+icon文件地址'，其中image::后的//不能省略                                        
                                    }
                                ],
                                textStyle: {
                                    color: '#0168ff',
                                    fontSize: 14,
                                },
                            },
                            tooltip: { show: false  },
                            xAxis: {
                                show:false,  //不显示X轴
                                max: maxData,
                                splitLine: { show: false },   //坐标轴在 grid 区域中的分隔线
                            },
                            yAxis: {
                                data: yData,
                                color: '#0067ff',
                                axisTick: {show: false},//坐标轴刻度
                                axisLine: { show: false },//坐标轴轴线
                                axisLabel: {
                                    show: true,
                                    fontSize: 12,
                                    formatter: function (p) {                                       
                                        //return p;
                                        var pYvalue = p;
                                        $.each(resultData, function (i, item) {
                                            if (item.Line_Name == p) {
                                                if (item.Line_Status == 3) {
                                                    pYvalue = '{Status3|} ' + p + '   ';   // |这个符号与rich属性关联
                                                    return false;
                                                }
                                                if (item.Line_Status == 2) {
                                                    pYvalue = '{Status2|} ' + p + '   ';
                                                    return false;
                                                }
                                                else {
                                                    pYvalue = '{Status1|} ' + p + '   ';
                                                    return false;
                                                }
                                            }
                                        });
                                        return pYvalue;
                                    },
                                    rich: {
                                        Status1: {
                                            align: 'left',
                                            backgroundColor: {
                                                image: StatusIcons.Status1
                                            }
                                        },
                                        Status2: {
                                            backgroundColor: {
                                                image: StatusIcons.Status2
                                            }
                                        },
                                        Status3: {
                                            backgroundColor: {
                                                image: StatusIcons.Status3
                                            }
                                        }
                                    },
                                    color: '#447dfe'
                                }
                            },                           
                            series: [
                                {
                                    type: 'bar',
                                    barWidth: 8,
                                    name: '运行中',
                                    color: '#00ff00',
                                    data: seriesObj,
                                    itemStyle: {
                                        normal: {
                                            barBorderRadius: 15,//柱条圆角半径,单位px.
                                            color: function (p) {
                                                var colorList = [];
                                                var c1 = '#00ff00';//自动绕线A线
                                                var c2 = '#00ff00';//自动绕线B线
                                                var c3 = '#00ff00';//自动绕线C线
                                                var c4 = '#00ff00';//手动绕线A线
                                                var c5 = '#00ff00';//自动装配A线
                                                var c6 = '#00ff00';//自动装配B线
                                                var c7 = '#00ff00';//自动装配C线
                                                var c8 = '#00ff00';//手动装配B线
                                                $.each(resultData, function (i, item) {
                                                    if (item.Line_Name == p.name && item.Line_Name == '自动绕线A线') {
                                                        colorList.push(c1);
                                                    }
                                                    else if (item.Line_Name == p.name && item.Line_Name == '自动绕线B线') {
                                                        colorList.push(c2);
                                                    }
                                                    else if (item.Line_Name == p.name && item.Line_Name == '自动绕线C线') {
                                                        colorList.push(c3);
                                                    }
                                                    else if (item.Line_Name == p.name && item.Line_Name == '手动绕线A线') {
                                                        colorList.push(c4);
                                                    }
                                                    else if (item.Line_Name == p.name && item.Line_Name == '自动装配A线') {
                                                        colorList.push(c5);
                                                    }
                                                    else if (item.Line_Name == p.name && item.Line_Name == '自动装配B线') {
                                                        colorList.push(c6);
                                                    }
                                                    else if (item.Line_Name == p.name && item.Line_Name == '自动装配C线') {
                                                        colorList.push(c7);
                                                    }
                                                    else {
                                                        colorList.push(c8);
                                                    }
                                                });
                                                var index = p.dataIndex;
                                                return colorList[index];
                                            }
                                        }
                                    },
                                    zlevel: 2//柱状图所有图形的 zlevel 值,层级高的的显示在最上面
                                },
                                {
                                    name: '暂停中',  //右侧显示数据
                                    type: 'bar',
                                    barGap: '-100%',//不同系列的柱间距离，为百分比。// 在同一坐标系上，此属性会被多个 'bar' 系列共享。// 此属性应设置于此坐标系中最后一个 'bar' 系列上才会生效，//并且是对此坐标系中所有 'bar' 系列生效。
                                    barWidth: 8,
                                    data: [100, 100, 100, 100, 100, 100, 100, 100],
                                    color: '#fcc423',//柱条颜色  -- 对应lenged 颜色，下面重新格式化指定
                                    itemStyle: {
                                        normal: {
                                            barBorderRadius: 15,//柱条圆角半径,单位px.
                                            color: function (p) {
                                                var colorList = [];
                                                $.each(resultData, function (i, item) {
                                                    colorList.push('#ffffff');  //白色
                                                });
                                                var index = p.dataIndex;
                                                return colorList[index];
                                            }
                                        }
                                    },
                                    label: {
                                        show: true,
                                        formatter: function (p) {
                                            var valueList = [];
                                            var pValue = ((p.value / maxData) * 100).toFixed(0) + ' %';
                                            var pLine_ActualCapacity = "0";
                                            var pLine_Percent = "0";
                                            $.each(resultData, function (i, item) {
                                                if (item.Line_Name == p.name) {
                                                    pLine_ActualCapacity = item.Line_ActualCapacity;
                                                    if (item.Line_ActualCapacity < 10) {  //1位数 4个空格
                                                        pLine_ActualCapacity = "    " + pLine_ActualCapacity;;
                                                    }
                                                    if (10 <= item.Line_ActualCapacity < 100) {  //2位数 3个空格
                                                        pLine_ActualCapacity = "   " + pLine_ActualCapacity;
                                                    }
                                                    pLine_Percent = ((item.Line_Percent / maxData) * 100).toFixed(0);
                                                    if (((item.Line_Percent / maxData) * 100).toFixed(0) < 10) {
                                                        pLine_Percent = "  " + pLine_Percent;
                                                    }
                                                    pValue = pLine_Percent + ' %    ' + pLine_ActualCapacity + '/' + item.Line_PlanCapacity;
                                                    valueList.push(pValue);
                                                }
                                            });
                                            return valueList[0];
                                        },
                                        position: 'right',
                                        offset: [25, 0],
                                        color: '#00ff00',
                                        fontSize: 12
                                    }
                                },
                                {
                                    name: '停止中',  //左侧显示状态
                                    type: 'bar',
                                    barGap: '-100%',//不同系列的柱间距离，为百分比。// 在同一坐标系上，此属性会被多个 'bar' 系列共享。// 此属性应设置于此坐标系中最后一个 'bar' 系列上才会生效，//并且是对此坐标系中所有 'bar' 系列生效。
                                    barWidth: 8,
                                    data: [100, 100, 100, 100, 100, 100, 100, 100],
                                    color: '#ff0000',//柱条颜色   
                                    itemStyle: {
                                        normal: {
                                            barBorderRadius: 15,//柱条圆角半径,单位px.
                                            color: function (p) {
                                                var colorList = [];
                                                $.each(resultData, function (i, item) {
                                                    colorList.push('#ffffff');  //白色
                                                });
                                                var index = p.dataIndex;
                                                return colorList[index];
                                            }
                                        }
                                    },
                                    label: {
                                        show: true,
                                        formatter: function (p) {
                                            return '';
                                            //return '00';
                                        },
                                        position: 'left',
                                        //offset: [-75, 0],
                                        offset: [0, 0],
                                        color: '#00ff00',
                                        fontSize: 18
                                    }
                                }
                           ]
                        };

                        // 初始化echarts实例
                        NIOecharts4 = echarts.init(document.getElementById('NIOecharts4'));
                        // 使用刚指定的配置项和数据显示图表。
                        NIOecharts4.setOption(option);
                    }
                });

                setTimeout("K4_GetLineStatusPercent()", 1000 * 60 * 5);
            }
        </script>         

        <%--5. 计划看板系统里面有，已经做了，图中下面字体“ 车间总应到人数:129.50;实到人数:112 50;标准UPPH:18.83;实际UPPH:31.20”计划日看板下面红字不滚动，居中显示。此看板由夏经理负责更改完成。--%>
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
            (function ($) {
                $.getUrlParam = function (name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                }
            })(jQuery);
            var welcomeMsg = $.getUrlParam('welcomeMsg');
            var scrollElem_JIT;
            $("#_left_top_welcome_text").html(welcomeMsg);
            var isScroll_JIT = false;
            function _InitScroll_JIT(_S1, _S2, _W, _H, _T) {
                if (isScroll_JIT) { return false; }
                marqueesHeight_JIT = _H;
                stopScroll_JIT = false;
                scrollElem_JIT = document.getElementById(_S1);
                scrollTable_JIT = document.getElementById('data_tbody_JIT');
                if (scrollTable_JIT.offsetHeight < marqueesHeight_JIT) {
                    return;
                }
                with (scrollElem_JIT) {
                    style.width = _W;
                    style.height = marqueesHeight_JIT;
                    style.overflow = 'hidden';
                    noWrap = true;
                }
                scrollElem_JIT.onmouseover = new Function('stopScroll_JIT = true');
                scrollElem_JIT.onmouseout = new Function('stopScroll_JIT = false');
                preTop_JIT = 0;
                //currentTop = 0;
                //stopTime = 0;
                var leftElem = document.getElementById(_S2);
                var childElems = $(scrollElem_JIT).children();
                if (childElems.length > 1) {
                    $(childElems[0]).nextAll().remove();
                }
                scrollElem_JIT.appendChild(leftElem.cloneNode(true));
                pauseTime = _T;
                //setTimeout('init_srolltext()', 1000);
                init_srolltext_JIT();
            }

            function init_srolltext_JIT() {
                scrollElem_JIT.scrollTop = 0;
                scrollIntervalId = setInterval('scrollUp_JIT()', 50);
            }

            function scrollUp_JIT() {
                if (stopScroll_JIT || !isScroll_JIT) {
                    return;
                }
                preTop_JIT = scrollElem_JIT.scrollTop;

                scrollElem_JIT.scrollTop += 1;
                if (preTop_JIT == scrollElem_JIT.scrollTop) {
                    $("#data_tbody_JIT tbody").html("");
                    bulidDataTb_JIT();
                    scrollElem_JIT.scrollTop = 0;
                    scrollElem_JIT.scrollTop += 1;
                }
            }
            ////////////////////分割线//////////////////////////////
            $(document).ready(function () {
         
                //ResizeAll();
                bulidDataTb_JIT();
                //GetNowTime_JIT();
                setInterval(function () {
                    bulidDataTb_JIT();
                    //}, 1000 * 30);
                }, 1000 * 60 * 3);
            });
            function GetNowTime_JIT() {
                //$("#dateAndWeek_JIT").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
                //setTimeout("GetNowTime_JIT()", 1000);
            }

            $(window).resize(function () {
                ResizeAll_JIT();
            });

            function ResizeAll_JIT() {

                var windowHeight = $(window).height();
                var contentHeight = $("#E5_ul").height();
                $(".rows_JIT").height(contentHeight * 0.08);
                var fixTopHeight = $("#data_thead_JIT").height();
                if ($("#data_tbody_JIT").height() > (contentHeight.subtract(fixTopHeight))) {
                    $("#_layout_left_data_div_tbody_JIT").height(contentHeight - fixTopHeight);
                    _InitScroll_JIT("_layout_left_data_div_tbody_JIT", "_layout_left_data_div2_tbody_JIT", $("#_layout_left_data_div2_tbody_JIT").width(), 22, 1000 * 10);
                    isScroll_JIT = true;
                } else {
                    isScroll_JIT = false;
                    $("#_layout_left_data_div_tbody_JIT").height(contentHeight.subtract(fixTopHeight));
                    var leftElem = document.getElementById("_layout_left_data_div2_tbody_JIT");
                    var childElems = $(scrollElem_JIT).children();
                    if (childElems.length > 1) {
                        $(childElems[0]).nextAll().remove();
                    }
                }
            }


            function bulidDataTb_JIT() {
                var html = "";
                var entity = {};
                var data=null;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspKanBanStockListPrepareMaterial", JSON.stringify(entity));
                if (ajax.error != null) {
                   // confirmDialog(ajax.error.Message);
                    return false;
                }
                data = ajax.value;
            
                data = JSON.parse(data).data;
           
                if (data == null) { return false; }
                var topHtml = "";
                var normalHtml = "";
                var j = 1;
                for (var i = 0; i < data.length; i++) {


                    if (i < 5) {
                        console.log(data[i]);


                    }

                     
                    normalHtml += "  <tr class=\"rows_JIT\">"
                                         + " <th style=\"width: 14%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].生产排程工单号 + "</th>"
                                         + " <th style=\"width: 19%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].领料单号 + "</th>"
                                         + " <th style=\"width: 14%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].产品编码 + "</th>"
                                         + " <th style=\"width: 14%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].产品名称 + "</th>"
                                         + " <th style=\"width: 14%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].产线 + "</th>"
                                         + " <th style=\"width: 7%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].工单数量 + "</th>"
                                         + " <th style=\"width: 6%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].工单状态 + "</th>"
                                         + " <th style=\"width: 6%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].已备料站 + "</th>"
                                         + " <th style=\"width: 6%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].待备料站 + "</th>"
                                      + "</tr>"
                    //新盛世用的自己的字段逻辑
                    //normalHtml += "  <tr class=\"rows_JIT\">"
                    //                     + " <th style=\"width: 5%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].num + "</th>"
                    //                     + " <th style=\"width: 14%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].线体 + "</th>"
                    //                     + " <th style=\"width: 19%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].工单 + "</th>"
                    //                     + " <th style=\"width: 14%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].产品名称 + "</th>"
                    //                     + " <th style=\"width: 10%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].今日计划 + "</th>"
                    //                     + " <th style=\"width: 10%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].今日投入 + "</th>"
                    //                     + " <th style=\"width: 10%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].今日产出 + "</th>";
                    //if (data[i].发料状态 == '关键料未齐套') {
                    //    normalHtml += "<th style=\"width: 8%;word-wrap:break-word;word-break:break-all;color:red;\" class=\"thTitle\">" + data[i].发料状态 + "</td>";
                    //} else {
                    //    normalHtml += "<th style=\"width: 8%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].发料状态 + "</td>";
                    //};
                    //normalHtml += " <th style=\"width: 10%;word-wrap:break-word;word-break:break-all;\" class=\"thTitle\">" + data[i].达成率 + "</th>"
                    //      + "</tr>";
                    //pwelcomeMsg = data[i].welcome;
                }
                $("#data_tbody_JIT tbody").html(normalHtml);
                $("#_left_top_welcome_text").html(pwelcomeMsg);
                ResizeAll_JIT();
                  
              

            }
            function dateFtt(fmt, date) { //author: meizz   
                date = date.replace(/-/g, "/"); //为了兼容IE
                date = new Date(date);
                var o = {
                    "M+": date.getMonth() + 1,                 //月份   
                    "d+": date.getDate(),                    //日   
                    "h+": date.getHours(),                   //小时   
                    "m+": date.getMinutes(),                 //分   
                    "s+": date.getSeconds(),                 //秒   
                    "q+": Math.floor((date.getMonth() + 3) / 3), //季度   
                    "S": date.getMilliseconds()             //毫秒   
                };
                if (/(y+)/.test(fmt))
                    fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
                for (var k in o)
                    if (new RegExp("(" + k + ")").test(fmt))
                        fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                return fmt;
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

            function isIE() { //ie?
                if (!!window.ActiveXObject || "ActiveXObject" in window)
                    return true;
                else
                    return false;
            }

            /**
            *   播放警报音
            **/
            function playSound() {
                $('embed').remove();

                var player = "";
                if (isIE()) {
                    //IE内核浏览器         
                    player = '<embed id="player" src="../Content/sound/warn.mp3" autostart="true" hidden="true" loop="false"></embed>';

                } else {
                    //非IE内核浏览器  
                    player = '<audio  id="player" autoplay ><source src="../Content/sound/warn.mp3" ></audio>';
                }

                $("body").append(player);
            }
        </script>

        <%--6. 计划达成率按照车间每天计划达成率数据连线展示，绕线线体：取的是自动绕线A线、自动绕线B线、自动绕线C线以及手工绕线 
            这四条线的计划达成率平均值。装配线体：取的是自动装配A线、自动装配B线、自动装配C线以及手工装配B线这四条线的计划达成率平均值。
            只有2个线体2条线，取绕线和装配线的计划达成率平均值。--%>
        <script type="text/javascript">
            function K6_GetLineUPPHAverageRateDay() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { "api": "K6_GetLineUPPHAverageRateDay" },
                    dataType: "json",          
                    success: function (resultData) {
                        var xData = [];  //X轴
                        var yLine1 = [];//绕线线体
                        var yLine2 = [];//装配线体
                        var YMinValue = 0;
                        var YMaxValue = 100;

                        var seriesObj = [];
                        var entity1 = {
                            name: '绕线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity2 = {
                            name: '装配',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };
                        $.each(resultData, function (i, item) {
                            xData.push(item.Day);
                            yLine1.push(item.Line1_Rate);
                            yLine2.push(item.Line2_Rate);
                            YMinValue = item.YMinValue;
                            YMaxValue = item.YMaxValue;

                            if (yLine1.length == resultData.length) {
                                entity1.data = yLine1;
                                entity2.data = yLine2;
                            }
                        });

                        seriesObj.push(entity1);
                        seriesObj.push(entity2);

                        var option = {
                            title: {
                                text: "计划达成率趋势图",
                                x: 'center',
                                top: 1,
                                textStyle: {
                                    fontSize: 20,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    fontFamily: 'SimSun'
                                }
                            },
                            legend: {
                                orient: 'vertical',  //height有效，width无效
                                //orient: 'horizontal',    //width有效，height无效
                                y: 'center',
                                right: 10,
                                icon: 'line',
                                data: [
                                    {
                                        name: '绕线',
                                        textStyle: {
                                            color: '#0dcf69'
                                        },

                                    },
                                    {
                                        name: '装配',
                                        textStyle: {
                                            color: '#886aac'
                                        }
                                    }
                                ],
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    fontFamily: 'SimSun'
                                },
                            },
                            tooltip: {
                                trigger: 'item',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '1%',
                                right: '17%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    name: '日期',
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        textStyle: {
                                            color: '#e0e2e8',//"#378DBD",//坐标值得具体的颜色
                                            fontSize: 12,
                                            fontFamily: 'SimSun',
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    nameTextStyle: {
                                        color: '#f6f6f8',
                                        fontSize: 12,
                                        fontFamily: 'SimSun'
                                    }
                                }
                            ],
                            yAxis: [
                                {
                                    name: '达成率',
                                    type: 'value',
                                    min: YMinValue,
                                    max: YMaxValue,
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
                                        color: '#e0e2e8',//"#378DBD",
                                        formatter: '{value}%',
                                        fontSize: 12,
                                        fontFamily: 'SimSun',
                                    },
                                    nameTextStyle: {
                                        color: '#f6f6f8',
                                        fontSize: 12,
                                        fontFamily: 'SimSun'
                                    }

                                }
                            ],
                            series: seriesObj,
                            color: ['#0dcf69', '#886aac']
                        };

                        // 初始化echarts实例
                        NIOecharts6 = echarts.init(document.getElementById('NIOecharts6'));
                        // 使用刚指定的配置项和数据显示图表。
                        NIOecharts6.setOption(option);
                    }
                });

                setTimeout("K6_GetLineUPPHAverageRateDay()", 1000 * 60 * 5);
            }
        </script>

        <%--7.车间品质监控看板已做，直接挪过来使用。--%>
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
                scrollElem.appendChild(leftElem.cloneNode(true));  //update by feifeng.zhao 2023.05.04 会重叠
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

            ////////////////////////////////分割线///////////////////////////////////////
            var workshopId;

            var echart1, echart2, echart3;
            var _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            $(document).ready(function () {
                workshopId = getQueryString("workshopId");
                if (!workshopId) {
                    workshopId = -1;
                }

                //ResizeAll();
                //bulidDataTb();
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
                            //$("#dateAndWeek").html(data);
                            //$("#dateAndWeek_JIT").html(data);
                            $("#dateAndWeek_E2").html(data);
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

            //$(window).resize(function () {
            //    ResizeAll();
            //    if (echart1 != null) { echart1.resize(); }
            //    if (echart2 != null) { echart2.resize(); }
            //    if (echart3 != null) { echart3.resize(); }
            //});

            function ResizeAll() {

                //某些浏览器不兼容div自适应高度
                //$(".gauge").height($(window).height() * 0.9 * 0.27);

                //var _contentHeight = $(window).height() * 1 * 0.3;

                var _contentHeight = $("#E7_ul").height();
                $("#_layout_left_data_div_tbody").css("height", "auto");

                $(".rows").height(_contentHeight * 0.1)

                if ($(".rows").length * _contentHeight * 0.4 > _contentHeight) {
                    //$("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                    $("#_layout_left_data_div_tbody").height(180);
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
                                text: '装配不良占比（最近一周）',
                                x: 'center',
                                textStyle: {
                                    fontSize: 14,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    //textBorderColor: '#447DFE',
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 20,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                            },
                            tooltip: {
                                trigger: 'item',
                                formatter: "{b} : {c} ({d}%)"
                            },
                            legend: {
                                x: 'center',
                                y: 'bottom',
                                padding: [0, 0, 5, 0],
                                textStyle: {
                                    fontSize: 10,
                                    color: '#58B2D4'
                                },
				itemHeight:7,
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
                                    //radius: ['30%', '55%'],
                                    radius: ['12%', '30%'],
                                    center: ['50%', '30%'],
                                    //roseType: 'radius',                            
                                    label: {
                                        normal: {
                                            show: true,
                                            color: "#58B2D3",
                                            fontSize: 10,
                                            fontWeight: 'bold',
                                            formatter: "{b}：\n{d}%"
                                        },
                                        emphasis: {
                                            show: true,
                                            fontSize: 10,
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
                                text: "绕线与装配不良数（最近一周）",
                                x: 'center',
                                textStyle: {
                                    fontSize: 14,
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
                                right: '6%',
                                bottom: '3%',
                                top: '25%',
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
                                            fontSize: 10,
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
                        text: "绕线不良占比（最近一周）",
                        x: 'center',
                        textStyle: {
                            fontSize: 14,
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
                        left: 120,
                        y: 'bottom',  //上（top）、下（bottom）、居中（center）、填写数字（如:100px）
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
                        left: '1%',
                        right: '1%',
                        bottom: '3%',
			top: '20%',
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
                                    fontSize: 10,
                                },
                                formatter: function (p) {
                                    var pVal = p;
                                    var v1 = "";
                                    var v2 = "";
                                    var v3 = "";
                                    var v4 = "";
                                    var v5 = "";
                                    var v6 = "";
                                    if (p.length > 3) {
                                        v1 = p.substr(0, 3);
                                        v2 = p.substr(3);
                                        if (v2.length > 3) {
                                            v3 = v2.substr(0, 3);
                                            v4 = v2.substr(3);
                                            if (v4.length > 3) {
                                                v5 = v4.substr(0, 3);
                                                v6 = v4.substr(3);
                                                pVal = v1 + "\n" + v3 + "\n" + v5 + "\n" + v6;
                                            }
                                            else {
                                                pVal = v1 + "\n" + v3 + "\n" + v4;
                                            }                                            
                                        }
                                        else {
                                            pVal = v1 + "\n" + v2;
                                        }

                                    }
                                    return pVal;
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
                                            type: 'bar',
                                            barWidth: '20%',
                                            itemStyle: {
                                                normal: {
                                                    //color: colorList[i],//'#95CA13',
                                                    color: function (p) {
                                                        var colorList = ['#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#32E0E7', '#826A4F', '#51DE8A', '#25851D', '#ADC7B8',];
                                                        var index = p.dataIndex;
                                                        return colorList[index];
                                                    },
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
                    }
                    )()
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
                       //     html += '<tr class="rows">' +
                       //    '<th style="width: 5%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["RowID"] + '</th>' +
                       //    '<th style="width: 10%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["LineName"] + '</th>' +
                       //    '<th style="width: 17%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["ItemCode"] + '</th>' +
                       //    '<th style="width: 15%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["ItemName"] + '</th>' +
                       //    '<th style="width: 12%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["LotNo"] + '</th>' +
                       //    '<th style="width: 5%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["SendQty"] + '</th>' +
                       //    '<th style="width: 5%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["NcQty"] + '</th>' +
                       //    '<th style="width: 5%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["SamplingQty"] + '</th>' +
                       //    '<th style="width: 8%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["CheckResult"] + '</th>' +
                       //    '<th style="width: 19%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["CheckTime"] + '</th>' +
                       //'</tr>';

                            html += '<tr class="rows">' +
                           '<th style="width: 5%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["RowID"] + '</th>' +
                           '<th style="width: 20%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["LineName"] + '</th>' +
                           '<th style="width: 19%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["ItemCode"] + '</th>' +
                           '<th style="width: 20%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["ItemName"] + '</th>' +
                           '<th style="width: 20%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["LotNo"] + '</th>' +
                           '<th style="width: 8%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["SamplingQty"] + '</th>' +
                           '<th style="width: 8%;word-wrap:break-word;word-break:break-all;" class="thTitle">' + n["NcQty"] + '</th>' +
                       '</tr>';

                        })
                        $(html).appendTo($("#data_tbody tbody"));
                        ResizeAll();
                    }
                });
            }

        </script>
        
        <%--8.日UPH按照车间每天UPH数据连线展示，一共8条线按照“自动绕线A线”、 “自动绕线B线”、 “自动绕线C线”、 “手动绕线A线”、 
            “自动装配A线”、 “自动装配B线”、 “自动装配C线”、 “手动动装配B线”一共8条线。每条线对应的的每天UPH平均值取值。--%>
        <script type="text/javascript">
            function K8_GetLineUPHDay() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { "api": "K8_GetLineUPHDay" },
                    dataType: "json",          
                    success: function (resultData) {
                        var xData = [];  //X轴
                        var yLine1 = [];//自动绕线A线
                        var yLine2 = [];//自动绕线B线
                        var yLine3 = [];//自动绕线C线
                        var yLine4 = [];//手动绕线A线
                        var yLine5 = [];//自动装配A线
                        var yLine6 = [];//自动装配B线
                        var yLine7 = [];//自动装配C线
                        var yLine8 = [];//手动装配B线
                        var YMinValue = 0;
                        var YMaxValue = 100;

                        var seriesObj = [];
                        var entity1 = {
                            name: '自动绕线A线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity2 = {
                            name: '自动绕线B线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity3 = {
                            name: '自动绕线C线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity4 = {
                            name: '手动绕线A线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity5 = {
                            name: '自动装配A线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity6 = {
                            name: '自动装配B线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity7 = {
                            name: '自动装配C线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity8 = {
                            name: '手动装配B线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        $.each(resultData, function (i, item) {
                            xData.push(item.Day);
                            yLine1.push(item.Line1_Rate);
                            yLine2.push(item.Line2_Rate);
                            yLine3.push(item.Line3_Rate);
                            yLine4.push(item.Line4_Rate);
                            yLine5.push(item.Line5_Rate);
                            yLine6.push(item.Line6_Rate);
                            yLine7.push(item.Line7_Rate);
                            yLine8.push(item.Line8_Rate);
                            YMinValue = item.YMinValue;
                            YMaxValue = item.YMaxValue;

                            if (yLine1.length == resultData.length) {
                                entity1.data = yLine1;
                                entity2.data = yLine2;
                                entity3.data = yLine3;
                                entity4.data = yLine4;
                                entity5.data = yLine5;
                                entity6.data = yLine6;
                                entity7.data = yLine7;
                                entity8.data = yLine8;
                            }
                        });

                        seriesObj.push(entity1);
                        seriesObj.push(entity2);
                        seriesObj.push(entity3);
                        seriesObj.push(entity4);
                        seriesObj.push(entity5);
                        seriesObj.push(entity6);
                        seriesObj.push(entity7);
                        seriesObj.push(entity8);

                        var option = {
                            title: {
                                text: "UPH分布趋势图",
                                x: 'center',
                                top: 1,
                                textStyle: {
                                    fontSize: 20,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    fontFamily: 'SimSun'
                                }
                            },
                            legend: {
                                orient: 'vertical',  //height有效，width无效
                                //orient: 'horizontal',    //width有效，height无效
                                y: '180px',  //上（top）、下（bottom）、居中（center）、填写数字（如:100px）
                                //padding:[0,0,-10,0], // [（距离上方距离），（距离右方距离）、（距离下方距离）、（距离左方距离）]
                                right: 1,
                                icon: 'line',
                                data: [
                                    {
                                        name: '自动绕线A线',
                                        textStyle: {
                                            color: '#67e0e3'
                                        },

                                    },
                                    {
                                        name: '自动绕线B线',
                                        textStyle: {
                                            color: '#9d96f5'
                                        }
                                    },
                                    {
                                        name: '自动绕线C线',
                                        textStyle: {
                                            color: '#61a0a8'
                                        }
                                    },
                                    {
                                        name: '手动绕线A线',
                                        textStyle: {
                                            color: '#d48265'
                                        }
                                    },
                                    {
                                        name: '自动装配A线',
                                        textStyle: {
                                            color: '#91c7ae'
                                        }
                                    },
                                    {
                                        name: '自动装配B线',
                                        textStyle: {
                                            color: '#749f83'
                                        }
                                    },
                                    {
                                        name: '自动装配C线',
                                        textStyle: {
                                            color: '#ca8622'
                                        }
                                    },
                                    {
                                        name: '手动装配B线',
                                        textStyle: {
                                            color: '#bda29a'
                                        }
                                    }
                                ],
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    fontFamily: 'SimSun'
                                },
                            },
                            tooltip: {
                                trigger: 'item',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '1%',
                                right: '22%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    name: '日期',
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        textStyle: {
                                            color: '#e0e2e8',//"#378DBD",//坐标值得具体的颜色
                                            fontSize: 12,
                                            fontFamily: 'SimSun',
                                        },
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    nameTextStyle: {
                                        color: '#f6f6f8',
                                        fontSize: 12,
                                        fontFamily: 'SimSun'
                                    }
                                }
                            ],
                            yAxis: [
                                {
                                    name: 'UPH',
                                    type: 'value',
                                    min: YMinValue,
                                    max: YMaxValue,
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
                                        color: '#e0e2e8',//"#378DBD",
                                        formatter: '{value}',
                                        fontSize: 12,
                                        fontFamily: 'SimSun',
                                    },
                                    nameTextStyle: {
                                        color: '#f6f6f8',
                                        fontSize: 12,
                                        fontFamily: 'SimSun'
                                    }
                                }
                            ],
                            series: seriesObj,
                            color: ['#67e0e3', '#9d96f5', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a']
                        };

                        // 初始化echarts实例
                        NIOecharts8 = echarts.init(document.getElementById('NIOecharts8'));
                        // 使用刚指定的配置项和数据显示图表。
                        NIOecharts8.setOption(option);
                    }
                });

                setTimeout("K8_GetLineUPHDay()", 1000 * 60 * 5);
            }
        </script>

        <%--9. 合格率按照车间线体每天日合格率数据连线展示，合格率按照车间每天合格率数据连线展示。
            绕线线体：取的是自动绕线A线、自动绕线B线、自动绕线C线以及手工绕线 这四条线的合格率平均值。
            装配线体，取的是自动装配A线、自动装配B线、自动装配C线以及手工装配B线这四条线的合格率平均值。只有2个线体2条线--%>
        <script type="text/javascript">
            function K9_GetLineQualityRateDay() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { "api": "K9_GetLineQualityRateDay" },
                    dataType: "json",          
                    success: function (resultData) {
                        var xData = [];  //X轴
                        var yLine1 = [];//绕线线体
                        var yLine2 = [];//装配线体
                        var YMinValue = 0;
                        var YMaxValue = 100;

                        var seriesObj = [];
                        var entity1 = {
                            name: '绕线',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };

                        var entity2 = {
                            name: '装配',
                            type: 'line',
                            smooth: true,
                            label: {
                                normal: {
                                    fontSize: 8
                                },
                            },
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        width: 3,
                                    }
                                }
                            }
                        };
                        $.each(resultData, function (i, item) {
                            xData.push(item.Day);
                            yLine1.push(item.Line1_Rate);
                            yLine2.push(item.Line2_Rate);
                            YMinValue = item.YMinValue;
                            YMaxValue = item.YMaxValue;

                            if (yLine1.length == resultData.length) {
                                entity1.data = yLine1;
                                entity2.data = yLine2;
                            }
                        });

                        seriesObj.push(entity1);
                        seriesObj.push(entity2);

                        var option = {
                            title: {
                                text: "合格率趋势图",
                                x: 'center',
                                top: 1,
                                textStyle: {
                                    fontSize: 20,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    fontFamily: 'SimSun'
                                }
                            },
                            legend: {
                                orient: 'vertical',  //height有效，width无效
                                //orient: 'horizontal',    //width有效，height无效
                                y: 'center',
                                right: 10,                                
                                icon:'line',
                                data: [
                                    {
                                        name: '绕线',
                                        textStyle: {
                                            color: '#0dcf69'
                                        },
                                       
                                    },
                                    {
                                        name: '装配',
                                        textStyle: {
                                            color: '#886aac'
                                        }
                                    }
                                ],
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    fontFamily: 'SimSun'
                                },
                            },
                            tooltip: {
                                trigger: 'item',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '13%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    name: '日期',
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        textStyle: {
                                            color: '#e0e2e8',//"#378DBD",//坐标值得具体的颜色
                                            fontSize: 12,
                                            fontFamily: 'SimSun',
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    nameTextStyle: {
                                        color: '#f6f6f8',
                                        fontSize: 12,
                                        fontFamily: 'SimSun'
                                    }
                                }
                            ],
                            yAxis: [
                                {
                                    name: '合格率',
                                    type: 'value',
                                    min: YMinValue,
                                    max: YMaxValue,
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
                                        color: '#e0e2e8',//"#378DBD",
                                        formatter: '{value}%',
                                        fontSize: 12,
                                        fontFamily: 'SimSun',
                                    },
                                    nameTextStyle: {
                                        color: '#f6f6f8',
                                        fontSize: 12,
                                        fontFamily: 'SimSun'
                                    }

                                }
                            ],
                            //yAxis: [
                            //    {
                            //        type: 'value',
                            //        axisLine: { show: false },
                            //        axisLabel:{show:false}
                            //    }
                            //],
                            series: seriesObj,
                            //color: ['#67e0e3', '#9d96f5', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570', '#c4ccd3']
                            color: ['#0dcf69', '#886aac']
                        };

                        // 初始化echarts实例
                        NIOecharts9 = echarts.init(document.getElementById('NIOecharts9'));
                        // 使用刚指定的配置项和数据显示图表。
                        NIOecharts9.setOption(option);
                    }
                });

                setTimeout("K9_GetLineQualityRateDay()", 1000 * 60 * 5);
            }
        </script>

    </form>
</body>
</html>
