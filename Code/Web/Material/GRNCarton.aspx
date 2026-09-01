<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="GRNCarton.aspx.cs" Inherits="SKT.LeanMES.Web.Material.GRNCarton" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
<script type="text/javascript">
    function loadfloatButtons(obj) {
        if (floatButtons != null) {
            document.getElementById(obj).innerHTML = floatButtons;
        }
    }
</script>
<table class="ListTable" width="100%">
    <tr class="ListTablePager">
        <td colspan="3">
            <%=Resources.lang.GRNCartonSN %>
        </td>
    </tr>
    <tr class="ListTableHeader">
        <th>#</th>
        <th><%=Resources.lang.GRNSN %></th>
        <th><%=Resources.lang.MinPackage %></th>
    </tr>
    <tr class="ListTableOddRow">
        <td></td>
        <td></td>
        <td></td>
    </tr>
</table>
<div style=" height:32px;">
     <span id="onKeyReceive"></span>
</div>
<script type="text/javascript">
    loadfloatButtons("onKeyReceive");
</script>
</asp:Content>
