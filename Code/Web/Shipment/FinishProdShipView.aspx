<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="FinishProdShipView.aspx.cs" Inherits="SKT.LeanMES.Web.Shipment.FinishProdShipView" %>
<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
  <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>            
            <asp:BoundField DataField="SerialNumber" HeaderText="已扫条码" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Shipment.BLL.ShipmentRecord"
        SelectMethod="GetAllSNInfo" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $("#chkAll").hide();
        }); 
    </script>
</asp:Content>
