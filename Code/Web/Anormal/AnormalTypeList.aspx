<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="AnormalTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalTypeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                异常名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAnormalType" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="AnormalTypeName" HeaderText="异常名称" HeaderStyle-Width="180px"
                SortExpression="AnormalTypeName" />
            <asp:BoundField DataField="AnormalTypeCode" HeaderText="异常代码" HeaderStyle-Width="180px"
                SortExpression="AnormalTypeCode" />
            <asp:BoundField DataField="AnormalGroupName" HeaderText="异常类型" HeaderStyle-Width="180px"
                SortExpression="AnormalGroupName" />           
            <asp:BoundField DataField="Descriptions" HeaderText="<%$ Resources:lang, Description %>" />
             <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Anormal.BLL.AnormalType"
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
            dialog({ title: "<%= Resources.lang.AnormalTypeView %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalTypeView.aspx?name=Anormal_TypeView&ID=" + idStr, width: 500, height: 300, resizeable: false });
        }
        //新增 
        function Add() {
            dialog({ title: "<%= Resources.lang.AnormalTypeAdd %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalTypeEdit.aspx?name=Anormal_TypeAdd&ID=-1", width: 500, height: 300, resizeable: false });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.lang.AnormalTypeEdit %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalTypeEdit.aspx?name=Anormal_TypeEdit&ID=" + idStr, width: 500, height: 300, resizeable: false });
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

        function UpdateList(AnormalTypeName) {
            $("#<%=this.txtAnormalType.ClientID %>").val(AnormalTypeName);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("复制异常"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalTypeEdit.aspx?name=Anormal_TypeEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random(), width: 500, height: 300, resizeable: false });
        }
    </script>
</asp:Content>
