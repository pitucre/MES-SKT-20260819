<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ShipmentView.aspx.cs" Inherits="SKT.LeanMES.Web.Shipment.ShipmentView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
  <table id="ShipmentTable" width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"> <%= Resources.lang.ShippingOrderNumber %></td>
            <td class="Field2">
                <asp:Label ID="lbOrderNO" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.Status %></td>
            <td class="Field2">
                <asp:Label ID="lbState" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ItemName%></td>
            <td class="Field2">
                <asp:Label ID="lbItemName" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.Qty%></td>
            <td class="Field2">
                <asp:Label ID="lbQty" runat="server" Text="Label"></asp:Label>
                  &nbsp;<asp:Label ID="lbUnit" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ShipDate %></td>
            <td class="Field2">
                <asp:Label ID="lbShipDate" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2">
                <asp:TextBox ID="txtbRemark" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.auditBy%></td>
            <td class="Field2">
                <asp:Label ID="auditBy" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.auditDateTime%></td>
            <td class="Field2">
                 &nbsp;<asp:Label ID="auditDateTime" runat="server" Text=""></asp:Label>
            </td>
        </tr>
          <tr>
            <td class="Label2"><%= Resources.lang.rejectBy%></td>
            <td class="Field2">
                <asp:Label ID="rejectBy" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.rejectDateTime%></td>
            <td class="Field2">
                 &nbsp;<asp:Label ID="rejectDateTime" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
