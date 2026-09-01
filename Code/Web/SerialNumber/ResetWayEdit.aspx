<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ResetWayEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.ResetWayEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.ResetWay %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtResetWay" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                复位存储过程<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlRestWayFunc" runat="server" IsRequired="1" ClientIDMode="Static">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtResetWayDesc" runat="server" CssClass="TextArea" MaxLength="100"
                    TextMode="MultiLine" Width="220px" Height="70px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var resetWayId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtResetWay = $.trim($("#<%=this.txtResetWay.ClientID%>").val());
            var txtResetWayDesc = $.trim($("#<%=this.txtResetWayDesc.ClientID%>").val());
            var ddlRestWayFunc = $("#<%=this.ddlRestWayFunc.ClientID%>").val();
            var chkIsSystemResetWay = false;
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var entity = {};
            entity.ResetWayId = resetWayId
            entity.ResetWay = txtResetWay;
            entity.IsSystemResetWay = chkIsSystemResetWay;
            entity.RelationFunc = ddlRestWayFunc;
            entity.ResetWayDesc = txtResetWayDesc;
            entity.CreateBy = userName
            entity.ModifyBy = userName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.ResetWayEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/ResetWayEdit.aspx?name=SerialNumber_ResetWayEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
