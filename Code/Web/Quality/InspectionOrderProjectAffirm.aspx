<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="InspectionOrderProjectAffirm.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionOrderProjectAffirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">检验单号</td>
            <td class="Field1">
                <asp:Label ID="lbInspectionOrderNo" runat="server" Text=""></asp:Label>
            </td>
        </tr>
            <tr>
            <td class="Label1">审核类型<em>*</em></td>
            <td class="Field1">
                <input name="type" value="0" type="radio"  /><span>通过</span>
                <input name="type" value="1" type="radio"  /><span>不通过</span>
            </td>
        </tr>
        <tr>
            <td class="Label1">解决方案</td>
            <td class="Field1">
                <asp:TextBox ID="txtRem" runat="server" Height="43px" TextMode="MultiLine"  Width="244px"  ></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">

        var ProjectStatus = '<%=ProjectStatus %>';
        $(function () {

            if (ProjectStatus == 1) {
                $("input[name='type'][value=1]").attr("checked", true);
            }
            else {
                $("input[name='type'][value=0]").attr("checked", true);
            }
        });

        //保存审核
        function Save() {
            var Id = '<%=Id %>';
            var Rem = $("#<%=this.txtRem.ClientID %>").val();
            var res = $('input:radio:checked').val();
            var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId  %>';
            if (res == "undefined" || res == null) {
                res = "-1";
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.InspectionOrderSaveProjectAffirm(parseInt(Id), res, Rem, parseInt(userId));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveInSuccess %>");
            }
            parent.window.UpdateList();
        }
    </script>
</asp:Content>
