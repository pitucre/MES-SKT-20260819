<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    Codebehind="SerialNumberView.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.SerialNumberView" Title="View SerialNumber" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewContent" runat="Server" EnableViewState="true">
 <table width="100%"  class="EditeContentTable">  
        <tr>
            <td class="Label2">
                <%= Resources.lang.SerialNumberType %>
            </td>
            <td class="Field2" colspan="3">
                <asp:DropDownList ID="ddlNumberType" runat="server" AutoPostBack="True" Visible="false"  Enabled ="false"
                    onselectedindexchanged="ddlNumberType_SelectedIndexChanged">
                </asp:DropDownList>     
                <asp:Label ID="lblNumberType" runat="server"  ></asp:Label>        
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SerialNumberRuleObject %>
                <%--<asp:DropDownList ID="ddlItem" runat="server" AutoPostBack="True"  Enabled="false"
                    onselectedindexchanged="ddlItem_SelectedIndexChanged">
                    <asp:ListItem>=select=</asp:ListItem>
                    <asp:ListItem>Item</asp:ListItem>
                    <asp:ListItem>Item Group</asp:ListItem>
                    <asp:ListItem>Container</asp:ListItem>
                </asp:DropDownList>--%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblValue" runat="server" Text="Label"></asp:Label>                             
            </td>
        </tr>        
        <tr>
            <td class="Label2">
                <%= Resources.lang.Revision %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblVer" runat="server" Text="Label"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SerialNumberPrefix %>
            </td>
            <td class="Field2" colspan="3">
               <asp:Label ID="lblPrefix" runat="server" Text="Label"  style="word-break:break-all; display:block;"></asp:Label>             
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SerialNumberSuffix %> 
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblSuffix" runat="server" Text="Label"  style="word-break:break-all; display:block;"></asp:Label>             
            </td>
        </tr>
         
        <tr>
            <td class="Label2">
                <%= Resources.lang.SequenceBase %>
            </td>
            <td class="Field2">
               <asp:Label ID="lblBase" runat="server" Text="Label"></asp:Label>           
            </td>
            <td class="Label2">
                <%= Resources.lang.NumericalSystemList %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblNumberSeq" runat="server" Text="Label"></asp:Label>                    
            </td>
        </tr>      
        <tr>
            <td class="Label2">
                <%= Resources.lang.SequenceLength %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblLength" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.MaxSeq %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblMax" runat="server" Text="Label"></asp:Label>           
            </td>
        </tr>       
        <tr>
            <td class="Label2">
                <%= Resources.lang.MinSeq %>
            </td>
            <td class="Field2">
              <asp:Label ID="lblMin" runat="server" Text="Label"></asp:Label>              
            </td>
            <td class="Label2">
                <%= Resources.lang.IncrementBy %>
            </td>
            <td class="Field2">
              <asp:Label ID="lblIncrement" runat="server" Text="Label"></asp:Label>              
            </td>
        </tr>        
        <tr>
            <td class="Label2">
                <%= Resources.lang.CurrentSeq %>
            </td>
            <td class="Field2">
              <asp:Label ID="lblCurrent" runat="server" Text="Label"></asp:Label>           
            </td>
            <td class="Label2">
                <%= Resources.lang.WarningSeq %>
            </td>
            <td class="Field2">
              <asp:Label ID="lblWarning" runat="server" Text="Label"></asp:Label>              
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ResetWay %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlReset" runat="server" Visible="false" Enabled="false">
                </asp:DropDownList>  
                 <asp:Label ID="lblReset" runat="server"  ></asp:Label>               
            </td>  
            <td class="Label2">
                <%= Resources.lang.SampleSerialNumber %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblSample" runat="server" Text="" style="word-break:break-all; display:block;" ></asp:Label>            
            </td>         
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblDesc" runat="server" Text=""></asp:Label>              
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var NextID = "<%=Request.QueryString["ID"] %>";      
        var chooseItem = 0;
        var SearchCondition="Property='SYS' and SUBSTRING(Value,1,1)='%'";

         function Edit() {
             openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberEdit.aspx?name=SerialNumber_SerialNumberEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
             location.href = openWinUrl;
         }
    </script>
</asp:Content>
