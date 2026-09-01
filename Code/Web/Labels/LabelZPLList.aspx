<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="LabelZPLList.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelZPLList"
    Title="LabelZPL List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                指令模板名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtZPLName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="ZplType" HeaderText="指令类型" SortExpression="ZplType" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="ZplName" HeaderText="指令模板名称" SortExpression="ZplName" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px" SortExpression="CreateBy"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="CreateDateTime"/>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Labels.BLL.LabelZPL"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelZPLEdit.aspx?name=Labels_LabelZPLAdd&ID=-1";
            dialog({ title: "<%= Resources.Pages.Labels_LabelZPLAdd %>", src: openWinUrl, width: 650, height: 450 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelZPLEdit.aspx?name=Labels_LabelZPLEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.Pages.Labels_LabelZPLEdit %>", src: openWinUrl, width: 650, height: 450 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelZPLView.aspx?name=Labels_LabelZPLView&ID=" + idStr;
            dialog({ title: "<%= Resources.Pages.Labels_LabelZPLView %>", src: openWinUrl, width: 650, height: 450 });
        }

        function UpdateList(itemName) {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
