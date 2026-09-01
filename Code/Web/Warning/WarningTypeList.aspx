<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="WarningTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Warning.WarningTypeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.WarningTypeName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtWarningTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="WarningTypeName" HeaderText="<%$ Resources:lang, WarningTypeName %>"  SortExpression="WarningTypeName"/>
            <asp:BoundField DataField="WarningTypeValue" HeaderText="<%$ Resources:lang, WarningTypeValue %>" SortExpression="WarningTypeValue"/>
            <asp:BoundField DataField="WarningGroup" HeaderText="<%$ Resources:lang, WarningGroup %>" SortExpression="WarningGroup"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warning.BLL.WarningType"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningTypeEdit.aspx?name=Quality_WarningTypeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.WarningTypeAdd %>", src: openWinUrl, width: 650, height: 300 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningTypeEdit.aspx?name=Quality_WarningTypeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WarningTypeEdit %>", src: openWinUrl, width: 600, height: 300 });
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
    </script>
</asp:Content>
