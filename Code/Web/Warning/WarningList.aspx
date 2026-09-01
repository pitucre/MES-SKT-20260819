<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="WarningList.aspx.cs" Inherits="SKT.LeanMES.Web.Warning.WarningList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.WarningName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtWarningName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="WarningName" HeaderText="<%$ Resources:lang, WarningName %>" SortExpression="WarningName"  />
            <asp:BoundField DataField="WarningGroup" HeaderText="<%$ Resources:lang, WarningGroup %>" SortExpression="WarningGroup"  />
            <asp:BoundField DataField="WarningTypeName" HeaderText="<%$ Resources:lang, WarningType %>" SortExpression="WarningTypeName"  />
            <asp:BoundField DataField="WarningDesc" HeaderText="<%$ Resources:lang, WarningDesc %>" SortExpression="WarningDesc" />
            <asp:BoundField DataField="LineName" HeaderText="线别" SortExpression="LineName" />
            <asp:BoundField DataField="WarningVal" HeaderText="警报预警值" SortExpression="WarningVal" />
           <%-- <asp:BoundField DataField="NcNum" HeaderText="不良现象" SortExpression="NcNum" />--%>
            <asp:BoundField DataField="MessageType" HeaderText="<%$ Resources:lang, MessageType %>" SortExpression="MessageType" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间"  />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Warning.BLL.Warning" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningEdit.aspx?name=Quality_WarningAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.WarningAdd %>", src: openWinUrl, width: 820, height: 520 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningEdit.aspx?name=Quality_WarningEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WarningEdit %>", src: openWinUrl, width: 820, height: 520 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningView.aspx?Name=Quality_WarningView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WarningView %>", src: openWinUrl, width: 820, height: 520 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
