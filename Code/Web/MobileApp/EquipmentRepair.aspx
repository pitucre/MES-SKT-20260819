<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentRepair.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.EquipmentRepair" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>设备报修</title>
    <style type="text/css">
        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        .ui-mobile .ui-page-theme-a .ui-btn {
            background-color: #2FC1FF;
            border-color: #2FC1FF;
            color: #fff;
        }

        .ui-page-theme-a .ui-controlgroup-controls .ui-btn {
            background-color: #f6f6f6;
            border-color: #ddd;
            color: #000;
        }

        .ui-page-theme-a .ui-controlgroup-controls .ui-btn-active {
            background-color: #f6f6f6;
            border-color: #ddd;
            color: #fff;
        }

        #layermsg {
            position: absolute;
            left: 50%;
            top: 50%;
            width: 700px;
            height: 500px;
            margin-left: -350px;
            margin-top: -250px;
            display: none;
            z-index: 999;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">

        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">PDA设备维修</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" id="content1">
                <table style="width: 100%; z-index: 2">
                    <tr>
                        <td>
                            <label for="txtEquipmentCode">
                                设备编码</label>
                        </td>
                        <td>
                            <input id="txtEquipmentCode" placeholder="设备编码" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                        <td>
                            <a href="#fpanelEquipmentCode" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="showEquipmentCode()">选择设备</a>
                        </td>
                    </tr>
                    <%--    <tr>
                        <td>
                            <label for="txtAnormalType">异常类型</label>
                        </td>
                        <td>
                            <input id="txtAnormalType" placeholder="异常类型名称" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                        <td>
                            <a href="#fpanelAnormalType" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="showAnormalType()">选择异常</a>
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <label>维修单号</label>
                        </td>
                        <td colspan="2">
                            <label id="repair-no"></label>
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td>
                            <label>线体</label>
                        </td>
                        <td colspan="2">
                            <label id="line-name"></label>
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td>
                            <label for="txtStation">工序</label>
                        </td>
                        <td colspan="2">
                            <input type="hidden" id="txtStation" value="" />

                            <span id="txtStationName"></span>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label>故障部位</label>
                        </td>
                        <td colspan="2">
                            <%--<select id="selFaultLocation" data-mini="true">
                                <option value="-1" selected="selected" class="default">请选择</option>
                            </select>--%>
                            <input id="selFaultLocation" readonly="readonly" type="text" data-mini="true" value="" />
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td>
                            <label>故障状况</label>
                        </td>
                        <td colspan="2">
                            <%-- <select id="selFaultCause" data-mini="true">
                                <option value="-1" selected="selected" class="default">请选择</option>
                            </select>--%>
                            <input id="selFaultCause" readonly="readonly" type="text" data-mini="true" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                报修人</label>
                        </td>
                        <td colspan="2">
                            <label id="lblCreateName"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                报修人电话</label>
                        </td>
                        <td colspan="2">
                            <label id="lblCreatePhone"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>故障图片</label>
                        </td>
                        <td colspan="2">
                            <div class="layui-upload-list">
                                <table class="ListTableAnormalImg" width="100%" style="margin-top: -1px;">

                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtAnormalDescription">
                                故障描述</label>
                        </td>
                        <td colspan="2">
                            <label id="anormal-desc"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>紧急程度</label>
                        </td>
                        <td colspan="2">
                            <label id="urgency-name"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>是否停机</label>
                        </td>
                        <td colspan="2">
                            <label id="stop-flag-name"></label>
                        </td>
                    </tr>
                    <tr class="part-info" style="display: none;">
                        <td>
                            <label for="txtPartNo">备件编码</label>
                        </td>
                        <td>
                            <input id="txtPartNo" placeholder="备件编码" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                        <td>
                            <a href="#fpanelPartNo" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="showPartNo()">选择备件</a>
                        </td>
                    </tr>
                    <tr style="display: none;">
                        <td>
                            <label for="txtPartQty">备件数量</label>
                        </td>
                        <td colspan="2">
                            <input id="txtPartQty" placeholder="" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                    </tr>
                    <tr class="part-info" style="display: none;">
                        <td>
                            <label>维修图片</label>
                        </td>
                        <td colspan="2">
                            <div class="layui-upload">
                                <button type="button" class="layui-btn androidTakePicture" style="background-color: #4E8CD4" ontakepicture="onTakePicture" id="upload-image">上传图片</button>
                                <div class="layui-upload-list">
                                    <table class="ListTable" width="100%" style="margin-top: -1px;">
                                        <thead>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </td>
                    </tr>
                    <tr class="external-repair-info" style="display: none;">
                        <td>
                            <label for="txtExternalRepairRemark">备注</label>
                        </td>
                        <td colspan="2">
                            <textarea id="txtExternalRepairRemark" data-corners="false" type="text" data-mini="true" value="" style="width: 95%; height: 90px;"></textarea>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center; font-size: 14px;">
                </div>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a onclick="save(0)" data-corners="false" data-role="button" data-fullscreen="true" data-theme="b">维修开始</a></li>
                        <li><a onclick="save(1)" data-corners="false" data-role="button" data-fullscreen="true" data-theme="a">报废</a></li>
                        <li><a onclick="save(2)" data-corners="false" data-role="button" data-fullscreen="true" data-theme="b">外修</a></li>
                        <li><a onclick="save(3)" data-corners="false" data-role="button" data-fullscreen="true" data-theme="a">完成</a></li>
                    </ul>
                </div>
            </div>
            <asp:HiddenField ID="hidStatus" runat="server" ClientIDMode="Static" />
            <!--筛选设备-->
            <div data-role="panel" id="fpanelEquipmentCode" data-display="overlay">
                <a href="#" id="btnFilterEquipmentCode" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选设备</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviewsEquipmentCode" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
            <!--筛选备件条码-->
            <div data-role="panel" id="fpanelPartNo" data-display="overlay">
                <a href="#" id="btnFilterPartNo" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选备件</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviewsPartNo" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
            <%--    <!--筛选异常类型-->
            <div data-role="panel" id="fpanelAnormalType" data-display="overlay">
                <a href="#" id="btnFilterAnormalType" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选异常</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviewsAnormalType" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>--%>

            <!--筛选工序-->
            <%--        <div data-role="panel" id="fpanelStation" data-display="overlay">
                <a href="#" id="btnFilterStation" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选工序</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviewsStation" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>--%>
        </div>
        <div id="layermsg">
        </div>
        <%--    <script type="text/javascript" src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.js'></script>--%>

        <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
        <link type="text/css" href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify.css"
            rel="Stylesheet" />
        <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js"></script>

        <script type="text/javascript">
            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            layui.use('upload', function () {
                var $ = layui.jquery, upload = layui.upload;
                //图片上传
                upload.render({
                    elem: '#upload-image',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
                    data: { Action: "EquipmentFailure", userName: username },
                    exts: 'jpg|jpge|gif|png', //只允许上传excel文件
                    size: 10240,//限制文件大小，单位 KB
                    multiple: true,
                    done: function (res) {
                        debugger;
                        //如果上传失败
                        if (res.msg != "上传成功") {
                            alert("上传失败:" + res.msg);
                            return false;
                        }
                        var fileUrl = GetFilePath("EquipmentFailure", res.data.FileName);
                        var display = "<td align='center' ><img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /></td>";

                        $(".ListTable tbody").append("<tr class='ListTableOddRow'>"
                            + display
                            + "<td align='center'>"
                            + "<input type='button' value='删除' onclick='deleteFileFtp(this)' />"
                            + "<input type='hidden' name='hidFileUrl' value='" + res.data.FileName + "' /></td></tr>");

                    },
                    before: function (obj) {
                    },
                    error: function () {
                        //debugger;
                        alert("上传失败！");
                    }
                });

            });

            //安卓拍照图片上传
            function onTakePicture(content, name) {
                let file = this.base64toFile(content, name);
                let fileData = new FormData();
                fileData.append('file', file);
                $.ajax({
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=EquipmentFailure&userName=' + username,
                      type: "POST",
                      data: fileData,
                      cache: false,
                      processData: false,  // 不处理数据
                      contentType: false,   // 不设置内容类型
                      dataType: "json",
                      success: function (res) {
                          //如果上传失败
                          if (res.code == 1) {
                              $("#lbFileReady").text("上传失败！").attr("server-name", "");
                              return;
                          }
                          var fileUrl = GetFilePath("EquipmentFailure", res.data.FileName);
                          var display = "<td align='center' ><img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /></td>";

                          $(".ListTable tbody").append("<tr class='ListTableOddRow'>"
                              + display
                              + "<td align='center'>"
                              + "<input type='button' value='删除' onclick='deleteFileFtp(this)' />"
                              + "<input type='hidden' name='hidFileUrl' value='" + res.data.FileName + "' /></td></tr>");

                    <%--  $('#<%=this.imgEquipment.ClientID%>').attr('src', content);
                      //上传成功
                      $("#lbFileReady").text(res.data.FileName).attr("server-name", res.data.src);--%>
                      },
                      error: function () {
                          $("#lbFileReady").text("上传失败！").attr("server-name", "");
                      }
                  });
            }


            //故障部位 数组
            var equipmentFaultTypeList = [];
            var eCode = ""; //设备编码


            $(document).ready(function () {
                //隐藏columntoggle列表按钮
                $(".ui-body-c").css("background", "#fff");
                $("#txtEquipmentCode").focus();

                //扫描设备编码事件
                $("#txtEquipmentCode").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        getEquipmentCode(null, 0);
                        return false;
                    }
                });

                //输入设备编码并进行筛选
                $("#listviewsEquipmentCode").on("filterablebeforefilter", function (e, data) {
                    val = $(data.input).val();
                    if (!val || val.length <= 1) {
                        return false;
                    }
                    searchEquipmentCode(val);
                });

                //筛选设备编码
                $("#btnFilterEquipmentCode").on("click", function () {
                    val = $.trim($("#fpanelEquipmentCode input[data-type='search']").first().val());
                    searchEquipmentCode(val);
                });
                //输入备件条码并进行筛选
                $("#listviewsPartNo").on("filterablebeforefilter", function (e, data) {
                    val = $(data.input).val();
                    if (!val || val.length <= 1) {
                        return false;
                    }
                    searchPartNo(val);
                });

                //扫描设备编码事件
                $("#txtPartNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        var val = $(this).val();
                        getPartNo(val, 0);
                        return false;
                    }
                });


                //扫描异常类型事件
                //$("#txtAnormalType").on("keydown", function (e) {
                //    var curKey = 0, e = e || window.event;
                //    curKey = e.keyCode || e.which || e.charCode;
                //    if (curKey == 13) {
                //        getAnormalType(null, 0);
                //    }
                //});

                ////输入异常类型并进行筛选
                //$("#listviewsAnormalType").on("filterablebeforefilter", function (e, data) {
                //    val = $(data.input).val();
                //    if (!val || val.length <= 1) {
                //        return false;
                //    }
                //    searchAnormalType(val);
                //});

                ////筛选异常类型
                //$("#btnFilterAnormalType").on("click", function () {
                //    val = $.trim($("#fpanelAnormalType input[data-type='search']").first().val());
                //    searchAnormalType(val);
                //});


                ////输入工序并进行筛选
                //$("#listviewsStation").on("filterablebeforefilter", function (e, data) {
                //    val = $(data.input).val();
                //    if (!val || val.length <= 1) {
                //        return false;
                //    }
                //    searchStation(val);
                //});

                ////筛选工序
                //$("#btnFilterStation").on("click", function () {
                //    val = $.trim($("#fpanelStation input[data-type='search']").first().val());
                //    searchStation(val);
                //});

                ////故障部位下拉框改变事件
                //$("#selFaultLocation").change(function () {
                //    $("#selFaultCause option").not(".default").remove();
                //    var val = $(this).val();
                //    if (val == "-1") {
                //        $("#selFaultCause").val("-1").selectmenu('refresh', true);
                //        return false;
                //    }
                //    var hl = "";
                //    for (var i = 0; i < equipmentFaultTypeList.length; i++) {
                //        if (val == equipmentFaultTypeList[i].FaultLocation) {
                //            hl += "<option value=\"" + equipmentFaultTypeList[i].FaultCause + "\">" + equipmentFaultTypeList[i].FaultCause + "</option>";
                //        }
                //    }
                //    $("#selFaultCause").append(hl);
                //    $("#selFaultCause").val("-1").selectmenu('refresh', true);
                //    return false;
                //});

            });

            //function FileShow(entity) {
            //    $("#upload-file-name").text(entity.FileName).attr("server-name", entity.ServerFileName);
            //}

            //搜索、筛选设备编码号
            function searchEquipmentCode(equipmentCode) {
                $("#listviewsEquipmentCode").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentList({ EquipmentCode: equipmentCode }, 1, 1);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }
                var list = ajax.value;

                var ulhtml = "";
                for (var i = 0; i < list.length; i++) {
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getEquipmentCode(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].EquipmentCode + "</a></li>";
                }
                $("#listviewsEquipmentCode").html(ulhtml);
                $("#listviewsEquipmentCode").listview("refresh");
            }

            function deleteFileFtp(obj) {
                $(obj).parent().parent().remove();

            }
            //预览图片
            function showPic(picUrl) {
                var picContent = "<div id='divClose' title='关闭'>X</div><img width=\"700\" height=\"500\" src=" + picUrl + " />";
                var bodyheight = $("body").height();
                var bodywidth = $("body").width();

                $("#layermsg").html(picContent).show();
                $("#layermsg").bind("click", function () { $("#layermsg,#layer").hide(); });
                $("#layer").css({
                    height: bodyheight,
                    width: bodywidth,
                    display: "block"
                });
            }
            //获取文件
            function GetFilePath(action, fileName) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.LocalFileExists(fileName, action);
                var imgurl = "";
                if (ajax.value != "") {
                    return ajax.value;
                }
                var fileUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/ESOP/DownLoad.aspx?Action=" + action + "&fileName=" + escape(fileName);

                $.ajax({
                    url: fileUrl,
                    type: "get",
                    async: false,
                    success: function () {
                        imgurl = "/UploadFiles/EquipmentFailure/" + fileName;
                    }

                })
                return imgurl;
            }

            //获取设备编码明细信息  type 0：扫描 1：选择单据
            function getEquipmentCode(entity, type) {
                //$("#selFaultCause option").not(".default").remove();
                //$("#selFaultLocation option").not(".default").remove();
                //$("#selFaultCause").val("-1").selectmenu('refresh', true);
                //$("#selFaultLocation").val("-1").selectmenu('refresh', true);
                equipmentFaultTypeList = [];
                showMsg("", 1);
                if (type == 0) {
                    //扫描
                    var equipmentCode = $.trim($("#txtEquipmentCode").val());
                    if (equipmentCode == "") {
                        showMsg("请输入设备编码", 0);
                        $("#txtEquipmentCode").val("").focus();
                        return;
                    }

                    eCode = equipmentCode;
                    //根据设备编码判断设备编码是否存在
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentList({ EquipmentCode: equipmentCode }, parseInt(type), 1);
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message, 0);
                        $("#txtEquipmentCode").val("").focus();
                        return false;
                    }

                    //回车带出供应商编码和供应商名称
                    entity = ajax.value[0];
                    if (!entity || !entity.EquipmentCode) {
                        showMsg("未获取到设备信息，原因可能有：1、设备编码不存在 2、设备已维修或已报废", 0);
                        $("#txtEquipmentCode").val("").focus();
                        return false;
                    }
                } else {

                    //选择单据后，获取设备编码
                    $("#txtEquipmentCode").val(entity.EquipmentCode);
                    eCode = entity.EquipmentCode;
                    $("input[data-type='search']").val('');
                    $("#listviewsEquipmentCode").html('');
                    $("#fpanelEquipmentCode").panel("close");
                }

                $("#line-name").text(entity.LineName);
                $("#txtStationName").text(entity.StationName);
                $("#txtStation").val(entity.StationId);
                //根据设备编码获取维修信息
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentRepair({ EquipmentCode: $.trim($("#txtEquipmentCode").val()) }, 1);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }
                var info = ajax.value;

                $("#selFaultLocation").val(info.FaultLocation);
                $("#selFaultCause").val(info.FaultCause);
                $("#anormal-desc").text(info.AnormalDesc);
                $("#lblCreateName").text(info.CreateName);
                $("#lblCreatePhone").text(info.CreatePhone);
                $("#urgency-name").text(info.UrgencyName);
                $("#stop-flag-name").text(info.StopFlagName);
                $("#anormal-desc").text(info.AnormalDesc);
                $("#hidStatus").val(info.Status);
                $("#repair-no").text(info.RepairNo);
                $("#txtExternalRepairRemark").val(info.ExternalRepairRemark);

                //var appU = info.AnormalImg.split('/');

                //if (appU[appU.length - 1] != "") {

                //    var imgurl = GetFilePath("EquipmentFailure", appU[appU.length - 1]);

                //}

                var AnormalImgaArr = info.AnormalImg.split(',');
                if (AnormalImgaArr.length > 0) {
                    $(".ListTable1 tbody").html("");
                    var display = "<td align='center' >";
                    for (var i = 0; i < AnormalImgaArr.length; i++) {
                        var fileUrl = GetFilePath("EquipmentFailure", AnormalImgaArr[i]);
                        display += " <img src = " + fileUrl + "  onclick = 'showPic(this.src)' style = 'width:60px; height:50px; cursor:pointer;' />";
                    }
                    $(".ListTableAnormalImg tbody").append("<tr class='ListTableOddRow'>"
                        + display
                        + " </td ></tr>");

                }



                if (!info || !info.RepairNo) {
                    showMsg("设备编码[" + equipmentCode + "]未报修", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }

                if (info.Status == 1 || info.Status == 3) {
                    $(".part-info").show();
                    $(".external-repair-info").show();
                    if (info.Status == 3) {
                        $("#txtExternalRepairRemark").prop("readonly", "true");
                    }
                } else {
                    $(".part-info").hide();
                    $(".external-repair-info").hide();
                }

                if (info.AnormalImg) {
              //  $("#imgEquipment").attr("src", "<%= SKT.LeanMES.Web.WebHelper.EquipmentFailureRoot %>" + info.AnormalImg);
                }
                ////带出故障部位、故障状况
                //var ajaxType = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentFaultTypeList({ EquipmentTypeId: entity.EquipmentTypeId });
                //if (ajaxType.error != null) {
                //    showMsg(ajaxType.error.Message, 0);
                //    return false;
                //}
                //equipmentFaultTypeList = ajaxType.value;
                //if (!equipmentFaultTypeList || equipmentFaultTypeList.length <= 0) {
                //    showMsg("设备[" + entity.EquipmentCode + "]未绑定设备类型", 0);
                //    return false;
                //}
                //var hlFaultLocation = "";
                ////var hlFaultCause = "";
                //var faultLocationArr = [];
                //for (var i = 0; i < equipmentFaultTypeList.length; i++) {
                //    if (faultLocationArr.indexOf(equipmentFaultTypeList[i].FaultLocation) < 0) {
                //        faultLocationArr.push(equipmentFaultTypeList[i].FaultLocation);
                //    }
                //    //hlFaultCause += "<option value=\"" + equipmentFaultTypeList[i].FaultCause + "\">" + equipmentFaultTypeList[i].FaultCause + "</option>";
                //}
                //for (var i = 0; i < faultLocationArr.length; i++) {
                //    hlFaultLocation += "<option value=\"" + faultLocationArr[i] + "\">" + faultLocationArr[i] + "</option>";
                //}
                //$("#selFaultLocation option").not(".default").remove();
                //$("#selFaultLocation").append(hlFaultLocation).val("-1").selectmenu('refresh', true);
                //$("#txtAnormalType").focus();
            }

            //搜索、筛选备件编码
            function searchPartNo(PartNo) {
                $("#listviewsPartNo").html("");
                if (!eCode) {
                    showMsg("请选择设备", 0);
                    $("#txtPartNo").val("").focus();
                    return;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentPartList(eCode);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtPartNo").val("").focus();
                    return false;
                }
                var list = ajax.value;

                var ulhtml = "";
                for (var i = 0; i < list.length; i++) {
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getPartNo(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].PartCode + "</a></li>";
                }
                $("#listviewsPartNo").html(ulhtml);
                $("#listviewsPartNo").listview("refresh");
            }
            //获取备件编码信息  type 0：扫描 1：选择单据
            function getPartNo(entity, type) {
                showMsg("", 1);
                if (type == 0) {
                    //扫描
                    var partNo = $.trim($("#txtPartNo").val());
                    if (partNo == "") {
                        showMsg("请输入备件编码", 0);
                        $("#txtPartNo").val("").focus();
                        return;
                    }
                    //判断备件编码是否存在
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetPartList({ PartNO: partNo }, parseInt(type));
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message, 0);
                        $("#txtPartNo").val("").focus();
                        return false;
                    }
                    //回车带出备件编码
                    entity = ajax.value[0];
                    if (!entity || !entity.PartCode) {
                        showMsg("备件编码不存在或没有库存", 0);
                        $("#txtPartNo").val("").focus();
                        return false;
                    }
                } else {
                    //验证 设备绑定关系备件

                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.IsBind(entity.PartCode, $("#txtEquipmentCode").val().trim());
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message, 0);
                        $("#txtPartNo").val("").focus();
                        return false;
                    }

                    //选择单据后，获取备件编码
                    $("#txtPartNo").val(entity.PartCode);
                    $("input[data-type='search']").val('');
                    $("#listviewsPartNo").html('');
                    $("#fpanelPartNo").panel("close");
                }
                $("#txtPartQty").focus();
            }
            //搜索、筛选异常类型
            //function searchAnormalType(anormalType) {
            //    $("#listviewsAnormalType").html("");
            //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAnormal.GetAnormalTypeList({ AnormalTypeName: anormalType }, 1);
            //    if (ajax.error != null) {
            //        showMsg(ajax.error.Message, 0);
            //        $("#txtAnormalType").val("").focus();
            //        return false;
            //    }
            //    var list = ajax.value;
            //    var ulhtml = "";
            //    for (var i = 0; i < list.length; i++) {
            //        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getAnormalType(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].AnormalTypeName + "</a></li>";
            //    }
            //    $("#listviewsAnormalType").html(ulhtml);
            //    $("#listviewsAnormalType").listview("refresh");
            //}


            //获取异常类型信息  type 0：扫描 1：选择单据
            //function getAnormalType(entity, type) {
            //    showMsg("", 1);
            //    if (type == 0) {
            //        //扫描
            //        var anormalType = $.trim($("#txtAnormalType").val());
            //        if (anormalType == "") {
            //            showMsg("请输入异常类型名称", 0);
            //            $("#txtAnormalType").val("").focus();
            //            return;
            //        }
            //        //判断异常类型是否存在
            //        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetAnormalTypeList({ EquipmentCode: anormalType }, parseInt(type));
            //        if (ajax.error != null) {
            //            showMsg(ajax.error.Message, 0);
            //            $("#txtAnormalType").val("").focus();
            //            return false;
            //        }
            //        //回车带出异常类型
            //        entity = ajax.value[0];
            //        if (!entity || !entity.AnormalTypeName) {
            //            showMsg("异常类型不存在", 0);
            //            $("#txtAnormalType").val("").focus();
            //            return false;
            //        }
            //    } else {
            //        //选择单据后，获取异常类型
            //        $("#txtAnormalType").val(entity.AnormalTypeName);
            //        $("input[data-type='search']").val('');
            //        $("#listviewsAnormalType").html('');
            //        $("#fpanelAnormalType").panel("close");
            //    }
            //}

            //搜索、筛选工序
            function searchStation(station) {
                var equipmentCode = $.trim($("#txtEquipmentCode").val());
                if (equipmentCode == "") {
                    showMsg("请扫描设备编码", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return;
                }
                $("#listviewsStation").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetRepairStationList({ EquipmentCode: equipmentCode, Station: station }, 1);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtStation").val("").attr("station-id", "-1").focus();
                    return false;
                }
                var list = ajax.value;

                var ulhtml = "";
                for (var i = 0; i < list.length; i++) {
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getStation(" + (JSON.stringify(list[i])) + ")'>" + list[i].Station + "</a></li>";
                }
                $("#listviewsStation").html(ulhtml);
                $("#listviewsStation").listview("refresh");
            }


            //获取工序信息
            function getStation(entity) {
                showMsg("", 1);
                //选择单据后，获取工序
                $("#txtStation").val(entity.Station).attr("station-id", entity.StationId);
                $("input[data-type='search']").val('');
                $("#listviewsStation").html('');
                $("#fpanelStation").panel("close");
                $("#txtAnormalDescription").focus();
            }


            function save(type) {
                showMsg("", 1);
                //验证
                var equipmentCode = $.trim($("#txtEquipmentCode").val());
                var repairNo = $.trim($("#repair-no").text());
                var partNo = $.trim($("#txtPartNo").val());
                var partQty = $.trim($("#txtPartQty").val());
                var status = $.trim($("#hidStatus").val());
                //var anormalType = $.trim($("#txtAnormalType").val());
                var externalRepairRemark = $.trim($("#txtExternalRepairRemark").val());
                var faultLocation = $("#selFaultLocation").val();                var faultCause = $("#selFaultCause").val();




                if (equipmentCode == "" || repairNo == "") {
                    showMsg("请先扫描设备编码", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }
                //if (anormalType == "") {
                //    showMsg("异常类型不能为空", 0);
                //    $("#txtAnormalType").val("").focus();
                //    return false;
                //}

                if (type == 1) {
                    if (!confirm("确认要报废吗？")) {
                        return false;
                    }
                } else if (type == 2) {
                    if (status == 3) {
                        showMsg("当前设备已在外修中", 0);
                        return false;
                    }
                    if (status != 1) {
                        showMsg("当前状态不能外修", 0);
                        return false;
                    }

                    if (externalRepairRemark == "") {
                        showMsg("请输入外修备注", 0);
                        $("#txtExternalRepairRemark").val("").focus();
                        return false;
                    }
                }
                var repairImgs = "";
                if (type == 3 && (status != 0)) {
                    //if (partNo != "") {
                    //    if (partQty == "") {
                    //        showMsg("备件数量不能为空", 0);
                    //        $("#txtPartQty").val("").focus();
                    //        return false;
                    //    }
                    //    if (!isGreaterThanZero(partQty)) {
                    //        showMsg("备件数量必须为正数", 0);
                    //        return false;
                    //    }

                    //}


                    $(".ListTable tbody tr").each(function (i, e) {
                        var u = $(this).find("td:eq(1) input").eq(1).val()
                        if (repairImgs != "") {
                            repairImgs += ",";
                        }
                        repairImgs += u;
                    })

                    if (repairImgs == "") {
                        showMsg("请上传维修图片", 0);
                        return false;
                    }
                }

                if (faultLocation == "" || faultLocation == "-1") {
                    showMsg("请选择故障部位", 0);
                    return false;
                }
                //if (faultCause == "" || faultCause == "-1") {
                //    showMsg("请选择故障状况", 0);
                //    return false;
                //}

                var entity =
                {
                    RepairNo: repairNo,                   //维修单号
                    Flag: parseInt(type),                 //操作类型（0 开始维修 1：报废 2：外修 3：维修完成 4：验收 5：拒收）
                    //   AnormalTypeName: anormalType,
                    PartNo: partNo,
                    PartQty: partQty == "" ? 0 : parseInt(partQty),
                    ExternalRepairRemark: externalRepairRemark, //外修备注
                    FaultLocation: faultLocation,
                    FaultCause: faultCause,
                    RepairImg1: repairImgs
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentRepairOperate(entity);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return false;
                }
                var typeName = "";
                switch (type) {
                    case 0: typeName = "开始维修"; break;
                    case 1: typeName = "已报废"; break;
                    case 2: typeName = "外修"; break;
                    case 3: typeName = "维修完成"; break;
                }

                if (type != 0) {
                    $("#hidStatus").val("")
                    $("#txtEquipmentCode").val("").focus();
                    $("#repair-no").text("");
                    //$("#txtAnormalType").val("");
                    $("#anormal-desc").text("");
                    $("#line-name").text("");
                    $("#txtStationName").text("");
                    $("#lblCreateName").text("");
                    $("#lblCreatePhone").text("");
                    $("#txtStation").val(0);
                    $("#selFaultCause").val("");
                    $("#selFaultLocation").val("");
                    $("#urgency-name").text("");
                    $("#stop-flag-name").text("");
                    $("#imgEquipment").attr("src", "");
                    $("#txtPartNo").val("");
                    $("#txtPartQty").val("");
                    $("#txtExternalRepairRemark").val("");
                    $(".ListTable tbody").html("");
                    $(".ListTableAnormalImg tbody").html("");

                    equipmentFaultTypeList = [];
                } else {
                    $("#hidStatus").val(1);
                }

                if (status == 0) {
                    $(".part-info").show();
                    $(".external-repair-info").show();
                }

                showMsg("设备编码[" + equipmentCode + "]" + typeName, 1);

                //if (type == 2) {
                //    //设备外修，提交至OA
                //    var msg = submitEquipmentRepairToOA(repairNo);
                //    if (msg != "") {
                //        alert("保存成功，但提交OA处理失败：" + msg + "；可到维修列表重新提交！");
                //    }
                //}
            }

            //显示设备编码筛选框
            function showEquipmentCode() {
                //初始化设备编码数据
                searchEquipmentCode("");
                $("#listviewsEquipmentCode").listview("refresh");
            }
            //显示备件条码筛选框
            function showPartNo() {
                //初始化备件条码数据
                searchPartNo("");
                $("#listviewsPartNo").listview("refresh");
            }

            ////显示异常类型名称筛选框
            //function showAnormalType() {
            //    //初始化异常类型名称数据
            //    searchAnormalType("");
            //    $("#listviewsAnormalType").listview("refresh");
            //}

            //显示工序筛选框
            function showStation() {
                var equipmentCode = $.trim($("#txtEquipmentCode").val());
                if (equipmentCode == "") {
                    showMsg("请扫描设备编码", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return;
                }
                searchStation("");
            }

            //显示消息 type 1:成功 0：失败
            function showMsg(msg, type) {
                $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
            }
            //验证是否为大于0的数字（小数部分最多允许输入2位）（不能验证0、0.000000这样的，需要加上parseFloat(XXX)!=0）
            function isGreaterThanZero(val) {
                var reg = /^[0-9]+(.[0-9]{1,2})?$/;
                if (reg.test(val) && parseFloat(val) != 0) {
                    return true;
                }
                return false;
            }
        </script>
    </form>
</body>
</html>
