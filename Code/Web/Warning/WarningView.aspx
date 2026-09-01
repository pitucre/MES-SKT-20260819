<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="WarningView.aspx.cs" Inherits="SKT.LeanMES.Web.Warning.WarningView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarningName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblWarningName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarningType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblWarningGroup" runat="server"></asp:Label> -
                <asp:Label ID="lblWarningType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2" id="txtRatio">
                警报预警值
            </td>
             <td class="Field2">
                <asp:Label ID="lblRatio" runat="server"></asp:Label>
            </td>
            <td class="Label2" id="Td1">
                 
            </td>
             <td class="Field2">
                
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarningDesc %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblWarningDesc" runat="server"></asp:Label>
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                <%= Resources.lang.WarningLevel %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblWarningLevel" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.CycleType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCycleType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                <%= Resources.lang.CycleTime %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCycleTime" runat="server"></asp:Label><asp:Label ID="labCycleTime" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PreWarning %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPreWarning" runat="server"></asp:Label><asp:Label ID="labPreWarning" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MessageType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblMessageType" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                基准值
            </td>
            <td class="Field2">
                 <asp:Label ID="lblRatioNum" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.RecipientLevel1 %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblRecipientLevel1" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                一级操作间隔
            </td>
            <td class="Field2" >
               <asp:Label ID="lblIntervalTime1" runat="server"></asp:Label>&nbsp;Minutes  
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ReceiveContent1 %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblReceiveContent1" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.RecipientLevel2 %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRecipientLevel2" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ReceiveContent2 %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblReceiveContent2" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                二级操作间隔
            </td>
            <td class="Field2" >
                <asp:Label ID="lblIntervalTime2" runat="server"></asp:Label>&nbsp;Minutes             
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.RecipientLevel3 %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRecipientLevel3" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ReceiveContent3 %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblReceiveContent3" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.CreateBy %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCreateBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.CreateDateTime %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCreateDateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ModifyBy %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblModifyBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.ModifyDateTime %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblModifyDateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningEdit.aspx?name=Quality_WarningEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
