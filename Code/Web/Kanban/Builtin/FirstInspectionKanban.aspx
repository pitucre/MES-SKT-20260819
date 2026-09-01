<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FirstInspectionKanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.FirstInspectionKanban" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <title>首件看板</title>
    <style type="text/css">
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 14px; overflow: hidden; }

        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; /*border: 1px solid #38FFFF;*/ }

        .logo_cus { background: url('../../Content/images/logo/logo.png') no-repeat 15px center; background-size: 94%; /*background-color: #0D213A;*/ }
        .logo_cus2 { background: url('../../Content/images/logo/skt-logo.png') no-repeat 15px center; background-size: 94%; /*background-color: #0D213A;*/ }

        .table { display: table; height: 100%; width: 100%; position: relative; }

        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }

        th { height: 35px; line-height: 35px; text-align: center; font-size: 20px; color: #1AB2C7; }

        tr { height: 22px; line-height: 22px; text-align: center; font-size: 18px; color: #1AB2C7; }

        .tdFont { font-size: 20px; color: #38FFFF; font-weight: bold; }

        .tdFont1 { font-size: 20px; color: #FFFFFF; font-weight: bold; text-align: left; }

        .thTitle { font-size: 18px; color: #FFFFFF; font-weight: bold; }

        .thTitle1 { font-size: 16px; color: #38FFFF; }

        .thTitle2 { font-size: 16px; color: red; text-shadow: 3px 2px 8px #5a5af7; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 10%;" class="kanban-head">
                <li style="height: 100%;">
                    <span class="logo_cus cell" style="width: 270px; display: block; float: left;"></span>
                    <div class="table kanban-name" style="float: left;">
                        <span class="cell" style="font-size: 36px; color: #fff; font-weight: bold;">首检看板</span>
                    </div>
                    <div class="table date-skt-logo" style="float: right; width: 270px;">
                        <span class="cell" style="font-size: 19px; color: #fff; font-weight: bold;" id="dateAndWeek"></span>
                        <%--<span class="logo_skt" style="width: 150px; height: 100%;"></span>--%>
                    </div>
                </li>
            </ul>
            <ul style="height: 89%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000;">
                <li style="height: 99%;" class="kanban-list">
                    <table style="width: 100%; table-layout: fixed;" class="kanban-fixed-head">
                        <tr class="rows">
                            <th style="width: 5%" class="thTitle">序号</th>
                            <th style="width: 10%" class="thTitle">检验单号</th>
                            <th style="width: 10%" class="thTitle">产线机台</th>
                            <th style="width: 10%" class="thTitle">产品编码</th>
                            <th style="width: 15%" class="thTitle">产品名称</th>
                            <th style="width: 6%" class="thTitle">送检人</th>
                            <th style="width: 15%" class="thTitle">送检时间</th>
                            <th style="width: 8%" class="thTitle">检验状态</th>
                              <th style="width: 6%" class="thTitle">审核人</th>
                            <th style="width: 8%" class="thTitle">判定结果</th>
                            <th style="width: 15%" class="thTitle">审核备注</th>
                        </tr>
                    </table>
                    <div id="_layout_left_data_div_tbody">
                        <div id="_layout_left_data_div2_tbody">
                            <table id="data_tbody" style="width: 100%; font-size: 22px; color: #4EC9CE; table-layout: fixed;">
                                <tbody id="dataList">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

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
            //var welcomeMsg = $.getUrlParam('welcomeMsg');
            //if (welcomeMsg != null && welcomeMsg != "" && welcomeMsg != undefined) {
            //    $("#_left_top_welcome_text").html(welcomeMsg);
            //}
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

        </script>

        <script type="text/javascript">

            var _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";

            $(document).ready(function () {

                //获取服务器时间
                getServerTime(0);

                //绑定表格数据
                bulidDataTb();

                setInterval(function () {
                    bulidDataTb();

                    //获取服务器时间
                    getServerTime(0);

                }, 1000 * 60 * 5);

                ResizeAll();

                setInterval(function () {
                    getServerTime(1);
                }, 1000 * 60 * 30)
            });


            //绑定表格数据
            function bulidDataTb() {
                //获取服务器时间
                $.ajax({
                    type: 'GET',
                    url: _webRoot + "/Handler/Kanban.ashx",
                    data: { "api": "FirstInspectionKanbanList" },
                    dataType: 'text',
                    success: function (data) {
                        debugger;
                        var list = JSON.parse(data).data;
                        var hl = ""
                        if (list != null && list.length > 0) {
                            for (var i = 0; i < list.length; i++) {
                                var color = "";
                                if (list[i].AuditStatusName == "待审核") {
                                    color = " color:#32E0E7";
                                } else if (list[i].AuditStatusName == "已审核") {
                                    if (list[i].AuditResult == "审核通过") {
                                        color = " color:#1EB950";
                                    } else if (list[i].AuditResult == "审核不通过") {
                                        color = " color:#ff0000";
                                    }
                                }
                                hl += "<tr class=\"rows\" style=\"" + color + "\">" +
                                    "<td style=\"width:5%\">" + (i + 1) + "</td>" +
                                    "<td style=\"width:10%\">" + list[i].InspectionOrderNo + "</td>" +
                                    "<td style=\"width:10%\">" + list[i].EquipmentCode + "</td>" +
                                    "<td style=\"width:10%\">" + list[i].ItemCode + "</td>" +
                                    "<td style=\"width:15%\">" + list[i].ItemName + "</td>" +
                                    "<td style=\"width:6%\">" + list[i].CName + "</td>" +
                                    "<td style=\"width:15%\">" + list[i].CreateDateTime + "</td>" +
                                  /*  "<td style=\"width:5%\">" + list[i].OrderInspectionQty + "</td>" +*/
                                    "<td style=\"width:8%\">" + list[i].AuditStatusName + "</td>" +
                                    "<td style=\"width:6%\">" + list[i].AuditBy + "</td>" +
                                    "<td style=\"width:8%\">" + list[i].AuditResult + "</td>" +
                                    "<td style=\"width:15%\">" + list[i].AuditRemark + "</td>" +
                                    "</tr>";
                            }
                        }
                        $("#dataList").html(hl);
                        resizeList();
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
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

            $(window).resize(function () {
                ResizeAll();
            });

            function ResizeAll() {
                var width = $(".kanban-head").width().subtract($(".logo_cus").width().add($(".date-skt-logo").width()));
                $(".kanban-name").width(width.subtract(5));

                //列表重置
                resizeList();
            }

            function resizeList() {
                //某些浏览器不兼容div自适应高度
                var _contentHeight = $(".kanban-list").height();
                $(".rows").height(_contentHeight * 0.05);
                var headHeight = $(".kanban-fixed-head").height();
                $("#_layout_left_data_div_tbody").css("height", _contentHeight.subtract(headHeight));
                if ($(".rows").length * _contentHeight * 0.06 > _contentHeight) {
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
    </form>
</body>
</html>
