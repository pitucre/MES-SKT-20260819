<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="InspectionmethodsEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionmethodsEdit"
    Title="Edit InspectionmethodsEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable"> 
        <tr>
            <td class="Label2">
                <%= Resources.lang.Name%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="20"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.Description %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td  colspan="3" class="Field2">
                <asp:TextBox ID="txtRemark"  TextMode="MultiLine" Width="500px" runat="server" CssClass="TextArea" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var dictionaryDataId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtName = $.trim($("#<%=this.txtName.ClientID%>").val());
            var txtDescription = $.trim($("#<%=this.txtDescription.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.DictionaryDataID = dictionaryDataId
            entity.Code = "";
            entity.Name = txtName;
            entity.DicProperty = "Inspectionmethod";//检验方法
            entity.Description = txtDescription;
            entity.Value = txtName;
            entity.Remark = txtRemark;
            entity.ModifyBy = txtModifyBy;
            entity.CreateBy = txtCreateBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDictionaryData.DictionaryDataEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
