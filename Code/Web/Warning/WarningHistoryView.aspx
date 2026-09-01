<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="WarningHistoryView.aspx.cs" Inherits="SKT.LeanMES.Web.Warning.WarningHistoryView" %>
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
                <asp:Label ID="lblWarningType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                工单
            </td>
            <td class="Field2">
                <asp:Label ID="lblOrder" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                线别
            </td>
            <td class="Field2">
                <asp:Label ID="lblLineName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                良率
            </td>
             <td class="Field2">
                <asp:Label ID="lblRatio" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                不良现象
            </td>
             <td class="Field2">
                <asp:Label ID="lblNcNum" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                一级解决方案
            </td>
            <td class="Field2" colspan="3">  
                <asp:Label ID="lblSolution1" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                二级解决方案
            </td>
            <td class="Field2" colspan="3">
                 <asp:Label ID="lblSolution2" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                三级解决方案
            </td>
            <td class="Field2" colspan="3">
                 <asp:Label ID="lblSolution3" runat="server"></asp:Label>
            </td>
        </tr>  
        <tr>
            <td class="Label2">
                关闭人
            </td>
             <td class="Field2">
                <asp:Label ID="lblCloseBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                关闭时间
            </td>
             <td class="Field2">
                <asp:Label ID="lblCloseDateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                状态
            </td>
            <td class="Field2" colspan="3">
                 <asp:Label ID="lblStatusName" runat="server"></asp:Label>
            </td>
        </tr>  
    </table>
</asp:Content>
