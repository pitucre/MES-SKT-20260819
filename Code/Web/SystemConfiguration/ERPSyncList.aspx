<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="ERPSyncList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.ERPSyncList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">同步编码</td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="SyncCode" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">同步名称</td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="SyncName" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" RowStyle-VerticalAlign="Middle">
        <Columns>
            <asp:BoundField DataField="SyncCode" HeaderText="同步编码" SortExpression="SyncCode" />
            <asp:BoundField DataField="SyncName" HeaderText="同步名称" SortExpression="SyncName" />
            <asp:BoundField DataField="FullSyncName" HeaderText="同步标识" SortExpression="FullSyncName" />
            <asp:BoundField DataField="InitCompleteFlagName" HeaderText="是否初始化完成" SortExpression="InitCompleteFlag" />
            <asp:BoundField DataField="IncrementalValue" HeaderText="同步递增量(天)" SortExpression="IncrementalValue" />
            <asp:BoundField DataField="LastSyncResultName" HeaderText="最后一次同步结果" SortExpression="LastSyncResult" />
            <asp:BoundField DataField="LastSyncMsg" HeaderText="最后一次同步消息" SortExpression="LastSyncMsg" />
            <asp:BoundField DataField="LastSyncTime" HeaderText="最后同步时间" SortExpression="LastSyncTime" />
            <asp:BoundField DataField="Remark" HeaderText="备注" SortExpression="Remark" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.CommonDataSource.BLL.ERPSync" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
