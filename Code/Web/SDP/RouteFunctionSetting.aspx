<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="RouteFunctionSetting.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.RouteFunctionSetting" %>

<%@ Import Namespace="Resources" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .ListTable tr td
        {
            word-wrap: break-word;
            word-break: break-all;
            text-align: left;
        }
    </style>
    <div class="tb_c" style="min-height: 500px; overflow: auto;">
        <div style="padding-bottom: 5px">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        路由：
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblRoute" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="Label2">
                        工序：
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblStation" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        工序描述：
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblStationDesc" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="wrap_tb" style="min-width: 710px; overflow: auto;">
            <ul class="tb">
                <li>模板</li>
                <li class="current">数据源</li>
                <li>执行逻辑</li>
            </ul>
            <div style="min-height: 385px; overflow: auto;">
                <div class="client-center" style="height: 350px">
                    <!--采集信息入口-->
                </div>
                <asp:HiddenField ID="ContenHtml" runat="server" />
                <asp:HiddenField ID="hdnModelId" runat="server" />
                <asp:HiddenField ID="hdnStationId" runat="server" />
            </div>
            <div class="tb_c" style="min-height: 385px; overflow: auto;">
                <div class="infoTips">
                    列表型数据源</div>
                <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                    min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tbTbleSource">
                    <tr class="ListTableHeader">
                        <th style="width: 100px; min-width: 100px;">
                            名称
                        </th>
                        <th style="min-width: 300px">
                            参数
                        </th>
                        <th style="min-width: 300px">
                            输出列
                        </th>
                        <th scope="col" onclick="addDataSource(null, true, this);" style="color: #0066CC;
                            cursor: pointer; width: 80px; vertical-align: middle;" align="center">
                            <img src="../Content/images/icon/Add.png" class="imgText" />
                            <%= Resources.Buttons.COM_Add%>
                        </th>
                    </tr>
                </table>
                <div style="height: 10px">
                </div>
                <div class="infoTips">
                    逻辑型数据源</div>
                <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                    min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tbLogicSource">
                    <tr class="ListTableHeader">
                        <th style="width: 100px; min-width: 100px;">
                            名称
                        </th>
                        <th style="min-width: 300px">
                            参数
                        </th>
                        <th style="min-width: 300px">
                            存储过程/SQL
                        </th>
                        <th scope="col" onclick="addDataSource2(null, true, this);" style="color: #0066CC;
                            cursor: pointer; width: 80px; vertical-align: middle;" align="center">
                            <img src="../Content/images/icon/Add.png" class="imgText" />
                            <%= Resources.Buttons.COM_Add%>
                        </th>
                    </tr>
                </table>
            </div>
            <div style="min-height: 385px; overflow: auto;">
                <table style="border-collapse: inherit;" width="100%">
                    <tr>
                        <td>
                            选择控件
                        </td>
                        <td align="left" style="padding: 10px; width: 250px;">
                            <asp:DropDownList ID="ddlControls" runat="server" Width="250px" onchange="BindActivityControl();">
                            </asp:DropDownList>
                        </td>
                        <td>
                            选择事件
                        </td>
                        <td align="left" style="padding: 10px; width: 250px;">
                            <select id="ddlActivity" style="width: 250px">
                            </select>
                        </td>
                        <td>
                            <input id="btnAddLogic" type="button" class="button" value="新增步骤" style="width: 100px"
                                onclick="AddLogic(this);" />
                        </td>
                    </tr>
                </table>
                <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                    min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tabActivity">
                    <tr style="min-height: 30px;"  class="ListTableHeader">
                        <th style="width: 100px;">
                            控件名称
                        </th>
                        <th style="width: 80px">
                            事件名称
                        </th>
                        <th>
                            步骤
                        </th>
                        <th>
                            删除
                        </th>
                    </tr>
                </table>
            </div>
        </div>
        <asp:HiddenField ID="hdnReouteDetailId" runat="server" />
    </div>
    <link href="../Content/plugin/Formdesign/css/bootstrap/css/bootstrap.css?2023" rel="stylesheet"
        type="text/css" />
        <link href="../Content/productioncollection.css" rel="stylesheet" type="text/css"/>
    <link href="../Content/plugin/Formdesign/css/site.css?2023" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var controlEntitys = [];
        $(document).ready(function () {
            //加载model界面
            $.post("../SDPHandler/LoadPage.ashx?api=LoadPage", { "station": $("#<%= hdnStationId.ClientID %>").val() }, function (data) {
                $(".client-center").append(data);
            }).error(function () { alert('model界面加载失败！', false); });

            //绑定model的控件
            var controls = document.getElementById("<%=ddlControls.ClientID %>");
            controlEntitys = $.parseJSON($("#<%= ContenHtml.ClientID %>").val());
            for (var k = 0; k < controlEntitys.length; k++) {
                controls.options.add(new Option(controlEntitys[k].title + "(" + controlEntitys[k].uictrltype + ")", controlEntitys[k].id));
            }

            //绑定控件对应的事件
            BindActivityControl();

            //加载数据源和事件的内容
            LoadDataSource();
        });

        //显示数据源和逻辑列表
        function LoadDataSource() {
            //获取数据源信息
            var ajaxSourct = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetRouteDetailParamList($("#<%=hdnReouteDetailId.ClientID %>").val());
            if (ajaxSourct.error != null) {
                alert(ajaxSourct.error.Message)
                return false;
            }
            var table = ajaxSourct.value;
            for (i = 0; i < table.Rows.length; i++) {
                var source = new Object();
                source.datasourceId = table.Rows[i].DataSourceID;
                source.sourceId = table.Rows[i].RouteDetailDataSourceID;
                source.tabColumn = table.Rows[i].TabColumn;
                source.sourceName = table.Rows[i].RouteDetailDataSourceName;
                source.sqlinfo = table.Rows[i].SQLInfo;
                var paramternames = "";
                if (table.Rows[i].Paramter != null) {
                    var paramters = table.Rows[i].Paramter.split(',');
                    for (paInedx = 0; paInedx < paramters.length; paInedx++) {

                        var paramArr = paramters[paInedx].split('/');
                        if (paramArr[1] != "") {
                            if (paramternames != "") {
                                paramternames = paramternames + ",";
                            }
                            //control列没值
                            if (paramters[paInedx] != "") {
                                for (controlIndex = 0; controlIndex < controlEntitys.length; controlIndex++) {
                                    if (paramArr[1] == controlEntitys[controlIndex].id) {
                                        paramternames += paramArr[0] + "(" + controlEntitys[controlIndex].title + "/" + paramArr[2] + ")";
                                        break;
                                    }
                                }
                            }
                            else {
                                paramternames += paramArr[0] + "(/" + paramArr[2] + ")";
                            }
                        }
                    }
                }

                if (table.Rows[i].DataSourceType == "Table") {
                    BindTableSource("tbTbleSource", source, paramternames, "Table");
                }
                else {
                    BindTableSource("tbLogicSource", source, paramternames, "Logic");
                }
            }

            //获取执行逻辑
            var ajaxActivity = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetActivityInfo($("#<%=hdnReouteDetailId.ClientID %>").val());
            if (ajaxActivity.error != null) {
                alert(ajaxActivity.error.Message);
                return false;
            }
            var activitylist = ajaxActivity.value;
            if (activitylist.length > 0) {
                var acIds = "";
                for (i = 0; i < activitylist.length; i++) {
                    acIds = acIds + activitylist[i].Id + ",";
                }
                //获取步骤
                var ajaxStep = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetStepInfo(acIds);
                if (ajaxStep.error != null) {
                    alert(ajaxStep.error.Message)
                    return false;
                }
                var steplist = ajaxStep.value;

                for (i = 0; i < activitylist.length; i++) {
                    var stepInfo = [];
                    for (k = 0; k < steplist.length; k++) {
                        if (steplist[k].AC_ID == activitylist[i].Id) {
                            steplist[k].StepId = steplist[k].LogicID;
                            steplist[k].DataSourceControl = steplist[k].DataSourceControlId;
                            if (steplist[k].DataSourceControlId != "") {
                                for (controlIndex = 0; controlIndex < controlEntitys.length; controlIndex++) {
                                    if (steplist[k].DataSourceControlId == controlEntitys[controlIndex].id) {
                                        steplist[k].DataSourceControl = controlEntitys[controlIndex].title + "(" + controlEntitys[controlIndex].uictrltype + ")";
                                        break;
                                    }
                                }
                            }

                            steplist[k].DataSource = "";
                            for (j = 0; j < table.Rows.length; j++) {
                                if (table.Rows[j].RouteDetailDataSourceID == steplist[k].DataSourceId) {
                                    steplist[k].DataSource = table.Rows[j].RouteDetailDataSourceName;
                                    break;
                                }
                            }
                            stepInfo.push(steplist[k]);
                        }
                    }
                    BindActivityTable(activitylist[i].Id, activitylist[i].ControlName, activitylist[i].ControlId, activitylist[i].EventType, stepInfo); //DataSourceControl
                }
            }
        }

        //根据数据源ID获取对应的参数（在绑定逻辑时候用）
        function getParamBySourceId(sourceId) {
            var paramter = ""; 
            $("#tbTbleSource tr td input[name='txtSourceID']").each(function () {                         
                if ($(this).val() == sourceId) {
                    paramter = $(this).parent().parent()[0].children[1].innerText;
                }
            });
            if (paramter == "") {
                $("#tbLogicSource tr td input[name='txtSourceID']").each(function () {
                    if ($(this).val() == sourceId) {
                        paramter = $(this).parent().parent()[0].children[1].innerText;
                    }
                });
            }
            return paramter;
        }

        //增加列表型数据源
        function addDataSource() {
            dialog({ title: "<%=Resources.Common.SetDataSource %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/SDP/SetDataSource.aspx?modelId=" + $("#<%=hdnModelId.ClientID %>").val() + "&SourceType=table" + "&rnd=" + Math.random(), width: 600, height: 400 });
        }

        //增加逻辑型数据源
        function addDataSource2() {
            dialog({ title: "<%=Resources.Common.SetDataSource %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/SDP/SetDataSource.aspx?modelId=" + $("#<%=hdnModelId.ClientID %>").val() + "&SourceType=logic" + "&rnd=" + Math.random(), width: 600, height: 400 });
        }

        //获取model上的control的json内容（绑定事件的时候使用）
        function GetmodelControl() {
            return $.parseJSON($("#<%= ContenHtml.ClientID %>").val());
        }

        //设置了数据源后的回调方法，这里分成增加事件，步骤和只增加步骤
        function SetStepInfo(stepInfo) {
            var inControl = $("#<%=ddlControls.ClientID %>")[0];
            var inControlId = inControl.options[inControl.selectedIndex].value;
            var inControlName = inControl.options[inControl.selectedIndex].text;

            var activity = $("#ddlActivity")[0];
            var activityFun = activity.options[activity.selectedIndex].value;

            var isNew = true;
            $("#tabActivity > tbody > tr").each(function () {
                if ($(this).find("td input[name*='txtControlId']").val() == inControlId && $.trim($(this).find("td")[1].innerText) == activityFun) {
                    isNew = false;
                    AddStep(this, stepInfo);
                }
            });

            if (isNew) {
                AddActivity(inControlName, inControlId, activityFun, stepInfo);
            }
            closeDialog();
        }

        //先实际增加步骤，再处理步骤的显示
        function AddStep(obj, stepInfo) {
            var tabStep = $(obj).find("td table")[0];
            var controlid = $.trim($(obj).find("input[name='txtControlId']").val());
            var eventType = $.trim(obj.children[1].innerText);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.SaveStepInfo($("#<%=hdnReouteDetailId.ClientID %>").val(), controlid, eventType,
                    stepInfo.StepName, stepInfo.DataSourceId, stepInfo.StepType, stepInfo.DataSourceControlId, stepInfo.StepXml);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var model = JSON.parse(ajax.value);
            if (model.result != "True") {
                alert(model.message);
                return;
            }
            stepInfo.StepId = model.StepId;
            BindStepTable(obj.children[2].children[0], stepInfo);
        }

        //步骤显示
        function BindStepTable(tabStep, stepInfo) {
            rowNewIdx = tabStep.rows.length;
            row = tabStep.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            //排序列
            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<a href='#' onclick='uprow(this)'><img src='../Content/images/arrowUp.gif' /></a>" +
                        "<a href='#' onclick='downrow(this)'><img src='../Content/images/arrowDown.gif'/></a>";

            //步骤名
            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = stepInfo.StepName + '<input name="stepid" type="hidden" value="' + stepInfo.StepId + '" />';

            //步骤类型
            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = stepInfo.StepType;

            //数据源
            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = stepInfo.DataSource + '<input type="hidden" name="txtDataSource" value="' + stepInfo.DataSourceId + '" />';

            //对应的xml
            cell = row.insertCell(4);
            cell.align = "center";
            cell.innerHTML = getParamBySourceId(stepInfo.DataSourceId);

            //影响的控件
            cell = row.insertCell(5);
            cell.align = "center";
            cell.innerHTML = stepInfo.DataSourceControl + '<input type="hidden" name="txtDataSource" value="' + stepInfo.DataSourceControlId + '" />';
                       

            //删除
            cell = row.insertCell(6);
            cell.align = "center";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteStep(this)\"><%= Buttons.COM_Delete %></span>";
        }

        //删除步骤
        function deleteStep(obj) {
            if (!window.confirm("你确定要删除这个步骤吗?")) {
                return;
            }

            var stepId = $(obj).parent().parent().find("input[name='stepid']").val();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.DeleteStep(stepId);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            var tab = obj.parentElement.parentElement.parentElement;
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);

            if (tab.rows.length == 1) {
                var tab2 = tab.parentElement.parentElement.parentElement.parentElement;
                tab2.deleteRow(tab.parentElement.parentElement.parentElement.rowIndex);
            }
        }

        //先实际增加事件和步骤，再显示他们
        function AddActivity(inControlName, inControlId, activityFun, step) {
            var control = inControlId.split("_");var ilength = control.length;
            var inControlType = inControlName.replace(control[ilength - 1], "").replace("(", "").replace(")", "");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.SaveActivity($("#<%=hdnReouteDetailId.ClientID %>").val(), inControlName, inControlId, inControlType,
                   activityFun, step.StepName, step.DataSourceId, step.StepType, step.DataSourceControlId, step.StepXml);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var model = JSON.parse(ajax.value);
            if (model.result != "True") {
                alert(model.message);
                return;
            }

            step.StepId = model.Step_ID;
            var stepInfo = [];
            stepInfo.push(step);
            BindActivityTable(model.AC_ID, inControlName, inControlId, activityFun, stepInfo);
        }

        //事件显示
        function BindActivityTable(ac_ID, inControlName, inControlId, activityFun, stepInfo) {
            var tabActivity = document.getElementById("tabActivity");

            rowNewIdx = tabActivity.rows.length;
            row = tabActivity.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            //控件名称
            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = inControlName + "<input type=\"hidden\" name=\"txtControlId\" value=\"" + inControlId + "\" />" + "<input type=\"hidden\" name=\"txtAcId\" value=\"" + ac_ID + "\" />";

            //事件名称
            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = activityFun;

            //步骤:步骤名，步骤类型，数据源，影响的控件，对应的xml
            cell = row.insertCell(2);
            cell.align = "center";
            cell.valign = "top"
            var innerXml = "";
            for (stepIndex = 0; stepIndex < stepInfo.length; stepIndex++) {
                innerXml = innerXml + '<tr class="ListTableOddRow"><td>' +
                        "<a href='#' onclick='uprow(this)'><img src='../Content/images/arrowUp.gif' /></a>" +
                        "<a href='#' onclick='downrow(this)'><img src='../Content/images/arrowDown.gif'/></a>" +
                    '</td><td>' +
                    stepInfo[stepIndex].StepName + '<input name="stepid" type="hidden" value="' + stepInfo[stepIndex].StepId + '" />' + '</td><td>' + stepInfo[stepIndex].StepType +
                    '</td><td>' + stepInfo[stepIndex].DataSource + '<input type="hidden" name="txtDataSource" value="' + stepInfo[stepIndex].DataSourceId + '" />' +
                    '</td><td>' + getParamBySourceId(stepInfo[stepIndex].DataSourceId) +
                    '</td><td>' + stepInfo[stepIndex].DataSourceControl + '<input type="hidden" name="txtDataSourceControl" value="' + stepInfo[stepIndex].DataSourceControlId + '" />' +
                    '</td><td style="display:none">' + stepInfo[stepIndex].StepXml.toString() +
                    '</td><td><span style="CURSOR: pointer; COLOR: #0000ff;" onclick="deleteStep(this)"><%= Buttons.COM_Delete %></span></td></tr>';
            }
            cell.innerHTML = '<table border="0" width="100%">' +
                '<tr class="ListTableHeader"><th></th><th>步骤名称</th><th>步骤类型</th><th>数据源</th><th>数据源参数</th><th>影响的控件</th><th>删除</th></tr>' +
                innerXml +
              '</table>';

            //删除
            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteActivity(this)\"><%= Buttons.COM_Delete %></span>";
        }

        //向上移动行
        function uprow(obj) {
            var objTR = $(obj).parent().parent();
            var prevTR = objTR.prev();
            if (prevTR.length > 0) {
                var stepId = objTR.find("input[name='stepid']").val();
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ChangeOrderId(stepId, "up");
                if (ajax.error != null) {
                    alert(ajax.error.Message)
                    return false;
                }

                prevTR.insertAfter(objTR);
            }
        }

        //向下移动行
        function downrow(obj) {
            var objTR = $(obj).parent().parent();
            var nextTR = objTR.next();
            if (nextTR.length > 0) {
                var stepId = objTR.find("input[name='stepid']").val();
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ChangeOrderId(stepId, "down");
                if (ajax.error != null) {
                    alert(ajax.error.Message)
                    return false;
                }

                nextTR.insertBefore(objTR);
            }
        }

        //删除事件
        function deleteActivity(obj) {
            if (!window.confirm("你确定要删除这个事件吗?")) {
                return;
            }
            var activityId = $(obj).parent().parent().find("input[name='txtAcId']").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.DeleteActivity(activityId);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            var tab = document.getElementById("tabActivity");
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }

        //数据源的回调方法，保存后，再显示
        function SetSource1(source, entity) {
            var existSource = false;
            $("input[name=txtSourceID]").each(function () {
                if (this.title == source.datasourceId) {
                    existSource = true;
                }
            });
            if (existSource) {
                alert("你选择的数据源已存在,不用再次添加");
                return false;
            }

            var paramters = "";
            var paramterNames = "";
            for (i = 0; i < entity.length; i++) {
                if (i != 0) {
                    paramters += ",";
                    paramterNames += ",";
                }
                paramters += entity[i].ParamterName + "(" + entity[i].ControlId + "/" + entity[i].ParamterValue + ")";
                if (entity[i].ControlId == "") {
                    paramterNames += entity[i].ParamterName + "(/" + entity[i].ParamterValue + ")";
                }
                else {
                    for (controlIndex = 0; controlIndex < controlEntitys.length; controlIndex++) {
                        if (entity[i].ControlId == controlEntitys[controlIndex].id) {
                            paramterNames += entity[i].ParamterName + "(" + controlEntitys[controlIndex].title + "/" + entity[i].ParamterValue + ")";
                            break;
                        }
                    }                    
                }
            }

            //直接保存到数据库
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.SaveRouteSource($("#<%=hdnReouteDetailId.ClientID %>").val(), source.datasourceId, paramters);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var model = JSON.parse(ajax.value);
            if (model.result != "True") {
                alert(model.message);
                return;
            }

            source.sourceId = model.RrouteDetailDatasourceId;

            BindTableSource("tbTbleSource", source, paramterNames, "Table");
        }

        //数据源的显示
        function BindTableSource(tabid, source, paramters, sourceType) {
            var tab = document.getElementById(tabid);
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            //名称
            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = source.sourceName + "<input type=\"hidden\" name=\"txtSourceID\" value=\"" + source.sourceId + "\" title=\"" + source.datasourceId + "\"/>";

            //参数
            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = paramters;

            //输出列/存储过程
            cell = row.insertCell(2);
            cell.align = "center";
            if (sourceType == "Table") {
                cell.innerHTML = source.tabColumn;
            }
            else {
                cell.innerHTML = source.sqlinfo;
            }

            //删除
            cell = row.insertCell(3);
            cell.align = "center";
            if (sourceType == "Table") {
                cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteSource(this)\"><%= Buttons.COM_Delete %></span>";
            }
            else {
                cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteSource2(this)\"><%= Buttons.COM_Delete %></span>";
            }
        }

        //逻辑型数据源的绑定，再显示
        function SetSource2(source, entity) {
            var existSource = false;
            $("input[name=txtSourceID]").each(function () {
                if (this.title == source.datasourceId) {
                    existSource = true;
                }
            });
            if (existSource) {
                alert("你选择的数据源已存在,不用再次添加");
                return false;
            }

            var paramters = "";
            var paramterNames = "";
            for (i = 0; i < entity.length; i++) {
                if (i != 0) {
                    paramters += ",";
                    paramterNames += ",";
                }
                paramters += entity[i].ParamterName + "(" + entity[i].ControlId + "/" + entity[i].ParamterValue + ")";
                if (entity[i].ControlId == "") {
                    paramterNames += entity[i].ParamterName + "(/" + entity[i].ParamterValue + ")";
                }
                else {
                    for (controlIndex = 0; controlIndex < controlEntitys.length; controlIndex++) {
                        if (entity[i].ControlId == controlEntitys[controlIndex].id) {
                            paramterNames += entity[i].ParamterName + "(" + controlEntitys[controlIndex].title + "/" + entity[i].ParamterValue + ")";
                            break;
                        }
                    }
                }
            }

            //直接保存到数据库
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.SaveRouteSource($("#<%=hdnReouteDetailId.ClientID %>").val(), source.datasourceId, paramters);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var model = JSON.parse(ajax.value);
            if (model.result != "True") {
                alert(model.message);
                return;
            }
            source.sourceId = model.RrouteDetailDatasourceId;
            BindTableSource("tbLogicSource", source, paramterNames, "Logic");
        }

        //数据源删除
        function deleteSource(obj) {
            if (!window.confirm("你确定要删除这个数据源吗?")) {
                return;
            }

            var rdSourceId = $(obj.parentElement.parentElement).find("input[name='txtSourceID']").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.DeleteRouteDetailSource(rdSourceId);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var model = JSON.parse(ajax.value);
            if (model.result != "True") {
                alert(model.message);
                return;
            }

            var tab = document.getElementById("tbTbleSource");
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }
        
        //删除数据源
        function deleteSource2(obj) {
            if (!window.confirm("你确定要删除这个数据源吗?")) {
                return;
            }
            var rdSourceId = $(obj.parentElement.parentElement).find("input[name='txtSourceID']").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.DeleteRouteDetailSource(rdSourceId);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var model = JSON.parse(ajax.value);
            if (model.result != "True") {
                alert(model.message);
                return;
            }

            var tab = document.getElementById("tbLogicSource");
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }

        function AddLogic(obj) {
            var ddlControls = document.getElementById("<%=ddlControls.ClientID %>");
            var controlsId = ddlControls.options[ddlControls.selectedIndex].text;
            var ddlActivity = document.getElementById("ddlActivity");
            var activityName = ddlActivity.options[ddlActivity.selectedIndex].value;
            dialog({ title: "增加步骤", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/SDP/AvtivityEdit.aspx?acId=" + $("#<%=hdnReouteDetailId.ClientID %>").val() + "&control=" + controlsId + "&activity=" + activityName + "&" + "&rnd=" + Math.random(), width: 600, height: 400 });
        }

        //根据控件，绑定控件对应的方法
        function BindActivityControl() {
            var ddlControls = document.getElementById("<%=ddlControls.ClientID %>");
            var controlsId = ddlControls.options[ddlControls.selectedIndex].value;
            var controlstext = ddlControls.options[ddlControls.selectedIndex].text;
            var controlsType = controlstext.substring(controlstext.indexOf("(")).replace("(", "").replace(")", "");

            var ddlActivity = document.getElementById("ddlActivity");
            ddlActivity.options.length = 0; //删除旧的方法

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetControlActivity(controlsType);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var controlfunction = ajax.value;
            var functions = controlfunction.split(",");

            for (index = 0; index < functions.length; index++) {
                if ($.trim(functions[index]) != "") {
                    var functionValue = $.trim(functions[index]).split("(")[1].split(")")[0];
                    ddlActivity.options.add(new Option($.trim(functions[index]), functionValue));
                }
            }
        }
    </script>
</asp:Content>
