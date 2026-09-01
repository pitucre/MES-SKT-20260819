<%@ Page Title="" Language="C#" MasterPageFile="~/MobileApp/MobileMaster.Master"
    AutoEventWireup="true" CodeBehind="MyInfo.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MyInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul data-role="listview" data-theme="c" style="font-family: Microsoft YaHei UI; color: #d3d3d3;">
        <li data-icon="false" id="sitetitle1" style="background: #f1f1f1; border-bottom: 1px solid #d3d3d3;">
            工厂<span class="ui-li-rightlabel" id="sitetitle2"></span></li>
        <li data-icon="false" style="background: #f1f1f1; border-bottom: 1px solid #d3d3d3;">
            登录名<span class="ui-li-rightlabel"><%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %></span></li>
        <li data-icon="false" style="background: #f1f1f1; border-bottom: 1px solid #d3d3d3;">
            中文名<span class="ui-li-rightlabel"><%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %></span></li>
        <li data-icon="false" style="background: #f1f1f1; border-bottom: 1px solid #d3d3d3;">
            英文名<span class="ui-li-rightlabel"><%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeEName %></span></li>
        <li data-icon="false" style="background: #f1f1f1; border-bottom: 1px solid #d3d3d3;">
            列表记录数<span class="ui-li-rightlabel"><%=SKT.LeanMES.Web.AccountController.GetCurrentUser().Linage %></span></li>
    </ul>
    <script type="text/javascript">
        $(function () {
            //$("#backlabel").html("个人中心");

            var cachSite = getCookie("cachSite");
            if (cachSite != null && cachSite != "") {
                $("#sitetitle2").html("(" + cachSite + ")");
            }
            else {
                $("#sitetitle1").hide();
            }
        });
    </script>
    <script src="js/skt.mobile.cookies.js" type="text/javascript"></script>
</asp:Content>
