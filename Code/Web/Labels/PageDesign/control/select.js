_PageDesignOptions.controls.push({
    type: "select",
    title: "下拉框",
    url: "PageDesign/img/select.png",
    attributes: function (design) {
        return [{
            title: "", control: "<a href='#' style='color:#0097ac;'>编辑初始化方法</a>", click: function () {
                design.openEventCode(design.getSelectItem());
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
            name: "change", text: "内容改变事件", params: [
                { name: "data", remark: "选择的对象" },
                { name: "data.elem", remark: "选择的原始DOM对象" },
                { name: "data.value", remark: "选择的值" }
            ], bind: function (func, en, node) {
                layui.form.on('select(' + en.contentAttr.id + ')', func);
            }
        }
    ],
    newEntity: function (en) {
        en.events = [{
            name: "init",
            code: "//绑定方法\nfunction bind(data){\n\tvar str=\"\";\n\tfor (var i = 0; i <data.length; i++) {\n\t\tstr+=\"<option\" + (data[i].selected ? \" selected='selected'\" : \"\") + \" value='\" + data[i].value + \"'>\" + data[i].text + \"</option>\";\n\t}\n\tnode.append(str);\n\tlayui.form.render(\"select\");\n}\n//Ctrl+K+C注释,如果是固定数据\nbind([\n\t{ value: '0', text: '请选择', selected: true },\n\t{ value: '1', text: '张三' },\n\t{ value: '2', text: '李四' }\n]);\n//Ctrl+K+U取消注释,如果请求存储过程数据$.get或者$.post\n//$.get({\n//\tdata:null,\n//\turl:'',\n//\tsuccess:function(e){\n//\t\tif(e.success){\n//\t\t\tbind(e.data);\n//\t\t}else{\n//\t\t\talert(e.msg);\n//\t\t}\n//\t}\n//});"
        }];
    },
    appendContent: function (en, node, design) {
        var obj = $("<select lay-filter='" + en.contentAttr.id + "' id='" + en.contentAttr.id + "'></select>").appendTo(node);
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
            _PageDesignOptions.events[en.contentAttr.id].init(en, obj, design);
        else
            layui.form.render("select");
    }
});