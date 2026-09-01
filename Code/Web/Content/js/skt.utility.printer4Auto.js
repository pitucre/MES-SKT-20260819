
var LABEL_CONTENT = "";
var CLSID = "";
var PRINT_PLUGIN_VERSION = "";
var PRINT_PLUGIN_CAB_PATH = "";
var PRINT_PLUGIN_DOWNLOAD_PATH = "";
var CER_MANUAL_HELP = _root + "/Help/安全证书导入帮助手册.pdf";
var NoPrinterPlugin = setNoPrintInfo(PRINT_PLUGIN_VERSION.replace(new RegExp(",", "gm"), "."), CER_MANUAL_HELP, PRINT_PLUGIN_DOWNLOAD_PATH);
var ALLOWTOPRINT = false;
var CERTIFICATION_PATH = _root + "/Content/Component/skt.zip";

function setNoPrintInfo(ver, helpDoc, downloadPath) {
    return "<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'>系统检测到您本地计算机还没有安装打印插件或者打印插件需要升级(新版本：" + ver + ")，打印插件的安装/升级有两种方式：<br/>方式一、手动<a title='查看导入安全证书教程' href='" + helpDoc + "' target='_blank'>导入安全证书</a>让浏览器自动安装或升级<a title='下载证书' href='" + CERTIFICATION_PATH + "' target='_blank'>[下载证书]</a>； <br/>方式二、手动<a href='" + downloadPath + "' title='手动下载打印插件' target='_blank'>下载插件</a>安装或升级；目前打印插件只支持IE浏览器！</div>";
}

window.browserDetect = function () {
    var userAgent = navigator.userAgent.toLocaleLowerCase(),
                rMsie = /(msie\s|trident\/7)([\w.]+)/,
                rTrident = /(trident)\/([\w.]+)/,
                rFirefox = /(firefox)\/([\w.]+)/,
                rOpera = /(opera).+version\/([\w.]+)/,
                rNewOpera = /(opr)\/(.+)/,
                rChrome = /(chrome)\/([\w.]+)/,
                rSafari = /version\/([\w.]+).*(safari)/;

    var matchBS, matchBS2;
    var browser;
    var version;
    var ua = userAgent.toLowerCase();
    var uaMatch = function (ua) {
        matchBS = rMsie.exec(ua);
        if (matchBS != null) {
            matchBS2 = rTrident.exec(ua);
            if (matchBS2 != null) {
                switch (matchBS2[2]) {
                    case "4.0": return { browser: "IE", version: "8" }; break;
                    case "5.0": return { browser: "IE", version: "9" }; break;
                    case "6.0": return { browser: "IE", version: "10" }; break;
                    case "7.0": return { browser: "IE", version: "11" }; break;
                    default: return { browser: "IE", version: "undefined" };
                }
            }
            else
                return { browser: "IE", version: matchBS[2] || "0" };
        }
        matchBS = rFirefox.exec(ua);
        if ((matchBS != null) && (!(window.attachEvent)) && (!(window.chrome)) && (!(window.opera))) {
            return { browser: matchBS[1] || "", version: matchBS[2] || "0" };
        }
        matchBS = rOpera.exec(ua);
        if ((matchBS != null) && (!(window.attachEvent))) {
            return { browser: matchBS[1] || "", version: matchBS[2] || "0" };
        }
        matchBS = rChrome.exec(ua);
        if ((matchBS != null) && (!!(window.chrome)) && (!(window.attachEvent))) {
            matchBS2 = rNewOpera.exec(ua);
            if (matchBS2 == null)
                return { browser: matchBS[1] || "", version: matchBS[2] || "0" };
            else
                return { browser: "Opera", version: matchBS2[2] || "0" };
        }
        matchBS = rSafari.exec(ua);
        if ((matchBS != null) && (!(window.attachEvent)) && (!(window.chrome)) && (!(window.opera))) {
            return { browser: matchBS[2] || "", version: matchBS[1] || "0" };
        }
        if (matchBS != null) {
            return { browser: "undefined", version: " browser" };
        }
    }
    var browserMatch = uaMatch(userAgent.toLowerCase());
    return browserMatch;
}

