/*
* Mes plugin dialog 2.0.1
*
* Date : 2015-08-11
*
* Author ：Alen Liu
* 
* Copyright(c) 2014 All Rights Reserved.   [ shzalen@163.com ].
*
* Modify By: Alen Liu 2016-09-28
*
* Description: 注释拖动功能，增加窗口大小改变时重新定位窗口位置
*/
var d = {};
let originalLeft = 0
let originalTop = 0
function dialog(a) {
    void 0 == _close && (_close = "Close");
    void 0 == _resizewin && (_resizewin = "Resize");
    void 0 == _dialogwin && (_dialogwin = "Dialog");
    void 0 == _help && (_help = "Help");
    void 0 == _enlarged && (_enlarged = "Enlarged");
    var g = _dialogwin,
        e = $(window).width() - 16,
        f = $(window).height() - 16;
    d = {
        title: "undefined" == typeof a.title ? g : a.title,
        width: "undefined" == typeof a.width || 0 == a.width ? e : a.width > $(window).width() - 30 ? $(window).width() - 30 : a.width,
        height: "undefined" == typeof a.height || 0 == a.height ? f : a.height > $(window).height() - 30 ? $(window).height() - 30 : a.height,
        src: "undefined" == typeof a.src ? "" : a.src,
        content: "undefined" == typeof a.content ? "" : a.content,
        buttons: "undefined" == typeof a.buttons ? null : a.buttons,
        resizeable: "undefined" == typeof a.resizeable ? !0 : a.resizeable,
        onClosing: "undefined" == typeof a.onClosing ? "" : a.onClosing,
        onClosed: "undefined" == typeof a.onClosed ? "" : a.onClosed,

    };
    d.src = encodeUrlParams(d.src);
    var b = "",
        b = '<div id="dialogWin" class="dialogWin" style="width:' + d.width.toString() + 'px;"><table id="dialogTable" cellpadding="0" cellspacing="0" border="0" width="100%"><tr class="dlg-header"><td><div class="dlg-nw"></div></td><td class="dlg-n"><div class="dlg-nc"><div id="dlg-title" class="dlg-title"  style="width:' + (d.width - 80).toString() + 'px;"><div class="dlg-title icon"></div><div class="dlg-title text">' + d.title + '</div></div><div class="nebutton"><div class="nebutton help" onclick="openHelp();" title="' + _help + '"></div><div class="nebutton enlarged" onclick="enlargedDialog();" title="' + _enlarged + '"><img src="../Content/images/icon/enlarged1.png" /></div><div class="nebutton close" onclick="closeDialog();" title="' + _close + '"></div></div></div></td><td><div class="dlg-ne"></div></td></tr><tr class="dlg-main"><td class="dlg-body-nw"></td><td class="dlg-body-n" style="width:' + (d.width - 32).toString() + 'px;"><div class="clearAll"></div><div id="dlg-body" style="width:' + d.width.toString() + "px; height:" + d.height.toString() + 'px">',
        b = b + ('<div id="dialogLoadingMessage" style="position:absolute; top:25%; left:0px; width:' + d.width.toString() + 'px; text-align:center; "><div style="border:1px solid #d3d3d3; color:#21adf7; width:170px; height:40px; margin-left:auto; margin-right:auto;background:#fafafa; line-height:25px;">' + _dataLoading + '<br/><img src="../Content/plugin/dialog/skin/default/images/loadinga.gif"/></div></div>'),
        b = "" != d.src ? b + ('<iframe id="ifrmDialog" frameborder="0" scrolling="auto" width="' + d.width.toString() + '" height="' + d.height + '" src="' + d.src + '"></iframe>') : b + d.content,
        b = b + '</div></td><td class="dlg-body-ne"></td></tr>';
    null != d.buttons && (b += '<tr class="dlg-buttonlist"><td class="dlg-body-nw"></td><td class="dlg-bottom button"><div class="clearAll"></div><div class="dlg-bottom-buttonlist"><ul>', $(d.buttons).each(function (a, c) {
        var e = void 0 == typeof c.icon || "" == c.icon ? "btn-bg" : c.icon,
            f = void 0 == typeof c.text || "" == c.text ? "Button" + (a + 1).toString() : c.text;
        b = void 0 != typeof c.onclick && "" != c.onclick ? b + ("<li><input type='button' class=\"" + e + '" onclick="' + c.onclick + "()\" value='" + f + "'/></li>") : b + ("<li><input type='button' class=\"" + e + "\" value='" + f + "'/></li>")
    }), b += '</ul></div></td><td class="dlg-body-ne"></td></tr>');
    b += '<tr class="dlg-footer"><td><div class="dlg-sw"></div></td><td class="dlg-sc" style="height:9px"></td><td><div class="dlg-se" id="dlg-se"><div id="resize" class="resize-btn" title="' + _resizewin + '" ></div></div></td></tr></table></div>';
    $("body").append(b);
    showShadow(!0);
    a = document.documentElement.scrollTop || document.body.scrollTop;
    $("#dialogWin").css({
        left: $(window).width() / 2 - $("#dialogWin").width() / 2,
        top: $(window).height() / 2 - $("#dialogWin").height() / 2 + a
    });
    originalLeft = $(window).width() / 2 - $("#dialogWin").width() / 2;
    originalTop = $(window).height() / 2 - $("#dialogWin").height() / 2;
    "" !== d.src ? (a = document.getElementById("ifrmDialog"), a.attachEvent ? a.attachEvent("onload",
        function () {
            $("#dialogLoadingMessage").remove()
        }) : a.onload = function () {
            $("#dialogLoadingMessage").remove()
        }) : $("#dialogLoadingMessage").remove();
    "" == d.src && $("#dlg-body").mousemove(function () {
        return !1
    });
    d.resizeable ? (a = !1, null != d.buttons && (a = !0), bindResize(document.getElementById("dlg-se"), a)) : $("#dlg-se .resize-btn").remove();
    d.resizeable && $("#dialogWin #dlg-se").mousedown(function () {
        return !1
    });
    $(document).keypress(function () {
        var a = 0,
            b = b || window.event,
            a = b.keyCode || b.which || b.charCode;
        if (27 == a) return closeDialog(),
            !1
    });
    $(window).resize(function () {
        var a = document.documentElement.scrollTop || document.body.scrollTop;
        $("#dialogWin").css({
            left: $(window).width() / 2 - $("#dialogWin").width() / 2,
            top: $(window).height() / 2 - $("#dialogWin").height() / 2 + a
        })
    })
}
function showShadow(a) {
    a ? (a = document.documentElement.scrollTop || document.body.scrollTop, $("#shadowdiv").height($(window).height() + a), $("#shadowdiv").width($(window).width() + 250), $("#shadowdiv").show(), $("body,html").css("overflow", "hidden")) : ($("#shadowdiv").height(0), $("#shadowdiv").width(0), $("#shadowdiv").hide(), $("body,html").css("overflow", "auto"))
}
function closeDialog() {
    if (void 0 != typeof d.onClosing && "" != d.onClosing) try {
        /*eval(d.onClosing + "($('#dlg-body'));")*/
        var res = d.onClosing($('#dlg-body'))
        if (false == res) {
            return;
        }
    } catch (a) { }
    showShadow(!1);
    $("#dialogWin").html("");
    $("#dialogWin").remove();
    $(window).focus();
    if (void 0 != typeof d.onClosed && "" != d.onClosed) try {
        eval(d.onClosed + "();")
    } catch (a) { }
}

