<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceEquimentList.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceEquimentList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.PlanName%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPlanName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.EquipmentCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">预警状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlWarnStatus" runat="server">
                    <asp:ListItem Text="全部" Value=""></asp:ListItem>
                    <asp:ListItem Text="是" Value="Warning"></asp:ListItem>
                    <asp:ListItem Text="否" Value="Not Warning"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">保养人工号
            </td>
            <td class="Field3">
                <asp:TextBox ID="EmployeeNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">下次保养日期
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtLastMaintainTimeStart" Style="width: 78px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtLastMaintainTimeEnd" Style="width: 78px;" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">周期类型
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlCycleType" runat="server">
                    <asp:ListItem Text="全部" Value=""></asp:ListItem>
                    <asp:ListItem Value="0" Text="时间"></asp:ListItem>
                    <asp:ListItem Value="1" Text="小时"></asp:ListItem>
                    <asp:ListItem Value="2" Text="天"></asp:ListItem>
                    <asp:ListItem Value="3" Text="周"></asp:ListItem>
                    <asp:ListItem Value="4" Text="月"></asp:ListItem>
                    <asp:ListItem Value="5" Text="年"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="PlanName" HeaderText="<%$Resources:lang,PlanName %>" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$Resources:lang,EquipmentCode %>" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$Resources:lang,EquipmentName %>" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="MaintainWayStr" HeaderText="<%$Resources:lang,MaintainWay %>" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="CycleTypeStr" HeaderText="<%$Resources:lang,CycleType %>" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="CycleTime" HeaderText="<%$Resources:lang,CycleTime  %>" HeaderStyle-Width="50px" />
            <asp:BoundField DataField="Usage" HeaderText="<%$Resources:lang,EquipmentUsedTimes %>" HeaderStyle-Width="50px" />

            <asp:BoundField DataField="PrewarningStr" HeaderText="<%$Resources:lang,PreWarning %>" HeaderStyle-Width="50px" />
            <%--       <asp:BoundField DataField="PrewarningStr" HeaderText="<%$Resources:lang,PreWarning %>" HeaderStyle-Width="50px"/>--%>
            <%--            <asp:BoundField DataField="MaintainPerson" HeaderText="<%$Resources:lang,MaintainActionPerson %>" HeaderStyle-Width="60px"/>--%>
            <asp:BoundField DataField="MaintainPersonName" HeaderText="<%$Resources:lang,MaintainActionPerson %>" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="WarningTo" HeaderText="<%$Resources:lang,PreWarningReceivePerson %>" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="StatusStr" HeaderText="<%$Resources:lang,WarningStatus %>" HeaderStyle-Width="80px" />

            <asp:BoundField DataField="FinisheDateTime" HeaderText="<%$Resources:lang,NextMaintainTime %>" HeaderStyle-Width="120px" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />
            <asp:BoundField DataField="LastMaintainTime" HeaderText="<%$Resources:lang,LastMaintainTime %>" HeaderStyle-Width="120px" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Remark" HeaderText="备注" HeaderStyle-Width="80px" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Maintenance.BLL.MaintenancePlan"
        SelectMethod="GetEquimentAll" SelectCountMethod="GetCount">
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

        //添加
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceEquimentEdit.aspx?name=Maintenance_MaintenanceEquimentAdd&Id=-1";
            dialog({ title: "<%=Resources.Pages.Maintenance_MaintenancePlanAdd %>", src: openWinUrl, width: 920, height: 560 });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceEquimentEdit.aspx?name=Maintenance_MaintenanceEquimentEdit&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_MaintenancePlanEdit %>", src: openWinUrl, width: 920, height: 560 });
        }

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceEquimentPlanView.aspx?name=Maintenance_MaintenancePlanView&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_MaintenancePlanView %>", src: openWinUrl, width: 920, height: 560 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        //计划保养确认
        function Confirm() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/PlanMaintainConfirm.aspx?name=Maintenance_PlanMaintainConfirm&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_PlanMaintainConfirm%>", src: openWinUrl, width: 920, height: 560 });
        }
        //保养
        function Ckeck() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceCheck.aspx?name=Maintenance_PlanMaintainCkeck&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_PlanMaintainCkeck%>", src: openWinUrl, width: 920, height: 560 });
        }
        function UpdateList(planName, equipmentCode) {
            $("#<%=this.txtPlanName.ClientID %>").val(planName);
            $("#<%=this.txtEquipmentCode.ClientID %>").val(equipmentCode);

            document.forms[0].submit();
        }
        function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=QC_InspectionItemDialog&controlId=controlId";
            dialog({ title: "设备类型", src: openWinUrl, width: 255, height: 350 });
        }
        SetValue = function (list) {
            closeDialog();
           <%-- $("#<%=txtEquimentType.ClientID%>").val(list[0].name);--%>
        }
    </script>
</asp:Content>

