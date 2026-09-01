<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialWhReturnToPDA.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MaterialWhReturnToPDA" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-9" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" href="css/bootstrap.min.css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">

    <title>生产退料入库</title>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }

        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }

        .ui-title { line-height: 30px; }
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false;">
        <div data-role="header" data-position="fixed">
            <h5 style="padding: 4px; margin: 0px;">
                <div>
                    <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">生产退料入库</label>
                </div>
            </h5>
            <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>
        </div>
        <div data-role="content">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <label for="listno">
                            退料单</label>
                    </td>
                    <td>
                        <input type="text" id="listno" />
                    </td>
                    <td>
                        <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择退料单</a>
                    </td>
                </tr>
                <tr id="trBarCode">
                    <td>
                        <label for="txtBarCode">
                            库位</label>
                    </td>
                    <td colspan="2">
                        <input id="txtBarCode" type="text" value="" />
                        <p style="color: black;">库位提示：<asp:Label ID="lblstation" runat="server" Text=""></asp:Label></p>
                    </td>
                </tr>
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
                <tr id="trGRN">
                    <td>
                        <label for="GRN">
                            GRN</label>
                    </td>
                    <td colspan="2">
                        <input id="GRN" type="text" value="" />
                    </td>
                </tr>
            </table>
            <div id="msg" style="text-align: center; font-size: 15px; font-weight: bold;"></div>
            <div id="testtab" style="margin-top: 3px; position: relative">
                <table data-role="table" id="instocktable" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%; overflow-x: scroll; overflow-y: scroll;">
                    <thead>
                        <tr>
                            <th>物料编码
                            </th>
                            <th>物料名称
                            </th>
                            <th>需退料数
                            </th>
                            <th>退料数量
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div style="margin-top: 12px">
                <table id="tblExpand" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%; overflow-x: scroll; overflow-y: scroll;">
                    <thead>
                        <tr>
                            <th>GRN</th>
                            <th>退料数量</th>
                            <th>入库库位</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="a">
            <div data-role="navbar" data-theme="none">
                <ul>
                    <li><a data-corners="false" onclick="Save()" data-role="button" data-fullscreen="true" data-theme="a">退料完成</a></li>
                </ul>
            </div>
        </div>
        <div data-role="panel" id="fpanel" data-display="overlay">
             <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
            <div data-role="main" data-theme="a" class="ui-content">
                <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                    data-theme="c" class="listview">
            </div>
        </div>

    </form>
    <script type="text/javascript">
        var arrGrn = [];
        var prodOrder = "";
        var GRN = "";
        var grnQty = 0;
        var userName = "";
        userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';//中文名
        $(document).bind("mobileinit", function () {
            $.mobile.ajaxEnabled = false;
        });

        //聚焦 失焦事件
        $(function () {
            $(".ui-body-c").css("background", "#fff");
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#listno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
            $("#listno").focus();
            //扫描退料单
            $('#listno').on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($(this).val()) == "") {
                        $("#msg").html("退料单不能为空！").css("color", "red");
                        $(this).val('').focus();
                        return false;
                    }
                    $("#infotab tbody").html('');
                    prodOrder = $.trim($(this).val());
                    if (prodOrder == "") {
                        $("#msg").html("退料单输入错误！").css("color", "red");
                        confirmDialogFocus(ajax.error.Message, function () {
                            $(this).val('').focus();
                        });
                    }
                    Select(prodOrder);
                    $("#txtBarCode").focus();
                    //检查是否存在正在入库的
                    var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SelectReturnToWarehouseDtlTempHave($.trim($("#listno").val()));
                    if (data.error != null) {
                        $("#msg").html(data.error.Message).css("color", "red");
                        return false;
                    }
                    else {
                        var havedata = data.value;
                        if (havedata.length > 0) {
                            if (userName != havedata[0].PRWDTUesrName) {
                                $("#msg").html("单据【" + $.trim($("#listno").val()) + "】存在未完成的生产退料入库-正在入库用户【" + havedata[0].PRWDTUesrName + "】").css("color", "red");
                                return false;
                            }
                        }
                    }

                    //转换单据，清空当前用户暂存
                    var delajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.DeleteReturnToWarehouseDtlTemp();
                    if (delajax.error != null) {
                        $("#msg").html(delajax.error.Message).css("color", "red");
                        return false;
                    }
                }
            });
            setTimeout(function () {
                BindMaterialData();//检测
            }, 100);

            //筛选退料单号
            $("#btnFilter").on("click", function () {
                var val = $.trim($("#fpanel input[data-type='search']").first().val());
                searchReturnOrder(val);
            });
        });


        //根据字符串模糊查询采购单
        $("#listviews").on("filterablebeforefilter", function (e, data) {
            var val = $(data.input).val();
            if (!val || val.length <= 2) {
                return false;
            }
            searchReturnOrder(val);
        });


        //搜索、筛选退料单号
        function searchReturnOrder(returnOrderNo) {
            $("#listviews").html("");
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetReturnOrder();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetReturnOrderNo(returnOrderNo);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }

            var entity = ajax.value;
            if (entity.error != null) {
                confirmDialogFocus(entity.error, function () {
                    $("#listno").focus();
                });
            };
            var ulhtml = "";
            for (var i = 0; i < entity.length; i++) {
                if (ulhtml.indexOf(entity[i].ReturnOrderNo) == -1) {
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].ReturnOrderNo + "</a></li>";
                }
            }
            $("#listviews").append(ulhtml);
            $("#listviews").listview("refresh");
        }


        function SetPOCode(Code) {
            prodOrder = $(Code).html();
            Select(prodOrder);
            $("#listno").val(prodOrder);


            //检查是否存在正在入库的
            var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SelectReturnToWarehouseDtlTempHave($.trim($("#listno").val()));
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            else {
                var havedata = data.value;
                if (havedata.length > 0) {
                    if (userName != havedata[0].PRWDTUesrName) {
                        $("#msg").html("单据【" + $.trim($("#listno").val()) + "】存在未完成的生产退料入库-正在入库用户【" + havedata[0].PRWDTUesrName + "】").css("color", "red");
                        return false;
                    }
                }
            }

            //转换单据，清空当前用户暂存
            var delajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.DeleteReturnToWarehouseDtlTemp();
            if (delajax.error != null) {
                $("#msg").html(delajax.error.Message).css("color", "red");
                return false;
            }
            $("#txtBarCode").focus();
            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#fpanel").panel("close");
        }


        //GRN，数量回车事件
        $("#GRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                if ($("#listno").val() === "") {
                    $("#listno").focus();
                    $("#GRN").val("");
                    $("#msg").html("请选择退料单！").css("color", "red");
                    return false;
                }
                GRN = $.trim($("#GRN").val());
                GetCbarcodeListbyNo(GRN);//库位提示


                if ($.trim($("#txtBarCode").val()).toUpperCase() != "") {
                    var type = $("#rblAddDeleteType :checked").val();
                    if (type == 1) {
                        if (!checkWhCodeExist($.trim($("#txtBarCode").val()).toUpperCase())) {
                            $("#msg").html("不存在此库位！").css("color", "red");
                            $("#txtBarCode").focus();
                            $("#txtBarCode").select();
                            return false;
                        }
                        if (GRN != "") {
                           
                            //检查是否可退
                            var grnResult = checkGrn($.trim($("#GRN").val())) || false;
                            if (grnResult) {
                                //校验产品唯一
                                if (grnResult[0]) {
                                    if (!verifyProductOnly($.trim($("#txtBarCode").val()), grnResult[0].SerialNumber)) return false;
                                }
                                //
                                if (!showGrnList(grnResult)) {
                                    return false;
                                }
                            }
                            else {
                                return false;
                            }

                        } else {
                            confirmDialogFocus("请输入GRN!", function () {
                                $("#GRN").val('').focus();
                            });
                            return false;
                        }
                        $("#GRN").val("");
                        $("#msg").html("GRN扫描成功!").css("color", "green");
                        $("#GRN").focus();
                    }
                    if (type == 2) {
                        if (GRN != "") {
                            //检查是否可退
                            var grnResult = checkGrn($.trim($("#GRN").val())) || false;
                            if (grnResult) {
                                if (!deleteGrnList(grnResult)) {
                                    return false;
                                }
                            }
                            else {
                                return false;
                            }

                        } else {
                            confirmDialogFocus("请输入GRN!", function () {
                                $("#GRN").val('').focus();
                            });
                            return false;
                        }
                        $("#GRN").val("");
                        $("#msg").html("GRN移除成功!").css("color", "green");
                        $("#GRN").focus();
                    }
                }
                else {
                    var type1 = $("#rblAddDeleteType :checked").val();
                    if (type1 == 1) {
                        $("#msg").html("请先扫描库位条码！").css("color", "red");
                        $("#txtBarCode").val("");
                        $("#txtBarCode").focus();
                        $("#GRN").val("");
                        return false;
                    }
                    if (type1 == 2) {
                        if (GRN != "") {
                            //检查是否可退
                            var grnResult = checkGrn($.trim($("#GRN").val())) || false;
                            if (grnResult) {
                                if (!deleteGrnList(grnResult)) {
                                    return false;
                                }
                            }
                            else {
                                return false;
                            }

                        } else {
                            confirmDialogFocus("请输入GRN!", function () {
                                $("#GRN").val('').focus();
                            });
                            return false;
                        }
                        $("#GRN").val("");
                        $("#msg").html("GRN移除成功!").css("color", "green");
                        $("#GRN").focus();
                    }

                }
            }
        });
        //库位条码回车
        $("#txtBarCode").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                if ($("#listno").val() === "") {
                    $("#listno").focus();
                    $("#txtBarCode").val("");
                    $("#msg").html("请选择退料单！").css("color", "red");
                    return false;
                }
                if (!checkWhCodeExist($.trim($("#txtBarCode").val()).toUpperCase())) {
                    $("#msg").html("不存在此库位！").css("color", "red");
                    $("#txtBarCode").focus();
                    $("#txtBarCode").select();
                    return false;
                }
                //校验产品唯一
                if (!verifyProductOnly($.trim($("#txtBarCode").val()))) return false;
                //
                $("#GRN").val("");
                $("#msg").html("扫描库位成功!").css("color", "green");
                //$("#txtBarCode").select();
                $("#GRN").focus();
            }
        });





        //未完成‘生产退料入库’ 物料
        function BindMaterialData() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SelectReturnToWarehouseDtlTemp();
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
            else {
                var data = ajax.value;
                if (data.length > 0) {
                    if (confirm("先前有未完成‘生产退料入库’，是否继续？")) {
                        $("#listno").val(data[0].PRWDTReturnOrder);
                        //$("#txtBarCode").val(data[0].PRWDTMSDTstation);
                        BindGDataOrder(data[0].PRWDTReturnOrder);
                        for (var i = 0; i < data.length; i++) {
                            BindGrnData(data[i].PRWDTSerialNumber, data[0].PRWDTMSDTstation);
                        }
                    }
                    else {
                        var delajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.DeleteReturnToWarehouseDtlTemp();
                        if (delajax.error != null) {
                            $("#msg").html(delajax.error.Message).css("color", "red");
                            return false;
                        }
                    }
                }
            }
        }
        function BindGDataOrder(order) {
            Select(order);
        }
        function BindGrnData(grn, BarCode) {
            //检查是否可退
            var grnResult = checkGrn(grn) || false;
            if (grnResult) {
                if (!showGrnListNoAdd(grnResult, BarCode)) {
                    return false;
                }
            }
            else {
                return false;
            }
        }

        function SelectChange() {
            $("#GRN").select();
        }

        function showGrnList(list) {
            if (!list[0]) return false;
            //验证是否重复扫描
            if (checkGrnExist(list[0].SerialNumber, list[0].ERPReBillID) === true) {
                $("#GRN").select();
                $("#msg").html("GRN重复扫描！").css("color", "red");
                return false;
            }
            if (AddupdateReQty(list[0].ItemId, list[0].BalanceQty, list[0].SerialNumber) == false) {
                return false;
            }
            //arrGrn.push(list[0].SerialNumber + ":" + list[0].ERPReBillID);
            arrGrn.push(list[0].SerialNumber);
            var addHtml = "<tr grn ='" + list[0].SerialNumber + "'><td>" + list[0].SerialNumber + "</td><td>" + list[0].BalanceQty + "</td><td>" + $.trim($("#txtBarCode").val()).toUpperCase() + "</td></tr>";
            $("#tblExpand").append(addHtml);
            //更新已扫描数量
            GetCbarcodeListbyNo(list[0].SerialNumber);//库位提示


            //临时保存扫描的Grn
            var ajaxGrn = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveReturnToWarehouseDtlTemp($.trim($("#listno").val()), list[0].SerialNumber, $.trim($("#txtBarCode").val()).toUpperCase());
            if (ajaxGrn.error != null) {
                $("#msg").html(ajaxGrn.error.Message).css("color", "red");
                return false;
            }
            //临时保存扫描的Grn
            return true;
        }
        function deleteGrnList(list) {
            if (!list[0]) return false;
            //验证是否重复扫描
            if (!checkGrnExist(list[0].SerialNumber, list[0].ERPReBillID)) {
                $("#GRN").select();
                $("#msg").html("移除的GRN不存在！").css("color", "red");
                return false;
            }
            if (deleteReQty(list[0].ItemId, list[0].BalanceQty, list[0].SerialNumber) == false) {
                return false;
            }
            deleteGrnExist(list[0].SerialNumber, list[0].ERPReBillID);//移除GRN

            //清空表
            $("#tblExpand tr:gt(0)").remove();

            //移除保存扫描的Grn
            var ajaxGrn = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.DeleteReturnToWarehouseDtlTempGRN($.trim($("#listno").val()), list[0].SerialNumber);
            if (ajaxGrn.error != null) {
                $("#msg").html(ajaxGrn.error.Message).css("color", "red");
                return false;
            }
            var resData = ajaxGrn.value;
            //移除保存扫描的Grn

            //重新加载表
            for (var i = 0; i < resData.length; i++) {
                var addHtml = "<tr grn ='" + resData[i].PRWDTSerialNumber + "'><td>" + resData[i].PRWDTSerialNumber + "</td><td>" + resData[i].BalanceQty + "</td><td>" + resData[i].PRWDTMSDTstation + "</td></tr>";
                $("#tblExpand").append(addHtml);
            }
            return true;
        }
        function showGrnListNoAdd(list, BarCode) {
            if (!list[0]) return false;
            //验证是否重复扫描
            if (checkGrnExist(list[0].SerialNumber, list[0].ERPReBillID) === true) {
                $("#GRN").select();
                $("#msg").html("GRN重复扫描！").css("color", "red");
                return false;
            }
            updateReQty(list[0].ItemId, list[0].BalanceQty);
            //arrGrn.push(list[0].SerialNumber + ":" + list[0].ERPReBillID);
            arrGrn.push(list[0].SerialNumber);
            var addHtml = "<tr grn ='" + list[0].SerialNumber + "'><td>" + list[0].SerialNumber + "</td><td>" + list[0].BalanceQty + "</td><td>" + BarCode + "</td></tr>";
            $("#tblExpand").append(addHtml);
            //更新已扫描数量
            GetCbarcodeListbyNo(list[0].SerialNumber);//库位提示
        }
        function AddupdateReQty(ItemId, BalanceQty, SerialNumber) {
            //页面显示，根据物料
            var $tr = $('#' + ItemId).parent();
            var a = parseFloat($tr.find("span").html());//数量
            var b = parseFloat(BalanceQty);//GRN数量
            var c = parseFloat($tr.find("em").html());//数量

            if (a + b > c) {
                $("#GRN").select();
                $("#msg").html("此GRN【" + SerialNumber + "】的数量【" + b + "】+退料数量【" + a + "】已经大于需退料数【" + c + "】，不能再扫了！").css("color", "red");
                return false;
            }
            $tr.find("span:eq(0)").html(a + b); //入库数量 
            $("#instocktable tbody tr").removeAttr("style");//移除高亮
            $tr.fadeOut(300).fadeIn(300);//闪动一次
            $("#instocktable").prepend($tr);
            $tr.css("background-color", "#7FFF00");
            $("#instocktable").table("refresh");
            return true;
        }
        function updateReQty(ItemId, BalanceQty) {
            //页面显示，根据物料
            var $tr = $('#' + ItemId).parent();
            var a = parseFloat($tr.find("span").html());//数量
            var b = parseFloat(BalanceQty);//GRN数量
            var c = parseFloat($tr.find("em").html());//数量
            $tr.find("span:eq(0)").html(a + b); //入库数量 
            $("#instocktable tbody tr").removeAttr("style");//移除高亮
            $tr.fadeOut(300).fadeIn(300);//闪动一次
            $("#instocktable").prepend($tr);
            $tr.css("background-color", "#7FFF00");
            $("#instocktable").table("refresh");
        }

        function deleteReQty(ItemId, BalanceQty) {
            //页面显示，根据物料
            var $tr = $('#' + ItemId).parent();
            var a = parseFloat($tr.find("span").html());//数量
            var b = parseFloat(BalanceQty);//GRN数量
            var c = parseFloat($tr.find("em").html());//数量
            $tr.find("span:eq(0)").html(a - b); //入库数量 
            $("#instocktable tbody tr").removeAttr("style");//移除高亮
            $tr.fadeOut(300).fadeIn(300);//闪动一次
            $("#instocktable").prepend($tr);
            $tr.css("background-color", "#7FFF00");
            $("#instocktable").table("refresh");
        }

        //验证仓库
        function checkWhCodeExist(barcode) {
            var exist = false;
            if (barcode.trim() === '') return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(barcode);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
            var en = $.parseJSON(ajax.value);
            if (en.BarCode) {
                exist = true;
            }
            return exist;
        }

        //库位提示
        function GetCbarcodeListbyNo(Grn) {
            var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetCbarcodeListbyGrn(Grn);
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            $("#<%=this.lblstation.ClientID%>").text(data.value);
        }

        //验证库位
        function checkBarCode() {
            var wh = $.trim($("#txtBarCode").val()).toUpperCase();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(wh);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
            var en = $.parseJSON(ajax.value);
            if (!en.BarCode) {
                $("#msg").html("库位条码不存在！").css("color", "red");
                $("#txtBarCode").val("");
                $("#txtBarCode").focus();
                $("#txtBarCode").select();
                return false;
            }
            return true;
        }

        //扫描Grn是否重复
        function checkGrnExist(grn, ERPRecordsAutoID) {
            var exist = false;
            for (var i = 0; i < arrGrn.length; i++) {
                //if (arrGrn[i] == grn + ":" + ERPRecordsAutoID) {
                if (arrGrn[i] == grn) {
                    exist = true;
                }
            }
            return exist;
        }
        //移转GRN
        function deleteGrnExist(grn, ERPRecordsAutoID) {
            var newGrn = [];
            for (var i = 0; i < arrGrn.length; i++) {
                //if (arrGrn[i] != grn + ":" + ERPRecordsAutoID) {
                if (arrGrn[i] != grn) {
                    newGrn.push(arrGrn[i]);
                }
            }
            arrGrn = [];
            for (var j = 0; j < newGrn.length; j++) {
                arrGrn.push(newGrn[j]);
            }
        }
        //扫描GRN，检查GRN
        function checkGrn(grn) {
            var returnOrder = $.trim($("#listno").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckGrnRTWPDA(returnOrder, grn);
            if (ajax.value === '') return false;
            if (ajax.error != null) {
                $("#GRN").focus();
                $("#GRN").select();
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
            var grnResult = JSON.parse(ajax.value);
            return grnResult;
        }
        function Select(ReturnOrderNo) {
            $("#msg").html('');
            $("#instocktable tr:gt(0)").remove();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SelectMaterialWhReturnByNo(ReturnOrderNo);
            if (ajax.error != null) {
                $("#listno").focus();
                $("#listno").select();
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            else {
                var entity = ajax.value;
                var htmlstr = "<tr>";
                if (entity.length <= 0) {
                    $("#msg").html("单据不包含可生产退料入库信息").css("color", "red");
                    $("#instocktable tr:gt(0)").remove();
                    $("#instocktable tbody").append('<tr class="ListTableOddRow" ><td colspan="10" style="text-align: center;"><font color="red">暂无数据</font></td></tr>');
                    $("#instocktable").table("refresh");
                }
                for (var i = 0; i < entity.length; i++) {
                    htmlstr += "<td id='" + entity[i].ItemID + "'>" + entity[i].ItemCode + "</td>"
                        + "<td>" + entity[i].ItemName + "<input class='ERPReBillID' type='text' style='display:none' value='" + entity[i].ERPReBillID + "'></input></td>"
                        + "<td><em id='ReturnQty'>" + entity[i].ReturnQty + "</em></td>"
                        + "<td><span  id='qty'>" + entity[i].ReceiveQty + "</span> </td>"
                        + "</tr>"
                }
                $("#instocktable tbody").append(htmlstr);
                $("#instocktable").table("refresh");
                $("#txtBarCode").focus();
            }
        }

        function Save() {
            confirmDialog("确认退料入库完成?", function () {
                if (arrGrn.length === 0) {                    
                    $("#msg").html("请扫描要退的GRN！").css("color", "red");
                    return false;
                }
                //if (!checkBarCode()) {
                //    return;
                //}
                var qtyLimit = true;
                $("#instocktable tr:gt(0)").each(function () {
                    var QtyALL = $(this).find("td").eq(2).text(); //总数
                    var Qty = $(this).find("td").eq(3).text(); //数量
                    if (QtyALL * 1 < Qty * 1) {
                        qtyLimit = false;
                    }
                });
                if (qtyLimit === false) {
                    $("#msg").html("存在 退料数量超出需退料数，不能进行生产退料入库！").css("color", "red");
                    return false;
                }
                //校验产品唯一
                if (!verifyProductOnly($.trim($("#txtBarCode").val()))) return false;
                //
                var strGrns = arrGrn.join(",");
                var returnNo = $.trim($("#listno").val());
                var cBarcode = $.trim($("#txtBarCode").val()).toUpperCase();
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveRTWPDA(returnNo, strGrns, cBarcode);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                $("#msg").html("退料成功!").css("color", "green");
                clearInfo();
                $("#tblExpand tr:gt(0)").remove();
                $("#instocktable tr:gt(0)").remove();
                $("#<%=this.lblstation.ClientID%>").text("");
            });
        }

        //清空数据
        function clearInfo() {
            arrGrn = [];
            prodOrder = "";
            $("#listno").val("");
            $("#txtBarCode").val("");
            $("#GRN").val("");
            $("#<%=this.lblstation.ClientID%>").text('');
            setTimeout(function () { $("#listno").focus(); }, 100);

        }

        //校验货位产品唯一
        function verifyProductOnly(cBarCode,grn) {
            var list = arrGrn;
            var array = [];
            //当前扫描的GRN
            if (grn) {
                array.push(grn);
            }
            //去重
            if (list && list.length > 0) {
                for (var i = 0; i < list.length; i++) {
                    if (array.indexOf(list[i]) === -1) {
                        array.push(list[i]);
                    }
                }
            }
            //校验
            if (array.length > 0) {
                if (array.length == 1) {
                    var result = isItemCanPlacedInWarehouseLocation(array[0], "", cBarCode);
                    if (result == -1) {
                        return false;
                    }
                    if (result == 0) {
                        $("#msg").html("当前库位不支持存放多种产品，请扫描其他库位！").css("color", "red");
                        $("#txtBarCode").val("").focus();
                        return false;
                    }
                }
                else {
                    var isProductOnly = isItemCanPlacedInWarehouseLocation("", "", cBarCode);
                    if (isProductOnly == -1) {
                        return false;
                    }
                    if (isProductOnly == 1) {
                        $("#msg").html("当前库位不支持存放多种产品，请扫描其他库位！").css("color", "red");
                        $("#txtBarCode").val("").focus();
                        return false;
                    }
                }
            }
            return true;
        }

        //判断产品是否能放入当前库位
        function isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                return -1;
            }
            return ajax.value ? 1 : 0;
        }

        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }
    </script>
</body>
</html>

