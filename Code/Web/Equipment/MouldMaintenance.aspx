<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MouldMaintenance.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Labels/PageDesign/layui/css/layui.css" rel="stylesheet" />
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px; text-align: left;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">保养项目<em>*</em></td>
            <td class="Field1">
                <asp:DropDownList ID="ddlTestItem" runat="server" IsRequired="1" ClientIDMode="Static">
                    <asp:ListItem Text="--请选择--" Value=""></asp:ListItem>
                    <asp:ListItem Text="一级保养" Value="一级保养"></asp:ListItem>
                    <asp:ListItem Text="二级保养" Value="二级保养"></asp:ListItem>
                    <asp:ListItem Text="三级保养" Value="三级保养"></asp:ListItem>
                    <%--<asp:ListItem Text="防锈" Value="防锈"></asp:ListItem>
                    <asp:ListItem Text="打磨" Value="打磨"></asp:ListItem>
                    <asp:ListItem Text="在机抛光" Value="在机抛光"></asp:ListItem>
                    <asp:ListItem Text="卸模抛光" Value="卸模抛光"></asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">备注</td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" ClientIDMode="Static" TextMode="MultiLine" CssClass="TextArea" runat="server" Height="60px" Width="80%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>

    <div class="layui-upload">
        <button type="button" class="layui-btn layui-btn-normal" id="testList">选择文件</button>
        <button type="button" class="layui-btn" id="testListAction">开始上传</button>
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
                        <th>图片</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="demoList"></tbody>
            </table>
        </div>
    </div>
    <script type="text/javascript" src="../Content/js/layui.js"></script>
    <script type="text/javascript">
        var mouldId = '<%=Request.QueryString["Id"]%>';
        var UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var CName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().EmployeeCName%>';
        var ResultId = -1;
        /*保存数据*/
        function Save() {
            var entity = {};

            var item1 = $("#ddlTestItem").val();
            var type = "模具保养"
            var remark = $("#txtRemark").val();

            entity.MouldId = mouldId;
            entity.OperateType = type;
            entity.Operator = CName;
            entity.Item1 = item1;
            entity.Item2 = "";
            entity.Item3 = "";
            entity.Remark = remark;
            entity.CreateBy = UserName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMouldOperateRecord.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            ResultId = ajax.value;
            alert('<%=Resources.Messages.SaveInSuccess%>');
            //parent.window.closeDialog();

        }


        layui.use(['upload', 'element', 'layer'], function () {
            var $ = layui.jquery
                , upload = layui.upload
                , element = layui.element
                , layer = layui.layer;

            //演示多文件列表
            var uploadListIns = upload.render({
                elem: '#testList'
                , elemList: $('#demoList') //列表元素对象
                , url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?action=MouldMaintenanceLoad&rnd=" + Math.random()
                , acceptMime: 'image/*'
                , multiple: true
                , number: 10
                , auto: false
                , exts: "png|jpg|jpeg"
                , bindAction: '#testListAction'
                , data: { ID: ResultId, userName: UserName }
                , before: function (obj) { // obj 参数同 choose
                    if (ResultId == -1) {
                        alert("请先保存再上传!")
                        return false;
                    }
                    this.data.ID = ResultId;
                    this.data.userName = UserName;
                }
                , choose: function (obj) {
                    var that = this;
                    var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                    //读取本地文件
                    obj.preview(function (index, file, result) {
                        var tr = $(['<tr id="upload-' + index + '">'
                            , '<td>' + file.name + '</td>'
                            , '<td>' + (file.size / 1014).toFixed(1) + 'kb</td>'
                            , '<td><div class="layui-progress" lay-filter="progress-demo-' + index + '"><div class="layui-progress-bar" lay-percent=""></div></div></td>'
                            , '<td><img src=\'' + result + '\' class=\'tdPreImg\'></td>'
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
                        element.render('progress');
                    });
                }
                , done: function (res, index, upload) { //成功的回调
                    if (res.code == 0) {
                        fileNames.push(res.fileName);

                        var that = this;

                        var tr = that.elemList.find('tr#upload-' + index)
                            , tds = tr.children();
                        tds.eq(4).html(''); //清空操作
                        delete this.files[index]; //删除文件队列已经上传成功的文件

                        element.progress('progress-demo-' + index, '100%');
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
                    tds.eq(4).find('.demo-reload').removeClass('layui-hide'); //显示重传
                }
                , progress: function (n, elem, e, index) { //注意：index 参数为 layui 2.6.6 新增
                    element.progress('progress-demo-' + index, n + '%'); //执行进度条。n 即为返回的进度百分比
                }
            });

        });

    </script>

</asp:Content>
