<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="CacheClear.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.CacheClear" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div style="text-align:center;">
    <asp:Button runat="server" ID="btnClearCache" Text="清空缓存" CssClass="button" Width="200px" Height="50px"/>
</div>
</asp:Content>
