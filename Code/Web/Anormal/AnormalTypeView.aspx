<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="AnormalTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalTypeView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="ContentTable">
         <tr>
            <td class="Label2">
                异常类型
            </td>
            <td class="Field2">
                <asp:Label ID="lblAnormalGroupName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                异常名称
            </td>
            <td class="Field2">
               <asp:Label ID="lblAnormalTypeName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                异常代码
            </td>
            <td class="Field2">
                <asp:Label ID="lblAnormalTypeCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2">
                 <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Anormal/AnormalTypeEdit.aspx?name=Anormal_TypeEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
