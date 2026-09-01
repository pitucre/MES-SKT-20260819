<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierView.aspx.cs" Inherits="SKT.LeanMES.Web.Supplier.SupplierView" MasterPageFile="~/Masters/ViewMaster.master"%>
<asp:Content runat="server" ContentPlaceHolderID="viewcontent">
    <table width="100%" class="EditeContentTable">    
        <tr>
            <td class="Label1">
              供应商来源
            </td>
            <td class="Field1">
               <asp:Label ID="lblIsMesAdd" runat="server" ></asp:Label>
            </td>
        </tr>    
        <tr>
            <td class="Label1">
                <%=Resources.lang.VendorCode %>
            </td>
            <td class="Field1">
                <span id="prefix" style=" float:left; line-height:20px; padding:0px; margin-right:2px;"></span><asp:Label ID="lblVendorCode" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.VendorSort %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblVendorSort" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.VendorName %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblVendorName" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.IsShipmentReport %>
            </td>
            <td class="Field1">
                 <asp:Label ID="lblIsShipmentReport" runat="server" ></asp:Label>
            </td>
        </tr>

        <tr>
            <td class="Label1">
                <%=Resources.lang.IsLaboratoryReport %>
            </td>
            <td class="Field1">
                 <asp:Label ID="lblIsLaboratoryReport" runat="server" ></asp:Label>
            </td>
        </tr>

        <tr>
            <td class="Label1">
                <%=Resources.lang.VendorAddress %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblVendorAddress" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.SupplierUserName %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblVenUserName" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.SupplierPhone %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblVenPhone" runat="server" ></asp:Label>
            </td>
        </tr>
          <tr>
            <td class="Label1">
                <%=Resources.lang.Remark %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblRemark" runat="server" ></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        //编辑
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Supplier/SupplierEdit.aspx?name=Supplier_SupplierEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true" + "&isView=1";
            location.href = openWinUrl;
        }
    </script>

</asp:Content>
