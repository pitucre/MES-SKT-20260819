_PageDesignOptions.controls.push({
    type: "datatable",
    title: "数据表格",
    url: "PageDesign/img/datatable.png",
    attributes: function (design) {
        return [
            {
                title: "", control: "<a href='#' style='color:#0097ac;'>编辑初始化方法</a>", click: function () {
                    design.openEventCode(design.getSelectItem());
                }
            },
            { title: "", control: "" },
            { title: "<div class='g_title'>垂直滚动设置</div>", colspan: 3, control: "<div class='g_line'></div>" },
        {
            label: "开启", control: "control-checkbox", click: function () {
                design.editContentAttr("marquee", $(this).get(0).checked);
            }, setdata: function (en) {
                return en.contentAttr.marquee;
            }
        }, {
            label: "隐藏滚动条", control: "control-checkbox", click: function () {
                design.editContentAttr("hidescrolly", $(this).get(0).checked);
            }, setdata: function (en) {
                return en.contentAttr.hidescrolly;
            }
        }, {
            title: "滚动方式", control: "control-select", change: function () {
                design.editContentAttr("behavior", $(this).val());
            }, data: [
                { value: "0", text: "循环滚动" },
                { value: "1", text: "滚动一次" },
                { value: "2", text: "来回滚动" },
                { value: "3", text: "重复滚动" },
            ], setdata: function (en) {
                return en.contentAttr.behavior;
            }
        }, {
            title: "滚动速度", remark: "请输入10到100之间的数字,单位毫秒", control: "control-text", change: function () {
                if (design.isInt($(this).val()) && parseInt($(this).val()) >= 10 && parseInt($(this).val()) <= 100)
                    design.editContentAttr("scrollamount", parseInt($(this).val()));
            }, setdata: function (en) {
                return en.contentAttr.scrollamount;
            }
        }, { title: "<div class='g_title'>表头设置</div>", colspan: 3, control: "<div class='g_line'></div>" },
         {
             title: "背景颜色", control: "control-tackcolor", changecolor: function (color) {
                 if (color && color.ok)
                     design.editContentAttr("headbgcolor", color.toString(color.format));
                 else
                     design.editContentAttr("headbgcolor", "#fff");
             }, setdata: function (en) {
                 return en.contentAttr.headbgcolor;
             }
         }, {
             title: "字体颜色", control: "control-tackcolor", changecolor: function (color) {
                 if (color && color.ok)
                     design.editContentAttr("headftcolor", color.toString(color.format));
                 else
                     design.editContentAttr("headftcolor", "#666");
             }, setdata: function (en) {
                 return en.contentAttr.headftcolor;
             }
         }, {
             title: "字体大小", control: "control-text", change: function (color) {
                 design.editContentAttr("headftSize", design.isInt($(this).val()) ? parseInt($(this).val()) : 14);
             }, setdata: function (en) {
                 return en.contentAttr.headftSize;
             }
         }, {
             label: "粗体", control: "control-checkbox", click: function () {
                 design.editContentAttr("headftWeight", $(this).get(0).checked ? "bold" : "normal");
             }, setdata: function (en) {
                 return en.contentAttr.headftWeight == "bold";
             }
         }, { title: "<div class='g_title'>表体设置</div>", colspan: 3, control: "<div class='g_line'></div>" },
         {
             title: "背景颜色", control: "control-tackcolor", changecolor: function (color) {
                 if (color && color.ok)
                     design.editContentAttr("bodybgcolor", color.toString(color.format));
                 else
                     design.editContentAttr("bodybgcolor", "#fff");
             }, setdata: function (en) {
                 return en.contentAttr.bodybgcolor;
             }
         }, {
             title: "字体颜色", control: "control-tackcolor", changecolor: function (color) {
                 if (color && color.ok)
                     design.editContentAttr("bodyftcolor", color.toString(color.format));
                 else
                     design.editContentAttr("bodyftcolor", "#666");
             }, setdata: function (en) {
                 return en.contentAttr.bodyftcolor;
             }
         }, {
             title: "字体大小", control: "control-text", change: function (color) {
                 design.editContentAttr("bodyftSize", design.isInt($(this).val()) ? parseInt($(this).val()) : 14);
             }, setdata: function (en) {
                 return en.contentAttr.bodyftSize;
             }
         }, {
             label: "粗体", control: "control-checkbox", click: function () {
                 design.editContentAttr("bodyftWeight", $(this).get(0).checked ? "bold" : "normal");
             }, setdata: function (en) {
                 return en.contentAttr.bodyftWeight == "bold";
             }
         }];
    },
    newEntity: function (en) {
        en.events = [{
            name: "init",
            code: "layui.table.render({\n\telem: \"#\" + entity.contentAttr.id,\n\turl: \"pagedesign.aspx?action=getuserlist\",\n\tpage: true,\n\theight: entity.area.heightContent,\n\tcols: [[\n\t\t{ field: 'id', title: 'ID', width: '20%' },\n\t\t{ field: 'username', title: '用户名', width: '20%' },\n\t\t{ field: 'sex', title: '性别', width: '20%' },\n\t\t{ field: 'city', title: '城市', width: '20%' },\n\t\t{ field: 'experience', title: '积分', width: '20%' }\n\t]]\n});"
        }];
        //表头属性
        en.contentAttr.headbgcolor = "#fff";
        en.contentAttr.headftcolor = "#666";
        en.contentAttr.headftSize = 14;
        en.contentAttr.headftWeight = "normal";
        //表体属性
        en.contentAttr.bodybgcolor = "#fff";
        en.contentAttr.bodyftcolor = "#666";
        en.contentAttr.bodyftSize = 14;
        en.contentAttr.bodyftWeight = "normal";
        //跑马灯
        en.contentAttr.marquee = false;
        en.contentAttr.behavior = "1";
        en.contentAttr.hidescrolly = false;
        en.contentAttr.scrollamount = 60;
    },
    beforeDelete: function (en, design) {
        //删除前停止任务
        if (en.contentAttr.scrollTimer) {
            clearInterval(en.contentAttr.scrollTimer);
            en.contentAttr.scrollTimer = null;
        }
    },
    //绑定事件
    events: [
       {
           name: "init", text: "控件初始化", params: [
               { name: "entity", remark: "设计控件时的对象" },
               { name: "design", remark: "页面设计对象" },
               { name: "entity.type", remark: "控件类型" },
               { name: "entity.contentAttr", remark: "控件的属性" },
               { name: "entity.contentAttr.id", remark: "控件的id属性" },
               { name: "entity.area", remark: "控件的区域" },
               { name: "entity.area.heightContent", remark: "控件的区域高度" }
           ]
       },
       {
           name: "rowclick", text: "行点击事件", params: [
               { name: "object", remark: "行点击对象" },
               { name: "object.tr", remark: "得到当前行元素对象" },
               { name: "object.data", remark: "得到当前行数据" }
           ], bind: function (func, en, node) {
               layui.table.on('row(' + en.contentAttr.id + ')', func);
           }
       },
       {
           name: "rowdblclick", text: "行双击事件", params: [
               { name: "object", remark: "行双击对象" },
               { name: "object.tr", remark: "得到当前行元素对象" },
               { name: "object.data", remark: "得到当前行数据" }
           ], bind: function (func, en, node) {
               layui.table.on('rowDouble(' + en.contentAttr.id + ')', func);
           }
       },
       {
           name: "checkboxclick", text: "复选框选择事件", params: [
               { name: "object", remark: "行选择对象" },
               { name: "object.checked", remark: "当前是否选中状态" },
               { name: "object.data", remark: "得到当前行数据" },
               { name: "object.type", remark: "如果触发的是全选为all，如果触发的是单选为one" }
           ], bind: function (func, en, node) {
               layui.table.on('checkbox(' + en.contentAttr.id + ')', func);
           }
       },
    ],
    //添加控件
    appendContent: function (en, node, design) {
        if (en.contentAttr.scrollTimer) {
            clearInterval(en.contentAttr.scrollTimer);
            en.contentAttr.scrollTimer = null;
        }
        var obj = $("<table id='" + en.contentAttr.id + "'  lay-filter='" + en.contentAttr.id + "'></table>").appendTo(node);
        //绑定初始化事件，如果是预览模式才绑定
        if (_PageDesignOptions.ispreview && _PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
            _PageDesignOptions.events[en.contentAttr.id].init(en, design);
        else
            layui.table.render({
                elem: '#' + en.contentAttr.id,
                url: "pagedesign.aspx?action=getuserlist",
                page: true,
                height: en.area.heightContent,
                cols: [[
                  { field: 'id', title: 'ID', width: '20%' },
                  { field: 'username', title: '用户名', width: '20%' },
                  { field: 'sex', title: '性别', width: '20%' },
                  { field: 'city', title: '城市', width: '20%' },
                  { field: 'experience', title: '积分', width: '20%' }
                ]]
            });

        var tab = node.find("div[lay-id='" + en.contentAttr.id + "']>div:eq(0)");
        //表头
        var head = tab.find(".layui-table-header");
        head.find("tr").css({
            backgroundColor: en.contentAttr.headbgcolor,
            color: en.contentAttr.headftcolor
        });
        head.find("th").css({
            fontSize: en.contentAttr.headftSize,
            fontWeight: en.contentAttr.headftWeight
        });
        //表体
        var body = tab.find(".layui-table-body");
        var tbody = body.find("tbody");
        tbody.css({
            backgroundColor: en.contentAttr.bodybgcolor,
            color: en.contentAttr.bodyftcolor,
            fontWeight: en.contentAttr.bodyftWeight
        });
        setTimeout(function () {
            tbody.find("td").css({
                fontSize: en.contentAttr.bodyftSize
            });
        }, 500);
        //隐藏表体滚动条
        if (en.contentAttr.hidescrolly)
            body.css({ overflow: "hidden" });

        //表格滚动设置
        if (!en.contentAttr.marquee)
            return;

        en.contentAttr.scrollTop = 0;
        en.contentAttr.scrollTimer = setInterval(function () {
            if (en.contentAttr.scrollTop <= 0)
                en.contentAttr.scrollWay = 1;

            if (en.contentAttr.scrollTop > body[0].scrollTop) {
                if (en.contentAttr.behavior == "0") {
                    tbody.append(tbody.html());
                }
                else if (en.contentAttr.behavior == "1") {
                    clearInterval(en.contentAttr.scrollTimer);
                    en.contentAttr.scrollTimer = null;
                }
                else if (en.contentAttr.behavior == "2") {
                    en.contentAttr.scrollWay = -1;
                    en.contentAttr.scrollTop += en.contentAttr.scrollWay;
                } else if (en.contentAttr.behavior == "3") {
                    en.contentAttr.scrollTop = 0;
                }
            } else {
                en.contentAttr.scrollTop += en.contentAttr.scrollWay;
            }
            body.scrollTop(en.contentAttr.scrollTop);
        }, en.contentAttr.scrollamount);
    }
});