<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StationMaterialPrepar.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.StationMaterialPrepar" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
     
    <title>站位备料</title>
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

        .ui-title {
            line-height: 30px;
        }

        #Orderlistview li {
            padding: 0.7em 0.5em;
            font-size: 14px;
        }

        a[href="#waitMaterialTab-popup"] {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">

        <div data-role="page" data-url="setpage" class="bindpage" id="bindpage">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">站位备料</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar">
                    <ul>
                        <li><a href="#bindpage" data-theme="c">绑定</a></li>
                        <li><a href="#searchpage" data-transition="none" data-theme="c">备料</a></li>
                    </ul>
                </div>
            </div>

            <div data-role="content" data-position="fixed">
                <label for="showOrderNo">
                    工单
                </label>
                <a href="#" data-transition="none" data-role="button" data-mini="true" onclick="chooseOrder();" data-ajax="false"
                    id="showOrderNo" data-theme="c">请选择</a>
                <div class="clear">
                </div>

                <label class="Field">
                    站位
                </label>
                <select id="selStation" data-mini="true" onchange="getSMTMaterial()">
                    <option value="-1">--请选择--</option>
                </select>
                <div class="clear">
                </div>
                <label for="Print" class="Field">
                    分料打印机
                </label>
                <select id="PDAselPrintersList" data-mini="true" class="perparelist">
                </select>
                <div class="clear">
                </div>
                <label for="Print" name="PDAselPrintersList_Station" class="Field">
                    站位打印机
                </label>
                <select id="PDAselPrintersList_Station" name="PDAselPrintersList_Station" data-mini="true" class="perparelist">
                </select>
            </div>

            <div data-role="panel" id="OrderPanel">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="content" style="padding: 10px 0px;">
                    <ul data-role="listview" id="Orderlistview" data-inset="true" data-filter="true" data-filter-placeholder="搜索"
                        class="listview" style="font-size: 11px;">
                    </ul>
                </div>
            </div>
        </div>
        <div data-role="page" data-url="setpage" class="bindpage" id="searchpage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">站位备料</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar">
                    <ul>
                        <li><a href="#bindpage" data-transition="none" data-theme="c">绑定</a></li>
                        <li><a href="#searchpage" data-transition="none" data-theme="c">备料</a></li>
                    </ul>
                </div>
                <!-- /navbar -->
            </div>

            <div data-role="content">
                <div>
                    <div style="float: left;">
                        <label for="showRes" style="padding-top: 15px; padding-right: 15px;" class="Field">
                            GRN
                        </label>
                    </div>
                    <div style="float: left; width: 70%; padding-right: 15px;">
                        <input type="text" id="txtGRNStation" style="" />
                    </div>
                    <div style="float: left; width: 25%;">
                        <a href="#" id="cancel" class="ui-link ui-btn ui-shadow ui-corner-all ui-mini" onclick="CancelPrepare()">取消备料</a>
                    </div>
                    <div style="float: left;">
                        <label for="showRes" style="padding-top: 15px; padding-right: 15px;" class="Field">
                            库位/储位信息：
                        </label>
                    </div>
                    <div style="float: left;">
                        <label id="cbarCodeInfo" style="padding-top: 15px; padding-right: 15px;" class="Field">
                            
                        </label>
                    </div>
                </div>

                <div data-role="fieldcontain">

                    <div id="msg" style="width: 100%; text-align: center; font-size: 15px; font-weight: bold;">
                    </div>
                    <div class="clear">
                    </div>

                    <div id="testtab" style="margin-top: 20px; position: relative">
                        <table data-role="table" id="datatab" data-mode="" class="ui-responsive table-stroke"
                            style="width: 100%">
                            <thead>
                                <tr>
                                    <th style="width: 6rem;">物料编码</th>
                                    <th style="width: 4.5rem;">需求数量</th>
                                    <th style="width: 4.5rem;">已备数量</th>
                                    <th style="width: 4.5rem;">货位</th>
                                    <th style="width: 4.5rem;">GRN</th>
                                    <th style="width: 4.5rem;">数量</th>
                                    <th style="width: 4.5rem;">状态</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div class="clear">
                    </div>
                    <div id="itemTablediv">
                        <table data-role="table" id="itemTable" data-mode="" class="ui-responsive table-stroke"
                            style="width: 98%">
                            <thead>
                                <tr>
                                    <th style="width: 4.5rem;">区域</th>
                                    <th style="width: 4.5rem;">站位</th>
                                    <th style="width: 6rem;">主料</th>
                                    <th style="width: 6rem;">替换料</th>
                                    <th style="width: 4.5rem;">总数量</th>
                                    <th style="width: 4.5rem;">应发数量</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </div>

        <script type="text/javascript" src="js/jqPaginator.js"></script>
        <script type="text/javascript" src="js/jquery.nicescroll.js"></script>
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.EShelf.js?v=202208170857" type="text/javascript"></script>

        <script type="text/javascript">


            $(function () {

                bindPrinters('PDAselPrintersList', function () {
                    if ($("#PDAselPrintersList").val()) {
                        $("#PDAselPrintersList-button span").text($("#PDAselPrintersList").find("option:selected").text());
                    }
                });

                bindPrinters('PDAselPrintersList_Station', function () {
                    if ($("#PDAselPrintersList_Station").val()) {
                        $("#PDAselPrintersList_Station-button span").text($("#PDAselPrintersList_Station").find("option:selected").text());
                    }
                });

                chooseOrder();

            });

            $(document).bind("mobileinit", function () {
                $.mobile.ajaxEnabled = false;
            });
            var userId = '<% =SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>';
            var userName = '<% =SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var orderNo = "";//工单号

            var LineId;
            var smtStatus;

            var _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            var re = /[`~!@#$^\-&*()=|{}':;',\\\[\]\.<>\/?~！@#￥……&*（）——|{}【】'；：""'。，、？\s]/g; //定义正则表达式
            var eshelf = new EShelf({
                userId: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>",
                userName: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>",
                pluginName: "<%= System.Configuration.ConfigurationManager.AppSettings["EShelfManufacturer"] %>",
                webRoot: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>",
                title: "PDA-站位备料",
            });

            var isEnaleEShelf = "<%= System.Configuration.ConfigurationManager.AppSettings["EnaleEShelf"] %>" == "1";      //是否启用电子货架
            var colorDesc = "绿色";              //入库上架的默认颜色：绿色
            var grnStr = ""; //存储扫描的Grn
            var FLgrnStr = ""; //存储分料截料GRN
            var itemStr = "";
            var cbaCodeList = [];   //亮灯货位信息
            var lightDowncbaList = [];  //所有灭灯库位信息


            $("#btnFilter").on("click", function () {
                $("#Orderlistview").html("");
                var $ul = $(this),
                    value = $.trim($("#OrderPanel input[data-type='search']:eq(0)").val());
                if (value == "") {
                    alert("请输入查询条件");
                    return false;
                }

                $.post("../Handler/SMTLoadingMaterial.ashx?type=GetOrders&OrderNo=" + value, function (data) {
                    var htmlstr = "";
                    var data = JSON.parse(data).data;
                    if (data.length <= 0) {
                        confirmDialog("没有搜索到符合的工单");
                        return;
                    }

                    $('#Orderlistview').html("");
                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='"
                            + data[i].ItemId + "|" + data[i].ItemCode + "|" + data[i].Status + "|" + data[i].BOMId
                            + "' onclick=OrderList(this)>" + data[i].OrderNO + "</li>";
                    }
                    $("#Orderlistview").append(htmlstr);
                    $('#Orderlistview').listview('refresh');
                });
            });

            
            //控制Msg的显示
            function setMsg(s, r) {
                $("#msg").html(s);
                $("#msg").css("color", r);
            }

            function hidePrinter() {
                $("[name='PDAselPrintersList_Material']").hide();
                $("#PDAselPrintersList_Material-button").hide();
            }

            function showPrinter() {
                $("[name='PDAselPrintersList_Material']").show();
                $("#PDAselPrintersList_Material-button").show();
            }

            $("#txtGRNStation").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    scanGRN($.trim($("#txtGRNStation").val()));
                }
            });

            //确认备料
            $("#aSave").on("click", function () { Finish(0); });
            function Finish(ht) {
                //var areainfo = $("#selArea option:selected").val(); //区域
                var stationinfo = $("#selStation option:selected").val();   //站位
                var planOrder = $("#showOrderNo").text();   //排程单
                if (grnStr == "" || grnStr == undefined) {
                    setMsg("请先扫描GRN", "red");
                    return false;
                }

                var releaseMessage = "";
                //var releaseMessage = "工单占用颜色释放失败【" + isEnaleEShelf + "】";
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveStationMaterialPrepar(-1, stationinfo, planOrder, grnStr);

                if (ajax.error != null) {
                    setMsg(ajax.error.Message, "red");
                    return;
                }
                else {

                    if (isEnaleEShelf) {
                        var array = [];

                        $("td[name='cbarcode']").each(function () {
                            array.push($(this).text());
                        });
                        //取消备料灭灯
                        setLightDownList(array);
                        //释放工单颜色
                        //if (!releaseProdOrderLightColor(planOrder)) return;
                        //releaseMessage = "工单颜色占用释放成功";
                    }

                    setMsg("备料成功，数量为：" + ht, "green");

                    //NewFLgrnStr = ajax.value;
                    //if (NewFLgrnStr != "") {
                    //    //执行打印  有分料截料情况下执行打印
                    //    Print();
                    //}
                    //打印完成清空分料截料数据
                    FLgrnStr = "";
                    NewFLgrnStr = "";
                    grnStr = "";
                    $("#datatab tr[name='data']").remove();
                    $("#listno").val("");
                }
            }
            //取消备料
            function CancelPrepare() {
                var code = $("#showOrderNo").text();
                var array = [];

                $("td[name='cbarcode']").each(function () {
                    array.push($(this).text());
                });
                if (isEnaleEShelf && cbaCodeList.length > 0) {
                    //取消备料灭灯
                    setLightDownList(cbaCodeList);
                }
                //释放工单颜色
                //if (!releaseProdOrderLightColor(code) && code != "") return;
                releaseMessage = "取消备料成功";

                code = "";
                cbaCodeList = [];
                FLgrnStr = "";
                NewFLgrnStr = "";
                grnStr = "";
                $("#showOrderNo").text("请选择");
                $("#selStation").empty();
                $("#datatab tbody").empty();
                $("#itemTable tbody").empty();
                $("#listno").val("");
            }

            //释放工单颜色
            function releaseProdOrderLightColor(code) {

                //获取占用得工单颜色
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.GetProdOrderLightColor(code);
                if (ajax.error != null) {
                    setMsg(ajax.error.Message, "red");
                    return false;
                }
                var lightColorConfig = ajax.value;
                if (lightColorConfig) {
                    //工单颜色释放
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.SetInUseProdOrderNoST(lightColorConfig.FunctionId, code, 0);
                    if (ajax.error != null) {
                        setMsg(ajax.error.Message, "red");
                        return false;
                    }
                }
                //清除颜色
                $("#lblLightColor").text("");
                $("#lblLightColor").css("background-color", "#FFFFFF");
                return true;
            }

            //推荐grn
            function bindtable(itemCodeList) {
                setMsg("");
                //var code = $.trim($("#listno").val());
                var code = $("#showOrderNo").text();
                var type = 0;
                //var itemcode = $.trim($("#selItemCode").val());
                var itemcode = "";
                //cbaCodeList = [];
                var positon = $("#selStation option:selected").val();



                //获取数据
                var entity = {};
                entity.type = type;
                entity.code = code;
                entity.username = "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                entity.itemcode = itemcode;
                entity.positon = positon;
                
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspTakeMaterialbyStationGRN2_ST", JSON.stringify(entity));
                if (ajax.error != null) {
                    setMsg(ajax.error.Message, "red");
                    return;
                }
                //var result;
                //$.ajax({
                //    url: "../Handler/SMTLoadingMaterial.ashx?type=TakeMaterialbyStation",
                //    type: "POST",
                //    async: false,
                //    data: { "code": code, "username": userName },
                //    success: function (data) {
                //        result = JSON.parse(data);
                //    },
                //    error: function (e) {
                //        alert(e.error.Message);
                //    }
                //})

                //var listGrnInfo = result.table;
                //var listCloseBarCode = result.table1;
                var result = JSON.parse(ajax.value);
                var listGrnInfoTmp = result.data;
                var listCloseBarCode = result.data1;
                var listGrnInfo = [];

                if (itemCodeList == "" || itemCodeList == undefined) {
                    listGrnInfo = listGrnInfoTmp;
                } else {
                    for (i = 0; i < listGrnInfoTmp.length; i++) {
                        if ((itemCodeList.indexOf(listGrnInfoTmp[i].ItemCode) > -1)) {
                            listGrnInfo.push(listGrnInfoTmp[i]);
                        }
                    }
                }


                //UI
                var str = "";
                var selitemidarry = [];
                var selitemid = "-1";
                for (var i = 0; i < listGrnInfo.length; i++) {
                    if (selitemid != listGrnInfo[i].ItemId) {
                        selitemid = listGrnInfo[i].ItemId;
                        if (selitemidarry.length > 0) {
                            if (selitemidarry.indexOf(selitemid) < 0)
                                selitemidarry.push(selitemid);
                        } else {
                            selitemidarry.push(selitemid);
                        }
                    }
                    if (itemCodeList) {
                        cbaCodeList.push(listGrnInfo[i].cBarCode);
                    }
                    lightDowncbaList.push(listGrnInfo[i].cBarCode);

                    requestId = listGrnInfo[i].ApplyId;
                    //扫描过的GRN背景色亮
                    var index = grnStr.split('|').indexOf(listGrnInfo[i].SerialNumber);
                    if (!listGrnInfo[i].SerialNumber) {
                        str += "<tr name='data' style='background-color:yellow'>";
                    }
                    else if (index > -1) {
                        debugger
                        str += "<tr name='data' style='background-color:#7FFF00'>";
                    }
                    else {
                        str += "<tr name='data'>";
                    }
                    str += "<td><span id='td" + listGrnInfo[i].ItemId + "' requestCount=" + listGrnInfo[i].StockQty + " style='display:none'>" + listGrnInfo[i].StockQty + "</span><span>" + listGrnInfo[i].ItemCode + "</span></td>";
                    str += "<td><span id='qtyn" + listGrnInfo[i].ItemId + "'>" + listGrnInfo[i].NeedQty + "</span></td>";
                    str += "<td><span id='qtyh" + listGrnInfo[i].ItemId + "'>" + listGrnInfo[i].StockQty + "</span></td>";
                    str += "<td name='cbarcode' id='cba" + listGrnInfo[i].cBarCode + "'>" + listGrnInfo[i].cBarCode + "</td>";
                    str += "<td ><span id='td" + listGrnInfo[i].SerialNumber.replace(re, "") + "'>" + listGrnInfo[i].SerialNumber + "</span></td>";
                    str += "<td><span id='qty" + listGrnInfo[i].SerialNumber.replace(re, "") + "' >" + listGrnInfo[i].BalanceQty + "</span></td>";
                    str += "<td>" + listGrnInfo[i].LockCode + "</td><tr/>";
                }
                itemStr = "";
                if (selitemidarry.length > 0) {
                    for (var i = 0; i < selitemidarry.length; i++) {
                        itemStr += selitemidarry[i] + ',';
                    }
                }
                $("#datatab tr[name='data']").remove();
                $("#datatab").append(str);

                //对货位进行排序
                //cbaCodeList = cbaCodeList.sort(function (a, b) {
                //    return b - a;
                //});

                cbaCodeList = cbaCodeList.sort();

                //电子货架灭灯控制
                if (isEnaleEShelf) {
                    var listNoBlinkBarcode = [];
                    var listBlinkBarcode = [];
                    var listDown = [];

                    listBlinkBarcode.push(cbaCodeList[0]);

                    //$.each(listGrnInfo, function (i, o) {
                    //    if (o.cBarCode) {
                    //        if (o.LockCode) {
                    //            return true;
                    //        }
                    //        if (o.Cut == 0) {
                    //            listNoBlinkBarcode.push(o.cBarCode);
                    //        }
                    //        else {
                    //            listBlinkBarcode.push(o.cBarCode);
                    //        }
                    //    }

                    //});
                    $.each(listCloseBarCode, function (i, o) {
                        if (o.cBarCode) {
                            listDown.push(o.cBarCode);
                        }
                    });

                    //关闭非当前物料
                    setLightDownList(listDown);
                    if (listNoBlinkBarcode.length <= 0 && listBlinkBarcode.length <= 0) {
                        return;
                    }
                    //获取工单颜色
                    //var lightColorConfig = null;
                    //lightColorConfig = getProdOrderLightColor(code);
                    //colorDesc = lightColorConfig.ColorDescription
                    //if (!lightColorConfig) return;

                    //点亮当前物料
                    setLightUpList(listBlinkBarcode, listNoBlinkBarcode, colorDesc);

                    $("#cbarCodeInfo").text(listBlinkBarcode[0]);

                    //工单颜色占用
                    //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.SetInUseProdOrderNo(lightColorConfig.FunctionId, code);
                    //if (ajax.error != null) {
                    //    setMsg(ajax.error.Message, "red");
                    //    return;
                    //}
                }


                //修改备料数量
                var listScanItemInfo = [];
                $.each(grnStr.split('|'), function (i, o1) {
                    if (o1) {
                        $.each(listGrnInfo, function (j, o2) {
                            if (o1 == o2.SerialNumber) {
                                //定位物料信息
                                var scanItemInfo = null;
                                $.each(listScanItemInfo, function (k, o3) {
                                    if (o3.ItemId == o2.ItemId) {
                                        scanItemInfo = o3;
                                        return true;
                                    }
                                });
                                if (scanItemInfo) {
                                    scanItemInfo.StockQty = scanItemInfo.StockQty.add(parseFloat(o2.BalanceQty));
                                }
                                else {
                                    listScanItemInfo.push({
                                        ItemId: o2.ItemId,
                                        StockQty: parseFloat(o2.StockQty).add(parseFloat(o2.BalanceQty))
                                    });
                                }
                                return true;
                            }
                        });
                    }
                });
                $.each(listScanItemInfo, function (i, o) {
                    $("#datatab tr").find('#td' + o.ItemId).text(o.StockQty);
                    $("#datatab tr").find('#qtyh' + o.ItemId).text(o.StockQty);
                });

                $("#txtGRNStation").val("");
                $("#txtGRNStation").focus();
            }

            //获取工单颜色
            function getProdOrderLightColor(code) {
                //获取占用得工单颜色
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.GetProdOrderLightColor(code);
                if (ajax.error != null) {
                    setMsg(ajax.error.Message, "red");
                    return null;
                }
                var lightColorConfig = ajax.value;
                if (!lightColorConfig) {
                    //未使用工单颜色
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.GetUsableProdOrderLightColor();
                    if (ajax.error != null) {
                        setMsg(ajax.error.Message, "red");
                        return null;
                    }
                    lightColorConfig = ajax.value;
                    if (!lightColorConfig) {
                        setMsg("工单备料颜色已全部占用", "red");
                        return null;
                    }
                }
                //显示颜色
                $("#lblLightColor").text(lightColorConfig.ColorDescription);
                $("#lblLightColor").css("background-color", eshelf.ConvertToColor(lightColorConfig.ColorDescription));

                return lightColorConfig;
            }

            //扫描grn
            function scanGRN(grn) {

                setMsg("");
                if (grn == "") {
                    setMsg("请扫描GRN", "red");
                    $("#txtGRNStation").focus();
                    return;
                }
                var code = $.trim($("#listno").val());

                var array = [];
                var isEx = 0;


                var itemcode_grn = "";
                var station_grn = "";

                //扫描GRN后传入货位进行对应货位灭灯，并进行扫描GRN记录
                $("#datatab tr").each(function (i, e) {
                    if ($.trim($(e).find("td:eq(4)").text()) == grn) {
                        array.push($.trim($(e).find("td:eq(3)").text()));
                        itemcode_grn = $.trim($(e).find("td:eq(0)").children().eq(1).text());
                        isEx = 1;
                    }
                });

                //获取扫描对应的站位
                $("#itemTable tr").each(function (i, e) {
                    if ($.trim($(e).find("td:eq(2)").text()) == itemcode_grn) {
                        station_grn = $.trim($(e).find("td:eq(1)").text());
                    }
                });

                if (grnStr.indexOf(grn) >= 0) {
                    confirmDialogFocus("该条码已经扫描完成，不能重复扫描!", function () {
                        $("materialcode").focus();
                    });
                    //清空GRN文本框，重新扫描
                    $("#txtGRNStation").val("");
                    $("#txtGRNStation").focus();
                    return false;
                }

                flage = 0; //默认需要遵循先进先出，没有遵循则提示用户
                //校验GRN
                var result = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckGrnMaterialPrepareNew(itemStr, grn, flage, grnStr, 1);
                if (result.error != null) {
                    setMsg(result.error.Message, "red");
                    //清空GRN文本框，重新扫描
                    $("#txtGRNStation").val("");
                    $("#txtGRNStation").focus();
                    return;
                } else {
                    result = result.value;
                    if (isEx == 0)//当扫描的GRN不在推荐列表中，不亮灯
                    {
                        setMsg("当扫描的GRN不在推荐列表中", "red");
                        //清空GRN文本框，重新扫描
                        $("#txtGRNStation").val("");
                        $("#txtGRNStation").focus();
                        return;
                    }


                    cbaCodeList.shift();
                    var listBlinkBarcode = [];
                    var listNoBlinkBarcode = [];
                    listBlinkBarcode.push(cbaCodeList[0]);
                    setLightUpList(listBlinkBarcode, listNoBlinkBarcode, colorDesc);

                    var itcode = result[0].PartId;
                    var ctrl;
                    var appCount = "";
                    var requestCount = "";
                    var balanceQty = result[0].BalanceQty;
                    debugger
                    ctrl = $('#td' + result[0].SerialNumber.replace(re, "")).parent().parent();
                    /*判断扫描数量总和不能大于申请数量*/
                    appCount = $.trim(ctrl.find('#qtyn' + itcode).text().replace("领料申请数量", "")); //申请数量
                    requestCount = $.trim(ctrl.find('#td' + itcode).text().replace("备料数量", "")); //已备料数量

                    //var IssueWay = ajax.value[0].IssueWay; //发料方式： 1.正常发料 2.最小包装发料

                    //产线不允许超发，超发后还继续扫描物料，则报错
                    //if ($('#perparelist option:selected').val() == "2" && IssueWay == "1") {
                    //if (parseFloat(parseFloat(requestCount)) > parseFloat(appCount)) {
                    //    $("#msg").html("备料数量不能大于领料申请数量!").css("color", "red");
                    //    //$("#GRN").val("");
                    //    $("#txtGRNStation").focus();
                    //    $("#txtGRNStation").select();
                    //    return false;
                    //}
                    //}

                    //当前扫描条码加已备数量，超过申请数量，则启用分料截料，记录当前GRN
                    if (parseFloat(appCount) < (parseFloat(requestCount) + balanceQty)) {
                        //需要多少就截多少，例如：申请100个，已扫了20个，当再扫90个时，需截80个出来
                        var FLQty = parseFloat(appCount) - parseFloat(requestCount);
                        FLgrnStr += grn + ":" + FLQty + "_";
                        //var ajaxitem = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetMaterialIsOver(itcode);
                        var ajaxitem;
                        $.ajax({
                            url: _webRoot + "/Handler/SMTLoadingMaterial.ashx?type=GetMaterialIsOver",
                            data: { "itcode": itcode },
                            type: "POST",
                            async: false,
                            success: function (data) {
                                ajaxitem = JSON.parse(data);
                            },
                            error: function (e) {
                                alert(e.error.Message);
                                return false;
                            }
                        });
                        if (!ajaxitem.IsItemOver) {     //数量超了时候，校验是否超发，未勾选超发则分料
                            confirmDialog("<%=Resources.Messages.ConfirmToSplit %>", function () {
                                var ajaxfl = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SplitMaterial(FLQty.toString(), grn);
                                //var list1;
                                //$.ajax({
                                //    url: "../Handler/SMTLoadingMaterial.ashx?type=SplitMaterial",
                                //    data: { "qty": FLQty.toString(), "grn": grn, "username": userName },
                                //    type: "POST",
                                //    async: false,
                                //    success: function (data) {
                                //        list1 = JSON.parse(data);
                                //    },
                                //    error: function (e) {
                                //        alert(e.error.Message);
                                //        return false;
                                //    }
                                //})
                                if (ajaxfl.error != null) {
                                    confirmDialog(ajaxfl.error.Message);
                                    return false;
                                }
                                var list1 = ajaxfl.value;
                                confirmDialog("<%=Resources.Messages.SplitMaterialSuccessed %>", function () {
                                    $("#txtGRNStation").focus();
                                    $("#txtGRNStation").select();
                                });
                                //GetSubGrn(grn, list);
                                NewFLgrnStr = list1[0].DetailContent;
                                PrintMaterial(NewFLgrnStr);
                                $("#msg").html("分料截料成功").css("color", "#7FFF00");
                                var grnArray = NewFLgrnStr.split("|");
                                if (grnArray.length > 1) {
                                    var oldGrn = grnArray[0];
                                    var newGrn = grnArray[1];
                                    grnStr = grnStr.replace(oldGrn, newGrn);
                                }

                                //var s = list.BalanceQty - FLQty + parseFloat(requestCount);
                                $("#qty" + result[0].SerialNumber.replace(re, "")).text(parseFloat(list1[0].BalanceQty));
                                $("#applyedQty" + result[0].ItemCode).text(parseFloat(appCount));
                                $("#qtyh" + itcode).text(parseFloat(appCount));
                                //$("#Qty").html(parseFloat($("#lblGRNQty").html()));
                            });
                        }
                    }

                    grnStr += grn + '|';
                    var ht = parseFloat(parseFloat(requestCount) + parseFloat(balanceQty));
                    $("#datatab tr").find('#td' + itcode).text(ht);
                    $("#datatab tr").find('#qtyh' + itcode).text(ht);

                    if (ht >= parseFloat(appCount)) {
                        $("#selStation option:selected").css("background", "#7FFF00");
                    } else {
                        if (cbaCodeList.length == 0) {
                            var ql = parseFloat(appCount) - ht;
                            alert("【" + ItemCode + "】缺料" + ql + "个，请从电子仓调拨！");
                        }
                    }

                    if (cbaCodeList.length == 0) {
                        Finish(ht);
                    }
                }

                if (isEnaleEShelf) {
                    //取消备料灭灯
                    setLightDownList(array);
                }
                //GRN备料，所在行高亮排前
                var $tr = $('#td' + result[0].SerialNumber.replace(re, "")).parent().parent();
                //$("#datatab tbody tr").removeAttr("style");//移除高亮
                $tr.fadeOut(300).fadeIn(300);//闪动一次
                $("#datatab").prepend($tr);
                $tr.css("background-color", "#7FFF00");
                $("#datatab").table("refresh");
                $(document).scrollTop(200);

                //清空GRN文本框，重新扫描
                $("#txtGRNStation").val("");
                $("#txtGRNStation").focus();

                //站位打印
                //PrintStation(station_grn);
            }

            //选择工单
            function chooseOrder() {
                $("#OrderPanel").panel("open");

                $("#Orderlistview").on("filterablebeforefilter", function (e, data) {
                    //    var $ul = $(this)
                    //    $input = $(data.input)
                    //    value = $input.val();
                    //    if (value && value.length > 2) {
                    //        $.post("../Handler/SMTLoadingMaterial.ashx?type=GetOrderList&PlanOrderNo=" + value, function (data) {
                    //            var htmlstr = "";
                    //            var data = JSON.parse(data);
                    //            $('#Orderlistview').html("");
                    //            for (var i = 0; i < data.length; i++) {
                    //                htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='"
                    //                     + data[i].ItemId + "|" + data[i].ItemCode + "|" + data[i].State + "|" + data[i].LineId + "|" + data[i].ItemName + "|" + data[i].LineName + "| " + data[i].TableDesc + "|" + data[i].StatusDesc
                    //                + "' onclick=OrderList(this)>" + data[i].PlanOrderNo + "</li>";
                    //            }
                    //            $("#Orderlistview").append(htmlstr);
                    //            $('#Orderlistview').listview('refresh');
                    //        });
                    //    }
                });
            }

            //选择工单
            function OrderList(ID) {
                $("#showMachie").html("请选择");
                $("#showOrderNo").html($(ID).html());
                var dataArr = $(ID).attr("id").split("|");
                orderNo = $(ID).html();
                ItemId = dataArr[0];
                ItemCode = dataArr[1];
                smtStatus = dataArr[2];
                LineId = dataArr[3];
                ItemName = dataArr[4];
                $("#fline").html(dataArr[5]);
                $("#fmf").html(dataArr[6]);
                $("#fstatus").html(dataArr[7]);
                if (dataArr[2] == 2) {
                    $("#pull").html("工单暂停");
                } else {
                    $("#pull").html("工单开始");
                }
                $("input[data-type='search']").val("");
                $("#OrderPanel").panel("close");
                //getAreaList();
                getStationList();
                //getSMTMaterial();
                //bindtable("");
            }

            //获取区域列表
            function getAreaList() {
                $("#selArea option:not(:first)").remove();
                var planOrder = $("#showOrderNo").text();
                $.ajax({
                    url: _webRoot + "/Handler/SMTLoadingMaterial.ashx?type=GetAreaListNew",
                    type: "POST",
                    async: false,
                    data: { "linePlanOrder": planOrder },
                    success: function (data) {
                        var opHtml = "";
                        var dataval = eval(data);
                        if (dataval.length > 0) {
                            for (var i = 0; i < dataval.length; i++) {
                                opHtml += "<option value=" + dataval[i] + ">" + dataval[i] + "</option>";
                            }
                            $("#selArea").append(opHtml);
                        }
                    },
                    error: function (data) {
                        alert(data);
                    }
                });
            }

            //获取站位列表
            function getStationList() {
                $("#selStation option:not(:first)").remove();
                var planOrder = $("#showOrderNo").text();
                $.ajax({
                    url: _webRoot + "/Handler/SMTLoadingMaterial.ashx?type=GetStationList",
                    type: "POST",
                    async: false,
                    data: { "linePlanOrder": planOrder },
                    success: function (data) {
                        var opHtml_1 = "";
                        var dataval_1 = eval(data);
                        if (dataval_1.length > 0) {
                            for (var i = 0; i < dataval_1.length; i++) {
                                opHtml_1 += "<option value=" + dataval_1[i] + ">" + dataval_1[i] + "</option>";
                            }
                            $("#selStation").append(opHtml_1);
                        }
                    },
                    error: function (data) {
                        alert(data);
                    }
                });
            }

            function getSMTMaterial() {
                //var areainfo = $("#selArea option:selected").val();
                var stationinfo = $("#selStation option:selected").val();
                var planOrder = $("#showOrderNo").text();
                var itemCodeList = "";
                $.ajax({
                    url: _webRoot + "/Handler/SMTLoadingMaterial.ashx?type=GetSMTMaterial",
                    type: "POST",
                    async: false,
                    data: { "areainfo": -1, "stationinfo": stationinfo, "linePO": planOrder },
                    success: function (data) {
                        var dataval = JSON.parse(data).data;
                        if (dataval.length > 0) {
                            var html = "";
                            $.each(dataval, function (i, o) {
                                itemCodeList += o.PartNumber;
                                var style = "";
                                //if (o.IsCompleted == "是") {
                                //    style = "style='background-color:yellow;' "
                                //}
                                html += "<tr id='tr" + o.PartNumber + o.TotalNum + "' >"
                                    + "<td class='Area'>" + o.Area + "</td>"
                                    + "<td class='Positon'>" + o.Positon + "</td>"
                                    + "<td class='PartNumber'>" + o.PartNumber + "</td>"
                                    + "<td class='ReplaceMaterial'>" + o.ReplaceMaterial + "</td>"
                                    + "<td class='TotalNum'>" + o.TotalNum + "</td>"
                                    + "<td class='ShouldIssue'>" + o.ShouldIssue + "</td>"
                                    + "</tr>";
                            });
                            $("#itemTable tbody").empty().append(html);

                        } else {
                            $("#itemTable tbody").empty();
                        }
                    },
                    error: function (data) {
                        alert(data);
                    }
                });

                //重新选择之后，所有灯都灭，然后清空库位
                setLightDownList(cbaCodeList);
                cbaCodeList = [];

                bindtable(itemCodeList);

            }

            //设置硬件亮灯
            function setLightUpList(listBlinkBarcode, listNoBlinkBarcode, colorDesc) {
                var cells = [];
                var colorCode = eshelf.ConvertToColorCode(colorDesc);
                if (listBlinkBarcode) {
                    $.each(listBlinkBarcode, function (i, o) {
                        cells.push({
                            cellId: o,
                            ledColor: colorCode,
                            isBlink: true,
                        });
                    });
                }
                if (listNoBlinkBarcode) {
                    $.each(listNoBlinkBarcode, function (i, o) {
                        cells.push({
                            cellId: o,
                            ledColor: colorCode,
                            isBlink: false,
                        });
                    });
                }
                if (cells.length == 0) {
                    return true;
                }
                var result = eshelf.LightUpCellLedList(cells);
                if (!result.success) {
                    //setMsg(result.error, "red");
                    return false;
                }
                return true;
            }
            //设置硬件灭灯
            function setLightDownList(listBarcode) {
                var cells = [];
                if (listBarcode) {
                    $.each(listBarcode, function (i, o) {
                        cells.push({
                            cellId: o,
                            ledColor: 0,
                            isBlink: false,
                        });
                    });
                }
                if (cells.length == 0) {
                    return true;
                }
                var result = eshelf.LightUpCellLedList(cells);
                if (!result.success) {
                    //setMsg(result.error, "red");
                    return false;
                }
                return true;
            }

            //打印物料条码
            function PrintMaterial(PrintNewFLgrnStr) {

                var labelDocumentId = -1    //Label文档Id
                var lableTypeQty = 1;       //连板数量
                var printName = "";         //打印机名称
                var labelItemId = -1;    //ItemId
                var labelStationId = -1;    //工位Id
                var labelType = -3;          //标签类型 (-2：SN，-3：GRN)
                var labelSequence = 2;      //标签序号 (1产品，2GRN, 3单号......)
                var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

                var lableArr = null;        //标签信息的SN序列号集合对象
                var SNInfo;                 //当前释放标签的信息集合对象
                var tempatePath = "";       //Lab模板文件路径
                var printCount = 1;
                var labelJsonData = "";

                var grn = PrintNewFLgrnStr;
                if (grn == "" || grn == null || PrintNewFLgrnStr.length == 0) {
                    return;
                }
                var grnArray = grn.split("|");
                SNInfo = {};
                SNInfo.SNList = [];
                SNInfo.ItemList = [];
                for (var i = 0; i < grnArray.length; i++) {
                    var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grnArray[i]);

                    if (ajax1.error != null) {
                        $("#msg").html(ajax1.error.Message).css("color", "red");
                        return false;
                    }
                    if (ajax1.value == null || ajax1.value.SerialNumber == null) {
                        $("#msg").html("无效的GRN或者该GRN对应的Item不存在！").css("color", "red");
                        return false;
                    }

                    try {
                        labelItemId = ajax1.value.PartId;
                        //是否供应商打印调用不同的模板
                        var IsSupper = ajax1.value.IsSuplySerialNumber;
                        if (IsSupper) {
                            labelType = -24; //调用供应商模板
                        }
                        else {
                            labelType = -3;
                        }

                        /***********************************        getDocumentInfo--begin       *********************************/
                        //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                        var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
                        if (ajax2.error == null) {
                            var entity = ajax2.value;
                            labelDocumentId = entity.LabelDocumentId;
                            lableTypeQty = entity.PlateQty;
                            //获取打印机名称值
                            printName = $("#PDAselPrintersList").val();
                            labelPrintWayId = entity.PrintWayId;
                            tempatePath = entity.TemplatePath.replace("\\", "\\\\");

                        }
                        else {
                            $("#msg").html(ajax2.error.Message).css("color", "red");
                            return false;
                        }
                        /***********************************        getDocumentInfo--end       *********************************/

                        //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                        SNInfo.SNList.push(grnArray[i]);
                        SNInfo.ItemList.push(ajax1.value.PartId);
                    }
                    catch (e) {
                        $("#msg").html(e).css("color", "red");
                    }

                }
                /***********************************        PrintLabContent--begin       *********************************/
                try {
                    var printdata = [];
                    printCount = 1;
                    lableArr = SNInfo.SNList;
                    labItemList = SNInfo.ItemList;

                    labelJsonData = "[";
                    for (var i = 0; i < lableArr.length; i++) {
                        var labelStr = lableArr[i];
                        var lablabItem = labItemList[i];
                        var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, lablabItem, -1);

                        if (ajaxLabContent.error == null) {
                            var list = ajaxLabContent.value;
                            if (list.length > 0) {
                                var page = { LabelContent: [] };
                                for (var k = 0; k < list.length; k++) {
                                    page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                                }
                                printdata.push(page);
                            }
                        }
                    }
                    if (printdata.length == 0)
                        return;
                    sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
                } catch (e) {
                    $("#msg").html(e).css("color", "red");
                    return false;
                }
                /***********************************        PrintLabContent--end       *********************************/
            }

            //打印站位
            function PrintStation(Station) {

                var labelDocumentId = -1    //Label文档Id
                var lableTypeQty = 1;       //连板数量
                var printName = "";         //打印机名称
                var labelItemId = -1;    //ItemId
                var labelStationId = -1;    //工位Id
                var labelType = -43;          //标签类型 (-2：SN，-3：GRN)
                var labelSequence = 2;      //标签序号 (1产品，2GRN, 3单号......)
                var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

                var lableArr = null;        //标签信息的SN序列号集合对象
                var SNInfo;                 //当前释放标签的信息集合对象
                var tempatePath = "";       //Lab模板文件路径
                var printCount = 1;
                var labelJsonData = "";
                SNInfo = {};
                SNInfo.SNList = [Station];
                SNInfo.ItemList = [-1];

                try {
                    /***********************************        getDocumentInfo--begin       *********************************/
                    //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                    var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
                    if (ajax2.error == null) {
                        var entity = ajax2.value;
                        labelDocumentId = entity.LabelDocumentId;
                        lableTypeQty = entity.PlateQty;
                        //获取打印机名称值
                        printName = $("#PDAselPrintersList").val();
                        labelPrintWayId = entity.PrintWayId;
                        tempatePath = entity.TemplatePath.replace("\\", "\\\\");

                    }
                    else {
                        $("#msg").html(ajax2.error.Message).css("color", "red");
                        return false;
                    }
                    /***********************************        getDocumentInfo--end       *********************************/

                    //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                    //SNInfo.SNList.push(grnArray[i]);
                    //SNInfo.ItemList.push(-1);

                    var printdata = [];
                    printCount = 1;
                    lableArr = SNInfo.SNList;
                    labItemList = SNInfo.ItemList;

                    labelJsonData = "[";
                    for (var i = 0; i < lableArr.length; i++) {
                        var labelStr = lableArr[i];
                        var lablabItem = labItemList[i];
                        var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, lablabItem, -1);

                        if (ajaxLabContent.error == null) {
                            var list = ajaxLabContent.value;
                            if (list.length > 0) {
                                var page = { LabelContent: [] };
                                for (var k = 0; k < list.length; k++) {
                                    page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                                }
                                printdata.push(page);
                            }
                        }
                    }
                    if (printdata.length == 0)
                        return;
                    sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
                }
                catch (e) {
                    $("#msg").html(e).css("color", "red");
                    return false;
                }
            }


            //浮点型加法运算
            Number.prototype.add = function (val) {
                var len = getPointLen(this, val);
                return ((this * len) + (val * len)) / len;
            }

            //浮点型减法运算
            Number.prototype.subtract = function (val) {
                var len = getPointLen(this, val);
                return ((this * len) - (val * len)) / len;
            }

            //获取小数点最大长度
            function getPointLen(val1, val2) {
                var len1, len2;
                try {
                    len1 = val1.toString().split(".")[1].length;
                } catch (e) {
                    len1 = 0;
                }
                try {
                    len2 = val2.toString().split(".")[1].length;
                } catch (e) {
                    len2 = 0;
                }
                return Math.pow(10, Math.max(len1, len2));
            }

        </script>


    </form>
</body>
