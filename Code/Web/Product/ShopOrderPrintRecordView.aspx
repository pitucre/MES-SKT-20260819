<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="ShopOrderPrintRecordView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ShopOrderPrintRecordView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ActionType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblActionType" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PrintType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrintType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.PrintKey %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrintKey" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.Station %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblStation" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Resource %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblResource" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PrintUser %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrintUser" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.PrintTime %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblPrintTime" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
