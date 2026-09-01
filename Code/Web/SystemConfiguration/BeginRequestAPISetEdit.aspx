<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="BeginRequestAPISetEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.BeginRequestAPISetEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">地址<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRequestUrl" MaxLength="200" Width="600" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">API请求地址<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtAPIUrl" MaxLength="200" Width="600" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">API请求方式<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlAPIMethod" ClientIDMode="Static">
                    <asp:ListItem Value="GET">GET</asp:ListItem>
                    <asp:ListItem Value="POST">POST</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">返回类型<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlResultType" ClientIDMode="Static">
                    <asp:ListItem Value="0">JSON</asp:ListItem>
                    <asp:ListItem Value="1">字符串</asp:ListItem>
                    <asp:ListItem Value="2">文件流</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">请求节点<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlApplication" ClientIDMode="Static">
                    <asp:ListItem Value="0">开始请求前</asp:ListItem>
                    <asp:ListItem Value="1">请求结束后</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">异常处理<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlDealError" ClientIDMode="Static">
                    <asp:ListItem Value="0">抛出异常</asp:ListItem>
                    <asp:ListItem Value="1">继续执行</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">参数类型<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlContentType" ClientIDMode="Static">
                    <asp:ListItem Value="0">JSON提交</asp:ListItem>
                    <asp:ListItem Value="1">FORM提交</asp:ListItem>
                    <asp:ListItem Value="2">URL提交</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
        <tr>
            <td class="Label2">处理参数存储过程
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeal_Param_Proc" Enabled="false" MaxLength="50" Width="200" runat="server"></asp:TextBox>
            </td>
            <td class="Label2">处理结果存储过程
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeal_Result_Proc" Enabled="false" MaxLength="50" Width="200" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">备注
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" Width="600" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        /*保存数据*/
        function Save() {
            var entity = {
                Id: parseInt("<%=Request.QueryString["Id"]%>"),
                RequestUrl: $("#<%=this.txtRequestUrl.ClientID%>").val(),
                APIUrl: $("#<%=this.txtAPIUrl.ClientID%>").val(),
                APIMethod: $("#<%=this.ddlAPIMethod.ClientID%>").val(),
                ResultType: $("#<%=this.ddlResultType.ClientID%>").val(),
                DealError: $("#<%=this.ddlDealError.ClientID%>").val(),
                ContentType: $("#<%=this.ddlContentType.ClientID%>").val(),
                Application: $("#<%=this.ddlApplication.ClientID%>").val(),
                Remark: $("#<%=this.txtRemark.ClientID%>").val(),
                ModifyBy: "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"
            };
            if (!entity.RequestUrl || !entity.APIUrl) {
                alert("请录入完整信息");
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.BeginRequestAPISetEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }
    </script>
</asp:Content>
