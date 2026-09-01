<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="RMANCRepairCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.RMANCRepairCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .listbg {
            background: url("../Content/images/tablistbg.png") repeat-x;
            height: 28px;
        }

        em {
            color: red;
        }
    </style>
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">
                            <%=Resources.lang.AC_OBA_ScanSN %></span> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" style="width: 70%;" class="scan-center-sn" />
                        &nbsp;&nbsp;&nbsp;<b>保固期：</b>&nbsp;<input type="text" id="txtWarrantyDate" class="ui-textbox DateTimeBox" readonly="readonly" style="width: 110px;" />
                        <img style="vertical-align: middle; cursor: pointer; margin-top: -2px; margin-left: -18px; margin-right: 5px"
                            class="ui-datepicker-trigger" src="../Content/plugin/calendar/skin/images/calendar2.png"
                            alt="选择日期" title="选择日期" />&nbsp;<em>*</em> &nbsp;&nbsp;
                         <b>是否保内：</b>&nbsp;<input type="checkbox" id="chkIsWarranty" style="width:18px; height:18px;position:relative;bottom:-4px;" /> 
                    </td>
                </tr>
                <tr>
                    <td colspan="2">

                        <table class="ListTable" id="nctable" style="border-width: 0px; width: 100%; margin-bottom: 40px; border-collapse: collapse;"
                            cellspacing="0" cellpadding="4">
                            <tbody>
                                <tr class="ListTableOddRow">
                                    <td style="padding: 0px 0px 10px; text-align: center; background-color: rgb(247, 247, 247);"
                                        colspan="4">
                                        <table id="tabRmaInfo" style="width: 100%; margin: -1px; border-collapse: collapse;"
                                            cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr class="ListTableOddRow">
                                                    <td style="text-align: left;" colspan="4">&nbsp;»RMA信息列表
                                                    </td>
                                                    <td style="text-align: left;" colspan="4">&nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="ListTableHeader listbg" style="text-align: center;">                                                    
                                                    <td>RMA单号
                                                    </td>
                                                    <td>机种
                                                    </td>
                                                    <td>名称
                                                    </td>
                                                    <td>规格
                                                    </td>
                                                    <td>退回次数
                                                    </td>
                                                    <td>退货日期
                                                    </td>
                                                    <td>客户
                                                    </td>
                                                    <td>不良描述
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="ListTableOddRow">
                                    <td style="padding: 0px 0px 10px; text-align: center; background-color: rgb(247, 247, 247);"
                                        colspan="4">
                                        <table id="tabNcAdded" style="width: 100%; margin: -1px; border-collapse: collapse;"
                                            cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr class="ListTableOddRow">
                                                    <td style="text-align: left;" colspan="4">&nbsp;»不良代码列表
                                                    </td>
                                                    <td style="text-align: left;" colspan="4">&nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="ListTableHeader listbg" style="text-align: center;">
                                                    <td></td>
                                                    <td>序 号
                                                    </td>
                                                    <td>不良代码
                                                    </td>
                                                    <td>代码描述
                                                    </td>
                                                    <td>不良状态
                                                    </td>
                                                    <td width="140px">记录时间
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="ListTableOddRow" style="height: 40px;">
                                    <td style="text-align: left;" colspan="2">&nbsp;»检测代码：
                    <input id="txtFailure" onkeyup="getRMADebugNCCode()" type="text" style="width: 130px; height: 24px;" />&nbsp;<em>*</em>
                                    </td>
                                    <td style="text-align: left;">&nbsp;»维修代码：
                    <input id="txtRepair" onkeyup="getRMARepairNCCode()" type="text" style="width: 130px; height: 24px;" />&nbsp;<em>*</em>
                                    </td>
                                    <td style="height: 29px; text-align: center;">
                                        <input onclick="assemblyPartsChange(window)" type="button" value=" 部件更换 " />
                                    </td>
                                </tr>
                                <tr class="ListTableOddRow">
                                    <td style="padding: 1px; width: 26%; vertical-align: top;">
                                        <div class="listbg">
                                            &nbsp;» 可选择的检测代码
                                        </div>
                                        <select id="listFailure" style="width: 98%; height: 100px; float: left;" onchange="failureCodeSelect(this)"
                                            multiple="multiple">
                                        </select>
                                    </td>
                                    <td style="padding: 2px; width: 23%; vertical-align: top;">
                                        <div class="listbg" style="width: 100%; height: 30px; text-align: left; line-height: 30px; float: left;">
                                            &nbsp;» 检测代码数据收集
                                        </div>
                                        <table id="tabDefectField" style="width: 100%; border-collapse: collapse;" cellspacing="0"
                                            cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td style="text-align: center;">检测代码数据收集区
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td style="padding: 2px; width: 26%; vertical-align: top;">
                                        <div class="listbg" style='width: 100%; height: 30px; text-align: left; line-height: 30px; float: left;'>
                                            &nbsp;» 可选择的维修代码
                                        </div>
                                        <select id="listRepairs" style="width: 98%; height: 100px; float: left;" onchange="repairCodeSelect(this)"
                                            multiple="multiple">
                                        </select>
                                    </td>
                                    <td style="padding: 2px; width: 23%; vertical-align: top;">
                                        <div class="listbg" style='width: 100%; height: 30px; text-align: left; line-height: 30px; float: left;'>
                                            &nbsp;» 维修代码数据收集
                                        </div>
                                        <table id="tabRepairField" style="width: 100%; border-collapse: collapse;" cellspacing="0"
                                            cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td style="text-align: center;">维修代码数据收集区
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding: 0px 0px 10px; text-align: center; background-color: rgb(247, 247, 247);"
                                        colspan="4">
                                        <table id="tabNCLog" style="width: 100%; margin: -1px; border-collapse: collapse;"
                                            cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr class="ListTableHeader listbg">
                                                    <td width="15%" style="text-align: center;">序 号
                                                    </td>
                                                    <td width="25%" style="text-align: center;">不良代码
                                                    </td>
                                                    <td width="25%" style="text-align: center;">检测代码
                                                    </td>
                                                    <td width="25%" style="text-align: center;">维修代码
                                                    </td>
                                                    <td width="10%" style="text-align: center;">操作
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="background-color: #fff;">
                                        <div style="height: 35px; line-height: 35px; text-align: right; background-color: #fff;">
                                            <div style="margin-right: 20px;">
                                                <input type="button" value=" 添 加 " onclick="addRepairRecord()" />&nbsp;
                                                <input type="button" value=" 维修完成 " onclick="finishedProductRepair()" />
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                            </tbody>
                        </table>

                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">

        var scanSN = "";
        var chkNcDataId = -1; //不良记录ID
        var chkNcDataCode = ""; //不良代码
        var arrRepairLog = []; //提交之前,临时保存不良维修记录
        var resourceId = $("#hdnCurrResourceId").val(); //资源Id
        var stationId = $("#hdnCurrStationId").val(); //工位Id
        var userId=<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>;
        var unitId = -1;
        var repairSN = "";
        //部件更换
        var bomListCount = 0;
        var assyDataChangeRecords = [];
        var assyDataId = -1;
        var selectMode = "notSequence";

        $(document).ready(function () {
            $("#leftmenu").hide().parent().attr("width", "0").css("width", "0px");      
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('RMARepairCollection');
                },
                10
            );
        });

        function afterScan() {
            if ($("#txtSN").val() != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
                
                scanSN = $.trim($("#txtSN").val()); //扫描Sn
                getRMAInfo();
                getRMANCCode();

            }
            $("#txtSN").val("");
        }

        /**
        *   保存完成维修操作
        **/
        function finishedProductRepair() {
            var isAllRepair = true;
            var noNCCode = "";
            $("#tabNcAdded tr td").find("input[name=chkSelect]").each(function(){
                for(var i=0;i<arrRepairLog.length;i++){
                    if(arrRepairLog[i].indexOf(this.value) < 0){
                        isAllRepair = false;
                        noNCCode = ( $(this).parent().next().next().text());
                        break;
                    }
                }                
            });

           if(!isAllRepair){
                    alert("未找到不良代码"+noNCCode+"的维修记录！");
                    $("#txtSN").val("").focus();
                    return false;
                }
            var txtWarrantyDate = $.trim($("#txtWarrantyDate").val());
            var chkIsWarranty = $("#chkIsWarranty").prop("checked");

            if(txtWarrantyDate==""){
                alert("请选择保固期！");
                $("#txtWarrantyDate").focus();
                return false;
            }
            /*用于没有不良，或者不良都已维修的情况下，直接跳过验证和记录保存。*/
            if (chkNcDataId == -1) {
                alert("未找到有效的不良信息！");
                $("#txtSN").val("").focus();
                return false;
            }

            var dataLog = "";

            for (var i = 0; i < arrRepairLog.length; i++) {
                dataLog = dataLog + arrRepairLog[i] + ";"
            }

            var resultAjax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.SynthesisRepairPartsChangeRMA(unitId, stationId, resourceId, userId, dataLog, -1, formatAssyDataChangeRecordsToXML(),txtWarrantyDate,chkIsWarranty);
            if (resultAjax.error == null) {
                $("#txtSN").val("").focus();
                $("#tabRmaInfo tr:gt(1)").remove();
                $("#tabNcAdded tr:gt(1)").remove();
                $("#tabNCLog tr:gt(0)").remove();
                $("#txtFailure").val("");
                $("#txtRepair").val("");
                $("#listFailure").html("");
                $("#listRepairs").html("");
                $("#txtWarrantyDate").val("");
                $("#chkIsWarranty").prop("checked",false);                 
                $("#tabDefectField,#tabRepairField").html('<tr class="ListTableOddRow"><td style="text-align:center;">没有需要采集的数据！</td></tr>');
                chkNcDataId = -1; //不良记录ID
                chkNcDataCode = ""; //不良代码
                arrRepairLog = [];
                unitId = -1;
                repairSN = "";
                bomListCount = 0;
                assyDataChangeRecords = [];
                assyDataId = -1;
                setMessageBox("维修完成！", "messageGreen");  

            } else {
                alert(resultAjax.error.Message);
                $("#txtSN").val("").focus();
                SaveUserUILog("一般", stationId, resourceId, "", resultAjax.error.Message);
                return false;
            }
        }

        /*
        **获取RMA单信息
        */
        function getRMAInfo(){
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetRMAInfo(scanSN);
            if (ajax.error != null) {
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                setMessageBox(ajax.error.Message, "messageRed");               
                $("#txtSN").val("").focus();
                return false;
            }
            
            var rmaInfo = jQuery.parseJSON(ajax.value);          
            if(rmaInfo != null && rmaInfo.length>0){
                $("#tabRmaInfo").append("<tr><td>"+rmaInfo[0].RmaNo+"</td><td>"+rmaInfo[0].ItemCode+"</td><td>"+rmaInfo[0].ItemName+"</td><td>"+rmaInfo[0].ItemSpec+"</td><td>"+rmaInfo[0].RMACount+"</td><td>"+rmaInfo[0].CancelTime+"</td><td>"+rmaInfo[0].CustomerName+"</td><td>"+rmaInfo[0].RejectsDesc+"</td></tr>");
            }
        }

        /*
        **获取扫描的RMA不良代码信息
        */
        function getRMANCCode() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetRMANcCode(scanSN);
            if (ajax.error != null) {
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                setMessageBox(ajax.error.Message, "messageRed");               
                $("#txtSN").val("").focus();
                return false;
            }

            var ncCodeArr = jQuery.parseJSON(ajax.value);
            loadNcData(ncCodeArr);

        }

        /**
        * 列出不良记录详情        
        **/
        function loadNcData(list) {
            var row, cell;
            var entity = {};
            var flage = "";
            var entityAry = list;
            var isclosecount = 0;
            var setTable = document.getElementById("tabNcAdded");

            if (entityAry == null) {
                row = setTable.insertRow(1);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = 6;
                cell.innerHTML = "未找到产品相关不良信息！";
                return false;
            }
            else {
                $("#tabNcAdded tr:gt(1)").remove();
            }
            if (entityAry.length > 0) {
                /***动态创建表***/
                for (var i = 0; i < entityAry.length; i++) {
                    entity = entityAry[i];
                    if (i == 0) {
                       unitId = entity.UID;
                    }
                    
                    row = setTable.insertRow(setTable.rows.length);
                    row.className = 'ListTableOddRow';

                    if (entity.Status != "Open") {
                        row.style.color = "#9C9C9C";
                        isclosecount++;
                    }

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = entity.Status == "Open" ? "<input name=\"chkSelect\" onclick=\"loadNCDetail(this)\" style=\"width:15px; height:15px;\" type=\"checkbox\" value='" + entity.NCDataId + "'>" : "!";

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = "<span>" + entity.SN + "</span>";//entity.NCDataId;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.NCCode;

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.Description;

                    cell = row.insertCell(4);
                    cell.align = "center";
                    cell.innerHTML = entity.Status; 

                    cell = row.insertCell(5);
                    cell.align = "center";
                    cell.innerHTML = entity.CreateDateTime;
                }
                getRMADebugNCCode();
                getRMARepairNCCode(); 
                $("#txtFailure").val("");
                $("#txtRepair").val("");
                $("#txtWarrantyDate").focus();
            }
            else{
                alert("未找到产品关联的不良信息！");
                $("#txtSN").val("").focus();
            }
            
           
        }

        /**
        * 选中某个NC，获取这个NC的详细信息(Data Type)
        **/
        function loadNCDetail(obj) {
            if (obj.checked) {
                var checkId = 0;
                chkNcDataId = obj.value;
                obj.parentNode.parentNode.style.backgroundColor = "#BDE3FB";
                /*清除其他选中的Checkbox，确保单选*/
                var myobj = document.getElementsByName("chkSelect");
                for (var i = 0; i < myobj.length; i++) {
                    if (myobj[i] != obj) {
                        myobj[i].checked = false;
                        myobj[i].parentNode.parentNode.style.backgroundColor = "#FFFFFF";
                    }
                }
                repairSN = obj.parentNode.parentNode.cells[1].innerText;
                chkNcDataCode = obj.parentNode.parentNode.cells[2].innerText;
                checkId = obj.parentNode.parentNode.cells[1].innerText;
            }
            else {
                chkNcDataId = -1;
                chkNcDataCode = "";             
            }
        }

        /*
        **获取不良检测代码信息
        */
        function getRMADebugNCCode() {
            var txtFailure = $("#txtFailure").val();
            var listFailure = $("#listFailure");
            listFailure.empty();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNCDebugCodeList(scanSN, txtFailure,stationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var entityAry = jQuery.parseJSON(ajax.value);
            var entity = {};
            for (var i = 0; i < entityAry.length; i++) {
                entity = entityAry[i];
                listFailure.append('<option value="' + entity.NCCodeId + '">' + entity.NCCode + '(' + entity.Description + ')' + '</option>');
            }
            if (entityAry.length == 1) {
                listFailure.val(entity.NCCodeId);
                listFailure.change();
            }
        }

        /*
        **获取不良维修代码信息
        */
        function getRMARepairNCCode() {
            var txtRepair = $("#txtRepair").val();
            var listRepairs = $("#listRepairs");
            listRepairs.empty();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNCRepairCodeList(scanSN, txtRepair,stationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var entityAry = jQuery.parseJSON(ajax.value);
            var entity = {};
            for (var i = 0; i < entityAry.length; i++) {
                entity = entityAry[i];
                listRepairs.append('<option value="' + entity.NCCodeId + '">' + entity.NCCode + '(' + entity.Description + ')' + '</option>');
            }
            if (entityAry.length == 1) {
                listRepairs.val(entity.NCCodeId);
                listRepairs.change();
            }
        }

        /**
       * 加载不良检测代码      
       * 因为不同的NC Code(Failure, Defect, Repair)所对应的数据类型不同
       * 也就是要收集的数据不同，所以，当选择一个NC Code时，其对应的数
       * 据收集窗口的显示也是不同的，这个函数主要是为了动态地切换数据收集
       * 窗口的内容，以确保正确的收据被收集 
       **/
        function failureCodeSelect(obj) {
            var sltFailure = $(obj).find("option:selected")
            var txtFailure = sltFailure.text();
            var txtFailureId = sltFailure.val();
            $("#txtFailure").val(getNCCode(txtFailure));

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNCCodeDataField(txtFailureId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var entityAry = jQuery.parseJSON(ajax.value);
            var tabField = document.getElementById("tabDefectField");
            if (entityAry.length > 0) {
                $(tabField).html('');
            } else {
                $(tabField).html('<tr class="ListTableOddRow"><td style="text-align:center;">没有需要采集的数据！</td></tr>');
            }
            /*Add Row*/
            for (var i = 0; i < entityAry.length; i++) {
                addFailureDataField(tabField, entityAry[i]);
            }
            if (entityAry.length > 0) {
                $(tabField).find("input[type=text]").eq(0).focus();
            }
        }

        /**
        * 加载不良维修代码      
        * 因为不同的NC Code(Failure, Defect, Repair)所对应的数据类型不同
        * 也就是要收集的数据不同，所以，当选择一个NC Code时，其对应的数
        * 据收集窗口的显示也是不同的，这个函数主要是为了动态地切换数据收集
        * 窗口的内容，以确保正确的收据被收集 
        **/
        function repairCodeSelect(obj) {
            var sltRepair = $(obj).find("option:selected")
            var txtRepair = sltRepair.text();
            var txtRepairId = sltRepair.val();
            $("#txtRepair").val(getNCCode(txtRepair));

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNCCodeDataField(txtRepairId);
            if (ajax.error != null) {
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                alert(ajax.error.Message);
             
                return false;
            }
            var entityAry = jQuery.parseJSON(ajax.value);
            var tabField = document.getElementById("tabRepairField");
            if (entityAry.length > 0) {
                $(tabField).html('');
            } else {
                $(tabField).html('<tr class="ListTableOddRow"><td style="text-align:center;">没有需要采集的数据！</td></tr>');
            }
            /*Add Row*/
            for (var i = 0; i < entityAry.length; i++) {
                addRepairDataField(tabField, entityAry[i]);
            }
            if (entityAry.length > 0) {
                $(tabField).find("input[type=text]").eq(0).focus();
            }
        }

        /**
        *   从NCCode+(Description)中分离NC Code       
        **/
        function getNCCode(str) {
            var i = str.indexOf("(");
            if (i > 0) {
                return str.substring(0, i);
            }
            else {
                return str;
            }
        }

        /*
      ** 动态创建Repair Data Field  
      */
        function addRepairDataField(tabDatas, entityData) {
            var row, cell;
            row = tabDatas.insertRow(tabDatas.rows.length);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.className = "Label1";
            cell.innerHTML = '<input type="hidden" name="rdnFID" value="' + entityData.DataFieldId + '" />'
                            + '<input type="hidden" name="hdnDataTypeID" value="' + entityData.DataTypeId + '" />' + entityData.DataTag;

            var required = (entityData.Required == false ? 'requireds="0"' : 'requireds="1"');
            var types = (entityData.DataType == "CheckBox" ? "checkbox" : "text");
            var reTag = (entityData.Required == false ? '' : '<em>*</em>');
            var dataTypes = 'dataTypes="' + entityData.DataType + '"';

            cell = row.insertCell(1);
            cell.className = "Field1";
            cell.innerHTML = '<input style="width:90px;height:22px;" type="' + types + '" name="txtValue" value="" ' + required + ' ' + dataTypes + ' class="TextBox" onchange="checkFormat(this)" />' + reTag;
        }

        /*
       *   动态创建Failure Data Field  
       */
        function addFailureDataField(tabDatas, entityData) {
            var row, cell;
            row = tabDatas.insertRow(tabDatas.rows.length);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.className = "Label1";
            cell.innerHTML = '<input type="hidden" name="ddnFID" value="' + entityData.DataFieldId + '" />'
                            + '<input type="hidden" name="hddnDataTypeID" value="' + entityData.DataTypeId + '" />' + entityData.DataTag;

            var selectType = entityData.DataType;
            if (selectType == "Data") {
                var required = (entityData.Required == false ? 'requireds="0"' : 'requireds="1"');
                var types = "Data";
                var reTag = (entityData.Required == false ? '' : '<em>*</em>');
                var dataTypes = 'dataTypes="' + entityData.DataType + '"';

                cell = row.insertCell(1);
                cell.className = "Field1";
                var remarkStr = entityData.Remark.split(",");
                var html = "";

                for (var i = 0; i < remarkStr.length; i++) {
                    html += '<option value=' + remarkStr[i] + '>' + remarkStr[i] + '</option>';
                }

                cell.innerHTML = ' <select style="width:90px;"  name="dtxtValue" class="textClass" onchange="checkFormat(this)">' + html + '</select>';
            }
            else {
                var required = (entityData.Required == false ? 'requireds="0"' : 'requireds="1"');
                var types = (entityData.DataType == "CheckBox" ? "checkbox" : "text");
                var reTag = (entityData.Required == false ? '' : '<em>*</em>');
                var dataTypes = 'dataTypes="' + entityData.DataType + '"';

                cell = row.insertCell(1);
                cell.className = "Field1";
                cell.innerHTML = '<input style="width:90px;height:22px;" type="' + types + '" name="dtxtValue" value="" ' + required + ' ' + dataTypes + ' class="TextBox" onchange="checkFormat(this)" />' + reTag;
            }
        }

        /**
       *   临时保存维修记录
       **/
        function addRepairRecord() {
            var sltFailure = $("#listFailure").val();
            var sltRepair = $("#listRepairs").val();

            if (chkNcDataId == -2) {
                alert('没有需要维修的记录！');
                return false;
            }

            if (chkNcDataId == -1) {
                alert('请选择需要维修的记录！');
                return false;
            }

            if (sltFailure == null) {
                alert('请选择检测代码！');
                return false;
            }

            if (sltRepair == null) {
                alert('请选择维修代码！');
                return false;
            }

            var repairDetail = "";

            var dfidAry = document.getElementsByName("ddnFID");
            var dfvalAry = document.getElementsByName("dtxtValue");
            var rfidAry = document.getElementsByName("rdnFID");
            var rfvalAry = document.getElementsByName("txtValue");

            for (var i = 0; i < dfidAry.length; i++) {
                repairDetail += dfidAry[i].value + ":" + dfvalAry[i].value + "^";
            }

            for (var i = 0; i < rfidAry.length; i++) {
                repairDetail += rfidAry[i].value + ":" + rfvalAry[i].value + "^";
            }

            repairDetail = repairDetail.toString().trim("^");

            var failureCodeAndDes = $("#listFailure").find("option:selected").text();
            var repairCodeAndDes = $("#listRepairs").find("option:selected").text();

            var strRepair = chkNcDataId + "|" + chkNcDataCode + "|" + getNCCode(failureCodeAndDes) + "|" + getNCCode(repairCodeAndDes) + "|" + repairDetail + "|";
            for (var i = 0; i < arrRepairLog.length; i++) {
                if (arrRepairLog[i].indexOf(strRepair) >= 0) {
                    alert(getResource("Messages", "AC_DR_DuplicateRepairRecord"));
                    return false;
                }
            }
            arrRepairLog.push(strRepair);

            var tabLog = document.getElementById("tabNCLog");
            var row, cell;
            row = tabLog.insertRow(tabLog.rows.length);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<span name='ncdataid' style='display:none;' >" + chkNcDataId + "</span>" + repairSN;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = chkNcDataCode;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = failureCodeAndDes;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = repairCodeAndDes;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.innerHTML = '<span style="cursor: pointer; color: #0000ff;" onclick="deleteItem(this)">' + getResource("lang", "AC_Delete") + '</span>';

            repairCodeAndDes = "";
            failureCodeAndDes = "";
            $("#txtFailure").val("");
            $("#txtRepair").val("");
            getRMADebugNCCode();
            getRMARepairNCCode();
            $("#txtFailure").focus();

        }

        /*
        ** 删除维修记录
        ** 删除的数据是页面上显示的数据，并不是数据库中的数据
        ** 页面上的数据并没有提交到数据库中
        ** 维修的数据是批量提交到数据库中
        */
        function deleteItem(obj) {
            var rows = obj.parentNode.parentNode;
            var tabs = document.getElementById("tabNCLog");
            var chkNcDataId = $(rows).find("span[name=ncdataid]").text();
            var strItem = chkNcDataId + "|" + rows.cells[1].innerText + "|" + getNCCode(rows.cells[2].innerText);

            for (var i = 0; i < arrRepairLog.length; i++) {
                if (arrRepairLog[i].indexOf(strItem) >= 0)
                    arrRepairLog.splice(i, 1);
            }

            tabs.deleteRow(rows.rowIndex);
        }

        /**
        *   保存时，将组装部件变更记录转换为XML。
        */        
        function formatAssyDataChangeRecordsToXML() {
            var xml = "<AssyDataChangeRecords>";
            for (var i = 0; i < assyDataChangeRecords.length; i++) {
                xml += "<Data>";
                xml += "<NCId>" + assyDataChangeRecords[i].ncId + "</NCId>";
                xml += "<AssyDataId>" + assyDataChangeRecords[i].assyDataId + "</AssyDataId>";
                xml += "<AssyDataIdString>" + assyDataChangeRecords[i].idString + "</AssyDataIdString>";
                xml += "<AssyDataValString>" + assyDataChangeRecords[i].valString + "</AssyDataValString>";
                xml += "<AssyItemId>" + assyDataChangeRecords[i].assyItemId + "</AssyItemId>";
                xml += "<DataTypeId>" + assyDataChangeRecords[i].dataTypeId + "</DataTypeId>";
                xml += "</Data>";
            }
            xml += "</AssyDataChangeRecords>";

            return xml;
        }

        /**
        *   部件变更按钮被点击 打开部件变更操作界面
        **/
        function assemblyPartsChange(win) {

            winParentR = win;
            var sltFailure = $("#listFailure").val();
            var sltRepair = $("#listRepairs").val();

            if (chkNcDataId<0 ) {
                alert("请先选择要维修的不良记录！");
                return false;
            }
            //打开维修窗口               
            dialog({ title:  "部件更换-S/N："+repairSN.substring(0,70)+"...", src:  "../Client/AssembleProUnBind.aspx?sn="+escape(repairSN)+"&stationid=" + 0 + "&resourceid=" + resourceId +"&ncdataid="+chkNcDataId+ "&rnd=" + Math.random(), width: 800, height: 500 });
            return false;	       
        }
    </script>
</asp:Content>
