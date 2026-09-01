<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="ExtensionFieldsList.aspx.cs" Inherits="SKT.LeanMES.Web.ExtensionTables.ExtensionFieldsList"
    Title="ExtensionFields List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.TableName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTableName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="TableName" HeaderText="<%$ Resources:lang, TableName %>" />
            <asp:BoundField DataField="ExtensionFieldName" HeaderText="<%$ Resources:lang, ExtensionFieldName %>" />
            <asp:BoundField DataField="ExtensionFieldDescription" HeaderText="<%$ Resources:lang, ExtensionFieldDescription %>" />
            <asp:BoundField DataField="ExtensionFieldType" HeaderText="<%$ Resources:lang, ExtensionFieldType %>" />
            <asp:BoundField DataField="ExtensionFieldIsAllowNull" HeaderText="<%$ Resources:lang, ExtensionFieldIsAllowNull %>" />
            <asp:BoundField DataField="Sequence" HeaderText="<%$ Resources:lang, Sequence %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ExtensionTables.BLL.ExtensionFields"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ExtensionTables/ExtensionFieldsEdit.aspx?Name=ExtensionFields_ExtensionFieldsAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.ExtensionFields_ExtensionFieldsAdd %>", src: openWinUrl, width: 650, height: 300 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ExtensionTables/ExtensionFieldsEdit.aspx?Name=ExtensionFields_ExtensionFieldsEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.ExtensionFields_ExtensionFieldsEdit %>", src: openWinUrl, width: 650, height: 300 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ExtensionTables/ExtensionFieldsView.aspx?Name=ExtensionFields_ExtensionFieldsView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.ExtensionFields_ExtensionFieldsView %>", src: openWinUrl, width: 600, height: 300 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
