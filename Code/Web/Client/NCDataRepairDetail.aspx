<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="NCDataRepairDetail.aspx.cs" Inherits="SKT.LeanMES.Web.Client.NCDataRepairDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        .listbg {
            background: url("../Content/images/tablistbg.png") repeat-x;
        }
    </style>
    <table class="ListTable" id="nctable" style="border-width: 0px; width: 100%; margin-bottom: 40px; border-collapse: collapse;"
        cellspacing="0" cellpadding="4">
        <tbody>
            <tr class="ListTableHeader listbg">
                <th style='background: url("../Content/images/tablistbg.png") repeat-x; text-align: left;'
                    colspan="4" scope="col">»维修不良品 (S/N :
                    <label id="lblSN">
                    </label>
                    )
                </th>
            </tr>
            <tr class="ListTableOddRow">
                <td style="padding: 0px 0px 5px; text-align: center; background-color: rgb(247, 247, 247);"
                    colspan="4">
                    <table id="tabNcAdded" style="width: 100%; margin: -1px; border-collapse: collapse;"
                        cellspacing="0" cellpadding="0">
                        <tbody>
                            <tr class="ListTableOddRow">
                                <td style="text-align: left;" colspan="4">»已添加不良代码列表
                                </td>
                                <td style="text-align: left;" colspan="6">&nbsp;<input type="button" value=" 不良位置录入 " onclick="setLocation()" /><%--ncCodeTypeIn(window)--%>
                                </td>
                            </tr>
                            <tr class="ListTableHeader listbg" style="text-align: center;">
                                <td></td>
                                <td>序 号
                                </td>
                                <td>不良现象代码
                                </td>
                                <td>条码数量
                                </td>
                                <td>代码描述
                                </td>
                                <td>不良位置
                                </td>
                                <td>不良状态
                                </td>
                                <td>工位
                                </td>
                                <td>资源
                                </td>
                                <td width="140px">记录时间
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr id="ncLocation"  class="ListTableOddRow" style="display:none;" >
                <td style="padding: -5px 0px 5px; text-align: center; background-color: rgb(247, 247, 247);"
                    colspan="4">
                    <table id="" style="width: 100%; margin: -1px; border-collapse: collapse;"
                        cellspacing="0" cellpadding="0">
                        <tbody>
                            <tr class="ListTableOddRow">
                                <td style="text-align: right;"   >
                                    位号
                                </td>
                                <td style="text-align: left;"   > 
                                    <input type="text" id="txtLocation" />
                                </td>
                            </tr>
                            <tr class="ListTableOddRow">
                                <td style="text-align: right;"   >
                                    已扫描位号
                                </td>
                                <td style="text-align: left;"   > 
                                    <textarea   id="txtScanLocation" class="TextArea" style="width:98%;"></textarea>
                                </td>
                            </tr>
                             <tr class="ListTableOddRow">
                                <td style="text-align: right;"   >                                    
                                </td>
                                <td style="text-align: left;"   > 
                                    <input id="txtClear" type="button" value=" 清 空 " onclick="clearLocation()" />&nbsp;&nbsp;<input id="txtConfirm" type="button" value=" 完 成 " onclick="confirmLocation()" />
                                    &nbsp;&nbsp;&nbsp;<input id="txtClose" type="button" value=" 关 闭 " onclick="closeLocation()" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding: 0px 0px 10px; text-align: center; background-color: rgb(247, 247, 247);"
                    colspan="4">
                    <table id="tabNCDetail" style="width: 100%; margin: -1px; border-collapse: collapse;"
                        cellspacing="0" cellpadding="0">
                        <tbody>
                            <tr class="ListTableOddRow ">
                                <td style="text-align: left;" colspan="4">»不良详情描述：
                                </td>
                            </tr>
                            <tr class="ListTableHeader listbg" style="text-align: center;">
                                <td width="30%">序 号
                                </td>
                                <td width="25%">不良详细属性
                                </td>
                                <td width="25%">属性描述
                                </td>
                                <td width="20%">属性值
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td style="text-align: left;" colspan="2">»不良原因代码：
                    <input id="txtFailure" onkeyup="showFailure()" type="text" style="width: 130px;" /><em>*</em>
                </td>
                <td style="text-align: left;">»维修方法代码：
                    <input id="txtRepair" onkeyup="showRepair()" type="text" style="width: 130px;" /><em>*</em>
                </td>
                <td style="height: 29px; text-align: center;">
                    <input onclick="materialReplacement(window)" type="button" value="物料更换" />&nbsp;
                    <input onclick="assemblyPartsChange(window)" type="button" value="部件更换" />&nbsp;
                    <input onclick="saveScrap(window)" type="button" value=" 产品报废 " id="buttonScrap" style="display: none;" />
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td style="padding: 1px; width: 26%; vertical-align: top;">
                    <div class="listbg">
                        » 可选择的不良原因代码
                    </div>
                    <select id="listFailure" style="width: 98%; height: 100px; float: left;" onchange="failureCodeSelect(this)"
                        multiple="multiple">
                    </select>
                </td>
                <td style="padding: 2px; width: 23%; vertical-align: top;">
                    <div class="listbg" style="width: 100%; height: 30px; text-align: left; line-height: 30px; float: left;">
                        » 不良原因代码数据收集
                    </div>
                    <table id="tabDefectField" style="width: 100%; border-collapse: collapse;" cellspacing="0"
                        cellpadding="0">
                        <tbody>
                            <tr>
                                <td style="text-align: center;">不良原因代码数据收集区
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td style="padding: 2px; width: 26%; vertical-align: top;">
                    <div class="listbg" style='width: 100%; height: 30px; text-align: left; line-height: 30px; float: left;'>
                        » 可选择的维修方法代码
                    </div>
                    <select id="listRepairs" style="width: 98%; height: 100px; float: left;" onchange="repairCodeSelect(this)"
                        multiple="multiple">
                    </select>
                </td>
                <td style="padding: 2px; width: 23%; vertical-align: top;">
                    <div class="listbg" style='width: 100%; height: 30px; text-align: left; line-height: 30px; float: left;'>
                        » 维修方法代码数据收集
                    </div>
                    <table id="tabRepairField" style="width: 100%; border-collapse: collapse;" cellspacing="0"
                        cellpadding="0">
                        <tbody>
                            <tr>
                                <td style="text-align: center;">维修方法代码数据收集区
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
                            <tr class="ListTableOddRow">
                                <td style="text-align: left;" colspan="5">»已记录的检测维修结果： 目的工位：
                                    <select id="selDestinationOpeId">
                                    </select>
                                    <%-- <input id="btnInputAnormal" onclick="UploadPicture();" type="button" value="上传图片" />--%>
                                    维修数量：
                                    <input id="txtBatchRepairQty" type="text" style="width: 130px;" />
                                    打印机列表：
                                    <select id="selPrintersList" style=" width: 250px; ">
                                    </select>
                                    <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机</a>
                                </td>
                            </tr>
                            <tr class="ListTableHeader listbg">
                                <td width="30%" style="text-align: center;">序 号
                                </td>
                                <td width="20%" style="text-align: center;">不良现象代码
                                </td>
                                <td width="20%" style="text-align: center;">不良原因代码
                                </td>
                                <td width="20%" style="text-align: center;">维修方法代码
                                </td>
                                <td width="10%" style="text-align: center;">操作
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    <div style="width: 99%; height: 35px; line-height: 35px; position: absolute; border-top: 1px solid #D3D3D3; bottom: 0px; text-align: right; background-color: #F3F3F3;">
        <div style="margin-right: 20px;">
            <input type="button" value=" 添 加 " onclick="addRepairRecord()" />&nbsp;
            <input type="button" value=" 完成关闭 " onclick="finishedProductRepair()" />&nbsp;
            <input type="button" value=" 取 消 " onclick="closeWin()" />
        </div>
    </div>
       <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.productioncollection.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        var scanSN = getQueryString("sn");
        var stationId = getQueryString("stationid");
        var resourceId = getQueryString("resourceid");
        var chkNcDataId = -1; //不良记录ID
        var chkNcDataCode = ""; //不良原因代码
        var arrRepairLog = []; //提交之前,临时保存不良维修记录
        var bomId = -1;//产品BomId
        var unitId = -1;
        var userId =<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        var repairSN = "";
        //部件更换
        var bomListCount = 0;
        var assyDataChangeRecords = [];
        var assyDataId = -1;
        var selectMode = "notSequence";
        var orderId = -1;
        var linePlanType = -1;
        //是否修改不良原因代码标记
        var UpdateSign = "0";
        //不良数量
        var myNGQty = 0;

        $(function () {
            bindPrinters('selPrintersList');
        });

        $().ready(function () {
            if(scanSN.toString().length>85){
                $("#lblSN").text(scanSN.toString().substring(0,85)+"...").attr("title",scanSN);
            }
            else{
                $("#lblSN").text(scanSN).attr("title",scanSN);
            }
            loadNCCode();
            loadDestinationOpe();
            //update by weixia on 2018.5.23 增加产品报废，有对应权限，该按钮方可显示
            if(IsHasPermission(userId,80010901)){
                $("#buttonScrap").show();
            }

        });

        function IsHasPermission(userId_int, popedom_int) {
            return SKT.LeanMES.Web.AjaxServices.AjaxClient.IsPermission(userId_int, popedom_int).value;
        }

        /**
        * 加载条码相关的不良记录
        **/
        function loadNCCode() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNcCodeDetail(scanSN,"");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
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
                cell.colSpan = 8;
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
                    if(i == 0){
                        unitId = entity.UID;
                        myNGQty = entity.NCQty;
                        orderId = entity.ProdOrderID;
                        linePlanType = entity.LinePlanType;
                    }
                    row = setTable.insertRow(setTable.rows.length);
                    row.className = 'ListTableOddRow';

                    if (entity.Status != "Open") {
                        row.style.color = "#9C9C9C";
                        isclosecount++;
                    }

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = entity.Status == "Open" ? "<input name=\"chkSelect\" onclick=\"loadNCDetail(this)\" type=\"checkbox\" value='" + entity.NCDataId + "'>" : "!";

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = "<span>"+entity.SN+"</span>";//entity.NCDataId;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = "<input type=\"text\" name=\"txtNCCode\"  value='" + entity.NCCode + "' class=\"TextBox txtNCCode\"  disabled=\"disabled\" style=\" width:85%;\"  />"
                        +'<input type="button" id="bnOper" class="ButtonBox" onclick="selectNcCode(this)" value="..." />'
                        + "<input type=\"hidden\" name=\"hdNCID\" class=\"hdNCID\" value='" + entity.NCID + "'  />";

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = "<span name='spDescription' class='spDescription'>" + entity.NCQty + "</span>"; //entity.NCQty;

                    cell = row.insertCell(4);
                    cell.align = "center";
                    cell.innerHTML ="<span name='spDescription' class='spDescription'>"+entity.Description+"</span>"; //entity.Description;

                    cell = row.insertCell(5);
                    cell.align = "center";
                    cell.innerHTML =  "<span name='position'>"+entity.Position+"</span>";//不良位置

                    cell = row.insertCell(6);
                    cell.align = "center";
                    cell.innerHTML = entity.Status;

                    cell = row.insertCell(7);
                    cell.align = "center";
                    cell.innerHTML = entity.Station;

                    cell = row.insertCell(8);
                    cell.align = "center";
                    cell.innerHTML = entity.ResName;

                    cell = row.insertCell(9);
                    cell.align = "center";
                    cell.innerHTML = entity.CreateDateTime;
                }
                /********如果有不良，并且处于关闭状态的不良数量和总的不良数量相等，
                那么，点击完成关闭时，直接跳过是否选择不良的检查。
                *******/
                if (entityAry.length == isclosecount) {
                    chkNcDataId = -2;
                }

            }
        }

        /**
        * 选中某个NC，获取这个NC的详细信息(Data Type)
        **/
        function loadNCDetail(obj) {
            var strObj = obj.parentElement.parentElement;
            if($(strObj).find(".hdNCID").val()=="-1"){
                var chk = document.getElementsByName("chkSelect");
                for (var i = 0; i < chk.length; i++) {
                    chk[i].checked = false;
                    chk[i].parentNode.parentNode.style.backgroundColor = "#FFFFFF";
                }
                alert("请先修改不良原因代码！");
                chkNcDataId = -1;
                chkNcDataCode = "";
                $("#tabNCDetail tr:gt(1)").remove();
                return false;
            }

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
                
                //var s=$(strObj).find(".txtNCCode").val();
                //$(rowObj).find(".hdNCID").val(list[0][0]);

                repairSN = obj.parentNode.parentNode.cells[1].innerText;
                chkNcDataCode = $(strObj).find(".txtNCCode").val();//obj.parentNode.parentNode.cells[2].innerText;
                checkId = obj.parentNode.parentNode.cells[1].innerText;

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNcDataDesc(chkNcDataId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    return false;
                }
                var ncCodeArr = jQuery.parseJSON(ajax.value);
                loadNcDesc(ncCodeArr,checkId);
            }
            else {
                chkNcDataId = -1;
                chkNcDataCode = "";
                $("#tabNCDetail tr:gt(1)").remove();
            }
        }

        /**
        * 加载不良记录详情描述
        **/
        function loadNcDesc(list,checkId) {
            var row, cell;
            var entity = {};
            var flage = "";
            var entityAry = list;
            var setTable = document.getElementById("tabNCDetail");

            if (entityAry == null) {
                row = setTable.insertRow(1);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = 4;
                cell.innerHTML = "未找到相关不良详情信息！";
                return false;
            }
            else {
                $("#tabNCDetail tr:gt(1)").remove();
            }
            if (entityAry.length > 0) {
                /***动态创建表***/
                for (var i = 0; i < entityAry.length; i++) {
                    entity = entityAry[i];
                    row = setTable.insertRow(setTable.rows.length);
                    if (i % 2 == 0) {
                        row.className = 'ListTableOddRow';
                    }
                    else {
                        row.className = 'ListTableEvenRow';
                    }

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = checkId;//entity.NCDataId;

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = entity.DataField;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.DataTag;

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.FieldValue;
                }
            }
                        
            showFailure();
            showRepair();
            
            $("#txtFailure").val("");
            $("#txtRepair").val("");
            $("#txtFailure").focus();
             
        }

        /**
        * 加载不良原因代码
        *
        **/
        function showFailure() {
            var txtFailure = $("#txtFailure").val();
            var listFailure = $("#listFailure");
            listFailure.empty();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNCDebugCodeList(scanSN, txtFailure,stationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            var entityAry = jQuery.parseJSON(ajax.value);
            var entity = {};
            for (var i = 0; i < entityAry.length; i++) {
                entity = entityAry[i];
                listFailure.append('<option value="' + entity.NCCodeId + '">' + entity.NCCode + '(' + entity.Description + ')' + '</option>');
            }
            if(entityAry.length==1){
                listFailure.val(entity.NCCodeId);
                listFailure.change();
            }
        }

        /**
        * 加载不良维修方法代码       
        **/
        function showRepair() {
            var txtRepair = $("#txtRepair").val();
            var listRepairs = $("#listRepairs");
            listRepairs.empty();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNCRepairCodeList(scanSN, txtRepair,stationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            var entityAry = jQuery.parseJSON(ajax.value);
            var entity = {};
            for (var i = 0; i < entityAry.length; i++) {
                entity = entityAry[i];
                listRepairs.append('<option value="' + entity.NCCodeId + '">' + entity.NCCode + '(' + entity.Description + ')' + '</option>');
            }
            if(entityAry.length==1){
                listRepairs.val(entity.NCCodeId);
                listRepairs.change();
            }
            /*add by weixia on 2018.5.23 增加报废代码*/
            listRepairs.append('<option value="Scrap">Scrap(产品报废)</option>');
        }

        /**
        * 加载不良原因代码     
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
                //写入日志
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
        * 加载不良维修方法代码      
        * 因为不同的NC Code(Failure, Defect, Repair)所对应的数据类型不同
        * 也就是要收集的数据不同，所以，当选择一个NC Code时，其对应的数
        * 据收集窗口的显示也是不同的，这个函数主要是为了动态地切换数据收集
        * 窗口的内容，以确保正确的收据被收集 
        **/
        function repairCodeSelect(obj) {
            var sltRepair = $(obj).find("option:selected")
            var txtRepair = sltRepair.text();
            var txtRepairId = sltRepair.val();
            if(txtRepairId=="Scrap"){
                return;
            }
            $("#txtRepair").val(getNCCode(txtRepair));

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNCCodeDataField(txtRepairId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
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
                cell.innerHTML = '<input style="width:90px;" type="' + types + '" name="dtxtValue" value="" ' + required + ' ' + dataTypes + ' class="TextBox" onchange="checkFormat(this)" />' + reTag;
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
            cell.innerHTML = '<input style="width:90px;" type="' + types + '" name="txtValue" value="" ' + required + ' ' + dataTypes + ' class="TextBox" onchange="checkFormat(this)" />' + reTag;
        }

        /**
        *   加载维修之后的目的工位
        **/
        function loadDestinationOpe() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetRepairNextStation(scanSN, stationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            var html = "";
            var list = jQuery.parseJSON(ajax.value);

            if (list.length > 0) {
                html += '<option value="-1">--请选择--</option>';
                for (var i = 0; i < list.length; i++) {
                    html += '<option value="' + list[i].Outgoing_OpeID + '">' + list[i].Station + '</option>';
                }
            }
            else {
                html += '<option value="-1">' + getResource("lang", "NoData") + '</option>';
            }

            $("#selDestinationOpeId").html(html);
            //当目的工位只有一个时 默认选择
            if (list.length == 1) {
                $("#selDestinationOpeId option").eq(1).attr("selected", true);
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
                alert('请选择不良原因代码！');
                return false;
            }

            if (sltRepair == null) {
                alert('请选择维修方法代码！');
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
            cell.innerHTML = "<span name='ncdataid' style='display:none;' >"+chkNcDataId+"</span>"+repairSN;

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
            showFailure();
            showRepair();
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
        *   保存完成维修操作
        **/
        function finishedProductRepair() {
            var destinationOpeId = $("#selDestinationOpeId option:selected").val();
            if (destinationOpeId < 0) {
                alert("请选择维修之后的目的工位！");
                $("#selDestinationOpeId").focus();
                return false;
            }
           
            /*用于没有不良，或者不良都已维修的情况下，直接跳过验证和记录保存。*/
            if (chkNcDataId == -1) {
                closeWin();
            }          
               
            var dataLog = "";

            for (var i = 0; i < arrRepairLog.length; i++) {
                dataLog = dataLog + arrRepairLog[i] + ";"
            }
        
            var resultAjax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.SynthesisRepairPartsChange(unitId, stationId, resourceId, userId, dataLog, bomId, formatAssyDataChangeRecordsToXML());
            if (resultAjax.error == null) {   
           
                if(allNCisRepair()){                    
                   
                    //校验当前维修的SN是否是批次SN，如果是批次SN，需要填写维修数量
                    var info = { UnitID: unitId };
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspRepairIsCheckBatchSN", JSON.stringify(info));
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    var list = JSON.parse(ajax.value);
                    var listOrder = list.data;
                    var IsBatch = listOrder[0].AcquisitionMode;//是否批次，1单件，2批次
                    labelItemId = listOrder[0].ItemID;
                    labelProdOrderId = listOrder[0].ProdOrderID;
                    if (IsBatch == 2 && $("#txtBatchRepairQty").val() == "") {
                        alert("当前SN为批次SN，请填写维修数量！");
                        $("#txtBatchRepairQty").focus();
                        return false;
                    }
                    if (IsBatch == 2 && parseFloat($("#txtBatchRepairQty").val()) <= 0) {
                        alert("维修数量必须大于0！");
                        $("#txtBatchRepairQty").focus();
                        return false;
                    }
                    if (IsBatch == 2 && parseFloat($("#txtBatchRepairQty").val()) > myNGQty) {
                        alert("维修数量不能大于条码数量！");
                        $("#txtBatchRepairQty").focus();
                        return false;
                    }
                    var myRepairQty=$("#txtBatchRepairQty").val();
                    //如果是批次维修，维修数量小于不良数量时，系统根据批次条码对应的产品维护的批次条码规则进行维修批次条码打印
                    //同时原SN的不良记录（Prod_NcData）需要重新激活维修状态(status:Closed改为Open)，使其可以再次重新维修，并且不良数量(NGQty,NCQty)需要减去已维修数量
                    //条码生成完毕之后，使用新生成的SN进行过站操作   snake.lu  2023年10月25日16: 29: 59
                    if (IsBatch == 2 && parseFloat($("#txtBatchRepairQty").val()) != myNGQty) {
                        var info = { UnitID: unitId, RepairQty: myRepairQty, StationID: destinationOpeId,UserID: userId };
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspRepairBatchSNSave", JSON.stringify(info));
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return false;
                        }
                        var list = JSON.parse(ajax.value);
                        var listOrder = list.data;
                        //使用新生成的SN进行过站操作
                        unitId = listOrder[0].UID;
                        scanSN = listOrder[0].SN;
                    }
                    var passType=1;
                    //有多个目的工位
                    if($("#selDestinationOpeId option").length>2){
                        passType=2;
                    }
                     //所有条码相关的不良都已维修好,可以进行过站操作
                    var resultAjax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.NcRepairUnitComplete(unitId,stationId, destinationOpeId, userId, resourceId, passType);
                    if(resultAjax.error!=null){
                        alert(resultAjax.error.Message);
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, "", resultAjax.error.Message);
                        return false;
                    }

                    window.parent.showAreaMessge(scanSN + ':维修完成！', "messageGreen");
                    window.parent.setMessageBox(scanSN + '维修完成', 'messageGreen');
                    window.parent.refreshProInfoBySN(scanSN);
                    //打印SN
                    if (IsBatch == 2 && parseFloat($("#txtBatchRepairQty").val()) != myNGQty) {
                        //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                        getDocumentInfo()
                        try {
                            //将SN信息添加到SNInfo的SNInfo.SNList集合中
                            SNInfo = {};
                            SNInfo.SNList = scanSN.split(',');
                            mesLabLabelPrint(SNInfo.SNList);
                        }
                        catch (e) {
                            $("#lblMessage").html(e);
                            $("#lblMessage").show();
                        }
                    }
                    else {
                        alert('维修完成！');
                        closeWin();
                    }
                }
                //closeWin();
            } else {
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", resultAjax.error.Message);
                alert(resultAjax.error.Message);
                return false;
            }
        }


        /**
        *   查询是否所有产品条码相关的
        *   不良记录都已维修好
        **/
        function allNCisRepair(){
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNcCodeDetail(scanSN,"Open");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            var ncCodeArr = jQuery.parseJSON(ajax.value);
           
            return ncCodeArr.length >0 ? false : true;
        }

        /**
        *   取消操作
        **/
        function closeWin() {
            window.parent.$("#txtSN").focus();
            window.parent.closeDialog();
        }

        /**
        *   数据采集格式验证
        **/
        function checkFormat(inputObj) {
            var format = $(inputObj).attr("dataTypes");
            if (format == "CheckBox") {
                inputObj.value = (inputObj.checked ? getResource("lang", "AC_YES") : getResource("lang", "AC_NO"));
            } else {
                if ($.trim(inputObj.value) != "") {
                    if (format == "Number") {
                        var reg = new RegExp(/^-?[1-9]+(\.\d+)?$|^-?0(\.\d+)?$|^-?[1-9]+[0-9]*(\.\d+)?$/);

                        if (!reg.test(inputObj.value)) {
                            alert(getResource("Messages", "AC_NumberOnly"));
                            inputObj.focus();
                            inputObj.value = "";
                        }
                    } else if (format == "Date") {
                        /*此处日期格式暂未验证...*/
                    }
                }
            }
        }

       
        /*不良点录入按钮被点击 打开不良点录入界面*/
        function ncCodeTypeIn(win) {
            winParentR = win;

            if (chkNcDataId < 0) {
                alert("请先选择要录入不良点的不良原因代码！");
                return false;
            }

            var html = '<table class="ListTable" cellspacing="0" cellpadding="4"';
            html += ' style="border-width:0px;width:100%;border-collapse:collapse;">';

            html += '<tr class="ListTableHeader">';
            html += '<th scope="col" colspan="2" style="text-align:left;background:url(../../images/tablistbg.png) repeat-x;">';
            //html += getResource("lang", "AC_NCCode");
            html += '</th>';
            html += '</tr>';

            html += '<tr class="ListTableHeader">';
            html += '<td style="text-align:center;">';
            html += getResource("lang", "AC_NCCode") + '：';
            html += '</td><td style="margin-right:5px;">';
            html += '<input type="text" id="txtModel" onkeyup="winParent.loadNCCodeList(window,this.value)" class="TextBox" style="width: 97%;" />';
            html += '</td>';
            html += '</tr>';

            html += '<tr class="ListTableOddRow">';
            html += '<td colspan="2" style="text-align:center;padding:0px;padding-bottom:20px;background-color:#f7f7f7;">';
            html += '<table id="tabNCCode" cellspacing="0" cellpadding="0"';
            html += ' style="width:100%;border-collapse:collapse;">';
            html += '<tr class="ListTableHeader" style="background:url(../../images/tablistbg.png) repeat-x;">';
            html += '<td style="text-align:center;">';
            html += '</td>';
            html += '<td style="text-align:center; width:120px;">';
            html += getResource("lang", "AC_NCCode");
            html += '</td>';
            html += '<td style="text-align:center;">';
            html += getResource("lang", "AC_DR_NCDesc");
            html += '</td>';
            html += '</tr>';

            html += '<tbody id="tbNCCode">';
            html += '</tbody></table>'
            html += '</td>';
            html += '</tr>';
            html += '</table>';

            var btns = [
	        { icon: "save", text: getResource("lang", "AC_Change"), click: "winParent.saveNCCode(window);" },
	        { icon: "return", text: getResource("lang", "AC_Cancel"), click: "winParent.returnToRepair(window);" }
            ];

            modalDialog({ title: getResource("lang", "AC_NCCode"), html: html, width: 450, height: 280, onload: "ncCodePageLoad", buttons: btns });
        }

        /**
        *   不良点录入弹窗加载方法
        **/
        function ncCodePageLoad(win) {
            loadNCCodeList(win, '');
        }

        /**
        *   加载不良原因代码列表信息
        **/
        function loadNCCodeList(win, nccode) {
            var tbNCCode = win.document.getElementById("tbNCCode");
            var $tbNCCode = $(tbNCCode);

            var html = "";
            var ncDataType = "Defect";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetNCCodeList(ncDataType, nccode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var list = jQuery.parseJSON(ajax.value);
            var len = list.length;
            for (var i = 0; i < len; i++) {
                var modellist = list[i];
                html += '<tr><td><input type="checkbox" name="checkNCCode" value="' + modellist.NCCodeId + '" /></td>';
                html += '<td>' + modellist.NCCode + '</td>';
                html += '<td>' + modellist.Description + '</td></tr>';
            }

            if (ajax.value.length < 1) {
                $(tbNCCode).html('<tr><td colspan="3">' + getResource("lang", "NotData") + '</td></tr>');
            }
            else {
                $(tbNCCode).html(html);
            }
        }

        /**
        *   不良点录入保存
        **/
        function saveNCCode(win) {
            var ncCodeId = -1;
            win.$("input[name ='checkNCCode']").each(function () {
                if ($(this).is(":checked")) {
                    ncCodeId = this.value;
                    return false;
                }
            });
            if (ncCodeId == -1) {
                alert('请选择不良原因代码！');
                return;
            }
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.UpdateTypeInNCCode(chkNcDataId, ncCodeId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            else {
                loadNCCode();
                returnToRepair(win);
            }
        }

        /**
        *不良原因代码弹窗取消操作
        **/
        function returnToRepair(win) {
            win.closeModalDialog();
            return;
        }

        /**
        *   物料更换按钮被点击 打开物料更换操作界面
        **/
        function materialReplacement(win) {
            winParentR = win;
            if (chkNcDataId<0 ) {
                alert("请先选择要维修的不良记录！");
                return false;
            }
            if(orderId <= -1){
                alert("未获取到工单信息！");
                return false;
            }
            //打开维修物料更换窗口                           
            dialog({ title:  "物料更换", src:  "../Client/MaterialReplacement.aspx?ncdataid=" + chkNcDataId  + "&prodOrderId=" + orderId + "&linePlanType=" + linePlanType +"&rnd=" + Math.random(), width: 800, height: 500 });
            return false;	      
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
 

        /*弹出线程阻塞式窗口*/
        function modalDialog(options) {
            var defaults = {
                title: "SKT LeanMES Dialog",
                width: 980,
                height: 580,
                buttons: "activeRow",
                html: "Empty Document.",
                onload: ""
            }
            options = $.extend(defaults, options);

            var url = "../Content/plugin/modalDialog/modalDialog.html?rnd=" + Math.random();
            var features = "status:0;resizable:0;scroll:0;dialogWidth:" + options.width + "px;dialogHeight:" + options.height + "px;help:0;edge:sunken;";

            window.showModalDialog(url, [options.html, window, options.onload, options.title, options.height, options.buttons], features);
        }

        /**
        *   JS获取系统定义的资源文本
        */
        function getResource(resClass, resKey) {
            return SKT.LeanMES.Web.AjaxServices.AjaxClientController.GetResourceString(resClass, resKey).value;
        }

        /*产品报废*/
        function  saveScrap(win){
            if(!confirm("确定该产品SN报废?")){
                return  false;
            }
            var sltRepair = $("#listRepairs").val();
            if(sltRepair !="Scrap"){
                alert("请选择Scrap维修方法代码,才能产品报废!");
                return  false ;
            }
            //获取目的工序
            var destinationOpeId = $("#selDestinationOpeId option:selected").val();
            if (destinationOpeId < 0) {
                alert("请选择报废之后的目的工位！");
                $("#selDestinationOpeId").focus();
                return false;
            }
            var passType=1;
            //有多个目的工位
            if($("#selDestinationOpeId option").length>2){
                passType=2;
            }
            //获取哪个序号：
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.SaveSNScrap(repairSN,stationId,resourceId,destinationOpeId,userId,passType)
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            else {
                win.parent.showAreaMessge(scanSN + ':报废完成！', "messageGreen");
                win.parent.setMessageBox(scanSN + '报废完成', 'messageGreen');
                win.parent.refreshProInfoBySN(scanSN);
                closeWin();
            }

        }
        var rowObj = null;
        function selectNcCode(obj) {
            rowObj = obj.parentElement.parentElement;
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=113&CallBackFunc=getChooseValuesNcCode&Multiple=false&rnd=" + Math.random(), width: 680, height: 350
            });
        }

        function getChooseValuesNcCode(list) {
            $(rowObj).find(".txtNCCode").val(list[0][1]);
            $(rowObj).find(".hdNCID").val(list[0][0]);
            $(rowObj).find(".spDescription").text(list[0][2]);
            UpdateSign="1";
        }
        
        $("#txtLocation").live("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                var location =  $.trim(this.value);
                if(location == ""){
                    return false;
                }

                var scanLocation = $.trim($("#txtScanLocation").val());
                if(scanLocation == ""){
                    $("#txtScanLocation").val(this.value);
                }
                else{                    
                    var arr = scanLocation.split(",");                    
                    if(arr.filter(function(v){return v.toLowerCase()==location.toLowerCase()}).length==0){
                        $("#txtScanLocation").val(scanLocation+","+location);
                    }                                 
                }
                $(this).val("").select();
            }
        });
                

        function confirmLocation(){
            var txtLocation = $("#txtScanLocation").val();
            if(txtLocation == ""){
                alert("请扫描位号！");
                $("#txtLocation").select();
                return false;
            }

            $("input[name=chkSelect]:checked").parent().parent().find("span[name=position]").text(txtLocation);

            var entity = {};
            entity.NcDataId = chkNcDataId;           
            entity.Position = txtLocation;           
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspUpdateNcPostion", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            closeLocation();
        }

        function setLocation(){
            if (chkNcDataId < 0) {
                alert("请先选择要录入不良位置的不良原因代码！");
                return false;
            }

            var position = $("input[name=chkSelect]:checked").parent().parent().find("span[name=position]").text();

            $("#txtScanLocation,#txtLocation").val("");
            $("#ncLocation").show();
            $("#txtScanLocation").val(position);
            $("#txtLocation").select();
        }

        function closeLocation(){
            $("#txtScanLocation,#txtLocation").val("");
            $("#ncLocation").hide();
        }

        function clearLocation(){
            $("#txtScanLocation,#txtLocation").val("");
            $("#txtLocation").select();
        }


        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '<%=Request.QueryString["ItemID"] %>';    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -36;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单-36:批次产品条码)
        var labelSequence = 1;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径
        var printCount = 1;        //打印份数：默认一次
        var templateGroup = 1;//新打印连板数
        //获取文档模板基础信息
        function getDocumentInfo() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                templateGroup = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintTemplateGroup(labelDocumentId).value;
                lableTypeQty = entity.PlateQty;
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                printCount = entity.Print_Qty;

            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }

            //初始化打印插件
            //InityPrintingPlugin();
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint(list) {
            if (list.length == 0) {
                ibs = 3 * printCount;
                setInterval(function () { $("#lblPt").html("打印条码完成！"); ibs-- }, 1000)
                setTimeout(function () {
                    document.forms[0].submit();
                }, 3000);
                return;
            }
            var sendQty = <%=ConfigurationManager.AppSettings["PrintSendQty"]%>;

            while (sendQty % templateGroup != 0) {
                sendQty++;
            }
            //从list中取出 sendQty 作为打印的数量，并且list截取掉sendQty
            var newlist = list.splice(sendQty);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfo(labelDocumentId, list, -1, -1, -1, labelItemId, labelProdOrderId);
            if (ajax.error == null) {
                if (ajax.value.length == 0) {
                    alert("没有找到该产品关联的模板信息");
                    return;
                }
            } else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return;
            }
            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, function (success, ws) {
                if (!success) {
                    if (ws && ws.readyState != 1)
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    return;
                }
                recordPrint(list);
                mesLabLabelPrint(newlist);
            },<%=ConfigurationManager.AppSettings["PrintType"]%>);

        }

        function recordPrint(list) {
            setTimeout(function () {
                for (var r = 0; r < list.length; r++) {
                    var printRecodeEntity = {};
                    printRecodeEntity.RecordId = -1;
                    printRecodeEntity.ActionType = 1;
                    printRecodeEntity.PrintType = -2;
                    printRecodeEntity.PrintKey = list[r];
                    printRecodeEntity.StationId = -1;
                    printRecodeEntity.ResourceId = -1;
                    var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
                    if (ajaxPrintRecodes.error != null) {
                        alert(ajaxPrintRecodes.error.Message);
                        $("#lblMessage").html(ajaxPrintRecodes.error.Message);
                        return false;
                    }
                }
            }, 10);
        }
        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/

    </script>
</asp:Content>
