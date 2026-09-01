<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="ResourceCalendarList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.ResourceCalendarList" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server" >
    <link href="../Content/fullcalendar.css" rel="stylesheet" />
    <link href="../Content/fullcalendar-3.7.0/rhui.css" rel="stylesheet" />
    <script src="../Content/js/jquery-1.9.1.js" type="text/javascript"></script>
    <%-- <script src="../Content/js/datetimepicker/jquery.datetimepicker.full.js"></script>
    <link href="../Content/js/datetimepicker/jquery.datetimepicker.css" rel="stylesheet" />
   <script src="../Content/js/datetimepicker/jquery.datetimepicker.js"></script>--%>
    <script src="../Content/js/jquery-ui-1.10.2.custom.min.js" type="text/javascript"></script>
    <script src="../Content/fullcalendar-3.7.0/lib/moment.min.js"></script>
    <script src="../Content/js/fullcalendar.min.js" type="text/javascript"></script>
    <script src="../Content/fullcalendar-3.7.0/rhui-all.js"></script>
    <style type="text/css">
    .base{
      width:150px;
      height:150px;
      border:2px solid black;
      margin-top:100px;
      margin-left:100px;
    }
    .pop{
      width:200px;
      height:100px;
      border:2px solid grey;
      border-radius: 2px;
      box-shadow: 2px 2px 2px grey;
      position:fixed;
      display:none;
      background-color:white;
      z-index:999 
    }
    .triangle-bottom{
      width:0;
      height:0;
      border-top:20px solid grey;
      border-left:10px dashed transparent;
      border-right:10px dashed transparent;
      position:absolute;
      left:90px;
      top:100px;
    }
    .triangle-bottom:after{
      content:'';
      width:0;
      height:0;
      border-top:18px solid white;
      border-left:8px dashed transparent;
      border-right:8px dashed transparent;
      position:absolute;
      left:-8px;
      top:-20px;
    }
    .triangle-top{
      width:0;
      height:0;
      border-bottom:20px solid grey;
      border-left:10px dashed transparent;
      border-right:10px dashed transparent;
      position:absolute;
      left:90px;
      bottom:100px;
    }
    .triangle-top:after{
      content:'';
      width:0;
      height:0;
      border-bottom:18px solid white;
      border-left:8px dashed transparent;
      border-right:8px dashed transparent;
      position:absolute;
      left:-8px;
      bottom:-20px;
    }
  .Field112
   {
    width: 23.3%;
    height: 21px;
    text-align: left;
    background-color: #fff;
    padding: 3px;
    border-top: 1px solid #d3d3d3;
    border-left: 1px solid #d3d3d3;
    border-right: 1px solid #d3d3d3;
    border-bottom: 1px solid #d3d3d3;
    word-break: break-all;
}
    </style>
    <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" id="tb1">
        <tr>
            <td align="left" valign="top" width="195px" height="100%">
                <div style="width: 190px; height: 100%; border: 1px solid #ccc;">
                    <iframe name="frmRoleChooseList" id="frmRoleChooseList" frameborder="0" style="width: 99%; height: 95%;"
                        src="ResourcePreItem.aspx"></iframe>
                </div>
            </td>
            <td align="left" valign="top">
                <div id="depUserList" style="overflow: auto;">
                    <div id="mycalendar"></div>
                    <!-- 新建日程窗口 -->
                    <div class="rhui-window" id="addCalendarWin" style="display: none;">
                        <div class="rhui-panel-body">
                            <table style="margin-left: 25px;">
                                <tr>
                                    <td class="field-label">生产班次：</td>
                                    <td>
                                        <%--<input class="rhui-field" name="title" type="text" />--%>
                                        <input type="text" id="txtClass" name="txtClass" class="rhui-field" style="width: 150px;" readonly="readonly" />
                                        <input id="button7" class="ButtonBox" type="button" onclick="openChoosePage(49,1)"
                                            value="..." title="选择班别" style="height: 24px; line-height: 24px; margin-bottom: 10px;" />
                                        <input id="hdclassId" type="hidden" name="hdClassId" value="-1" />
                                    </td>
                                </tr>
                                <%-- <tr>
                                    <td class="field-label">日程内容：</td>
                                    <td>
                                        <textarea class="rhui-field" name="content" style="height: 62px;"></textarea></td>
                                <--%>
                                <tr>
                                    <td class="field-label">开始时间：</td>
                                    <td>
                                        <input class="DateTimeBox" style="margin-bottom: 10px; width: 160px;" name="startTime" type="text" readonly="readonly" /></td>
                                </tr>
                                <tr>
                                    <td class="field-label">结束时间：</td>
                                    <td>
                                        <input class="DateTimeBox" style="margin-bottom: 10px; width: 160px;" name="endTime" type="text" readonly="readonly" /></td>
                                </tr>
                                   <tr>
                                    <td class="field-label">是否排班：</td>
                                    <td>
                                       周六: <input type="checkbox" class="CheckBox"  name="ckeBoxSaturd"  />&nbsp;&nbsp;&nbsp;
                                       周日: <input type="checkbox" class="CheckBox"  name="ckeBoxSunday"  />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- end 新建日程窗口 -->

                    <!-- 修改日程窗口 -->
                    <div class="rhui-window" id="editCalendarWin" style="display: none;">
                        <div class="rhui-panel-body">
                            <!-- 日程id -->
                            <input type="hidden" name="id" />
                            <table style="margin-left: 25px;">
                                <tr>
                                    <td class="field-label">生产班次：</td>
                                    <td>
                                        <input type="text" id="txtClass1" name="txtClass" class="rhui-field" style="width: 150px;" readonly="readonly" />
                                        <input id="button8" class="ButtonBox" type="button" style="height: 24px; line-height: 24px; margin-bottom: 10px;" onclick="openChoosePage(49,2)" value="..." title="选择班别" />
                                        <input id="hdclassId1" name="hdClassId" type="hidden" value="-1" />
                                    </td>
                                </tr>
                                <%--  <tr>
                                    <td class="field-label">日程内容：</td>
                                    <td>
                                        <textarea class="rhui-field" name="content" style="height: 62px;"></textarea></td>
                                <--%>
                                <tr>
                                    <td class="field-label">开始时间：</td>
                                    <td>
                                        <input class="DateTimeBox" style="margin-bottom: 10px; width: 160px;" name="startTime" type="text" readonly="readonly" /></td>
                                </tr>
                                <tr>
                                    <td class="field-label">结束时间：</td>
                                    <td>
                                        <input class="DateTimeBox" style="margin-bottom: 10px; width: 160px;" name="endTime" type="text" readonly="readonly" /></td>
                                </tr>
                                <tr>
                                    <td class="field-label">是否排班：</td>
                                    <td>
                                       周六: <input type="checkbox" class="CheckBox"  name="ckeBoxSaturd"  />&nbsp;&nbsp;&nbsp;
                                       周日: <input type="checkbox" class="CheckBox"  name="ckeBoxSunday"  />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
   <div class="pop" id="pop">
       <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 2px;"
        class="EditeContentTable">
          
            <tbody id="tblExpandBody"></tbody>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="8" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
             
          </table>
      <div id="triangle" class="triangle-bottom">
          
      </div>
    </div>
    <asp:HiddenField runat="server" ID="hdnOrganizationId" />
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnResourceId" value="-1" />
    <input type="hidden" id="hdnResName" value="-1" />
    <script type="text/javascript">



        function UpdateList(obj) {
            var id = $(obj).find("td:eq(0) input[type='checkbox']").val();
            var resName = $(obj).find("td:eq(1)").html();
          
            if ($(obj).find("td:eq(0) input[type='checkbox']").is(':checked')) {
                $("#hdnResourceId").val(id);
                $("#hdnResName").val(resName);
                var view = $('#mycalendar').fullCalendar('getView');
                var startTime = $.fullCalendar.formatDate(view.start, "yyyy-MM-dd");
                var endTime = $.fullCalendar.formatDate(view.end, "yyyy-MM-dd");

                GetLoadInfo(id, startTime, endTime);
            } else {
                $("#hdnResourceId").val(-1);
                $("#hdnResName").val("");
            }


        }

        function GetLoadInfo(lineId,start,end) {
            var nowDate=$.fullCalendar.formatDate(new Date(), "yyyy-MM-dd");
            var resultList = SKT.LeanMES.Web.Plan.ResourceCalendarList.GetList(lineId,start,end);
          
            $("#mycalendar").fullCalendar('removeEvents');
            var  data = resultList.value;
            for(var i=0;i<data.length;i++) {   
        
                var obj = new Object();    
                obj.id = data[i].Id+"-"+data[i].ShiftId;    
                obj.title = data[i].ShiftName;     
                obj.start = $.fullCalendar.parseDate(data[i].StartTime);                 
                obj.end = $.fullCalendar.parseDate(data[i].EndTime);
                obj.editable = true;
                
                if (nowDate == $.fullCalendar.formatDate(obj.start, "yyyy-MM-dd") || nowDate == $.fullCalendar.formatDate(obj.end, "yyyy-MM-dd")) {
                    obj.backgroundColor = '#EE3B3B';
                             
                } else {
                    obj.backgroundColor = '#4E8CD4';
                }
                       
                obj.textColor = 'white';
                obj.className = 'Ziti';

                $("#mycalendar").fullCalendar('renderEvent',obj,true);
            }
            /*
             * 描述：  解决因为mouseover导致的频繁闪烁的问题
             * 修改：  修改fullcalendar组件实例绑定的mouseover,mouseout事件为mouseenter,mouseleave
             * 备注：  最新fullcalendar已经使用mouseenter,mouseleave替代mouseover,mouseout事件组
             */
            var $event = $("#mycalendar").find(".fc-event");
            $event.each(function(i){
                var obj = data[i].Id + "-" + data[i].ShiftId;
                $(this).bind("mouseenter", obj, function (event) {
                    var idStr = event.data;
                    var id = idStr.split('-')[0];
                    var shiftId = idStr.split('-')[1];
                    show(event.originalEvent, shiftId);

                    event.stopPropagation();
                });
                $(this).bind("mouseleave", function (event) {
                    hiden();

                    event.stopPropagation();
                });
            });
        }
    </script>

    <script type="text/javascript">
        
   
        var selectRowClass = "selectRow";
        var tab = document.getElementById("tblExpandBody");
        function show(event, shiftId) {
            event = event || window.event;
            var pop = document.getElementById('pop');
            var x = 0, y = 0;
            var target = event.currentTarget;
            while (target.offsetParent !== null) {
                x += target.offsetTop;
                y += target.offsetLeft;
                target = target.offsetParent;
            }

            pop.style.display = 'block';
            pop.style.left = y - 25 + 'px';
            if (x - 100 - 100 < document.body.scrollTop) {
                document.getElementById('triangle').setAttribute('class', 'triangle-top');
                pop.style.top = x + 150 - document.body.scrollTop + 'px';
            } else {
                document.getElementById('triangle').setAttribute('class', 'triangle-bottom');
                pop.style.top = x - 100 - document.body.scrollTop + 'px';
            }

            var result = SKT.LeanMES.Web.AjaxServices.AjaxServicesShift.GetShiftList(shiftId);
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
            
            if (null != result) {
                var index = 1;
                $("#tblExpandBody ").html("");
                for (var i = 0; i < result.value.length; i++) {
                    addDetail(result.value[i], index);
                    index++;
                }
            }
        }

        function hiden() {
            var pop = document.getElementById('pop');
            pop.style.display = 'none';
        }

        function GetIndex() {
            var list = $(tab).find("tr");
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {

                    return i;
                }
            }
            return tab.rows.length;
        }

        function addDetail(entity) {
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = GetIndex();
          
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field112 pointer";
            cell.innerHTML = entity.ProductionShift;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field112 pointer";
           
            cell.innerHTML = entity.StartTime + "--" + entity.EndTime;
          
          
        }


        $(function() {
            FullCalendar();
        });

        function FullCalendar(){
            $('#mycalendar').fullCalendar({
                //日历初始化默认视图，可选agendaWeek、agendaDay、month
                defaultView: 'month',
				
                /*
                    设置日历头部信息
                    头部信息包括left、center、right三个位置，分别对应头部左边、头部中间和头部右边。
                    头部信息每个位置可以对应以下配置：
                        title: 显示当前月份/周/日信息
                        prev: 用于切换到上一月/周/日视图的按钮
                        next: 用于切换到下一月/周/日视图的按钮
                        prevYear: 用于切换到上一年视图的按钮
                        nextYear: 用于切换到下一年视图的按钮
                    如果不想显示头部信息，可以设置header为false
                */
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month'
                },
                //拖动事件 
                eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc,data) {
                    var idStr = event.id;
                    var id = idStr.split('-')[0];
                    var shiftId=idStr.split('-')[1];
                 
                    var entity = {};
                    entity.Id =id;
                    entity.ResourceId = parseInt($("#hdnResourceId").val());
                    entity.ShiftId =parseInt(shiftId);
                    var startTime = $.fullCalendar.formatDate(event.start,"yyyy-MM-dd");
                    var endTime = $.fullCalendar.formatDate(event.end,"yyyy-MM-dd");
                    entity.IsSaturd =1;    //周六是否排班
                    entity.IsSunday = 1;
                    entity.AllDay = true;
                    var result=  SKT.LeanMES.Web.Plan.ResourceCalendarList.Edit(entity,startTime,endTime);
               
                    if (result.error != null) {
                        $("#mycalendar").fullCalendar('refetchEvents');
                        alert(result.error.Message);

                        return;
                    }

                },
                //eventMouseover: function (event, jsEvent, view) {
                //    var idStr = event.id;
                //    var id = idStr.split('-')[0];
                //    var shiftId = idStr.split('-')[1];
                //    show(jsEvent, shiftId);
                //},
                //eventMouseout: function (event, jsEvent, view) {
                //    hiden();
                //},
                eventResize: function(event,dayDelta, jsEvent, ui, view) {
                    var idStr = event.id;
                    var id = idStr.split('-')[0];
                    var shiftId=idStr.split('-')[1];

                    var entity = { };
                    entity.Id =id;
                    entity.ResourceId = parseInt($("#hdnResourceId").val());
                    entity.ShiftId =parseInt(shiftId);
                    var startTime = $.fullCalendar.formatDate(event.start,"yyyy-MM-dd");
                    var endTime = $.fullCalendar.formatDate(event.end,"yyyy-MM-dd");
                    entity.IsSaturd =1;    //周六是否排班
                    entity.IsSunday = 1;
                    entity.AllDay = true;
                    var result= SKT.LeanMES.Web.Plan.ResourceCalendarList.Edit(entity,startTime,endTime);
                    if (result.error != null) {
                        $("#mycalendar").fullCalendar('refetchEvents');
                        alert(result.error.Message);
                        return;
                    }
                },
                //设置日历头部的日期格式
                titleFormat: {
                    month: 'yyyy年MM月',
                    week: 'yyyy年MM月dd日',
                    day: 'yyyy年MM月dd日 dddd'
                },
				
                //日历高度
                height: $(window).height() - 40,
				
                //显示周末，设为false则不显示周六和周日。
                weekends: true,
				
                /*
                    在月视图里显示周的模式，因为每月周数可能不同，所以月视图高度不一定。
                    fixed：固定显示6周高，日历高度保持不变
                    liquid：不固定周数，高度随周数变化
                    variable：不固定周数，但高度固定
                */
                weekMode: 'liquid',
				
                //日历上显示全天的文本
                allDayText: '全天',
				
                //允许用户通过单击或拖动选择日历中的对象，包括天和时间。
                selectable: true,
				
                //当点击或拖动选择时间时，显示默认加载的提示信息，该属性只在周/天视图里可用。
                selectHelper: true,
				
                //当点击页面日历以外的位置时，自动取消当前的选中状态。
                unselectAuto: true,
                viewDisplay: function(view) {    
                    //var viewStart = $.fullCalendar.formatDate(view.start,"yyyy-MM-dd");  
                    //var viewEnd = $.fullCalendar.formatDate(view.end,"yyyy-MM-dd");
                },  
                events: function(start, end, callback) {
                    var lineId= $("#hdnResourceId").val();
                    var viewStart = $.fullCalendar.formatDate(start,"yyyy-MM-dd");  
                    var viewEnd = $.fullCalendar.formatDate(end,"yyyy-MM-dd");
                    
                    if (lineId != -1) {
                        GetLoadInfo(lineId,viewStart,viewEnd);
                    }
                    
                },
                /*
                events: {
                    url: '',
                    type: 'post'
                },
                */
				
                /*
                    添加日程事件
                    start: 被选中区域的开始时间
                    end: 被选中区域的结束时间
                    jsEvent: jascript对象
                    view: 当前视图对象
                */
                select: function(start, end, jsEvent, view){
                    //添加日程事件
                    var $win = $('#addCalendarWin');
                    var lineId= $("#hdnResourceId").val();
                    if (lineId == -1) {
                        alert("请选择资源");
                        return;
                    }
                    $win.find('input[name="startTime"]').val($.fullCalendar.formatDate(start,"yyyy-MM-dd"));
                    $win.find('input[name="endTime"]').val($.fullCalendar.formatDate(end,"yyyy-MM-dd"));
                    $win.rhui('window').show();
                },

                /*
                    修改日程事件
                    当点击日历中的某一日程时，触发此事件
                    data: 日程信息
                    jsEvent: jascript对象
                    view: 当前视图对象
                */
                eventClick: function(data, jsEvent, view){
                    //修改日程事件
                    var $win = $('#editCalendarWin');
                   
                    //var resultInfo=SKT.LeanMES.Web.Plan.ResourceCalendarList.GetScheduleRecordInfo(data.id).value;
                    //alert("ShiftId:"+resultInfo.ShiftId);
                   
                    //$("#hdclassId1").val(resultInfo.ShiftId);
                    $win.find('input[name="id"]').val(data.id);
                    $win.find('input[name="txtClass"]').val(data.title);
                    $win.find('input[name="hdClassId"]').val(data.Shi);
                    $win.find('textarea[name="content"]').val(data.cntent);
                    $win.find('input[name="startTime"]').val($.fullCalendar.formatDate(data.start,"yyyy-MM-dd"));
                    $win.find('input[name="endTime"]').val($.fullCalendar.formatDate(data.end,"yyyy-MM-dd"));
                 
                    $win.rhui('window').show();
                }
            });
			
            //初始化新建日程窗口
            (function(){
                var $win = $('#addCalendarWin');
                $win.rhui('window', {
                    title: '新建日程',
                    width: 400,
                    height: 265,
                    buttons: [{
                        text: '确定',
                        cls: 'rhui-btn-primary',
                        click: function(toolbar, win) {
                            var entity = {};
                            entity.Id = -1;
                            entity.ResourceId = parseInt($("#hdnResourceId").val());
                            entity.ShiftId =parseInt($win.find('input[name="hdClassId"]').val());
                            
                            var startTime = $win.find('input[name="startTime"]').val();
                            var endTime = $win.find('input[name="endTime"]').val();
                            entity.IsSaturd = $win.find('input[name="ckeBoxSaturd"]').is(":checked")?1:0;    //周六是否排班
                            entity.IsSunday = $win.find('input[name="ckeBoxSunday"]').is(":checked")?1:0;
                           
                            entity.AllDay = true;    //全天
						    
                            if ($win.find('input[name="txtClass"]').val() == "") {
                                alert("请选择生产班次");
                                return;
                            }
                          

                            var result=SKT.LeanMES.Web.Plan.ResourceCalendarList.Edit(entity,startTime,endTime);
                            if (result.error != null) {
                                alert(result.error.Message);
                                return;
                            }
                            $("#mycalendar").fullCalendar('refetchEvents');
                            $("#txtClass").val("");
                            $("#hdclassId").val(-1);
                            alert('日程已新建');
                            win.hide();
                        }
                    },{
                        text: '取消',
                        click: function(toolbar, win){
                            win.hide();
                        }
                    }]
                }).hide();				
            })();
			
            //初始化修改日程窗口
            (function(){
                var $win = $('#editCalendarWin');
               
                ////初始化日期控件
                //$win.find('input[name="startTime"]').datetimepicker({format: 'Y-m-d'});
                //$win.find('input[name="endTime"]').datetimepicker({format: 'Y-m-d'});
				
                $win.rhui('window', {
                    title: '修改日程',
                    width: 400,
                    height: 265,
                    buttons: [{
                        text: '确定',
                        cls: 'rhui-btn-primary',
                        click: function(toolbar, win) {
                            var idStr = $win.find('input[name="id"]').val();
                          
                          
                            var id = idStr.split('-')[0];
                            var shiftId;
                            if ($win.find('input[name="hdClassId"]').val() == "") {
                                shiftId = idStr.split('-')[1];
                            } else {
                                shiftId = $win.find('input[name="hdClassId"]').val();
                            }
                           
                            var entity = {};
                            entity.Id =id;
                            entity.ResourceId = parseInt($("#hdnResourceId").val());
                            entity.ShiftId =parseInt(shiftId);
                            var startTime = $win.find('input[name="startTime"]').val();
                            var endTime = $win.find('input[name="endTime"]').val();
                            entity.IsSaturd = $win.find('input[name="ckeBoxSaturd"]').is(":checked")?1:0;    //周六是否排班
                            entity.IsSunday = $win.find('input[name="ckeBoxSunday"]').is(":checked")?1:0;
                            entity.AllDay = true;
                            var result=SKT.LeanMES.Web.Plan.ResourceCalendarList.Edit(entity,startTime,endTime);
                            if (result.error != null) {
                                alert(result.error.Message);
                                return;
                            }
                            $("#mycalendar").fullCalendar('refetchEvents');
                            $("#txtClass1").val("");
                            $("#hdclassId1").val(-1);
                          
                            win.hide();
                            alert('日程已修改');
                        }
                    },{
                        text: '删除',
                        cls: 'rhui-btn-danger',
                        click: function(toolbar, win){
                            var result=SKT.LeanMES.Web.Plan.ResourceCalendarList.Delete($win.find('input[name="id"]').val().split('-')[0]);
                            if (result.error != null) {
                                alert(result.error.Message);
                                return;
                            }
                            $("#mycalendar").fullCalendar('refetchEvents');
                            win.hide();
                        }
                    },{
                        text: '取消',
                        click: function(toolbar, win){
                            win.hide();
                        }
                    }]
                }).hide();
            })();
        }
        var isAdd = 1;
        var globalFlag = 0;
        function openChoosePage(flags,obj) {
            var condition = "";
            globalFlag = flags;
            isAdd = obj;

            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags +
                    "&Multiple=false&PageCondition=" +
                    escape(condition) +"&callBackFunc=getChooseValue1"+
                    "&rnd=" +
                    Math.random(),
                width: 400,
                height: 300
            });

        }

        function getChooseValue1(list) {
            switch (globalFlag) {
            case 49: //选择班别
                if (isAdd == 1) {
                    $("#txtClass").val(list[0][1]);
                    $("#hdclassId").val(list[0][0]);
               
                } else {
                    $("#txtClass1").val(list[0][1]);
                    $("#hdclassId1").val(list[0][0]);
                }
                break;
            }
        }

        function Copy() {
            var id=$("#hdnResourceId").val();
            if (id == "-1") {
                alert("请选择记录");
                return;
            }  
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/ResourceCalendarCopy.aspx?ResName="+$("#hdnResName").val()+"&ID=" + $("#hdnResourceId").val(); 
            dialog({ title: "复制资源日历 ", src: openWinUrl, width: 500, height: 320 });

       
        }
    </script>
    <style type="text/css">
		#mycalendar{
			display: block;
			position: relative;
			width: 900px;
			margin: 15px auto;
			padding: 0;
		}
		
		.fc button{
			height: 27px;
		}
		
		.fc-center>h2{
			font-size: 20px;
			line-height: 27px;
		}
		
		.fc-unthemed .fc-divider, .fc-unthemed .fc-popover, .fc-unthemed .fc-row, .fc-unthemed tbody, .fc-unthemed td, .fc-unthemed th, .fc-unthemed thead{
			border-color: #bed5f3;
		}
		
		.fc-unthemed .fc-divider, .fc-unthemed .fc-popover .fc-header,.fc-widget-header,.fc-axis{
			background-color: #e5effe;
		}
		
		.fc th, .fc td{
			font-size: 14px;
			line-height: 25px;
		}
		
		.rhui-field{
			width: 200px;
			margin-bottom: 10px;
		}
		
		.field-label{
			width: 70px;
			line-height: 23px;
			vertical-align: top;
		}
        .Ziti {
        line-height:280%;
            font-size:16px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
        }
	</style>

</asp:Content>

<%--<script src='../lib/jquery/jquery-1.11.2.min.js'></script>
	
	<!-- 
		日期控件
		http://xdsoft.net/jqplugins/datetimepicker/
	 -->
	<link href='../lib/datetimepicker/jquery.datetimepicker.css' rel='stylesheet' type="text/css" />
	<script src='../lib/datetimepicker/jquery.datetimepicker.js'></script>	
	
	<!-- 日程管理样式及JS -->
	<link href='../lib/fullcalendar/fullcalendar.css' rel='stylesheet' type="text/css" />
	<script src='../lib/fullcalendar/lib/moment.min.js'></script>	
	<script src='../lib/fullcalendar/fullcalendar.min.js'></script>	
	<script src='../lib/fullcalendar/lang/zh-cn.js'></script>
	
	<!-- 
		rhui
		http://git.oschina.net/accountwcx/rhui
	-->
	<link href='../lib/rhui/css/rhui.css' rel='stylesheet' type="text/css" />
	<script src='../lib/rhui/rhui-all.js'></script>
--%>
	


