<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentPositionEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentPositionEdit" Title="Edit EquipmentPosition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
        <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.PositionName %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtPositionName" runat="server" CssClass="TextBox"  isrequired="1" MaxLength="100"></asp:TextBox>
            </td>
            </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  isrequired="1" MaxLength="500"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var equipmentPositionId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtPositionName = $.trim($("#<%=this.txtPositionName.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


        var entity = {};

        entity.EquipmentPositionId = equipmentPositionId
        entity.PositionName = txtPositionName;
        entity.Remark = txtRemark;
        entity.CreateBy = txtCreateBy;

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentPosition.EquipmentPositionEdit(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        alert('<%=Resources.Messages.SaveInSuccess%>')
        if('<%=Request.QueryString["inMenu"] %>' == "true") {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
            location.href = openWinUrl;
        }
        else {
            parent.window.Refresh();
        }
    }
    </script>

</asp:Content>