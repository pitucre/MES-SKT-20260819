<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="True"
    CodeBehind="SteelMeshView.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshView"
    Title="View SteelMesh" %>
<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        
        <tr>
            <td class="Label3">
                设备名称
            </td>
            <td class="Field3">
                <asp:Label ID="lblEquipmentName" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                设备编号
            </td>
            <td class="Field3">
                <asp:Label ID="lblEquipmentCode" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                设备类型
            </td>
            <td class="Field3">
                <asp:Label ID="lblEquipmentType" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                设备型号
            </td>
            <td class="Field3">
                <asp:Label ID="lblEquipmentModel" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                存放位置
            </td>
            <td class="Field3">
                <asp:Label ID="lblPosition" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                设备状态
            </td>
            <td class="Field3">
                <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.thick%>（毫米）
            </td>
            <td class="Field3">
                <asp:Label ID="lblThick" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%= Resources.lang.VendorName%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblVendorName" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%= Resources.lang.VendorBarNo %>
            </td>
            <td class="Field3">
                <asp:Label ID="lblVendorBarcodeNum" runat="server" Text=""></asp:Label>
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
            <td class="Label3">
                线别
            </td>
            <td class="Field3">
                <asp:Label ID="lbllineName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.StandarLive%>（次数）
            </td>
            <td class="Field3">
                <asp:Label ID="lblStandarLive" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%= Resources.lang.UserCount%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblUseCount" runat="server" Text="0"></asp:Label>
            </td>
            <td class="Label3">
                保养预警
            </td>
            <td class="Field3">
                <asp:Label ID="lblWarningCount" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                当前位置
            </td>
            <td class="Field3">
                <asp:Label ID="lblCurPosition" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                在库状态
            </td>
            <td class="Field3">
                <asp:Label ID="lblInOrOut" runat="server" Text="" ></asp:Label>
            </td>
            <td class="Label3">
                清洗状态
            </td>
            <td class="Field3">
                <asp:Label ID="lblIsClear" runat="server" Text="" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="5">
                <asp:Label ID="lblRemark" runat="server" Text="" ></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshEdit.aspx?name=SteelMeshEdit&ID=" + '<%= Request.QueryString["ID"] %>';
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
            SelectMethod="GetAll" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>

    </asp:Panel>
</asp:Content>
