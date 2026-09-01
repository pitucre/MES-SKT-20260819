_PageDesignOptions.controls.push({
    type: "text",
    title: "文本框",
    url: "PageDesign/img/text.png",
    attributes: function (design) {
        return [{
            title: "预期显示内容", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                design.editContentAttr("placeholder", $(this).val());
            }, setdata: function (en) {
                return en.contentAttr.placeholder;
            }
        }, {
            title: "最大字符数", control: "control-text", change: function () {
                if (design.isInt($(this).val()))
                    design.editContentAttr("maxlength", parseInt($(this).val()));
            }, setdata: function (en) {
                return en.contentAttr.maxlength;
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
            name: "change", text: "内容改变事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
                $("#" + en.contentAttr.id).change(func);
            }
        },
        {
            name: "focus", text: "获取焦点事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
                $("#" + en.contentAttr.id).focus(func);
            }
        },
        {
            name: "blur", text: "失去焦点事件", params: _PageDesignOptions.baseEventParams, bind: function (func, en, node) {
                $("#" + en.contentAttr.id).blur(func);
            }
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
        en.contentAttr.maxlength = 10;
        en.contentAttr.placeholder = "请输入内容";
    },
    appendContent: function (en, node, design) {
        var obj = $("<input maxlength='" + en.contentAttr.maxlength + "' placeholder='" + en.contentAttr.placeholder + "' id='" + en.contentAttr.id + "' class='layui-input' type='text'/>").appendTo(node);
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
            _PageDesignOptions.events[en.contentAttr.id].init(en, obj, design);
    }
});