<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="ItemGroupEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemGroupEdit"
    Title="Edit ItemGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                产品类型名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemGroupName" runat="server" IsRequired='1' MaxLength='50'  CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                描述
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemGroupDesc" runat="server" CssClass="TextArea" TextMode="MultiLine" Width="260px" Height="80px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var grouId = '<%=Request.QueryString["ID"] %>';
        function Save() {
            var txtItemGroupName = $.trim($("#<%=this.txtItemGroupName.ClientID %>").val());
            var txtItemGroupDesc = $("#<%=this.txtItemGroupDesc.ClientID %>").val();

            var errStr = "";

            if (txtItemGroupName == "") {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }

            if (errStr != "") {
                alert(errStr.toString());
                return false;
            }

            var entity = {};
            entity.ItemGroupId = grouId;
            entity.GroupName = txtItemGroupName;
            entity.GroupDesc = txtItemGroupDesc;
            entity.Remark = '';

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.ItemGroupEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtItemGroupName);

        }
    </script>
</asp:Content>