function setWarningMessage(msg) {
    $(".noInstallPrintPlugin").remove();
    if (document.getElementById("toolbar") == null) {
        var firstDom = document.body.firstChild;
        $(msg).insertBefore(firstDom)
    }
    else {
        $(msg).insertBefore($("form", document.body));
    }
}

function pendPrintPluginDom(__CLSID, __PRINT_PLUGIN_CAB_PATH) {
    if (document.getElementById("LeanMESPrintPlugin") == null) {
        $('<object classid="clsid:' + __CLSID + '" id="LeanMESPrintPlugin" style="display:none;" codebase="' + __PRINT_PLUGIN_CAB_PATH + '"></object>').insertBefore($("form", document.body).children(":first"));
    }
}

function checkPrintPlugin(__NoPrinterPlugin) {
    if (document.all.LeanMESPrintPlugin.object == null) {
        setWarningMessage(__NoPrinterPlugin);
        return false;
    }
    else {
        $(".noInstallPrintPlugin").remove();
        ALLOWTOPRINT = true;
        return true;
    }
}

function getPrintPluginInfoFromXml(xmlPath) {
    $.ajax({
        url: xmlPath,
        dataType: 'xml',
        type: 'GET',
        timeout: 2000,
        error: function (xml) {
            alert("加载XML文件出错！");
        },
        beforeSend: function () {
            setWarningMessage("<div class='noInstallPrintPlugin Tips'><img src='" + _root + "/Content/Images/gif/loading.gif' style='vertical-align:middle; margin-right:5px;'/>正在加载打印插件，请稍后...</div>");
        },
        success: function (xml) {
            $(xml).find("plugin").each(function (i) {
                var plnId = $(this).attr("plnId");
                if (plnId == 2) {
                    var version = $(this).children("version").text();
                    var plnpath = $(this).children("plnpath").text();
                    var cabpath = $(this).children("cabpath").text();
                    var clsid = $(this).children("clsid").text();
                    CLSID = clsid;
                    PRINT_PLUGIN_VERSION = version.replace(".", ",").replace(".", ",").replace(".", ",").replace(".", ",");
                    PRINT_PLUGIN_CAB_PATH = _root + "/" + cabpath + "#version=" + PRINT_PLUGIN_VERSION;
                    PRINT_PLUGIN_DOWNLOAD_PATH = _root + "/" + plnpath;
                    NoPrinterPlugin = setNoPrintInfo(version.replace(new RegExp(",", "gm"), "."), CER_MANUAL_HELP, PRINT_PLUGIN_DOWNLOAD_PATH);
                }
            });
        },
        complete: function () {
            pendPrintPluginDom(CLSID, PRINT_PLUGIN_CAB_PATH);
            checkPrintPlugin(NoPrinterPlugin);
        }
    });
}


$(document).ready(function () {   
    var browserInfo = browserDetect();
    if (browserInfo.browser.toLowerCase() != "ie") {
        var errmsg = "<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>系统检测到您当前使用的不是IE浏览器无法进行打印，打印插件暂时只支持IE内核，请使用IE浏览器来打印！</div>";
        setWarningMessage(errmsg);
        return false;
    }

    getPrintPluginInfoFromXml(_root + "/Content/Component/PluginInfo.xml?rnd=" + Math.random()); 
});

function printLabel(labPath, labContent, printerName, printMode) {
    if (!ALLOWTOPRINT) {
        alert("未能正确加载打印插件无法进行打印。");
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>未能加载打印插件无法进行打印。</div>");
        return false;
    }
    setWarningMessage("<div class='noInstallPrintPlugin Tips'><img src='" + _root + "/Content/Images/gif/loading.gif' style='vertical-align:middle; margin-right:5px;'/>正在进行打印，请稍后...</div>");
    setTimeout(function () {
        switch (printMode.toLowerCase()) {
            case "lab":
                printWithLab(labPath, labContent, printerName);
                break;
            case "zpl":
                printWithZpl(labContent, printerName);
                break;
            default:
                alert("请传入正确的打印模式参数，lab为调用.lab模板打印，zpl为调用ZPL内容打印！");
                break;
        }
        $(".noInstallPrintPlugin.Tips").remove();
    }, 10);
}

