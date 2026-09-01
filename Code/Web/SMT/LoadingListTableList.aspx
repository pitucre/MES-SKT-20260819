<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
    CodeBehind="LoadingListTableList.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.LoadingListTableList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1"><%= Resources.lang.LayoutDesc %></td>
            <td class="Field1">
                <asp:TextBox ID="txtLoadingListTableNO2" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="TableName" HeaderText="<%$ Resources:lang, Layout %>" />
            <asp:BoundField DataField="TableDesc" HeaderText="<%$ Resources:lang, LayoutDesc %>" />
            <asp:BoundField DataField="EnableFlag" HeaderText="<%$ Resources:lang, IsActive %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />                     
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.SMT.BLL.LoadingListTable" SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingListTableEdit.aspx?name=LoadingListTableEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.LoadingListTableEdit %>", src: openWinUrl, width: 600, height: 400 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingListTableView.aspx?ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.LoadingListTableView %>", src: openWinUrl, width: 600, height: 400 });
        }
        
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
