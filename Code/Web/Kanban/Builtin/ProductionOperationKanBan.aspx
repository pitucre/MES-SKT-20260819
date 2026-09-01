<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductionOperationKanBan.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.ProductionOperationKanBan" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <title>制造中心生产运行监控</title>
    <script type="text/javascript" src="../../../Content/Kanban/ProductionOperationKanBan/js/jquery.js"></script>
    <script src="../../../Content/Kanban/ProductionOperationKanBan/js/echarts.min.js"></script>
    <link rel="stylesheet" href="../../../Content/Kanban/ProductionOperationKanBan/css/comon0.css" />
    <%--<link rel="stylesheet" href="../../../Content/Kanban/ProductionOperationKanBan/css/toPage.css" />--%>
</head>
<script>
    $(window).load(function () {
        $(".loading").fadeOut();
    });

    /****/
    $(document).ready(function () {
        var whei = $(window).width();
        $("html").css({
            fontSize: whei / 20,
        });
        $(window).resize(function () {
            var whei = $(window).width();
            $("html").css({
                fontSize: whei / 20,
            });
        });
    });
</script>

<body>
    <form id="form1" runat="server">
        <div class="loading">
            <div class="loadbox">
                <img src="../../../Content/Kanban/ProductionOperationKanBan/picture/loading.gif" />
                页面加载中...
            </div>
        </div>
        <div class="head">
            <div></div>
            <div>
                <div>
                    <h1 style="font-size: 2.5em">车间生产运行监控</h1>
                </div>
                <div style="display: none">
                    <h2 style="font-size: 2em">workshop production operation monitoring</h2>
                </div>
            </div>
            <div></div>
        </div>

        <div class="logo">
            <div class="leftLogo">
                <img src="../../../Content/Kanban/ProductionOperationKanBan/images/leftLogo.png" style="object-fit: cover; width: 22%; height: 100%;">
            </div>
            <div class="rightLogo">
                <img src="../../../Content/Kanban/ProductionOperationKanBan/images/rightLogo.png" style="object-fit: cover;">
            </div>
        </div>
        <!-- 欢迎词-->
        <ul style="height: 10%;">
            <li style="height: 100%;">

                <div class="table">
                    <table style="width: 100%;" cellpadding="5" cellspacing="5" border="0">
                        <tr>
                            <td id="_left_top_welcome">
                                <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                    scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                    <div id="_left_top_welcome_text" style="padding-top: 5px; padding-bottom: 5px; font-size: 30px; color: red; font-weight: bold;">
                                        热烈欢迎各位领导莅临参观指导
                                    </div>
                                </marquee>
                            </td>
                        </tr>
                    </table>
                </div>
            </li>
        </ul>
        <div class="title">
            <div class="completion font_title" style="width: 50%;">
                <span>生产总完成的情况</span>
            </div>
            <div class="completion font_title" style="width: 50%;">
                <span>OEE</span>
                <div>
                    <div>
                        <img src="../../../Content/Kanban/ProductionOperationKanBan/images/temperature.png" alt="温度图标加载失败">
                    </div>
                    <div><span class="font" id="lblTemp">温度:1℃</span></div>
                    <div>
                        <img src="../../../Content/Kanban/ProductionOperationKanBan/images/humidity.png" alt="湿度图标加载失败">
                    </div>
                    <div><span class="font" id="lblTumidity">湿度:61.9℃</span></div>
                </div>
            </div>
        </div>
        <div class="efficiency">
            <div class="workOrderCompleted borders">
                <div class="border_content">
                    <div class="fontPosition">生产完成情况</div>
                    <div class="PercentageContent">
                        <div class="proportion" id="lblOrderPercentage">53%</div>
                        <div style="position: relative">
                            <div class="thirdContent">
                                <div class="capsule-item-column" id="lblOrderProgress" style="width: 50%"></div>

                            </div>
                            <div style="position: absolute; font-size: .2rem;" id="lblOrderFinishQty">125/200个</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="weightCompletionRate borders">
                <div class="border_content">
                    <div class="fontPosition">设备开机率</div>
                    <div class="PercentageContent">
                        <div class="proportion" id="lblWeightPercentage">100%</div>
                        <div style="position: relative">
                            <div class="thirdContent">
                                <div class="capsule-item-column" id="lblWeightProgress" style="width: 100%; position: relative">
                                </div>

                            </div>
                            <div style="position: absolute; font-size: .2rem;" id="lblWeightFinishQty">125/200个</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="order borders" style="width: 100%">
                <div style="height: 100%; display: flex;">
                    <div style="width: 50%;height:100%;">
                        <div id="NightingaleChart" style="height:100%"></div>
                    </div>
                    <div style="width: 50%">
                        <ul class="sec h100">
                            <li>
                                <div>
                                    <p>
                                        时间稼动率
                                    </p>
                                    <div class="barnav">
                                        <div class="bar2"><span style="width: 12.5%;" id="spwidth1"></span></div>
                                        <span id="span1">12.5</span>
                                    </div>


                                </div>
                            </li>

                            <li>
                                <div>
                                    <p>
                                        OEE
                                    </p>

                                    <div class="barnav">
                                        <div class="bar2"><span style="width: 25.3%;" id="spwidth2"></span></div>
                                        <span id="span2">25.3</span>
                                    </div>
                                </div>
                            </li>

                            <li>
                                <div>
                                    <p>
                                        合格率
                                    </p>
                                    <div class="barnav">
                                        <div class="bar2"><span style="width: 35.2%;" id="spwidth3"></span></div>
                                        <span id="span3">35.2</span>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>


                <%-- <div id="NightingaleChart"></div>--%>
            </div>
        </div>
        <div class="efficiency" style="height: 25vh; margin-top: 10px; display: block;">
            <div style="text-align: center; padding: 0.1rem 0;">每小时产能</div>
            <div id="Histogram"></div>
        </div>
        <div class="title_xx">
            <div>工单生产明细</div>
            <div>生产状况统计</div>
        </div>
        <div class="tableandraido">
            <div class="table" id="table">
                <div class="row" style="color: #02c694;">
                    <div class="bilingual">
                        <div class="chinese">工单号</div>
                    </div>
                    <div>
                        <div class="bilingual">
                            <div class="chinese">产品型号</div>
                        </div>
                    </div>
                    <div>
                        <div class="bilingual">
                            <div class="chinese">数量</div>
                        </div>
                    </div>
                    <div>
                        <div class="bilingual">
                            <div class="chinese">生产状态</div>
                        </div>
                    </div>
                    <div>
                        <div class="bilingual">
                            <div class="chinese">计划开工时间</div>
                        </div>
                    </div>
                </div>
                <div class="contentRows" style="height: 100%; overflow-y: auto" id="table1">
                </div>
            </div>
            <div class="radiu">
                <div class="boxradius">
                    <div class="boxradiuss" id="lblSalOrder">5000</div>
                    <p class="titles">
                        生产数量

                </div>
                <div class="boxradius">
                    <div class="boxradiuss" id="lblOrderCount">450</div>
                    <p class="titles">
                        检验数量
                </div>
                <div class="boxradius">
                    <div class="boxradiuss" id="lblTestCount">350</div>
                    <p class="titles">
                        入库数量
                </div>
            </div>
        </div>
        <div class="foot">
            <div></div>
            <h1></h1>
            <div></div>
        </div>

        <script src="../../../Content/Kanban/ProductionOperationKanBan/js/storage.js"></script>
        <script type="text/javascript">
            var stopScroll = false;
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
            $("#_left_top_welcome_text").html(welcomeMsg);
        </script>
        <script>
            let autoScrollInterval = null;
            var timeInterval = 1000 * 60 * 2;
            var scrollContainer = document.getElementById("table1");
            var procedure = 'uspProductionOperationKanBan'
            $(document).ready(() => {
                init();
                //var myChart = echarts.init(document.getElementById('NightingaleChart'));
                //var myChart1 = echarts.init(document.getElementById('Histogram'));
                window.addEventListener("resize", () => {
                    //myChart.resize();
                    myChart1.resize()
                })
            })
            setInterval(function () {
                window.location.reload();
            }, 1000 * 60 * 60 * 2);

            function autoScroll() {
                if (autoScrollInterval !== null) {
                    return; // Prevent starting multiple timers
                }
                autoScrollInterval = setInterval(() => {
                    const { scrollTop, scrollHeight, clientHeight } = scrollContainer;
                    if (scrollTop + clientHeight >= scrollHeight - 1) {
                        scrollContainer.scrollTop = 0; // Reset to top when reaching bottom
                    } else {
                        scrollContainer.scrollTop += 1; // Scroll down by 1px
                    }
                }, 50); // Adjust the interval as needed
            }
            function stopAutoScroll() {
                if (autoScrollInterval !== null) {
                    clearInterval(autoScrollInterval);
                    autoScrollInterval = null;
                }
            }
            scrollContainer.addEventListener("mouseenter", stopAutoScroll);
            scrollContainer.addEventListener("mouseleave", autoScroll);

            function init() {
                var entity = {}
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspProductionOperationKanBan", JSON.stringify(entity))
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var json = JSON.parse(ajax.value)

                // 工单完成率
                $("#lblOrderPercentage").html(json.data[0].Percentage)
                $("#lblOrderProgress").attr({ "style": "width:" + json.data[0].Percentage + "" })
                $("#lblOrderFinishQty").html(json.data[0].Qty_Released + '/' + json.data[0].Qty_to_Build + '个')

                //设备的开机率
                $("#lblWeightPercentage").html(json.data1[0].Percentage)
                $("#lblWeightProgress").attr({ "style": "width:" + json.data1[0].Percentage + "" })
                $("#lblWeightFinishQty").html(json.data1[0].StartEquipmentCount + '/' + json.data1[0].AllEquipmentCount + '台')
                // 时间稼动率
                $("#span1").text(json.data3[0]["Availability"])
                $("#spwidth1").css('width', json.data3[0]["Availability"] + '%'); 
                //OEE
                $("#span2").text(json.data3[0]["Performance"])
                $("#spwidth2").css('width', json.data3[0]["Performance"] + '%');
                //质量合格率
                $("#span3").text(json.data3[0]["Quality"])
                $("#spwidth3").css('width', json.data3[0]["Quality"] + '%');

                //生产数量
                $("#lblSalOrder").text(json.data4[0]["ProductCount"]);
                //检验数量
                $("#lblOrderCount").text(json.data4[0]["TestCount"]);
                //入库数量
                $("#lblTestCount").text(json.data4[0]["OutStockCount"])

                // 列表
                AddTableDetail(json.data2)

                //$.each(json.data2, function (index, value) {
                //    $("<tr'>" +
                //        "<td>" + value.OrderNO + "</td>" +
                //        "<td>" + value.ItemCode + "</td>" +
                //        "<td>" + value.Qty_to_Build + "</td>" +
                //        "<td>" + value.StatusName + "</td>" +
                //        "<td>" + value.Planned_Start_Time + "</td>" +
                //        "</tr>").appendTo($("#StayDoneTable tbody"));
                //});
                //if (timer) {
                //    clearTimeout(timer)
                //}
                //startRoll(50, "#StayDoneTable tbody")  //50为时间

                // 饼图
                //option.series[0].data = [{
                //    value: 100,
                //    name: '中（≥60KG）\n Medium (≥60KG)',
                //    itemStyle: {
                //        normal: {
                //            borderWidth: 4,
                //            shadowBlur: 100,
                //        }
                //    }
                //},
                //{
                //    value: 60,
                //    name: '小（＜60KG）\n Small (<60KG)',
                //    itemStyle: {
                //        normal: {
                //            borderWidth: 4,
                //            shadowBlur: 100,
                //        }
                //    }
                //},
                //{
                //    value: 70,
                //    name: "大(≥330KG）\n Large (≥330KG)",
                //    itemStyle: {
                //        normal: {
                //            borderWidth: 4,
                //            shadowBlur: 100,
                //        }
                //    }
                //},
                //]
                // 柱状图
                //option1.series[0].data = [310, 369, 220, 700, 220, 400, 220]
                //option1.series[1].data = [310, 369, 220, 700, 220, 400, 220]
                //option1.series[2].data = [310, 369, 220, 700, 220, 400, 220]
                //数量时间段获取
                //option1.xAxis[0].data = ["08:00","09:00","10:00","11:00","12:00","13:00","14:00"];

                //myChart.setOption(option);
                option.title.text = 'OEE \n\n' + json.data3[0]["OEE"] + "%";
                option.series.data = [json.data3[0]["OEE"]];
                myChart.setOption(option);

                debugger
                option1.xAxis[0].data = json.data5.map(item => item.TimeStr)
                option1.series[0].data = json.data5.map(item => item.OrderQty)
                //option1.series[1].data = json.data5.map(item => item.ProductQty)
                //option1.series[2].data = json.data5.map(item => item.Rate)


                myChart1.setOption(option1);

                setTimeout("init()", timeInterval)
            }

            // 添加列表数据
            function AddTableDetail(data) {
                var str = ""
                $("#table1").html(str);
                for (var i = 0; i < data.length; i++) {
                    str += "<div  class=\"row\"> <div> " + data[i].OrderNO + "</div > <div>" + data[i].ItemCode + "</div> <div>" + data[i].Qty_to_Build + "</div> <div>" + data[i].StatusName + "</div> <div>" + data[i].Planned_Start_Time + "</div> </div > "
                }
                if (str) {
                    $("#table1").html(str);
                    scrollContainer = document.getElementById("table1");
                    autoScroll();
                }
            }

        </script>
    </form>

</body>

</html>



