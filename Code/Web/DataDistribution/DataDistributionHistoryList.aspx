<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataDistributionHistoryList.aspx.cs" MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.DataDistribution.DataDistributionHistoryList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                事业部名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDepartNameStr" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="DepartCodeStr" HeaderText="下发事业部编号" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="DepartNameStr" HeaderText="下发事业部名称" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="SerialCodeStr" HeaderText="下发信息" HeaderStyle-Width="170px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="下发人" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="下发时间" SortExpression="CreateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="Content" HeaderText="内容描述" HeaderStyle-Width="300px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.DataDistribution.BLL.DataDistributionHistoryBll"
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
    </script>
</asp:Content>
