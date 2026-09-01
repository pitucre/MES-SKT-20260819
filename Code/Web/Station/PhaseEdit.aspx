<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="PhaseEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Station.PhaseEdit" Title="Edit Phase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                生产阶段<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPhaseName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" MaxLength="50" Width="250px"
                    Height="90px" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var phaseId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtPhaseName = $.trim($("#<%=this.txtPhaseName.ClientID%>").val());
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());

            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.PhaseID = -1;
            }
            else {
                entity.PhaseID = phaseId;
            }
            entity.PhaseName = txtPhaseName;
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPhase.PhaseEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            window.parent.Refresh();
        }
    </script>
</asp:Content>
