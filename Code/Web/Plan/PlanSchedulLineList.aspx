<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/MastersNoCss.master"  CodeBehind="PlanSchedulLineList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.PlanSchedulLineList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../Content/guant/platform.css" type="text/css">
    <link rel="stylesheet" href="../Content/guant/libs/jquery/dateField/jquery.dateField.css" type="text/css">
    <link href="../Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../Content/guant/gantt.css" type="text/css">
    <link rel="stylesheet" href="../Content/guant/ganttPrint.css" type="text/css" media="print">
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/jquery.min.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/jquery-ui.min.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/jquery/jquery.livequery.1.1.1.min.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/jquery/jquery.timers.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/utilities.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/forms.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/date.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/dialogs.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/layout.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/i18nJs.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/jquery/dateField/jquery.dateField.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/guant/libs/jquery/JST/jquery.JST.js"></script>

    <script type="text/javascript" src="../Content/guant/libs/jquery/svg/jquery.svg.min.js"></script>
    <script type="text/javascript" src="../Content/guant/libs/jquery/svg/jquery.svgdom.1.8.js"></script>


    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-ui.min.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/js/jPlugin-dialog-2.0.js?v=160624"
        type="text/javascript"></script>

    <script  type="text/javascript" src="../Content/guant/ganttUtilities.js"></script>
    <script  type="text/javascript" src="../Content/guant/ganttTask.js"></script>
    <script  type="text/javascript" src="../Content/guant/ganttDrawerSVG.js"></script>
    <script  type="text/javascript" src="../Content/guant/ganttZoom.js"></script>
    <script  type="text/javascript" src="../Content/guant/ganttGridEditor.js"></script>
    <script  type="text/javascript" src="../Content/guant/ganttMaster.js"></script>


    <style type="text/css">
        .EditeContentTable, .ContentTable {
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
        }

        .Label3 {
            width: 10%;
            height: 26px;
            text-align: right;
            background-color: #f7f7f7;
            padding: 3px;
            border-top: 1px solid #d3d3d3;
            border-left: 1px solid #d3d3d3;
            border-right: 1px solid #d3d3d3;
            border-bottom: 1px solid #d3d3d3;
        }

        .Field3 {
            width: 23.3%;
            height: 26px;
            text-align: left;
            background-color: #fff;
            padding: 3px;
            border-top: 1px solid #d3d3d3;
            border-left: 1px solid #d3d3d3;
            border-right: 1px solid #d3d3d3;
            border-bottom: 1px solid #d3d3d3;
            word-break: break-all;
        }

        input[type='button'].ButtonBox:hover {
            cursor: pointer;
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
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<table class="EditeContentTable" style="width: 100%; margin: 2px;">
    <tr>
        <td id="Td1" class="Label3"><select id="selType" style="font-size:12px">
                <option value="1">资源名称</option>
                <option value="2">车间名称</option>
                <option value="3">工厂名称</option>
            </select>
        </td>
        <td class="Field3">
            <input type="text" id="txtLineName" class="TextBox" /><input type="button" id="bnOper"
                                                                        class="ButtonBox" onclick="openChoosePage()" value="..." />
        </td>
        <td class="Label3">计划开始时间
        </td>
        <td class="Field3">
            <input type="text" id="txtStartTime" style="width: 40%;font-size:12px" class="DateTimeBox" />~ <input type="text" id="txtEndTime" style="width: 40%;font-size:12px" class="DateTimeBox" />
            &nbsp;&nbsp;&nbsp;<img id="repairTimeClear"  style="cursor: pointer;" onclick="clearTime(this)" title="点击清除日期" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==" />


        </td>
        <td>
            <div id="bnView" style="font-size: 16px; width: 80px; cursor: pointer; float: left; margin-left: 40%; text-decoration: underline;">
                <img src="../Content/images/search.png" /><span>查询</span>
            </div>
             <div id="bnImport" style="font-size: 16px; cursor: pointer; text-decoration: underline;
	                    float: left; margin-left: 10px;width:150px;">
	                    <img src="../Content/images/icon/Import.png" /><span>导出到EXCEL</span></div> 
        </td>
    </tr>


</table>


<div id="workSpace" style="padding:0px; overflow-y:auto; overflow-x:hidden;border:1px solid #e5e5e5;position:relative;margin:0 5px"></div>

<style>
    .resEdit {
        padding: 15px;
    }

    .resLine {
        width: 95%;
        padding: 3px;
        margin: 5px;
        border: 1px solid #d0d0d0;
    }

    body {
        overflow: hidden;
    }

    .ganttButtonBar h1{
        color: #000000;
        font-weight: bold;
        font-size: 28px;
        margin-left: 10px;
    }

</style>
<iframe id="ifile" style="display: none"></iframe>
<form id="gimmeBack" style="display:none;" action="../gimmeBack.jsp" method="post" target="_blank"><input type="hidden" name="prj" id="gimBaPrj"></form>

<script type="text/javascript">
    var _close = "<%=Resources.Common.Close %>";
    var _resizewin = "<%=Resources.lang.ResizeWin %>";
    var _dialogwin = "<%=Resources.lang.PopWin %>";
    var _help = "<%=Resources.Common.Help %>";
    var _dataLoading = "<%=Resources.Messages.DataLoading %>";
    var printInProcess = "<%=Resources.Messages.PrintInProcess %>";
    var NoLabelTemplate = "<%=Resources.Messages.NoLabelTemplate %>";
var ge;
$(function () {
    $("#txtStartTime").val(GetDateStr(-1));
    $("#txtEndTime").val(GetDateStr(30));
  var canWrite=false; //this is the default for test purposes
  $("#bnView").bind("click", function () {
      getLineProject();
  });
  $("#bnImport").bind("click", function () {
      var type = $("#selType").val();
      var txtLineName = $("#txtLineName").val();
      var startDate = $("#txtStartTime").val();
      var endDate = $("#txtEndTime").val();
      var dom = document.getElementById('ifile');
      dom.src = "../Handler/GANT_MSTServer.ashx?action=GetProjectLineExcel&name=" + txtLineName + "&type=" + type + "&startDate=" + startDate + "&endDate=" + endDate;;
  });
  // here starts gantt initialization
  ge = new GanttMaster();
  ge.set100OnClose=true;
  ge.shrinkParent=true;

  ge.init($("#workSpace"));
  loadI18n(); //overwrite with localized ones
  //in order to force compute the best-fitting zoom level
   delete ge.gantt.zoom;
   


});
var flags = 6;
function openChoosePage() {
   
    var type = $("#selType").val();
    if (type == 2) {
        flags = 122;
    }else if (type == 3) {
        flags = 47;
    } else {
        flags = 6;
    }
    var condition = "";
    dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
}
function getChooseValue(list) {
    if (flags == 47) {
        $("#txtLineName").val(list[0][2]);
    } else {
        $("#txtLineName").val(list[0][1]);
    }
    
}
/*清除日期*/
function clearTime(obj) {
        if (obj.id == "timeClear") {
            $("#txtStartTime").val("");
            $("#txtEndTime").val("");
        }
        else if (obj.id == "repairTimeClear") {
            $("#txtStartTime").val("");
            $("#txtEndTime").val("");
        }
    }

function getLineProject() {
         var type = $("#selType").val();
         var txtLineName = $("#txtLineName").val();
        var startDate = $("#txtStartTime").val();
      var endDate = $("#txtEndTime").val();
        $.ajax({
            url: "../Handler/GANT_MSTServer.ashx",
            type: "get",
            data: {
                action: "GetProjectLine",
                name: txtLineName,
                type: type,
                startDate: startDate,
                endDate: endDate
            },
            async: false,
            success: function(msg) {
                if (msg.Statue == "ok") {
                    ret = JSON.parse(msg.Data);
                }
            }
        });
        if (!ret.canWrite)
            $(".ganttButtonBar button.requireWrite").attr("disabled", "true");
        ge.loadProject(ret);
        ge.checkpoint(); //empty the undo stack
}

function saveGanttOnServer() {
  saveInLocalStorage();
}

function newProject(){
  clearGantt();
}


function clearGantt() {
  ge.reset();
}

function getFile() {
  $("#gimBaPrj").val(JSON.stringify(ge.saveProject()));
  $("#gimmeBack").submit();
  $("#gimBaPrj").val("");
}

function saveInLocalStorage() {
  var prj = ge.saveProject();
  alert(JSON.stringify(prj));
  if (localStorage) {
    localStorage.setObject("teamworkGantDemo", prj);
  }
}


//-------------------------------------------  Open a black popup for managing resources. This is only an axample of implementation (usually resources come from server) ------------------------------------------------------
function editResources(){


  var resourceEditor = $.JST.createFromTemplate({}, "RESOURCE_EDITOR");
  var resTbl=resourceEditor.find("#resourcesTable");

  for (var i=0;i<ge.resources.length;i++){
    var res=ge.resources[i];
    resTbl.append($.JST.createFromTemplate(res, "RESOURCE_ROW"))
  }


  //bind add resource
  resourceEditor.find("#addResource").click(function(){
    resTbl.append($.JST.createFromTemplate({id:"new",name:"resource"}, "RESOURCE_ROW"))
  });

  //bind save event
  resourceEditor.find("#resSaveButton").click(function(){
    var newRes=[];
    //find for deleted res
    for (var i=0;i<ge.resources.length;i++){
      var res=ge.resources[i];
      var row = resourceEditor.find("[resId="+res.id+"]");
      if (row.length>0){
        //if still there save it
        var name = row.find("input[name]").val();
        if (name && name!="")
          res.name=name;
        newRes.push(res);
      } else {
        //remove assignments
        for (var j=0;j<ge.tasks.length;j++){
          var task=ge.tasks[j];
          var newAss=[];
          for (var k=0;k<task.assigs.length;k++){
            var ass=task.assigs[k];
            if (ass.resourceId!=res.id)
              newAss.push(ass);
          }
          task.assigs=newAss;
        }
      }
    }

    //loop on new rows
    var cnt=0
    resourceEditor.find("[resId=new]").each(function(){
      cnt++;
      var row = $(this);
      var name = row.find("input[name]").val();
      if (name && name!="")
        newRes.push (new Resource("tmp_"+new Date().getTime()+"_"+cnt,name));
    });

    ge.resources=newRes;

    closeBlackPopup();
    ge.redraw();
  });


  var ndo = createModalPopup(400, 500).append(resourceEditor);
}


function showBaselineInfo (event,element){
  //alert(element.attr("data-label"));
  $(element).showBalloon(event, $(element).attr("data-label"));
  ge.splitter.secondBox.one("scroll",function(){
    $(element).hideBalloon();
  })
}

</script>





<div id="gantEditorTemplates" style="display:none;">
<!-- 操作按扭 -->
<div class="__template__" type="GANTBUTTONS"><!--
  <div class="ganttButtonBar noprint">
    <div class="buttons">
      <button onclick="$('#workSpace').trigger('undo.gantt');return false;" class="button textual icon requireCanWrite" title="撤销"><span class="teamworkIcon">&#39;</span></button>
      <button onclick="$('#workSpace').trigger('redo.gantt');return false;" class="button textual icon requireCanWrite" title="回到撤销前"><span class="teamworkIcon">&middot;</span></button>
      <span class="ganttButtonSeparator requireCanWrite requireCanAdd"></span>
      <button onclick="$('#workSpace').trigger('addAboveCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanAdd" title="上面插入一行"><span class="teamworkIcon">l</span></button>
      <button onclick="$('#workSpace').trigger('addBelowCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanAdd" title="下面插入一行"><span class="teamworkIcon">X</span></button>
      <span class="ganttButtonSeparator requireCanWrite requireCanInOutdent"></span>
      <button onclick="$('#workSpace').trigger('outdentCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanInOutdent" title="任务升级"><span class="teamworkIcon">.</span></button>
      <button onclick="$('#workSpace').trigger('indentCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanInOutdent" title="任务降级"><span class="teamworkIcon">:</span></button>
      <span class="ganttButtonSeparator requireCanWrite requireCanMoveUpDown"></span>
      <button onclick="$('#workSpace').trigger('moveUpCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanMoveUpDown" title="任务上移"><span class="teamworkIcon">k</span></button>
      <button onclick="$('#workSpace').trigger('moveDownCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanMoveUpDown" title="任务下移"><span class="teamworkIcon">j</span></button>
      <span class="ganttButtonSeparator requireCanWrite requireCanDelete"></span>
      <button onclick="$('#workSpace').trigger('deleteFocused.gantt');return false;" class="button textual icon delete requireCanWrite" title="删除任务"><span class="teamworkIcon">&cent;</span></button>
      <span class="ganttButtonSeparator"></span>
      <button onclick="$('#workSpace').trigger('expandAll.gantt');return false;" class="button textual icon " title="展开子任务"><span class="teamworkIcon">6</span></button>
      <button onclick="$('#workSpace').trigger('collapseAll.gantt'); return false;" class="button textual icon " title="关闭子任务"><span class="teamworkIcon">5</span></button>

    <span class="ganttButtonSeparator"></span>
      <button onclick="$('#workSpace').trigger('zoomMinus.gantt'); return false;" class="button textual icon " title="宏观展示"><span class="teamworkIcon">)</span></button>
      <button onclick="$('#workSpace').trigger('zoomPlus.gantt');return false;" class="button textual icon " title="微观展示"><span class="teamworkIcon">(</span></button>
    <span class="ganttButtonSeparator"></span>
      <button onclick="$('#workSpace').trigger('print.gantt');return false;" class="button textual icon " title="打印"><span class="teamworkIcon">p</span></button>
    <span class="ganttButtonSeparator"></span>
      <button onclick="ge.gantt.showCriticalPath=!ge.gantt.showCriticalPath; ge.redraw();return false;" class="button textual icon requireCanSeeCriticalPath" title="关键任务"><span class="teamworkIcon">&pound;</span></button>
    <span class="ganttButtonSeparator requireCanSeeCriticalPath"></span>
      <button onclick="ge.splitter.resize(.1);return false;" class="button textual icon" title="仅图形展示"><span class="teamworkIcon">F</span></button>
      <button onclick="ge.splitter.resize(50);return false;" class="button textual icon" title="同时展示"><span class="teamworkIcon">O</span></button>
      <button onclick="ge.splitter.resize(100);return false;" class="button textual icon" title="仅文字展示"><span class="teamworkIcon">R</span></button>
      <span class="ganttButtonSeparator"></span>
      <button onclick="$('#workSpace').trigger('fullScreen.gantt');return false;" class="button textual icon" title="FULLSCREEN" id="fullscrbtn"><span class="teamworkIcon">@</span></button>

      &nbsp; &nbsp; &nbsp; &nbsp;
  
    <button class="button login" title="login/enroll" onclick="loginEnroll($(this));" style="display:none;">login/enroll</button>
    <button class="button opt collab" title="Start with Twproject" onclick="collaborate($(this));" style="display:none;"><em>collaborate</em></button>
    </div></div>
  --></div>
<!-- 表格标题 -->
<div class="__template__" type="TASKSEDITHEAD">
  <table class="gdfTable" cellspacing="0" cellpadding="0">
    <thead>
    <tr style="height:40px">
      <th class="gdfColHeader" style="width:35px;"></th>

    
      <th class="gdfColHeader gdfResizable" style="width:250px;">资源名称/排产号</th>
        <th class="gdfColHeader gdfResizable" style="width:110px;">工单</th>
        <th class="gdfColHeader gdfResizable" style="width:100px;">排产数量</th>
       <%-- <th class="gdfColHeader gdfResizable" style="width:90px;">开始时间</th>
        <th class="gdfColHeader gdfResizable" style="width:90px;">结束时间</th>--%>
        <th class="gdfColHeader gdfResizable" style="width:140px;">计划开始时间</th>
        <th class="gdfColHeader gdfResizable" style="width:140px;">计划完成时间</th>
      <th class="gdfColHeader gdfResizable" style="width:50px;">天数</th>
      <th class="gdfColHeader gdfResizable" style="width:100px;">生产进度(%)</th>
      <th class="gdfColHeader gdfResizable requireCanSeeDep" style="width:1000px;padding-left: 10px; text-align: left;margin-left:10px;">状态</th>
   
      
    </tr>
    </thead>
  </table>
  </div>
<!-- 表格内容 -->
<div class="__template__" type="TASKROW"><!--
  <tr id="tid_(#=obj.id#)" taskId="(#=obj.id#)" class="taskEditRow (#=obj.isParent()?'isParent':''#) (#=obj.collapsed?'collapsed':''#)" level="(#=level#)">
    <th class="gdfCell edit" align="center" style="cursor:pointer;"><span class="taskRowIndex">(#=obj.getRow()+1#)</span> <span class="teamworkIcon" style="font-size:12px;" >e</span></th>

  
    <td class="gdfCell indentCell" style="padding-left:(#=obj.level*10+18#)px;">
      <div class="exp-controller" align="center"></div>
      <input type="text" name="name" value="(#=obj.name#)" placeholder="name">
    </td>
      <td class="gdfCell"><input type="text" name="code" style="text-align:  center;" value="(#=obj.code?obj.code:''#)" placeholder="" ></td>
      <td class="gdfCell"><input type="text" style="text-align:  center;" name="planNum" value="(#=obj.description?obj.description:''#)" placeholder="排产数量"></td>

      <td class="gdfCell"><input type="text" name="startDate" style="text-align:  center;"  value=""></td>
      <td class="gdfCell"><input type="text" name="endDate" style="text-align:  center;" value="" ></td>
    <td class="gdfCell"><input type="text" style="text-align:  center;" name="duration" autocomplete="off" value="(#=obj.duration#)"></td>
    <td class="gdfCell" align="right"><input type="text" style="text-align:  center;" name="progress" class="validated" entrytype="PERCENTILE" autocomplete="off" value="(#=obj.progress?obj.progress:''#)" (#=obj.progressByWorklog?"readOnly":""#)></td>
    <td class="gdfCell requireCanSeeDep"><input type="text" style="text-align:  left;margin-left:10px;" name="depends" autocomplete="off" value="(#=obj.depends#)" (#=obj.hasExternalDep?"readonly":""#)></td>
   
   
  </tr>
  --></div>

<div class="__template__" type="TASKEMPTYROW"><!--
  <tr class="taskEditRow emptyRow" >
    <th class="gdfCell" align="center"></th>

    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell requireCanSeeDep"></td>
   
  </tr>
  --></div>

<div class="__template__" type="TASKBAR"><!--
  <div class="taskBox taskBoxDiv" taskId="(#=obj.id#)" >
    <div class="layout (#=obj.hasExternalDep?'extDep':''#)">
      <div class="taskStatus" status="(#=obj.status#)"></div>
      <div class="taskProgress" style="width:(#=obj.progress>100?100:obj.progress#)%; background-color:(#=obj.progress>100?'red':'rgb(153,255,51);'#);"></div>
      <div class="milestone (#=obj.startIsMilestone?'active':''#)" ></div>

      <div class="taskLabel"></div>
      <div class="milestone end (#=obj.endIsMilestone?'active':''#)" ></div>
    </div>
  </div>
  --></div>


<div class="__template__" type="CHANGE_STATUS"><!--
    <div class="taskStatusBox">
    <div class="taskStatus cvcColorSquare" status="STATUS_WAITING" title="等待"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_ACTIVE" title="进行中"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_SUSPENDED" title="暂停"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_DONE" title="完成"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_UNDEFINED" title="延期"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_FAILED" title="失败"></div>
    </div>
  --></div>




<div class="__template__" type="TASK_EDITOR"><!--
  <div class="ganttTaskEditor">
    <h2 class="taskData">编辑任务</h2>
    <table  cellspacing="1" cellpadding="5" width="100%" class="taskData table" border="0">
          <tr>
        <td width="200" style="height: 80px"  valign="top">
          <label for="code">资源</label><br>
          <input type="text" name="code" id="code" value="" size=15 class="formElements" autocomplete='off' maxlength=255 style='width:100%' oldvalue="1">
        </td>
        <td colspan="3" valign="top"><label for="name" class="required">任务名称</label><br><input type="text" name="name" id="name"class="formElements" autocomplete='off' maxlength=255 style='width:100%' value="" required="true" oldvalue="1"></td>
          </tr>


      <tr class="dateRow">
        <td nowrap="">
          <div style="position:relative">
            <label for="start">开始时间</label>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="checkbox" id="startIsMilestone" name="startIsMilestone" value="yes"> &nbsp;<label for="startIsMilestone">里程碑</label>&nbsp;
            <br><input type="text" name="start" id="start" size="8" class="formElements dateField validated date" autocomplete="off" maxlength="255" value="" oldvalue="1" entrytype="DATE">
            <span title="calendar" id="starts_inputDate" class="teamworkIcon openCalendar" onclick="$(this).dateField({inputField:$(this).prevAll(':input:first'),isSearchField:false});">m</span>          </div>
        </td>
        <td nowrap="">
          <label for="end">结束时间</label>&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="checkbox" id="endIsMilestone" name="endIsMilestone" value="yes"> &nbsp;<label for="endIsMilestone">里程碑</label>&nbsp;
          <br><input type="text" name="end" id="end" size="8" class="formElements dateField validated date" autocomplete="off" maxlength="255" value="" oldvalue="1" entrytype="DATE">
          <span title="calendar" id="ends_inputDate" class="teamworkIcon openCalendar" onclick="$(this).dateField({inputField:$(this).prevAll(':input:first'),isSearchField:false});">m</span>
        </td>
        <td nowrap="" >
          <label for="duration" class=" ">工期</label><br>
          <input type="text" name="duration" id="duration" size="4" class="formElements validated durationdays" title="Duration is in working days." autocomplete="off" maxlength="255" value="" oldvalue="1" entrytype="DURATIONDAYS">&nbsp;
        </td>
      </tr>

      <tr>
        <td  colspan="2">
          <label for="status" class=" ">状态</label><br>
          <select id="status" name="status" class="taskStatus" status="(#=obj.status#)"  onchange="$(this).attr('STATUS',$(this).val());">
            <option value="STATUS_WAITING" class="taskStatus" status="STATUS_WAITING" >等待</option>
            <option value="STATUS_ACTIVE" class="taskStatus" status="STATUS_ACTIVE" >进行中</option>
            <option value="STATUS_SUSPENDED" class="taskStatus" status="STATUS_SUSPENDED" >暂停</option>
            <option value="STATUS_DONE" class="taskStatus" status="STATUS_DONE" >完成</option>
            <option value="STATUS_UNDEFINED" class="taskStatus" status="STATUS_UNDEFINED" >延期</option>
            <option value="STATUS_FAILED" class="taskStatus" status="STATUS_FAILED" >失败</option>
          </select>
        </td>

        <td valign="top" nowrap>
          <label>进度</label><br>
          <input type="text" name="progress" id="progress" size="7" class="formElements validated percentile" autocomplete="off" maxlength="255" value="" oldvalue="1" entrytype="PERCENTILE">
        </td>
      </tr>

          </tr>
          <tr>
            <td colspan="4">
              <label for="description">描述</label><br>
              <textarea rows="3" cols="30" id="description" name="description" class="formElements" style="width:100%"></textarea>
            </td>
          </tr>
        </table>

    <h2>资源分配</h2>
  <table  cellspacing="1" cellpadding="0" width="100%" id="assigsTable">
    <tr>
      <th style="width:100px;">姓名</th>
      <th style="width:70px;">角色</th>
      <th style="width:30px;">预计工作时间（小时）</th>
      <th style="width:30px;" id="addAssig"><span class="teamworkIcon" style="cursor: pointer">+</span></th>
    </tr>
  </table>

  <div style="text-align: right; padding-top: 20px">
    <span id="saveButton" class="button" onClick="$(this).trigger('saveFullEditor.gantt');">保存</span>
  </div>

  </div>
  --></div>



<div class="__template__" type="ASSIGNMENT_ROW"><!--
  <tr taskId="(#=obj.task.id#)" assId="(#=obj.assig.id#)" class="assigEditRow" >
    <td ><select name="resourceId"  class="formElements" (#=obj.assig.id.indexOf("tmp_")==0?"":"disabled"#) ></select></td>
    <td ><select type="select" name="roleId"  class="formElements"></select></td>
    <td ><input type="text" name="effort" value="(#=getMillisInHoursMinutes(obj.assig.effort)#)" size="5" class="formElements"></td>
    <td align="center"><span class="teamworkIcon delAssig del" style="cursor: pointer">d</span></td>
  </tr>
  --></div>



<div class="__template__" type="RESOURCE_EDITOR"><!--
  <div class="resourceEditor" style="padding: 5px;">

    <h2>项目参与人员</h2>
    <table  cellspacing="1" cellpadding="0" width="100%" id="resourcesTable">
      <tr>
        <th style="width:100px;">名称</th>
        <th style="width:30px;" id="addResource"><span class="teamworkIcon" style="cursor: pointer">+</span></th>
      </tr>
    </table>

    <div style="text-align: right; padding-top: 20px"><button id="resSaveButton" class="button big">保存</button></div>
  </div>
  --></div>



<div class="__template__" type="RESOURCE_ROW"><!--
  <tr resId="(#=obj.id#)" class="resRow" >
    <td ><input type="text" name="name" value="(#=obj.name#)" style="width:100%;" class="formElements"></td>
    <td align="center"><span class="teamworkIcon delRes del" style="cursor: pointer">d</span></td>
  </tr>
  --></div>


</div>
<script type="text/javascript">
  $.JST.loadDecorator("RESOURCE_ROW", function(resTr, res){
    resTr.find(".delRes").click(function(){$(this).closest("tr").remove()});
  });

  $.JST.loadDecorator("ASSIGNMENT_ROW", function(assigTr, taskAssig){
    var resEl = assigTr.find("[name=resourceId]");
    var opt = $("<option>");
    resEl.append(opt);
    for(var i=0; i< taskAssig.task.master.resources.length;i++){
      var res = taskAssig.task.master.resources[i];
      opt = $("<option>");
      opt.val(res.id).html(res.name);
      if(taskAssig.assig.resourceId == res.id)
        opt.attr("selected", "true");
      resEl.append(opt);
    }
    var roleEl = assigTr.find("[name=roleId]");
    for(var i=0; i< taskAssig.task.master.roles.length;i++){
      var role = taskAssig.task.master.roles[i];
      var optr = $("<option>");
      optr.val(role.id).html(role.name);
      if(taskAssig.assig.roleId == role.id)
        optr.attr("selected", "true");
      roleEl.append(optr);
    }

    if(taskAssig.task.master.permissions.canWrite && taskAssig.task.canWrite){
      assigTr.find(".delAssig").click(function(){
        var tr = $(this).closest("[assId]").fadeOut(200, function(){$(this).remove()});
      });
    }

  });


  function loadI18n(){
    GanttMaster.messages = {
      "CANNOT_WRITE":"不能编辑:",
      "CHANGE_OUT_OF_SCOPE":"不能编辑，因为依赖的父任务未更新",
      "START_IS_MILESTONE":"开始日期是一个里程碑",
      "END_IS_MILESTONE":"结束日期是一个里程碑",
      "TASK_HAS_CONSTRAINTS":"这个任务有其它约束",
      "GANTT_ERROR_DEPENDS_ON_OPEN_TASK":"错误:打开的任务有其它依赖",
      "GANTT_ERROR_DESCENDANT_OF_CLOSED_TASK":"错误:有被关闭的任务",
      "TASK_HAS_EXTERNAL_DEPS":"这个任务有外部依赖项",
      "GANNT_ERROR_LOADING_DATA_TASK_REMOVED":"GANNT_ERROR_LOADING_DATA_TASK_REMOVED",
      "CIRCULAR_REFERENCE":"循环引用",
      "CANNOT_DEPENDS_ON_ANCESTORS":"不能依赖父级任务",
      "INVALID_DATE_FORMAT":"添加的数据对于字段格式无效",
      "GANTT_ERROR_LOADING_DATA_TASK_REMOVED":"加载数据时发生错误，一项任务被破坏了",
      "CANNOT_CLOSE_TASK_IF_OPEN_ISSUE":"不能关闭一个正被打开的任务",
      "TASK_MOVE_INCONSISTENT_LEVEL":"你不能交换不同目录下的任务",
      "CANNOT_MOVE_TASK":"CANNOT_MOVE_TASK",
      "PLEASE_SAVE_PROJECT":"PLEASE_SAVE_PROJECT",
      "GANTT_SEMESTER":"Semester",
      "GANTT_SEMESTER_SHORT":"s.",
      "GANTT_QUARTER":"Quarter",
      "GANTT_QUARTER_SHORT":"q.",
      "GANTT_WEEK":"Week",
      "GANTT_WEEK_SHORT":"第"
    };
  }

  function createNewResource(el) {
    var row = el.closest("tr[taskid]");
    var name = row.find("[name=resourceId_txt]").val();
    var url = contextPath + "/applications/teamwork/resource/resourceNew.jsp?CM=ADD&name=" + encodeURI(name);

    openBlackPopup(url, 700, 320, function (response) {
      //fillare lo smart combo
      if (response && response.resId && response.resName) {
        //fillare lo smart combo e chiudere l'editor
        row.find("[name=resourceId]").val(response.resId);
        row.find("[name=resourceId_txt]").val(response.resName).focus().blur();
      }

    });
  }
</script>



</asp:Content>