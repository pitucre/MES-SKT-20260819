<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="JigTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Jig.JigTypeEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="4" class="Label infoTips"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.FeederTypeName%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtTypeName" runat="server" CssClass="TextBox" isRequired="1"  MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.JigTypeCode%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtTypeCode" runat="server" CssClass="TextBox" isRequired="1"  MaxLength="50"></asp:TextBox>
            </td>
        </tr>
       <tr>
            <td class="Label2">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="4">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="400" Width="99%" Height="50"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
        /*保存数据*/
        function Save() {
            var txtTypeName = $.trim($("#<%=this.txtTypeName.ClientID%>").val());
            var txtTypeCode = $.trim($("#<%=this.txtTypeCode.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {}; 

            entity.JigTypeId = Id
            entity.TypeName = txtTypeName;
            entity.TypeCode = txtTypeCode;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxJigType.JigTypeEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigTypeEdit.aspx?name=JigTypeEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
 