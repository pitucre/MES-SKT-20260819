<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComponentEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Kanban.ComponentEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th
        {
            padding: 8px;
            vertical-align: top;
            border-top: 1px solid #ddd;
        }
        table tr:nth-child(even) {
            background: rgba(254, 210, 210, 0.20);
        }
    </style>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="tabCompAttr">控件属性</li>
            <li id="tabBindData">数据信息</li>
            <li id="showPrv">预览</li>
        </ul>
        <!--图表属性-->
        <div class="tb_c tb_content">
            <div id="divAttrEdit">
                <table width="100%" class="EditeContentTable">
                    <tr>
                        <td class="Label1" align="left">
                            控件类型：<em>*</em>
                        </td>
                        <td class="Field1" align="left" id="tdSelType">
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1" align="left">
                            控件命名：<em>*</em>
                        </td>
                        <td class="Field1" align="left">
                            <input type="text" id="txtCompName" runat="server" clientidmode="Static"  IsRequired="1" maxlength="20"
                                class="TextBox" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1" align="left">
                            独立标题：
                        </td>
                        <td class="Field1" align="left">
                            <input type="text" id="txtCompTitle" runat="server" clientidmode="Static" class="TextBox"
                                maxlength="20" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1" align="left">
                            标题位置：
                        </td>
                        <td class="Field1" align="left">
                            <select class="ddlTitleLoc" id="ddlTitleLoc" runat="server" clientidmode="Static">
                                <option value="left">居左</option>
                                <option value="center" selected="selected">居中</option>
                                <option value="right">居右</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1" align="left">
                            标题大小：
                        </td>
                        <td class="Field1" align="left">
                            <select class="ddlTitleSize" id="ddlTitleSize" runat="server" clientidmode="Static">
                                <option value="18">小</option>
                                <option value="28" selected="selected">大</option>
                                <option value="38">特大</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td class="Label1" align="left">
                            主题色调：
                        </td>
                        <td class="Field1" align="left">
                            <select class="ddlTheme" id="ddlTheme" runat="server" clientidmode="Static">
                                <option value="0">默认</option>
                                <option value="1">深色</option>
                                <option value="2">蓝色</option>
                                <option value="3">深蓝色</option>
                            </select>
                        </td>
                    </tr>
                    <tr id="trShowRowNum" style="display: none" class="tableOnly">
                        <td class="Label1" align="left">
                            显示行数：<em>*</em>
                        </td>
                        <td class="Field1" align="left">
                            <input type="text" id="txtShowRowNum" value="20" runat="server" isrequired="1" maxlength="10" minValue="-1"
                                clientidmode="Static" class="TextBox" />
                        </td>
                    </tr>
                    <tr id="tr1" style="display: none" class="tableOnly">
                        <td class="Label1" align="left">
                            值配对变化：
                        </td>
                        <td class="Field1" align="left">
                            第<input type="text" id="txtMatchLoc" runat="server" style="width: 20px" maxlength="3" 
                                clientidmode="Static" class="TextBox" />列
                            <select class="tableOnly" id="ddlMatchOp" runat="server" clientidmode="Static">
                                <option value="eq" selected="selected">等于</option>
                                <option value="bg">大于</option>
                                <option value="le">小于</option>
                                <option value="bgeq">大于等于</option>
                                <option value="leeq">小于等于</option>
                            </select>
                            <input type="text" id="txtMatchValue" runat="server" clientidmode="Static" class="TextBox" />
                        </td>
                    </tr>
                    <tr class="tableOnly" style="display: none">
                        <td class="Label1" align="left">
                            值对变化(单元格样式)：
                        </td>
                        <td class="Field1" align="left">
                            <asp:TextBox ID="txtMatchValueCss" runat="server" CssClass="TextArea" TextMode="MultiLine"
                                ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="tableOnly" style="display: none">
                        <td class="Label1" align="left">
                            表头样式：
                        </td>
                        <td class="Field1" align="left">
                            <asp:TextBox ID="txtTHead" runat="server" CssClass="TextArea" TextMode="MultiLine"
                                ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1" align="left">
                            刷新/翻页频率(秒)：<em>*</em>
                        </td>
                        <td class="Field1" align="left">
                            <input type="text" id="txtRefresh" value="180" runat="server"  IsRequired="1" maxlength="10" clientidmode="Static"
                                class="TextBox" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1" align="left">
                            控件整体样式：
                        </td>
                        <td class="Field1" align="left">
                            <%--<input type="text" id="txtRemark" runat="server" clientidmode="Static" class="TextArea" />--%>
                            <asp:TextBox ID="txtCompCss" runat="server" CssClass="TextArea" TextMode="MultiLine"
                                ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1" align="left">
                            备注信息：
                        </td>
                        <td class="Field1" align="left">
                            <%--<input type="text" id="txtRemark" runat="server" clientidmode="Static" class="TextArea" />--%>
                            <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                                ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!--图表数据-->
        <div class="tb_content">
            <%--动态数据源(存储过程)--%>
            <div id="divDataSource">
                <table width="100%" class="EditeContentTable">
                    <tr>
                        <td class="Label1" align="left">
                            请选择数据源：<em>*</em>
                        </td>
                        <td class="Field1" align="left">
                            <asp:TextBox ID="txtTable" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                                Width="250px">
                            </asp:TextBox><input type="button" id="btnSelect" class="ButtonBox" style="width: 65px;
                                line-height: 12px; background: #ccc; font-size: 12px;" value="选择数据源" title="点击选择数据源"
                                onclick="openChoosePage(this);" />
                            <asp:HiddenField ID="hfDsTableID" runat="server" Value="-1" ClientIDMode="Static" />
                            <asp:HiddenField ID="hfDsType" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                    </tr>
                </table>
                <table width="100%" class="EditeContentTable" id="tbDsEdit">
                </table>
            </div>
            <%--文本数据源(文字编辑器)--%>
            <div id="divTextEdit" style="display: none;">
                <textarea id="txtArea" cols="30" rows="30" style="width: 98%; height: 300px; display: none;
                    padding: 3px;" runat="server" class="TextArea" clientidmode="Static"></textarea>
                <script type="text/plain" id="myEditor" style="height: 240px;">
                     
                </script>
            </div>
            <%--网页数据源(URL)--%>
            <div id="divWebEdit" style="display: none;">
                <table width="100%" class="EditeContentTable">
                    <tr>
                        <td class="Label1" align="left">
                            网页地址：<em>*</em>
                        </td>
                        <td class="Field1" align="left">
                            <input type="text" id="txtWebSrc" style="width: 280px" runat="server" clientidmode="Static"
                                class="TextBox" value="http://" /><span class="Tips"></span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!--预览-->
        <div style="padding: 3px;" class="tb_content">
            <div id="divDataPreV" class="divPrev" style="width:780px ; height: 400px; overflow: auto;
                text-align: center">
                <div class="ListTableEmptyDataRow">
                    未能加载预览信息</div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfCompTypeJson" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfEditOptinJS" runat="server" ClientIDMode="Static" Value="-1" />
    <asp:HiddenField runat="server" ID="hfSelectedType" Value="1002@line@echart" ClientIDMode="Static" />
    <link href="../Content/plugin/umeditor1_2_2/themes/default/css/umeditor.css" type="text/css"
        rel="stylesheet">
    <%--开发模式，含console提示，不兼容IE8<script src="../Content/Kanban/echarts.js" type="text/javascript"></script>--%>
    <script src="../Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Content/plugin/umeditor1_2_2/third-party/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/umeditor1_2_2/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/umeditor1_2_2/umeditor.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/umeditor1_2_2/lang/zh-cn/zh-cn.js"></script>
    <script src="../Content/plugin/highCharts/highcharts.js" type="text/javascript"></script>
    <script src="../Content/plugin/highCharts/highcharts-3d.js" type="text/javascript"></script>
    <script type="text/javascript">
        var compId = '<%=Request.QueryString["ID"] %>';
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var rowJson = '';
        var rowObj;
        var compPara = 'line';  //控件参数 ,默认折线图，同步hfSelectedType的组合值
        var selectedType = '1002'; //控件类型  TODO 取消这个逻辑判断
        var comPlayType = 'echart';  //控件解释类型
        var autoRef;        //刷新计时器 obj
        var winWidth = $(document.body).width() - 10; //浏览器当前窗口文档body的宽度： 
        var myEchart;
        var curRowNum =0;//表格分页查询时，记录当前显示的行号
        var pageInTime; //表格分页查询时间间隔
       var isRefresh = '<%=Request.QueryString["IsRefresh"] %>';
        window.onunload = function () {
            //alert("退出了");
            clearShowLoop();
        }
        $(document).ready(function () {
            $(function () {
                $(document).keydown(function (e) {
                    if (e.which == 83 && e.ctrlKey) {
                        Save();
                    }
                });
            });

            $("#divDataPreV").height($(window).height() - 110);
            $("#divDataPreV").width(winWidth);
            if (compId !== '-1') {
                initPage(); //初始化页面信息      
            }
            
            //获取并设置可选控件
            setSelType($("#hfCompTypeJson").val(), $("#hfSelectedType").val());
            //类型下拉框事件
            $("#ddlCompType").on("change", function () {
                myEchart = null;//清空echart实例
                $("#divDataPreV").html('<div class="ListTableEmptyDataRow">未能加载预览信息</div>'); //Add By Alen 2016-09-07 当控件类型更换时清空预览的内容
                var arrItem = $("#ddlCompType").val().split('@');
                $("#hfSelectedType").val($("#ddlCompType").val());
                selectedType = arrItem[0];
                compPara = arrItem[1];
                comPlayType = arrItem[2];
                $("#txtTable").val("");         //清空数据源选择
                $("#hfDsTableID").val(-1);
                changeByType();
            });

            $("#tabCompAttr").click(function() {
                clearShowLoop();
            });
            $("#tabBindData").click(function () {
                clearShowLoop();
            });
        })
        //=======document.ready  END

        //-------预览点击事件
        $("#showPrv").click(function () {
            //验证输入信息
            if (comPlayType !== 'text' && comPlayType !== 'web' && $("#txtTable").val() === '') {
                return false;
            } else {
                //清理计时器
                clearShowLoop();
                switch (comPlayType) {
                    case 'table':  //表格
                        showTable($("#txtTable").val()); //第一次显示
                        curRowNum += $("#txtShowRowNum").val() * 1;
                        if ($("#txtRefresh").val() * 1 > 0) {   //循环体/翻页
                            autoRef = setInterval(
                                function () {
                                    showTable($("#txtTable").val());
                                    curRowNum += $("#txtShowRowNum").val() * 1;
                                },
                                $("#txtRefresh").val() * 1000);
                        }
                        break;
                    case 'text':    //文本
                        showText();
                        break;
                    case 'web':        //网页
                        var webUrl = $.trim($("#txtWebSrc").val());
                        if (webUrl !== "" && webUrl !== "http://" && webUrl !== "https://") {
                            if (webUrl.toLowerCase().indexOf("http://") == -1 && webUrl.toLowerCase().indexOf("https://") == -1) {
                                webUrl = "http://" + webUrl;
                            }
                            var preViewContent = '<iframe frameborder="0" width="100%" height="100%" scrolling="auto" src="' + webUrl + '"></iframe>';
                            $("#divDataPreV").html(preViewContent);
                        }
                        break;
                    case 'echart': //echart
                        showChart($("#txtTable").val());
                        if ($("#txtRefresh").val() * 1 > 0) {
                            autoRef = setInterval(function () { showChart($("#txtTable").val()) },
                            $("#txtRefresh").val() * 1000);
                        }
                        break;
                    case 'highchart'://hightchart
                        showHightChart($("#txtTable").val());
                        if ($("#txtRefresh").val() * 1 > 0) {
                            autoRef = setInterval(function () { showHightChart($("#txtTable").val()) },
                            $("#txtRefresh").val() * 1000);
                        }
                        break;
                    default:
                        {
                            alert("未支持的类型");
                            return false;
                        }
                }
 
            }
        })//------预览点击事件END

        //实例化编辑器
        var um = UM.getEditor('myEditor');
        um.setWidth("99.8%");
        um.setContent($("#txtArea").val());
        $(".edui-body-container").css("width", "98%");
        $(".edui-body-container").css("height", $(window).height() - 155);
        //初始化页面和控件值
        function initPage() {
            var arrItem = $("#hfSelectedType").val().split('@');
            selectedType = arrItem[0];
            compPara = arrItem[1];
            comPlayType = arrItem[2];
            //控件状态信息
            changeByType();
            //userSetting加载
            var strUset = $("#hfEditOptinJS").val();
            if (strUset === '-1')return;
            var objUset = $.parseJSON(strUset);         //{"titleText","titleFontSize"...}
            if (objUset.length === 0) return;
            $("#txtCompTitle").val(objUset.titleText);
            $("#ddlTitleLoc").val(objUset.titleLoc);
            $("#ddlTitleSize").val(objUset.titleSize);
            $("#ddlTheme").val(objUset.compTheme);
            $("#txtShowRowNum").val(objUset.showRowNum);
            $("#txtRefresh").val(objUset.changePageTime);
            $("#txtCompCss").val(objUset.compCss);
            $("#txtMatchLoc").val(objUset.matchColLoc);
            $("#ddlMatchOp").val(objUset.matchColLocOp);
            $("#txtMatchValue").val(objUset.matchColLocValue);
            $("#txtMatchValueCss").val(objUset.matchColLocCss);
            $("#txtTHead").val(objUset.tHeadCss);
            showProcSet();
            var procParas = objUset.dsParas == null ? '' : objUset.dsParas;
            procParas = procParas.split(',');
            if (procParas.length > 0) {
                $(".txtDsPara").each(function (i) {
                    $(this).val(procParas[i].replace(/'/g, ""));
                });
            }

        }

        //关于用户的样式和控件定义属性设置    
        function getUserSetting() {
            var compTitle = $("#txtCompTitle").val();
            var compTheme = $("#ddlTheme").val();
            var titleSize = $("#ddlTitleSize").val();
            var titleLoc = $("#ddlTitleLoc").val();
            var showRowNum = $("#txtShowRowNum").val();
            var changePageTime = $("#txtRefresh").val();
            var compCss = $("#txtCompCss").val();
            var matchColLoc = $("#txtMatchLoc").val();
            var matchColLocOp = $("#ddlMatchOp").val();
            var matchColLocValue = $("#txtMatchValue").val();
            var matchColLocCss = $("#txtMatchValueCss").val();
            var tHeadCss = $("#txtTHead").val();
            var dsParas = '';
            $(".txtDsPara").each(function (i) {
                if (i === 0) {
                    dsParas += "'" + $(this).val() + "'";
                } else {
                    dsParas += ",'" + $(this).val() + "'"; 
                }
            });
            var usObj = {};
            usObj.titleText = compTitle;
            usObj.titleSize = titleSize;
            usObj.compTheme = compTheme;
            usObj.titleLoc = titleLoc;
            usObj.showRowNum = showRowNum;
            usObj.changePageTime = changePageTime;
            usObj.compCss = compCss;
            usObj.matchColLoc = matchColLoc * 1 > 0 ? matchColLoc : 0;
            usObj.matchColLocOp = matchColLocOp;
            usObj.matchColLocValue = matchColLocValue;
            usObj.matchColLocCss = matchColLocCss;
            usObj.tHeadCss = tHeadCss;
            usObj.dsParas = dsParas;
            var strUserSetting = JSON.stringify(usObj);
            return strUserSetting;
        }

        function setSelType(strJson, selectedItem) {
            var objJson;
            if (typeof strJson === 'undefined' || strJson === "") {
                return;
            } else {
                objJson = $.parseJSON(strJson);
            }
            var ddlHtml = "<select class='ddlCompType' id='ddlCompType'> ";
            //ddlHtml += "<option value=''>=请选择=</option> ";
            var _alt = "";
            for (var i = 0; i < objJson.length; i++) {
                var compPara = objJson[i].ItemStatus;
                var ItemName = objJson[i].ItemName;
                var ItemValue = objJson[i].ItemValue + '@' + compPara;      //需要用到param1 拼接
                //var arrItem = ItemValue.split('@');
                if (ItemValue.toLocaleLowerCase()=="line,bar")
                {
                    _alt = "拆线柱状图数据源的第2列应该为拆线数据源，第3列为柱状图数据源";
                }
                if (ItemValue == selectedItem) {
                    ddlHtml += "<option selected='selected' value='" + ItemValue + "' title='" + _alt + "'>" + ItemName + "</option> ";
                } else {
                    ddlHtml += "<option value='" + ItemValue + "' title='" + _alt + "'>" + ItemName + "</option> ";
                }
            }
            ddlHtml += "</select>";
            $("#tdSelType").html(ddlHtml);
        }

        function openChoosePage(obj) {
            //使用系统通用数据源功能维护  BirongLiang 2017-01-10
            //var searchSettings = " StatusFlag =2";  //1、报表数据源，2、看板数据源
            //var searchSettings = escape(" UseTypeID IN (N'Board',N'Report')");
            var searchSettings = "";
            if (comPlayType!=='table') {
                searchSettings = escape(" SQLType='存储过程' ");
            }
            else {
                searchSettings = escape(" SQLType='表格/视图' ");
            }//modified by zhi.li 20180620
            dialog({ title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=115&Multiple=false&CallBackFunc=getChooseValue&PageCondition=" + searchSettings + "&rnd=" + Math.random()
            , width: 600, height: 300
            });
        }

        function getChooseValue(list) {
            if (list[0][3].toLowerCase() === '存储过程'
                && $("#txtShowRowNum").val() * 1 > -1
                && comPlayType === 'table') {
                    alert("此数据源不能分页查询和显示，请将显示行数设为-1");
                    return false;
            }
            if ((list[0][3].toLowerCase() === '表格/视图') && comPlayType !== 'table') {
                alert("此数据源仅支持表格控件类型");
                return false;
            }
            $("#<%=this.txtTable.ClientID %>").val(list[0][5]);
            $("#<%=this.hfDsTableID.ClientID %>").val(list[0][0]);
            //增加数据源类型赋值，判断sp不能分页, table, view可以 @2016-11-10
            var dataSourceType = list[0][3];
            $("#hfDsType").val(dataSourceType);
            //清空预览内容
            $("#divDataPreV").html('<div class="ListTableEmptyDataRow">未能加载预览信息</div>').removeAttr("_echarts_instance_")
            myEchart = null;//清空echart实例
            $("#tbDsEdit").html('');
            curRowNum = 0;
            //存储过程参数设置
            showProcSet();
        }

        //存储过程参数设置
        function showProcSet() {
            var type = $("#hfDsType").val();
            if (type!="存储过程") return false;
            var procName = $("#txtTable").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCommDataSource.GetJsonInfo(procName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var dsInfo = JSON.parse(ajax.value);
            if (dsInfo[0]==null ||dsInfo[0].Paramters === '') return false;
            var para = dsInfo[0].Paramters.split(",");
            var strHtml = '';
            for (var i = 0; i < para.length; i++) {
                strHtml += '<tr>' +
                    '<td class="Label1" align="right">' + para[i] + '</td>' +
                    '<td class="Field1" align="left"><input type="text" class="txtDsPara" id="txtDsPara' + i + '" ></td>' +
                    '</tr>';
            }
            $("#tbDsEdit").html(strHtml);
        }

        //TODO:数据库获取支持类型数组
        function showChart(uspDataSrc) {         
            try {
                //var ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson(uspDataSrc); //sp数据源的调用方法
                var ajxService = ExecProc();
                var strJson = ajxService.value;
                var dataObj = $.parseJSON(strJson);
                if (!dataObj[0] || dataObj[0].length <= 1) {
                    alert("数据为空");
                    return false;
                }
                var curTheme = $("#ddlTheme").val() * 1; //type int
                var defTheme = getTheme();
                var objLen = dataObj.length;
                var dataGroup = -1;      //数据集数量,从-1开始因为第一列是XLabel
                var atrName = [];       //存放数据属性名 
                var oneDimensionData = [];    //一维数据类型   [{name:XXX,value:xxx}]
                for (var attr in dataObj[0]) {
                    atrName.push(attr);
                    dataGroup++;
                }
                var mySeries = [];
                var dataSet = [];     //数据集数组(二维数组)
                var xLabel = [];                        //X轴标示
                var arrLegend = atrName.slice(1);
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
                if (compPara === 'pie' || compPara === 'funnel' || compPara === 'gauge') {
                    dataGroup = 1;      //一维数据的chart类型，数据集只拿一次
                }

                var __compChartType, isMultipChart = false;
                if (compPara.indexOf(",") != -1) {
                    __compChartType = compPara.split(",");
                    isMultipChart = true;
                }

                var chartTypes = (isMultipChart) ? __compChartType.length : dataGroup;
                if (chartTypes < dataGroup) {
                    dataGroup = chartTypes;
                }

                for (var d = 0; d <= dataGroup; d++) {
                    var ts = [];
                    var _chart_type = "";
                    for (var i = 0; i < objLen; i++) {
                        if (d === 0) {
                            xLabel.push(dataObj[i][atrName[0]]); //每{}第一属性 name
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
                            _chart_type = compPara;
                        }
                        mySeries.push({ name: atrName[d], type: _chart_type, data: ts, itemStyle: itemStyle });
                    }
                }

                if (!myEchart) {
                    myEchart = echarts.init(document.getElementById('divDataPreV'));
                }

                // 指定图表的配置项和数据
                var option = {
                    color: ['#097532', '#1466c2', '#8acaaa', '#cc5664', '#f1ec64', '#ee8686', '#a48dc1', '#5da6bc', '#b9dcae'],
                    backgroundColor: defTheme.backgroundColor[curTheme],
                    textStyle: defTheme.textStyle[curTheme],
                    title: {
                        text: $("#txtCompTitle").val(),
                        textStyle: defTheme.titleStyle[curTheme],
                        left: $("#ddlTitleLoc").val(),
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
                    yAxis: null
                    //series: mySeries
                };

                switch (compPara) {
                    case 'line':
                        option.xAxis = { data: xLabel, axisLine: { lineStyle: defTheme.lineStyle[curTheme] }, splitLine: { show: true, lineStyle: defTheme.lineStyle[curTheme] } };
                        option.yAxis = { axisLine: { lineStyle: defTheme.lineStyle[curTheme] }, splitLine: { show: true, lineStyle: defTheme.lineStyle[curTheme] } };
                        option.series = mySeries;
                        break;
                    case 'bar':
                        option.xAxis = { data: xLabel, axisLine: { lineStyle: defTheme.lineStyle[curTheme] }, splitLine: { show: true, lineStyle: defTheme.lineStyle[curTheme] } };
                        option.yAxis = { axisLine: { lineStyle: defTheme.lineStyle[curTheme] }, splitLine: { show: true, lineStyle: defTheme.lineStyle[curTheme] } };
                        option.series = mySeries;
                        break;
                    case 'pie':
                        option.series = { name: atrName[0], type: compPara, data: oneDimensionData };
                        break;
                    case 'gauge': //仪表盘
                        option.series = { name: atrName[0], type: compPara, data: oneDimensionData };
                        break;
                    case 'funnel':
                        option.series = { name: atrName[0], type: compPara, data: oneDimensionData };
                        break;
                    case 'line,bar':
                        option.xAxis = { data: xLabel, axisLine: { lineStyle: defTheme.lineStyle[curTheme] }, splitLine: { show: true, lineStyle: defTheme.lineStyle[curTheme] } };
                        option.yAxis = { axisLine: { lineStyle: defTheme.lineStyle[curTheme] }, splitLine: { show: true, lineStyle: defTheme.lineStyle[curTheme] } };
                        option.series = mySeries;
                        break;
                    default:
                        {
                            alert("未支持的类型");
                            clearShowLoop(); //清理计时器
                            return false;
                        }
                }
                myEchart.setOption(option);
            }
            catch (ex) { alert(ex);}
        }

        function showHightChart(uspDataSrc) {
            var ajxService = ExecProc();
            var strJson = ajxService.value;
            var dataObj = $.parseJSON(strJson);
            if (!dataObj[0] || dataObj[0].length <= 1) {
                alert("数据为空");
                return false;
            }
            var defTheme = getTheme();
            var objLen = dataObj.length;
            var compTitle = $("#txtCompTitle").val();                  //标题
            var showDom = 'divDataPreV';  
 
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
                            [dataObj[i][atrName[0]], dataObj[i][atrName[d]] * 1]
                        );
                        }
                    }
                }
                if (d > 0) {
                    dataSet.push(ts);              //构造 dataSet
                    mySeries.push({ name: atrName[d], data: ts });
                }
            }

            switch (compPara) {
                case 'column':
                    myOption3D = {
                        enabled: true,
                        alpha: 15,
                        beta: 15,
                        depth: 50,
                        viewDistance: 25
                    };
                    break;
                case 'pie':
                    mySeries = [{ type: compPara, data: oneDimensionData}];
                    myOption3D = {
                        enabled: true,
                        alpha: 45,
                        beta: 0
                    };
                    break;
                default:
                    {
                        clearShowLoop(); //清理计时器
                        alert("未支持的类型");
                        return false;
                    }
            }

            var chart = new Highcharts.Chart({
                chart: {
                    renderTo: showDom,          //图表位置 DOM 
                    type: compPara,        //图类型
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

        //读取DB得到HTML代码    
        function showText() {
            $("#divDataPreV").css("background-color", "");
            $("#divDataPreV").html(um.getContent());
        }

        //表格展示
        function showTable(dataSource) {
            $("#divDataPreV").css("background-color", "");
            if (!dataSource) {
                return false;
            }
            $("#divDataPreV").html('');//清空内容
            var changePageTime = $("#txtRefresh").val();
            var startRow = curRowNum;
            var pageSize = $("#txtShowRowNum").val() * 1;
            var compCSS = $("#txtCompCss").val();
            var defTheme = getTheme();
            var curTheme = $("#ddlTheme").val() * 1; //type int
            var backgroundColor = defTheme.backgroundColor[curTheme];
            var fontColor = defTheme.textStyle[curTheme].color;
            var matchColLoc = $("#txtMatchLoc").val() * 1; //值配对坐标 Cell
            var matchColLocValue = $("#txtMatchValue").val(); //配对值
            var matchColLocOp = $("#ddlMatchOp").val(); //配对操作  
            var matchColLocCss = $("#txtMatchValueCss").val(); //配对值附加CSS 
            var tableEvenColor = defTheme.tableEven[curTheme].color;
            var tbHeadCss = $("#txtTHead").val();

            var ajxService;

            //BirongLiang 2017-1-10 改用系统通用数据源
            //TODO：增加输入参数运行存储过程功能
            if ($("#hfDsType").val().toLowerCase() === '存储过程') {
                //ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson(dataSource);
                ajxService = ExecProc();
            } else {
                ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetTabelByPager(startRow,pageSize,dataSource);
            }

            var strJson = ajxService.value;
            var dataObj = $.parseJSON(strJson);
            if (dataObj === null || !dataObj[0] || dataObj[0].length <= 1) {
                return false;
            }
            var myHtml = "<table width='100%' class=' table table-bordered table-condensed table-striped' " +
                "style='background-color: " + backgroundColor + ";color: " + fontColor + "; "+compCSS+"; '>" +
                "<tr style='font-size: " + defTheme.titleStyle[curTheme].fontSize + "px;"+tbHeadCss+"'>";
            var objLen = dataObj.length;
            if (objLen < pageSize) {//当得到的数据不够设定的显示行数时重置curRowNum
                curRowNum = 0 - pageSize;
            }
            var dataGroup = 0;
            var atrName = [];       // 列名
            for (var attr in dataObj[0]) {
                atrName.push(attr);
                dataGroup++;
                myHtml += "<th>" + attr + "</th>";
            }

            myHtml += "</tr><tbody>";
            for (var r = 0; r < objLen; r++) {
                if (r % 2 == 1) {
                    myHtml += "<tr class='' style='background-color:" + tableEvenColor + "'>";

                } else {
                    myHtml += "<tr class=''>";
                }
                for (var c = 0; c < atrName.length; c++) {
                    if (matchColLoc > 0 && c === matchColLoc - 1) {
                        switch (matchColLocOp) {
                            case 'eq':
                                if (dataObj[r][atrName[c]] == matchColLocValue) { //值配对判断
                                    myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                                } else {
                                    myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                                }
                                break;
                            case 'bg':
                                if (dataObj[r][atrName[c]] * 1 > matchColLocValue * 1) { //值配对判断
                                    myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                                } else {
                                    myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                                }
                                break;
                            case 'le':
                                if (dataObj[r][atrName[c]] * 1 < matchColLocValue * 1) { //值配对判断
                                    myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                                } else {
                                    myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                                }
                                break;
                            case 'bgeq':
                                if (dataObj[r][atrName[c]] * 1 >= matchColLocValue * 1) { //值配对判断
                                    myHtml += "<td style='" + matchColLocCss + ";'>" + dataObj[r][atrName[c]] + "</td>";
                                } else {
                                    myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                                }
                                break;
                            case 'leeq':
                                if (dataObj[r][atrName[c]] * 1 <= matchColLocValue * 1) { //值配对判断
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
            $("#divDataPreV").html(myHtml);
        }

        //保存
        function Save() {
            var _compId = compId;
            var _compTypeId = selectedType;
            var _compName = $("#txtCompName").val();
            var _compRefr = $("#txtRefresh").val();
            var _compRemark = $("#txtRemark").val();
            var _compDataSrc = $("#txtTable").val();
            var sourceType = $("#hfDsType").val();
            var _compEditOption = getUserSetting();

            if (comPlayType === 'text') {
                _compDataSrc = um.getContent(); //$("#txtArea").val();//Modify By Alen Liu 2016-09-08 获取文本编辑器的内容
            }
            if (comPlayType === 'web') {
                _compDataSrc = $("#txtWebSrc").val();
            }
            var userSetting = getUserSetting();

            if ($.trim(_compTypeId) === "" || $.trim(_compTypeId) === "-1") {
                alert("请选择控件类型");
                return false;
            }
            if ($.trim(_compName) === "") {
                alert("请填写控件命名");
                return false;
            }
            if ($.trim(_compDataSrc) === "") {
                alert("请选择数据来源");
                return false;
            }
            if ($.trim(_compRefr) === "") {
                alert("请填写控件刷新时间");
                return false;
            }

            var entity = {};
            entity.KanbanComponentId = _compId;
            entity.ComponentName = _compName;
            entity.DataSource = _compDataSrc;
            entity.SourceType = sourceType;
            entity.RefreshSec = _compRefr;
            entity.ComponentTypeId = _compTypeId;
            entity.Remark = _compRemark;
            entity.EditOption = _compEditOption;
            entity.RawCode = '';
            entity.CreateBy = user;
            entity.ModifyBy = user;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.EditComponent(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            if(isRefresh==1){
              parent.InputGRNResultBckFunction();
            }else{
                window.parent.UpdateList(_compName);
            }
        }

        function changeByType() {
            if (comPlayType === 'table') {                           //表格     
                $("#txtCompTitle").val("").attr("disabled", "disabled");        //独立标题
                $("#ddlTitleLoc").val("center").attr("disabled", "disabled");   //标题位置
                $("#divDataSource").show();             //数据源选择
                $("#divTextEdit").hide();               //文本编辑器
                $("#divWebEdit").hide();                //网页url
                $(".tableOnly").show();
            } else if (comPlayType === 'text') {                 //文本  
                $("#divTextEdit").show();
                $("#divDataSource").hide();
                $("#divWebEdit").hide();
                $("#txtCompTitle").val("").attr("disabled", "disabled");
                $("#ddlTitleLoc").attr("disabled", "disabled");
                $(".tableOnly").hide();
            } else if (comPlayType === 'web') {                 //网页  
                $("#divWebEdit").show();
                $("#divTextEdit").hide();
                $("#divDataSource").hide();
                $("#txtCompTitle").val("").attr("disabled", "disabled");
                $("#ddlTitleLoc").attr("disabled", "disabled");
                $(".tableOnly").hide();
            } else {//统计图类型，echart，highchart....
                $("#divDataSource").show();
                $("#divTextEdit").hide();
                $("#divWebEdit").hide();
                $("#txtCompTitle").val("").removeAttr("disabled");
                $("#ddlTitleLoc").removeAttr("disabled");
                $(".tableOnly").hide();
            }
        }

        function clearShowLoop() {
            if (typeof autoRef != 'undefined') { clearInterval(autoRef); }
        }
        function getTheme() {
            //全局的，默认无色，第二个深色
            var titleSize = $("#ddlTitleSize").val() * 1;
            var compTheme = {
                backgroundColor: ['', '#2c343c', '#24244f', '#14142b'],
                textStyle: [{ color: '#333' }, { color: '#ccc' }, { color: '#a7a7a9' }, { color: '#cacacb' }],
                titleStyle: [{ color: '#333', fontSize: titleSize }, { color: '#ccc', fontSize: titleSize }, { color: '#767688' }, { color: '#57576a' }],
                lineStyle: [{ color: '#333' }, { color: '#eee' }, { color: '#767688' }, { color: '#57576a' }],      // lineStyle1{},lineStyle2{}
                tableEven: [{ color: '#FFFFE0' }, { color: '#424242;' }, { color: '#43435a' }, { color: '#57576a' }]    //表格的隔行换色 为了兼容IE8
            }
            return compTheme;
        }
        //BirongLiang 存储过程数据源更新为支持参数运行 2017-3-22
        var ExecProc = function () {
            var dsPrcSource = $("#txtTable").val();
            if (dsPrcSource === '') return '';
            var dsParas = '';
            $(".txtDsPara").each(function (i) {
                if (i === 0) {
                    dsParas += "'" + $(this).val() + "'";
                } else {
                    dsParas += ",'" + $(this).val() + "'";
                }
            });
            return SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetKanbanProcData(dsPrcSource, dsParas);
        }
    </script>
</asp:Content>
