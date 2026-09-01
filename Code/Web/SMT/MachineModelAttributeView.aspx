<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MachineModelAttributeView" Title="Edit MODEL_ATTRIBUTE"
    CodeBehind="MachineModelAttributeView.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineModelName %>
            </td>
            <td class="Field1">
                <asp:Label ID="txtMachineModelName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                设备分区数量
            </td>
            <td class="Field1">
                <asp:Label runat="server" ID="txtTablePosition" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineTableType%>
            </td>
            <td class="Field1">
            <asp:Label runat="server" ID="ddlMachineTableType" Text=""></asp:Label>
                 
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.StartSlotPosition%> 
            </td>
            <td class="Field1">
            <asp:Label runat="server" ID="txtStartSlotPosition" Text=""></asp:Label>
                 
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.EndSlotPosition%> 
            </td>
            <td class="Field1">
            <asp:Label runat="server" ID="txtEndSlotPosition" Text=""></asp:Label>
                 
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Status%>
            </td>
            <td class="Field1">
            <asp:Label runat="server" ID="ddlStatus" Text=""></asp:Label>
                
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field1">
            <asp:Label runat="server" ID="txtDescription" Text=""></asp:Label>
                
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/MachineModelAttributeEdit.aspx?name=MachineModelAttributeEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
