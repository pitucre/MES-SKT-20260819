_PageDesignOptions.controls.push({
    type: "line",
    title: "折线图",
    url: "PageDesign/img/line.png",
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
                 { name: "design", remark: "页面设计对象" },
                 { name: "entity.type", remark: "控件类型"},
                 { name: "entity.contentAttr", remark: "控件的属性"},
                 { name: "entity.contentAttr.id", remark: "控件的id属性"}
             ]
         },
        {
            name: "click", text: "图形点击事件", params: [
                 { name: "params", remark: "图形点击对象" },
                 { name: "params.name", remark: "图形点击的名称"},
                 { name: "params.value", remark: "图形点击的值"}
            ], bind: function (func, en, node) {
                echarts.init(document.getElementById(en.contentAttr.id)).on("click", func);
            }
        }, {
            name: "dblclick", text: "图形双击事件", params: [
                 { name: "params", remark: "图形点击对象" },
                 { name: "params.name", remark: "图形双击的名称"},
                 { name: "params.value", remark: "图形双击的值"}
            ], bind: function (func, en, node) {
                echarts.init(document.getElementById(en.contentAttr.id)).on("dblclick", func);
            }
        }, {
            name: "legendselectchanged", text: "图例切换事件", params: [
                 { name: "params", remark: "图形点击对象" },
                 { name: "params.name", remark: "图形切换的名称"},
                 { name: "params.value", remark: "图形切换的值"}
            ], bind: function (func, en, node) {
                echarts.init(document.getElementById(en.contentAttr.id)).on("legendselectchanged", func);
            }
        }
    ],
    newEntity: function (en) {
        en.events = [{
            name: "init",
            code: "var options={\n\txAxis: [{\n\t\ttype: 'category',\n\t\tdata: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],\n\t}],\n\tyAxis: [{\n\t\ttype: 'value'\n\t}],\n\tseries:[{\n\t\tname: '访问来源',\n\t\ttype: 'line',\n\t\tdata: [10, 52, 200, 334, 390, 330, 220]\n\n\t}]\n};\necharts.init(document.getElementById(entity.contentAttr.id)).setOption(options);"
        }];
    },
    appendContent: function (entity, node, design) {
        node.append("<div style='width:100%;height:100%;' id='" + entity.contentAttr.id + "'></div>");
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[entity.contentAttr.id] && _PageDesignOptions.events[entity.contentAttr.id].init) {
            _PageDesignOptions.events[entity.contentAttr.id].init(entity, design);
            return;
        }
        var options = {
            xAxis: [{
                type: 'category',
                data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            }],
            yAxis: [{
                type: 'value'
            }],
            series: [{
                name: '直接访问',
                type: 'line',
                data: [10, 52, 200, 334, 390, 330, 220]
            }]
        };
        echarts.init(document.getElementById(entity.contentAttr.id)).setOption(options);
    }
});