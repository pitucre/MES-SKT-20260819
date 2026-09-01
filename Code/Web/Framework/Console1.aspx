<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Console1.aspx.cs" Inherits="SKT.LeanMES.Web.Framework.Console1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
    <link href="../Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet"
        type="text/css" />
    <title>LEAN MES - 控制面板</title>
    <link href="../Content/console/console.css?v=BB4890C8-9117-434D-831A-4BD169C32852" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/umeditor1_2_2/third-party/jquery.min.js" type="text/javascript"></script>

    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Language.ashx?cmd=GetLanguageRes&lang=<%=hfMESLang.Value %>" type="text/javascript"></script>
    <script src="../Content/js/lang/skt.utility.lang.js" type="text/javascript"></script>
    <script src="../Content/js/jsencrypt.js?v=20210913"></script>
    <style type="text/css">
        .dlg-nc > .nebutton > .close {
            width: 46px;
            height: 19px;
            cursor: pointer;
            position: absolute;
            top: -1px;
            right: 0px;
            background-position: -14px 0;
        }
    </style>
    <script type="text/javascript">
        var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hfMESLang" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnCsrfToken" runat="server" />
        <input type="hidden" id="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" name="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" value="<%=hdnCsrfToken.Value %>" />
        <div class="shadowdiv" id="shadowdiv">
        </div>
        <!--顶部-->
        <div style="background: #faf9f9; border-bottom: 1px solid #cccccc; height: 50px; padding: 0px; margin: 0px; width: 100%;">
            <div style="position: relative; margin: auto auto;">
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
                    <div style="float: left; height: 30px; padding: 10px; line-height: 30px;">
                        <asp:Localize ID="setupLine" runat="server"></asp:Localize>
                    </div>
                    <ul class="menu" style="margin-left: -5px;">
                        <li style="position: relative;" id="menu"><span>设置</span><img src="../Content/login/login2/drp.png" style="margin-left: 5px;" />
                            <ul class="dlmenu" id="dlmenu">
                                <li onclick="modifyPwd()"><span>修改密码</span></li>
                                <li onclick="quit()"><span>退出</span></li>
                                <li onclick="versionList()"><span>版本记录</span></li>
                                <li onclick="help()"><span>帮助</span></li>
                            </ul>
                        </li>
                    </ul>
                    <!--客户logo-->
                    <div id="customerLogoContainer" style="float: right; margin-top: 2px; margin-right: 2px; width: 200px; height: 45px; display: none;">
                    </div>
                </div>
            </div>
        </div>
        <!--控制面板-->
        <style>
            .module-list {
            }

                .module-list div {
                }

            #datacollection {
                width: 406px;
                height: 354px;
                float: left;
                background: url(../Content/console/2.0/datacollection.jpg);
                display: block;
                border: none;
            }

                #datacollection:hover {
                    width: 406px;
                    height: 354px;
                    float: left;
                    background: url(../Content/console/2.0/datacollection_active.png?bdf);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            #system {
                width: 243px;
                height: 184px;
                float: left;
                background: url(../Content/console/2.0/system.jpg);
                display: block;
                border: none;
            }

                #system:hover {
                    width: 243px;
                    height: 184px;
                    float: left;
                    background: url(../Content/console/2.0/system_active.png);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            #basedata {
                width: 253px;
                height: 184px;
                float: left;
                background: url(../Content/console/2.0/basedata.png);
                display: block;
                border: none;
            }

                #basedata:hover {
                    width: 253px;
                    height: 184px;
                    float: left;
                    background: url(../Content/console/2.0/basedata_active.png);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            #quality {
                width: 243px;
                height: 170px;
                float: left;
                background: url(../Content/console/2.0/quality.jpg);
                display: block;
                border: none;
            }

                #quality:hover {
                    width: 243px;
                    height: 170px;
                    float: left;
                    background: url(../Content/console/2.0/quality_active.png);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            #equement {
                width: 253px;
                height: 170px;
                float: left;
                background: url(../Content/console/2.0/equement.jpg);
                display: block;
                border: none;
            }

                #equement:hover {
                    width: 253px;
                    height: 170px;
                    float: left;
                    background: url(../Content/console/2.0/equement_active.png);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            #prod {
                width: 209px;
                height: 175px;
                float: left;
                background: url(../Content/console/2.0/prod.jpg);
                display: block;
                border: none;
            }

                #prod:hover {
                    width: 209px;
                    height: 175px;
                    float: left;
                    background: url(../Content/console/2.0/prod_active.png);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            #wms {
                width: 197px;
                height: 175px;
                float: left;
                background: url(../Content/console/2.0/wms.jpg);
                display: block;
                border: none;
            }

                #wms:hover {
                    width: 197px;
                    height: 175px;
                    float: left;
                    background: url(../Content/console/2.0/wms_active.png);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            #kanban {
                width: 243px;
                height: 175px;
                float: left;
                background: url(../Content/console/2.0/kanban.jpg);
                display: block;
                border: none;
            }

                #kanban:hover {
                    width: 243px;
                    height: 175px;
                    float: left;
                    background: url(../Content/console/2.0/kanban_active.png);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            #report {
                width: 253px;
                height: 175px;
                float: left;
                background: url(../Content/console/2.0/report.jpg);
                display: block;
                border: none;
            }

                #report:hover {
                    width: 253px;
                    height: 175px;
                    float: left;
                    background: url(../Content/console/2.0/report_active.png);
                    display: block;
                    border: none;
                    color: #ffffff;
                }

            .module-list a:hover {
                cursor: pointer;
            }
        </style>
        <!--模块列表-->
        <div style="margin: auto auto; margin-top: 20px; width: 960px; text-align: center;" class="module-list" id="module_list">
            <!--数据采集-->
            <a id="datacollection" data="liProCollection" pe="LeanMES_Collection" link="../Client/CommonProCollection.aspx" title="数据采集">
                <div style="margin-top: 200px; font-size: 16px;" class="mesLang">数据采集</div>
            </a>
            <!--系统管理-->
            <a id="system" data="SYS_SystemInfo" link="home.aspx?module=SYS_SystemInfo&modulename=系统管理" title="系统管理">
                <div style="margin-top: 115px; font-size: 16px;" class="mesLang">系统管理</div>
            </a>
            <!--基础数据-->
            <a id="basedata" data="LeanMES_BasalInfo" link="home.aspx?module=LeanMES_BasalInfo&modulename=基础数据" title="基础数据">
                <div style="margin-top: 115px; font-size: 16px;" class="mesLang">基础数据</div>
            </a>
            <!--品质管理-->
            <a id="quality" data="LeanMES_Quality" link="home.aspx?module=LeanMES_Quality&modulename=品质管理" title="品质管理">
                <div style="margin-top: 105px; font-size: 16px;" class="mesLang">品质管理</div>
            </a>
            <!--设备管理-->
            <a id="equement" data="LeanMES_Equipment" link="home.aspx?module=LeanMES_Equipment&modulename=设备管理" title="设备管理">
                <div style="margin-top: 105px; font-size: 16px;" class="mesLang">设备管理</div>
            </a>
            <!--生产管理-->
            <a id="prod" data="LeanMES_Production" link="home.aspx?module=LeanMES_Production&modulename=生产管理" title="生产管理">
                <div style="margin-top: 105px; padding-left: 15px; font-size: 16px;" class="mesLang">生产管理</div>
            </a>
            <!--仓库管理-->
            <a id="wms" data="LeanMES_Store" link="home.aspx?module=LeanMES_Store&modulename=仓库管理" title="仓库管理">
                <div style="margin-top: 105px; font-size: 16px;" class="mesLang">仓库管理</div>
            </a>
            <!--看板管理-->
            <a id="kanban" data="LeanMES_Kanban" link="home.aspx?module=LeanMES_Kanban&modulename=看板管理" title="看板管理">
                <div style="margin-top: 105px; font-size: 16px;" class="mesLang">看板管理</div>
            </a>
            <!--BI中心-->
            <a id="report" data="LeanMES_Report" link="home.aspx?module=LeanMES_Report&modulename=BI中心" title="BI中心">
                <div style="margin-top: 105px; font-size: 16px;" class="mesLang">BI中心</div>
            </a>
        </div>

        <div style="clear: both; height: 10px;">
        </div>
        <!--底部-->
        <div style="color: #333; height: 30px; text-align: center; line-height: 30px;">
            Copyright &copy;
        <%=DateTime.Now.Year.ToString() %>
            <span>深圳市深科特信息技术有限公司 版权所有</span>
        </div>
        <input type="hidden" runat="server" id="hdnUserId" value="0" />
        <asp:HiddenField ID="hdnCustomerLogoPath" Value="" runat="server" />
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
        var __USER_ACCESS_MODULES = "";
        var checkPasswordMessage = "<%=checkPasswordMessage%>";
        var _enlarged;

        getModulesByUserId();
        $(function () {
            $("#menu").hover(
                function () { $("#dlmenu").show(); $("li img", this).attr("src", "../Content/console/img/arrow_open.gif"); },
                function () { $("#dlmenu").hide(300); $("li img", this).attr("src", "../Content/login/login2/drp.png") }
            );

            $("#module_list a").click(function () {
                var url = $(this).attr("link");
                if ($(this).attr("id") == "datacollection") {
                    if (__USER_ACCESS_MODULES.indexOf($(this).attr("pe").toLocaleLowerCase()) == -1) {
                        alert("对不起，您没有权限进入此子系统！");
                        return false;
                    }
                    url = getLoginLocation();
                    if (url == "") {
                        url = $(this).attr("link") + "?isPop=1";
                    }
                    else {
                        url = "../" + url + "&rnd=" + Math.random();
                    }
                }
                else {
                    if (__USER_ACCESS_MODULES.indexOf($(this).attr("data").toLocaleLowerCase()) == -1) {
                        alert("对不起，您没有权限进入此子系统！");
                        return false;
                    }
                }
                location.href = encodeURI(url);
            });

            /*多语初始化*/
            initPageLang();

            if (checkPasswordMessage) {
                if (confirm(checkPasswordMessage)) {
                    modifyPwd();
                }
            }
        });

        function modifyPwd() {
            dialog({ title: "<%=Resources.Pages.UserChangePwd %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/User/CurrentUserChangePwd.aspx?name=Account_ChangePwd&rnd=" + Math.random(), width: 450, height: 300 });
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
            /*获取用户登录工序资源路径*/
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
            __USER_ACCESS_MODULES = ajax.value.toLowerCase();
        }

        /*版本记录*/
        function versionList() {
            dialog({ title: "<%=Resources.Pages.VersionUpGrade %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/VersionUpGrade.aspx?name=Version_UpGrade&ID=-1&rnd=" + Math.random(), width: 800, height: 500 });
        }
    </script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/js/jPlugin-dialog-2.0.js"
        type="text/javascript"></script>
</body>
</html>
