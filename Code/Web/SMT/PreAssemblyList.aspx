<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
Inherits="SKT.LeanMES.Web.SMT.PreAssemblyList" Codebehind="PreAssemblyList.aspx.cs" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"  >
                <%=Resources.lang.OrderNum%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="schOrderNO" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
             <td class="Label2"  >
                <%=Resources.lang.ModelNum%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="schModelNO" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">     
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="ContainerNO" HeaderText="<%$ Resources:lang,ContainerNO %>" SortExpression="ContainerNO" />
            <asp:BoundField DataField="ModelNO" HeaderText="<%$ Resources:lang,ModelNum %>" SortExpression="ModelNO" />
            <asp:BoundField DataField="OrderNO" HeaderText="<%$ Resources:lang,OrderNum %>" SortExpression="OrderNO" />
            <asp:BoundField DataField="PartNO" HeaderText="<%$ Resources:lang,MaterielNO %>" SortExpression="PartNO" />
            <asp:BoundField DataField="LotNO" HeaderText="<%$ Resources:lang,LotNO %>" SortExpression="LotNO" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>" SortExpression="CreateDateTime"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy %>" SortExpression="CreateBy"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.PreAssemblyContainer"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

