<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTFeedValidationEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.SMT.SMTFeedValidationEdit" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <object width="0" height="0" id="AndonActiveX" codebase="../Content/Component/Andon/Andon1.0.1.cab#version=1,0,0,1"
        classid="clsid:685F0A47-944D-4145-BF4E-76A02A422B02">
    </object>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td colspan="4" class="Label" align="left">
                <span class="information16"></span>&nbsp;<%=Resources.lang.OrderAndLineWei%>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Line%>
            </td>
            <td class="Field2">
                <select id="selLine" name="D1" style="width: 200px;">
                </select>
            </td>
            <td class="Label2">
                <%=Resources.lang.MaterialTable%>
            </td>
            <td class="Field2">
                <input type="text" id="txtLoadList" class="TextBox" style="width: 200px;" disabled="disabled"
                    readonly="true" /><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.OrderNo%>
            </td>
            <td class="Field2">
                <input type="text" id="txtOrder" class="TextBox" style="width: 200px;" disabled="disabled"
                    readonly="true" />
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label" align="left">
                <span class="information16"></span>&nbsp;<%=Resources.lang.ScanWei%>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.SlotSN%>
            </td>
            <td class="Field2">
                <input type="text" id="txtSlot" class="TextBox" style="width: 200px; height: 25px;"
                    onkeypress="return  SlotSN(event)" /><em>*</em>
            </td>
            <td class="Label2">
                <%=Resources.lang.FeedSN%>
            </td>
            <td class="Field2">
                <input type="text" id="txtFeedSN" class="TextBox" style="width: 200px; height: 25px;"
                    onkeypress="return  FeedSN(event)" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.GRN%>
            </td>
            <td class="Field2" colspan="3">
                <input type="text" id="txtGRN" class="TextBox" onkeydown="mykeydown(event)" style="width: 200px;
                    height: 25px;" /><em>*</em>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div id="showAI">
        <div id="smalltoolbar">
            <span style="font-weight: bold;"><span>
                <%=Resources.lang.MaterialTable%>:[<span id="loadListspn"></span>] </span><span style="width: 10px;">
                    &nbsp;</span> <span style="height: 10px; width: 30px; display: inline-block; background-color: #FFCC99">
                    </span><span>
                        <%=Resources.lang.AlreadyMaterial%></span> <span style="height: 10px; width: 30px;
                            display: inline-block; background-color: #99FF33"></span><span>
                                <%=Resources.lang.AlreadyOpen%></span> <span style="height: 10px; width: 30px; display: inline-block;
                                    background-color: red"></span><span>
                                        <%=Resources.lang.AlreadyStop%></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="<%=Resources.lang.StartFeed%>" title="<%=Resources.lang.StartFeed%>"
                    id="btnStart" onclick="returnOpen(1);" class="SearchButton" style="font-weight: bolder;
                    font-size: small;" />
                &nbsp;&nbsp;
                <input type="button" value="<%=Resources.lang.StopFeed%>" title="<%=Resources.lang.StopFeed%>"
                    id="btnClose" onclick="returnOpen(2);" class="SearchButton" style="font-weight: bolder;
                    font-size: small;" />
                &nbsp;&nbsp;
                <input id="cnkFeed" type="checkbox" disabled="disabled" /><%=Resources.lang.AlreadyOpen%>
            </span>
        </div>
        <table id="tableHeader" cellspacing="0" cellpadding="0" style="width: 100%; border-collapse: collapse;
            display: none;">
            <tr style="background: #fff; font-family: Verdana, 微软雅黑,黑体, 宋体;">
                <td colspan="2" style="text-align: center; height: 21px;">
                </td>
                <td colspan="2" style="text-align: center;">
                </td>
                <td colspan="2" style="text-align: center;">
                </td>
            </tr>
        </table>
        <table id="tableSMT" width="100%" class="ListTable">
            <tr class="ListTableHeader">
                <th align="center">
                    <%=Resources.lang.Machine%>
                </th>
                <th align="center">
                    <%=Resources.lang.MachineTable%>
                </th>
                <th align="center">
                    <%=Resources.lang.SlotSN%>
                </th>
                <th align="center">
                    <%=Resources.lang.ItemName%>
                </th>
                <th align="center">
                    <%=Resources.lang.GRN%>
                </th>
                <th align="center">
                    <%=Resources.lang.FeedType%>
                </th>
                <th align="center">
                    <%=Resources.lang.FeedSN%>
                </th>
                <th align="center">
                    <%=Resources.lang.Status%>
                </th>
            </tr>
        </table>
    </div>
    <table width="100%">
        <tr>
            <td align="center">
            </td>
            <td align="center">
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        //全局变量
        var HostName = "";
        function SlotSN(event) {
            var e = event || window.event
            if (e && e.keyCode == 13) {
                $("#txtFeedSN").focus();
            }
        }
        function FeedSN(event) {
            var e = event || window.event
            if (e && e.keyCode == 13) {
                $("#txtGRN").focus();
            }
        }
        function Return() {
            HistoryGo();
        }
        /***全局变量****/
        var lineId = 0;
        var prodOrderId = 0;
        var loadList = "";
        //回车事件
        function mykeydown(e) {
            if (e.keyCode == 13) {
                stopDefault(e);

                lineId = $("#selLine").val();
                var slotSn = $("#txtSlot").val();
                var grn = $("#txtGRN").val();
                var feeder = $("#txtFeedSN").val();
                loadList = $("#txtLoadList").val();

                if (!validateSMT(slotSn, grn, feeder, prodOrderId, loadList, lineId)) {

                }
                else if (validateSMT(slotSn, grn, feeder, prodOrderId, loadList, lineId)) {
                    var setTable = document.getElementById("tableSMT");
                    //autoRowSpan(setTable, 0, 0);
                    $(setTable).rowspan(0, 2);
                }
            }
        }
        function ClearParmar() {
            $("#txtSlot").val("");
            $("#txtGRN").val("");
            $("#txtFeedSN").val("");
            $("#txtSlot").focus();
        }
        //验证方法
        function validateSMT(slotSn, grn, feeder, prodOrderId, loadList, lineId) {
            //执行之前判断该电脑是否有报警记录，如有不执行后来的数据如
            var status = 0;
            HostName = document.getElementById("AndonActiveX").GetComputerName();
            var ajaxErrorCode = SKT.LeanMES.Web.Controls.PageSQLService.Search("H0dZQmiL7S0XnDjnp1N1rtdGDglXMrsR6aYmv17CUxfZUQr/OT+kig==", "59Re+XIyDOk=",
            "59Re+XIyDOk=",
            "1FzU4DWWuP6PyHLnzbXfVRGijzltjAFa#{'" + HostName + "'}#z/n32SYuIf99rlMoCC9vYJKPkxdSh/jK#{" + status + "}#xgKJsRKfHKc=", "xgKJsRKfHKc=");
            if (ajaxErrorCode.value != "") {
                alert("该机台正在报警，请解除报警后再进行上料验证！");
                return false;
            }
            else {
                if (slotSn.length <= 0) {
                    alert("<%=Resources.Messages.SlotSnEmptyWei %>");
                    $("#txtSlot").focus();
                    return false;
                }
                else if (grn.length <= 0) {
                    alert("<%=Resources.Messages.GrnEmptyWei %>");
                    $("#txtGRN").focus();
                    return false;
                }
                else if (prodOrderId.length <= 0) {
                    alert("<%=Resources.Messages.OrderEmptyWei %>");
                    return false;
                }
                else if (loadList.length <= 0) {
                    alert("<%=Resources.Messages.LoadListEmpetyWei %>");
                    return false;
                }
                else if (lineId.length <= 0) {
                    alert("<%=Resources.Messages.PleaseSelectLine %>");
                    $("#selLine").focus();
                    return false;
                }
                var cmd = "mzBT/KlGe4kAViGFkcQGStXMTo++PImyT85Df6xoM1Q=";  //uspValidateSMTFeedMap
                var params = [], param = {};
                param.ParamName = "SrAbW+172GEtY2t1NpYFAg==";    //@SlotSN
                param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";    //NVARCHAR
                param.ParamValue = slotSn;
                param.ParamSize = 50;
                params.push(param);

                param = {};
                param.ParamName = "ebhY7NUwdK4nhSceFCqdew==";   //@Grn
                param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";   //NVARCHAR
                param.ParamValue = grn;
                param.ParamSize = 50;
                params.push(param);

                param = {};
                param.ParamName = "mUvNAGnsMMVhXFmvai5CVQ==";  //@FeedSN
                param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";          //NVARCHAR
                param.ParamValue = feeder;
                param.ParamSize = 50
                params.push(param);

                param = {};
                param.ParamName = "V18PVCJSJFZJs+5L/3VV03DpuifbaqOd";  //@prodOrderId
                param.ParamType = "1o/d3CICk7c=";   //int
                param.ParamValue = prodOrderId;
                param.ParamSize = 0;
                params.push(param);

                param = {};
                param.ParamName = "ZSuP9QNVOu1mQfNDKK2CT7gyrSPI8vYfPK0p/VRJRf4=";  //@LoadingListName
                param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";   //NVARCHAR
                param.ParamValue = loadList;
                param.ParamSize = 100;
                params.push(param);

                param = {};
                param.ParamName = "6SNsGx3QCcmA3MBUw4S4XQ==";  //@LineID
                param.ParamType = "1o/d3CICk7c=";  //int
                param.ParamValue = lineId;
                param.ParamSize = 0;
                params.push(param);

                //执行
                var ajaxResult = SKT.LeanMES.Web.Controls.PageSQLService.ExecuteNonQuery(cmd, params);
                if (ajaxResult.error != null) {
                    var ajaxValue = ajaxResult.value;
                    var msg = ajaxResult.error.Message;
                    if (msg != "" && msg != null) {
                        var arr = new Array();
                        arr = msg.split("|");
                        if (arr[2] == '1') {
                            try {
                                document.getElementById("AndonActiveX").AndonStart(true);
                                alert("<%=Resources.Messages.StartAlert %>");
                                /***add by weixia on 2014/12/15***/
                                var flage = 0;   //0表示报警记录，1表示关闭记录
                                HostName = document.getElementById("AndonActiveX").GetComputerName();
                                var Comment = "报警开始";
                                var Action = 0;
                                var Errcode = arr[0];  //待获取
                                var Status = 0;   //报警记录状态
                                var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.SaveAlertHistory(flage, HostName, Comment, Action, Errcode, Status);
                                if (ajaxsave.error != null) {
                                    alert(ajaxsave.error.Message);
                                }
                            }
                            catch (e) {
                                alert("<%=Resources.Messages.InvalidRelieveAlert %>")
                            }
                            alert(arr[1]);
                            return false;
                        }
                    }
                    if (arr[2] == '0') {
                        alert(arr[1]);
                        return false;
                    }
                } else {
                    var setTable = document.getElementById("tableSMT");
                    clearItem$Main_MPIPQC(setTable);
                    loadProductStructure();
                    $("#txtSlot").val("");
                    $("#txtGRN").val("");
                    $("#txtFeedSN").val("");
                    document.getElementById("txtSlot").focus();
                }
            }
        }

        function DeleteShowTable() {
            var setTable = document.getElementById("tableSMT");
            clearItem$Main_MPIPQC(setTable);
            loadProductStructure();
        }
        /* 清空指定table中数据 */
        function clearItem$Main_MPIPQC(tabParams) {
            if ($("#tableSMT tr").length > 1) {
                $("#tableSMT tr:not(:first)").remove();
            }
        }
        //根据loadingList查询对应数据
        function loadProductStructure() {
            var setTable = document.getElementById("tableSMT");
            clearItem$Main_MPIPQC(setTable);
            var loadList = $("#txtLoadList").val();
            var ajaxResult = SKT.LeanMES.Web.Controls.PageSQLService.Search("39USUy571latMQeBjxUbjHPD463KKZC5tEk87dBc7YI=", "59Re+XIyDOk=",
            "oQrzRl+jGdYfpTUFESMKwd48XjoHdoTqFpQnsnRItGMGQObYDGLVgAEyqzjkxe3LUp00r/A26SbThO021HXD2t8nE/1dkyS32aWuQCWs1Zt7bSlZ002Fl4UJNLtIf/qIfJ4O4BdbYHSTOJ/k3bpB0sqkPECV8xKk",
            "AbfxjyPAxM/T7mkEf54nQ8KtPDnsSdrH#{'" + loadList + "'}#xgKJsRKfHKc=", "x7EEC6nuN2ddRToUHkK4PGdrC9wluIrm182YSNWvmu3Su1X9tmJfjw==");
            var setTable = "";
            if (ajaxResult.error == null) {
                $("#loadListspn").html(loadList);
                setTable = document.getElementById("tableSMT");
                var row, cell;
                var entityAry = ajaxResult.value;
                var entity = {};
                var flage = 0;
                //动态创建表
                for (var i = 0; i < entityAry.length; i++) {
                    entity = entityAry[i];
                    row = setTable.insertRow(setTable.rows.length);
                    row.className = "ListTableOddRow";
                    var grn = entity.Field5;
                    var status = entity.Field8;
                    flage = entity.Field8;

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = entity.Field1;


                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = entity.Field2;


                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.Field3;
                    if (grn != "" && status == "Active") {
                        cell.style.backgroundColor = '#FFCC99';
                    }
                    else if (grn != "" && status == "Processing") {
                        cell.style.backgroundColor = "#99FF33";
                    }
                    else if (grn != "" && status == "StopLine") {
                        cell.style.backgroundColor = "red";
                    }

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.Field4;
                    if (grn != "" && status == "Active") {
                        cell.style.backgroundColor = '#FFCC99';
                    }
                    else if (grn != "" && status == "Processing") {
                        cell.style.backgroundColor = "#99FF33";
                    }
                    else if (grn != "" && status == "StopLine") {
                        cell.style.backgroundColor = "red";
                    }

                    cell = row.insertCell(4);
                    cell.align = "center";
                    cell.innerHTML = entity.Field5;
                    if (grn != "" && status == "Active") {
                        cell.style.backgroundColor = '#FFCC99';
                    }
                    else if (grn != "" && status == "Processing") {
                        cell.style.backgroundColor = "#99FF33";
                    }
                    else if (grn != "" && status == "StopLine") {
                        cell.style.backgroundColor = "red";
                    }

                    cell = row.insertCell(5);
                    cell.align = "center";
                    cell.innerHTML = entity.Field6;
                    if (grn != "" && status == "Active") {
                        cell.style.backgroundColor = '#FFCC99';
                    }
                    else if (grn != "" && status == "Processing") {
                        cell.style.backgroundColor = "#99FF33";
                    }
                    else if (grn != "" && status == "StopLine") {
                        cell.style.backgroundColor = "red";
                    }

                    cell = row.insertCell(6);
                    cell.align = "center";
                    cell.innerHTML = entity.Field7;
                    if (grn != "" && status == "Active") {
                        cell.style.backgroundColor = '#FFCC99';
                    }
                    else if (grn != "" && status == "Processing") {
                        cell.style.backgroundColor = "#99FF33";
                    }
                    else if (grn != "" && status == "StopLine") {
                        cell.style.backgroundColor = "red";
                    }

                    cell = row.insertCell(7);
                    cell.align = "center";
                    cell.innerHTML = entity.Field8;
                    if (grn != "" && status == "Active") {
                        cell.style.backgroundColor = '#FFCC99';
                    }
                    else if (grn != "" && status == "Processing") {
                        cell.style.backgroundColor = "#99FF33";
                    }
                    else if (grn != "" && status == "StopLine") {
                        cell.style.backgroundColor = "red";
                    }
                }

                //判断状态:Processing
                if (flage == "Processing") {
                    document.getElementById("cnkFeed").checked = true;
                }
                else {
                    document.getElementById("cnkFeed").checked = false;
                }
                //合并单元格
            }
            $(setTable).rowspan(0, 2);
        }
        /***停止页面自动提交***/
        function stopDefault(e) {
            //如果提供了事件对象，则这是一个非IE浏览器   
            if (e && e.preventDefault) {
                //阻止默认浏览器动作(W3C)  
                e.preventDefault();
            } else {
                //IE中阻止函数器默认动作的方式   
                window.event.returnValue = false;
            }
            return false;
        }
        function showMessagge(flage) {
            if (flage == 1) {
                if (confirm("<%=Resources.Messages.SureOpenWei%>")) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else if (flage == 2) {
                if (confirm("<%=Resources.Messages.SureStopWei%>")) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
        //开拉事件
        function returnOpen(flage) {
            var result = showMessagge(flage);
            if (result == true) {
                var loadList = $("#txtLoadList").val();
                var cmd = "mzBT/KlGe4kAViGFkcQGSvU5B3r4WK0R6IkzQL1LWDTDXbcqEqOJnQ==";  //uspValidateSMTStartFeeMap
                var params = [], param = {};
                param.ParamName = "SdvSPB+RvAcXyEn46xSVsA==";    //@flage
                param.ParamType = "1o/d3CICk7c=";    //int
                param.ParamValue = flage
                param.ParamSize = 0;
                params.push(param);

                param = {};
                param.ParamName = "GX7iLhXZNal+bQJLY/DYAkwIbFcgw/O5U5oj41biO20=";   //@loadListSetName
                param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";   //NVARCHAR
                param.ParamValue = loadList;
                param.ParamSize = 100;
                params.push(param);

                param = {};
                param.ParamName = "uW2T6zlxHBm1yB66Nmn0iiaaj3QNx7d8";  //@GrnOpenStatus
                param.ParamType = "1o/d3CICk7c=";          //int
                param.ParamValue = 5;
                param.ParamSize = 0;
                params.push(param);

                param = {};
                param.ParamName = "K0bVTIQzfkWYFdbcMOqgoJrwFw8Bn3DU";  //@MapOpenStatus
                param.ParamType = "1o/d3CICk7c=";   //int
                param.ParamValue = 2;
                param.ParamSize = 0;
                params.push(param);

                param = {};
                param.ParamName = "aHbGrrQZRaB+zWf3cOhCWaCGpyDj9DBC";  //@GrnStopStatus
                param.ParamType = "1o/d3CICk7c=";   //int
                param.ParamValue = 2;
                param.ParamSize = 0;
                params.push(param);

                param = {};
                param.ParamName = "lCVpwXdwypmuxSmdDCVr7MAEDIfoWlUK";  //@MapStopStatus
                param.ParamType = "1o/d3CICk7c=";   //int
                param.ParamValue = 3;
                param.ParamSize = 0;
                params.push(param);
                //执行
                var ajaxResult = SKT.LeanMES.Web.Controls.PageSQLService.ExecuteNonQuery(cmd, params);
                if (ajaxResult.error == null) {
                    if (flage == 1) {
                        alert("<%=Resources.Messages.StartFeedSuccess %>");
                        var setTable = document.getElementById("tableSMT");
                        clearItem$Main_MPIPQC(setTable);
                        loadProductStructure();
                        document.getElementById("cnkFeed").checked = true;
                        return;
                    }
                    else if (flage == 2) {
                        alert("<%=Resources.Messages.StopFeedSuccess %>");
                        document.getElementById("cnkFeed").checked = false;
                        var setTable = document.getElementById("tableSMT");
                        clearItem$Main_MPIPQC(setTable);
                        loadProductStructure();
                        return;
                    }
                } else {
                    alert(ajaxResult.error.Message);
                }
            }
        }
        //合并单元格
        function autoRowSpan(tb, row, col) {
            var lastValue = "";
            var value = "";
            var pos = 1;
            for (var i = row; i < tb.rows.length; i++) {
                value = tb.rows[i].cells[col].innerText;
                if (lastValue == value) {
                    tb.rows[i].deleteCell(col);
                    tb.rows[i - pos].cells[col].rowSpan = tb.rows[i - pos].cells[col].rowSpan + 1;
                    pos++;
                } else {
                    lastValue = value;
                    pos = 1;
                }
            }
        }

        //加载事件
        $(document).ready(function () {
            //加载工单：
            $(function () {
                //加载线别
                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                var ajaxline = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.GetLineNameByUserName(userName);
                if (ajaxline.error == null) {
                    var entityAry = ajaxline.value;
                    var entity = {};
                    $("#selLine").append('<option value ="-1">---<%=Resources.lang.PleaseSelectWei%>---</option>');
                    for (var i = 0; i < entityAry.length; i++) {
                        entity = entityAry[i];
                        $("#selLine").append('<option  value ="' + entity.LineId + '">' + entity.LineName + '</option>');
                    }
                    $("selLine").eq(0).attr("selected", "true");
                }
                else {
                    alert(ajaxline.error.Message);
                }
            });
        });
        //线别触发事件
        $("#selLine").change(function () {
            //重新触发一次，重新获取数据
            DeleteShowTable();
            $("#txtSlot").val("");
            $("#txtGRN").val("");
            $("#txtFeedSN").val("");
            $("#txtOrder").val("");
            var lineId = $("#selLine").val();
            var status = 1;

            //获取loadingList
            var ItemId = 0; // listB.LineID =7  and  listB.StatusID =1
            var ajaxline = SKT.LeanMES.Web.Controls.PageSQLService.Search("e+i3jyLBgcstVM4KHOcbpjAVrEEIpmROJZcL6l+s3S7qn8gUr+PDOj1vfv6wMFaKhV4S84URREu2SUd01pKbHdrohMC+u+wH/cc46If055eqZdiKOq2GoGnCGAMHhrQWPFkpl1FCppyZqiaQTIxt6sPPmdbGsw1ekKq3pHzOxk/u+YFPa+C1d9GZeUS2kAj6DwX7yrI6u7c=",
             "8hpP9rOMqd8ryPOIgo3vNTT6AefOZPP65faH2Ra/ZYw=", "Flw0x6Ajiti9IStZnXDHxeRACe7upbFl2fTnAYpcgQ2QlOEdRReKTHa1vG1qNZTYA2B5lxcITNGdPRjbYEwpeVsLsPUra3HbdU//1DvaWaeWlr7UU/vOvQ==",
                "vZr/Vfk1AGYC2AU/C9uOofDDzJAFwSy5#{" + lineId + "}#+rp516xMJ2A=", "+rp516xMJ2A=");
            if (ajaxline.error == null) {
                var entityAry = ajaxline.value;
                var entity = {};
                $("#txtSlot").focus();
                if (entityAry[0] == null) {
                    document.getElementById("txtLoadList").value = "";
                    alert("<%=Resources.Messages.ChoiceLineWei %>");
                    $("#selLine").val(-1);
                    $("#selLine").focus();
                    DeleteShowTable();
                    return false;
                }
                else if (entityAry[0].Field3 != null) {
                    document.getElementById("txtLoadList").value = entityAry[0].Field3;
                    document.getElementById("txtLoadList").disabled = true;
                    ItemId = entityAry[0].Field2;
                    loadProductStructure();
                }
            }
            else {
                alert(ajaxline.error.Message);
            }
            //获取工单id
            var loadList = $("#txtLoadList").val();
            var ajaxOrderId = SKT.LeanMES.Web.Controls.PageSQLService.Search("bZz+yNYyTSQcYD4V6XY5Wqz01HyGRifdNu0YC6MCGArvkeHjsYsRI5JScs2YZcwEv6c+VdwmOqJY9/tnyyI9X8jKrw68Fdv6zYrgLaV7oGqE85e9UaZ+8Fvuo/3mpCs5Fc8mUGMWP2XKAx7/EEtvjVSoVo60fat4aiRcdCURATOb0/MO3bvHSZ6dQGIVpdNyBk/zN3EjSUFrkxByIDZG19lnuNpRsAw7gFh3Sa0BioeX5iRlAGMkHl46YCcylLxklhNEMceF8sGcQ1orZ9qeU6lA5DQAZoVP+9WDLxbSvzA5hjkzdnsXXzMFLxhQtLv3PlJqyFqcmsoznnQwLfwkkvQxnhJOCRhR",
             "59Re+XIyDOk=", "/Woj01XOS6mZHNuddTIG5vFaeStDcCZLuy8Svkn5xrcRzwHcQ6GdvpHcNk2d0+BRE8FYnuXxiIlgDI58hTGh4w==",
                "bZz+yNYyTSQcYD4V6XY5Wqz01HyGRifdIvRgnPHCrGN5tITLSCqeNCZZXtxFHI82#{#+rp516xMJ2A=" + lineId + "}#z/n32SYuIf/g12Va3Iq6Sdc3B4OFcgbrE8+x5qj/aXg=#{'" + loadList + "'}#+rp516xMJ2A=", "+rp516xMJ2A=");
            if (ajaxOrderId.error == null) {
                var entityOrder = ajaxOrderId.value;
                if (entityOrder[0] != null) {
                    prodOrderId = entityOrder[0].Field2;
                    $("#txtOrder").val(entityOrder[0].Field3);
                }
            }
        });

        function HistoryGo() {
            history.go(-1);
        }
         
    </script>
    <script type="text/javascript" src="../Content/js/skt.utility.rowspan.min.js"></script>
    
</asp:Content>
