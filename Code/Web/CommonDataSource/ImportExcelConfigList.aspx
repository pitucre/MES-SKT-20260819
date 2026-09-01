<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportExcelConfigList.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.CommonDataSource.ImportExcelConfigList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:content id="Content1" contentplaceholderid="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                导入表名称
                </td>
            <td class="Field2">
                <asp:TextBox ID="txtIdcName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">
                存储过程
                </td>
            <td class="Field2">
                 <asp:TextBox ID="txtProcName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:content>
<asp:content id="Content2" contentplaceholderid="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
           <asp:BoundField DataField="IdcName" HeaderText="导入表名称" />
            <asp:BoundField DataField="ProcName" HeaderText="存储过程" />
            <asp:BoundField DataField="FileNames" HeaderText="模板" />
<%--            <asp:BoundField DataField="SQLType" HeaderText="<%$ Resources:DataSource, SQLType %>" />--%>
<%--            <asp:BoundField DataField="SQLInfo" HeaderText="<%$ Resources:DataSource, SQLInfo %>" />--%>
            <%--<asp:BoundField DataField="Paramters" HeaderText="<%$ Resources:DataSource, Paramters %>" />--%>
            <%--<asp:BoundField DataField="TabColumn" HeaderText="<%$ Resources:DataSource, TabColumn %>" />--%>
           
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="UpdateTime" HeaderText="修改时间" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.CommonDataSource.BLL.ImportDataConfig"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CommonDataSource/ImportExcelConfigEdit.aspx?name=ImportExcelConfigEdit&ID=-1";
            dialog({ title: "新增导入数据配置", src: openWinUrl, width: 650, height: 400 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CommonDataSource/ImportExcelConfigView.aspx?name=ImportExcelConfigView&ID=" + idStr;
            dialog({ title: "查看导入数据配置", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CommonDataSource/ImportExcelConfigEdit.aspx?name=ImportExcelConfigEdit&ID=" + idStr;
            dialog({ title: "编辑导入数据配置", src: openWinUrl, width: 650, height: 400 });
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
            $("#<%=this.txtIdcName.ClientID %>").val(name);
            document.forms[0].submit();
        }
       <%-- function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "查看详细", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/CommonDataSource/CommonDataSourceView.aspx?name=CommonDataSourceView&ID=" + idStr + "&rnd=" + Math.random(), width: 800, height: 400 });
        }--%>
    </script>
</asp:content>
