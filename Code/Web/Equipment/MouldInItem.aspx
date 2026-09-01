<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChooseListMaster.master" AutoEventWireup="true" CodeBehind="MouldInItem.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldInItem" %>
<%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
             <td class="Label1">
                 <%=Resources.lang.MouldName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtBomName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
              <asp:BoundField DataField="BomName" HeaderText="<%=Resources.lang.MouldName%>" ItemStyle-Width="90px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.MoludBom"
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
