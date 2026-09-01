<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Report.master"
     CodeBehind="ReportPage.aspx.cs" Inherits="SKT.LeanMES.Web.Report.ReportPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContentReport" runat="server">
<input type="hidden" clientidmode="Static" id="hdnLimitExportRowCount" name="hdnLimitExportRowCount"  runat="server"/>
<%=InitPage() %>
</asp:Content>
