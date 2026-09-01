<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="CustomerProjectEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Customer.CustomerProjectEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                客户简称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" Enabled="false" ReadOnly="true"
                    IsRequired='1'></asp:TextBox><input type="button" id="btnSelectCustomer" class="ButtonBox"
                        value="..." title="选择客户" onclick="selectCustomer();" />
                <asp:HiddenField ID="hdnCustomerId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                项目名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtProName" runat="server" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtProDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    Width="260px" Height="60px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Save() {
            var action = '<%=Request.QueryString["Action"] %>';
            var proId = '<%=Request.QueryString["ID"] %>';
            var txtCustomerId = $("#<%=this.hdnCustomerId.ClientID %>").val();
            var txtProName = $("#<%=this.txtProName.ClientID %>").val();
            var txtProDesc = $("#<%=this.txtProDesc.ClientID %>").val();
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

            var errStr = "";
            if (!isNull(errStr)) {
                alert(errStr.toString());
                return false;
            }

            var entity = {};
            if (action.toLocaleLowerCase() == "copy") {
                entity.ProjectId = -1;
            }
            else {
                entity.ProjectId = proId;
            }
            entity.ProName = txtProName;
            entity.CustomerID = txtCustomerId;
            entity.ProDesc = txtProDesc;
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            entity.Remark = "";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCustomer.ProjectEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;

            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtProName, txtCustomerId, $("#<%=this.txtCustomer.ClientID %>").val());
        }

        function selectCustomer() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 500, height: 220 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtCustomer.ClientID %>").val(list[0][1]);
            $("#<%=this.hdnCustomerId.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
