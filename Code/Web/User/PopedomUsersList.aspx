<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChooseListMaster.master" AutoEventWireup="true" CodeBehind="PopedomUsersList.aspx.cs" Inherits="SKT.LeanMES.Web.User.PopedomUsersList" %>
<%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<script language="javascript" type="text/javascript">
    $(function () {
        $("#searchField").hide();
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="RoleName" HeaderText="角色" />
            <asp:BoundField DataField="UserName" HeaderText="用户" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" TypeName="SKT.Common.Account.BLL.Users"
        SelectMethod="GetPopedomUsers" SelectCountMethod="GetPopedomUsersCount">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Popedom" Name="popedom" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>