<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChooseListMaster.master" AutoEventWireup="true" CodeBehind="EquipmentPreItem.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentPreItem" %>
<%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                设备编码
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$ Resources:lang,EquipmentCode %>" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$ Resources:lang,EquipmentName %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.Equipments"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="search"/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value=""/>
    <script type="text/javascript">
        isMultiple = true;
    </script>
</asp:Content>

