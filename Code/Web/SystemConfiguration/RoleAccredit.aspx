<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="RoleAccredit.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.RoleAccredit" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">工号</td>
            <td class="Field3">
                <asp:TextBox ID="txtUserNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">姓名</td>
            <td class="Field3">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">授权动作</td>
            <td class="Field3">
                <asp:TextBox ID="txtLogContent" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">开始时间</td>
            <td class="Field3">
                <asp:TextBox ID="txtBegTime" runat="server" CssClass="DateTimeBox" Width="150px"></asp:TextBox>
            </td>
            <td class="Label3">结束时间</td>
            <td class="Field3">
                <asp:TextBox ID="txtEndTime" runat="server" CssClass="DateTimeBox" Width="150px"></asp:TextBox>
            </td>
            <td class="Label3"></td>
            <td class="Field3">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="LogId" HeaderText="编号" HeaderStyle-Width="50px"/>
            <asp:BoundField DataField="UserNo" HeaderText="工号" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="UserName" HeaderText="操作人" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="LogContent" HeaderText="授权动作" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="操作时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SystemLog.BLL.AccreditLog"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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
