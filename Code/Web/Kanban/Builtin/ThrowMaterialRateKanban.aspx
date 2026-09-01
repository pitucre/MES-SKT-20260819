<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThrowMaterialRateKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.ThrowMaterialRateKanban" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/v4.9/echarts.min.js" type="text/javascript"></script>
    <title></title>

    <style type="text/css">
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 14px; overflow: hidden; }

        div, ul, li, table, thead, tbody, tr, th, td { margin: 0px; padding: 0px; }

        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; }

        .logo_cus { background: url('../../Content/images/logo/skt-logo.png') no-repeat 15px center; background-size: 94%; }

        .logo_skt { background: url('../../Content/images/logo/skt-logo.png') no-repeat center center; background-size: 90%; }

        .table { display: table; height: 100%; width: 100%; position: relative; }

        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }

        th { text-align: center; font-size: 14px; color: #fff; }

        tr { text-align: center; font-size: 14px; color: #fff; }

        .chart-tit { font-size: 20px; color: #fff; font-weight: bold; text-align: center; text-shadow: 3px 2px 8px #5a5af7; }

        span { display: inline-block; color: #fff; }

        #dataList tr { color: #38FFFF; }

        td.info-left { color: #38ffff; width: 70%; }

        td.info-right { text-align: left; }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 10%;" class="kanban-head">
                <li style="height: 100%;">
                    <span class="logo_cus cell" style="width: 270px; display: block; float: left;"></span>
                    <div class="table kanban-name" style="float: left;">
                        <span class="cell" style="font-size: 42px; color: #fff; font-weight: bold;">设备抛料率看板</span>
                    </div>
                    <div class="table date-skt-logo" style="float: right; width: 270px;">
                        <span class="cell" style="font-size: 19px; color: #fff; font-weight: bold;" id="dateAndWeek"></span>
                        <%--<span class="logo_skt" style="width: 150px; height: 100%;"></span>--%>
                    </div>
                </li>
            </ul>
            <%--列表数据--%>
            <ul style="height: 79%; width: 100%; border-bottom: 5px solid #0c0c0c; border-top: 5px solid #0c0c0c;">
                <li style="height: 98%;" class="kanban-list">
                    <table style="width: 100%; table-layout: fixed;" class="kanban-fixed-head">
                        <tr class="rows">
                            <th style="width: 15%" class="thTitle">生产时间</th>
                            <th style="width: 15%" class="thTitle">机台</th>
                            <th style="width: 15%" class="thTitle">物料编码</th>
                            <th style="width: 25%" class="thTitle">物料名称</th>
                            <th style="width: 6%" class="thTitle">用量</th>
                            <th style="width: 9%" class="thTitle">贴装数量</th>
                            <th style="width: 7%" class="thTitle">抛料数</th>
                            <th style="width: 8%" class="thTitle">抛料率</th>
                        </tr>
                    </table>
                    <div id="_layout_left_data_div_tbody" class="oqc-scroll">
                        <div id="_layout_left_data_div2_tbody">
                            <table id="data_tbody" style="width: 100%; font-size: 22px; color: #4EC9CE; table-layout: fixed;">
                                <tbody id="dataList">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </li>
            </ul>
            <div style="clear: both;"></div>
            <ul style="height: 10%;">
                <li style="height: 100%;">
                    <div class="table">
                        <table style="width: 100%; height: 100%;" cellpadding="5" cellspacing="5" border="0">
                            <tr>
                                <td id="_left_top_welcome">
                                    <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                        scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                        <div id="_left_top_welcome_text" style="padding-top: 0px; padding-bottom: 5px; font-size: 30px; color: red; font-weight: bold;">
                                            <%--热烈欢迎各位领导莅临参观指导--%>
                                        </div>
                                    </marquee>
                                </td>
                            </tr>
                        </table>
                    </div>
                </li>
            </ul>
        </div>
    </form>
</body>
</html>

<script>
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
    if (welcomeMsg != null && welcomeMsg != "" && welcomeMsg != undefined) {
        $("#_left_top_welcome_text").html(welcomeMsg);
    }
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
            //style.height = marqueesHeight;
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
        }
    }

    var _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";

    $(window).resize(function () {
        ResizeAll();
    });

    $(document).ready(function () {
        //获取服务器时间
        getServerTime(0);

        //绑定表格数据
        //bulidDataTb();

        getBasalInfo();

        setInterval(function () {
            //bulidDataTb();

            getBasalInfo();

            //获取服务器时间
            getServerTime(0);

        }, 1000 * 60 * 5);

        ResizeAll();

        setInterval(function () {
            getServerTime(1);
        }, 1000 * 60 * 30)

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
            //data: { "api": "GetServerTimeNew", "fmt": "yyyy-MM-dd" },
            data: { "api": "GetServerTime", "fmt": "0" },
            dataType: 'text',
            success: function (data) {
                if (flag == 0) {
                    $("#dateAndWeek").html(data);
                } else {
                    window.location.reload();
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }

    function ResizeAll() {
        var width = $(".kanban-head").width().subtract($(".logo_cus").width().add($(".date-skt-logo").width()));
        $(".kanban-name").width(width.subtract(5));

        //列表重置
        resizeList();

        ResizeChart();
    }

    function resizeList() {
        //某些浏览器不兼容div自适应高度
        var _contentHeight = $(".kanban-list").height();
        $(".rows").height(_contentHeight * 0.08);
        var headHeight = $(".kanban-fixed-head").height();
        $("#_layout_left_data_div_tbody").css("height", _contentHeight.subtract(headHeight));
        if ($(".rows").length * _contentHeight * 0.09 > _contentHeight) {
            _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
            isScroll = true;
        }
        $("#_layout_left_data_div_tbody").css({ width: "100%" });
    }

    //浮点型加法运算
    Number.prototype.add = function (val) {
        var len = getPointLen(this, val);
        return ((this * len) + (val * len)) / len;
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

<script type="text/javascript">

    //var chartThrowQty = echarts.init(document.getElementById('chart-throw-rate'));//Top 5 抛料数
  
    //var colorList = ["#229eb1", "#0ebe94", "#9b9f07", "#187e4d", "#1f84ec"];
    //var colorList2 = ["#2bbed5", "#12dfae", "#b5ba09", "#1fa062", "#228dfb"];
    //var colorList3 = ["#63eaff", "#41fdd0", "#e5ea3c", "#5ae09f", "#83c0ff"];

    function ResizeChart() {
        //if (chartThrowQty != null) { chartThrowQty.resize(); }
    }

    //绑定表格数据
    function bulidDataTb(list) {
        var hl = ""
        if (list != null && list.length > 0) {
            for (var i = 0; i < list.length; i++) {
                hl += "<tr class=\"rows\">" +
                    "<td style=\"width:15%\">" + list[i].ProductDate + "</td>" +
                    "<td style=\"width:15%\">" + list[i].EquipmentCode + "</td>" +
                    "<td style=\"width:15%\">" + list[i].ItemCode + "</td>" +
                    "<td style=\"width:25%\">" + list[i].ItemName + "</td>" +
                    "<td style=\"width:6%\">" + list[i].Qty + "</td>" +
                    "<td style=\"width:9%\">" + list[i].MountQty + "</td>" +
                    "<td style=\"width:7%\">" + list[i].ThrowMaterialQty + "</td>" +
                    "<td style=\"width:8%\">" + list[i].ThrowMaterialRate + "</td>" +
                    "</tr>";
            }
        }
        $("#dataList").html(hl);
        resizeList();
    }


    //获取基础信息
    function getBasalInfo() {

        //获取数据
        var ajax = SKT.AjaxCommon.DBService.SearchList("uspGetThrowMaterialRateKanbanInfo", JSON.stringify({}));
        if (ajax.error != null) {
            return false;
        }
        var kanbanData = JSON.parse(ajax.value);

        //低位预警
        bulidDataTb(kanbanData.data);
    }

</script>
