<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="NCGroupList.aspx.cs" Inherits="SKT.LeanMES.Web.NCCode.NCGroupList"
    Title="NCGroup List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                不良代码类型名
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtGroup" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="NCGroupName" HeaderText="不良代码类型名" HeaderStyle-Width="180px"
                SortExpression="NCGroupName" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description%>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.NCCode.BLL.NCGroup"
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
        //添加
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCGroupEdit.aspx?name=NCCode_NCGroupAdd&ID=-1";
            dialog({ title: "<%= Resources.lang.NCGroupAdd %>", src: openWinUrl, width: 630, height: 400 });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCGroupEdit.aspx?name=NCCode_NCGroupEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.NCGroupEdit %>", src: openWinUrl, width: 630, height: 400 });
        }
        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCGroupView.aspx?name=NCCode_NCGroupView&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.NCGroupView %>", src: openWinUrl, width: 630, height: 400 });
        }

        function UpdateList(Group) {
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCGroupEdit.aspx?name=NCCode_NCGroupEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "<%= Resources.lang.NCGroupEdit %>", src: openWinUrl, width: 630, height: 400 });
        }
    </script>
</asp:Content>
