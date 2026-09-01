<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="ClientProInfoConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.ClientConfig.ClientProInfoConfigList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1"><%= Resources.lang.InfoName %></td>
            <td class="Field1">
                <asp:TextBox ID="txtInfoName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="InfoName" HeaderText="<%$ Resources:lang, InfoName %>" />
            <asp:BoundField DataField="DbName" HeaderText="<%$ Resources:lang, DbName %>" />
            <asp:BoundField DataField="IsDisplay" HeaderText="<%$ Resources:lang, IsDisplay %>" />
            <asp:BoundField DataField="InfoType" HeaderText="<%$ Resources:lang, InfoType %>" />
            <asp:BoundField DataField="DisplayStyle" HeaderText="<%$ Resources:lang, DisplayStyle %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        /*
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/ClientProInfoConfigEdit.aspx?name=ClientProInfoConfigAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Client_ProInfoConfigEdit %>", src: openWinUrl, width: 650, height: 400 });
        }
        */
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/ClientProInfoConfigEdit.aspx?name=Client_ProInfoConfigEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Client_ProInfoConfigEdit %>", src: openWinUrl, width: 600, height: 400 });
        }
        /*
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        */
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

