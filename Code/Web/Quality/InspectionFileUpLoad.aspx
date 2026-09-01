<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InspectionFileUpLoad.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionFileUpLoad" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <link href="../Labels/PageDesign/layui/css/layui.css" rel="stylesheet" />
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1" font-size="30">检验单号</td>
            <td>
                <asp:Label runat="server" ClientIDMode="Static" ID="lbOrder" Font-Size="11"></asp:Label>
            </td>
        </tr>

    </table>
    <div class="clear5">
    </div>

    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="上传文件">上传文件
            </li>
            <li class="view-qcfile" title="相关文件">相关文件</li>
        </ul>
        <div class="tb_c">
            <div class="layui-upload">
                <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
                <button type="button" class="layui-btn" id="testListAction">开始上传</button>
                <button type="button" class="layui-btn" id="Save">保存</button>
                <div class="layui-upload-list" style="max-width: 1000px;">
                    <table class="layui-table">
                        <colgroup>
                            <col>
                            <col width="150">
                            <col width="260">
                            <col width="150">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>文件名</th>
                                <th>大小</th>
                                <th>上传进度</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="demoList"></tbody>
                    </table>
                </div>
            </div>
        </div>
        <div>
            <div id="FileInfo">
                <table class="ListTable" width="100%">
                    <thead>
                        <tr class="ListTableHeader">
                            <th>序号</th>
                            <th>文件名称</th>
                            <th>文件类型</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                            <th>下载</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>



    <script type="text/javascript">
        var OrderON = '<%=Request.QueryString["OrderON"]%>';
        var type = '<%=Request.QueryString["Action"]%>';
        var OrderON = '<%=Request.QueryString["OrderON"]%>';
        var Id = '<%=Request.QueryString["Id"]%>';
        var username = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName%>";
        var fileNames = []

        $().ready(function () {
            $("#<%=this.lbOrder.ClientID%>").html(OrderON);
            FileShow();
        });

        $("#Save")[0].addEventListener('click', function () {
            if (fileNames.length > 0) {
                parent.window.Show(1);
            } else {
                parent.window.Show(0);
                return false;
            }
        });


        function FileShow() {
            $("#FileInfo tbody")[0].innerHTML = "";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetFileInfo("", $.trim(OrderON), "");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value;
            for (var i = 0; i < data.length; i++) {
                var $tr = $("<tr class='ListTableOddRow'>"
                    + "<td>" + (i + 1) + "</td>"
                    + "<td>" + data[i].FileName + "</td>"
                    + "<td>" + data[i].FileType + "</td>"
                    + "<td>" + data[i].CreateBy + "</td>"
                    + "<td>" + data[i].CreateDateTime + "</td>"
                    + "<td><a href='#' onclick=FileSave(this)><span style='font-size:12px;'>" + mesLang("下载") + "</span></a></td>"
                    + "<td><a href='#' onclick=DeleteSave(\'" + data[i].Id + "\')><span style='font - size: 12px; '>" + mesLang("删除") + "</span></a></td>"
                        + "</tr>");
                $("#FileInfo tbody").append($tr);
                $tr.data("FileSaveName", data[i].FileSaveName);
            }
        }

        function FileSave(el) {
            var fileName = $(el).parent().parent().data("FileSaveName");
            var path = GetFilePath("InspectionIPQCFile", fileName);

            window.open(path);
        }

        function DeleteSave(el) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.DeleteSysUpLoadFileFile(el, username);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("删除成功!")
            FileShow();
        }

    </script>
    <script src="../Labels/PageDesign/layui/layui.js"></script>
    <script>
        layui.use(['upload', 'element', 'layer'], function () {
            var $ = layui.jquery
                , upload = layui.upload
                , element = layui.element
                , layer = layui.layer;



            //演示多文件列表
            var uploadListIns = upload.render({
                elem: '#testList'
                , elemList: $('#demoList') //列表元素对象
                , url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?action=" + type + "&OrderON=" + OrderON + "&Id=" + Id + "&userName=" + username + "&rnd=" + Math.random() //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                , accept: 'file'
                , multiple: true
                , number: 3
                , auto: false
                , bindAction: '#testListAction'
                , choose: function (obj) {
                    var that = this;
                    var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                    //读取本地文件
                    obj.preview(function (index, file, result) {
                        var tr = $(['<tr id="upload-' + index + '">'
                            , '<td>' + file.name + '</td>'
                            , '<td>' + (file.size / 1014).toFixed(1) + 'kb</td>'
                            , '<td><div class="layui-progress" lay-filter="progress-demo-' + index + '"><div class="layui-progress-bar" lay-percent=""></div></div></td>'
                            , '<td>'
                            , '<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                            , '<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                            , '</td>'
                            , '</tr>'].join(''));

                        //单个重传
                        tr.find('.demo-reload').on('click', function () {
                            obj.upload(index, file);
                        });

                        //删除
                        tr.find('.demo-delete').on('click', function () {
                            delete files[index]; //删除对应的文件
                            tr.remove();
                            uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                        });

                        that.elemList.append(tr);
                    });
                }
                , done: function (res, index, upload) { //成功的回调
                    if (res.code == 0) {
                        fileNames.push(res.fileName);

                        var that = this;

                        var tr = that.elemList.find('tr#upload-' + index)
                            , tds = tr.children();
                        tds.eq(3).html(''); //清空操作
                        delete this.files[index]; //删除文件队列已经上传成功的文件

                        element.progress('progress-demo-' + index, '100%');
                        FileShow();
                    }
                    else {
                        error(index, upload);
                    }
                }
                , allDone: function (obj) { //多文件上传完毕后的状态回调
                    console.log(obj)
                    alert("上传成功");
                }
                , error: function (index, upload) { //错误回调
                    var that = this;
                    var tr = that.elemList.find('tr#upload-' + index)
                        , tds = tr.children();
                    tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
                }
                , progress: function (n, elem, e, index) { //注意：index 参数为 layui 2.6.6 新增
                    element.progress('progress-demo-' + index, n + '%'); //执行进度条。n 即为返回的进度百分比
                }
            });



        });
    </script>

</asp:Content>
