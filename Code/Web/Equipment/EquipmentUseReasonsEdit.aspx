<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentUseReasonsEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentUseReasonsEdit" Title="Edit EquipmentUseReasons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.Content %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtContent" runat="server" CssClass="TextBox" MaxLength="100"  IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.Type %></td>
            <td>
                <asp:DropDownList runat="server" ID="dlltype">
                    <asp:ListItem Value="1">领用</asp:ListItem>
                    <asp:ListItem Value="2">归还</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var equipmentUseReasonsId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtContent = $.trim($("#<%=this.txtContent.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.EquipmentUseReasonsId = equipmentUseReasonsId
            entity.Content = txtContent;
            entity.Type = $("#ContentPlaceHolder1_EditContent_dlltype :selected").val();
            entity.Remark = txtRemark;
            entity.CreateBy = txtCreateBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentUseReasons.EquipmentUseReasonsEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
            location.href = openWinUrl;
        }
        else {
            parent.window.Refresh();
        }
    }
    </script>

</asp:Content>
