<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentSendRepair.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.EquipmentSendRepair" %>


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

        #slider2 {
            display: none;
        }

        .button-label {
            position: relative;
            display: inline-block;
            width: 80px;
            height: 25px;
            background-color: #ccc;
            box-shadow: #ccc 0px 0px 0px 2px;
            border-radius: 30px;
            overflow: hidden;
        }

        .circle {
            position: absolute;
            top: 0;
            left: 0;
            width: 30px;
            height: 25px;
            border-radius: 50%;
            background-color: #fff;
        }

        .button-label .text {
            line-height: 25px;
            font-size: 13px;
            text-shadow: 0 0 2px #ddd;
        }

        .on {
            color: #fff;
            display: none;
            text-indent: 10px;
        }

        .off {
            color: #fff;
            display: inline-block;
            text-indent: 50px;
        }

        .button-label .circle {
            left: 0;
            transition: all 0.3s;
        }

        #slider2:checked + label.button-label .circle {
            left: 50px;
        }

        #slider2:checked + label.button-label .on {
            display: inline-block;
        }

        #slider2:checked + label.button-label .off {
            display: none;
        }

        #slider2:checked + label.button-label {
            background-color: #51ccee;
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">PDA设备报修</label>
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
                    <tr style="display: none;">
                        <td>
                            <label>线体</label>
                        </td>
                        <td colspan="2">
                            <label id="line-name"></label>
                        </td>
                    </tr>
                    <tr style="display: none;">
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
                            <input id="selFaultLocation" type="text" data-mini="true" value="" />
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
                            <input id="selFaultCause" type="text" data-mini="true" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>上传图片</label>
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
                    <tr>
                        <td>
                            <label for="txtAnormalDescription">
                                故障描述</label>
                        </td>
                        <td colspan="2">
                            <textarea id="txtAnormalDescription" data-corners="false" type="text" data-mini="true" value="" style="width: 95%; height: 90px;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>紧急程度</label>
                        </td>
                        <td colspan="2">
                            <select id="selUrgencyFlag" data-mini="true">
                                <option value="-1" selected="selected">请选择</option>
                                <option value="0">低</option>
                                <option value="1">中</option>
                                <option value="2">高</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>是否停机</label>
                        </td>
                        <td colspan="2">
                            <%-- <fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
                                <input type="radio" name="stop-flag" id="stopFlag1" value="1">
                                <label for="stopFlag1">是</label>
                                <input type="radio" name="stop-flag" id="stopFlag0" value="0">
                                <label for="stopFlag0">否</label>
                            </fieldset>--%>
                            <div class="slider2-wrapper" data-role="none">
                                <input type="checkbox" id="slider2" name="switch" data-role="none"><label for="slider2" class="button-label" data-role="none"><span class="circle" data-role="none"></span><span class="text off" data-role="none">否</span><span class="text on" data-role="none">是</span></label>
                            </div>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center; font-size: 14px;">
                </div>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="StartCheck" onclick="Save()" data-corners="false" data-role="button"
                            data-fullscreen="true" data-theme="a">保存</a></li>
                    </ul>
                </div>
            </div>

            <!--筛选设备-->
            <div data-role="panel" id="fpanelEquipmentCode" data-display="overlay">
                <a href="#" id="btnFilterEquipmentCode" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选设备</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviewsEquipmentCode" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
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
        <script type="text/javascript">
            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            //故障部位 数组
            var equipmentFaultTypeList = [];



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
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentList({ EquipmentCode: equipmentCode }, 1, 0);
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
                    //根据设备编码判断设备编码是否存在
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentList({ EquipmentCode: equipmentCode }, parseInt(type), 0);
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
                    $("input[data-type='search']").val('');
                    $("#listviewsEquipmentCode").html('');
                    $("#fpanelEquipmentCode").panel("close");
                }

                $("#line-name").text(entity.LineName);
                $("#txtStationName").text(entity.StationName);
                $("#txtStation").val(entity.StationId);

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

            //保存
            function Save() {
                showMsg("", 1);
                //扫描
                var equipmentCode = $.trim($("#txtEquipmentCode").val());
                // var anormalType = $.trim($("#txtAnormalType").val());
                var anormalDescription = $.trim($("#txtAnormalDescription").val());
                /*  var anormalImg = $("#lbFileReady").attr("server-name");*/
                var stationId = $("#txtStation").val(); //$("#txtStation").attr("station-id");
                var urgencyFlag = $("#selUrgencyFlag").val();
                // var stopObj = $("input[name=\"stop-flag\"]:checked");
                var faultLocation = $("#selFaultLocation").val();
                var faultCause = $("#selFaultCause").val();

                var stopFlag = 0;

                if (equipmentCode == "") {
                    showMsg("请扫描设备编码", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return;
                }
                //if (anormalType == "") {
                //    showMsg("请扫描异常类型名称", 0);
                //    $("#txtAnormalType").val("").focus();
                //    return;
                //}

                if (faultLocation == "" || faultLocation == "-1") {
                    showMsg("请输入故障部位", 0);
                    return;
                }
                //if (faultCause == "" || faultCause == "-1") {
                //    showMsg("请输入故障状况", 0);
                //    return;
                //}
                if ($("#selUrgencyFlag").val() == "-1") {
                    showMsg("请选择紧急程度", 0);
                    return;

                }
                var anormalImg = ""
                $(".ListTable tbody tr").each(function (i, e) {
                    var u = $(this).find("td:eq(1) input").eq(1).val()
                    if (anormalImg != "") {
                        anormalImg += ",";
                    }
                    anormalImg += u;
                })

                //if (stopObj.length <= 0) {
                //    showMsg("请选择是否停机", 0);
                //    return;
                //}
                // stopFlag = parseInt(stopObj.val());
                var stopFlag = $("#slider2").prop("checked") == true ? 1 : 0;
                //保存
                var entity =
                {
                    EquipmentCode: equipmentCode,                  //设备编码
                    //  AnormalTypeName: anormalType,                  //异常类型
                    AnormalDesc: anormalDescription,               //故障描述
                    AnormalImg: anormalImg,                        //图片
                    StationId: parseInt(stationId),                //工序
                    UrgencyFlag: parseInt(urgencyFlag),            //紧急程序
                    StopFlag: stopFlag,                             //是否停机
                    FaultLocation: faultLocation,
                    FaultCause: faultCause,
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentRepairEdit(entity);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return false;
                }
                var info = ajax.value;
                $("#txtEquipmentCode").val("").focus();
                $("#txtAnormalType").val("");
                $("#txtAnormalDescription").val("");
                $("#imgEquipment").attr("src", "");
                $("#lbFileReady").text("").attr("server-name", "");
                $("#txtStation").val("");
                $("#txtStationName").text("");
                $("#line-name").text("");
                $("#selFaultLocation").val("");
                $("#selFaultCause").val("");
                $("#selUrgencyFlag").val("-1").selectmenu('refresh', true);
                $("input[name=\"stop-flag\"]:checked").prop("checked", false).checkboxradio("refresh");
                //$("#selFaultCause option").not(".default").remove();
                //$("#selFaultLocation option").not(".default").remove();
                //$("#selFaultCause").val("-1").selectmenu('refresh', true);
                //$("#selFaultLocation").val("-1").selectmenu('refresh', true);
                equipmentFaultTypeList = [];


                
                if (info.length > 0) {
                    var showMsgStr = "保存成功！维修单号：" + info[0].RepairNo;
                    for (var i = 0; i < info.length; i++) {
                        showMsgStr += "，维修人：" + info[i].RepairName + "，维修人工号：" + info[i].RepairBy + "，维修电话：" + info[i].Phone;
                    }
                } else {
                    var showMsgStr = "保存成功！";
                }
                showMsg(showMsgStr, 1, 1);
                //调用API，将报修信息发送给OA，由OA通知维修人员
                //var msg = submitRepairToOA(info.RepairNo);
                //if (msg != "") {
                //    alert("保存成功，但发送OA消息失败：" + msg);
                //}
            }


            //显示设备编码筛选框
            function showEquipmentCode() {
                //初始化设备编码数据
                searchEquipmentCode("");
                $("#listviewsEquipmentCode").listview("refresh");
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

        </script>
    </form>
</body>
</html>
