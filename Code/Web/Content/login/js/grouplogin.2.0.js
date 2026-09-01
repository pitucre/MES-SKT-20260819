var isMultiplant = false;

$(document).ready(function () {
    resizeLoginWin();
    $(window).resize(function () {
        resizeLoginWin();
    });
    getOrganizations();
    $("#Organization").click(function () {
        $(this).css("border", "0px solid").css("color", "black").css("background-color", "rgb(232, 240, 254)");
    }).blur(function () {
        var ovalue = $(this).val();
        if (ovalue == "-1") {
            $(this).css("border", "1px solid #a2d7ff").css("color", "#e0e0e0").css("background-color", "white");
        } else {
            $(this).css("border", "0px solid").css("color", "black").css("background-color", "rgb(232, 240, 254)");
        }
    });
    
    $("#Organization").change(function () {
        var ovalue = $(this).val();
        if (ovalue == "-1") {
            return false;
        }
        location.href = $(this).find("option:selected").attr("data-url");
    });
    $("#hideorshow").click(function () {
        if ($(this).attr("src") == "Content/login/login2/hide.png") {
            $(this).attr("src", "Content/login/login2/show.png");
            $("#passwd")[0].type = "text";
        } else {
            $(this).attr("src", "Content/login/login2/hide.png");
            $("#passwd")[0].type = "password";
        }
    });
});

function resizeLoginWin() {
    ////var marginH = $(window).height() / 2 - 190;
    var marginH = $(window).height() / 2 - 200;
    $("#login_margin").css("height", marginH.toString() + "px");
}

$(function () {
    isPlaceholder();
    //$("#userName").focus();
    $("#Organization").focus();
    $(".checkbox-btn span").click(function () {
        $rmbme = $("#rmbme");
        $rmbme[0].checked = !$rmbme[0].checked;
    });

    $("#qrcode").qrcode({
        render: "table",
        width: 111,
        height: 111,
        text: "http://" + window.location.host + _webRoot + "/MobileApp/Login.aspx",
        typeNumber: -1,/*计算模式*/
        correctLevel: 2,/*二维码纠错级别*/
        background: "#ffffff",/*背景颜色*/
        foreground: "#333"  /*二维码颜色*/
    });

    $("#qrcode").attr("link", "http://" + window.location.host + _webRoot + "/MobileApp/Login.aspx");

    /*点击二维码进入APP*/
    $("#qrcode").click(function () {
        var a = document.createElement("a");
        a.href = $("#qrcode").attr("link");
        a.target = "_blank";
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    });

    /*多语言切换*/
    $("#multiple_language").click(function () {
        if ($(this).hasClass("zh-cn")) {
            $(this).attr("data", "en-us");
            $("#rmbme").parent().parent("div.input-group").css("width", "45%");
            $("#msg").css("width", "50%");
        } else {
            $(this).attr("data", "zh-cn");
        }
        _LANGUAGE = $(this).attr("data");
        setCookie("lang", _LANGUAGE);
        InitLang();
    });

    $("#multiple_language").attr("data", _LANGUAGE);
    InitLang();
});
function GetQueryString(name)
{
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)return unescape(r[2]); return null;
}

