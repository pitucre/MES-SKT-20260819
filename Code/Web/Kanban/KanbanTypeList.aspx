<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KanbanTypeList.aspx.cs" MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Kanban.KanbanTypeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="ListTable" width="100%">
        <tr>
            <td class="Label1">
                看板类型
            </td>
            <td class="Field1">
                <asp:TextBox CssClass="TextBox" ID="txtKanbanTypeName" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound" >
        <Columns>
            <asp:BoundField DataField="RTModuleCNValue" HeaderText="看板类型名(中文)" HeaderStyle-HorizontalAlign="Left" SortExpression="ReportCNValues" HeaderStyle-Width="180px"/>
            <asp:BoundField DataField="RTModuleENValue" HeaderText="看板类型名(英文)" HeaderStyle-HorizontalAlign="Left" SortExpression="ReportENValues"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Kanban.BLL.Master"
        SelectMethod="GetKanbanType" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanTypeEdit.aspx?name=Template_KanbanTypeAdd&ID=-1";
            dialog({ title: "新增看板类型", src: openWinUrl, width: 500, height: 300 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanTypeEdit.aspx?name=Template_KanbanTypeEdit&ID=" + idStr;
            dialog({ title: "编辑看板类型", src: openWinUrl, width: 500, height: 300 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(templName) {
            $("#<%=this.txtKanbanTypeName.ClientID %>").val(templName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>

