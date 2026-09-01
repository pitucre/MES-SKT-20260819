<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="WriteBackConfigureEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.WriteBackConfigureEdit" Title="Edit WriteBackConfigure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td>
        </tr>
        <tr>
            <td class="Label2">回写编码</td>
            <td class="Field2">
                <asp:TextBox ID="WriteBackCode" runat="server" CssClass="TextBox" Enabled="False" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label2">回写名称</td>
            <td class="Field2">
                <asp:TextBox ID="WriteBackName" runat="server" CssClass="TextBox" Enabled="False" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">是否回写ERP<em>*</em></td>
            <td class="Field2">
                <asp:RadioButtonList ID="WriteBackFlag" runat="server" RepeatDirection="Horizontal" CssClass="rbl" CellSpacing="5" CellPadding="3" ClientIDMode="Static">
                    <asp:ListItem Selected="True" Text="否" Value="0"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="Label2">备注</td>
            <td class="Field2">
                <asp:TextBox ID="Remark" runat="server" CssClass="TextBox" MaxLength="500" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        var writeBackConfigId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var writeBackCode = $.trim($("#WriteBackCode").val());
            var writeBackFlag = $("#WriteBackFlag input[type=\"radio\"]:checked").val();
            var remark = $.trim($("#Remark").val());

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};
            entity.WriteBackConfigId = writeBackConfigId;
            entity.WriteBackCode = writeBackCode;
            entity.WriteBackFlag = parseInt(writeBackFlag);
            entity.Remark = remark;
            entity.ModifyBy = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspERPWriteBackConfigEdit", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }
    </script>

</asp:Content>
