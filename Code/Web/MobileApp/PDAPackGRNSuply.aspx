<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDAPackGRNSuply.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAPackGRNSuply" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js?v=2" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <title>供应商包装物料条码</title>
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
        }    .ui-title {
            line-height: 30px;
            
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" id="pageone">
            <div data-role="header" data-position="fixed" >
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">供应商包装物料条码</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table width="100%">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100px;">
                            <label>当前包装箱：</label>
                        </td>
                        <td colspan="2">
                           <span id="GrnPackingSN" style="font-size: 12px; font-weight: bold;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td> 
                           &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr id="showSupplierList" style="display: none">
                        <td>
                             <label>供应商</label>
                        </td>
                        <td>
                            <input type="text" id="txtVendorCode" class="TextBox"  readonly="readonly" value=""   style="height: 25px;
                    text-transform: uppercase; font-size: 12px; font-weight: bold;"/>
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择供应商</a>
                        </td>
                    </tr>
                    <tr id="showSupplierList1" style="display: none">
                        <td> 
                           <label>供应商名称</label>
                        </td>
                        <td colspan="2">
                            <label id="lblVendorName"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>物料条码</label>
                        </td>
                        <td colspan="2">
                            <input type="text" value="" id="txtGRN" class="TextBox" style="width: 200px; height: 25px;
                    text-transform: uppercase; font-size: 12px; font-weight: bold;" />
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

                <div id="msg" style="text-align: center"></div>
               <br />
               <div id="divPackScanCode">
                <table class="ListTable ui-responsive table-stroke" width="100%" id="tabPackScanCode" style="text-align: center;">
                    <tr class="ListTableHeader">
                        <th>
                            &nbsp;
                        </th>
                        <th style="width:38%">
                            未关闭的包装箱号
                        </th>
                        <th>
                            物料编码(名称)
                        </th>
                        <th>
                            供应商名称
                        </th>
                        <th>
                            批次号
                        </th>
                    </tr>
                    <tr id="trNewInfo" class="ListTableOddRow" style="text-align: center;">
                        <td colspan="7" style="text-align: center;">
                            暂无数据
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <br />
            <div class="clear5">
            </div>
            <div id="lblPt" class="Tips">
            </div>
            <div id="packingItemList">
                <table class="ListTable ui-responsive table-stroke" width="100%" id="packingItemListTbl">
                    <tr class="ListTableHeader">
                        <th align="left" colspan="2">
                            <%=Resources.lang.GRNCartonSN%>&nbsp;&nbsp;&nbsp;<span id="CartonSN"></span>&nbsp;&nbsp;&nbsp;总数量 <span id="PackQty">0</span>
                        </th>
                    </tr>
                    <tr class="ListTableEvenRow">
                        <td align="left" colspan="2">
                            <%=Resources.lang.PackedGRN %>&nbsp;&nbsp;&nbsp;<span id="packedItemQty">0</span>
                        </td>
                    </tr>
                </table>
            </div>

            </div>
            <div data-role="footer" data-position="fixed"  data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtn" data-theme="a" value="完成包装" /></li>
                    </ul>
                </div>
            </div>


            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选供应商</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="供应商编码/名称"
                        data-theme="c" class="listview">
                </div>
            </div>


        </div>
        <input type="hidden" value="" id="hdnCartonSN" />
        <input type="hidden" value="" id="hdnVendorCode" />
        <input class="TextBox" id="hidtxt" style="display: none;" />
        <script type="text/javascript">
            var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            var vendorCode = "";
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
            var num = 0; //取消次数
            var GrnCount = 0;
            var OneGrn = "";
            var firstGrn = "";

            $(function () {
                $("#divPackScanCode").hide();
                $(".ui-body-c").css("background", "#fff");
                //获取打印机名称
                $(document).ready(function () {
                    bindPrinters('PDAselPrintersList', function () {
                        if ($("#PDAselPrintersList").val()) {
                            $("#PDAselPrintersList-button span").text($("#PDAselPrintersList").find("option:selected").text());
                        }
                    });
                });

                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");


                //通过用户获取对应的供应商
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetVenCodeByUserId(userId);
                if (ajax.error != null) {
                    //alert(ajax.error.Message);
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                vendorCode = ajax.value.VendorCode;
                if (vendorCode == "") {
                    $("#showSupplierList").show();
                    $("#showSupplierList1").show();
                }
                $("#hdnVendorCode").val(vendorCode);

                //回车包装
                $("#txtGRN").keydown(function (event) {
                    var e = event || window.event
                    if (e && e.keyCode == 13) {
                        if ($.trim($("#txtGRN").val()) != "") {
                            //if (GrnCount == 0) {
                            //    OneGrn = $.trim($("#txtGRN").val());
                            //    //判断Grn
                            //    if (!GrnFirstValidate(OneGrn)) {
                            //        return false;
                            //    }
                            //    GrnCount = GrnCount + 1;
                            //    $("#msg").html("物料条码【" + OneGrn + "】扫描成功！但【单个物料条码不需要包装操作】，请继续扫描物料条码进行包装操作！");
                            //    $("#msg").css("color", "green");
                            //    $("#txtGRN").focus();
                            //    $("#txtGRN").select();
                            //    return false;
                            //}
                            //else if (GrnCount == 1) {
                            //    var grnTwo = $.trim($("#txtGRN").val());
                            //    //判断Grn
                            //    if (!GrnFirstValidate(grnTwo)) {
                            //        return false;
                            //    }
                            //    PackGRNFirst(OneGrn);//写入第一条码
                            //    //回车只显示GRN信息 
                            //    PackGRNFirst(grnTwo);//写入第二个条码
                            //}
                            //else {
                                //回车只显示GRN信息 
                                PackGRN();
                            //}
                        }
                        else {
                            $("#msg").html("请先扫描GRN条码");
                            $("#msg").css("color", "red");
                            //alert("请先扫描GRN条码");
                            return false;
                        }
                    }
                });
                //筛选
                $("#btnFilter").on("click", function () {
                    $("#listviews").html("");
                    var $ul = $(this),
                    value = $.trim($("input[data-type='search']:eq(0)").val());
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.GetGetVendorCodeList(value);
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message);
                        $("#msg").css("color", "red");
                        $("#txtVendorCode").focus();
                        return false;
                    }

                    var entity = ajax.value;
                    if (entity.error != null) {
                        $("#msg").html(entity.error);
                        $("#msg").css("color", "red");
                        $("#txtVendorCode").focus();
                        //confirmDialogFocus(entity.error, function () {
                        //    $("#txtVendorCode").focus();
                        //});
                        return false;
                    };
                    var ulhtml = "";
                    for (var i = 0; i < entity.length; i++) {
                        if (ulhtml.indexOf(entity[i].SupplierId) == -1) {
                            ulhtml += '<li class="ui-btn ui-btn-icon-right ui-icon-carat-r"><a onclick="SetVendorCode(this)" style="font-size:80%;">' + entity[i].VendorCode + '-' + entity[i].VendorName + '</a></li>';
                        }
                    }
                    $("#listviews").html(ulhtml);
                    $("#listviews").listview("refresh");
                });
                $("#Savebtn").on("click", function () {
                    ClosePack();
                });
            });

            //判断Grn是否合法
            function GrnFirstValidate(grn) {
                //验证包装的GRN条码是否合法
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.FirstValidateGRN(grn, $.trim($("#hdnCartonSN").val()), $("#hdnVendorCode").val());
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                var messageStr1 = ajax.value;
                //alert(messageStr1[3]);
                //有错误信息
                if (messageStr1[0] == -1) {
                    $("#msg").html(messageStr1[1]);
                    $("#msg").css("color", "red");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                //大包装箱
                if (messageStr1[0] == 2 && GrnCount == 0) {
                    $("#PackQty").text(messageStr1[3]);
                    var str = messageStr1[1].split("|");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    if (vendorCode != str[1]) {
                        $("#msg").html("<%=Resources.Messages.GrnNotMatchVendorCode %>");
                        $("#msg").css("color", "red");
                        return false;
                    }
                    setCartonSN(str[0]);
                    getPackedItemList(str[0]);
                    $("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装物料！");
                    $("#msg").css("color", "green");
                    GrnCount = GrnCount + 1;
                    return false;
                }
                return true;
            }

            function SetVendorCode(Code) {
                //alert($(Code).html());
                var codeString = $(Code).html().split('-');
                $("#txtVendorCode").val(codeString[0]);
                vendorCode = codeString[0];
                $("#hdnVendorCode").val(codeString[0]);
                $("#lblVendorName").text(codeString[1]);

                $("input[data-type='search']").val('');
                $("#listviews").html('');
                $("#fpanel").panel("close");
                firstGrn = "";
                $("#GrnPackingSN").html("");
                $("#hdnCartonSN").val("");
                $("#txtGRN").val("");
                $("#PackQty").text("0");
                $("#txtGRN").focus();
                $("#CartonSN").html("");
                $("#packingItemListTbl tr:gt(1)").remove();
                $("#packedItemQty").html("0");
                $("#msg").html("");
                GrnCount = 0;
            }

            //包装GRN
            function PackGRNFirst(txtGRN) {
            $("#msg").html("");
            $(".StrongFont").removeClass("StrongFont");
            var hdnCartonSN = $.trim($("#hdnCartonSN").val());
            vendorCode = $("#hdnVendorCode").val();
            if (vendorCode == "") {
                $("#msg").html("请选择供应商!");
                $("#msg").css("color", "red");
                //alert("请选择供应商!");
                return false;
            }
            //验证包装的GRN条码是否合法
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateGRN(txtGRN, hdnCartonSN, vendorCode);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                highListCurrentItem(txtGRN);
                return false;
            }
            var messageStr = ajax.value;
            vendorCode = messageStr[2];
            //alert(messageStr[3].toString());
            $("#PackQty").text(messageStr[3]);
            $("#hdnVendorCode").val(vendorCode);
            //有错误信息
            if (messageStr[0] == -1) {
                $("#msg").html(messageStr[1]);
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            //数据库中没有未关闭的包装箱，系统生成新carton箱条码并成功包装GRN
            if (messageStr[0] == 0) {
                setCartonSN(messageStr[1]);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                GrnCount = GrnCount + 1;
                return false;
            }
            //系统中还有未关闭的包装箱可使用，是否使用未关闭的包装箱？\n点击【确定】重新生成新的包装箱，点击【取消】打开未关闭的包装箱
            if (messageStr[0] == 1) {
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode == "") {
                    $("#msg").html("获取供应商编码失败！");
                    $("#msg").css("color", "red");
                    return false;
                }
                //不检测是否有未关闭的包装箱，每重新扫描一次，都打开新箱
                //if (confirm("<%=Resources.Messages.ConfirmToNewCartonSN %>")) {
                //update by peter on 2016-5-12 生成新的包装箱号
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateNewCartonSNAndPack(txtGRN, 1);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                var returnCartonSN = ajax.value;
                setCartonSN(returnCartonSN);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                GrnCount = GrnCount + 1;
                //}
                //else {
                //    //点击【取消】打开未关闭的包装箱(获取原包装箱号) update by peter on 2016-5-12
                //    //显示未关闭的包装箱列表
                //    num += 1;
                //    $("#divPackScanCode").show();
                //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetOldCartonGRNList(txtGRN);
                //    if (ajax.error != null) {
                //        $("#msg").html(ajax.error.Message);
                //        $("#msg").css("color", "red");
                //        return false;
                //    }
                //    var strHtml = "";
                //    var oldCartonSN = "";
                //    var list = ajax.value;
                //    $("#trNewInfo").remove();
                //    if (num == 1) {
                //        for (var i = 0; i < list.length; i++) {
                //            strHtml += "<tr class='ListTableOddRow'>";
                //            strHtml += "<td><input name='chkSelect' align='center' type='checkbox' value='" + list[i].SerialNumber + "'/></td>";
                //            strHtml += "<td>" + list[i].SerialNumber + "</td>";
                //            strHtml += "<td>" + list[i].ItemCode + "(" + list[i].ItemName + ")</td>";
                //            strHtml += "<td>" + list[i].VendorName + "</td>";
                //            strHtml += "<td>" + list[i].LotCode + "</td>";
                //            strHtml += "</tr>";
                //        }
                //        $(strHtml).appendTo($("#tabPackScanCode"));
                //    }
                //    //获取选中的值
                //    $("input[name='chkSelect']").click(function () {
                //        if (this.checked) {
                //            $("#tabPackScanCode tr").each(function () {
                //                if ($($(this).find("td")[0]).find("input[name='chkSelect']").is(":checked")) {
                //                    oldCartonSN += $($(this).find("td")[1]).html();
                //                }
                //            });
                //            //包装扫描的GRN
                //            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetOldCartonGRN(txtGRN, vendorCode, oldCartonSN);
                //            if (ajax.error != null) {
                //                $("#msg").html(ajax.error.Message);
                //                $("#msg").css("color", "red");
                //                return false;
                //            }
                //            setCartonSN(oldCartonSN);
                //            setPackInfo(txtGRN);
                //            getPackedItemList(oldCartonSN);
                //        }
                //    });
                //}
            }
            //大包装箱
            if (messageStr[0] == 2) {
                var str = messageStr[1].split("|");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode != str[1]) {
                    $("#msg").html("<%=Resources.Messages.GrnNotMatchVendorCode %>");
                    $("#msg").css("color", "red");
                    return false;
                }
                setCartonSN(str[0]);
                getPackedItemList(str[0]);
                $("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装物料！");
                $("#msg").css("color", "green");
                GrnCount = GrnCount + 1;
                return false;
            }
        }


        //包装GRN
        function PackGRN() {
            if ($.trim($("#txtGRN").val()) == "") {
                $("#msg").html("请先扫描GRN条码");
                $("#msg").css("color", "red");
                //alert("请先扫描GRN条码");
                return false;
            }
            $("#msg").html("");
            $("#msg").css("color", "red");
            $(".StrongFont").removeClass("StrongFont");
            var txtGRN = $.trim($("#txtGRN").val());
            var hdnCartonSN = $.trim($("#hdnCartonSN").val());
            vendorCode = $("#hdnVendorCode").val();
            if (txtGRN == "") {
                $("#msg").html("请扫GRN条码！");
                $("#msg").css("color", "red");
                //alert("请扫GRN条码！");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (vendorCode == "") {
                $("#msg").html("请选择供应商!");
                $("#msg").css("color", "red");
                //alert("请选择供应商!");
                return false;
            }
            if (firstGrn == "") {
                firstGrn = $.trim($("#txtGRN").val());
            }

            //验证包装的GRN条码是否合法
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateGRN(txtGRN, hdnCartonSN, vendorCode, firstGrn);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                highListCurrentItem(txtGRN);
                return false;
            }

            //验证GRN状态是否在送货单
            var ajaxCK = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateGRNOnWay(txtGRN);
            if (ajaxCK.error == null && ajaxCK.value) {
                $("#msg").html("该物料条码已在供应商已产生送货单！");
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            var messageStr = ajax.value;
            vendorCode = messageStr[2];
            $("#PackQty").text(messageStr[3]);
            $("#hdnVendorCode").val(vendorCode);
            //有错误信息
            if (messageStr[0] == -1) {
                $("#msg").html(messageStr[1]);
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            //数据库中没有未关闭的包装箱，系统生成新carton箱条码并成功包装GRN
            if (messageStr[0] == 0) {
                setCartonSN(messageStr[1]);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                GrnCount = GrnCount + 1;
                return false;
            }
            //系统中还有未关闭的包装箱可使用，是否使用未关闭的包装箱？\n点击【确定】重新生成新的包装箱，点击【取消】打开未关闭的包装箱
            if (messageStr[0] == 1) {
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode == "") {
                    $("#msg").html("获取供应商编码失败！");
                    $("#msg").css("color", "red");
                    return false;
                }
                //不检测是否有未关闭的包装箱，每重新扫描一次，都打开新箱
                //if (confirm("<%=Resources.Messages.ConfirmToNewCartonSN %>")) {
                //update by peter on 2016-5-12 生成新的包装箱号
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateNewCartonSNAndPack(txtGRN, 1);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                var returnCartonSN = ajax.value;
                setCartonSN(returnCartonSN);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                GrnCount = GrnCount + 1;
                //}
                //else {
                //    //点击【取消】打开未关闭的包装箱(获取原包装箱号) update by peter on 2016-5-12
                //    //显示未关闭的包装箱列表
                //    num += 1;
                //    $("#divPackScanCode").show();
                //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetOldCartonGRNList(txtGRN);
                //    if (ajax.error != null) {
                //        $("#msg").html(ajax.error.Message);
                //        $("#msg").css("color", "red");
                //        return false;
                //    }
                //    var strHtml = "";
                //    var oldCartonSN = "";
                //    var list = ajax.value;
                //    $("#trNewInfo").remove();
                //    if (num == 1) {
                //        for (var i = 0; i < list.length; i++) {
                //            strHtml += "<tr class='ListTableOddRow'>";
                //            strHtml += "<td><input name='chkSelect' align='center' type='checkbox' value='" + list[i].SerialNumber + "'/></td>";
                //            strHtml += "<td>" + list[i].SerialNumber + "</td>";
                //            strHtml += "<td>" + list[i].ItemCode + "(" + list[i].ItemName + ")</td>";
                //            strHtml += "<td>" + list[i].VendorName + "</td>";
                //            strHtml += "<td>" + list[i].LotCode + "</td>";
                //            strHtml += "</tr>";
                //        }
                //        $(strHtml).appendTo($("#tabPackScanCode"));
                //    }
                //    //获取选中的值
                //    $("input[name='chkSelect']").click(function () {
                //        if (this.checked) {
                //            $("#tabPackScanCode tr").each(function () {
                //                if ($($(this).find("td")[0]).find("input[name='chkSelect']").is(":checked")) {
                //                    oldCartonSN += $($(this).find("td")[1]).html();
                //                }
                //            });
                //            //包装扫描的GRN
                //            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetOldCartonGRN(txtGRN, vendorCode, oldCartonSN);
                //            if (ajax.error != null) {
                //                $("#msg").html(ajax.error.Message);
                //                $("#msg").css("color", "red");
                //                return false;
                //            }
                //            setCartonSN(oldCartonSN);
                //            setPackInfo(txtGRN);
                //            getPackedItemList(oldCartonSN);
                //        }
                //    });
                //}
            }
            //大包装箱
            if (messageStr[0] == 2) {
                var str = messageStr[1].split("|");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode != str[1]) {
                    $("#msg").html("<%=Resources.Messages.GrnNotMatchVendorCode %>");
                    $("#msg").css("color", "red");
                    return false;
                }
                setCartonSN(str[0]);
                getPackedItemList(str[0]);
                $("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装物料！");
                $("#msg").css("color", "green");
                GrnCount = GrnCount + 1;
                return false;
            }
        }

        /*得到选中记录的值*/
        function getSelectedValues() {
            var selValues = "";
            var checkboxs = document.getElementsByName("chkSelect");
            var checkboxCount = checkboxs.length;

            for (var i = 0; i < checkboxCount; i++) {
                if (checkboxs[i].checked) {
                    if (selValues != "") {
                        selValues += ",";
                    }

                    selValues += checkboxs[i].value;
                }
            }
            return selValues;
        }
        function highListCurrentItem(txtGRN) {
            $("#packingItemListTbl tr").each(function () {
                if ($(this).children("td:eq(1)").html() == txtGRN) {
                    $(this).addClass("StrongFont");
                }
            });
        }
        //赋值
        function setCartonSN(cartonsn) {
            $("#GrnPackingSN").html(cartonsn);
            $("#hdnCartonSN").val(cartonsn);
            $("#CartonSN").html(cartonsn);
        }
        //设置完成包装信息
        function setPackInfo(info) {
            var msg = "" + GrnCount == 2 ? "[" + OneGrn + "]" + "[" + info + "]<%=Resources.Messages.PackingSuccessful %>" : "[" + info + "]<%=Resources.Messages.PackingSuccessful %>";
            $("#msg").html(msg);
            $("#msg").css("color", "green");
            $("#txtGRN").val("");
            $("#txtGRN").focus();
            $("#txtGRN").select();
            $("#divPackScanCode").hide();
        }
        //包装成功显示列表
        function appendPackItem(grn) {
            $(".StrongFont").removeClass("StrongFont");
            var rows = $("#packingItemListTbl tr").length - 2;
            if (rows % 2 == 0) {
                $("<tr class='ListTableOddRow StrongFont'><td width='5%'>" + (rows + 1) + "&nbsp;&nbsp;&nbsp;</td><td>" + grn + "</td></tr>").appendTo($("#packingItemListTbl"));
            }
            else {
                $("<tr class='ListTableEvenRow StrongFont'><td width='5%'>" + (rows + 1) + "&nbsp;&nbsp;&nbsp;</td><td>" + grn + "</td></tr>").appendTo($("#packingItemListTbl"));
            }
            $("#packedItemQty").html((parseInt($("#packedItemQty").html()) + 1).toString());
        }

        function getPackedItemList(cartonsn) {
            $(".StrongFont").removeClass("StrongFont");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetPackedItemList(cartonsn);
            if (ajax.error != null) {
                //alert(ajax.error.Message);
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }

            var list = ajax.value;
            var l = "";
            var rows = $("#packingItemListTbl tr").length - 2;
            var scaningGRN = $.trim($("#txtGRN").val());
            for (var i = 0; i < list.length; i++) {
                if ((rows + i) % 2 == 0) {
                    if (list[i].SerialNumber == scaningGRN) {
                        l += "<tr class='ListTableOddRow StrongFont'><td width='5%'>" + (rows + i + 1) + "&nbsp;&nbsp;&nbsp;</td><td>" + list[i].SerialNumber + "</td></tr>";
                    }
                    else {
                        l += "<tr class='ListTableOddRow'><td width='5%'>" + (rows + i + 1) + "&nbsp;&nbsp;&nbsp;</td><td>" + list[i].SerialNumber + "</td></tr>";
                    }
                }
                else {
                    if (list[i].SerialNumber == scaningGRN) {
                        l += "<tr class='ListTableEvenRow StrongFont'><td width='5%'>" + (rows + i + 1) + "&nbsp;&nbsp;&nbsp;</td><td>" + list[i].SerialNumber + "</td></tr>";
                    }
                    else {
                        l += "<tr class='ListTableEvenRow'><td width='5%'>" + (rows + i + 1) + "&nbsp;&nbsp;&nbsp;</td><td>" + list[i].SerialNumber + "</td></tr>";
                    }
                }
            }
            $(l).appendTo($("#packingItemListTbl"));
            $("#packedItemQty").html(list.length.toString());
        }

        //完成包装箱
        function ClosePack() {
            var txtCartonSN = $("#hdnCartonSN").val();
            if (txtCartonSN == "") {
                //alert("<%=Resources.Messages.NoCartonToClose %>");
                $("#msg").html("<%=Resources.Messages.NoCartonToClose %>");
                $("#msg").css("color", "red");
                return false;
            }
            var grncount = $("#packingItemListTbl tr").length - 2;
            if (grncount == 0) {
                $("#msg").html("<%=Resources.Messages.CartonCannotBeClosed %>");
                $("#msg").css("color", "red");
                //alert("<%=Resources.Messages.CartonCannotBeClosed %>");
                return false;
            }
            //if (grncount == 1) {
            //    //alert("单个物料条码不需要包装操作！");
            //    $("#msg").html("单个物料条码不需要包装操作！");
            //    $("#msg").css("color", "red");
            //    return false;
            //}
            confirmDialog(String.format("<%=Resources.Messages.ConfirmCloseCarton %>", txtCartonSN.toString(), grncount.toString()), function () {
                 var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ClosePack(txtCartonSN);
                    if (ajax.error != null) {
                        //alert(ajax.error.Message);
                        $("#msg").html(ajax.error.Message);
                        $("#msg").css("color", "red");
                        return false;
                    }
                    $("#CartonSN").html("<span style='color:green;'>" + txtCartonSN + "[<%=Resources.lang.CartonIsClosed %>]</span>");
                    $("#GrnPackingSN").html("");
                    $("#hdnCartonSN").val("");
                    $("#txtGRN").val("");
                    $("#PackQty").text("0");
                    $("#txtGRN").focus();

                    $("#msg").html("正在打印...");
                    $("#msg").css("color", "green");
                    printCartonLabel(txtCartonSN);
            });
        }       


            function clearInfo() {
                $("#txtVendorCode").val("");
                $("#lblVendorName").text("");
                $("#GrnPackingSN").html("");
                $("#hdnCartonSN").val("");
                $("#txtGRN").val("");
                $("#PackQty").text("0");
                $("#txtGRN").focus();
                $("#CartonSN").html("");
                $("#packingItemListTbl tr:gt(1)").remove();
                $("#packedItemQty").html("0");
                $("#msg").html("");
                GrnCount = 0;
            }



         //打印包装箱
         function printCartonLabel(grn) {
            //获取包装箱物料信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grn);
            if (ajax.error != null) {
                //alert(ajax.error.Message);
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
            var entity = ajax.value;
            labelItemId = entity.PartId

            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.ItemList = [];
            SNInfo.SNList.push(grn);
            SNInfo.ItemList.push(entity.PartId);
            if (SNInfo.SNList.length == 0) return false;

            //根据打印方式决定 调用ZPL还是Lab打印
            getDocumentInfo();
            PrintLabContent();

            
            setTimeout(function () {
                //document.forms[0].submit()
                clearInfo();
            },2000);
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '<%=Request.QueryString["ItemID"] %>';    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -14;          //标签类型  (1.物料条码 2：包装条码)
        var labelSequence = 3;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径



        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //获取打印机名称值
                printName = $("#PDAselPrintersList").val();
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                //alert(ajax.error.Message);
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
        }


        var printCount = 1;
        var labelJsonData = "";
        function PrintLabContent() {
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
        }

        </script>
    </form>
</body>
</html>

