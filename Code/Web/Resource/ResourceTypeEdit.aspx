<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ResourceTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.ResTypeName %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtResTypeName" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtResTypeDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        /*保存*/
        function Save() {
            var action = '<%=Request.QueryString["Action"] %>';
            var resTypeId = '<%=Request.QueryString["ID"] %>';
            var txtResTypeName = $("#txtResTypeName").val();
            var txtResTypeDesc = $("#txtResTypeDesc").val();
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var errStr = "";

            if (txtResTypeName == "") {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }

            if (errStr != "") {
                alert(errStr.toString());
                return false;
            }

            var entity = {};
            if (action == "Copy") {
                entity.ResourceTypeId = -1;
            }
            else {
                entity.ResourceTypeId = resTypeId;
            }
            entity.ResTypeName = txtResTypeName;
            entity.ResTypeDesc = txtResTypeDesc;
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            entity.Remark = "";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceResource.EditResourceType(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtResTypeName);
        }
    </script>
</asp:Content>
