var _piecontrolset = {
    type: "pie",
    title: "饼图",
    url: "PageDesign/img/pie.png",
    attributes: function (design) {
        return [{
            title: "", control: "<a href='#' style='color:#0097ac;'>编辑初始化方法</a>", click: function () {
                design.openEventCode(design.getSelectItem());
            }
        }];
    },
    newEntity: function (en) {
        en.events = [{
            name: "init",
            code: "var options={\n\ttooltip:{\n\t\ttrigger:'item',\n\t\tformatter:'{a} <br/>{b}: {c} ({d}%)'\n\t},\n\tlegend:{\n\t\tdata: ['直接访问', '邮件营销', '联盟广告', '视频广告', '搜索引擎']\n\t},\n\tseries:[{\n\t\tname: '访问来源',\n\t\ttype: 'pie',\n\t\tdata: [\n\t\t\t{value: 335, name: '直接访问'},\n\t\t\t{value: 310, name: '邮件营销'},\n\t\t\t{value: 234, name: '联盟广告'},\n\t\t\t{value: 135, name: '视频广告'}\n\t\t]\n\t}]\n};\necharts.init(document.getElementById(entity.contentAttr.id)).setOption(options);"
        }];
    },
    //绑定事件
    events: [
        {
            name: "init", text: "控件初始化", params: [
                { name: "entity", remark: "设计控件时的对象" },
                { name: "design", remark: "页面设计对象" },
                { name: "entity.type", remark: "控件类型" },
                { name: "entity.contentAttr", remark: "控件的属性" },
                { name: "entity.contentAttr.id", remark: "控件的id属性" }
            ]
        },
       {
           name: "click", text: "图形点击事件", params: [
                { name: "params", remark: "图形点击对象" },
                { name: "params.name", remark: "图形点击的名称" },
                { name: "params.value", remark: "图形点击的值" }
           ], bind: function (func, en, node) {
               echarts.init(document.getElementById(en.contentAttr.id)).on("click", func);
           }
       }, {
           name: "dblclick", text: "图形双击事件", params: [
                { name: "params", remark: "图形点击对象" },
                { name: "params.name", remark: "图形双击的名称" },
                { name: "params.value", remark: "图形双击的值" }
           ], bind: function (func, en, node) {
               echarts.init(document.getElementById(en.contentAttr.id)).on("dblclick", func);
           }
       }, {
           name: "legendselectchanged", text: "图例切换事件", params: [
                { name: "params", remark: "图形点击对象" },
                { name: "params.name", remark: "图形切换的名称" },
                { name: "params.value", remark: "图形切换的值" }
           ], bind: function (func, en, node) {
               echarts.init(document.getElementById(en.contentAttr.id)).on("legendselectchanged", func);
           }
       }
    ],
    appendContent: function (entity, node, design) {
        node.append("<div style='width:100%;height:100%;' id='" + entity.contentAttr.id + "'></div>");
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[entity.contentAttr.id] && _PageDesignOptions.events[entity.contentAttr.id].init) {
            _PageDesignOptions.events[entity.contentAttr.id].init(entity, design);
            return;
        }
        var options = {
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            legend: {
                data: ['直接访问', '邮件营销', '联盟广告', '视频广告', '搜索引擎']
            },
            series: [{
                name: '访问来源',
                type: 'pie',
                data: [
                    { value: 335, name: '直接访问' },
                    { value: 310, name: '邮件营销' },
                    { value: 234, name: '联盟广告' },
                    { value: 135, name: '视频广告' }
                ]
            }]
        };
        echarts.init(document.getElementById(entity.contentAttr.id)).setOption(options);
    }
}
_PageDesignOptions.controls.push(_piecontrolset);