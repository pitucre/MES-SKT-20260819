<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MouldSupplierDeliveryTime.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldSupplierDeliveryTime" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px; text-align:left;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">交付日期</td>
            <td class="Field1"  >
                <asp:TextBox ID="txtDeliveryTime" runat="server" ClientIDMode="Static" CssClass="DateTimeBox" MaxLength="100" ></asp:TextBox>
               
            </td>             
        </tr>
         <tr>
            <td class="Label1">维修价格</td>
            <td class="Field1"  >
                <asp:TextBox ID="txtMaintenanceCosts" runat="server" ClientIDMode="Static"   MaxLength="100" CssClass="numbercheck" Width="90px" ></asp:TextBox>
               
            </td>             
        </tr>
        </table>
     <script type="text/javascript">
         var mouldId =<%= Request.QueryString["Id"] == null ? "" : Request.QueryString["Id"].ToString()%>;

         $(".numbercheck").keyup(function () {
             getDecimalVal(this);
         });

         function Save(){
             var deliveryTime = $("#txtDeliveryTime").val();
             var maintenanceCosts = $("#txtMaintenanceCosts").val()==""?0:parseFloat($("#txtMaintenanceCosts").val());

             var ajax = SKT.LeanMES.Web.Equipment.MouldSupplierDeliveryTime.DeliveryTime(mouldId,deliveryTime,maintenanceCosts);
             if (ajax.error != null) {
                 alert(ajax.error.Message);
                 return false;
             }
             alert("保存成功！");
             parent.window.UpdateList("");
         }
     </script>
</asp:Content>
