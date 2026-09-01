<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ESOPStroeConfig.aspx.cs" Inherits="SKT.LeanMES.Web.ESOP.ESOPStroeConfig" MasterPageFile="~/Masters/EditMaster.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div >
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
        <table style="width:100%">
             <tr>
                <td class="Label1">
                    Ftp服务器地址：
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtFtpServerName" runat="server" ClientIDMode="Static" CssClass="TextBox" Width="160px" IsRequired='1'></asp:TextBox>
                    <font color="red">*</font>
                    &nbsp;例如：156.45.0.4
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    Ftp登录用户名：
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtUserName" runat="server" ClientIDMode="Static" CssClass="TextBox" Width="160px" IsRequired='1'></asp:TextBox>
                    <font color="red">*</font>
                    &nbsp;例如：test
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    Ftp登录密码：
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtPassWord" runat="server" ClientIDMode="Static" CssClass="TextBox" TextMode="Password"  Width="160px" IsRequired='1'></asp:TextBox>
                    <font color="red">*</font>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    存储目录：
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtStoreLocation" runat="server" ClientIDMode="Static" CssClass="TextBox" Width="160px"></asp:TextBox>
                    &nbsp;例如：ESOP
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript" language="javascript">
        var isCP = <%=isCP %>;
        var Id = <%=id%>

        function Save() {
            var txtFtpServerName = $.trim($("#txtFtpServerName").val());

            var txtUserName = $.trim($("#txtUserName").val());
            var txtPassWord = $("#txtPassWord").val();
            var txtStoreLocation = $.trim($("#txtStoreLocation").val()); 
            if (isCP == 0 && isNull(txtPassWord)) {
                alert('请输入密码！')
                $("#txtPassWord").css('background-color', 'yellow').focus();
                return false;
            }

            //var reg = /^((0|(?:[1-9]\d{0,1})|(?:1\d{2})|(?:2[0-4]\d)|(?:25[0-5]))\.){3}((?:[1-9]\d{0,1})|(?:1\d{2})|(?:2[0-4]\d)|(?:25[0-5]))$/;            
            //if(!reg.test(txtFtpServerName)){
            //    alert("请输入正确的Ftp服务器地址！");
            //    $("#txtFtpServerName").css('background-color', 'yellow').focus();               
            //    return false;
            //}

            var entity = {}; 
            entity.FtpServerName = txtFtpServerName; 
            entity.UserName = txtUserName;
            entity.PWD = txtPassWord;
            entity.FtpStoreLocation = txtStoreLocation;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxFtpConfig.FtpServerEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert("保存成功！"); 
            }
        }
    </script>
</asp:Content>
