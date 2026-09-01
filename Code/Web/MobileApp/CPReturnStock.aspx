<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CPReturnStock.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.CPReturnStock" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>成品退货</title>
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }

        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }
        .ui-title { line-height: 30px; }
        div.ui-body-c { background-color: #fff; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #fff">成品退货</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%; z-index: 2">
                    <tr>
                        <td>
                            <label for="txtSaleReturnNo">
                                退货单号</label>
                        </td>
                        <td>
                            <input id="txtSaleReturnNo" data-corners="false" type="text" data-mini="true"
                                value="" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" style="" onclick="getSaleReturnOrder()">选择单据</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>客户名称</label></td>
                        <td colspan="2">
                            <label id="CustomerName"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>库位</label></td>
                        <td colspan="2">
                            <input id="CBarCode" type="text" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="#myPopup" id="scanType" data-rel="popup" class="ui-link-inherit" data-position-to="window">GRN</a>
                        </td>
                        <td colspan="2">
                            <input class="status" id="txtSN" data-corners="false" type="text" data-mini="true" value="" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <div style="margin-top: 3px">
                    <div>
                        <strong>退货单明细</strong>
                    </div>
                    <table data-role="table" id="saleReturnDetail" data-mode="columntoggle:none" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>行号
                                </th>
                                <th>产品编码
                                </th>
                                <th>退货数量
                                </th>
                                <th>已退数量
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <div style="margin-top: 15px;">
                        <strong>扫描明细</strong>
                    </div>
                    <table data-role="table" id="saleReturnSN" data-mode="columntoggle:none" class="ui-responsive table-stroke" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>条码
                                </th>
                                <th>产品编码
                                </th>
                                <th>数量
                                </th>
                                <th>操作
                                </th>
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
                        <li><a class="StartCheck" onclick="Save()" data-corners="false" data-role="button"
                            data-fullscreen="true" data-theme="a">保存</a></li>
                    </ul>
                </div>
            </div>

            <div data-role="popup" id="myPopup" style="min-width: 220px" data-theme="f">
                <div class="ui-controlgroup-controls" data-theme="f">
                    <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(-1)">GRN</a>
                    <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(0)">SN</a>
                    <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(3)">客户SN</a>
                    <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(1)">卡通箱</a>
                    <a href="#" data-theme="f" data-role="button" onclick="chooseScanType(2)">栈板</a>
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
        </div>

        <script type="text/javascript">
            var scanType = -1; //扫描类型
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            $(document).ready(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $(".ui-body-c").css("background", "#fff");
                $("#txtSaleReturnNo,#txtSN,#CBarCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });

                //扫描退货单事件
                $("#txtSaleReturnNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        getSaleReturnNoDetailInfo(null, 0);
                    }
                });

                //输入退货单号并进行筛选
                $("#listviews").on("filterablebeforefilter", function (e, data) {
                    var val = $(data.input).val();
                    if (!val || val.length <= 2) {
                        return false;
                    }
                    searchSaleReturnNo(val);
                });

                //筛选退货单号
                $("#btnFilter").on("click", function () {
                    var val = $.trim($("#fpanel input[data-type='search']").first().val());
                    searchSaleReturnNo(val);
                });

                //库位扫描
                $("#CBarCode").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        showMsg("", 1);
                        var cBarCode = $.trim($("#CBarCode").val());
                        if (cBarCode == "") {
                            showMsg("请扫描库位条码", 0);
                            $("#CBarCode").val("").focus();
                            return false;
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(cBarCode);
                        if (ajax.error != null) {
                            showMsg(ajax.error.Message, 0);
                            $("#CBarCode").val("").focus();
                            return false;
                        }
                        var en = $.parseJSON(ajax.value);
                        if (!en.BarCode) {
                            showMsg("库位条码不存在", 0);
                            $("#CBarCode").val("").focus();
                            return false;
                        }
                        $("#txtSN").val("").focus();
                    }
                });

                //扫描条码事件
                $("#txtSN").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        showMsg("", 1);
                        //扫描
                        var saleReturnNo = $.trim($("#txtSaleReturnNo").val());
                        if (saleReturnNo == "" || $("#saleReturnDetail tbody tr").length <= 0) {
                            showMsg("请扫描退货单号", 0);
                            $("#txtSaleReturnNo").val("").focus();
                            return;
                        }
                        var cBarCode = $.trim($("#CBarCode").val());
                        if (cBarCode == "") {
                            showMsg("请扫描库位", 0);
                            $("#CBarCode").val("").focus();
                            return false;
                        }
                        var sn = $.trim($("#txtSN").val());
                        if (sn == "") {
                            showMsg("请扫描条码", 0);
                            $("#txtSN").val("").focus();
                            return false;
                        }
                        var entity =
                        {
                            SaleReturnNo: saleReturnNo,
                            BarCode: sn,
                            ScanType: scanType,
                            CBarCode: cBarCode,
                        };
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.SaleReturnScanSN(entity);
                        if (ajax.error != null) {
                            showMsg(ajax.error.Message, 0);
                            $("#txtSN").val("").focus();
                            return false;
                        }

                        //刷新退货明细信息
                        getSaleReturnDtlList(saleReturnNo);

                        var list = ajax.value;
                        var hl = appendScanSN(list);
                        $("#saleReturnSN tbody").prepend(hl);

                        showMsg("扫描成功", 1);

                        $("#txtSN").val("").focus();
                    }
                });

                //删除条码
                $("#saleReturnSN tbody").on("click", "a.delete-sn", function () {
                    showMsg("", 1);

                    var obj = $(this);
                    var sn = obj.attr("BarCode");
                    var saleReturnNo = obj.attr("SaleReturnNo");
                    var entity =
                    {
                        SaleReturnNo: saleReturnNo,
                        BarCode: sn,
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.SaleReturnDeleteSN(entity);
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message, 0);
                        return false;
                    }
                    getSaleReturnDtlList(saleReturnNo);
                    //删除行
                    $("#saleReturnSN tbody td a.delete-sn[BarCode=\"" + sn + "\"]").closest("tr").remove();

                    showMsg('删除成功！', 1);
                });

                $("#txtSaleReturnNo").focus();
            });

            //搜索、筛选退货单号
            function searchSaleReturnNo(saleReturnNo) {
                $("#listviews").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnList({ SaleReturnNo: saleReturnNo,CreateBy:userName });
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtSaleReturnNo").val("").focus();
                    return false;
                }
                var list = ajax.value;
                var ulhtml = "";
                for (var i = 0; i < list.length; i++) {
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getSaleReturnNoDetailInfo(" + (JSON.stringify(list[i])) + ",1)'>" + list[i].SaleReturnNo + "</a></li>";
                }
                $("#listviews").html(ulhtml);
                $("#listviews").listview("refresh");
            }

            //获取退货单明细信息  type 0：扫描 1：选择单据
            function getSaleReturnNoDetailInfo(entity, type) {
                showMsg("", 1);
                if (type == 0) {
                    //扫描
                    var saleReturnNo = $.trim($("#txtSaleReturnNo").val());
                    if (saleReturnNo == "") {
                        showMsg("请输入退货单号", 0);
                        $("#txtSaleReturnNo").val("").focus();
                        return;
                    }
                    //根据送货单信息加载供应商信息
                    
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnInfo({ SaleReturnNo: saleReturnNo, CreateBy: userName });
                    if (ajax.error != null) {
                        showMsg(ajax.error.Message, 0);
                        $("#txtSaleReturnNo").val("").focus();
                        return false;
                    }
                    //带出供应商名称
                    entity = ajax.value;
                    if (!entity || !entity.SaleReturnNo) {
                        showMsg("退货单号[" + saleReturnNo + "]不存在或已退货完成", 0);
                        $("#txtSaleReturnNo").val("").focus();
                        return false;
                    }
                } else {
                    //选择单据后，获取换货明细信息
                    $("#txtSaleReturnNo").val(entity.SaleReturnNo);
                    $("input[data-type='search']").val('');
                    $("#listviews").html('');
                    $("#fpanel").panel("close");
                    $("#txtSN").focus();
                }
                $("#CustomerName").text(entity.CustomerName);
                getSaleReturnDtlList(entity.SaleReturnNo);
                getSaleReturnScanList(entity.SaleReturnNo);
                $("#CBarCode").focus();
            }

            //获取退货物料信息
            function getSaleReturnDtlList(saleReturnNo) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnDetail({ SaleReturnNo: saleReturnNo });
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtSaleReturnNo").val("").focus();
                    return false;
                }
                var list = ajax.value;
                var hl = "";
                if (list) {
                    for (var i = 0; i < list.length; i++) {
                        hl += "<tr class=\"return-dtl\" item-code=\"" + list[i].ItemCode + "\">" +
                            "<td>" + list[i].SaleReturnRowId + "</td>" +
                            "<td>" + list[i].ItemCode + "</td>" +//<td>" + list[i].ItemName + "</td>
                            "<td class=\"saleReturnQty\" SaleReturnQty=\"" + list[i].SaleReturnQty + "\">" + list[i].SaleReturnQty + "</td>" +
                            "<td class=\"currentReturnQty\" CurrentReturnQty=\"" + list[i].CurrentReturnQty + "\">" + list[i].CurrentReturnQty + "</td>" +
                            "</tr>";
                    }
                }
                $("#saleReturnDetail tbody").html(hl);
            }

            //获取已扫描的条码
            function getSaleReturnScanList(saleReturnNo) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnScanList({ SaleReturnNo: saleReturnNo });
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return false;
                }
                var list = ajax.value;
                var hl = appendScanSN(list);
                $("#saleReturnSN tbody").html(hl);
            }

            //拼接HTML
            function appendScanSN(list) {
                var hl = "";
                if (list != null) {
                    for (var i = 0; i < list.length; i++) {
                        hl += "<tr>" +
                            "<td>" + list[i].BarCode + "</td>" +
                            "<td>" + list[i].ItemCode + "</td>" +
                            "<td>" + list[i].Qty + "</td>" +
                            "<td><a href=\"javascript:void(0)\" class=\"delete-sn\" SaleReturnNo=\"" + list[i].SaleReturnNo + "\" BarCode=\"" + list[i].BarCode + "\">删除</a></td>" +
                            "</tr>";
                    }
                }
                return hl;
            }

            //保存
            function Save() {
                showMsg("", 1);
                //扫描
                var saleReturnNo = $.trim($("#txtSaleReturnNo").val());
                if (saleReturnNo == "" || $("#saleReturnDetail tbody tr").length <= 0) {
                    showMsg("请扫描退货单号", 0);
                    $("#txtSaleReturnNo").val("").focus();
                    return;
                }
                if ($("#saleReturnSN tbody tr").length <= 0) {
                    showMsg("请扫描条码", 0);
                    $("#txtSN").val("").focus();
                    return;
                }
                //保存
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.SaleReturnSave({ SaleReturnNo: saleReturnNo });
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    $("#txtSN").val("").focus();
                    return false;
                }

                $("#txtSaleReturnNo").val("");
                $("#CustomerName").text("");
                $("#CBarCode").val("");
                $("#txtSN").val("");
                $("#saleReturnDetail tbody").html("");
                $("#saleReturnSN tbody").html("");
                $("#saleReturnDetail").table("refresh");
                $("#saleReturnSN").table("refresh");
                scanType = -1;//扫描类型
                chooseScanType(scanType);
                showMsg("保存成功！", 1);
            }

            //根据字符串模糊查询采购单
            function getSaleReturnOrder() {
                searchSaleReturnNo("");
                $("#listviews").listview("refresh");
            }

            //选择扫描方式 
            function chooseScanType(data) {
                var htmls = "";
                scanType = data;
                switch (data) {
                    case -1:
                        htmls = "GRN";
                        break;
                    case 0:
                        htmls = "SN";
                        break;
                    case 3:
                        htmls = "客户SN";
                        break;
                    case 1:
                        htmls = "卡通箱";
                        break;
                    case 2:
                        htmls = "栈板";
                        break;
                }
                $("#scanType").html(htmls);
                $("#myPopup").popup("close");
                setTimeout('$("#txtSN").val("").focus()', 100);
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

            //显示消息 type 1:成功 0：失败
            function showMsg(msg, type) {
                $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
            }
        </script>
    </form>
</body>
</html>
