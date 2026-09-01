_PageDesignOptions.controls.push({
    type: "radio",
    title: "单选按钮",
    url: "PageDesign/img/radio.png",
    attributes: function (design) {
        return [{
            title: "文本", control: "control-text", change: function () {
                design.editContentAttr("title", $(this).val());
            }, setdata: function (en) {
                return en.contentAttr.title;
            }
        }, {
            title: "值", control: "control-text", change: function () {
                design.editContentAttr("value", $(this).val());
            }, setdata: function (en) {
                return en.contentAttr.value;
            }
        }, {
            title: "分组名", control: "control-text", change: function () {
                design.editContentAttr("name", $(this).val());
            }, setdata: function (en) {
                return en.contentAttr.name;
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
            name: "click", text: "点击事件",params: [
                { name: "data", remark: "点击的对象" },
                { name: "data.elem", remark: "点击的原始DOM对象" },
                { name: "data.value", remark: "点击的值" }
            ] ,bind: function (func, en, node) {
                layui.form.on('radio(' + en.contentAttr.id + ')', func);
            }
        }
    ],
    newEntity: function (en) {
        en.contentAttr.name = "radioname";
        en.contentAttr.title = "选项";
        en.contentAttr.value = "0";
    },
    appendContent: function (en, node, design) {
        var obj = $("<input name='" + en.contentAttr.name + "' id='" + en.contentAttr.id + "' lay-filter='" + en.contentAttr.id + "' type='radio' title='" + en.contentAttr.title + "' value='" + en.contentAttr.value + "' />").appendTo(node);
        layui.form.render("radio");
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
            _PageDesignOptions.events[en.contentAttr.id].init(en, obj, design);
    }
});