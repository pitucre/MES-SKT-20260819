<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" 
CodeBehind="AQLRuleTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.AQLRuleTypeEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.AqlRuleType %><em>*</em>
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtAqlRuleTypeName" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="Label2">
                <em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRuleList" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Remark %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <asp:HiddenField runat="server" ID="txtHideID"/>
        </tr>
        </table>

        <script language="javascript" type="text/javascript">
            var ReqId = '<%=Request.QueryString["ID"] %>';

            /*保存数据*/
            function Save() {
                var entity = {};
                entity.AqlRuleTypeName = $("#<%=this.txtAqlRuleTypeName.ClientID %>").val();
                entity.AqlRuleTypeList = $("#<%=this.txtRuleList.ClientID %>").val();
                entity.Remark = $("#<%=this.txtRemark.ClientID %>").val();
                entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
                entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
                entity.AqlRuleTypeId = $("#<%=this.txtHideID.ClientID %>").val();
                if (entity.AqlRuleTypeId === '') {
                    entity.AqlRuleTypeId = ReqId;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.AQLRuleTypeEdit(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert('<%=Resources.Messages.SaveInSuccess %>');
                parent.window.UpdateList($("#<%=this.txtAqlRuleTypeName.ClientID %>").val());
                return ajax;
            }
    </script>
</asp:Content>
