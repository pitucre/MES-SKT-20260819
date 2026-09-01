<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="WarningHistoryEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warning.WarningHistoryEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
     <table width="100%" class="EditeContentTable">      
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarningName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblWarningName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarningType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblWarningType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                工单
            </td>
            <td class="Field2">
                <asp:Label ID="lblOrder" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                线别
            </td>
            <td class="Field2">
                <asp:Label ID="lblLineName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                良率
            </td>
             <td class="Field2">
                <asp:Label ID="lblRatio" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                不良现象
            </td>
             <td class="Field2">
                <asp:Label ID="lblNcNum" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                一级解决方案
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSolution" runat="server" CssClass="TextBox" TextMode="MultiLine" Height="60px" Width="90%" MaxLength="50"></asp:TextBox><em>*</em>
            </td>
        </tr>
    </table>

    <script type="text/javascript">

        var warninghistoryId = '<%=Request.QueryString["ID"]%>';

        function Save() {

            var txtOneSolve = $.trim($("#<%=this.txtSolution.ClientID%>").val());
            var txtValue = $.trim($("#<%=this.lblWarningName.ClientID%>").html());

            if (txtOneSolve == "") {
                alert("决方案不能为空,请填写！");
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarning.SaveOneSolve(warninghistoryId, txtOneSolve);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList(txtValue);
        }

    </script>
</asp:Content>
