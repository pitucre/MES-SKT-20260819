<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="SupplierExameResultView.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameResultView" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">  
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">考核类型</td>
            <td class="Field2">
                <asp:Label ID="lblExamType" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label2">
                考核时间
            </td>
            <td class="Field2">
                <asp:Label ID="lblExamDate" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">供应商编码</td>
            <td class="Field2">
                <asp:Label ID="lblVendorCode" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label2">
                供应商
            </td>
            <td class="Field2">
                <asp:Label ID="lblVendorName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">考核得分</td>
            <td class="Field2">
                <asp:Label ID="lblTotalGrades" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label2">
                考核模板
            </td>
            <td class="Field2">
                <asp:Label ID="lblSupplierExameName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableTitle">
        <span>考核详情</span><span id="demo1"></span>
    </div>
    <div style="height: 220px; overflow: auto;">
        <asp:GridView ID="GridView1" AutoGenerateColumns="true" runat="server" DataSourceID="ObjectDataSource1">
            <Columns>
                <asp:BoundField DataField="SupplierExameName" HeaderText="考核项名称"  />
                <asp:BoundField DataField="SupplierExameType" HeaderText="考核方式" />
                <asp:BoundField DataField="SupplierExameCompute" HeaderText="计算方法" />
                <asp:BoundField DataField="Grades" HeaderText="考核得分" />
                <asp:BoundField DataField="AssessmentWeight" HeaderText="权重" />
                <asp:BoundField DataField="WeightGrades" HeaderText="权重得分" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.SupplierExameResult"
            SelectMethod="GetAllSupplierExam" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
</asp:Content>
