<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="TaskList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.TaskList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1"><%=Resources.lang.TaskName%></td>
            <td class="Field1">
                <asp:TextBox ID="txtTaskName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" RowStyle-VerticalAlign="Middle">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="TaskName" HeaderText="<%$ Resources:lang, TaskName %>" />
            <asp:BoundField DataField="ExecDll" HeaderText="<%$ Resources:lang, ExecDll %>" />
            <asp:BoundField DataField="StartTime" HeaderText="<%$ Resources:lang, StartTime %>" />
            <asp:BoundField DataField="EndTime" HeaderText="<%$ Resources:lang, EndTime %>" />
            <asp:BoundField DataField="IntervalTime" HeaderText="<%$ Resources:lang, IntervalTime %>" />
            <%--<asp:BoundField DataField="LastExecTime" HeaderText="<%$ Resources:lang, LastExecTime %>" />
            <asp:BoundField DataField="LastExecResultName" HeaderText="<%$ Resources:lang, LastExecResult%>" />
            <asp:BoundField DataField="NextExecTime" HeaderText="<%$ Resources:lang, NextExecTime %>" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang, CreateTime %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
            <%--<asp:BoundField DataField="TaskName" HeaderText="任务名称" />
            <asp:BoundField DataField="ExecDll" HeaderText="执行DLL" />
            <asp:BoundField DataField="StartTime" HeaderText="开始时间" />
            <asp:BoundField DataField="EndTime" HeaderText="结束时间" />
            <asp:BoundField DataField="IntervalTime" HeaderText="间隔时间" />
            <asp:BoundField DataField="LastExecTime" HeaderText="上次执行时间" />
            <asp:BoundField DataField="LastExecResultName" HeaderText="上次执行结果" />
            <asp:BoundField DataField="NextExecTime" HeaderText="下次执行时间" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" />--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Task.BLL.Task" SelectMethod="GetTaskList" SelectCountMethod="GetCount">
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
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/TaskView.aspx?name=TaskView&id=" + idStr;
            dialog({ title: "<%=Resources.Pages.TaskView %>", src: openWinUrl, width: 650, height: 450 });
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/TaskEdit.aspx?name=TaskAdd&id=-1";
            dialog({ title: "<%=Resources.Pages.TaskAdd %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/TaskEdit.aspx?name=TaskEdit&id=" + idStr;
            dialog({ title: "<%=Resources.Pages.TaskEdit %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Delete() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (confirm("确认要删除吗？")) {
                hdnOperate.val("delete");
                hdnIdString.val(idStr);
                document.forms[0].submit();
            }
        }

        function Execute() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            alert("Execute Success");
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

