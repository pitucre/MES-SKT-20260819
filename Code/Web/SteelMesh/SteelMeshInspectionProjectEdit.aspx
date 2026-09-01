<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SteelMeshInspectionProjectEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshInspectionProjectEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
            <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">项目代码<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSMIPCode" runat="server" CssClass="TextBox"  MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2">项目名称<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSMIPName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">类型<em>*</em></td>
            <td class="Field2">
                <asp:DropDownList ID="SMIPType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Selected="True" Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">通用</asp:ListItem>
                    <asp:ListItem Value="1">钢网</asp:ListItem>
                    <asp:ListItem Value="2">刮刀</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">单位</td>
            <td class="Field2">
                <asp:TextBox ID="txtSMIPUnit" runat="server" CssClass="TextBox"  MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">录入方式<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSMIPEntryMode" runat="server" CssClass="TextBox"   IsRequired='1' Text="固定值结果" ReadOnly="true"></asp:TextBox>
            </td>
            <td class="Label2">判定标准<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSMIPCriterion" runat="server" CssClass="TextBox" IsRequired='1' Text="OK/NG" ReadOnly="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">备注</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSMIPRem" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var SMIPId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtSMIPCode = $.trim($("#<%=this.txtSMIPCode.ClientID%>").val());
            var txtSMIPName = $("#<%=this.txtSMIPName.ClientID%>").val();
            var txtSMIPEntryMode = $("#<%=this.txtSMIPEntryMode.ClientID%>").val();
            var txtSMIPCriterion = $("#<%=this.txtSMIPCriterion.ClientID%>").val();
            var txtSMIPUnit = $("#<%=this.txtSMIPUnit.ClientID%>").val();
            var txtSMIPRem = $("#<%=this.txtSMIPRem.ClientID%>").val();
            var SMIPUserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var SMIPType = $("#SMIPType").val();

            /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/
            if (SMIPType == "-1") {
                alert("请选择类型");
                return false;
            }


            var entity = {};

            entity.SMIPId = SMIPId
            entity.SMIPCode = txtSMIPCode;
            entity.SMIPName = txtSMIPName;
            entity.SMIPEntryMode = txtSMIPEntryMode;
            entity.SMIPCriterion = txtSMIPCriterion;
            entity.SMIPUnit = txtSMIPUnit;
            entity.SMIPRem = txtSMIPRem;
            entity.SMIPUserName = SMIPUserName;
            entity.SMIPUpdateUserName = SMIPUserName
            entity.SMIPType = parseInt(SMIPType);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.SaveSteelMeshInspectionProject(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }
    </script>

</asp:Content>
