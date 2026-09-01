<%@ Page Language="C#" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.Framework.Home"
    ViewStateMode="Disabled" CodeBehind="Home.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
    <title>
        <%= Resources.Common.AppName %></title>
    <link href="../Content/theme/Metro/Metro-core.css" rel="stylesheet" type="text/css" />
    <link href="../Content/Main.css" rel="stylesheet" type="text/css" />
    <link href="../Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet"
        type="text/css" />
    <!--[if(gte IE 9)]><!-->
    <link href="../Content/ie9.css" rel="stylesheet" type="text/css" />
    <!--<![endif]-->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        window.onbeforeunload = function () {
            try {
                AccountController.Logout();
            }
            catch (e) { }
        };

        var wHeight = 500, isCollapse = false, isSlideDown = false, multipwin = true, _leftMenuWidth = "198px";

        var text_CollapsAll = "<%=Resources.lang.CollapsAll %>",
            text_ExpandAll = "<%=Resources.lang.ExpandAll %>",
            text_ShowLeftMenu = "<%=Resources.lang.ShowLeftMenu %>",
            text_HideLeftMenu = "<%=Resources.lang.HideLeftMenu %>",
            text_DefautTabNotAllowDelete = "<%=Resources.Messages.DefautTabNotAllowDelete %>",
            text_ComfirmToQuit = "<%=Resources.Messages.ComfirmToQuit %>",
            _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>",
            _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            _close = "<%=Resources.Common.Close %>",
            _resizewin = "<%=Resources.lang.ResizeWin %>",
            _dialogwin = "<%=Resources.lang.PopWin %>",
            _help = "<%=Resources.Common.Help %>",
            _dataLoading = "<%=Resources.Messages.DataLoading %>",
            _closeCurrentTab = "<%=Resources.lang.CloseCurrentTab %>",
            _closeOtherTab = "<%=Resources.lang.CloseOtherTab %>",
            _closeAllTab = "<%=Resources.lang.CloseAllTab %>",
            _refreshTab = "<%=Resources.lang.RefreshTab %>",
            userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
    </script>
    <style type="text/css">
        .custoemrInfo {
            position: absolute;
            left: 10px;
            top: 0px;
            line-height: 20px;
            font-size: 11px;
            color: #000000;
            font-family: 微软雅黑,宋体;
            overflow: hidden;
        }

        .floatleft {
            float: left;
            font-size: 11px;
            color: #000000;
            font-family: 微软雅黑,宋体;
        }

        .copyright {
            margin-left: auto;
            margin-right: auto;
            margin-top: 0px;
            line-height: 14px;
            height: 30px;
            font-size: 11px;
            color: #000000;
            font-family: 微软雅黑,宋体;
            overflow: hidden;
        }

        .operator {
            position: absolute;
            right: 10px;
            top: 0px;
            line-height: 20px;
            font-size: 11px;
            color: #000000;
            font-family: 微软雅黑,宋体;
            overflow: hidden;
        }
    </style>
