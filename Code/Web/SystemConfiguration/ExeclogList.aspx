<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
    CodeBehind="ExeclogList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.ExeclogList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">执行函数名称</td>
            <td class="Field2">
                <asp:TextBox ID="txtFunName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>   
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="FuncName" HeaderText="执行函数名称" />
            <asp:BoundField DataField="ParamName" HeaderText="参数名" />
            <asp:BoundField DataField="ParamValue" HeaderText="参数值" />
            <asp:BoundField DataField="SapCode" HeaderText="SAP代码" />
            <asp:BoundField DataField="SapMsg" HeaderText="SAP消息" />
            <asp:BoundField DataField="MesMsg" HeaderText="MES消息" />
            <asp:BoundField DataField="ExecUser" HeaderText="执行人" />
            <asp:BoundField DataField="CreateDate" HeaderText="执行时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.CommonDataSource.BLL.Execlog" SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
