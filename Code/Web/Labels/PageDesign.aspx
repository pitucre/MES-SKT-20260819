<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageDesign.aspx.cs" ValidateRequest="false" Inherits="SKT.LeanMES.Web.Labels.PageDesign" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title></title>
    <script src="../Content/js/jquery-2.0.0.min.js"></script>
    <script src="../Content/js/jquery-ui.min.js"></script>
    <script src="../Content/plugin/echarts/echarts.min.js"></script>
    <script src="../Content/plugin/TackColor/spectrum.js"></script>
    <link href="../Content/plugin/TackColor/spectrum.css" rel="stylesheet" />
    <script src="PageDesign/layui/layui.all.js"></script>
    <link href="PageDesign/layui/css/layui.css" rel="stylesheet" />
    <link href="PageDesign/main.css" rel="stylesheet" />
</head>
<body>
    <div class="layui-tab layui-tab-brief" lay-filter="laytab">
        <ul class="layui-tab-title" id="laytabul">
            <li class="layui-this">控件布局</li>
            <li lay-id="control_event">控件事件</li>
            <li disabled="disabled" style="right: 0px; position: absolute; padding: 1px;">
                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_save"><i class="layui-icon layui-icon-ok-circle"></i>保存</button>
                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_preview"><i class="layui-icon layui-icon-search"></i>预览</button>
            </li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <table class="laytable">
                    <tr>
                        <td>
                            <div id="d_left" class="module search-panel">
                                <div>
                                    <input class="search-text" placeholder="搜索控件" type="text" value="" maxlength="20" />
                                </div>
                                <div class="controls">
                                </div>
                            </div>
                        </td>
                        <td>
                            <div id="d_center" class="module" style="background: #999;">
                                <div class="layui-form" id="panel1" labname="面板" tabindex="1"></div>
                            </div>
                        </td>
                        <td>
                            <div id="d_right" class="module">
                                <div class="layui-collapse">
                                    <div class="layui-colla-item">
                                        <h2 class="layui-colla-title">控件名称<select class="control-select" id="ddllables"></select>
                                        </h2>
                                        <div class="layui-colla-content layui-show" style="padding: 0px !important;">
                                            <div class="layui-tab">
                                                <ul class="layui-tab-title">
                                                    <li class="layui-this">基础属性</li>
                                                    <li>私有属性</li>
                                                </ul>
                                                <div class="layui-tab-content">
                                                    <div class="layui-tab-item layui-show" id="commonAttr"></div>
                                                    <div class="layui-tab-item" id="controlAttr"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="layui-tab-item">
                <table class="laytable">
                    <tr>
                        <td style="width: 120px;">
                            <div id="e_controls" class="module search-panel" style="width: 120px;">
                                <div>
                                    <input class="search-text" placeholder="搜索控件" type="text" value="" maxlength="20" />
                                </div>
                                <div class="datalist">
                                </div>
                            </div>
                        </td>
                        <td style="width: 130px;">
                            <div id="e_events" class="module search-panel" style="width: 130px; border-left: 1px solid #e6e6e6; border-right: 1px solid #e6e6e6; box-sizing: border-box;">
                                <div>
                                    <input class="search-text" placeholder="搜索控件事件" type="text" value="" maxlength="20" />
                                </div>
                                <div class="datalist">
                                </div>
                            </div>
                        </td>
                        <td>
                            <div id="e_funcbody" class="module">
                            </div>
                        </td>
                        <td style="width: 250px;">
                            <div id="e_sysobject" class="module search-panel" style="border-left: 1px solid #e6e6e6; box-sizing: border-box; width: 250px;">
                                <div>
                                    <input class="search-text" placeholder="搜索全局事件" type="text" value="" maxlength="20" />
                                </div>
                                <div class="datalist" style="font-size: 12px;">
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">
    var _PageDesignOptions = {
        control: {
            path: "PageDesign/control/",
            names: ["panel", "div", "select", "text", "datetime", "radio", "checkbox", "button", "datatable", "img", "bar", "line", "pie"]
        },
        //预览
        preview: function (str) {
            var loading_id = layer.load(1, { shade: [0.5, '#000'] });
            $.ajax({
                type: "POST",
                cache: false,
                data: { data: str, control: JSON.stringify(_PageDesignOptions.control), action: "preview" },
                url: "PageDesign.aspx",
                success: function (data) {
                    layer.close(loading_id);
                    data = JSON.parse(data);
                    if (!data.success) {
                        layer.open({ content: data.msg });
                        return;
                    }
                    window.open("PagePreview.html");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.close(loading_id);
                    layer.open({ content: '预览出错' });
                }
            });
        },
        //保存
        save: function (str) {
          
        },
        //基础事件的参数
        baseEventParams: [
            { name: "event", remark: "当前事件对象" },
            { name: "event.target", remark: "当前事件目标对象" },
            { name: "event.target.nodeName", remark: "当前事件目标对象名称" },
            { name: "event.preventDefault()", remark: "阻止关联事件" },
            { name: "event.stopPropagation()", remark: "阻止事件冒泡" }
        ],
        sysobjects: [
            { name: "_PageDesignOptions", remark: "页面设计配置模型" },
            { name: "window", remark: "浏览器对象模型" },
            { name: "document", remark: "文档对象模型" },
            { name: "function", remark: "定义方法" },
            { name: "var", remark: "声明变量" },
            { name: "break;", remark: "跳出" },
            { name: "continue;", remark: "继续" },
            { name: "alert()", remark: "提示框", selection: function () { return { begin: 6, end: 6 }; } },
            { name: "confirm('')", remark: "确认框", selection: function () { return { begin: 9, end: 9 }; } },
            { name: "layui", remark: "layui对象" },
            { name: "JSON", remark: "JSON对象" },
            { name: "isNaN()", remark: "检查非数字值" },
            { name: "echarts", remark: "echarts图表对象" },
            { name: ".replace()", remark: "替换字符" },
            { name: ".substring()", remark: "截取字符" },
            { name: ".indexOf()", remark: "字符下标" },
            { name: ".split(\",\")", remark: "分割字符" },
            { name: ".toLocaleLowerCase()", remark: "字母转小写" },
            { name: ".toLocaleUpperCase()", remark: "字母转大写" },
            { name: "for (var i = 0; i < length; i++) {\n\t\n}", remark: "for循环", selection: function () { return { begin: 20, end: 26 }; } },
            { name: "if(true){\n\t\n}else{\n\t\n}", remark: "条件判断", selection: function () { return { begin: 3, end: 7 }; } },
            { name: "while(true){\n\t\n}", remark: "while循环", selection: function () { return { begin: 6, end: 10 }; } },
            { name: "switch(number){\n\tcase 0:\n\t\t\n\t\tbreak;\n\tdefault:\n\t\t\n\t\tbreak;\n}", remark: "switch", selection: function () { return { begin: 7, end: 13 }; } },
            { name: "document.getElementById()", remark: "根据id获取元素" },
            { name: "document.getElementsByName()", remark: "根据名称属性获取元素" },
            { name: "document.getElementsByTagName()", remark: "根据标签名获取元素" },
            { name: "document.getElementsByClassName()", remark: "根据样式名获取元素" },
            { name: "window.open()", remark: "打开一个窗口" },
            { name: "window.location", remark: "浏览器客户端本地对象" },
            { name: "window.document", remark: "文档对象模型" },
            { name: "window.location.href", remark: "浏览器客户端请求的地址" },
            { name: "window.location.reload()", remark: "浏览器客户端的请求重新加载" },
            { name: "layer.open({content:''})", remark: "layui提示框", selection: function () { return { begin: 21, end: 21 }; } },
            { name: "layui.table", remark: "layui数据表格对象" },
            { name: "layui.table.render()", remark: "layui数据表格初始化方法" },
            { name: "layui.table.reload()", remark: "layui数据表格重新加载方法" },
            { name: "layui.laydate", remark: "layui日期时间对象" },
            { name: "layui.laydate.render()", remark: "layui日期时间初始化方法" },
            { name: "layui.form", remark: "layui表单对象" },
            { name: "layui.form.render()", remark: "layui表单元素初始化方法" },
            { name: "echarts.init()", remark: "echarts图表初始化方法" },
            { name: "JSON.parse()", remark: "JSON字符串转对象" },
            { name: "JSON.stringify()", remark: "对象转JSON字符串" },
            { name: "$.each(['a','b'],function(index){\n\t//index:下标,this数组中当前下标的元素\n});", remark: "foreach循环" },
            { name: "$.get({\n\tdata:null,\n\turl:'',\n\tsuccess:function(){\n\t\t\n\t},\n\terror:function(){\n\t\t\n\t}\n});", remark: "ajax以get方法请求数据" },
            { name: "$.post({\n\tdata:null,\n\turl:'',\n\tsuccess:function(){\n\t\t\n\t},\n\terror:function(){\n\t\t\n\t}\n});", remark: "ajax以post方法请求数据" },
            { name: "window.document.getElementById()", remark: "根据id获取元素" },
            { name: "window.document.getElementsByName()", remark: "根据名称属性获取元素" },
            { name: "window.document.getElementsByTagName()", remark: "根据标签名获取元素" },
            { name: "window.document.getElementsByClassName()", remark: "根据样式名获取元素" }
        ]
    };
</script>
<script src="PageDesign/main.js"></script>
