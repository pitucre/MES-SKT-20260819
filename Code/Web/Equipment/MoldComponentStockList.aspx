<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MoldComponentStockList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MoldComponentStockList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">模具构件名称</td>
            <td class="Field1">
                <asp:TextBox ID="txtComponentName" runat="server"></asp:TextBox>
            </td>            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="ComponentName" HeaderText="模具构件名称" ItemStyle-Width="200px" />
            <asp:BoundField DataField="InStock" HeaderText="在库数量" ItemStyle-Width="200px" />
            <asp:BoundField DataField="OutStock" HeaderText="出库数量"  ItemStyle-Width="200px" />
            <asp:BoundField DataField="TotalStock" HeaderText="总数量" ItemStyle-Width="200px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.MoldComponent"
        SelectMethod="GetMoldComponentStock" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
