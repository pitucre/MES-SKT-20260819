<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SteelConfigView.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelConfigView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">        
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">
                配置项
            </td>
            <td class="Field1">
                <asp:Label ID="txtSteelName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                结果
            </td>
            <td class="Field1">
                <asp:Label ID="txtResult" runat="server" Text=""></asp:Label>                
            </td>
        </tr>
        <tr>
            <td class="Label1">
                系统内置
            </td>
            <td class="Field1">
                <asp:Label ID="txtIsGlobal" runat="server" Text="是"></asp:Label>          
            </td>
        </tr>
        <tr>
            <td class="Label1">
                描述
            </td>
            <td class="Field1">
                <asp:Label ID="txtRemark" runat="server"  Text=""></asp:Label>                
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var code = '<%= Request.QueryString["ID"] == null ? "" : Request.QueryString["ID"].ToString()%>';
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelConfigEdit.aspx?name=SteelConfigEdit&ID=" + code;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
