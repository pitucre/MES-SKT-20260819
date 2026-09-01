<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTSetupLine.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.SMTSetupLine"
    MasterPageFile="~/Masters/EditMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <input type="hidden" id="loadlistId" style="display: none" />
    <input type="hidden" id="status" style="display: none" />
    <table class="listTableRow" id="tbTitle" style="width: 100%">
        <tr>
            <td colspan="5" class="Label" align="left">
                <span class="information16"></span>&nbsp;<%=Resources.lang.OrderAndLineWei%>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Line%>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlLineName" runat="server" AppendDataBoundItems="true" AutoPostBack="false"
                    Style="width: 180px; height: 22px;" class="TextBox">
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%=Resources.lang.OrderNo%>
            </td>
            <td class="Field2">
                <input type="text" id="selOrder" class="TextBox" /><input type="button" id="btnOrder"
                    class="ButtonBox" title="" onclick="selectOrder();" value="..." />
                <label id="orderLine">
                </label>
                <input id="Line" type="hidden" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Resource%>
            </td>
            <td class="Field2">
                <select id="selResource" name="D1" style="width: 180px; height: 22px;">
                </select>
            </td>
            <td class="Label2" colspan="2">
                <div id="divLastOperation" style="display: none; text-align: left;">
                    &nbsp<label id="labName"></label>
                    &nbsp<label id="labItem"></label>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="5" class="Field2">
                <div id="showTable" style="display: none; width: 100%">
                    <table id="tbLoadingListInfo">
                        <tr class="ListTableHeader">
                            <th align="center">
                                选择
                            </th>
                            <th align="center">
                                <%=Resources.lang.MaterialTable%>
                            </th>
                            <th align="center">
                                <%=Resources.lang.Status%>
                            </th>
                            <th align="center">
                                <%=Resources.lang.OrderNo%>
                            </th>
                            <th align="center">
                                <%=Resources.lang.AC_Resource%>
                            </th>
                            <th align="center">
                                <%=Resources.lang.CreateDateTime%>
                            </th>
                        </tr>
                    </table>
                </div>
                <span id="showmessage" style="text-align: center; color: #CC6600; font-size: larger;">
                </span>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        /*****定义全局变量******/
        var orderNo = "";
        function selectOrder() {
             var searchSettings = "OrderType=1 and Status=1";  
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=37&PageCondition=" + escape(searchSettings) + "&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function getChooseValue(list) {
            $("#orderLine").html("");
            $("#selOrder").val(list[0][1]);
            orderNo = list[0][1];
            findItemNameByOrder(orderNo);
        }
        /*  function Onkey() {
        $("#orderLine").html("");
        orderNo = $("#selOrder").val();
        findItemNameByOrder(orderNo);
        }*/
        /******根据工单找到对应的ItemName*****/
        function findItemNameByOrder(orderNo) {
            /*****根据资源找到对应的ItemName****/
            var ajaxOrderId = SKT.LeanMES.Web.Controls.PageSQLService.Search("rZXWNP4ukgV3pcC/cHr535HEK5O+7jk5YRsPzufu67D2TFwSMu7nqpH99LBQWHpI38hd8CSYhtR0miuSV+HTP0+FpzqJO1K+IHcDxTI1JEaeZGjFzV3QIhFOu67qpzZHwcBMaj+D1lA=",
             "D8n1d8LbMMeK4qjkKC8fBbX9BkOsKv15", "D8n1d8LbMMeK4qjkKC8fBWTtYOILMzWOiGy3q4lAT+pRNu4pTL4ZsbVIp21W+jgq",
                "68AeG/gw++MFVGZy/4IUmaMS/0OGPbLv#{'" + orderNo + "'}#xgKJsRKfHKc=", "+rp516xMJ2A=");
            if (ajaxOrderId.error == null) {
                var entityOrder = ajaxOrderId.value;
                if (entityOrder[0] != null) {
                    if (entityOrder[0].Field2.length == 0) {
                        $("#orderLine").html("暂无对应产品信息");
                    }
                    else if (entityOrder[0].Field2.length >= 1) {
                        $("#orderLine").html("产品：" + entityOrder[0].Field3);
                    }
                }
                else {
                    alert("该工单没有对应的产品信息！");
                    $("#selOrder").val("");
                    return false;
                }
            }
        }
        /****End****/
        function Save() {
            orderNo = $("#selOrder").val();
            var lineId = $("ddlLineName").val();
            /*****update by weixia on 2014/12/2*******/
            if (orderNo.length == 0) {
                alert("<%=Resources.Messages.OrderEmptyWei %>");
                $("#selOrder").focus();
                return false;
            }
            $("#orderLine").html("");
            orderNo = $("#selOrder").val();
            findItemNameByOrder(orderNo);    //add  by weixia  on  2015/1/26
            if (checkSelectValue()) {
                var ddlLineId = $("#ContentPlaceHolder1_EditContent_ddlLineName option:selected").val();
                var loadingId = $("#loadlistId").val();
                if (loadingId.length == 0) {
                    alert("<%=Resources.Messages.RequireOperateRecord %>");
                    return false;
                }
                if (!isNumber(loadingId)) {
                    alert("<%=Resources.Messages.RequireOperateRecord%>");
                    return false;
                }
                var status = "Processing";
                /****/
                var ajaxNc = SKT.LeanMES.Web.Controls.PageSQLService.Search("bZz+yNYyTSQcYD4V6XY5WjKn7uTfXcjMhCNSSgWf9SL3YDRTtpGsuiz4a8p0/5FPmIntCTL/u7mC6JXopooVU/OW5izOHD6CFvivl6DI6f1SSlsv5u9fqmt2/obQZcXGK6Qfc1T8ZNgsHWIqYBAvrwj46l1ki45C58VSTb6pcOysYhz+mVkY3A6HoWzjYcGh",
                 "bZz+yNYyTSQcYD4V6XY5WgycS8a/RJsKor4L8AAytDk=",
             "bZz+yNYyTSQcYD4V6XY5WgycS8a/RJsKor4L8AAytDk=", "kCDCEC2l4M8zdV8F4Zc8LQ==#{" + ddlLineId + "}#9QadfqgfEpyc3d6TNGpzJtDvEJUq35mRFP/HDxMP0dM=#{'" + status + "'}#xgKJsRKfHKc=", "+rp516xMJ2A=");
                if (ajaxNc.error == null) {
                    var entityArr = ajaxNc.value;
                    if (entityArr.length >= 1) {
                        /**end**/
                        if (confirm("<%=Resources.Messages.ConfirmSetupLineWei%>")) {
                            if (AjaxMaterialCheck(ddlLineId, loadingId)) {
                                alert("<%=Resources.Messages.SetSuccess %>");
                                DeleteShowTable();
                                GetObjArr(ddlLineId);
                            }
                        }
                        else {
                            return false;
                        }
                    }
                    else {
                        if (confirm("<%=Resources.Messages.ConfirmSetLineWei%>")) {
                            if (AjaxMaterialCheck(ddlLineId, loadingId)) {
                                alert("<%=Resources.Messages.SetSuccess %>");
                                DeleteShowTable();
                                GetObjArr(ddlLineId);
                            }
                        }
                        else {
                            return false;
                        }
                    }
                }
            }
        }
        //获取线别对应所有loadingList
        function AjaxMaterialCheck(ddlLineId, loadingId) {
      
            /**update by weixia on 2014.11.26***/
            /***1.通过选择线别带出资源：如果没有对应的资源，对应的loadingList也不应该显示出来,提示请选择正确的线别****/
            /***2.如果有对应的资源，但是没有loadinglist，显示没有数据信息*****************/
            orderNo = $("#selOrder").val();
            var resId = $("#selResource").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.MaterialCheck(orderNo, resId, ddlLineId, loadingId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return true;
        }
        function checkSelectValue() {
            var ddlLineId = $("#ContentPlaceHolder1_EditContent_ddlLineName option:selected").val();
            if (!isNumber(ddlLineId)) {
                return false;
            }
            return true;
        }
        function isNull(str) {
            if (str == "") return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }
        function isNumber(s) {
            var regu = "^[0-9]+$";
            var re = new RegExp(regu);
            if (s.search(re) != -1) {
                return true;
            } else {
                return false;
            }
        }
        /* 清空指定table中数据 */
        function DeleteShowTable(tabParams) {
            if ($("#tbLoadingListInfo tr").length > 1) {
                $("#tbLoadingListInfo tr:not(:first)").remove();
                $("#loadlistId").val('');
            }
        }
        $("#ContentPlaceHolder1_EditContent_ddlLineName").change(function () {
            $("#orderLine").html("");
            $("#selOrder").val("");
            var ddlLineId = $("#ContentPlaceHolder1_EditContent_ddlLineName option:selected").val();
            /****add  by weixia on 2014/11/26 通过选择线别带出资源******/
            /*****add by  weixia  on  2014/12/31通过线别id和userId带出资源***********/
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var lstDefect = document.getElementById("selResource");
            var $lstDefect = $(lstDefect);
            //每加载一次清空下拉框
            document.getElementById("selResource").innerHTML = "";
            var ajaxNc = SKT.LeanMES.Web.Controls.PageSQLService.Search("mft0dEY55RD2ZtefarErLJnjmXaCG324XW/wShuk1yQ=", "kS457a+KsG27HQ+tNF7cJzUg9mzD8P0o", "kS457a+KsG1nkT0VYBSVYuF66oIAHEoF0dI37SYekhQ=",
             "oEwqQgAsYJOQczXuxQwgQae5dH338ut7#{'" + userName + "'}#eScktSi2p05354r5FUCB4EUOpPCaRfrw#{" + ddlLineId + "}#xgKJsRKfHKc=", "+rp516xMJ2A=");
            if (ajaxNc.error == null) {
                var entityArr = ajaxNc.value;
                if (entityArr.length >= 1) {
                    var entity = {};
                    for (var i = 0; i < entityArr.length; i++) {
                        entity = entityArr[i];
                        $lstDefect.append('<option value="' + entity.Field1 + '">' + entity.Field2 + '</option>');
                    }

                } else {
                    /****add  record  by  weixia ********/
                    alert("<%=Resources.Messages.NoRescourceByLineWei %>");
                    document.getElementById("selResource").value = "";
                    document.getElementById("showmessage").innerHTML = "";
                    $("#ContentPlaceHolder1_EditContent_ddlLineName").focus();
                    DeleteShowTable();
                    document.getElementById("labName").innerHTML = "";
                    document.getElementById("labItem").innerHTML = "";
                    return false;
                }
            }

            /*****add end***********/

            DeleteShowTable(); //清除表格数据

            GetObjArr(ddlLineId);

            var ajaxRes = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.GetLastLineHistory(ddlLineId);
            if (ajaxRes.error == null) {
                var obj = ajaxRes.value;
                if (obj != null && obj != "") {
                    var model = obj;
                    $("#labName").html("<%=Resources.lang.LastUseMaterielName%>:" + model.SetupName); //<%=Resources.lang.LastUseMaterielName%>:
                    $("#labItem").html("<%=Resources.lang.Material%>:" + model.ItemName);
                    $("#divLastOperation").show();
                } else {
                    $("#divLastOperation").hide();
                }
            }
        });
        //获取实体数组
        function GetObjArr(ddlId) {
      
            if (checkSelectValue()) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.GetAllLoadingListinfo(ddlId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                } else {
                    if (ajax.value != null && ajax.value != "") {
                        $("#btnSubmit").show();
                        $("#showTable").show();
                    }
                    else {
                        $("#btnSubmit").hide();
                        $("#showTable").hide();
                    }
                    MakeRow(ajax.value);
                }
            }
        }
        //创建行
        function MakeRow(objArr) {
       
            document.getElementById("showmessage").innerHTML = "";
            var NewTr = document.getElementById("tbLoadingListInfo");
            var row, cell;
            var entityArr = objArr;
            /*****update  record  by  weixia on  2014/11/26*********/
            /**如果没有记录，表中显示没有对应的料站表信息***/
            if (entityArr.length > 0) {
                var entity = {};
                for (var i = 0; i < entityArr.length; i++) {
                    entity = entityArr[i];
                    row = NewTr.insertRow(NewTr.rows.length);
                    row.className = "ListTableOddRow";
                    var status = entity.Description;

                    cell = row.insertCell(0);
                    cell.innerHTML = entity.ID;
                    if (status == "Processing") {
                        cell.style.backgroundColor = '#99FF33';
                    }
                    else if (status == "StopLine") {
                        cell.style.backgroundColor = 'red';
                    }
                    else if (status == "Locked") {
                        cell.style.backgroundColor = '#FFFF00';
                    }

                    cell = row.insertCell(1);
                    cell.innerHTML = "<input type='checkbox' name='chkb' onclick='check(this)' />";
                    if (status == "Processing") {
                        cell.style.backgroundColor = '#99FF33';
                    }
                    else if (status == "StopLine") {
                        cell.style.backgroundColor = 'red';
                    }
                    else if (status == "Locked") {
                        cell.style.backgroundColor = '#FFFF00';
                    }

                    cell = row.insertCell(2);
                    cell.innerHTML = entity.SetupName;
                    if (status == "Processing") {
                        cell.style.backgroundColor = '#99FF33';
                    }
                    else if (status == "StopLine") {
                        cell.style.backgroundColor = 'red';
                    }
                    else if (status == "Locked") {
                        cell.style.backgroundColor = '#FFFF00';
                    }

                    cell = row.insertCell(3);
                    cell.innerHTML = entity.Description;
                    if (status == "Processing") {
                        cell.style.backgroundColor = '#99FF33';
                    }
                    else if (status == "StopLine") {
                        cell.style.backgroundColor = 'red';
                    }
                    else if (status == "Locked") {
                        cell.style.backgroundColor = '#FFFF00';
                    }

                    cell = row.insertCell(4);
                    cell.innerHTML = entity.OrderNo;
                    if (status == "Processing") {
                        cell.style.backgroundColor = '#99FF33';
                    }
                    else if (status == "StopLine") {
                        cell.style.backgroundColor = 'red';
                    }
                    else if (status == "Locked") {
                        cell.style.backgroundColor = '#FFFF00';
                    }

                    cell = row.insertCell(5);
                    cell.innerHTML = entity.ResName;
                    if (status == "Processing") {
                        cell.style.backgroundColor = '#99FF33';
                    }
                    else if (status == "StopLine") {
                        cell.style.backgroundColor = 'red';
                    }
                    else if (status == "Locked") {
                        cell.style.backgroundColor = '#FFFF00';
                    }

                    cell = row.insertCell(6);
                    cell.innerHTML = entity.CreationTime_Str;
                    if (status == "Processing") {
                        cell.style.backgroundColor = '#99FF33';
                    }
                    else if (status == "StopLine") {
                        cell.style.backgroundColor = 'red';
                    }
                    else if (status == "Locked") {
                        cell.style.backgroundColor = '#FFFF00';
                    }      //add  by  weixia  on  2014/11/27

                    //隐藏第一列ID
                    $("#tbLoadingListInfo tr").find('td:eq(0)').hide();
                }
            }
            else if (entityArr.length == 0) {
                document.getElementById("showmessage").innerHTML = "没有对应的料站表信息！";
                return false;
            }
            var mTable = document.getElementById("tbLoadingListInfo");
            var mTr;
            if (mTable.rows.length > 0) {
                for (var i = 1; i < mTable.rows.length; i++) {
                    mTr = mTable.rows[i];
                    mTr.onclick = function () {
                        $("#loadlistId").val($(this).find('td:eq(0)').text());
                        $("#status").val($(this).find('td:eq(2)').text());
                        $(this).css('background-color', '#0277bd');
                        $(this).siblings().css('background-color', '#fff');
                    }
                }
            }
        }
        function Return() {
            HistoryGo();
        }
        function HistoryGo() {
            history.go(-1);
        }
        // 加上复选框按钮
        function check(obj) {
            $('input').each(function () {
                if (this != obj)
                    $(this).attr("checked", false);
                else {
                    if ($(this).prop("checked"))
                        $(this).attr("checked", true);
                    else
                        $(this).attr("checked", false);
                }
            });
        }
    </script>
    <style type="text/css">
        #tbLoadingListInfo td, th
        {
            width: 400px;
            border: solid 1px #ccc;
        }
        #tbTitle td, th
        {
            width: 400px;
        }
        .listTableRow
        {
            background-color: #fff;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            height: 24px;
            border-collapse: collapse;
            border: 0px;
        }
        
        .ListTableHeader
        {
            font-size: 15px;
            font-weight: bold;
            text-align: left;
            height: 21px;
            line-height: 18px;
            color: #183152;
            margin-left: 3px;
            border: 0px;
            padding: 1px;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
        }
        
        .ListTableOddRow
        {
            cursor: pointer;
            background: #fff;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 14px;
            height: 26px;
        }
        .ListTableSelectRow
        {
            background: #0277bd;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            height: 26px;
            border: 1px;
        }
    </style>
</asp:Content>
