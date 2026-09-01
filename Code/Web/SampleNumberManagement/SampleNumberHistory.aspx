<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="SampleNumberHistory.aspx.cs" 
    Inherits="SKT.LeanMES.Web.SampleNumberManagement.SampleNumberHistory" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">线别</td>
            <td class="Field3">
                <asp:TextBox ID="txtLineCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">工单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtProOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">序号</td>
            <td class="Field3">
                <asp:TextBox ID="txtSampleNumber" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            
        </tr>
        <tr>
           <td class="Label3">工序</td>
           <td class="Field3">
                <asp:TextBox ID="txtStationCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">记录时间
            </td>
            <td class="Field3">
                <input type="text" id="txtDateF" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtDateT" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" SortExpression="OrderNo" />
            <asp:BoundField DataField="SampleNumber" HeaderText="序号" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="LineName" HeaderText="线别" SortExpression="LineName" />
            <asp:BoundField DataField="IsPassName" HeaderText="是否PASS" SortExpression="IsPassName" />
            <asp:BoundField DataField="NcCodes" HeaderText="不良代码" />
            <asp:BoundField DataField="CreateBy" HeaderText="操作人" />
            <asp:BoundField DataField="CreateTime" HeaderText="测试时间" SortExpression="CreateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIdString" runat="server" ClientIDMode="Static" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var gridClientId = "<%=this.GridView1.ClientID%>";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Refresh() {
            document.forms[0].submit();
        }
        //导出
        function Import() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>