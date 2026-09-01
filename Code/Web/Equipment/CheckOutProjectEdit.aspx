<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="CheckOutProjectEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.CheckOutProjectEdit" Title="Edit CheckOutProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1"><%= Resources.lang.CheckOutProjectName %><em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtCheckOutProjectName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1"><%= Resources.lang.IsEnable %></td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="txtIsEnable">
                    <asp:ListItem Value="1">启用</asp:ListItem>
                    <asp:ListItem Value="0">未启用</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1"><%= Resources.lang.Remark %></td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var checkOutProjectId = '<%=Request.QueryString["ID"]%>';
        var name = '<%=Request.QueryString["name"]%>';
        $(function () {
        });
        /*保存数据*/
        function Save() {
            var txtCheckOutProjectName = $.trim($("#<%=this.txtCheckOutProjectName.ClientID%>").val());
            var txtIsEnable = $("#<%=this.txtIsEnable.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.CheckOutProjectId = checkOutProjectId
            entity.CheckOutProjectName = txtCheckOutProjectName;
            entity.IsEnable = txtIsEnable == 0 ? false : true;
            entity.Remark = txtRemark;
            entity.CreateBy = txtCreateBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCheckOutProject.CheckOutProjectEdit(entity);
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
