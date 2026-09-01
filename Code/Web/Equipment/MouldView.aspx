<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MouldView.aspx.cs"
    Inherits="SKT.LeanMES.Web.Equipment.MouldView" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div id="printContext" style="width: 100%;">
        <div class="wrap_tb" style="min-height: 283px; min-width: 600px">
            <ul class="tb">
                <li class="current" title="<%= Resources.lang.BaseInfo%>">
                    <%= Resources.lang.BaseInfo%>
                </li>
                <%-- <li title="扩展信息">扩展信息</li>--%>
            </ul>

            <div class="tb_c">
                <table class="EditeContentTable" width="100%">

                    <tr>
                        <td class="Label3">
                            <%= Resources.lang.MouldCode%><em>*</em>
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblEquipmentCode"></asp:Label>
                            <%-- <input type="checkbox" class="check_ico_docu"/>自动生成--%>
                        </td>
                        <td class="Label3">
                            <%= Resources.lang.MouldName%><em>*</em>
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblEquipmentName"></asp:Label>

                        </td>
                        <td rowspan="5" class="Field3" style="text-align: center;">
                            <div id="layer-photos-demo" class="layer-photos-demo">
                                <asp:Image runat="server" ID="txtimg" alt="查看图片" Style="width: 139px; height: 135px;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label3">模具构件名称<em>*</em>
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblEquipmentType"></asp:Label>

                        </td>
                        <td class="Label3">
                            <%= Resources.lang.Supplier %><em>*</em>
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblSupplierName"></asp:Label>

                        </td>

                    </tr>

                    <tr>
                        <td class="Label3">当前位置<em>*</em>
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblPosition"></asp:Label>

                        </td>
                        <td class="Label3">公司
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblCompany"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label3">
                            <%= Resources.lang.EnterFactoryDate%><em>*</em>
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblFactortTime"></asp:Label>
                        </td>
                        <td class="Label3">价格
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblPrice"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label3">标准使用寿命
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblStandardLife"></asp:Label>

                        </td>
                        <td class="Label3">累计使用寿命
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblServiceLife"></asp:Label>

                        </td>
                    </tr>
                    <tr>
                        <td class="Label3">
                            <%= Resources.lang.Remark%>
                        </td>
                        <td class="Field3" colspan="4">
                            <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                                ClientIDMode="Static" Width="99%" Height="75" Enabled="False"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
        <div class="wrap_tb" style="min-width: 600px">
            <ul class="tb">
                <li class="current" title="<%= Resources.lang.BaseInfo%>">模具履历
                </li>
                <%-- <li title="扩展信息">扩展信息</li>--%>
            </ul>

            <div class="tb_c">
                <table class="ListTable" id="tbCompentList" style="border-width: 0px; width: 100%; border-collapse: collapse;"
                    cellspacing="0" cellpadding="2">
                    <tr class="ListTableHeader">
                        <th scope="col" style="text-align: center;" width="160px">操作时间
                        </th>
                        <th scope="col" style="text-align: center; width: 80px;">操作人
                        </th>
                        <th scope="col" style="text-align: center; width: 120px;">操作类型
                        </th>
                        <th scope="col" style="text-align: center;">项目1
                        </th>
                        <th scope="col" style="text-align: center;">项目2
                        </th>
                        <th scope="col" style="text-align: center">项目3
                        </th>
                        <th scope="col" style="text-align: center">图片查看
                        </th>
                        <%--<th scope="col" style="text-align: center;">备注
                        </th>--%>
                    </tr>
                    <tbody id="historyTb">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="lbFileReady" runat="server" Value="-1" ClientIDMode="Static" />
    <div class="clear5">
    </div>
    <asp:HiddenField ID="filepaths" runat="server" Value="-1" ClientIDMode="Static" />

    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>

    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <script type="text/javascript" language="javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>;
        $(function () {

            var path = "<%=SKT.LeanMES.Web.WebHelper.EQPictureFileRoot%>" + "/" + $("#<%=this.lbFileReady.ClientID%>").val();

            if ($("#<%=this.lbFileReady.ClientID%>").val() == "") {
                $("#layer-photos-demo").html("暂无图片");
                $("#<%=this.txtimg.ClientID%>").attr("display", "none");
            } else {
                $("#<%=this.txtimg.ClientID%>").attr("src", path);
                $("#<%=this.txtimg.ClientID%>").attr("layer-src", path);
            }

            //$("#<%=this.txtimg.ClientID%>").width(_width).height(_height).attr("src",path);


            getMouldOperateRecord();
        });

        function getMouldOperateRecord() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMouldOperateRecord.GetMouldOperateRecord(Id);
            if (ajax.error != null) {
                alert(ajax.value.ErrorMsg);
                return false;
            }
            bulidTable(ajax.value);
        }

        function bulidTable(list) {
            if (list.lenght == 0) {
                return;
            }
            var obj = $("#historyTb");
            var html = "";

            for (var i = 0; i < list.length; i++) {
                var entity = {};
                entity = list[i];

                html += "<tr class=\"ListTableOddRow\"><td  width=\"175px\">" + entity.CreateTime + "</td><td  width=\"80px\">" + entity.Operator + "</td><td>" + entity.OperateType + "</td><td >" + entity.Item1 + "</td><td>" + entity.Item2 + "</td><td>" + entity.Item3 + "</td><td style='text-align:center;'><a href='javascript: void (0);' onclick='showImg(" + entity.MouldOperateRecordId + ")'>查看</a></td></tr>";//<td>" + entity.Remark + "</td>
            }
            obj.html(html);
        }


        //显示大图片
        function showImg(t) {

            var entity = {};
            entity.MouldOperateRecordId = t;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetMouldMaintenanceUploadFile", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var FileData = JSON.parse(ajax.value);

            if (FileData.data.length == 0) {
                alert("未上传文件！")
                return false;
            }
            let showImgArr = [];

            for (var i = 0; i < FileData.data.length; i++) {
                //PDA端
                var fileUrl = GetFilePath("MouldMaintenanceLoad", FileData.data[i]["FileSaveName"]);
                if (!fileUrl) {
                    //PC端
                    fileUrl = GetFilePath("MouldMaintenanceLoad", JSON.parse(FileData.data[i]["FileSaveName"]).data.FileName);
                }
                showImgArr.push({
                    "alt": "",
                    "pid": i, //图片id
                    "src": fileUrl, //原图地址
                    "thumb": "" //缩略图地址
                });
            }

            if (showImgArr) {
                let shouImgObj = {
                    "title": "", //相册标题
                    "id": Math.round(Math.random() * 100), //相册id
                    "start": 0, //初始显示的图片序号，默认0
                    "data": showImgArr
                };
                layer.photos({
                    photos: shouImgObj
                });
            }
        }


        //编辑
        function Edit() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldEdit.aspx?name=Equipment_MouldEdit&Id=" + Id;
            $(".dlg-title.text", parent.window.document).html("编辑模具");
            window.location.href = openWinUrl;
        }


        function Look() {
            var filename = $("#<%=this.lbFileReady.ClientID%>").val();
            if (filename == "") {
                alert("没有上传图片");
                return false;
            }
            var path = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/UploadFiles/EQPicture" + "/" + filename;
            var path1 = '<%=SKT.LeanMES.Web.WebHelper.EQPictureFileRoot %>' + filename;
            var img = "<img src='" + path + "' >";

            layer.open({
                title: "图片",
                type: 1,
                maxmin: true,
                area: ['90%', '90%'],
                //offset: ['10px', '10px'],
                shadeClose: true, //点击遮罩关闭
                content: img
            });
        }

        layer.ready(function () { //为了layer.ext.js加载完毕再执行
            layer.photos({
                photos: '#layer-photos-demo'
                , shift: 5 //0-6的选择，指定弹出图片动画类型，默认随机
            });
        });
        function Down(data) {
            var name = $(data).parent().parent().find("td:eq(1)").html();
            var path = '<%=SKT.LeanMES.Web.WebHelper.EQFileRoot %>' + name;
            window.open(path);
        }
        function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=QC_InspectionItemDialog&controlId=-4";
            dialog({ title: "设备类型", src: openWinUrl, width: 255, height: 350 });
        }

        function PrintA4() {
            var currentTitle = window.parent.$("#dlg-title").children().eq(1).text();
            var title = window.top.document.title;
            var historyHTML = window.document.body.innerHTML;
            $(".noPrint").hide();
            //$(".noPrint,#toolbar,.infoTips").hide();
            $html = $("#printContext");
            //决绝打印时，文本框不出数据问题
            $("input[type='text']", $html).each(function () {
                $(this).attr("value", $(this).val());
            });

            $("select", $html).each(function () {
                var selected = $(this).val();
                $(this).children().each(function (j, m) {
                    if ($(m).val() == selected) {
                        $(m).attr("selected", true);
                    }
                });
            });

            window.document.body.innerHTML = "<div id='printContext'>" + $html.html() + "</div>";
            window.top.document.title = "模具信息";
            window.print();
            window.document.body.innerHTML = historyHTML;

            window.top.document.title = title;
        }


    </script>

</asp:Content>
