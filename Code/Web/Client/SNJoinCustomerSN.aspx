<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="SNJoinCustomerSN.aspx.cs" Inherits="SKT.LeanMES.Web.Client.SNJoinCustomerSN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">请扫描SN条码<em style="color: red">*</em></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                        </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                    <input type="checkbox" id="chkRePrint" title="如果您的客户条码标签需要重打，点击选择此复选框" value="0" />
                        重印&nbsp;&nbsp;
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked />
                        <%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" />
                    </td>
                </tr>
                <tr name="trCustomerSN">
                    <td align="left" colspan="2">
                        <span class="scan-center-title" id="Span1">请扫描客户SN条码<em style="color: red">*</em></span>
                    </td>
                </tr>
                <tr name="trCustomerSN">
                    <td align="left" colspan="2">
                        <input type="text" id="txtCSN" class="scan-center-sn" />
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <table id="tabDataField" cellpadding="0" cellspacing="0" border="0" style="width: 100%">
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.LastStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="laststationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="right">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.NextStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="nextstationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td valign="top" style="width: 100%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                客户SN关联列表</div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 50px;">
                                            <%=Resources.lang.Sequence%>
                                        </th>
                                        <th style="width: 100px;">
                                            <%=Resources.lang.SerialNumber %>
                                        </th>
                                        <th style="width: 200px;">
                                            客户SN
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlist">
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
           <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
   <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.print.js?v=20211012" type="text/javascript"></script>
    <script language="javascript"  type="text/javascript">
        var resourceId = 0;
        var stationId = 0;
        var regExpress = "";
        var joinType = 3; //客户条码关联方式：1、在线打印客户条码 2、离线打印客户条码 3、外购客户条码关联
        var isValid = true;

        String.prototype.trim = function () {
            return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
        }

        $(document).ready(function () {
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('SNJoinCustomerSN');
                },
                10
            );

            //扫描框回车事件
            $("#txtCSN").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        $("#txtCSN").val($.trim($("#txtCSN").val()));
                        var customer = $.trim($("#txtCSN").val());
                        if (joinType == 3 && regExpress != "" && customer != "") {
                            var regular = regExpress;
                            var regularArr = regular.split(';');
                            var reg;
                            if (regularArr != undefined && regularArr.length > 0) {
                                for (var i = 0; i < regularArr.length; i++) {
                                    reg = new RegExp(regularArr[i]);
                                    if (!reg.test(customer)) {
                                        var errmsg = customer + ":客户条码不符合系统设定的验证规则！";
                                        showAreaMessge(errmsg, "messageRed");
                                        setMessageBox(errmsg, "messageRed");
                                        $("#txtCSN").select();
                                        return false;
                                    }
                                }
                            }
                        }
                        afterScan();
                    }
                    if (curKey == 46) {
                        $("#txtSN").val("");
                    }
                }
            );
            stationId = $("#hdnCurrStationId").val(); //工位Id
            resourceId = $("#hdnCurrResourceId").val(); //资源Id            
            if (!stationId > 0) {
                alert("请先在操作菜单列表进行切换工位操作！");
                return;
            }

            lableType = -16; //客户条码打印
            lableSequence = 5//序号              
        });

        /**
        *扫描触发事件
        */
        function afterScan(asstype) {
            $("#txtSN").val($.trim($("#txtSN").val()));
            if ($.trim($("#txtSN").val()) != "") {
                if ($("#cbxforceuppercase").prop("checked")) {
                    scanSN = ($.trim($("#txtSN").val()).toUpperCase());
                }
            }
            else {
                $("#txtSN").focus();
                return false;
            }


            //验证扫描的条码信息

            //检查是否有配置采集的数据参数，没有则在列表中新增
            if (!checkDataFieldExist()) {
                return false;
            }

            if (joinType > 1) {//非在线打印条码的                   
                if ($.trim($("#txtCSN").val()) != "") {                   
                    $("#txtCSN").val($.trim($("#txtCSN").val()).toUpperCase());
                }
                else {
                    $("#txtCSN").focus();
                    return false;
                }                
            }

            //检验是否所有采集的数据类型是否都有值
            var bneedInput = true;
            $("input[name='dtxtValue']").each(function () {                
                if ($.trim($(this).val()) != "") {
                    $(this).val($.trim($(this).val()).toUpperCase());
                }
                else if ($(this).attr("requireds") == "1" && asstype == 1) {//由于是数据类型填写完成后，只验证必填的内容，非必填则可以为空
                    bneedInput = false;
                    $(this).focus();
                    return false;
                }
                else if (asstype != 1) {//如果是SN或者CSN回车后验证过来的，则需要检查所有的内容是否都已经填写，如果没有则需要焦点到它，继续填写
                    bneedInput = false;
                    $(this).focus();
                    return false;
                }
            });
           
            if (!bneedInput) {
                return false;
            }
           
            var isValid = true;
            //保存前再次检测客户条码规则
            var customer = $.trim($("#txtCSN").val());
            if (joinType == 3 && regExpress != "" && customer != "") {
                var regular = regExpress;
                var regularArr = regular.split(';');
                var reg;
                if (regularArr != undefined && regularArr.length > 0) {
                    for (var i = 0; i < regularArr.length; i++) {
                        reg = new RegExp(regularArr[i]);
                        if (!reg.test(customer)) {
                            var errmsg = customer + ":客户条码不符合系统设定的验证规则！";
                            showAreaMessge(errmsg, "messageRed");
                            setMessageBox(errmsg, "messageRed");
                            $("#txtCSN").select();
                            return false;
                        }
                    }
                }
            }

            //保存时再次检测采集数据规则
            $("input[name='dtxtValue']").each(function (obj) {
                var regular = ($(this).attr("regularExpression"));
                if (regular != undefined && regular != "") {
                    var regularArr = regular.split(';');
                    var reg;
                    if (regularArr != undefined && regularArr.length > 0) {
                        for (var i = 0; i < regularArr.length; i++) {
                            reg = new RegExp(regularArr[i]);
                            if (!reg.test($(this).val())) {
                                errmsg = "[" + $(this).val() + "]不符合系统设定的验证规则！";
                                alert(errmsg);
                                isValid = false;
                                n = $(this).attr("dataFieldId");
                                setTimeout(function () {
                                    $("input[dataFieldId='" + n + "']").select();
                                }, 100);
                                return false;
                            }
                            else {
                                isValid = true;
                            }
                        }
                    }
                }
            });

            if (!isValid) {
                return false;
            }

            if (mainProcess($("#txtSN").val(), $("#txtCSN").val())) {
                $("#txtCSN").val("");
                $("#txtSN").val("").focus();         
                $("input[name='dtxtValue']").each(function () {
                    $.trim($(this).val(""));
                });
            }
        }
        
        /*
        * 检查数据类型的字段是否有在加载
        */
        function checkDataFieldExist() {

            var tabDataField = document.getElementById("tabDataField");
            var scanSN = $.trim($("#txtSN").val()); //扫描Sn

            //通用验证SN条码
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxJoin.CheckJoinCustomerSN(scanSN, stationId, resourceId);
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                setMessageBox(ajax.error.Message, "messageRed");
                $("#txtCSN").val("");
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                clearDataField();
                return false;
            }

            joinType = ajax.value[0];
            regExpress = ajax.value[1];
            
            if (joinType == 1) {//如果为在线打印客户条码的模式
                //$("#txtCSN").attr("disabled", "disabled");
                $("#txtCSN").val(ajax.value[2]);
                $("tr[name='trCustomerSN']").hide();
            }
            else {
                $("tr[name='trCustomerSN']").show();
            }
            //查询SN是否有配置数据类型
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxJoin.GetStationDataField(scanSN, stationId);
            if (ajax.error != null) {
                showAreaMessge(ajax.error.Message, "messageRed");
                setMessageBox(ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                $("#txtCSN").val("");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                clearDataField();
                return false;
            }
           
            ajax = ajax.value;
            if (ajax.length == 0) {
                clearDataField();
                return true;
            }

            //验证每个项是否都存在
            var bExist = true;
            var rowLength = tabDataField.rows.length;
            var entitylength = ajax.length;
            for (i = 0; i < entitylength; i++) {
                var bFieldExist = false;
                for (j = 0; j < rowLength; j++) {
                    if (tabDataField.rows[j].cells[0].title == ajax[i].DataFieldId) {
                        bFieldExist = true;
                        break;
                    }
                }

                if (!bFieldExist) {
                    bExist = bFieldExist;
                    break;
                }
            }
            
            //全部都能对照且数量相同，那么就直接退出
            if (bExist && tabDataField.rows.length == ajax.length * 2) {                
                return true;
            }
            else {
                //不是全部数据字段都相同的话，可能是换了产品！所以先删除所有的数据字段，再添加新的新的数据字段
                clearDataField();

                for (i = 0; i < entitylength; i++) {
                    var entityData = ajax[i];

                    rowNewIdx = tabDataField.rows.length;
                    row = tabDataField.insertRow(rowNewIdx);

                    //数据类型名称
                    cell = row.insertCell(0);
                    cell.align = "left";
                    var reTag = (entityData.Required == false ? '' : '<em style="color:red">*</em>');
                    cell.innerHTML = '<span class="scan-center-title" name="assbly">' + entityData.DataTag + reTag + '</span>';


                    row = tabDataField.insertRow(rowNewIdx + 1);
                    //创建控件
                    cell = row.insertCell(0);
                    cell.align = "left";
                    cell.title = entityData.DataFieldId;
                    var selectType = entityData.DataType;
                    if (selectType == "Data") {
                        var required = (entityData.Required == false ? 'requireds="0"' : 'requireds="1"');
                        var types = "Data";
                        var dataTypes = 'dataTypes="' + entityData.DataType + '"';
                        var remarkStr = entityData.Remark.split(",");
                        var html = "";
                        for (var i = 0; i < remarkStr.length; i++) {
                            html += '<option value=' + remarkStr[i] + '>' + remarkStr[i] + '</option>';
                        }
                        cell.innerHTML = ' <select style="width:100%;"  name="dtxtValue" class="textClass" onchange="checkFormat(this)">' + html + '</select>';
                    }
                    else {
                        var required = (entityData.Required == false ? 'requireds="0"' : 'requireds="1"');
                        var types = (entityData.DataType == "CheckBox" ? "checkbox" : "text");
                        var dataTypes = 'dataTypes="' + entityData.DataType + '" regularExpression="' + entityData.Remark + '"';
                        cell.innerHTML = '<input type="' + types + '" name="dtxtValue" dataFieldId=' + entityData.DataFieldId + ' value="" ' + required + ' ' + dataTypes + ' class="scan-center-sn" onkeydown="dtxkeydown(this,event)" />';
                    }
                }
                return true;
            }
        }

        /**
        *   保存时，将组装部件变更记录转换为XML。
        */
        function formatAssyDataChangeRecordsToXML() {
            var tabDataField = document.getElementById("tabDataField");
            var rowLength = tabDataField.rows.length;
            var xml = "<AssyDataChangeRecords>";
            for (var i = 0; i < rowLength; i++) {
                var row = tabDataField.rows[i];
                if (row.cells[0].title != undefined && row.cells[0].title != "") {
                    xml += "<Data>";
                    xml += "<AssyDataIdString>" + row.cells[0].title + "</AssyDataIdString>";
                    xml += "<AssyDataValString>" + $(row.cells[0]).children(0).val() + "</AssyDataValString>";
                    xml += "</Data>";
                }
            }
            xml += "</AssyDataChangeRecords>";

            return xml;
        }

        function dtxkeydown(obj, e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;

            if (curKey == 13) {
                checkFormat(obj);
            }
            if (curKey == 46) {
                $("#txtSN").val("");
            }
        }

        /**
        *   数据采集格式验证
        **/
        function checkFormat(inputObj) {
            var format = $(inputObj).attr("dataTypes");
            var regular = $(inputObj).attr("regularExpression");
            if (format == "CheckBox") {
                inputObj.value = (inputObj.checked ? getResource("lang", "AC_YES") : getResource("lang", "AC_NO"));
            } else {
                if ($.trim(inputObj.value) != "") {
                    if (format == "Number") {
                        var reg = new RegExp(/^-?[1-9]+(\.\d+)?$|^-?0(\.\d+)?$|^-?[1-9]+[0-9]*(\.\d+)?$/);

                        if (!reg.test(inputObj.value)) {
                            alert(getResource("Messages", "AC_NumberOnly"));
                            $(inputObj).select();
                            return
                        }
                    }
                    else {
                        if (regular != undefined && regular != "") {
                            var regularArr = regular.split(';');
                            var reg;
                            if (regularArr != undefined && regularArr.length > 0) {
                                for (var i = 0; i < regularArr.length; i++) {
                                    reg = new RegExp(regularArr[i]);
                                    if (!reg.test($(inputObj).val())) {
                                        errmsg = "[" + $(inputObj).val() + "]不符合系统定义的字符格式！";
                                        alert(errmsg);
                                        isValid = false;
                                        $(inputObj).select();
                                        return false;
                                    }
                                    else {
                                        isValid = true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            //到末尾行就进行扫描检查，否则就算是跳转到下一行
            var tabDataField = document.getElementById("tabDataField");
            if ($(inputObj).parent().parent()[0].rowIndex == (tabDataField.rows.length - 1)) {
                afterScan(1);
            }
            else {
                var dtxtValue = $(tabDataField.rows[$(inputObj).parent().parent()[0].rowIndex + 2]).find("input[name='dtxtValue']");
                dtxtValue.select();
                dtxtValue.focus();
                return;
            }
        }

        /*
        *执行主序列号相关业务流程
        */
        function mainProcess(sn, csn) {
            //1.获取当前基本信息          
            var scanSN = $.trim($("#txtSN").val()); //扫描Sn
             
            //2.验证SN和CSN是否有被绑定过
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxJoin.ValidateSNAndCSNJoin(sn, csn);
            if (ajax.error != null) {
                showAreaMessge(ajax.error.Message, "messageRed");
                setMessageBox(ajax.error.Message, "messageRed");
                $("#txtCSN").val("");
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, sn, ajax.error.Message);
                return false;
            }
            var returnValue = JSON.parse(ajax.value); //当前返回string
            if (returnValue.result == "ERROR") {
                showAreaMessge(returnValue.message, "messageRed");
                setMessageBox(returnValue.message, "messageRed");
                if(joinType==1){
                    $("#txtSN").select();
                }else{
                    $("#txtCSN").select();
                }
                return false;
            }
            else if (returnValue.result == "COMFIRM") {
                showAreaMessge(returnValue.message, "messageRed");
                setMessageBox(returnValue.message, "messageRed");
                if(joinType==1){
                    $("#txtSN").select();
                }else{
                    $("#txtCSN").select();
                }                
                return false;
            }

            //3.对SN和CSN进行关联
            var xml = formatAssyDataChangeRecordsToXML();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxJoin.SNAndCSNJoin(scanSN, csn, stationId, resourceId, userId, xml,joinType);
            if (ajax.error != null) {
                showAreaMessge(ajax.error.Message, "messageRed");
                setMessageBox(ajax.error.Message, "messageRed");
                if(joinType==1){
                    $("#txtSN").select();
                }else{
                    $("#txtCSN").select();
                }
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            checkCustomerSNPrint(sn);
            AddRecord(sn, csn);
            refreshProInfoBySN(scanSN);
            showAreaMessge('SN:' + sn + '和客户SN：' + csn + '关联成功！', "messageGreen");
            setMessageBox('SN:' + sn + '和客户SN：' + csn + '关联成功！', "messageGreen");
            $("#txtCSN").removeAttr("disabled");

            return true;            
        }

        /*
        *检查是否需要打印客户条码
        */
        function checkCustomerSNPrint(sn) {
            labelStr = sn;
            lableType = -16; //客户条码打印
            lableTypeQty = 1;
            //如果勾选了重印复选框，则必定会调动打印功能。
            if ($("#chkRePrint").prop("checked")) {
                print();
            }
            else {
                //查询当前工单所跑路由在当前工序是否需要打印包装箱条码。
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CheckIsPrintSN($.trim($("#txtCSN").val()), 3, stationId);
                if (ajax.error != null) {
                    showAreaMessge(sn + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").select();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, $("#txtCSN").val(), ajax.error.Message);
                    return false;
                }
                if (ajax.value == true) {                 
                    print();
                }
            }
        }

        function AddRecord(sn, csn) {
            var bgStyle = "collection-list-ok";
            var html = ''
            + '<tr class="ListTableOddRow">'
            + '<td align="center" valign="middle" >' + collectionIndex[0] + '</td>'
            + '<td align="center" valign="middle">' + sn + '</td>'
            + '<td align="center" valign="middle">' + csn + '</td>'
            + '</tr>';

            //tbody用于更新采集明细
            var control = $("#collectionlist");
            if (control.find('tr').length == COLLECTIONLIST_COUNT) {
                control.find('tr:last').remove();
            }
            //control.find('tr:last').remove();
            var i = 1;
            control.find('tr').each(
                function () {
                    if (i % 2) {
                        $(this).addClass('ListTableEvenRow');
                        $(this).removeClass("ListTableOddRow");
                    } else {
                        $(this).removeClass('ListTableEvenRow');
                        $(this).addClass("ListTableOddRow");
                    }
                    //$(this).find('a:first').text(collectionIndex[i]);
                    $(this).find('td:first').text(collectionIndex[i]);
                    i++;
                }
            );
            control.prepend(html);
        }

        /*
        *清除数据类型字段
        */
        function clearDataField() {
            var tabDataField = document.getElementById("tabDataField");
            var rowLength = tabDataField.rows.length;
            for (i = rowLength - 1; i >= 0; i--) {
                tabDataField.deleteRow(i);
            }
        }
    </script>
</asp:Content>
