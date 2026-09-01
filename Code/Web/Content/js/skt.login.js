$(document).ready(function () {
    checkBrowser();
    if (currentSelectedTab == null || currentSelectedTab=="") {
        var selectedLoginTab = getCookie("SelectedLoginTab");
        if (selectedLoginTab != null && selectedLoginTab != "") {

            isUserTab.val(selectedLoginTab);

        }
    }
    showtabs(isUserTab.val());

    $(document).keypress(function () {
        var event = arguments.callee.caller.arguments[0] || window.event;
        if (event.keyCode == 13) {
            if ($(".seltab").attr("id") == "tabitem2") {
                adminLogin();
            }
            else {
                userLogin();
            }
        }
    });
    var unamevalue = $.trim(userName.val());
    if ($(".seltab").attr("id") == "tabitem1" && unamevalue != "") {
        $("#ddlOperations").html("<option value='-1'>正在加载工位</option>");
        setTimeout(function () {
            bindOperation(unamevalue);
            if (stationId != "" && stationId != "-1") {
                $("#ddlOperations").val(stationId);
                bindResourcesByOprId(stationId, unamevalue);
                $("#ddlResources").val(resourceId);
            }
            else {
                stdId = getCookie("OpeId");
                rsId = getCookie("ResId");

                if (stdId != null) {
                    $("#ddlOperations").val(stdId);
                    if (rsId != null) {
                        bindResourcesByOprId(stdId, unamevalue);
                        $("#ddlResources").val(rsId);
                    }
                }
            }
        }, 1);
    }
});

function getCookie(c_name) {
    if (document.cookie.length > 0) {
        var c_start = document.cookie.indexOf(c_name + "=")
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1
            var c_end = document.cookie.indexOf(";", c_start)
            if (c_end == -1) c_end = document.cookie.length
            var c_coo = document.cookie.substring(c_start, c_end);
            if (c_coo.indexOf("&") != -1) {
                return unescape(c_coo.substring(0, c_coo.indexOf("&")));
            }
            else {
                return unescape(c_coo);
            }
        }
    }
    return ""
}

$(function () {
    /*当用户名改变时，绑定用户相应的工位*/
    userName.change(function () {
        msg.text("");
        var uname = $.trim(userName.val())
        if (uname != "") {
            $("#ddlOperations").html("<option value='-1'>正在加载工位</option>");
            setTimeout(function () {
                bindOperation(uname);
            }, 1);
        } else {
            $("#ddlOperations").html("<option value='-1'>选择工位</option>");
            $("#ddlResources").html("<option value='-1'>选择资源</option>");
        }
    });

    /*操作站位改变时绑定相应的资源*/
    $("#ddlOperations").change(function () {
        operationId = $("#ddlOperations").val();
        bindResourcesByOprId(operationId, $.trim(userName.val()));
    });
});

/*检查浏览器版本*/
function checkBrowser() {
    var browserInfo = browserDetect();
    if (browserInfo.browser.toLowerCase() == "ie") {
        if (parseInt(browserInfo.version, 10) < 7) {
            $("#browserInfo").html(lowBrowserVersion);
            return false;
        }
        else {
            return true;
        }
    }
    else {
        $("#browserInfo").html(highlyRecommendIEBrowser + "<br/>您当前浏览器的内核版本是：" + browserInfo.browser + " " + browserInfo.version);
        return true;
    }

}

/*选项卡切换*/
function showtabs(i) {
    $(".seltab").removeClass("seltab");
    /*1 - 普通用户；2 - 管理员*/
    if (i == 1) {
        $("#tb2").hide();
        $("#tb1").show();
        $("#tabitem1").addClass("seltab");
        $("#logfrm-body").css("background", "url(Content/theme/Metro/images/client/logfrm_body.gif) no-repeat");
        isUserTab.val("1");
        userName.focus();
    }
    else {
        admiUser = getCookie("AdminName");
        if (admiUser != null && admiUser != "") {
            adminUserName.val(admiUser);
            rememberAdmin[0].checked = true;
        }

        $("#tb1").hide();
        $("#tb2").show();
        $("#tabitem2").addClass("seltab");
        $("#logfrm-body").css("background", "url(Content/theme/Metro/images/client/logfrm_body_admin.gif) no-repeat");
        isUserTab.val("0");
        adminUserName.focus();
    }
}

