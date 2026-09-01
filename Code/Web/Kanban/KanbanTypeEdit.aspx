<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KanbanTypeEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Kanban.KanbanTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                序号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSequence" runat="server" CssClass="NumericBox50" IsRequired="1" Text="1" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                看板类型名字(中文)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtKanbanTypeNameCN" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="20"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                看板类型名字(英文)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtKanbanTypeNameEN" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="20"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var reportTypeId = '<%=Request.QueryString["ID"]%>';
        function Save() {
            var TypeName = $("#<%=this.txtKanbanTypeNameCN.ClientID %>").val();
            var TypeNameEN = $("#<%=this.txtKanbanTypeNameEN.ClientID %>").val();
            var seq = $("#<%=this.txtSequence.ClientID %>").val();
            var error = "";
            if ($.trim(seq) == "") {
                error += "看板序号不能为空，且只能为数字。\n";
            }
            if ($.trim(TypeName) == "") {
                error += "看板类型中文名字不能为空\n";
            }
            if ($.trim(TypeNameEN) == "") {
                error += "看板类型英文名字不能为空\n";
            }
            if (!isNumber(seq)) {
                error += "顺序必须为数字\n";
            }
            if (error != "") {
                alert(error);
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.EditReportType(TypeName, TypeNameEN, seq, reportTypeId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");

            parent.UpdateList(TypeName);
        }
    </script>
</asp:Content>
