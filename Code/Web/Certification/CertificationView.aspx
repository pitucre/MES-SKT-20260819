<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" 
CodeBehind="CertificationView.aspx.cs" Inherits="SKT.LeanMES.Web.Certification.CertificationView" %>
   
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
  <table width="100%" class="ContentTable">
       <tr>
            <td class="Label1"> 
               认证名称
            </td>
            <td class="Field1">
                <asp:Label ID="lblCert" runat="server"></asp:Label>                
            </td>
        </tr>        
        <tr>
            <td class="Label1">
                认证类型
            </td>
            <td class="Field1">
                <asp:Label ID="lblType" runat="server"></asp:Label>                
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblDesc" runat="server"></asp:Label>                
            </td>
        </tr>
        <tr>
            <td class="Label1">
                有效期(天) 
            </td>
            <td class="Field1">
                <asp:Label ID="lblRenewal" runat="server"></asp:Label>                
            </td>
        </tr>
        <tr>
            <td class="Label1">
                到期提前警告天数  
            </td>
            <td class="Field1">
                <asp:Label ID="lblWarning" runat="server"></asp:Label>                
            </td>
        </tr>
        <tr>
            <td class="Label1">
                到期行为
            </td>
            <td class="Field1">
                <asp:Label ID="lblEvent" runat="server"></asp:Label>                
            </td>
        </tr>
  </table>
   <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Certification/CertificationEdit.aspx?name=Account_CertificationListEdit&ID="+<%= Request.QueryString["ID"] %>;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
