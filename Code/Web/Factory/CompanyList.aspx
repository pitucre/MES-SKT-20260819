<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="CompanyList.aspx.cs" Inherits="SKT.LeanMES.Web.Factory.CompanyList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
               公司名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFactoryName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
               公司代码
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFactoryCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="FactoryName" HeaderText="<%$ Resources:lang, CompanyNames %>" />
            <asp:BoundField DataField="FactoryCode" HeaderText="<%$ Resources:lang, CompanyCode %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
                <asp:BoundField DataField="IsDefaultFactory" HeaderText="默认首选公司"  />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Factory.BLL.Factory"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Factory/FactoryEdit.aspx?name=CompanyAdd&TypeId=2&ID=-1";
            dialog({ title: "<%=Resources.Pages.CompanyAdd %>", src: openWinUrl, width: 450, height: 320 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Factory/FactoryEdit.aspx?name=CompanyEdit&TypeId=2&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.CompanyEdit %>", src: openWinUrl, width: 450, height: 320 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Factory/FactoryView.aspx?name=CompanyView&TypeId=2&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.CompanyView %>", src: openWinUrl, width: 450, height: 320 });
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

