<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="AssembleProUnBind.aspx.cs" Inherits="SKT.LeanMES.Web.Client.AssembleProUnBind" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js?v=20211209"
        type="text/javascript"></script>
    <div id="scancenter" class="scan-center">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="left">
                    <span class="scan-center-title" id="labscancentertitle">
                        <%=Resources.lang.AC_OBA_ScanSN %></span> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                        </div>
                </td>
                <td align="right" style="width: 180px;">
                    <%-- <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>--%>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <input type="text" id="txtSN" class="scan-center-sn" style="height: 30px; font-size: 15px;" />
                </td>
                <td width="250px;">
                    &nbsp;&nbsp;
                    <input type="button" id="btnRemove" value=" 移 除 " onclick="remove()" />
                    &nbsp;
                    <input type="button" id="btnScrap" value=" 报 废 " onclick="scrap()" />
                    &nbsp;
                    <input type="button" id="btnReplace" value=" 替 换 " onclick="replace()" />
                    &nbsp;
                    <input type="button" id="btnAssy" value=" 数据采集 " onclick="assyData()"  />
                </td>
            </tr>
        </table>
    </div>
    <table class="ListTable" id="tbCompentList" style="border-width: 0px; width: 100%;
        border-collapse: collapse;" cellspacing="0" cellpadding="2">
        <tbody>
            <tr class="ListTableHeader">
                <th style="width: 35px;" scope="col">
                    <input name="chkAll" id="chkAll" onclick="checkAll(this.checked);" type="checkbox">
                </th>
                <th style="width: 160px;" scope="col">
                    组件条码
                </th>
                <th style="width: 150px;" scope="col">
                    组件编码
                </th>
                <th scope="col">
                    组件名称
                </th>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript">
        var isMultiple = true;
        var RequireOnlyOneRecord = "<%=Resources.Messages.RequireOnlyOneRecord %>";
        var RequireOperateRecord = "<%=Resources.Messages.RequireOperateRecord %>";
        var ConfirmDelete = "<%=Resources.Messages.ConfirmDelete %>";
        var currentRowIndex = -1;
        var mainSN = getQueryString("sn");
        var stationid = getQueryString("stationid");
        var resourceid = getQueryString("resourceid");
        var ncdataid = getQueryString("ncdataid");
        var userId=<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>;
        var scanSN =""
        var isShow ;

        $().ready(function () {
            $("#txtSN").focus();
            if(mainSN!=null){
                $("#btnRemove,#btnScrap,#chkAll").remove();
                scanSN=mainSN;
                isMultiple = false;
                loadAssemble();
            }
        });

        //扫描框回车事件
        $("#txtSN").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if(mainSN==null){
                        afterAssembleSNScan();
                    }
                    else{
                        //选中需替换的部件
                        checkReplacePart();
                    }
                }
                if (curKey == 46) {
                    $("#txtSN").val("");
                }
            }
        );

        /**
        *   扫描触发事件
        **/
        function afterAssembleSNScan() {
            scanSN = $.trim($("#txtSN").val()); //扫描Sn       
            if (scanSN == "") {
                alert("请扫描条码！");
                snFocus();
                return false;
            }
            else {
                loadAssemble();
            }
        }

        /**
        *   查询替换部件信息
        **/
        function checkReplacePart(){
            scanSN = $.trim($("#txtSN").val()); //扫描Sn              
            $("#tbCompentList tr:not(.ListTableHeader)").each(
            function(){                
                if($(this).children("td:eq(1)").text()==scanSN){
                    $(this).css("background","#FFFFE0");
                    $(this).children("td:eq(0)").find("input[name=chkSelect]").prop("checked",true);;
                    setTimeout(function () {
                        replace();
                    }, 200);
                }
                else{
                    $(this).css("background","");
                    $(this).children("td:eq(0)").find("input[name=chkSelect]").prop("checked",false);
                }
            }
            );
            
            $("#txtSN").val("");
            var chk = $("#tbCompentList   tr:not(.ListTableHeader) input[type='checkbox']:checked");
            if(chk.length==0){
                snFocus();
            }
            
        }

        function assyData(){
            var chk = $("#tbCompentList   tr:not(.ListTableHeader) input[type='checkbox']:checked");
            if(chk.length>1){
                alert(RequireOnlyOneRecord);
                return false;
            }
            else if(chk.length==0){
                alert(RequireOperateRecord);
                return false;
            }
            var oldSN = $(chk).parent().next().text();
            showDetail(oldSN,1);
        }
        /**
        *   加载组装信息
        *   --根据主件SN加载组装信息        
        **/
        function loadAssemble() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.GetAssyDataPartInfo(scanSN,stationid);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtSN").val("");
                snFocus();     
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            } 
            loadTable(ajax);   
            $("#txtSN").val("");
                snFocus();          
        }

        function loadTable(list) {
            var row, cell;           
            var entity = {};
            var flage = ""; 
            var entityAry = list.value; 
            var setTable = document.getElementById("tbCompentList");
            //清空原来的内容
            $("#tbCompentList tr:not(.ListTableHeader)").remove();
            if(!entityAry || entityAry.length ==0){                
                row = setTable.insertRow(1);
                row.className = 'ListTableOddRow';                
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan= 4;
                cell.innerHTML = "未找到产品相关装配信息！";
                $("#txtSN").val("");
                snFocus(); 
                return false;
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
                    row.onclick = function(){ try{clk(this);}catch (ex){} };
                    row.onmouseover = function(){ try{mi(this);}catch (ex){} };
                    row.onmouseout = function(){ try{mo(this);}catch (ex){} };
                    row.ondblclick = function(){ try{dblClk(this);}catch (ex){} };

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = "<input name=\"chkSelect\" onclick=\"chkClk(this)\" type=\"checkbox\" value='"+entity.UnitAssyDataId+"'><input type=\"hidden\" name=\"hidIsOffline\" value='"+entity.IsOffline+"' /><input type=\"hidden\" name=\"hidRegex\" value='"+entity.RegularExpression+"'/>";

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = entity.SN;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.ItemCode;

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.ItemName;
                }
            }
        }

        /**
        *   移除组件        
        **/
        function remove() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
             var isOfflineStr = getIsOfflieStr();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.UnBindAssyData(idStr, 1, "", userId, stationid, resourceid,isOfflineStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            else {
                alert("组件移除成功！");                
            }  
            loadAssemble();         
        }

        /**
        *   报废组件        
        **/
        function scrap() {
            var idStr = getRecordIdString();            
            if (idStr == "") return false;
            var isOfflineStr = getIsOfflieStr();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.UnBindAssyData(idStr, 2, "", userId, stationid, resourceid,isOfflineStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            else {
                alert("组件报废成功！");
                loadAssemble();
            }   
        }

        function getIsOfflieStr(){
            var isOfflineStr = "";
            $("input[name=chkSelect]:checked").next().each(
            function(){
                if(isOfflineStr!=""){
                    isOfflineStr+=",";
                }
                isOfflineStr += ($(this).val());
            });             
            return isOfflineStr;
        }

        /**
        *   替换组件--按钮事件        
        **/
        function replace() { 
            var chk = $("#tbCompentList   tr:not(.ListTableHeader) input[type='checkbox']:checked");
            if(chk.length>1){
                alert(RequireOnlyOneRecord);
                return false;
            }
            else if(chk.length==0){
                alert(RequireOperateRecord);
                return false;
            }
            var oldSN = $(chk).parent().next().text();
            $("tr[name='trReplace']").remove();
             $(chk).parent().parent().after("<tr class='ListTableOddRow' name='trReplace'><td></td><td colspan='3' width='160px'>"
             + "<input type='text' id='txtReplaceSN'  onkeydown=replacePart(this,'"+oldSN+"') > 扫描替换组件条码: " 
             +"<span style='color:#5090D8;' >"+ oldSN + "</span></td></tr>");
             setTimeout(function () {
                        $("#txtReplaceSN").focus();
                    }, 100); 
        }

        /**
        *   替换组件--替换事件        
        **/
        function replacePart(obj,oldSN) {
            var e = event || window.event || arguments.callee.caller.arguments[0];           
            if (e && e.keyCode == 13) { // enter 键 
                stopDefault(e);
                var sn = $.trim(obj.value); 
                if(sn==oldSN){
                    alert("替换的组件不能与当前组件条码相同！");
                    $("#txtReplaceSN").val("");
                    setTimeout(function () {
                        $("#txtReplaceSN").focus();
                    }, 100); 
                    return false;
                }
                var chk = $("#tbCompentList  tr:not(.ListTableHeader) input[type='checkbox'][name=chkSelect]:checked");
                var uid = chk.val();
                if(!uid){
                    alert("请选择需替换的组件条码！");
                    $("#txtReplaceSN").val("");
                    setTimeout(function () {
                        $("#txtReplaceSN").focus();
                    }, 100); 
                    return false;
                }
                var prevObj = $(obj).parent().parent().prev();
                var isOffline = prevObj.find("input[type=hidden][name=hidIsOffline]").val();//是否为离线条码
                var regex = prevObj.find("input[type=hidden][name=hidRegex]").val();//离线条码规则
                 
                if(isOffline==1){//如果为离线条码，验证相关规则
                        var regularArr = regex.split(';');
                        var reg;
                        if (regularArr != undefined && regularArr.length > 0) {
                            for (var j = 0; j < regularArr.length; j++) {
                                if (regularArr[j] != "") {
                                    reg = new RegExp(regularArr[j]);
                                    if (!reg.test(sn)) {                                       
                                        isValid = false;
                                    }
                                    else {                                     
                                        isValid = true;
                                        break;
                                    }
                                }
                            }
                            if(!isValid){//错误的条码规则
                                 alert("["+sn+"]不符合离线条码规则！");
                                 $("#txtReplaceSN").val("");
                                setTimeout(function () {
                                    $("#txtReplaceSN").focus();
                                }, 100); 
                                return false;
                            }
                       }
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.UnBindAssyData(uid, 3, sn, userId, stationid, resourceid,isOffline,ncdataid);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtReplaceSN").val("");
                    setTimeout(function () {
                        $("#txtReplaceSN").focus();
                    }, 100); 
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, sn, ajax.error.Message);
                    return false;
                }
                else {
                    if(mainSN !=null){//维修部件替换
                        scanSN = mainSN;
                    }
                    loadAssemble();
                    $("tr[name='trReplace']").remove();
                    $(chk).parent().next().text(sn);
                    $(chk).parent().parent().css("background","");
                    $(chk).removeAttr("checked");
                    showDetail(sn,0);
                    if(!isShow){
                        alert("组件替换成功！");
                    }
                } 
            }
        }

         /*
        *判断是否需要加载数据采集窗口
        */
        function isShowDetail(assySN,flag) {        
            isShow = false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.GetAssyDataDetailInfo(assySN);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, assySN, ajax.error.Message);
                return false;
            }
            if (ajax.value!=null && ajax.value.length > 0) {
                isShow = true;
            }
            else{
                if(flag==1){
                    alert("未找到需要采集的数据项！");
                }                
                isShow = false;
            }
            return isShow;
        }

        /*
        *弹框让用户扫描数据类型字段
        */
        function showDetail(assySN,flag) {
            if (isShowDetail(assySN,flag)) {           
                dialog({ title: '组件相关数据采集', src: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>' + "/Client/CollectAssyMatInfo.aspx?IsReplace=1&SN=" + assySN + "&rnd=" + Math.random(), width: 450, height: 300 });
            }
        }

        function closeDetail() {
            closeDialog();
            $("#txtSN").focus();
        }       

        function snFocus() {
            setTimeout(function () {
                $("#txtSN").focus();
            }, 100);
        }

       
    </script>
</asp:Content>