function printMultipleLabel(labPath, labContent, printerName, copies, printMode) {
    if (!ALLOWTOPRINT) {
        alert("未能加载打印插件无法进行打印。");
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>未能加载打印插件无法进行打印。</div>");
        return false;
    }
    setWarningMessage("<div class='noInstallPrintPlugin Tips'><img src='" + _root + "/Content/Images/gif/loading.gif' style='vertical-align:middle; margin-right:5px;'/>正在进行打印，请稍后...</div>");
    setTimeout(function () {
        switch (printMode.toLowerCase()) {
            case "lab":
                printMultipleWithLab(labPath, labContent, printerName, copies);
                break;
            case "zpl":
                printMultipleWithZpl(labContent, printerName, copies);
                break;
            default:
                alert("请传入正确的打印模式参数，lab为调用.lab模板打印，zpl为调用ZPL内容打印！");
                break;
        }
        $(".noInstallPrintPlugin.Tips").remove();
    }, 10);
}

function printWithLab(labelFilePath, labelValue, printerName) {
    try {
        var LeanMESPrintPlugin = document.getElementById("LeanMESPrintPlugin");
        if (_lang == undefined) {
            _lang = "";
        }
        if (_lang == "zh-cn") _lang = "cn";
        LeanMESPrintPlugin.PrintLabelWithLab(labelFilePath, labelValue, _lang, printerName);
    }
    catch (e) {
        alert(e.message);
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>" + e.message + "</div>");
    }
}

function printMultipleWithLab(labelFilePath, labelValue, printerName, copies) {
    try {
        var LeanMESPrintPlugin = document.getElementById("LeanMESPrintPlugin");
        if (_lang == undefined) {
            _lang = "";
        }
        if (_lang == "zh-cn") _lang = "cn";
        LeanMESPrintPlugin.PrintMultipleLabelWithLab(labelFilePath, labelValue, copies, _lang, printerName);
    }
    catch (e) {
        alert(e.message);
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>" + e.message + "</div>");
    }
}

function printWithZpl(labelValue, printerName) {
    try {
        var LeanMESPrintPlugin = document.getElementById("LeanMESPrintPlugin");
        if (_lang == undefined) {
            _lang = "";
        }
        if (_lang == "zh-cn") _lang = "cn";
        LeanMESPrintPlugin.PrintLabelWithZpl(labelValue, printerName, _lang);
    }
    catch (e) {
        alert(e.message);
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>" + e.message + "</div>");
    }
}

function printMultipleWithZpl(labelValue, printerName, copies) {
    try {
        var LeanMESPrintPlugin = document.getElementById("LeanMESPrintPlugin");
        if (_lang == undefined) {
            _lang = "";
        }
        if (_lang == "zh-cn") _lang = "cn";
        LeanMESPrintPlugin.PrintMultipleLabelWithZpl(labelValue, printerName, _lang, copies);
    }
    catch (e) {
        alert(e.message);
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>" + e.message + "</div>");
    }
}

function getLocalPrintersList() {
    if (!ALLOWTOPRINT) {
        alert("未能正确加载打印插件无法获取本地打印机列表。");
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>未能正确加载打印插件无法获取本地打印机列表。</div>");
        return "";
    }
    var LeanMESPrintPlugin = document.getElementById("LeanMESPrintPlugin");
    try {
        return LeanMESPrintPlugin.GetLocalPrintersList();
    }
    catch (e) {
        alert(e.message);
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>" + e.message + "</div>");
    }
}

function checkLocalPrinter(printerName) {
    if (!ALLOWTOPRINT) {
        alert("未能正确加载打印插件无法获取本地打印机列表。");
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>未能正确加载打印插件无法获取本地打印机列表。</div>");
        return false;
    }
    var LeanMESPrintPlugin = document.getElementById("LeanMESPrintPlugin");
    try {
        return LeanMESPrintPlugin.CheckPrinter(printerName);
    }
    catch (e) {
        alert(e.message);
        setWarningMessage("<div class='noInstallPrintPlugin' style='padding:3px; border:1px solid #FFEC8B; background:yellow; color:red;'><img src='" + _root + "/Content/Images/icon/help.png' style='vertical-align:middle; margin-right:5px;'/>" + e.message + "</div>");
    }
}