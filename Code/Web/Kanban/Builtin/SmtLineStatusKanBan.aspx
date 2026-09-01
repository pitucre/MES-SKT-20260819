<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmtLineStatusKanBan.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.SmtLineStatusKanBan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SMT产线状态看板</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>

    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            margin: 0px;
            padding: 0px;
            border: 0px;
            font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif;
            color: #fff;
            background-color: #041622;
            font-size:15px;
            overflow:hidden;
        }

        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat 15px center;
            background-size: 93%;
            background-color: #0D213A;
        }

        .logo_skt {           
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center center;
            background-size: 93%;
            background-color: #0D213A;
        }

        #_left_top_title {
            height: 100%;
            font-size: 1.5em;
            text-align: center;
        }

        #_left_top_welcome {
            height: 100%;
            font-size: 1.7em;
            color: Red;
        }

        #dateAndWeek {
            width: 13%;
            height: 100%;
            font-size: 1.0em;
            text-align: center;
        }

        table {
            width: 100%;
            height: 100%;
            border-collapse: collapse;
            border-spacing: 0px;
            padding: 0px;
            margin: 0px;
        }

        table td, table th {
            padding: 0px;
        }
        .Machine_content{
           background-color: #0D213A; 
           height:85px;
           max-height:85px;
        }
        .Machine_title{
            background-color: #0D213A; 
            vertical-align:top;
            font-weight:bolder;
            font-size:20px;
            height:25px;
        }
        .Machine {
            background-color: #0D213A;
            background-size:100%;
        }
        .Machine_1_g{           
            background: url('../../Content/images/kanban/Machine_1_g.png') no-repeat center center;
            width:60px;
        }
        .Machine_1_r{           
            background: url('../../Content/images/kanban/Machine_1_r.png') no-repeat center center;
            width:60px;
        }
        .Machine_1_y{           
            background: url('../../Content/images/kanban/Machine_1_y.png') no-repeat center center;
            width:60px;
        }
        .Machine_2_g{           
            background: url('../../Content/images/kanban/Machine_2_g.png') no-repeat center center;
            width:50px;
        }
        .Machine_2_r{           
            background: url('../../Content/images/kanban/Machine_2_r.png') no-repeat center center;
            width:50px;
        }
        .Machine_2_y{           
            background: url('../../Content/images/kanban/Machine_2_y.png') no-repeat center center;
            width:50px;
        }
        .Machine_3_g{           
            background: url('../../Content/images/kanban/Machine_3_g.png') no-repeat center center;
            width:60px;
        }
        .Machine_3_r{           
            background: url('../../Content/images/kanban/Machine_3_r.png') no-repeat center center;
            width:60px;
        }
        .Machine_3_y{           
            background: url('../../Content/images/kanban/Machine_3_y.png') no-repeat center center;
            width:60px;
        }
        .Machine_4_g{           
            background: url('../../Content/images/kanban/Machine_4_g.png') no-repeat center center;
            width:70px;
        }
        .Machine_4_r{           
            background: url('../../Content/images/kanban/Machine_4_r.png') no-repeat center center;
            width:70px;
        }
        .Machine_4_y{           
            background: url('../../Content/images/kanban/Machine_4_y.png') no-repeat center center;
            width:70px;
        }
        .Machine_5_g{           
            background: url('../../Content/images/kanban/Machine_5_g.png') no-repeat center center;
            width:140px;
        }
        .Machine_5_r{           
            background: url('../../Content/images/kanban/Machine_5_r.png') no-repeat center center;
            width:140px;
        }
        .Machine_5_y{           
            background: url('../../Content/images/kanban/Machine_5_y.png') no-repeat center center;
            width:140px;
        }
        .Machine_6_g{           
            background: url('../../Content/images/kanban/Machine_6_g.png') no-repeat center center;
            width:42px;
        }
        .Machine_6_r{           
            background: url('../../Content/images/kanban/Machine_6_r.png') no-repeat center center;
            width:42px;
        }
        .Machine_6_y{           
            background: url('../../Content/images/kanban/Machine_6_y.png') no-repeat center center;
            width:42px;
        }
        
        
        .Machine_04 {           
            background: url('../../Content/images/logo/ColorNew.png') no-repeat center center;
            background-size: 175px;
            background-color: #0D213A;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <table id="_layout" style="border-collapse:separate; border-spacing:5px 3px;">
       <tr style="height: 100%;">
          <td style="height: 100%;" colspan="3">
                <table style="background-color: #0D213A;">
                    <tr>
                        <td class="logo_cus" style="width: 250px; height: 100%;" rowspan="2"></td>
                        <td id="_left_top_welcome">
                            <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                scrollamount="3" onmouseover="this.stop();" onmouseout="this.start();" >
                                <div id="_welcome_text">
                                </div>
                            </marquee>
                        </td>
                        <td id="dateAndWeek" rowspan="2" style="color: #38FFFF; white-space:nowrap;"></td>
                        <td class="logo_skt" style="width: 250px; height: 100%;" rowspan="2"></td>
                    </tr>
                    <tr>
                        <td ><div id="_left_top_title" style="float: inherit;font-weight:bolder; margin-bottom: 10px;">-</div>
                        </td>
                    </tr>
                </table> 
          </td>
       </tr>
       <tr style="height: 100%;">
          <td style="height: 100%;">
              <tr>
                   <td style="width :30%;text-align:center;">
                       <div class="Machine_title">Line 6</div>
                        <table class="Machine_content" id="Line06">
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                   </td>
                   <td style="width :30%;text-align:center;">
                       <div class="Machine_title">Line 7</div>
                        <table class="Machine_content" id="Line07">
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                   </td>
                   <td style="width :30%">
                       <table style="background-color: #0D213A; text-align:center;" border ="1">
                           <tr>
                                <td style="font-weight:bolder;">产线状态</td>
                                <td style="font-weight:bolder;" colspan="2">车间温湿度℃</td>
                           </tr>
                           <tr>  
                                <td>
                                    <img src="../../Content/images/logo/ColorNew.png" id="img3" 
                                     style="width: 80%;height:70px;max-height:70px;background-color: #0D213A;"/> 
                                </td>
                                <td>当前温度: <span id="spTemperature">18</span> ℃</td>
                                <td>当前湿度: <span id="spHumidity">60±10%RH</span></td>
                           </tr>
                       </table>
                   </td>
              </tr>
          </td>
       </tr>
       <tr style="height: 100%;">
          <td style="height: 100%;">
            <tr>
                   <td style="width :30%;text-align:center;">
                       <div class="Machine_title">Line 5</div>
                        <table class="Machine_content" id="Line05">
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                   </td>
                   <td style="width :30%;text-align:center;">
                       <div class="Machine_title">Line 4</div>
                        <table class="Machine_content" id="Line04">
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                   </td>
                   <td style="width :30%">
                       <table style="background-color: #0D213A;" border ="1">
                           <tr style="font-weight:bolder;">
                                <td>车间介绍：</td>
                                <td style=" text-align:center;">车间负责人：<span id="tdPrincipal">张某某</span></td>
                           </tr>
                           <tr>
                               <td style="width: 246px; height: 100%;">
                                   <table style=" display:none">
                                       <tr><td>年利亚电子（深圳）有限公司的SMT</td></tr>
                                       <tr><td>产线始建于2012年6月。车间引入先</td></tr>
                                       <tr><td>进的自动印刷设备、自动贴装设备、</td></tr>
                                       <tr><td>自动检查设备以及其他品质管控设备。</td></tr>
                                       <tr><td>~~~~~</td></tr>
                                       <tr><td>~~~~~</td></tr>
                                       <tr><td>~~~~~</td></tr>
                                       <tr><td>~~~~~</td></tr>
                                   </table>
                                   <div id="_layout_left_data_div_tbody">
                                      <div id="_layout_left_data_div2_tbody">
                                          <table id="data_tbody" style="width: 100%; font-size: 15px; color: #4EC9CE; margin: 0 auto; height: 16%;">
                                              <tbody>
                                              </tbody>
                                           </table>
                                      </div>
                                   </div>
                               </td>
                               <td style="width: 150px; height: 100%;">
                                        <img src="../../Content/images/portraits/default.png" id="imgPortraits" 
                                        style="width: 80%;height:99%;max-height:170px; margin-left:16px; " alt="头像" title="头像" />
                               </td>
                           </tr>
                       </table>
                   </td>
              </tr>
          </td>
       </tr>
       <tr style="height: 100%;">
          <td>
             <tr>
                   <td style="width :30%;text-align:center;">
                       <div class="Machine_title">Line 1</div>
                       <table class="Machine_content" id="Line01">
                           <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                           </tr>
                       </table>
                   </td>
                   <td style="width :30%;text-align:center;">
                       <div class="Machine_title">Line 2</div>
                       <table class="Machine_content" id="Line02">
                           <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                           </tr>
                       </table>
                   </td>
                   <td style="width :30%;text-align:center;">
                        <div class="Machine_title">Line 3</div>
                        <table class="Machine_content" id="Line03">
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                   </td>
              </tr>
          </td>
       </tr>
       <tr style="height: 100%;">
          <td style="height: 100%;">
               <tr>
                   <td style="width :30%;text-align:center;">
                      <table border ='1' style="text-align:center;background-color: #0D213A; height:130px;max-height:130px;">
                           <tr style="font-weight:bolder;">
                                <td colspan="3">监控项目(Line 1)</td>
                           </tr>
                           <tr>
                                <td>贴片机抛料率(%)</td>
                                <td>贴片机效率(%)</td>
                                <td>生产效率(%)</td>
                           </tr>
                           <tr>
                                <td><span id="Line1PL">0.01</span>%</td>
                                <td><span id="Line1LY">0.01</span>%</td>
                                <td><span id="Line1XL">44.23</span>%</td>
                           </tr>
                       </table>
                   </td>
                   <td style="width :30%">
                        <table border ='1' style="text-align:center;background-color: #0D213A; height:130px;max-height:130px;">
                            <tr style="font-weight:bolder;">
                                <td colspan="3">监控项目(Line 2)</td>
                            </tr>
                            <tr>
                                <td>贴片机抛料率(%)</td>
                                <td>贴片机效率(%)</td>
                                <td>生产效率(%)</td>
                            </tr>
                            <tr>
                                <td><span id="Line2PL">0.01</span>%</td>
                                <td><span id="Line2LY">0.04</span>%</td>
                                <td><span id="Line2XL">26.36</span>%</td>
                            </tr>
                        </table>
                   </td>
                   <td style="width :30%">
                       <table border ='1' style="text-align:center;background-color: #0D213A;">
                           <tr style="font-weight:bolder;">
                                <td colspan="3">监控项目(Line 3)</td>
                           </tr>
                           <tr>
                                <td>贴片机抛料率(%)</td>
                                <td>贴片机效率(%)</td>
                                <td>生产效率(%)</td>
                           </tr>
                           <tr>
                                <td><span id="Line3PL">0.01</span>%</td>
                                <td><span id="Line3LY">0.06</span>%</td>
                                <td><span id="Line3XL">35.76</span>%</td>
                           </tr>
                       </table>
                   </td>
               </tr>
          </td>
       </tr>
    </table>

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
        $("#_left_top_title").html("SMT产线状态看板");
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
            scrollIntervalId = setInterval('scrollUp()', 500);
        }

        function scrollUp() {
            if (stopScroll) {
                return;
            }
            preTop = scrollElem.scrollTop;

            scrollElem.scrollTop += 1;
            if (preTop == scrollElem.scrollTop) {
                $("#data_tbody tbody").html("");
                GetWorkShop();
                scrollElem.scrollTop = 0;
                scrollElem.scrollTop += 1;
            }
        }

    </script>


    <script type="text/javascript">

        var AnalysisTime = 0; //解析时间(分钟)

        $(document).ready(function () {

            //获取抛料率的解析时间
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetRejectRateTime();
            AnalysisTime = ajax.value
            if (!AnalysisTime)
            {
                AnalysisTime = 1;
            }
            //获取车间信息
            GetWorkShop();

            //窗体作自适应大小
            ResizeAll();

            //显示时间
            GetNowTime();

            //获取当前产线的状态
            GetLineStatus();

            //解析贴片机的抛料率
            AnalysisRejectRate();

            //5分钟
            clearInterval(aTimeout);
            var aTimeout = setInterval("AnalysisRejectRate()", 1000 * 60 * AnalysisTime);
            //一分钟
            clearInterval(lsTimeout);
            var lsTimeout = setInterval("GetLineStatus()", 1000 * 60 * 1);
            //2分钟
            clearTimeout(lineInfoTimeout);
            var lineInfoTimeout = setTimeout("GetWorkShop()", 1000 * 60 * 2);
            //10分钟
            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("GetNowTime()", 1000 * 60 * 10);

        });

        //窗体作自适应大小
        $(window).resize(function () {
            ResizeAll();
        });

        function ResizeAll() {

            //某些浏览器不兼容div自适应高度
            //$(".gauge").height($(window).height() * 0.9 * 0.27);
        
            var _contentHeight = $(window).height() * 1 * 0.34;

            $("#_layout_left_data_div_tbody").css("height", "auto");

            $(".rows").height(_contentHeight * 0.1)

            if (8 * _contentHeight * 0.14 > _contentHeight) {
                $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                isScroll = true;
            }
        }

        //显示时间
        function GetNowTime() {
            //获取欢迎词
            var welcomeMsg = $.getUrlParam('welcomeMsg');
            $("#_welcome_text").html("");
            $("#_welcome_text").html(welcomeMsg);
          
            $("#dateAndWeek").html("");
            $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value));
            //clearTimeout(gwTimeout);
            //var gwTimeout = setTimeout("GetNowTime()", 1000 * 60 * 10);
        }

        //获取车间信息
        function GetWorkShop() {
            
            //获取车间名称
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWorkShopName();
            //var workShop = ajax.value
            //var ajaxResult = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetLineWorkShop(workShop);

            var ajaxResult = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetLineWorkShopInfo();
            if (ajaxResult.error != null) { return false; }
            $("#tdPrincipal").html(ajaxResult.value.CName);
            $("#spTemperature").html(ajaxResult.value.Temperature);
            $("#spHumidity").html(ajaxResult.value.Humidity);

            var html = "";
            $("#data_tbody tbody").html("");//先清空再加载 不然会把页面整死
            html += '<tr class="rows" ><td style="padding-left: 10px;border:none;padding-right: 10px;">' + ajaxResult.value.Remark + '</td></tr>';
            $(html).appendTo($("#data_tbody tbody"));
            ResizeAll();

            $.ajax({
                type: 'GET',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                data: { 'Type': 'Refresh', 'UserId': ajaxResult.value.Principal },
                dataType: 'text',
                success: function (data) {
                    $("#imgPortraits").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                    //clearTimeout(lineInfoTimeout);
                    //var lineInfoTimeout = setTimeout("GetWorkShop()", 1000 * 60 * 2);
                },
                error: function () {
                    return false;
                }
            });
        }

        /*解析贴片机的抛料率*/
        function AnalysisRejectRate() {
            $.ajax({
                type: 'GET',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                data: { 'Type': 'Analysis' },
                dataType: 'text',
                success: function (data) {
                    //获取贴片机抛料率
                    GetLineRejectRate();
                },
                error: function () {
                    return false;
                }
            });
        }

        /*获取贴片机抛料率(当天的)*/
        function GetLineRejectRate() {
           
            //获取当天Line1产线线抛料率与效率
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetLineRejectRate();
            if (ajax.error == null && ajax.value != null) {
                var LineList = ajax.value;
                //抛料率
                $("#Line1PL").html(LineList.RejectRate1);
                $("#Line2PL").html(LineList.RejectRate2);
                $("#Line3PL").html(LineList.RejectRate3);
                //利用率
                $("#Line1LY").html(LineList.WorkRatio1);
                $("#Line2LY").html(LineList.WorkRatio2);
                $("#Line3LY").html(LineList.WorkRatio3);
                //生产效率
                $("#Line1XL").html(LineList.ProdRatio1);
                $("#Line2XL").html(LineList.ProdRatio2);
                $("#Line3XL").html(LineList.ProdRatio3);
            }
            else {
                $("#Line1PL").html(0);
                $("#Line1LY").html(0);
                $("#Line1XL").html(0);
                $("#Line2PL").html(0);
                $("#Line2LY").html(0);
                $("#Line2XL").html(0);
                $("#Line3PL").html(0);
                $("#Line3LY").html(0);
                $("#Line3XL").html(0);
            }
        }


        //获取当前产线的状态
        function GetLineStatus() {
            //初始化所有产线为正常
            for(var i=1;i<=7;i++){
                var element_id = "Line0" + i;
                var tds = $("#" + element_id + " tr:eq(0) td");
                tds.removeClass();
                $(tds[0]).addClass("Machine_1_g Machine");
                $(tds[1]).addClass("Machine_2_g Machine");
                $(tds[2]).addClass("Machine_3_g Machine");
                $(tds[3]).addClass("Machine_4_g Machine");
                $(tds[4]).addClass("Machine_5_g Machine");
                $(tds[5]).addClass("Machine_6_g Machine");
            }
            //获取产线状态
            var entity = {};
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetLineMachineStatusKanban", JSON.stringify(entity));
            var result = $.parseJSON(ajax.value);
            var listStatus = result.data;
            var listEarlyWarningValue = result.data1;
            
            if (!listStatus || !listEarlyWarningValue) { return; }

            $.each(listStatus, function (i, o) {
                var element_id = "Line0" + o.LineId;
                var tds = $("#" + element_id + " tr:eq(0) td");

                //设备段1(上板机)
                if (o.MachineId == 1) {
                    $(tds[0]).removeClass();
                    if (o.MachineValue == 0) {
                        $(tds[0]).addClass("Machine_1_r Machine");
                    }
                    else if (o.MachineValue >= listEarlyWarningValue[0].EarlyWarningValue_SBJ) {
                        $(tds[0]).addClass("Machine_1_g Machine");
                    }
                    else {
                        $(tds[0]).addClass("Machine_1_y Machine");
                    }
                }
                //设备段2(印刷机)
                if (o.MachineId == 2) {
                    $(tds[1]).removeClass();
                    if (o.MachineValue == 0) {
                        $(tds[1]).addClass("Machine_2_r Machine");
                    }
                    else if (o.MachineValue >= listEarlyWarningValue[0].EarlyWarningValue_YSJ) {
                        $(tds[1]).addClass("Machine_2_g Machine");
                    }
                    else {
                        $(tds[1]).addClass("Machine_2_y Machine");
                    }
                }
                //设备段3(SPI)
                if (o.MachineId == 3) {
                    $(tds[2]).removeClass();
                    if (o.MachineValue == 0) {
                        $(tds[2]).addClass("Machine_3_r Machine");
                    }
                    else if (o.MachineValue >= listEarlyWarningValue[0].EarlyWarningValue_SPI) {
                        $(tds[2]).addClass("Machine_3_g Machine");
                    }
                    else {
                        $(tds[2]).addClass("Machine_3_y Machine");
                    }
                }
                //设备段4(贴片机)
                if (o.MachineId == 4) {
                    $(tds[3]).removeClass();
                    if (o.MachineValue == 0) {
                        $(tds[3]).addClass("Machine_4_r Machine");
                    }
                    else if (o.MachineValue >= listEarlyWarningValue[0].EarlyWarningValue_TPJ) {
                        $(tds[3]).addClass("Machine_4_g Machine");
                    }
                    else {
                        $(tds[3]).addClass("Machine_4_y Machine");
                    }
                }
                //设备段5(锡炉)
                if (o.MachineId == 5) {
                    $(tds[4]).removeClass();
                    if (o.MachineValue == 0) {
                        $(tds[4]).addClass("Machine_5_r Machine");
                    }
                    else if (o.MachineValue >= listEarlyWarningValue[0].EarlyWarningValue_XL) {
                        $(tds[4]).addClass("Machine_5_g Machine");
                    }
                    else {
                        $(tds[4]).addClass("Machine_5_y Machine");
                    }
                }
                //设备段6(AOI)
                if (o.MachineId == 6) {
                    $(tds[5]).removeClass();
                    if (o.MachineValue == 0) {
                        $(tds[5]).addClass("Machine_6_r Machine");
                    }
                    else if (o.MachineValue >= listEarlyWarningValue[0].EarlyWarningValue_AOI) {
                        $(tds[5]).addClass("Machine_6_g Machine");
                    }
                    else {
                        $(tds[5]).addClass("Machine_6_y Machine");
                    }
                }
            });
        }
    </script>
    </form>
</body>
</html>
