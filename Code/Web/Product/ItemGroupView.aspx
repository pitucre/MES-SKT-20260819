<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="ItemGroupView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemGroupView"
    Title="View ItemGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                产品类型名称
            </td>
            <td class="Field1">
                <asp:Label ID="txtItemGroupName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                描述
            </td>
            <td class="Field1">
                <asp:Label ID="txtItemGroupDesc" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemGroupEdit.aspx?name=Product_ItemGroupEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
