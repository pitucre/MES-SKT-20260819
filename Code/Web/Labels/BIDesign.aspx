<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BIDesign.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.BIDesign" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>BIDesign</title>
    <script src="../Content/js/jquery-2.0.0.min.js"></script>
    <script src="../Content/js/jquery-ui.min.js"></script>
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <script type="text/javascript" src="~/Content/TackColor/spectrum.js"></script>
    <script src="../Content/plugin/TackColor/spectrum.js"></script>
    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <link href="../Content/plugin/TackColor/spectrum.css" rel="stylesheet" />
    <script src="../Content/login/js/jquery.cookie.js"></script>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .laytab {
            border-collapse: collapse;
            width: 100%;
            height: 100%;
            
        }

            .laytab td {
                padding: 0;
            }

        .module {
            box-sizing: border-box;
            border-top: 1px solid #0097ac;
            border-bottom: 1px solid #0097ac;
            overflow: auto;
        }

        #d_left div {
            margin: 10px auto;
        }

        #d_left {
            text-align: center;
        }

            #d_left img {
                width: 30px;
                height: 30px;
            }

                #d_left img:hover {
                    background: #ccc;
                }

        #d_center {
            border-left: 1px solid #0097ac;
            border-right: 1px solid #0097ac;
            background: #999;
        }

        #panel {
            background: #fff;
            position: relative;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .control-text {
            width: 88px;
            height: 24px;
            border: 1px solid #0097ac;
            padding: 0 5px;
        }

        .control-select {
            width: 100px;
            height: 24px;
            border: 1px solid #0097ac;
        }

        .attrtab {
            border-collapse: collapse;
        }

            .attrtab .tdtitle {
                text-align: right;
                width: 80px;
                font-size: 12px;
                color: #000;
            }

            .attrtab .tdvalue {
                padding: 2px 0;
                text-align: left;
                width: 100px;
            }

        .layui-colla-item h2 {
            line-height: 35px !important;
            height: 35px !important;
            padding: 0 0 0 20px !important;
        }

        .attrtab .g_title {
            font-weight: bold;
            color: #0097ac;
        }

        .attrtab .g_line {
            border-bottom: 1px solid #0097ac;
        }

        .tackcolor {
            padding: 1px 4px !important;
        }

        .dragItem {
            box-sizing: border-box;
            float: left;
        }

        .selectItem {
            cursor: move;
            border-style: solid;
        }
    </style>
</head>
<body>
    <table class="laytab">
        <tr>
            <td>
                <div id="d_left" class="module">
                    <div>
                        <img src="../Content/images/print/text.png" type="text" title="文字(拖动添加)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/barcode.png" type="barcode" title="条码(拖动添加)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/qrcode.png" type="qrcode" title="二维码(拖动添加)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/matrix.png" type="matrix" title="二维条码(拖动添加)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/img.png" type="img" title="图片(拖动添加)" />
                    </div>
                </div>
            </td>
            <td>
                <div id="d_center" class="module">
                    <div id="panel" labname="面板" tabindex="1"></div>
                </div>
            </td>
            <td>
                <div id="d_right" class="module">
                    <div class="layui-collapse">
                        <div class="layui-colla-item">
                            <div class="layui-colla-content layui-show" style="position: absolute; z-index: 1; width: 100%; background: #fff; border-bottom: 1px solid #0097ac; box-sizing: border-box;">
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_save">保存</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_preview">预览</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_zoomin">放大</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_zoomout">缩小</button>
                            </div>
                        </div>
                        <div class="layui-colla-item" style="margin-top: 60px;">
                            <h2 class="layui-colla-title">标签名称
                                <select class="control-select" id="ddllables"></select>
                            </h2>
                            <div class="layui-colla-content layui-show" id="lableattr" style="padding: 0px !important;"></div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</body>
