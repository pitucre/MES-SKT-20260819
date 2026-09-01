<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SerialNumberPrefixSufEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.SerialNumberPrefixSufEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                规则名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRuleName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                规则内容<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlRuleFunc" runat="server" IsRequired="1" ClientIDMode="Static">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" MaxLength="50"
                    TextMode="MultiLine" Width="250px" Height="60px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var dictionaryId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtRuleName = $.trim($("#<%=this.txtRuleName.ClientID%>").val());
            var ddlRuleFunc = $("#<%=this.ddlRuleFunc.ClientID%>").val();
            var txtDescription = $.trim($("#<%=this.txtDescription.ClientID%>").val());
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var entity = {};

            entity.DictionaryDataId = dictionaryId
            entity.Value = txtRuleName;
            entity.Code = ddlRuleFunc;
            entity.Description = txtDescription;
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.PerfixSufEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')

            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberPrefixSufEdit.aspx?name=SerialNumber_PrefixSufEdit&ID=" + dictionaryId;
                location.href = openWinUrl;
            }
            else {
                parent.window.UpdateList(txtRuleName);
            }
        }
    </script>
</asp:Content>
