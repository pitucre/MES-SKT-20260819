<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InterfaceTypeModelEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.InterfaceTypeModelEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired  %></td>
        </tr>
        <tr>
            <td class="Label2">设备类型</td>
            <td class="Field2" style="width: 15%">
                <asp:TextBox ID="txtDeviceType" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">品牌型号</td>
            <td class="Field2">
                <asp:TextBox ID="txtBrandType" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox><em>*</em>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var ID=<%= Request.QueryString["ID"] %>; 
        function Save() { 
            var deviceType = $.trim($("#<%=this.txtDeviceType.ClientID %>").val());
            var brandType = $.trim($("#<%=this.txtBrandType.ClientID %>").val());
            var modifyBy ='<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            if(deviceType =="" || brandType =="")
            {
                alert("带*为必填项.");
                return;
            }
            var entity = {};
            entity.DeviceInterfaceTypeId = ID;
            entity.DeviceType = deviceType;
            entity.Brand = brandType;
            entity.ModifyBy = modifyBy;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.DeviceInterfaceTypeEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
  
        }
    </script>
</asp:Content>
