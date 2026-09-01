var _imgcontrolset = {
    type: "img",
    title: "图片",
    url: "PageDesign/img/img.png",
    selectImg: function (en, design) {
        layer.open({
            title: '选择图片',
            type: 2,
            area: ['80%', '500px'],
            content: 'SelectImg.aspx?id=0',
            btn: ['确定', '取消'],
            btn1: function (index, layero) {
                var url = layero.find("iframe")[0].contentWindow.selectImgName;
                layer.close(index);
                if (url) {
                    en.contentAttr.src = url;
                    design.initItems();
                    $("#" + en.type + en.id).click();
                }
            },
            btn2: function (index, layero) {
                layer.close(index);
                design.initItems();
                $("#" + en.type + en.id).click();
            }
        });
    },
    attributes: function (design) {
        return [{
            title: "", control: "<a href='#' style='color:#0097ac;'>点击浏览图片</a>", click: function () {
                var en = design.getSelectItem();
                _imgcontrolset.selectImg(en, design);
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
    //创建实体初始化默认信息
    newEntity: function (en) {
        
    },
    //创建实体初始化默认信息之后
    afterNewEntity: function (en, design) {
        _imgcontrolset.selectImg(en, design);
    },
    //双击事件
    onDblClick: function (en, design) {
        _imgcontrolset.selectImg(en, design);
    },
    appendContent: function (en, node, design) {
        var obj = $("<img style='width:100%;height:100%;' id='" + en.contentAttr.id + "' src='" + en.contentAttr.src + "'/>").appendTo(node);
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
            _PageDesignOptions.events[en.contentAttr.id].init(en, obj, design);
    }
};
_PageDesignOptions.controls.push(_imgcontrolset);