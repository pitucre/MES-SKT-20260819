<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PTHWaveSolderingKanBak.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.PTHWaveSolderingKanBak" %>


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
            .temperature th, .temperature td { border: 1px solid #fff; border-collapse: collapse; color: #fff; }
        .item-info table td { color: #fff; }
        .temperature td.red { color: #ff0000; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 8%;">
                <li style="height: 100%;">
                    <span class="logo_cus cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 48%;">
                        <span class="cell" style="font-size: 36px; color: #FFFFFf; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">PTH波峰焊实时看板</span>
                    </div>
                    <div class="table" style="float: right; width: 30%">
                        <span class="cell" style="font-size: 18px; width: 210px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                        <span class="logo_skt" style="width: 220px; height: 100%; float: right;"></span>
                    </div>
                </li>
            </ul>
            <div style="width: 100%; height: 36%; margin-bottom: 15px;">
                <div style="width: 49.5%; height: 100%; float: left; padding-left: 0.5%">
                    <img src="../../Content/images/pth-wavesoldering.jpg" width="100%" height="100%" />
                </div>
                <div style="width: 49%; height: 100%; float: left; padding-left: 0.5%; padding-right: 0.5%" class="item-info">
                    <table style="height: 100%; width: 100%;" cellpadding="3" cellspacing="0" class="temperature">
                        <tr>
                            <td class="td-tit">产线<span></span></td>
                            <td><span id="lineName"></span></td>
                            <td class="td-tit">产品编码<span></span></td>
                            <td><span id="itemCode"></span></td>
                        </tr>
                        <tr>
                            <td class="td-tit">锡炉类型<span></span></td>
                            <td><span id="stoveType"></span></td>
                            <td class="td-tit">锡膏类型<span></span></td>
                            <td><span id="leadFlag"></span></td>
                        </tr>
                        <tr>
                            <td class="td-tit">设定运输速度<span></span></td>
                            <td><span id="setSpeed"></span></td>
                            <td class="td-tit">实际运输速度<span></span></td>
                            <td><span id="actualSpeed"></span></td>
                        </tr>
                        <tr>
                            <td class="td-tit">允许最大温差<span></span></td>
                            <td><span id="allowMaxTemperature"></span></td>
                            <td class="td-tit">实际最大温差<span></span></td>
                            <td><span id="actualMaxTemperature"></span></td>
                        </tr>
                        <tr>
                            <td class="td-tit">波峰1设定参数<span></span></td>
                            <td><span id="peakSet1"></span></td>
                            <td class="td-tit">波峰1实际参数<span></span></td>
                            <td><span id="peakActual1"></span></td>
                        </tr>
                        <tr>
                            <td class="td-tit">波峰2设定参数<span></span></td>
                            <td><span id="peakSet2"></span></td>
                            <td class="td-tit">波峰2实际参数<span></span></td>
                            <td><span id="peakActual2"></span></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="width: 100%; height: 53%;">
                <div style="width: 49.5%; height: 100%; float: left; padding-left: 0.5%;">
                    <table style="width: 100%; height: 100%;" cellpadding="3" cellspacing="0" id="temperatureInfo" class="temperature">
                        <tbody>
                            <tr style="max-height: 10%" class="tit">
                                <td>波峰焊温区</td>
                                <td>设定值(℃)</td>
                                <td>实际值(℃)</td>
                                <td>差异值(℃)</td>
                                <td>运行状态</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div style="width: 49%; height: 100%; float: left; margin-left: 0.5%; border: 1px solid #fff">
                    <div id="temperatureChart" style="width: 100%; height: 100%;">
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>

        var lineId = -1;//线别
        var setData = [];//设定值柱状线图数据
        var actualData = [];//设定值柱状图数据
        var pthChart = null;//PTH波峰焊看板柱状图

        $(window).resize(function () {
            if (pthChart != null) { pthChart.resize(); }
        });

        $(document).ready(function () {
            lineId = getQueryString("lineId");

            //读取共享文件数据
            AddData();
            //setInterval(AddData, 1000 * 30);//测试用
            setInterval(AddData, 1000 * 60 * 1);            

            //获取看板数据
            GetInfo();
            //setInterval(GetInfo, 1000 * 5);//测试用
            setInterval(GetInfo, 1000 * 60 * 3);
            
            //获取当前日期
            GetNowTime();

            var dom = document.getElementById("temperatureChart");
            pthChart = echarts.init(dom);
        });

        //读取共享文件数据
        function AddData() {
            $.ajax({
                type: 'POST',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/PTHWaveSolderingKanban.ashx',
                data: { "Type": "AddPTHWaveSolderingKanbanData", "LineId": lineId },
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
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/PTHWaveSolderingKanban.ashx',
                data: { "Type": "GetPTHWaveSolderingKanban", "LineId": lineId },
                dataType: "Json",
                success: function (data) {
                    if (data && data[0]) {
                        //$("#temperatureInfo tbody").html("<tr><td>波峰焊温区</td><td>设定值(℃)</td><td>实际值(℃)</td><td>差异值(℃)</td><td>运行状态</td></tr>");
                        $("#temperatureInfo tbody tr:not(.tit)").remove();

                        setData = [];//设定值柱状线图数据
                        actualData = [];//设定值柱状图数据

                        var item = data[0];
                        var allowMaxTemperature = item.AllowMaxTemperature;//允许最大温差
                        //var actualMaxTemperature = 0;//实际最大温差
                        //var diffValue =0;
                        $("#lineName").html(item.LineName);
                        $("#stoveType").html(item.StoveType);
                        $("#itemCode").html(item.ItemCode);
                        $("#leadFlag").html(item.LeadFlag);
                        $("#setSpeed").html(item.SetSpeed + "mm/min");
                        $("#actualSpeed").html(item.ActualSpeed == -1 ? "未启动" : item.ActualSpeed + "mm/min");
                        $("#allowMaxTemperature").html(allowMaxTemperature === "" ? "" : "±" + allowMaxTemperature + "℃");//允许最大温差
                        $("#peakSet1").html(item.PeakSet1 + "HZ");//波峰1设定参数
                        $("#peakActual1").html(item.PeakActual1 == -1 ? "未启动" : item.PeakActual1 + "HZ");//波峰1实际参数
                        $("#peakSet2").html(item.PeakSet2 + "HZ");//波峰2设定参数
                        $("#peakActual2").html(item.PeakActual2 == -1 ? "未启动" : item.PeakActual2 + "HZ");//波峰2实际参数

                        //波峰焊温区表格数据
                        //var obj = getTemperature(item.TinFurnaceStatus, item.TinFurnaceSet, item.TinFurnaceActual, allowMaxTemperature, actualMaxTemperature);
                        //actualMaxTemperature = obj.ActualMaxTemperature;//实际最大温差
                        //var cls = Math.abs(item.ActualMaxTemperature) > 
                        //var hl = "<tr><td>锡炉</td><td>" + item.TinFurnaceSet + "</td><td>" + item.TinFurnaceActual + "</td><td class=\"" + obj.Class + "\">" + (item.TinFurnaceActual - item.TinFurnaceSet) + "</td><td>" + item.TinFurnaceStatus + "</td></tr>";
                        var hl = "<tr><td>锡炉</td><td>" + item.TinFurnaceSet + "</td><td>" + item.TinFurnaceActual + "</td><td class=\"" + getClass(item.TinFurnaceStatus, item.TinFurnaceSet, item.TinFurnaceActual, allowMaxTemperature) + "\">" + (item.TinFurnaceActual - item.TinFurnaceSet) + "</td><td>" + item.TinFurnaceStatus + "</td></tr>";
                        setData.push(item.TinFurnaceSet);
                        actualData.push(item.TinFurnaceActual);
                        var face = "B";
                        for (var i = 1; i <= 3; i++) {
                            //var obj = getTemperature(item["PreheatAreaStatus" + i + face], item["PreheatAreaSet" + i + face], item["PreheatAreaActual" + i + face], allowMaxTemperature, actualMaxTemperature);
                            //actualMaxTemperature = obj.ActualMaxTemperature;//实际最大温差
                            //hl += "<tr><td>预热区" + i + face + "</td><td>" + item["PreheatAreaSet" + i + face] + "</td><td>" + item["PreheatAreaActual" + i + face] + "</td><td class=\"" + obj.Class + "\">" + (item["PreheatAreaActual" + i + face] - item["PreheatAreaSet" + i + face]) + "</td><td>" + item["PreheatAreaStatus" + i + face] + "</td></tr>";
                            hl += "<tr><td>预热区" + i + face + "</td><td>" + item["PreheatAreaSet" + i + face] + "</td><td>" + item["PreheatAreaActual" + i + face] + "</td><td class=\"" + getClass(item["PreheatAreaStatus" + i + face], item["PreheatAreaSet" + i + face], item["PreheatAreaActual" + i + face], allowMaxTemperature) + "\">" + (item["PreheatAreaActual" + i + face] - item["PreheatAreaSet" + i + face]) + "</td><td>" + item["PreheatAreaStatus" + i + face] + "</td></tr>";

                            setData.push(item["PreheatAreaSet" + i + face]);
                            actualData.push(item["PreheatAreaActual" + i + face]);

                            if (i == 3) {
                                //var obj = getTemperature(item["SprayAreaStatus" + face], item["SprayAreaSet" + face], item["SprayAreaActual" + face], allowMaxTemperature, actualMaxTemperature);
                                //actualMaxTemperature = obj.ActualMaxTemperature;//实际最大温差
                                //hl += "<tr><td>喷雾区" + face + "</td><td>" + item["SprayAreaSet" + face] + "</td><td>" + item["SprayAreaActual" + face] + "</td><td class=\"" + obj.Class + "\">" + (item["SprayAreaActual" + face] - item["SprayAreaSet" + face]) + "</td><td>" + item["SprayAreaStatus" + face] + "</td></tr>";
                                hl += "<tr><td>喷雾区" + face + "</td><td>" + item["SprayAreaSet" + face] + "</td><td>" + item["SprayAreaActual" + face] + "</td><td class=\"" + getClass(item["SprayAreaStatus" + face], item["SprayAreaSet" + face], item["SprayAreaActual" + face], allowMaxTemperature) + "\">" + (item["SprayAreaActual" + face] - item["SprayAreaSet" + face]) + "</td><td>" + item["SprayAreaStatus" + face] + "</td></tr>";

                                setData.push(item["SprayAreaSet" + face]);
                                actualData.push(item["SprayAreaActual" + face]);
                                if (face == "B") {
                                    face = "T";
                                    i = 0;
                                }
                            }
                        }
                        //获取实际最大温差
                        //$("#actualMaxTemperature").html(actualMaxTemperature + "℃");
                        //if (allowMaxTemperature != "" && Math.abs(actualMaxTemperature) > allowMaxTemperature) {
                        //    $("#actualMaxTemperature").css("color", "#ff0000");
                        //} else {
                        //    $("#actualMaxTemperature").css("color", "#fff");
                        //}
                        $("#actualMaxTemperature").html(item.ActualMaxTemperature + "℃");
                        if (allowMaxTemperature != "" && Math.abs(item.ActualMaxTemperature) > allowMaxTemperature) {
                            $("#actualMaxTemperature").css("color", "#ff0000");
                        } else {
                            $("#actualMaxTemperature").css("color", "#fff");
                        }
                        $("#temperatureInfo tbody").append(hl);

                        pthChart.setOption(getOption(), true);
                    }
                }
            });
        }

        /*
            获取实际最大温差、是否标红

            参数信息：
            status：运行状态
            set：设定值
            actual：实际值
            allowMaxTemperature：允许最大温差
            actualMaxTemperature：实际最大温差
        */
        function getTemperature(status, set, actual, allowMaxTemperature, actualMaxTemperature) {
            var obj = {};
            obj.Class = "";
            obj.ActualMaxTemperature = actualMaxTemperature;

            if (status == "恒温工作") {
                if (Math.abs(actual - set) > Math.abs(actualMaxTemperature)) {
                    obj.ActualMaxTemperature = actual - set;
                }
                if (allowMaxTemperature != "" && Math.abs(actual - set) > allowMaxTemperature) {
                    obj.Class = "red";
                }
            }
            return obj;
        }

        //获取样式
        function getClass(status, set, actual, allowMaxTemperature) {
            if (status != "恒温工作" || allowMaxTemperature == "") {
                return "";
            }
            return Math.abs(actual - set) > allowMaxTemperature ? "red" : "";
        }

        //获取配置
        function getOption() {
            option = {
                title: {
                    text: '波峰焊温度实时图',
                    textStyle: {
                        color: "#fff",
                        fontSize: 20
                    },
                    x: 'center',
                    top: 12
                },
                legend: {
                    data: ['设定值(°C)', '实际值(°C)'],
                    textStyle:
                    {
                        color: "#fff"
                    },
                    bottom: 10
                },
                grid: {
                    left: 50,
                    right: 30,
                    top: 50,
                    bottom: 65
                },
                tooltip: {},
                xAxis:
                    {
                        type: 'category',
                        data: ['锡炉', '预热区1B', '预热区2B', '预热区3B', '喷雾区B', '预热区1T', '预热区2T', '预热区3T', '喷雾区T'],
                        axisPointer: {
                            type: 'shadow'
                        },
                        axisLine: {
                            lineStyle: {
                                color: "#fff"
                            }
                        }, splitLine: {
                            lineStyle: { color: "#434B53" }
                        }
                    }
                ,
                yAxis: {
                    interval: 30,
                    min: 0,
                    max: 300,
                    axisLine: {
                        lineStyle: {
                            color: "#fff"
                        }
                    }, splitLine: {
                        lineStyle: { color: "#434B53" }
                    }
                },
                series: [
                    {
                        name: '设定值(°C)',
                        type: 'bar',
                        data: setData,//[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 200, 90],
                        label: {
                            normal: {
                                show: true,
                                position: 'top',
                                color: '#fff'
                            }
                        },
                    },
                    {
                        name: '实际值(°C)',
                        type: 'bar',
                        data: actualData,//[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 200, 290],
                        label: {
                            normal: {
                                show: true,
                                position: 'top',
                                color: '#fff'
                            }
                        },
                    }
                ],
                color: ['#00B050', '#FFC000']
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