let dialogOpenFlag = false
function enlargedDialog() {
    dialogOpenFlag = !dialogOpenFlag
    if (dialogOpenFlag) {
        $('#dialogWin').css({
            'width': '94%',
            'height': '94%',
            'top': '3%',
            'left': '3%'
        });
        $('#dialogTable').css({
            'width': '100%',
            'height': '100%'
        });
        $('#dlg-body').css({
            'width': '100%',
            'height': '100%'
        });
        $('#ifrmDialog').css({
            'width': '100%',
            'height': '100%'
        });
    } else {
        $('#dialogWin').css({
            'width': d.width,
            'height': 'auto',
            left: originalLeft,
            top: originalTop
        });
        $('#dialogTable').css({
            'width': '100%',
            'height': 'auto'
        });
        $('#dlg-body').css({
            width: d.width,
            height: d.height
        });
        $('#ifrmDialog').css({
            width: d.width,
            height: d.height
        });
    }

}
function bindResize(a, g) {
    function e(a) {
        var c = 420 > a.clientX - b ? 420 > d.width ? d.width : 420 : a.clientX - b;
        a = 280 > a.clientY - y ? 280 > d.height ? d.height : 280 : a.clientY - y;
        g && (a -= 42);
        var e = document.documentElement.scrollTop || document.body.scrollTop;
        $("#dialogWin").css({
            width: c - 33 + "px",
            height: a - 52 + "px",
            left: $(window).width() / 2 - $("#dialogWin").width() / 2,
            top: $(window).height() / 2 - $("#dialogWin").height() / 2 + e
        });
        $("#dlg-title").css({
            width: c - 33 + "px"
        });
        $("#dlg-body").css({
            width: c - 33 + "px",
            height: a - 52 + "px"
        });
        $("#dlg-body>iframe").css({
            width: c - 33 + "px",
            height: a - 52 + "px"
        })
    }
    function f() {
        a.releaseCapture ? (a.releaseCapture(), a.onmousemove = a.onmouseup = null) : $(document).unbind("mousemove", e).unbind("mouseup", f)
    }
    $(a).css("cursor", "se-resize");
    var b = y = 0;
    $(a).mousedown(function (g) {
        b = g.clientX - a.parentElement.parentElement.parentElement.offsetWidth;
        y = g.clientY - a.parentElement.parentElement.parentElement.offsetHeight;
        a.setCapture ? (a.setCapture(), a.onmousemove = function (a) {
            e(a || event)
        },
            a.onmouseup = f) : $(document).bind("mousemove", e).bind("mouseup", f);
        g.preventDefault()
    })
}
function openHelp() {
    window.open("Help")
}
function dialogDom(a) {
    return $(a).children("iframe")[0].contentWindow.document.body
};

function encodeUrlParams(url) {

    if (!url) {
        return "";
    }
    // 提取路径和查询字符串
    let [path, queryString] = url.split('?');

    // 解析查询字符串
    let params = new URLSearchParams(queryString);

    // 创建一个数组来保存编码后的参数
    let encodedParams = [];

    // 对每个参数进行编码
    params.forEach((value, key) => {
        if (value != "") {
            if (key.toLowerCase() == 'pagecondition' || key.toLowerCase() == 'searchcondition') {
                encodedParams.push(key + '=' + encodeURIComponent(AES_CBC_ENCRYPT(value)));
            } else {
                encodedParams.push(key + '=' + value);
            }
        }

    });

    // 重新构建URL
    let encodedUrl = path + '?' + encodedParams.join('&');

    return encodedUrl;
}