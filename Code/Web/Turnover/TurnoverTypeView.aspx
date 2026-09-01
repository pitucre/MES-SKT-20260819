<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurnoverTypeView.aspx.cs"
    Inherits="SKT.LeanMES.Web.Turnover.TurnoverTypeView" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content runat="server" ContentPlaceHolderID="viewcontent">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.TurnoverTypeCode%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblTurnoverTypeCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.TurnoverTypeName%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblTurnoverTypeName" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverTypeEdit.aspx?name=Turnover_TurnoverTypeEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
             window.location.href = openWinUrl;
        }
    </script>
</asp:Content>
