<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="UIDesigner.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.UIDesigner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <link href="../Content/plugin/treeview/jquery.tree.css" rel="Stylesheet" type="text/css" />
    <link href="../Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet"
        type="text/css" />
    <link href="../Content/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-ui.min.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.validation.js"
        type="text/javascript"></script>
    <style type="text/css">
        .nav-list
        {
            border: 1px solid #d3d3d3;
            border-top: none;
            min-height: 350px;
        }
        .nav-list li
        {
            text-align: left;
            list-style: none;
            padding: 0px;
            margin: 0px;
        }
        .btn
        {
            height: 20px;
            line-height: 20px;
            padding: 5px 5px 5px 15px;
            overflow: hidden;
            white-space: nowrap;
            display: block;
        }
        .btn:hover
        {
            background: #f1f1f1;
            display: block;
            cursor: default;
            border: 1px solid #d3d3d3;
            height: 18px;
            border-right: none;
            border-left: none;
            line-height: 18px;
        }        
    </style>
    <div class="container">
        <form method="post" id="saveform" name="saveform" action="" target="_blank">
        <!--预览也要用 用来解析表单-->
        <input type="hidden" name="fields" id="fields" value="0" />
        <!--要提交到服务器的-->
        <input type="hidden" name="type" id="leipi_type" value="save" />
        <input type="hidden" name="formid" id="leipi_formid" value="1" />
        <textarea name="parse_form" id="leipi_parse_form" style="display: none;"></textarea>
        <div class="" style="height: auto; height:28px;line-height:28px;">
            <%--<h1 style="font-size: 24px; text-align: center;">
                UI设计器</h1>--%>
            <div style="text-align: center">
                <label>
                    <%=Resources.lang.Station %><em>*</em></label>
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox><input type="button" runat="server" id="btnSelectStation"
                        class="ButtonBox" value="..." title="选择工序" onclick="selectStation();" style="height:24px;" />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />&nbsp;
                <label>
                    UI模板名称：</label><em>*</em>
                <asp:TextBox ID="txtModelName" runat="server" CssClass="TextBox"></asp:TextBox>
            </div>
        </div>
        <div class="infoTips">
            <strong>提醒：</strong><span style="color: Red;">单选框和复选框，如：<code>{|-</code>选项<code>-|}</code>两边边界是防止误删除控件，程序会把它们替换为空，请不要手动删除！</span>
        </div>
        <table cellpadding="0" cellspacing="3" width="100%" border="0">
            <tr>
                <%--                                <td>
                    <input value="测试" onclick="btntest()" />
                </td>--%>
                <td valign="top" align="center" width="13%">
                    <div class="divHeader" style="text-align: left;">
                        控件列表</div>
                    <ul class="nav-list" id="nav-list">
                        <li><span onclick="uiFormDesign.exec('text');" class="btn btn-link" title="文本框">文本框</span></li>
                        <li><span onclick="uiFormDesign.exec('textarea');" class="btn btn-link" title="多行文本">
                            多行文本</span></li>
                        <li><span onclick="uiFormDesign.exec('select');" class="btn btn-link" title="下拉菜单">下拉菜单</span></li>
                        <li><span onclick="uiFormDesign.exec('radios');" class="btn btn-link" title="单选框">单选框</span></li>
                        <li><span onclick="uiFormDesign.exec('checkboxs');" class="btn btn-link" title="复选框">
                            复选框</span></li>
                        <li><span onclick="uiFormDesign.exec('listctrl');" class="btn btn-link" title="列表控件">
                            列表控件</span></li>
                        <li><span onclick="uiFormDesign.exec('gridctrl');" class="btn btn-link" title="表格控件">
                            表格控件</span></li>
                        <li><span onclick="uiFormDesign.exec('btnctrl');" class="btn btn-link" title="按钮控件">
                            按钮控件</span></li>
                        <li><span onclick="uiFormDesign.exec('choosepagectrl');" class="btn btn-link" title="弹窗控件">
                            弹窗控件</span></li>                        
                    </ul>
                </td>
                <td valign="top" align="left" colspan="2">
                    <script id="myFormDesign" type="text/plain" style="width: 100%; text-align: left;">

                    </script>
                </td>
            </tr>
        </table>
        <!--end row-->
        </form>
    </div>
    <!--end container-->
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/Formdesign/js/jquery-1.7.2.min.js?2022"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/Formdesign/js/ueditor/ueditor.config.js?2022"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/Formdesign/js/ueditor/ueditor.all.js?2022"> </script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/Formdesign/js/ueditor/lang/zh-cn/zh-cn.js?2022"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/Formdesign/js/ueditor/formdesign/skt.plugins.ui.formdesigner.js?2022"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <!-- script start-->
    <script type="text/javascript">
        var WIN_H = 300;
        $(function () {
            WIN_H = $(window).height() - 120;
            $("#nav-list").height(WIN_H);

            (function ($) {
                $.getUrlParam = function (name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                }
            })(jQuery);
            //如果有 modelid 加载对应的html代码
            var modelid = $.getUrlParam('ID'); 
            if (modelid != null && modelid != "" && modelid != "-1") {
                uiEditor.ready(function () {
                    $.post("../SDPHandler/LoadPage.ashx?api=GetInfo", { "modelid": modelid }, function (data) {
                        uiEditor.setContent(data);

                    });

                });
            }
        });
        var uiEditor = UE.getEditor('myFormDesign', {
            //allowDivTransToP: false,//阻止转换div 为p
            tooluictrl: true, //是否显示，设计器的 toolbars
            textarea: 'design_content',
            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
            toolbars: [[
            'fullscreen', 'source', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'removeformat', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|', 'fontfamily', 'fontsize', '|', 'indent', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'link', 'unlink', '|', 'horizontal', 'spechars', 'wordimage', '|', 'inserttable', 'deletetable', 'mergecells', 'splittocells']],
            //focus时自动清空初始化时的内容
            //autoClearinitialContent:true,
            //关闭字数统计
            wordCount: true,
            //关闭elementPath
            elementPathEnabled: false,
            //默认的编辑区域高度
            initialFrameHeight: $(window).height() - 150,
            autoHeightEnabled: false,
            scaleEnabled: false
            //,iframeCssUrl:"/Public/css/bootstrap/css/bootstrap.css" //引入自身 css使编辑器兼容你网站css
            //更多其他参数，请参考ueditor.config.js中的配置项
        });
        var uiFormDesign = {
            /*执行控件*/
            exec: function (method) {
                uiEditor.execCommand(method);
            },
            /*
            Javascript 解析表单
            template 表单设计器里的Html内容
            fields 字段总数
            */
            parse_form: function (template, fields) {
                //正则  radios|checkboxs|select|choosepagectrl 匹配的边界 |--|  因为当使用 {} 时js报错
                var preg = /(\|-<span(((?!<span).)*uictrltype=\"(radios|checkboxs|select|choosepagectrl)\".*?)>(.*?)<\/span>-\||<(img|input|textarea|select).*?(<\/select>|<\/textarea>|\/>))/gi, preg_attr = /(\w+)=\"(.?|.+?)\"/gi, preg_group = /<input.*?\/>/gi;
                if (!fields) fields = 0;

                var template_parse = template, template_data = new Array(), add_fields = new Object(), checkboxs = 0;

                var pno = 0;
                template.replace(preg, function (plugin, p1, p2, p3, p4, p5, p6) {
                    var parse_attr = new Array(), attr_arr_all = new Object(), name = '', select_dot = '', is_new = false;
                    var p0 = plugin;
                    var tag = p6 ? p6 : p4;
                    //alert(tag + " \n- t1 - "+p1 +" \n-2- " +p2+" \n-3- " +p3+" \n-4- " +p4+" \n-5- " +p5+" \n-6- " +p6);

                    if (tag == 'radios' || tag == 'checkboxs') {
                        plugin = p2;
                    } else if (tag == 'select' || 'choosepagectrl') {
                        plugin = plugin.replace('|-', '');
                        plugin = plugin.replace('-|', '');
                    }
                    plugin.replace(preg_attr, function (str0, attr, val) {
                        if (attr == 'name') {
                            if (val == 'uictrl_NewField') {
                                is_new = true;
                                fields++;
                                val = 'data_' + fields;
                            }
                            name = val;
                        }

                        if (tag == 'select' && attr == 'value') {
                            if (!attr_arr_all[attr]) attr_arr_all[attr] = '';
                            attr_arr_all[attr] += select_dot + val;
                            select_dot = ',';
                        } else {
                            attr_arr_all[attr] = val;
                        }
                        var oField = new Object();
                        oField[attr] = val;
                        parse_attr.push(oField);
                    })
                    /*alert(JSON.stringify(parse_attr));return;*/
                    if (tag == 'checkboxs') /*复选组  多个字段 */
                    {
                        plugin = p0;
                        plugin = plugin.replace('|-', '');
                        plugin = plugin.replace('-|', '');
                        var name = 'checkboxs_' + checkboxs;
                        attr_arr_all['parse_name'] = name;
                        attr_arr_all['name'] = '';
                        attr_arr_all['value'] = '';

                        attr_arr_all['content'] = '<span uictrltype="checkboxs"  title="' + attr_arr_all['title'] + '">';
                        var dot_name = '', dot_value = '';
                        p5.replace(preg_group, function (parse_group) {
                            var is_new = false, option = new Object();
                            parse_group.replace(preg_attr, function (str0, k, val) {
                                if (k == 'name') {
                                    if (val == 'uictrl_NewField') {
                                        is_new = true;
                                        fields++;
                                        val = 'data_' + fields;
                                    }

                                    attr_arr_all['name'] += dot_name + val;
                                    dot_name = ',';

                                }
                                else if (k == 'value') {
                                    attr_arr_all['value'] += dot_value + val;
                                    dot_value = ',';

                                }
                                option[k] = val;
                            });

                            if (!attr_arr_all['options']) attr_arr_all['options'] = new Array();
                            attr_arr_all['options'].push(option);

                            //if(!option['checked']) option['checked'] = '';
                            var checked = option['checked'] != undefined ? 'checked="checked"' : '';
                            attr_arr_all['content'] += '<input type="checkbox" name="' + option['name'] + '" value="' + option['value'] + '"  ' + checked + '/>' + option['value'] + '&nbsp;';

                            if (is_new) {
                                var arr = new Object();
                                arr['name'] = option['name'];
                                arr['uictrltype'] = attr_arr_all['uictrltype'];
                                add_fields[option['name']] = arr;

                            }

                        });
                        attr_arr_all['content'] += '</span>';

                        //parse
                        template = template.replace(plugin, attr_arr_all['content']);
                        template_parse = template_parse.replace(plugin, '{' + name + '}');
                        template_parse = template_parse.replace('{|-', '');
                        template_parse = template_parse.replace('-|}', '');
                        template_data[pno] = attr_arr_all;
                        checkboxs++;

                    } else if (name) {
                        if (tag == 'radios') /*单选组  一个字段*/
                        {
                            plugin = p0;
                            plugin = plugin.replace('|-', '');
                            plugin = plugin.replace('-|', '');
                            attr_arr_all['value'] = '';
                            attr_arr_all['content'] = '<span uictrltype="radios" name="' + attr_arr_all['name'] + '" title="' + attr_arr_all['title'] + '">';
                            var dot = '';
                            p5.replace(preg_group, function (parse_group) {
                                var option = new Object();
                                parse_group.replace(preg_attr, function (str0, k, val) {
                                    if (k == 'value') {
                                        attr_arr_all['value'] += dot + val;
                                        dot = ',';
                                    }
                                    option[k] = val;
                                });
                                option['name'] = attr_arr_all['name'];
                                if (!attr_arr_all['options']) attr_arr_all['options'] = new Array();
                                attr_arr_all['options'].push(option);
                                //if(!option['checked']) option['checked'] = '';
                                var checked = option['checked'] != undefined ? 'checked="checked"' : '';
                                attr_arr_all['content'] += '<input type="radio" name="' + attr_arr_all['name'] + '" value="' + option['value'] + '"  ' + checked + '/>' + option['value'] + '&nbsp;';

                            });
                            attr_arr_all['content'] += '</span>';

                        } else {
                            attr_arr_all['content'] = is_new ? plugin.replace(/leipiNewField/, name) : plugin;
                        }
                        //attr_arr_all['itemid'] = fields;
                        //attr_arr_all['tag'] = tag;
                        template = template.replace(plugin, attr_arr_all['content']);
                        template_parse = template_parse.replace(plugin, '{' + name + '}');
                        template_parse = template_parse.replace('{|-', '');
                        template_parse = template_parse.replace('-|}', '');
                        if (is_new) {
                            var arr = new Object();
                            arr['name'] = name;
                            arr['uictrltype'] = attr_arr_all['uictrltype'];
                            add_fields[arr['name']] = arr;
                        }
                        template_data[pno] = attr_arr_all;


                    }
                    pno++;
                })
                template = template.replace(/-\|}|{\|-/g, ''); //替换“{|-”和“-|}”
                var parse_form = new Object({
                    'fields': fields, //总字段数
                    'template': template, //完整html
                    'parse': template_parse, //控件替换为{data_1}的html
                    'data': template_data, //控件属性
                    'add_fields': add_fields//新增控件
                });
                return JSON.stringify(parse_form);
            },
            /*type  =  save 保存设计 versions 保存版本  close关闭 */
            fnCheckForm: function (type) {

                if (uiEditor.queryCommandState('source'))
                    uiEditor.execCommand('source'); //切换到编辑模式才提交，否则有bug

                if (uiEditor.hasContents()) {
                    uiEditor.sync(); /*同步内容*/

                    // alert("你点击了保存,这里可以异步提交....");
                    //return false;

                    var type_value = '', formid = 0, fields = $("#fields").val(), formeditor = '';

                    if (typeof type !== 'undefined') {
                        type_value = type;
                    }
                    //获取表单设计器里的内容
                    formeditor = uiEditor.getContent();
                    //解析表单设计器控件
                    var parse_form = this.parse_form(formeditor, fields);

                    if ($('#<%=txtModelName.ClientID %>').val() == "") {
                        alert("请填写模型名称");
                        return;
                    }
                    //判断入口事件
                    if ($.parseJSON(parse_form).template.indexOf("loadPage(this)") < 0) {
                        alert("模型没有选择入口事件的控件！");
                        return;
                    }

                    var id = $.getUrlParam('ID');
                    if (id != -1) {
                        var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxSDP.CheckModelIsUsed(id);
                        if (ajax2.error != null) {
                            alert(ajax2.error.Message);
                            return false;
                        }

                        if (ajax2.value) {
                            if (!window.confirm("当前模板已经被使用过了,您的修改可能会导致设置的地方出错,您确定要修改?!")) {
                                return;
                            }
                        }
                    }

                    $.post("../SDPHandler/Operation.ashx?api=Save", { 'name': $('#<%=txtModelName.ClientID %>').val(), 'postdata': parse_form, 'id': id, "stationid": $("#hdnStationId").val() }, function (data) {
                        var result = JSON.parse(data);
                        if (result.result == "True") {
                            alert('保存成功！');
                            //window.parent.refreshTab("ModuleList");
                            //window.parent.closeTab(window.parent.getCurrentTab()[0]);
                        }
                        else {
                            alert('保存失败,' + result.message);
                        }
                    });

                    /*
                    $("#leipi_type").val(type_value);
                    $("#leipi_parse_form").val(parse_form);

                    $("#saveform").attr("target", "_blank");
                    $("#saveform").attr("action", "/index/parse.html");
                    $("#saveform").submit();

                    //异步提交数据
                    $.ajax({
                    type: 'POST',
                    url : '/index/parse.html',
                    //dataType : 'json',
                    data : {'type' : type_value,'formid':formid,'parse_form':parse_form},
                    success : function(data){
                    if(confirm('查看js解析后，提交到服务器的数据，请临时允许弹窗'))
                    {
                    win_parse=window.open('','','width=800,height=600');
                    //这里临时查看，所以替换一下，实际情况下不需要替换  
                    data  = data.replace(/<\/+textarea/,'&lt;textarea');
                    win_parse.document.write('<textarea style="width:100%;height:100%">'+data+'</textarea>');
                    win_parse.focus();
                    }
                    
                    /*
                    if(data.success==1){
                    alert('保存成功');
                    $('#submitbtn').button('reset');
                    }else{
                    alert('保存失败！');
                    }* /
                    }
                    });*/

                } else {
                    alert('表单内容不能为空！')
                    $('#submitbtn').button('reset');
                    return false;
                }
            },
            /*预览表单*/
            fnReview: function () {
                if (uiEditor.queryCommandState('source'))
                    uiEditor.execCommand('source'); /*切换到编辑模式才提交，否则部分浏览器有bug*/

                if (uiEditor.hasContents()) {
                    uiEditor.sync();       /*同步内容*/

                    var type_value = '', formid = 0, fields = $("#fields").val(), formeditor = '';


                    /*设计form的target 然后提交至一个新的窗口进行预览*/
                    //获取表单设计器里的内容
                    formeditor = uiEditor.getContent();
                    //解析表单设计器控件
                    var parse_form = this.parse_form(formeditor, fields);
                    $.post("../SDPHandler/LoadPage.ashx?api=Preview", { "content": parse_form, "station": $("#hdnStationId").val() }, function (data) {
                        layer.open({
                            type: 1,
                            area: ['95%', '95%'],
                            shadeClose: true, //点击遮罩关闭
                            content: data
                        });
                    });



                    $("#leipi_parse_form").val(parse_form);
                    /*
                    $("#saveform").attr("target", "_blank");
                    $("#saveform").attr("action", "/index/parse.html");
                    $("#saveform").submit();
                    
                    document.forms[0].target = "mywin";
                    alert(document.forms[0].target) 
                    window.open('', 'mywin', "menubar=0,toolbar=0,status=0,resizable=1,left=0,top=0,scrollbars=1,width=" + (screen.availWidth - 10) + ",height=" + (screen.availHeight - 50) + "\"");

                    document.forms[0].action = "/index/preview.html";
                    document.forms[0].submit(); //提交表单
                    */
                } else {
                    alert('表单内容不能为空！');
                    return false;
                }
            }
        };

        /*
        $('#tools_iconv').grumble({
        text: '新功能', 
        angle: 340, 
        distance: 10, 
        showAfter: 100
        //,hideAfter: 1000
        });*/
        /*工序选择*/
        function selectStation() {
            flag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });

        }
        function getChooseValue(list) {
            $("#txtStation").val(list[0][1]);
            $("#hdnStationId").val(list[0][0]);
        }

        //        /* 测试使用  */
        //        function btntest() {
        //                    //获取表单设计器里的内容
        //                    formeditor = uiEditor.getContent();
        //                    //解析表单设计器控件
        //                    var fields = 1;
        //                    var parse_form = uiFormDesign.parse_form(formeditor, fields);
        //                    alert(parse_form)
        //                }
    </script>
    <!-- script end -->
</asp:Content>
