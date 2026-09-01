<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true"
    CodeBehind="UChartGraph.aspx.cs" Inherits="SKT.LeanMES.Web.SPC.UChartGraph" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        table
        {
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            cursor: default;
            padding: 0px;
            border-collapse: collapse;
        }
        table tr td
        {
            padding-left: 3px;
            border: 1px solid #d3d3d3;
            border: 1px solid #d3d3d3 !important;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            padding-top: 3px;
            padding-bottom: 3px;
            text-align: center;
            overflow: auto;
        }
        
        #xbarTb-header tr td
        {
            line-height: 24px;
        }
        #xbarTb-content tr td
        {
            line-height: 22px;
            min-width: 20px;
        }
        #processUl li
        {
            height: 24px;
            line-height: 24px;
            border-bottom: 1px dashed #D3D3D3;
        }
        #processUl span
        {
            margin-right: 5px;
            float: right;
            color: blue;
            margin-left: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="100%" cellpadding="0" cellspacing="0" border="0" id="xbarTb-header">
        <tr>
            <td style="width: 100px">
                制品名称
            </td>
            <td bgcolor="#CCFFFF" style="min-width: 120px;">
                <span id="lblItemName" style="font-weight: bold; font-size: 16px;"></span>
            </td>
            <td style="width: 70px;">
                线 别
            </td>
            <td style="width: 90px;" bgcolor="#CCFFFF">
                <span id="lblLineName"></span>
            </td>
            <td style="width: 70px;">
                上限 UCL
            </td>
            <td style="width: 80px;">
                <span id="lblUcl"></span>
            </td>
            <td style="width: 70px;">
                中心限 CL
            </td>
            <td style="width: 80px;">
                <span id="lblCl"></span>
            </td>
            <td style="width: 70px;">
                下限 LCL
            </td>
            <td style="width: 80px;">
                <span id="lblLcl"></span>
            </td>
            <td style="width: 80px;">
                子组数
            </td>
            <td style="width: 70px;">
                <span id="lblGroupQty"></span>
            </td>
            <td style="width: 80px;">
                样本上限
            </td>
            <td style="width: 70px;">
                <span id="lblSampleU"></span>
            </td>
        </tr>
        <tr>
            <td>
                控制项目
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblProjectName"></span>
            </td>
            <td>
                工 序
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblStation"></span>
            </td>
            <td>
                日 期
            </td>
            <td>
                <span id="lblDate">
                    <%=DateTime.Now.Date.ToShortDateString() %></span>
            </td>
            <td>
                时 间
            </td>
            <td>
                <span id="lblTime"></span>
            </td>
            <td>
                <span style="text-decoration: overline;">U</span>
            </td>
            <td>
                <span id="lblP"></span>
            </td>
            <td>
                <span id="lblMachine">样本容量</span>
            </td>
            <td>
                <span id="lblSampleQty"></span>
            </td>
            <td style="width: 80px;">
                样本下限
            </td>
            <td style="width: 70px;">
                <span id="lblSampleL"></span>
            </td>
        </tr>
        <tr>
            <td colspan="12">
            </td>
        </tr>
    </table>
    <div id="createtable">
    </div>
    <table style="width: 100%; margin-top: -1px; margin-bottom: 3px;" id="xbarTb-graph">
        <tr>
            <td style="width: 100px;">
                <span style="text-decoration: overline">U</span><br />
                控<br />
                制<br />
                图<br />
            </td>
            <td>
                <div id="pcharts" style="height: 200px;">
                </div>
            </td>
        </tr>
    </table>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js"
        type="text/javascript"></script>
    <script type="text/jscript">
        var spcTaskId = '<%=Request.QueryString["ID"]%>';
        var uclData = []; //上限UCL
        var clData = []; //中心限CL
        var lclData = []; //下限LCL
        var defData = []; //%DEF.不良率
        var subData = []; //图表下标数据源
        var sampleQty = 20; //样本数量
        var decimalPoint = 2; //小数点位数
        var ncCodeQty = 0; //不良代码的数量
        var myCharts; //图表对象
        $().ready(function () {
            //加载表头信息
            setHeaderContent();

            //加载表格信息
            createTable();

            //创建图表
            buildXBarRCharts();

            //刷新数据
            setInterval(function () { Refresh(); }, refeshInterval);

            //刷新时间
            timerTick();
        });

        /*
        *刷新控制图表
        */
        function Refresh() {
            uclData = []; //上限UCL
            clData = []; //中心限CL
            lclData = []; //下限LCL
            defData = []; //%DEF.不良率
            subData = []; //图表下标数据源

            //加载表头信息
            setHeaderContent();

            //加载表格信息
            createTable();

            //更新图表信息

            $.each(defData, function (index, item) {
                if (item > uclData[index] || item < lclData[index]) {
                    $("#xbarTb-content tr:eq(1) td:eq(" + (index + 1) + ")").css("background-color", "Red").css("color", "#000");
                    for (var i = 0; i < ncCodeQty + 3; i++) {
                        $("#xbarTb-content tr:eq(" + (i + 2) + ") td:eq(" + (index + 1) + ")").css("background-color", "Red").css("color", "#000");
                    }
                    defData[index] = { value: defData[index],
                        symbol: 'emptyHeart',
                        symbolSize: 5,
                        itemStyle: { normal: { color: '#ff0000', label: { show: true}} }
                    };
                }
            });
            var option = myCharts.getOption();
            option.xAxis[0].data = subData;
            option.series[0].data = uclData;
            option.series[1].data = clData;
            option.series[2].data = lclData;
            option.series[3].data = defData;
            myCharts.setOption(option);

        }

        /*
        * 获取检测项目数据
        */
        function setHeaderContent() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSPC.GetGraphInfo(spcTaskId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            refeshInterval = entity.RefeshInterval == 0 ? (60 * 1000) : decimal(entity.RefeshInterval * 60, 0) * 1000;

            sampleQty = entity.SampleQty; //群组数
            decimalPoint = entity.SampleDecimalPoint; //保留小数点位数

            $("#lblItemName").text(entity.ItemCode);
            $("#lblProjectName").text(entity.ProjectName);
            $("#lblLineName").text(entity.LineName);
            $("#lblStation").text(entity.Station);

        }

        /*
        *   获取检测的数据
        */
        function getPChartData() {
            var entity = [];
            var newChildEntity = [];
            var childEntity = [];

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSPC.GetUChartGraphData(spcTaskId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return entity;
            }
            childEntity = ajax.value;
            if (childEntity == null || childEntity.length == 0) {
                return entity;
            }

            ncCodeQty = childEntity[0].NCCodeQty;

            for (var i = 0; i < childEntity.length; i++) {
                if (i % ncCodeQty == 0 && i != 0) {
                    newChildEntity = []
                    newChildEntity.push(childEntity[i]);
                    entity.push(newChildEntity);

                }
                else {
                    newChildEntity.push(childEntity[i]);
                    if (i == ncCodeQty - 1) {
                        entity.push(newChildEntity);
                    }
                }
            }

            return entity;
        }

        /*
        *创建数据表格
        */
        function createTable() {

            var totalNcQty = 0; //不良数量合计
            var entity = getPChartData();

            $("#createtable").empty();
            sampleQty = 0;
            if (entity.length > 0) {
                $.each(entity, function (i, item) {
                    sampleQty = sampleQty + item[0].SampleQty;
                });
                sampleQty = sampleQty / entity.length;
                $("#lblSampleQty").text(decimal(sampleQty, 0));
                $("#lblSampleU").text(decimal(sampleQty * 1.25, 0));
                $("#lblSampleL").text(decimal(sampleQty * 0.75, 0));
            }
            var table = $("<table style=\" width:100%; margin-top: -1px;\" id=\"xbarTb-content\">");
            table.appendTo($("#createtable"));
            var defArr = [];
            for (var i = 0; i < ncCodeQty + 5; i++) {
                var tr = $("<tr></tr>");
                tr.appendTo(table);

                for (var j = 0; j < entity.length + 1; j++) {
                    if (j == 0) {
                        if (i == 0) {
                            td = $("<td style='width:100px;' >子 组 号：</td>");
                        }
                        else if (i == 1) {
                            td = $("<td style='width:100px;'>检查时间：</td>");
                        }
                        else if (i <= ncCodeQty+1) {
                            td = $("<td>" + entity[0][i-2].NCCode + "</td>");
                        }
                        else if (i == ncCodeQty + 2) {
                            td = $("<td>不良累计：</td>");
                        }
                        else if (i == ncCodeQty + 3) {
                            td = $("<td style='font-size:11px;'>NO.DEF./UNIT ：</td>");
                        }
                        else if (i == ncCodeQty + 4) {
                            td = $("<td>样本数量：</td>");
                        }
                        td.appendTo(tr);
                    }
                    else {
                        var ncQty = 0;
                        if (i == 0) {
                            td = $("<td  bgcolor='#CCFFFF'>" + (j) + "</td>");
                            td.appendTo(tr);
                            continue;
                        }
                        else if (i == 1) {
                            td = $("<td style='color:#372288;font-weight:bold;'>" + entity[j - 1][0].CollectTime + "</td>"); 
                            td.appendTo(tr);
                            continue;
                        }
                        else if (i <= ncCodeQty+1) {
                            td = $("<td>" + entity[j - 1][i-2].Qty + "</td>");
                        }
                        else if (i == ncCodeQty + 2) {
                            var cellArr = entity[j - 1];
                            $.each(cellArr, function (k, item) {
                                ncQty = ncQty + item.Qty;
                            });
                            totalNcQty = totalNcQty + ncQty;
                            var def = ncQty / (entity[j - 1][0].SampleQty);
                            defArr.push(decimal(def, decimalPoint));
                            td = $("<td style='color:#52AA52; font-weight:bold;'>" + ncQty + "</td>");
                        }
                        else if (i == ncCodeQty + 3) {
                            defData.push(defArr[j - 1]);
                            td = $("<td style='color:blue;'>" + defArr[j - 1] + "</td>");
                        }
                        else if (i == ncCodeQty + 4) {
                            td = $("<td  style='color:blue;'>" + entity[j - 1][0].SampleQty + "</td>");
                        }
                        td.appendTo(tr);
                    }
                }
            }
            $("#createtable").append("</table>");
            if (entity.length > 0) {
                var cl = 0;
                var ucl = 0;
                var lcl = 0;

                cl = (totalNcQty / (entity.length * sampleQty));
                ucl = (cl + 3 * Math.sqrt(cl * (1 - cl) / sampleQty));
                lcl = (cl - 3 * Math.sqrt(cl * (1 - cl) / sampleQty));

                cl = decimal(cl, decimalPoint);
                ucl = decimal(ucl, decimalPoint);
                lcl = lcl < 0 ? 0 : decimal(lcl, decimalPoint);

                for (var i = 0; i < entity.length; i++) {
                    clData.push(cl);
                    uclData.push(ucl);
                    lclData.push(lcl);
                    subData.push(i + 1);
                }
                $("#lblUcl").text(ucl);
                $("#lblCl,#lblP").text(cl);
                $("#lblLcl").text(lcl);
                $("#lblGroupQty").text(entity.length);
            }
            return true;
        }

        /*
        *   创建XBar-R图表
        */
        function buildXBarRCharts() {
            var maxtip = "上限UCL";
            var mintip = "下限UCL";
            var centerTip = "中心限CL";
            var valtip = "NO.DEF./UNIT";
            var dom = document.getElementById("pcharts");
            myCharts = echarts.init(dom);

            $.each(defData, function (index, item) {
                if (item > uclData[index] || item < lclData[index]) {
                    $("#xbarTb-content tr:eq(1) td:eq(" + (index + 1) + ")").css("background-color", "Red").css("color", "#000");
                    for (var i = 0; i < ncCodeQty + 3; i++) {
                        $("#xbarTb-content tr:eq(" + (i + 2) + ") td:eq(" + (index + 1) + ")").css("background-color", "Red").css("color", "#000");
                    }
                    defData[index] = { value: defData[index],
                        symbol: 'emptyHeart',
                        symbolSize: 5,
                        itemStyle: { normal: { color: '#ff0000', label: { show: true}} }
                    };
                }
            });

            option = null;
            option = {
                tooltip: {
                    trigger: 'axis'
                },
                grid: {
                    left: '2%',
                    top: '30px',
                    right: '2%',
                    bottom: '30px',
                    containLabel: true
                },
                legend: {
                    //x: 'left',
                    //y:'center',
                    //orient: 'vertical',                 
                    data: [valtip, maxtip, centerTip, mintip]
                },
                toolbox: {
                    show: true,
                    feature: {
                        magicType: { show: false, type: ['stack', 'tiled'] },
                        saveAsImage: { show: true }
                    }
                },
                color: ["#317010", "#e3e311", "#bd92a9", '#60609D'],
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: subData
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                {
                    name: maxtip,
                    type: 'line',
                    itemStyle: {
                        normal: {
                            lineStyle: {
                                color: '#317010'
                            }
                        }
                    },
                    smooth: true,
                    symbol: 'none',
                    data: uclData
                },
                {
                    name: centerTip,
                    type: 'line',
                    itemStyle: {
                        normal: {
                            lineStyle: {
                                color: '#e3e311'
                            }
                        }
                    },
                    smooth: true,
                    symbol: 'none',
                    data: clData
                },
                {
                    name: mintip,
                    type: 'line',
                    itemStyle: {
                        normal: {
                            lineStyle: {
                                color: '#bd92a9'
                            }
                        }
                    },
                    smooth: true,
                    symbol: 'none',
                    data: lclData
                },
                {
                    name: valtip,
                    type: 'line',
                    itemStyle: {
                        normal: {
                            lineStyle: {
                                color: '#60609D'
                            }
                            //,
                            //label: { show: true }
                        }
                    },
                    smooth: false,
                    data: defData
                }]
            };
            if (option && typeof option === "object") {
                myCharts.setOption(option, true);
            }
        }
        /*
        * 对多位小数进行四舍五入
        * num是要处理的数字  v为要保留的小数位数
        */
        function decimal(num, v) {
            var vv = Math.pow(10, v);
            return Math.round(num * vv) / vv;
        }

        /**
        *获取当前时间
        */
        function getDateTime() {
            var now = new Date();
            var hour = now.getHours();
            var min = now.getMinutes();
            var sec = now.getSeconds();
            var day = now.getDay();

            hour = (hour < 10) ? '0' + hour.toString() : hour.toString();
            min = (min < 10) ? '0' + min.toString() : min.toString();
            sec = (sec < 10) ? '0' + sec.toString() : sec.toString();
            return hour.toString() + ":" + min.toString() + ":" + sec.toString();
        }

        /**
        *页面时间每秒钟变换
        */
        function timerTick() {
            $("#lblTime").html(getDateTime());
            setInterval(function () { $("#lblTime").html(getDateTime()); }, 1000);
        }
    </script>
</asp:Content>
