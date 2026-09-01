<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="SystemOperation.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.SystemOperation" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">功能名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtPageName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtOederNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">操作描述</td>
            <td class="Field3">
                <asp:TextBox ID="txtOperation" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">操作人</td>
            <td class="Field3">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">开始时间</td>
            <td class="Field3">
                <asp:TextBox ID="txtBegTime" runat="server" CssClass="DateTimeBox" Width="150px"></asp:TextBox>
            </td>
            <td class="Label3">结束时间</td>
            <td class="Field3">
                <asp:TextBox ID="txtEndTime" runat="server" CssClass="DateTimeBox" Width="150px"></asp:TextBox>
            </td>
        </tr>
        <tr>
             <td class="Label3">模块</td>
            <td class="Field3">
                <asp:TextBox ID="txtModuleName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="LogId" HeaderText="日志编号"/>
            <asp:BoundField DataField="LogType" HeaderText="类型" />
            <asp:BoundField DataField="ModuleName" HeaderText="模块" />
            <asp:BoundField DataField="PageName" HeaderText="功能名称" />
            <asp:BoundField DataField="OederNo" HeaderText="单号" />
            <asp:BoundField DataField="Operation" HeaderText="操作描述" />
            <asp:BoundField DataField="UserName" HeaderText="操作人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="日志时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SystemLog.BLL.AccreditLog"
        SelectMethod="GetOperationLog" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        _isHms = true;
    </script>
</asp:Content>
