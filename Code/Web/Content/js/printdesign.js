(function ($, window, layer, undefined, options) {
    var design = {
        //毫米转像素
        mmToPx: function (val, isIgnoreRate) { return parseFloat((parseFloat(val) / 0.3527 / (72 / design.panel.dpi) * (isIgnoreRate ? 1 : design.panel.rate)).toFixed(3)); },
        //像素转毫米
        pxToMm: function (val, isIgnoreRate) { return parseFloat((parseFloat(val) * 0.3527 * (72 / design.panel.dpi) / (isIgnoreRate ? 1 : design.panel.rate)).toFixed(3)); },
        //点数转像素
        ptToPx: function (val, isIgnoreRate) { return parseFloat((parseFloat(val) / (72 / design.panel.dpi) * (isIgnoreRate ? 1 : design.panel.rate)).toFixed(3)); },
        //像素转点数
        pxToPt: function (val, isIgnoreRate) { return parseFloat((parseFloat(val) * (72 / design.panel.dpi) / (isIgnoreRate ? 1 : design.panel.rate)).toFixed(3)); },
        //数值转像素（指定单位）
        ValueToPx: function (val, unit, isIgnoreRate) {
            switch (unit) {
                case "pt":
                    val = design.ptToPx(val, isIgnoreRate);
                    break;
                case "mm":
                    val = design.mmToPx(val, isIgnoreRate);
                    break;
                case "pixel":
                    val = parseFloat(val) * (isIgnoreRate ? 1 : design.panel.rate);
                    break;
                default:
                    val = design.ptToPx(val, isIgnoreRate);
            }
            return val;
        },
        //像素转数值（指定单位）
        pxToValue: function (val, unit, isIgnoreRate) {
            switch (unit) {
                case "pt":
                    val = design.pxToPt(val, isIgnoreRate);
                    break;
                case "mm":
                    val = design.pxToMm(val, isIgnoreRate);
                    break;
                case "pixel":
                    val = parseFloat(val) / (isIgnoreRate ? 1 : design.panel.rate);
                    break;
                default:
                    val = design.pxToPt(val, isIgnoreRate);
                    break;
            }
            return val;
        },
        //获取DPI
        getDPI: function () {
            var arrDPI = new Array();
            if (window.screen.deviceXDPI != undefined) {
                arrDPI[0] = window.screen.deviceXDPI;
                arrDPI[1] = window.screen.deviceYDPI;
            }
            else {
                var tmpNode = document.createElement("DIV");
                tmpNode.style.cssText = "width:1in;height:1in;position:absolute;left:0px;top:0px;z-index:99;visibility:hidden";
                document.body.appendChild(tmpNode);
                arrDPI[0] = parseInt(tmpNode.offsetWidth);
                arrDPI[1] = parseInt(tmpNode.offsetHeight);
                tmpNode.parentNode.removeChild(tmpNode);
            }
            return arrDPI;
        },
        //面板属性
        panel: { width: options.panelWidth, height: options.panelHeight, rate: 1, dpi: 72 },
        //标签列表
        items: [],
        //当前拖动大小的元素对象
        resizeItem: null,
        //当前拖动添加标签类型的元素对象
        currDrag: null,
        //复制时的元素
        addJson: null,
        //当前撤销和反撤销的下标
        currIndex: -1,
        //操作记录 用于撤销和反撤销
        operation: [],
        //顶部的刻度尺
        top_ruleline: null,
        //左边的刻度尺
        left_ruleline: null,
        //旋转时间控件
        intervalRoteId: null,
        //编辑属性
        attrs: [
            //面板属性
            {
                group: "attr_panel", title: "纸宽(mm)", control: "control-text", change: function () {
                    if (!design.isInt($(this).val()))
                        $(this).val(design.panel.width);
                    design.panel.width = parseInt($(this).val());
                    if (design.panel.width > 400) {
                        $(this).val("400");
                        design.panel.width = 400;
                        layer.open({ content: '最大宽度400' });
                    }
                    design.initPanel(false);
                }, setdata: function () {
                    return Math.round(design.panel.width * 100) / 100;
                }
            },
            {
                group: "attr_panel", title: "纸高(mm)", control: "control-text", change: function () {
                    if (!design.isInt($(this).val()))
                        $(this).val(design.panel.height);
                    design.panel.height = parseInt($(this).val());
                    if (design.panel.height > 400) {
                        $(this).val("400");
                        design.panel.height = 400;
                        layer.open({ content: '最大高度400' });
                    }
                    design.initPanel(false);
                }, setdata: function () {
                    return Math.round(design.panel.height * 100) / 100;
                }
            },
            //公共属性
            {
                group: "attr_common", title: "KEY", control: "control-ddlsearch", change: function () {
                    design.setAttr("key", $(this).val());
                    //处理文本自适应
                    design.autoFontSize();
                }, setdata: function (entity, type) {
                    if (!entity)
                        return "";
                    if (type == "tagvalue")
                        return entity.key;
                    for (var i = 0; i < options.datakeys.length; i++) {
                        if (options.datakeys[i].value == entity.key) {
                            return options.datakeys[i].text;
                        }
                    }
                    return "";
                }, click: function () {
                    var that = this;
                    if ($(that).val() == "请选择")
                        $(that).val("");
                    design.ddlsearch(that, options.datakeys, function (e) {
                        $(that).val($(e).text());
                        $(that).attr("tagtext", $(e).text());
                        $(that).attr("tagvalue", $(e).attr("value"));
                        design.setAttr("key", $(e).attr("value"));
                    });
                }, keyup: function () {
                    var that = this;
                    design.ddlsearch(that, options.datakeys, function (e) {
                        $(that).val($(e).text());
                        $(that).attr("tagtext", $(e).text());
                        $(that).attr("tagvalue", $(e).attr("value"));
                        design.setAttr("key", $(e).attr("value"));
                    });
                }, blur: function () {
                    $(this).val($(this).attr("tagtext"));
                }, dblclick: function () {
                    design.autofillserialnumber(1);
                }
            },
              {
                  group: "attr_common", title: "层级", control: "control-text", change: function () {
                      if (design.isInt($(this).val()))
                          design.setAttr("zIndex", parseInt($(this).val()));
                  }, setdata: function (entity) {
                      if (!entity)
                          return "";
                      return entity.zIndex;
                  }
              },
            {
                group: "attr_common", title: "宽度(mm)", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        if (parseFloat($(this).val()) < 0)
                            $(this).val("0");
                        design.setAttr("width", design.mmToPx($(this).val()));
                        //处理文本自适应
                        design.autoFontSize();
                        //自动条码大小
                        design.autoBarcodeSize();
                    }
                }, setdata: function (entity) {
                    if (!entity)
                        return "";
                    if (design.isInt(entity.width))
                        return design.pxToMm(entity.width);
                    return "1";
                }
            },
            {
                group: "attr_common", title: "高度(mm)", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        if (parseFloat($(this).val()) < 0)
                            $(this).val("0");
                        design.setAttr("height", design.mmToPx($(this).val()));
                        //处理文本自适应
                        design.autoFontSize();
                        //自动条码大小
                        design.autoBarcodeSize();
                    }
                }, setdata: function (entity) {
                    if (!entity)
                        return "";
                    if (design.isInt(entity.height))
                        return design.pxToMm(entity.height);
                    return "1";
                }
            },
            {
                group: "attr_common", title: "X轴(mm)", control: "control-text", change: function () {
                    if (design.isInt($(this).val()))
                        design.setAttr("left", design.mmToPx($(this).val()));
                }, setdata: function (entity) {
                    if (!entity)
                        return "";
                    if (design.isInt(entity.left))
                        return design.pxToMm(entity.left);
                    return "1";
                }
            },
            {
                group: "attr_common", title: "Y轴(mm)", control: "control-text", change: function () {
                    if (design.isInt($(this).val()))
                        design.setAttr("top", design.mmToPx($(this).val()));
                }, setdata: function (entity) {
                    if (!entity)
                        return "";
                    if (design.isInt(entity.top))
                        return design.pxToMm(entity.top);
                    return "1";
                }
            },
           {
               group: "attr_common", title: "分组", control: "control-text", change: function () {
                   if (design.isInt($(this).val()))
                       design.setAttr("group", parseInt($(this).val()));
               }, setdata: function (entity) {
                   if (!entity || !entity.group)
                       return 1;
                   return entity.group;
               }, dblclick: function () {
                   design.autofillserialnumber(0);
               }
           },
            //文字属性
            {
                group: "attr_text", title: "默认内容", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                    if ($.trim($(this).val()) == "") {
                        layer.open({ content: '默认内容为空,会无法正常预览！' });
                        $(this).val("0123456789");
                    }
                    design.setAttr("text", $(this).val());
                    //处理文本自适应
                    design.autoFontSize();
                    //自动条码大小
                    design.autoBarcodeSize();
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return "";
                    return entity.text;
                }
            },
            {
                group: "attr_text", title: "字体颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setAttr("color", color.toString(color.format));
                    else
                        design.setAttr("color", "#000");
                }, setdata: function (entity) {
                    return entity.color;
                }
            },
            {
                group: "attr_text", title: "背景颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setAttr("backgroundColor", color.toString(color.format));
                    else
                        design.setAttr("backgroundColor", "");
                }, setdata: function (entity) {
                    return entity.backgroundColor;
                }
            },
             {
                 group: "attr_text", title: "边框颜色", control: "control-tackcolor", changecolor: function (color) {
                     if (color && color.ok)
                         design.setAttr("borderColor", color.toString(color.format));
                     else
                         design.setAttr("borderColor", "");
                 }, setdata: function (entity) {
                     if (entity == undefined || entity == null)
                         return "";
                     return entity.borderColor;
                 }
             },
            {
                group: "attr_text", title: "边宽度(mm)", control: "control-text", change: function () {
                    if (design.isInt($(this).val()))
                        design.setAttr("borderWidth", design.mmToPx($(this).val()));
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return "";
                    return design.pxToMm(entity.borderWidth);
                }
            },
            {
                group: "attr_text", title: "字体", control: "control-select", change: function () {
                    design.setAttr("fontFamily", $(this).val());
                }, data: options.fontFamilys, setdata: function (entity) {
                    return entity.fontFamily;
                }
            },
            {
                group: "attr_text", title: "字体大小", key: "fontSize", control: "control-text", change: function (color) {
                    if (design.isInt($(this).val())) {
                        //获取字体大小单位
                        var entity = design.getSelectData();
                        var fontSize = design.ValueToPx($(this).val(), entity.fontSizeUnit);
                        entity.fontSize = fontSize;
                        //行高默认为字体大小                      
                        design.configFontDefaultLineHeight();
                        design.setAttr("fontSize", fontSize);
                    }
                }, setdata: function (entity) {
                    return design.pxToValue(entity.fontSize, entity.fontSizeUnit)
                }
            },
            {
                group: "attr_text", title: "字体大小单位", key: "fontSizeUnit", control: "control-select", change: function () {
                    //配置字体大小
                    var entity = design.getSelectData();
                    var $tdContent = $(this).parent().parent().parent().find("td[key='fontSize']").next();
                    var fontSize = $tdContent.find("input:eq(0)").val();
                    entity.fontSize = design.ValueToPx(fontSize, $(this).val());
                    entity.fontSizeUnit = $(this).val();
                    //行高默认为字体大小
                    design.configFontDefaultLineHeight();
                    design.setAttr("fontSizeUnit", entity.fontSizeUnit);
                    
                }, data: [
                    { value: "pt", text: "字号" },
                    { value: "mm", text: "毫米" },
                    //{ value: "pixel", text: "像素" }
                ], setdata: function (entity) {
                    return entity.fontSizeUnit;
                }
            },
              {
                  group: "attr_text", title: "字间距(mm)", control: "control-text", change: function (color) {
                      if (design.isNumber($(this).val()))
                          design.setAttr("fontSpace", design.mmToPx($(this).val()));
                      //处理文本自适应
                      design.autoFontSize();
                  }, setdata: function (entity) {
                      return design.pxToMm(entity.fontSpace);
                  }
              },
             {
                 group: "attr_text", title: "行高(mm)", control: "control-text", change: function () {
                     if (design.isInt($(this).val())) {
                         if (parseFloat($(this).val()) < 0)
                             $(this).val("0");
                         design.setAttr("lineHeight", design.mmToPx($(this).val()));
                     }
                 }, setdata: function (entity) {
                     if (entity == undefined || entity == null)
                         return "";
                     return design.pxToMm(entity.lineHeight);
                 }
             },
             {
                 group: "attr_text", title: "文本自适应", control: "control-checkbox", click: function () {
                     design.setAttr("enaleAutoTextSize", $(this).get(0).checked ? true : false);
                     //处理文本自适应
                     if ($(this).get(0).checked) {
                         design.autoFontSize();
                     } else {
                         design.configAutoTextSize();
                     }
                 }, setdata: function (entity) {
                     if (entity == undefined || entity == null)
                         return false;
                     return entity.enaleAutoTextSize;
                 }
             },
             {
                 group: "attr_text", title: "圆角(mm)", control: "control-text", change: function () {
                     if (design.isInt($(this).val())) {
                         if (parseFloat($(this).val()) < 0)
                             $(this).val("0");
                         design.setAttr("radius", design.mmToPx($(this).val()));
                     }
                 }, setdata: function (entity) {
                     if (entity == undefined || entity == null)
                         return "";
                     return design.pxToMm(entity.radius);
                 }
             },
              
              {
                  group: "attr_text", title: "对齐方式", control: "control-select", change: function () {
                      design.setAttr("textAlign", $(this).val());
                  }, data: [
                      { value: "left", text: "左" },
                      { value: "center", text: "中" },
                      { value: "right", text: "右" }
                  ], setdata: function (entity) {
                      return entity.textAlign;
                  }
              },
               {
                   group: "attr_text", title: "左内距(mm)", control: "control-text", change: function (color) {
                       if (design.isInt($(this).val()))
                           design.setAttr("paddingLeft", design.mmToPx($(this).val()));
                       //处理文本自适应
                       design.autoFontSize();
                   }, setdata: function (entity) {
                       return design.pxToMm(entity.paddingLeft);
                   }
               },
              {
                  group: "attr_text", title: "右内距(mm)", control: "control-text", change: function (color) {
                      if (design.isInt($(this).val()))
                          design.setAttr("paddingRight", design.mmToPx($(this).val()));
                      //处理文本自适应
                      design.autoFontSize();
                  }, setdata: function (entity) {
                      return design.pxToMm(entity.paddingRight);
                  }
              },
            {
                group: "attr_text", title: "边框虚线", control: "control-checkbox", click: function () {
                    design.setAttr("borderStyle", $(this).get(0).checked ? "dashed" : "solid");
                    //处理文本自适应
                    design.autoFontSize();
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return false;
                    return entity.borderStyle == "dashed";
                }
            },
            {
                group: "attr_text", title: "粗体", control: "control-checkbox", click: function () {
                    design.setAttr("fontWeight", $(this).get(0).checked ? "bold" : "normal");
                    //处理文本自适应
                    design.autoFontSize();
                }, setdata: function (entity) {
                    return entity.fontWeight == "bold";
                }
            },
            {
                group: "attr_text", title: "斜体", control: "control-checkbox", click: function () {
                    design.setAttr("fontStyle", $(this).get(0).checked ? "italic" : "normal");
                    //处理文本自适应
                    design.autoFontSize();
                }, setdata: function (entity) {
                    return entity.fontStyle == "italic";
                }
            },
               {
                   group: "attr_text", title: "下划线", control: "control-checkbox", click: function () {
                       design.setAttr("underline", $(this).get(0).checked);
                       //处理文本自适应
                       design.autoFontSize();
                   }, setdata: function (entity) {
                       return entity.underline;
                   }
               },
                 {
                     group: "attr_text", title: "删除线", control: "control-checkbox", click: function () {
                         design.setAttr("linethrough", $(this).get(0).checked);
                         //处理文本自适应
                         design.autoFontSize();
                     }, setdata: function (entity) {
                         return entity.linethrough;
                     }
                 },
                  {
                      group: "attr_text", title: "旋转(0~360)", control: "control-text", change: function () {
                          if (design.isInt($(this).val())) {
                              if (parseFloat($(this).val()) < 0)
                                  $(this).val("0");
                              if (parseFloat($(this).val()) > 360)
                                  $(this).val("360");
                              design.setAttr("rote", $(this).val());
                          }
                      }, setdata: function (entity) {
                          if (entity == undefined || entity == null)
                              return "";
                          return entity.rote;
                      }
                  },
                   {
                       group: "attr_text", title: "旋转基点", control: "control-select", change: function () {
                           design.setAttr("origin", $(this).val());
                       }, data: [
                           { value: "center center", text: "中点" },
                           { value: "left bottom", text: "左下" },
                           { value: "left top", text: "左上" },
                           { value: "right bottom", text: "右下" },
                           { value: "right top", text: "右上" }
                       ], setdata: function (entity) {
                           return entity.origin;
                       }
                   },
            //二维码属性
              {
                  group: "attr_qrcode", title: "默认内容", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                      if ($.trim($(this).val()) == "") {
                          layer.open({ content: '默认内容为空,会无法正常预览！' });
                          $(this).val("");
                      }
                      design.setAttr("text", $(this).val());
                  }, setdata: function (entity) {
                      if (entity == undefined || entity == null)
                          return "";
                      return entity.text;
                  }
              },
            {
                group: "attr_qrcode", title: "密度", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        if (parseInt($(this).val()) < 0) {
                            $(this).val("0");
                        }
                        if (parseInt($(this).val()) > 40) {
                            $(this).val("40");
                        }
                        design.setAttr("version", parseInt($(this).val()));
                    }
                }, setdata: function (entity) {
                    return entity.version;
                }
            },
            {
                group: "attr_qrcode", title: "清晰度", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        if (parseInt($(this).val()) < 1) {
                            $(this).val("1");
                        }
                        if (parseInt($(this).val()) > 40) {
                            $(this).val("40");
                        }
                        design.setAttr("scale", parseInt($(this).val()));
                    }
                }, setdata: function (entity) {
                    return entity.scale;
                }
            },
               {
                   group: "attr_qrcode", title: "旋转(0~360)", control: "control-text", change: function () {
                       if (design.isInt($(this).val())) {
                           if (parseFloat($(this).val()) < 0)
                               $(this).val("0");
                           if (parseFloat($(this).val()) > 360)
                               $(this).val("360");
                           design.setAttr("rote", $(this).val());
                       }
                   }, setdata: function (entity) {
                       if (entity == undefined || entity == null)
                           return "";
                       return entity.rote;
                   }
               },
                   {
                       group: "attr_qrcode", title: "旋转基点", control: "control-select", change: function () {
                           design.setAttr("origin", $(this).val());
                       }, data: [
                           { value: "center center", text: "中点" },
                           { value: "left bottom", text: "左下" },
                           { value: "left top", text: "左上" },
                           { value: "right bottom", text: "右下" },
                           { value: "right top", text: "右上" }
                       ], setdata: function (entity) {
                           return entity.origin;
                       }
                   },
			{
			    group: "attr_qrcode", title: "换行符", control: "control-text", change: function () {
			        design.setAttr("overflow", $(this).val());
			    }, setdata: function (entity) {
			        return entity.overflow ? entity.overflow : "";
			    }
			},
            //条码属性
            {
                group: "attr_barcode", title: "默认内容", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                    if ($.trim($(this).val()) == "") {
                        layer.open({ content: '默认内容为空,会无法正常预览！' });
                        $(this).val("");
                    }
                    design.setAttr("text", $(this).val());
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return "";
                    return entity.text;
                }
            },
            {
                group: "attr_barcode", title: "类型", control: "control-select", change: function () {
                    design.setAttr("version", $(this).val());
                    design.configLabelFontSize();
                    //标记img为类型切换中
                    $("#panel .select img").addClass("changeVersion");
                }, data: [
                    { value: "-1", text: "默认" },
                    { value: "1", text: "UPCA" },
                    { value: "2", text: "UPCE" },
                    { value: "3", text: "UPC_SUPPLEMENTAL_2DIGIT" },
                    { value: "4", text: "UPC_SUPPLEMENTAL_5DIGIT" },
                    { value: "5", text: "EAN13" },
                    { value: "35", text: "EAN13_A" },
                    { value: "6", text: "EAN8" },
                    { value: "7", text: "Interleaved2of5" },
                    { value: "8", text: "Standard2of5" },
                    { value: "9", text: "Industrial2of5" },
                    { value: "10", text: "CODE39" },
                    { value: "11", text: "CODE39Extended" },
                    { value: "12", text: "Codabar" },
                    { value: "13", text: "PostNet" },
                    { value: "14", text: "BOOKLAND" },
                    { value: "15", text: "ISBN" },
                    { value: "16", text: "JAN13" },
                    { value: "17", text: "MSI_Mod10" },
                    { value: "18", text: "MSI_2Mod10" },
                    { value: "19", text: "MSI_Mod11" },
                    { value: "20", text: "MSI_Mod11_Mod10" },
                    { value: "21", text: "Modified_Plessey" },
                    { value: "22", text: "CODE11" },
                    { value: "23", text: "USD8" },
                    { value: "24", text: "UCC12" },
                    { value: "25", text: "UCC13" },
                    { value: "26", text: "LOGMARS" },
                    { value: "27", text: "CODE128" },
                    { value: "28", text: "CODE128A" },
                    { value: "29", text: "CODE128B" },
                    { value: "30", text: "CODE128C" },
                    { value: "31", text: "ITF14" },
                    { value: "32", text: "CODE93" },
                    { value: "33", text: "TELEPEN" },
                    { value: "34", text: "FIM" },
                    { value: "36", text: "PDF417" }
                ], setdata: function (entity) {
                    return entity.version;
                }
            }, {
                group: "attr_barcode", title: "线宽(px)", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        design.setAttr("barWidth", parseInt($(this).val()));
                    }
                    else {
                        design.setAttr("barWidth", 0);
                    }
                }, setdata: function (entity) {
                    if (!entity.barWidth)
                        entity.barWidth = 0;
                    return entity.barWidth;
                }
            }, {
                group: "attr_barcode", title: "宽度(px)", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        design.setAttr("line_bx", parseInt($(this).val()));
                    }
                }, setdata: function (entity) {
                    if (!entity.line_bx)
                        entity.line_bx = 300;
                    return entity.line_bx;
                }
            }, {
                group: "attr_barcode", title: "高度(px)", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        design.setAttr("line_by", parseInt($(this).val()));
                    }
                }, setdata: function (entity) {
                    if (!entity.line_by)
                        entity.line_by = 100;
                    return entity.line_by;
                }
            }, {
                group: "attr_barcode", title: "条码颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setAttr("color", color.toString(color.format));
                    else
                        design.setAttr("color", "#000");
                }, setdata: function (entity) {
                    return entity.color;
                }
            },
            {
                group: "attr_barcode", title: "背景颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setAttr("backgroundColor", color.toString(color.format));
                    else
                        design.setAttr("backgroundColor", "#fff");
                }, setdata: function (entity) {
                    return entity.backgroundColor;
                }
            },
                 {
                     group: "attr_barcode", title: "旋转(0~360)", control: "control-text", change: function () {
                         if (design.isInt($(this).val())) {
                             if (parseFloat($(this).val()) < 0)
                                 $(this).val("0");
                             if (parseFloat($(this).val()) > 360)
                                 $(this).val("360");
                             design.setAttr("rote", $(this).val());
                         }
                     }, setdata: function (entity) {
                         if (entity == undefined || entity == null)
                             return "";
                         return entity.rote;
                     }
                 },
                   {
                       group: "attr_barcode", title: "旋转基点", control: "control-select", change: function () {
                           design.setAttr("origin", $(this).val());
                       }, data: [
                           { value: "center center", text: "中点" },
                           { value: "left bottom", text: "左下" },
                           { value: "left top", text: "左上" },
                           { value: "right bottom", text: "右下" },
                           { value: "right top", text: "右上" }
                       ], setdata: function (entity) {
                           return entity.origin;
                       }
                   },
                    {
                        group: "attr_barcode", title: "是否显示标签", control: "control-select", change: function () {
                            design.setAttr("includeLabel", $(this).val() === "1");
                        }, data: [
                            { value: "0", text: "否" },
                            { value: "1", text: "是" },
                            
                        ], setdata: function (entity) {
                            return entity.includeLabel;
                        }
                    },
                    {
                        group: "attr_barcode", title: "是否显示边框", control: "control-select", change: function () {
                            design.setAttr("includeBorder", $(this).val() === "1");
                        }, data: [
                            { value: "0", text: "否" },
                            { value: "1", text: "是" },

                        ], setdata: function (entity) {
                            return entity.includeBorder;
                        }
                    },
                    {
                        group: "attr_barcode", title: "字体", control: "control-select", change: function () {
                            design.setAttr("fontFamily", $(this).val());
                        }, data: options.fontFamilys, setdata: function (entity) {
                            return entity.fontFamily;
                        }
                    },
                    {
                        group: "attr_barcode", title: "字体大小", key: "fontSize", control: "control-text", change: function (color) {
                            if (design.isInt($(this).val())) {
                                //获取字体大小单位
                                var entity = design.getSelectData();
                                design.setAttr("fontSize", design.ValueToPx($(this).val(), entity.fontSizeUnit, true));
                            }
                        }, setdata: function (entity) {
                            return design.pxToValue(entity.fontSize, entity.fontSizeUnit, true)
                        }
                    },
                    {
                        group: "attr_barcode", title: "字体大小单位", key: "fontSizeUnit", control: "control-select", change: function () {
                            //配置字体大小
                            var entity = design.getSelectData();
                            var $tdContent = $(this).parent().parent().parent().find("td[key='fontSize']").next();
                            var fontSize = $tdContent.find("input:eq(0)").val();
                            entity.fontSize = design.ValueToPx(fontSize, $(this).val(), true);
                            design.setAttr("fontSizeUnit", $(this).val());
                    
                        }, data: [
                            { value: "pt", text: "字号" },
                            { value: "mm", text: "毫米" },
                            //{ value: "pixel", text: "像素" }
                        ], setdata: function (entity) {
                            return entity.fontSizeUnit;
                        }
                    },
                    {
                        group: "attr_barcode", title: "粗体", control: "control-checkbox", click: function () {
                            design.setAttr("fontWeight", $(this).get(0).checked ? "bold" : "normal");
                        }, setdata: function (entity) {
                            return entity.fontWeight == "bold";
                        }
                    },
                    {
                        group: "attr_barcode", title: "斜体", control: "control-checkbox", click: function () {
                            design.setAttr("fontStyle", $(this).get(0).checked ? "italic" : "normal");
                        }, setdata: function (entity) {
                            return entity.fontStyle == "italic";
                        }
                    },
                   {
                       group: "attr_barcode", title: "下划线", control: "control-checkbox", click: function () {
                           design.setAttr("underline", $(this).get(0).checked);
                       }, setdata: function (entity) {
                           return entity.underline;
                       }
                   },
                {
                    group: "attr_barcode", title: "删除线", control: "control-checkbox", click: function () {
                        design.setAttr("linethrough", $(this).get(0).checked);
                    }, setdata: function (entity) {
                        return entity.linethrough;
                    }
                },
                    //二维条码属性
              {
                  group: "attr_matrix", title: "默认内容", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                      if ($.trim($(this).val()) == "") {
                          layer.open({ content: '默认内容为空,会无法正常预览！' });
                          $(this).val("");
                      }
                      design.setAttr("text", $(this).val());
                  }, setdata: function (entity) {
                      if (entity == undefined || entity == null)
                          return "";
                      return entity.text;
                  }
              },
            {
                group: "attr_matrix", title: "清晰度", colspan: 3, control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        if (parseInt($(this).val()) < 1) {
                            $(this).val("1");
                        }
                        if (parseInt($(this).val()) > 40) {
                            $(this).val("40");
                        }
                        design.setAttr("scale", parseInt($(this).val()));
                    }
                }, setdata: function (entity) {
                    return entity.scale;
                }
            },
               {
                   group: "attr_matrix", title: "旋转(0~360)", control: "control-text", change: function () {
                       if (design.isInt($(this).val())) {
                           if (parseFloat($(this).val()) < 0)
                               $(this).val("0");
                           if (parseFloat($(this).val()) > 360)
                               $(this).val("360");
                           design.setAttr("rote", $(this).val());
                       }
                   }, setdata: function (entity) {
                       if (entity == undefined || entity == null)
                           return "";
                       return entity.rote;
                   }
               },
                   {
                       group: "attr_matrix", title: "旋转基点", control: "control-select", change: function () {
                           design.setAttr("origin", $(this).val());
                       }, data: [
                           { value: "center center", text: "中点" },
                           { value: "left bottom", text: "左下" },
                           { value: "left top", text: "左上" },
                           { value: "right bottom", text: "右下" },
                           { value: "right top", text: "右上" }
                       ], setdata: function (entity) {
                           return entity.origin;
                       }
                   },
            //线条属性
            {
                group: "attr_line", title: "旋转(0~180)", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        if (parseFloat($(this).val()) < 0)
                            $(this).val("0");
                        if (parseFloat($(this).val()) > 180)
                            $(this).val("180");
                        design.setAttr("rote", $(this).val());
                    }
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return "";
                    return entity.rote;
                }
            },
            {
                group: "attr_line", title: "线条颜色", control: "control-tackcolor", changecolor: function (color) {
                    if (color && color.ok)
                        design.setAttr("strokeStyle", color.toString(color.format));
                    else
                        design.setAttr("strokeStyle", "");
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return "";
                    return entity.strokeStyle;
                }
            },
            {
                group: "attr_line", title: "线宽", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        design.setAttr("lineWidth", design.mmToPx($(this).val()) * 0.3527);
                    }
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return "1";
                    return parseFloat(design.pxToMm(entity.lineWidth) / 0.3527).toFixed(2);
                }
            },
             {
                 group: "attr_line", title: "虚线", control: "control-checkbox", click: function () {
                     design.setAttr("borderStyle", $(this).get(0).checked ? "dashed" : "solid");
                 }, setdata: function (entity) {
                     if (entity == undefined || entity == null)
                         return false;
                     return entity.borderStyle == "dashed";
                 }
             },
             {
                 group: "attr_line", title: "虚线长", control: "control-text", change: function () {
                     if (design.isInt($(this).val())) {
                         if (parseFloat($(this).val()) < 1)
                             $(this).val("1");
                         $(this).val(parseInt($(this).val()));
                         design.setAttr("unitsOn", design.mmToPx($(this).val()) * 0.3527);
                     }
                 }, setdata: function (entity) {
                     if (entity == undefined || entity == null)
                         return "1";
                     return parseInt(design.pxToMm(entity.unitsOn) / 0.3527);
                 }
             },
              {
                  group: "attr_line", title: "虚线间隙", control: "control-text", change: function () {
                      if (design.isInt($(this).val())) {
                          if (parseFloat($(this).val()) < 1)
                              $(this).val("1");
                          $(this).val(parseInt($(this).val()));
                          design.setAttr("unitsOff", design.mmToPx($(this).val()) * 0.3527);
                      }
                  }, setdata: function (entity) {
                      if (entity == undefined || entity == null)
                          return "1";
                      return parseInt(design.pxToMm(entity.unitsOff) / 0.3527);
                  }
              },
            //图片属性
           {
               group: "attr_img", title: "边框颜色", control: "control-tackcolor", changecolor: function (color) {
                   if (color && color.ok)
                       design.setAttr("borderColor", color.toString(color.format));
                   else
                       design.setAttr("borderColor", "");
               }, setdata: function (entity) {
                   if (entity == undefined || entity == null)
                       return "";
                   return entity.borderColor;
               }
           },
          {
              group: "attr_img", title: "边宽度(mm)", control: "control-text", change: function () {
                  if (design.isInt($(this).val()))
                      design.setAttr("borderWidth", design.mmToPx($(this).val()));
              }, setdata: function (entity) {
                  if (entity == undefined || entity == null)
                      return "";
                  return design.pxToMm(entity.borderWidth);
              }
          },
            {
                group: "attr_img", title: "边框虚线", control: "control-checkbox", click: function () {
                    design.setAttr("borderStyle", $(this).get(0).checked ? "dashed" : "solid");
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return false;
                    return entity.borderStyle == "dashed";
                }
            },
             {
                 group: "attr_img", title: "圆角(mm)", control: "control-text", change: function () {
                     if (design.isInt($(this).val())) {
                         if (parseFloat($(this).val()) < 0)
                             $(this).val("0");
                         design.setAttr("radius", design.mmToPx($(this).val()));
                     }
                 }, setdata: function (entity) {
                     if (entity == undefined || entity == null)
                         return "";
                     return design.pxToMm(entity.radius);
                 }
             },
            {
                group: "attr_img", title: "旋转(0~360)", control: "control-text", change: function () {
                    if (design.isInt($(this).val())) {
                        if (parseFloat($(this).val()) < 0)
                            $(this).val("0");
                        if (parseFloat($(this).val()) > 360)
                            $(this).val("360");
                        design.setAttr("rote", $(this).val());
                    }
                }, setdata: function (entity) {
                    if (entity == undefined || entity == null)
                        return "";
                    return entity.rote;
                }
            },
            {
                group: "attr_img", title: "旋转基点", control: "control-select", change: function () {
                    design.setAttr("origin", $(this).val());
                }, data: [
                    { value: "center center", text: "中点" },
                    { value: "left bottom", text: "左下" },
                    { value: "left top", text: "左上" },
                    { value: "right bottom", text: "右下" },
                    { value: "right top", text: "右上" }
                ], setdata: function (entity) {
                    return entity.origin;
                }
            }
        ],
        //搜索下拉框
        ddlsearch: function (node, array, callback) {
            var val = $.trim($(node).val()).toLowerCase();
            $(".ddlsearch").remove();
            var str = "";
            for (var i = 0; i < array.length; i++) {
                if (val != "" && array[i].text.toLowerCase().indexOf(val) == -1)
                    continue;
                str += "<div value='" + array[i].value + "'>" + array[i].text + "</div>";
            }
            var div = $("<div class='ddlsearch'></div>").css({ top: $(node).offset().top + $(node).height(), left: $(node).offset().left }).html(str).mouseleave(function () {
                $(this).remove();
            }).appendTo($("body"));
            div.find("div").click(function () {
                callback(this);
                div.remove();
            });
        },
        //初始化
        init: function () {
            //初始化面板高宽
            this.panel.width = this.pxToMm(this.panel.width);
            this.panel.height = this.pxToMm(this.panel.height);
            //初始化大小
            this.resize(true);
            //初始化拖动
            this.initDrag();
            //点击左右两边和刻度尺的时候取消选择
            $("#d_left").unbind("click").bind("click", design.cancelAll).show();
            $("#d_right").unbind("click").bind("click", function (e) {
                if (e.eventPhase == 2)
                    design.cancelAll();
            }).scroll(function () { $(".ddlsearch").remove(); }).show();
            $("#top_rule").unbind("click").bind("click", design.cancelAll);
            $("#left_rule").unbind("click").bind("click", design.cancelAll);
            //对齐,分散，缩放，预览，保存
            $("#btn_top").unbind("click").bind("click", function () { design.align(0); });
            $("#btn_left").unbind("click").bind("click", function () { design.align(1); });
            $("#btn_bottom").unbind("click").bind("click", function () { design.align(2); });
            $("#btn_right").unbind("click").bind("click", function () { design.align(3); });
            $("#btn_vertical").unbind("click").bind("click", function () { design.movePosition(true); });
            $("#btn_level").unbind("click").bind("click", function () { design.movePosition(false); });
            $("#btn_preview").unbind("click").bind("click", design.preview);
            $("#btn_print").unbind("click").bind("click", design.openPrintDialog);
            $("#btn_save").unbind("click").bind("click", design.save);
            this.panelKeyDown();
            $("#rdofs").click(function () {
                $("#txtautoarrange").hide();
            });
            $("#rdodq").click(function () {
                $("#txtautoarrange").hide();
            });
            $("#rdokq").click(function () {
                $("#txtautoarrange").show();
            });
            $("#btn_zoomin").click(function () {
                design.zoom((design.panel.rate * 10 + 1) / 10, true);
            });
            $("#btn_zoomout").click(function () {
                design.zoom((design.panel.rate * 10 - 1) / 10, true);
            });
            window.onresize = function () {
                design.resize(false);
            }
            window.onkeydown = function (e) {
                if (e.target.nodeName != "INPUT" && e.which == 8) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            }
            //鼠标右键
            $("body").bind('mousewheel DOMMouseScroll', function (e) {
                if (window.event.ctrlKey) {
                    var wheel = e.originalEvent.wheelDelta;
                    var detal = e.originalEvent.detail;
                    if (wheel) {
                        if (wheel > 0) {
                            design.zoom((design.panel.rate * 10 + 1) / 10, true);
                        }
                        if (wheel < 0) {
                            design.zoom((design.panel.rate * 10 - 1) / 10, true);
                        }
                    } else if (detal) {
                        if (detal > 0) {
                            design.zoom((design.panel.rate * 10 - 1) / 10, true);
                        }
                        if (detal < 0) {
                            design.zoom((design.panel.rate * 10 + 1) / 10, true);
                        }
                    }
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
            //初始化数据
            design.initdata(options.tempSet);
        },
        //检查socket连接信息
        checkConnection: function (showmsg) {
            var ip = $("#txtdesign_ip").val();
            if ($.trim(ip) == "") {
                if (showmsg)
                    layer.open({ content: '请输入IP' });
                return null;
            }
            if (!/^\d+\.\d+\.\d+\.\d+$/.test(ip)) {
                if (showmsg)
                    layer.open({ content: 'IP格式错误' });
                return null;
            }
            var port = $("#txtdesign_port").val();
            if (!design.isInt(port)) {
                if (showmsg)
                    layer.open({ content: '端口格式错误' });
                return null;
            }
            var cookie = design.socketCookie();
            cookie.ip = ip;
            cookie.port = port;
            if ($("#ddlprintname").val()) {
                cookie.printname = $("#ddlprintname").val();
            }
            cookie.printtype = parseInt($("#ddlprinttype").val());
            design.socketCookie(JSON.stringify(cookie));
            return cookie;
        },
        //加载打印机
        loadPrinter: function () {
            var cookie = design.checkConnection(true);
            if (!cookie)
                return;
            var loading_id = layer.load(1, { shade: [0.5, '#000'] });
            $.initWebSocket({
                Ip: cookie.ip,
                Port: cookie.port,
                Method: "GetPrinter",
                Data: null,
                onMessage: function (ws, msg) {
                    layer.close(loading_id);
                    var data = JSON.parse(msg.data);
                    if (!data.Success) {
                        layer.open({ content: data.Error });
                        return;
                    }
                    var html;
                    for (var filed in data.Result) {
                        html += "<option value=\"" + filed + "\">" + filed + "</option>"
                    }
                    $("#ddlprintname").html(html);
                    if (cookie.printname)
                        $("#ddlprintname").val(cookie.printname);
                },
                onClose: function (ws, msg) {
                    layer.close(loading_id);
                    if (ws && ws.readyState != 1) {
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    }
                }
            });
        },
        //点击打印
        print: function () {
            var cookie = design.checkConnection(true);
            if (!cookie)
                return;
            if (!cookie.printname) {
                layer.open({ content: '请选择打印机' });
                return false;
            }
            var val = design.panel.rate;
            var count = 1;
            if (design.isInt($("#txtprintcount").val())) {
                count = parseInt($("#txtprintcount").val());
            }
            var data = [];
            for (var i = 0; i < count; i++) {
                data.push({ LabelContent: [] });
            }
            design.zoom(1);
            var list = JSON.parse(JSON.stringify(design.items));
            for (var i = 0; i < list.length; i++) {
                list[i].group = 1;
            }
            var str = JSON.stringify({
                List: list,
                Width: design.mmToPx(design.panel.width),
                Height: design.mmToPx(design.panel.height),
                PrintName: cookie.printname,
                Data: data,
                Type: cookie.printtype,
                Version: options.version,
                Domain: options.domain
            });
            design.zoom(val);
            var loading_id = layer.load(1, { shade: [0.5, '#000'] });
            $.initWebSocket({
                Ip: cookie.ip,
                Port: cookie.port,
                Method: "Print",
                Data: str,
                onMessage: function (ws, msg) {
                    layer.close(loading_id);
                    var data = JSON.parse(msg.data);
                    if (!data.Success) {
                        layer.open({ content: data.Error });
                        return;
                    }
                    if (data.Result) {
                        layer.open({ title: "打印机脱机", content: "如需预览请复制以下地址到浏览器地址栏并回车。<textarea style='width:100%;height:100%;border:none;overflow:hidden;color:red;'>" + data.Result + "</textarea>" });
                        return;
                    }
                    layer.open({ content: "打印完成" });
                },
                onClose: function (ws, msg) {
                    layer.close(loading_id);
                    if (ws && ws.readyState != 1) {
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    }
                }
            });
            return true;
        },
        //获取Cookie
        socketCookie: function (value) {
            if (value) {
                $.cookie("SocketParams", value, { expires: 7 });
                return;
            }
            var option = $.cookie("SocketParams");
            if (!option) {
                option = {
                    ip: "127.0.0.1",
                    port: "53817",
                    printname: "",
                    printtype: 0,
                    rate: 1
                };
            } else {
                option = JSON.parse(option);
            }
            if (!option.rate)
                option.rate = 1;
            return option;
        },
        //打开打印选项
        openPrintDialog: function () {
            if (!design.items || design.items.length == 0) {
                layer.alert("请先编辑打印模板", {
                    icon: 5
                });
                return false;
            }
            var cookie = design.socketCookie();
            layer.open({
                type: 1,
                area: ["400px", "390px"],
                title: "打印",
                content: "<br/><div class='layui-form-item'>"
                            + "<div class='layui-inline'>"
                                 + "<label class='layui-form-label'>IP</label>"
                                 + "<div class='layui-input-inline'><input type='text'  maxlength='15' id='txtdesign_ip' value='" + cookie.ip + "' class='layui-input'></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                 + "<label class='layui-form-label'>端口</label>"
                                 + "<div class='layui-input-inline'><input type='text' maxlength='4' id='txtdesign_port' value='" + cookie.port + "' class='layui-input'></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                    + "<label class='layui-form-label'>打印机</label>"
                                    + "<div class='layui-input-inline'><select class='layui-input' id='ddlprintname'></select></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                    + "<label class='layui-form-label'></label>"
                                    + "<div class='layui-input-inline'><a id='areloadprint' style='cursor:pointer;color:#0094ff;'>刷新打印机</a></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                    + "<label class='layui-form-label'>份数</label>"
                                    + "<div class='layui-input-inline'><input type='text' id='txtprintcount' value='1' class='layui-input'></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                + "<label class='layui-form-label'>方式</label>"
                                + "<div class='layui-input-inline'><select class='layui-input' id='ddlprinttype'><option value='0'>默认</option><option value='1'>Adobe</option><option value='2'>zpl</option></select></div>"
                            + "</div>"
                        + "</div>",
                btn: ['确定', '取消'],
                btn1: function (index, layero) {
                    if (!design.print())
                        return;
                    layer.close(index);
                }
            });
            $("#areloadprint").unbind("click").bind("click", design.loadPrinter);

            if (design.checkConnection(false))
                $("#areloadprint").trigger("click");
            $("#ddlprinttype").val(cookie.printtype);
        },
        //初始化拖动标签类型
        initDrag: function () {
            $("#d_left img").unbind("mouseover").bind("mouseover", function () {
                if (design.currDrag)
                    design.currDrag.remove();
                var set = $(this).offset();
                design.currDrag = $($(this)[0].outerHTML)
                    .css({ position: "absolute", top: set.top, left: set.left, zIndex: 9999 })
                    .draggable({
                        stop: function (event, ui) {
                            var that = $(this);
                            var p = $("#panel").offset();
                            var item = design.newEntity(that.width(), that.height(), ui.position.top, ui.position.left, that.attr("type"));
                            that.remove();
                            if (design.items.length >= 300) {
                                layer.open({ content: '别拖了,最多拖300个。' });
                                return;
                            }
                            if (ui.position.top >= p.top && ui.position.top + item.height <= design.mmToPx(design.panel.height) + p.top && ui.position.left >= p.left && ui.position.left + item.width <= p.left + design.mmToPx(design.panel.width)) {
                                item.top = ui.position.top - p.top;
                                item.left = ui.position.left - p.left;
                                if (item.left + item.width > design.mmToPx(design.panel.width))
                                    item.left = design.mmToPx(design.panel.width) - item.width;
                                design.cancelAll();
                                design.addItem(item, true);
                                design.items.push(item);
                                design.saveOperation();
                            }
                        }
                    })
                    .appendTo($(this).parent())
                    .unbind("dblclick").bind("dblclick", function () {
                        design.cancelAll();
                        var type = $(this).attr("type");
                        $("#panel .drag").each(function () {
                            var entity = $(this).data("Entity");
                            if (entity.type == "text") {
                                if (type == "text" && entity.text.length > 0) {
                                    $(this).removeClass("unselect").addClass("select");
                                }
                                else if (type == "rect" && entity.borderWidth > 0) {
                                    $(this).removeClass("unselect").addClass("select");
                                }
                            } else if (entity.type == type) {
                                $(this).removeClass("unselect").addClass("select");
                            }
                        });
                        design.createSelectItemAttr();
                    });
            });
        },
        //初始化数据
        initdata: function (json) {
            if (!json)
                return;
            design.items = json;
            design.zoom(design.socketCookie().rate);
            design.currIndex = -1;
            design.operation = [];
            design.saveOperation();
        },
        //初始化刻度尺
        initrule: function (pw, ph) {
            var vw = design.mmToPx(parseFloat(design.panel.width) + 10), vh = design.mmToPx(parseFloat(design.panel.height) + 10);
            var top_r = {
                width: vw,
                height: 50,
                top: 0,
                left: 20
            };
            var top_li2 = "";
            var top_li1 = "";
            var li_width = parseFloat(top_r.width) / (parseFloat(design.panel.width) + 10);
            for (var i = 0; i < parseFloat(design.panel.width) + 10; i++) {
                if (i % 10 == 0) {
                    top_li2 += "<li style='width:" + li_width + "px;height:20px;border-left: 1px solid #000; float: left;box-sizing: border-box;margin-top:5px;'></li>";
                    top_li1 += "<li style='width:" + li_width * 10 + "px;height:25px;display:inline-block;'><span style='position:absolute;margin-left:-" + (i / 10 < 10 ? '4' : '7') + "px;'>" + i / 10 + "<span></li>";
                }
                else if (i % 5 == 0) {
                    top_li2 += "<li style='width:" + li_width + "px;height:15px;border-left: 1px solid #000; float: left;box-sizing: border-box;margin-top:10px;'></li>";
                }
                else {
                    top_li2 += "<li style='width:" + li_width + "px;height:10px;border-left: 1px solid #000; float: left;box-sizing: border-box;margin-top:15px;'></li>";
                }
            }
            $("#top_rule").css(top_r).html("<div style='display:block;white-space:nowrap;'><ul>" + top_li1 + "</ul><div/><div><ul>" + top_li2 + "</ul></div>");

            var left_r = {
                width: 50,
                height: vh,
                top: 20,
                left: 0
            };
            var left_li2 = "";
            var left_li1 = "";
            var li_height = parseFloat(left_r.height) / (parseFloat(design.panel.height) + 10);
            for (var i = 0; i < parseFloat(design.panel.height) + 10; i++) {
                if (i % 10 == 0) {
                    left_li2 += "<li style='height:" + li_height + "px;width:20px;border-top: 1px solid #000;box-sizing: border-box;margin-left:30px;'></li>";
                    left_li1 += "<li style='height:" + li_height * 10 + "px;width:25px;'><span style='position:absolute;margin-top:-7px;'>" + i / 10 + "<span></li>";
                }
                else if (i % 5 == 0) {
                    left_li2 += "<li style='height:" + li_height + "px;width:15px;border-top: 1px solid #000;box-sizing: border-box;margin-left:35px;'></li>";
                }
                else {
                    left_li2 += "<li style='height:" + li_height + "px;width:10px;border-top: 1px solid #000;box-sizing: border-box;margin-left:40px;'></li>";
                }
            }
            $("#left_rule").css(left_r).html("<ul style='float:left;'>" + left_li1 + "</ul><ul>" + left_li2 + "</ul>");
        },
        //初始化面板
        initPanel: function (empty) {
            var panel = $("#panel");
            var ph = panel.parent().height();
            var ch = design.mmToPx(design.panel.height);
            design.initrule(panel.parent().width(), ph);
            var set = {
                width: design.mmToPx(design.panel.width), height: ch, opacity: 1, top: 20, left: 20
            };
            if (!empty) {
                panel.css(set);
                return;
            }
            panel.empty()
            .css(set)
            //.css({ width: 0, height: 0, opacity: 0, top: parseFloat(ch) / 2 + 70, left: design.mmToPx(design.panel.width) / 2 + 70 })
            //.animate(set, 500)
            .selectable({
                filter: "div.drag",
                start: function (event, ui) {
                    $("#panel").focus();
                    if (window.event.ctrlKey)
                        return;
                    design.cancelAll();
                },
                stop: design.createSelectItemAttr,
                selected: function (event, ui) {
                    var item = $(ui.selected);
                    item.removeClass("unselect").addClass("select");
                },
                unselected: function (event, ui) {
                    var item = $(ui.unselected);
                    item.removeClass("select").addClass("unselect");
                }
            })
            .mousemove(function (e) {
                if (!design.resizeItem)
                    return;
                var vSet = $(this).offset();
                var vX = e.pageX - vSet.left;
                var vY = e.pageY - vSet.top;
                var vName = design.resizeItem.attr("class");
                var parent = design.resizeItem.parent();
                var entity = parent.data("Entity");
                if (vName.indexOf("top") > -1 && entity.top - vY + entity.height >= 2) {
                    entity.height = entity.top - vY + entity.height;
                    entity.top = vY;
                }
                if (vName.indexOf("bottom") > -1) {
                    entity.height = vY - entity.top + 1;
                }
                if (vName.indexOf("left") > -1 && entity.left - vX + entity.width >= 2) {
                    entity.width = entity.left - vX + entity.width;
                    entity.left = vX;
                }
                if (vName.indexOf("right") > -1) {
                    entity.width = vX - entity.left + 1;
                }
                design.itemCss(parent, entity);
                design.autoFontSize();
                design.autoBarcodeSize();
            })
            .mouseup(function (e) {
                if (!design.resizeItem)
                    return;
                design.resizeItem = null;
                if ($("#panel .select").length == 1) {
                    var node = $("#panel .select").eq(0);
                    var itemdata = node.data("Entity");
                    if (itemdata.type == "qrcode" || itemdata.type == "barcode")
                        $(node).find("img").attr("src", design.getCodeUrl(itemdata));
                    design.createAttr("attr_common", itemdata);
                    design.saveOperation();
                }
            })
            .contextmenu(function (e) {
                var menu = $("#div_menu");
                if (!menu || menu.length == 0) {
                    menu = $("<div id='div_menu'></div>").mouseleave(function () {
                        $(this).hide();
                    }).appendTo($("body"));
                    $("<div>全选&nbsp;&nbsp;Ctrl+A</div>").click(function () {
                        menu.hide(); $("#panel").focus(); design.ctrlA();
                    }).appendTo(menu);
                    $("<div>复制&nbsp;&nbsp;Ctrl+C</div>").click(function () {
                        menu.hide(); $("#panel").focus(); design.ctrlC();
                    }).appendTo(menu);
                    $("<div>粘贴&nbsp;&nbsp;Ctrl+V</div>").click(function () {
                        menu.hide(); $("#panel").focus(); design.ctrlV();
                    }).appendTo(menu);
                    $("<div>撤销&nbsp;&nbsp;Ctrl+Z</div>").click(function () {
                        menu.hide(); $("#panel").focus(); design.ctrlZ();
                    }).appendTo(menu);
                    $("<div>反撤销&nbsp;&nbsp;Ctrl+Y</div>").click(function () {
                        menu.hide(); $("#panel").focus(); design.ctrlY();
                    }).appendTo(menu);
                    $("<div>删除&nbsp;&nbsp;Delete</div>").click(function () {
                        menu.hide(); $("#panel").focus(); design.deleteItems();
                    }).appendTo(menu);
                    $("<div>取消选中</div>").click(function () {
                        menu.hide(); $("#panel").focus(); design.cancelAll();
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
            design.createAttr("attr_panel");
            design.createAttr("attr_common");
        },
        zoomAttr: ["top", "left", "width", "height", "lineHeight", "borderWidth", "fontSize", "fontSpace", "radius", "paddingLeft", "paddingRight"],
        //面板放大缩小
        zoom: function (rate, showmsg) {
            if (showmsg) {
                layer.msg(design.panel.rate + "倍");
            }
            if (rate < 1) {
                layer.open({ content: '不能在小了' });
                return;
            }
            if (rate > 3) {
                layer.open({ content: '不能在大了' });
                return;
            }
            for (var i = 0; i < design.items.length; i++) {
                for (var j = 0; j < design.zoomAttr.length; j++) {
                    if (design.isNumber(design.items[i][design.zoomAttr[j]]))
                        if (design.zoomAttr[j] == "fontSize") {
                            design.items[i][design.zoomAttr[j]] = design.pxToValue(design.items[i][design.zoomAttr[j]],
                                design.items[i].fontSizeUnit,
                                design.items[i].type == "barcode" ? true : false);
                        }
                        else {
                            design.items[i][design.zoomAttr[j]] = design.pxToMm(design.items[i][design.zoomAttr[j]]);
                        }
                }
                if (design.items[i].type == "line") {
                    design.items[i].unitsOn = design.pxToMm(design.items[i].unitsOn) / 0.3527;
                    design.items[i].unitsOff = design.pxToMm(design.items[i].unitsOff) / 0.3527;
                    design.items[i].lineWidth = design.pxToMm(design.items[i].lineWidth) / 0.3527;
                }
            }
            design.panel.rate = rate;
            for (var i = 0; i < design.items.length; i++) {
                for (var j = 0; j < design.zoomAttr.length; j++) {
                    if (design.isNumber(design.items[i][design.zoomAttr[j]])) {
                        if (design.zoomAttr[j] == "fontSize") {
                            design.items[i][design.zoomAttr[j]] = design.ValueToPx(design.items[i][design.zoomAttr[j]],
                                design.items[i].fontSizeUnit,
                                design.items[i].type == "barcode" ? true : false);
                        }
                        else {
                            design.items[i][design.zoomAttr[j]] = design.mmToPx(design.items[i][design.zoomAttr[j]]);
                        }
                    }

                }
                if (design.items[i].type == "line") {
                    design.items[i].unitsOn = design.mmToPx(design.items[i].unitsOn) * 0.3527;
                    design.items[i].unitsOff = design.mmToPx(design.items[i].unitsOff) * 0.3527;
                    design.items[i].lineWidth = design.mmToPx(design.items[i].lineWidth) * 0.3527;
                }
            }
            design.initPanel(false);
            design.loadItems();
            var cookie = design.socketCookie();
            cookie.rate = rate;
            design.socketCookie(JSON.stringify(cookie));
        },
        //预览
        preview: function () {
            if (!design.items || design.items.length == 0) {
                layer.alert("请先编辑打印模板", {
                    icon: 5
                });
                return false;
            }
            var val = design.panel.rate;
            design.zoom(1);
            var list = JSON.parse(JSON.stringify(design.items));
            for (var i = 0; i < list.length; i++) {
                list[i].group = 1;
            }
            options.preview(list, design.mmToPx(design.panel.width), design.mmToPx(design.panel.height));
            design.zoom(val);
        },
        //保存
        save: function () {
            if (!design.items || design.items.length == 0) {
                layer.alert("请先编辑打印模板", {
                    icon: 5
                });
                return false;
            }
            var groups = [];
            for (var i = 0; i < design.items.length; i++) {
                if (!design.items[i].group)
                    design.items[i].group = 1;
                groups.push(parseInt(design.items[i].group));
            }
            for (var j = 0; j < groups.length - 1; j++) {
                for (var i = 0; i < groups.length - 1 - j; i++) {
                    if (groups[i] > groups[i + 1]) {
                        var temp = groups[i];
                        groups[i] = groups[i + 1];
                        groups[i + 1] = temp;
                    }
                }
            }
            if (groups[0] != 1) {
                layer.open({
                    content: '请按顺序分组'
                });
                return;
            }
            for (var i = 0; i < groups.length - 1; i++) {
                if (groups[i] + 1 < groups[i + 1]) {
                    layer.open({
                        content: '请按顺序分组'
                    });
                    return;
                }
            }
            var val = design.panel.rate;
            design.zoom(1);
            options.save(design.items, design.mmToPx(design.panel.width), design.mmToPx(design.panel.height));
            design.zoom(val);
            options.winclose = true;
        },
        //删除选中的标签
        deleteItems: function () {
            $("#panel .select").remove();
            design.items = [];
            $("#panel .unselect").each(function () {
                design.items.push($(this).data("Entity"));
            });
            design.deleteRuleLine();
            design.saveOperation();
        },
        //删除刻度尺
        deleteRuleLine: function () {
            if (design.top_ruleline != null) {
                design.top_ruleline.remove();
                design.top_ruleline = null;
            }
            if (design.left_ruleline != null) {
                design.left_ruleline.remove();
                design.left_ruleline = null;
            }
        },
        //取消所有选中
        cancelAll: function myfunction() {
            $("#panel .select").removeClass("select").addClass("unselect");
            $("#panel").focus();
        },
        //面板事件
        panelKeyDown: function () {
            $("#panel").unbind("keydown").bind("keydown", function (e) {
                if (e.which == 37) {
                    design.setposition("left", -1);
                } else if (e.which == 38) {
                    design.setposition("top", -1);
                } else if (e.which == 39) {
                    design.setposition("left", 1);
                } else if (e.which == 40) {
                    design.setposition("top", 1);
                } else if (e.which == 46) {
                    design.deleteItems();
                } else if (window.event.ctrlKey) {
                    if (e.which == 65) {
                        design.ctrlA();
                    } else if (e.which == 67) {
                        design.ctrlC();
                    } else if (e.which == 86) {
                        design.ctrlV();
                    } else if (e.which == 89) {
                        design.ctrlY();
                    } else if (e.which == 90) {
                        design.ctrlZ();
                    }
                }
                if (e.which >= 37 && e.which <= 40) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
        },
        //面板事件上下左右设置属性
        setposition: function (name, value) {
            $("#panel .select").each(function () {
                var entity = $(this).data("Entity");
                entity[name] += value;
                design.itemCss($(this), entity);
            });
            design.saveOperation();
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
            design.operation.push(JSON.stringify({ items: design.items, panel: design.panel }));
            design.currIndex = design.operation.length - 1;
            $("#panel").focus();
        },
        //复制
        ctrlC: function () {
            var items = [];
            $("#panel .select").each(function () {
                items.push($(this).data("Entity"));
            });
            design.addJson = items.length > 0 ? JSON.stringify(items) : null;
        },
        //粘贴
        ctrlV: function () {
            if (!design.addJson)
                return;
            var items = JSON.parse(design.addJson);
            if (!items || items.length == 0)
                return;
            if (items.length + design.items.length > 300) {
                design.addJson = null;
                layer.open({ content: '搞这么多你不累吗' });
                return;
            }
            design.cancelAll();
            for (var i = 0; i < items.length; i++) {
                items[i].zIndex = design.items.length + i + 11;
                //items[i].left += 10;
                items[i].top += 10;
                design.addItem(items[i], true, true);
                design.items.push(items[i]);
            }
            design.addJson = JSON.stringify(items);
            design.saveOperation();
            design.createSelectItemAttr();
        },
        //撤销
        ctrlZ: function () {
            if (design.currIndex > 0 && design.currIndex < design.operation.length) {
                design.currIndex--;
                var data = JSON.parse(design.operation[design.currIndex]);
                design.items = data.items;
                design.panel = data.panel;
                design.initPanel(false);
                design.loadItems();
            }
        },
        //反撤销
        ctrlY: function () {
            if (design.currIndex < design.operation.length - 1) {
                design.currIndex++;
                var data = JSON.parse(design.operation[design.currIndex]);
                design.items = data.items;
                design.panel = data.panel;
                design.initPanel(false);
                design.loadItems();
            }
        },
        //全选
        ctrlA: function () {
            $("#panel .unselect").removeClass("unselect").addClass("select");
            design.createSelectItemAttr();
        },
        //创建一个新的标签对象
        newEntity: function (width, height, top, left, type) {
            var entity = {
                width: width,
                height: height,
                top: top,
                left: left,
                type: type,
                rote: 0,
                origin: "center center",
                zIndex: design.items.length + 10,
                text: "0123456789",
                borderColor: "#000",
                borderWidth: 0,
                borderStyle: "solid",
                key: "",
                group: 1
            };
            if (entity.type == "text" || entity.type == "rect" || entity.type == "line") {
                entity.fontFamily = "Arial";
                entity.wordBreak = "break-all";
                entity.lineHeight = 14;
                entity.radius = 0;
                entity.overflow = "hidden";
                entity.underline = false;
                entity.linethrough = false;
                entity.backgroundColor = "";
                entity.fontSize = 14;
                entity.fontSpace = 0;
                entity.color = "#000";
                entity.fontWeight = "normal";
                entity.textAlign = "left";
                entity.paddingLeft = 0;
                entity.paddingRight = 0;
                entity.fontStyle = "normal";
                entity.fontSizeUnit = "pt";
                entity.enaleAutoTextSize = true;
                if (entity.type == "rect") {
                    entity.text = "";
                    entity.borderWidth = 1;
                    entity.type = "text";
                } else if (entity.type == "line") {
                    entity.text = "";
                    entity.unitsOn = design.mmToPx(1) * 0.3527;
                    entity.unitsOff = design.mmToPx(1) * 0.3527;
                    entity.lineWidth = design.mmToPx(1) * 0.3527;
                    entity.strokeStyle = "#000";
                    entity.height = 20;
                }
            } else if (entity.type == "barcode") {
                entity.color = "#000";
                entity.backgroundColor = "#fff";
                entity.version = 27;
                entity.barWidth = 1;
                entity.line_bx = entity.width;
                entity.line_by = entity.height;
                entity.includeBorder = false;
                entity.includeLabel = true;
                entity.fontFamily = "Arial";
                entity.fontSize = 14;
                entity.underline = false;
                entity.linethrough = false;
                entity.fontWeight = "normal";
                entity.fontStyle = "normal";
                entity.fontSizeUnit = "pt";
            } else if (entity.type == "qrcode") {
                entity.version = 2;
                entity.scale = 4;
            } else if (entity.type == "matrix") {
                entity.scale = 10;
            } else if (entity.type == "img") {
                entity.url = "";
                entity.text = "";
                entity.radius = 0;
            }
            //var rate = design.panel.rate;
            //design.panel.rate = 1;
            //for (var j = 0; j < design.zoomAttr.length; j++) {
            //    if (design.isNumber(entity[design.zoomAttr[j]]))
            //        entity[design.zoomAttr[j]] = design.pxToMm(entity[design.zoomAttr[j]]);
            //}
            //design.panel.rate = rate;
            //for (var j = 0; j < design.zoomAttr.length; j++) {
            //    if (design.isNumber(entity[design.zoomAttr[j]]))
            //        entity[design.zoomAttr[j]] = design.mmToPx(entity[design.zoomAttr[j]]);
            //}
            return entity;
        },
        //设置标签样式
        itemCss: function (node, entity) {
            entity.top = parseFloat(entity.top);
            entity.left = parseFloat(entity.left);
            entity.width = parseFloat(entity.width);
            entity.height = parseFloat(entity.height);
            var w = design.mmToPx(design.panel.width);
            var h = design.mmToPx(design.panel.height);
            if (!entity.rote) {
                if (entity.top < 0)
                    entity.top = 0;
                if (entity.left < 0)
                    entity.left = 0;
                if (entity.width < 0)
                    entity.width = 0;
                if (entity.height < 0)
                    entity.height = 0;
                if (entity.width > w)
                    entity.width = w;
                if (entity.height > h)
                    entity.height = h;
                if (entity.top + entity.height > h)
                    entity.top = h - entity.height;
                if (entity.left + entity.width > w)
                    entity.left = w - entity.width;
            }
            var content = node.find(".drag_content");
            if (entity.type == "text") {
                var dec = "";
                if (entity.underline) {
                    dec += "underline";
                }
                if (entity.linethrough) {
                    if (dec != "")
                        dec += " ";
                    dec += "line-through";
                }
                if (dec == "")
                    dec = "none";
                var text = entity.text;
                if (entity.key != "") {
                    for (var i = 0; i < options.datakeys.length; i++) {
                        if (entity.key == options.datakeys[i].value) {
                            text = options.datakeys[i].text;
                            break;
                        }
                    }
                }
                content.css({
                    borderColor: entity.borderColor ? entity.borderColor : "transparent",
                    borderWidth: entity.borderWidth,
                    borderStyle: entity.borderStyle,
                    wordBreak: entity.wordBreak,
                    lineHeight: entity.lineHeight + "px",
                    borderRadius: entity.radius + "px",
                    overflow: entity.overflow,
                    textDecoration: dec,
                    backgroundColor: entity.backgroundColor,
                    fontSize: entity.fontSize,
                    letterSpacing: entity.fontSpace,
                    color: entity.color,
                    fontWeight: entity.fontWeight,
                    textAlign: entity.textAlign,
                    paddingLeft: entity.paddingLeft + "px",
                    paddingRight: entity.paddingRight + "px",
                    fontStyle: entity.fontStyle,
                    fontFamily: entity.fontFamily,
                    whiteSpace: "pre-wrap"
                }).text(text);
            } else {
                content.css({
                    borderColor: entity.borderColor ? entity.borderColor : "transparent",
                    borderWidth: entity.borderWidth,
                    borderRadius: entity.radius + "px",
                    borderStyle: entity.borderStyle
                });
            }
            node.css({
                width: entity.width,
                height: entity.height,
                top: entity.top,
                left: entity.left,
                zIndex: entity.zIndex
            });
            node.find(".drag_item").css("zIndex", entity.zIndex + 1);
            node.find(".drag_area").css("zIndex", entity.zIndex + 2);

            if (entity.type == "line") {
                content.find("canvas").remove();
                var cw = parseFloat((entity.width - entity.borderWidth * 2).toFixed(3));
                var ch = parseFloat((entity.height - entity.borderWidth * 2).toFixed(3));
                entity.line_bx = 0;
                entity.line_by = ch / 2;
                entity.line_ex = cw;
                entity.line_ey = ch / 2;
                if (entity.rote > 0 && entity.rote < 180) {
                    var a = parseFloat((Math.tan(parseFloat(90 - entity.rote) * Math.PI / 180) * (ch / 2)).toFixed(3));
                    var b = parseFloat((Math.tan(parseFloat(entity.rote) * Math.PI / 180) * (cw / 2)).toFixed(3));
                    var c = parseFloat((Math.tan(parseFloat(180 - entity.rote) * Math.PI / 180) * (cw / 2)).toFixed(3));

                    entity.line_bx = cw / 2 - a;
                    entity.line_by = 0;
                    entity.line_ex = cw / 2 + a;
                    entity.line_ey = ch;

                    if (entity.line_bx < 0) {
                        entity.line_bx = 0;
                        entity.line_by = ch / 2 - b;
                    }
                    if (entity.line_bx > cw) {
                        entity.line_bx = cw;
                        entity.line_by = ch / 2 - c;
                    }
                    if (entity.line_ex > cw) {
                        entity.line_ex = cw;
                        entity.line_ey = ch / 2 + b;
                    }
                    if (entity.line_ex < 0) {
                        entity.line_ex = 0;
                        entity.line_ey = ch / 2 + c;
                    }
                }
                var node = $("<canvas width=\"" + Math.round(cw) + "\" height=\"" + Math.round(ch) + "\"/>");
                content.append(node);
                var context = node[0].getContext("2d");
                context.strokeStyle = entity.strokeStyle;
                context.lineWidth = Math.round(entity.lineWidth);
                if (entity.borderStyle == "dashed")
                    context.setLineDash([entity.unitsOn, entity.unitsOff]);
                context.moveTo(Math.round(entity.line_bx), Math.round(entity.line_by) + (context.lineWidth % 2 == 0 ? 0 : 0.5));
                context.lineTo(Math.round(entity.line_ex), Math.round(entity.line_ey) + (context.lineWidth % 2 == 0 ? 0 : 0.5));
                context.stroke();
            } else {
                content.css({
                    transform: "rotate(" + entity.rote + "deg)",
                    transformOrigin: entity.origin
                });
            }
        },
        //设置编辑属性
        setAttr: function (name, value) {
            var items = $("#panel .select");
            if (!items || items.length == 0)
                return;
            $("#panel .select").each(function () {
                var entity = $(this).data("Entity");
                entity[name] = value;
                if (entity.type == "qrcode" || entity.type == "barcode" || entity.type == "matrix") {
                    $(this).find("img").attr("src", design.getCodeUrl(entity));
                }
                design.itemCss($(this), entity);
            });
            design.saveOperation();
        },
        //获取二维码或条码图片
        getCodeUrl: function (entity) {
            var data = null;
            if (entity.type == 'barcode') {
                data = {
                    type: entity.type,
                    text: entity.text,
                    backgroundColor: entity.backgroundColor.replace('#', ''),
                    color: entity.color.replace('#', ''),
                    version: entity.version,
                    barWidth: entity.barWidth,
                    line_bx: entity.line_bx,
                    line_by: entity.line_by,
                    includeLabel: entity.includeLabel,
                    includeBorder: entity.includeBorder,
                    fontFamily: entity.fontFamily,
                    fontSize: entity.fontSize,
                    fontWeight: entity.fontWeight,
                    fontStyle: entity.fontStyle,
                    underline: entity.underline,
                    linethrough: entity.linethrough,
                };
            } else if (entity.type == 'matrix') {
                data = {
                    type: entity.type,
                    text: entity.text,
                    scale: entity.scale
                };
            } else {
                data = {
                    type: entity.type,
                    text: entity.text,
                    version: entity.version,
                    scale: entity.scale,
                    overflow: entity.overflow
                };
            }
            var base64 = options.getCodeUrl(JSON.stringify(data));
            //条码自动处理图片大小
            let newImage = new Image()
            newImage.src = base64
            newImage.onload = () => {
                if (entity.type == 'barcode') {
                    if (entity.barWidth && entity.barWidth > 0) {
                        entity.width = newImage.width * design.panel.rate;
                    }
                    design.autoBarcodeSize(entity);
                }
            }
            return base64;
        },
        //点击标签时

        clickItem: function (node) {
            if ($(node).hasClass("select"))
                return;
            if (!window.event.ctrlKey)
                design.cancelAll();
            $(node).removeClass("unselect").addClass("select");
            design.createSelectItemAttr();
        },
        //加载标签
        loadItems: function () {
            $("#panel .drag").remove();
            $(".attr_type").hide();
            design.cancelAll();
            for (var i = 0; i < design.items.length; i++) {
                design.addItem(design.items[i]);
            }
        },
        //选择图片
        selectImg: function () {
            options.selectImg(function (url) {
                var items = $("#panel .select");
                if (items && items.length == 1) {
                    var entity = items.eq(0).data("Entity");
                    if (entity.type == "img") {
                        entity.url = url;
                        items.eq(0).find("img").attr("src", entity.url);
                    }
                }
            });
        },
        //添加标签
        addItem: function (entity, isclick, select) {
            var html = "";
            if (entity.type == 'text')
                html = "<div class=\"drag_content\">" + entity.text + "</div>";
            else if (entity.type == 'line')
                html = "<div class=\"drag_content\"></div>";
            else if (entity.type == 'qrcode')
                html = "<div class=\"drag_content\"><img alt=\"二维码加载不出来试试调整密度和清晰度\" src=\"" + design.getCodeUrl(entity) + "\"/></div>";
            else if (entity.type == 'matrix')
                html = "<div class=\"drag_content\"><img alt=\"二维条码加载不出来试试调整清晰度\" src=\"" + design.getCodeUrl(entity) + "\"/></div>";
            else if (entity.type == "barcode")
                html = "<div class=\"drag_content\"><img alt=\"条码加载不出来试试调整类型和内容\" src=\"" + design.getCodeUrl(entity) + "\"/></div>";
            else if (entity.type == "img") {
                html = "<div class=\"drag_content\"><img alt=\"双击选择图片\" src=\"" + entity.url + "\"/></div>";
                if (isclick && !entity.url)
                    design.selectImg();
            }
            var $html = $(html);
            
            if (entity.type == "barcode") {
                //切换条码类型时图片异常处理
                var $img = $html.find("img");
                $img.bind("load", function () {
                    if ($(this).hasClass("changeVersion")) {
                        $(this).removeClass('changeVersion');
                    }
                });
                $img.bind("error", function () {
                    if ($(this).hasClass("changeVersion")) {
                        design.configLabelDefaultText();
                        $(this).removeClass('changeVersion');
                    }
                });
                //条码处理
                design.autoBarcodeSize(entity);
            }
            var node = $("<div class='drag " + (select ? "select" : "unselect") + "'></div>")
                     .data("Entity", entity)
                     .append($html)
                     .append("<div class='drag_item drag_top_line'></div><div class='drag_item drag_bottom_line'></div><div class='drag_item drag_left_line'></div><div class='drag_item drag_right_line'></div><div class='drag_item drag_area drag_top_left_area'></div><div class='drag_item drag_area drag_top_center_area'></div><div class='drag_item drag_area drag_top_right_area'></div><div class='drag_item drag_area drag_bottom_left_area'></div><div class='drag_item drag_area drag_bottom_center_area'></div><div class='drag_item drag_area drag_bottom_right_area'></div><div class='drag_item drag_area drag_left_center_area'></div><div class='drag_item drag_area drag_right_center_area'></div>"
                     //+ "<div class='drag_item drag_area drag_center_rote'></div>"
                     )
                     .appendTo($("#panel"))
                     .draggable({
                         start: function (event, ui) {
                             if ($(this).hasClass("unselect"))
                                 $(this).removeClass("unselect").addClass("select");
                             if (design.top_ruleline == null && design.left_ruleline == null) {
                                 design.top_ruleline = $("<div style='border-top:1px dashed #0097ac;box-sizing: border-box;width:" + (design.mmToPx(design.panel.width) + 70) + "px;position:absolute;z-index:1;top:" + ui.offset.top + "px;left:" + $("#d_left").width() + "px;'></div>");
                                 design.left_ruleline = $("<div style='border-left:1px dashed #0097ac;box-sizing: border-box;height:" + (design.mmToPx(design.panel.height) + 70) + "px;position:absolute;z-index:1;top:0px;left:" + ui.offset.left + "px;'></div>");
                                 $("#d_center").append(design.top_ruleline).append(design.left_ruleline);
                             }
                         },
                         drag: design.draggable,
                         stop: function (event, ui) {
                             design.draggable(event, ui, this)
                         }
                     })
                     .mousedown(function () {
                         if ($(this).hasClass("select")) {
                             if (window.event.ctrlKey)
                                 $(this).removeClass("select").addClass("unselect");
                             return;
                         }
                         design.clickItem(this);
                     })
                     .dblclick(function () {
                         var entity = $(this).data("Entity");
                         if (entity.type == "img")
                             design.selectImg();
                     });
            node.find(".drag_item").not(".drag_center_rote").mousedown(function (e) {
                e.stopPropagation();
                design.resizeItem = $(this);
            });
            //node.find(".drag_center_rote").mousedown(design.startRotate).mouseleave(design.stopRotate).mouseup(design.stopRotate);
            design.itemCss(node, entity);
            if (isclick)
                design.clickItem(node);
        },
        //开始旋转
        startRotate: function () {
            if (design.intervalRoteId == null) {
                var parent = $(this).parent();
                var entity = $(this).parent().data("Entity");
                design.intervalRoteId = setInterval(function () {
                    entity.rote++;
                    //线条180度
                    if (entity.type == 'line' && entity.rote >= 180)
                        entity.rote = 0;
                    //其余360度
                    if (entity.rote >= 360)
                        entity.rote = 0;
                    design.itemCss(parent, entity);
                }, 30);
            }
        },
        //停止旋转
        stopRotate: function () {
            if (design.intervalRoteId != null) {
                clearInterval(design.intervalRoteId);
                design.intervalRoteId = null;
                design.createSelectItemAttr();
            }
        },
        //标签拖动后业务
        draggable: function (event, ui, node) {
            if (design.top_ruleline != null)
                design.top_ruleline.css("top", ui.offset.top + "px");
            if (design.left_ruleline != null)
                design.left_ruleline.css("left", ui.offset.left + "px");
            var entity = $(node ? node : this).data("Entity");
            var top = ui.position.top - entity.top;
            var left = ui.position.left - entity.left;
            var count = 0;
            $("#panel .select").each(function () {
                count++;
                entity = $(this).data("Entity");
                entity.top += top;
                entity.left += left;
                design.itemCss($(this), entity);
            });
            if (node) {
                design.deleteRuleLine();
                design.saveOperation();
                if (count == 1)
                    design.createAttr("attr_common", entity);
            }
        },
        //是否正整数
        isInt: function (val) {
            return /^\d+(.\d+|\d*)$/.test(val);
        },
        //是否数字
        isNumber: function (val) {
            return /^[+-]?\d+(.\d+|\d*)$/.test(val);
        },
        //创建编辑属性
        createAttr: function (pId, entity) {
            $(".ddlsearch").remove();
            var node = $("#" + pId).empty();
            var data = [];
            for (var i = 0; i < design.attrs.length; i++) {
                if (design.attrs[i].group == pId)
                    data.push(design.attrs[i]);
            }
            var tab = $("<table class=\"attrtab\"></table>").appendTo(node);
            var tr = null;
            var newrow = true;
            for (var i = 0; i < data.length; i++) {
                if (newrow)
                    tr = $("<tr></tr>").appendTo(tab);
                tr.append("<td class='tdtitle' key='" + (data[i].key || "") + "'>" + (data[i].control == "control-checkbox" ? "" : data[i].title) + "</td>");
                var td = null;
                if (data[i].colspan) {
                    td = $("<td class='tdvalue' colspan='" + data[i].colspan + "'></td>");
                    newrow = false;
                }
                else {
                    td = $("<td class='tdvalue'></td>");
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
                }
                if (!obj)
                    continue;
                if (data[i].change)
                    obj.change(data[i].change);
                if (data[i].click)
                    obj.click(data[i].click);
                if (data[i].dblclick)
                    obj.dblclick(data[i].dblclick);
                if (data[i].keyup)
                    obj.keyup(data[i].keyup);
                if (data[i].blur)
                    obj.blur(data[i].blur);
                newrow = !newrow;
            }
            //
            design.configLabelFontSize(entity);
            //处理文本的拖放自动适应字
            design.autoFontSize();
        },
        //创建选择的标签属性，包括公共和私有属性
        createSelectItemAttr: function (event, ui) {
            var en = null;
            var isgroup = true;
            $(".attr_type").hide();
            $("#panel .select").each(function () {
                var entity = $(this).data("Entity");
                if (en == null)
                    en = entity;
                if (entity.type != en.type)
                    isgroup = false;
            });
            if (isgroup && en) {
                $("#attr_" + en.type).parent().show();
                design.createAttr("attr_common", en);
                design.createAttr("attr_" + en.type, en);
            }
        },
        //取色器属性
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
        //自动填充序号
        autofillserialnumber: function (type) {
            var items = $("#panel .select");
            if (!items || items.length < 2) {
                layer.alert("至少要选两个标签", { icon: 5 });
                return false;
            }
            var title = type == 0 ? "自动填充分组" : "自动填充Key";
            layer.open({
                type: 1,
                area: ["400px", "370px"],
                title: title,
                content: "<br/><div class='layui-form-item'>"
                            + (type == 0 ? "" : ("<div class='layui-inline'>"
                                 + "<label class='layui-form-label'>编号</label>"
                                 + "<div class='layui-input-inline'><input type='text' id='txtautofillcode' maxlength='20' value='GRN%number%' class='layui-input'></div>"
                            + "</div>"))
                            + "<div class='layui-inline'>"
                                 + "<label class='layui-form-label'>开始值</label>"
                                 + "<div class='layui-input-inline'><input type='text' id='txtautobeginval' maxlength='3' value='1' class='layui-input'></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                + "<label class='layui-form-label'>权重</label>"
                                + "<div class='layui-input-inline'><select class='layui-input' id='ddlautofilldirection'><option value='0'>水平(从横到竖,需上对齐)</option><option value='1'>垂直(从竖到横,需左对齐)</option></select></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                + "<label class='layui-form-label'>水平</label>"
                                + "<div class='layui-input-inline'><select class='layui-input' id='ddlautofilllevel'><option value='0'>从左往右</option><option value='1'>从右往左</option></select></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                + "<label class='layui-form-label'>垂直</label>"
                                + "<div class='layui-input-inline'><select class='layui-input' id='ddlautofillvertical'><option value='0'>从上往下</option><option value='1'>从下往上</option></select></div>"
                            + "</div>"
                        + "</div>",
                btn: ['确定', '取消'],
                btn1: function (index, layero) {
                    var code;
                    if (type == 1) {
                        code = $("#txtautofillcode").val();
                        if (code.indexOf("%number%") == -1) {
                            layer.msg("缺少%number%");
                            return;
                        }
                    }
                    var begin = $("#txtautobeginval").val();
                    if (!design.isInt(begin))
                        begin = 1;
                    else
                        begin = parseInt(begin);
                    var level = $("#ddlautofilllevel").val();
                    var vertical = $("#ddlautofillvertical").val();
                    var array = [];
                    items.each(function (i) {
                        array.push($(this).data("Entity"));
                    });
                    if ($("#ddlautofilldirection").val() == "0") {
                        array = design.itemssort(array, "left", level == "0");
                        array = design.itemssort(array, "top", vertical == "0");
                    } else {
                        array = design.itemssort(array, "top", vertical == "0");
                        array = design.itemssort(array, "left", level == "0");
                    }
                    for (var i = 0; i < array.length; i++) {
                        items.each(function () {
                            var entity = $(this).data("Entity");
                            if (JSON.stringify(entity) == JSON.stringify(array[i])) {
                                if (type == "0") {
                                    array[i].group = entity.group = begin;
                                } else {
                                    var key = code.replace("%number%", begin);
                                    for (var k = 0; k < options.datakeys.length; k++) {
                                        if (options.datakeys[k].text == key) {
                                            array[i].key = entity.key = options.datakeys[k].value;
                                            break;
                                        }
                                    }
                                }
                                begin++;
                                design.itemCss($(this), entity);
                                return false;
                            }
                        });
                    }
                    layer.close(index);
                }
            });
        },
        //对齐
        align: function (type) {
            var items = $("#panel .select");
            if (!items || items.length < 2) {
                layer.alert("至少要选两个标签", {
                    icon: 5
                });
                return false;
            }
            var value = 0;
            items.each(function (i) {
                var entity = $(this).data("Entity");
                if (i == 0) {
                    if (type == 0) {
                        value = entity.top;
                    } else if (type == 1) {
                        value = entity.left;
                    } else if (type == 2) {
                        value = entity.top + entity.height;
                    } else {
                        value = entity.left + entity.width;
                    }
                } else {
                    if (type == 0 && entity.top < value) {
                        value = entity.top;
                    } else if (type == 1 && entity.left < value) {
                        value = entity.left;
                    } else if (type == 2 && entity.top + entity.height > value) {
                        value = entity.top + entity.height;
                    } else if (type == 3 && entity.left + entity.width > value) {
                        value = entity.left + entity.width;
                    }
                }
            });
            items.each(function (i) {
                var entity = $(this).data("Entity");
                if (type == 0) {
                    entity.top = value;
                } else if (type == 1) {
                    entity.left = value;
                } else if (type == 2 && entity.top + entity.height < value) {
                    entity.top = value - entity.height;
                } else if (type == 3 && entity.left + entity.width < value) {
                    entity.left = value - entity.width;
                }
                design.itemCss($(this), entity)
            });
            design.saveOperation();
        },
        //冒泡排序
        itemssort: function (array, name, asc) {
            var len = array.length;
            for (var i = 0; i < len - 1; i++) {
                for (var j = 0; j < len - 1 - i; j++) {
                    if ((asc && array[j][name] > array[j + 1][name]) || (!asc && array[j][name] < array[j + 1][name])) {
                        var temp = array[j];
                        array[j] = array[j + 1];
                        array[j + 1] = temp;
                    }
                }
            }
            return array;
        },
        //靠齐
        autoarrange: function (type) {
            var items = $("#panel .select");
            if (!items || items.length < 2) {
                layer.alert("至少要选两个标签", { icon: 5 });
                return false;
            }
            var val = $("#txtautoarrange").val(); val = design.isNumber(val) ? design.mmToPx(val) : 0;
            var array = [];
            items.each(function (i) {
                array.push($(this).data("Entity"));
            });
            array = design.itemssort(array, type ? "top" : "left", true);
            for (var i = 1; i < array.length; i++) {
                items.each(function () {
                    var entity = $(this).data("Entity");
                    if (JSON.stringify(entity) == JSON.stringify(array[i])) {
                        if (type) {
                            array[i].top = entity.top = array[i - 1].top + array[i - 1].height + val;
                        } else {
                            array[i].left = entity.left = array[i - 1].left + array[i - 1].width + val;
                        }
                        design.itemCss($(this), entity);
                        return false;
                    }
                });
            }
            design.saveOperation();
        },
        //分散
        disperse: function (type) {
            var items = $("#panel .select");
            if (!items || items.length < 3) {
                layer.alert("至少要选三个标签", {
                    icon: 5
                });
                return false;
            }
            var min = 9999999, max = 0, maxIndex = 0, minIndex = 0;
            items.each(function (i) {
                var entity = $(this).data("Entity");
                var center = (type ? entity.top : entity.left) + (parseFloat(type ? entity.height : entity.width) / 2);
                if (center < min) {
                    min = center;
                    minIndex = i;
                }
                if (center > max) {
                    max = center;
                    maxIndex = i;
                }
            });
            var margin = parseFloat(max - min) / (items.length - 1);
            items.each(function (i) {
                if (i != maxIndex && i != minIndex) {
                    var entity = $(this).data("Entity");
                    min += margin;
                    if (type)
                        entity.top = min - (parseFloat(entity.height) / 2);
                    else
                        entity.left = min - (parseFloat(entity.width) / 2);
                    design.itemCss($(this), entity)
                }
            });
            design.saveOperation();
        },
        //对齐
        alignCenter: function (type) {
            var items = $("#panel .select");
            if (!items || items.length < 2) {
                layer.alert("至少要选两个标签", {
                    icon: 5
                });
                return false;
            }
            var min = 9999999, minIndex = 0;
            items.each(function (i) {
                var entity = $(this).data("Entity");
                var center = (type ? entity.top : entity.left) + (parseFloat(type ? entity.height : entity.width) / 2);
                if (center < min) {
                    min = center;
                    minIndex = i;
                }
            });
            items.each(function (i) {
                if (i != minIndex) {
                    var entity = $(this).data("Entity");
                    if (type)
                        entity.top = min - (parseFloat(entity.height) / 2);
                    else
                        entity.left = min - (parseFloat(entity.width) / 2);
                    design.itemCss($(this), entity)
                }
            });
            design.saveOperation();
        },
        //移动位置
        movePosition: function (type) {
            if ($("#rdokq").get(0).checked) {
                design.autoarrange(type);
            } else if ($("#rdofs").get(0).checked) {
                design.disperse(type);
            } else if ($("#rdodq").get(0).checked) {
                design.alignCenter(type);
            }
        },
        //窗体大小改变
        resize: function (empty) {
            $(".module").height(0).height($("body").height());
            $("#d_left").width(design.d_left);
            $("#d_right").width(design.d_right);
            $("#d_center").width($("body").width() - design.d_left - design.d_right);
            design.initPanel(empty);
        },
        //获取选中项的数据
        getSelectData: function () {
            var items = $("#panel .select");
            var entity = null;
            if (!items || items.length == 0)
                return entity;
            $("#panel .select").each(function () {
                entity = $(this).data("Entity");
                return false;
            });
            return entity;
        },
        //配置条码标签字体大小（UPCA,UPCE,EAN13,EAN13-A,这4种会自适应字体大小，不需要设置）
        configLabelFontSize: function (entity) {
            if (!entity) {
                entity = design.getSelectData();
            }
            if (entity && entity.type == "barcode") {
                isShow = !(entity.version == "1" || entity.version == "2" || entity.version == "5" || entity.version == "35");
                $("#attr_barcode").find(".tdtitle").each(function () {
                    if ($(this).attr("key") == "fontSize" || $(this).attr("key") == "fontSizeUnit") {
                        var $tdTitle = $(this);
                        var $tdCotent = $(this).next();
                        if (isShow) {
                            $tdTitle.show()
                            $tdCotent.show();
                        }
                        else {
                            $tdTitle.hide()
                            $tdCotent.hide();
                        }
                    }
                });
            }
        },
        //配置条码标签的默认内容（切换条码类型图片加载不成功时）
        configLabelDefaultText: function () {
            var entity = design.getSelectData();
            if (!entity) {
                return;
            }
            if (entity && entity.type == "barcode" && entity.version) {
                var sampleTxt = "0123456789";
                switch (entity.version)
                {
                    case "1":   //UPCA
                        sampleTxt = "01234567890";
                        break;
                    case "2":   //UPCE
                        sampleTxt = "01234565";
                        break;
                    case "3":   //UPC_SUPPLEMENTAL_2DIGIT
                        sampleTxt = "12";
                        break;
                    case "4":   //UPC_SUPPLEMENTAL_5DIGIT
                        sampleTxt = "12345";
                        break;
                    case "5":   //EAN13
                        sampleTxt = "012345678912";
                        break;
                    case "35":   //EAN13-A
                        sampleTxt = "0123456789123";
                        break;
                    case "6":   //EAN8
                        sampleTxt = "01234567";
                        break;
                    case "12":   //Codabar
                        sampleTxt = "a12345678a";
                        break;
                    case "13":   //PostNet
                        sampleTxt = "12345";
                        break;
                    case "16":   //JAN13
                        sampleTxt = "490123456789";
                        break;
                    case "24":   //UCC12
                        sampleTxt = "012345678912";
                        break;
                    case "25":   //UCC13
                        sampleTxt = "012345678912";
                        break;
                    case "31":   //ITF14
                        sampleTxt = "0123456789123";
                        break;
                    case "34":   //FIM
                        sampleTxt = "A";
                        break;
                    default:
                        break;
                }
                if (sampleTxt != entity.text) {
                    $("#attr_barcode").find(".tdtitle").each(function () {
                        if ($(this).text().indexOf("默认内容") == 0) {
                            var $tdCotent = $(this).next();
                            $tdCotent.find("input").val(sampleTxt);
                            design.setAttr("text", sampleTxt);
                            return false;
                        }
                    });
                }
            }
        },
        //配置字体默认行高（改变字体大小和字体单位时）
        configFontDefaultLineHeight: function () {
            var entity = design.getSelectData();
            if (!entity) {
                return;
            }
            entity.lineHeight = (entity.fontSize < 12 ? 12 : entity.fontSize);
            $("#attr_text").find(".tdtitle").each(function () {
                if ($(this).text().indexOf("行高") == 0) {
                    var $tdCotent = $(this).next();
                    $tdCotent.find("input").val(design.pxToMm(entity.lineHeight));
                    return false;
                }
            });
        },
        //文本自适应（计算字体大小）
        autoFontSize: function ($content) {
            $content = $content || $("#panel .select .drag_content");
            if ($content.length == 0) return

            var entity = $content.parent().data("Entity");
            if (entity && entity.type == "text" && entity.enaleAutoTextSize) {
                var fontSize = parseFloat(entity.fontSize);
                if ($content.text()) {
                    if (!design.isTextOverFlow($content)) {
                        //自动放大字体
                        while (true) {
                            fontSize += 0.1;
                            $content.css("font-size", fontSize + "px");
                            $content.css("line-height", fontSize + "px");
                            if (design.isTextOverFlow($content) || fontSize >= 1000) {
                                fontSize -= 0.1;
                                break;
                            }

                        }
                    }
                    else {
                        //自动缩小字体
                        while (true) {
                            fontSize -= 0.1;
                            $content.css("font-size", fontSize + "px");
                            $content.css("line-height", fontSize + "px");
                            if (!design.isTextOverFlow($content) || fontSize <= 2) {
                                break;
                            }
                        }
                    }
                }
                entity.fontSize = fontSize;
                entity.lineHeight = fontSize;
                $content.css("font-size", fontSize + "px");
                $content.css("line-height", fontSize + "px");
                design.configAutoTextSize();
            }
        },
        //是否文本溢出
        isTextOverFlow: function ($content) {
            return $content[0].scrollHeight > $content[0].clientHeight
                || $content[0].scrollWidth > $content[0].clientWidth;
        },
        //配置文本自适应模式
        configAutoTextSize: function () {
            var entity = design.getSelectData();
            if (!entity) {
                return;
            }
            if (entity && entity.type == "text") {
                $("#attr_text").find(".tdtitle").each(function () {
                    if ($(this).text() == "字体大小") {
                        var $tdCotent = $(this).next();
                        $tdCotent.find("input").prop("disabled", entity.enaleAutoTextSize);
                        if (entity.enaleAutoTextSize) {
                            if (entity.fontSizeUnit == "pt") {
                                $tdCotent.find("input").val(design.pxToPt(entity.fontSize));
                            }
                            else if (entity.fontSizeUnit == "mm") {
                                $tdCotent.find("input").val(design.pxToMm(entity.fontSize));
                            } 
                        }
                    }
                    else if ($(this).text() == "字体大小单位") {
                        var $tdCotent = $(this).next();
                        $tdCotent.find("select").prop("disabled", entity.enaleAutoTextSize);
                    }
                    else if ($(this).text().indexOf("行高") == 0) {
                        var $tdCotent = $(this).next();
                        $tdCotent.find("input").prop("disabled", entity.enaleAutoTextSize);
                        if (entity.enaleAutoTextSize) {
                            $tdCotent.find("input").val(design.pxToMm(entity.lineHeight));
                        }
                    }
                });
            }
        },
        //自动条码大小
        autoBarcodeSize: function (entity) {
            entity = entity ||design.getSelectData();
            if (!entity) {
                return;
            }
            if (entity && entity.type == "barcode") {
                //处理条码的宽度和高度
                entity.line_bx = entity.width / design.panel.rate;
                entity.line_by = entity.height / design.panel.rate;
                //处理条码属性
                $("#attr_barcode").find(".tdtitle").each(function () {
                    if ($(this).text() == "宽度(px)") {
                        var $tdCotent = $(this).next();
                        $tdCotent.find("input").val(entity.line_bx).prop("readOnly",true);
                    }
                    else if ($(this).text() == "高度(px)") {
                        var $tdCotent = $(this).next();
                        $tdCotent.find("input").val(entity.line_by).prop("readOnly", true);;
                    }
                });
                //处理公共属性
                $("#attr_common").find(".tdtitle").each(function () {
                    if ($(this).text() == "宽度(mm)") {
                        var $tdCotent = $(this).next();
                        $tdCotent.find("input").val(design.pxToMm(entity.width))
                    }
                    else if ($(this).text() == "高度(mm)") {
                        var $tdCotent = $(this).next();
                        $tdCotent.find("input").val(design.pxToMm(entity.height))
                    }
                });
                //启用线宽
                if (entity.barWidth && entity.barWidth > 0) {
                    var selectItem = $("#panel .select:first");
                    if (selectItem.length > 0) {
                        design.itemCss(selectItem, entity);
                    }
                }
            }
        },
        //左边和右边div宽度固定，剩下就是中间的面板区了
        d_left: 60,
        d_right: 380
    };
    //初始化
    design.init();
    options.winclose = true;
})(jQuery, window, layer, undefined, designOptions);