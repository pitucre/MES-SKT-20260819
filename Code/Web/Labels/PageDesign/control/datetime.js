_PageDesignOptions.controls.push({
    type: "datetime",
    title: "日期时间控件",
    url: "PageDesign/img/datetime.png",
    attributes: function (design) {
        return [{
            title: "控件类型", control: "control-select", change: function () {
                design.editContentAttr("type", $(this).val());
            }, data: [
                { value: "year", text: "年选择器" },
                { value: "month", text: "年月选择器" },
                { value: "date", text: "日期选择器" },
                { value: "time", text: "时间选择器" },
                { value: "datetime", text: "日期时间选择器" }
            ], setdata: function (en) {
                return en.contentAttr.type;
            }
        }, {
            label: "开启范围选择", control: "control-checkbox", click: function () {
                design.editContentAttr("range", $(this).get(0).checked);
            }, setdata: function (en) {
                return en.contentAttr.range;
            }
        }, {
            title: "格式化", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                design.editContentAttr("format", $(this).val());
            }, setdata: function (en) {
                return en.contentAttr.format;
            }
        }, {
            title: "预期显示内容", colspan: 3, style: " style='width:268px;'", control: "control-text", change: function () {
                design.editContentAttr("placeholder", $(this).val());
            }, setdata: function (en) {
                return en.contentAttr.placeholder;
            }
        }];
    },
    events: [
      {
          name: "init", text: "控件初始化", params: [
              { name: "entity", remark: "设计控件时的对象" },
              { name: "options", remark: "日期时间控件的属性" },
              { name: "design", remark: "页面设计对象" },
              { name: "entity.type", remark: "控件类型" },
              { name: "entity.contentAttr", remark: "控件的属性" },
              { name: "entity.contentAttr.id", remark: "控件的id属性" },
              { name: "options.format", remark: "格式化" },
              { name: "options.range", remark: "是否区域选择" },
              { name: "options.type", remark: "控件类型" }
          ]
      },
      {
          name: "ready", text: "初始打开事件", params: [
                { name: "data", remark: "日期时间对象" },
                { name: "data.year", remark: "年" },
                { name: "data.month", remark: "月" },
                { name: "data.date", remark: "日" },
                { name: "data.hours", remark: "时" },
                { name: "data.minutes", remark: "分" },
                { name: "data.seconds", remark: "秒" },

          ]
      },
      {
          name: "change", text: "日期时间切换事件", params: [
                  { name: "value", remark: "日期生成的值" },
                  { name: "data", remark: "日期时间对象" },
                  { name: "endData", remark: "结束的日期时间对象,开启范围选择才会返回" },
                  { name: "data.year", remark: "年" },
                  { name: "data.month", remark: "月" },
                  { name: "data.date", remark: "日" },
                  { name: "data.hours", remark: "时" },
                  { name: "data.minutes", remark: "分" },
                  { name: "data.seconds", remark: "秒" },
                  { name: "endData.year", remark: "年" },
                  { name: "endData.month", remark: "月" },
                  { name: "endData.date", remark: "日" },
                  { name: "endData.hours", remark: "时" },
                  { name: "endData.minutes", remark: "分" },
                  { name: "endData.seconds", remark: "秒" }

          ]
      },
      {
          name: "done", text: "选择完毕后事件", params: [
                    { name: "value", remark: "日期生成的值" },
                    { name: "data", remark: "日期时间对象" },
                    { name: "endData", remark: "结束的日期时间对象,开启范围选择才会返回" },
                    { name: "data.year", remark: "年" },
                    { name: "data.month", remark: "月" },
                    { name: "data.date", remark: "日" },
                    { name: "data.hours", remark: "时" },
                    { name: "data.minutes", remark: "分" },
                    { name: "data.seconds", remark: "秒" },
                    { name: "endData.year", remark: "年" },
                    { name: "endData.month", remark: "月" },
                    { name: "endData.date", remark: "日" },
                    { name: "endData.hours", remark: "时" },
                    { name: "endData.minutes", remark: "分" },
                    { name: "endData.seconds", remark: "秒" }

          ]
      }
    ],
    newEntity: function (en) {
        en.contentAttr.type = "datetime";
        en.contentAttr.format = "yyyy-MM-dd HH:mm:ss";
        en.contentAttr.range = false;
        en.contentAttr.placeholder = "请选择时间";
    },
    appendContent: function (en, node, design) {
        var obj = $("<input placeholder='" + en.contentAttr.placeholder + "' id='" + en.contentAttr.id + "' class='layui-input' type='text'/>").appendTo(node);
        var option = {
            elem: "#" + en.contentAttr.id,
            type: en.contentAttr.type,
            format: en.contentAttr.format,
            range: en.contentAttr.range
        };
        //绑定事件，第二种方式，不需要 在events中bind
        //如果是预览模式才绑定
        if (_PageDesignOptions.ispreview) {
            //循环当前对象的所有配置的事件
            for (var i = 0; i < en.events.length; i++) {
                //如果事件编辑过 且 存在这个事件的方法
                if (en.events[i].name != "init" && en.events[i].code && _PageDesignOptions.events[en.contentAttr.id][en.events[i].name]) {
                    //绑定
                    option[en.events[i].name] = _PageDesignOptions.events[en.contentAttr.id][en.events[i].name];
                }
            }
            if (_PageDesignOptions.events[en.contentAttr.id] && _PageDesignOptions.events[en.contentAttr.id].init)
                _PageDesignOptions.events[en.contentAttr.id].init(en, option, design);
        }
        layui.laydate.render(option);
    }
});