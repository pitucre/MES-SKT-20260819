<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommonDataSourceList.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.CommonDataSource.CommonDataSourceList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:content id="Content1" contentplaceholderid="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                数据源名称
                </td>
            <td class="Field2">
                <asp:TextBox ID="txtDataSource" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">
                使用类型
                </td>
            <td class="Field2">
                <select class="ddlUseType" id="ddlUseType" runat="server">
                    <option value="">--全部--</option>
                    <option value="Common">通用</option>
                    <option value="UIModel">UI模板</option>
                    <option value="Report">报表</option>
                    <option value="Board">看板</option>
                </select>
            </td>
        </tr>
    </table>
</asp:content>
<asp:content id="Content2" contentplaceholderid="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="DataSourceName" HeaderText="数据源名称" />            
            <asp:BoundField DataField="SQLType" HeaderText="数据源类型" />            
<%--            <asp:BoundField DataField="SQLInfo" HeaderText="<%$ Resources:DataSource, SQLInfo %>" />--%>
            <%--<asp:BoundField DataField="Paramters" HeaderText="<%$ Resources:DataSource, Paramters %>" />--%>
            <%--<asp:BoundField DataField="TabColumn" HeaderText="<%$ Resources:DataSource, TabColumn %>" />--%>
            <asp:BoundField DataField="UseType" HeaderText="使用类型" />
            <asp:BoundField DataField="DataSourceType" HeaderText="逻辑分类" />
            <asp:BoundField DataField="ModifyBy" HeaderText="创建人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="DataSourceDesc" HeaderText="描述" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.CommonDataSource.BLL.DataSource"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CommonDataSource/CommonDataSourceEdit.aspx?name=CommonDataSourceEdit&ID=-1";
            dialog({ title: "新增数据源", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CommonDataSource/CommonDataSourceEdit.aspx?name=CommonDataSourceEdit&ID=" + idStr;
            dialog({ title: "编辑数据源", src: openWinUrl, width: 650, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
        function UpdateList(name) {
            $("#<%=this.txtDataSource.ClientID %>").val(name);
            document.forms[0].submit();
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "查看详细", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/CommonDataSource/CommonDataSourceView.aspx?name=CommonDataSourceView&ID=" + idStr + "&rnd=" + Math.random(), width: 800, height: 400 });
        }
    </script>
</asp:content>
