<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KanbanPage.aspx.cs" 
Inherits="SKT.LeanMES.Web.Kanban.KanbanSingle" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
   <%-- <meta http-equiv="X-UA-Compatible" content="IE=edge" />--%>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link href="../Content/theme/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../Content/animate.css" rel="stylesheet" />
<%--    <link href="../Content/plugin/jquery-ui-1.10.4/jquery-ui.min.css" rel="stylesheet"
        type="text/css" />--%>
    <%--<script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>--%>
    <script src="../Content/plugin/jquery-ui-1.10.4/jquery-1.10.2.js" type="text/javascript"></script>
    <%--开发模式，含console提示，不兼容IE8<script src="../Content/Kanban/echarts.js" type="text/javascript"></script>--%>
    <script src="../Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <%--<script src="../Content/plugin/jquery-ui-1.10.4/jquery-ui.min.js" type="text/javascript"></script>--%>
    <script src="../Content/plugin/highCharts/highcharts.js" type="text/javascript"></script>
    <script src="../Content/plugin/highCharts/highcharts-3d.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="../Content/theme/bootstrap/js/respond.js"></script>
    <![endif]-->
    <style type="text/css">
        html, body {
        font-family: Verdana, 微软雅黑,黑体, 宋体;
        overflow:hidden;
        }
        .contUnit
        {
            border-color: #d3d3d3 !important;
            border: solid 1px;
            text-align: center;
            padding: 60px;
            border-collapse: collapse;
            overflow: auto;
        }
        .addShadow {
            box-shadow: 5px 5px 7px #888888;
        }
        html, body ,form ,#divMaster
        {
            height: 99.9%;
            /*overflow: auto;*/
            margin: 0;
            padding: 0;
            border: 0px;
            border-collapse: collapse;
        }
        #divMasterTitle .clock li
        {
            display: inline;
            font-size: x-large;
            text-align: center;
            font-family: Arial;
        }
        #divMasterTitle .Date
        {
            font-family: Arial;
            font-size: large;
            text-align: center;
        }
        #divMasterBody .clock li
        {
            display: inline;
            font-size: medium;
            font-family: Arial;
        }
        #divMasterBody .Date
        {
            font-family: Arial;
            font-size: medium;
            text-align: center;
        }
        #divMasterFoot .clock li
        {
            display: inline;
            font-size: medium;
            font-family: Arial;
        }
        #divMasterFoot .Date
        {
            font-family: Arial;
            font-size: medium;
            text-align: center;
        }
        #divMasterTitle,#divMasterFoot
        {
            padding: 0px;
            /*min-height: 1%;*/
            max-height: 10%;
            overflow: hidden;
            vertical-align: middle;
        }
        .divTitle
        {
            padding: 0px;
            max-height: 70px;
            overflow: hidden;
             
        }
        .divMasterTitle {
            padding: 0px;
            height: 70px;
            overflow: hidden;
            line-height:70px;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
        }
            .divMasterTitle div {
                 height: 70px;
                 line-height:70px;
                  padding:0 5px 0 5px;
                vertical-align:middle;
                 text-align:center; 
                 font-family: Verdana, 微软雅黑,黑体, 宋体;
            }
             
        .divL
        {
            text-align: left;
            padding: 0px;
        }
        .divM
        {
            text-align: center;
            padding: 0px;
        }
        .divR
        {
            text-align: right;
            padding: 0px;
        }
        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th
        {
            padding: 8px;
            vertical-align: top;
            border-top: 1px solid #ddd;
            text-align: center;
        }
        table tr:nth-child(even) {
            background: RGBA(254, 210, 210, 0.20);
        }
        /*.ListTableEvenRow {
            background: rgb(254, 210, 210);
        }*/
    </style>
    <title>电子看板 - <%= Resources.Common.AppName%></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="btnFullShow" title="全屏显示" style="font-size: 12px; background:#f1f1f1; padding:5px; cursor: pointer;  display: none; position:absolute; top:5px; right:5px; z-index:1000000;" class="btn-default">
        <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAy0lEQVQ4T7WT7RHBQBCGn1QgJdBBSqATOqACUgEd0EmUQAWUoAPmzWTHZe2NGNyvu73d5/bjvQK4019nYArcnL0CjsAotRcOkAu2mBeIB6yAnXvZHzfA2owG0MsHYAssun3EmQN7oAaWKkeAU1KzOUQQf9eWI0DpGiZHlTFO7NpfguwqAaLlofIR5Oqdc4A3fXxe/w3wUQlREzXOydAmfjPGxoQkiISk8Q0RktQoIZU/k7LNRZnMgp+YfqamE19r8xnIloNIur1gOT8AdoQ+SAtB/HUAAAAASUVORK5CYII="/> 全屏显示</div>
    <div id="divMaster">
            <div style="height:2px; background:#ffffff;" ></div>
        <div id="divMasterTitle">
        </div>
        <div style="clear: both" id="divMasterBody">
        </div>
        <div style="clear: both" id="divMasterFoot">
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hfMasterTitle" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfMasterFoot" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfContainList" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfServerTime" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hidMachineMac" ClientIDMode="Static" />
    </form>
