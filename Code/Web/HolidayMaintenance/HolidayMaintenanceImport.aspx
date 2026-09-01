<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="HolidayMaintenanceImport.aspx.cs" Inherits="SKT.LeanMES.Web.HolidayMaintenance.HolidayMaintenanceImport" %>

<%--<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div style="text-align: center">
        <asp:FileUpload ID="fuLoadingList" runat="server" Width="350px" BorderWidth="1px" /><br />
        <asp:Label ID="lblMesg" runat="server" Style="color: Red"></asp:Label><br />
        <asp:Button ID="ButSave" runat="server" Text="导入" onclick="ButSave_Click1" />
    </div>
</asp:Content>
