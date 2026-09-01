<%@ Page Title="" Language="C#" MasterPageFile="~/MobileApp/MobileMaster.Master"
    AutoEventWireup="true" CodeBehind="ModifyPwd.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.ModifyPwd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <input type="password" id="pwd" placeholder="输入旧密码" data-clear-btn="true" />
    </div>
    <div class="clear">
    </div>
    <div>
        <input type="password" id="pwd1" placeholder="输入新密码" data-clear-btn="true" />
    </div>
    <div class="clear">
    </div>
    <div>
        <input type="password" id="pwd2" placeholder="确认新密码" data-clear-btn="true" />
    </div>
    <div class="clear">
    </div>
    <div>
        <button data-theme="d" onclick="changePwd();">
            修改密码</button>
    </div>
    <div class="center">
        <div id="message" class="message">
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
           // $("#backlabel").html("个人中心");
        });
    </script>
</asp:Content>
