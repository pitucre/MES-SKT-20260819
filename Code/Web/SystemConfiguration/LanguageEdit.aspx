<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" 
    CodeBehind="LanguageEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.LanguageEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label1">多语言标识<em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtLanguageKey" isrequired="1"  runat="server" CssClass="TextBox"  MaxLength="255"></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <td class="Label1">中文</td>
            <td class="Field1">
                <asp:TextBox ID="txtCN"  runat="server" CssClass="TextBox" MaxLength="255"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">英文</td>
            <td class="Field1">
                <asp:TextBox ID="txtEN" runat="server" CssClass="TextBox"  MaxLength="255"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"]%>';

        /*保存数据*/
        function Save() {
            var txtLanguageKey = $.trim($("#<%=this.txtLanguageKey.ClientID%>").val());
            var txtCN = $.trim($("#<%=this.txtCN.ClientID%>").val());
            var txtEN = $.trim($("#<%=this.txtEN.ClientID%>").val());

            var entity = {};
            entity.LanguageId = id;
            entity.LanguageKey = txtLanguageKey;
            entity.CN = txtCN;
            entity.EN = txtEN;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLanguage.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }
    </script>
</asp:Content>
