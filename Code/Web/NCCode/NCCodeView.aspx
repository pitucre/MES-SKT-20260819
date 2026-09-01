<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    Codebehind="NCCodeView.aspx.cs" Inherits="SKT.LeanMES.Web.NCCode.NCCodeView" Title="View NCCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">不良代码类型</td>
            <td class="Field2">
                <asp:Label ID="lblNCCodeType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.NCCode%></td>
            <td class="Field2">
                <asp:Label ID="lblNCCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.DataType%></td>
            <td class="Field2">
                <asp:Label ID="lblDataType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Category%></td>
            <td class="Field2">
                <asp:Label ID="lblCategory" runat="server"></asp:Label>
            </td>
        </tr>  
        <tr>
            <td class="Label2"><%= Resources.lang.Status%></td>
            <td class="Field2">
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Description %></td>
            <td class="Field2">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCCodeEdit.aspx?name=NCCode_NCCodeEdit&ID="+<%= Request.QueryString["ID"] %>;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>