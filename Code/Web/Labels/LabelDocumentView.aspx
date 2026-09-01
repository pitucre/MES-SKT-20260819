<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="LabelDocumentView.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelDocumentView"
    Title="View LabelDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%=Resources.lang.DocumentName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDocumentName" runat="server"></asp:Label>
            </td>
        </tr>
  <%--      <tr>
            <td class="Label2">
                打印方式
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrintMode" runat="server"></asp:Label>
            </td>
        </tr>--%>
        <tr>
            <td class="Label2">
                <%=Resources.lang.TemplateName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblTemplateName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.PrinterName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrinterName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
               打印份数
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrint_Qty" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.PlateQty %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPlateQty" runat="server"></asp:Label>
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                <%=Resources.lang.PrintBy %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrint_By" runat="server"></asp:Label>
            </td>
        </tr>
        <tr  style="display:none">
            <td class="Label2">
                <%=Resources.lang.PrintMethod %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrint_Method" runat="server"></asp:Label>
            </td>
        </tr>
        <tr  style="display:none">
            <td class="Label2">
                <%=Resources.lang.DocumentType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDocument_Type" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </td>
        </tr>
        
        <tr>
            <td class="Label2">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelDocumentEdit.aspx?name=Labels_LabelDocumentEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
