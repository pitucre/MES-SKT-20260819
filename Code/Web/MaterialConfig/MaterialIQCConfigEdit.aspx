<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialIQCConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.MaterialIQCConfigEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                IQC检验结果<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtCheckResult" CssClass="TextBox" MaxLength="25" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr id="showMaterialPrint">
            <td class="Label1">
                物料检验状态
            </td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="ddlIQCStatus" ClientIDMode="Static">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                是否可入库
            </td>
            <td class="Field1">
                <asp:CheckBox ID="chkIsStorage" Checked="true"  ClientIDMode="Static" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var iqcCheckId = '<%=Request.QueryString["ID"]%>';        

        function Save() {
            var txtCheckType = $.trim($("#<%=this.txtCheckResult.ClientID%>").val());
            var txtMaterialStatusId = $.trim($("#ddlIQCStatus").find(":selected").val());
            var txtMaterialStatus = $.trim($("#ddlIQCStatus").find(":selected").text());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());

            var isStorage = $("#chkIsStorage").is(":checked");
            if (isStorage) {
                isStorage = 1
            }
            else {
                isStorage = 0;
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};

            entity.ID = iqcCheckId;
            entity.CheckType = txtCheckType;
            entity.MaterialStatusId = txtMaterialStatusId;
            entity.MaterialStatus = txtMaterialStatus;
            entity.Remark = txtRemark;
            entity.IsStorage = Boolean(isStorage);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.MaterialIQCEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList(txtCheckType);
        }
    </script>
</asp:Content>
