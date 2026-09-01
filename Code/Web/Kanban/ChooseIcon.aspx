<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="ChooseIcon.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.ChooseIcon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" 
        OnRowDataBound="GridView1_OnRowDataBound" Width="100%" CssClass="ListTable" 
        AllowPaging="true" PageSize="10" 
        onpageindexchanging="GridView1_PageIndexChanging">
    <Columns>
        <asp:BoundField DataField="Icon" HeaderText="<%$Resources:lang,Icon %>" ItemStyle-HorizontalAlign="Center"/>
        <asp:BoundField HeaderText="<%$Resources:lang,Select %>" HeaderStyle-Width="70px"/>
    </Columns>
    <HeaderStyle CssClass="ListTableHeader"/>
    <RowStyle  CssClass="OddTableRow"/>
    <AlternatingRowStyle CssClass="EventTableRow"/>
    <PagerStyle CssClass="ListTablePager"/>
    </asp:GridView>
    <script type="text/javascript">
        function chooseIcon(icon, iconname) {
            parent.setIcon(icon, iconname);
        }
    </script>
</asp:Content>
