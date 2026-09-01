<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTRefluxFurnaceKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.SMTRefluxFurnaceKanban" %>

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
        .logo_skt { background: url('../../Content/images/logo/skt-logo.png') no-repeat center center; background-size: 93%; /*background-color: #0D213A;*/ }
        .table { display: table; height: 100%; width: 100%; position: relative; }
        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }
        th { height: 35px; line-height: 35px; text-align: center; font-size: 22px; color: #1AB2C7; }
        tr { height: 22px; line-height: 22px; text-align: center; font-size: 20px; color: #1AB2C7; }
        .td-tit { width: 20%; }
        .temperature { border-collapse: collapse; }
            .temperature td { border: 1px solid #fff; border-collapse: collapse; color: #fff; }
        .item-info table td { color: #fff; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 8%;">
                <li style="height: 100%;">
                    <span class="logo_cus cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 48%;">
                        <span class="cell" style="font-size: 36px; color: #FFFFFf; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">SMT回流炉实时看板</span>
                    </div>
                    <div class="table" style="float: right; width: 30%">
                        <span class="cell" style="font-size: 18px; width: 210px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                        <span class="logo_skt" style="width: 220px; height: 100%; float: right;"></span>
                    </div>
                </li>
            </ul>
            <div style="width: 100%; height: 24%; margin-bottom: 15px;">
                <div style="width: 49.5%; height: 100%; float: left; padding-left: 0.5%">
                    <img src="../../Content/images/smt-refluxfurnace.jpg" width="100%" height="100%" />
                </div>
                <div style="width: 49%; height: 100%; float: left; padding-left: 0.5%; padding-right: 0.5%" class="item-info">
                    <table style="height: 100%; width: 100%;" cellpadding="3" cellspacing="0" class="temperature">
                        <tr>
                            <td class="td-tit">产线<span></span></td>
                            <td><span id="lineName"></span></td>
                            <td class="td-tit">产品编码<span></span></td>
                            <td><span id="itemCode"></span></td>
                        </tr>
                        <tr style="height: 10px;">
                            <td colspan="4" style="border: 0px solid #fff;"></td>
                        </tr>
                        <tr>
                            <td class="td-tit">锡膏类型<span></span></td>
                            <td><span id="leadFlag"></span></td>
                            <td class="td-tit">生产面别<span></span></td>
                            <td><span id="face"></span></td>
                        </tr>
                        <tr style="height: 10px;">
                            <td colspan="4" style="border: 0px solid #fff;"></td>
                        </tr>
                        <tr>
                            <td class="td-tit">允许最大温差<span></span></td>
                            <td><span id="allowMaxTemperature"></span></td>
                            <td class="td-tit">实际最大温差<span></span></td>
                            <td><span id="actualMaxTemperature"></span></td>
                        </tr>
                        <tr style="height: 10px;">
                            <td colspan="4" style="border: 0px solid #fff;"></td>
                        </tr>
                        <tr>
                            <td class="td-tit">设定链速<span></span></td>
                            <td><span id="sp13"></span></td>
                            <td class="td-tit">实际链速<span></span></td>
                            <td><span id="pv13"></span></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="width: 100%; height: 66%;">
                <div style="width: 49.5%; height: 100%; float: left; padding-left: 0.5%;">
                    <table style="width: 100%; height: 30%;" cellpadding="3" cellspacing="0" id="topTemperatureInfo" class="temperature">
                        <thead>
                            <tr>
                                <td>温区</td>
                                <td>Z1</td>
                                <td>Z2</td>
                                <td>Z3</td>
                                <td>Z4</td>
                                <td>Z5</td>
                                <td>Z6</td>
                                <td>Z7</td>
                                <td>Z8</td>
                                <td>Z9</td>
                                <td>C1</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="set">
                                <td>上温区设定值</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="actual">
                                <td>上温区实际值</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="difference">
                                <td>差异值</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="power">
                                <td>上温区输出功率值</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <div id="topTemperatureChart" style="width: 100%; height: 70%;">
                    </div>
                </div>
                <div style="width: 49%; height: 100%; float: left; padding-left: 0.5%; padding-right: 0.5%;">
                    <table style="width: 100%; height: 30%;" cellpadding="3" cellspacing="0" id="botTemperatureInfo" class="temperature">
                        <thead>
                            <tr>
                                <td>温区</td>
                                <td>Z1</td>
                                <td>Z2</td>
                                <td>Z3</td>
                                <td>Z4</td>
                                <td>Z5</td>
                                <td>Z6</td>
                                <td>Z7</td>
                                <td>Z8</td>
                                <td>Z9</td>
                                <td>C1</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="set">
                                <td>下温区设定值</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="actual">
                                <td>下温区实际值</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="difference">
                                <td>差异值</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr class="power">
                                <td>下温区输出功率值</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <div id="botTemperatureChart" style="width: 100%; height: 70%;">
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>

        var lineId = -1;//线别
        var topSetData = [];//上温区设定值折线图数据
        var topActualData = [];//上温区实际值折线图数据
        var topDiffData = [];//上温区差异值折线图数据
        var botSetData = [];//下温区设定值折线图数据
        var botActualData = [];//下温区实际值折线图数据
        var botDiffData = [];//下温区差异值折线图数据 
        var topChart = null;//上温区折线图
        var botChart = null;//下温区折线图

        $(window).resize(function () {
            if (topChart != null) { topChart.resize(); }
            if (botChart != null) { botChart.resize(); }
        });

        $(document).ready(function () {
            lineId = getQueryString("lineId");

            //读取共享文件数据
            AddData();
            //setInterval(AddData, 1000 * 30);//测试用
            setInterval(AddData, 1000 * 60 * 1);
            

            //获取看板数据
            GetInfo();
            //setInterval(GetInfo, 1000 * 10);//测试用
            setInterval(GetInfo, 1000 * 60 * 3);
            
            //获取当前日期
            GetNowTime();

            var domTop = document.getElementById("topTemperatureChart");
            topChart = echarts.init(domTop);

            var domBot = document.getElementById("botTemperatureChart");
            botChart = echarts.init(domBot);
        });

        
        //读取共享文件数据
       function AddData() {
            $.ajax({
                type: 'POST',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SMTRefluxFurnaceKanban.ashx',
                data: { "Type": "AddSMTRefluxFurnaceKanbanData", "LineId": lineId },
                dataType: "Json",
                success: function (data) {
                    if (data) {
                    }
                }
            });
        }

        //获取数据
        function GetInfo() {
            $.ajax({
                type: 'POST',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SMTRefluxFurnaceKanban.ashx',
                data: { "Type": "GetSMTRefluxFurnaceKanban", "LineId": lineId },
                dataType: "Json",
                success: function (data) {
                    if (data && data[0]) {
                        var item = data[0];
                        var allowMaxTemperature = "";//允许最大温差
                        var sp13 = fixedOneDecimal(item.SP13);//设定链速
                        var pv13 = fixedOneDecimal(item.PV13);//实际链速
                        $("#lineName").html(item.LineName);
                        $("#itemCode").html(item.ItemCode);
                        $("#leadFlag").html(item.LeadFlag);
                        $("#face").html(item.Face);
                        switch (item.Face) {
                            case "TOP": allowMaxTemperature = item.TopMaxTemperature; break;
                            case "BOT": allowMaxTemperature = item.BotMaxTemperature; break;
                            case "TB": allowMaxTemperature = item.TBMaxTemperature; break;
                            default: break;
                        }
                        $("#allowMaxTemperature").html(allowMaxTemperature === "" ? "" : "±" + allowMaxTemperature + "℃");//允许最大温差
                        $("#sp13").html(sp13 === "" ? "" : sp13 + "cm/min");//设定链速
                        $("#pv13").html(pv13 === "" ? "" : pv13 + "cm/min");//实际链速                        

                        //上温区表格数据
                        var topTemperatureObj = $("#topTemperatureInfo tbody");
                        var topSetObj = topTemperatureObj.find("tr.set td:gt(0)");
                        var topActualObj = topTemperatureObj.find("tr.actual td:gt(0)");
                        var topDifferenceObj = topTemperatureObj.find("tr.difference td:gt(0)");
                        var topPowerObj = topTemperatureObj.find("tr.power td:gt(0)");

                        //下温区表格数据
                        var botTemperatureObj = $("#botTemperatureInfo tbody");
                        var botSetObj = botTemperatureObj.find("tr.set td:gt(0)");
                        var botActualObj = botTemperatureObj.find("tr.actual td:gt(0)");
                        var botDifferenceObj = botTemperatureObj.find("tr.difference td:gt(0)");
                        var botPowerObj = botTemperatureObj.find("tr.power td:gt(0)");

                        var index;
                        var actualMaxTemperature = "";//实际最大温差
                        var differenceVal = "";//差异值
                        for (var i = 0; i < topSetObj.length; i++) {
                            if (i == (topSetObj.length - 1)) {
                                //12表示C1
                                index = 12;
                            } else {
                                index = (i * 2) >= 12 ? (i + 1) * 2 : (i * 2);//12表示C1温区，因此超过12后，变量i需要+1
                            }

                            //上温区信息（0、2、4、6、8、10、14、16、18）
                            topSetObj[i].innerHTML = item["SP" + index];
                            topActualObj[i].innerHTML = item["PV" + index];
                            differenceVal = parseFloat(item["PV" + index]).reduce(parseFloat(item["SP" + index]));
                            topSetData.push(item["SP" + index]);//上温区折线图数据
                            topActualData.push(item["PV" + index]);//上温区折线图数据
                            topDiffData.push(differenceVal);//上温区折线图数据
                            if (actualMaxTemperature === "") {
                                actualMaxTemperature = Math.abs(differenceVal);
                            } else {
                                actualMaxTemperature = actualMaxTemperature > Math.abs(differenceVal) ? actualMaxTemperature : Math.abs(differenceVal);
                            }
                            topDifferenceObj[i].innerHTML = differenceVal;
                            if (allowMaxTemperature != "" && Math.abs(differenceVal) > allowMaxTemperature) {
                                $(topDifferenceObj[i]).css("color", "#ff0000");
                            } else {
                                $(topDifferenceObj[i]).css("color", "#fff");
                            }
                            topPowerObj[i].innerHTML = item["OP" + index];

                            //下温区信息（1、3、5、7、9、11、15、17、19）
                            if (index + 1 == 13) {
                                //13表示链速（SP 13：设定链速；  PV 13：实际链速）
                                continue;
                            }
                            botSetObj[i].innerHTML = item["SP" + (index + 1)];
                            botActualObj[i].innerHTML = item["PV" + (index + 1)];
                            differenceVal = parseFloat(item["PV" + (index + 1)]).reduce(parseFloat(item["SP" + (index + 1)]));
                            botSetData.push(item["SP" + (index + 1)]);//下温区折线图数据
                            botActualData.push(item["PV" + (index + 1)]);//下温区折线图数据
                            botDiffData.push(differenceVal);//下温区折线图数据
                            actualMaxTemperature = actualMaxTemperature > Math.abs(differenceVal) ? actualMaxTemperature : Math.abs(differenceVal);
                            botDifferenceObj[i].innerHTML = differenceVal;
                            if (allowMaxTemperature != "" && Math.abs(differenceVal) > allowMaxTemperature) {
                                $(botDifferenceObj[i]).css("color", "#ff0000");
                            } else {
                                $(botDifferenceObj[i]).css("color", "#fff");
                            }
                            botPowerObj[i].innerHTML = item["OP" + (index + 1)];
                        }
                        //获取实际最大温差
                        $("#actualMaxTemperature").html(actualMaxTemperature === "" ? "" : actualMaxTemperature + "℃");
                        if (allowMaxTemperature != "" && (actualMaxTemperature === "" ? 0 : actualMaxTemperature) > allowMaxTemperature) {
                            $("#actualMaxTemperature").css("color", "#ff0000");
                        } else {
                            $("#actualMaxTemperature").css("color", "#fff");
                        }

                        topChart.setOption(getOption(1), true);
                        botChart.setOption(getOption(0), true);

                    }
                }
            });
        }

        //获取配置
        function getOption(flag) {
            var name = flag == 1 ? "上" : "下";
            option = {
                title: {
                    text: '' + name + '温区温度实时图',
                    textStyle: {
                        color: "#fff"
                    }, top: 10
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['' + name + '温区设定值', '' + name + '温区实际值', '差异值'],
                    textStyle:
                    {
                        color: "#fff"
                    },
                    itemWidth: 45
                    , top: 15
                },
                grid: {
                    left: 30,
                    right: flag == 1 ? '2%' : 7,
                    top: 45,
                    bottom: 40
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                    axisLine: {
                        lineStyle: {
                            color: "#fff"
                        }
                    }, splitLine: {
                        show: true,
                        lineStyle: { color: "#434B53" }
                    }
                },
                yAxis: {
                    //type: 'category',
                    //boundaryGap: false,
                    //data: [-20, 10, 40, 70, 100, 130, 160, 190, 220, 250, 280, 310]
                    interval: 30,
                    min: -20,
                    max: 310,
                    axisLine: {
                        lineStyle: {
                            color: "#fff"
                        }
                    }, splitLine: {
                        show: true,
                        lineStyle: { color: "#434B53" }
                    }
                },
                series: [
                    {
                        name: '' + name + '温区设定值',
                        type: 'line',
                        smooth: true,
                        data: flag == 1 ? topSetData : botSetData//[160, 170, 180, 185, 190, 220, 250, 260, 270, 120]
                    },
                    {
                        name: '' + name + '温区实际值',
                        type: 'line',
                        smooth: true,
                        data: flag == 1 ? topActualData : botActualData//[150, 170, 180, 185, 190, 220, 250, 240, 270, 120]
                    }
                    , {
                        name: '差异值',
                        type: 'line',
                        smooth: true,
                        data: flag == 1 ? topDiffData : botDiffData//[0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0.1]
                    }
                ],
                color: ['#00B050', '#2E75B6', '#FFC000'],
                textStyle: {
                    color: "#fff"
                }
            };
            return option;
        }

        //获取URL参数值
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

        //当前日期
        function GetNowTime() {
            $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value));
            setTimeout("GetNowTime()", 1000 * 60);
        }

        //保留一位小数，不足补 0 （不四舍五入）
        function fixedOneDecimal(val) {
            if (val == null || val == "") {
                return "";
            }
            var v = Math.floor(parseFloat(val) * 10) / 10;
            var idx = v.toString().indexOf(".");
            if (idx < 0) {
                v += ".0";
            }
            return v;
        }


        //浮点型减法运算，解决js浮点型运算精确有误问题
        Number.prototype.reduce = function (arg) {
            var r1, r2, m;
            try {
                r1 = this.toString().split(".")[1].length;
            } catch (e) {
                r1 = 0;
            }
            try {
                r2 = arg.toString().split(".")[1].length;
            } catch (e) {
                r2 = 0;
            }
            m = Math.pow(10, Math.max(r1, r2));
            return (this * m - arg * m) / m;
        }

        //浮点型加法运算，解决js浮点型运算精确有误问题
        Number.prototype.add = function (arg) {
            var r1, r2, m;
            try {
                r1 = this.toString().split(".")[1].length;
            } catch (e) {
                r1 = 0;
            }
            try {
                r2 = arg.toString().split(".")[1].length;
            } catch (e) {
                r2 = 0;
            }
            m = Math.pow(10, Math.max(r1, r2));
            return (this * m + arg * m) / m;
        }

    </script>
</body>
</html>
