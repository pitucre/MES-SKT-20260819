<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MoldComponentEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MoldComponentEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
       
        <tr>
            <td class="Label2">模具构件名称<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtComponentName" runat="server" CssClass="TextBox" MaxLength="100" IsRequired="1" ></asp:TextBox>
            </td>
        </tr>    
        <tr>
            <td class="Label2">安全库存<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSafeStock" runat="server" CssClass="TextBox" MaxLength="100" IsRequired="1" IsNumber="1" ></asp:TextBox>
            </td>
        </tr>     
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" MaxLength="500" TextMode="MultiLine" Width="90%" Height="65"></asp:TextBox>
            </td>
        </tr>
    </table>
    
    <script type="text/javascript">
        var moldComponentId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {         
            var txtComponentName = $.trim($("#<%=this.txtComponentName.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtSafeStock = $.trim($("#<%=this.txtSafeStock.ClientID%>").val());

        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


        var entity = {};
        entity.MoldComponentId = moldComponentId;
        entity.ComponentName = txtComponentName;
        entity.SafeStock = txtSafeStock;
        entity.Remark = txtRemark;
        entity.CreateBy = txtCreateBy;
        
        if (parseInt(txtSafeStock) <= 0) {
            alert("安全库存需大于0！");
            $("#<%=this.txtSafeStock.ClientID%>").select();
            return false;
        }
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EditMoldComponent(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        alert('<%=Resources.Messages.SaveInSuccess%>');
        parent.window.UpdateList( $.trim($("#<%=this.txtComponentName.ClientID%>").val()));
        
      }

       

        
    </script>

</asp:Content>

