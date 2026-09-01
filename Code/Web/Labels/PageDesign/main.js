(function ($, window, layer, undefined, options) {
    var design = {
        //通用属性
        commonAttributes: [
            {
                title: "控件ID", remark: "ctl_开头，并且不能和其他控件id重复", control: "control-text", change: function () {
                    if ($(this).val().indexOf("ctl_") == 0) {
                        design.editContentAttr("id", $(this).val());
                    }
                }, setdata: function (en) {
                    return en.contentAttr.id;
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            },
            {
                title: "控件名称", control: "control-text", change: function () {
                    design.editContentAttr("labname", $(this).val());
                }, setdata: function (en) {
                    return en.contentAttr.labname;
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            },
            {
                label: "允许内容超出区域高度", colspan: 3, control: "control-checkbox", click: function () {
                    design.editItemAttr("overflowY", $(this).get(0).checked ? "auto" : undefined);
                }, setdata: function (en) {
                    return en.attr.overflowY == "auto";
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "宽度", control: "control-text", change: function () {
                    if (design.isNumber($(this).val()) && parseFloat($(this).val()) > 0)
                        design.editItemAttr("width", parseFloat($(this).val()));
                }, setdata: function (en) {
                    return en.attr.width == undefined ? "" : en.attr.width;
                }, show: function (en) {
                    return en.attr.wShow;
                }
            }, {
                title: "宽度单位", control: "control-select", change: function () {
                    design.editItemAttr("widthUnit", parseInt($(this).val()));
                }, data: [
                    { value: "0", text: "像素" },
                    { value: "1", text: "百分比" },
                    { value: "2", text: "自适应" },
                    { value: "3", text: "填充" }
                ], setdata: function (en) {
                    return en.attr.widthUnit == undefined ? "" : en.attr.widthUnit;
                }, show: function (en) {
                    if (en.type == "panel")
                        return false;
                    return en.attr.wShow;
                }
            }, {
                title: "高度", control: "control-text", change: function () {
                    if (design.isNumber($(this).val()) && parseFloat($(this).val()) > 0)
                        design.editItemAttr("height", parseFloat($(this).val()));
                }, setdata: function (en) {
                    return en.attr.height == undefined ? "" : en.attr.height;
                }, show: function (en) {
                    return en.attr.hShow;
                }
            }, {
                title: "高度单位", control: "control-select", change: function () {
                    design.editItemAttr("heightUnit", parseInt($(this).val()));
                }, data: [
                    { value: "0", text: "像素" },
                    { value: "1", text: "百分比" },
                    { value: "2", text: "自适应" },
                    { value: "3", text: "填充" }
                ], setdata: function (en) {
                    return en.attr.heightUnit == undefined ? "" : en.attr.heightUnit;
                }, show: function (en) {
                    if (en.type == "panel")
                        return false;
                    return en.attr.hShow;
                }
            },
           {
               title: "<div class='g_title'>字体</div>", colspan: 3, control: "<div class='g_line'></div>", show: function (en) {
                   return !(en.type == "panel");
               }
           },
           {
               title: "字体类型", control: "control-select", change: function () {
                   design.editItemAttr("fontFamily", $(this).val() ? $(this).val() : undefined);
               }, data: [
                   { value: "", text: "默认" },
                   { value: "FangSong", text: "仿宋" },
                   { value: "KaiTi", text: "楷体" },
                   { value: "SimHei", text: "黑体" }
               ], setdata: function (en) {
                   return en.attr.fontFamily == undefined ? "" : en.attr.fontFamily;
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               title: "字体颜色", control: "control-tackcolor", changecolor: function (color) {
                   if (color && color.ok)
                       design.editItemAttr("color", color.toString(color.format));
                   else
                       design.editItemAttr("color", undefined);
               }, setdata: function (en) {
                   return en.attr.color == undefined ? "" : en.attr.color;
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               title: "字体大小", control: "control-text", change: function (color) {
                   design.editItemAttr("fontSize", design.isInt($(this).val()) ? parseInt($(this).val()) : undefined);
               }, setdata: function (en) {
                   return en.attr.fontSize == undefined ? "" : en.attr.fontSize;
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               title: "行高", control: "control-text", change: function () {
                   design.editItemAttr("lineHeight", design.isInt($(this).val()) ? parseInt($(this).val()) : undefined);
               }, setdata: function (en) {
                   return en.attr.lineHeight == undefined ? "" : en.attr.lineHeight;
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               title: "字间距", control: "control-text", change: function (color) {
                   design.editItemAttr("letterSpacing", design.isNumber($(this).val()) ? parseInt($(this).val()) : undefined);
               }, setdata: function (en) {
                   return en.attr.letterSpacing == undefined ? "" : en.attr.letterSpacing;
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               title: "对齐方式", control: "control-select", change: function () {
                   design.editItemAttr("textAlign", $(this).val());
               }, data: [
                   { value: "left", text: "左" },
                   { value: "center", text: "中" },
                   { value: "right", text: "右" }
               ], setdata: function (en) {
                   return en.attr.textAlign == undefined ? "left" : en.attr.textAlign;
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               label: "粗体", control: "control-checkbox", click: function () {
                   design.editItemAttr("fontWeight", $(this).get(0).checked ? "bold" : undefined);
               }, setdata: function (en) {
                   return en.attr.fontWeight == undefined ? false : (en.attr.fontWeight == "bold");
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               label: "斜体", control: "control-checkbox", click: function () {
                   design.editItemAttr("fontStyle", $(this).get(0).checked ? "italic" : undefined);
               }, setdata: function (en) {
                   return en.attr.fontStyle == undefined ? false : (en.attr.fontStyle == "italic");
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               label: "上划线", control: "control-checkbox", click: function () {
                   design.editItemAttr("overline", $(this).get(0).checked ? "1" : undefined);
               }, setdata: function (en) {
                   return en.attr.overline == undefined ? false : (en.attr.overline == "1");
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               label: "贯穿线", control: "control-checkbox", click: function () {
                   design.editItemAttr("linethrough", $(this).get(0).checked ? "1" : undefined);
               }, setdata: function (en) {
                   return en.attr.linethrough == undefined ? false : (en.attr.linethrough == "1");
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               label: "下划线", control: "control-checkbox", click: function () {
                   design.editItemAttr("underline", $(this).get(0).checked ? "1" : undefined);
               }, setdata: function (en) {
                   return en.attr.underline == undefined ? false : (en.attr.underline == "1");
               }, show: function (en) {
                   return !(en.type == "panel");
               }
           }, {
               title: "", control: "<div></div>", show: function (en) {
                   return !(en.type == "panel");
               }
           },
            {
                title: "阴影位置", control: "control-text", change: function (color) {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val))
                        design.editItemAttr("textShadowMargin", val);
                    else
                        design.editItemAttr("textShadowMargin", undefined);
                }, setdata: function (en) {
                    return en.attr.textShadowMargin == undefined ? "" : en.attr.textShadowMargin;
                }, remark: "水平偏移 垂直偏移 深度,例:5px 5px 5px", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "阴影颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.editItemAttr("textShadowColor", color.toString(color.format));
                    else
                        design.editItemAttr("textShadowColor", undefined);
                }, setdata: function (en) {
                    return en.attr.textShadowColor == undefined ? "" : en.attr.textShadowColor;
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "<div class='g_title'>边框</div>", colspan: 3, control: "<div class='g_line'></div>", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "边宽度", control: "control-text", change: function () {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px$/.test(val))
                        design.editItemAttr("borderWidth", val);
                    else if (/^[+-]?\d+$/.test(val))
                        design.editItemAttr("borderWidth", val + "px");
                    else
                        design.editItemAttr("borderWidth", undefined);
                }, setdata: function (entity) {
                    return entity.attr.borderWidth == undefined ? "" : entity.attr.borderWidth;
                }, remark: "上 右 下 左 例:1px 1px 1px 1px，上下 左右 例:1px 1px，四向例:1px", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "边框颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.editItemAttr("borderColor", color.toString(color.format));
                    else
                        design.editItemAttr("borderColor", undefined);
                }, setdata: function (entity) {
                    return entity.attr.borderColor == undefined ? "" : entity.attr.borderColor;
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                label: "边框虚线", control: "control-checkbox", click: function () {
                    design.editItemAttr("borderStyle", $(this).get(0).checked ? "dashed" : undefined);
                }, setdata: function (en) {
                    return en.attr.borderStyle == undefined ? false : (en.attr.borderStyle == "dashed");
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "", control: "<div></div>", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "内边距", control: "control-text", change: function (color) {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px$/.test(val))
                        design.editItemAttr("padding", val);
                    else if (/^[+-]?\d+$/.test(val))
                        design.editItemAttr("padding", val + "px");
                    else
                        design.editItemAttr("padding", undefined);
                }, setdata: function (entity) {
                    return entity.attr.padding == undefined ? "" : entity.attr.padding;
                }, remark: "上 右 下 左 例:1px 1px 1px 1px，上下 左右 例:1px 1px，四向例:1px", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "外边距", control: "control-text", change: function (color) {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px$/.test(val))
                        design.editItemAttr("margin", val);
                    else if (/^[+-]?\d+$/.test(val))
                        design.editItemAttr("margin", val + "px");
                    else
                        design.editItemAttr("margin", undefined);
                }, setdata: function (entity) {
                    return entity.attr.margin == undefined ? "" : entity.attr.margin;
                }, remark: "上 右 下 左 例:1px 1px 1px 1px，上下 左右 例:1px 1px，四向例:1px", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "阴影位置", control: "control-text", change: function (color) {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val))
                        design.editItemAttr("boxShadowMargin", val);
                    else
                        design.editItemAttr("boxShadowMargin", undefined);
                }, setdata: function (entity) {
                    return entity.attr.boxShadowMargin == undefined ? "" : entity.attr.boxShadowMargin;
                }, remark: "水平偏移 垂直偏移 模糊程度 阴影半径,例:5px 5px 5px 5px", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "阴影颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.editItemAttr("boxShadowColor", color.toString(color.format));
                    else
                        design.editItemAttr("boxShadowColor", undefined);
                }, setdata: function (entity) {
                    return entity.attr.boxShadowColor == undefined ? "" : entity.attr.boxShadowColor;
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "阴影透明度", control: "control-text", change: function () {
                    if (design.isNumber($(this).val()) && parseFloat($(this).val()) >= 0 && parseFloat($(this).val()) <= 1)
                        design.editItemAttr("boxShadowOpacity", parseFloat($(this).val()));
                    else
                        design.editItemAttr("boxShadowOpacity", undefined);
                }, setdata: function (entity) {
                    return entity.attr.boxShadowOpacity == undefined ? "" : entity.attr.boxShadowOpacity;
                }, remark: "阴影透明度0到1之间的数字，0代表完全透明，1代表完全不透明", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "圆角", control: "control-text", change: function () {
                    design.editItemAttr("borderRadius", design.isInt($(this).val()) ? $(this).val() : undefined);
                }, setdata: function (entity) {
                    return entity.attr.borderRadius == undefined ? "" : entity.attr.borderRadius;
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "<div class='g_title'>背景</div>", colspan: 3, control: "<div class='g_line'></div>", show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "背景颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.editItemAttr("backgroundColor", color.toString(color.format));
                    else
                        design.editItemAttr("backgroundColor", undefined);
                }, setdata: function (entity) {
                    return entity.attr.backgroundColor == undefined ? "" : entity.attr.backgroundColor;
                }, show: function (en) {
                    return !(en.type == "panel");
                }
            }, {
                title: "背景透明度", control: "control-text", change: function () {
                    if (design.isNumber($(this).val()) && parseFloat($(this).val()) >= 0 && parseFloat($(this).val()) <= 1)
                        design.editItemAttr("bgOpacity", parseFloat($(this).val()));
                    else
                        design.editItemAttr("bgOpacity", undefined);
                }, setdata: function (entity) {
                    return entity.attr.bgOpacity == undefined ? "" : entity.attr.bgOpacity;
                }, remark: "背景透明度0到1之间的数字，0代表完全透明，1代表完全不透明", show: function (en) {
                    return !(en.type == "panel");
                }
            }
        ],
        //左边拖动的项目
        currDragItem: { node: null, width: 60, height: 60 },
        //预览的浮动层
        floatDragArea: null,
        currIndex: -1,
        operation: [],
        batchChoice: false,
        //面板
        panel: {
            id: 1,
            index: 1,//层级
            type: "panel",//类型(所有的都是div 嵌套一个 type元素)
            //私有属性
            contentAttr: {
                id: "ctl_panel",
                labname: "面板",
                rate: 1,//缩放比率
                leftWidth: 95,//左边区域宽度
                rightWidth: 380//右边区域宽度
            },//div 内容，根据type绘制的元素
            child: [],//子集，注意子集不是type内容，而是嵌套的div
            area: {},//当前div区域
            //公共属性
            attr: {
                width: 800,//宽度
                height: 600,//高度
                widthUnit: 0,//0px   1%   2自适应  3填充
                heightUnit: 0,//0px   1%   2自适应  3填充
                wShow: true,//宽度是否显示
                hShow: true//高度是否显示
            },
            events: []
        },
        //窗体大小改变
        resize: function () {
            $(".module").height(0).height($("body").height() - $("#laytabul").height());
            $("#d_left").width(design.panel.contentAttr.leftWidth);
            $("#d_left .search-text").width(design.panel.contentAttr.leftWidth - 15);
            $("#d_right").width(design.panel.contentAttr.rightWidth);
            $("#d_center").width($("body").width() - design.panel.contentAttr.leftWidth - design.panel.contentAttr.rightWidth);
        },
        //初始化
        init: function () {
            //引用控件的js
            options.controls = [];
            var script = "";
            for (var i = 0; i < options.control.names.length; i++) {
                script += "<script src='" + options.control.path + options.control.names[i] + ".js'></script>";
            }
            $("head").append(script);

            if (options.data)
                design.panel = design.toJsModel(options.data);
            //预览
            if (options.ispreview) {
                window.onresize = function () {
                    design.setItemsArea();
                    options.events.resize(design);
                };
                design.initItems(true);
                return;
            }
            $(".module").show();
            design.resize();
            //初始化布局的搜索和控件
            $("#d_left input").change(design.initControls).keyup(design.initControls);
            design.initControls();
            //初始化事件的控件和，搜索
            $("#e_controls input").change(design.initEventNode).keyup(design.initEventNode);
            design.initEventNode();
            //初始化事件的名称搜索
            $("#e_events input").change(design.initEventName).keyup(design.initEventName);
            //初始化系统函数的搜索
            $("#e_sysobject input").keyup(function (e) {
                if (e.keyCode == 40)
                    design.selectSysObject(e);
                else if (e.keyCode == 13)
                    design.eventCodeKeyEnter();
                else
                    design.searchSysObject($(this).val())
            });
            //初始化面板
            design.initPanel();
            window.onresize = function () {
                design.resize();
                design.initPanel(true);
            };
            design.currIndex = -1;
            design.operation = [];
            $("#ddllables").change(function () {
                $("#" + $(this).val()).click();
            });
            $("#btn_preview").unbind("click").bind("click", function () {
                if (design.panel.child.length == 0) {
                    layer.open({ content: '请先添加控件' });
                    return;
                }
                options.preview(design.toCSharpModel());
            });
            $("#btn_save").unbind("click").bind("click", function () {
                if (design.panel.child.length == 0) {
                    layer.open({ content: '请先添加控件' });
                    return;
                }
                options.save(design.toCSharpModel());
            });
            $("body").bind('mousewheel DOMMouseScroll', function (e) {
                if (window.event.ctrlKey) {
                    var wheel = e.originalEvent.wheelDelta;
                    var detal = e.originalEvent.detail;
                    if (wheel) {
                        if (wheel > 0) {
                            design.zoom((design.panel.contentAttr.rate * 10 + 1) / 10, true);
                        }
                        if (wheel < 0) {
                            design.zoom((design.panel.contentAttr.rate * 10 - 1) / 10, true);
                        }
                    } else if (detal) {
                        if (detal > 0) {
                            design.zoom((design.panel.contentAttr.rate * 10 - 1) / 10, true);
                        }
                        if (detal < 0) {
                            design.zoom((design.panel.contentAttr.rate * 10 + 1) / 10, true);
                        }
                    }
                    e.preventDefault();
                    e.stopPropagation();
                }
            }).mousemove(function (e) {
                design.itemMove.e = e;
                if (design.itemMove.node)
                    design.itemMove.node.css({ top: e.clientY - design.currDragItem.height / 2, left: e.clientX - design.currDragItem.width / 2 });
            });
        },
        toCSharpModel: function (item) {
            if (item == undefined)
                item = JSON.parse(JSON.stringify(design.panel));
            delete item.area;
            //因为各个控件私有属性不一样，只能传递字符串到后台代码，根据具体类型反序列化
            item.contentAttr = JSON.stringify(item.contentAttr);
            var array = [];
            //为空的事件主体，就不要了
            for (var i = 0; i < item.events.length; i++) {
                if (item.events[i].code) {
                    item.events[i].remark = design.findEventHead(item.events[i].name, item).str;
                    array.push(item.events[i]);
                }
            }
            item.events = array;
            for (var i = 0; i < item.child.length; i++) {
                design.toCSharpModel(item.child[i]);
            }
            return JSON.stringify(item);
        },
        toJsModel: function (item) {
            item.contentAttr = JSON.parse(item.contentAttr);
            for (var i = 0; i < item.child.length; i++) {
                design.toJsModel(item.child[i]);
            }
            return item;
        },
        //保存操作记录
        saveOperation: function () {
            options.winclose = false;
            if (design.currIndex > design.operation.length - 1)
                design.currIndex = design.operation.length - 1;
            if (design.currIndex < design.operation.length - 1)
                design.operation.splice(design.currIndex + 1, design.operation.length - 1 - design.currIndex);
            if (design.operation.length > 100)
                design.operation.splice(0, 1);
            design.operation.push(JSON.stringify(design.panel));
            design.currIndex = design.operation.length - 1;
            $("#panel1").focus();
        },
        //撤销
        ctrlZ: function () {
            if (design.currIndex > 0 && design.currIndex < design.operation.length) {
                design.currIndex--;
                design.controlEventExc("beforeDelete");
                design.panel = JSON.parse(design.operation[design.currIndex]);
                design.initPanel(true);
                design.initItems(true);
            }
        },
        //反撤销
        ctrlY: function () {
            if (design.currIndex < design.operation.length - 1) {
                design.currIndex++;
                design.controlEventExc("beforeDelete");
                design.panel = JSON.parse(design.operation[design.currIndex]);
                design.initPanel(true);
                design.initItems(true);
            }
        },
        //执行所有控件的事件
        controlEventExc: function (eventname, items) {
            if (!items)
                items = [design.panel];
            for (var i = 0; i < items.length; i++) {
                var control = design.findControlByType(items[i].type);
                if (control && control[eventname])
                    control[eventname](items[i], design);
                design.controlEventExc(eventname, items[i].child);
            }
        },
        //初始化左边拖动的图片控件
        initControls: function (search) {
            var search = $.trim($("#d_left input").val());
            var obj = $("#d_left .controls").empty();
            var html = "";
            for (var i = 0; i < options.controls.length; i++) {
                if (options.controls[i].type == "panel")
                    continue;
                if (search && options.controls[i].type.indexOf(search) == -1 && options.controls[i].title.indexOf(search) == -1)
                    continue;
                html += "<div><img type='" + options.controls[i].type + "' src='" + options.controls[i].url + "' title='" + options.controls[i].title + "'/></div>";
            }
            obj.html(html);
            design.initDrag();
        },
        //初始化编辑项
        initItems: function (nochange) {
            //如果是预览，则调用页面加载事件
            if (options.ispreview && options.events[design.panel.contentAttr.id] && options.events[design.panel.contentAttr.id].load)
                options.events[design.panel.contentAttr.id].load(design);
            //追加编辑项元素到节点,开始布局
            design.appendItemsNode();
            //填充编辑项的大小
            design.fillItems(design.panel);
            //设置编辑项区域
            design.setItemsArea();
            //如果是预览，则调用页面布局完成事件
            if (options.ispreview && options.events[design.panel.contentAttr.id] && options.events[design.panel.contentAttr.id].layout)
                options.events[design.panel.contentAttr.id].layout(design);
            //加载内容，加载控件
            design.appendContent();
            //如果是预览，绑定事件，并且不往下执行了
            if (options.ispreview) {
                design.bindEvent();
                //如果是预览，则调用页面加载完成事件
                if (options.events[design.panel.contentAttr.id] && options.events[design.panel.contentAttr.id].done)
                    options.events[design.panel.contentAttr.id].done(design);
                return;
            }
            design.initEventNode();
            //保存操作
            if (nochange)
                return;
            design.saveOperation();
        },
        //加载内容
        appendContent: function (items) {
            if (!items)
                items = design.panel.child;
            for (var i = 0; i < items.length; i++) {
                var node = $("#" + items[i].type + items[i].id);

                var control = design.findControlByType(items[i].type);
                if (control && control.appendContent)
                    control.appendContent(items[i], node, design);

                if (items[i].child)
                    design.appendContent(items[i].child);
            }
        },
        //绑定事件
        bindEvent: function (items) {
            if (!items)
                items = design.panel.child;
            for (var i = 0; i < items.length; i++) {
                var node = $("#" + items[i].type + items[i].id);
                var control = design.findControlByType(items[i].type);
                if (control && control.events && options.events[items[i].contentAttr.id]) {
                    for (var j = 0; j < control.events.length; j++) {
                        if (options.events[items[i].contentAttr.id][control.events[j].name] && control.events[j].bind)
                            control.events[j].bind(options.events[items[i].contentAttr.id][control.events[j].name], items[i], node, design);
                    }
                }
                if (items[i].child)
                    design.bindEvent(items[i].child);
            }
        },
        //追加编辑项元素到节点
        appendItemsNode: function (parent, items) {
            if (!parent && !items) {
                items = design.panel.child;
                parent = $("#panel1").empty();
            }
            for (var i = 0; i < items.length; i++) {
                var node = design.addItem(parent, items[i]);
                if (items[i].child)
                    design.appendItemsNode(node, items[i].child);
            }
        },
        //初始化面板
        initPanel: function (isresize) {
            var panel = $("#panel1");
            var pw = panel.parent().width();
            var ph = panel.parent().height();
            var width = design.panel.attr.width * design.panel.contentAttr.rate;
            var height = design.panel.attr.height * design.panel.contentAttr.rate;
            if (width < pw)
                pw = (pw - width) / 2;
            else
                pw = 0;
            if (height < ph)
                ph = (ph - height) / 2;
            else
                ph = 0;
            if (isresize) {
                panel.css({ width: width, height: height, opacity: 1, top: ph, left: pw });
                return;
            }
            panel.css({ width: 0, height: 0, opacity: 0, top: height / 2 + ph, left: width / 2 + pw, backgroundColor: "#fff", position: "relative", overflowY: "hidden", overflowX: "hidden" })
                .animate({
                    width: width, height: height, opacity: 1, top: ph, left: pw
                }, 500, "swing", function () {
                    design.initItems();
                    options.winclose = true;
                });
            panel.unbind("keydown").bind("keydown", function (e) {
                if (e.which == 37) {
                    design.changeItemIndex("wShow", -1);
                } else if (e.which == 38) {
                    design.changeItemIndex("hShow", -1);
                } else if (e.which == 39) {
                    design.changeItemIndex("wShow", 1);
                } else if (e.which == 40) {
                    design.changeItemIndex("hShow", 1);
                } else if (e.which == 46) {
                    design.deleteItems(0);
                } else if (window.event.ctrlKey) {
                    if (e.which == 89) {
                        design.ctrlY();
                    } else if (e.which == 90) {
                        design.ctrlZ();
                    }
                }
            });
            panel.unbind("click").bind("click", design.itemClick);
            panel.contextmenu(function (e) {
                if (design.panel.child.length == 0)
                    return;
                var menu = $("#div_menu");
                if (!menu || menu.length == 0) {
                    menu = $("<div class='panelmenu' id='div_menu'></div>").mouseleave(function () {
                        $(this).hide();
                    }).appendTo($("body"));
                    $("<div>撤销&nbsp;&nbsp;Ctrl+Z</div>").click(function () {
                        menu.hide(); panel.focus(); design.ctrlZ();
                    }).appendTo(menu);
                    $("<div>反撤销&nbsp;&nbsp;Ctrl+Y</div>").click(function () {
                        menu.hide(); panel.focus(); design.ctrlY();
                    }).appendTo(menu);
                    $("<div>删除元素和布局&nbsp;&nbsp;Delete</div>").click(function () {
                        menu.hide(); panel.focus(); design.deleteItems(0);
                    }).appendTo(menu);
                    $("<div>仅删除元素</div>").click(function () {
                        menu.hide(); panel.focus(); design.deleteItems(1);
                    }).appendTo(menu);
                    $("<div>下移&nbsp;&nbsp;↓</div>").click(function () {
                        menu.hide(); panel.focus(); design.changeItemIndex("hShow", 1);
                    }).appendTo(menu);
                    $("<div>右移&nbsp;&nbsp;→</div>").click(function () {
                        menu.hide(); panel.focus(); design.changeItemIndex("wShow", 1);
                    }).appendTo(menu);
                    $("<div>刷新页面</div>").click(function () {
                        menu.hide();
                        if (options.winclose || confirm("当前模板没有保存确定要刷新吗？"))
                            window.location.reload();
                    }).appendTo(menu);
                }
                var top = e.clientY - 5;
                if (e.clientY + 200 > $("#d_center").height())
                    top = e.clientY - 175;
                menu
                .css({ top: top, left: e.clientX - 5, opacity: 0, height: 240 })
                .show()
                .animate({ opacity: 1 }, 300)
                .focus();
                e.preventDefault();
                e.stopPropagation();
            });
            panel.click();
        },
        //上下左右键，交换编辑项位置，必须是同级才能交换
        changeItemIndex: function (attr, val) {
            var nodes = $(".selectItem");
            if (!nodes || nodes.length != 1)
                return;
            var index = -1;
            var item = null;
            var id = $(nodes[0]).attr("id");
            var parent = design.findParentById(id);
            for (var i = 0; i < parent.child.length; i++) {
                if (parent.child[i].attr[attr] && parent.child[i].type + parent.child[i].id == id) {
                    item = parent.child[i];
                    index = i;
                    break;
                }
            }
            if (item) {
                parent.child.splice(index, 1);
                if (val == -1) {
                    parent.child.splice((index == 0) ? parent.child.length : (index - 1), 0, item);
                } else {
                    parent.child.splice((index == parent.child.length) ? 0 : (index + 1), 0, item);
                }
                design.initItems();
                $("#" + id).click();
            }
        },
        //初始化拖动标签类型
        initDrag: function () {
            var list = [];
            $("#d_left img").unbind("mouseover").bind("mouseover", function () {
                if (design.currDragItem.node) {
                    design.currDragItem.node.remove();
                    design.currDragItem.node = null;
                }
                design.currDragItem.node = $($(this)[0].outerHTML)
                    .css({ position: "absolute", top: $(this).offset().top, left: $(this).offset().left, zIndex: 9999 })
                    .mousedown(function (e) {
                        $(this).css({ width: design.currDragItem.width, height: design.currDragItem.height, top: e.clientY - design.currDragItem.height / 2, left: e.clientX - design.currDragItem.width / 2 });
                        design.setItemsArea();
                    })
                    .draggable({
                        start: function (event, ui) {
                            list = design.getListItems(design.panel.child);
                        },
                        drag: function (event, ui) {
                            design.draggable_drag(list, event, ui);
                        },
                        stop: function (event, ui) {
                            var that = $(this);
                            var type = that.attr("type");
                            design.removeDragArea();
                            var en = design.draggable_stop(list, event, ui, type);
                            if (en) {
                                var control = design.findControlByType(en.type);
                                if (control && control.afterNewEntity) {
                                    control.afterNewEntity(en, design);
                                } else {
                                    design.initItems();
                                    $("#" + type + en.id).click();
                                }
                            }
                            that.remove();
                        },
                    })
                    .appendTo($(this).parent());
            });
        },
        //根据类型查找控件
        findControlByType: function (type) {
            for (var i = 0; i < options.controls.length; i++) {
                if (options.controls[i].type == type)
                    return options.controls[i];
            }
            return null;
        },
        //删除编辑项，如果传入id列表，则根据id删除，否则根据选择的项目删除 deltype 0删除元素和布局  1仅删除元素
        deleteItems: function (deltype, idlist) {
            var ids = [];
            if (!idlist) {
                var nodes = $(".selectItem");
                if (!nodes || nodes.length == 0)
                    return;
                nodes.each(function () {
                    ids.push($(this).attr("id"));
                });
            } else {
                ids = idlist;
            }
            if (ids == 0)
                return;
            var pids = [];
            var data = JSON.parse(JSON.stringify(design.panel));
            data.child = [];
            var appendData = function (_new, _old) {
                for (var i = 0; i < _old.child.length; i++) {
                    if (ids.indexOf(_old.child[i].type + _old.child[i].id) == -1) {
                        var _child = JSON.parse(JSON.stringify(_old.child[i]));
                        _child.child = [];
                        appendData(_child, _old.child[i]);
                        _new.child.push(_child);
                    } else {
                        //要删除的
                        var control = design.findControlByType(_old.child[i].type);
                        if (control && control.beforeDelete)
                            control.beforeDelete(_old.child[i], design);

                        //如果删除了最后一个子集，父级也删除掉
                        if (_old.child.length == 1 && _old.type == "div")
                            pids.push(_old.type + _old.id);
                    }
                }
            }
            appendData(data, design.panel);
            design.panel = data;
            if (pids.length == 0 || deltype == 1)
                design.initItems();
            else
                design.deleteItems(0, pids);
        },
        //移除预览的浮动层
        removeDragArea: function () {
            if (design.floatDragArea) {
                design.floatDragArea.remove();
                design.floatDragArea = null;
            }
        },
        //鼠标是否在区域
        mouseInArea: function (event, area) {
            return (event.clientX > area.left && event.clientY > area.top && event.clientX < area.left + area.width && event.clientY < area.top + area.height);
        },
        //拖动项是否跨两个区域
        dragInDoubleArea: function (event, ui, item) {
            var items = item.child;
            if (!items || items.length == 0)
                return null;
            if (items.length == 1)
                return design.dragInDoubleArea(event, ui, items[0]);
            if (items[0].attr.hShow) {
                //上下排列
                for (var i = 0; i < items.length; i++) {
                    if (ui.position.top > items[i].area.top && ui.position.top < items[i].area.top + items[i].area.height
                        && i < items.length - 1
                        && ui.position.top + design.currDragItem.height > items[i + 1].area.top && ui.position.top + design.currDragItem.height < items[i + 1].area.top + items[i + 1].area.height
                        && (Math.abs(event.clientY - items[i].area.height - items[i].area.top) < design.currDragItem.height / 3 && event.clientX > items[i].area.left && event.clientX < items[i].area.left + items[i].area.width)) {
                        return {
                            data: item, a: i, b: i + 1, t: "height"
                        };
                    }
                }
                for (var i = 0; i < items.length; i++) {
                    var data = design.dragInDoubleArea(event, ui, items[i]);
                    if (data != null)
                        return data;
                }
            } else if (items[0].attr.wShow) {
                //左右排列
                for (var i = 0; i < items.length; i++) {
                    if (ui.position.left > items[i].area.left && ui.position.left < items[i].area.left + items[i].area.width
                        && i < items.length - 1
                        && ui.position.left + design.currDragItem.width > items[i + 1].area.left && ui.position.left + design.currDragItem.width < items[i + 1].area.left + items[i + 1].area.width
                        && (Math.abs(event.clientX - items[i].area.width - items[i].area.left) < design.currDragItem.width / 3 && event.clientY > items[i].area.top && event.clientY < items[i].area.top + items[i].area.height)) {
                        return {
                            data: item, a: i, b: i + 1, t: "width"
                        };
                    }
                }
                for (var i = 0; i < items.length; i++) {
                    var data = design.dragInDoubleArea(event, ui, items[i]);
                    if (data != null)
                        return data;
                }
            } else {
                layer.open({ content: '计算出错了,错误代码:001！' });
            }
            return null;
        },
        //拖动时的预览
        draggable_drag: function (list, event, ui) {
            //如果是空的面板，直接添加，100%大小
            if (!design.panel.child || design.panel.child.length == 0) {
                design.mouseInArea(event, design.panel.area) ? design.dragArea(design.panel.area) : design.removeDragArea();
                return;
            }
            //判断是否在两个同级块中间
            var result = design.dragInDoubleArea(event, ui, design.panel.child[0]);
            if (result != null) {
                var info = design.itemChildInfo(result.data, function (child) {
                    return child.attr[result.t + "Unit"] != 3;
                });
                var begin = result.data.child[result.a];
                var end = result.data.child[result.b];
                var val = 0;
                if ((result.t == "width" && begin.attr.widthUnit == 0 && end.attr.widthUnit == 0) || (result.t == "height" && begin.attr.heightUnit == 0 && end.attr.heightUnit == 0)) {
                    //两个区域是像素的情况，直接均分
                    val = (begin.area[result.t] + end.area[result.t]) / 3;
                } else if ((result.t == "width" && begin.attr.widthUnit == 1 && end.attr.widthUnit == 1) || (result.t == "height" && begin.attr.heightUnit == 1 && end.attr.heightUnit == 1)) {
                    //两个区域是百分比的情况，直接均分
                    val = (begin.area[result.t] + end.area[result.t]) / 3;
                } else if (!info[result.t + "_auto"] && info[result.t] < result.data.area[result.t + "Content"]) {
                    //如果没有填充元素，并且还有区域是空白，则创建一个填充元素的大小
                    val = result.data.area[result.t + "Content"] - info[result.t];
                } else if (result.data.attr.overflowY == "auto") {
                    //判断是否允许内容超出，如果允许则均分
                    val = (begin.area[result.t] + end.area[result.t]) / 3;
                } else {
                    //没有可用区域
                    design.removeDragArea();
                    return;
                }
                if (result.t == "height") {
                    //上下排列
                    design.dragArea({
                        width: begin.area.width,
                        height: val,
                        top: begin.area.top + begin.area.height - begin.area.height / (begin.area.height + end.area.height) * val,
                        left: begin.area.left
                    }, 0.6);
                } else {
                    //左右排列 
                    design.dragArea({
                        width: val,
                        height: begin.area.height,
                        top: begin.area.top,
                        left: begin.area.left + begin.area.width - begin.area.width / (begin.area.width + end.area.width) * val
                    }, 0.6);
                }
                return;
            }
            //获取包含 拖动的块的最大层级,看是否包含在层内
            var item;
            var index = 0;
            for (var i = 0; i < list.length; i++) {
                if (design.mouseInArea(event, list[i].area)) {
                    if (list[i].index > index) {
                        index = list[i].index;
                        item = list[i];
                    }
                }
            }
            if (!item) {
                design.removeDragArea();
                return;
            }
            if (item.child.length == 0) {
                //如果当前层没有子集，则创建两个子集，5 5分，判断当前块的中点在 item中的什么区域
                if (event.clientX < item.area.left + item.area.width / 2) {
                    if (ui.position.top + design.currDragItem.height < item.area.top + item.area.height / 2) {
                        //如果 当前块 底部 在item中点上 上面
                        design.dragArea({ width: item.area.width, height: item.area.height / 2, top: item.area.top, left: item.area.left }, 0.6);
                    } else if (ui.position.top > item.area.top + item.area.height / 2) {
                        //如果 当前块 顶部 在item中点下 下面
                        design.dragArea({ width: item.area.width, height: item.area.height / 2, top: item.area.top + item.area.height / 2, left: item.area.left }, 0.6);
                    } else {
                        //在左边
                        design.dragArea({ width: item.area.width / 2, height: item.area.height, top: item.area.top, left: item.area.left }, 0.6);
                    }
                } else {
                    if (ui.position.top + design.currDragItem.height < item.area.top + item.area.height / 2) {
                        //如果 当前块 底部 在item中点上 上面
                        design.dragArea({ width: item.area.width, height: item.area.height / 2, top: item.area.top, left: item.area.left }, 0.6);
                    } else if (ui.position.top > item.area.top + item.area.height / 2) {
                        //如果 当前块 顶部 在item中点下 下面
                        design.dragArea({ width: item.area.width, height: item.area.height / 2, top: item.area.top + item.area.height / 2, left: item.area.left }, 0.6);
                    } else {
                        //在右边
                        design.dragArea({ width: item.area.width / 2, height: item.area.height, top: item.area.top, left: item.area.left + item.area.width / 2 }, 0.6);
                    }
                }
            } else {
                //如果当前层有子集，看还有没有剩余区域
                var info = design.itemChildInfo(item);
                if (item.child[0].attr.wShow) {
                    //横向 创建一个填充的div，如果子集全是百分比，则创建一个百分比的div
                    if (info.width < item.area.widthContent) {
                        design.dragArea({ width: item.area.width - info.width, height: item.area.height, top: item.area.top, left: item.area.left + info.width });
                    }
                } else {
                    //纵向 创建一个填充的div，如果子集全是百分比，则创建一个百分比的div
                    if (info.height < item.area.heightContent) {
                        design.dragArea({ width: item.area.width, height: item.area.height - info.height, top: item.area.top + info.height, left: item.area.left });
                    }
                }
            }
        },
        //拖动结束，判断位置是否合适，添加到面板，并返回该位置的实体信息
        draggable_stop: function (list, event, ui, type) {
            var en;
            //如果是空的面板，直接添加，100%大小
            if (!design.panel.child || design.panel.child.length == 0) {
                if (design.mouseInArea(event, design.panel.area)) {
                    en = design.newEntity(type, 2, 100, 100, 1, 1, false, false);
                    design.panel.child.push(en);
                    return en;
                }
                return null;
            }
            //判断是否在两个同级块中间
            var result = design.dragInDoubleArea(event, ui, design.panel.child[0]);
            if (result != null) {
                var info = design.itemChildInfo(result.data, function (child) {
                    return child.attr[result.t + "Unit"] != 3;
                });
                var begin = result.data.child[result.a];
                var end = result.data.child[result.b];
                if ((result.t == "width" && begin.attr.widthUnit == 0 && end.attr.widthUnit == 0) || (result.t == "height" && begin.attr.heightUnit == 0 && end.attr.heightUnit == 0)) {
                    //如果在两个同级块中间，两边都是像素，如果有足够的空间则不用平分，没有足够空间平分像素的方式计算
                    var _sum = begin.area[result.t] + end.area[result.t];
                    var _val = parseInt(_sum / 3);
                    //判断空间是否足够
                    if (info[result.t] + _val > result.data.area[result.t + "Content"]) {
                        begin.attr[result.t] = parseInt(begin.area[result.t] * 0.6666);
                        end.attr[result.t] = parseInt(end.area[result.t] * 0.6666);
                        while (_val + begin.attr[result.t] + end.attr[result.t] < _sum) {
                            _val++;
                        }
                    }
                    if (result.t == "height") {
                        //上下排列
                        en = design.newEntity(type, begin.index, begin.attr.width, _val, begin.attr.widthUnit, begin.attr.heightUnit, begin.attr.wShow, begin.attr.hShow);
                    } else {
                        //左右排列 
                        en = design.newEntity(type, begin.index, _val, begin.attr.height, begin.attr.widthUnit, begin.attr.heightUnit, begin.attr.wShow, begin.attr.hShow);
                    }
                } else if ((result.t == "width" && begin.attr.widthUnit == 1 && end.attr.widthUnit == 1) || (result.t == "height" && begin.attr.heightUnit == 1 && end.attr.heightUnit == 1)) {
                    //如果在两个同级块中间，两边都是百分比，如果有足够的空间则不用平分，没有足够空间平分百分比的方式计算
                    //新的几个区域所占大小
                    var px_val = begin.area[result.t] + end.area[result.t];
                    //中间的百分比大小
                    var center_val = parseInt((px_val / 3) / result.data.area[result.t + "Content"] * 100);
                    //判断空间是否足够
                    if (info[result.t] + parseInt(px_val / 3) > result.data.area[result.t + "Content"]) {
                        //新的几个区域所占大小百分比
                        var rate_val = begin.attr[result.t] + end.attr[result.t];
                        //前面一个的百分比大小
                        begin.attr[result.t] = parseInt(begin.area[result.t] * 0.6666 / result.data.area[result.t + "Content"] * 100);
                        //后面一个的百分比大小
                        end.attr[result.t] = parseInt(end.area[result.t] * 0.6666 / result.data.area[result.t + "Content"] * 100);
                        //这个3个加起来要等于 新的几个区域所占百分比，如果不满足 追加0.01
                        while (begin.attr[result.t] + center_val + end.attr[result.t] < rate_val) {
                            center_val = parseFloat((center_val + 0.01).toFixed(2));
                            if (begin.attr[result.t] + center_val + end.attr[result.t] < rate_val)
                                begin.attr[result.t] = parseFloat((begin.attr[result.t] + 0.01).toFixed(2));
                            if (begin.attr[result.t] + center_val + end.attr[result.t] < rate_val)
                                end.attr[result.t] = parseFloat((end.attr[result.t] + 0.01).toFixed(2));
                        }
                    }
                    if (result.t == "height") {
                        //上下排列
                        en = design.newEntity(type, begin.index, begin.attr.width, center_val, begin.attr.widthUnit, begin.attr.heightUnit, begin.attr.wShow, begin.attr.hShow);
                    } else {
                        //左右排列
                        en = design.newEntity(type, begin.index, center_val, begin.attr.height, begin.attr.widthUnit, begin.attr.heightUnit, begin.attr.wShow, begin.attr.hShow);
                    }
                } else if (!info[result.t + "_auto"] && info[result.t] < result.data.area[result.t + "Content"]) {
                    //如果没有填充元素，并且还有区域是空白，则创建一个填充元素
                    if (result.t == "height")
                        en = design.newEntity(type, begin.index + 1, 100, 50, 1, 3, false, true);
                    else
                        en = design.newEntity(type, begin.index + 1, 50, 100, 3, 1, true, false);
                } else if (result.data.attr.overflowY == "auto") {
                    //判断是否允许内容超出，如果允许则均分,创建一个px元素
                    if (result.t == "height")
                        en = design.newEntity(type, begin.index + 1, 100, parseInt((begin.area[result.t] + end.area[result.t]) / 3), 1, 0, false, true);
                    else
                        en = design.newEntity(type, begin.index + 1, parseInt((begin.area[result.t] + end.area[result.t]) / 3), 100, 0, 1, true, false);
                } else {
                    //没有可用区域
                    return null;
                }
                result.data.child.splice(result.b, 0, en);
                return en;
            }
            //获取包含 拖动的块的最大层级,看是否包含在层内
            var item;
            var index = 0;
            for (var i = 0; i < list.length; i++) {
                if (design.mouseInArea(event, list[i].area)) {
                    if (list[i].index > index) {
                        index = list[i].index;
                        item = list[i];
                    }
                }
            }
            if (!item) return null;
            var parent = design.findItemById(item.type + item.id);
            if (item.child.length == 0) {
                //和item 5 5分，判断当前块的中点在 item中的什么区域
                //通用属性，留给上级，私有属性留给新的下级
                if (event.clientX < item.area.left + item.area.width / 2) {
                    if (ui.position.top + design.currDragItem.height < item.area.top + item.area.height / 2) {
                        //如果 当前块 底部 在item中点上 上面
                        en = design.newEntity(type, item.index + 1, 100, 50, 1, 1, false, true);
                        parent.child.push(en);
                        parent.child.push(design.newExtEntity(item.index + 1, 100, 50, parent));
                    } else if (ui.position.top > item.area.top + item.area.height / 2) {
                        //如果 当前块 顶部 在item中点下 下面
                        parent.child.push(design.newExtEntity(item.index + 1, 100, 50, parent));
                        en = design.newEntity(type, item.index + 1, 100, 50, 1, 1, false, true);
                        parent.child.push(en);
                    } else {
                        //在左边
                        en = design.newEntity(type, item.index + 1, 50, 100, 1, 1, true, false);
                        parent.child.push(en);
                        parent.child.push(design.newExtEntity(item.index + 1, 50, 100, parent));
                    }
                } else {
                    if (ui.position.top + design.currDragItem.height < item.area.top + item.area.height / 2) {
                        //如果 当前块 底部 在item中点上 上面
                        en = design.newEntity(type, item.index + 1, 100, 50, 1, 1, false, true);
                        parent.child.push(en);
                        parent.child.push(design.newExtEntity(item.index + 1, 100, 50, parent));
                    } else if (ui.position.top > item.area.top + item.area.height / 2) {
                        //如果 当前块 顶部 在item中点下 下面
                        parent.child.push(design.newExtEntity(item.index + 1, 100, 50, parent));
                        en = design.newEntity(type, item.index + 1, 100, 50, 1, 1, false, true);
                        parent.child.push(en);
                    } else {
                        //在右边
                        parent.child.push(design.newExtEntity(item.index + 1, 50, 100, parent));
                        en = design.newEntity(type, item.index + 1, 50, 100, 1, 1, true, false);
                        parent.child.push(en);
                    }
                }
            } else {
                //如果当前层有子集，看还有没有剩余区域
                var info = design.itemChildInfo(item);
                if (item.child[0].attr.wShow) {
                    //横向 创建一个填充的div，如果子集全是百分比，则创建一个百分比的div,否则判断是否有填充，没有则创建填充，否则创建像素
                    if (info.width < item.area.widthContent) {
                        if (info.w_rate && info.width_attr < 100) {
                            //添加百分比
                            en = design.newEntity(type, item.index + 1, 100 - info.width_attr, 100, 1, 1, true, false);
                        } else if (!info.width_auto) {
                            //添加填充
                            en = design.newEntity(type, item.index + 1, 50, 100, 3, 1, true, false);
                        } else {
                            //添加像素
                            en = design.newEntity(type, item.index + 1, item.area.widthContent - info.width, 100, 0, 1, true, false);
                        }
                        parent.child.push(en);
                    }
                } else {
                    //纵向 创建一个填充的div，如果子集全是百分比，则创建一个百分比的div,否则判断是否有填充，没有则创建填充，否则创建像素
                    if (info.height < item.area.heightContent) {
                        if (info.h_rate && info.height_attr < 100) {
                            //添加百分比
                            en = design.newEntity(type, item.index + 1, 100, 100 - info.height_attr, 1, 1, false, true);
                        } else if (!info.height_auto) {
                            //添加填充
                            en = design.newEntity(type, item.index + 1, 100, 50, 1, 3, false, true);
                        } else {
                            //添加像素
                            en = design.newEntity(type, item.index + 1, 100, item.area.heightContent - info.height, 1, 0, false, true);
                        }
                        parent.child.push(en);
                    }
                }
            }
            return en;
        },
        //获取当前选择的编辑项的实体信息
        getSelectItem: function () {
            return design.findItemById($("#ddllables").val());
        },
        //创建一个从父类继承的实体，用于一分为二
        newExtEntity: function (index, width, height, parent) {
            var en = design.newEntity(parent.type, index, width, height, 1, 1, !(width == 100), !(height == 100));
            var newid = en.id;
            en.id = parent.id;
            parent.id = newid;
            en.contentAttr = parent.contentAttr;
            en.events = parent.events;
            parent.type = "div";
            parent.attr = {
                width: parent.attr.width,
                height: parent.attr.height,
                widthUnit: parent.attr.widthUnit,
                heightUnit: parent.attr.heightUnit,
                wShow: parent.attr.wShow,
                hShow: parent.attr.hShow
            };
            parent.contentAttr = {
            };
            parent.events = [];
            var control = design.findControlByType(parent.type);
            if (control) {
                parent.contentAttr.id = "ctl_" + parent.type + parent.id;
                parent.contentAttr.labname = control.title + parent.id;
                if (control.newEntity)
                    control.newEntity(parent, design);
            }
            return en;
        },
        //创建一个新的实体
        newEntity: function (type, index, width, height, widthUnit, heightUnit, wShow, hShow) {
            var en = {
                id: design.getMaxId() + 1,
                index: index,//层级
                type: type,//类型(所有的都是div 嵌套一个 type元素)
                //私有属性
                contentAttr: {
                },
                events: [],
                child: [],//子集，注意子集不是type内容，而是嵌套的div
                area: {
                },//当前div区域
                //公共属性
                attr: {
                    width: width,
                    height: height,
                    widthUnit: widthUnit,
                    heightUnit: heightUnit,
                    wShow: wShow,
                    hShow: hShow
                }
            };
            //调用控件的初始化方法
            var control = design.findControlByType(en.type);
            if (control) {
                en.contentAttr.id = "ctl_" + type + en.id;
                en.contentAttr.labname = control.title + en.id;
                if (control.newEntity)
                    control.newEntity(en, design);
            }
            return en;
        },
        //以集合形势获取添加的项，而非层级关系
        getListItems: function (items) {
            var array = [];
            if (!items || items.length == 0)
                return array;
            for (var i = 0; i < items.length; i++) {
                array.push({
                    id: items[i].id,
                    type: items[i].type,
                    index: items[i].index,
                    area: items[i].area,
                    child: JSON.parse(JSON.stringify(items[i].child)),
                    attr: items[i].attr,
                    contentAttr: items[i].contentAttr
                });
                array.push.apply(array, design.getListItems(items[i].child));
            }
            return array;
        },
        //根据id获取实体
        findItemById: function (id, items) {
            if (!items)
                items = [design.panel];
            var item;
            for (var i = 0; i < items.length; i++) {
                if (items[i].type + items[i].id == id) {
                    item = items[i];
                    break;
                }
                item = design.findItemById(id, items[i].child);
                if (item)
                    break;
            }
            return item;
        },
        //根据id获取上级
        findParentById: function (id, parent) {
            if (!parent)
                parent = design.panel;
            var item;
            for (var i = 0; i < parent.child.length; i++) {
                if (parent.child[i].type + parent.child[i].id == id) {
                    item = parent;
                    break;
                }
                item = design.findParentById(id, parent.child[i]);
                if (item)
                    break;
            }
            return item;
        },
        //获取最大的id
        getMaxId: function (items) {
            if (!items)
                items = [design.panel];
            var id = 0;
            for (var i = 0; i < items.length; i++) {
                if (items[i].id > id) {
                    id = items[i].id;
                }
                var cid = design.getMaxId(items[i].child);
                if (cid > id) {
                    id = cid;
                }
            }
            return id;
        },
        //编辑项的双击事件
        itemDBLClick: function (e) {
            clearTimeout(design.itemMove.timer);
            e.preventDefault();
            e.stopPropagation();
            var node = $(this);
            var en = design.findItemById(node.attr("id"));
            if (!en)
                return;
            var control = design.findControlByType(en.type);
            if (control.onDblClick)
                control.onDblClick(en, design);
        },
        //编辑项的点击事件
        itemClick: function (e) {
            clearTimeout(design.itemMove.timer);
            e.preventDefault();
            e.stopPropagation();
            var node = $(this);
            var en = design.findItemById(node.attr("id"));
            if (!en)
                return;
            if (design.batchChoice || (window.event && window.event.ctrlKey)) {
                //同类型可多选
                if (node.hasClass("selectItem")) {
                    node.removeClass("selectItem");
                    return;
                }
                var sibling = $(".selectItem").first();
                if (sibling && sibling.length > 0) {
                    sibling = design.findItemById(sibling.attr("id"));
                    if (sibling.type != en.type || sibling.wShow != en.wShow || sibling.hShow != en.hShow)
                        $(".selectItem").removeClass("selectItem");
                }
                node.addClass("selectItem");
            } else {
                //单选
                $(".selectItem").removeClass("selectItem");
                node.addClass("selectItem");
            }
            //创建编辑属性
            var control = design.findControlByType(en.type);
            if (control) {
                design.createAttr("commonAttr", design.commonAttributes, en);
                design.createAttr("controlAttr", control.attributes ? control.attributes(design, en) : [], en);
            }
            if (control.onClick)
                control.onClick(en, design);

            var pid = $("#panel1").parent().attr("id");
            var str = "";
            while (node.attr("id") != pid) {
                str += "<option value='" + node.attr("id") + "'>" + node.attr("labname") + "</option>";
                node = node.parent();
            }
            $("#ddllables").html(str);
        },
        //拖动面板中的编辑项
        itemMove: {
            e: null,//拖动的事件
            timer: null,//延迟启动事件
            node: null,//拖动的对象
            en: null,//拖动的实体信息
            init: function () {
                if (design.itemMove.node) {
                    design.itemMove.node.remove();
                    design.itemMove.node = null;
                    design.itemMove.en = null;
                }
            },
            start: function () {
                design.itemMove.init();
                //拖动后，删除面板中的编辑项
                design.deleteItems(0, [design.itemMove.en.type + design.itemMove.en.id]);
                //获取剩余的编辑项列表
                var list = design.getListItems(design.panel.child);
                design.itemMove.node = $($("#d_left img[type='" + design.itemMove.en.type + "']")[0].outerHTML)
                .css({ position: "absolute", zIndex: 9999, width: design.currDragItem.width, height: design.currDragItem.height, top: design.itemMove.e.clientY - design.currDragItem.height / 2, left: design.itemMove.e.clientX - design.currDragItem.width / 2 })
                .mousemove(function (e) {
                    //鼠标移动时，预览
                    var position = {
                        top: e.clientY - design.currDragItem.height / 2, left: e.clientX - design.currDragItem.width / 2
                    };
                    design.itemMove.node.css(position);
                    design.draggable_drag(list, e, {
                        position: position
                    });
                    e.preventDefault();
                    e.stopPropagation();
                })
                .mouseup(function (e) {
                    //鼠标松开时添加到面板中
                    e.preventDefault();
                    e.stopPropagation();
                    design.removeDragArea();
                    var position = {
                        top: e.clientY - design.currDragItem.height / 2, left: e.clientX - design.currDragItem.width / 2
                    };
                    var en = design.draggable_stop(list, e, {
                        position: position
                    }, design.itemMove.en.type);
                    if (en) {
                        //除去位置属性，其他的属性都用原来的
                        en.id = design.itemMove.en.id;
                        en.contentAttr = design.itemMove.en.contentAttr;
                        en.events = design.itemMove.en.events;
                        var array = ["width", "height", "widthUnit", "heightUnit", "wShow", "hShow"];
                        for (var field in design.itemMove.en.attr) {
                            if (array.indexOf(field) == -1)
                                en.attr[field] = design.itemMove.en.attr[field];
                        }
                        design.initItems();
                        $("#" + en.type + en.id).click();
                    }
                    design.itemMove.init();
                }).appendTo($("#d_left"));
            }
        },
        //添加项目
        addItem: function (parent, en) {
            var node = $("<div id='" + en.type + en.id + "' index='" + en.index + "' class='pageItem'></div>").appendTo(parent);
            if (!options.ispreview) {
                node.addClass("unselectItem");
                node.click(design.itemClick)
                .dblclick(design.itemDBLClick)
                .mousedown(function (e) {
                    if (e.button != 0)
                        return;
                    var en = design.findItemById($(this).attr("id"));
                    if (en && en.child.length == 0) {
                        clearTimeout(design.itemMove.timer);
                        design.itemMove.e = e;
                        design.itemMove.timer = setTimeout(function () {
                            design.itemMove.en = en;
                            design.itemMove.start(e);
                        }, 400);
                    }
                }).mouseup(function (e) {
                    clearTimeout(design.itemMove.timer);
                });
            }
            design.itemAttr(node, en);
            design.setItemArea(node, en);
            return node;
        },
        //拖动预览层的区域
        dragArea: function (area, opacity) {
            if (opacity == undefined)
                opacity = 1;
            if (!design.floatDragArea)
                design.floatDragArea = $("<div></div>").appendTo($("body"));
            area.backgroundColor = "#a1d8f8";
            design.floatDragArea.css({
                position: "absolute",
                zIndex: 9998,
                backgroundColor: "#a1d8f8",
                width: area.width,
                height: area.height,
                top: area.top,
                left: area.left,
                opacity: opacity
            });
        },
        //缩放
        zoom: function (rate, showmsg) {
            if (rate < 0.1) {
                layer.open({ content: '不能在小了' });
                return;
            }
            if (showmsg)
                layer.msg(rate + "倍");
            var ids = [];
            var nodes = $(".selectItem");
            if (nodes && nodes.length > 0)
                nodes.each(function () {
                    ids.push($(this).attr("id"))
                });
            design.panel.contentAttr.rate = rate;
            design.initPanel(true);
            design.initItems(true);
            design.selectItemsByIds(ids);
        },
        //设置单个编辑项的区域
        setItemArea: function (node, en) {
            if (!en.area)
                en.area = {};
            en.area.width = node.outerWidth();
            en.area.height = node.outerHeight();
            en.area.widthContent = node.width();
            en.area.heightContent = node.height();
            en.area.top = node.offset().top;
            en.area.left = node.offset().left;
        },
        //设置多个编辑项区域
        setItemsArea: function (items) {
            if (!items) {
                design.setItemArea($("#panel1"), design.panel);
                items = design.panel.child;
            }
            for (var i = 0; i < items.length; i++) {
                var node = $("#" + items[i].type + items[i].id);
                if (node.length == 1)
                    design.setItemArea(node, items[i]);
                design.setItemsArea(items[i].child);
            }
        },
        //编辑内容属性
        editContentAttr: function (name, value) {
            var nodes = $(".selectItem");
            if (!nodes || nodes.length == 0)
                return;
            var initItems = false;
            var ids = [];
            nodes.each(function () {
                var en = design.findItemById($(this).attr("id"));
                ids.push(en.type + en.id);
                if (value === undefined)
                    delete en.contentAttr[name];
                else
                    en.contentAttr[name] = value;
            });
            design.initItems();
            design.selectItemsByIds(ids);
        },
        //根据id列表，选中项目
        selectItemsByIds: function (ids) {
            design.batchChoice = true;
            for (var i = 0; i < ids.length; i++) {
                $("#" + ids[i]).click();
            }
            design.batchChoice = false;
        },
        //设置选中的元素的样式
        editItemAttr: function (name, value) {
            var nodes = $(".selectItem");
            if (!nodes || nodes.length == 0)
                return;
            //是否需要重新加载编辑项
            var is_reload = false;
            //选择的项目id
            var ids = [];
            if (name == "width" || name == "height")
                is_reload = true;

            nodes.each(function () {
                var node = $(this);
                var parent = design.findItemById(node.parent().attr("id"));
                var en = design.findItemById(node.attr("id"));
                if (en.type == "panel") {
                    en.attr[name] = value;
                    design.initPanel(true);
                    node.click();
                    return;
                }
                ids.push(en.type + en.id);
                //判断是否允许内容超出区域高度
                if (name == "overflowY" && value != "auto") {
                    var _sum = 0;
                    for (var i = 0; i < en.child.length; i++) {
                        _sum += en.child[i].area.height;
                    }
                    if (_sum > parent.area.heightContent) {
                        node.click();
                        layer.open({ content: '内容已经超出区域高度,请先设置内容高度！' });
                        return;
                    }
                }
                if (name == "widthUnit" || name == "heightUnit") {
                    is_reload = true;
                    //判断widthUnit或heightUnit在同级元素中只能存在一个
                    if (value == 3) {
                        for (var i = 0; i < parent.child.length; i++) {
                            if (parent.child[i].attr[name] == 3 && parent.child[i].type + parent.child[i].id != en.type + en.id) {
                                node.click();
                                layer.open({ content: '同级元素中只允许存在一个填充项！' });
                                return;
                            }
                        }
                    }
                }
                //记录原属性值
                var oldValue = en.attr[name];
                //改变属性值
                if (value === undefined) {
                    delete en.attr[name];
                } else {
                    en.attr[name] = value;
                }
                //设置样式和属性
                design.itemAttr(node, en);
                //计算区域，用于下面填充计算
                design.setItemArea(node, en);
                //填充
                design.fillItems(parent);
                //判断是否允许内容超出区域
                var info = design.itemChildInfo(parent);
                if (en.attr.wShow) {
                    if (parent.attr.overflowX != "auto") {
                        if (info.width > parent.area.widthContent) {
                            en.attr[name] = oldValue;
                            //重新设置样式和属性，恢复原值
                            design.itemAttr(node, en);
                            //重新计算区域，恢复原值
                            design.setItemArea(node, en);
                            //重新填充
                            design.fillItems(parent);
                            //不允许内容超出区域高度
                            node.click();
                            layer.open({ content: '不允许内容超出区域宽度！' });
                            return;
                        }
                    }
                } else if (en.attr.hShow) {
                    if (parent.attr.overflowY != "auto") {
                        if (info.height > parent.area.heightContent) {
                            en.attr[name] = oldValue;
                            //重新设置样式和属性，恢复原值
                            design.itemAttr(node, en);
                            //重新计算区域，恢复原值
                            design.setItemArea(node, en);
                            //重新填充
                            design.fillItems(parent);
                            //不允许内容超出区域高度
                            node.click();
                            layer.open({ content: '不允许内容超出区域高度！' });
                            return;
                        }
                    }
                }
            });
            if (is_reload) {
                design.initItems();
                design.selectItemsByIds(ids);
            }
            else
                design.setItemsArea();
        },
        //获取填充区最小宽度
        fillItemMinWidth: function (item) {
            var val = 0;
            for (var i = 0; i < item.child.length; i++) {
                if (item.child[i].attr.wShow) {
                    if (item.child[i].attr.widthUnit == 0)
                        val += item.child[i].attr.width;
                    else if (item.child[i].attr.widthUnit == 2)
                        val += item.child[i].area.width;
                    else
                        val += design.fillItemMinWidth(item.child[i]);
                }
            }
            return val;
        },
        //获取填充区最小高度
        fillItemMinHeight: function (item) {
            var val = 0;
            for (var i = 0; i < item.child.length; i++) {
                if (item.child[i].attr.hShow) {
                    if (item.child[i].attr.heightUnit == 0)
                        val += item.child[i].attr.height;
                    else if (item.child[i].attr.heightUnit == 2)
                        val += item.child[i].area.height;
                    else
                        val += design.fillItemMinHeight(item.child[i]);
                }
            }
            return val;
        },
        //编辑项和子集信息，用于计算，代码重用
        itemChildInfo: function (item, filter) {
            var en = {
                width: 0,//实际大小px
                height: 0,
                width_attr: 0,//属性大小
                height_attr: 0,
                w_rate: true,//true 全百分比
                h_rate: true,
                width_auto: false,//false 不含填充
                height_auto: false
            };
            if (item) {
                for (var i = 0; i < item.child.length; i++) {
                    if (en.w_rate)
                        en.w_rate = item.child[i].attr.widthUnit == 1;
                    if (en.h_rate)
                        en.h_rate = item.child[i].attr.heightUnit == 1;
                    if (!en.width_auto && item.child[i].attr.widthUnit == 3)
                        en.width_auto = true;
                    if (!en.height_auto && item.child[i].attr.heightUnit == 3)
                        en.height_auto = true;
                    if (filter && !filter(item.child[i]))
                        continue;
                    en.width += item.child[i].area.width;
                    en.height += item.child[i].area.height;
                    en.width_attr += item.child[i].attr.width;
                    en.height_attr += item.child[i].attr.height;
                }
            }
            return en;
        },
        //填充编辑项，填充的元素要等同级别元素计算完后，最后才计算
        fillItems: function (item) {
            if (!item)
                return;
            for (var i = 0; i < item.child.length; i++) {
                if (item.child[i].attr.widthUnit == 3) {
                    var info = design.itemChildInfo(item, function (child) {
                        return child.attr.widthUnit != 3;
                    });
                    var node = $("#" + item.child[i].type + item.child[i].id);
                    design.itemAttr(node, item.child[i]);
                    //填充区的宽度
                    var val = parseInt(item.area.widthContent - info.width);
                    //获取填充区最小宽度
                    var min = design.fillItemMinWidth(item.child[i]) + item.child[i].area.width - item.child[i].area.widthContent;
                    if (val < min)
                        val = min;
                    node.css({ width: val + "px" });
                    design.setItemArea(node, item.child[i]);
                }
                if (item.child[i].attr.heightUnit == 3) {
                    //获取非填充区高度
                    var info = design.itemChildInfo(item, function (child) {
                        return child.attr.heightUnit != 3;
                    });
                    var node = $("#" + item.child[i].type + item.child[i].id);
                    design.itemAttr(node, item.child[i]);
                    //填充区的高度
                    var val = parseInt(item.area.heightContent - info.height);
                    //获取填充区最小高度
                    var min = design.fillItemMinHeight(item.child[i]) + item.child[i].area.height - item.child[i].area.heightContent;
                    if (val < min)
                        val = min;
                    node.css({ height: val + "px" });
                    design.setItemArea(node, item.child[i]);
                }
            }
            for (var i = 0; i < item.child.length; i++) {
                design.fillItems(item.child[i]);
            }
        },
        //设置元素样式
        itemAttr: function (node, en) {
            var set = en.attr;
            if (!set)
                return;
            var css = {
            };
            //设置高度
            if (set.height != undefined) {
                if (set.heightUnit == 0) {
                    css.height = set.height + "px";
                }
                else if (set.heightUnit == 1) {
                    css.height = set.height + "%";
                }
                else if (set.heightUnit == 2) {//自适应
                    css.height = "auto";
                }
            }
            //设置宽度
            if (set.width != undefined) {
                if (set.widthUnit == 0) {
                    css.width = set.width + "px";
                }
                else if (set.widthUnit == 1) {
                    css.width = set.width + "%";
                }
                else if (set.widthUnit == 2) {//自适应
                    css.width = "auto";
                }
            }
            //设置文字 上中下线条
            var dec = "";
            if (set.overline == "1") {
                if (dec != "")
                    dec += " ";
                dec += "overline";
            }
            if (set.linethrough == "1") {
                if (dec != "")
                    dec += " ";
                dec += "line-through";
            }
            if (set.underline == "1") {
                if (dec != "")
                    dec += " ";
                dec += "underline";
            }
            css.textDecoration = (dec == "") ? "none" : dec;
            //其他属性
            $.each(["fontSize", "textAlign", "verticalAlign", "fontWeight", "color", "fontFamily", "position", "borderColor", "borderWidth", "letterSpacing",
                "borderStyle", "boxSizing", "padding", "margin", "fontStyle", "opacity", "lineHeight", "borderRadius", "overflowX", "overflowY"], function () {
                    if (set[this] != undefined && set[this] !== "" && set[this] != null) {
                        //行高和圆角是需要加上px单位
                        if (this == "lineHeight" || this == "borderRadius") {
                            css[this] = set[this] + "px";
                        } else {
                            css[this] = set[this];
                        }
                    }
                });
            //文字阴影
            if (set.textShadowMargin && set.textShadowColor)
                css.textShadow = set.textShadowMargin + " " + set.textShadowColor;
            else
                css.textShadow = "none";
            //背景
            if (set.backgroundColor) {
                if (set.bgOpacity == undefined)
                    set.bgOpacity = 1;
                css.backgroundColor = "rgba(" + parseInt("0x" + set.backgroundColor.slice(1, 3)) + "," + parseInt("0x" + set.backgroundColor.slice(3, 5)) + "," + parseInt("0x" + set.backgroundColor.slice(5, 7)) + "," + set.bgOpacity + ")";
            }
            //边框阴影
            if (set.boxShadowMargin && set.boxShadowColor) {
                if (set.boxShadowOpacity == undefined)
                    set.boxShadowOpacity = 1;
                css.boxShadow = set.boxShadowMargin + " rgba(" + parseInt("0x" + set.boxShadowColor.slice(1, 3)) + "," + parseInt("0x" + set.boxShadowColor.slice(3, 5)) + "," + parseInt("0x" + set.boxShadowColor.slice(5, 7)) + "," + set.boxShadowOpacity + ")";
            }
            node.removeAttr("style");
            node.css(css);

            //其他属性
            node.attr("labname", en.contentAttr.labname);
        },
        //创建属性控件
        createAttr: function (id, data, en) {
            var node = $("#" + id).empty();
            if (!en)
                return;
            if (!data || data.length == 0)
                return;
            var tab = $("<table class=\"attrtab\"></table>").appendTo(node);
            var tr = null;
            var newrow = true;
            for (var i = 0; i < data.length; i++) {
                if (data[i].show && !data[i].show(en))
                    continue;
                if (!data[i].remark)
                    data[i].remark = "";
                if (!data[i].title)
                    data[i].title = "";
                if (newrow)
                    tr = $("<tr></tr>").appendTo(tab);
                tr.append("<td class='tdtitle' title='" + data[i].remark + "'>" + data[i].title + "</td>");
                var td = null;
                if (data[i].colspan) {
                    td = $("<td class='tdvalue' title='" + data[i].remark + "' colspan='" + data[i].colspan + "'></td>");
                    newrow = false;
                }
                else {
                    td = $("<td class='tdvalue' title='" + data[i].remark + "'></td>");
                }
                if (!data[i].style)
                    data[i].style = "";
                td.appendTo(tr);
                var obj = null;
                if (data[i].control == "control-text") {
                    obj = $("<input" + data[i].style + " type=\"text\" class=\"control-text\" value=\"" + data[i].setdata(en) + "\"/>").appendTo(td);
                }
                else if (data[i].control == "control-tackcolor") {
                    obj = $("<input type=\"text\" class=\"control-text\" value=\"" + data[i].setdata(en) + "\"/>").appendTo(td);
                    obj.spectrum($.extend(design.tackColorSet, { hide: data[i].changecolor }));
                }
                else if (data[i].control == "control-select") {
                    var option_str = "";
                    var val = data[i].setdata(en);
                    if (data[i].data) {
                        for (var j = 0; j < data[i].data.length; j++) {
                            option_str += "<option value=\"" + data[i].data[j].value + "\"" + (data[i].data[j].value == val ? " selected='selected'" : "") + ">" + data[i].data[j].text + "</option>";
                        }
                    } else {
                        for (var j = data[i].min; j <= data[i].max; j++) {
                            option_str += "<option value=\"" + j + "\"" + (j == val ? " selected='selected'" : "") + ">" + j + "</option>";
                        }
                    }
                    obj = $("<select class='control-select'>" + option_str + "</select>").appendTo(td);
                }
                else if (data[i].control == "control-checkbox") {
                    obj = $("<input class=\"control-checkbox\" type=\"checkbox\"" + (data[i].setdata(en) ? " checked" : "") + " id=\"txt_" + en.type + i + "\" />").appendTo(td);
                    td.append("<label" + data[i].style + " for=\"txt_" + en.type + i + "\">" + data[i].label + "</label>");
                }
                else if (data[i].control == "control-ddlsearch") {
                    obj = $("<input type=\"text\" class=\"control-text\" tagtext=\"" + data[i].setdata(en, 'tagtext') + "\" tagvalue=\"" + data[i].setdata(en, 'tagvalue') + "\" value=\"" + data[i].setdata(en) + "\"/>").appendTo(td);
                } else {
                    obj = $(data[i].control).appendTo(td);
                }
                if (data[i].change)
                    obj.change(data[i].change);
                if (data[i].click)
                    obj.click(data[i].click);
                if (data[i].keyup)
                    obj.keyup(data[i].keyup);
                if (data[i].blur)
                    obj.blur(data[i].blur);
                newrow = !newrow;
            }
        },
        //取色器
        tackColorSet: {
            previewWidth: 71,
            containerClassName: "full-spectrum",
            preferredFormat: "hex",
            localStorageKey: "spectrumdata",
            palette: [],
            className: "tackcolor",
            cancelText: "取消",
            chooseText: "确定",
            clearText: "清除选择的颜色",
        },
        //是否正整数
        isInt: function (val) {
            return /^\d+$/.test(val);
        },
        //是否数字
        isNumber: function (val) {
            return /^[+-]?\d+(.\d+|\d*)$/.test(val);
        },
        //创建无限递归echart属性编辑器
        appendEchartTree: function (en, array) {
            var ul = "<ul>";
            for (var i = 0; i < array.length; i++) {
                if (array[i].child && array[i].child.length > 0) {
                    if (en[array[i].field] == undefined)
                        en[array[i].field] = {
                        };
                    ul += "<li field='" + array[i].field + "'><table><tr><td><span>" + array[i].title + "</span></td><td>" + design.appendEchartTree(en[array[i].field], array[i].child) + "</td></tr></table></li>";
                    continue;
                }
                ul += "<li field='" + array[i].field + "' type='" + array[i].type + "'><span>" + array[i].title + "</span>";
                if (en[array[i].field] == undefined)
                    en[array[i].field] = array[i].def;
                if (array[i].type == "checkbox") {
                    ul += "<input class='control-checkbox' type='checkbox'" + (en[array[i].field] ? " checked='checked'" : "") + "/>";
                } else if (array[i].type == "text") {
                    ul += "<input class='control-text' type='text' value='" + en[array[i].field] + "'/>";
                } else if (array[i].type == "tackcolor") {
                    ul += "<input class='control-text' type='text' name='tackcolor' value='" + en[array[i].field] + "'/>";
                } else if (array[i].type == "select") {
                    ul += "<select class='control-select'>";
                    for (var j = 0; j < array[i].data.length; j++) {
                        ul += "<option value='" + array[i].data[j] + "'" + (array[i].data[j] == en[array[i].field] ? " selected='selected'" : "") + ">" + array[i].data[j] + "</option>";
                    }
                    ul += "</select>";
                }
                ul += "</li>";
            }
            ul += "</ul>";
            return ul;
        },
        //无限递归获取echart属性
        getEchartTreeData: function (en, ul) {
            var child = ul.children();
            var node;
            for (var i = 0; i < child.length; i++) {
                node = $(child[i]);
                switch (node.attr("type")) {
                    case "checkbox":
                        en[node.attr("field")] = node.find("input[type='checkbox']").get(0).checked;
                        break;
                    case "text":
                    case "tackcolor":
                        en[node.attr("field")] = node.find("input[type='text']").val();
                        break;
                    case "select":
                        en[node.attr("field")] = node.find("select").val();
                        break;
                    default:
                        design.getEchartTreeData(en[node.attr("field")], node.find("ul:first"));
                }
            }
        },
        //打开echart属性编辑窗口
        openTreeDialog: function (title, name, array) {
            var en = design.getSelectItem();
            layer.open({
                type: 1,
                area: ["600px", "500px"],
                title: title + "-" + en.contentAttr.labname,
                content: "<div class='tree_attributeset'>" + design.appendEchartTree(en.contentAttr[name], array) + "</div>",
                btn: ['确定', '取消'],
                btn1: function (index, layero) {
                    design.getEchartTreeData(en.contentAttr[name], $(layero.context).find(".tree_attributeset>ul"));
                    design.editContentAttr(name, en.contentAttr[name]);
                    layer.close(index);
                }
            });
            //初始化颜色选择器
            $("input[name='tackcolor']").spectrum($.extend(design.tackColorSet, { hide: function (color) { } }));
        },
        //打开事件编辑代码
        openEventCode: function (en) {
            if (en) {
                layui.element.tabChange("laytab", "control_event");
                $("#e_controls div[itemId='" + en.type + en.id + "']").click();
                $("#e_events div[title='init']").click();
            }
        },
        //初始化事件设置 - 控件列表
        initEventNode: function () {
            var search = $.trim($("#e_controls input").val());
            var obj = $("#e_controls .datalist").empty();
            var html = "";
            var list = design.getListItems([design.panel]);
            for (var i = 0; i < list.length; i++) {
                if (list[i].type == "div" && list[i].child.length > 0)
                    continue;
                if (search && list[i].contentAttr.labname.indexOf(search) == -1 && list[i].contentAttr.id.indexOf(search) == -1)
                    continue;
                html += "<div itemId='" + list[i].type + list[i].id + "' title='" + list[i].contentAttr.labname + "'>" + (list[i].type == "panel" ? "页面" : list[i].contentAttr.id) + "</div>";
            }
            obj.html(html);
            if (html) {
                obj.find("div[itemId]").click(function () {
                    if ($(this).hasClass("datalist_select"))
                        return;
                    $("#e_controls").find(".datalist_select").removeClass("datalist_select");
                    $(this).addClass("datalist_select");
                    design.initEventName();
                });
            }
            design.initEventName();
        },
        //初始化事件设置 - 事件名称
        initEventName: function () {
            design.initEventCode();
            var obj = $("#e_events .datalist").empty();
            var id = $("#e_controls .datalist_select").attr("itemId");
            if (!id)
                return;
            var en = design.findItemById(id);
            var control = design.findControlByType(en.type);
            if (!control.events || control.events.length == 0)
                return;
            var search = $.trim($("#e_events input").val());
            var html = "";
            for (var i = 0; i < control.events.length; i++) {
                if (search && control.events[i].name.indexOf(search) == -1 && control.events[i].text.indexOf(search) == -1)
                    continue;
                html += "<div title='" + control.events[i].name + "'>" + control.events[i].text + "</div>";
            }
            obj.html(html);
            obj.find("div[title]").click(function () {
                $("#e_events").find(".datalist_select").removeClass("datalist_select");
                $(this).addClass("datalist_select");
                design.initEventCode($(this).attr("title"), en);
                $("#e_sysobject input").val("");
                $("#e_sysobject .datalist").empty();
            });
        },
        eventParams: [],
        initPreHtml: function (text) {
            var array = text.split("\n");
            var pre = $("#e_funcbody pre");
            var newElement;
            for (var i = 0; i < array.length; i++) {
                newElement = document.createElement("p");
                newElement.appendChild(document.createTextNode(array[i]));
                pre[0].appendChild(newElement);
            }
            design.preEventCodeFlag(pre[0].childNodes);
            pre.focus().click();
        },
        findEventHead: function (eventname, en) {
            var control = design.findControlByType(en.type);
            var funstr = "";
            var params;
            for (var i = 0; i < control.events.length; i++) {
                if (eventname == control.events[i].name) {
                    params = control.events[i].params;
                    break;
                }
            }
            for (var j = 0; j < params.length; j++) {
                if (params[j].name.indexOf(".") > 0)
                    continue;
                if (funstr != "")
                    funstr += ",";
                funstr += params[j].name;
            }
            if (funstr != "")
                funstr = "function(" + funstr + ")//"
            for (var j = 0; j < params.length; j++) {
                if (params[j].name.indexOf(".") > 0)
                    continue;
                funstr += params[j].name + ":" + params[j].remark + ";";
            }
            var event = null;
            for (var i = 0; i < en.events.length; i++) {
                if (en.events[i].name == eventname) {
                    event = en.events[i];
                    break;
                }
            }
            return { str: funstr, params: params, event: event };
        },
        //初始化事件主体代码块
        initEventCode: function (eventname, en) {
            var obj = $("#e_funcbody").empty();
            if (!en)
                return;
            var head = design.findEventHead(eventname, en);
            design.eventParams = head.params;
            if (head.event == null) {
                head.event = { name: eventname, code: "" };
                en.events.push(head.event);
            }
            var flag = true;
            var ctrlK = false;
            obj.append("<div>" + head.str + "</div><div>{</div><div><pre class='preeditable' contenteditable='true'></pre></div><div>}</div>");
            obj.find("pre").css({
                border: "none",
                marginLeft: 10,
                width: $("body").width() - 510,
                height: $("body").height() - 100
            }).blur(function (e) {
                var text = "";
                for (var i = 0; i < e.target.childNodes.length; i++) {
                    if (i > 0)
                        text += "\n";
                    text += e.target.childNodes[i].textContent.replace(/\n/g, "");
                }
                head.event.code = text;
            }).focus(function (e) {
                var select = window.getSelection();
                design.preHistorySelection.index = design.preGetStrLenBySelection(e.target, select.anchorNode).index;
                design.preHistorySelection.offfset = select.anchorOffset;
            }).keydown(function (e) {
                var that = $(this);
                if (e.ctrlKey) {
                    //按下k键，组合键
                    if (e.keyCode == 75) {
                        ctrlK = true;
                        e.preventDefault();
                        e.stopPropagation();
                        return;
                    }
                    else if (ctrlK && (e.keyCode == 67 || e.keyCode == 85)) {
                        design.eventCodeKeyCU(e);
                        e.preventDefault();
                        e.stopPropagation();
                    }
                }
                ctrlK = false;
                //tab格式化
                if (e.keyCode == 9) {
                    design.eventCodeKeyTab(e);
                    return;
                }
                //回车插入代码
                var node = $("#e_sysobject .datalist_select");
                if (e.keyCode == 13 && node.length == 1) {
                    design.eventCodeKeyEnter();
                    e.preventDefault();
                    e.stopPropagation();
                    return;
                }
                //上下键，选择代码
                if (e.keyCode == 38 || e.keyCode == 40) {
                    var data = design.preGetEditCode();
                    if ($.trim(data.name) && !/^[a-zA-Z0-9_.]$/.test(data.after[0]) && $("#e_sysobject .datalist").text()) {
                        design.selectSysObject(e);
                        e.preventDefault();
                        e.stopPropagation();
                        return;
                    }
                }
            }).keyup(function (e) {
                //处理粘贴过来的内容
                if (e.ctrlKey && e.keyCode == 86) {
                    design.eventCodeCtrlV(e);
                    return;
                }
                //回车后，如果当前行没有内容，说明是新的行，和上一行前面对其
                if (e.keyCode == 13) {
                    design.eventCodeBeforeAlign(e);
                    return;
                }
                //如果是ctrl+k+c组合键则不做任何处理了
                if (e.ctrlKey && (ctrlK || e.keyCode == 67 || e.keyCode == 85))
                    return;
                if (e.keyCode == 38 || e.keyCode == 40) {
                    var data = design.preGetEditCode();
                    if ($.trim(data.name) && !/^[a-zA-Z0-9_.]$/.test(data.after[0]) && $("#e_sysobject .datalist").text())
                        return;
                }
                //筛选代码
                if (flag && e.char != "") {
                    //调起输入法的时候 标记
                    design.preEventCodeFlag(design.preGetSelectionRows(design.preGetSelection(e)));
                }
                //搜索
                design.searchSysObject();
            }).bind('mousewheel DOMMouseScroll', function (e) {
                //缩放字体
                if (window.event.ctrlKey) {
                    var size = parseInt($(this).css("fontSize").replace("px", ""));
                    var wheel = e.originalEvent.wheelDelta;
                    var detal = e.originalEvent.detail;
                    if (wheel) {
                        if (wheel > 0) {
                            size++;
                        }
                        if (wheel < 0) {
                            size--;
                        }
                    } else if (detal) {
                        if (detal > 0) {
                            size--;
                        }
                        if (detal < 0) {
                            size++;
                        }
                    }
                    $(this).css("fontSize", size);
                    e.preventDefault();
                    e.stopPropagation();
                }
            }).on('compositionstart', function () {
                flag = false;
            }).on('compositionend', function () {
                flag = true;
            }).click(function () {
                design.preGetEditCode();
            });
            design.initPreHtml(head.event.code);
        },
        selectSysObject: function (e) {
            var node = $("#e_sysobject .datalist_select");
            if (e.keyCode == 38 || e.keyCode == 40) {
                e.preventDefault();
                e.stopPropagation();
                if (node.length == 0) {
                    $("#e_sysobject .datalist div:first").addClass("datalist_select");
                } else if (e.keyCode == 38) {
                    node.prev().addClass("datalist_select");
                } else {
                    node.next().addClass("datalist_select");
                }
                node.removeClass("datalist_select");
            }
        },
        //和上一行对其
        eventCodeBeforeAlign: function (e) {
            var select = window.getSelection();
            var p = select.anchorNode;
            while (p.nodeName.toLocaleLowerCase() != "p" && p.nodeName.toLocaleLowerCase() != "pre") {
                p = p.parentNode;
            }
            if (p.nodeName.toLocaleLowerCase() != "p")
                return;
            var text = p.innerText;
            if (text)
                return;
            var before = p.previousSibling;
            var data = before.innerText.match(/^\s+/);
            if (data)
                p.innerHTML = data[0];
        },
        //事件编辑代码的时候按下的Ctrl+K+C或Ctrl+K+U者键盘，注释或取消注释
        eventCodeKeyCU: function (e) {
            var data = design.preGetSelection(e);
            var beginNode = data.beginNode, beginIndex = data.beginIndex, beginVal = data.beginVal, endNode = data.endNode, endIndex = data.endIndex, endVal = data.endVal;
            if (e.keyCode == 67) {
                //注释
                beginNode.nodeValue = beginVal.substring(0, beginIndex) + "//" + beginVal.substring(beginIndex);
                //如果不是同行
                if (!design.preSiblingsAppendCode(e.target, beginNode, endNode, false, "//")) {
                    var parent = endNode;
                    while (parent.nodeName.toLowerCase() != "p" && parent.nodeName.toLowerCase() != "pre") {
                        parent = parent.parentNode;
                    }
                    if (parent.nodeName.toLowerCase() == "p") {
                        var child = parent.childNodes[0];
                        while (child.nodeName.toLowerCase() != "#text") {
                            child = child.childNodes[0];
                        }
                        if (child.nodeName.toLowerCase() == "#text") {
                            child.nodeValue = "//" + child.nodeValue;
                        }
                        if (child == endNode) {
                            endIndex += 2;
                        }
                    }
                } else {
                    endIndex += 2;
                }
            } else {
                //取消注释
                //如果不是同行
                if (!design.preSiblingsAppendCode(e.target, beginNode, endNode, true, "//")) {
                    if (beginVal.substring(beginIndex, 2) == "//") {
                        beginNode.nodeValue = beginVal.substring(0, beginIndex) + beginVal.substring(beginIndex + 2);
                    }
                    if (endVal.indexOf("//") == 0) {
                        endNode.nodeValue = endVal.replace("//", "");
                        endIndex -= 2;
                    }
                } else {
                    if (beginVal.substring(beginIndex, 2) == "//") {
                        beginNode.nodeValue = beginVal.substring(0, beginIndex) + beginVal.substring(beginIndex + 2);
                        endIndex -= 2;
                    }
                }
            }
            design.preCreateRange(beginNode, beginIndex, endNode, endIndex);
            design.preEventCodeFlag(design.preGetSelectionRows({ beginNode: beginNode, endNode: endNode }));
        },
        //事件编辑代码的时候按下的tab键盘，格式化
        eventCodeKeyTab: function (e) {
            var select = window.getSelection();
            if ((select.anchorNode != select.focusNode || (select.anchorNode == select.focusNode && select.anchorOffset != select.focusOffset))) {
                var data = design.preGetSelection(e);
                var beginNode = data.beginNode, beginIndex = data.beginIndex, beginVal = data.beginVal, endNode = data.endNode, endIndex = data.endIndex, endVal = data.endVal;
                if (e.shiftKey) {
                    if (beginVal[beginIndex] == "\t")
                        beginNode.nodeValue = beginVal.substring(0, beginIndex) + beginVal.substring(beginIndex + 1);
                    if (beginNode == endNode) {
                        //如果是同元素
                        if (beginVal[beginIndex] == "\t")
                            endIndex--;
                    } else if (!design.preSiblingsAppendCode(e.target, beginNode, endNode, true, "\t")) {
                        //如果不是同行
                        var textnode = design.getendfirsttextnode(endNode);
                        if (textnode.nodeValue.indexOf("\t") == 0) {
                            textnode.nodeValue = textnode.nodeValue.replace("\t", "");
                            if (textnode == endNode)
                                endIndex--;
                        }
                    }
                } else {
                    beginNode.nodeValue = beginVal.substring(0, beginIndex) + "\t" + beginVal.substring(beginIndex);
                    if (beginNode == endNode) {
                        //如果是同元素
                        endIndex++;
                    } else if (!design.preSiblingsAppendCode(e.target, beginNode, endNode, false, "\t")) {
                        //如果不是同行
                        var textnode = design.getendfirsttextnode(endNode);
                        if (textnode == endNode)
                            endIndex++;
                        textnode.nodeValue = "\t" + textnode.nodeValue;
                    }
                }
                design.preCreateRange(beginNode, beginIndex, endNode, endIndex);
                e.preventDefault();
                e.stopPropagation();
            }
        },
        //获取终节点对应的第一个文本元素
        getendfirsttextnode: function (node) {
            var endfirsttext = node;
            while (endfirsttext.nodeName.toLocaleLowerCase() != "p" && endfirsttext.nodeName.toLocaleLowerCase() != "pre") {
                endfirsttext = endfirsttext.parentNode;
            }
            while (endfirsttext.nodeName.toLocaleLowerCase() != "#text") {
                endfirsttext = endfirsttext.childNodes[0];
            }
            return endfirsttext;
        },
        //对粘贴过来的元素进行格式化处理
        eventCodeCtrlV: function (e) {
            var select = window.getSelection();
            var p = select.anchorNode;
            while (p.nodeName.toLocaleLowerCase() != "p" && p.nodeName.toLocaleLowerCase() != "pre") {
                p = p.parentNode;
            }
            if (p.nodeName.toLocaleLowerCase() != "p")
                return;
            var text = p.innerText;
            if (!text || text.indexOf("\n") == -1)
                return;
            text = text.replace(/        /g, "\t").split("\n");
            var eles = [];
            var newElement;
            for (var i = 0; i < text.length; i++) {
                newElement = document.createElement("p");
                newElement.appendChild(document.createTextNode(text[i]));
                e.target.insertBefore(newElement, p);
                eles.push(newElement);
            }
            e.target.removeChild(p);
            design.preEventCodeFlag(eles);
        },
        //事件编辑代码的时候按下的enter键盘,添加代码
        eventCodeKeyEnter: function (node) {
            if (!node)
                node = $("#e_sysobject .datalist_select");
            var objstr = node.text();
            node.removeClass("datalist_select");
            var data = design.preGetEditCode();
            if ($.trim(data.p.innerText) == objstr)
                return;
            var object;
            for (var i = 0; i < options.sysobjects.length; i++) {
                if (options.sysobjects[i].name == objstr) {
                    object = options.sysobjects[i];
                    break;
                }
            }
            var eles = [data.p];
            var selectnode = data.anchorNode, beginIndex = data.anchorOffset, endIndex = data.anchorOffset;
            //如果选择内容有换行
            if (objstr.indexOf("\n") > -1) {
                //格式化
                if (data.p.innerText.indexOf("\t") > -1) {
                    objstr = objstr.replace(/\n/g, "\n" + data.p.innerText.replace(/[^\t]/g, ""));
                }
                //一行行添加
                objstr = objstr.split("\n");
                var pre = $("#e_funcbody pre");
                var newElement;
                var next = data.p.nextSibling;
                var islast = pre[0].lastChild == data.p;
                for (var i = 0; i < objstr.length; i++) {
                    if (i == 0) {
                        data.anchorNode.nodeValue = data.before + objstr[i];
                    } else {
                        newElement = document.createElement("p");
                        newElement.appendChild(document.createTextNode(objstr[i]));
                        if (islast)
                            pre[0].appendChild(newElement);
                        else
                            pre[0].insertBefore(newElement, next);
                        eles.push(newElement);
                    }
                }
                //光标后的字符，追加到最后
                var nextstr = data.after;
                var that = (selectnode.parentNode.nodeName.toLowerCase() == "span" || selectnode.parentNode.nodeName.toLowerCase() == "font") ? selectnode.parentNode : selectnode;
                while (that.nextSibling) {
                    if (that.nextSibling.nodeName.toLowerCase() == "#text") {
                        nextstr += that.nextSibling.nodeValue;
                    } else {
                        nextstr += that.nextSibling.innerText;
                    }
                    data.p.removeChild(that.nextSibling);
                }
                if (nextstr != "") {
                    newElement = document.createElement("p");
                    newElement.appendChild(document.createTextNode(nextstr));
                    if (islast)
                        pre[0].appendChild(newElement);
                    else
                        pre[0].insertBefore(newElement, next);
                    eles.push(newElement);
                }
            } else {
                var appendStr = "", appendIndex = 0;
                //string 方法
                if (objstr.indexOf(".") == 0 && data.name.indexOf(".") > 0) {
                    appendIndex = data.name.indexOf(".");
                    appendStr = data.name.substring(0, appendIndex);
                }
                data.anchorNode.nodeValue = data.before + appendStr + objstr + data.after;
            }
            if (!data.ispre) {
                design.preHistorySelection.offfset = data.anchorNode.nodeValue.length;
            }
            if (object && object.selection)
                design.preCreateRange(selectnode, beginIndex - data.name.length + object.selection().begin, selectnode, endIndex - data.name.length + object.selection().end);
            //标记
            if (eles.length > 0)
                design.preEventCodeFlag(eles);
        },
        //搜素系统对象,函数
        searchSysObject: function (search) {
            var obj = $("#e_sysobject .datalist").empty();
            if (!search) {
                search = design.preGetEditCode().name.toLowerCase();
                $("#e_sysobject input").val(search);
            }
            var isToString = false;
            var html = "";
            var node = $("#e_funcbody pre");
            //匹配变量名
            var array = node[0].innerText.match(/var\s+[a-zA-Z0-9_,\s=]+/g);
            if (array) {
                var names;
                var name;
                for (var i = 0; i < array.length; i++) {
                    names = array[i].replace(/\s|var/g, "").split(",");
                    if (names && names.length > 0) {
                        for (var j = 0; j < names.length; j++) {
                            name = names[j].split("=")[0];
                            if (isToString == false)
                                isToString = search.indexOf(name.toLowerCase() + ".") == 0;
                            if (search && name.toLowerCase().indexOf(search) != 0)
                                continue;
                            html += "<div title='变量'>" + name + "</div>";
                        }
                    }
                }
            }
            var str;
            if (isToString)
                str = search.substring(search.indexOf("."));
            //全局对象
            for (var i = 0; i < options.sysobjects.length; i++) {
                if (isToString) {
                    if (options.sysobjects[i].name.toLowerCase().indexOf(str) != 0)
                        continue;
                }
                else {
                    if (options.sysobjects[i].name[0] == ".")
                        continue;
                    if (search && options.sysobjects[i].name.toLowerCase().indexOf(search) != 0 && options.sysobjects[i].remark.toLowerCase().indexOf(search) == -1)
                        continue;
                }
                html += "<div title='" + options.sysobjects[i].remark + "'>" + options.sysobjects[i].name + "</div>";
            }
            //方法的参数
            for (var i = 0; i < design.eventParams.length; i++) {
                if (search && design.eventParams[i].name.toLowerCase().indexOf(search) != 0 && design.eventParams[i].remark.toLowerCase().indexOf(search) == -1)
                    continue;
                html += "<div title='" + design.eventParams[i].remark + "'>" + design.eventParams[i].name + "</div>";
            }
            obj.html(html);
            obj.find("div[title]").click(function () {
                design.eventCodeKeyEnter($(this));
                design.searchSysObject();
            });
        },
        //代码编辑器中的历史选择记录
        preHistorySelection: {
            index: 0,
            offfset: 0,
            getanchor: function (data) {
                data.ispre = false;
                var b_data = design.preFindSelectionByStrLen($("#e_funcbody pre")[0], design.preHistorySelection.index + design.preHistorySelection.offfset);
                if (b_data.node) {
                    data.anchorNode = b_data.node;
                    data.anchorOffset = design.preHistorySelection.offfset;
                } else {
                    data.anchorNode = document.createTextNode("");
                    data.anchorOffset = 0;
                    $("#e_funcbody pre")[0].childNodes[0].appendChild(data.anchorNode);
                }
                return data;
            }
        },
        //获取代码编辑器中编辑的代码块
        preGetEditCode: function () {
            var select = window.getSelection();
            var data = {
                name: "",
                before: "",
                after: "",
                p: null,
                anchorNode: select.anchorNode,
                anchorOffset: select.anchorOffset,
                ispre: true//焦点是否来自pre控件
            };
            //处理光标不在编辑框内的情况
            var divnode = select.anchorNode;
            if (divnode == null) {
                data = design.preHistorySelection.getanchor(data);
            } else {
                while (divnode.nodeName.toLocaleLowerCase() != "pre") {
                    if (divnode.nodeName.toLocaleLowerCase() == "div") {
                        data = design.preHistorySelection.getanchor(data);
                        break;
                    }
                    divnode = divnode.parentNode;
                }
            }
            if (data.anchorNode.nodeValue != null) {
                data.p = data.anchorNode;
                while (data.p.nodeName.toLocaleLowerCase() != "p" && data.p.nodeName.toLocaleLowerCase() != "pre") {
                    data.p = data.p.parentNode;
                }
                data.name = data.anchorNode.nodeValue.substring(0, data.anchorOffset);
                var charts = [];
                for (var i = data.name.length - 1; i >= 0; i--) {
                    if (!/^[a-zA-Z0-9_.$]$/.test(data.name[i]))
                        break;
                    charts.push(data.name[i]);
                }
                data.name = charts.reverse().join("");
                //光标前，当前元素
                data.before = data.anchorNode.nodeValue.substring(0, data.anchorOffset - data.name.length);
                //光标后，当前元素
                data.after = data.anchorNode.nodeValue.substring(data.anchorOffset);
                if (data.ispre) {
                    design.preHistorySelection.index = design.preGetStrLenBySelection($("#e_funcbody pre")[0], data.anchorNode).index;
                    design.preHistorySelection.offfset = data.anchorOffset;
                }
            }
            return data;
        },
        //代码编辑器中的标注
        preEventCodeFlag: function (rows) {
            if (!rows || rows.length == 0)
                return;
            var select = window.getSelection();
            var beginNode = select.anchorNode;
            var beginIndex = select.anchorOffset;
            var endNode = select.focusNode;
            var endIndex = select.focusOffset;
            if (beginNode == null)
                return;
            if (endNode == null)
                return;
            var flagstr = [
                { text: "function", pattern: /\bfunction\b/g, color: "#00f" },
                { text: "var", pattern: /\bvar\b/g, color: "#00f" },
                { text: "return", pattern: /\breturn\b/g, color: "#00f" },
                { text: "break", pattern: /\bbreak\b/g, color: "#00f" },
                { text: "continue", pattern: /\bcontinue\b/g, color: "#00f" },
                { text: "null", pattern: /\bnull\b/g, color: "#00f" },
                { text: "false", pattern: /\bfalse\b/g, color: "#00f" },
                { text: "true", pattern: /\btrue\b/g, color: "#00f" },
                { text: "this", pattern: /\bthis\b/g, color: "#00f" },
                { text: "for", pattern: /\bfor\b/g, color: "#00f" },
                { text: "if", pattern: /\bif\b/g, color: "#00f" },
                { text: "else", pattern: /\belse\b/g, color: "#00f" },
                { text: "switch", pattern: /\bswitch\b/g, color: "#00f" },
                { text: "while", pattern: /\bwhile\b/g, color: "#00f" }
            ];
            var change = false, data, val, b_data, e_data, array, index;
            for (var i = 0; i < rows.length; i++) {
                array = [];
                b_data = design.preGetStrLenBySelection(rows[i], beginNode);
                e_data = design.preGetStrLenBySelection(rows[i], endNode);
                val = rows[i].textContent.replace(/</g, "&lt;").replace(/>/g, "&gt;");
                //匹配 ""
                //如果有字符串，为了后面的元素好匹配，将字符串截断
                index = -1;
                while (index >= -1) {
                    index = val.search(/("(?:[^"\\]|\\.)*")|('(?:[^'\\]|\\.)*')/g);
                    if (index == -1) {
                        array.push({ type: 0, str: val });
                        break;
                    }
                    if (index > 0) {
                        array.push({ type: 0, str: val.substring(0, index) });
                        val = val.substring(index);
                    }
                    data = val.match(/("(?:[^"\\]|\\.)*")|('(?:[^'\\]|\\.)*')/g);
                    array.push({ type: 1, str: data[0] });
                    val = val.substring(data[0].length);
                }
                //匹配 特殊符号
                for (var s = 0; s < array.length; s++) {
                    if (array[s].type == 1)
                        continue;
                    for (var j = 0; j < flagstr.length; j++) {
                        array[s].str = array[s].str.replace(flagstr[j].pattern, "<span style='color:" + flagstr[j].color + ";'>" + flagstr[j].text + "</span>");
                    }
                }
                //匹配 //
                for (var s = 0; s < array.length; s++) {
                    if (array[s].type == 1)
                        continue;
                    index = array[s].str.search(/\/\//);
                    if (index > -1) {
                        //后面的全是注释
                        array[s].str = array[s].str.substring(0, index) + "<span style='color:#008000;'>" + array[s].str.substring(index).replace(/<span style='color:#[0-9a-z]{3,6};'>/g, '').replace(/<\/span>/g, '');
                        for (var j = s + 1; j < array.length; j++) {
                            if (array[j].type == 1) {
                                array[j].type = 0;
                            } else {
                                array[j].str = array[j].str.replace(/<span style='color:#[0-9a-z]{3,6};'>/g, '').replace(/<\/span>/g, '');
                            }
                        }
                        array[array.length - 1].str += "</span>";
                        break;
                    }
                }
                val = "";
                for (var s = 0; s < array.length; s++) {
                    if (array[s].type == 1)
                        val += "<span style='color:#f00;'>" + array[s].str + "</span>";
                    else
                        val += array[s].str;
                }
                rows[i].innerHTML = val;
                if (b_data.node) {
                    b_data.index += beginIndex;
                    b_data = design.preFindSelectionByStrLen(rows[i], b_data.index);
                    if (b_data.node) {
                        beginNode = b_data.node;
                        beginIndex = b_data.index;
                        change = true;
                    }
                }
                if (e_data.node) {
                    e_data.index += endIndex;
                    e_data = design.preFindSelectionByStrLen(rows[i], e_data.index);
                    if (e_data.node) {
                        endNode = e_data.node;
                        endIndex = e_data.index;
                        change = true;
                    }
                }
            }
            if (change) 
                design.preCreateRange(beginNode, beginIndex, endNode, endIndex);
        },
        preCreateRange: function (bnode, bindex, enode, eindex) {
            var select = window.getSelection();
            var range = document.createRange();
            select.removeAllRanges();
            range.setStart(bnode, bindex);
            range.setEnd(enode, eindex);
            select.addRange(range);
        },
        //代码编辑器中 根据字符长度获取选择的节点
        preFindSelectionByStrLen: function (parent, index) {
            var data = {
                node: null, index: index
            };
            var name;
            for (var i = 0; i < parent.childNodes.length; i++) {
                name = parent.childNodes[i].nodeName.toLowerCase();
                if (name == "#text") {
                    if (parent.childNodes[i].nodeValue.length >= data.index) {
                        data.node = parent.childNodes[i];
                        break;
                    }
                    data.index -= parent.childNodes[i].nodeValue.length;
                } else if (name == "span" || name == "font" || name == "p") {
                    data = design.preFindSelectionByStrLen(parent.childNodes[i], data.index);
                    if (data.node)
                        break;
                }
            }
            return data;
        },
        //代码编辑器中 获取选择节点，之前的字符长度
        preGetStrLenBySelection: function (parent, node) {
            var data = {
                node: null, index: 0
            };
            if (parent == node) {
                data.node = parent;
                return data;
            }
            var name;
            for (var i = 0; i < parent.childNodes.length; i++) {
                name = parent.childNodes[i].nodeName.toLowerCase();
                if (name == "#text") {
                    if (node == parent.childNodes[i]) {
                        data.node = parent.childNodes[i];
                        break;
                    }
                    data.index += parent.childNodes[i].nodeValue.length;
                } else if (name == "span" || name == "font" || name == "p") {
                    var newdata = design.preGetStrLenBySelection(parent.childNodes[i], node);
                    data.index += newdata.index;
                    data.node = newdata.node;
                    if (data.node)
                        break;
                }
            }
            return data;
        },
        //代码编辑器中，开始和结束节点中间的 兄弟p节点追加和删除字符
        preSiblingsAppendCode: function (parent, begin, end, move, str) {
            var a = begin; b = end;
            if (a.nodeName == "PRE" || b.nodeName == "PRE")
                return a == b;
            while (a.nodeName.toLowerCase() != "p") {
                a = a.parentNode;
            }
            while (b.nodeName.toLowerCase() != "p") {
                b = b.parentNode;
            }
            if (a != b) {
                var exists = false;
                var text;
                for (var i = 0; i < parent.childNodes.length; i++) {
                    if (parent.childNodes[i] == a) {
                        exists = true;
                        continue;
                    }
                    if (parent.childNodes[i] == b)
                        break;
                    if (exists) {
                        text = parent.childNodes[i];
                        while (text && text.nodeName.toLowerCase() != "#text") {
                            if (text.childNodes[0]) {
                                text = text.childNodes[0];
                            } else {
                                if (text.innerText == "") {
                                    var node = document.createTextNode("");
                                    text.appendChild(node);
                                    text = null;
                                }
                            }
                        }
                        if (!text)
                            continue;
                        if (move) {
                            if (text.nodeValue.indexOf(str) == 0)
                                text.nodeValue = text.nodeValue.replace(str, "");
                        } else {
                            text.nodeValue = str + text.nodeValue;
                        }
                    }
                }
            }
            return a == b;
        },
        //获取代码编辑器中开始和结束节点对应的所有行
        preGetSelectionRows: function (data) {
            if (!data || !data.beginNode || !data.endNode)
                return [];
            var a = data.beginNode, b = data.endNode;
            if (a.nodeName.toLowerCase() == "pre") {
                a = a.childNodes[0];
            } else {
                while (a.nodeName.toLowerCase() != "p") {
                    a = a.parentNode;
                }
            }
            if (b.nodeName.toLowerCase() == "pre") {
                b = b.childNodes[0];
            } else {
                while (b.nodeName.toLowerCase() != "p") {
                    b = b.parentNode;
                }
            }
            var array = [];
            array.push(a);
            if (a != b) {
                var next = a.nextSibling;
                while (next != b) {
                    array.push(next);
                    next = next.nextSibling;
                }
                array.push(b);
            }
            return array;
        },
        //获取代码编辑器中开始和结束节点
        preGetSelection: function (e) {
            var select = window.getSelection();
            //开始和结束节点
            var anchorNode = select.anchorNode, focusNode = select.focusNode;
            if (!anchorNode || !focusNode)
                return null;
            //获取开始和结束节点，前面的字符串长度。以此判断是从右往左还是从左往右选择的
            var b_data = design.preGetStrLenBySelection(e.target, select.anchorNode);
            var e_data = design.preGetStrLenBySelection(e.target, select.focusNode);
            //如果开始节点没有内容
            if (anchorNode.nodeName.toLocaleLowerCase() == "p" && anchorNode.childNodes.length == 0) {
                var node = document.createTextNode("");
                anchorNode.appendChild(node);
                anchorNode = node;
            }
            //如果结束节点没有内容
            if (focusNode.nodeName.toLocaleLowerCase() == "p" && focusNode.childNodes.length == 0) {
                var node = document.createTextNode("");
                focusNode.appendChild(node);
                focusNode = node;
            }
            var data = {};
            if (b_data.index + select.anchorOffset > e_data.index + select.focusOffset) {
                //从右往左选的
                data.beginNode = focusNode;
                data.beginIndex = select.focusOffset;
                data.beginVal = focusNode.nodeValue;
                data.endNode = anchorNode;
                data.endIndex = select.anchorOffset;
                data.endVal = anchorNode.nodeValue;
            } else {
                //从左往右选的
                data.beginNode = anchorNode;
                data.beginIndex = select.anchorOffset;
                data.beginVal = anchorNode.nodeValue;
                data.endNode = focusNode;
                data.endIndex = select.focusOffset;
                data.endVal = focusNode.nodeValue;
            }
            return data;
        }
    };
    $.request = function (options) {
        //安全验证
        //$.ajax({
        //    type: 'post',
        //    data: null,
        //    url: '',
        //    success: function (e) {
        //        $.ajax(options);
        //    },
        //    error: function () {

        //    }
        //});
        alert(options.type);
    };
    $.get = function (options) {
        options.type = "get";
        $.request(options);
    };
    $.post = function (options) {
        options.type = "post";
        $.request(options);
    };
    design.init();
})(jQuery, window, layer, undefined, _PageDesignOptions);
