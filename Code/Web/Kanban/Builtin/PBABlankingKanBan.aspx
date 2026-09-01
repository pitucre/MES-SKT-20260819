 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PBABlankingKanBan.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.PBABlankingKanBan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>

    <title></title>
    <style type="text/css">
             html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: #041622; font-size: 14px; overflow: hidden; }

        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; /*border: 1px solid #38FFFF;*/ }

        .logo_cus { background: url('../../Content/images/logo/logo.png') no-repeat 15px center; background-size: 94%; /*background-color: #0D213A;*/ }

        .table { display: table; height: 100%; width: 100%; position: relative; }

        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }

        th { height: 35px; line-height: 35px; text-align: center; font-size: 20px; color: #1AB2C7; border-top: 1px solid #263C54; border-bottom: 1px solid #263C54; }

        tr { height: 22px; line-height: 22px; text-align: center; font-size: 18px; color: #1AB2C7; }
        .thTitle { font-size: 20px; color: #FFFFFF; font-weight: bold; }
        table { width: 100%; height: 100%; border-collapse: collapse; border-spacing: 0px; padding: 0px; margin: 0px; }

            table td, table th { padding: 0px; }

        #_layout_right_table td { font-size: 1em; text-align: center; }

        #data_tbody td, #data_tfoot td { text-align: center; font-size: 24px; color: #38FFFF; /*width: 7%;*/ border-top: 1px solid #263C54; /*border-left: 1px solid #c5c5c5;*/ border-bottom: 1px solid #263C54; }

        #data_tfoot td { border-bottom: 1px solid #263C54; }

        #data_thead td { font-size: 24px; border-top: 1px solid #263C54; border-bottom: 1px solid #263C54; }

        #data_tbody tr.warn td, tr.warn td { color: #ff0000; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;">
            <ul style="height: 10%;" class="head">
                <li style="height: 100%;">
                    <span class="logo_cus cell" style="margin-left: 15px; width: 260px; display: block; float: left;"></span>
                    <div class="table" style="float: left; width: 57%;">
                        <span class="cell" style="font-size: 36px; color: #FFFFFf; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">PBA接料看板</span>
                    </div>
                     <div class="table" style="float: right; width: 19%;">
                        <span class="cell" style="font-size: 18px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                    </div>
                </li>
            </ul>
            <ul style="height: 80%; border-top: 1px solid #008b8b; border-bottom: 5px solid #000000; border-top: 5px solid #000000;" class="content">
                <li style="height: 80%;">
                    <table id="data_thead" style="height: 12%; border-left: 1px solid #263C54; font-size: 21px; border-right: 1px solid #263C54; width: 98%; margin: 0 auto;">
                       <thead>
                         <tr class="rows">
                            <th style="width: 5%" class="thTitle">序号</th>
                            <th style="width: 10%" class="thTitle">线体</th>
                            <th style="width: 20%" class="thTitle">工单</th>
<%--                            <th style="width: 15%" class="thTitle">设备</th>
                            <th style="width: 8%" class="thTitle">站位</th>--%>
                             <th style="width: 8%" class="thTitle">扣料组</th>
                            <th style="width: 20%" class="thTitle">物料编码</th>
                            <th style="width: 10%" class="thTitle">剩余数量</th>
                            <th style="width: 10%" class="thTitle">可装配数</th>
                        </tr>
                           </thead>
                        <tbody></tbody>
                    </table>
                    <div id="_layout_left_data_div_tbody">
                        <div id="_layout_left_data_div2_tbody">
                            <table id="data_tbody" style="width: 98%; font-size: 22px; color: #4EC9CE; border-left: 1px solid #263C54; border-right: 1px solid #263C54; margin: 0 auto;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </li>
            </ul>
            <ul style="height: 10%;" class="bot">
                <li style="height: 100%;">

                    <div class="table" style="border-top: 5px solid #000000;">
                        <table style="width: 100%;" cellpadding="5" cellspacing="5" border="0">
                            <tr>
                                <td id="_left_top_welcome">
                                    <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                        scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                    <div id="_left_top_welcome_text" style=" padding-top:5px; padding-bottom:5px;font-size: 30px; color: red; font-weight: bold;">
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

        <script type="text/javascript">
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
            var scrollElem;
            $("#_left_top_welcome_text").html(welcomeMsg);
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
                    style.height = marqueesHeight;
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
                if (stopScroll || !isScroll) {
                    return;
                }
                preTop = scrollElem.scrollTop;

                scrollElem.scrollTop += 1;
                if (preTop == scrollElem.scrollTop) {
                    $("#data_tbody tbody").html("");
                    bulidDataTb();
                    scrollElem.scrollTop = 0;
                    scrollElem.scrollTop += 1;
                }
            }
        </script>

        <script type="text/javascript">
            var lineId = -1;
            $(document).ready(function () {
                lineId = getQueryString("lineId");
                //ResizeAll();
                bulidDataTb();
                GetNowTime();
                setInterval(function () {
                    bulidDataTb();
                    //}, 1000 * 30);
                }, 1000 * 60 * 3);
            });
            function GetNowTime() {
                $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
                setTimeout("GetNowTime()", 1000);
            }

            $(window).resize(function () {
                ResizeAll();
            });

            function ResizeAll() {

                //某些浏览器不兼容div自适应高度
                //var _contentHeight = $(window).height() * 1 * 0.80;
                //$(".rows").height(_contentHeight * 0.08)
                //if ($(".rows").length * _contentHeight * 0.085 > _contentHeight) {
                //    //$("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                //    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                //    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                //    isScroll = true;
                //}

                var windowHeight = $(window).height();
                var contentHeight = $("ul.content").height();
                $(".rows").height(contentHeight * 0.08);
                var fixTopHeight = $("#data_thead").height();
                if ($("#data_tbody").height() > (contentHeight.subtract(fixTopHeight))) {
                    $("#_layout_left_data_div_tbody").height(contentHeight - fixTopHeight);
                    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                    isScroll = true;
                } else {
                    isScroll = false;
                    $("#_layout_left_data_div_tbody").height(contentHeight.subtract(fixTopHeight));
                    var leftElem = document.getElementById("_layout_left_data_div2_tbody");
                    var childElems = $(scrollElem).children();
                    if (childElems.length > 1) {
                        $(childElems[0]).nextAll().remove();
                    }
                }
            }


            function bulidDataTb() {
                var html = "";
                $.ajax({
                    type: "POST",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/WareHouseInOperation.ashx',
                    data: { "api": "GetPBABlankingKanBan", 'lineId': lineId },
                    dataType: "Json",
                    success: function (data) {
                        if (data == null) { return false; }
                        var j = 1;

                        var topHtml = "";
                        var normalHtml = "";

                        $.each(data, function (i, n) {
                            html = "<tr class=\"rows\ " + ((n["IsWarn"] == 1) ? "warn" : "") + "\">" +
                                    "<td style=\"width:5%\">" + j + "</td>" +
                                    "<td style=\"width:10%\">" + n["LineName"] + "</td>" +
                                    "<td style=\"width:20%\">" + n["PlanBillNo"] + "</td>" +    
                                    "<td style=\"width:8%\">" + n["GroupCode"] + "</td>" +
                                    //"<td style=\"width:15%\">" + n["EquipmentCode"] + "</td>" +
                                    //"<td style=\"width:8%\">" + n["Positon"] + "</td>" +
                                    "<td style=\"width:20%\">" + n["PartNumber"] + "</td>" +
                                    "<td style=\"width:10%\">" + n["BalanceQty"] + "</td>" +
                                    "<td style=\"width:10%\">" + n["BalanceMin"] + "</td>" +
                                    "</tr>";
                            if (n["IsWarn"] == 1 && j <= 5) {
                                topHtml += html;
                            } else {
                                normalHtml += html;
                            }
                            j++;
                        });
                        //$("#data_tbody tbody").html(html);
                        $("#data_thead tbody").html(topHtml);
                        $("#data_tbody tbody").html(normalHtml);
                        ResizeAll();
                    }
                });


            }
            function dateFtt(fmt, date) { //author: meizz   
                date = date.replace(/-/g, "/"); //为了兼容IE
                date = new Date(date);
                var o = {
                    "M+": date.getMonth() + 1,                 //月份   
                    "d+": date.getDate(),                    //日   
                    "h+": date.getHours(),                   //小时   
                    "m+": date.getMinutes(),                 //分   
                    "s+": date.getSeconds(),                 //秒   
                    "q+": Math.floor((date.getMonth() + 3) / 3), //季度   
                    "S": date.getMilliseconds()             //毫秒   
                };
                if (/(y+)/.test(fmt))
                    fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
                for (var k in o)
                    if (new RegExp("(" + k + ")").test(fmt))
                        fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                return fmt;
            }

            /*  *   获取URL参数值**/
            function getQueryString(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
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
