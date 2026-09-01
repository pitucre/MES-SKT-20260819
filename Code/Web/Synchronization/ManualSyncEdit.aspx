<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="ManualSyncEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Synchronization.ManualSyncEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
 <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
             类型<em>*</em>
            </td>
            <td class="Field1">
                  <asp:DropDownList ID="ddlSyncType" runat="server" ClientIDMode="Static">
                    
                </asp:DropDownList>  
            </td>
        </tr>
        <tr>
              <td class="Label1">
                内容<em>*</em>
            </td>
            <td class="Field1">
                 <asp:TextBox ID="txtSyncContent" runat="server"  IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><em>*</em>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var SynchID = '<%=Request.QueryString["ID"]%>';
        function Save() {

            var SyncType = $("#ddlSyncType").val();
            var SyncContent = $("#txtSyncContent").val();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSynchronization.SaveManualSync(SynchID, SyncType, SyncContent);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('保存成功！');
            parent.window.Refresh();
        }
   

    </script>

</asp:Content>