function InitLang() {
    if (_LANGUAGE === "zh-cn") {
        $("#multiple_language").addClass("zh-cn");
        $("#multiple_language").removeClass("en");
        $("#multiple_language").html("EN");


        $("#dvHeadLogin").html("智能制造一站式解决方案");
        $("#dvPdaLogIn").html("扫描二维码登录PDA客户端");
        $("#dvUserLogIn").html("用户登录");
        $("#spMemory").html("记住我");
        $("#IsStartADLogin").html("域账号");
        $("#loginbtn").text("登  录");
        $("#spVersions").text("产品版本:");
        $("#userName").attr("placeholder", "请输入帐号");
        $("#passwd").attr("placeholder", "请输入密码");
        $("#userName").attr("title", "请输入帐号");
        $("#passwd").attr("title", "请输入密码");
        $("#version_name").text(_VersionName);
        $("#Organization option:first").text("请选择账套");
    }
    else {

        $("#multiple_language").addClass("en");
        $("#multiple_language").removeClass("zh-cn");
        $("#multiple_language").html("中文");

        $("#dvHeadLogin").html("One-Stop Intelligent Solution");
        $("#dvPdaLogIn").html("Scan the QR Code with PDA to login");
        $("#dvUserLogIn").html("User Login");
        $("#spMemory").text("Remember Password");
        $("#IsStartADLogin").html("Domain account");
        $("#loginbtn").text("Login");
        $("#spVersions").text("Version:");
        $("#userName").attr("placeholder", "Enter account ID");
        $("#passwd").attr("placeholder", "Enter password");
        $("#userName").attr("title", "Enter account ID");
        $("#passwd").attr("title", "Enter password");
        $("#version_name").text("(Company Profile)");
        $("#Organization option:first").text("Please Select Account Set");
    }
}

if (!isPlaceholder()) {
    /*不支持placeholder 用jquery来完成*/
    $(document).ready(function () {
        if (!isPlaceholder()) {
            $("input").not("input[type='password']").each(
                /*把input绑定事件 排除password框*/
            function () {
                if ($(this).val() == "" && $(this).attr("placeholder") != "") {
                    $(this).val($(this).attr("placeholder"));
                    $(this).css("color", "#ddd");
                    $(this).focus(function () {
                        if ($(this).val() == $(this).attr("placeholder")) $(this).val("");
                    });
                    $(this).blur(function () {
                        if ($(this).val() == "") $(this).val($(this).attr("placeholder"));
                    });
                }

            });
            $("input").keyup(function () {
                if ($(this).val() != "" && $(this).val() != $(this).attr("placeholder"))
                    $(this).css("color", "#333");
                else {
                    $(this).css("color", "#ddd");
                }
            });

            $("input").blur(function () {
                if ($(this).val() != "" && $(this).val() != $(this).attr("placeholder"))
                    $(this).css("color", "#333");
                else {
                    $(this).css("color", "#ddd");
                }
            });

            if ($.cookie("rmb") != "true") {
                /*对password框的特殊处理1.创建一个text框 2获取焦点和失去焦点的时候切换*/
                $("input[type='password']").each(
                    function () {
                        var pwdField = $(this);
                        var pwdVal = pwdField.attr('placeholder');
                        pwdField.after('<input  class="input login-input loginr_input_password try_font_color_ing" type="text" value=' + pwdVal + ' autocomplete="off" />');
                        var pwdPlaceholder = $(this).siblings('.login-input');
                        pwdPlaceholder.show();
                        pwdField.hide();
                        pwdPlaceholder.css("color", "#ddd");

                        pwdPlaceholder.focus(function () {
                            pwdPlaceholder.hide();
                            pwdField.show();
                            pwdField.focus();
                        });

                        pwdField.blur(function () {
                            if (pwdField.val() == '') {
                                pwdPlaceholder.show();
                                pwdField.hide();
                            }
                        });
                    });
            }

        }
    });
}

$(document).keyup(function (event) {
    if (event.keyCode == 13) {
        if (isMultiplant) {
            if ($("#btn_text").html() != "选择工厂登录") {
                doLogin();
            }
            else {
                login();
            }
        }
        else {
            login();
        }
    }
});

jQuery(function () {
    if ($.cookie("rmb") == "true") {
        $.ajax({
            type: 'post',
            url: _WEB_ROOT + "Handler/MobileAppLogin.ashx?Action=decryption&rnd=" + Math.random(),
            async: true,
            data: { Pwd1: $.cookie("passwd") },
            success: function (data) {
                $("#rmbme").attr("checked", true);
                $("#userName").val($.cookie("account"));
                $("#passwd").val(data);
                $("#Organization").val($.cookie("Organization"));
            }
        });

    }
    //if ($.cookie("rmb") == "true") {
    //    $("#rmbme").attr("checked", true);
    //    $("#userName").val($.cookie("account"));
    //    $("#passwd").val($.cookie("passwd"));
    //}
    if (!isMultiplant) {
        $.cookie("multiplant", "", { expires: -1 });
        $.cookie("multiplantid", "", { expires: -1 });
    }
});

