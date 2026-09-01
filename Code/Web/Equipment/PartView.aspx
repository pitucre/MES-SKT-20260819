<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="PartView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.PartView" Title="View Part" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.myPartName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPartName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PartCode%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPartCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
              备件类别
            </td>
            <td class="Field2">
                <asp:Label ID="lblEquipmentType" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PartBrand%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPartStand" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
             <td class="Label2">
               生产厂商
            </td>
            <td class="Field2">
                <asp:Label ID="lblFactoryName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.VendorName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPartSupplierName" runat="server"></asp:Label>
            </td>
           
        </tr>
         <tr>
            <td class="Label2">
            存放位置
            </td>
            <td class="Field2">
                <asp:Label ID="lblPosition" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.Status%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPartLive" runat="server"></asp:Label>
            </td>
        </tr>
        
        <tr>
            <td class="Label2">
               最小库存
            </td>
            <td class="Field2">
                <asp:Label ID="lblMinStock" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                最大库存
            </td>
            <td class="Field2">
                <asp:Label ID="lblMaxStock" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
               初始库存
            </td>
            <td class="Field2">
                <asp:Label ID="lblCuStock" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                计量单位
            </td>
            <td class="Field2">
                 <asp:Label ID="lblUnitname" runat="server"></asp:Label>
                
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
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/PartEdit.aspx?name=PartEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
