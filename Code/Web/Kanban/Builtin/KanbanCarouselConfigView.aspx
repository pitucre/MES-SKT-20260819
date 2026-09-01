<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="KanbanCarouselConfigView.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.KanbanCarouselConfigView" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">轮播看板名<em>*</em>
            </td>
            <td class="Field2">
                <asp:Literal ID="ltrCarouselName" runat="server"></asp:Literal>
            </td>
            <td class="Label2">轮播时间(秒)<em>*</em>
            </td>
            <td class="Field2">
                <asp:Literal ID="ltrCarouselTime" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="Label2">描述
            </td>
            <td class="Field2" colspan="3">
                <asp:Literal ID="ltrRemark" runat="server"></asp:Literal>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="Sequence" HeaderText="播放顺序" />
            <asp:BoundField DataField="KanBanName" HeaderText="子看板名" />
            <asp:BoundField DataField="KanBanURL" HeaderText="子看板URL" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Kanban.BLL.KanBanCarouselConfigDetail"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script>
        $(function () {
            $("#<%=this.GridView1.ClientID%>").find("input[type='checkbox']").parent().hide();
        })
    </script>
</asp:Content>