function isPlaceholder() {
    var input = document.createElement('input');
    return 'placeholder' in input;
}

function login() {
    if (isMultiplant) {
        $("#login_button").children(":eq(1)").slideDown();
    }
    else {
        doLogin();
    }
}

function doLogin() {
    var loginmsg = "<img src='Content/images/gif/loading.gif' style='vertical-align:middle; margin-right:5px;'><span style='vertical-align:middle;'>正在登录，请稍后...</span>";
    var trueUrl = $("#Organization").find("option:selected").attr("data-url");
    var badUrl = window.location.href;
    if (badUrl.indexOf("?") == -1) {
        badUrl = badUrl + "?Org=" + $.cookie("Organization");
    }
    badUrl = badUrl.substring(badUrl.lastIndexOf(badUrl.split('/')[3]) - 1);
    trueUrl = trueUrl.substring(trueUrl.lastIndexOf(trueUrl.split('/')[3]) - 1);
    if (badUrl != trueUrl) {
        $("#msg").html("<img src='" + _WEB_ROOT + "Content/login/login2/errinfo.png' style='vertical-align:middle; margin-right:5px;'><span style='vertical-align:middle;'>选择账套有误，请重新选择！</span>");
        return false;
    }
    var $username = $("#userName");
    var username = $.trim($username.val());
    if (!username || username == $username.attr("placeholder")) {
        $("#msg").html("<img src='" + _WEB_ROOT + "Content/login/login2/errinfo.png' style='vertical-align:middle; margin-right:5px;'><span style='vertical-align:middle;'>请输入您的帐号！</span>");
        $username.focus();
        return false;
    }
    var $passwddom = $("#passwd");
    var passwd = $.trim($passwddom.val());
    if (!passwd || passwd == $passwddom.attr("placeholder")) {
        $("#msg").html("<img src='" + _WEB_ROOT + "Content/login/login2/errinfo.png' style='vertical-align:middle; margin-right:5px;'><span style='vertical-align:middle;'>请输入您的密码！</span>");
        $passwddom.focus();
        return false;
    }
    var Organization = $.trim($("#Organization").val());
    var OrganizationName = $.trim($("#Organization").find("option:selected").text());
    if (!Organization || Organization == "-1") {
        $("#msg").html("<img src='" + _WEB_ROOT + "Content/login/login2/errinfo.png' style='vertical-align:middle; margin-right:5px;'><span style='vertical-align:middle;'>请选择账套！</span>");
        $("#Organization").focus();
        return false;
    }
    //验证一下密码
    //$.ajax({
    //    type: 'post',
    //    url: _WEB_ROOT + "Handler/MobileAppLogin.ashx?Action=ValidatePwd&rnd=" + Math.random(),
    //    async: true,
    //    data: { Pwd1: passwd },
    //    success: function (data) {
    //        if (data != "") {
    //            alert(data);
    //        }
    //    }
    //});
    if ($("#rmbme").is(":checked")) {
        var str_account = $username.val();
        var str_passwd = $passwddom.val();
        $.ajax({
            type: 'post',
            url: _WEB_ROOT + "Handler/MobileAppLogin.ashx?Action=encryption&rnd=" + Math.random(),
            async: true,
            data: { Pwd1: str_passwd },
            success: function (data) {
                $.cookie("rmb", "true", { expires: 7 });
                $.cookie("account", str_account, { expires: 7 });
                $.cookie("passwd", data, { expires: 7 });
                $.cookie("Organization", Organization, { expires: 7 });
            }
        });

    } else {
        $.cookie("rmb", "false", { expires: -1 });
        $.cookie("account", "", { expires: -1 });
        $.cookie("passwd", "", { expires: -1 });
        $.cookie("Organization", "", { expires: -1 });
    }

    var _multiplant = "";
    var _site = "";

    if (isMultiplant) {
        /*多工厂*/
        $.cookie("multiplant", $("#btn_text").html(), { expires: 7 });
        $.cookie("multiplantid", $("#btn_text").attr("data"), { expires: 7 });

        _multiplant = $("#btn_text").attr("data");
        _site = $("#btn_text").html();
    }
    var rmb = ($("#rmbme")[0].checked) ? 1 : 0;
    var _lang = $("#multiple_language").attr("data");
    $.ajax({
        type: 'post',
        url: _WEB_ROOT + "Handler/MobileAppLogin.ashx?Action=Login&rnd=" + Math.random(),
        async: true,
        data: { UserName: username, Pwd1: JsDesEncrypt(passwd), lang: _lang, rmb: rmb, multiplant: _multiplant, site: _site, Organization: Organization },
        beforeSend: function () {
            $("#msg").html(loginmsg);
            if (!isMultiplant)
                $("#loginbtn").html("正在登录...");
        },
        success: function (data) {
            var errMsg = "";
            if (data.indexOf("登录失败") == -1) {
                window.localStorage.setItem("OrganizationName", OrganizationName);
            }
            if (data == "") {
                location.href = _WEB_ROOT + "Framework/Console.aspx";
            }
            else {
                if (data.indexOf("expiredBox") != -1) {
                    window.localStorage.removeItem("OrganizationName");
                    errMsg = $(".expiredBox table tr:eq(0) td:eq(1)", data).html().replace(new RegExp(/<br>/g), "\n").replace(new RegExp(/ /g), "");
                    setLoginInfo(errMsg);
                }
                else if (data.indexOf("licenseInvalide") != -1) {
                    window.localStorage.removeItem("OrganizationName");
                    errMsg = $("#licenseInvalide", data).html();
                    setLoginInfo(errMsg);
                }
                else {
                    setLoginInfo(data);
                }
            }
        },
        complete: function (XMLHttpRequest, str) {
            if (!isMultiplant)
                $("#loginbtn").html("登&nbsp;&nbsp;录");
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
}

function setLoginInfo(m) {
    if (m.indexOf("<") == -1) {
        $("#msg").attr("title", m);
        if (m.length > 27) {
            m = m.substring(0, 25) + "...";
        }
        var m = "<img src='" + _WEB_ROOT + "Content/login/login2/errinfo.png' style='vertical-align:middle; margin-right:5px;'><span style='vertical-align:middle;'>" + m + "</span>";
    }
    $("#msg").html(m);

}
function getOrganizations() {
    $.ajax({
        type: 'post',
        url: _WEB_ROOT + "Handler/Multiplant.ashx?action=GetOrganizations&rnd=" + Math.random(),
        async: true,
        success: function (data, status) {
            if (status == "success") {
                if (data != "") {
                    $("#Organization").html(data);
                    if ($("#Organization").val() == "-1") {
                        $("#Organization").css("border", "1px solid #a2d7ff").css("color", "#e0e0e0").css("background-color", "white");
                    } else {
                        $("#Organization").css("border", "0px solid").css("color", "black").css("background-color", "rgb(232, 240, 254)");
                    }
                    var orgvalue = GetQueryString("Org");
                    if (orgvalue) {
                        $("#Organization").val(orgvalue);
                    }
                }
            }
        }
    });
}

//JS操作cookies方法!
//写cookies
function setCookie(name, value) {
    var Days = 365;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
}
//读取cookies
function getCookie(name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg)) return unescape(arr[2]);
    else return null;
}
//删除cookies
function delCookie(name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = getCookie(name);
    if (cval != null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
}