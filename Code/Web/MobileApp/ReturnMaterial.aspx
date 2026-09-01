<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.ReturnMaterial" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

    <title>生产退料申请</title>
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
        <div data-role="page" data-url="setpage" class="bindpage" id="bindpage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">无单生产退料入库</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-ajax="false" data-theme="c">无单申请</a></li>
                        <li><a href="#searchpage" data-ajax="false" data-theme="c">查询</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="content">
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <label for="listno">
                                工单</label>
                        </td>
                        <td>
                            <input type="text" id="listno" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择工单</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="perparelist">
                                退料部门</label>
                        </td>
                        <td colspan="2">
                            <select name="deptNo" data-mini="true" id="deptNo" class="warehouse">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="perparelist">
                                仓库</label>
                        </td>
                        <td colspan="2">
                            <select name="warehouse" data-mini="true" id="warehouse" class="warehouse">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="CheckBox">
                                全部清点</label>
                        </td>
                        <td colspan="2">
                            <input type="checkbox" value="-1" id="chkMatchWholeWord" onclick="CheckAll();" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="showScanQty">
                                已扫描</label>
                        </td>
                        <td colspan="2">
                            <label id="showScanQty"></label>
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
                    <tr id="trGRNQty">
                        <td>
                            <label for="barcodes">
                                数量</label>
                        </td>
                        <td colspan="2">
                            <input id="txtGRNQty" type="text" value="" />

                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;"></div>
                <table id="tblExpand" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%; overflow-x: scroll; overflow-y: scroll;">
                    <thead>
                        <tr>
                            <th>GRN</th>
                            <th>清点数量</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a data-corners="false" onclick="Save()" data-role="button" data-fullscreen="true" data-theme="a">确认退料</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">

                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>

        </div>
        <div data-role="page" data-url="setpage" class="searchpage" id="searchpage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">无单生产退料入库</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
                <div data-role="navbar">
                    <ul>
                        <li><a href="#bindpage" data-ajax="false" data-theme="c">无单申请</a></li>
                        <li><a href="#" data-ajax="false" data-theme="c">查询</a></li>
                    </ul>
                </div>
                <!-- /navbar -->
            </div>
            <div data-role="content" style="width: 100%; overflow: scroll;">
                <table id="infotab" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%; overflow-x: scroll; overflow-y: scroll;">
                    <thead>
                        <tr>
                            <th>GRN</th>
                            <th>物料编码</th>
                            <th>领料单</th>
                            <th>退料数量</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        var prodOrder = "";
        var GRN = "";
        var grnQty = 0;
        $(document).bind("mobileinit", function () {
            $.mobile.ajaxEnabled = false;
        });

        //聚焦 失焦事件
        $(function () {
            $(".ui-body-c").css("background", "#fff");
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#listno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") })
            $("#listno").focus();
            //扫描工单
            $('#listno').on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($(this).val()) == "") {
                        $("#msg").html("工单不能为空！").css("color", "red");
                        $(this).val('').focus();
                        return false;
                    }
                    $("#infotab tbody").html('');
                    prodOrder = $.trim($(this).val());
                    if (prodOrder == "") {
                        $("#msg").html("请输入工单号！").css("color", "red");
                        confirmDialogFocus(ajax.error.Message, function () {
                            $(this).val('').focus();
                        });
                    }
                    //显示物料数据：
                    CheckAll();
                }
            });
            //仓库下拉
            $.ajax({
                type: "POST",
                url: "../Handler/WarehouseCheck.ashx?api=GetWarehouseInfo",
                async: false,
                dataType: "json",
                success: function (data) {
                    $.each(data, function (a, b) {
                        $("#warehouse").append("<option value='" + b.CWhCode + "'>" + b.CWhName + "</option>");
                    });
                },
                error: function (err) {
                    return;
                }
            });
            $("#warehouse").select("refresh");
            //选择备料部门
            $.ajax({
                type: "POST",
                url: "../Handler/WarehouseCheck.ashx?api=GetDepartInfo",
                async: false,
                dataType: "json",
                success: function (data) {
                    $.each(data, function (a, b) {
                        $("#deptNo").append("<option value='" + b.OrganizationId + "'>" + b.DepartName + "</option>");
                    });
                },
                error: function (err) {
                    return;
                }
            });
            $("#deptNo").select("refresh");
        });

        //根据字符串模糊查询采购单
        $("#listviews").on("filterablebeforefilter", function (e, data) {

            var $ul = $(this)
            $input = $(data.input)
            value = $input.val()
            $("#listviews").html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyMoCodeAll();
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
                if (ulhtml.indexOf(entity[i].MOCode) == -1) {
                    ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].MOCode + "</a></li>";
                }
            }
            $("#listviews").append(ulhtml);
            $("#listviews").listview("refresh");
        });
        function SetPOCode(Code) {       
            prodOrder = $(Code).html();
            $("#listno").val(prodOrder);
            CheckAll();
            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#fpanel").panel("close");
            $("#GRN").focus();
        }

        //进入查询页面
        $(document).on("pageshow", "#searchpage", function (event) {
            $(".ui-table-columntoggle-btn").css("display", "none");
        });

        //GRN，数量回车事件
        var GRN = "";
        var grnQty = 0;
        $("#GRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                GRN = $.trim($("#GRN").val());
                if (GRN != "") {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetMaInfo(GRN);
                    if (ajax.value == null) {
                        confirmDialogFocus("GRN在系统中不存在", function () {
                            $("#GRN").val('').focus();
                        });                     
                        return false;
                    }
                    $("#txtGRNQty").val(ajax.value.StockQty);
                    setTimeout(function () {
                        $("#txtGRNQty").focus();
                        $("#txtGRNQty").select();
                    }, 100);
                } else {
                    confirmDialogFocus("请输入GRN!", function () {
                        $("#GRN").val('').focus();
                    });
                    return false;
                }
            }
        });

        //GRN数量回车
        $("#txtGRNQty").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                grnQty = $.trim($("#txtGRNQty").val());
                if (grnQty == "") {
                    confirmDialogFocus("请输入GRN清点数量!", function () {
                        $("#txtGRNQty").val('').focus();
                    });
                    return false;
                } else {
                    if (isPositiveNum(this, 1)) {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckReturnApplyGRN(prodOrder, GRN, grnQty);
                        if (ajax.error != null) {
                            confirmDialog(ajax.error.Message);
                            clearGRNInfo();
                            return false;
                        }
                        else {
                            scanCount += 1;
                            var addHtml = "<tr grn ='" + GRN + "'><td>" + GRN + "</td><td>" + grnQty + "</td></tr>";
                            $("#tblExpand").append(addHtml);
                            $("#showScanQty").html(scanCount + "/" + grnCount);
                            clearGRNInfo();
                        }
                    }
                }
            }
        });

        $(document).on("pageshow", "#searchpage", function (event) {
            $(".ui-table-columntoggle-btn ui-btn ui-btn-a ui-corner-all ui-shadow ui-mini").css("display", "none");
        });

        function clearGRNInfo() {
            $("#GRN").val("");
            $("#txtGRNQty").val("");
            setTimeout(function () { $("#GRN").focus(); }, 100)

        }

        function isPositiveNum(obj, i) {//是否为正整数
            var s = $(obj).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(s)) {
                confirmDialogFocus("请输入正整数!", function () {
                    $(obj).val('').focus();
                });
                return false;
            } else {
                return true;
            }
        }

        function CheckAll() {
            if (prodOrder == "") {
                $("#msg").html("请选择要退料的工单！").css("color", "red");
                return false;
            }
            else {
                if ($('#chkMatchWholeWord').is(":checked")) {
                    //隐藏GRN和数量：
                    showApplyOrderDetail(2);
                    $("#trGRN").hide();
                    $("#trGRNQty").hide();
                    //更新已扫描数量为
                }
                else {
                    showApplyOrderDetail(1);
                    $("#trGRN").show()
                    $("#trGRNQty").show();
                }
            }
        }

        //通过工单查询信息
        //searchType：查询类型：1：正常查询  清点数量为空  2：全部选中，清点数量默认为退料数量
        var scanCount;
        var grnCount;
        function showApplyOrderDetail(searchType) {
            scanCount = 0;
            grnCount = 0;
            //每次加载删除除了第一行的数据
            $(".ui-table-columntoggle-btn ui-btn ui-btn-a ui-corner-all ui-shadow ui-mini").css("display", "none");
            $("#tblExpand tr:gt(0)").remove();
            $("#infotab tr:gt(0)").remove();
            $("#msg").html("");
            var grnList = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetAllReturnMaterial(prodOrder);
            if (grnList.error != null) {
                $("#msg").html(grnList.error.Message).css("color", "red");
                return false;
            } else {
                var addHtmlStr = "";
                var rightStr = "";
                grnCount = grnList.value.length;
                for (var i = 0; i < grnList.value.length; i++) {
                    var entity = grnList.value[i];
                    //push数据：
                    addHtmlStr += "<tr grn ='" + entity.SerialNumber + "' >";
                    addHtmlStr += "<td>" + entity.SerialNumber + "</td>"
                    addHtmlStr += "<td>" + entity.BalanceQty + "</td>"
                    addHtmlStr += "</tr>";

                    rightStr += "<tr><td>" + entity.SerialNumber + "</td><td>" + entity.ItemCode + "</td><td>" + entity.ApplyNo + "</td><td>" + entity.BalanceQty + "</td></tr>";
                }
                if (searchType == 1) {
                    $("#showScanQty").html(scanCount + "/" + grnCount);
                    $("#tblExpand").append("");
                }
                else {
                    $("#showScanQty").html(grnCount + "/" + grnCount);
                    $("#tblExpand").append(addHtmlStr);
                }
                $("#infotab").append(rightStr);
            }
        }

        function Save() {
            var GRNDetail = [];
            var deptId = $("#deptNo option:selected").val();
            var whCodeId = $("#warehouse option:selected").val();
            if (deptId == "") {
                confirmDialog("请选择退料部门!");
                return false;
            }
            if (whCodeId == "") {
                confirmDialog("请选择备料仓库!");
                return false;
            }
            var Reson = "";
            //遍历表中，清点的数据
            $("#tblExpand tr:gt(0)").each(function () {
                var grn = $(this).find("td").eq(0).text(); //GRN
                var grnQty = $(this).find("td").eq(1).text();  //GrnQty
                if (grnQty != "") {
                    GRNDetail.push({ "GRN": grn, "ReturnQty": grnQty });
                }
            });

            var entity = {};
            entity.ProdOrderNo = prodOrder;
            entity.DeptId = deptId;
            entity.WhId = whCodeId;
            entity.Remark = Reson;
            entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.TbDtl = JSON.stringify(GRNDetail);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveReturnApplyGRN(JSON.stringify(entity));
            if (ajax.error != null) {
                confirmDialog(ajax.error.Message);
                return false;
            }
            $("#msg").html("生产备料申请成功!").css("color", "green");
            $("#tblExpand tr:gt(0)").remove();
            $("#infotab tr:gt(0)").remove();
            clearInfo();
        }
        //清空数据
        function clearInfo() {
            prodOrder = "";
            $("#listno").val("");
            $("#showScanQty").html("");
            setTimeout(function () { $("#listno").focus(); }, 100);

        }
    </script>
</body>
</html>

