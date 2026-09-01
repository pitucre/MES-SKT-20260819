<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentAccept.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.EquipmentAccept" %>


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
    <title>设备验收</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">PDA设备验收</label>
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
                    <tr>
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
                            <label>故障图片</label>
                        </td>
                        <td colspan="2">
                          <div class="layui-upload">
                            <div class="layui-upload-list">
                                <table class="ListTableAnormalImg" width="100%" style="margin-top: -1px;">
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
                            <label>备件编码</label>
                        </td>
                        <td colspan="2">
                            <label id="part-no"></label>
                        </td>
                    </tr>
                    <tr class="part-info" style="display: none;">
                        <td>
                            <label>备件数量</label>
                        </td>
                        <td colspan="2">
                            <label id="part-qty"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>维修图片</label>
                        </td>
                        <td colspan="2">
                            <div class="layui-upload">
                                <div class="layui-upload-list">
                                    <table class="ListTable" width="100%" style="margin-top: -1px;">
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                备注</label>
                        </td>
                        <td colspan="2">
                            <textarea id="txtAcceptRemark" data-corners="false" type="text" data-mini="true" value="" style="width: 95%; height: 90px;"></textarea>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center; font-size: 14px;">
                </div>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a onclick="save(4)" data-corners="false" data-role="button" data-fullscreen="true" data-theme="b">设备验收</a></li>
                        <li><a onclick="save(5)" data-corners="false" data-role="button" data-fullscreen="true" data-theme="a">设备拒收</a></li>
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


            });

            //function FileShow(entity) {
            //    $("#upload-file-name").text(entity.FileName).attr("server-name", entity.ServerFileName);
            //}

            //搜索、筛选设备编码号
            function searchEquipmentCode(equipmentCode) {
                $("#listviewsEquipmentCode").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentList({ EquipmentCode: equipmentCode }, 1, 2);
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
                    //根据设备编码判断设备编码是否存在
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentList({ EquipmentCode: equipmentCode }, parseInt(type), 2);
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
                //根据设备编码获取维修信息
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentRepairWaitAccept({ EquipmentCode: $.trim($("#txtEquipmentCode").val()) });
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }
                var info = ajax.value;
                if (!info || !info.RepairNo) {
                    showMsg("设备编码[" + equipmentCode + "]未完成维修，不能验收", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }

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

              


                //var appU = info.AnormalImg.split('/');
                //if (appU[appU.length - 1] != "") {

                //    var imgurl = GetFilePath("EquipmentFailure", appU[appU.length - 1]);
                //    $("#imgEquipment").attr("src", imgurl);
                //}
                $(".ListTable tbody").html("");
                $(".ListTableAnormalImg tbody").html("");
                var AnormalImgAttr = info.AnormalImg.split(',');
                for (var i = 0; i < AnormalImgAttr.length; i++) {
                    var fileUrl = GetFilePath("EquipmentFailure", AnormalImgAttr[i]);
                    var display = "<td align='center' ><img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /></td>";
                    $(".ListTableAnormalImg tbody").append("<tr class='ListTableOddRow'>"
                        + display
                        + "</tr>");


                }


                var RepairImgAttr = info.RepairImg1.split(',');
                for (var i = 0; i < RepairImgAttr.length; i++) {
                    var fileUrl = GetFilePath("EquipmentFailure", RepairImgAttr[i]);
                    var display = "<td align='center' ><img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /></td>";
                    $(".ListTable tbody").append("<tr class='ListTableOddRow'>"
                        + display
                        + "</tr>");


                }


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
            function save(type) {
                showMsg("", 1);
                //验证
                var equipmentCode = $.trim($("#txtEquipmentCode").val());
                var repairNo = $.trim($("#repair-no").text());
                var acceptRemark = $.trim($("#txtAcceptRemark").val());
                if (equipmentCode == "" || repairNo == "") {
                    showMsg("请先扫描设备编码", 0);
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }
                if (type == 5) {
                    if (acceptRemark == "") {
                        showMsg("请填写拒收原因", 0);
                        $("#txtAcceptRemark").val("").focus();
                        return false;
                    }
                }

                var entity =
                {
                    RepairNo: repairNo,                   //维修单号
                    Flag: parseInt(type),                 //操作类型（0 开始维修 1：报废 2：外修 3：维修完成 4：验收 5：拒收）
                    AcceptRemark: acceptRemark,
                    AnormalTypeName: "",
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentRepairOperate(entity);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return false;
                }
                var typeName = "";
                switch (type) {
                    case 4: typeName = "验收"; break;
                    case 5: typeName = "拒收"; break;
                }

                if (type != 0) {
                    $("#txtEquipmentCode").val("").focus();
                    $("#repair-no").text("");

                    $("#anormal-desc").text("");
                    $("#line-name").text("");
                    $("#txtStationName").text("");
                    $("#selFaultLocation").val("");
                    $("#selFaultCause").val("");
                    $("#urgency-name").text("");
                    $("#stop-flag-name").text("");
                    $("#part-no").text("");
                    $("#part-qty").text("");
                    $("#imgEquipment").attr("src", "");
                    $("#txtAcceptRemark").val("");

                }
                showMsg("设备编码[" + equipmentCode + "]" + typeName, 1);
            }


            //显示设备编码筛选框
            function showEquipmentCode() {
                //初始化设备编码数据
                searchEquipmentCode("");
                $("#listviewsEquipmentCode").listview("refresh");
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
