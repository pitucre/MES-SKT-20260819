<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="LoadingListGrnRecord.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.LoadingListGrnRecord" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.SetupName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSetupName" runat="server" CssClass="TextBox" patterns="AutoComplete"
                    source="SetupName" field="SetupName" minChars="2"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="setupName" HeaderText="<%$ Resources:lang,setupName %>" />
            <asp:BoundField DataField="revision" HeaderText="<%$ Resources:lang,revision %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" HeaderStyle-Width="180px"/>            
            <asp:BoundField DataField="SerialNumber" HeaderText="<%$ Resources:lang,GRN %>" />            
            <asp:BoundField DataField="CreationTime" HeaderText="<%$ Resources:lang,CreateTime %>"  HeaderStyle-Width="150px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.Loadinglist"
        SelectMethod="GetAllGRN" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
