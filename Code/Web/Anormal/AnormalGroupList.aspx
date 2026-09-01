<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="AnormalGroupList.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalGroupList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                异常类型名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAnormalGroup" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="AnormalGroupName" HeaderText="异常类型名称" HeaderStyle-Width="180px" SortExpression="AnormalGroupName"/>
            <asp:BoundField DataField="AnormalGroupCode" HeaderText="异常类型代码" HeaderStyle-Width="180px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Anormal.BLL.AnormalGroup"
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
        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            dialog({ title: mesLang("查看异常类型"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalGroupView.aspx?name=Anormal_GroupView&ID=" + idStr, width: 500, height: 300, resizeable: false });
        }
        //新增 
        function Add() {
            dialog({ title: mesLang("新增异常类型"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalGroupEdit.aspx?name=Anormal_GroupAdd&ID=-1", width: 500, height: 300, resizeable: false });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("编辑异常类型"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalGroupEdit.aspx?name=Anormal_GroupEdit&ID=" + idStr, width: 500, height: 300, resizeable: false });
        }
        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {

            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(AnormalGroupName) {
            $("#<%=this.txtAnormalGroup.ClientID %>").val(AnormalGroupName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
