<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SynchronizationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Synchronization.SynchronizationEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
 <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
             <%=Resources.lang.StoredProcedureName %> 
            </td>
            <td class="Field1">
                  <asp:TextBox ID="txtStoredProcedureName" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
              <td class="Label1">
                <%=Resources.lang.BusinessName%> 
            </td>
            <td class="Field1">
                 <asp:TextBox ID="txtBusinessName" runat="server"  IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Timeout%>(毫秒)
            </td>
             <td class="Field1">
                 <asp:TextBox ID="txtTimeout"  runat="server"  IsRequired='1' IsNumber='1' MinValue='0' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><em>*</em>
            </td>
        </tr>
    </table>

    <script>
        var SynchID = '<%=Request.QueryString["ID"]%>';
        function Save() {
            var entity = {};
            entity.SynchID = SynchID;
            entity.StoredProcedureName = $.trim($("#<%=this.txtStoredProcedureName.ClientID%>").val()).toString();
            entity.BusinessName = $.trim($("#<%=this.txtBusinessName.ClientID%>").val()).toString();
            entity.Timeout = $.trim($("#<%=this.txtTimeout.ClientID%>").val()).toString();
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'
            entity.ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSynchronization.EidtSynchronization(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }
   

    </script>

</asp:Content>
