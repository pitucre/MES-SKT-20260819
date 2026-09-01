_PageDesignOptions.controls.push({
    type: "div",
    title: "文本标签",
    url: "PageDesign/img/div.png",
    attributes: function (design) {
        return [{
            title: "文本内容", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                design.editContentAttr("text", $(this).val());
            }, setdata: function (en) {
                return en.contentAttr.text == undefined ? "" : en.contentAttr.text;
            }
        },
        { title: "<div class='g_title'>跑马灯设置</div>", colspan: 3, control: "<div class='g_line'></div>" },
        {
            label: "开启", control: "control-checkbox", click: function () {
                design.editContentAttr("marquee", $(this).get(0).checked);
            }, setdata: function (en) {
                return en.contentAttr.marquee;
            }
        }, {
            title: "滚动速度", control: "control-select", change: function () {
                design.editContentAttr("scrollamount", $(this).val());
            }, min: 1, max: 20, setdata: function (en) {
                return en.contentAttr.scrollamount;
            }
        }, {
            title: "滚动方向", control: "control-select", change: function () {
                design.editContentAttr("direction", $(this).val());
            }, data: [
                { value: "up", text: "往上" },
                { value: "down", text: "往下" },
                { value: "left", text: "往左" },
                { value: "right", text: "往右" }
            ], setdata: function (en) {
                return en.contentAttr.direction;
            }
        }, {
            title: "滚动方式", control: "control-select", change: function () {
                design.editContentAttr("behavior", $(this).val());
            }, data: [
                { value: "scroll", text: "循环滚动" },
                { value: "slide", text: "滚动一次" },
                { value: "alternate", text: "来回滚动" }
            ], setdata: function (en) {
                return en.contentAttr.behavior;
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
        en.contentAttr.text = "深圳市深科技信息技术有限公司";
        en.contentAttr.marquee = false;
        en.contentAttr.direction = "left";
        en.contentAttr.behavior = "scroll";
        en.contentAttr.scrollamount = "5";
    },
    appendContent: function (en, node, design) {
        var obj;
        if (en.contentAttr.marquee) {
            obj = $("<marquee id='" + en.contentAttr.id + "' direction='" + en.contentAttr.direction + "' behavior='" + en.contentAttr.behavior + "' scrollamount='" + en.contentAttr.scrollamount + "' style='width:100%;height:100%;'>" + en.contentAttr.text + "</marquee>").appendTo(node);
        } else {
            obj = $("<div id='" + en.contentAttr.id + "'></div>").appendTo(node);
            if (en.child.length == 0 && en.contentAttr.text != undefined)
                obj.text(en.contentAttr.text);
        }
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
            _PageDesignOptions.events[en.contentAttr.id].init(en, obj, design);
    }
});