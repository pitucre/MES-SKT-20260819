<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IQCPassRateAndBadDistributionKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.IQCPassRateAndBadDistributionKanban" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 16px; overflow: hidden; }
        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; /*border: 1px solid #38FFFF;*/ }
        .logo_cus { background: url('../../Content/images/logo/logo.png') no-repeat 15px center; background-size: 94%; /*background-color: #0D213A;*/ }
        .logo_cus2 { background: url('../../Content/images/logo/skt-logo.png') no-repeat 15px center; background-size: 90%; }
        .table { display: table; height: 100%; width: 100%; position: relative; }
        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }
        /*th { height: 35px; line-height: 35px; text-align: center; font-size: 20px; color: #1ab2c7; }
        tr { height: 22px; line-height: 22px; text-align: center; font-size: 18px; color: #38FFFF; }*/
        .thTitle { font-size: 20px; color: #fff; }
        .chart-tit { font-size: 20px; color: #fff; font-weight: bold; text-align: center; text-shadow: 3px 2px 8px #5a5af7; }

        #div1 { display: black; width: 110px; height: 50px; line-height: 50px; white-space: nowrap; overflow: hidden; background-color: #a2a2a2; margin: 15px; padding: 5px 15px; }
        span { display: inline-block; color: #fff; padding-right: 20px; }
        #ng-detail tr { font-size: 16px; color: #37f6fe; }
            #ng-detail tr td { text-align: center; height: 25px; line-height: 25px; border: 1px solid #2E2A32; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 8%;">
                <li style="height: 100%;">
                    <span class="logo_cus2 cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 57%;">
                        <span class="cell" style="font-size: 36px; color: #38FFFF; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">IQC合格率及不良分布看板</span>
                    </div>
                    <div class="table" style="float: right; width: 19%;">
                        <span class="cell" style="font-size: 18px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>

            <!--IQC来料合格率-->
            <div style="height: 37%;">
                <div id="iqcQualifiedRate" style="width: 100%; height: 100%"></div>
            </div>

            <%--<div style="height: 5%;">
                <div style="position: relative; top: 30%; height: 5px; background-color: #000; margin: 20px 0px"></div>
            </div>--%>

            <!--IQC来料来料不良分布-->
            <div class="distribute" style="height: 48%; margin-top:15px;">
                <div class="ng-chart-info">
                    <div id="ngDistribute" style="width: 100%; height: 100%"></div>
                </div>
                <div class="ng-list-info">
                    <table id="ng-detail" style="width: 100%; padding-left: 4.5%; padding-right: 6.5%; position: relative; ">
                    </table>
                </div>
            </div>

            <div style="height: 7%;">
                <div class="table" style="border-top: 5px solid #000000;">
                    <table style="width: 100%; height: 100%;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td id="_left_top_welcome">
                                <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                    scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                    <%--<div id="_left_top_welcome_text" style="margin-top: -2px;min-height:30px;line-height:30px;font-size: 30px; color: red; font-weight: bold;">
                                        热烈欢迎各位领导莅临参观指导
                                    </div>--%>
                                    <div id="_left_top_welcome_text" style="font-size: 30px; color: red; font-weight: bold;">
                                        <%--热烈欢迎各位领导莅临参观指导--%>
                                    </div>
                                </marquee>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <script type="text/javascript">
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

        </script>

        <script type="text/javascript">
            var chartQualifiedRate = null;
            var chartNGDistribute = null;

            $(document).ready(function () {
                //IQC来料合格率
                QualifiedRateData();

                //来料不良分布
                NGDistribute();

                //获取时间
                GetNowTime();
            });

            function GetNowTime() {
                $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value));
                setTimeout("GetNowTime()", 1000 * 60);
            }

            $(window).resize(function () {
                //动态设置来料不良分布层高度
                calcDistributeHeigh();
                if (chartQualifiedRate != null) { chartQualifiedRate.resize(); }
                if (chartNGDistribute != null) { chartNGDistribute.resize(); }
            });

            function fmtDate(obj) {
                obj = obj.replace(new RegExp(/-/gm), "/"); 　　//将所有的'-'转为'/'即可
                var date = new Date(obj);
                var y = date.getFullYear();
                var m = "0" + (date.getMonth() + 1);
                var d = "0" + date.getDate();
                return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
            }

            //IQC来料合格率 
            function QualifiedRateData() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { "api": "GetIQCPassRateAndBadDistributionKanbanInCome" },
                    dataType: "json",
                    //contentType: "application/json; charset=utf-8",                    
                    success: function (iqcData) {
                        //IQC来料合格率
                        var xData = [];
                        var yDataActual = [];//合格比率
                        var yDataTarget = [];//目标合格率

                        var seriesObj = [];
                        var entityActual = {
                            name: '合格率',
                            type: 'line',
                            label: {
                                normal: {
                                    show: true,
                                    position: 'top',
                                    formatter: '{c} %',
                                    fontSize: 13
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
                        var entityTarget =
                            {
                                name: '目标合格率',
                                type: 'line',
                                label: {
                                    normal: {
                                        show: true,
                                        position: 'right',
                                        formatter: function (params) {
                                            var result = "";
                                            if (params.dataIndex == 11) {
                                                result = params.data + '%';
                                            }
                                            return result;
                                        },
                                        //formatter: params => {
                                        //    var result = "";
                                        //    if (params.dataIndex == 11) {
                                        //        result = params.data + '%';
                                        //    }
                                        //    return result;
                                        //},
                                        fontSize: 13,
                                        fontStyle: 'oblique',
                                        fontWeight: 'bold'
                                    },


                                },
                                itemStyle: {
                                    normal: {
                                        lineStyle: {
                                            width: 3,
                                        }
                                    }
                                },

                            };

                        $.each(iqcData, function (i, item) {
                            xData.push(item.Month);
                            yDataActual.push(item.QualifiedRate);
                            yDataTarget.push(item.TargetQualifiedRate);

                            if (yDataActual.length == iqcData.length) {
                                entityActual.data = yDataActual;
                                entityTarget.data = yDataTarget;
                            }
                        });

                        seriesObj.push(entityTarget);
                        seriesObj.push(entityActual);

                        // 初始化echarts实例
                        chartQualifiedRate = echarts.init(document.getElementById('iqcQualifiedRate'));

                        var option = {
                            title: {
                                text: "IQC来料合格率",
                                x: 'center',
                                top: 5,
                                textStyle: {
                                    fontSize: 22,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                }
                            },
                            legend: {
                                top: 5,
                                right: 100,
                                itemWidth: 40,
                                data: [
                                    {
                                        name: '合格率',
                                        textStyle: {
                                            color: '#9d96f5'
                                        }
                                    },
                                    {
                                        name: '目标合格率',
                                        textStyle: {
                                            color: '#37f6fe'
                                        }
                                    }
                                ],
                                textStyle: {
                                    //color: '#37f6fe',
                                    fontSize: 16,
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
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        textStyle: {
                                            color: '#37f6fe',//"#378DBD",//坐标值得具体的颜色
                                            fontSize: 16,
                                        },
                                        formatter: '{value} 月',
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
                            series: seriesObj,
                            color: ['#67e0e3', '#9d96f5', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570', '#c4ccd3']
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartQualifiedRate.setOption(option);
                    }
                });

                setTimeout("QualifiedRateData()", 1000 * 60 * 5);
            }


            //来料不良分布
            function NGDistribute() {

                //获取当前年月
                var yearMonth = $.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDate(10).value);

                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                    data: { "api": "GetIQCPassRateAndBadDistributionKanbanNGDistribute" },
                    dataType: "json",
                    //contentType: "application/json; charset=utf-8",                    
                    success: function (ngData) {
                        //IQC来料不良分布
                        var xData = [];
                        var yDataNGQty = [];//不合格批次
                        var yDataCumulativeRate = [];//累积比例
                        var seriesObj = [];

                        var ngHtml = "<tr>";//不良批次
                        var crHtml = "<tr>";//累积比例

                        $.each(ngData, function (i, item) {

                            xData.push(item.CategoryOne);
                            yDataNGQty.push(item.NGQty);
                            ngHtml += "<td>" + (i == 0 ? "<div style='position:absolute; left:0px; color: #37f6fe; padding:0px; width:90px; text-align:center;'>不合格批次</div>" : "") + item.NGQty + "</td>";
                            if (yDataCumulativeRate.length < 10) {
                                yDataCumulativeRate.push(item.CumulativeRate);
                                crHtml += "<td>" + (i == 0 ? "<div style='position:absolute; left:0px; color: #37f6fe; padding:0px; width:90px; text-align:center;'>累积比例</div>" : "") + item.CumulativeRate + "%</td>";
                            } else {
                                crHtml += "<td></td>";
                            }
                        });
                      
                        ngHtml += "</tr>";
                        crHtml += "</tr>";
                        $("#ng-detail").html(ngHtml + crHtml);
                        $("#ng-detail td").width($("#ng-detail").width() / 11);

                        //动态设置来料不良分布层高度
                        calcDistributeHeigh();

                        // 初始化echarts实例
                        chartNGDistribute = echarts.init(document.getElementById('ngDistribute'));

                        var titleText;
                        if (yearMonth) {
                            var year = yearMonth.substring(0, 4);
                            var month = yearMonth.substring(4);
                            titleText = year.toString() + "年" + month + "月来料不良分布";
                        } else {
                            titleText = "来料不良分布";
                        }

                        var option = {
                            title: {
                                text: titleText,
                                x: 'center',
                                top: 15,
                                textStyle: {
                                    fontSize: 22,
                                    color: '#F1F1F2',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
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
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            color: ['#37f6fe'],
                            legend: {
                                top: 15,
                                right: 160,
                                itemWidth: 40,
                                //data: ['不合格批次', '累积比例'],
                                data: [{
                                    name: '不合格批次',
                      
                                    textStyle: {
                                        color: '#37f6fe'
                                    }
                                },
                                    {
                                        name: '累积比例',
                                        textStyle: {
                                            color: '#9d96f5'
                                        }
                                    }],
                                textStyle: {
                                    fontSize: 16,
                                },
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisPointer: {
                                        type: 'shadow'
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: ['#378DBD'],
                                        }
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        textStyle: {
                                            color: '#37f6fe',//"#378DBD",
                                            fontSize: 16,
                                        }
                                    },
                                },
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    name: '不合格数量',
                                    nameTextStyle: {
                                        color: '#37f6fe',
                                        fontSize: 14
                                    },
                                    min: 0,
                                    max: 100,
                                    interval: 10,
                                    axisLine: {
                                        lineStyle: {
                                            color: ['#378DBD'],
                                        }
                                    },
                                    axisLabel: {
                                        color: '#37f6fe',//"#378DBD",
                                        formatter: '{value} ',
                                        fontSize: 14
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#2e2a32',//'#1f1529',
                                        }
                                    },
                                },
                                {
                                    type: 'value',
                                    name: '累积比例',
                                    nameTextStyle: {
                                        color: '#9d96f5',
                                        fontSize: 14
                                    },
                                    min: 0,
                                    max: 120,
                                    interval: 20,
                                    axisLine: {
                                        //lineStyle: {
                                        //    color: ['#378DBD'],
                                        //},
                                    },
                                    axisLabel: {
                                        color: '#9d96f5',//"#378DBD",
                                        formatter: '{value} %',
                                        fontSize: 14,
                                    },
                                    splitLine: {
                                        show: false,
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    },
                                }
                            ],
                            series: [
                                {
                                    name: '不合格批次',
                                    type: 'bar',
                                    data: yDataNGQty,
                                    itemStyle: {
                                        normal: {
                                            //color: '#37f6fe'
                                            color: function (params) {
                                                //如果颜色太少的话，后面颜色不会自动循环，最好多定义几个颜色
                                                //var colorList = ['#32c5e9', '#c23531', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622'];
                                                var colorList = ['#37f6fe', '#37f6fe', '#37f6fe', '#37f6fe', '#37f6fe', '#37f6fe', '#37f6fe', '#37f6fe', '#37f6fe', '#37f6fe', '#ca8622'];
                                                return colorList[params.dataIndex]
                                            }
                                        }
                                    }, label: {
                                        normal: {
                                            show: true,
                                            position: 'top',
                                            fontSize: 14
                                        }
                                    },
                                },
                                {
                                    name: '累积比例',
                                    type: 'line',
                                    yAxisIndex: 1,
                                    data: yDataCumulativeRate,
                                    color: ['#467dfc'],//['#42f9a4'],
                                    itemStyle: {
                                        normal: {
                                            lineStyle: {
                                                width: 3,
                                                //color: "#67e0e3"
                                            }
                                        }
                                    }
                                }
                            ],
                            //color: ['#32c5e9', '#ff9f7f', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570']  
                        };

                        /*注册ECHARTS*/
                        chartNGDistribute.setOption(option, true);

                    }
                });

                setTimeout("NGDistribute()", 1000 * 60 * 5);
            }

            //动态设置来料不良分布层高度
            function calcDistributeHeigh() {
                var distributeHeight = $(".distribute").height();//来料不良图形及table高度
                var ngListHeight = $(".ng-list-info").height();//table高度
                $(".ng-chart-info").height(distributeHeight.subtract(ngListHeight));//来料不良图形高度
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
    </form>
</body>
</html>