</head>
<body style="margin: 0px; padding: 0px; background: #faf9f9; min-width: 1024px;">
    <form id="form1" runat="server">
        <asp:HiddenField ID="hfMESLang" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnCsrfToken" runat="server" />
        <input type="hidden" id="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" name ="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" value="<%=hdnCsrfToken.Value %>" />
        <div class="shadowdiv" id="shadowdiv">
        </div>
        <!--top begin-->
        <div id="header" class="topnav">
            <!--Logo begin-->
            <div class="logo">
                <img src="../Content/login/login2/logo.png"
                    title="" alt="" />
            </div>
            <div id="favorityLink" class="favorityLink">
                <!--user info begin-->
                <div id="gohome" class="tpbtn" onclick="GoHome();" title="<%=Resources.lang.ControlPanel %>">
                    <div>
                        <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/homepage.png"
                            alt="<%=Resources.lang.ControlPanel %>" />
                    </div>
                    <div>
                        <%=Resources.lang.ControlPanel %>
                    </div>
                </div>
                <div id="refresh" class="tpbtn" onclick="Refresh();" title="<%=Resources.lang.RefreshPage %>">
                    <div>
                        <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/refresh.png"
                            alt="<%=Resources.lang.RefreshPage %>" />
                    </div>
                    <div>
                        <%=Resources.lang.RefreshPage %>
                    </div>
                </div>
                <%if (SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType == -1
                              || SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId, 10100110))
                    { %>
                <div id="chpwd" class="tpbtn" onclick="ChangePwd();" title="<%=Resources.lang.ChangePwd %>">
                    <div>
                        <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/popedom.png"
                            alt="<%=Resources.lang.ChangePwd %>" />
                    </div>
                    <div>
                        <%=Resources.lang.ChangePwd%>
                    </div>
                </div>
                <%} %>
                <div id="lgout" class="tpbtn" onclick="Logout();" title="<%=Resources.lang.CommonExit %>">
                    <div>
                        <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/lgout.png"
                            alt="<%=Resources.lang.CommonExit %>" />
                    </div>
                    <div>
                        <%=Resources.lang.CommonExit %>
                    </div>
                </div>
                <%--<div id="hlp" class="tpbtn" onclick="Help();" title="<%=Resources.lang.HelpDoc %>">
                    <div>
                        <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/help.png" alt="<%=Resources.lang.HelpDoc %>" />
                    </div>
                    <div>
                        <%=Resources.lang.HelpDoc %>
                    </div>
                </div>--%>
                <div id="customerLogoContainer" style="float: left; margin-top: -5px; margin-right: -5px; width: 200px; height: 45px; display: none;">
                </div>
                <div class="clearAll">
                </div>
            </div>
            <!--top menu begin-->
            <div id="topmenu">
                <asp:Localize ID="llTopMenu" runat="server"></asp:Localize>
            </div>
            <div class="line">
            </div>
        </div>
        <div class="clearAll">
        </div>
        <!--content begin-->
        <table cellpadding="0" align="left" cellspacing="0" border="0" width="100%">
            <tr>
                <td valign="top" width="198px" align="left">
                    <!--left menu begin-->
                    <div class="leftmenu-new" id="leftmenu-new">
                        <div class="leftmenu-new-header" id="leftmenu-new-header">
                            <div class="leftmneu-header-icon">
                            </div>
                            <div class="leftmneu-header-text">
                                <asp:Label ID="lbTopMenuHeader" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div class="leftmenu-new-content" id="leftmenu-new-content">
                            <asp:Localize ID="llLeftMenu" runat="server"></asp:Localize>
                        </div>
                    </div>
                </td>
                <!--shrink begin-->
                <td align="center" valign="middle" width="7px" class="slidertd">
                    <div id="slider">
                        <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/images/mini-left.gif"
                            alt="<%=Resources.lang.HideLeftMenu %>" title="<%=Resources.lang.HideLeftMenu %>" />
                    </div>
                </td>
                <!--main content begin-->
                <td valign="top">
                    <div id="content">
                        <!--tabs begin-->
                        <div class="tabs-container">
                            <div id="tabs_list">
                                <div class="vleft-bg">
                                    <div id="vleft">
                                    </div>
                                </div>
                                <div class="tabs" id="tabs">
                                    <div id="tab-1" class="tabs-selected">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td class="tab-left-selected"></td>
                                                <td class="tab-body-selected" onclick="selecteTab(this)">
                                                    <span class="tabs-text" id="tabshome">
                                                        <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/home.png" alt=""
                                                            style="float: left;" /><%=Resources.lang.UserInfoCenter%></span>
                                                </td>
                                                <td class="tab-right-selected"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="vright-bg">
                                    <div id="vright">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clear">
                        </div>
                        <div id="framecenter">
                            <!--tabs content begin-->
                            <div class="tabs-items" id="tabs-items">
                                <div id="tab1" class="tabs-items-selected">
                                    <iframe width="100%" frameborder="0" scrolling="auto" class="ifmcenter" id="ifmcenter"
                                        height="500" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/MsgCenter.aspx"></iframe>
                                </div>
                            </div>
                        </div>
                        <div class="clearAll">
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <div class="clear">
        </div>
        <!--foot begin-->
        <div id="foot">
            <div class="custoemrInfo">
                <div class="floatleft">
                     <asp:Label runat="server" ID="lblAppVersionName"></asp:Label>
                   <%-- <%=Resources.Common.CustomerName %>--%>
                </div>
                <div class="btn-line">
                </div>
                <div class="floatleft">
                    <asp:Label runat="server" ID="lblAppVersion"></asp:Label>
                </div>
                <div class="btn-line">
                </div>
                <div class="floatleft" id="OrgZt">
                    账套 : <span id="OrgDepartName"></span>
                </div>
                <div class="btn-line" id="OrgZtLine">
                </div>
            </div>
            <div class="copyright">
                Copyright &copy;
            <%=DateTime.Now.Year.ToString() %>&nbsp;&nbsp;
            <%=Resources.Common.CopyRight %>
            </div>
            <div class="operator" style="background-color: #faf9f9">
                <div id="licenseDisplayText" class="floatleft"></div>
                <div class="btn-line"></div>
                <div id="onlineUserDisplayText" class="floatleft"></div>
                <div class="btn-line"></div>
                <div class="floatleft">
                    <%=Resources.lang.CurrentUser%>
                -
                <%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>
                </div>
                <% if (Request.Cookies["DBLink"] != null)
                    {%>
                <div class="btn-line">
                </div>
                <div class="floatleft" style="color: blue;">
                    工厂：
                <%=Request.Cookies["DBLink"]["site"] %>
                </div>
                <%} %>
            </div>
        </div>
        <asp:HiddenField ID="hdnCustomerLogoPath" Value="" runat="server" />
    </form>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.frame.core.js?v=20220106"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.contextmenu.min.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-ui.min.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/js/jPlugin-dialog-2.0.js"
        type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var _enlarged;
        $(document).ready(function () {
            showShadow(false);
            if (window.localStorage.getItem("OrganizationName")) {
                $("#OrgDepartName").html(window.localStorage.getItem("OrganizationName"));
            } else {
                $("#OrgZt").hide();
                $("#OrgZtLine").hide();
            }
            var module = '<%=Request.QueryString["module"] %>';
            var modulename = '<%=Request.QueryString["modulename"] %>';
            /*if (userId != -1) {
            //    if (module != null && module != "") {
                    
            //        $("#topmenu ul li").not(".iselected").hide();
            //    }
            //}*/
            showTest("#sub-" + module, module, modulename);
            /*Add By Alen 2017-11-21 客户logo设置*/
            if ($("#<%=this.hdnCustomerLogoPath.ClientID%>").val() != "") {
                $("#customerLogoContainer").show();
                $("#customerLogoContainer").html("<img src='" + $("#<%=this.hdnCustomerLogoPath.ClientID%>").val() + "' width='200px' height='45px'/>");
            }

            /*多语初始化*/
            initPageLang();

            /*获取license信息*/
            getLicenseInfo();
            setInterval(function () {
                getLicenseInfo();
            }, 60 * 1000);
        });

        function showClickClass(obj, menuId, menuName) {
            $(".iselected").removeClass("iselected");
            $(obj).addClass("iselected");
            $(".menugroup").hide();
            $("#leftmenu-new-content #menugroup" + menuId.toString()).show();
            $("#lbTopMenuHeader").text(menuName);
            selecteTab($("#tab-1 table tr td:eq(1)"));
        }

        function showTest(obj, menuId, menuName) {
            $(".iselected").removeClass("iselected");
            $(obj).addClass("iselected");
            $(".menugroup").hide();
            $("#leftmenu-new-content #menugroup" + menuId.toString()).show();
            $("#lbTopMenuHeader").text(menuName);
            selecteTab($("#tab-1 table tr td:eq(1)"));
            var currentLength = $("#" + menuId + " li").length;
            if (currentLength == 0) {
                $.ajaxSetup({ cache: false });
                $.ajax({
                    url: "../Handler/PopedomHandler.ashx?type=HomeModules",
                    data: { id: userId, name: menuId, menuName: menuName, OrganizationName: window.localStorage.getItem("OrganizationName") },
                    type: "GET",
                    dataType: "text",
                    contentType: "application/json;charset=utf-8",
                    success: function (result) {
                        var c = result;
                        $("#" + menuId + "").show();
                        $("#" + menuId + "").empty();
                        $("#" + menuId + "").append(c);
                        onLoadClick();
                        initMenuLang(menuId);
                    },
                    error: function (result) {
                        console.log(result, result.status + "：" + result.statusText);
                    }
                });
            }
        }

        function onLoadClick() {

            setContentHeight();
            setLeftMenuHeight();
            setFramecenterHeight();
            showLeftRightMove();


            /*show or hide left menu*/
            /*$("#slider").click(function () {
                showLeftMenu();
            });*/
            /*expand or close left menu item*/
            $(".leftmenu-group-item").click(function () {
               
                /*$(".leftmenu-group-item").parent().children("ul").slideUp();*/
                var menuId = $(this).parent().attr("id");
                var menuName = $(this).parent().parent().attr("id");
                var currentLength = $("#" + menuId + "S li").length;
                if (currentLength == 0) {
                    /*$.post("../Handler/PopedomHandler.ashx?type=ModulesPopedom", { id: userId, name: menuId, menuName: menuName }, function (result) {
                        var c = result;
                        $("#" + menuId + "S").show();
                        $("#" + menuId + "S").empty();
                        $("#" + menuId + "S").append(c);
                    });*/
                    $.ajax({
                        url: "../Handler/PopedomHandler.ashx?type=ModulesPopedom",
                        data: { id: userId, name: menuId, menuName: menuName, OrganizationName: window.localStorage.getItem("OrganizationName") },
                        type: "GET",
                        dataType: "text",
                        contentType: "application/json;charset=utf-8",
                        success: function (result) {                             
                            var c = result;
                            $("#" + menuId + "S").show();
                            $("#" + menuId + "S").empty();
                            $("#" + menuId + "S").append(c);
                            initMenuLang(menuId);
                        },
                        error: function (result) {
                            console.log(result,result.status + "：" + result.statusText);
                        }
                    });
                }
            });
        }

        function showPageList(obj, menuName, subSystem) {
            var ul = $(obj).children("ul");
            if (ul.attr("class") == null || ul.attr("class").indexOf("Expand") == -1) {
                $(".leftmenu-group-item").parent().children("ul").slideUp(300);
                $(".leftmenu-group-item").parent().children("ul").removeClass("Expand");
                ul.stop(false, true).slideDown(300);
                ul.addClass("Expand");
                $(".leftmenu-group-item-toggle-selected").removeClass("leftmenu-group-item-toggle-selected");
                $(obj).children(".leftmenu-group-item").children(".leftmenu-group-item-toggle").addClass("leftmenu-group-item-toggle-selected");
            }
            else {
                ul.stop(false, true).slideUp(300);
                ul.removeClass("Expand");
                $(".leftmenu-group-item-toggle-selected").removeClass("leftmenu-group-item-toggle-selected");
            }
        }

        /*logout*/
        function Logout() {
            if (confirm(text_ComfirmToQuit)) {
                window.location = "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Logout.aspx";
            }
        }

        function ChangePwd() {
            dialog({ title: "<%=Resources.Pages.CurrentUserChangePwd %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/User/CurrentUserChangePwd.aspx?name=Account_CurrentUserChangePwd&rnd=" + Math.random(), width: 450, height: 300 });
        }

        function GoHome() {
            location.href = "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/Console.aspx";
        }

        function Help() {
            window.open("../Help/Help.htm");
        }

        function Refresh() {
            $("#framecenter .tabs-items-selected iframe").prev().show();
            $("#framecenter .tabs-items-selected iframe").bind("load", function () {
                $(this).prev().hide();
            });
            $("#framecenter .tabs-items-selected iframe").attr("src", $("#framecenter .tabs-items-selected iframe").attr("src"));
        }

        function getLicenseInfo() {
            $.ajax({
                type: 'get',
                url: "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Account.ashx?type=getLicenseInfo&userid=" + userId + "&rnd=" + Math.random(),
                datatype: 'text',
                success: function (data) {
                    var licenseInfo = JSON.parse(data);
                    if (licenseInfo) {
                        if (licenseInfo.LicenseType == 0) {
                            $("#licenseDisplayText").text("License授权:" + licenseInfo.LineQty + "条产线用户数不限");
                        }
                        else if (licenseInfo.LicenseType == 1) {
                            $("#licenseDisplayText").text("License授权:并发用户数" + licenseInfo.UserQty);
                        }
                        else if (licenseInfo.LicenseType == 2) {
                            $("#licenseDisplayText").text("License授权:服务器授权");
                        }
                        $("#onlineUserDisplayText").text("在线用户" + licenseInfo.OnlineUserQty + "人");
                    }
                }
            });
        }

    </script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.ajaxpll.js"></script>

    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Language.ashx?cmd=GetLanguageRes&lang=<%=hfMESLang.Value %>" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/lang/skt.utility.lang.js" type="text/javascript"></script>
</body>
</html>
