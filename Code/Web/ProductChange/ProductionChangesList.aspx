<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="ProductionChangesList.aspx.cs" Inherits="SKT.LeanMES.Web.ProductChange.ProductionChangesList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">序列号</td>
            <td class="Field1">
                <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>            
            <asp:BoundField DataField="SerialNumber" HeaderText="序列号" />
            <asp:BoundField DataField="OldOrderNo" HeaderText="原工单" />   
            <asp:BoundField DataField="NewOrderNo" HeaderText="新工单" />
            <asp:BoundField DataField="OldRouterName" HeaderText="原路由" />
            <asp:BoundField DataField="NewRouterName" HeaderText="新路由" />
            <asp:BoundField DataField="OldStationName" HeaderText="原工序" />
            <asp:BoundField DataField="NewStationName" HeaderText="新工序" />            
            <asp:BoundField DataField="CreatedBy" HeaderText="变更人" />
            <asp:BoundField DataField="CretatedTime" HeaderText="变更时间" />
            <asp:BoundField DataField="Remark" HeaderText="变更原因" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.ProductChange.BLL.ProductionChange" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false; 
         
    </script>
</asp:Content>

