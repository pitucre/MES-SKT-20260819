<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChooseListMaster.master" AutoEventWireup="true" CodeBehind="StationMatPreList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationMatPreList" %>
<%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
   <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                物料编码
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码"
                HeaderStyle-Width="100px" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="物料描述"
                SortExpression="ItemName" />
            <asp:BoundField DataField="CategoryOne" HeaderText="大类"
                  SortExpression="CategoryOne" />
            <asp:BoundField DataField="CategoryTwo" HeaderText="中类" 
                SortExpression="CategoryTwo" />
            <asp:BoundField DataField="CategoryThree" HeaderText="小类"
                  SortExpression="CategoryThree" />             
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.Item"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        isMultiple = true;
</script>
</asp:Content>

