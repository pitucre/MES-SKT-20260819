<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="AccessoryTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryTypeEdit" Title="Edit AccessoryType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
            <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.AccessoryTypeName %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtAccessoryTypeName" runat="server" CssClass="TextBox"  MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.ThawTime %></td>
            <td class="Field2">
                <asp:TextBox ID="txtThawTime" runat="server" CssClass="TextBox" IsNumber="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.LeaveUnusedTime %></td>
            <td class="Field2">
                <asp:TextBox ID="txtLeaveUnusedTime" runat="server" CssClass="TextBox" IsNumber="1"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.UseTime %></td>
            <td class="Field2">
                <asp:TextBox ID="txtUseTime" runat="server" CssClass="TextBox" IsNumber="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.StirTime %></td>
            <td class="Field2">
                <asp:TextBox ID="txtStirTime" runat="server" CssClass="TextBox" IsNumber="1"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.StirIdleTime %></td>
            <td class="Field2">
                <asp:TextBox ID="txtStirIdleTime" runat="server" CssClass="TextBox" IsNumber="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">搅拌次数</td>
            <td class="Field2" colspan="4">
                <asp:TextBox ID="txtStirQty" runat="server" CssClass="TextBox" IsNumber="1"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var accessoryTypeId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtAccessoryTypeName = $.trim($("#<%=this.txtAccessoryTypeName.ClientID%>").val());
            var txtThawTime = $("#<%=this.txtThawTime.ClientID%>").val();
            var txtLeaveUnusedTime = $("#<%=this.txtLeaveUnusedTime.ClientID%>").val();
            var txtUseTime = $("#<%=this.txtUseTime.ClientID%>").val();
            var txtStirTime = $("#<%=this.txtStirTime.ClientID%>").val();
            var txtStirIdleTime = $("#<%=this.txtStirIdleTime.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtStirQty = $("#<%=this.txtStirQty.ClientID%>").val();

        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


        var entity = {};

        entity.AccessoryTypeId = accessoryTypeId
        entity.AccessoryTypeName = txtAccessoryTypeName;
        entity.ThawTime = parseFloat(txtThawTime);
        entity.LeaveUnusedTime = parseFloat(txtLeaveUnusedTime);
        entity.UseTime = parseFloat(txtUseTime);
        entity.StirTime = parseFloat(txtStirTime);
        entity.StirIdleTime = parseFloat(txtStirIdleTime);
        entity.CreateBy = txtCreateBy;
        entity.StirQty = parseInt(txtStirQty);

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryTypeEdit(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        alert('<%=Resources.Messages.SaveInSuccess%>')
        if('<%=Request.QueryString["inMenu"] %>' == "true") {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
            location.href = openWinUrl;
        }
        else {
            parent.window.Refresh();
        }
    }
    </script>

</asp:Content>