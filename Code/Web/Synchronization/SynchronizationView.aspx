<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="SynchronizationView.aspx.cs" Inherits="SKT.LeanMES.Web.Synchronization.SynchronizationView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
             <%=Resources.lang.StoredProcedureName %> 
            </td>
            <td class="Field1">
                <label ID="lblStoredProcedureName"  runat="server"></label>
            </td>
        </tr>
        <tr>
              <td class="Label1">
                <%=Resources.lang.BusinessName%> 
            </td>
            <td class="Field1">
                <label id="lblBusinessName" runat="server" ></label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Timeout%>(毫秒)
            </td>
             <td class="Field1">
                 <label id="lblTimeout" runat="server" ></label>                 
            </td>
        </tr>
    </table>
     <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Synchronization/SynchronizationEdit.aspx?name=CommonDataSourceEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
