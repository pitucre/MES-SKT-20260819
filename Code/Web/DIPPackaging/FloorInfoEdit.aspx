<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="FloorInfoEdit.aspx.cs" Inherits="SKT.LeanMES.Web.DIPPackaging.FloorInfoEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label2">楼层代码<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtCode" runat="server" CssClass="TextBox"  IsRequired="1"  MaxLength="100"></asp:TextBox>
            </td>
            <td class="Label2">楼层名称<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"  IsRequired="1"  MaxLength="100"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var floorInfoId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtFid = floorInfoId;
            var txtCode = $.trim($("#<%=this.txtCode.ClientID%>").val());
            var txtName = $.trim($("#<%=this.txtName.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


        var entity = {};

        entity.Fid = txtFid;
        entity.Code = txtCode;
        entity.Name = txtName;
        entity.Status = 1;
        entity.CreateBy = txtCreateBy;
        entity.ModifyBy = txtModifyBy;
        entity.Remark = txtRemark;

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDIPPackaging.FloorInfoEdit(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        alert('<%=Resources.Messages.SaveInSuccess%>')
        parent.window.Refresh();
    }
    </script>

</asp:Content>
