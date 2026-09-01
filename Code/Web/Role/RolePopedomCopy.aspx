<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="RolePopedomCopy.aspx.cs" Inherits="SKT.LeanMES.Web.Role.RolePopedomCopy" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

<style type="text/css">
    .Label2 {
        width: 25%
    }
</style>
    <div class="infoTips">
        <%= Resources.Messages.TipOperation %><%= Resources.Messages.WithAsteriskIsRequired %>
        
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
             <td class="Label2">
               <%= Resources.Messages.SetRoleName %>
                 
            </td>
            <td class="Field2" colspan="3">
               <asp:Label runat="server" ID="lblRoleName"></asp:Label>
                <asp:HiddenField runat="server" ID="hdnRoleId"/>
                </td>
        </tr>
        <tr id="trLine">
            <td class="Label2">
                  <%= Resources.Messages.CopyTargetRole %> <em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRoleName" runat="server" ReadOnly="true" IsRequired="1" CssClass="TextBox" ClientIDMode="Static"
                    Width="50%">
                </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(15);" />
                <asp:HiddenField ID="hdnRoleCopyId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        
    </table>
       
    <script type="text/javascript">
        var standardLaborTimeId = '<%=Request.QueryString["ID"]%>';
        var flag = 0;

        $().ready(function () {
        });

        /*保存数据*/
        function Save() {

            var hdnRoleCopyId = $("#<%=this.hdnRoleCopyId.ClientID %>").val();
            var hdnRoleId = $("#<%=this.hdnRoleId.ClientID %>").val(); 
           
            var ajax = SKT.LeanMES.Web.Role.RolePopedomCopy.CopyRolePopedom(hdnRoleCopyId, hdnRoleId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            //保存后关闭
            if (parent) {
                parent.window.closeDialog();
            }
        }
       
        function openChoosePage(flags) {
          
            var condition = " RoleId!=" + $("#<%=this.hdnRoleId.ClientID %>").val();
            flag = flags;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 600,
                height: 300
            });
        }

        function getChooseValue(list) {
         if (flag == 15) {
                $("#<%=this.txtRoleName.ClientID %>").val(list[0][1]);
                 $("#<%=this.hdnRoleCopyId.ClientID %>").val(list[0][0]);
            }
        }

    
    </script>
</asp:Content>
