<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="ContainerTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.ContainerTypeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">布局类型名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLayoutTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2"></td>
            <td class="Field2" id="tdSelType">
                <%--<SKTControl:ReportDDL runat="server" ID="ddlReport" ClientIDMode="Static"></SKTControl:ReportDDL>--%>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="LayoutType" HeaderText="布局类型名称" HeaderStyle-Width="180px"
                SortExpression="LayoutType" />
            <asp:BoundField DataField="Remark" HeaderText="备注/描述" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Kanban.BLL.Master"
        SelectMethod="GetContainerType" SelectCountMethod="GetCount">
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
        var w = $(window).width() - 100;
        var h = $(window).height() - 50;
        $(document).ready(function () {

        });
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/ContainerTypeEdit.aspx?name=ContainerTypeAdd&ID=-1";
            window.parent.openLeftMenu(this, "新增自定义布局", openWinUrl, 'addContainerType');
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            var wins = $(window.parent);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/ContainerTypeEdit.aspx?name=ContainerTypeEdit&ID=" + idStr;
            window.parent.openLeftMenu(this, "编辑自定义布局", openWinUrl, 'editContainerType');
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") { return false; }

            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(templName) {
            document.forms[0].submit();
        }
        function AddType() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/ContainerTypeEdit.aspx?name=ContainerTypeAdd&ID=-1";
            window.parent.openLeftMenu(this, "新增看板布局类型", openWinUrl, '-1');

        }

    </script>
</asp:Content>





