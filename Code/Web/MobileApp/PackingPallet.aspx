<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PackingPallet.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PackingPallet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script>
        //打印查询需要的参数
        var _root = "";
        var _lang = "zh-cn";
    </script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>
    <title>包装栈板</title>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }

        table { font-size: 12px !important; }

        .operate > div { float: left; }

        .chk-print label.ui-btn { border: 0px; margin-top: 10px; }

        .ui-table-columntoggle-btn { display: none !important; }
        .auto-generate { margin-left: 50px; position: relative; }
            .auto-generate div.ui-slider { top: 10px; }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <label style="font-size: 17px !important; font-weight: bold; color: #fff">包装栈板</label>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <div class="operate">
                    <div>
                        <a href="#" id="Save" class="ui-btn ui-btn-inline">保存</a>
                    </div>
                    <div class="auto-generate">
                        自动生成栈板号：
                            <select id="autoGeneratePalletSN" data-role="slider" data-mini="true" style="top: 20px;">
                                <option value="1">开</option>
                                <option value="0">关</option>
                            </select>
                    </div>
                </div>
                <div style="clear: both"></div>
                <div class="ui-field-contain pallet-no" style="display:none;">
                    <label for="txtPalletSN">输入栈板号码：</label>
                    <input type="text" id="txtPalletSN" />
                </div>
                <div class="ui-field-contain">
                    <label for="txtPackSN">输入包装箱号码：</label>
                    <input type="text" id="txtPackSN" />
                </div>
                <div id="error-msg" style="text-align: center; color: red;"></div>
                <div class="ui-field-contain">
                    <label>产品编码：<span id="itemCode"></span></label>
                    <label>产品名称：<span id="itemName"></span></label>
                    <label>产品规格：<span id="itemSpec"></span></label>
                </div>
                <div class="ui-field-contain">
                    <label>外箱数量：<span id="outBoxQty"></span></label>
                    <label>产品数量：<span id="itemQty"></span></label>
                </div>
                <table id="outBoxList" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke ui-table ui-table-columntoggle" style="width: 100%; margin-top: 20px;">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>外箱号码</th>
                            <th>数量</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var noData = "<tr><td colspan=\"4\" style=\"text-align: center;\">暂无数据</td></tr>";
            var outBoxNoArr = [];//扫描的外箱号码集合
            
            var ItemId = -1;//产品ID
            var ProdOrderId = -1;//工单ID
            var ArrPackSN = "";

            $(function () {
                $("#txtPackSN,#txtPalletSN").blur(function () { $(this).css("background-color", "#fff") }).focus(function () { $(this).css("background-color", "#ffffcc") });
                $("#txtPackSN").focus();

                //表格默认显示暂无数据
                $("#outBoxList tbody").html(noData);

                $('#autoGeneratePalletSN').on('change', function () {
                    var selVal = $("#autoGeneratePalletSN").val();
                    if (selVal == 1) {
                        $(".pallet-no").hide();
                        $("#txtPackSN")[0].focus();
                    } else {
                        $(".pallet-no").show();
                        $("#txtPalletSN")[0].focus();
                    }
                });

                //包装箱号码回车事件
                $("#txtPackSN").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        GetPackSNItemInfo();
                    }
                });

                //栈板箱号码回车事件
                $("#txtPalletSN").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        var palletSN = $.trim($("#txtPalletSN").val());
                        if (palletSN == "") {
                            //confirmDialogFocus("请输入栈板号", function () {
                            //    $("#itemCode").html("");
                            //    $("#itemName").html("");
                            //    $("#itemSpec").html("");
                            //    $("#txtPalletSN").focus();
                            //});
                            $("#error-msg").html("请输入栈板号");
                            $("#itemCode").html("");
                            $("#itemName").html("");
                            $("#itemSpec").html("");
                            $("#txtPalletSN").focus();
                            return;
                        }
                        //获取栈板信息
                        var entity = {};
                        entity.PSN = palletSN;
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPrepSerialNumberInfo(entity);
                        if (ajax.error != null) {
                            //confirmDialogFocus(ajax.error.Message, function () {
                            //    $("#txtPalletSN").select().focus();
                            //});
                            $("#error-msg").html(ajax.error.Message);
                            $("#txtPalletSN").val("").focus();
                            return;
                        }
                        var palletSNInfo = ajax.value;
                        if (palletSNInfo.StatusId == 2) {
                            //confirmDialogFocus("栈板号已使用", function () {
                            //    $("#txtPalletSN").select().focus();
                            //});
                            $("#error-msg").html("栈板号已使用");
                            $("#txtPalletSN").val("").focus();
                            return;
                        }
                        //$("#itemCode").html(palletSNInfo.ItemCode);
                        //$("#itemName").html(palletSNInfo.ItemName);
                        //$("#itemSpec").html(palletSNInfo.ItemSpec);
                        $("#error-msg").html("");
                        $("#txtPackSN")[0].focus();
                    }
                });

                //保存事件
                $("#Save").on("click", function () {
                    var palletSN = $.trim($("#txtPalletSN").val());
                    var autoGenerate = $("#autoGeneratePalletSN").val();
                    if (autoGenerate == 0 && palletSN == "") {
                        $("#txtPalletSN")[0].focus();
                        return;
                    }

                    if (outBoxNoArr == null || outBoxNoArr.length <= 0) {
                        //confirmDialogFocus("请扫描包装箱号码", function () {
                        //    $("#txtPackSN").select();
                        //});
                        $("#error-msg").html("请扫描包装箱号码");
                        $("#txtPackSN").val("").focus();
                        return;
                    }

                    ArrPackSN = "";
                    for (var i = 0; i < outBoxNoArr.length; i++) {
                        ArrPackSN += outBoxNoArr[i].PackSN + ",";
                    }
                    ArrPackSN = ArrPackSN.substring(0, ArrPackSN.length - 1)
                    //绑定栈板与包装箱关系
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.SavePackPalletRelation(ArrPackSN, ItemId, ProdOrderId, palletSN);
                    if (ajax.error != null) {
                        //confirmDialogFocus(ajax.error.Message);
                        $("#error-msg").html(ajax.error.Message);
                        return;
                    }
                    confirmDialogFocus("栈板包装成功,栈板号:【" + ajax.value + "】", function () {
                        //清空数据
                        Clear();
                    });
                });
            });

            //根据包装箱号获取产品信息
            function GetPackSNItemInfo() {
                //outBoxNoArr = [];
                var PackSN = $.trim($("#txtPackSN").val());
                if (PackSN == "") {
                    //confirmDialogFocus("包装箱不能为空", function () {
                    //    $("#txtPackSN").val("").focus();
                    //});
                    $("#error-msg").html("包装箱不能为空");
                    $("#txtPackSN").val("").focus();
                    return;
                }
                if (existsPackSN(PackSN)) {
                    //confirmDialogFocus("该包装箱已经添加", function () {
                    //    $("#txtPackSN").select().focus();
                    //});
                    $("#error-msg").html("该包装箱已经添加");
                    $("#txtPackSN").val("").focus();
                    return false;
                }

                //获取数据
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPackSNItemInfo(PackSN);
                if (ajax.error != null) {
                    //confirmDialogFocus(ajax.error.Message, function () {
                    //    $("#txtPackSN").select().focus();
                    //});
                    $("#error-msg").html(ajax.error.Message);
                    $("#txtPackSN").val("").focus();
                    return;
                } else {
                    //绑定产品信息
                    var item = ajax.value.Rows[0];

                    //判断第二个包装箱与上一个包装箱的产品是否一致
                    if (outBoxNoArr.length > 0) {
                        if (item.ItemCode != $("#itemCode").html()) {
                            //confirmDialogFocus("该包装箱的产品与上一个包装箱产品不一致", function () {
                            //    $("#txtPackSN").select().focus();
                            //});
                            $("#error-msg").html("该包装箱的产品与上一个包装箱产品不一致");
                            $("#txtPackSN").val("").focus();
                            return false;
                        }
                    }

                    $("#itemCode").html(item.ItemCode);
                    $("#itemName").html(item.ItemName);
                    $("#itemSpec").html(item.ItemSpec);
                    $("#itemQty").html(item.PackQty);
                    ItemId = item.ItemID;
                    ProdOrderId = item.ProdOrderId;

                    var obj = {};
                    obj.PackSN = PackSN;
                    obj.PackQty = item.PackQty;
                    obj.ItemCode = item.ItemCode;
                    outBoxNoArr.push(obj);
                    Show();
                    $("#outBoxQty").html(outBoxNoArr.length);
                    $("#error-msg").html("");
                }
                $("#txtPackSN").val("").focus();
            }

            function Show() {
                var data = "";
                $("#outBoxList tbody").html("");
                //将包装箱数组拼接成HTML代码
                var html = bullderScanHtml();
                $("#outBoxList tbody").append(html);
            }

            //将数组拼接成HTML代码
            function bullderScanHtml() {
                var html = "";
                for (var i = 0; i < outBoxNoArr.length; i++) {
                    //ArrPackSN = ArrPackSN + outBoxNoArr[i].PackSN + ",";
                    html += "<tr><td>" + (i + 1) + "</td>"
                        + "<td>" + outBoxNoArr[i].PackSN + "</td>"
                        + "<td>" + outBoxNoArr[i].PackQty + "</td>"
                        + "<td><img title='删除' src='../Content/images/delete.gif' onclick=Delet('" + outBoxNoArr[i].PackSN + "')></img></td></tr>";
                }
                return html;
            }

            //判断包装箱是否已经添加
            function existsPackSN(PackSN) {
                for (var i = 0; i < outBoxNoArr.length; i++) {
                    if (outBoxNoArr[i].PackSN == PackSN) {
                        return true;
                    }
                }
                return false;
            }


            //删除包装箱
            function Delet(PackSN) {
                var idx = -1;
                for (var i = 0; i < outBoxNoArr.length; i++) {
                    if (outBoxNoArr[i].PackSN == PackSN) {
                        idx = i;
                        break;
                    }
                }
                if (idx > -1) {
                    outBoxNoArr.splice(idx, 1);
                }
                //重置列表
                var html = bullderScanHtml();
                $("#outBoxList tbody").html(html);
                $("#outBoxQty").html(outBoxNoArr.length);
            }

            //清空界面数据
            function Clear() {
                outBoxNoArr = [];
                ItemId = -1;//产品ID
                ProdOrderId = -1;//工单ID                
                ArrPackSN = "";
                $("#txtPalletSN").val("");
                $("#txtPackSN").val("");
                $("#itemCode").html("");
                $("#itemName").html("");
                $("#itemSpec").html("");
                $("#outBoxQty").html("");
                $("#itemQty").html("");
                $("#outBoxList tbody").html(noData);
                var selVal = $("#autoGeneratePalletSN").val();
                if (selVal == 1) {
                    $("#txtPackSN")[0].focus();
                } else {
                    $("#txtPalletSN")[0].focus();
                }
                $("#error-msg").html("");
            }

        </script>
    </form>
</body>
</html>
