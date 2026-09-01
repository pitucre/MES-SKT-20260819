<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="EquipmentRepairEditNew.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentRepairEditNew" %>

<asp:Content runat="server" ContentPlaceHolderID="viewcontent">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2" style="min-width: 70px;">维修单号</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblRepairNo"></asp:Label>
                <asp:HiddenField ID="hidRepairId" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">状态</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStatusName"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentCode %></td>
            <td class="Field2">
                <asp:Label ID="lblEquipmentCode" runat="server" />
            </td>
            <td class="Label2"><%= Resources.lang.EquipmentName %></td>
            <td class="Field2">
                <asp:Label ID="lblEquipmentName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
       <%--     <td class="Label2">线别</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLineName"></asp:Label>
            </td>--%>
            <td class="Label2">工序</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStationName"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">故障部位</td>
            <td class="Field2">
                <asp:Label runat="server" ID="FaultLocation"></asp:Label>
            </td>
            <td class="Label2">故障状况</td>
            <td class="Field2">
                <asp:Label runat="server" ID="FaultCause"></asp:Label>
            </td>
        </tr>
        <tr>
      <%--      <td class="Label2">异常类型</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblAnormalTypeName"></asp:Label>
            </td>--%>
            <td class="Label2">
                <label>紧急程度</label>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblUrgencyName"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">备件编码</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPartNo"></asp:Label>
            </td>
            <td class="Label2">备件数量</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPartQty"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">报修人
            </td>
            <td class="Field2">
                <asp:Label ID="lblCreateBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">报修时间</td>
            <td class="Field2">
                <asp:Label ID="lblCreateDateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">维修人</td>
            <td class="Field2">
                <asp:Label ID="lblRepairBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">维修开始时间</td>
            <td class="Field2">
                <asp:Label ID="lblRepairSTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">维修结束时间</td>
            <td class="Field2">
                <asp:Label ID="lblRepairETime" runat="server"></asp:Label>
            </td>
            <td class="Label2">故障描述</td>
            <td class="Field2">
                <asp:Label ID="lblAnormalDesc" runat="server"></asp:Label>
            </td>
        </tr>
         <tr>
            <td class="Label2">外修原因</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblExternalRepairRemark" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">验收/拒收备注</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblAcceptRemark" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">维修方法</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRepairFunction" runat="server" TextMode="MultiLine" ClientIDMode="Static" CssClass="TextArea" Width="500" Height="90"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">异常图片</td>
            <td class="Field2" colspan="3">
                <asp:Image ID="imgAnormalImg" runat="server" Style="max-width: 700px; max-height: 700px;" />
            </td>
        </tr>
         <asp:HiddenField ID="hidimg" runat="server" ClientIDMode="Static" />
    </table>
    <script>
        function Save() {
            var repairFunction = $.trim($("#txtRepairFunction").val());
            if (repairFunction == "") {
                alert("请输入维修方法");
                $("#txtRepairFunction").val("").focus();
                return false;
            }

            var entity =
            {
                EquipmentRepairId: parseInt($("#hidRepairId").val()),                   //维修单
                RepairFunction : repairFunction
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentRepairFunctionEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message, 0);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess%>');
            parent.window.UpdateList();
        }
    </script>
</asp:Content>

