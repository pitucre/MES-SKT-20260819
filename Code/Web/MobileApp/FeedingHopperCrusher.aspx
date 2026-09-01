<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedingHopperCrusher.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.FeedingHopperCrusher" %>

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
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>

    <title>粉碎机上料</title>
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

        .ui-title {
            line-height: 30px;
        }
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false">
        <div data-role="page" id="pageTwo">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">粉碎机上料</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <label for="listno">
                                粉碎机编码</label>
                        </td>
                        <td>
                            <input type="text" id="listno" />
                        </td>
                        <td>
                            <a href="#OrderPanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择机器</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="GRN">
                                条码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="GRN" androidscan="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="GRN">
                                所用原料</label>
                        </td>
                        <td>
                            <input type="text" id="MaterialName" disabled="disabled" />
                        </td>
                        <td>
                            <input type="text" id="MaterialCode" disabled="disabled" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Print">
                                打印机</label>
                        </td>
                        <td colspan="2">
                            <select id="PDAselPrintersList" data-mini="true" class="perparelist">
                            </select>
                        </td>
                    </tr>
                </table>
                <div style="text-align: center; font-size: 14px" id="msg">
                </div>
                <table id="InfoTableGrn" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%">
                    <thead>
                        <tr>
                            <th>条码
                            </th>
                            <th>客户料号
                            </th>
                            <th>数量
                            </th>
                            <th>单位
                            </th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-transition="none" onclick="pull()" style="background-color: Gray">完成上料</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="OrderPanel" style="background: #f9f9f9">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="content">
                    <ul data-role="listview" id="listview" data-inset="false" data-filter="true" data-filter-placeholder="搜索"
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
            var CrusherCode = "";
            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("body>[data-role='listview']").listview();

                $(document).ready(function () {
                    bindPrinters('PDAselPrintersList', function () {
                        if ($("#PDAselPrintersList").val()) {
                            $("#PDAselPrintersList-button span").text($("#PDAselPrintersList").find("option:selected").text());
                        }
                    });
                });
            });
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#listno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
            $("#listno").focus();
            $("#GRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });

            $('#listno').on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html("");

                    if ($.trim($(this).val()) == "") {
                        $("#msg").html("粉碎机编码不能为空！").css("color", "red");
                        $(this).val('').focus();
                        return false;
                    }
                    $("#InfoTableGrn tbody").html('');
                    CrusherCode = $.trim($(this).val());
                    var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFeedingHoppeCrusher.GetCrusher(CrusherCode, 1);
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        $(this).val('').focus();
                        return false;
                    }
                    GetFeedingHopper(CrusherCode);
                    $("#GRN").val('').focus();
                }
            });

            $("#btnFilter").on("click", function () {
                $("#listview").html("");
                var $ul = $(this), value = $.trim($("#OrderPanel input[data-type='search']:eq(0)").val());

                var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFeedingHoppeCrusher.GetCrusher(value, value == "" ? 0 : 2);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                var htmlstr = "";
                var data = JSON.parse(ajax.value).data;
                $('#listview').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].EquipmentCode + "' onclick=ResList('" + data[i].EquipmentCode + "')>" + data[i].EquipmentName + "</li>";
                }
                $("#listview").append(htmlstr);
                $('#listview').listview('refresh');
            });

            function ResList(EquipmentCode) {
                $("#msg").html("");
                $("#listno").val(EquipmentCode);
                GetFeedingHopper(EquipmentCode);
                $("input[data-type='search']").val('');
                $("#OrderPanel").panel("close");
                $("#GRN").val('').focus();
            }

            function GetFeedingHopper(EquipmentCode) {
                var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFeedingHoppeCrusher.GetSrapFeedingDtl(EquipmentCode);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                var list = JSON.parse(ajax.value).data;
                if (ajax.value == null) {
                    return false;
                }

                $("#InfoTableGrn tbody").html("");
                if (list.length > 0) {
                    var htmlstr = "";
                    for (var i = 0; i < list.length; i++) {
                        htmlstr += "<tr>";
                        htmlstr += "<td>" + list[i].BarCode + "</td>";
                        htmlstr += "<td>" + list[i].BarCodeItemCode + "</td>";
                        htmlstr += "<td>" + list[i].BarcodeQty + "</td>";
                        htmlstr += "<td>" + list[i].BarcodeUnit + "</td>";
                        htmlstr += "<td><a href='javascript:void(0);' onclick=\"DeleteBarCode('" + list[i].SrapFeedingDtId + "','" + list[i].EquipmentCode + "')\"><%=Resources.lang.Delete %></a></td>";
                        htmlstr += "</tr>";
                    }
                    $("#MaterialName").val(list[0]["MaterialPartNumberName"]);
                    $("#MaterialCode").val(list[0]["MaterialPartNumberCode"]);
                }

                $("#InfoTableGrn tbody").html(htmlstr);
                $("#InfoTableGrn").table("refresh");
            }


            function DeleteBarCode(SrapFeedingDtId, EquipmentCode) {
                var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFeedingHoppeCrusher.SrapFeedingDeleteBarCode(SrapFeedingDtId);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                GetFeedingHopper(EquipmentCode);
            }



            /*
            *获取未上料的物料信息
            */
            function getMaterialList() {
                getPickListDetail(1, "InfoTableGrn");
            }

            var scanSN;
            //上料
            $("#GRN").on("keydown", function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $(".msg").html("");
                    var fMaterialBucketCode = $.trim($("#listno").val());
                    if (fMaterialBucketCode == "") {
                        confirmDialogFocus("请选择或扫描碎料机编码", function () {
                            $("#listno").select();
                        });
                        return false;
                    }
                    scanSN = $.trim($("#GRN").val());
                    if (scanSN == "") {
                        confirmDialogFocus("请输入GRN", function () {
                            $("#GRN").select();
                        });
                        return false;
                    }

                    var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFeedingHoppeCrusher.FeedingHopperLoadCrusher(fMaterialBucketCode, scanSN);
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        $("#GRN").val("").focus();
                        return false;
                    }

                    $(".msg").html(scanSN + "上料成功!").css("color", "#7FFF00");
                    scanSN = "";
                    setTimeout(function () {
                        $(".msg").html("");
                    }, 1500);
                    $("#GRN").val("").focus();
                    GetFeedingHopper(fMaterialBucketCode);
                }
            });

            /**
            *完成上料
            */
            function pull() {
                var fMaterialBucketCode = $.trim($("#listno").val());
                if (fMaterialBucketCode == "") {
                    confirmDialogFocus("请选择或扫描碎料机编码", function () {
                        $("#listno").select();
                    });
                    return false;
                }
                var grnLength = $("#InfoTableGrn tbody").find("tr").length;
                if (grnLength <= 0) {
                    confirmDialogFocus("请扫描上料GRN", function () {
                        $("#GRN").select();
                    });
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFeedingHoppeCrusher.FeedingHopperCompleteCrusher(fMaterialBucketCode);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    $("#GRN").val("").focus();
                    return false;
                }
                Clean();
                confirmDialog("完成上料成功！");
                var grnArray = [$.parseJSON(ajax.value)];
                setTimeout(function () {
                    try {
                        Print(grnArray);
                    }
                    catch (e) {
                        alert(e);
                    }
                }, 100);

            }

            function Clean() {
                $("#InfoTableGrn tbody").html("");
                $("#listno").val("");
                $("#MaterialName").val("");
                $("#MaterialCode").val("");
            }



            //查询页隐藏columntoggle列表按钮
            $(document).on("pageshow", "#Search,#pageTwo", function (event) {
                $(".ui-body-c").css("background", "#fff");
                $(".ui-table-columntoggle-btn").css("display", "none");
            });

            $(document).on("pageshow", function (event) {
                var _id = location.hash;
                if (_id == "") {
                    $("#pageOne div ul li a").each(function () {
                        if ($(this).attr("href") == "#pageOne") {
                            $(this).addClass("ui-btn-active");
                            return;
                        }
                    });
                    return false;
                }
                $(_id + " div ul li a").each(function () {
                    if ($(this).attr("href") == _id) {
                        $(this).addClass("ui-btn-active");
                        return;
                    }
                })
            });

            /*
            *写入用户操作日志
            */
            function SaveUserUILog(OederNo, LogContent) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.SaveUserUILog("一般", -1, -1, OederNo, LogContent);
                if (ajax.error != null) {
                    return false;
                }
            }
        </script>
        <script type="text/javascript">



            function Print(grnArray) {
                SNInfo = {};
                SNInfo.SNList = [];
                SNInfo.ItemList = [];
                for (var i = 0; i < grnArray.length; i++) {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grnArray[i].GRNString);

                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        $("#info").html(ajax.error.Message);
                        $("#info").css("color", "red");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                    if (ajax.value == null || ajax.value.SerialNumber == null) {
                        $("#info").html("无效的GRN或者该GRN对应的Item不存在！");
                        $("#info").css("color", "red");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }

                    try {
                        labelItemId = ajax.value.PartId;
                        //是否供应商打印调用不同的模板
                        //var IsSupper = ajax.value.IsSuplySerialNumber;
                        //if (IsSupper) {

                        //    labelType = -24; //调用供应商模板
                        //}
                        //else {
                        //    labelType = -3;
                        //}
                        //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                        getDocumentInfo();

                        //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                        SNInfo.SNList.push(grnArray[i].GRNString);
                        SNInfo.ItemList.push(ajax.value.PartId);
                    }
                    catch (e) {
                        alert(e)
                        $("#lblMessage").html(e);
                    }

                }
                PrintLabContent();


            }




            /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

            var ibs;                    //秒
            var labelDocumentId = -1    //Label文档Id
            var lableTypeQty = 1;       //连板数量
            var printName = "";         //打印机名称
            var labelItemId = -1;    //ItemId

            var labelStationId = -1;    //工位Id
            var labelType = -40;          //标签类型 (-2：SN，-3：GRN)
            var labelSequence = 2;      //标签序号 (1产品，2GRN, 3单号......)
            var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

            var lableArr = null;        //标签信息的SN序列号集合对象
            var SNInfo;                 //当前释放标签的信息集合对象
            var tempatePath = "";       //Lab模板文件路径

            //根据打印方式决定 调用ZPL还是Lab打印
            function getDocumentInfo() {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
                if (ajax.error == null) {
                    var entity = ajax.value;
                    labelDocumentId = entity.LabelDocumentId;
                    lableTypeQty = entity.PlateQty;
                    //获取打印机名称值
                    printName = $("#PDAselPrintersList").val();
                    labelPrintWayId = entity.PrintWayId;
                    tempatePath = entity.TemplatePath.replace("\\", "\\\\");

                }
                else {
                    alert(ajax.error.Message);
                    return false;
                }
            }

            var printCount = 1;
            function PrintLabContent() {
                try {
                    printCount = 1;
                    lableArr = SNInfo.SNList;
                    labItemList = SNInfo.ItemList;
                    var printdata = [];
                    for (var i = 0; i < lableArr.length; i++) {
                        var labelStr = lableArr[i];
                        var lablabItem = labItemList[i];
                        var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, lablabItem, -1);
                        if (ajaxLabContent.error == null) {
                            var list = ajaxLabContent.value;
                            var page = { LabelContent: [] };

                            for (var j = 0; j < list.length; j++) {

                                //xiang.yan 2024-06-28 物料编码10501.000410被认定为浮点数，打印时打印为10501.00041
                                if (isNumberVal(list[j].LabelValue) && list[j].LabelName != "物料编码") {
                                    page.LabelContent.push({ name: list[j].LabelName, value: parseFloat(list[j].LabelValue) });
                                }
                                else {
                                    page.LabelContent.push({ name: list[j].LabelName, value: list[j].LabelValue });

                                }


                            }
                            printdata.push(page);
                        }
                    }
                    if (printdata.length == 0)
                        return;
                    sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
                } catch (e) {
                    alert(e);
                    $("#msg1").html(e);
                    return false;
                }
            }

            //判断是否为数字
            function isNumberVal(val) {
                var regPos = /^\d+(\.\d+)?$/; //非负浮点数
                var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
                if (val.substring(0, 1) == "0") {
                    if (val.substring(1, 1) != ".") {
                        return false;
                    }
                }
                if (regPos.test(val) || regNeg.test(val)) {
                    return true;
                } else {
                    return false;
                }
            }


        </script>
    </form>
</body>
