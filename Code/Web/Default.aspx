<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SKT.LeanMES.Web.Default"
    EnableViewState="false" EnableViewStateMac="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <title>LEAN MES登录</title>
    <link href="Content/login/login.css" rel="stylesheet" type="text/css" />
    <script src="Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="Content/js/skt.utility.checkmobile.js" type="text/javascript"></script>
    <script type="text/javascript">
        checkMobile();

        function checkMobile() {
            if (isMobile.any()) {
                location.href = "MobileApp/Login.aspx";
            }
        }
    </script>
</head>
<body>
    <form runat="server" id="userLogin">
    <div class="wrap-bg-l-b">
    </div>
    <div class="wrap-bg-l-m">
    </div>
    <div class="wrap">
        <!--logo-->
        <div class="wrap-logo">
        </div>
        <!--做中国最好的MES产品-->
        <div class="wrap-title">
        </div>
        <!--登录-->
        <div class="wrap-login">
            <div class="wrap-login-lang" id="wrap-login-lang">
                <div style="width: 85px; cursor: pointer; position: relative;" id="ddlLang">
                    <input type="text" id="langtext" style="background: url(Content/login/img/lang.gif) no-repeat;
                        width: 75px; height: 19px; padding: 3px 5px; line-height: 19px; font-family: Verdana, 微软雅黑,黑体, 宋体;"
                        value="简体中文" data-value="zh-cn" readonly="readonly" />
                    <img src="Content/login/img/arrow_down.png" style="margin-top: -25px; margin-left: 60px;
                        cursor: pointer;" />
                    <ul id="lang" style="position: absolute; border: 1px solid #d3d3d3; width: 83px;
                        left: 0px; top: 24px; background-color: #fff;">
                        <li data-value="zh-cn">简体中文</li>
                        <li data-value="en-us">英文</li>
                    </ul>
                </div>
            </div>
            <div class="wrap-login-version" id="leanmes-version">
            </div>
            <div class="wrap-login-info" id="login-info">
            </div>
            <!--用户名和密码-->
            <div class="wrap-login-form">
                <p id="multiplantwrap">
                    <label for="Text1">
                        工厂:</label>
                    <select id="multiplan" style="width: 280px; height: 40px; background: url(Content/login/img/textbox.gif);
                        padding: 10px 5px; cursor: " disabled="disabled">
                        <option>数据加载中...</option>
                    </select>
                </p>
                <p>
                    <label for="userName">
                        用户名:</label><input type="text" id="userName" value="admin" class="placehold" />
                </p>
                <p>
                    <label for="pwd">
                        密码:</label><input type="password" id="pwd" value="sktmes" />
                </p>
                <p style="font-size: 14px; text-align: right;">
                    <label class="ckbrmb" id="ckbrmb">
                        记住我</label>
                </p>
                <div style="text-align: right; margin-top: 25px;">
                    <div class="loginbtn" id="loginbtn">
                        登 录</div>
                </div>
                <div id="qrcode" style=" margin-top:-30px; cursor:pointer;" title="扫描二维码登录PDA客户端或点击进入APP">
                </div>
            </div>
        </div>
        <!--版权-->
        <div class="wrap-copyright">
            Copyright &copy;
            <%=DateTime.Now.Year.ToString() %>
            <%=Resources.Common.CopyRight %>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hdnLang" Value="zh-cn" />
    <asp:HiddenField runat="server" ID="hdnUserName" Value="" />
    <asp:HiddenField runat="server" ID="hdnIsRmb" Value="0" />
    <asp:HiddenField runat="server" ID="hdnVersion" Value="" />
    <asp:HiddenField runat="server" ID="hdnCurrentSite" Value="" />
    </form>
    <script src="Content/js/skt.utility.qrcode.js" type="text/javascript"></script>
    <script type="text/javascript">
        var isMultiplant = false;
        $(function () {
            var ver = getSercerCtlVal("<%=this.hdnVersion.ClientID %>", true);
            var lang = getSercerCtlVal("<%=this.hdnLang.ClientID %>", true);
            var isRmb = getSercerCtlVal("<%=this.hdnIsRmb.ClientID %>", true);
            var userName = getSercerCtlVal("<%=this.hdnUserName.ClientID %>", true);
            /*当前版本*/
            $("#leanmes-version").html(ver);
            /*当前语言*/
            setLang(lang);
            /*记住我*/
            setRmb(isRmb, userName);

            $("#ckbrmb").click(function () {
                $(this).toggleClass("checked");
            });

            if ($.trim($("#userName").val()) == "" || $.trim($("#userName").val()) == "请输入用户名") {
                $("#userName").val("请输入用户名");
                $("#userName").addClass("placehold")
            }
            else {
                $("#userName").removeClass("placehold")
            }

            $("#userName").blur(function () {
                if ($.trim($(this).val()) == "" || $.trim($(this).val()) == "请输入用户名") {
                    $(this).val("请输入用户名");
                    $(this).addClass("placehold")
                }
                else {
                    $(this).removeClass("placehold")
                }
            });
            $("#userName").focus(function () {
                if ($.trim($(this).val()) == "" || $.trim($(this).val()) == "请输入用户名") {
                    $(this).val("");
                    $(this).removeClass("placehold")
                }
            });
            $("#loginbtn").click(function () {
                login();
            });
            var t;
            $("#ddlLang").click(function () {
                clearTimeout(t);
                $("#lang").toggle();
            });
            $("#lang li").click(function () {
                setLang($(this).attr("data-value"), $(this).html())
            });
            $("#lang").mouseout(function () {
                if ($("#lang").css("display") != "none") {
                    t = setTimeout(function () {
                        $("#lang").hide();
                    }, 5000);
                }
            });
            /*回车登录*/
            $(document).keypress(function () {
                var event = arguments.callee.caller.arguments[0] || window.event;
                if (event.keyCode == 13) {
                    login();
                }
            });

            /*点击二维码进入APP*/
            $("#qrcode").click(function () {
                var a = document.createElement("a");
                a.href = $("#qrcode").attr("link");
                a.target = "_blank";
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            });
        });

        function setLoginInfo(_msg) {
            $("#login-info").html(_msg);
        }

        function clearLoginInfo() {
            $("#login-info").html("");
        }

        function setLang(_lang) {
            var _text = "英文";
            if (_lang.toLowerCase() == "zh-cn") {
                _text = "简体中文";
            }
            $("#langtext").val(_text);
            $("#langtext").attr("data-value", _lang);
        }

        function setRmb(_m, _username) {
            if (parseInt(_m, 10) == 1) {
                $("#ckbrmb").addClass("checked");
                $("#userName").val(_username);
            }
        }

        function getSercerCtlVal(_ctlId, _needTrim) {
            if (_needTrim) {
                return $.trim($("#" + _ctlId).val());
            }
            else {
                return $("#" + _ctlId).val();
            }
        }

        function login() {
            var username = $.trim($("#userName").val());
            var pwd = $.trim($("#pwd").val());
            if (username == "" || username == "请输入用户名") {
                setLoginInfo("请输入用户名。");
                $("#userName").focus();
                return false;
            }
            if (pwd == "") {
                setLoginInfo("请输入密码。");
                $("#pwd").focus();
                return false;
            }
            doLogin(username, pwd);
        }

        function doLogin(username, pwd) {
            var rmbMe = $("#ckbrmb").attr("class");
            if (rmbMe.indexOf("checked") != -1) {
                rmbMe = 1;
            }
            else {
                rmbMe = 0;
            }
            var _multiplant = (isMultiplant) ? $("#multiplan").val() : "";
            var _site = (isMultiplant) ? $("#multiplan").find("option:checked").text() : "";

            $.ajax({
                type: 'post',
                url: "Handler/MobileAppLogin.ashx?Action=Login&rnd=" + Math.random(),
                async: true,
                data: { UserName: username, Pwd1: pwd, lang: $("#langtext").attr("data-value"), rmb: rmbMe, multiplant: _multiplant, site: _site },
                beforeSend: function () {
                    setLoginInfo('<img src="Content/images/gif/loading.gif" style="vertical-align:middle;"/><span style=" vertical-align:middle; margin-left:5px;">正在登录，请稍后...</span>');
                    $("#loginbtn").html('正在登录...');
                    $("#loginbtn").addClass("logining");
                },
                success: function (data) {
                    var errMsg = "";
                    if (data == "") {
                        location.href = "Framework/Console.aspx";
                    }
                    else {
                        if (data.indexOf("expiredBox") != -1) {
                            errMsg = $(".expiredBox table tr:eq(0) td:eq(1)", data).html().replace(new RegExp(/<br>/g), "\n").replace(new RegExp(/ /g), "");
                            setLoginInfo(errMsg);
                        }
                        else if (data.indexOf("licenseInvalide") != -1) {
                            errMsg = $("#licenseInvalide", data).html();
                            setLoginInfo(errMsg);
                        }
                        else {
                            setLoginInfo(data);
                        }
                    }
                },
                complete: function (XMLHttpRequest, str) {
                    $("#loginbtn").html("登录");
                    $("#loginbtn").removeClass("logining");
                },
                datatype: 'text',
                error: function (xhr, status, error) {
                    if (error.indexOf("expiredBox") != -1) {
                        var errMsg = $(".expiredBox table tr:eq(0) td:eq(1)", error).html().replace(new RegExp(/<br>/g), "\n").replace(new RegExp(/ /g), "");
                        setLoginInfo(errMsg);
                    }
                    else if (error.indexOf("licenseInvalide") != -1) {
                        errMsg = $("#licenseInvalide", error).html();
                        setLoginInfo(errMsg);
                    }
                    else {
                        setLoginInfo(error)
                    }
                }
            });
        };
        $(function () {
            $("#qrcode").qrcode({
                render: "table",
                width: 85,
                height: 85,
                text: "http://" + window.location.host + "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/MobileApp/Login.aspx"
            });

            $("#qrcode").attr("link", "http://" + window.location.host + "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/MobileApp/Login.aspx");

            getDBLinks();
        });

        function getDBLinks() {
            $.ajax({
                type: 'post',
                url: "Handler/Multiplant.ashx?action=GetMultiDbLinks&rnd=" + Math.random(),
                async: true,
                success: function (data, status) {
                    if (status == "success") {
                        if (data != "") {
                            $("#multiplan").removeAttr("disabled");
                            isMultiplant = true;
                            var jsonData = eval('(' + data + ')');
                            var sites = "";
                            for (var i = 0, j = jsonData.dblinks.length; i < j; i++) {
                                sites += "<option value='" + jsonData.dblinks[i].id + "'>" + jsonData.dblinks[i].site + "</option>";
                            }
                            $("#multiplan").html(sites);
                            var currentSite = $("#<%=this.hdnCurrentSite.ClientID %>").val();
                            if (currentSite != "") {
                                $("#multiplan").val(currentSite);
                            }
                            if (jsonData.dblinks.length == 1) {
                                $("#multiplan").attr("disabled", "disabled");
                            }
                        }
                        else {
                            $("#multiplantwrap").hide();
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>
