<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="PrepareToOtherConfig.aspx.cs"
    Inherits="SKT.LeanMES.Web.MaterialConfig.PrepareToOtherConfig" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">备货地点<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtPrepareTo" CssClass="TextBox"
                    MaxLength="25" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var prepId = '<%=Request.QueryString["ID"]%>';

        function Save() {

            var txtPrepareDesc = $.trim($("#<%=this.txtPrepareTo.ClientID%>").val());
            var txtRemark = $("#<%=this.txtRemark.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};
            entity.PrepareToOtherId = -1;
            entity.RID = prepId;
            entity.PrepareDesc = txtPrepareDesc;
            entity.EnableFlag = 1;
            entity.CreateBy = txtCreateBy;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.PrepareToOtherEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList(txtPrepareDesc);
    }
    </script>
</asp:Content>
