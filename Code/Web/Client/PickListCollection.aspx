<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="PickListCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PickListCollection" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        #layerNc, #layermsg {
            position: absolute;
            left: 50%;
            top: 50%;
            width: 500px;
            height: 200px;
            margin-left: -250px;
            margin-top: -100px;
            display: none;
            z-index: 999;
            background-color: White;
        }

        #layer {
            background-color: #F1F3F8;
            left: 0;
            opacity: 0.95;
            position: absolute;
            top: 0;
            z-index: 3;
            filter: alpha(opacity=95);
            -moz-opacity: 0.95;
            -khtml-opacity: 0.95;
            display: none;
            z-index: 100;
        }

        #divClose {
            color: #fff;
            width: 15px;
            background: red;
            text-align: center;
            cursor: pointer;
            position: absolute;
            right: 10px;
            top: 10px;
        }
    </style>

    <table id="tabTmplContent" class="EditeContentTable" style="width: 99%; margin: 0 auto; margin-top: 5px; margin-bottom: 5px;">
        <%--<tr>
                
                 <td class="Label3" align="right"  style=" height:40px;">线别&nbsp;
                </td>
                <td class="Field3">
                   <input type="text" id="txtLine" name="txtProductionLine" class="ui-textbox" style="height:26px;" readonly="readonly"/><input id="button5" class="ButtonBox" type="button" onclick="openChoosePage(21)"
                        value="..." title="选择生产产线" />
                    <asp:HiddenField ID="hdLineId" runat="server" Value="-1" />
                    <asp:HiddenField ID="hdnLineName" runat="server" Value="" />
                </td>              
            </tr> --%>
        <tr>
            <td class="Label3" align="right" style="height: 35px;">工单&nbsp;
            </td>
            <td class="Field3">
                <input type="text" id="txtOrder" class="ui-textbox" style="height: 26px;" readonly="readonly" /><input id="button4" class="ButtonBox" type="button" onclick="openChoosePage(44)"
                    value="..." title="选择生产订单号" />
                <input id="hdOrderId" type="hidden" value="-1" />
                <input id="hdItemCode" type="hidden" />
            </td>
            <td class="Label3" align="right">工序&nbsp;
            </td>
            <td class="Field3">
                <select id="ddlStation">
                    <option value="">--请选择--</option>
                </select>
            </td>
            <td class="Label3" align="right">资源&nbsp;
            </td>
            <td class="Field3">
                <select id="ddlResource">
                    <option value="">--请选择--</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label2">GRN条码&nbsp;</td>
            <td class="Field2" colspan="7">
                <input type="text" id="txtSN" class="scan-center-sn" style="width: 79%; margin-right: 15px; height: 35px;" />
                <input type="button" value=" 检测配对 " onclick="collectPickList()" /></td>
        </tr>
    </table>

    <!--数据分析统计展示及操作区-->
    <div id="datastatistic" class="data-statistic">
        <div style="height: 60px; line-height: 30px; text-align: center; width: 98.5%; margin: 0px auto 5px auto;">
            <ul>
                <li style="border-bottom: 1px solid #f7f7f7;">料站表：<span id="lblPickListName" style="font-weight: bold; color: #18316E;"></span>&nbsp;&nbsp;
                    <input id="chkStatus" type="checkbox" disabled="disabled" />
                    完成上料<span style="font-weight: bold; color: Blue; margin-left: 15px;">应上料数量: <span
                        id="lblNeedQty"></span></span>&nbsp;<span style="font-weight: bold; color: Green;">已上料数量：<span
                            id="lblCurrentQty"></span></span> &nbsp;<span style="font-weight: bold; color: Red;">未上料数量：<span
                                id="lblToInputQty"></span></span></li>
            </ul>
            <ul>
                <li style="float: left; margin-bottom: 5px; margin-top: 5px;"><span style="background-color: #ffcc99; border: 1px #ccc solid; height: 10px; width: 30px; display: inline-block;"></span>
                    <span>已上料</span> &nbsp; <span style="background-color: #99ff33; border: 1px #ccc solid; height: 10px; width: 30px; display: inline-block;"></span><span>已完成上料</span> &nbsp;
                </li>
                <li style="float: right; margin-top: 5px;">
                    <input type="button" value=" 完成上料 " onclick="pull()" />&nbsp;&nbsp;&nbsp;&nbsp;                    
                    <input type="button" value=" 续 料 " onclick="addMaterial()" />&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" value=" 卸 料 " onclick="unLoadMaterial()" />&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" value=" 不良数录入 " onclick="inputNCQty()" />
                </li>
            </ul>
        </div>
        <table id="tablePickList" cellpadding="0" cellspacing="0" border="0" class="ListTable"
            style="width: 98.5%; margin: 0 auto;">
            <thead>
                <tr class="ListTableHeader">
                    <th style="width: 60px;">选择
                    </th>
                    <th style="width: 200px;">物料编码
                    </th>
                    <th >物料规格
                    </th>
                    <th style="width: 200px;">GRN
                    </th>
                    <th style="width: 90px;">所需数量
                    </th>
                    <th style="width: 90px;">剩余数量
                    </th>
                    <th style="width: 70px;">操作
                    </th>
                </tr>
            </thead>
            <tbody id="picklist">
                <tr id="trNew" class="ListTableOddRow">
                    <td colspan="8" style="text-align: center;">暂无数据！
                    </td>
                </tr>
            </tbody>
        </table>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <div id="layer">
    </div>
    <div id="layermsg">
        <div id='divClose' title='关闭'>
            X
        </div>
        <div style="width: 500px; height: 200px;">
            <table width="100%" class="EditeContentTable" id="addMaterialTab">
                <tr>
                    <td colspan="2" class="Field1">
                        <label id="ppmsg" style="font-weight: bold; color: #18316E;">
                            请输入要换料的物料条码！</label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">旧料GRN
                    </td>
                    <td class="Field1">
                        <input type="text" style="height: 25px;" id="CurrentGRN" onkeydown="onKeyPress(event,1)" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">新料GRN
                    </td>
                    <td class="Field1">
                        <input type="text" style="height: 25px;" id="NewGRN" onkeydown="onKeyPress(event,2)" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1"></td>
                    <td class="Field1">
                        <input type="button" id="btnAddMaterial" value=" 续 料 " onclick="saveAddMaterial()" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="layerNc">
        <div id='divClose' title='关闭'>
            X
        </div>
        <div style="width: 500px; height: 200px;">
            <table width="100%" class="EditeContentTable" id="Table1">
                <tr>
                    <td colspan="2" class="Field1">
                        <label id="Label1" style="font-weight: bold; color: #18316E;">
                            请输入要不良数录入的物料条码！</label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">物料GRN
                    </td>
                    <td class="Field1">
                        <input type="text" style="height: 25px;" id="txtNCGRN" onkeydown="onKeyPress(event,3)" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">不良数量
                    </td>
                    <td class="Field1">
                        <input type="text" style="height: 25px;" id="txtNCQty" onkeydown="onKeyPress(event,4)"
                            onkeyup="getIntVal(this)" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1"></td>
                    <td class="Field1">
                        <input type="button" id="Button1" value=" 保 存 " onclick="saveNCMaterial()" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        var scanSN = "";
        var prodOrderId = -1;
        var pickListId = 0;
        var status = 0;
        var intRefresh;
        var sltStationId = -1;
        var sltResId = -1;
        $(document).ready(function () {
            //投入过站必须选择工单后才可以进行扫描动作
            //$("#txtSN").attr("readonly", "readonly");
            // SelectProOrder();
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('Input_ProCollectionUI');
                },
                10
            );

            $("#ddlStation").change(function () {
                sltStationId = this.value;
                sltResId = "";               
                $("#ddlResource option:gt(0)").remove();
                clear();
                if (sltStationId != "") {
                    loadResource(sltStationId);
                }
            });

            $("#ddlResource").change(function () {
                sltResId = this.value;
                clear();
                if (sltResId != "" && setPickListInfo()) {
                    buildPickListTable();
                    $("#txtSN").select();
                }
            });
        });

        /**
        *扫描触发事件
        */
        function afterScan() {
            scanSN = $.trim($("#txtSN").val());
            if (scanSN != "") {
                if ($("#cbxforceuppercase").prop("checked")) {
                    scanSN = ($.trim($("#txtSN").val()).toUpperCase());
                }
                collectPickList();
            }
        }

        /**
        *加载扣料工序
        */
        function loadStation() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.GetPickListStation(prodOrderId);
            if (ajax.error != null) {
                showAreaMessge(ajax.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var list = (ajax.value);

            $("#ddlStation option:gt(0)").remove();
            if (list.keys.length == 0) {
                alert("未找到工单[" + $("#txtOrder").val() + "]关联路由的扣料工序，请先配置扣料工序！");
                return false;
            }
            var html = "";
            for (var i = 0 ; i < list.keys.length; i++) {
                html += "<option value='" + list.keys[i] + "'>" + list.values[i] + "</option>";
            }

            $("#ddlStation").append(html);

        }

        /**
        *加载资源（工位）
        */
        function loadResource(opeId) {
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetResourcesByOprId(opeId, userName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            var html = "";
            $("#ddlResource option:gt(0)").remove();

            for (var i = 0; i < list.length; i++) {
                html += "<option value='" + list[i].ResourceId + "'>" + list[i].ResName + "</option>";
            }
            $("#ddlResource").append(html);
        }

        /**
        *设置上料清单信息
        */
        function setPickListInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.GetPickListResource(prodOrderId, sltStationId, sltResId);
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var entity = ajax.value;

            if (entity != null && entity.PickListId == 0) {
                showAreaMessge("未找到工单料站表信息！", "messageRed");
                $("#tablePickList  tr:not(:first)").remove();
                return false;
            }

            pickListId = entity.PickListId;

            $("#lblPickListName").text(entity.PickListName);

            status = entity.IsMatComplete;

            if (status == 1) {
                $("#chkStatus").prop("checked", true);
                if (pickListId > 0) {
                    intRefresh = setInterval(function () { buildPickListTable() }, 60000);
                }
            }
            else {
                $("#chkStatus").prop("checked", false);
            }
            $("#lblNeedQty").text(entity.NeedQty);
            $("#lblCurrentQty").text(entity.CurrentQty);
            $("#lblToInputQty").text(parseInt(entity.NeedQty) - parseInt(entity.CurrentQty));
            return true;
        }

        /**
        *构建手插上料清单列表
        */
        function buildPickListTable() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.GetPickListDetail(pickListId, prodOrderId,sltStationId, sltResId);
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }

            var setTable = document.getElementById("tablePickList");
            var row, cell;
            var entityAry = [];
            var entity = {};

            $("#tablePickList  tr:not(:first)").remove();
            entityAry = ajax.value;

            if (entityAry == null || entityAry.length == 0) {
                row = setTable.insertRow(1);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = 7;
                cell.innerHTML = "暂无数据！";
                showAreaMessge(scanSN + ':未找到关联的上料清单信息！', "messageRed");
                return;
            }

            //var disabled = status != 0 ? "disabled=disabled" : "";
            //var style = status != 0 ? "style='background-image:none;color:#000;background-color:#ccc;'" : "";
            var disabled = "";
            var style = "";
            /***动态创建表***/
            for (var i = 0; i < entityAry.length; i++) {
                entity = entityAry[i];
                row = setTable.insertRow(setTable.rows.length);
                row.className = "ListTableOddRow";

                var grn = entity.GRN; //GRN

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = "<input type='checkbox' style='width:15px;height:15px;' name='chkPickList' value='" + grn + "' onclick='getGRN(this)'  /> ";

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.ItemCode;

                cell = row.insertCell(2);
                cell.align = "left";
                cell.innerHTML = entity.ItemSpec;

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = "<span name='lblGRN'>" + entity.GRN + "<span>";
                if (entity.GRN != "") {
                    cell.ondblclick = function () {
                        var grn = $(this).find("span[name=lblGRN]").text();
                        addMaterial();
                        $("#CurrentGRN").val(grn);
                    }
                    cell.style.cursor = "Pointer";
                }


                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = entity.RequireQty;

                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = "<span name='lblBalanceQty'>" + entity.BalanceQty + "<span>";;

                cell = row.insertCell(6);
                cell.align = "center";
                cell.innerHTML = "<input name='btnRemove' type='button' value=' 移除 '   onclick='remove(this)' " + style + "  " + disabled + " />";

                if (grn != "" && status == 0) {
                    row.style.backgroundColor = '#FFCC99';
                }
                else if (status == 1) {
                    row.style.backgroundColor = "#99FF33";
                }

            }

            /**合并单元格**/
            autoRowSpan(setTable, 0, 1);

            setActiveInfoHeight();
        }

        /**
        *获取GRN信息
        */
        function getGRN(obj) {
            $("#tablePickList  tr").find("input[name=chkPickList]").prop("checked", false);
            $(obj).prop("checked", true);
        }

        /**
        *验证手插上料
        */
        function collectPickList() {

            if (prodOrderId == -1) {
                alert("请选择工单！");
                return;
            }
            else if (sltStationId == "") {
                alert("请选择工序！");
                return;
            }
            else if (sltResId == "") {
                alert("请选择资源！");
                return;
            }

            if (pickListId <= 0) {
                showAreaMessge("未找到工单料站表信息！", "messageRed");
                return false;
            }
            //检验上料匹配信息
            if ($.trim(scanSN) == "") {
                showAreaMessge("请扫码GRN条码！", "messageRed");
                $("#txtSN").focus();
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.CollectPickListGRN(pickListId, scanSN, prodOrderId, sltStationId, sltResId);

            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                $("#txtSN").val("").focus();
                scanSN = "";                
                return false;
            }

            $("#lblCurrentQty").text(parseInt($("#lblCurrentQty").text()) + 1);
            $("#lblToInputQty").text(parseInt($("#lblToInputQty").text()) - 1);

            buildPickListTable();
            scanSN = "";
            $("#txtSN").val("").focus();
        }

        /**
        *完成上料
        */
        function pull() {
            if (pickListId <= 0) {
                    showAreaMessge("未找到有效的手插上料清单！", "messageRed");
                    return false;
                }
            if (confirm("确定资源[" + $("#ddlResource option:selected'").text() + "]的所有物料都已完成上料吗？")) {
                
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.PickListPullAndStop(pickListId, prodOrderId,sltStationId, sltResId, 1);
                if (ajax.error != null) {
                    //showAreaMessge(ajax.error.Message, "messageRed");
                    alert(ajax.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    $("#txtSN").val("").focus();
                    scanSN = "";
                    return false;
                }

                alert("完成上料成功！");
                if (pickListId > 0) {
                    intRefresh = setInterval(function () { buildPickListTable() }, 30000);
                }
                $("#chkStatus").prop("checked", true);
                status = 1;
                $("#tablePickList tr:not(first)").css("background-color", "#99FF33");
            }
        }


        /**
        *续料
        */
        function addMaterial() {
            if (pickListId <= 0) {
                showAreaMessge("未找到有效的手插上料清单！", "messageRed");
                return false;
            }
            var grn = $("#tablePickList  tr").find("input[name=chkPickList]:checked").val();
            $("#CurrentGRN").val(grn);
            showPage("layermsg");

            $("#CurrentGRN").focus();
            return;
        }
        /**
        *保存续料操作
        **/
        function saveAddMaterial() {
            var curentGRN = $("#CurrentGRN").val();
            var newGRN = $("#NewGRN").val();
            if (curentGRN == "") {
                alert("请输入旧GRN");
                $("#CurrentGRN").select();
                return false;
            }
            else if (newGRN == "") {
                alert("请输入新GRN!");
                $("#NewGRN").select();
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.PickListAddMaterial(pickListId, prodOrderId, curentGRN, newGRN, sltResId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                showAreaMessge(ajax.error.Message, "messageRed");
                $("#NewGRN").select();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, curentGRN, ajax.error.Message);
                return false;
            }

            buildPickListTable();
            if (confirm('续料成功,是否继续续料?')) {
                $("#CurrentGRN").val(newGRN);
                $("#NewGRN").val("").select();
                return;
            }
            else {
                $("#CurrentGRN,#NewGRN").val("");
                $("#layer,#layermsg").hide();
            }

        }

        /**
        *卸料
        */
        function unLoadMaterial() {
            if (pickListId <= 0) {
                    showAreaMessge("未找到有效的手插上料清单！", "messageRed");
                    return false;
                }
            if (confirm("确定卸下资源[" + $("#ddlResource option:selected'").text() + "]上的所有物料吗？")) {
               
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.PickListUnLoadMaterial(pickListId, prodOrderId, sltResId, 0);
                if (ajax.error != null) {
                    showAreaMessge(ajax.error.Message, "messageRed");
                    $("#sltPosition").empty();
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    scanSN = "";
                    return false;
                }
                showAreaMessge("卸料执行成功！", "messageGreen");
                status = 0;
                $("#lblCurrentQty").text(0);
                $("#lblToInputQty").text($("#lblNeedQty").text());
                buildPickListTable();
            }
        }

        /**
        *不良数录入
        */
        function inputNCQty() {
            if (pickListId <= 0) {
                showAreaMessge("未找到有效的手插上料清单！", "messageRed");
                return false;
            }
            var grn = $("#tablePickList  tr").find("input[name=chkPickList]:checked").val();

            $("#txtNCGRN").val(grn);

            showPage("layerNc");

            $("#txtNCGRN").focus();
            return;
        }

        /**
        *保存不良数录入
        */
        function saveNCMaterial() {
            var txtNCGRN = $("#txtNCGRN").val();
            var txtNCQty = $("#txtNCQty").val();
            if (txtNCGRN == "") {
                alert("请输入物料GRN！");
                $("#txtNCGRN").select();
                return false;
            }
            else if (txtNCQty == "") {
                alert("请输入物料GRN不良数量！");
                $("#txtNCQty").select();
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.PickListNCMaterial(pickListId, prodOrderId, txtNCGRN, txtNCQty, sltStationId, sltResId, 0);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                showAreaMessge(ajax.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, txtNCGRN, ajax.error.Message);
                return false;
            }

            buildPickListTable();
            $("#txtNCGRN,#txtNCQty").val("");
            alert("不良数录入成功!");
            $("#txtNCGRN").select();
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

        function openChoosePage(flags) {
            var condition = "";
            globalFlag = flags;

            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags +
                    "&Multiple=false&PageCondition=" +
                    escape(condition) + "&callBackFunc=getChooseValue1" +
                    "&rnd=" +
                    Math.random(),
                width: 700,
                height: 300
            });
        }

        function getChooseValue1(list) {
            switch (globalFlag) {
                case 21:  //选择产线
                    $("#txtLine").val(list[0][1]);
                <%--$("#<%=this.hdLineId.ClientID %>").val(list[0][0]);
                $("#<%=this.hdnLineName.ClientID %>").val(list[0][1]); --%>

                LineId = list[0][0];
                break;
            case 44:   //选择工单

                $("#txtOrder").val(list[0][1]);
                $("#hdOrderId").val(list[0][0]);
                prodOrderId = list[0][0];
                $("#txtOrderQty").text(list[0][3]);
                $("#txtItemName").text(list[0][5]);
                $("#hdItemCode").val(list[0][2]);
                //2、相关动态信息获取
                refreshProInfoByProOrderId(list[0][0]);
                //加载扣料工序信息
                loadStation();
                break;
            default:
                break;
        }
    }

    /**
    *显示相关功能窗口
    **/
    function showPage(pageContent) {
        var bodyheight = $("body").height();
        var bodywidth = $("body").width();

        $("#" + pageContent).show();
        $("#btnCancle,#divClose").bind("click", function () { $("#txtNCGRN,#txtNCQty,#CurrentGRN,#NewGRN").val(""); $("#layer,#" + pageContent).hide(); });
        $("#layer").css({
            height: bodyheight,
            width: bodywidth,
            display: "block"
        });
    }

    function onKeyPress(e, flage) {
        if (e.keyCode == 13) {
            stopDefault(e);
            if (flage == 1) {
                var curentGRN = $("#CurrentGRN").val();
                if (curentGRN == "") {
                    alert("请输入旧GRN");
                    return false;
                }
                else {
                    $("#NewGRN").focus();
                }
            }
            else if (flage == 2) {
                var newGRN = $("#NewGRN").val();
                if (newGRN == "") {
                    alert("请输入新GRN!");
                    return false;
                }
                else {
                    saveAddMaterial();
                }
            }
            else if (flage == 3) {
                var txtNCGRN = $("#txtNCGRN").val();
                if (txtNCGRN == "") {
                    alert("请输入物料GRN");
                    return false;
                }
                else {
                    $("#txtNCQty").focus();
                }
            }
            else if (flage == 4) {

                var txtNCQty = $("#txtNCQty").val();
                if (txtNCQty == "") {
                    alert("请输入物料GRN不良数量！");
                    return false;
                }
                else {
                    saveNCMaterial();
                }
            }
        }
    }

    /**
    *移除操作
    **/
    function remove(obj) {
        var grn = "";
        grn = $.trim($(obj).parent().parent().children('td').find("span[name=lblGRN]").text());
        if (grn == "") {
            return false;
        }

        if (confirm("确定移除已上料的GRN[" + grn + "]？")) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.PickListRemoveMaterial(pickListId, prodOrderId, grn,sltStationId, sltResId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                showAreaMessge(ajax.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, grn, ajax.error.Message);
                return false;
            }

            showAreaMessge("GRN[" + grn + "]移除成功！", "messageRed");
            //设置清单信息 
            setPickListInfo();
            //加载上料详情信息
            buildPickListTable();
        }

    }

    /**
    *清除文本信息
    **/
    function clear() {
        pickListId = -1;
        $("#chkStatus").prop("checked", false);
        $("#lblPickListName").text("");
        $("#lblNeedQty").text("");
        $("#lblCurrentQty").text("");
        $("#lblToInputQty").text("");
        $("#tablePickList  tr:not(:first)").remove();
        $("#tablePickList").append("<tr><td class= 'ListTableOddRow' colspan='7' align='center'>暂无数据！</td></tr>");
    }

    </script>
</asp:Content>
