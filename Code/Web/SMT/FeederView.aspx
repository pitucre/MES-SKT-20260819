<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.FeederView" Title="Feeder View" CodeBehind="FeederView.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
     <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.SerialNumber%>
            </td>
            <td class="Field1">
            <asp:Label ID="txtSerialNumbe" runat="server"></asp:Label>
                 
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.FeederTypeName%><em>*</em>
            </td>
            <td class="Field1">
            <asp:Label ID="txtFeederType" runat="server"></asp:Label>
             </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineModelName%><em>*</em>
            </td>
            <td class="Field1">
            <asp:Label ID="txtModelName" runat="server"></asp:Label>
             </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.FeederCategory%>
            </td>
            <td class="Field1">
            <asp:Label ID="ddlFeederCategory" runat="server"></asp:Label>
             </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxUseDuration%>
            </td>
            <td class="Field1">
            <asp:Label ID="txtMaxUseDuration" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxUnuseDuration%>
            </td>
            <td class="Field1">
            <asp:Label ID="txtMaxUnuseDuration" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxPickUp%>
            </td>
            <td class="Field1">
            <asp:Label ID="txtMaxPickUp" runat="server"></asp:Label>
             </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxPickUpErr%>
            </td>
            <td class="Field1">
            <asp:Label ID="txtMaxPickUpErr" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxPickUpErrRatio%>
            </td>
            <td class="Field1">
            <asp:Label ID="txtMaxPickUpErrRatio" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Status%>
            </td>
            <td class="Field1">
            <asp:Label ID="ddlStatus" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field1">
            <asp:Label ID="txtDescription" runat="server"></asp:Label>
             </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/FeederEdit.aspx?name=FeederEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
