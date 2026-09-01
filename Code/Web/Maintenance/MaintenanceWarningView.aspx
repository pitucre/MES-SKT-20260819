<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceWarningView.aspx.cs"
    Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceWarningView" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.EquipmentCode%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentCode"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentName"></asp:Label>
            </td>
        </tr>
      <%--  <tr>
            <td class="Label2">
                <%= Resources.lang.LineName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLineName"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.StationName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStation"></asp:Label>
            </td>
        </tr>--%>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainWay%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblMaintainWay"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.CycleType%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblCycleType"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainActionPerson%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblMaintainActionPerson"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PreWarningReceivePerson%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblWarningTo"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.PreWarningReceiveEmail%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblWarningEmail"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarningStatus%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStatusStr"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.CycleTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblCycleTime"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.DistanceNextMaintenanceTimeLimit%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblWillMaintainOfTimes"></asp:Label>
            </td>
        </tr>
        <!-----按次数结果------>
        <tr id="tr1ByUsage" runat="server">
            <td class="Label2">
                <%= Resources.lang.EquipmentUsedTimes%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblUsage"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.DistancePreWarningTimeLimit%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblWillSendWarningTimes"></asp:Label>
            </td>
        </tr>
        <tr id="tr2ByUsage" runat="server">
            <td class="Label2">
                <%= Resources.lang.LastMaintainUsedTimes%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLastTimes"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentLifeTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLifeTime"></asp:Label>
            </td>
        </tr>
        <!---按周期的结果--->
        <tr id="trByCycle" runat="server">
            <td class="Label2">
                <%= Resources.lang.NextMaintainTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblWillMaintainOfDateTime"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.NextPreWarningTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblWillSendWarningDateTime"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.LastMaintainTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLastDateTime"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.TimeoutPreWarning%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblTimeoutWarning"></asp:Label>
            </td>
        </tr>
        <%--        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainDetail%>
            </td>
            <td class="Field2" colspan="3" style="height:100px">
                <asp:Label runat="server" ID="lblMaintainContents"></asp:Label>
            </td>
        </tr>--%>
    </table>
    <asp:HiddenField ID="hdfPlanId" runat="server" />
    <div class="clear5">
    </div>
    <table class="ListTable" id="tbDemo" style="width: 100%;">
        <tr class="ListTableHeader">
            <th>
                <%= Resources.lang.MaintenanceDemoNO%>
            </th>
            <th>
                <%= Resources.lang.MaintenanceDemoName%>
            </th>
            <th>
                <%= Resources.lang.Description%>
            </th>
            <th>
                是否已保养
            </th>
        </tr>
        <tbody id="tbody">
        </tbody>
    </table>
    <script type="text/javascript">
        var pid = $("#<%=this.hdfPlanId.ClientID %>").val();
        var eid=  '<%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>';
        $(document).ready(function () {
            //如果是在列表页点击的新增，编辑。
            GetDemoListByPlanId(eid);
        });
        /*通过计划id获取保养项目列表*/
        function GetDemoListByPlanId(planId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.GetRelationList(planId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax != null) {
                var tbody = $("#tbody");
                var html = "";
                for (var i = 0; i < ajax.value.Rows.length; i++) {
                    html += "<tr class='ListTableOddRow'><input id='hdf" + ajax.value.Rows[i].DemoId + "' type='hidden' value='" + ajax.value.Rows[i].DemoId + "' />";
                    html += "<td>";
                    html += ajax.value.Rows[i].DemoCode;
                    html += "</td>";

                    html += "<td>";
                    html += ajax.value.Rows[i].DemoName;
                    html += "</td>";

                    html += "<td>";
                    html += ajax.value.Rows[i].Description;
                    html += "</td>";

                    html += "<td>";
                    if (ajax.value.Rows[i].IsDone == "1") {
                        html += "<input id='cb'" + ajax.value.Rows[i].DemoId + "' type='checkbox' checked='checked' disabled='disabled'/>";
                    }
                    else {
                        html += "<input id='cb'" + ajax.value.Rows[i].DemoId + "' type='checkbox' disabled='disabled'/>";
                    }
                    html += "</td>";
                }
                tbody.append(html);
            }
        }
    </script>
</asp:Content>
