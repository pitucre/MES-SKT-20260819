<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="CustomerProjectView.aspx.cs" Inherits="SKT.LeanMES.Web.Customer.CustomerProjectView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
  <table width="100%" class="ContentTable">
    <tr>
          <td class="Label2">
              客户简称 
            </td>
            <td class="Field2">
                <asp:Label ID="lblCustomerName" runat="server"></asp:Label>                     
            </td>
        </tr>        
        <tr>
            <td class="Label2">
                项目名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblProjectName" runat="server"></asp:Label>   
            </td>
        </tr>
        <tr>
            <td class="Label2">
                描述
            </td>
            <td class="Field2">
               <asp:Label ID="lblDesc" runat="server"></asp:Label>                   
            </td>
        </tr>
  </table>
 <script type="text/javascript">
     function Edit() {
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerProjectEdit.aspx?name=Customer_CustomerProjectEdit&ID=" + '<%= Request.QueryString["ID"] %>';
         location.href = openWinUrl;
     }
    </script>
</asp:Content>
