<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadingTypeList.aspx.cs" 
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.SMT.LoadingTypeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.FeederTypeName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtLoadingTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="TypeName" HeaderText="类型" />
            <asp:BoundField DataField="BeginRow" HeaderText="数据起始行" />
            <asp:BoundField DataField="ColArea" HeaderText="区（列）"/>
            <asp:BoundField DataField="ColPosition" HeaderText="料站/插槽（列）"/>
            <asp:BoundField DataField="ColPosition_2" HeaderText="子插槽"/>
            <asp:BoundField DataField="ColPartNum" HeaderText="物料编码（列）" />
            <%--<asp:BoundField DataField="ColTable" HeaderText="面别（列）" />--%>
            <asp:BoundField DataField="ColNum" HeaderText="用量（列）" />
            <asp:BoundField DataField="ColPoint" HeaderText="点位（列）" />
            <asp:BoundField DataField="ColFeederType" HeaderText="飞达类型（列）" />
            <%--<asp:BoundField DataField="ColLocationType" HeaderText="元件位置（列）" />--%>
            <asp:BoundField DataField="ColReplaceNum" HeaderText="替换料（列）" />
            <asp:BoundField DataField="ElementDescription" HeaderText="元件说明" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.LoadingType"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingTypeEdit.aspx?name=LoadingTypeAdd&ID=-1";
            dialog({ title: mesLang("新增"), src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingTypeEdit.aspx?name=LoadingTypeEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑"), src: openWinUrl, width: 600, height: 400 });
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

