<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditListMaster.master" AutoEventWireup="true" CodeBehind="RMAReciveView.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.RMAReciveView" %>

<%@ MasterType VirtualPath="~/Masters/EditListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                RMA单号
            </td>
            <td class="Field3">
                <span id="lblRMANo" runat="server"></span>
            </td>
            <td class="Label3">
                客户
            </td>
            <td class="Field3">
                <span id="lblCustomerName" runat="server"></span>
            </td>
            <td class="Label3">
                产品名称
            </td>
            <td class="Field3">
                <span id="lblItemName" runat="server"></span>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                产品编码
            </td>
            <td class="Field3">
                <span id="lblItemCode" runat="server"></span>
            </td>
            <td class="Label3">
                规格
            </td>
            <td class="Field3">
                <span id="lblItemSpec" runat="server"></span>
            </td>
            <td class="Label3">
                申请数量
            </td>
            <td class="Field3">
                <span id="lblNumber" runat="server"></span>
            </td>
        </tr> 
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ListContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="RmaNo" HeaderText="RMA编号" />
            <asp:BoundField DataField="SN" HeaderText="产品条码" />
            <asp:BoundField DataField="StatusName" HeaderText="产品状态" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            <asp:BoundField DataField="CWhName" HeaderText="仓库名称" />
            <asp:BoundField DataField="cBarCode" HeaderText="库位" />
        </Columns>
        <EmptyDataTemplate>
            <label>没有数据</label>
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.RMAUnit"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        isMultiple = false;

    </script>
</asp:Content>
