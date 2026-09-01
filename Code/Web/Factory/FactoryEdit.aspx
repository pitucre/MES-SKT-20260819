<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="FactoryEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Factory.FactoryEdit"
    Title="Edit Factory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1" id="tdFactoryName">
                <%= Resources.lang.FactoryName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFactoryName" runat="server" IsRequired='1' CssClass="TextBox"
                    MaxLength="50"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1" id="tdFactoryCode">
                <%= Resources.lang.FactoryCode%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFactoryCode" runat="server" IsRequired='1' CssClass="TextBox"
                    MaxLength="50"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">是否首选
            </td>
            <td class="Field2">
                <asp:CheckBox runat="server" ID="chkIsDefaultFactory" Checked="false" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
        var typeId =  <%= Request.QueryString["TypeId"] == null ? 1 : Convert.ToInt32(Request.QueryString["TypeId"].ToString())%>;

        $(function() {
            if (typeId == 2) {
                $("#tdFactoryName").text(mesLang("公司名称"));
                $("#tdFactoryCode").text(mesLang("公司代码"));
            }
        });
            /*保存数据*/
            function Save() {
                var txtFactoryName = $.trim($("#<%=this.txtFactoryName.ClientID%>").val());
            var txtFactoryCode = $.trim($("#<%=this.txtFactoryCode.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var chkIsDefaultFactory = $("#chkIsDefaultFactory").is(":checked") == true ? 1 : 2;
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};
            entity.FactoryID = Id;
            entity.FactoryName = txtFactoryName;
            entity.FactoryCode = txtFactoryCode;
            entity.Remark = txtRemark;
            entity.ChkIsDefaultFactory = chkIsDefaultFactory;
            entity.TypeId = typeId;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxFactory.FactoryEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Factory/FactoryEdit.aspx?name=FactoryView&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
