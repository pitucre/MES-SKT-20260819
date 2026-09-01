<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDAMaterialDeliver.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAMaterialDeliver" %>

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
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <title>生成送货单</title>
    <style type="text/css">
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

        img {
            -webkit-filter: grayscale(100%);
            -moz-filter: grayscale(100%);
            -ms-filter: grayscale(100%);
            -o-filter: grayscale(100%);
            filter: grayscale(100%);
            filter: gray;
        }

        .ui-title {
            line-height: 30px;
        }
        .popedomBtn {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" id="pageone">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">生成送货单</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table width="100%">
                    <tr>
                        <td style="width: 110px;">
                            <label>采购订单</label>
                        </td>
                        <td>
                            <input type="text" id="txtBuyNO" class="TextBox" runat="server" clientidmode="Static" />

                            <input type="hidden" value="" id="hdnBuyNO" runat="server" clientidmode="Static" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择采购订单</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>供应商</label>
                        </td>
                        <td colspan="2">
                            <input type="hidden" value="" id="htnVender" />
                            <asp:Label ID="lblVendorCode" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                        <td>&nbsp;
                        </td>
                        <td>&nbsp;
                        </td>
                    </tr>
                    <tr class="popedomBtn">
                        <td>
                            <label>自动添加送货物料明细</label>
                        </td>
                        <td colspan="2">
                            <input id="cbShowALL" type="checkbox" class="text" onchange="cbClick()" />
                        </td>
                    </tr>
<%--                    <tr>
                        <td>&nbsp;
                        </td>
                        <td>&nbsp;
                        </td>
                        <td>&nbsp;
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <label for="perparelist">操作</label>
                        </td>
                        <td colspan="2">
                            <select name="rblAddDeleteType" data-mini="true" id="rblAddDeleteType" data-role="slider" onchange="SelectChange()">
                                <option value="2">移除</option>
                                <option value="1" selected="selected">增加</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>物料条码/包装箱条码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" value="" id="txtGRN" class="TextBox" style="width: 200px; height: 25px; text-transform: uppercase; font-size: 12px; font-weight: bold;" />
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                        <td>&nbsp;
                        </td>
                        <td>&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>备注</label>
                        </td>
                        <td colspan="2">
                            <input type="text" value="" id="txtRemark" class="TextBox" style="width: 98%; height: 25px; font-size: 12px; font-weight: bold; text-transform: uppercase;" />
                        </td>
                    </tr>
                </table>
                <br />

                <div id="msg" style="text-align: center"></div>

                <div style="margin-top: 5px">
                    <strong>送货单明细</strong>
                    <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px; text-align: center;">
                        <tr class="ListTableHeader">
                            <th style="width: 7%">行号
                            </th>
                            <th style="width: 18%">采购单
                            </th>
                            <th style="width: 20%">物料编码
                            </th>
                            <th style="width: 15%">数量
                            </th>
                            <th style="width: 7%">操作
                            </th>
                        </tr>
                        <tr id="trNewInfo" class="ListTableOddRow">
                            <td colspan="5" style="text-align: center;">暂无数据
                            </td>
                        </tr>
                    </table>
                </div>
                <%--<div style="margin-top: 5px">
               <strong>送货物料明细</strong>
               <table id="tblRec" class="row-border stripe" width="100%" style="line-height: 28px;text-align: center;">
                <tr class="ListTableHeader">
                    <th style="width: 15%">采购单号
                    </th>
                    <th style="width: 12%">物料条码
                    </th>
                    <th style="width: 10%">数量
                    </th>
                    <th style="width: 10%">操作
                    </th>
                </tr>
                <tr id="trNewInfo1" class="ListTableOddRow">
                    <td colspan="4" style="text-align: center;">暂无数据
                    </td>
                </tr>
              </table>
           </div>--%>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtn" data-theme="a" value="确认生成" /></li>
                    </ul>
                </div>
            </div>


            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选采购订单</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="采购订单号"
                        data-theme="c" class="listview">
                </div>
            </div>


        </div>
        <input type="hidden" value="" id="hdnCartonSN" />
        <input type="hidden" value="" id="hdnVendorCode" />
        <input class="TextBox" id="hidtxt" style="display: none;" />
        <script type="text/javascript">
            var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            var OrderList = []; //采购单送货细项列表
            var GRNList = []; //送货GRN细项列表
            var NewGRNList = []; //送货GRN新细项列表(用于验证数量)
            var Vender = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType %>";
            var txtBuyNO = "";
            var IsSupplierPeriod = 2;//供应商是否交期维护：1：需要 2：不需要 默认不需要
            var limitType = -2;//限制送货单中采购单类型，委外单不能和采购通放在同一送货单

            /*JS检查用户是否具有某一权限*/
            function IsHasPermission(userId_int, popedom_int) {
                return SKT.LeanMES.Web.AjaxServices.AjaxClient.IsPermission(userId_int, popedom_int).value;
            }

            $(function () {
                showIsSuppler();
                $("#divPackScanCode").hide();
                $(".ui-body-c").css("background", "#fff");
                if (IsHasPermission(userId, 11400602)) {
                    $(".popedomBtn").show();
                }
                //$(document).ready(function () {

                //});

                //showRecDtl(0);
                $("#txtBuyNO").keydown(function (event) {
                    var e = event || window.event
                    if (e && e.keyCode == 13) {
                        if ($.trim($("#txtBuyNO").val()) != "") {
                            //回车只显示GRN信息   
                            buyOrder = $.trim($("#txtBuyNO").val());
                            //showBuyOrderList(buyOrder,"P",'',2);
                            txtBuyNO = $.trim($("#txtBuyNO").val());
                            if (scanPoCode(buyOrder)) {
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                $("#txtGRN").select();
                            }
                        }
                        return false;
                    }
                });

                /*扫描条码*/
                $("#txtGRN").keydown(function () {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        if ($.trim($("#txtGRN").val()) != "") {
                            //判断操作
                            var type = $("#rblAddDeleteType :checked").val();
                            if (type == 1) {//增加
                                //第一次扫描，如果采购单为空时
                                //if (OrderList.length <= 0 || $.trim($("#txtBuyNO").val()) == "") {
                                //查询GRN对应的采购单
                                //if (!GetPOCode($.trim($("#txtGRN").val()))) {
                                //    return false;
                                //}

                                //}
                                showBuyGrn($.trim($("#txtGRN").val()), "G", $.trim($("#htnVender").val()));
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                $("#txtGRN").select();
                                return true;
                            }
                            if (type == 2) {//移除
                                DeleteBuyGrn($.trim($("#txtGRN").val()), "G", $.trim($("#htnVender").val()));
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                $("#txtGRN").select();
                                return true;
                            }

                        } else {
                            //alert("请扫描GRN！");
                            $("#msg").html("请扫描GRN！");
                            $("#msg").css("color", "red");
                            $("#txtGRN").val("");
                            $("#txtGRN").focus();
                            $("#txtGRN").select();
                            return false;
                        }
                    }
                });


                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");




                //回车包装
                //$("#txtGRN").keydown(function (event) {

                //});



                //筛选
                $("#btnFilter").on("click", function () {
                    $("#listviews").html("");
                    var $ul = $(this),
                    value = $.trim($("input[data-type='search']:eq(0)").val());
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetShowOrderPDA(103, Vender, IsSupplierPeriod, value);
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message);
                        $("#msg").css("color", "red");
                        $("#txtBuyNO").focus();
                        return false;
                    }

                    var entity = ajax.value;
                    if (entity.error != null) {
                        confirmDialogFocus(entity.error, function () {
                            $("#txtBuyNO").focus();
                        });
                        return false;
                    };
                    var ulhtml = "";
                    for (var i = 0; i < entity.length; i++) {
                        if (ulhtml.indexOf(entity[i].POCode) == -1) {
                            ulhtml += '<li class="ui-btn ui-btn-icon-right ui-icon-carat-r"><a onclick="SetPOCode(this)" style="font-size:80%;">' + entity[i].POCode + '</a></li>';
                        }
                    }
                    $("#listviews").html(ulhtml);
                    $("#listviews").listview("refresh");
                });
                $("#Savebtn").on("click", function () {
                    Save();
                });
            });
            function showIsSuppler() {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(6);
                if (ajax.error == null) {
                    var entity = $.parseJSON(ajax.value).data[0];
                    IsSupplierPeriod = entity.ChoosePageId;
                }
            }
            //根据GRN查采购单
            function GetPOCode(grn) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitPoCode(grn);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                var data = ajax.value;
                var count = 0;
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        buyOrder = $.trim(data[i].PoCode);
                        txtBuyNO = $.trim(data[i].PoCode);
                        scanPoCode(data[i].PoCode);
                        $("#txtBuyNO").val(data[i].PoCode);
                        $("#hdnBuyNO").val(data[i].PoCode);
                        count = count + 1;
                    }
                    if (count > 0) {
                        return true;
                    }
                    else {
                        $("#msg").html("条码无效或者查无采购单！");
                        $("#msg").css("color", "red");
                        $("#txtGRN").val("");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                        return false;
                    }
                }
                else {
                    $("#msg").html("条码无效或者查无采购单！");
                    $("#msg").css("color", "red");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                    return false;
                }
            }

            //点击全选
            function cbClick() {
                var po = $.trim($("#txtBuyNO").val());
                if (!po) {
                    $("#msg").html("请选择采购单！").css("color", "red");
                    return false;
                }
                showBuyOrderList(po, "P", "", 1);
            }

            function SetPOCode(Code) {
                //alert($(Code).html());
                var pocodeString = $(Code).html();
                scanPoCode(pocodeString);
                txtBuyNO = pocodeString;
                $("#txtBuyNO").val(pocodeString);
                $("#hdnBuyNO").val(pocodeString);
                $("input[data-type='search']").val('');
                $("#listviews").html('');
                $("#fpanel").panel("close");
            }

            function scanPoCode(pocode) {
                if (pocode == "") {
                    $("#msg").html("采购单不能为空！");
                    $("#msg").css("color", "red");
                    return false;
                }
                var entity = {};
                entity.POCode = pocode;
                entity.UserName = userName;
                entity.POType = limitType;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetPoCodeInfo", JSON.stringify(entity));
                if (ajax.error != null) {
                    //alert(ajax.error.Message);
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }

                var entity = JSON.parse(ajax.value).data;
                limitType = entity[0].POType;

                if (entity.length == 0) {
                    //alert("未找到采购单[" + pocode + "]所需送货信息！");
                    $("#msg").html("未找到采购单[" + pocode + "]所需送货信息！");
                    $("#msg").css("color", "red");
                    $("#txtBuyNO").select();
                    return false;
                }

                if ($("#htnVender").val() != "" && $("#htnVender").val() != entity[0].VendorCode) {
                    //alert("只能选择同一家供应商的采购单");
                    if (window.confirm("选择采购单的供应商与当前采购单的供应商不相同,将会刷掉你之前操作的送货单内容，你确定要继续选择它？！")) {
                        Clear();
                    }
                    else {
                        return;
                    }
                }

                //$("#txtBuyNO").val(list[0][1]);
                $("#hdnBuyNO").val(pocode);
                $("#<%=this.lblVendorCode.ClientID %>").text(entity[0].VendorCode + "  " + entity[0].VendorName);
            $("#htnVender").val(entity[0].VendorCode);
            showBuyOrderList(pocode, "P", "", 2);

            return true;

        }

        //验证数量
        function QtySum(Glist) {
            //GRN采购单：Glist[i].POCode
            //GRN数量：Glist[i].BalanceQty
            //物料：Glist[i].ItemCode
            var Olist = OrderList;
            //采购单:Olist[i].POCode
            //扫描数量：Olist[i].SentQty
            //总数量：Olist[i].BuyQty
            //物料：Olist[i].ItemCode
            var POCode = "";
            var ItemCode = "";
            var GRNQty = 0;

            var OSentQty = 0;
            var OBuyQty = 0;

            if (Glist.length > 0) {
                for (var i = 0; i < Glist.length; i++) {
                    POCode = Glist[i].POCode;
                    ItemCode = Glist[i].ItemCode;
                    GRNQty += parseFloat(Glist[i].BalanceQty);
                }
            }
            if (Olist.length > 0) {
                for (var i = 0; i < Olist.length; i++) {
                    if (Olist[i].ItemCode == ItemCode) {//Olist[i].POCode == POCode && 
                        OSentQty += parseFloat(Olist[i].SentQty);
                        OBuyQty += parseFloat(Olist[i].BuyQty);
                    }
                }
            }
            var allSUMQTY = parseFloat(GRNQty) + parseFloat(OSentQty);
            if (parseFloat(allSUMQTY) > parseFloat(OBuyQty)) {
                //$("#msg").html("采购单【" + POCode + "】物料【" + ItemCode + "】所扫描的条码数量【" + GRNQty + "】加上已经扫描数【" + OSentQty + "】【" + allSUMQTY + "】大于采购单物料所需要的数据【" + OBuyQty + "】");
                $("#msg").html("扫描的【" + $.trim($("#txtGRN").val()) + "】条码总数【" + GRNQty + "】不能大于送货需求总数" + OBuyQty + "！");
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                $("#txtGRN").val("");
                $("#txtGRN").focus().select();
                return false;
            }
            else {
                return true;
            }

        }

        //扫描条码显示记录
        function showBuyGrn(buyOrder, type) {
            $("#msg").html("");
            var bExists = false;
            if (buyOrder == "" || OrderList.length <= 0) {
                $("#msg").html("请选择采购单后再扫描条码！");
                $("#msg").css("color", "red");
                $("#txtBuyNO").focus();
                return false;
            }

            //修改该验证方式
            for (var i = 0; i < GRNList.length; i++) {
                if (buyOrder == GRNList[i].GRN) {
                    //alert("条码在列表中存在,不需要重复扫描！");
                    $("#msg").html("条码已扫描,不需要重复扫描！");
                    $("#msg").css("color", "red");
                    $("#txtGRN").val("");
                    return false;
                }
            }

            var pocodes = "";
            for (var i = 0; i < OrderList.length; i++) {
                if (pocodes.indexOf(OrderList[i].POCode + ",") < 0) {
                    pocodes = pocodes + OrderList[i].POCode + ",";
                }
            }
            var cbShowAll = document.getElementById("cbShowALL").checked;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.GetDeliverInfo(buyOrder, type, $("#htnVender").val(), pocodes, cbShowAll);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            var data = $.parseJSON(ajax.value).data;


            for (var i = 0; i < GRNList.length; i++) {
                if (data[0].GRN == GRNList[i].GRN) {
                    //alert("条码在列表中存在,不需要重复扫描！");
                    $("#msg").html("条码已扫描,不需要重复扫描！");
                    $("#msg").css("color", "red");
                    $("#txtGRN").val("");
                    return false;
                }
            }



            var OrderListTemp = [];
            var index = -1;

            OrderListTemp.push({});
            //判断是否存在
            for (i = 0; i < data.length; i++) {
                for (var k = 0; k < OrderList.length; k++) {
                    if (OrderList[k].POCode == data[i].POCode && OrderList[k].RowID == data[i].RowID) {
                        if (index == -1)
                            index = k;
                        break;
                    }
                }

            }
            if (index == -1) {
                //alert("物料条码所属物料行在当前送货单明细列表中不存在！");
                $("#msg").html("物料条码所属物料行在当前送货单明细列表中不存在！");
                $("#msg").css("color", "red");
                return false;
            }



            //判断数量
            NewGRNList = [];
            //添加GRN新列表
            $.grep(data, function (e, i) {
                var arr = $.grep(GRNList, function (o, j) {
                    return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                });
                if (arr.length == 0) {
                    NewGRNList.push(e);
                }
            });
            if (!QtySum(NewGRNList)) {
                NewGRNList = [];
                return;
            }
            NewGRNList = [];
            //判断数量



            var pocodestring = "";
            var grntype = 1;
            //按PO和PoLineId合并data的数量到采购单
            for (i = 0; i < data.length; i++) {
                for (var k = 0; k < OrderList.length; k++) {
                    if (OrderList[k].POCode == data[i].POCode && OrderList[k].RowID == data[i].RowID) {
                        pocodestring = data[i].POCode;
                        OrderList[k].SentQty = parseFloat(OrderList[k].SentQty) * 1 + parseFloat(data[i].BalanceQty) * 1;
                    }
                }
            }
            OrderListTemp = OrderList;

            var entity = OrderListTemp.splice(index, 1);
            OrderListTemp.splice(0, 0, entity[0]);

            OrderList = OrderListTemp;

            if (data.length > 1) {
                grntype = 2;
            }
            //添加GRN列表
            $.grep(data, function (e, i) {
                var arr = $.grep(GRNList, function (o, j) {
                    return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                });
                if (arr.length == 0) {
                    GRNList.push(e);
                }
            });

            ShowOrderList();

            ShowGRNList();
            if (type == "G") {
                if (grntype == 2) {
                    $("#msg").html("采购单号【" + pocodestring + "】包装箱条码【" + buyOrder + "】扫描成功！");
                    $("#msg").css("color", "green");
                }
                else {
                    $("#msg").html("采购单号【" + pocodestring + "】物料条码【" + buyOrder + "】扫描成功！");
                    $("#msg").css("color", "green");
                }
            }
        }

        //移除条码
        function DeleteBuyGrn(buyOrder, type) {
            $("#msg").html("");
            var bExists = false;
            var pocodes = "";
            for (var i = 0; i < OrderList.length; i++) {
                if (pocodes.indexOf(OrderList[i].POCode + ",") < 0) {
                    pocodes = pocodes + OrderList[i].POCode + ",";
                }
            }
            var cbShowAll = document.getElementById("cbShowALL").checked;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.GetDeliverInfo(buyOrder, type, $("#htnVender").val(), pocodes, cbShowAll);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            var data = $.parseJSON(ajax.value).data;

            bExists = false;
            for (var i = 0; i < GRNList.length; i++) {
                if (data[0].GRN == GRNList[i].GRN) {
                    bExists = true;
                }
            }
            if (!bExists) {
                $("#msg").html("条码未扫描,不需要移除操作！");
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                return false;
            }

            var OrderListTemp = [];
            var index = -1;

            OrderListTemp.push({});
            //按PO和PoLineId合并data的数量到采购单
            for (i = 0; i < data.length; i++) {
                for (var k = 0; k < OrderList.length; k++) {
                    if (OrderList[k].POCode == data[i].POCode && OrderList[k].RowID == data[i].RowID) {
                        OrderList[k].SentQty = parseFloat(OrderList[k].SentQty) * 1 - parseFloat(data[i].BalanceQty) * 1;
                        if (index == -1)
                            index = k;
                        break;
                    }
                }

            }
            if (index == -1) {
                //alert("物料条码所属物料行在当前送货单明细列表中不存在！");
                $("#msg").html("物料条码所属物料行在当前送货单明细列表中不存在！");
                $("#msg").css("color", "red");
                return false;
            }
            OrderListTemp = OrderList;

            var entity = OrderListTemp.splice(index, 1);
            OrderListTemp.splice(0, 0, entity[0]);

            OrderList = OrderListTemp;


            //移除GRN列表
            $.grep(data, function (e, i) {
                var arr = $.grep(GRNList, function (o, j) {
                    return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                });
                if (arr.length > 0) {
                    deleteByGrn(e.GRN);
                }
            });

            ShowOrderList();

            ShowGRNList();
        }

        function SelectChange() {
            $("#txtGRN").val("");
            $("#txtGRN").focus().select();
        }

        //显示采购单数量
        function showBuyOrderList(buyOrder, type, code, number) {
            $("#msg").html("");
            var cbShowAll = document.getElementById("cbShowALL").checked;
            var pocodes = "";
            for (var i = 0; i < OrderList.length; i++) {
                if (pocodes.indexOf(OrderList[i].POCode + ",") < 0) {
                    pocodes = pocodes + OrderList[i].POCode + ",";
                }
            }
            if (pocodes.indexOf(buyOrder) < 0) {
                pocodes = pocodes + buyOrder;
            }
            txtBuyNO = buyOrder;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.GetDeliverInfo(buyOrder, type, $.trim($("#htnVender").val()), pocodes, cbShowAll);
            if (ajax.error != null) {
                //处理自动添加送货物料明细
                if (cbShowAll) {
                    $("#cbShowALL").prop("checked", false);
                }
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            var data = $.parseJSON(ajax.value).data;
            var data1 = $.parseJSON(ajax.value).data1;

            var Copylist = [];
            $.extend(Copylist, OrderList);
            OrderList = [];

            var haveList = [];

            //添加送货项列表
            $.grep(data, function (e, i) {
                e.SpareQty = 0;//备品数量
                e.PackingDetail = "";
                OrderList.push(e);
                haveList.push(e);
            });
            //添加送货项列表
            $.grep(Copylist, function (e, i) {
                var arr = $.grep(OrderList, function (o, j) {
                    //return e.POCode == o.POCode && e.ItemCode == o.ItemCode;   BirongLiang 增加如下ROWID
                    return e.POCode === o.POCode && e.ItemCode === o.ItemCode && e.RowID === o.RowID;
                });

                if (arr.length == 0) {
                    OrderList.push(e);
                }
            });

            //重新计算
            if (document.getElementById("cbShowALL").checked == false && number == 2) {
                for (var i = 0; i < GRNList.length; i++) {
                    for (var k = 0; k < OrderList.length; k++) {
                        if (OrderList[k].POCode == GRNList[i].POCode && OrderList[k].RowID == GRNList[i].RowID) {
                            OrderList[k].SentQty = parseFloat(OrderList[k].SentQty) * 1 + parseFloat(GRNList[i].BalanceQty) * 1;
                        }
                    }
                }
            }
            if (document.getElementById("cbShowALL").checked == false && number == 1) {
                GRNList = [];
            }

            ShowOrderList();

            //GRNList = [];
            if (document.getElementById("cbShowALL").checked) {

                //判断数量
                NewGRNList = [];
                //添加GRN新列表
                $.grep(data, function (e, i) {
                    var arr = $.grep(GRNList, function (o, j) {
                        return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                    });
                    if (arr.length == 0) {
                        NewGRNList.push(e);
                    }
                });
                if (!QtySum(NewGRNList)) {
                    NewGRNList = [];
                    return;
                }
                NewGRNList = [];
                //判断数量




                //添加GRN列表
                $.grep(data1, function (e, i) {
                    var arr = $.grep(GRNList, function (o, j) {
                        return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                    });
                    if (arr.length == 0) {
                        GRNList.push(e);
                    }
                });
            }

            ShowGRNList();

            if (type == "P") {
                if (haveList.length <= 0) {
                    $("#msg").html("采购单号【" + buyOrder + "】已全部送完货！");
                    $("#msg").css("color", "red");
                }
                else {
                    $("#msg").html("采购单号【" + buyOrder + "】扫描成功！");
                    $("#msg").css("color", "green");
                }
            }
        }

        //删除送货项
        function del(i) {
            var grns = "";
            //获取改物料GRN列表
            var arr = $.grep(GRNList, function (e, j) {
                grns = grns + e.GRN + ",";
                return e.POCode == OrderList[i].POCode && e.ItemCode == OrderList[i].ItemCode && e.RowID == OrderList[i].RowID;
            }, true);

            //增加验证采购订单行下物料的包装箱
            var pocode = OrderList[i].POCode;
            var rowid = OrderList[i].RowID;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.checkPOLineCanDel(pocode, rowid, grns);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                //alert(ajax.error.Message);
                return false;
            }

            GRNList = arr;

            OrderList.splice(i, 1);
            ShowOrderList();
            if (OrderList.length == 0) {
                Clear();
            }
            ShowGRNList();
        }




        //删除Grn项
        function deleteGrn(obj) {
            var grn = $("#tblRecRowID" + obj + "").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.checkGrnCanRemove(grn);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                //alert(ajax.error.Message);
                return false;
            }

            var data = {};
            for (var i = 0; i < GRNList.length; i++) {
                if (GRNList[i].GRN == grn) {
                    data = GRNList[i];
                    GRNList.splice(i, 1);
                    break;
                }
            }

            //按PO和PoLineId合并data的数量到采购单
            for (var k = 0; k < OrderList.length; k++) {
                if (OrderList[k].POCode == data.POCode && OrderList[k].RowID == data.RowID) {
                    OrderList[k].SentQty = parseFloat(OrderList[k].SentQty) * 1 - parseFloat(data.BalanceQty) * 1;
                    break;
                }
            }

            ShowOrderList();

            ShowGRNList();
        }

        //移除Grn项
        function deleteByGrn(grn) {
            var data = {};
            for (var i = 0; i < GRNList.length; i++) {
                if (GRNList[i].GRN == grn) {
                    data = GRNList[i];
                    GRNList.splice(i, 1);
                    break;
                }
            }
            ShowGRNList();
        }

        //显示送货单细项
        function ShowOrderList() {
            if (OrderList != null && OrderList.length > 0) {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel;
                for (var i = 0; i < OrderList.length; i++) {
                    //强制转型 BirongLiang 2017-3-27
                    //OrderList[i].SentQty = Math.floor(OrderList[i].SentQty);
                    //OrderList[i].AScanQty = Math.floor(OrderList[i].AScanQty);
                    // 
                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = i + 1;
                    cel.innerHTML += "<input type='hidden' id='RowID" + i + "' value='" + OrderList[i].RowID + "' name='RowId' POCode=" + OrderList[i].POCode + "/>";

                    cel = row.insertCell(1);
                    cel.innerHTML = OrderList[i].POCode;
                    cel.id = 'tdPoCode' + i;

                    cel = row.insertCell(2);
                    cel.innerHTML = OrderList[i].ItemCode;
                    cel.id = 'tdInvCode' + i;


                    cel = row.insertCell(3);
                    cel.innerHTML = parseFloat(OrderList[i].SentQty).toString() + "/" + parseFloat(OrderList[i].BuyQty).toString();

                    cel = row.insertCell(4);
                    cel.innerHTML += "<a href='#' onclick='del(" + i + ")'>删除 </a>";

                }
            }
            else {
                $("#txtRemark").val("");
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#tbBuyOrderDetail tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="9" align="center"><font color="red">没有送货项！</font></td></tr>');
            }
        }

        //显示GRN细项
        function ShowGRNList() {
            showRecDtl(1);
        }

        function showRecDtl(doclean) {
            //var dataSet = []; //数据源
            //if (doclean) { //清空，绑定表格
            //    $("#tblRec tr:gt(0)").remove();
            //}

            ////绑定列表
            //if (GRNList != null && GRNList.length > 0) {
            //    var tableList = document.getElementById("tblRec");
            //    var row, cel;
            //    for (var i = 0; i < GRNList.length; i++) {
            //        row = tableList.insertRow(i + 1);

            //        cel = row.insertCell(0);
            //        cel.innerHTML = GRNList[i].POCode;
            //        cel.innerHTML += "<input type='hidden' id='tblRecRowID" + i + "' value='" + GRNList[i].GRN + "' name='tblRecRowId' POCode=" + GRNList[i].POCode + "/>";
            //        cel.id = 'tblRectdPoCode' + i;

            //        cel = row.insertCell(1);
            //        cel.innerHTML = GRNList[i].GRN;
            //        cel.id = 'tblRectdGRNCode' + i;

            //        cel = row.insertCell(2);
            //        cel.innerHTML = parseFloat(GRNList[i].BalanceQty).toString();

            //        cel = row.insertCell(3);
            //        cel.innerHTML += "<a href='#' onclick='deleteGrn(" + i + ")'>删除 </a>";

            //    }
            //}

        }

        //生成送货单
        function Save() {
            if (OrderList.length == 0) {
                //alert("请添加送货项!");
                $("#msg").html("请添加送货项!");
                $("#msg").css("color", "red");
                return false;
            }
            confirmDialog('确定生成送货单?', function () {
                //addby zj 2019年9月5日 修改生成送货单报错报格式错误
                for (var i = 0; i < OrderList.length; i++) {
                    if (OrderList[i].SentQty === '0.000' || OrderList[i].SentQty === '0.000000') {
                        OrderList[i].SentQty = '0';
                    }
                }
                var re = /^[0-9]*[0-9][0-9]*$/;
                if (re.test(OrderList[0].BuyQty)) {
                    OrderList[0].BuyQty = OrderList[0].BuyQty.toFixed(6);
                }
                if (re.test(OrderList[0].SentQty)) {
                    OrderList[0].SentQty = OrderList[0].SentQty.toFixed(6);
                }
                if (re.test(OrderList[0].SpareQty)) {
                    OrderList[0].SpareQty = OrderList[0].SpareQty.toFixed(6);
                }
                if (re.test(GRNList[0].BalanceQty)) {
                    GRNList[0].BalanceQty = GRNList[0].BalanceQty.toFixed(6);
                }

                var entity = {};
                entity.DeliverId = -1;
                entity.VenderNo = $("#htnVender").val();
                entity.Remark = $.trim($("#txtRemark").val());
                entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
                entity.tbDtl = JSON.stringify(OrderList);
                entity.tbGRNDtl = JSON.stringify(GRNList);

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.SaveDeliverToPDA(JSON.stringify(entity));
                if (ajax.error != null) {
                    //alert(ajax.error.Message);
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                $("#msg").html("送货单生成成功，请到电脑端打印！");
                $("#msg").css("color", "green");
                //alert("送货单生成成功，请到电脑端打印！");
                Clear();
            });
        }

        function Clear() {
            OrderList = [];
            GRNList = [];
            ShowOrderList();
            ShowGRNList();
            $("#htnVender").val("");
            $("#txtGRN").val("");
            $("#<%=this.lblVendorCode.ClientID %>").text("");
            $("#txtBuyNO").val("");
            $("#hdnBuyNO").val("");
            $("#tblShippingReport tbody").html("");
            $("#txtRemark").val("");
            $("#msg").html("");

        }

        function isPositiveNum(obj) {//是否为正整数
            var s = $(obj).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(s)) {
                //alert("请输入正整数！");
                $("#msg").html("请输入正整数！");
                $("#msg").css("color", "red");
                $(obj).val(0);
                $(obj).focus();
            }
        }
        </script>
    </form>
</body>
</html>