</body>
</html>
<script type="text/javascript">
    var tmpName = '<%=Request.QueryString["name"] %>';
    var contId = '<%=Request.QueryString["ID"] %>';
    var fullShow = '<%=Request.QueryString["full"] %>';
 
    var winHeight = $(document.body).height() - 50; //        浏览器当前窗口文档body的高度： 
    var winWidth = $(document.body).width() - 50; //浏览器当前窗口文档body的宽度： 
    var settingCont = 0;    //播放中的看板容器编号
    var masterPlayer;
    var compsPlayer = [];   // comp buffer //task{}增加ID属性，以便对象控制2016-11-14
    var echartDom = [];     //记录echart的DOM ID
    var posFlag = 0;//当前容器的定位（绘制）模式
    $(document).ready(function () {
        fullMode(); // fullScreen button
        $("#divMasterTitle").html($("#hfMasterTitle").val());   //Master Title
        $("#divMasterFoot").html($("#hfMasterFoot").val());   //Master Foot
        showClock();                                            //Master Clock
        initPage(); //Just Container 开始绘制看板容器
        $(window).resize(function () {
            setUnitAttr();
            echartResize();
        });

        window.onunload = function () {
            //alert("退出了");
            clearShowLoop();
        }
        //2017-6-5  加入9分钟强制刷新页面做测试BirongLiang 
        //2017-09-07 Alen 每隔一个小时强制将整个看板页面刷新一次；
        var timeoutTime = 3600000;//60分钟 
        setTimeout(function () {
            window.location.href = location.href;
        }, timeoutTime);

        //2017-09-07 Alen 显示穿越过来的看板
        var macAddress = $("#<%=this.hidMachineMac.ClientID%>").val();
        if (macAddress != "" && macAddress != "00-00-00-00-00-00") {
            var intervalTime = 300000;//5分钟
            setInterval(function () {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetKanbanName(macAddress);
                if (ajax.error == null) {
                    var kanbanName = ajax.value;
                    if (kanbanName != "" && tmpName != kanbanName) {
                        location.href = "../Kanban/KanbanPage.aspx?name=" + kanbanName + "&full=1";
                    }
                }

            }, intervalTime);//每5分钟检查一次是否有穿越到此设备的看板
        }
        
        //Add By Alen 2017-09-02 重新设置看板头部样式，使用整体一致
        $(".divMasterTitle .divR,.divMasterTitle .divL").addClass("col-md-2").removeClass("col-md-4");
        $(".divMasterTitle .divM").addClass("col-md-8").removeClass("col-md-4");
        $(".divMasterTitle .divL img").css("margin-top", (35 - 45 / 2) + "px");
        $(".divMasterTitle .divR img").css("margin-top", (35 - 45 / 2) + "px");
        $(".divMasterTitle .divL img,.divMasterTitle .divR img").css({ height: '45px', width: '200px' });
        $(".addShadow").removeClass("addShadow");
        //Add By Alen 2017-09-02 对于特殊看板头进行设置，可使用参数，
        //{param:"对看板要传的参数条件，名字和url参数名字一样，多个参数使用&分割",
        // date:'此参数的值可以为任意，如果有此参数，看板会自动添加当前日期',
        // marquee:'如果有此参数，看板会将此参数的内容作为走马灯显示'}        
        var content = $(".divMasterTitle .divM").html();
        if (content.trim() == "") {
            $("#divMasterTitle").hide();
            return false;
        }
        try {
            var obj = eval('(' + content + ')');
            var i = 0;
            var t1 = obj.param;

            if (t1 != undefined) {
                t1 = t1;
                if (t1 && t1 != undefined) {
                    i = i + 1;
                }
                else {
                    t1 = "";
                }
            }
            else {
                t1 = "";
            }
            var t2 = obj.date;

            if (t2 != undefined) {
                t2 = $("#hfServerTime").val();
                i = i + 1;
            }
            else {
                t2 = "";
            }
            var t3 = obj.marquee;
            if (t3 != undefined) {
                t3 = "<marquee>" + t3 + "</marquee>";
                i = i + 1;
            }
            else {
                t3 = "";
            }
            i = 12 / i;
            var html = "";
            if (t1 != "") {
                html += '<div class="col-md-' + i.toString() + '">' + t1 + '</div>';
            }

            if (t2 != "") {
                html += '<div class="col-md-' + i.toString() + '">' + t2 + '</div>';
            }

            if (t3 != "") {
                html += '<div class="col-md-' + i.toString() + '">' + t3 + '</div>';
            }
            if (html != "") {
                $(".divMasterTitle .divM").html('<div class="container-fluid"><div class="row">' + html + '</div></div>');
            }
        } catch (e) {
            console.log(e);
        }
    });

    function clearShowLoop() {
        clearInterval(masterPlayer);  //clear contain loop
        if (compsPlayer.length > 0) {  //clear component loop
            for (var curComps = 0; curComps < compsPlayer.length; curComps++) {
                compsPlayer[curComps].stop();
            }
            compsPlayer = [];
        }
    }

    function initPage() {
        var containIdList = $.parseJSON($("#hfContainList").val());
        var contId;
        var contBody;
        //console.log("容器：" + $("#hfContainList").val());
        //console.log("容器数量：" + containIdList.length);
        echartDom = []; //clear Dom records
        if (settingCont >= containIdList.length) {
            settingCont = 0;
            clearInterval(masterPlayer);
            initPage();
            return;
        } else {
            contId = containIdList[settingCont].KanbanContainerId;
            contBody = getContainerLayOut(containIdList[settingCont].LayoutType);
            posFlag = containIdList[settingCont].PositionType;              //定位方式
            $("#divMasterBody").empty();                                        // clear Body 
            $("#divMasterBody").prepend(containIdList[settingCont].Title); // Container Title
            showClock();                                                    //container clock
            $("#divMasterBody").append(contBody);                           // Container Body
            $.when(setContEditOption(contId))                          // Set User Setting in Container Body，如果需要容器级别的额外样式
                .done(setUnitAttr(posFlag))
                .done(showComponents(contId));                                   //SET ID & width & height... ，如果需要控件级别的额外样式
            //showComponents(contId);                          //Show Component by ContainerID

            if (typeof masterPlayer !== 'undefined') {
                clearInterval(masterPlayer);
            }
            masterPlayer = setInterval(function () { initPage(); }, containIdList[settingCont].PlayMinutes * 1000);
            settingCont = settingCont + 1;
        }

    }

    function getContainerLayOut(type) {
        if (type === 'undefined' || type === "") {
            //console.log("未能获取容器类型，描绘版面失败");
            return '';
        }
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetContainerHtml(type);
        var objResult = JSON.parse(ajax.value);
        if (ajax.value !== "") {
            return objResult[0].RawCode;
        }
    }

    //设置预览控件所在长宽数值
    function setUnitAttr() {
        winHeight = $(document.body).height();
        winWidth = $(document.body).width();
        var bodyWidth = $("#divMasterBody").css("width").slice(0, -2) * 1;
        var bodyHeight = winHeight - $("#divMasterTitle").css("height").slice(0, -2) * 1
                                    - $("#divMasterFoot").css("height").slice(0, -2) * 1 
                                    - $("#divTitle").css("height").slice(0, -2) * 1;
        //alert(bodyHeight)
        var compWidthArr = [];
        var sumCompWidth = 0;
        var unitHeight = 0;
        $('.contUnit').each(function (key, value) {
//            $(this).css("width", '');
//            $(this).css("height", '');
            $(this).attr("id", "divShowComp" + key); // SET ID
            //$(this).addClass("showUnit"); // SET CLASS
            $(this).css("padding", "0"); //CLEAR padding
            //sumCompWidth += $(this).css("width").slice(0, -2) * 0.01 * winWidth; //get Sum(width)
            sumCompWidth += parseInt($(this).css("width"), 10);
            compWidthArr[key] = parseInt($(this).css("width"), 10) - 7;

        });
        var r = Math.ceil((sumCompWidth) / winWidth);
        unitHeight = Math.round(bodyHeight / r); //get Avg(Height)
        //alert(bodyHeight + "///" + sumCompWidth + "//" + winWidth+"=="+r)
        if (posFlag * 1 === 0) { //position:auto，设置每个Unit的高度
            //SET width & height
            $('.contUnit')
                .each(function(key, value) {
                    //$(this).css("width", compWidthArr[key]);
                    $(this).css("height", unitHeight);
                });
        } else { //绝对定位时，添加阴影
            $('.contUnit').addClass("addShadow");
        }

    }

    function setContEditOption(contId) {
        var ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetContainerEditOption(contId);
        var strJson = ajxService.value;
        var optionObj = $.parseJSON(strJson);
        $("#divMasterBody").css("background-color", optionObj.bodyColor);
        //2017-4-13主体背景跟随容器背景变化
        $("#divMaster").css("background-color", optionObj.bodyColor);

    }

    function showComponents(contId) {
        var compData = [];
        var compObjArr = [];
        var ajax, ajaxResult;
        if (compsPlayer.length > 0) {
            for (var curComps = 0; curComps < compsPlayer.length; curComps++) {
                compsPlayer[curComps].stop();
            }
            compsPlayer = [];
        }

        ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetMapContainer(contId);
        if (ajax.error == null && ajax.value != null) {
            var entityAry = ajax.value;
            for (var a = 0; a < entityAry.length; a++) {
                compData[a] = entityAry[a].KanbanComponentId;
                //console.log(entityAry[a].ComponentName);
            }
        }

        for (var i = 0; i < compData.length; i++) {
            if (compData[i] !== "" || compData[i] !== "0") {
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetCompParamById(compData[i]);
                ajaxResult = ajax.value;
                if (ajaxResult[0] !== null && ajax.error == null) {
                    //提取EditOption
                    var compEditOption = $.parseJSON(ajaxResult[0].EditOption); //用户配置内容
                    var pageSize = compEditOption.showRowNum * 1 > 0 ? compEditOption.showRowNum : -1;
                    compObjArr.push({
                        "compData": (ajaxResult[0].DataSource || ''),
                        "compDsType": ajaxResult[0].SourceType || '',
                        "compPara1": ajaxResult[0].Param1 || '',
                        "compPara2": ajaxResult[0].Param2 || '',
                        "compRe": ajaxResult[0].RefreshSec || 0,
                        "compEditOption": ajaxResult[0].EditOption || '',
                        "compPageSize": pageSize, //分页表格行数
                        "compStartRow": 0, //分页表格开始行
                        "compDOM": "divShowComp" + i
                    });

                    compsPlayer.push(createComp(compObjArr[i], ajaxResult[0].RefreshSec * 1));//创建控件

                    if (ajaxResult[0].Param2 === 'echart') {
                        echartDom.push(compObjArr[i].compDOM); //save echart dom id
                        //showChart(compObjArr[i]); 
                        compsPlayer[compsPlayer.length - 1].excutor = showChart; //set loop
                        compsPlayer[compsPlayer.length - 1].play(); //first generate
                        
                    }
                    if (ajaxResult[0].Param2 === 'text') {
                        //showText(compObjArr[i]); //first generate
                        compsPlayer[compsPlayer.length - 1].excutor = showText;
                        compsPlayer[compsPlayer.length - 1].play();
                    }
                    if (ajaxResult[0].Param2 === 'web') {
                        //showPage(compObjArr[i]); //first generate
                        compsPlayer[compsPlayer.length - 1].excutor = showPage;
                        compsPlayer[compsPlayer.length - 1].play();
                    }
                    if (ajaxResult[0].Param2 === 'table') {
                        //showTable(compObjArr[i],null,0); //first generate
                        compsPlayer[compsPlayer.length - 1].excutor = showTable;
                        compsPlayer[compsPlayer.length - 1].pageSize = pageSize; //分页表格行数目
                        compsPlayer[compsPlayer.length - 1].taskId = compsPlayer.length - 1; //ID
                        compsPlayer[compsPlayer.length - 1].play();
                    }
                    if (ajaxResult[0].Param2 === 'highchart') {
                        //echartDom.push(compObjArr[i].compDOM);     //save echart dom id
                        //showHightChart(compObjArr[i]);
                        compsPlayer[compsPlayer.length - 1].excutor = showHightChart; //update by loop
                        compsPlayer[compsPlayer.length - 1].play();
                    }
                    compsPlayer[compsPlayer.length - 1].start();
                } else {//2017-4-14 修复为空控件时的BUG
                    compObjArr.push({"compData":'',
                        "compDsType":'',
                        "compPara1":'',
                        "compPara2":'',
                        "compRe": 0,
                        "compEditOption": '',
                        "compDOM": "divShowComp" + i
                    });
                }
            }
        }
    }

    function showChart(paraObj) {
        var defTheme = getTheme();
        var dataSource = paraObj.compData;                          //默认主题配色
        var _compChartType = paraObj.compPara1;                     //控件类型：折线图，柱状图......
        var compEditOption = $.parseJSON(paraObj.compEditOption);   //用户配置内容
        var _compTitle = compEditOption.titleText;                  //标题
        var compTheme = compEditOption.compTheme * 1;               //整体色调，已设定好的css配置
        var backgroundColor = defTheme.backgroundColor[compTheme];  //背景颜色
        var textStyle = defTheme.textStyle[compTheme];              //主体色调
        var titleStyle = defTheme.titleStyle[compTheme];            //控件标题主题色调
        var titleSize = compEditOption.titleSize * 1;               //控件标题大小
        var titleLoc = compEditOption.titleLoc;                     //控件标题方位
        var lineStyle = defTheme.lineStyle[compTheme];
        var showDom = paraObj.compDOM;                                  //生成chart的DOM节点
        //var ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson(dataSource);
        var procParas = compEditOption.dsParas == null ? '' : compEditOption.dsParas;
        var ajxService = ExecProc(dataSource, procParas);
        var strJson = ajxService.value;
        //console.log(strJson);
        var dataObj = $.parseJSON(strJson);
        if (!dataObj || !dataObj[0] || dataObj[0].length <= 1) {
            //console.log(dataSource + "数据为空");
            return;
        }
        var objLen = dataObj.length;
        var dataGroup = -1;      //数据集数量(列名),从-1开始因为第一列是XLabel
        var atrName = [];       //存放数据属性名
        var oneDimensionData = [];    //一维数据类型   [{name:XXX,value:xxx}]
        var itemStyle = {
            normal: {
                //color: function (params) {
                //    // build a color map as your need.
                //    var colorList = [
                //'#C1232B', '#B5C334', '#FCCE10', '#E87C25', '#27727B',
                // '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
                // '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'
                //    ];
                //    return colorList[params.dataIndex]
                //},
                label: {
                    show: true,
                    position: 'top'
                    //formatter: '{b}\n{c}'
                }
            }
        };
        for (var attr in dataObj[0]) {
            atrName.push(attr);
            dataGroup++;
        }
        var mySeries = [];
        var dataSet = [];     //数据集数组(二维数组)
        var xLabel = [];                        //X轴标示

        if (_compChartType === 'pie' || _compChartType === 'funnel' || _compChartType === 'gauge') {
            dataGroup = 1;      //一维数据的chart类型，数据集只拿一次
        }

            var __compChartType,isMultipChart=false;
            if (_compChartType.indexOf(",") != -1) {
                __compChartType = _compChartType.split(",");
                isMultipChart = true;
            }
             
            var chartTypes = (isMultipChart) ? __compChartType.length : dataGroup;
            if (chartTypes < dataGroup)
            {
                dataGroup = chartTypes;
            }
                 
            for (var d = 0; d <= dataGroup; d++) {
                var ts = [];
                var _chart_type = "";
                for (var i = 0; i < objLen; i++) {
                    if (d === 0) {
                        xLabel.push(dataObj[i][atrName[0]]); //每{}第一属性}
                    } else {
                        ts.push(dataObj[i][atrName[d]]);    //构造 Y-Value
                        oneDimensionData.push({
                            name: dataObj[i][atrName[0]], value: dataObj[i][atrName[d]]
                        });
                    }
                }
                
                if (d > 0) {
                    dataSet.push(ts);              //构造 dataSet

                    if (isMultipChart) {
                        _chart_type = __compChartType[d - 1];
                    }
                    else {
                        _chart_type = _compChartType;
                    }
                    mySeries.push({ name: atrName[d], type: _chart_type, data: ts, itemStyle: itemStyle });

                }
                
            }

        //判断是否需要生成echarts实例。
        //IE8下，init方法不会自动删除上次实例，只能init()一次。
        var myChart = echarts.getInstanceByDom(document.getElementById(showDom));
        if (!myChart) {
            myChart = echarts.init(document.getElementById(showDom));           
        }
        var arrLegend = atrName.slice(1);

        // 指定图表的配置项和数据
        var option = {
            //如要指定颜色
            color: ['#097532', '#1466c2', '#8acaaa', '#cc5664', '#f1ec64', '#ee8686', '#a48dc1', '#5da6bc', '#b9dcae'],
            backgroundColor: backgroundColor,
            textStyle: textStyle,
            title: {
                text: _compTitle,
                textStyle: titleStyle,
                left: titleLoc,
                subtext: ''
            },
            tooltip: {},
            legend: {      //图例组件展现了不同系列的标记(symbol)。
                show: true,
                x: 'center',
                y: 'top',
                textStyle: 'auto',
                data: arrLegend
            },
            xAxis: null, //X轴标签数组
            yAxis: null,
            toolbox: {
                show: true,
                feature: {
                    dataZoom: {
                        yAxisIndex: 'none'
                    },
                    dataView: { readOnly: false },
                    /*magicType: { type: ['line', 'bar' ,'stack', 'tiled'] },*/
                    restore: {},
                    saveAsImage: {}
                }
            }
        };

        option.title.textStyle.fontSize = titleSize; //titleSize
         
        switch (_compChartType) {
            case 'line':
                option.xAxis = { data: xLabel, axisLine: { lineStyle: lineStyle }, splitLine: { show: true,lineStyle:lineStyle } };
                option.yAxis = { axisLine: { lineStyle: lineStyle }, splitLine: { show: true, lineStyle: lineStyle } };
                option.series = mySeries;
                break;
            case 'bar':
                option.xAxis = { data: xLabel, axisLine: { lineStyle: lineStyle }, splitLine: { show: true, lineStyle: lineStyle } };
                option.yAxis = { axisLine: { lineStyle: lineStyle }, splitLine: { show: true, lineStyle: lineStyle } };
                option.series = mySeries;
                break;
            case 'pie':
                option.series = { name: atrName[0], radius: '65%', center: ['50%', '60%'], type: _compChartType, data: oneDimensionData
                };
                break;
            case 'gauge': //仪表盘
                option.series = { name: atrName[0], type: _compChartType, data: oneDimensionData, title: { textStyle: {color:'#eee'}} };
                break;
            case 'funnel':
                option.series = { name: atrName[0], type: _compChartType, data: oneDimensionData };
                break;
            case 'line,bar':
                option.xAxis = { data: xLabel, axisLine: { lineStyle: lineStyle }, splitLine: { show: true, lineStyle: lineStyle } };
                option.yAxis = { axisLine: { lineStyle: lineStyle }, splitLine: { show: true, lineStyle: lineStyle } };
                option.series = mySeries;
                break;
            default:
                {
                    alert("未支持的类型");
                    return false;
                }
        }
        myChart.setOption(option);

        
    }

    function showText(paraObj) {
        var myData = paraObj.compData;
        var compEditOption = $.parseJSON(paraObj.compEditOption);
        //var _compTitle = _compEditOption.titleText;
        var showDom = paraObj.compDOM;
        $("#" + showDom).html(myData);
    }

    function showPage(paraObj) {
        var myData = paraObj.compData;
        //var _compEditOption = $.parseJSON(paraObj.compEditOption);
        var showDom = paraObj.compDOM;
        $("#" + showDom).html("<iframe style='width:100%;height:100%;' frameborder='0' src='" + myData + "'></iframe>");
    }

    //var startRow = 0;   //初始化分页查询时的显示行号,全局参数
    function showTable(paraObj,compPlayerId,showOffset) {
        var myTable = paraObj.compData;
        var compEditOption = $.parseJSON(paraObj.compEditOption);
        var defTheme     = getTheme();
        var compTheme = compEditOption.compTheme * 1;               //默认主题标识值
        var backgroundColor = defTheme.backgroundColor[compTheme];
        var fontColor = defTheme.textStyle[compTheme].color;
        var titleSize = compEditOption.titleSize;
        var titleLoc = compEditOption.titleLoc; //not use
        var showDom = paraObj.compDOM;              //控件坐标DOM
        var dsType = paraObj.compDsType;            //数据源类型
        //var changePageTime = compEditOption.changePageTime;  //翻页间隔     
        var pageSize = compEditOption.showRowNum * 1;               //每页显示行数
        var matchColLoc = compEditOption.matchColLoc ? compEditOption.matchColLoc * 1 : 0;                  //值配对坐标 Cell
        var matchColLocValue = compEditOption.matchColLocValue ? compEditOption.matchColLocValue : '';      //配对值
        var matchColLocOp = compEditOption.matchColLocOp ? compEditOption.matchColLocOp : '';               //配对操作  
        var matchColLocCss = compEditOption.matchColLocCss ? compEditOption.matchColLocCss : '';            //配对值附加CSS 
        var curRow = showOffset ? showOffset : 0;
        var compCss = compEditOption.compCss;                   //表格控件用户增加的CSS代码
        var tableEvenColor = defTheme.tableEven[compTheme].color;
        var tbHeadCss = compEditOption.tHeadCss;
        var procParas = compEditOption.dsParas == null ? '' : compEditOption.dsParas;
        var ajxService;
        if (dsType.toLowerCase() === 'procedure') {
            //ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson(myTable);
            ajxService = ExecProc(myTable, procParas);
        } else {
            ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetTabelByPager(curRow, pageSize, myTable);
        }
        
        var strJson = ajxService.value;
        var dataObj = $.parseJSON(strJson);
        //if (!dataObj[0] || dataObj[0].length <= 1) {
            //console.log(myTable + "数据为空");
        //    return;
        //}

        var objLen = dataObj.length;
        //如果返回数据刚好为0，并且开始行数据不为0
        if (objLen === 0 && compsPlayer[compPlayerId].curRowNum > 0) {
            compsPlayer[compPlayerId].curRowNum = 0; //初始化开始行为0
            compsPlayer[compPlayerId].play();//执行一次
            return;
        }
        //开始行更新
        if (compPlayerId !== null) {
            if (objLen < pageSize) { //当得到的数据不够设定的显示行数时重置startRow
                compsPlayer[compPlayerId].curRowNum = 0;
            } else {
                compsPlayer[compPlayerId].curRowNum = compsPlayer[compPlayerId].curRowNum + pageSize;
            }
        } else {
             
        }

        var myHtml = "<table width='100%' class='table table-bordered' " +
                "style='background-color: " + backgroundColor + ";color: " + fontColor + "; "+compCss+";'>" +
                "<tr style='font-size: " + titleSize + "px;" + tbHeadCss + "'>";
        var dataGroup = 0;
        var atrName = [];       // 列名
        for (var attr in dataObj[0]) {
            atrName.push(attr);
            dataGroup++;
            myHtml += "<th>" + attr + "</th>";
        }
        if (dataGroup == 0)
        {
            myHtml += "<td>暂无数据</td>";
        }
        myHtml += "</tr><tbody>";
        for (var r = 0; r < objLen; r++) {
            if (r % 2 == 1) {
                myHtml += "<tr class='ListTableEvenRow  animated fadeInUp' style='background-color:" + tableEvenColor + "'>";

            } else {
                myHtml += "<tr class='ListTableOddRow  animated fadeInUp'>";
            }
            
            for (var c = 0; c < atrName.length; c++) {
                if (matchColLoc > 0 && c === matchColLoc-1) {
                    switch(matchColLocOp) {
                        case 'eq':
                            if (dataObj[r][atrName[c]] == matchColLocValue) { //值配对判断
                                myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                            } else {
                                myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                            }
                            break;
                        case 'bg':
                            if (dataObj[r][atrName[c]]*1 > matchColLocValue*1) { //值配对判断
                                myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                            } else {
                                myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                            }
                            break;
                        case 'le':
                            if (dataObj[r][atrName[c]]*1 < matchColLocValue*1) { //值配对判断
                                myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                            } else {
                                myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                            }
                            break;
                        case 'bgeq':
                            if (dataObj[r][atrName[c]]*1 >= matchColLocValue*1) { //值配对判断
                                myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                            } else {
                                myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                            }
                            break;
                        case 'leeq':
                            if (dataObj[r][atrName[c]]*1 <= matchColLocValue*1) { //值配对判断
                                myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                            } else {
                                myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                            }
                            break;
                        default:
                            myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                            break;
                    }
                } else {
                    myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                }

            }
            myHtml += "</tr>";
        }
        myHtml += "</tbody></table>";
        $("#" + showDom).html(myHtml);
    }

    //hightChart BirongLiang 2017-1-22
    function showHightChart(paraObj) {
        var defTheme = getTheme();
        var dataSource = paraObj.compData;                              //默认主题配色
        var compChartType = paraObj.compPara1;                     //控件类型：column，pie
        var compEditOption = $.parseJSON(paraObj.compEditOption);   //用户配置内容
        var compTitle = compEditOption.titleText;                  //标题
        var showDom = paraObj.compDOM;                                  //生成chart的DOM节点
        //var ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson(dataSource);
        var procParas = compEditOption.dsParas == null ? '' : compEditOption.dsParas;
        var ajxService = ExecProc(dataSource, procParas);
        var strJson = ajxService.value;
        var dataObj = $.parseJSON(strJson);
        if (!dataObj[0] || dataObj[0].length <= 1) {
            //console.log(dataSource + "数据为空");
            return;
        }
        var objLen = dataObj.length;
        var dataGroup = -1;      //数据集数量(列名),从-1开始因为第一列是XLabel
        var atrName = [];       //存放数据属性名
        var oneDimensionData = [];    //一维数据类型   [{name:XXX,value:xxx}]

        for (var attr in dataObj[0]) {
            atrName.push(attr);
            dataGroup++;
        }
        var mySeries = [];
        var dataSet = [];     //数据集数组(二维数组)
        var xLabel = [];       //X轴标示
        var myOption3D = {};    //3D参数设置
        for (var d = 0; d <= dataGroup; d++) {
            var ts = [];
            for (var i = 0; i < objLen; i++) {
                if (d === 0) {
                    xLabel.push(dataObj[i][atrName[0]]); //每{}第一属性}
                } else {
                    ts.push(dataObj[i][atrName[d]] * 1);    //构造 Y-Value  转换成数字数组2017-1-22 by BirongLiang
                    if (d <= 1) {       //一维数据集
                        oneDimensionData.push(
                            [dataObj[i][atrName[0]], dataObj[i][atrName[d]] * 1 ]
                        );                        
                    }
                }
            }
            if (d > 0) {
                dataSet.push(ts);              //构造 dataSet
                mySeries.push({ name: atrName[d] , data: ts });
            }
        }

        switch (compChartType) {
            case 'column':
                //mySeries = mySeries;
                myOption3D = {
                    enabled: true,
                    alpha: 15,
                    beta: 15,
                    depth: 50,
                    viewDistance: 25
                };
                break;
            case 'pie':
                mySeries = [{ type: compChartType, data: oneDimensionData }];
                myOption3D = {
                    enabled: true,
                    alpha: 45,
                    beta: 0
                };
                break;
            default:
                {
                    alert("未支持的类型");
                    return false;
                }
        }

        var chart = new Highcharts.Chart({
            chart: {
                renderTo: showDom,          //图表位置 DOM 
                type: compChartType,        //图类型
                options3d: myOption3D       //3D参数设置
            },
            title: {
                text: compTitle
            },
            subtitle: {
                //text: '副标题'
            },
            plotOptions: {
                column: {       //柱形图设置
                    depth: 35
                },
                pie: {          //饼状图设置
                    allowPointSelect: true,
                    cursor: 'pointer',
                    depth: 35,
                    dataLabels: {
                        enabled: true,
                        format: '{point.name}'
                    }
                }
            },
            xAxis: {
                categories: xLabel
            },

            yAxis: {
                allowDecimals: true,  //坐标轴上是否允许小数。
                min: 0,
                title: {
                    text: '' //Y轴标题
                }
            },
            series: mySeries            //数据主体赋值
        });



    }

    //控件自动刷新生成器，返回task{}，保存于全局数组compsPlayer
    //
    var createComp = function (compObj, refreshSec) {
        var task = {
            excutorPara: compObj,       //事件参数
            taskSec: refreshSec * 1000,    //循环时间
            excutor: null,                  //事件excutor
            taskId: null,
            curRowNum: 0,
            pageSize:-1,
            start: function () {
                if (this.timerId) { return; }
                this.timerId = setTimeout(function () {
                    if (task.excutor) { task.excutor(task.excutorPara, task.taskId, task.curRowNum); }   //执行excutor
                    task.timerId = null;                       //清除上一个循环
                    task.start();           //开始下一个循环
                }, task.taskSec);
            },
            stop: function () {
                if (this.timerId) {
                    clearTimeout(this.timerId);
                }
            },
            play: function () { //执行excutor
                if (task.excutor) {
                    task.excutor(task.excutorPara, task.taskId, task.curRowNum);
                }  
            }
        };
        return task;
    }

    function showClock(userStyle) {
        if ($(".showTimeNow").length === 0) {
            return;
        }
        //userStyle已经直接保存在title代码,这里暂时用不着
        var clockCss = typeof userStyle != "string" ? '' : userStyle;
        var clockMaster = '<div class="clock" style="' + clockCss + '">' +
                '<div class="Date"></div>' +
                '<ul style="margin:0 auto; padding:0px; list-style:none; text-align:center;">' +
                '<li class="hours"> </li>' +
                '<li id="point">:</li><li class="min"> </li>' +
                '<li id="point">:</li><li class="sec"> </li>' +
                '</ul>' +
                '</div>';
        var contClock = '<div class="clock" style="' + clockCss + '">' +
                '<ul style="margin:0 auto; padding:0px; list-style:none; text-align:center;">' +
                '<li class="Date"> </li>' +
                '<li class="hours"> </li>' +
                '<li id="point">:</li><li class="min"> </li>' +
                '<li id="point">:</li><li class="sec"> </li>' +
                '</ul>' +
                '</div>';
        $("#divMasterTitle .showTimeNow").html(clockMaster);
        $("#divMasterFoot .showTimeNow").html(contClock);
        if ($("#divMasterBody .showTimeNow").length > 0) {
            $("#divMasterBody .showTimeNow").html(contClock);
        }
        var monthNames = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"];
        var dayNames = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];

        // 创建一个日期对象
        //var newDate = new Date();
        //newDate.setDate(newDate.getDate());
        var strServTime = $("#hfServerTime").val();
        var newDate = new Date(Date.parse(strServTime.replace(/-/g, "/")));//服务器时间
        //var newDate = new Date(strServTime);
        // 输出年月日
        $('.Date').html(newDate.getFullYear() + "年 " + monthNames[newDate.getMonth()] + ' ' + newDate.getDate() + '日 ' + dayNames[newDate.getDay()]);

        setInterval(function () {
            //创建时间对象，并取得当前时间的秒数值
            var seconds = new Date().getSeconds();
            $(".sec").html((seconds < 10 ? "0" : "") + seconds);

            // 取得当前时间的分钟数值
            var minutes = new Date().getMinutes();
            $(".min").html((minutes < 10 ? "0" : "") + minutes);

            var hours = new Date().getHours();
            $(".hours").html((hours < 10 ? "0" : "") + hours);
        }, 1000);
    }

    function fullMode() {
        $("#btnFullShow").click(function () {
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanPage.aspx?name=" + tmpName + "&full=1", 'newwindow', 'width=' + (window.screen.availWidth - 10) + ',height=' + (window.screen.availHeight - 30) + ',top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
            return false;
        })
        if (fullShow !== '1') {
            $("#btnFullShow").css("display", "block");
        }         
    }
     

    //全局主题设置，对应 echart,table控件
    function getTheme() {
        //全局的，默认无色，第二个深色
        var titleSize = [18, 28, 38];
        var compTheme = {
            backgroundColor: ['', '#2c343c', '#24244f', '#14142b'],
            textStyle: [{ color: '#333' }, { color: '#ccc' }, { color: '#a7a7a9' }, { color: '#cacacb' }],
            titleStyle: [{ color: '#333' }, { color: '#ccc' }, { color: '#767688' }, { color: '#57576a' }],
            lineStyle: [{ color: '#333' }, { color: '#ccc' }, { color: '#767688' }, { color: '#57576a' }],      // lineStyle1{},lineStyle2{}
            tableEven: [{ color: '#FFFFE0' }, { color: '#424242;' }, { color: '#43435a' }, { color: '#57576a' }]    //表格的隔行换色 为了兼容IE8
        }
        return compTheme;
    }

    function echartResize() {
        //Birong@20160928添加echart的resize事件
        if (echartDom.length > 0) {
            $('.contUnit')
                    .each(function (k) {
                        var myEchart = echarts.getInstanceByDom(document.getElementById(echartDom[k]));
                        myEchart.resize();
                    });
        }
    }
    //BirongLiang 存储过程数据源更新为支持参数运行 2017-3-22
    var ExecProc = function (procName, paras) {
        if (procName == null || procName === '') return '';
        var dsParas = paras;
        return SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetKanbanProcData(procName, dsParas);
    }

    //2016-12-23 BirongLiang 按ESC关闭全屏
    $(document).keyup(function (event) {
        if (fullShow === '1') {
            switch (event.keyCode) {
                case 27:
                    window.opener = null;
                    window.open('', '_self');
                    window.close();
            }   
        }
    });
</script>