/*根据用户绑定工位*/
function bindOperation(username) {
    //msg.text("");
    $("#ddlOperations").html("<option value='-1'>没有合适的工位</option>");
    $("#ddlResources").html("<option value='-1'>没有合适的资源</option>");

    /*根据用户获取所有的工位类型*/
    var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetOperationTypeByUser(username, -1, false);
    if (ajax1.error != null) {
        msg.text(ajax1.error.Message); // + " - [" + loadOperationFailed + "]"
        return false;
    }
    var list1 = ajax1.value; //所有的有权限的站位
    var list2 = list1;
    if (list1.length == 0) {
        $("#ddlOperations").html("<option value='-1'>" + noOperation + "</option>");
        return false;
    }
    var oprType = "<option value='-1'>选择工位</option>";
    var stationTypeIdStr = ";" + list1[0].StationTypeId + ";";
    var arr1 = new Array();
    var arr2 = new Array();
    arr1[0] = list1[0].StationTypeId; ;
    arr1[1] = list1[0].OpeType;
    arr2.push(arr1);

    for (var i = 0, j = list1.length; i < j; i++) {
        if (stationTypeIdStr.indexOf(";" + list1[i].StationTypeId + ";") == -1) {
            arr1 = new Array();
            arr1[0] = list1[i].StationTypeId; ;
            arr1[1] = list1[i].OpeType;
            arr2.push(arr1);
            stationTypeIdStr += list1[i].StationTypeId + ";";
        }
    }

    for (var i = 0, j = arr2.length; i < j; i++) {
        oprType += "<optgroup label='" + arr2[i][1] + "'>";
        for (var k = 0, m = list2.length; k < m; k++) {
            if (list2[k].StationTypeId == arr2[i][0]) {
                oprType += "<option value='" + list2[k].StationId + "'>" + list2[k].Station + "</option>";
            }
        }
    }

    $("#ddlOperations").html(oprType);
}

/*根据工位ID绑定资源*/
function bindResourcesByOprId(oprId, username) {
    var r = "";
    //msg.text("");
    $("#ddlResources").html("<option value='-1'>没有合适的资源</option>");
    if (oprId == -1) {
        r = "<option value='-1'>" + noResources + "</option>";
    }
    else {
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetResourcesByOprId(oprId, username);
        if (ajax.error != null) {
            msg.text(ajax.error.Message); //+ " - [" + loadResourcesFailed + "]"
            return false;
        }
        var list = ajax.value;

        if (list.length == 0) {
            r = "<option value='-1'>" + noResources + "</option>";
        }
        else {
            r = "<option value='-1'>选择资源</option>";
        }

        for (var i = 0; i < list.length; i++) {
            r += "<option value='" + list[i].ResourceId + "'>" + list[i].ResName + "</option>";
        }
    }
    $("#ddlResources").html(r);
}

/*扫描登录按钮*/
function userLogin() {
    msg.text("");
    /*如果浏览器低于IE7则不允许使用*/
    if (!checkBrowser()) {
        msg.text(lowBrowserVersion);
        return false;
    }
    /*用户名不能为空*/
    if (userName.val() == "") {
        msg.text(userNameRequired);
        userName.focus();
        return false;
    }

    /*密码不能为空*/
    if (userPwd.val() == "") {
        msg.text(passwordRequired);
        userPwd.focus();
        return false;
    }
    /*需要选择工位*/
    if ($("#ddlOperations").val() == "-1") {
        msg.text(qualificationOperationIsRequired);
        $("#ddlOperations").focus();
        return false;
    }
    /*需要选择资源*/
    if ($("#ddlResources").val() == "-1") {
        msg.text(resourceRequired);
        $("#ddlResources").focus();
        return false;
    }

    msg.text(loginInProcess);
    setTimeout(function () {
        document.forms[0].submit();
    }, 1);
}

/*维护登录按钮*/
function adminLogin() {
    msg.text("");
    /*如果浏览器低于IE7则不允许使用*/
    if (!checkBrowser()) {
        msg.text(lowBrowserVersion);
        return false;
    }
    /*用户名不能为空*/
    if (adminUserName.val() == "") {
        msg.text(userNameRequired);
        adminUserName.focus();
        return false;
    }
    /*密码不能为空*/
    if (adminPwd.val() == "") {
        msg.text(passwordRequired);
        adminPwd.focus();
        return false;
    }
    msg.text(loginInProcess);
    setTimeout(function () {
        document.forms[0].submit();
    }, 1);
}