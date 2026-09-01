<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditHeadMaster.master" CodeBehind="MaterialGrnShow.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialGrnShow" %>
<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<div class="ListTableTitle">先进先出列表</div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SerialNumber" HeaderText="GRN" ItemStyle-Width="25%"/>
            <asp:BoundField DataField="BalanceQty" HeaderText="数量" ItemStyle-Width="15%"/>
            <asp:BoundField DataField="CBarCode" HeaderText="库位条码" ItemStyle-Width="30%"/>
            <asp:BoundField DataField="PackTime" HeaderText="入库日期" ItemStyle-Width="30%"/>
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
    </script>
</asp:Content>


