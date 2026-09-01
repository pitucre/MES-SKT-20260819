<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InspectionOrderConfirmation.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionOrderConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    
<table width="100%" class="EditeContentTable">
    <tr>
        <td class="Label1">检验单号</td>
        <td class="Field1">
            <asp:Label ID="lbInspectionOrderNo" runat="server" Text=""></asp:Label>
        </td>
    </tr>
        <tr>
        <td class="Label1">审核类型<em>*</em></td>
        <td class="Field1">
            <input name="type" value="2" type="radio"  /><span>通过</span>
            <input name="type" value="3" type="radio"  /><span>不通过</span>
        </td>
    </tr>
        <tr id="trIsolatedStorage" style="display:none;">
        <td class="Label1">隔离入库</td>
        <td class="Field1">
            <input type="checkbox" id="IsolatedStorage" />
            <input type="hidden" id="hdIsolatedStorage" value="0" />
        </td>
    </tr>
        <tr style="display:none;">
        <td class="Label1">检验备注</td>
        <td class="Field1">
            <asp:Label ID="DealResultRemark" runat="server" Text="Label"></asp:Label>
        </td>
    </tr>
        <tr>
        <td class="Label1">审核备注</td>
        <td class="Field1">
            <asp:TextBox ID="txtRem" runat="server" Height="43px" TextMode="MultiLine" Width="244px"  ></asp:TextBox>
        </td>
    </tr>
    <tr id="showImageUrl1" style="display:none;"> 
        <td class="Label1">
            上传文件
        </td>
        <td class="Field1">
                <input type="file" id="uploadify" name="uploadify" />
            <asp:Label ID="lblSamplePicture" runat="server"></asp:Label>
            <div id="fileQueue">
            </div>

            <asp:HiddenField ID="hdSamplePicture" runat="server" Value="-1" />
            <asp:HiddenField ID="hdFileName" runat="server" Value="-1" />                                
        </td>
    </tr>
 </table>
 
 <link type="text/css" href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify.css"rel="Stylesheet" />
 <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js"></script>
 <script type="text/javascript">

     var InspectionTypeId = '<%=InspectionTypeId %>'
     var Ischecked = '<%=Ischecked%>'; //审核类型
     var AuditStatus = '<%=AuditStatus%>';

     $(function () {
         if (AuditStatus == "3") {
             $("input[name='type'][value=3]").attr("checked", true);
         }
         else {
             $("input[name='type'][value=2]").attr("checked", true);
         }
     });

     function Save() {

         var Id = '<%=Id %>';
         var Rem = $("#<%=this.txtRem.ClientID %>").val();
         var res = $('input:radio:checked').val();
         var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>';
         if (res == "undefined" || res == null) {
             res = "-1";
         }
        
         var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.InspectionOrderConfirmationSave(parseInt(Id), res, Rem, parseInt(userId));
         if (ajax.error != null) {
             alert(ajax.error.Message);
             return false;
         }
         else {
             alert("<%= Resources.Messages.SaveInSuccess %>");
         }
         parent.window.UpdateList();
     }
 
 </script>
</asp:Content>
