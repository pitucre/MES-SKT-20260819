<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="AnormalTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                异常类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlAnormalGroup" runat="server" ClientIDMode="Static" Width="100"
                    IsRequired='1'>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                异常名称<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtAnormalTypeName" runat="server" IsRequired='1' CssClass="TextBox"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                异常代码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtAnormalTypeCode" runat="server" CssClass="TextBox" MaxLength="20"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDesc" CssClass="TextArea" TextMode="MultiLine" Width="180px" runat="server"
                    Height="40px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var AnormalTypeId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtAnormalTypeCode = $.trim($("#<%=this.txtAnormalTypeCode.ClientID%>").val());
            var txtAnormalTypeName = $.trim($("#<%=this.txtAnormalTypeName.ClientID%>").val());
            var txtDesc = $.trim($("#<%=this.txtDesc.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = txtCreateBy;
            var txtRemark = "";
            var txtAnormalGroupId = $("#<%=this.ddlAnormalGroup.ClientID%>").val();

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.AnormalTypeId = -1;
            }
            else {
                entity.AnormalTypeId = AnormalTypeId;
            }
            entity.AnormalTypeCode = txtAnormalTypeCode;
            entity.AnormalTypeName = txtAnormalTypeName;
            entity.Descriptions = txtDesc;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Remark = txtRemark;
            entity.AnormalGroupId = txtAnormalGroupId;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAnormal.EditAnormalType(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');

            parent.window.UpdateList(txtAnormalTypeName);
        }
    </script>
</asp:Content>
