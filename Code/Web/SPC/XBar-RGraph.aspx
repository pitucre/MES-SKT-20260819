<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true"
    CodeBehind="XBar-RGraph.aspx.cs" Inherits="SKT.LeanMES.Web.SPC.XBar_RGraph" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        table { font-family: Verdana, 微软雅黑,黑体, 宋体; font-size: 12px; cursor: default; padding: 0px; border-collapse: collapse; }
            table tr td { padding-left: 3px; border: 1px solid #d3d3d3; border: 1px solid #d3d3d3 !important; font-family: Verdana, 微软雅黑,黑体, 宋体; font-size: 12px; padding-top: 3px; padding-bottom: 3px; text-align: center; overflow: auto; }

        #xbarTb-header tr td { line-height: 15px; }
        #xbarTb-content tr td { line-height: 15px; min-width: 20px; }
        #processUl li { height: 24px; line-height: 24px; border-bottom: 1px dashed #D3D3D3; }
        #processUl span { margin-right: 5px; float: right; color: blue; margin-left: 10px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="100%" cellpadding="0" cellspacing="0" border="0" id="xbarTb-header">
        <tr>
            <td rowspan="2" style="width: 100px; font-size: 14px;">制 品<br />
                名 称
            </td>
            <td rowspan="2" bgcolor="#CCFFFF" style="min-width: 120px;">
                <span id="lblItemName" style="font-weight: bold; font-size: 16px;"></span>
            </td>
            <td style="width: 70px;">规 格
            </td>
            <td style="width: 70px;">标 准
            </td>
            <td style="width: 80px;">群组数大小
            </td>
            <td style="width: 70px;">控 制
            </td>
            <td style="width: 60px;">
                <span style="text-decoration: overline">X</span> 图
            </td>
            <td style="width: 60px;">R 图
            </td>
            <td rowspan="2" style="width: 80px;">线 别
            </td>
            <td rowspan="2" bgcolor="#CCFFFF" style="width: 120px;">
                <span id="lblDepartment" style="font-size: 13px;"></span>
            </td>
            <td rowspan="2" style="width: 70px;">时 间
            </td>
            <td rowspan="2" bgcolor="#CCFFFF" style="width: 120px;">
                <span id="lblTime"></span>
            </td>
        </tr>
        <tr>
            <td>上限 USL
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblUsl" style="font-weight: bold; font-size: 13px;"></span>
            </td>
            <td>
                <span id="lblGropupQty"></span>
            </td>
            <td>上限 UCL
            </td>
            <td>
                <span id="lblXucl"></span>
            </td>
            <td>
                <span id="lblRucl"></span>
            </td>
        </tr>
        <tr>
            <td>控制项目
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblProjectName"></span>
            </td>
            <td>中心限SL
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblCl" style="font-weight: bold; font-size: 13px;"></span>
            </td>
            <td>总组数
            </td>
            <td>中心限CL
            </td>
            <td>
                <span id="lblXcl"></span>
            </td>
            <td>
                <span id="lblRcl"></span>
            </td>
            <td>工 序
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblMachine" style="font-size: 13px;"></span>
            </td>
            <td>抽样方法
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblSampling">随机</span>
            </td>
        </tr>
        <tr>
            <td>测量单位
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblUnits"></span>
            </td>
            <td>下限 LSL
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblLsl" style="font-weight: bold; font-size: 13px;"></span>
            </td>
            <td>
                <span id="lblTotalGroupQty"></span>
            </td>
            <td>下限 LCL
            </td>
            <td>
                <span id="lblXlcl"></span>
            </td>
            <td>
                <span id="lblRlcl"></span>
            </td>
            <td>
                <%--测 试 者--%>
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblOperator" style="font-size: 13px;"></span>
            </td>
            <td>日 期
            </td>
            <td bgcolor="#CCFFFF">
                <span id="lblDate">
                    <%=DateTime.Now.Date.ToShortDateString() %></span>
            </td>
        </tr>
    </table>
    <div id="createtable">
    </div>
    <table style="width: 100%; margin-top: -1px; margin-bottom: 3px;" id="xbarTb-graph">
        <tr>
            <td style="width: 100px;">
                <span style="text-decoration: overline">X</span><br />
                控<br />
                制<br />
                图<br />
            </td>
            <td>
                <div id="xcharts" style="height: 200px;">
                </div>
            </td>
            <td rowspan="2" style="width: 120px; vertical-align: top;">
                <div style='width: 121px; padding: 0px; margin: -2px 0px 0px -2px; text-align: left;'>
                    <%-- <ul>
                        <li style='height: 26px; line-height: 26px; background-color: #C0C0C0; text-align: center;'>
                            预估不良率 (PPM)</li></ul>
                    <ul>
                        <li style='height: 30px; line-height: 30px; color: Blue;'>&nbsp;&nbsp;1000000</li></ul>--%>
                    <ul id="processUl">
                        <li style='height: 26px; line-height: 26px; background-color: #C0C0C0; text-align: center;'>制程能力分析</li>
                        <li>Std.Dev.=<span id="lblStddev"></span></li>
                        <li>Sigma&nbsp;=<span id="lblSigma"></span></li>
                        <li>PPK&nbsp;=<span id="lblPPK"></span></li>
                        <li>PP&nbsp;=&nbsp;<span id="lblPP"></span></li>
                        <li>Ca&nbsp;=&nbsp;<span id="lblCa"></span></li>
                        <li>CPK&nbsp;=&nbsp;<span id="lblCPK"></span></li>
                        <li>CP&nbsp;=&nbsp;<span id="lblCP"></span></li>
                        <li>Grade&nbsp;=&nbsp;<span id="lblGrade"></span></li>
                    </ul>
                </div>
            </td>
        </tr>
        <tr>
            <td>R<br />
                控<br />
                制<br />
                图<br />
            </td>
            <td style="border: solid 1px #a0c6e5;">
                <div id="rcharts" style="height: 200px;">
                </div>
            </td>
        </tr>
    </table>
    <input type="hidden" id="hidSpliceQty" value="0" />
    <input type="hidden" id="hidNqty" value="0" />
    <input type="hidden" id="hidCurrentNqty" value="0" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js"
        type="text/javascript"></script>
    <script type="text/jscript">
        var spcTaskId = '<%=Request.QueryString["ID"]%>';
        var totalGroupQty = 25; //总组数
        var groupQty = 6; //群组数
        var decimalPoint = 2; //保留小数点位数 
        var spcJson = []; //spc检测结果

        var xGraphData = []; //X控制图均值数据源
        var rGraphData = []; //R控制图均值数据源
        var subGraphpData = []; //控制图下坐标数据源

        var xUclData = []; //X上限UCL数据源
        var xClData = []; //X中限UCL数据源
        var xLclData = []; //X下限UCL数据源

        var rUclData = []; //R上限UCL数据源
        var rClData = []; //R中限UCL数据源
        var rLclData = []; //R下限UCL数据源

        var GmaxArr = [];  //规格上限 USL 
        var GminArr = [];  //规格下限 LSL 

        var graphWarnData = []; //需预警的数据
        var exresult = 0; //ΣＸ合计值
        var erresult = 0; //ΣＲ合计值
        var xavg = 0; //X平均值
        var nQty = 0; //N 抽样数量
        var lsl = 0; //规格下限 LSL
        var usl = 0; //规格上限USL 

        var stddev = 0;   // Std.Dev.     
        var xChartsGraph; //X 控制图图表对象
        var rChartsGraph; //R 控制图图表对象
        var refeshInterval; //刷新间隔（秒）
        var spliceQty = 0; //显示过且已隐藏的数据
        var spliceLen = 0;
        var dataCount = 0; //添加的数据量
        var isGroup = false;
        var IsCurve = 0;   //是否曲线显示

        $().ready(function () {
            //加载表头信息
            var entity = setHeaderContent();

            //获取表格数据
            spcJson = getCheckData();

            //加载表格信息
            createTable(groupQty, totalGroupQty);
            //加载分析结果信息
            setResultContent(entity);
            //刷新图表
            setTimeout(function () {
                buildXBarRCharts("xcharts", xGraphData);
                buildXBarRCharts("rcharts", rGraphData);
                graphWarn(entity);
            }, 100);

            //刷新数据
            setInterval(function () { Refresh(); }, refeshInterval);

            //刷新时间
            timerTick();
        });

        /*
        *刷新控制图表
        */
        function Refresh() {

            var record = 0;
            spliceLen = 0;
            //获取表格数据
            spcJson = getCheckData();

            /*if (dataCount == 0) {
                return false;
            }*/

            //if (record % groupQty != 0) {//一组一组刷新
            //     return false;
            //}

            //初始化数据            
            nQty = 0; //N 抽样数量
            lsl = 0; //下限 LSL
            usl = 0; //上限USL
            xGraphData = [];
            rGraphData = [];
            subGraphpData = [];
            exresult = 0; //ΣＸ合计值
            erresult = 0; //ΣＲ合计值
            xavg = 0; //X平均值
            stddev = 0; // Std.Dev.
            $("#createtable").empty();

            //加载表头信息
            var entity = setHeaderContent();

            //加载表格信息
            createTable(groupQty, totalGroupQty);

            //加载分析结果信息
            setResultContent(entity);
            //刷新图表

            /*if (!isGroup && xUclData.length != totalGroupQty - 1) {
                return;
            }*/

            setTimeout(function () {
                //更新数据
                $.each(xGraphData, function (index, item) {
                    if (item > xUclData[index] || item < xLclData[index]) {
                        if (item > usl || item < lsl) {
                            $("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "red").css("color", "#000");
                            for (var i = 0; i < groupQty + 2; i++) {
                                $("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "red").css("color", "#000");
                            }
                        }
                        else {
                            $("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "yellow").css("color", "#000");
                            for (var i = 0; i < groupQty + 2; i++) {
                                $("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "yellow").css("color", "#000");
                            }
                        }
                        xGraphData[index] = {
                            value: xGraphData[index],
                            symbol: 'emptyHeart',
                            symbolSize: 5,
                            itemStyle: { normal: { color: '#ff0000', label: { show: true } } }
                        };
                    }
                });

                $.each(rGraphData, function (index, item) {
                    if (item > rUclData[index] || item < rLclData[index]) {
                        $("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "yellow").css("color", "#000");
                        for (var i = 0; i < groupQty + 2; i++) {
                            $("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "yellow").css("color", "#000");
                        }
                        rGraphData[index] = {
                            value: rGraphData[index],
                            symbol: 'emptyHeart',
                            symbolSize: 5,
                            itemStyle: { normal: { color: '#ff0000', label: { show: true } } }
                        };
                    }
                });
                var option = xChartsGraph.getOption();
                //option.series[0].data = xUclData;
                //option.series[1].data = xClData;
                //option.series[2].data = xLclData;
                //option.series[3].data = xGraphData;
                option.series[5].data = xGraphData;
                xChartsGraph.setOption(option);

                var roption = rChartsGraph.getOption();
                //roption.series[0].data = rUclData;
                //roption.series[1].data = rClData;
                //roption.series[2].data = rLclData;
                roption.series[3].data = rGraphData;
                rChartsGraph.setOption(roption);
                graphWarn(entity);

            }, 100);
        }

        var dateArr = [];
        /*
        *   获取检测的数据
        */
        function getCheckData() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSPC.GetXbarRGraphData(spcTaskId, spliceQty);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var str = ajax.value[0];
            var date = ajax.value[1];

            if (str == null) {
                return;
            }
            var checkArr = [];
            var checkChildArr = [];
            var strArr = str.split(',');
            dateArr = [];
            var dateChildArr = [];
            var strDate = date.split(',');

            for (var i = 0; i < strArr.length; i++) {
                if (parseFloat(strArr[i]) >= 0) {

                    if (i % groupQty == 0 && i != 0) {
                        checkChildArr = [];
                        checkChildArr.push(decimal(parseFloat(strArr[i]), decimalPoint));
                        checkArr.push(checkChildArr);

                        dateChildArr = [];
                        dateChildArr.push(strDate[i]);
                        dateArr.push(dateChildArr);
                    }
                    else {
                        checkChildArr.push(decimal(parseFloat(strArr[i]), decimalPoint));
                        dateChildArr.push(strDate[i]);
                        if (i == groupQty - 1) {
                            checkArr.push(checkChildArr);
                            dateArr.push(dateChildArr);
                        }
                    }
                }
            }
            if (checkArr.length == 0) {
                spliceQty = 0;
                xUclData = []; //X上线UCL数据源
                xClData = []; //X中线UCL数据源
                xLclData = []; //X下线UCL数据源

                rUclData = []; //R上线UCL数据源
                rClData = []; //R中线UCL数据源
                rLclData = []; //R下线UCL数据源
                $("#hidNqty").val(0);
            }
            $("#hidSpliceQty").val(spliceQty);

            var oldCurrentNqty = parseInt($("#hidCurrentNqty").val());
            var oldSpliceQty = parseInt($("#hidSpliceQty").val());
            if (checkArr.length > totalGroupQty) {
                spliceQty = spliceQty + ((checkArr.length - totalGroupQty) * groupQty);
                spliceLen = (checkArr.length - totalGroupQty);
                checkArr.splice(0, checkArr.length - totalGroupQty);

                dateArr.splice(0, dateArr.length - totalGroupQty);
            }
            var record = 0;
            $.each(checkArr, function (index) {
                $.each(checkArr[index], function () {
                    record = record + 1;
                })
            });
            $("#hidCurrentNqty").val(record);

            dataCount = (spliceQty + record) - (oldSpliceQty + oldCurrentNqty);
            isGroup = ((oldCurrentNqty % groupQty + dataCount) - groupQty >= 0);

            return checkArr;
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
            usl = entity.USL;
            lsl = entity.LSL;
            totalGroupQty = entity.GroupQty; //总组数
            groupQty = entity.SampleQty; //群组数
            decimalPoint = entity.SampleDecimalPoint; //保留小数点位数
            IsCurve = entity.IsCurve;  //是否曲线显示

            $("#lblItemName").text(entity.ItemCode);
            $("#lblProjectName").text(entity.ProjectName);
            $("#lblUnits").text(entity.Unit);
            $("#lblUsl").text(usl);

            $("#lblCl").text(decimal((usl + lsl) / 2, decimalPoint));
            $("#lblLsl").text(lsl);
            $("#lblGropupQty").text(groupQty);
            $("#lblTotalGroupQty").text(totalGroupQty);

            $("#lblDepartment").text(entity.LineName);
            $("#lblMachine").text(entity.Station);
            return entity;
        }

        //时间转字符串
        Date.prototype.Format = function (fmt) {
            if (undefined == fmt || null == fmt) {
                fmt = "yyyy-MM-dd HH:mm:ss";
            }
            var t = this;
            var tf = function (str, len) {
                if (str.length < len) {
                    for (var i = 0; i < len - str.length; i++) {
                        str = "0" + str;
                    }
                }
                return str
            };
            var opt = {
                "y+": t.getFullYear().toString(),        // 年
                "M+": (t.getMonth() + 1).toString(),     // 月
                "d+": t.getDate().toString(),            // 日
                "H+": t.getHours().toString(),           // 时
                "m+": t.getMinutes().toString(),         // 分
                "s+": t.getSeconds().toString()          // 秒
                // 有其他格式化字符需求可以继续添加，必须转化成字符串
            };
            var ret;
            for (var k in opt) {
                ret = new RegExp("(" + k + ")").exec(fmt);
                if (ret) {
                    fmt = fmt.replace(ret[1], ret[1].length == 1 ? opt[k] : tf(opt[k], ret[1].length));
                }
            }
            return fmt;
        }

        /*
        * 获取检测项目详情数据
        */
        function createTable(rowCount, cellCount) {
            rowCount = rowCount <= 0 ? 1 : rowCount;
            var table = $("<table style=\" width:100%; margin-top: -1px;\" id=\"xbarTb-content\">");
            table.appendTo($("#createtable"));
            for (var i = 0; i < rowCount + 5; i++) {
                var tr = $("<tr></tr>");

                tr.appendTo(table);

                for (var j = 0; j < cellCount + 3; j++) {
                    var td;
                    var totalVal = 0;
                    if (j == 0) {
                        continue;
                    }
                    else if (j == 1) {
                        if (i == 0) {
                            td = $("<td colspan=\"2\">日期/时间</td>");
                            td.appendTo(tr);
                            continue;
                        }
                        else if (i == 1) {
                            td = $("<td colspan=\"2\">批 号</td>");
                            td.appendTo(tr);
                            continue;
                        }
                        else if (i == 2) {
                            td = $("<td style='width: 66px;'  rowspan='" + (rowCount) + "' >样<br />本<br />测<br />定<br />值</td><td style='width: 30px;' >" + (parseInt(i) - 1) + "</td>");
                            td.appendTo(tr);
                            continue;
                        }
                        else if (i > 2 && i <= rowCount + 1) {
                            td = $("<td>" + (parseInt(i) - 1) + "</td>");
                            td.appendTo(tr);
                            continue;
                        }
                        else if (i == (rowCount + 2)) {
                            td = $("<td colspan=\"2\">∑X</td>");
                            td.appendTo(tr);
                            continue;
                        }
                        else if (i == (rowCount + 3)) {
                            td = $("<td colspan=\"2\"><span style='text-decoration: overline'>X</span></td>");
                            td.appendTo(tr);
                            continue;
                        }
                        else if (i == (rowCount + 4)) {
                            td = $("<td colspan=\"2\">R</td>");
                            td.appendTo(tr);
                            continue;
                        }
                    }

                    if (j == cellCount + 2 && i == 0) {
                        td = $("<td rowspan='" + (rowCount + 5) + "' style='width: 120px; vertical-align:top;'><div id='divTotal'></div></td>");
                    }
                    if (j < cellCount + 2) {
                        if (i == 0) {//日期/时间
                            //td = $("<td bgcolor='#99CCFF'></td>");
                            var dateStr = "";
                            try {
                                if (dateArr.length > (j - 2)) {
                                    if (dateArr.length > (j - 2)) {
                                        dateStr = dateArr[j - 2][dateArr[j - 2].length - 1] == undefined ? "" : dateArr[j - 2][dateArr[j - 2].length - 1];
                                        var date = new Date(dateStr.replace(/-/g, "/"));
                                        dateStr = date.Format("dd/MM HH:mm");
                                        dateStr = dateStr.replace(" ", "<br/>")
                                    }
                                }
                            } catch (e) {
                            }
                            td = $("<td bgcolor='#99CCFF'>" + dateStr + "</td>");
                        }
                        else if (i == 1) {//批次
                            td = $("<td>" + (j - 1) + "</td>");
                            subGraphpData.push((j - 1));
                        }
                        else if (i >= 2 && i <= rowCount + 1) {//样本测定值
                           
                            if (spcJson.length > (j - 2)) {
                                var cellVal = spcJson[j - 2][i - 2] == undefined ? "" : spcJson[j - 2][i - 2];
                                var colorVal = "";
                                if (cellVal > usl) {
                                    colorVal = "style='color:blue;font-weight:bold;'";
                                }
                                else if (cellVal < lsl) {
                                    colorVal = "style='color:red;font-weight:bold;'";
                                }
                                td = $("<td bgcolor='#CCFFFF' " + colorVal + ">" + cellVal + "</td>");
                            }
                            else {
                                td = $("<td bgcolor='#CCFFFF'></td>");
                            }
                        }
                        else if (i == (rowCount + 2)) {//∑X
                            if (spcJson.length > (j - 2)) {
                                var cellArr = spcJson[j - 2];
                                if (cellArr.length == groupQty) {
                                    var seq = 0;
                                    $.each(cellArr, function (index, item) {
                                        totalVal = totalVal + item;
                                        seq = seq + (item * item);
                                        nQty = nQty + 1;
                                    });
                                    stddev = stddev + seq;
                                    exresult = exresult + totalVal;
                                    totalVal = decimal(totalVal, decimalPoint);
                                    td = $("<td style='color:#317010;'>" + totalVal + "</td>");

                                } else {
                                    td = $("<td></td>");
                                }
                            }
                            else {
                                td = $("<td></td>");
                            }
                        }
                        else if (i == (rowCount + 3)) {//X
                            if (spcJson.length > (j - 2)) {
                                var cellArr = spcJson[j - 2];
                                var totalVal = 0;
                                var avgVal = 0;
                                if (cellArr.length == groupQty) {
                                    $.each(cellArr, function (index, item) {
                                        totalVal = totalVal + item;
                                    });
                                    avgVal = totalVal / rowCount;
                                    xGraphData.push(decimal(avgVal, decimalPoint));
                                    xavg = xavg + avgVal;
                                    td = $("<td style='color:#372288;'>" + decimal(avgVal, decimalPoint) + "</td>");
                                } else {
                                    td = $("<td></td>");
                                }
                            }
                            else {
                                td = $("<td></td>");
                            }
                        }
                        else if (i == (rowCount + 4)) {//R
                            if (spcJson.length > (j - 2)) {
                                var cellArr = spcJson[j - 2];
                                if (cellArr.length == groupQty) {
                                    var maxVal = (Math.max.apply(null, cellArr));
                                    var minVal = (Math.min.apply(null, cellArr));
                                    var rval = (maxVal - minVal);
                                    rGraphData.push(decimal(rval, decimalPoint));
                                    td = $("<td style='color:#372288;'>" + decimal(rval, decimalPoint) + "</td>");

                                    erresult = erresult + rval;
                                } else {
                                    td = $("<td></td>");
                                }
                            }
                            else {
                                td = $("<td></td>");
                            }
                        }
                        else {
                            td = $("<td></td>");
                        }
                    }
                    td.appendTo(tr);
                }
            }

            $("#createtable").append("</table>");

        }

        /*
        * 获取检测项目结果数据
        */
        function setResultContent(entity) {
            var cellQty = nQty / groupQty; //实际数据总组数
            var totalqty = decimal(cellQty, decimalPoint);
            var xcl = nQty == 0 ? 0 : xavg / cellQty; //X 中心限CL
            var rcl = nQty == 0 ? 0 : erresult / cellQty; //R 中心限CL

            var resultHtml = "<div style=' width:121px; padding:0px;margin:-2px 0px 0px -2px;text-align:left;'>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;background-color:#C0C0C0; text-align:center;'>合&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计</li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;'>&nbsp;&nbsp;ΣＸ＝&nbsp;" + decimal(exresult, decimalPoint) + "</li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;'>&nbsp;&nbsp;ΣＲ＝&nbsp;" + decimal(erresult, decimalPoint) + "</li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;background-color:#C0C0C0; text-align:center;'>量测数值的判定条件</li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;'>&nbsp;&nbsp;>  USL  <span style='color:blue;'>蓝色</span></li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;'>&nbsp;&nbsp;<  LSL  <span style='color:red;'>黄色</span></li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;'>&nbsp;&nbsp;Ｎ＝&nbsp;" + nQty + "</li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;background-color:#C0C0C0; text-align:center;'>平&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;均</li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;'>&nbsp;&nbsp;<span style='text-decoration: overline'>X</span>=&nbsp;" + decimal(xcl, decimalPoint) + "</li></ul>";
            resultHtml += "<ul><li style='height:24px;line-height:24px;'>&nbsp;&nbsp;<span style='text-decoration: overline'>R</span>=&nbsp;" + decimal(rcl, decimalPoint) + "</li></ul>";
            resultHtml += "</div>";

            $("#divTotal").html(resultHtml);
            $("#lblTotalGroupQty").text(totalqty);

            if (!isGroup && xUclData.length < totalGroupQty) {
                return;
            }
            if (stddev > 0) {
                //计算制程能力分析
                stddev = decimal(stddev, decimalPoint);
                stddev = Math.sqrt((stddev - ((exresult * exresult) / nQty)) / (nQty - 1));
                $("#lblStddev").text(decimal(stddev, decimalPoint));
            }
            //计算X/R 上限 UCL、下限 UCL...
            var dataroot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/spc/json/xbar-r-data.js";
            $.ajaxSettings.async = false; //设置getJson同步
            $.getJSON(dataroot, function (data) {
                var result = data[0]["n" + groupQty];
                if (result != undefined && rcl > 0) {
                    var rucl = 0; //R 上限 UCL
                    var rlcl = 0; //R 下限 UCL                    
                    var xucl = 0; //X 上限 UCL
                    var xlcl = 0; //X 下限 UCL  
                    if (xUclData.length == 0
                        || (spliceQty == 0
                            && ((nQty - $("#hidNqty").val()) / groupQty > 1))) { //初始化 一次加载多组数据（当未达到总组数时 多项数据重新计算平均值） 

                        xUclData = []; //X上限UCL数据源
                        xClData = []; //X中限UCL数据源
                        xLclData = []; //X下限UCL数据源
                        rUclData = []; //R上限UCL数据源
                        rClData = []; //R中限UCL数据源
                        rLclData = []; //R下限UCL数据源
                        var nXAvg = 0;
                        var nRAvg = 0;
                        var nXcl = 0;
                        var nRcl = 0;
                        for (var i = 0; i < spcJson.length; i++) {
                            if (spcJson[i].length % groupQty == 0) {

                                nXAvg = (nXAvg + xGraphData[i]);
                                nRAvg = (nRAvg + rGraphData[i]);
                                nXcl = nXAvg / (i + 1);
                                nRcl = nRAvg / (i + 1);

                                rucl = decimal(nRcl * result.D4, decimalPoint); //R 上限 UCL
                                rlcl = decimal(nRcl * result.D3, decimalPoint); //R 下限 UCL                    
                                xucl = decimal((nXcl + nRcl * result.A2), decimalPoint); //X 上限 UCL
                                xlcl = decimal((nXcl - nRcl * result.A2), decimalPoint); //X 下限 LCL 

                                xUclData.push(xucl);
                                xLclData.push(xlcl);
                                rUclData.push(rucl);
                                rLclData.push(rlcl);
                                xClData.push(decimal(nXcl, decimalPoint));
                                rClData.push(decimal(nRcl, decimalPoint));
                            }
                        }
                        if (IsCurve == false) {
                            //add by peter on time 2018-10-15 直线显示
                            xUclData = [];
                            xLclData = [];
                            rUclData = [];
                            rLclData = [];
                            xClData = [];
                            rClData = [];
                            GmaxArr = [];
                            GminArr = [];
                            for (var i = xUclData.length; i < spcJson.length; i++) {
                                xUclData.push(xucl);
                                xLclData.push(xlcl);
                                rUclData.push(rucl);
                                rLclData.push(rlcl);
                                xClData.push(decimal(nXcl, decimalPoint));
                                rClData.push(decimal(nRcl, decimalPoint));
                                GmaxArr.push(usl);
                                GminArr.push(lsl);
                            }
                        }
                    }
                    else {
                        if (spliceQty != 0 && spliceLen > 1) { //数据刷新 一次加载多组数据 考虑不重新计算所有的平均值

                            xUclData.splice(0, spliceLen); //X上限UCL数据源
                            xClData.splice(0, spliceLen);; //X中限UCL数据源
                            xLclData.splice(0, spliceLen);; //X下限UCL数据源
                            rUclData.splice(0, spliceLen);; //R上限UCL数据源
                            rClData.splice(0, spliceLen);; //R中限UCL数据源
                            rLclData.splice(0, spliceLen);; //R下限UCL数据源
                            var nXAvg = 0;
                            var nRAvg = 0;
                            var nXcl = 0;
                            var nRcl = 0;
                            for (var j = 0; j < xGraphData.length - spliceLen; j++) {
                                nXAvg = nXAvg + xGraphData[j];
                                nRAvg = nRAvg + rGraphData[j];
                            }

                            for (var i = xUclData.length; i < spcJson.length; i++) {
                                if (spcJson[i].length % groupQty == 0) {

                                    nXAvg = (nXAvg + xGraphData[i]);
                                    nRAvg = (nRAvg + rGraphData[i]);
                                    nXcl = nXAvg / (i + 1);
                                    nRcl = nRAvg / (i + 1);

                                    rucl = decimal(nRcl * result.D4, decimalPoint); //R 上限 UCL
                                    rlcl = decimal(nRcl * result.D3, decimalPoint); //R 下限 LCL                    
                                    xucl = decimal((nXcl + nRcl * result.A2), decimalPoint); //X 上限 UCL
                                    xlcl = decimal((nXcl - nRcl * result.A2), decimalPoint); //X 下限 LCL  
                                    xUclData.push(xucl);
                                    xLclData.push(xlcl);
                                    rUclData.push(rucl);
                                    rLclData.push(rlcl);
                                    xClData.push(decimal(nXcl, decimalPoint));
                                    rClData.push(decimal(nRcl, decimalPoint));
                                }
                            }
                            if (IsCurve == false) {
                                //add by peter on time 2018-10-15 直线显示（取最后的）
                                xUclData = [];
                                xLclData = [];
                                rUclData = [];
                                rLclData = [];
                                xClData = [];
                                rClData = [];
                                GmaxArr = [];
                                GminArr = [];
                                for (var i = xUclData.length; i < spcJson.length; i++) {
                                    xUclData.push(xucl);
                                    xLclData.push(xlcl);
                                    rUclData.push(rucl);
                                    rLclData.push(rlcl);
                                    xClData.push(decimal(nXcl, decimalPoint));
                                    rClData.push(decimal(nRcl, decimalPoint));
                                    GmaxArr.push(usl);
                                    GminArr.push(lsl);
                                }
                            }
                        }
                        else {
                            rucl = decimal(rcl * result.D4, decimalPoint); //R 上限 UCL
                            rlcl = decimal(rcl * result.D3, decimalPoint); //R 下限 UCL                    
                            xucl = decimal((xcl + rcl * result.A2), decimalPoint); //X 上限 UCL
                            xlcl = decimal((xcl - rcl * result.A2), decimalPoint); //X 下限 LCL 

                            if (spliceQty != 0 && (spliceLen == 1)
                                || nQty / groupQty == totalGroupQty
                                || (spliceQty == 0) && ((nQty - $("#hidNqty").val()) / groupQty == 1)) {

                                //设置控制线数据源
                                xUclData.push(xucl);
                                xLclData.push(xlcl);
                                rUclData.push(rucl);
                                rLclData.push(rlcl);
                                //中心限数据源
                                xClData.push(decimal(xcl, decimalPoint));
                                rClData.push(decimal(rcl, decimalPoint));
                            }
                        }
                        if ((xUclData.length >= totalGroupQty)) {
                            var len = (xUclData.length - totalGroupQty);
                            if (xGraphData.length == totalGroupQty - 1) {
                                len = len + 1;
                            }

                            xUclData.splice(0, len);
                            xClData.splice(0, len);
                            xLclData.splice(0, len);
                            rUclData.splice(0, len);
                            rClData.splice(0, len);
                            rLclData.splice(0, len);
                        }
                    }

                    $("#lblRcl").text(decimal(rcl, decimalPoint));
                    $("#lblXcl").text(decimal(xcl, decimalPoint));
                    $("#lblXucl").text(xucl);
                    $("#lblXlcl").text(xlcl);
                    $("#lblRucl").text(rucl);
                    $("#lblRlcl").text(rlcl);
                    $("#hidNqty").val(nQty);

                    var sigma = decimal(rcl / result.d2, decimalPoint); //Sigma
                    var ppk = decimal(Math.min((usl - xcl) / (3 * stddev), (xcl - lsl) / (3 * stddev)), decimalPoint); //PPK
                    var pp = decimal((usl - lsl) / (6 * stddev), decimalPoint); //PP
                    var ca = decimal(Math.abs((xcl - ((usl + lsl) / 2)) / ((usl - lsl) / 2)) * 100, decimalPoint);
                    var cpk = decimal(Math.min((usl - xcl) / (3 * rcl / result.d2), (xcl - lsl) / (3 * rcl / result.d2)), decimalPoint);
                    var cp = decimal((usl - lsl) / (6 * rcl / result.d2), decimalPoint);
                    var grade = "";
                    if (cpk < 0.67) {
                        grade = "E";
                    }
                    else if (cpk < 1) {
                        grade = "D";
                    }
                    else if (cpk < 1.33) {
                        grade = "C";
                    }
                    else if (cpk < 1.67) {
                        grade = "B";
                    }
                    else {
                        grade = "A";
                    }

                    $("#lblSigma").text(sigma);
                    if (entity.IsShowPPK) {
                        $("#lblPPK").text(ppk);
                    }
                    if (entity.IsShowPP) {
                        $("#lblPP").text(pp);
                    }
                    $("#lblCa").text(ca + "%");

                    if (entity.IsShowCPK) {
                        $("#lblCPK").text(cpk);
                    }

                    if (entity.IsShowCP) {
                        $("#lblCP").text(cp);
                    }
                    $("#lblGrade").text(grade);
                }
            });
            $.ajaxSettings.async = true; //设置getJson同步
            //计算预估不良率 (PPM)      

        }

        /*
        * 对多位小数进行四舍五入
        * num是要处理的数字  v为要保留的小数位数
        */
        function decimal(num, v) {
            var vv = Math.pow(10, v);
            return Math.round(num * vv) / vv;
        }

        /*
        *   创建XBar-R图表
        */
        function buildXBarRCharts(id, data) {
            var maxArr = [];
            var centerArr = [];
            var minArr = [];

            var Gmaxtip = "上限USL";
            var Gmintip = "下限LSL";

            var valtip = "";
            var maxtip = "上限UCL";
            var mintip = "下限LCL";
            var centerTip = "中心限CL";
            var dom = document.getElementById(id);

            /*测试数据
            GmaxArr = [0.13, 0.13, 0.13, 0.13, 0.13, 0.13, 0.13, 0.13, 0.13];
            GminArr = [0.03, 0.03, 0.03, 0.03, 0.03, 0.03, 0.03, 0.03, 0.03]
            xLclData = [0.5, 0.6, 0.5, 0.5, 0.55, 0.45, 0.5, 0.65, 0.45];
            xClData = [0.6, 0.7, 0.65, 0.67, 0.76, 0.75, 0.67, 0.76, 0.75];
            xUclData = [0.8, 0.85, 0.75, 0.87, 0.88, 0.85, 0.77, 0.88, 0.85]
            //xGraphData = [0.6, 0.7, 0.65, 0.75, 0.68, 0.72, 0.58, 0.68, 0.60]; //上下交替
            xGraphData = [0.6, 0.65, 0.65, 0.70, 0.71, 0.72, 0.58, 0.68, 0.69]; //连续上升
            //xGraphData = [0.6, 0.65, 0.65, 0.70, 0.71, 0.72, 0.58, 0.54, 0.50]; //连续下降超控
            data = xGraphData;*/

            if (id == "xcharts") {
                xChartsGraph = echarts.init(dom);
                valtip = "X均值";
                maxArr = xUclData;
                centerArr = xClData;
                minArr = xLclData;
            }
            else if (id == "rcharts") {
                rChartsGraph = echarts.init(dom);
                valtip = "R均值";
                maxArr = rUclData;
                centerArr = rClData;
                minArr = rLclData;
            }

            //上限USL
            var arrUSL = [];
            for (var i = 0; i < subGraphpData.length; i++) {
                arrUSL.push(parseFloat($("#lblUsl").text()));
            }
            GmaxArr = arrUSL;

            //下限LSL
            var arrLSL = [];
            for (var i = 0; i < subGraphpData.length; i++) {
                arrLSL.push(parseFloat($("#lblLsl").text()));
            }
            GminArr = arrLSL;

            //上限UCL
            var arrXUCL = [];
            var arrRUCL = [];
            for (var i = 0; i < subGraphpData.length; i++) {
                arrXUCL.push(parseFloat($("#lblXucl").text()));
                arrRUCL.push(parseFloat($("#lblRucl").text()));
            }
            maxArr = id == "xcharts" ? arrXUCL : arrRUCL;

            //中心限CL
            var arrXCL = [];
            var arrRCL = [];
            for (var i = 0; i < subGraphpData.length; i++) {
                arrXCL.push(parseFloat($("#lblXcl").text()));
                arrRCL.push(parseFloat($("#lblRcl").text()));
            }
            centerArr = id == "xcharts" ? arrXCL : arrRCL;

            //下限LCL            
            var arrXLCL = [];
            var arrRLCL = [];
            for (var i = 0; i < subGraphpData.length; i++) {
                arrXLCL.push(parseFloat($("#lblXlcl").text()));
                arrRLCL.push(parseFloat($("#lblRlcl").text()));
            }
            minArr = id == "xcharts" ? arrXLCL : arrRLCL;


            $.each(data, function (index, item) {
                if (item > maxArr[index] || item < minArr[index]) {
                    //usl 规格上限 lsl 规格下限
                    if (item > usl || item < lsl) {
                        $("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "red").css("color", "#000");
                        for (var i = 0; i < groupQty + 2; i++) {
                            $("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "red").css("color", "#000");
                        }
                    }
                    else {
                        $("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "yellow").css("color", "#000");
                        for (var i = 0; i < groupQty + 2; i++) {
                            $("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "yellow").css("color", "#000");
                        }
                    }
                    data[index] = {
                        value: data[index],
                        symbol: 'emptyHeart',
                        symbolSize: 5,
                        itemStyle: { normal: { color: '#ff0000', label: { show: true } } }
                    };
                }
            });
            option = null;
            if (id != "rcharts") {
                option = {
                    tooltip: {
                        trigger: 'axis'
                    },
                    grid: {
                        left: '2%',
                        top: '30px',
                        right: '2%',
                        bottom: '10px',
                        containLabel: true
                    },
                    legend: {
                        //x: 'left',
                        //y:'center',
                        //orient: 'vertical',                 
                        data: [Gmaxtip, Gmintip, maxtip, centerTip, mintip, valtip]
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            magicType: { show: false, type: ['stack', 'tiled'] },
                            saveAsImage: { show: true }
                        }
                    },
                    color: ["#317010", "#e3e311", "#bd92a9", '#60609D', '#00AA55', '#0000FF'],
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: subGraphpData
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        //规格上限
                        {
                            name: Gmaxtip,
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
                            data: GmaxArr
                        },
                        //规格下限
                        {
                            name: Gmintip,
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
                            data: GminArr
                        },
                        //上限UCL
                        {
                            name: maxtip,
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
                            data: maxArr
                        },
                        //中心限CL
                        {
                            name: centerTip,
                            type: 'line',
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        color: '#60609D'
                                    }
                                }
                            },
                            smooth: true,
                            symbol: 'none',
                            data: centerArr
                        },
                        //下限LCL
                        {
                            name: mintip,
                            type: 'line',
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        color: '#00AA55'
                                    }
                                }
                            },
                            smooth: true,
                            symbol: 'none',
                            data: minArr
                        },
                        {
                            name: valtip,
                            type: 'line',
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        color: '#0000FF'
                                    }
                                    //,
                                    //label: { show: true }
                                }
                            },
                            smooth: false,
                            data: data
                        }]
                };
            }
            else {
                option = {
                    tooltip: {
                        trigger: 'axis'
                    },
                    grid: {
                        left: '2%',
                        top: '30px',
                        right: '2%',
                        bottom: '10px',
                        containLabel: true
                    },
                    legend: {
                        //x: 'left',
                        //y:'center',
                        //orient: 'vertical',                 
                        data: [maxtip, centerTip, mintip, valtip]
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            magicType: { show: false, type: ['stack', 'tiled'] },
                            saveAsImage: { show: true }
                        }
                    },
                    color: ["#bd92a9", '#60609D', '#00AA55', '#0000FF'],
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: subGraphpData
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
                                        color: '#bd92a9'
                                    }
                                }
                            },
                            smooth: true,
                            symbol: 'none',
                            data: maxArr
                        },
                        {
                            name: centerTip,
                            type: 'line',
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        color: '#60609D'
                                    }
                                }
                            },
                            smooth: true,
                            symbol: 'none',
                            data: centerArr
                        },
                        {
                            name: mintip,
                            type: 'line',
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        color: '#00AA55'
                                    }
                                }
                            },
                            smooth: true,
                            symbol: 'none',
                            data: minArr
                        },
                        {
                            name: valtip,
                            type: 'line',
                            itemStyle: {
                                normal: {
                                    lineStyle: {
                                        color: '#0000FF'
                                    }
                                    //,
                                    //label: { show: true }
                                }
                            },
                            smooth: false,
                            data: data
                        }]
                };
            }
            if (option && typeof option === "object") {
                if (id == "xcharts") {
                    xChartsGraph.setOption(option, true);
                } else if (id == "rcharts") {
                    rChartsGraph.setOption(option, true);
                }
            }
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

        var hasWarnQty = 0; //已预警组数量
        /**
        *控制图预警
        */
        function graphWarn(entity) {

            var currentQty = 0;
            var isWarnA = entity.IsWarnA;
            var isWarnB = entity.IsWarnB;
            var isWarnC = entity.IsWarnC;
            var isWarnD = entity.IsWarnD;
            var isWarnE = entity.IsWarnE;

            var sideWarnQty = entity.WarnCVal; //连续中心限同一侧报警数量
            var upSideQty = 0; //X中心限上同一侧数量
            var downSideQty = 0; //X中心限下同一侧数量
            var rUpSideQty = 0; //R中心限上同一侧数量
            var rDownSideQty = 0; //R中心限下同一侧数量

            var nSortWarnQty = entity.WarnDVal //n点连续上升或者下降报警 
            var nAscQty = 0; //连续上升数量
            var nDescQty = 0; //连续下降数量     

            var xrSortWarnQty = entity.WarnEVal; //n点上下交替预警数量
            var xrSortQty = 0; //n点上下交替 
            var errorMsg = "";

            var needWarnQty = 0; //需要检测的组数
            needWarnQty = (nQty / groupQty);

            /* 暂注释 不知道搞什么 update by peter on 2018-12- 5
            if (hasWarnQty == 0) {
                hasWarnQty = (nQty / groupQty);
            }
            if (spliceQty == 0) {//未超过总组数
                needWarnQty = (nQty / groupQty) - hasWarnQty;
            }
            else {
                needWarnQty = (spliceLen > totalGroupQty) ? totalGroupQty : spliceLen;

                if (spliceLen <= 1 && spcJson[spcJson.length - 1].length % groupQty == 0) {
                    needWarnQty++;
                }
                if ((spliceLen > 1
                    && dataCount % groupQty != 0
                    && spcJson[spcJson.length - 1].length % groupQty != 0)
                    || spliceLen == 1 && !isGroup) {
                    needWarnQty--;
                }
            }
            //alert("隐藏组数：" + spliceLen + " 现有组数：" + nQty / groupQty + " 已检测组数：" + hasWarnQty + " 需要检测的组数：" + needWarnQty);
            hasWarnQty = hasWarnQty + needWarnQty;
            */

            //A、B预警
            for (var i = needWarnQty; i > 0; i--) {
                var j = xGraphData.length - i;
                var item = (xGraphData[j]);
                if (typeof (item) == "object") {
                    item = (item.value);
                }
                //A 超规预警（所有点预警）
                if (isWarnA) {
                    if (item > usl) {
                        errorMsg += ("A超规：" + item + " 超过规格上限USL" + usl + "！\n");
                    }
                    else if (item < lsl) {
                        errorMsg += ("A超规：" + item + " 超过规格下限LSL" + lsl + "！\n");
                    }
                }
                //B 超控预警
                if (isWarnB) {
                    if (item > xUclData[j]) {
                        errorMsg += ("B超控：" + item + " 超过X控制上限UCL" + xUclData[j] + "！\n");
                    }
                    if (item < xLclData[j]) {
                        errorMsg += ("B超控：" + item + " 超过X控制下限LCL" + xLclData[j] + "！\n");
                    }
                }
            }

            //C预警：n点在中线同一侧
            if (isWarnC && (xGraphData.length >= sideWarnQty)) {
                for (var i = sideWarnQty; i > 0; i--) {
                    var j = xGraphData.length - i;
                    var item = xGraphData[j];

                    if (item > xClData[j]) {//X中心限上
                        upSideQty++;
                        if (upSideQty >= sideWarnQty && (xGraphData[j + 1] <= xClData[j] || (j == xGraphData.length - 1))) {
                            errorMsg += ("C预警：" + upSideQty + "点在X中心限上的同一侧！\n");
                        }
                    }
                    else {
                        upSideQty = 0;
                    }
                    if (item < xClData[j]) {//X中心限下 
                        downSideQty++;
                        if (downSideQty >= sideWarnQty && (xGraphData[j + 1] >= xClData[j] || (j == xGraphData.length - 1))) {
                            errorMsg += ("C预警：" + downSideQty + "点在X中心限下的同一侧！\n");
                        }
                    }
                    else {
                        downSideQty = 0;
                    }

                }
            }

            //D预警： n点连续上升或者下降预警
            if (isWarnD && (xGraphData.length >= nSortWarnQty)) {
                for (var i = nSortWarnQty; i > 0; i--) {
                    var j = xGraphData.length - i;
                    var item = (xGraphData[j]);

                    if (item < xGraphData[j + 1] || (xGraphData[j + 1] == undefined && item > xGraphData[j - 1])) {//连续上升
                        nAscQty++;
                        if (nAscQty == nSortWarnQty) {
                            errorMsg += ("D预警：" + nAscQty + "点数据连续上升！\n");
                        }
                    } else {
                        nAscQty = 0;
                    }
                    if (item > xGraphData[j + 1] || (xGraphData[j + 1] == undefined && item < xGraphData[j - 1])) {//连续下降
                        nDescQty++;

                    } else {
                        nDescQty = 0;
                    }
                }
                if (nDescQty == nSortWarnQty) {
                    errorMsg += ("D预警：" + nDescQty + "点数据连续下降！\n");
                }
            }

            //E预警：n点上下交替预警
            var sortCount = (xrSortWarnQty * 2 + 1);
            if (isWarnE && (xGraphData.length >= sortCount)) {
                for (var i = sortCount; i > 0; i--) {
                    var j = xGraphData.length - i;
                    var item = (xGraphData[j]);

                    if ((xGraphData[j - 1] < item && item > xGraphData[j + 1])
                        || (xGraphData[j - 1] > item && item < xGraphData[j + 1])
                        || (xGraphData[j + 1] == undefined
                            && ((xGraphData[j - 1] > xGraphData[j - 2] && xGraphData[j - 1] > item)
                                || (xGraphData[j - 1] < xGraphData[j - 2] && xGraphData[j - 1] < item)))
                        || (xGraphData[j - 1] == undefined
                            && ((xGraphData[j + 1] > xGraphData[j + 2] && xGraphData[j + 1] > item)
                                || (xGraphData[j + 1] < xGraphData[j + 2] && xGraphData[j + 1] < item)))
                    ) {
                        xrSortQty++;
                        if (xrSortWarnQty == (xrSortQty - 1) / 2) {
                            errorMsg += ("E预警：" + xrSortWarnQty + "点数据上下交替！\n");
                        }
                    }
                    else {
                        xrSortQty = 0;
                    }
                }
            }
            if (errorMsg != "") {
                //消息预警
                //errorMsg 预警消息,spcTaskId 预警任务ID,entity.SPCActionProc 预警执行的存储过程
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSPC.XbarRGraphWarn(spcTaskId, errorMsg, entity.SPCActionProc);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }

        }

    </script>
</asp:Content>
