<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Design.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.Design" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Design</title>
    <script src="../Content/js/jquery-2.0.0.min.js"></script>
    <script src="../Content/js/jquery-ui.min.js"></script>
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <script type="text/javascript" src="~/Content/TackColor/spectrum.js"></script>
    <script src="../Content/plugin/TackColor/spectrum.js"></script>
    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <link href="../Content/plugin/TackColor/spectrum.css" rel="stylesheet" />
    <link href="../Content/printdesign.css?v=2.0" rel="stylesheet" />
    <script src="../Content/login/js/jquery.cookie.js"></script>
</head>
<body>
    <table class="laytab">
        <tr>
            <td style="vertical-align: top;">
                <div id="d_left" class="module" style="display: none;">
                    <div>
                        <img src="../Content/images/print/text.png" type="text" title="文字(拖动添加,双击选择)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/barcode.png" type="barcode" title="条码(拖动添加,双击选择)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/qrcode.png" type="qrcode" title="二维码(拖动添加,双击选择)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/matrix.png" type="matrix" title="二维条码(拖动添加,双击选择)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/img.png" type="img" title="图片(拖动添加,双击选择)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/rect.png" type="rect" title="格子(拖动添加,双击选择)" />
                    </div>
                    <div>
                        <img src="../Content/images/print/line.png" type="line" title="线条(拖动添加,双击选择)" />
                    </div>
                </div>
            </td>
            <td style="vertical-align: top;">
                <div id="d_center" class="module">
                    <table>
                        <tr>
                            <td></td>
                            <td style="vertical-align: top;">
                                <div id="top_rule"></div>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top;">
                                <div id="left_rule"></div>
                            </td>
                            <td style="vertical-align: top;">
                                <div id="panel" tabindex="1"></div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="vertical-align: top;">
                <div id="d_right" class="module" style="display: none;">
                    <div class="layui-collapse">
                        <div class="layui-colla-item">
                            <div class="layui-colla-content layui-show" style="position: absolute; z-index: 1; width: 100%; background: #fff; border-bottom: 1px solid #0097ac; box-sizing: border-box;">
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_save">保存</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_preview">预览</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_print">打印</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_zoomin">放大</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px; margin: 0;" id="btn_zoomout">缩小</button>
                            </div>
                        </div>
                        <div class="layui-colla-item" style="margin-top: 60px;">
                            <h2 class="layui-colla-title">对齐</h2>
                            <div class="layui-colla-content layui-show">
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px;" id="btn_top">上</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px;" id="btn_bottom">下</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px;" id="btn_left">左</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px;" id="btn_right">右</button>
                            </div>
                        </div>
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">
                                <input id="rdokq" checked="checked" name="button1" type="radio" /><label for="rdokq">靠齐</label>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input name="button1" id="rdofs" type="radio" /><label for="rdofs">分散</label>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input name="button1" id="rdodq" type="radio" /><label for="rdodq">对齐</label>
                            </h2>
                            <div class="layui-colla-content layui-show">
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px;" id="btn_vertical">垂直</button>
                                <button type="button" class="layui-btn layui-btn-sm" style="border-radius: 0px;" id="btn_level">水平</button>
                                <input id="txtautoarrange" maxlength="8" type="text" class="control-text" placeholder="间隙(mm)" />
                            </div>
                        </div>
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">面板属性(mm毫米单位)</h2>
                            <div class="layui-colla-content layui-show" id="attr_panel" style="padding: 0px !important;"></div>
                        </div>
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">公共属性(mm毫米单位)</h2>
                            <div class="layui-colla-content layui-show" id="attr_common" style="padding: 0px !important;">
                            </div>
                        </div>
                        <div class="layui-colla-item attr_type">
                            <h2 class="layui-colla-title">文字设置(mm毫米单位)</h2>
                            <div class="layui-colla-content layui-show" id="attr_text" style="padding: 0px !important;">
                            </div>
                        </div>
                        <div class="layui-colla-item attr_type">
                            <h2 class="layui-colla-title">二维码设置</h2>
                            <div class="layui-colla-content layui-show" id="attr_qrcode" style="padding: 0px !important;">
                            </div>
                        </div>
                        <div class="layui-colla-item attr_type">
                            <h2 class="layui-colla-title">二维条码设置</h2>
                            <div class="layui-colla-content layui-show" id="attr_matrix" style="padding: 0px !important;">
                            </div>
                        </div>
                        <div class="layui-colla-item attr_type">
                            <h2 class="layui-colla-title">条形码设置</h2>
                            <div class="layui-colla-content layui-show" id="attr_barcode" style="padding: 0px !important;">
                            </div>
                        </div>
                        <div class="layui-colla-item attr_type">
                            <h2 class="layui-colla-title">线条设置</h2>
                            <div class="layui-colla-content layui-show" id="attr_line" style="padding: 0px !important;">
                            </div>
                        </div>
                        <div class="layui-colla-item attr_type">
                            <h2 class="layui-colla-title">图片设置</h2>
                            <div class="layui-colla-content layui-show" id="attr_img" style="padding: 0px !important;">
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</body>
</html>
<script type="text/javascript">
    var fontFamilys = [];
    var datakeys=[{ value:"", text:"请选择" }];
          <%foreach (var kv in FontFamilys)
    {%>fontFamilys.push({ value:"<%=kv.Name%>", text:"<%=kv.Name%>" });
    <%}%> 
     <%foreach (var kv in Fields)
    {%>datakeys.push({ value:"<%=kv.FieldDfID%>", text:"<%=kv.FieldDfName%>" });
    <%}%>
    var designOptions={
        winclose:true,
        fontFamilys:fontFamilys,//字体
        datakeys:datakeys,//key
        panelWidth:<%=Model.PanelWidth%>,//面板宽度 磅
        panelHeight:<%=Model.PanelHeight%>,//面板高度 磅
        tempSet:<%=Model.TempSet%>,//标签设置
        version:"8.5.3",
        domain: window.location.protocol + "//" + window.location.host,
        //预览
        preview:function (items,width,height) {
            var loading_id= layer.load(1, { shade: [0.5, '#000'] });
            $.ajax({
                type: "POST",
                cache: false,
                data: { temp: JSON.stringify(items), width: width, height: height, action:"preview"},
                url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Labels/Design.aspx",
                success: function (data) {
                    data = data.replace(/[\r]/g, "\\r").replace(/[\n]/g, "\\n");
                    layer.close(loading_id);
                    data=JSON.parse(data);
                    if(!data.success){
                        layer.open({ content:data.msg });
                        return;
                    }
                    window.open("Design.aspx?action=writepdf&name=" + data.name);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.close(loading_id);
                    layer.open({ content: '预览出错' });
                }
            });
        },
        //保存
        save:function (items,width,height) {
            var loading_id= layer.load(1, { shade: [0.5, '#000'] });
            $.ajax({
                type: "POST",
                cache: false,
                data:{ id:<%=Model.TempId%>,name:'<%=Model.TempName%>',set:JSON.stringify(items), width:width, height: height,action:"save" },
                url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Labels/Design.aspx",
                success: function (data) {
                    data = data.replace(/[\r]/g, "\\r").replace(/[\n]/g, "\\n");
                    layer.close(loading_id);
                    data=JSON.parse(data);
                    if(!data.success){
                        layer.open({ content:data.msg });
                        return;
                    }
                    layer.open({ content: '保存成功' });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.close(loading_id);
                    layer.open({ content: '保存出错' });
                }
            });
        },
        //选择图片
        selectImg:function (callback) {
            layer.open({
                title: '选择图片',
                type: 2,
                area: ['80%', '300px'],
                content: 'SelectImg.aspx?id=<%=Model.TempId%>',
                btn: ['确定', '取消'],
                btn1: function (index, layero) {
                    var url = layero.find("iframe")[0].contentWindow.selectImgName;
                    layer.close(index);
                    if(url)
                        callback(url);
                }
            });
        },
        getCodeUrl:function (str) {
            var base64Data ="data:image/png;base64,";
            $.ajax({
                type: 'post',
                async: false,

                url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Labels/Design.aspx?action=writecode",
                data:{
                    json:str
                },
                success: function (data) {
                    if(data){
                        base64Data += data;
                    }
                    else{
                        base64Data ="";
                    }
                }, error: function (a, b, c) {
                    console.log("获取图片数据异常");
                }
            });
            return base64Data;
        }
    };
</script>
<script src="../Content/js/printdesign.js?v=202304141115"></script>
<script src="../Content/js/ws.js"></script>
