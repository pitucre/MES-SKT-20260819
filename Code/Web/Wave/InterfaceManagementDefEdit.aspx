<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="InterfaceManagementDefEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.InterfaceManagementDefEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
      <table width="100%" class="EditeContentTable">
          <tr>
             <td class="Label2"> 
               行：
            </td>
            <td class="Field2">
                  <asp:TextBox ID="txtRow"  runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
            </td>
          </tr>
        <tr>
            <td class="Label2"> 
               段：<em>*</em>
            </td>
            <td class="Field2" >                
              <asp:DropDownList ID="ddlSegment" runat="server">              
               </asp:DropDownList>
            </td>
           
        </tr>
        <tr>
            <td class="Label2">
              内容:<em>*</em>
            </td>
            <td class="Field2">         
                 <asp:DropDownList ID="ddlContent" runat="server">
                  </asp:DropDownList>
            </td>
           
        </tr>       
    </table>
    <script type="text/javascript"> 
        var ID=<%= Request.QueryString["ID"] %>; 
        var InterfaceManagementId=<%= Request.QueryString["InterfaceManagementId"] %>; 
        function Save() {       
            var rows=$.trim($("#<%=this.txtRow.ClientID%>").val());
            if(rows==""){
                alert("请输入有效行！");
                return;
            }else if(rows!="" && rows!='*'){               
                if(!/^[0-9]*$/.test(rows)){
                    alert("请输入数字!");
                    return;
                }           
            }
            var sslContent = $("#<%=this.ddlContent.ClientID %>").val();    
            var segment = $("#<%=this.ddlSegment.ClientID %>").val().replace("第", "").replace("段", "");      
          
            var entity = {};
            entity.ID=ID;
            entity.InterfaceManagementId=InterfaceManagementId;
            entity.Rows=(rows=="*"?-1:rows);
            entity.Segment=segment
            entity.Contents=sslContent;            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.InterfaceManagementDefEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
          alert('<%=Resources.Messages.SaveInSuccess%>')
           parent.window.Refresh();
        }
    </script>
</asp:Content>
