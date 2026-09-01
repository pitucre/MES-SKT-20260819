(function () {
    var parent = window.parent;
    //dialog对象
    dialog = parent.$EDITORUI[window.frameElement.id.replace(/_iframe$/, '')];
    //当前打开dialog的编辑器实例
    editor = dialog.editor;

    UE = parent.UE;

    domUtils = UE.dom.domUtils;

    utils = UE.utils;

    browser = UE.browser;

    ajax = UE.ajax;

    $G = function (id) {
        return document.getElementById(id)
    };
    $createid = function (uictrltype) {
        var timestamp = new Date().getTime();
        return 'uictrl_' + timestamp.toString() + (Math.random() * 1000).toFixed(0) + '_' + uictrltype;
    };
    $getstyle = function (oNode) {
        var gStyle = oNode.getAttribute('style');
        var styleArr = [];
        if (gStyle != null && gStyle != '') {
            styleArr = gStyle.split(";");
        }
        var gWidth = '', gHeight = '';
        for (var i = 0; i < styleArr.length; i++) {
            if (styleArr[i].indexOf("width:") != -1) {
                gWidth = styleArr[i].replace("width:", "").replace("px", "");
            }
            if (styleArr[i].indexOf("height:") != -1) {
                gHeight = styleArr[i].replace("height:", "").replace("px", "");
            }
        }
        styleArr = [];
        styleArr[0] = gWidth;
        styleArr[1] = gHeight;
        return styleArr;
    }
    //focus元素
    $focus = function (node) {
        setTimeout(function () {
            if (browser.ie) {
                var r = node.createTextRange();
                r.collapse(false);
                r.select();
            } else {
                node.focus()
            }
        }, 0)
    };
    utils.loadFile(document, {
        href: editor.options.themePath + editor.options.theme + "/dialogbase.css?cache=" + Math.random(),
        tag: "link",
        type: "text/css",
        rel: "stylesheet"
    });
    lang = editor.getLang(dialog.className.split("-")[2]);
    if (lang) {
        domUtils.on(window, 'load', function () {

            var langImgPath = editor.options.langPath + editor.options.lang + "/images/";
            //针对静态资源
            for (var i in lang["static"]) {
                var dom = $G(i);
                if (!dom) continue;
                var tagName = dom.tagName,
                    content = lang["static"][i];
                if (content.src) {
                    //clone
                    content = utils.extend({}, content, false);
                    content.src = langImgPath + content.src;
                }
                if (content.style) {
                    content = utils.extend({}, content, false);
                    content.style = content.style.replace(/url\s*\(/g, "url(" + langImgPath)
                }
                switch (tagName.toLowerCase()) {
                    case "var":
                        dom.parentNode.replaceChild(document.createTextNode(content), dom);
                        break;
                    case "select":
                        var ops = dom.options;
                        for (var j = 0, oj; oj = ops[j]; ) {
                            oj.innerHTML = content.options[j++];
                        }
                        for (var p in content) {
                            p != "options" && dom.setAttribute(p, content[p]);
                        }
                        break;
                    default:
                        domUtils.setAttributes(dom, content);
                }
            }
        });
    };
})();

