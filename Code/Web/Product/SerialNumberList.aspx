<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="SerialNumberList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.SerialNumberList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                工单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="bnOper" class="ButtonBox" onclick="openChoosePage()" value="..." />
            </td>
            <td class="Label2">
                号码类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlNumberType" runat="server" ClientIDMode="Static" isrequired="1">
                    <asp:ListItem Value="产品条码">产品条码</asp:ListItem>
                    <asp:ListItem Value="MAC条码">MAC条码</asp:ListItem>
                </asp:DropDownList>  
            </td>          
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="NumberType" HeaderText="号码类型" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="SerialNumber" HeaderText="条码" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateBy" HeaderText="建立人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="建立时间" HeaderStyle-Width="120px" />     
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdUnit.BLL.BarCodeScope"
        SelectMethod="GetSerialNumberAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        
    </script>
</asp:Content>
