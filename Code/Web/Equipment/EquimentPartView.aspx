<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="EquimentPartView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquimentPartView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.PartCode%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPartCode" runat="server"></asp:Label>
            </td>
             <td class="Label2">
                <%= Resources.lang.myPartName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPartName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.EquipmentName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblEquimentName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentCode%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblEquimentCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
            <%= Resources.lang.CreateTime%>
            </td>
            <td class="Field2" colspan="3">
            <asp:Label ID="lblCreateTime" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
