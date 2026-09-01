<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceRecordView.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceRecordView" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">

        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label1">
                    <%= Resources.lang.EquipmentCode%>
                </td>
                <td class="Field1">
                    <asp:Label ID="lblEquipmentCode" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    <%= Resources.lang.EquipmentName%>
                </td>
                <td class="Field1">
                    <asp:Label ID="lblEquipmentName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    <%= Resources.lang.EquipmentTypeName%>
                </td>
                <td class="Field1">
                    <asp:Label ID="lblEquipmentTypeName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    <%= Resources.lang.MaintainActionPerson%>
                </td>
                <td class="Field1">
                    <asp:Label ID="lblMaintainPerson" runat="server"></asp:Label>
                </td>
            </tr>
             <tr>
                <td class="Label1">
                    <%= Resources.lang.MaintainDetail%>
                </td>
                <td class="Field1">
                    <asp:Label ID="lblMaintainDetail" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    <%= Resources.lang.MaintainTime%>
                </td>
                <td class="Field1">
                    <asp:Label ID="lblMaintainDateTime" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    <%= Resources.lang.Remark%>
                </td>
                <td class="Field1">
                    <asp:Label ID="lblRemark" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

</asp:Content>



