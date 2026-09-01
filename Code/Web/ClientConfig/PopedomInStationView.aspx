<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="PopedomInStationView.aspx.cs" Inherits="SKT.LeanMES.Web.ClientConfig.PopedomInStationView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">        
        <tr>
            <td class="Label1">
                <%=Resources.lang.StationType %><em>*</em>
            </td>
            <td class="Field1">
                <label id="lblStationType" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Station %>
            </td>
            <td class="Field1">
                <label id="lblStation" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.TemplateName %><em>*</em>
            </td>
            <td class="Field1">
                <label id="lblNewTemp" runat="server"></label>
            </td>
        </tr>       
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/PopedomInStationEdit.aspx?name=Client_PopedomStationEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
