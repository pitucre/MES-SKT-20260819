<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentRepairList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentRepairList" Title="EquipmentRepair List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"><%=Resources.lang.RepairNo%></td>
            <td class="Field3">
                <asp:TextBox ID="txtRepairNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
             <td class="Label3"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field3">
                <asp:TextBox ID="txtEqCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">送修时间</td>
            <td class="Field3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />-
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
                <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
        </tr>
        <tr>
            <td class="Label3">维修人</td>
            <td class="Field3">
                <asp:TextBox ID="txtRepairBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
             <td class="Label3">设备名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">状态</td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlStates">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">待维修</asp:ListItem>
                    <asp:ListItem Value="1">维修中</asp:ListItem>
                    <asp:ListItem Value="2">已完成</asp:ListItem>
                    <asp:ListItem Value="3">待确认</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="RepairNo" HeaderText="<%$ Resources:lang, RepairNo %>" HeaderStyle-Width="125px"/>
            <asp:BoundField DataField="EqCode" HeaderText="<%$ Resources:lang, EquipmentCode %>" HeaderStyle-Width="125px"/>
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称" HeaderStyle-Width="125px" />
            <asp:BoundField DataField="CreateBy" HeaderText="送修人" HeaderStyle-Width="45px"/>
            <asp:BoundField DataField="RepairTime" HeaderText="送修时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" ItemStyle-Width="135px"/>
            <asp:BoundField DataField="RepairBy" HeaderText="维修人" HeaderStyle-Width="45px"/>
            <asp:BoundField DataField="RepairSTime" HeaderText="维修开始时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" ItemStyle-Width="135px"/>
            <asp:BoundField DataField="RepairETime" HeaderText="维修结束时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" ItemStyle-Width="135px" />
            <asp:BoundField DataField="StatusName" HeaderText="<%$ Resources:lang, Status %>" HeaderStyle-Width="45px"/>
            <asp:BoundField DataField="ConfirmUser" HeaderText="确认人" HeaderStyle-Width="45px" />
            <asp:BoundField DataField="ConfirmDateTime" HeaderText="确认时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="RepairDesc" HeaderText="<%$ Resources:lang, RepairDesc %>" />
            <asp:BoundField DataField="HandleContent" HeaderText="故障分析及处理"  Visible="false"/>

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Equipment.BLL.EquipmentRepair" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairEdit.aspx?name=EquipmentRepairListAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.EquipmentRepairListAdd %>", src: openWinUrl, width: 850, height: 450 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var status = getRecordCellTextsByFiled("StatusName");
            if (status != "待维修") {
                alert("只能编辑待维修的设备");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairEdit.aspx?name=EquipmentRepairListEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.EquipmentRepairListEdit %>", src: openWinUrl, width: 850, height: 450 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairEdit.aspx?name=EquipmentRepairListView&ID=" + idStr;
            dialog({ title: "查看维修信息", src: openWinUrl, width: 850, height: 450 });
        }

        function Repair() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var status = getRecordCellTextsByFiled("StatusName");
            if (status == "已完成") {
                alert("当前维修申请已完成");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairEdit.aspx?name=EquipmentRepairListRepair&ID=" + idStr;
            dialog({ title: "编辑维修信息", src: openWinUrl, width: 850, height: 450 });
        }
        //维修确认
        function RepairConfirm() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var status = getRecordCellTextsByFiled("StatusName");
            if (status != "待确认") {
                alert("设备未维修，不能确认！");
                return false;
            }
            if (confirm("是否确认维修已完成？")) {
                var entity = {};
                entity.EquipmentRepairId = idStr;
                entity.UserName = userName;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentRepairConfirm", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("维修确认成功！");
                document.forms[0].submit();
            }
        }

        //导出到EXCEL
        function Import() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            var listStatus = getRecordCellTextsByFiled("StatusName").split(",");
            if (listStatus.length > 0) {
                for (var i = 0; i < listStatus.length; i++) {
                    if (listStatus[i] != "待维修") {
                        alert("选择单据不是待维修状态，不能进行删除操作！");
                        return false;
                    }
                }
            }
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

