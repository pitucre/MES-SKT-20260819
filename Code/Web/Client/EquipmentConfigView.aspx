<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="EquipmentConfigView.aspx.cs" Inherits="SKT.LeanMES.Web.Client.EquipmentConfigView" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">

    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="CollectionDate" HeaderText="日期" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CollectionTime" HeaderText="时间" HeaderStyle-Width="120px" />
            <%--<asp:BoundField DataField="EquipmentType"   HeaderText="类型" />--%>
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MouldCode" HeaderText="模具编码" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MoldCavity" HeaderText="模穴数" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Status" HeaderText="状态" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="ShotCounter" HeaderText="开合模次" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="PerformanceTest" HeaderText="周期(节拍)计数器" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ProcessFormulaName" HeaderText="工艺配方名称" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="InjectionForce" HeaderText="注塑力" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MoldProtectionTime" HeaderText="模具保护时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ActualProtectionTime" HeaderText="模具保护时间实际值" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CycleTimeSetValue" HeaderText="周期时间设定值" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MaximumCycleTime" HeaderText="周期时间最大值" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="PreviousCycleTime" HeaderText="上一节拍周期时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CoolingTime" HeaderText="冷却时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ActualBasketballTimeValue" HeaderText="冷却时间实际值" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ActualValueOfMoldClosingTime" HeaderText="合模时间实际值" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="RotationPositionMoldRotationCycleTime" HeaderText="旋转位置转出模具循环时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ConfirmCycleInsertTime" HeaderText="确认镶件插入位置周期时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ConfirmTheRemovalOfPositionCycleTime" HeaderText="确认去除位置周期时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="DryCycleTime" HeaderText="干循环时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ClosingTime" HeaderText="合模时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ShutdownTimeBeforeRestartingProduction" HeaderText="重启生产前停机时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="UnlockTime" HeaderText="解锁时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MoldOpeningTime" HeaderText="开模时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="LockingForceAndUnloadingTime" HeaderText="锁模力卸力时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ConstructionTimeOfLockingForce" HeaderText="锁模力建设时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MoldOpeningCycleTime" HeaderText="开模周期时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="LockTime" HeaderText="锁定时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="NeutronMotionTime" HeaderText="中子运动时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MoldPauseTime" HeaderText="模具暂停时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="UntilTheCompletionTimeOfDemolding" HeaderText="至脱模完成时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="TopOutTime" HeaderText="顶出时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="NozzleAdvanceCycleTime" HeaderText="喷嘴前进周期时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ActualValueOfCleaningTime" HeaderText="清洗时间实际值" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="PressureHoldingCycleTime" HeaderText="保压周期时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="PressureHoldingCycleTimeSettingValue" HeaderText="保压周期时间设定值" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MoldNumber" HeaderText="模具号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MachineNumber" HeaderText="机器号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="AutomatedProductionOfFirstPiece" HeaderText="自动生产首件" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="TotalProductionQuantity" HeaderText="总生产数量" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ActualValueOfProductCounter" HeaderText="产品计数器实际值" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Temperature" HeaderText="温度" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="InternalCavityPressureDuringPressureConversion" HeaderText="转压时模内型腔压力" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ReasonForShutdown" HeaderText="停机原因" HeaderStyle-Width="120px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.Equipments"
        SelectMethod="GetCollectionEquiConfigList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        isMultiple = false;

        $(function () {
            //var tbObj = $(".ListTable");
            //var length = tbObj.find("tr:not(.ListTableEmptyDataRow)").length;
            //if (length == 0) {
            //    tbObj.hide();
            //}
            //tbObj.find("tr th:nth-child(1)").hide();
            //tbObj.find("tr td:nth-child(1)").hide();

            $("#searchField").hide();
            $("#updownSearchContainer1").hide();
        })

        //function Export() {
        //    hdnOperate.val("ExportExcel");
        //    document.forms[0].submit();
        //    hdnOperate.val("");
        //}
    </script>
</asp:Content>
