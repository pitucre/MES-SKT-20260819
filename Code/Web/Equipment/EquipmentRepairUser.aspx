<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="EquipmentRepairUser.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentRepairUser" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">用户名
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">工号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEmployeeNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">中文名
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="用户名" SortExpression="UserName" />
            <asp:BoundField DataField="EmployeeNo" HeaderText="工号" />
            <asp:BoundField DataField="CName" HeaderText="中文名" />
<%--            <asp:BoundField DataField="WorkShiftName" HeaderText="班次" />--%>
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="DepartNo" HeaderText="部门编号" />
            <asp:BoundField DataField="DepartName" HeaderText="部门" />
            <asp:BoundField DataField="EquipmentRepairUserId" HeaderText="EquipmentRepairUserId" ItemStyle-CssClass="EquipmentRepairUserId" HeaderStyle-CssClass="EquipmentRepairUserId" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentRepairUser"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnRoleId" name="hdnIdString" value="-1" runat="server" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var gridId = "<%= this.GridView1.ClientID %>";

        $(function () {
            $("#" + gridId + " .EquipmentRepairUserId").hide();
        });

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairUserEdit.aspx?name=EquipmentRepairUserAdd&ID=-1";
            dialog({ title: mesLang("新增设备维修人员"), src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            var equipmentRepairUserId = $.trim($("#" + gridId + " input[name=\"chkSelect\"]:checked").closest("tr").find("td.EquipmentRepairUserId").text());
            if (idStr == "" || equipmentRepairUserId == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairUserEdit.aspx?name=EquipmentRepairUserEdit&ID=" + equipmentRepairUserId;
            dialog({ title: mesLang("编辑设备维修人员"), src: openWinUrl, width: 600, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;

            var equipmentRepairUserIds = "";
            var chk = $("#" + gridId + " input[name=\"chkSelect\"]:checked");
            chk.each(function (i) {
                var id = $.trim($(this).closest("tr").find("td.EquipmentRepairUserId").text());
                equipmentRepairUserIds += (i == 0 ? id : "," + id);
            });
            if (equipmentRepairUserIds == "") return false;

            hdnOperate.val("delete");
            hdnIdString.val(equipmentRepairUserIds);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            var equipmentRepairUserId = $.trim($("#" + gridId + " input[name=\"chkSelect\"]:checked").closest("tr").find("td.EquipmentRepairUserId").text());
            if (idStr == "" || equipmentRepairUserId == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairUserView.aspx?name=EquipmentRepairUserView&ID=" + equipmentRepairUserId;
            dialog({ title: "<%=Resources.Pages.Account_UserView %>", src: openWinUrl, width: 600, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
