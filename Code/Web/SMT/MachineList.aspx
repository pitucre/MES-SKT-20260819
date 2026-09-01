<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MachineList" Title="MODEL List Page" CodeBehind="MachineList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .itemCollapsed
        {
            background: url(../Content/theme/Metro/images/tree.gif) -5px -5px;
            width: 10px;
            height: 12px;
            cursor: pointer;
            margin: 7px;
            display: block;
            float: left;
        }
        .itemExpanded
        {
            background: url(../Content/theme/Metro/images/tree.gif) -5px -94px;
            width: 10px;
            height: 12px;
            cursor: pointer;
            margin: 7px;
            display: block;
            float: left;
        }
    </style>
    <div class="ListTableTitle" style="border-bottom: 0px;">
        <%=Resources.lang.MachineModelList%></div>
    <table class="ListTable" width="100%" cellpadding="3" cellspacing="0" border="0"
        id="tblMachineList">
        <tr class="ListTableHeader">
            <th width="3%">
                <input type="checkbox" name="chkAll" onclick="checkAll(this.checked);" style="display:none" />
            </th>
            <th width="20%" align="left">
                <%= Resources.lang.SerialNumber%>
            </th>
            <th width="10%" align="left">
                <%= Resources.lang.MachineModelName%>
            </th>
            <th width="10%" align="left">
                <%= Resources.lang.Line%>
            </th>
            <th align="left">
                <%= Resources.lang.Description%>
            </th>
            <th width="10%" align="left">
                <%= Resources.lang.Status%>
            </th>
        </tr>
    </table>
     
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var jsonStatus = [{ text: "Active", value: 0 }, { text: "Created", value: 1 }, { text: "Deleted", value: 2 }, { text: "InActive", value: 3 }, { text: "Processing", value: 4}];

        function StatusSelect(id) {
            var sel = "";
            for (var i = 0; i < jsonStatus.length; i++) {
                if (id == jsonStatus[i].value) {
                    sel += "<option value='" + jsonStatus[i].value + "' selected='selected'>" + jsonStatus[i].text + "</option>";
                }
                else {
                    sel += "<option value='" + jsonStatus[i].value + "'>" + jsonStatus[i].text + "</option>";
                }
            }
            return sel;
        }

        /*更新状态*/
        function ChangeStatus(Table, obj) {
            var _id = $(obj).parent().children("input").eq(0).val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceMachine.EditStatus(_id, Table, $(obj).val());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
        }

        /*增加 */
        function Add() {
            dialog({ title: "<%= Resources.lang.MachineAdd %>", src: "MachineEdit.aspx?name=MachineAdd&ID=-1", width: 588, height: 415, resizeable: true });
        }

        /*删除*/
        function Delete() {
            var idStr = "";
            var chkList = $("input[name='chkSelect']");
            for (var i = 0; i < chkList.length; i++) {
                if ($(chkList[i]).attr("checked")) {
                    idStr += $(chkList[i]).val() + ",";
                }
            }
            if (idStr == "") {
                alert("<%=Resources.Messages.RequireOnlyOneRecord %>");
                return false;
            }
            if (!window.confirm("<%=Resources.Messages.ConfirmDelete %>")) {
                return false;
            }
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        /*刷新页面*/
        function UpdateList(MachineSN) {
            document.forms[0].submit();
        }

        /*获取机器列表*/
        function GetMachineList() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceMachine.GetMachine("-1");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return ajax.value;
        }

        /*根据机器ID获取Table列表*/
        function GetMachineTableList(machineId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceMachine.GetMachineTable(machineId.toString());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return ajax.value;
        }

        /*根据Table ID 获取Slot列表*/
        function GetMachineTableSlotList(tableId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceMachine.GetMachineTableSlot(tableId.toString());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return ajax.value;
        }

        /*绑定数据*/
        $(function () {
            /*1、绑定机器*/
            var machineHtml = "";
            var list1 = GetMachineList();
            var style1 = "ListTableEvenRow";
            var isR = true;
            for (var i = 0; i < list1.length; i++) {
                isR = !isR;
                style1 = (style1 == "ListTableEvenRow") ? "ListTableOddRow" : "ListTableEvenRow";

                machineHtml = "<tr class='" + style1 + "' onmouseover='omi(this)' onmouseout='omt(this," + isR + ")' onclick='clk(" + list1[i].ID + "," + isR + ")'>";
                machineHtml += "<td><input type='checkbox' name='chkSelect' id='ckb" + list1[i].ID.toString() + "' value='" + list1[i].ID.toString() + "' /></td>";
                machineHtml += "<td><span class='itemCollapsed' onclick='toggleTable(this," + list1[i].ID + ")'></span>" + list1[i].MachineSN + "</td>";
                machineHtml += "<td>" + list1[i].ModelName + "</td>";
                machineHtml += "<td>" + list1[i].LineName + "</td>";
                machineHtml += "<td>" + list1[i].Description + "</td>";
                machineHtml += "<td><select onchange='ChangeStatus(1,this)'>" + StatusSelect(list1[i].Status) + "</select><input type='hidden' value='" + list1[i].ID.toString() + "'/></td>";
                machineHtml += "</tr>";

                /*2.绑定Table*/
                var list2 = GetMachineTableList(list1[i].ID);
                machineHtml += "<tr id='machine" + list1[i].ID.toString() + "' style='display:none; background:#faf9f9;' class='ListTableOddRow'><td colspan='6' style='padding-left:10px;'>";

                var tableHtml = "";

                tableHtml += "<table class='ListTable' width='80%'  cellpadding='2' cellspacing='0' border='0' id='tblMachineTableList'>";
                tableHtml += "<tr><td colspan='6' style='margin:0px; padding:0px;'>"
                tableHtml += "<div class='ListTableTitle' style='border:0px;'>";
                tableHtml += "<div style=' position:absolute; left:5px; top:0px;'><img src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/icon/list.png' alt='' style=' vertical-align:middle;'/>&nbsp;<%=Resources.lang.MachineTableList %></div>";
                tableHtml += "</div>";
                tableHtml += "</td></tr>";

                tableHtml += "<tr class='ListTableHeader'>";
                tableHtml += "<th width='25%' align='left'><%= Resources.lang.SerialNumber%></th>";
                tableHtml += "<th width='10%' align='left'><%= Resources.lang.TablePosition%></th>";
                tableHtml += "<th width='10%' align='left'><%= Resources.lang.MachineTableType%></th>";
                tableHtml += "<th align='left'><%= Resources.lang.Description%></th>";
                tableHtml += "<th width='10%' align='left'><%= Resources.lang.Status%></th>";
                tableHtml += "</tr>";
                var style2 = "ListTableEvenRow";
                var tableHtml2 = "";
                var isR2 = true;
                for (var j = 0; j < list2.length; j++) {
                    isR2 = !isR2;
                    style2 = (style2 == "ListTableEvenRow") ? "ListTableOddRow" : "ListTableEvenRow";

                    tableHtml2 += "<tr class='" + style2 + "' onmouseover='omi(this)' onmouseout='omt(this," + isR2 + ")'>";
                    tableHtml2 += "<td><span class='itemCollapsed' onclick='toggleSlot(this," + list2[j].MachineTableID + ")'></span>" + list2[j].MachineTableSN + "</td>";
                    tableHtml2 += "<td>" + list2[j].TablePosition + "</td>";
                    tableHtml2 += "<td>" + list2[j].MachineTableTypeName + "</td>";
                    tableHtml2 += "<td>" + list2[j].Description + "</td>";
                    tableHtml2 += "<td><select onchange='ChangeStatus(2,this)'>" + StatusSelect(list2[j].Status) + "</select><input type='hidden' value='" + list2[j].MachineTableID.toString() + "'/></td>";
                    tableHtml2 += "</tr>";

                    /*3.绑定Slot*/
                    //var list3 = GetMachineTableSlotList(list2[j].MachineTableID);
                    tableHtml2 += "<tr id='mtable" + list2[j].MachineTableID.toString() + "' style='display:none;' class='ListTableOddRow'>" +
                        "<td colspan='6' style='padding-left:10px;' class='tdAddSlot'></td></tr>";
                    //tableHtml2 = tableHtml2 + slotHtml + "</td></tr>";
                }
                tableHtml = tableHtml + tableHtml2 + "</table>";
                machineHtml = machineHtml + tableHtml + "</td></tr>";

                $(machineHtml).appendTo($("#tblMachineList"));
                machineHtml = "";
            }
        });


        /*Add By Alen 2014-06-18 增加此方法用来控制树形列表鼠标移上去的样式*/
        function omi(obj) {
            $(obj).addClass("ListTableHoverRow");
        }

        /*Add By Alen 2014-06-18 增加此方法用来控制树形列表鼠标移开的样式*/
        function omt(obj, r) {
            $(obj).removeClass("ListTableHoverRow");
            if ($(obj).children("td").eq(0).children("input[type='checkbox']").attr("checked") == undefined) {
                if (!r) {
                    $(obj).attr("class", "ListTableOddRow");
                }
                else {
                    $(obj).attr("class", "ListTableEvenRow");
                }
            }
        }

        /*Add By Alen 2014-06-20 增加此方法用来显示或隐藏Machine下的Table*/
        function toggleTable(obj, id) {
            $("#machine" + id.toString()).toggle();
            $(obj).toggleClass("itemExpanded");
        }

        /*Add By Alen 2014-06-20 增加此方法用来显示或隐藏Table下的Slot
            Birongliang 2016-12-21 抽出显示SLOT逻辑
        */
        function toggleSlot(obj, id) {
            var codeSlot = getSlot(id);
            $(obj).parent().parent().next().find('.tdAddSlot').html(codeSlot);
            $("#mtable" + id.toString()).toggle();
            $(obj).toggleClass("itemExpanded");
        }

        /*Add By Alen 2014-06-20 增加此方法用来处理行单击事件*/
        function clk(id, sss) {
            $("#tblMachineList input[type='checkbox']").each(function () {
                if ($(this).attr("id") != "ckb" + id.toString()) {
                    $(this).attr("checked", false);
                    $(this).parent().parent().removeClass("ListTableSelectedRow");
                }
            });

            if ($("#tblMachineList #ckb" + id.toString()).attr("checked") == undefined) {
                $("#tblMachineList #ckb" + id.toString()).parent().parent().addClass("ListTableSelectedRow");
                $("#tblMachineList #ckb" + id.toString()).attr("checked", true);
            }
            else {
                $("#tblMachineList #ckb" + id.toString()).attr("checked", false);
                if (sss) {
                    $("#tblMachineList #ckb" + id.toString()).parent().parent().attr("class", "ListTableEvenRow");
                }
                else {
                    $("#tblMachineList #ckb" + id.toString()).parent().parent().attr("class", "ListTableOddRow")
                }
            }
        }

        /*Add By Alen 2014-06-20 增加此方法用于全选记录或取消全选记录*/
        function checkAll(isChecked) {
            if (isChecked) {
                $("input[name='chkSelect']").attr("checked", true);
            }
            else {
                $("input[name='chkSelect']").attr("checked", false);
            }
        }

       /*Birongliang 2016-12-21 抽出显示SLOT逻辑*/
        function getSlot(tableId) {
            var list3 = GetMachineTableSlotList(tableId);
            var slotHtml = "<table class='ListTable' width='80%' cellpadding='2' cellspacing='0' border='0' id='tblMachineTblSlotList'>";
            slotHtml += "<tr><td colspan='6' style='margin:0px; padding:0px;'>";
            slotHtml += "<div class='ListTableTitle' style='border:0px;'>";
            slotHtml += "<div style=' position:absolute; left:5px; top:0px;'><img src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/icon/list.png' alt='' style=' vertical-align:middle;'/>&nbsp;<%=Resources.lang.TableSlotList %></div>";
            slotHtml += "</div>";
            slotHtml += "</td></tr>";

            slotHtml += "<tr class='ListTableHeader'>";
            slotHtml += "<th width='25%' align='left'><%= Resources.lang.SerialNumber%></th>";
            slotHtml += "<th width='10%' align='left'><%= Resources.lang.SlotPosition%></th>";
            slotHtml += "<th align='left'><%= Resources.lang.Description%></th>";
            slotHtml += "<th width='10%' align='left'><%= Resources.lang.Status%></th>";
            slotHtml += "</tr>";
            var style3 = "ListTableEvenRow";
            var slotHtml2 = "";
            var isR3 = true;
            for (var k = 0; k < list3.length; k++) {
                isR3 = !isR3;
                style3 = (style3 == "ListTableEvenRow") ? "ListTableOddRow" : "ListTableEvenRow";

                slotHtml2 += "<tr class='" + style3 + "' onmouseover='omi(this)' onmouseout='omt(this," + isR3 + ")'>";
                slotHtml2 += "<td>" + list3[k].TableSlotSN + "</td>";
                slotHtml2 += "<td>" + list3[k].SlotPosition + "</td>";
                slotHtml2 += "<td>" + list3[k].Description + "</td>";
                slotHtml2 += "<td><select onchange='ChangeStatus(3,this)'>" + StatusSelect(list3[k].Status) + "</select><input type='hidden' value='" + list3[k].TableSlotID.toString() + "'/></td>";
                slotHtml2 += "</tr>";
            }
            return slotHtml = slotHtml + slotHtml2 + "</table>";
        }
    </script>
</asp:Content>
