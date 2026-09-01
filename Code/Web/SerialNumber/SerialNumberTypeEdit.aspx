<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="SerialNumberTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.SerialNumberTypeEdit"
    Title="Edit SerialNumberType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.SerialNumberRuleTypeName %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSerialNumberType" runat="server" CssClass="TextBox" IsRequired="1"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>       
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSerialNumberDesc" runat="server" CssClass="TextArea" MaxLength="100"
                    TextMode="MultiLine" Width="250px" Height="60px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var serialNumberTypeId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtSerialNumberType = $.trim($("#<%=this.txtSerialNumberType.ClientID%>").val());
            var txtSerialNumberDesc = $.trim($("#<%=this.txtSerialNumberDesc.ClientID%>").val());           
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var entity = {};

            entity.SerialNumberTypeId = serialNumberTypeId
            entity.SerialNumberType = txtSerialNumberType;
            entity.SerialNumberDesc = txtSerialNumberDesc;            
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.SerialNumberTypeEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')

            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberTypeEdit.aspx?name=SerialNumber_SerialNumberTypeEdit&ID=" + serialNumberTypeId;
                location.href = openWinUrl;
            }
            else {
                parent.window.UpdateList(txtSerialNumberType);
            }
        }
    </script>
</asp:Content>
