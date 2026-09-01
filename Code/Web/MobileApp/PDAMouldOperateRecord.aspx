<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDAMouldOperateRecord.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAMouldOperateRecord" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>

    <title>模具保养</title>
    <style type="text/css">
        .clear {
            clear: both;
            height: 2px;
        }

        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        table {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px !important;
            color: #1d1007;
        }

        .ui-table th, .ui-table td {
            text-align: center;
            vertical-align: middle !important;
        }

        .fold {
            font-weight: bolder;
            display: inline-block;
            margin-bottom: 5px;
        }

        .flex {
            width: 99%;
            display: flex;
        }

        .flex_t_l {
            width: 32.55% !important;
        }

            .flex_t_l span {
                margin-bottom: 6px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
        <div data-role="page" id="pageOne">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">模具保养</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" style="margin-top: 0px; padding: 0.5em" id="content1">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label for="txtEquipmentCode">扫描模具编码</label>
                        </td>
                        <td>
                            <input type="text" id="txtEquipmentCode" androidscan="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>保养项目</label>
                        </td>
                        <td>
                            <select id="selUrgencyFlag" data-mini="true">
                                <option value="-1" selected="selected">请选择</option>
                                <option value="一级保养">一级保养</option>
                                <option value="二级保养">二级保养</option>
                                <option value="三级保养">三级保养</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtRemark">
                                备注</label>
                        </td>
                        <td colspan="2">
                            <textarea id="txtRemark" data-corners="false" type="text" data-mini="true" value="" style="width: 95%; height: 90px;"></textarea>
                        </td>
                    </tr>

                </table>
                <div style="text-align: center; font-size: 14px" id="rmsg" class="msg">
                </div>
                <div id="msg" style="text-align: center;">
                </div>

                <table style="width: 100%">
                    <tr>
                        <%-- <td>
                            <label>上传图片</label>
                        </td>--%>
                        <td colspan="2">
                            <div class="layui-upload">
                                <button type="button" class="layui-btn androidTakePicture" style="background-color: #4E8CD4" ontakepicture="onTakePicture" id="test1">上传图片</button>
                                <div class="flex">
                                    <div class="flex_t_l" onclick="ImgPosition(1)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment1" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady1" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                    <div class="flex_t_l" onclick="ImgPosition(2)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment2" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady2" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                    <div class="flex_t_l" onclick="ImgPosition(3)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment3" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady3" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                </div>
                                <div class="flex">
                                    <div class="flex_t_l" onclick="ImgPosition(4)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment4" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady4" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                    <div class="flex_t_l" onclick="ImgPosition(5)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment5" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady5" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                    <div class="flex_t_l" onclick="ImgPosition(6)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment6" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady6" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>

                <%--</div>--%>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="StartCheck" onclick="Confirm()" data-role="button" data-fullscreen="true" data-theme="a">确认</a></li>
                    </ul>
                </div>
            </div>

        </div>
    </form>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <script type="text/javascript">
        var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        $(function () {
            $(".ui-body-c").css("background", "#fff");
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#txtEquipmentCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
            $("#txtEquipmentCode").val("").focus();

            //折叠隐藏
            $("#tbody").on("click", ".fold", function () {
                showOrHideItem($(this));
            });
            //普通图片上传
            if (typeof (android) == "undefined") {
                layui.use('upload', function () {
                    var $ = layui.jquery, upload = layui.upload;

                    var uploadInst = upload.render({
                        elem: '#test1',
                        accept: 'images',
                        exts: 'jpg|jpge|gif|png|bmp',
                        size: 1024 * 10,//限制文件大小，单位 KB
                        url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=MouldMaintenanceLoad&userName=' + username,
                        data: { ID: "-1" },
                        before: function (obj) {
                            //预读本地文件示例，不支持ie8
                            obj.preview(function (index, file, result) {
                                //debugger;
                                $("#imgEquipment" + ImgCount).attr('src', result);//图片链接（base64）
                            });
                        },
                        done: function (res) {

                            //debugger;
                            //如果上传失败
                            if (res.code == 1) {
                                $("#lbFileReady" + ImgCount).text("上传失败！").attr("server-name", "").attr("fileName", "");
                                return;
                            }
                            //上传成功
                            $("#lbFileReady" + ImgCount).text(res.data.FileName).attr("server-name", res.data.src).attr("fileName", res.data.FileName);
                            if (ImgCount == 6) {
                                ImgCount = 1;
                            } else {
                                ImgCount++;
                            }

                        },
                        error: function () {
                            //debugger;

                            $("#lbFileReady" + ImgCount).text("上传失败！").attr("server-name", "").attr("fileName", "");
                        }
                    });
                });
            }

        });

        //折叠、隐藏
        function showOrHideItem(obj) {
            //var trObj = $(this).closest("tr");
            //var tdObj = $(this).closest("td");
            var trObj = obj.closest("tr");
            var tdObj = obj.closest("td");
            var eId = trObj.attr("EId");
            var demoId = trObj.attr("DemoId");

            var len = $("#tbody tr[EId=\"" + eId + "\"][DemoId=\"" + demoId + "\"]").length;
            if (len > 0) {
                if (trObj.next().is(":visible")) {
                    tdObj.attr("rowspan", 1);
                    trObj.nextAll("tr[EId=\"" + eId + "\"][DemoId=\"" + demoId + "\"]").hide();
                } else {
                    tdObj.attr("rowspan", len);
                    trObj.nextAll("tr[EId=\"" + eId + "\"][DemoId=\"" + demoId + "\"]").show();
                }
            }
        }

        //验证设备编码
        $("#txtEquipmentCode").on("keydown", function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#msg").html("");
                var EquipmentCodeNo = $.trim($("#txtEquipmentCode").val());
                if (EquipmentCodeNo == "") {
                    $("#msg").html("请扫描模具编码！").css("color", "red");
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }

                //验证设备编码
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMouldOperateRecord.MouldMaintenanceCheck_PDA(EquipmentCodeNo);
                if (ajax.error != null) {
                    var html = "";
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }
            }
        });

        //保存
        function Confirm() {
            $("#msg").html("");
            var equipmentCodeNo = $.trim($("#txtEquipmentCode").val());
            if (equipmentCodeNo == "") {
                $("#msg").html("请扫描模具编码！").css("color", "red");
                $("#txtEquipmentCode").val("").focus();
                return false;
            }

            var maintenanceImg1 = $("#lbFileReady1").attr("fileName");
            var maintenanceImg2 = $("#lbFileReady2").attr("fileName");
            var maintenanceImg3 = $("#lbFileReady3").attr("fileName");
            var maintenanceImg4 = $("#lbFileReady4").attr("fileName");
            var maintenanceImg5 = $("#lbFileReady5").attr("fileName");
            var maintenanceImg6 = $("#lbFileReady6").attr("fileName");

            if (confirm("确认操作？")) {
                var flag = false;
                var Remark = $.trim($("#txtRemark").val());
                var urgencyFlag = $("#selUrgencyFlag").val();
                var arrImg = [];
                arrImg.push(maintenanceImg1);
                arrImg.push(maintenanceImg2);
                arrImg.push(maintenanceImg3);
                arrImg.push(maintenanceImg4);
                arrImg.push(maintenanceImg5);
                arrImg.push(maintenanceImg6);
                var serverImageNames = arrImg.join(",");

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMouldOperateRecord.MouldMaintenanceUploadFile_PDA(equipmentCodeNo, Remark, urgencyFlag, serverImageNames);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert("操作成功！");
                $("#txtEquipmentCode").val("");
                window.location.reload();
            }
        }


        var ImgCount = 1;
        function ImgPosition(count) {
            ImgCount = count;
        }
        //安卓拍照图片上传
        function onTakePicture(content, name) {
            let file = this.base64toFile(content, name);
            let fileData = new FormData();
            fileData.append('file', file);
            fileData.append('ID', "-1");
            $.ajax({
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=MouldMaintenanceLoad&userName=' + username,
                type: "POST",
                data: fileData,
                cache: false,
                processData: false,  // 不处理数据
                contentType: false,   // 不设置内容类型
                dataType: "json",
                success: function (res) {
                    //如果上传失败
                    if (res.code == 1) {
                        $("#lbFileReady" + ImgCount).text("上传失败！").attr("server-name", "").attr("fileName", "");
                        return;
                    }
                    $("#imgEquipment" + ImgCount).attr('src', content);
                    //上传成功
                    $("#lbFileReady" + ImgCount).text(res.data.FileName).attr("server-name", res.data.src).attr("fileName", res.data.FileName);
                    if (ImgCount == 6) {
                        ImgCount = 1;
                    } else {
                        ImgCount++;
                    }
                },
                error: function () {
                    $("#lbFileReady" + ImgCount).text("上传失败！").attr("server-name", "").attr("fileName", "");
                }
            });
        }

    </script>
</body>
</html>

