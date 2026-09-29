<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormChangeByMES.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.FormChangeByMES" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-9" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/jquery.mobile.datepicker.css">
    <link rel="stylesheet" href="css/jquery.mobile.datepicker.theme.css">
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <link href="/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/Common.js?v=2" type="text/javascript"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <title>形态转换综合页面</title>
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

        .ui-title {
            line-height: 30px;
        }
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false;">
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label id="lbltitle" style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">形态转换综合页面</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back" data-transition="none" data-ajax="false">返回</a>
                <a href="Index.aspx" class="ui-btn-right" data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label for="FormChangeNo">单号</label>
                        </td>
                        <td>
                            <input id="FormChangeNo" />
                        </td>
                        <td>
                            <a href="#mypanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择单据</a>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <a href="#scantypepopup" data-rel="popup" data-position-to="window" id="scantype">GRN</a>
                        </td>
                        <td>
                            <input id="Number" />
                        </td>
                        <td>
                            <a data-transition="none" data-role="button" data-mini="true" data-ajax="false" id="CleanGrn" data-theme="c">清除</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="cBarCode">转换前原料</label>
                        </td>
                        <td>
                            <input id="rawMaterialBeforeConversionItemName" disabled="disabled" />
                        </td>
                        <td>
                            <input id="rawMaterialBeforeConversionItemCode" disabled="disabled" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="ConvertedScrap">转换后碎料</label>
                        </td>
                        <td>
                            <span id="ScrapSelectWrap"><select id="ConvertedScrap" data-mini="true">
                                <option value="">--请选择--</option>
                            </select></span>
                            <span id="ScrapManualWrap" style="display: none;">
                                <input id="ConvertedScrapManual" type="text" data-mini="true" placeholder="请输入06粉碎料" />
                            </span>
                            <span id="ScrapTextWrap" style="display: none;">
                                <input id="ConvertedScrapText" type="text" data-mini="true" disabled="disabled" />
                            </span>
                        </td>
                        <td>
                            <span id="ChooseScrapWrap" style="display: none;"><a data-role="button" data-mini="true" data-ajax="false" id="chooseScrap" data-theme="c">选择物料</a></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="cBarCode">转换后库位</label>
                        </td>
                        <td colspan="2">
                            <input id="cBarCode" />
                        </td> 
                    </tr>
                    <tr>
                        <td>
                            <label for="Qty">转换后数量</label>
                        </td>
                        <td colspan="2">
                            <input id="Qty" inputmode="decimal" placeholder="扫条码后默认=转换前数量，可改为重量" />
                            <a data-role="button" data-mini="true" data-ajax="false" id="enterGrn" data-theme="c">入明细</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Qty">最小包装数量</label>
                        </td>
                        <td colspan="2">
                            <input id="MiniPackQty" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Print">
                                打印机</label>
                        </td>
                        <td>
                            <select id="PDAselPrintersList" data-mini="true" class="perparelist">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>打印新GRN</label></td>
                        <td>
                            <input id="PrintNew" type="checkbox" value="PrintNew" checked="checked" /></td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center; margin-top: 3px">
                </div>
                <div>
                    <table id="DNInfotab" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%">
                        <thead>
                            <tr>
                                <th>行号
                                </th>
                                <th>条码
                                </th>
                                <th>转换前物料
                                </th>
                                <th>转换后物料
                                </th>
                                <th>转换数量
                                </th>
                                <th>操作
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

                <div data-role="popup" id="popupGrnLog">
                    <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">关闭</a>
                    <table data-role="table" id="Table1" data-mode="columntoggle" class="ui-responsive table-stroke">
                        <thead style="background-color: #2FC1FF">
                            <tr>
                                <th>序号
                                </th>
                                <th>序列号
                                </th>
                                <th style="min-width: 40px">数量
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="ListTableOddRow">
                                <td colspan="10" style="text-align: center;">暂无数据</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a data-corners="false" id="Save" data-role="button" data-fullscreen="true" data-theme="a">确认转换</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="mypanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-theme="c" data-filter="true" data-filter-placeholder="输入形态转换单号。。。" data-inset="false">
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="mypanelItem" data-display="overlay">
                <a href="#" id="btnFilterItem" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选物料</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviewsItem" data-theme="c" data-filter="true" data-filter-placeholder="输入料号或物料名称。。。" data-inset="false">
                    </ul>
                </div>
            </div>
            <div data-role="popup" id="scantypepopup" style="min-width: 220px">
                <ul data-role="listview">
                    <li><a onclick="Scantype(-1)">GRN</a></li>
                    <li><a onclick="Scantype(0)">SN</a></li>
                    <li><a onclick="Scantype(3)">客户SN</a></li>
                    <li><a onclick="Scantype(1)">卡通箱</a></li>
                    <li><a onclick="Scantype(2)">栈板</a></li>
                </ul>
            </div>
        </div>
    </form>
    <script src="js/datepicker.js"></script>
    <%--<script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>--%>
    <script type="text/javascript">
        var ScanType = 1;//扫描类型 ，默认是栈板
        var Numberarr = [];//记录数量
        var ArrGRN = [];//保存已扫描的GRN
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var SalOrderId = "";
        $(document).ready(function () {

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
            $(".ui-body-c").css("background", "#fff");
            $("body>[data-role='listview']").listview();
            $("#FormChangeNo").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
            $("#Number").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });
            $("#cBarCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });
            $("#MiniPackQty").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });

            //形态转换单号查询
            $("#FormChangeNo").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Numberarr = [];
                    ArrGRN = [];
                    if (PDAGetFormChangeList($("#FormChangeNo").val()) != false) {
                        $("#msg").html('形态转换单扫描成功').css("color", "green");
                        $("#FormChangeNo").attr("disabled", "disabled");
                        $("#Number").focus();
                    } else {
                        $("#FormChangeNo").select();
                    }
                }
            });
            //条码扫描事件
            $("#Number").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Scan();
                }
            });
            //库位扫描事件
            $("#cBarCode").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    ScanCBarcode();
                }
            });

            //多候选：选料只回填不入明细，需人点【入明细】（change + selectmenuchange + 关闭菜单后兜底）
            $(document).on("change", "#ConvertedScrap", function () {
                onScrapChanged();
            });
            $(document).on("selectmenuchange", "#ConvertedScrap", function () {
                onScrapChanged();
            });
            $(document).on("selectmenuclose", "#ConvertedScrap", function () {
                setTimeout(function () { onScrapChanged(); }, 50);
            });

            //无候选手动输入：回车只跳到【入明细】，不自动提交（必须人点【入明细】）
            $(document).on("keydown", "#ConvertedScrapManual", function (e) {
                var key = e.keyCode || e.which || e.charCode;
                if (key == 13) {
                    e.preventDefault();
                    if (getScrapValue()) {
                        showMsg("已输入粉碎料，请点【入明细】", 1);
                        $("#enterGrn").focus();
                    }
                }
            });

            //筛选
            $("#btnFilter").on("click", function () {
                $("#listviews").html("");
                var $ul = $(this),
                    value = $.trim($("input[data-type='search']:eq(0)").val());


                $("#listviews").html("");
                var data = SKT.LeanMES.Web.AjaxServices.Client.AjaxFromChangeByMES.GetFromChangeNo(value);

                if (data.error != null) {
                    $("#msg").html(data.error.Message).css("color", "red");
                    return false;
                }
                var ulhtml = "";
                var entity = JSON.parse(data.value).data;
                for (var i = 0; i < entity.length; i++) {
                    ulhtml += "<li><a id='" + entity[i].FromChangeByMESNo + "' onclick='CheckDNlist(this)'>" + entity[i].FromChangeByMESNo + "</a></li>";
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            });

            $("#btnFilterItem").on("click", function () {
                $("#listviewsItem").html("");
                var $ul = $(this),value = $.trim($("input[data-type='search']:eq(1)").val());

                var sn = $.trim($("#Number").val());
                if (value === "" && scrapMode !== "normal" && sn !== "") {
                    loadScrapCandidates(sn, true);
                    return false;
                }
                if (value === "") {
                    return false;
                }
                $("#listviewsItem").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFromChangeByMES.GetItemCode(value);

                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                var ulhtml = "";
                entity = JSON.parse(ajax.value).data;
                for (var i = 0; i < entity.length; i++) {
                    var itemName = entity[i].ItemName || "";
                    var itemTip = (entity[i].ItemCode + (itemName ? (" " + itemName) : "")).replace(/'/g, "&#39;").replace(/"/g, "&quot;");
                    //换行显示：第一行料号、第二行名称；title 悬浮提示完整「料号 名称」
                    ulhtml += "<li><a id='" + entity[i].ItemCode + "' onclick='CheckItemlist(this)' title='" + itemTip + "' style='white-space: normal; word-break: break-all;'>"
                        + entity[i].ItemCode + (itemName ? ("<br/> " + itemName) : "") + "</a></li>";
                }
                $("#listviewsItem").append(ulhtml);
                $("#listviewsItem").listview("refresh");
            });

            $("#Save").on("click", function () { Save(); });
        });

        function chooseItem() {
            if ($.trim($("#Number").val()) == "") {
                confirmDialog("请先扫码条码！");
                return false;
            }
            if (!isCrusherMode()) {
                //生产原版：打开面板由操作者按料号自由搜索(GetItemCode)，不预载06候选
                $("#listviewsItem").html("");
                $("#mypanelItem").panel("open");
                return true;
            }
            loadScrapCandidates($.trim($("#Number").val()), true);
        }

        function loadScrapCandidates(barCode, openPanel) {
            $("#listviewsItem").html("");
            if (!barCode) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFromChangeByMES.GetMaterialCandidates(barCode, "06");
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                return false;
            }
            var entity = JSON.parse(ajax.value).data || [];
            var ulhtml = "";
            for (var i = 0; i < entity.length; i++) {
                var name = entity[i].ItemName || "";
                var tip = (entity[i].ItemCode + (name ? (" " + name) : "")).replace(/'/g, "&#39;").replace(/"/g, "&quot;");
                //换行显示：第一行料号、第二行名称；title 悬浮提示完整「料号 名称」
                ulhtml += "<li><a id='" + entity[i].ItemCode + "' onclick='CheckItemlist(this)' title='" + tip + "' style='white-space: normal; word-break: break-all;'>"
                    + entity[i].ItemCode + (name ? ("<br/> " + name) : "") + "</a></li>";
            }
            if (entity.length == 0) {
                ulhtml = "<li>无06候选粉碎料，请返回主界面在【转换后碎料】手动输入粉碎料(06开头)</li>";
            }
            $("#listviewsItem").append(ulhtml);
            $("#listviewsItem").listview("refresh");
            if (openPanel) {
                $("#mypanelItem").panel("open");
            }
            return entity;
        }

        var pendingSn = "";
        var pendingBalance = 0;
        var pendingMaterial = "";
        var confirmingLine = false;

        //GRN 来源模式：crusher=粉碎机上料生成的条码(新逻辑：06候选下拉/无候选手动输入/数量自动=余额)；
        //               normal=其它来源条码(生产原版：选择物料面板自由选料、无候选校验、数量手工填)
        var scrapMode = "crusher";

        function isCrusherMode() {
            return scrapMode !== "normal";
        }

        function setScrapMode(mode) {
            scrapMode = (mode === "normal") ? "normal" : "crusher";
            hideScrapManual();
            $("#ConvertedScrap").html('<option value="">--请选择--</option>');
            $("#ConvertedScrap").val("");
            if ($("#ConvertedScrap").data("mobile-selectmenu")) {
                $("#ConvertedScrap").selectmenu("refresh", true);
            }
            $("#ConvertedScrapText").val("");
            if (scrapMode === "normal") {
                $("#ScrapSelectWrap").hide();
                $("#ScrapTextWrap").show();
                $("#ChooseScrapWrap").show();
                $("#Qty").removeAttr("placeholder").attr("placeholder", "请输入转换后数量");
            } else {
                $("#ScrapTextWrap").hide();
                $("#ChooseScrapWrap").hide();
                $("#ScrapSelectWrap").show();
                $("#Qty").removeAttr("placeholder").attr("placeholder", "扫条码后默认=转换前数量，可改为重量");
            }
        }

        function onScrapChanged() {
            if (!pendingSn || confirmingLine) {
                return;
            }
            var material = $.trim($("#ConvertedScrap").val());
            if (!material) {
                return;
            }
            //已选料：不自动入明细，等操作者点【入明细】
            pendingMaterial = material;
            showMsg("已选择 " + material + "，请点【入明细】", 1);
            $("#enterGrn").focus();
        }

        //06 候选为空：切换为手动输入粉碎料（0候选时允许操作者手工录入）
        function isScrapManualMode() {
            return $("#ScrapManualWrap").css("display") != "none";
        }

        function showScrapManual(preferred) {
            $("#ScrapSelectWrap").hide();
            $("#ScrapManualWrap").show();
            $("#ConvertedScrapManual").val(preferred || "");
        }

        function hideScrapManual() {
            $("#ScrapManualWrap").hide();
            $("#ScrapSelectWrap").show();
            $("#ConvertedScrapManual").val("");
        }

        function getScrapValue() {
            if (!isCrusherMode()) {
                return $.trim($("#ConvertedScrapText").val());
            }
            return isScrapManualMode() ? $.trim($("#ConvertedScrapManual").val()) : $.trim($("#ConvertedScrap").val());
        }

        function focusScrapInput() {
            if (!isCrusherMode()) {
                $("#ConvertedScrapText").focus();
                return;
            }
            if (isScrapManualMode()) {
                $("#ConvertedScrapManual").focus();
            } else {
                $("#ConvertedScrap").focus();
            }
        }

        function fillScrapManual(barCode, balanceQty, preferMaterial) {
            var preferred = preferMaterial || "";
            showScrapManual(preferred);
            pendingSn = barCode;
            pendingBalance = balanceQty || 0;
            pendingMaterial = preferred;
            var tip = "该条码无06候选粉碎料，请手动输入粉碎料(06开头)后点【入明细】";
            if (preferred) {
                tip += "（本单已选 " + preferred + "，已带入）";
            }
            showMsg(tip, 1);
            setTimeout(function () { $("#ConvertedScrapManual").focus(); }, 100);
            return true;
        }

        function resetScrapSelect(keepValue) {
            hideScrapManual();
            var val = keepValue ? $.trim(keepValue) : "";
            $("#ConvertedScrap").html('<option value="">--请选择--</option>');
            if (val) {
                $("#ConvertedScrap").append($("<option></option>").val(val).text(val));
            }
            $("#ConvertedScrap").val(val);
            if ($("#ConvertedScrap").data("mobile-selectmenu")) {
                $("#ConvertedScrap").selectmenu("refresh", true);
            }
        }

        //按模式清空转换后碎料（crusher=下拉，normal=原版输入框）
        function resetScrapUI() {
            if (isCrusherMode()) {
                resetScrapSelect("");
            } else {
                $("#ConvertedScrapText").val("");
            }
        }

        function fillScrapSelect(barCode, balanceQty, preferMaterial) {
            var entity = loadScrapCandidates(barCode, false) || [];
            if (entity.length == 0) {
                //无候选：切换到手动输入，允许操作者录入粉碎料
                return fillScrapManual(barCode, balanceQty, preferMaterial);
            }
            hideScrapManual();
            var preferred = preferMaterial || "";
            var ordered = entity.slice();
            if (preferred) {
                for (var i = 0; i < ordered.length; i++) {
                    if (ordered[i].ItemCode == preferred) {
                        ordered.splice(i, 1);
                        ordered.unshift({ ItemCode: preferred, ItemName: entity[i].ItemName || "" });
                        break;
                    }
                }
            }
            //不预选：占位项保持选中，用户必须实际点选，change 才会触发
            var html = '<option value="">--请选择--</option>';
            for (var j = 0; j < ordered.length; j++) {
                var code = ordered[j].ItemCode;
                var name = ordered[j].ItemName || "";
                html += '<option value="' + code + '">' + code + (name ? (" " + name) : "") + '</option>';
            }
            $("#ConvertedScrap").html(html);
            $("#ConvertedScrap").val("");
            if ($("#ConvertedScrap").data("mobile-selectmenu")) {
                $("#ConvertedScrap").selectmenu("refresh", true);
            }
            pendingSn = barCode;
            pendingBalance = balanceQty || 0;
            pendingMaterial = preferred || "";
            var tip = "共" + entity.length + "个候选，请选择转换后碎料后点【入明细】";
            if (preferred) {
                tip += "（本单已选 " + preferred + "）";
            }
            showMsg(tip, 1);
            $("#ConvertedScrap").focus();
            return true;
        }

        function confirmLine(barCode, material, qty) {
            if (confirmingLine) {
                return false;
            }
            if (!barCode) {
                showMsg("请扫描条码", 0);
                $("#Number").focus();
                return false;
            }
            if (!material) {
                showMsg(!isCrusherMode() ? "请选择转换后碎料！" : (isScrapManualMode() ? "请输入转换后粉碎料(06开头)" : "请选择转换后碎料"), 0);
                focusScrapInput();
                return false;
            }
            confirmingLine = true;
            try {
                var origQty = parseFloat(qty || 0);
                if (isNaN(origQty) || origQty < 0) {
                    origQty = 0;
                }
                /*转换后数量可编辑（转换前=数量，转换后=重量）；未填则用条码余额*/
                var passQty = origQty;
                var inputQty = $.trim($("#Qty").val());
                if (!isCrusherMode()) {
                    /*生产原版：数量必填且须为数字，不自动回填余额*/
                    if (inputQty === "" || isNaN(parseFloat(inputQty))) {
                        showMsg("请输入正确的数量", 0);
                        $("#Qty").val("").focus();
                        return false;
                    }
                    passQty = parseFloat(inputQty);
                } else if (inputQty !== "") {
                    var parsedQty = parseFloat(inputQty);
                    if (isNaN(parsedQty)) {
                        showMsg("转换后数量【" + inputQty + "】不是有效数字", 0);
                        $("#Qty").focus();
                        return false;
                    }
                    if (parsedQty <= 0) {
                        showMsg("转换后数量必须大于0", 0);
                        $("#Qty").focus();
                        return false;
                    }
                    passQty = parsedQty;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFromChangeByMES.FromChangeMesScanGenerateEx($("#FormChangeNo").val(), barCode, material, passQty, 1, 2);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    pendingSn = barCode;
                    pendingBalance = origQty;
                    if (isCrusherMode()) {
                        //保留候选供重选，不整表清空（保留已填的转换后数量）
                        resetScrapSelect("");
                        fillScrapSelect(barCode, origQty, material);
                        $("#ConvertedScrap").val("");
                        if ($("#ConvertedScrap").data("mobile-selectmenu")) {
                            $("#ConvertedScrap").selectmenu("refresh", true);
                        }
                        $("#Number").val(barCode);
                        $("#enterGrn").focus();
                    } else {
                        //生产原版：清空已选转换后碎料，回到输入状态由操作者重选
                        $("#ConvertedScrapText").val("");
                        $("#ConvertedScrapText").focus();
                        $("#Number").val(barCode);
                    }
                    return false;
                }
                if (!ajax.value) {
                    showMsg("入明细失败：服务器无返回", 0);
                    pendingSn = barCode;
                    return false;
                }
                var list = JSON.parse(ajax.value).data || [];
                if (list.length > 0 && list[0]["FromChangeByMESNo"]) {
                    $("#FormChangeNo").val(list[0]["FromChangeByMESNo"]);
                }
                var usedQty = passQty;
                if (list.length > 0 && list[0]["BalanceQty"] != null && passQty <= 0) {
                    usedQty = parseFloat(list[0]["BalanceQty"]) || 0;
                }
                var orderNo = $.trim($("#FormChangeNo").val());
                var refreshed = PDAGetFormChangeList(orderNo);
                if (refreshed === false) {
                    //再查一次：偶发时序
                    refreshed = PDAGetFormChangeList(orderNo);
                }
                if (refreshed === false) {
                    showMsg("已提交但明细刷新失败，单号：" + orderNo + "，请点单据重载", 0);
                    pendingSn = "";
                    pendingBalance = 0;
                    pendingMaterial = "";
                    resetScrapUI();
                    $("#Number").removeAttr("disabled");
                    $("#Number").val("").focus();
                    return false;
                }
                var rowCount = $("#DNInfotab tbody tr").length;
                if (rowCount <= 0) {
                    showMsg("明细为空，请检查单号 " + orderNo, 0);
                    return false;
                }
                pendingSn = "";
                pendingBalance = 0;
                pendingMaterial = "";
                resetScrapUI();
                //生产原版入明细后清空数量；粉碎机模式保留本次提交数量便于连扫参考
                $("#Qty").val(isCrusherMode() ? usedQty : "");
                $("#Number").removeAttr("disabled");
                $("#Number").val("").focus();
                showMsg("已入明细(" + rowCount + "行)，请扫下一条GRN", 1);
                setTimeout(function () {
                    if ($("#msg").html().indexOf("已入明细") >= 0) {
                        $("#msg").html("");
                    }
                }, 1500);
                return true;
            } finally {
                confirmingLine = false;
            }
        }

        /*扫描条码：1候选直接入明细；多候选下拉选择后入明细；随后回焦GRN连扫*/
        var Scan = function () {
            $("#msg").html('');

            if (pendingSn) {
                var selectedMaterial = getScrapValue();
                if (!selectedMaterial) {
                    showMsg(!isCrusherMode() ? "请先选择转换后碎料！" : (isScrapManualMode() ? "请先输入转换后粉碎料" : "请先选择转换后碎料"), 0);
                    focusScrapInput();
                    return false;
                }
                //已有待入明细条码：不自动提交，也不覆盖，提示先点【入明细】
                showMsg("请先点【入明细】提交 " + pendingSn + " 的明细", 0);
                $("#Number").val(pendingSn);
                $("#enterGrn").focus();
                return false;
            }

            var sn = $.trim($("#Number").val());
            if (sn == "") {
                showMsg("请扫描条码", 0);
                $("#Number").val("").focus();
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFromChangeByMES.FromChangeMesScanGenerateEx($("#FormChangeNo").val(), sn, "", 0.00, 0, 2);
            if (ajax.error != null) {
                if (ajax.error.Message.indexOf("#1") > 0 && $("#FormChangeNo").val() == "") {
                    var str = ajax.error.Message;
                    const startOrder = str.indexOf('[') + 1;
                    const endOrder = str.indexOf(']');
                    const orderNumber = str.substring(startOrder, endOrder);
                    $("#FormChangeNo").val(orderNumber);
                    $("#Number").val("");
                    PDAGetFormChangeList(orderNumber);
                    showMsg("条码已在单据[" + orderNumber + "]，已刷新明细", 0);
                    $("#Number").focus();
                    return false;
                }
                showMsg(ajax.error.Message, 0);
                $("#Number").val("").focus();
                return false;
            }
            var list = JSON.parse(ajax.value).data;
            $("#FormChangeNo").val(list[0]["FromChangeByMESNo"]);
            $("#FormChangeNo").attr("disabled", "disabled");
            $("#rawMaterialBeforeConversionItemName").val(list[0]["ItemName"]);
            $("#rawMaterialBeforeConversionItemCode").val(list[0]["ItemCode"]);
            var ConvertedMaterial = list[0]["ConvertedMaterial"];
            var balanceQty = parseFloat(list[0]["BalanceQty"]) || 0;
            var candCnt = parseInt(list[0]["CandidateCount"], 10) || 0;
            //按 GRN 来源切换模式：IsCrusherGRN=1 走粉碎机新逻辑，否则回生产原版（老 SP 无该列时按原版）
            //注意：ComMethodTemplate.StringFormat 对 bit 列序列化为 true/false，需兼容 boolean/1/0/"1"/"true"
            var crusherFlag = list[0]["IsCrusherGRN"];
            var isCrusher = (crusherFlag === true || crusherFlag === 1 || crusherFlag === "1"
                || crusherFlag === "true" || crusherFlag === "True");
            setScrapMode(isCrusher ? "crusher" : "normal");

            if (!isCrusher) {
                /*生产原版：不自动填数量，扫完弹「选择物料」面板由操作者自由搜料*/
                pendingSn = sn;
                pendingBalance = balanceQty;
                pendingMaterial = "";
                $("#Qty").val("");
                $("#ConvertedScrapText").val(ConvertedMaterial || "");
                $("#Number").attr("disabled", "disabled");
                if (ConvertedMaterial == null || ConvertedMaterial == "") {
                    showMsg("扫描成功，请选择转换后碎料", 1);
                    setTimeout(function () {
                        if ($("#msg").html().indexOf("扫描成功") >= 0) {
                            $("#msg").html("");
                        }
                    }, 1500);
                    chooseItem();
                    return;
                }
                showMsg("扫描成功", 1);
                setTimeout(function () {
                    if ($("#msg").html().indexOf("扫描成功") >= 0) {
                        $("#msg").html("");
                    }
                }, 1500);
                $("#Qty").focus();
                return;
            }

            //转换后数量默认=转换前余额，操作者可改填重量
            $("#Qty").val(balanceQty);

            if (ConvertedMaterial != null && ConvertedMaterial != "") {
                //带出转换后碎料但不自动入明细：回填后等操作者点【入明细】
                pendingSn = sn;
                pendingBalance = balanceQty;
                pendingMaterial = ConvertedMaterial;
                resetScrapSelect(ConvertedMaterial);
                showMsg("扫描成功，转换后碎料=" + ConvertedMaterial + "，请点【入明细】", 1);
                setTimeout(function () {
                    if ($("#msg").html().indexOf("请点【入明细】") >= 0) {
                        $("#msg").html("");
                    }
                }, 1500);
                $("#enterGrn").focus();
                return;
            }
            //多候选：等人工选择（选择后需人点【入明细】）；优先本单已选06
            var orderMaterial = "";
            var firstRow = $("#DNInfotab tbody tr").first().find("td").eq(3).text();
            if (firstRow) {
                orderMaterial = $.trim(firstRow);
            }
            //0 候选：切换为手动输入粉碎料（SP 已放开 0 候选，不再报错）
            if (candCnt <= 0) {
                fillScrapManual(sn, balanceQty, orderMaterial);
                return;
            }
            fillScrapSelect(sn, balanceQty, orderMaterial);
        };

        /*扫描库位*/
        var ScanCBarcode = function () {
            $("#msg").html('');
            if ($("#FormChangeNo").val() == '' || $("#FormChangeNo").val() == null) {
                confirmDialog('请选择形态转换单！');
                return false;
            }

            var barcode = $.trim($("#cBarCode").val());
            if (barcode == "") {
                showMsg("请扫描库位条码", 0);
                $("#cBarCode").val("").focus();
                return false;
            }

            var scanresult = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.ScanCBarCode(barcode);

            if (scanresult.value != '') {
                $("#msg").html('库位不存在').css('color', '#ff0000');
                $("#cBarCode").focus()
                return false;
            } else {
                $("#msg").html('库位扫描成功').css('color', "#00FF00");
                $("#MiniPackQty").focus();
            }
        };

        var ScanQty = function () {
            if (pendingSn) {
                var selMaterial = getScrapValue();
                if (!selMaterial) {
                    showMsg(!isCrusherMode() ? "请选择转换后碎料！" : (isScrapManualMode() ? "请输入转换后粉碎料(06开头)" : "请选择转换后碎料"), 0);
                    focusScrapInput();
                    return;
                }
                confirmLine(pendingSn, selMaterial, pendingBalance);
                return;
            }
            showMsg("请扫描条码", 0);
            $("#Number").focus();
        }

        $("#enterGrn").on("click", function () {
            ScanQty();
        });

        $("#chooseScrap").on("click", function () {
            chooseItem();
        });

        $("#CleanGrn").on("click", function () {
            pendingSn = "";
            pendingBalance = 0;
            pendingMaterial = "";
            resetScrapUI();
            $("#Number").removeAttr("disabled");
            $("#Number").val("").focus();
            $("#Qty").val("");
        });
        //确认进行转换
        function Save() {
            if (pendingSn) {
                var selMaterial = getScrapValue();
                if (!selMaterial) {
                    confirmDialogFocus(!isCrusherMode() ? "请选择转换后碎料后点【入明细】" : (isScrapManualMode() ? "请输入转换后粉碎料(06开头)后点【入明细】" : "请选择转换后碎料后点【入明细】"), function () {
                        focusScrapInput();
                    });
                    return false;
                }
                //需人点【入明细】提交明细，确认转换不代提交
                confirmDialogFocus("已选 " + selMaterial + "，请先点【入明细】再确认转换", function () {
                    $("#enterGrn").focus();
                });
                return false;
            }

            var grnLength = $("#DNInfotab tbody").find("tr").length;
            if (grnLength <= 0) {
                confirmDialogFocus("请扫描转换GRN", function () {
                    $("#Number").select();
                });
                return false;
            }
            var cBarCode = $.trim($("#cBarCode").val());
            if (cBarCode == "") {
                confirmDialogFocus("请扫描转换后库位", function () {
                    $("#cBarCode").select();
                });
                return false;
            }

            var miniPack = $.trim($("#MiniPackQty").val());
            if (isNaN(miniPack) || miniPack == "") {
                showMsg("请输入正确的最小包装数量", 0);
                $("#MiniPackQty").val("").select();
                return false;
            }

            var entity =
            {
                FromChangeByMESNo: $.trim($("#FormChangeNo").val()),
                cBarCode: cBarCode,
                MiniPackQty: parseInt(miniPack),
                ModifyBy: userName,
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFromChangeByMES.SaveFormChangeMES(JSON.stringify(entity));
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                return false;
            }


            $("#msg").html('形态转换成功').css('color', "#00FF00")

            $("#Number").removeAttr("disabled");
            $("#FormChangeNo").removeAttr("disabled");
            $("#FormChangeNo").val("");
            pendingSn = "";
            pendingBalance = 0;
            pendingMaterial = "";
            resetScrapUI();
            $("#rawMaterialBeforeConversionItemName").val("");
            $("#rawMaterialBeforeConversionItemCode").val("");
            $("#Qty").val("");
            $("#cBarCode").val("");
            $("#MiniPackQty").val("");
            $('#listview').html('');
            $("#DNInfotab tbody").html('');
            var grns = ajax.value;
            //如果勾选了打印新GRN
            if ($("#PrintNew").prop('checked')) {
                Print(grns);
            }

        }

        function getGrnStrings(jsonString) {
            // 将JSON字符串解析为JavaScript对象
            var jsonObject = JSON.parse(jsonString);
            // 初始化一个空字符串用于拼接
            var grnStringList = "";
            // 遍历JSON中的每条记录
            jsonObject.data.forEach(function (record) {
                // 提取每条记录的GRNString
                var grnString = record.GRNString;
                // 将当前的GRNString添加到列表中
                // 如果列表不为空，则在添加前加上逗号
                if (grnStringList !== "") {
                    grnStringList += ",";
                }
                grnStringList += grnString;
            });
            // 返回拼接好的字符串
            return grnStringList;
        }

        //弹出面板选择装箱单
        function CheckDNlist(data) {
            $("#FormChangeNo").val($(data).html());
            PDAGetFormChangeList($("#FormChangeNo").val());
            // $("#msg").html('形态转换单扫描成功').css("color", "green");
            $("#mypanel").panel("close");
            $("#Number").focus();
            $("#FormChangeNo").attr("disabled", "disabled");
        }

        function CheckItemlist(data) {
            var material = $(data).attr("id") || $(data).html().split(" ")[0];
            $("input[data-type='search']").val('');
            $("#mypanelItem").panel("close");
            if (!isCrusherMode()) {
                //生产原版：选中回填输入框，焦点转到数量，由操作者点【入明细】提交
                $("#ConvertedScrapText").val(material);
                $("#Qty").focus();
                return;
            }
            resetScrapSelect(material);
            if (pendingSn) {
                //选料只回填：必须人点【入明细】才提交
                pendingMaterial = material;
                showMsg("已选择 " + material + "，请点【入明细】", 1);
                $("#enterGrn").focus();
            } else {
                showMsg("已选择转换后碎料", 1);
                $("#Number").focus();
            }
        }

        //获取形态转换单
        function PDAGetFormChangeList(code) {
            var data1 = SKT.LeanMES.Web.AjaxServices.Client.AjaxFromChangeByMES.GetFromChangeByNo(code);
            if (data1.error != null) {
                $("#msg").html(data1.error.Message).css("color", "red");
                return false;
            }

            $("#msg").html('');
            var list = JSON.parse(data1.value).data || [];
            if (list.length <= 0) {
                //入明细后刷新为空时不要清空单号，便于排查
                $("#msg").html('单据[' + code + ']明细为空或已转换完成!').css('color', '#ff0000');
                return false;
            }
            $("#DNInfotab tbody").html('');
            var htmlstr = "";
            for (var i = 0; i < list.length; i++) {

                htmlstr += "<tr>";
                htmlstr += "<td>" + (i + 1) + "</td>";
                htmlstr += "<td>" + list[i].BarCode + "</td>";
                htmlstr += "<td>" + list[i].PreConversionMaterial + "</td>";
                htmlstr += "<td>" + list[i].ConvertedMaterial + "</td>";
                htmlstr += "<td>" + list[i].ConvertedQty + "</td>";
                htmlstr += "<td><a href='javascript:void(0);' onclick=\"DeleteBarCode('" + list[i].FromChangeByMESDtId + "','" + code + "')\"><%=Resources.lang.Delete %></a></td>";
                htmlstr += "</tr>";

                $("#rawMaterialBeforeConversionItemName").val(list[0]["ItemName"]);
                $("#rawMaterialBeforeConversionItemCode").val(list[0]["PreConversionMaterial"]);
            }
            $("#DNInfotab tbody").append(htmlstr);
            $("#DNInfotab").table("refresh");
            return true;
        }

        function DeleteBarCode(SrapFeedingDtId, Code) {
            var ajax = SKT.LeanMES.Web.AjaxServices.Client.AjaxFromChangeByMES.FromChangeByMESDeleteBarCode(SrapFeedingDtId);
            if (ajax.error != null) {
                confirmDialog(ajax.error.Message);
                return false;
            }
            $("#DNInfotab tbody").html('');
            PDAGetFormChangeList(Code);
            $("#msg").html("删除成功!").css("color", "#7FFF00");
            $("#Number").removeAttr("disabled");
            $("#Number").val("").focus();
            setTimeout(function () {
                $("#msg").html("");
            }, 1500);
        }

        //扫描类型选择事件
        var Scantype = function (code) {
            switch (code) {
                case -1:
                    ScanType = -1;
                    $("#scantype").html('扫描GRN');
                    break;
                case 0:
                    ScanType = 0;
                    $("#scantype").html('扫描SN');
                    break;
                case 1:
                    ScanType = 1;
                    $("#scantype").html('扫描卡通箱');
                    break;
                case 2:
                    ScanType = 2;
                    $("#scantype").html('扫描栈板');
                    break;
                case 3:
                    ScanType = 3;
                    $("#scantype").html('扫描客户SN');
                    break;
            }
            $("#scantypepopup").popup("close");
            setTimeout('$("#Number").val("").focus()', 100);
        };


        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }

        function showDetail(objDom, salOrderDtlID) {
            var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderDtlMemberList(salOrderDtlID);
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            var m = data.value;
            var htmlstr = "";
            if (m.length == 0) {
                htmlstr += '<tr class="ListTableOddRow"><td colspan="10" style="text-align: center;">暂无数据</td></tr>';
            }
            else {
                for (var i = 0; i < m.length; i++) {
                    htmlstr += "<tr>";
                    htmlstr += "<td>" + (i + 1) + "</td>";
                    htmlstr += "<td>" + m[i].Number + "</td>";
                    htmlstr += "<td>" + m[i].Qty + "</td>";
                    htmlstr += "</tr>";
                }
            }
            $("#Table1 tbody").html("");
            $("#Table1 tbody").append(htmlstr);
        }


        function Print(grns) {

            if (grns == "" || grns == null || grns.length == 0) {
                return;
            }
            var grnArray = grns.split(",");
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.ItemList = [];
            for (var i = 0; i < grnArray.length; i++) {

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grnArray[i]);

                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                if (ajax.value == null || ajax.value.SerialNumber == null) {
                    $("#msg").html("无效的GRN或者该GRN对应的Item不存在！").css("color", "red");
                    return false;
                }

                try {
                    labelItemId = ajax.value.PartId;
                    //是否供应商打印调用不同的模板
                    var IsSupper = ajax.value.IsSuplySerialNumber;
                    if (IsSupper) {
                        labelType = -24; //调用供应商模板
                    }
                    else {
                        labelType = -3;
                    }
                    //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                    getDocumentInfo();

                    //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                    SNInfo.SNList.push(grnArray[i]);
                    SNInfo.ItemList.push(ajax.value.PartId);
                }
                catch (e) {
                    $("#msg").html(e).css("color", "red");
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
        var labelType = -3;          //标签类型 (-2：SN，-3：GRN)
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
                debugger
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            } catch (e) {
                $("#msg").html(e).css("color", "red");
                return false;
            }
        }

        //加法 
        function accAdd(arg1, arg2) {
            var r1, r2, m;
            try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
            try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
            m = Math.pow(10, Math.max(r1, r2))
            return (arg1 * m + arg2 * m) / m
        }
        //数组之和 (小数)
        function NumsAdd(arr) {
            var result = 0;
            for (var i = 0; i < arr.length; i++) {
                result = accAdd(result, accAdd(0, arr[i]));
            }
            return result;
        }

    </script>
</body>
</html>
