_PageDesignOptions.controls.push({
    type: "checkbox",
    title: "多选按钮",
    url: "PageDesign/img/checkbox.png",
    attributes: function (design) {
        return [{
            title: "风格", control: "control-select", change: function () {
                design.editContentAttr("skin", $(this).val());
            }, data: [
                { value: "primary", text: "原始" },
                { value: "switch", text: "开关" }
            ], setdata: function (en) {
                return en.contentAttr.skin;
            }
        }, {
            title: "文本内容", control: "control-text", change: function () {
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
            name: "click", text: "点击事件", params: [
                { name: "data", remark: "点击的对象" },
                { name: "data.elem", remark: "点击的原始DOM对象" },
                { name: "data.value", remark: "点击的值" },
                { name: "data.elem.checked", remark: "是否被选中" }
            ], bind: function (func, en, node) {
                if (en.contentAttr.skin == "switch")
                    layui.form.on('switch(' + en.contentAttr.id + ')', func);
                else
                    layui.form.on('checkbox(' + en.contentAttr.id + ')', func);
            }
        }
    ],
    newEntity: function (en) {
        en.contentAttr.skin = "primary";
        en.contentAttr.title = "复选框";
        en.contentAttr.value = "0";
    },
    appendContent: function (en, node, design) {
        var obj = $("<input lay-filter='" + en.contentAttr.id + "' value='" + en.contentAttr.value + "' id='" + en.contentAttr.id + "' type='checkbox' title='" + en.contentAttr.title + "' lay-skin='" + en.contentAttr.skin + "'/>").appendTo(node);
        layui.form.render("checkbox");
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
            _PageDesignOptions.events[en.contentAttr.id].init(en, obj, design);
    }
});