</html>
<script type="text/javascript">
    var BIOptions = {
        //选择图片
        selectImg: function (callback) {
            layer.open({
                title: '选择图片',
                type: 2,
                area: ['80%', '500px'],
                content: 'SelectImg.aspx?id=0',
                btn: ['确定', '取消'],
                btn1: function (index, layero) {
                    var url = layero.find("iframe")[0].contentWindow.selectImgName;
                    layer.close(index);
                    if (url)
                        callback(url);
                }
            });
        }
    };
    (function ($, window, layer, undefined, options) {
        //属性和样式设置控件
        var controls = {
            text: {
                title: "文本内容", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                    design.setAttr("text", $(this).val());
                }, setdata: function (entity) {
                    return (entity.attr == undefined || entity.attr.text == undefined) ? "" : entity.attr.text;
                }
            },
            behavior: {
                title: "滚动方式", control: "control-select", change: function () {
                    design.setAttr("behavior", $(this).val());
                }, data: [
                    { value: "alternate", text: "来回滚动" },
                    { value: "scroll", text: "循环滚动" },
                    { value: "slide", text: "滚动一次" }
                ], setdata: function (entity) {
                    return (entity.attr == undefined || entity.attr.behavior == undefined) ? "" : entity.attr.behavior;
                }
            },
            direction: {
                title: "滚动方向", control: "control-select", change: function () {
                    design.setAttr("direction", $(this).val());
                }, data: [
                    { value: "left", text: "向左" },
                    { value: "right", text: "向右" },
                    { value: "up", text: "向上" },
                    { value: "down", text: "向下" }
                ], setdata: function (entity) {
                    return (entity.attr == undefined || entity.attr.direction == undefined) ? "" : entity.attr.direction;
                }
            },
            scrollamount: {
                title: "滚动速度", control: "control-text", change: function () {
                    if (design.isInt($(this).val()))
                        design.setAttr("scrollamount", $(this).val());
                }, setdata: function (entity) {
                    return (entity.attr == undefined || entity.attr.scrollamount == undefined) ? "" : entity.attr.scrollamount;
                }
            },
            mouseoverstop: {
                title: "鼠标移入停止", control: "control-checkbox", click: function () {
                    design.setAttr("mouseoverstop", $(this).get(0).checked ? "1" : "0");
                }, setdata: function (entity) {
                    return (entity.attr == undefined || entity.attr.mouseoverstop == undefined) ? false : (entity.attr.mouseoverstop == "1");
                }
            },
            width: {
                title: "宽度", control: "control-text", change: function () {
                    if (design.isInt($(this).val()))
                        design.setCss("width", $(this).val());
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.width == undefined) ? "" : entity.css.width;
                }
            },
            height: {
                title: "高度", control: "control-text", change: function () {
                    if (design.isInt($(this).val()))
                        design.setCss("height", $(this).val());
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.height == undefined) ? "" : entity.css.height;
                }
            },
            color: {
                title: "字体颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setCss("color", color.toString(color.format));
                    else
                        design.setCss("color", "#000");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.color == undefined) ? "" : entity.css.color;
                }
            },
            opacity: {
                title: "透明度", control: "control-text", change: function () {
                    if (design.isNumber($(this).val()) && parseFloat($(this).val()) >= 0 && parseFloat($(this).val()) <= 1)
                        design.setCss("opacity", parseFloat($(this).val()));
                    else
                        design.setCss("opacity", 1);
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.opacity == undefined) ? "" : entity.css.opacity;
                }, remark: "0到1之间的数字，0代表完全透明，1代表完全不透明"
            },
            bgOpacity: {
                title: "背景透明度", control: "control-text", change: function () {
                    if (design.isNumber($(this).val()) && parseFloat($(this).val()) >= 0 && parseFloat($(this).val()) <= 1)
                        design.setCss("bgOpacity", parseFloat($(this).val()));
                    else
                        design.setCss("bgOpacity", 1);
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.bgOpacity == undefined) ? "" : entity.css.bgOpacity;
                }, remark: "背景透明度0到1之间的数字，0代表完全透明，1代表完全不透明"
            },
            boxShadowOpacity: {
                title: "阴影透明度", control: "control-text", change: function () {
                    if (design.isNumber($(this).val()) && parseFloat($(this).val()) >= 0 && parseFloat($(this).val()) <= 1)
                        design.setCss("boxShadowOpacity", parseFloat($(this).val()));
                    else
                        design.setCss("boxShadowOpacity", 1);
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.boxShadowOpacity == undefined) ? "" : entity.css.boxShadowOpacity;
                }, remark: "阴影透明度0到1之间的数字，0代表完全透明，1代表完全不透明"
            },
            backgroundColor: {
                title: "背景颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setCss("backgroundColor", color.toString(color.format));
                    else
                        design.setCss("backgroundColor", "");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.backgroundColor == undefined) ? "" : entity.css.backgroundColor;
                }
            },
            borderColor: {
                title: "边框颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setCss("borderColor", color.toString(color.format));
                    else
                        design.setCss("borderColor", "");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.borderColor == undefined) ? "" : entity.css.borderColor;
                }
            },
            borderWidth: {
                title: "边宽度", control: "control-text", change: function () {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px$/.test(val))
                        design.setCss("borderWidth", val);
                    else
                        design.setCss("borderWidth", "0px");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.borderWidth == undefined) ? "" : entity.css.borderWidth;
                }, remark: "上 右 下 左 例:1px 1px 1px 1px，上下 左右 例:1px 1px，四向例:1px"
            },
            fontSize: {
                title: "字体大小", control: "control-text", change: function (color) {
                    if (design.isInt($(this).val()))
                        design.setCss("fontSize", parseInt($(this).val()));
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.fontSize == undefined) ? "" : entity.css.fontSize;
                }
            },
            letterSpacing: {
                title: "字间距", control: "control-text", change: function (color) {
                    if (design.isNumber($(this).val()))
                        design.setCss("letterSpacing", parseInt($(this).val()));
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.letterSpacing == undefined) ? "" : entity.css.letterSpacing;
                }
            },
            lineHeight: {
                title: "行高", control: "control-text", change: function () {
                    if (design.isInt($(this).val()))
                        design.setCss("lineHeight", $(this).val());
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.lineHeight == undefined) ? "" : entity.css.lineHeight;
                }
            },
            borderRadius: {
                title: "圆角", control: "control-text", change: function () {
                    if (design.isInt($(this).val()))
                        design.setCss("borderRadius", $(this).val());
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.borderRadius == undefined) ? "" : entity.css.borderRadius;
                }
            },
            fontFamily: {
                title: "字体类型", control: "control-select", change: function () {
                    design.setCss("fontFamily", $(this).val());
                }, data: [
                    { value: "", text: "默认" },
                    { value: "FangSong", text: "仿宋" },
                    { value: "KaiTi", text: "楷体" },
                    { value: "SimHei", text: "黑体" }
                ], setdata: function (entity) {
                    return (entity.css == undefined || entity.css.fontFamily == undefined) ? "" : entity.css.fontFamily;
                }
            },
            textAlign: {
                title: "对齐方式", control: "control-select", change: function () {
                    design.setCss("textAlign", $(this).val());
                }, data: [
                    { value: "left", text: "左" },
                    { value: "center", text: "中" },
                    { value: "right", text: "右" }
                ], setdata: function (entity) {
                    return (entity.css == undefined || entity.css.textAlign == undefined) ? "" : entity.css.textAlign;
                }
            },
            padding: {
                title: "内边距", control: "control-text", change: function (color) {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px$/.test(val))
                        design.setCss("padding", val);
                    else
                        design.setCss("padding", "0px");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.padding == undefined) ? "" : entity.css.padding;
                }, remark: "上 右 下 左 例:1px 1px 1px 1px，上下 左右 例:1px 1px，四向例:1px"
            },
            margin: {
                title: "外边距", control: "control-text", change: function (color) {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px [+-]?\d+px$/.test(val) || /^[+-]?\d+px$/.test(val))
                        design.setCss("margin", val);
                    else
                        design.setCss("margin", "0px");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.margin == undefined) ? "" : entity.css.margin;
                }, remark: "上 右 下 左 例:1px 1px 1px 1px，上下 左右 例:1px 1px，四向例:1px"
            },
            textShadowMargin: {
                title: "阴影位置", control: "control-text", change: function (color) {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val))
                        design.setCss("textShadowMargin", val);
                    else
                        design.setCss("textShadowMargin", "");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.textShadowMargin == undefined) ? "" : entity.css.textShadowMargin;
                }, remark: "水平偏移 垂直偏移 深度,例:5px 5px 5px"
            },
            textShadowColor: {
                title: "阴影颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setCss("textShadowColor", color.toString(color.format));
                    else
                        design.setCss("textShadowColor", "");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.textShadowColor == undefined) ? "" : entity.css.textShadowColor;
                }
            },
            boxShadowMargin: {
                title: "阴影位置", control: "control-text", change: function (color) {
                    var val = $.trim($(this).val());
                    if (/^[+-]?\d+px [+-]?\d+px [+-]?\d+px [+-]?\d+px$/.test(val))
                        design.setCss("boxShadowMargin", val);
                    else
                        design.setCss("boxShadowMargin", "");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.boxShadowMargin == undefined) ? "" : entity.css.boxShadowMargin;
                }, remark: "水平偏移 垂直偏移 模糊程度 阴影半径,例:5px 5px 5px 5px"
            },
            boxShadowColor: {
                title: "阴影颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setCss("boxShadowColor", color.toString(color.format));
                    else
                        design.setCss("boxShadowColor", "");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.boxShadowColor == undefined) ? "" : entity.css.boxShadowColor;
                }
            },
            borderStyle: {
                title: "边框虚线", control: "control-checkbox", click: function () {
                    design.setCss("borderStyle", $(this).get(0).checked ? "dashed" : "solid");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.borderStyle == undefined) ? false : (entity.css.borderStyle == "dashed");
                }
            },
            boxSizing: {
                title: "内边框", control: "control-checkbox", click: function () {
                    design.setCss("boxSizing", $(this).get(0).checked ? "border-box" : "content-box");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.boxSizing == undefined) ? false : (entity.css.boxSizing == "border-box");
                }
            },
            fontWeight: {
                title: "粗体", control: "control-checkbox", click: function () {
                    design.setCss("fontWeight", $(this).get(0).checked ? "bold" : "normal");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.fontWeight == undefined) ? false : (entity.css.fontWeight == "bold");
                }
            },
            fontStyle: {
                title: "斜体", control: "control-checkbox", click: function () {
                    design.setCss("fontStyle", $(this).get(0).checked ? "italic" : "normal");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.fontStyle == undefined) ? false : (entity.css.fontStyle == "italic");
                }
            },
            overline: {
                title: "上划线", control: "control-checkbox", click: function () {
                    design.setCss("overline", $(this).get(0).checked ? "1" : "0");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.overline == undefined) ? false : (entity.css.overline == "1");
                }
            },
            linethrough: {
                title: "贯穿线", control: "control-checkbox", click: function () {
                    design.setCss("linethrough", $(this).get(0).checked ? "1" : "0");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.linethrough == undefined) ? false : (entity.css.linethrough == "1");
                }
            },
            underline: {
                title: "下划线", control: "control-checkbox", click: function () {
                    design.setCss("underline", $(this).get(0).checked ? "1" : "0");
                }, setdata: function (entity) {
                    return (entity.css == undefined || entity.css.underline == undefined) ? false : (entity.css.underline == "1");
                }
            }
        };
        var design = {
            d_left: 40,
            d_right: 380,
            panel: { type: "panel", attr: { rate: 1 }, css: { width: 800, height: 600, backgroundColor: "#041622" } },
            //窗体大小改变
            resize: function () {
                $(".module").height(0).height($("body").height());
                $("#d_left").width(design.d_left);
                $("#d_right").width(design.d_right);
                $("#d_center").width($("body").width() - design.d_left - design.d_right);
                design.initPanel(true);
                design.initDrag();
            },
            init: function () {
                design.resize();
                design.initPanel();
                window.onresize = this.resize;

            },
            initItems: function (parent, items) {
                if (!parent && !items) {
                    items = design.items;
                    parent = $("#panel").empty();
                }
                for (var i = 0; i < items.length; i++) {
                    var node = design.addItem(parent, items[i]);
                    if (items[i].child)
                        design.initItems(node, items[i].child);
                }
            },
            initPanel: function (isresize) {
                var panel = $("#panel");
                var pw = panel.parent().width();
                var ph = panel.parent().height();
                var width = design.panel.css.width * design.panel.attr.rate;
                var height = design.panel.css.height * design.panel.attr.rate;
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
                panel.css({ width: 0, height: 0, opacity: 0, top: height / 2 + ph, left: width / 2 + pw })
                    .animate({ width: width, height: height, opacity: 1, top: ph, left: pw }, 500, "swing", design.initItems);
                panel.bind('mousewheel DOMMouseScroll', function (event) {
                    var wheel = event.originalEvent.wheelDelta;
                    var detal = event.originalEvent.detail;
                    if (event.originalEvent.wheelDelta) {
                        if (wheel > 0) {
                            design.zoom((design.panel.attr.rate * 10 + 1) / 10, true);
                        }
                        if (wheel < 0) {
                            design.zoom((design.panel.attr.rate * 10 - 1) / 10, true);
                        }
                    } else if (event.originalEvent.detail) {
                        if (detal > 0) {
                            design.zoom((design.panel.attr.rate * 10 - 1) / 10, true);
                        }
                        if (detal < 0) {
                            design.zoom((design.panel.attr.rate * 10 + 1) / 10, true);
                        }
                    }
                });
                panel.data("entity", design.panel);
            },
            mouseInArea: function (event, area) {
                return (event.clientX > area.left && event.clientY > area.top && event.clientX < area.left + area.width && event.clientY < area.top + area.height);
            },
            dragInDoubleArea: function (event, ui, items) {
                if (!items || items.length < 2)
                    return null;
                if (items[0].width == 100) {
                    //上下排列
                    for (var i = 0; i < items.length; i++) {
                        if (ui.position.top > items[i].area.top && ui.position.top < items[i].area.top + items[i].area.height
                            && i < items.length - 1
                            && ui.position.top + design.dragSize.height > items[i + 1].area.top && ui.position.top + design.dragSize.height < items[i + 1].area.top + items[i + 1].area.height
                            && (design.mouseInArea(event, items[i].area) || design.mouseInArea(event, items[i + 1].area))) {
                            return { data: items, a: i, b: i + 1, t: "height" };
                        }
                    }
                    for (var i = 0; i < items.length; i++) {
                        var data = design.dragInDoubleArea(event, ui, items[i].child);
                        if (data != null)
                            return data;
                    }
                } else if (items[0].height == 100) {
                    //左右排列
                    for (var i = 0; i < items.length; i++) {
                        if (ui.position.left > items[i].area.left && ui.position.left < items[i].area.left + items[i].area.width
                            && i < items.length - 1
                            && ui.position.left + design.dragSize.width > items[i + 1].area.left && ui.position.left + design.dragSize.width < items[i + 1].area.left + items[i + 1].area.width
                            && (design.mouseInArea(event, items[i].area) || design.mouseInArea(event, items[i + 1].area))) {
                            return { data: items, a: i, b: i + 1, t: "width" };
                        }
                    }
                    for (var i = 0; i < items.length; i++) {
                        var data = design.dragInDoubleArea(event, ui, items[i].child);
                        if (data != null)
                            return data;
                    }
                } else {
                    layer.open({ content: '计算出错了,错误代码:001！' });
                }
                return null;
            },
            currDrag: null,
            items: [],
            draggable_drag: function (panelInfo, listItem, event, ui) {
                //如果是空的面板，直接添加，100%大小
                if (panelInfo.childLen == 0) {
                    if (design.mouseInArea(event, panelInfo)) {
                        design.dragArea(panelInfo);
                    } else if (design.dragAreaObj) {
                        design.dragAreaObj.remove();
                        design.dragAreaObj = null;
                    }
                    return;
                }
                //判断是否在两个同级块中间
                var result = design.dragInDoubleArea(event, ui, design.items[0].child);
                if (result != null) {
                    var begin = result.data[result.a];
                    var end = result.data[result.b];
                    var val = (begin.area[result.t] + end.area[result.t]) / 3;
                    if (result.t == "height") {
                        //上下排列
                        design.dragArea({
                            width: begin.area.width,
                            height: val,
                            top: begin.area.top + begin.area.height - begin.area.height / (begin.area.height + end.area.height) * val,
                            left: begin.area.left
                        }, 0.8);
                    } else {
                        //左右排列 
                        design.dragArea({
                            width: val,
                            height: begin.area.height,
                            top: begin.area.top,
                            left: begin.area.left + begin.area.width - begin.area.width / (begin.area.width + end.area.width) * val
                        }, 0.8);
                    }
                    return;
                }
                //获取包含 拖动的块的最大层级
                var item;
                var index = 0;
                for (var i = 0; i < listItem.length; i++) {
                    if (design.mouseInArea(event, listItem[i])) {
                        if (listItem[i].index > index) {
                            index = listItem[i].index;
                            item = listItem[i];
                        }
                    }
                }
                if (!item) {
                    if (design.dragAreaObj) {
                        design.dragAreaObj.remove();
                        design.dragAreaObj = null;
                    }
                    return;
                }
                var parentInfo = {
                    width: item.width,
                    height: item.height,
                    top: item.top,
                    left: item.left
                };
                //和item 5 5分，判断当前块的中点在 item中的什么区域
                if (event.clientX < item.left + item.width / 2) {
                    if (ui.position.top + design.dragSize.height < item.top + item.height / 2) {
                        //如果 当前块 底部 在item中点上 上面
                        design.dragArea({ width: parentInfo.width, height: parentInfo.height / 2, top: parentInfo.top, left: parentInfo.left });
                    } else if (ui.position.top > item.top + item.height / 2) {
                        //如果 当前块 顶部 在item中点下 下面
                        design.dragArea({ width: parentInfo.width, height: parentInfo.height / 2, top: parentInfo.top + parentInfo.height / 2, left: parentInfo.left });
                    } else {
                        //在左边
                        design.dragArea({ width: parentInfo.width / 2, height: parentInfo.height, top: parentInfo.top, left: parentInfo.left });
                    }
                } else {
                    if (ui.position.top + design.dragSize.height < item.top + item.height / 2) {
                        //如果 当前块 底部 在item中点上 上面
                        design.dragArea({ width: parentInfo.width, height: parentInfo.height / 2, top: parentInfo.top, left: parentInfo.left });
                    } else if (ui.position.top > item.top + item.height / 2) {
                        //如果 当前块 顶部 在item中点下 下面
                        design.dragArea({ width: parentInfo.width, height: parentInfo.height / 2, top: parentInfo.top + parentInfo.height / 2, left: parentInfo.left });
                    } else {
                        //在右边
                        design.dragArea({ width: parentInfo.width / 2, height: parentInfo.height, top: parentInfo.top, left: parentInfo.left + parentInfo.width / 2 });
                    }
                }
            },
            draggable_stop: function (panelInfo, listItem, event, ui, type) {
                //如果是空的面板，直接添加，100%大小
                if (panelInfo.childLen == 0 && design.mouseInArea(event, panelInfo)) {
                    design.items.push(design.newEntity(type, 1, 100, 100));
                    design.initItems();
                    return;
                }
                //判断是否在两个同级块中间
                var result = design.dragInDoubleArea(event, ui, design.items[0].child);
                if (result != null) {
                    var begin = result.data[result.a];
                    var end = result.data[result.b];
                    //上级大小
                    var parent_val = $("#" + begin.id).parent()[result.t]();
                    //新的几个区域所占大小百分比
                    var rate_val = begin[result.t] + end[result.t];
                    //新的几个区域所占大小
                    var px_val = begin.area[result.t] + end.area[result.t];
                    //前面一个的百分比大小
                    begin[result.t] = parseInt(begin.area[result.t] * 0.6666 / parent_val * 100);
                    //中间的百分比大小
                    var center_val = parseInt((px_val / 3) / parent_val * 100);
                    //后面一个的百分比大小
                    end[result.t] = parseInt(end.area[result.t] * 0.6666 / parent_val * 100);
                    //这个3个加起来要等于 新的几个区域所占百分比，如果不满足 追加0.01
                    while (begin[result.t] + center_val + end[result.t] < rate_val) {
                        center_val = parseFloat((center_val + 0.01).toFixed(2));
                        if (begin[result.t] + center_val + end[result.t] < rate_val)
                            begin[result.t] = parseFloat((begin[result.t] + 0.01).toFixed(2));
                        if (begin[result.t] + center_val + end[result.t] < rate_val)
                            end[result.t] = parseFloat((end[result.t] + 0.01).toFixed(2));
                    }
                    if (result.t == "height") {
                        //上下排列
                        result.data.splice(result.b, 0, design.newEntity(type, begin.index, begin.width, center_val));
                    } else {
                        //左右排列
                        result.data.splice(result.b, 0, design.newEntity(type, begin.index, center_val, begin.height));
                    }
                    design.initItems();
                    return;
                }
                //获取包含 拖动的块的最大层级
                var item;
                var index = 0;
                for (var i = 0; i < listItem.length; i++) {
                    if (design.mouseInArea(event, listItem[i])) {
                        if (listItem[i].index > index) {
                            index = listItem[i].index;
                            item = listItem[i];
                        }
                    }
                }
                if (!item)
                    return;
                result = design.findItemById(item.id);
                if (!result)
                    return;
                var parentInfo = {
                    width: item.width,
                    height: item.height,
                    top: item.top,
                    left: item.left
                };
                //和item 5 5分，判断当前块的中点在 item中的什么区域
                if (event.clientX < item.left + item.width / 2) {
                    if (ui.position.top + design.dragSize.height < item.top + item.height / 2) {
                        //如果 当前块 底部 在item中点上 上面
                        result.child.push(design.newEntity(type, item.index + 1, 100, 50));
                        result.child.push(design.newEntity(type, item.index + 1, 100, 50, result));
                    } else if (ui.position.top > item.top + item.height / 2) {
                        //如果 当前块 顶部 在item中点下 下面
                        result.child.push(design.newEntity(type, item.index + 1, 100, 50, result));
                        result.child.push(design.newEntity(type, item.index + 1, 100, 50));
                    } else {
                        //在左边
                        result.child.push(design.newEntity(type, item.index + 1, 50, 100));
                        result.child.push(design.newEntity(type, item.index + 1, 50, 100, result));
                    }
                } else {
                    if (ui.position.top + design.dragSize.height < item.top + item.height / 2) {
                        //如果 当前块 底部 在item中点上 上面
                        result.child.push(design.newEntity(type, item.index + 1, 100, 50));
                        result.child.push(design.newEntity(type, item.index + 1, 100, 50, result));
                    } else if (ui.position.top > item.top + item.height / 2) {
                        //如果 当前块 顶部 在item中点下 下面
                        result.child.push(design.newEntity(type, item.index + 1, 100, 50, result));
                        result.child.push(design.newEntity(type, item.index + 1, 100, 50));
                    } else {
                        //在右边
                        result.child.push(design.newEntity(type, item.index + 1, 50, 100, result));
                        result.child.push(design.newEntity(type, item.index + 1, 50, 100));
                    }
                }
                design.initItems();
            },
            newEntity: function (t, i, w, h, parent) {
                var en = { id: design.getMaxId() + 1, index: i, type: t, width: w, height: h, child: [], area: {}, attr: {}, css: {} };
                if (parent) {
                    en.css = parent.css;
                    en.attr = parent.attr;
                    en.type = parent.type;
                    parent.css = {};
                    parent.attr = {};
                }
                else {
                    if (en.type == "text") {
                        en.attr.text = "";
                        en.css = {
                            borderStyle: "dashed",
                            borderWidth: "1px",
                            borderColor: "#0097ac",
                            textAlign: "center",
                            color: "#000",
                            fontSize: 20,
                            fontWeight: "bold",
                            letterSpacing: 10,
                            lineHeight: 30,
                            padding: "0px 0px 0px 0px",
                            margin: "0px 0px 0px 0px",
                            fontStyle: "italic",
                            overline: "1",
                            linethrough: "1",
                            underline: "1"
                        }
                    }
                }
                return en;
            },
            dragSize: { width: 100, height: 100 },
            //初始化拖动标签类型
            initDrag: function () {
                var panelInfo = {};
                var list = [];
                $("#d_left img").unbind("mouseover").bind("mouseover", function () {
                    if (design.currDrag)
                        design.currDrag.remove();
                    design.currDrag = $($(this)[0].outerHTML)
                        .css({ position: "absolute", top: $(this).offset().top, left: $(this).offset().left, zIndex: 9999 })
                        .mousedown(function (e) {
                            $(this).css({ width: design.dragSize.width, height: design.dragSize.height, top: e.clientY - design.dragSize.height / 2, left: e.clientX - design.dragSize.width / 2 });
                        })
                        .draggable({
                            start: function (event, ui) {
                                var panel = $("#panel");
                                panelInfo = {
                                    childLen: panel.children().length,
                                    width: panel.width(),
                                    height: panel.height(),
                                    top: panel.offset().top,
                                    left: panel.offset().left
                                };
                                list = design.getAll();
                            },
                            drag: function (event, ui) {
                                design.draggable_drag(panelInfo, list, event, ui);
                            },
                            stop: function (event, ui) {
                                var that = $(this);
                                that.remove();
                                design.dragAreaObj.remove();
                                design.dragAreaObj = null;
                                design.draggable_stop(panelInfo, list, event, ui, that.attr("type"));
                            },
                        })
                        .appendTo($(this).parent());
                });
            },
            getAll: function (items) {
                if (!items)
                    items = design.items;
                var array = [];
                for (var i = 0; i < items.length; i++) {
                    array.push({ id: items[i].id, index: items[i].index, width: items[i].area.width, height: items[i].area.height, top: items[i].area.top, left: items[i].area.left });
                    array.push.apply(array, design.getAll(items[i].child));
                }
                return array;
            },
            findItemById: function (id, items) {
                if (!items)
                    items = design.items;
                var item;
                for (var i = 0; i < items.length; i++) {
                    if (items[i].id == id) {
                        item = items[i];
                        break;
                    }
                    item = design.findItemById(id, items[i].child);
                    if (item)
                        break;
                }
                return item;
            },
            getMaxId: function (items) {
                if (!items)
                    items = design.items;
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
            addItem: function (parent, entity) {
                var node = $("<div id='" + entity.id + "' index='" + entity.index + "' class='dragItem' style='width:" + entity.width + "%;height:" + entity.height + "%;'></div>");
                parent.append(node);
                entity.area.width = node.width();
                entity.area.height = node.height();
                entity.area.top = node.offset().top;
                entity.area.left = node.offset().left;
                node.data("entity", entity);
                if (!entity.child || entity.child.length == 0) {
                    node.click(function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        $(".selectItem").removeClass("selectItem")
                        $(this).addClass("selectItem");
                        design.createAttr(node.data("entity"));
                    });
                }
                design.itemCss(node, entity);
                design.itemAttr(node, entity);
                return node;
            },
            dragAreaObj: null,
            dragArea: function (area, opacity) {
                if (opacity == undefined)
                    opacity = 1;
                if (!design.dragAreaObj)
                    design.dragAreaObj = $("<div></div>").appendTo($("body"));
                area.backgroundColor = "#a1d8f8";
                design.dragAreaObj.css({
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
            nodes: {
                panel: {
                    attr: [
                        controls.width,
                        controls.height,
                        { title: "<div class='g_title'>背景</div>", colspan: 3, control: "<div class='g_line'></div>" },
                        controls.backgroundColor,
                        controls.bgOpacity
                    ]
                },
                text:[
                    controls.text,
                    //{ title: "<div class='g_title'>位置</div>", colspan: 3, control: "<div class='g_line'></div>" },
                    //controls.width,
                    //controls.height,
                    { title: "<div class='g_title'>字体</div>", colspan: 3, control: "<div class='g_line'></div>" },
                    controls.fontFamily,
                    controls.color,
                    controls.fontSize,
                    controls.lineHeight,
                    controls.letterSpacing,
                    controls.textAlign,
                    controls.fontWeight,
                    controls.fontStyle,
                    controls.overline,
                    controls.linethrough,
                    controls.underline,
                    { title: "", control: "<div></div>" },
                    controls.textShadowMargin,
                    controls.textShadowColor,
                    { title: "<div class='g_title'>边框</div>", colspan: 3, control: "<div class='g_line'></div>" },
                    controls.borderStyle,
                    controls.boxSizing,
                    controls.borderColor,
                    controls.borderWidth,
                    controls.padding,
                    controls.margin,
                    controls.boxShadowMargin,
                    controls.boxShadowColor,
                    controls.boxShadowOpacity,
                    controls.borderRadius,
                    { title: "<div class='g_title'>背景</div>", colspan: 3, control: "<div class='g_line'></div>" },
                    controls.backgroundColor,
                    controls.bgOpacity
                ]
            },
            zoom: function (rate, showmsg) {
                if (showmsg) {
                    layer.msg(design.panel.attr.rate + "倍");
                }
                if (rate < 0.1) {
                    layer.open({ content: '不能在小了' });
                    return;
                }
                design.panel.attr.rate = rate;
                design.initPanel(true);
                design.setItemPosition();
            },
            setItemPosition: function (items) {
                if (!items)
                    items = design.items;
                for (var i = 0; i < items.length; i++) {
                    var node = $("#" + items[i].id);
                    items[i].area.width = node.width();
                    items[i].area.height = node.height();
                    items[i].area.top = node.offset().top;
                    items[i].area.left = node.offset().left;
                    node.data("entity", items[i]);
                    design.setItemPosition(items[i].child);
                }
            },
            itemCss: function (node, entity) {
                var set = entity.css;
                if (!set)
                    return;
                var css = {};
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
                $.each(["fontSize", "textAlign", "verticalAlign", "fontWeight", "color", "fontFamily", "position", "top", "left",  "borderColor", "borderWidth", "letterSpacing",
                    "borderStyle", "boxSizing", "padding", "margin", "fontStyle","opacity", "lineHeight", "borderRadius"], function () {
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
                node.css(css);
            },
            itemAttr: function (node, entity) {
                var set = entity.attr;
                if (!set)
                    return;
                //文本内容
                if (set.text != undefined)
                    node.text(set.text);
                //其他属性
                $.each(["width", "behavior", "direction", "scrollamount", "src", "id"], function () {
                    if (set[this] != undefined)
                        node.attr(this, set[this]);
                });
                //跑马灯事件
                if (entity.type == "marquee") {
                    node.unbind("mouseover").unbind("mouseout");
                    if (set.mouseoverstop == "1") {
                        node.bind("mouseover", function () {
                            this.stop();
                        }).bind("mouseout", function () {
                            this.start();
                        });
                    }
                }
            },
            createAttr: function (entity) {
                if (!entity)
                    return;
                var node = $("#lableattr").empty();
                var data = [];
                for (var i = 0; i < design.nodes[entity.type].length; i++) {
                    data.push(design.nodes[entity.type][i]);
                }
                if (data.length == 0)
                    return;
                var tab = $("<table class=\"attrtab\"></table>").appendTo(node);
                var tr = null;
                var newrow = true;
                for (var i = 0; i < data.length; i++) {
                    if (!data[i].remark)
                        data[i].remark = "";
                    if (newrow)
                        tr = $("<tr></tr>").appendTo(tab);
                    tr.append("<td class='tdtitle' title='" + data[i].remark + "'>" + (data[i].control == "control-checkbox" ? "" : data[i].title) + "</td>");
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
                        obj = $("<input" + data[i].style + " type=\"text\" class=\"control-text\" value=\"" + data[i].setdata(entity) + "\"/>").appendTo(td);
                    }
                    else if (data[i].control == "control-tackcolor") {
                        obj = $("<input type=\"text\" class=\"control-text\" value=\"" + data[i].setdata(entity) + "\"/>").appendTo(td);
                        obj.spectrum($.extend(design.tackColorSet, { hide: data[i].changecolor }));
                    }
                    else if (data[i].control == "control-select") {
                        var option_str = "";
                        var val = data[i].setdata(entity);
                        for (var j = 0; j < data[i].data.length; j++) {
                            option_str += "<option value=\"" + data[i].data[j].value + "\"" + (data[i].data[j].value == val ? " selected='selected'" : "") + ">" + data[i].data[j].text + "</option>";
                        }
                        obj = $("<select class='control-select'>" + option_str + "</select>").appendTo(td);
                    }
                    else if (data[i].control == "control-checkbox") {
                        obj = $("<input type=\"checkbox\"" + (data[i].setdata(entity) ? " checked" : "") + " id=\"txt_" + data[i].group + i + "\" />").appendTo(td);
                        td.append("<label for=\"txt_" + data[i].group + i + "\">" + data[i].title + "</label>");
                    }
                    else if (data[i].control == "control-ddlsearch") {
                        obj = $("<input type=\"text\" class=\"control-text\" tagtext=\"" + data[i].setdata(entity, 'tagtext') + "\" tagvalue=\"" + data[i].setdata(entity, 'tagvalue') + "\" value=\"" + data[i].setdata(entity) + "\"/>").appendTo(td);
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
            setAttr: function (name, value) {
                var node = $(".selectItem")
                var entity = node.data("entity");
                entity.attr[name] = value;
                design.itemAttr(node, entity);
            },
            setCss: function (name, value) {
                var node = $(".selectItem")
                var entity = node.data("entity");
                entity.css[name] = value;
                design.itemCss(node, entity);
            },
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
            isInt: function (val) {
                return /^\d+$/.test(val);
            },
            isNumber: function (val) {
                return /^[+-]?\d+(.\d+|\d*)$/.test(val);
            },
            selectImg: function () {
                var node = $(this);
                options.selectImg(function (url) {
                    var entity = node.data("entity");
                    entity.attr.src = url;
                    node.attr("src", entity.attr.src);
                });
            }
        };
        design.init();
    })(jQuery, window, layer, undefined, BIOptions);
</script>
