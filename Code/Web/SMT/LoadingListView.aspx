<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.LoadingListView" CodeBehind="LoadingListView.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server" ViewStateMode="Enabled">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <div class="clear5"></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">模板类型：<em>*</em></td>
            <td class="Field2">
                <asp:Label ID="ddlloadingType" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.FullSet%>
            </td>
            <td class="Field2">
                <asp:CheckBox ID="cbFullSet" runat="server" Checked="true" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.SetupName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:Label ID="txtSetupName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.ItemsName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:Label ID="txtModelName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">线别设备类型：<em>*</em></td>
            <td class="Field2">
                <asp:Label ID="ddlEquipmentLine" runat="server"></asp:Label>
            </td>
            <td class="Label2">线别设备序号：<em>*</em></td>
            <td class="Field2 redFont">
                <asp:Label ID="ddlSequenceNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Revision %><em>*</em>
            </td>
            <td class="Field2">
                <asp:Label ID="txtRev" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
                <asp:Label ID="ddlStatus" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Layout %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="ddlLayout" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableTitle">
        <span>上料清单明细</span><span id="demo1"></span>
    </div>
    <div style="height: 220px; overflow: scroll;">
        <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
            <Columns>
                <asp:BoundField DataField="SetupName" HeaderText="上料清单" SortExpression="SetupName" />
                <asp:BoundField DataField="Area" HeaderText="区" SortExpression="Area" ItemStyle-Width="40px" />
                <asp:BoundField DataField="Position" HeaderText="料站/插槽" SortExpression="Position" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="MaterialItemCode" />
                <asp:BoundField DataField="SmtNum" HeaderText="需求用量" SortExpression="SmtNum" />
                <asp:BoundField DataField="FeederType" HeaderText="飞达类型" SortExpression="FeederType" />
                <asp:BoundField DataField="Point" HeaderText="点位" SortExpression="Point" />
                <asp:BoundField DataField="ReplaceNum" HeaderText="替代料" SortExpression="ReplaceNum" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.LoadingList_DETAIL"
            SelectMethod="GetLoadingListDetailAll" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdnTIDString" runat="server" ClientIDMode="Static" Value="-1" />
    <asp:HiddenField ID="hdnBoardItemID" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIsSwitchable" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIsRefDesignator" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnFamilyMatrixID" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnCreateTime" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        loadfloatButtons("demo1");
        var LoadingListId = '<%=Request.QueryString["ID"] %>';
        var name = '<%=Request.QueryString["name"] %>';
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        

    </script>
</asp:Content>
