<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SPCProjectList.aspx.cs" Inherits="SKT.LeanMES.Web.SPC.SPCProjectList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">项目名称</td>
            <td class="Field1">
                <asp:TextBox ID="txtSPCProjectName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>            
            <asp:BoundField DataField="ProjectName" HeaderText="项目名称" />
            <asp:BoundField DataField="ProjectDesc" HeaderText="项目描述" />
            <asp:BoundField DataField="GraphType" HeaderText="图表类型"  HeaderStyle-Width="120px" />
            <asp:BoundField DataField="SampleQty" HeaderText="组内样本数"  HeaderStyle-Width="120px" />
            <asp:BoundField DataField="GroupQty" HeaderText="每屏显示组数"  HeaderStyle-Width="120px" />
            <asp:BoundField DataField="SampleDecimalPoint" HeaderText="样本小数位数" HeaderStyle-Width="120px" />      
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.SPC.BLL.SPCProject" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/SPCProjectEdit.aspx?name=SPC_ProjectAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.SPC_ProjectAdd %>", src: openWinUrl, width: 750, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/SPCProjectEdit.aspx?name=SPC_ProjectEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SPC_ProjectEdit %>", src: openWinUrl, width: 750, height: 500 });
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
