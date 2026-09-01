var isMultiplant = false;
function login() {
    var userName = $.trim($("#userName").val());
    var pwd = $.trim($("#pwd").val());
    if (userName == "") {
        confirmDialog("用户名不能为空！", null);
        $("#userName").select();
        return false;
    }
    if (pwd == "") {
        confirmDialog("密码不能为空！", null);
        $("#pwd").select();
        return false;
    }
    var _multiplant = (isMultiplant) ? $("div.ui-select #sitelist-button span").attr("data-value") : "";
    var _site = (isMultiplant) ? $("div.ui-select #sitelist-button span").html() : "";

    $.ajax({
        type: 'post',
        url: "../Handler/MobileAppLogin.ashx?Action=Login&rnd=" + Math.random(),
        async: true,
        data: {
            UserName: $("#userName").val(), Pwd1: JsDesEncrypt($("#pwd").val()), multiplant: _multiplant, site: _site
        },
        beforeSend: function () {
            $("#message").html("<img src='../Content/images/gif/loading.gif' style='vertical-align:middle; margin-right:5px;'/>正在登录，请稍后...");
        },
        success: function (data) {
            var errMsg = "";
            if (data == "") {
                setCookie("cachSiteValue", _multiplant);
                setCookie("cachSite", _site);
             
                try {

               
                if ($('#repass').is(':checked')) {
                    var user = {};
                    user.userName = userName;
                    user.pwd = pwd;
                    setCookie("user", JSON.stringify(user));
                }
                else
                {
                    if (getCookie("user") != null)
                    {
                        delCookie('user');
                    }
                }
                } catch (e) {
                   
                    confirmDialog(JSON.stringify(e), null);

                }
          
                location.href = "Index.aspx";
            }
            else {
                if (data.indexOf("expiredBox") != -1) {
                    errMsg = $(".expiredBox table tr:eq(0) td:eq(1)", data).html().replace(new RegExp(/<br>/g), "\n").replace(new RegExp(/ /g), "");
                    confirmDialog(errMsg, null);
                }
                else if (data.indexOf("licenseInvalide") != -1) {
                    errMsg = $("#licenseInvalide", data).html();
                    confirmDialog(errMsg, null);
                }
                else {
                    confirmDialog(data, null);
                }
            }
        },
        complete: function (XMLHttpRequest, str) {
            $("#message").html("");
        },
        datatype: 'text',
        error: function (xhr, status, error) {
            if (error.indexOf("expiredBox") != -1) {
                var errMsg = $(".expiredBox table tr:eq(0) td:eq(1)", error).html().replace(new RegExp(/<br>/g), "\n").replace(new RegExp(/ /g), "");
                confirmDialog(errMsg, null);
            }
            else if (error.indexOf("licenseInvalide") != -1) {
                errMsg = $("#licenseInvalide", error).html();
                confirmDialog(errMsg, null);
            }
            else {
                confirmDialog(error, null)
            }
        }
    });
}


function getDBLinks() {
    $.ajax({
        type: 'post',
        url: "../Handler/Multiplant.ashx?action=GetMultiDbLinks&rnd=" + Math.random(),
        async: true,
        success: function (data, status) {
            if (status == "success") {
                if (data != "") {
                    $(".ismultiplant").show();
                    $("#sitelist").html(sites);
                    $("#sitelist").removeAttr("disabled");
                    isMultiplant = true;
                    var jsonData = eval('(' + data + ')');
                    var sites = "";
                    var cachSiteValue = getCookie("cachSiteValue");
                    var cachIsValid = false;
                    for (var i = 0, j = jsonData.dblinks.length; i < j; i++) {
                        sites += "<option value='" + jsonData.dblinks[i].id + "'>" + jsonData.dblinks[i].site + "</option>";
                        if (i == 0) {
                            $("div.ui-select #sitelist-button span").html(jsonData.dblinks[i].site)
                            $("div.ui-select #sitelist-button span").attr("data-value", jsonData.dblinks[i].id);
                        }
                        if (cachSiteValue == jsonData.dblinks[i].id) cachIsValid = true;
                    }
                    $("#sitelist").html(sites);
                    if (cachIsValid) {
                        if (cachSiteValue != null && cachSiteValue != "") {
                            setSelectedSite(getCookie("cachSite"), cachSiteValue);
                        }
                    }
                    else {
                        delCookie("cachSiteValue");
                        delCookie("cachSite");
                    }
                    if (jsonData.dblinks.length == 1) {
                        $("#sitelist").attr("disabled", "disabled");
                    }
                }
                else {
                    $(".ismultiplant").hide();
                    delCookie("cachSiteValue");
                    delCookie("cachSite");
                }
            }
        }
    });
}

$(document).ready(function () {
    getDBLinks();
    $("#sitelist").click(function () {
        setSelectedSite($("#sitelist option:selected").text(), $("#sitelist option:selected").val());
    });
});

function setSelectedSite(name, value) {
    $("div.ui-select #sitelist-button span").html("");
    $("div.ui-select #sitelist-button span").html(name)
    $("div.ui-select #sitelist-button span").attr("data-value", value);
}
