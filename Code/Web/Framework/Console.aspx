<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Console.aspx.cs" Inherits="SKT.LeanMES.Web.Framework.Console"
    EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
    <link href="../Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet"
        type="text/css" />
    <title>控制面板</title>
    <link href="../Content/console/console.css?v=BB4890C8-9117-434D-831A-4BD169C32852" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/umeditor1_2_2/third-party/jquery.min.js" type="text/javascript"></script>
    <style type="text/css">
        .dlg-nc > .nebutton > .close
        {
            width: 46px;
            height: 19px;
            cursor: pointer;
            position: absolute;
            top: -1px;
            right: 0px;
            background-position: -14px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="shadowdiv" id="shadowdiv">
    </div>
    <!--顶部-->
    <div style="background: #faf9f9; border-bottom:3px solid #4484bf; height: 50px;
        padding: 0px; margin: 0px; width: 100%; position: fixed; top: 0px; left: 0px;">
        <div style="max-width: 1300px; position: relative; margin: auto auto;">
            <!--logo-->
            <div style="position: absolute; left: 30px; top: 0px;">
                <img src="../Content/login/login2/logo.png"
                    title="LEAN MES" alt="LEAN MES" />
                <label id="lblVersion" runat="server" style="color: #666;">
                </label>
            </div>
            <!--user-->
            <div style="position: absolute; top: 0px; right: 30px;">
                <div style="float: left; height: 30px; padding: 10px; line-height: 30px;">
                    <asp:Localize ID="userInfo" runat="server"></asp:Localize>
                </div>
                <!--设置菜单-->
                <ul class="menu" id="menu">
                    <li style="position: relative;">设置<img src="../Content/console/img/arrow.gif" style="margin-left: 5px;" />
                        <ul class="dlmenu" id="dlmenu">
                            <li onclick="modifyPwd()">修改密码</li>
                            <li onclick="quit()">退出</li>
                            <li onclick="help()">帮助</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!--控制面板-->
    <div style="margin-top: 55px; height: 65px; line-height: 65px; text-align: center; display:none;">
        <span style="font-size: 26px; font-weight: bold; color: #333333; font-family: Verdana, 微软雅黑,黑体, 宋体;">
            控制面板</span>
    </div>
    <!--split-->
    <div style="height: 4px; background: url(../Content/console/img/split.gif) repeat-x;
        width: 90%; margin: auto auto; display:none;">
    </div>
    <!--module list-->
    <div style="margin-top: 30px; padding: 30px; margin: auto auto; width: 860px; text-align: center;
        margin-bottom: 30px; ">
        <ul class="modules" id="modules">
            <li class="m" id="liProCollection" link="../Client/CommonProCollection.aspx" title="数据采集"><p class="btnIcon dataCollection"></p><p>数据采集</p></li>
            <li class="m" id="SYS_SystemInfo" link="home.aspx?module=SYS_SystemInfo&modulename=系统管理" title="系统管理"><p class="btnIcon noaccess"></p><p>系统管理</p></li>
            <li class="m" id="LeanMES_BasalInfo" link="home.aspx?module=LeanMES_BasalInfo&modulename=基础数据" title="基础数据"><p class="btnIcon noaccess"></p><p>基础数据</p></li>
            <li class="m" id="LeanMES_Production" link="home.aspx?module=LeanMES_Production&modulename=生产管理" title="生产管理"><p class="btnIcon noaccess"></p><p>生产管理</p></li>
            <li class="m" id="LeanMES_Store" link="home.aspx?module=LeanMES_Store&modulename=仓库管理" title="仓库管理"><p class="btnIcon noaccess"></p><p>仓库管理</p></li>
            <li class="m" id="LeanMES_Quality" link="home.aspx?module=LeanMES_Quality&modulename=品质管理" title="品质管理"><p class="btnIcon noaccess"></p><p>品质管理</p></li>
            <li class="m" id="LeanMES_Equipment" link="home.aspx?module=LeanMES_Equipment&modulename=设备管理" title="设备管理"><p class="btnIcon noaccess"></p><p>设备管理</p></li>
            <li class="m" id="LeanMES_Report" link="home.aspx?module=LeanMES_Report&modulename=BI中心" title="BI中心"><p class="btnIcon noaccess"></p><p>BI中心</p></li>
            <li class="m" id="LeanMES_Kanban" link="home.aspx?module=LeanMES_Kanban&modulename=看板管理" title="看板管理"><p class="btnIcon noaccess"></p><p>看板管理</p></li>
        </ul>
        
    </div>
    <div style="clear: both; height: 20px;">
    </div>
    <!--底部-->
    <div style="position: fixed; bottom: 0px; right: 0px; color: #333; background: #d3d3d3;
        height: 30px; width: 100%; text-align: right; line-height: 30px; padding-right: 50px;">
        Copyright &copy;
        <%=DateTime.Now.Year.ToString() %>&nbsp;&nbsp;
        <%=Resources.Common.CopyRight %></div>
        <input type="hidden" runat="server" id="hdnUserId" value="0"/>
    </form>
    <script type="text/javascript">
        var _close = "<%=Resources.Common.Close %>",
            _resizewin = "<%=Resources.lang.ResizeWin %>",
            _dialogwin = "<%=Resources.lang.PopWin %>",
            _help = "<%=Resources.Common.Help %>",
            _dataLoading = "<%=Resources.Messages.DataLoading %>",
            _closeCurrentTab = "<%=Resources.lang.CloseCurrentTab %>",
            _closeOtherTab = "<%=Resources.lang.CloseOtherTab %>",
            _closeAllTab = "<%=Resources.lang.CloseAllTab %>",
            _refreshTab = "<%=Resources.lang.RefreshTab %>";
        
        var checkPasswordMessage = "<%=checkPasswordMessage%>";

        var classArr = ["dataCollection", "systemInfo", "basalInfo", "production", "wms", "quality", "equipment", "biCenter", "kanban"];
        var idArr = ["liProCollection", "SYS_SystemInfo", "LeanMES_BasalInfo", "LeanMES_Production", "LeanMES_Store", "LeanMES_Quality", "LeanMES_Equipment", "LeanMES_Report", "LeanMES_Kanban", "LeanMES_Collection"];
        $(function () {
            $("#modules li").click(function () {
                var url = $(this).attr("link");
                if ($(this).attr("id") == "liProCollection") {
                    url = getLoginLocation();
                    if (url == "") {
                        url = $(this).attr("link") + "?isPop=1";
                    }
                    else {
                        url = "../" + url + "&rnd=" + Math.random();
                    }
                }
                location.href = encodeURI(url);
            });
            /*
            var l = 0;
            if ($("#modules li").length >= 4)
            l = 4 * 200 + 60 + 100;
            else {
            l = $("#modules li").length * 200 + ($("#modules li").length - 1) * 20 + 100;
            }
            $("#modules").width(l);
            */
            $("#menu").hover(
            function () { $("#dlmenu").show(); $("li img", this).attr("src", "../Content/console/img/arrow_open.gif"); },
            function () { $("#dlmenu").hide(300); $("li img", this).attr("src", "../Content/console/img/arrow.gif") }
            );

            getModulesByUserId();

            if (checkPasswordMessage) {
                alert(checkPasswordMessage);
            }
        });

        function modifyPwd() {
            dialog({ title: "<%=Resources.Pages.UserChangePwd %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/User/UserChangePwd.aspx?name=Account_ChangePwd&ID=-1&rnd=" + Math.random(), width: 450, height: 300 });

        }

        function quit() {
            if (confirm("是否确定退出系统？")) {
                window.location = "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Logout.aspx";
            }
        }

        function help() {
            window.open("../Help/Help.htm");
        }

        function getLoginLocation() {
            //获取用户登录工序资源路径
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.GetUserLoginLocation();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return ajax.value.toString();
        }

        function getModulesByUserId() {
            var userId = $("#hdnUserId").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetPopedomByUserId(userId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var result=ajax.value.toLowerCase();
            for (var i = 0; i < idArr.length; i++) {
                if (result.indexOf(idArr[i].toLowerCase()) != -1) {
                    $("#" + idArr[i]).children("p:eq(0)").addClass(classArr[i]);
                    $("#" + idArr[i]).children("p:eq(0)").removeClass("noaccess");
                    
                }
            }
            $(".noaccess").parent().removeClass("m").removeAttr("link").unbind("click").attr("title","您没有权限使用此模块");
        }
    </script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/js/jPlugin-dialog-2.0.js"
        type="text/javascript"></script>
</body>
</html>
