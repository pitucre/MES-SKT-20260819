<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="True"
    CodeBehind="SparePartsView.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.PartsView" Title="View Parts" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label3"><%= Resources.lang.ToolName %></td>
            <td class="Field3">
                <asp:Label ID="lblPartName" runat="server"></asp:Label>
            </td>
            <td class="Label3"><%= Resources.lang.ToolCode%></td>
            <td class="Field3">
                <asp:Label ID="lblPartNickName" runat="server"></asp:Label>
            </td>
            <td class="Label3"><%= Resources.lang.PartLocation%></td>
            <td class="Field3">
                <asp:Label ID="lblPartLocation" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3"><%= Resources.lang.PartStandard%></td>
            <td class="Field3">
                <asp:Label ID="lblPartStandard" runat="server"></asp:Label>
            </td>
            <td class="Label3">工具类别</td>
            <td class="Field3">
                <asp:Label ID="lblPartCategory" runat="server"></asp:Label>
            </td>
            <td class="Label3"><%= Resources.lang.venCode%></td>
            <td class="Field3">
                <asp:Label ID="lblVencode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.EnterFactoryDate%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblFactoryDate" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%= Resources.lang.ProduceDate%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblProduceDate" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3"><%= Resources.lang.Supplier%></td>
            <td class="Field3">
                <asp:Label ID="lblSupplier" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3"><%= Resources.lang.PartUnit%></td>
            <td class="Field3">
                <asp:Label ID="lblPartUnit" runat="server"></asp:Label>
            </td>
            <td class="Label3"><%= Resources.lang.PartQty%></td>
            <td class="Field3">
                <asp:Label ID="lblPartQty" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                使用期限
            </td>
            <td class="Field3">
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </td>
        </tr>
         <tr>
            <td class="Label3"><%= Resources.lang.Remark%></td>
            <td class="Field3" colspan="5">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
           
        </tr>
    </table>

    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/SparePartsEdit.aspx?name=Production_SparepartEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:Panel ID="plContent2" runat="server">
        <div class="ListTableTitle">
            <%=Resources.lang.Item%>&nbsp;<span id="bomCompList"></span>
        </div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
            <Columns>
                <%-- To Do --%>
                <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
                <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />
                <asp:BoundField DataField="layout" HeaderText="面别" />
                <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SteelItem.BLL.SteelItem"
            SelectMethod="GetAll_Spare" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>

    </asp:Panel>
</asp:Content>