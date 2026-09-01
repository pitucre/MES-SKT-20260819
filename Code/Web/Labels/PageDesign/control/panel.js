_PageDesignOptions.controls.push({
    type: "panel",
    attributes: function (design) {
        return [
            {
                title: "左边区宽", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        design.panel.contentAttr.leftWidth = parseInt($(this).val());
                        design.resize();
                    }
                }, setdata: function (en) {
                    return en.contentAttr.leftWidth;
                }
            }, {
                title: "右边区宽", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        design.panel.contentAttr.rightWidth = parseInt($(this).val());
                        design.resize();
                    }
                }, setdata: function (en) {
                    return en.contentAttr.rightWidth;
                }
            }
        ];
    },
    events: [
        { name: "load", text: "页面开始加载", params: [{ name: "design", remark: "页面设计对象" }] },
        { name: "layout", text: "页面布局完成", params: [{ name: "design", remark: "页面设计对象" }] },
        { name: "done", text: "页面加载完成", params: [{ name: "design", remark: "页面设计对象" }] }
    ]
});