<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="AccessoryHistoryList.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryHistoryList" Title="AccessoryHistory List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">辅料编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtAccessoryHistoryNO2" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">辅料条码</td>
            <td class="Field3">
                <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">操作状态</td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="dlltype">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">打印登记</asp:ListItem>
                    <asp:ListItem Value="1">登记</asp:ListItem>
                    <asp:ListItem Value="2">解冻</asp:ListItem>
                    <asp:ListItem Value="7">搅拌</asp:ListItem>
     <%--               <asp:ListItem Value="3">发料</asp:ListItem>--%>
                    <asp:ListItem Value="4">上料</asp:ListItem>
                    <asp:ListItem Value="5">退回</asp:ListItem>
                    <asp:ListItem Value="6">报废</asp:ListItem>
                    <asp:ListItem Value="8">用完</asp:ListItem>
                    <asp:ListItem Value="9">下线</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SerialNumber" HeaderText="辅料条码" />
            <asp:BoundField DataField="AccessoryCodoe" HeaderText="<%$ Resources:lang, AccessoryCodoe %>" />
            <asp:BoundField DataField="AccessoryName" HeaderText="<%$ Resources:lang, AccessoryName %>" />
            <asp:BoundField DataField="OpTypeName" HeaderText="操作类型" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang, CreateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.AccessoryManagement.BLL.AccessoryHistory" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
     <div style="display:none"><asp:Button ID="Button1" runat="server"  /></div>
    <div style="display:none"><asp:Button ID="btnExport" runat="server" OnClick="btnExport_Click"  /></div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        function Export()
        {
            $("#<%=this.btnExport.ClientID%>").click();
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

