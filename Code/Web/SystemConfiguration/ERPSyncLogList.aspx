<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="ERPSyncLogList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.ERPSyncLogList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">同步编码</td>
            <td class="Field4">
                <asp:TextBox runat="server" ID="SyncCode" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">存储过程</td>
            <td class="Field4">
                <asp:TextBox runat="server" ID="SyncProcName" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">同步结果</td>
            <td class="Field4">
                <asp:DropDownList ID="SyncResult" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="-1" Selected="True">请选择</asp:ListItem>
                    <asp:ListItem Value="1" Text="<%$ Resources:lang, Succeed %>"></asp:ListItem>
                    <asp:ListItem Value="0" Text="<%$ Resources:lang, Fail %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label4">单据号</td>
            <td class="Field4">
                <asp:TextBox runat="server" ID="BillNo" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">同步消息</td>
            <td class="Field4">
                <asp:TextBox runat="server" ID="SyncMsg" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">创建时间</td>
            <td class="Field4">
                <asp:TextBox runat="server" ID="CreateDateTimeBegin" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                -
                <asp:TextBox runat="server" ID="CreateDateTimeEnd" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                <img title="点击清除日期" class="clear-time" style="margin: -10px 3px 0px 2px; cursor: pointer;" onclick="clearDataTime();" alt="点击清除日期" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" RowStyle-VerticalAlign="Middle">
        <Columns>
            <asp:BoundField DataField="SyncCode" HeaderText="同步编码" SortExpression="SyncCode" />
            <asp:BoundField DataField="SyncName" HeaderText="同步名称" SortExpression="SyncName" />
            <asp:BoundField DataField="SyncProcName" HeaderText="存储过程" SortExpression="SyncProcName" />
            <asp:BoundField DataField="SyncResultName" HeaderText="同步结果" SortExpression="SyncResult" />
            <asp:BoundField DataField="SyncMsg" HeaderText="同步消息" SortExpression="SyncMsg" />
            <asp:BoundField DataField="BillNo" HeaderText="单据号" SortExpression="BillNo" />
            <asp:BoundField DataField="QueryStartTime" HeaderText="查询ERP开始时间" SortExpression="QueryStartTime" />
            <asp:BoundField DataField="QueryEndTime" HeaderText="查询ERP结束时间" SortExpression="QueryEndTime" />
            <asp:BoundField DataField="InsertRowCount" HeaderText="新增行数" SortExpression="InsertRowCount" />
            <asp:BoundField DataField="UpdateRowCount" HeaderText="更新行数" SortExpression="UpdateRowCount" />
            <asp:BoundField DataField="DeleteRowCount" HeaderText="删除行数" SortExpression="DeleteRowCount" />
            <asp:BoundField DataField="StartSyncTime" HeaderText="同步开始时间" SortExpression="StartSyncTime" />
            <asp:BoundField DataField="EndSyncTime" HeaderText="同步结束时间" SortExpression="EndSyncTime" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.CommonDataSource.BLL.ERPSyncLog" SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        $(function () {
            $(".clear-time").click(function () {
                $(this).prevAll(".TextBox").val("");
            });
        });

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
