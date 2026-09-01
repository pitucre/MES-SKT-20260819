_PageDesignOptions.controls.push({
    type: "button",
    title: "按钮",
    url: "PageDesign/img/button.png",
    attributes: function (design) {
        return [{
            title: "文本", control: "control-text", change: function () {
                design.editContentAttr("text", $(this).val());
            }, setdata: function (en) {
                return en.contentAttr.text;
            }
        }, {
            title: "主题", control: "control-select", change: function () {
                design.editContentAttr("theme", $(this).val());
            }, data: [
                { value: "", text: "默认" },
                { value: "layui-btn-primary", text: "原始" },
                { value: "layui-btn-normal", text: "百搭" },
                { value: "layui-btn-warm", text: "暖色" },
                { value: "layui-btn-danger", text: "警告" }
            ], setdata: function (en) {
                return en.contentAttr.theme;
            }
        }, {
            title: "尺寸", control: "control-select", change: function () {
                design.editContentAttr("size", $(this).val());
            }, data: [
                { value: "", text: "默认" },
                { value: "layui-btn-lg", text: "大型" },
                { value: " layui-btn-sm", text: "小型" },
                { value: "layui-btn-xs", text: "迷你" }
            ], setdata: function (en) {
                return en.contentAttr.size;
            }
        }, {
            label: "圆角", control: "control-checkbox", click: function () {
                design.editContentAttr("radius", $(this).get(0).checked ? "layui-btn-radius" : "");
            }, setdata: function (en) {
                return en.contentAttr.radius == "layui-btn-radius";
            }
        }, {
            title: "", control: "<a href='#' style='color:#0097ac;'>点击设置图标</a>", click: function () {
                var icons = ["heart-fill", "heart", "light", "time", "bluetooth", "at", "mute", "mike", "key", "gift", "email", "rss", "wifi", "logout", "android", "ios", "windows", "transfer", "service", "subtraction", "addition", "slider", "print", "export", "cols", "screen-restore", "screen-full", "rate-half", "rate", "rate-solid", "cellphone", "vercode", "login-wechat", "login-qq", "login-weibo", "password", "username", "refresh-3", "auz", "spread-left", "shrink-right", "snowflake", "tips", "note", "home", "senior", "refresh", "refresh-1", "flag", "theme", "notice", "website", "console", "face-surprised", "set", "template-1", "app", "template", "praise", "tread", "male", "female", "camera", "camera-fill", "more", "more-vertical", "rmb", "dollar", "diamond", "fire", "return", "location", "read", "survey", "face-smile", "face-cry", "cart-simple", "cart", "next", "prev", "upload-drag", "upload", "download-circle", "component", "file-b", "user", "find-fill", "loading", "loading-1", "add-1", "play", "pause", "headset", "video", "voice", "speaker", "fonts-del", "fonts-code", "fonts-html", "fonts-strong", "unlink", "picture", "link", "face-smile-b", "align-left", "align-right", "align-center", "fonts-u", "fonts-i", "tabs", "radio", "circle", "edit", "share", "delete", "form", "cellphone-fine", "dialogue", "fonts-clear", "layer", "date", "water", "code-circle", "carousel", "prev-circle", "layouts", "util", "templeate-1", "upload-circle", "tree", "table", "chart", "chart-screen", "engine", "triangle-d", "triangle-r", "file", "set-sm", "reduce-circle", "add-circle", "404", "about", "up", "down", "left", "right", "circle-dot", "search", "set-fill", "group", "friends", "reply-fill", "menu-fill", "log", "picture-fine", "face-smile-fine", "list", "release", "ok", "help", "chat", "top", "star", "star-fill", "close-fill", "close", "ok-circle", "add-circle-fine"];
                var en = design.getSelectItem();
                var iconsstr = "";
                for (var i = 0; i < icons.length; i++) {
                    iconsstr += "<i class='layui-icon layui-icon-" + icons[i] + "'></i>";
                }
                var index = layer.open({
                    type: 1,
                    area: ["550px", "400px"],
                    title: "设置按钮图标-" + en.contentAttr.labname,
                    content: "<div class='buttonicons'>" + iconsstr + "</div>",
                    btn: ['置空'],
                    btn1: function () {
                        layer.close(index);
                        design.editContentAttr("icon", "");
                    }
                });
                $(".buttonicons i").click(function () {
                    design.editContentAttr("icon", "<i class='" + $(this).attr("class") + "'></i>");
                    layer.close(index);
                });
            }
        }];
    },
    //绑定事件
    events: [
        {
            name: "init", text: "控件初始化", params: [
                { name: "entity", remark: "设计控件时的对象" },
                { name: "node", remark: "当前控件元素节点" },
                { name: "design", remark: "页面设计对象" },
                { name: "entity.type", remark: "控件类型" },
                { name: "entity.contentAttr", remark: "控件的属性" },
                { name: "entity.contentAttr.id", remark: "控件的id属性" }
            ]
        },
        {
            name: "click", text: "点击事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
                $("#" + en.contentAttr.id).click(func);
            }
        },
       {
           name: "dblclick", text: "双击事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
               $("#" + en.contentAttr.id).dblclick(func);
           }
       },
       {
           name: "mousedown", text: "鼠标按下事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
               $("#" + en.contentAttr.id).mousedown(func);
           }
       },
       {
           name: "mouseup", text: "鼠标松开事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
               $("#" + en.contentAttr.id).mouseup(func);
           }
       },
       {
           name: "mouseover", text: "鼠标移入事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
               $("#" + en.contentAttr.id).mouseover(func);
           }
       },
       {
           name: "mouseout", text: "鼠标移出事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
               $("#" + en.contentAttr.id).mouseout(func);
           }
       },
       {
           name: "mousemove", text: "鼠标移动事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
               $("#" + en.contentAttr.id).mousemove(func);
           }
       }
    ],
    newEntity: function (en) {
        en.contentAttr.text = "按钮";
        en.contentAttr.theme = "";
        en.contentAttr.size = "";
        en.contentAttr.radius = "";
        en.contentAttr.icon = "";
    },
    appendContent: function (en, node, design) {
        var obj = $("<button class='layui-btn' id='" + en.contentAttr.id + "'>" + en.contentAttr.icon + en.contentAttr.text + "</button>").appendTo(node);
        if (en.contentAttr.theme)
            obj.addClass(en.contentAttr.theme);
        if (en.contentAttr.size)
            obj.addClass(en.contentAttr.size);
        if (en.contentAttr.radius)
            obj.addClass(en.contentAttr.radius);
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
            _PageDesignOptions.events[en.contentAttr.id].init(en, obj, design);
    }
});