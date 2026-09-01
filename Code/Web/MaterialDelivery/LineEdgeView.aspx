<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="LineEdgeView.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.LineEdgeView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.EdgeName %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblEdgeName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label5" runat="server" Text="选择线别"></asp:Label>
            </td>
            <td class="Label" style="width: 10%; text-align: center;">
            </td>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label6" runat="server" Text="已选线别"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Field" align="center" style="width: 45%; vertical-align: top;">
                <asp:ListBox ID="lbLeft" runat="server" Width="230" Height="200" ></asp:ListBox>
            </td>
            <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                <input type="button" id="btnLeftChoose" runat="server" value=" >> " class="SearchButton" disabled="disabled"/>
                <br />
                <br />
                <br />
                <br />
                <input type="button" id="btnRightChoose" runat="server" value=" << " class="SearchButton" disabled="disabled"/>
            </td>
            <td class="Field" align="center" style="width: 45%; vertical-align: top;">
                <asp:ListBox ID="lbRight" runat="server" Width="230" Height="200" ></asp:ListBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/LineEdgeEdit.aspx?name=LineEdgeEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
