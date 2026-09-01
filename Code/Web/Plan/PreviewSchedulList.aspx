<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Masters.master"
    CodeBehind="PreviewSchedulList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.PreviewSchedulList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-1.9.1.js"></script>
    <link href="../Content/tableJs/bootstrap.min.css" rel="stylesheet" />

    <style type="text/css">
        body {
            padding-top: 50px;
            padding-bottom: 30px;
        }

        table.table > tbody > tr > td {
            height: 28px;
            vertical-align: middle;
        }

        /*td {
            min-width: 80px;
        }
        th {
            min-width: 80px;
        }*/
        .width100 {
            min-width: 100px;
        }
        .width120 {
            min-width: 120px;
        }
         .width140 {
            min-width: 140px;
        }
        .toolBar {
            height: 27px;
            padding: 0px 0px 0px 0px;
            margin: 0px 0px 2px 0px;
            background: url(../content/images/l_bg_hover.gif) repeat-x;
            position: relative;
            z-index: 1;
            width: 100%;
        }

        .toolbar-btn {
            float: left;
            padding: 1px 2px 1px 2px;
            margin: 4px 0px 0px 5px;
            height: 20px;
            display: inline;
        }

        .icon-16-view {
            background: url(../content/images/icon/view.png) no-repeat;
            width: 16px;
            height: 16px;
            float: left;
            margin-right: 3px;
            margin-top: 2px;
          
        }
    

        .btn-text {
            float: left;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            line-height: 18px;
            *line-height: 22px;
            height: 22px;
            text-decoration: none;
        }

        input[type=checkbox] {
            margin: 0px;
        }
       
        #div2 ::-webkit-scrollbar {display:none}
        .divPreview{
            width: 900px;
            overflow:auto;
            height: 208px;
        }
        .divPreview td, th {
            border:1px solid gray;
            width:100px;
            height:30px;
        }
        th {
            background-color:#ffffff;
        }
        .divPreview table {
            table-layout: fixed;
            width: 200px;
        }
        td:first-child.td1, th:first-child {
            
            position: -webkit-sticky;
            position:sticky;
            left:0; 
            z-index:1;
            background-color:#ffffff;
        }
        thead tr th {
            
            position: -webkit-sticky;
            position:sticky;
            top:0;
        }
        th:first-child{
            z-index:2;
            
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
     <div class="wrap_tb">
       
        <div id="divReport" class="tb_c">
            <div style="position: relative; width: 1240px" id="divPreview" class="divPreview">

                <table id="tblPreview" class="table table-bordered " style="width: 1240px; vertical-align: middle; position: absolute;word-break:break-all">
                    <thead id="thd1" >
                    </thead>
                    <tbody id="tby1">
                    </tbody>
                </table>

            </div>
        </div>
        <div id="divChart" class="" >
            <div id="ChartContainer"  >
            </div>
        </div>
    </div>

    <%--<div class="form-inline" style="padding-bottom: 5px;">
                预排天数：<select id="sltDayNum">
                    <option value="7">7</option>
                    <option value="15">15</option>
                    <option value="30">30</option>
                </select>
        
    </div>--%>

 
       
     
      <%--  <div id="div2" style="position: fixed; background-color: white;display: none">
            <table id="tblPreview2"  class="table table-bordered " style=" vertical-align: middle; width: 440px">
            <thead  style="width: 100%;display: block">
                <tr>
                    <th style="width: 140px">工单号</th>
                    <th style="width: 80px">面别</th>
                    <th style="width: 120px">工单待排总数</th>
                    <th style="width: 100px">预排总数</th>
                </tr>
            </thead>
            <tbody id="tby2" style="height: 300px;overflow: hidden; width: 100%;display: block">
            </tbody>
        </table>
        </div>--%>
    
    <script src="../Content/js/skt.utility.datetime.js"></script>
    <script type="text/javascript">
      

        var DayArr = [];
        var dayNum = <%=DayNum%>;
        var isLine =<%=IsLine%>;
        var dayTime,shiftId;
        var nowdate = new Date();
        var currentDay=getNowFormatDate(nowdate);
        var iframeWidth = (document.body.clientWidth < 1366 ? 1366 : document.body.clientWidth) - 10;
        var width12 = parseInt(iframeWidth * 0.12);
        var width10 = parseInt(iframeWidth * 0.11);
        var width4 = parseInt(iframeWidth * 0.065);
        var width8 = parseInt(iframeWidth * 0.08);
        var width9 = parseInt(iframeWidth * 0.09);
        var width7 = parseInt(iframeWidth * 0.065);
        var module = '<%=Request.QueryString["module"] %>';
        if (module == 1) {
            $("#toolbar>div")[0].style.display = "none";
            $("#toolbar>div")[1].style.display = "none";
        }
       
        $(function () {
            Load();
            var divPreview = document.getElementById('divPreview');
            var resizeContainer = function () {
              
                divPreview.style.width = window.innerWidth - 25 + 'px';
                divPreview.style.height = window.innerHeight - 37 + 'px';
            };
            resizeContainer();
            $(".tdCheck").on("click",function () {
                $(this).find("input")[0].click();
            });

            var $input = $("input[type='checkbox']");
            for (let i = 0; i < $input.length; i++) {
                $($input[i]).click(function(e) {
                    e = window.event || e;
                    if(document.all) {
                        e.cancelBubble = true;
                    } else {
                        e.stopPropagation();
                    }
                });
            }
        });
     

        function Load() {

            GetDayArr();
            List();
           
        }

        function GetDayArr() {
            var currentDate = nowdate.getTime();
            DayArr = [];
            dayLineCapacityArr = [];
            for (var i = 0; i <=dayNum; i++) {
                var oneDateTime = new Date(currentDate + i * 86400000);
                var one = ReturnTime(oneDateTime);
                DayArr.push(one);
            }
        }
        var dayLineCapacityArr = {};  //
        var ddList = {}; //线别日工作时长集合
        var wkList = {}; //车间线别日工作时长集合
        var ddBzList = {}; //线别日班制集合
        var wkBzList = {}; //车间线别日班制集合
        function List() {

            GetLineSchedulingWorkTimeList();
            GetWorkShopLineWorkHourList();
         
            //获取已排计划列表
            var ajax = SKT.LeanMES.Web.Plan.PreviewSchedulList.GetSchedulingList();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value != null) {
                var planVal = ajax.value;
                for (var i = 0; i < planVal.length; i++) {

                    if (planVal[i].DayTime != currentDay) {
                        //判断线别是否有预排
                        if ($("div").data(planVal[i].ProdOrderId + planVal[i].TableName + planVal[i].ResourceId) == undefined) {
                            $("div").data(planVal[i].ProdOrderId + planVal[i].TableName + planVal[i].ResourceId,1);
                        } 
                       
                    }
                    //累加工单面别的预排数量
                    if ($("div").data(planVal[i].ProdOrderId + planVal[i].TableName ) != undefined) {
                        $("div").data(planVal[i].ProdOrderId + planVal[i].TableName , $("div").data(planVal[i].ProdOrderId + planVal[i].TableName) + planVal[i].PlanNumber);
                    } else {
                        $("div").data(planVal[i].ProdOrderId + planVal[i].TableName , planVal[i].PlanNumber);
                    }
                    //日期预排数量
                    $("div").data(planVal[i].ProdOrderId+planVal[i].TableName+planVal[i].ResourceId + planVal[i].DayTime, planVal[i].PlanNumber+";"+planVal[i].State);
                }
            }
           
            //var html2 = "";  //表2数据
            var html = "";   //表1数据
            html += "<tr><th style=\"min-width:" + width12 + "px\"><%=Resources.lang.OrderNum%></th><th style=\"min-width:" + width4 + "px\"><%=Resources.lang.Layout%></th><th style=\"min-width:" + width9 + "px\"><%=Resources.lang.TotalWorkOrdersWaiting%></th><th style=\"min-width:" + width8 + "px\"><%=Resources.lang.TotalNumberOfPreArranged%></th><th style=\"min-width:" + width10 + "px\"><%=Resources.lang.AC_Resource%></th><th style=\"min-width:" + width8 + "px\"><%=Resources.lang.DailyCapacity%><span class=\"icon-16-info\" title=\"一天按8小时计算\"></span></th>";

            for (var k = 0; k < DayArr.length; k++) {
                var dt = new Date(DayArr[k]).getDay();
                if (DayArr[k] == currentDay) {
                    html += " <th style=\"min-width:" + width7 + "px;background-color: darkseagreen;\">" + DayArr[k] + "<span class=\"icon-16-info\" title=\"当天不参与预排\"></span></th>";
                }else if (dt == 0 || dt == 6) {
                    html += " <th style=\"min-width:" + width7 + "px;background-color: beige;\">" + DayArr[k] + "</th>";
                } else {
                    html += " <th style=\"min-width:" + width7 + "px\">" + DayArr[k] + "</th>";
                }
               
            }
            html += "</tr>";
            $("#thd1").html(html);
            html = "";
            var rowSpan = 0;
            //获取排产工单列表
            var ajax = SKT.LeanMES.Web.Plan.PreviewSchedulList.GetSchedulingOrderList();
            if (ajax.error == null) {
                var result = ajax.value;
                for (var i = 0; i < result.length; i++) {

                    //根据产品与面别获取资源线别
                    var lineAjax = SKT.LeanMES.Web.Plan.PreviewSchedulList.GetSchedulingLine(result[i].ItemId, result[i].TableName).value;
                    if (lineAjax.length > 0) {
                        rowSpan = lineAjax.length;
                    } else {
                        rowSpan = 1;
                    }

                    var tableName = result[i].TableName;
                    html += '<tr><td style="min-width:' + width12 + 'px;font-weight:bold;cursor: pointer;" rowspan="' + rowSpan + '" onclick="View('+result[i].ProdOrderID+',\''+tableName+'\')" class="td1">' + result[i].OrderNo + '</td>';
                    html += '<td rowspan="' + rowSpan + '" style="min-width:' + width4 + 'px">' + tableName + '</td>';
                    html += '<td style="min-width:' + width9 + 'px"  rowspan="' + rowSpan + '"><label id="lblOrderNum' + result[i].ProdOrderID + tableName + '">' + result[i].OrderNum + '</label></td>';

                    //如果有预排则赋值
                    if ($("div").data(result[i].ProdOrderID + tableName) != undefined) {
                        html += '<td style="min-width:' + width8 + 'px"  rowspan="' + rowSpan + '" ><label id="lblAlreadySchedulingNum' + result[i].ProdOrderID + tableName + '">' + $("div").data(result[i].ProdOrderID + tableName).toFixed(2) + '</label></td>';
                    } else {
                        html += '<td style="min-width:' + width8 + 'px"  rowspan="' + rowSpan + '" ><label id="lblAlreadySchedulingNum' + result[i].ProdOrderID + tableName + '">' + result[i].AlreadySchedulingNum + '</label></td>';
                    }
                  

                    if (lineAjax.length > 0) {
                        for (var j = 0; j < lineAjax.length; j++) {
                            if (j != 0) {
                                html += '<tr>';
                            }
                            //如果有预排则赋值
                            if ($("div").data(result[i].ProdOrderID + tableName + lineAjax[j].ResourceId) != undefined) {
                                html += '<td style="min-width:' + width10 + 'px" class="tdCheck"><input checked="checked" type="checkbox" onclick="ChoiceLine(this,' + lineAjax[j].ResourceId + ',' + result[i].ProdOrderID + ',\'' + tableName + '\')" //><input type="hidden" value="' + lineAjax[j].ResourceId + '_' + result[i].ProdOrderID + '_' + tableName + '_' + result[i].ItemId + '" />' + lineAjax[j].ResName + ' </td>';
                            } else {
                                html += '<td style="min-width:' + width10 + 'px" class="tdCheck"><input type="checkbox" onclick="ChoiceLine(this,' + lineAjax[j].ResourceId + ',' + result[i].ProdOrderID + ',\'' + tableName + '\')" //><input type="hidden" value="' + lineAjax[j].ResourceId + '_' + result[i].ProdOrderID + '_' + tableName + '_' + result[i].ItemId + '" />' + lineAjax[j].ResName + ' </td>';
                            }
                          
                            html += '<td style="min-width:' + width8 + 'px">' + lineAjax[j].Capacity + '</td>';

                            for (var f = 0; f < DayArr.length; f++) {

                                var dt1 = new Date(DayArr[f]).getDay();
                                if (DayArr[f] == currentDay) {
                                    html += '<td style="min-width:' + width7 + 'px;background-color: darkseagreen;">';
                                }
                                else if (dt1 == 0 || dt1 == 6) {
                                    html += '<td style="min-width:' + width7 + 'px;background-color: beige;">';
                                } else {
                                    html += '<td style="min-width:' + width7 + 'px">';
                                }
                             
                               
                                //获取日工作时间
                                dayTime = ddList[lineAjax[j].ResourceId + DayArr[f]];
                                //如果当天线别没有排日历
                                if (dayTime == undefined) {
                                    //则获取车间班制时长与班制ID
                                    dayTime= wkList[lineAjax[j].ResourceId];
                                    shiftId = wkBzList[lineAjax[j].ResourceId];
                                    if (dayTime != undefined) {
                                        ddList[lineAjax[j].ResourceId + DayArr[f]] = dayTime;
                                        ddBzList[lineAjax[j].ResourceId + DayArr[f]] = shiftId;
                                    }
                                }
                               // AddLineCapacity(lineCapacity,dayTime);
                               
                                if (dayTime != undefined ) {
                                   
                                    var dayPlanNumber = 0;   //日计划排产数量
                                    var dayState = -3;   //日计划排产数量
                                    var useTimes = 0;        //用时时长
                                    //判断当天有没有已排产
                                    var dayObj = $("div").data(result[i].ProdOrderID + tableName + lineAjax[j].ResourceId + DayArr[f]);
                                    if ( dayObj!= undefined) {
                                        dayPlanNumber = dayObj.split(";")[0];
                                        dayState= dayObj.split(";")[1];
                                        //var lineCapaTime = dayLineCapacityArr[lineCapacity];
                                        var dd = lineAjax[j].Capacity / (8 * 60);
                                        var bb = dd * dayTime - dayPlanNumber;
                                        useTimes = dayPlanNumber / dd;
                                        ddList[lineAjax[j].ResourceId + DayArr[f]] = bb / dd < 0 ? 0 : bb / dd;
                                        //wkList[lineAjax[j].ResourceId] = ddList[lineAjax[j].ResourceId + DayArr[f]];
                                    }
                                    html +=ReturnLable(result[i].ProdOrderID,lineAjax[j].ResourceId,DayArr[f],tableName,ddBzList[lineAjax[j].ResourceId + DayArr[f]],dayState,useTimes,dayPlanNumber);

                                } else {
                                    html += "<label id='lbl" + result[i].ProdOrderID + "_" + lineAjax[j].ResourceId + "_" + DayArr[f] + "_" + tableName + "' data-shift=\"0\" data-time=\"0\" data-state=\"-3\" style=\"color:red\" title=\"未排班\">0</label></td>";
                                }
                            }
                            html += "</tr>";
                        }
                    } else {
                        html += '<td style="min-width:' + width10 + 'px">-</td>';
                        html += '<td style="min-width:' + width8 + 'px">-</td>';
                        for (var k = 0; k < DayArr.length; k++) {
                            var dt2 = new Date(DayArr[k]).getDay();
                            if (DayArr[k] == currentDay) {
                                html += '<td style="min-width:' + width7 + 'px;background-color: darkseagreen;">';
                            } else if (dt2 == 0 || dt2 == 6) {
                                html += '<td style="min-width:' + width7 + 'px;background-color: beige;">0</td>';
                            } else {
                                html += '<td style="min-width:' + width7 + 'px">0</td>';
                            }
                           
                        }
                        html += " </tr>";
                    }
                    html += "</tr>";
                }
            }
            $("#tby1").html(html);
            //$("#tblPreview2 tbody").html(html2);
           
        }

        //单开页面显示
        function SeparateWindow() {
            var url = encodeURI("PreviewSchedulList.aspx?module=1");
            window.open(url);
        }

        //返回排产文本信息
        function ReturnLable(prodorderId,resourceId,datetime,tableName,dataShift,dayState,useTimes,dayPlanNumber){
            if(dayState!=-3){
                var stateStr="";
                switch(dayState){
                    case "-2":
                        stateStr="待备料";
                        break;
                    case "-1":
                        stateStr="备料中";
                        break;
                    case "0":
                        stateStr="备料完成/可上料";
                        break;
                    case "1":
                        stateStr="上料验证";
                        break;
                    case "2":
                        stateStr="投产中";
                        break;
                    case "3":
                        stateStr="已暂停";
                        break;
                    case "4":
                        stateStr="已完成";
                        break;
                    case "5":
                        stateStr="卸料";
                        break;
                }
                return  "<label id='lbl" + prodorderId + "_" + resourceId + "_" + datetime + "_" + tableName + "' data-shift='"+dataShift+"' title='"+stateStr+"' data-state=\""+dayState+"\"  data-time=\""+useTimes+"\" style=\"color:orange\">" + dayPlanNumber + "</label></td>";
            }else{
                return  "<label id='lbl" + prodorderId + "_" + resourceId + "_" + datetime + "_" + tableName + "' data-shift='"+dataShift+"' data-state=\""+dayState+"\"  data-time=\""+useTimes+"\">" + dayPlanNumber + "</label></td>";
            }
           
            
        }

        //选择单线排产
        function ChoiceLine(obj, resourceId, prodOrderId, tableName) {
           
            var capacity = parseFloat($(obj).parent().next().text()); //线别日产能
            var orderNum = parseFloat($("#lblOrderNum" + prodOrderId + tableName).text()); //工单数
            var alreadySchedulingNum = parseFloat($("#lblAlreadySchedulingNum" + prodOrderId + tableName).text()); //已排数量
            var schedulingNum = orderNum - alreadySchedulingNum; //待排产数量
            var dayTime = 8;  //一天时间默认8小时
            var timeCapacity = capacity / (dayTime * 60);   //每分钟产能
            var surplusTimes = 0;
            if ($(obj).prop('checked') == true) {

                if (schedulingNum > 0) {
                    for (var i = 1; i <DayArr.length; i++) {
                        
                        var lineOneVal = parseFloat(ddList[resourceId + DayArr[i]]); //获取线别日产能可生产时间

                        if (lineOneVal > 0 && schedulingNum > 0) {
                            var syCapacity = parseFloat((timeCapacity * lineOneVal).toFixed(4)); //日剩余产能=日产能/天时间*天剩余时间
                            if (schedulingNum > syCapacity) { //如果剩余排产数大于当日产能
                                schedulingNum = schedulingNum - syCapacity;
                                $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text(syCapacity.toFixed(2));
                                $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-time", ddList[resourceId + DayArr[i]]);
                                ddList[resourceId + DayArr[i]] = 0; //剩余产能时间清空
                                alreadySchedulingNum = parseFloat(alreadySchedulingNum) + syCapacity;
                            } else {
                                
                                syCapacity = syCapacity - schedulingNum;
                                surplusTimes=syCapacity / timeCapacity < 0 ? 0 : syCapacity / timeCapacity;   //剩余产能时间
                                alreadySchedulingNum = alreadySchedulingNum + schedulingNum; //累计已排数量
                                $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text(schedulingNum.toFixed(2));
                                $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-time", ddList[resourceId + DayArr[i]]-surplusTimes);
                                schedulingNum = 0;
                                ddList[resourceId + DayArr[i]] = surplusTimes;
                            }
                        }
                        if (schedulingNum <= 0) {
                            break;
                        }

                    }
                }

            } else {

                for (var i = 1; i <DayArr.length; i++) {
                    var dd = parseFloat($("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text());
                    var state = parseFloat($("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-state"));
                    if (dd <= 0 ||state!=-3) {
                        continue;
                    }
                    $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text(0);
                    $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-time", 0);
                    var lineOneVal1 = parseFloat(ddList[resourceId + DayArr[i]]); //获取线别日产能可生产时间
                    ddList[resourceId + DayArr[i]] = lineOneVal1 + Math.round((dd / timeCapacity).toFixed(2));
                    alreadySchedulingNum = alreadySchedulingNum.toFixed(2) - dd;

                }
            }
            SetAlreadySchedulingNum(prodOrderId, tableName, alreadySchedulingNum.toFixed(2));
          
           // $("#lbl2AlreadySchedulingNum" + prodOrderId + tableName).text(alreadySchedulingNum.toFixed(2));
                
        }

        function SetAlreadySchedulingNum(prodOrderId, tableName, val) {
          
            $("#lblAlreadySchedulingNum" + prodOrderId + tableName).text(Math.round(val));
        }




        function AddLineCapacity(lineCapacity,dayTime) {
            if (dayLineCapacityArr[lineCapacity]!=undefined) {
                return false;
            } else {
                if (dayTime != undefined) {
                    dayLineCapacityArr[lineCapacity] = dayTime;
                } else {
                    dayLineCapacityArr[lineCapacity] = 0;
                }
                return true;
            }
        }

        //获取线别排产日历工作时长
        function GetLineSchedulingWorkTimeList() {
            ddList = {};
            ddBzList = {};
            var ajax = SKT.LeanMES.Web.Plan.PreviewSchedulList.GetLineSchedulingWorkTimeList();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            if (ajax.value != null) {
                for (var i = 0; i < ajax.value.length; i++) {
                  
                    ddList[ajax.value[i].ResourceId + ajax.value[i].DayTime] = ajax.value[i].WorkMinute;
                    ddBzList[ajax.value[i].ResourceId + ajax.value[i].DayTime]=ajax.value[i].ShiftId;
                }
            }
        }

        //获取车间线别排产日历工作时长
        function GetWorkShopLineWorkHourList() {
            wkList = {};
            wkBzList = {};
            var ajax = SKT.LeanMES.Web.Plan.PreviewSchedulList.GetWorkShopLineWorkHourList();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            if (ajax.value != null) {
                for (var i = 0; i < ajax.value.length; i++) {
                    wkList[ajax.value[i].ResourceId] = ajax.value[i].WorkMinute;
                    wkBzList[ajax.value[i].ResourceId]=ajax.value[i].ShiftId;
                }
            }
        }

        //重新预排产
        function AfreshPreScheduling() {

            //取消所有排产数据 但不取消勾选
            $("#tblPreview :checked").each(function () {
                var capacity = parseFloat($(this).parent().next().text()); //线别日产能
                var hiddenVal = $(this).parent().find("input")[1].value.split('_');
                var resourceId = hiddenVal[0];
                var prodOrderId = hiddenVal[1];
                var tableName = hiddenVal[2];
               
                var alreadySchedulingNum = parseFloat($("#lblAlreadySchedulingNum" + prodOrderId + tableName).text()); //已排数量
                var dayTime = 8;  //一天时间默认8小时
                var timeCapacity = capacity / (dayTime * 60);   //每分钟产能

                for (var i = 1; i <DayArr.length; i++) {
                    var dd = parseFloat($("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text());
                    var state = parseFloat($("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-state"));
                    if (dd <= 0 ||state!=-3) {
                        continue;
                    }
                    $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text(0);
                    $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-time", 0);
                    var lineOneVal1 = parseFloat(ddList[resourceId + DayArr[i]]); //获取线别日产能可生产时间
                    ddList[resourceId + DayArr[i]] = lineOneVal1 + Math.round((dd / timeCapacity).toFixed(2));
                    alreadySchedulingNum = alreadySchedulingNum.toFixed(2) - dd;

                }
                SetAlreadySchedulingNum(prodOrderId, tableName, alreadySchedulingNum.toFixed(2));
                //$("#lbl2AlreadySchedulingNum" + prodOrderId + tableName).text(alreadySchedulingNum.toFixed(2));
            });


            if (isLine == 0) {
                ////重新预排产 根据 1=  线别》天数 方式排产
                $("#tblPreview  :checked").each(function() {
                    var hiddenVal = $(this).parent().find("input")[1].value.split('_');
                    var resourceId = hiddenVal[0];
                    var prodOrderId = hiddenVal[1];
                    var tableName = hiddenVal[2];
                    ChoiceLine($(this), resourceId, prodOrderId, tableName);

                });
            } else {

                //重新预排产 根据 1= 天数》线别 方式排产
                var orderTableList = [];
                var orderList = [];
                $("#tblPreview  :checked").each(function () {

                    var hiddenVal = $(this).parent().find("input")[1].value.split('_');
                    var resourceId = hiddenVal[0];
                    var prodOrderId = hiddenVal[1];
                    var tableName = hiddenVal[2];
                    var alreadySchedulingNum = parseFloat($("#lblAlreadySchedulingNum" + prodOrderId + tableName).text());
                    var schedulingNum = parseFloat($("#lblOrderNum" + prodOrderId + tableName).text()) - alreadySchedulingNum;

                    if (orderTableList.indexOf(prodOrderId + "-" + tableName + "-" + schedulingNum + "-" + alreadySchedulingNum) <= -1) {
                        orderTableList.push(prodOrderId + "-" + tableName + "-" + schedulingNum + "-" + alreadySchedulingNum);
                    }

                    var entity = {};
                    entity.ProdOrderId = prodOrderId;
                    entity.TableName = tableName;
                    entity.ResourceId = resourceId;
                    entity.DayCapacity = parseFloat($(this).parent().next().text());//线别日产能
                    entity.TimeCapacity = parseFloat($(this).parent().next().text()) / (8 * 60);   //每分钟产能
                    orderList.push(entity);
                });


                for (var k = 0; k < orderTableList.length; k++) {

                    var proderId = orderTableList[k].split('-')[0];
                    var tableName = orderTableList[k].split('-')[1];
                    var schedulingNum = parseFloat(orderTableList[k].split('-')[2]);
                    var alreadySchedulingNum = parseFloat(orderTableList[k].split('-')[3]);
                    var lineAjax = orderList.filter(function (entity1) {
                        return entity1.ProdOrderId == proderId && entity1.TableName == tableName;
                    });
                    var surplusTimes = 0;
                    var i = 1;
                    //预排产数大于0 和预排天数大于0
                    while (schedulingNum > 0 && (dayNum - i) > 0) {
                        for (var j = 0; j < lineAjax.length; j++) {
                            var lineOneVal = parseFloat(ddList[lineAjax[j].ResourceId + DayArr[i]]); //获取线别日产能可生产时间

                            if (lineOneVal > 0 && schedulingNum > 0) {
                                var syCapacity = parseFloat((lineAjax[j].TimeCapacity * lineOneVal).toFixed(4)); //日剩余产能=日产能/天时间*天剩余时间
                                if (schedulingNum > syCapacity) { //如果剩余排产数大于当日产能
                                    schedulingNum = schedulingNum - syCapacity;
                                   
                                    $("#lbl" + proderId + "_" + lineAjax[j].ResourceId + "_" + DayArr[i] + "_" + tableName).text(syCapacity.toFixed(2));
                                    $("#lbl" + proderId + "_" + lineAjax[j].ResourceId + "_" + DayArr[i] + "_" + tableName).attr("data-time", ddList[lineAjax[j].ResourceId + DayArr[i]]);
                                    ddList[lineAjax[j].ResourceId + DayArr[i]] = 0; //剩余产能时间清空
                                    alreadySchedulingNum = parseFloat(alreadySchedulingNum) + syCapacity;
                                } else {

                                    syCapacity = syCapacity - schedulingNum;
                                    surplusTimes = syCapacity / lineAjax[j].TimeCapacity < 0 ? 0 : syCapacity / lineAjax[j].TimeCapacity;
                                    alreadySchedulingNum = alreadySchedulingNum + schedulingNum; //累计已排数量
                                    $("#lbl" + proderId + "_" + lineAjax[j].ResourceId + "_" + DayArr[i] + "_" + tableName).text(schedulingNum.toFixed(2));
                                    $("#lbl" + proderId + "_" + lineAjax[j].ResourceId + "_" + DayArr[i] + "_" + tableName).attr("data-time", ddList[lineAjax[j].ResourceId + DayArr[i]]-surplusTimes);
                                    schedulingNum = 0;
                                    ddList[lineAjax[j].ResourceId + DayArr[i]] =surplusTimes ;
                                }
                            }
                            if (schedulingNum <= 0) {
                                break;
                            }

                        }
                        i += 1;
                    }
                    SetAlreadySchedulingNum(proderId, tableName, alreadySchedulingNum.toFixed(2));
                }
            }
        }


     


        ///单线预排
        function SinglePreScheduling() {
            CancelCheckd();
            var i = 0;
            var tdCount = 0;
            var resourceId = 0;
            var prodOrderId = 0;
            var tableName = '';
            var hiddenVal;
                
            $("#tby1 tr").each(function (obj) {
                if (i == 0) { //获取第一行的列数
                    tdCount = $(this).find("td").length;
                }
                //如果行的列数等于最大列数 
                if ($(this).find("td").length >= tdCount) {
                    if ($(this).find("td:eq(4)").find("input")[0] != undefined) {
                        $(this).find("td:eq(4)").find("input")[0].checked = true;
                        hiddenVal = $(this).find("td:eq(4)").find("input")[1].value.split('_');
                        resourceId = hiddenVal[0];
                        prodOrderId = hiddenVal[1];
                        tableName = hiddenVal[2];
                        ChoiceLine($(this).find("td:eq(4)").find("input")[0], resourceId, prodOrderId, tableName);
                    }

                }
                i++;
            });
        }

        ///全线预排
        function AllPreScheduling() {
         
            CancelCheckd();
           
            var i = 0;
            var tdCount = 0;
            var resourceId = 0;
            var prodOrderId = 0;
            var tableName = '';
            var hiddenVal;
            var capacity; //线别日产能

            if (isLine == 0) {

                $("#tby1 tr").each(function(obj) {
                    if (i == 0) { //获取第一行的列数
                        tdCount = $(this).find("td").length;
                    }

                    //如果行的列数等于最大列数 
                    if ($(this).find("td").length >= tdCount) {
                        if ($(this).find("td:eq(4)").find("input")[0] != undefined) {
                            $(this).find("td:eq(4)").find("input")[0].checked = true;
                            hiddenVal = $(this).find("td:eq(4)").find("input")[1].value.split('_');
                            resourceId = hiddenVal[0];
                            prodOrderId = hiddenVal[1];
                            tableName = hiddenVal[2];
                            ChoiceLine($(this).find("td:eq(4)").find("input")[0], resourceId, prodOrderId, tableName);
                        }
                    } else {
                        if ($(this).find("td:eq(0)").find("input")[0] != undefined) {
                            $(this).find("td:eq(0)").find("input")[0].checked = true;
                            hiddenVal = $(this).find("td:eq(0)").find("input")[1].value.split('_');
                            resourceId = hiddenVal[0];
                            prodOrderId = hiddenVal[1];
                            tableName = hiddenVal[2];
                            ChoiceLine($(this).find("td:eq(0)").find("input")[0], resourceId, prodOrderId, tableName);
                        }
                    }
                    i++;
                });
            } else {

                var orderTableList = [];
                var orderList = [];
                $("#tby1 tr").each(function (obj) {


                    if (i == 0) { //获取第一行的列数
                        tdCount = $(this).find("td").length;
                    }

                    //如果行的列数等于最大列数 
                    if ($(this).find("td").length >= tdCount) {
                        if ($(this).find("td:eq(4)").find("input")[0] != undefined) {
                            $(this).find("td:eq(4)").find("input")[0].checked = true;
                            hiddenVal = $(this).find("td:eq(4)").find("input")[1].value.split('_');
                            resourceId = hiddenVal[0];
                            prodOrderId = hiddenVal[1];
                            tableName = hiddenVal[2];
                            capacity = parseFloat($($(this).find("td:eq(4)").find("input")[0]).parent().next().text());

                        }
                    } else {
                        if ($(this).find("td:eq(0)").find("input")[0] != undefined) {
                            $(this).find("td:eq(0)").find("input")[0].checked = true;
                            hiddenVal = $(this).find("td:eq(0)").find("input")[1].value.split('_');
                            resourceId = hiddenVal[0];
                            prodOrderId = hiddenVal[1];
                            tableName = hiddenVal[2];
                            capacity = parseFloat($($(this).find("td:eq(0)").find("input")[0]).parent().next().text());
                        }
                    }
                    i++;

                    var alreadySchedulingNum = parseFloat($("#lblAlreadySchedulingNum" + prodOrderId + tableName).text());
                    var schedulingNum = parseFloat($("#lblOrderNum" + prodOrderId + tableName).text()) - alreadySchedulingNum;


                    if (orderTableList.indexOf(prodOrderId + "-" + tableName + "-" + schedulingNum + "-" + alreadySchedulingNum) <= -1) {
                        orderTableList.push(prodOrderId + "-" + tableName + "-" + schedulingNum + "-" + alreadySchedulingNum);
                    }

                    var entity = {};
                    entity.ProdOrderId = prodOrderId;
                    entity.TableName = tableName;
                    entity.ResourceId = resourceId;
                    entity.DayCapacity = capacity; //线别日产能
                    entity.TimeCapacity = capacity / (8 * 60); //每分钟产能
                    orderList.push(entity);
                });


                for (var k = 0; k < orderTableList.length; k++) {

                    var proderId = orderTableList[k].split('-')[0];
                    var tableNamek = orderTableList[k].split('-')[1];
                    var schedulingNum = parseFloat(orderTableList[k].split('-')[2]);
                    var alreadySchedulingNum = parseFloat(orderTableList[k].split('-')[3]);
                    var lineAjax = orderList.filter(function (entity1) {
                        return entity1.ProdOrderId == proderId && entity1.TableName == tableNamek;
                    });
                    var g = 1;
                    //预排产数大于0 和预排天数大于0
                    while (schedulingNum > 0 && (dayNum - g) > 0) {
                        for (var j = 0; j < lineAjax.length; j++) {
                            var lineOneVal = parseFloat(ddList[lineAjax[j].ResourceId + DayArr[g]]); //获取线别日产能可生产时间

                            if (lineOneVal > 0 && schedulingNum > 0) {
                                var syCapacity = parseFloat((lineAjax[j].TimeCapacity * lineOneVal).toFixed(4)); //日剩余产能=日产能/天时间*天剩余时间
                                if (schedulingNum > syCapacity) { //如果剩余排产数大于当日产能
                                    schedulingNum = schedulingNum - syCapacity;
                                    ddList[lineAjax[j].ResourceId + DayArr[g]] = 0; //剩余产能时间清空
                                    $("#lbl" + proderId + "_" + lineAjax[j].ResourceId + "_" + DayArr[g] + "_" + tableNamek).text(syCapacity.toFixed(2));
                                    alreadySchedulingNum = parseFloat(alreadySchedulingNum) + syCapacity;
                                } else {

                                    syCapacity = syCapacity - schedulingNum;
                                    alreadySchedulingNum = alreadySchedulingNum + schedulingNum; //累计已排数量
                                    $("#lbl" + proderId + "_" + lineAjax[j].ResourceId + "_" + DayArr[g] + "_" + tableNamek).text(schedulingNum.toFixed(2));
                                    schedulingNum = 0;
                                    ddList[lineAjax[j].ResourceId + DayArr[g]] = syCapacity / lineAjax[j].TimeCapacity < 0 ? 0 : syCapacity / lineAjax[j].TimeCapacity;
                                }
                            }
                            if (schedulingNum <= 0) {
                                break;
                            }

                        }
                        g += 1;
                    }
                    SetAlreadySchedulingNum(proderId, tableNamek, alreadySchedulingNum.toFixed(2));
                }
            }
       

        }

        //取消勾选
        function CancelCheckd() {
            
            $("#tblPreview  :checked").each(function () {
                
                var capacity = parseFloat($(this).parent().next().text()); //线别日产能
           
                var hiddenVal = $(this).parent().find("input")[1].value.split('_');
                var resourceId = hiddenVal[0];
                var prodOrderId = hiddenVal[1];
                var tableName = hiddenVal[2];
                var alreadySchedulingNum = parseFloat($("#lblAlreadySchedulingNum" + prodOrderId + tableName).text()); //已排数量
                var dayTime = 8;  //一天时间默认8小时
                var timeCapacity = capacity / (dayTime * 60);   //每分钟产能
                for (var i = 1; i <DayArr.length; i++) {
                  
                    var dd = parseFloat($("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text());
                    var state = parseFloat($("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-state"));
                    if (dd <= 0 ||state!=-3) {
                        continue;
                    }

                    $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text(0);
                   
                    var lineOneVal1 = parseFloat(ddList[resourceId + DayArr[i]]); //获取线别日产能可生产时间
                    ddList[resourceId + DayArr[i]] = lineOneVal1 + Math.round((dd / timeCapacity).toFixed(2));
                    alreadySchedulingNum = alreadySchedulingNum.toFixed(2) - dd;

                }
                SetAlreadySchedulingNum(prodOrderId, tableName, alreadySchedulingNum.toFixed(2));
               // $("#lbl2AlreadySchedulingNum" + prodOrderId + tableName).text(alreadySchedulingNum.toFixed(2));
                $(this).attr("checked", false);
            });

        }
        //生成生产计划
        function CreatePlan() {
            if (!window.confirm("确认生成排产计划？")) {
                return "";
            }
            var list = [];
            $("#tblPreview  :checked").each(function () {
                var hiddenVal = $(this).parent().find("input")[1].value.split('_');
                var resourceId = hiddenVal[0];
                var prodOrderId = hiddenVal[1];
                var tableName = hiddenVal[2];
                // var capacity = 0.0;
                var dayCapacityList = "";
                var entity = {};

                for (var i = 1; i <DayArr.length; i++) {

                    var ddCapacity = parseFloat($("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).text());
                    var shift = $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-shift");
                    var time = $("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-time");
                    var state = parseFloat($("#lbl" + prodOrderId + "_" + resourceId + "_" + DayArr[i] + "_" + tableName).attr("data-state"));
                    if (dayCapacityList != "") {
                        dayCapacityList += ",";
                    }
                    if (state != -3) {
                        ddCapacity = 0;
                    }
                    dayCapacityList += ddCapacity+";"+shift+";"+parseInt(time);

                    //capacity = capacity + parseFloat(ddCapacity);
                }

                entity.ResourceId = resourceId;
                entity.ProdOrderId = prodOrderId;
                entity.TableName = tableName;
                entity.DayCapacityList = dayCapacityList;

                list.push(entity);
            });
            
            //todo 生成排产计划
            var ajax = SKT.LeanMES.Web.Plan.PreviewSchedulList.CreateSchedulPlan(JSON.stringify(list),dayNum);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
          
            alert('<%=Resources.Messages.OperationSuccess%>');
            setTimeout('location.reload()',1000); 
             
        }

        function ReloadUrl(){
            location.reload();
        }
      

        function ReturnTime(twoDateTime) {

            var twoMonth = twoDateTime.getMonth() + 1;
            var twoDate = twoDateTime.getDate();
            var two = twoDateTime.getFullYear() + '-' + (twoMonth > 9 ? twoMonth : '0' + twoMonth) + '-' + (twoDate > 9 ? twoDate : '0' + twoDate);
            return two;
        }
      
        function View(id,tb) {
            if (id == "") return false;
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/PreviewSchedulView.aspx?ID=" + id+"&Tb="+tb;
            dialog({ title: "查看工单排产信息", src: openWinUrl, width: 1000, height: 520 });
        }
    </script>


</asp:Content>


