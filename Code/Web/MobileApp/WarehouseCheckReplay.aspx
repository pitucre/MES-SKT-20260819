<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WarehouseCheckReplay.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.WarehouseCheckReplay" %>

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
    <link href="js/layui/css/layui.css" rel="stylesheet" />
    <script src="js/layui/layui.js"></script>
    <title>仓库复盘</title>
    <style type="text/css">
        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        .ui-title {
            line-height: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" data-url="setpage" class="setpage" id="setpage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">仓库复盘</label>
                    </div>
                </h5>
                <a href="#" onclick="return BackFromScan();" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="#" onclick="return GoHomeFromScan();" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <!--<tr>
                       <td>
                            <label for="warehouse">
                                仓库:</label>
                        </td>
                        <td>
                            <select name="warehouse"  id="warehouse" class="warehouse">
                                <option></option>
                            </select>
                        </td>
                    </tr> -->
                    <tr>
                        <td>
                            <label for="orders">
                                盘点单:</label>
                        </td>
                        <td colspan="2">
                            <select name="select-custom-20" data-mini="true" id="orders" class="orders">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="cposcode">
                                当前库位:</label>
                        </td>
                        <td colspan="2">
                            <input class="cposcode" id="cposcode" type="text" data-theme="e"
                                data-clear-btn="true" placeholder="选择/扫码/手动输入库位" list="cposcodeList" />
                            <datalist id="cposcodeList"></datalist>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="orders">
                                扫描GRN:</label></td>
                        <td>
                            <input type="text" id="txtGRN" class="TextBox" />
                        </td>
                        <td>
                            <button id="entertxtGRN" type="button" style="line-height: 0.5">确认</button>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td>
                            <label for="orders">
                                复盘数量:</label></td>
                        <td>
                            <input type="text" id="txtQty" class="TextBox" isnumber='1' />
                        </td>
                        <td>
                            <button id="entertxtQty" type="button" style="line-height: 0.5">确认</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="orders">
                                备注:</label>
                        </td>
                        <td>
                            <input id="Remark" type="text" value="" class="TextBox" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center; font-size: 14px">
                </div>
                <div data-role="content" style="max-height: 380px; overflow: scroll;">
                    <table id="infotab" data-role='table' data-mode='columntoggle' class='ui-responsive table-stroke' style='width: 100%;'>
                        <thead>
                            <tr>
                                <th>仓库</th>
                                <th>库位条码</th>
                                <th>实际库位条码</th>
                                <th>GRN</th>
                                <th>物料编码</th>
                                <th>账面数量</th>
                                <th>初盘数量</th>
                                <th>复盘数量</th>
                                <th>盈亏</th>
                                <th>物料名称</th>
                                <th>物料规格</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="d">
                <div data-role="navbar">
                    <ul>
                        <li><a onclick="AcceptFirstResult()" data-role="button" data-theme="e">认可初盘结果</a></li>
                        <li><a onclick="Finish()" data-role="button" data-theme="d">盘点完成</a></li>
                    </ul>

                </div>
            </div>
        </div>
        <div id="showInfo" style="display: none; width: 100%; height: 70%">
            <label id="scanErrorMsg" style="display: none; color: red; font-weight: bold; text-align: center; width: 100%; padding: 4px;"></label>
    <table id="demo" lay-filter="test"></table>
</div>
        <script type="text/javascript">
            var ProdWarehouseCheckId = -1;
            var CheckListNo;//盘点单
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var CheckDifferenceListss = [];
            var noList = [];
            var curLocation = "";
            var hasScanned = false; //本次进入复盘界面后是否有扫描过(未点复盘完成退出时提醒)


            var layer;
            var table;
            var data = [];
          
            layui.use(function () {
                layer = layui.layer;
                table = layui.table;
                //第一个实例
                table.render({
                    elem: '#demo'
                    , height: 312
                    , data: data //数据接口
                    , limit: 999999999,
                     cols: [[ //表头
                        , { field: 'GRN', title: 'GRN', width: 160, minwidth: 160 }
                        , { field: 'ItemCode', title: '物料编码', width: 100 }
                        , { field: 'CPN', title: '客户料号', width: 100 }
                        , { field: 'BarCode', title: '库位', width: 100 }
                        , { field: 'RealBarCode', title: '实际库位', width: 100, edit: 'text' }
                        , { field: 'UsekQty', title: '复盘数量', width: 70, edit: 'text' }
                      

                    ]]
                });
            });


            $('#setpage').on('pagecreate', function (event) {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
            });
            $(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                $("input[name='qty']").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });
                //动态绑定
                $(document).on("keydown", "input[name='qty']", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        if (isPositiveNum(this)) {
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Scan(CheckListNo, $.trim($("#txtGRN").val()), $("input[name='qty']:focus").val(), userName, 2);
                            if (ajax.error != null) {
                                confirmDialog(ajax.error.Message);
                                return false;
                            }
                            $("#txtGRN").focus().select();
                            $("#msg").html("扫描成功").css("color", "#2ecc71");
                            CheckDifferenceList(CheckListNo);
                        }
                    }
                });
                //盘点单加载
                Orderselect();
            });

            $("#entertxtGRN").on('click', function () {
                EntertxtGRN();

            });
            $("#entertxtQty").on('click', function () {

                EntertxtQty();

            });
            function EntertxtGRN() {
                $("#msg").html("");


                if (CheckListNo == "" || CheckListNo == null || typeof (CheckListNo) == 'undefined') {
                    confirmDialog("请选择盘点单");
                    return false;
                }
                var grn = $.trim(($("#txtGRN").val()));
                if (!grn) {
                    confirmDialogFocus("请扫描物料条码/包装箱", function () {
                        $("grn").focus();
                    });
                    return false;
                }
                //扫码识别：如果扫的是库位条码，设为当前库位
                if (curLocation === "" || grn === curLocation) {
                    // 检查是否是有效的库位编码
                    var isLocation = false;
                    $.each(CheckDifferenceListss, function (i, e) {
                        if (e.BarCode === grn) {
                            isLocation = true;
                            return false;
                        }
                    });
                    if (isLocation || grn === curLocation) {
                        curLocation = grn;
                        $("#cposcode").val(curLocation);
                        showMsg("当前库位:" + curLocation, 1);
                        $("#txtGRN").val("").focus();
                        return false;
                    }
                }
                if (!curLocation) {
                    confirmDialogFocus("请先选择或扫描库位", function () {
                        $("#cposcode").focus();
                    });
                    return false;
                }
                //校验GRN
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetMaListInfo(grn);
                if (ajax.value == null || ajax.value.length == 0) {
                    //系统无此SN: 确认后按盘盈处理,构造模拟行走盘点弹窗,确认后由ScanBatch自动加入盘点单
                    if (!confirm("系统中未找到此SN，是否要盘点到当前库位【" + curLocation + "】下？")) {
                        $("#txtGRN").val("").focus();
                        return false;
                    }
                    ajax.value = [{ GRN: grn, PSN: null, Flag: -1, ItemCode: "(系统无此SN)", ItemName: "", BarCode: curLocation, RealBarCode: "", StockQty: 0 }];
                }
                var entity = ajax.value[0];
                //if (ajax.value.PFlag > -1 && ajax.value.PSN) {
                //    alert("包装过的物料请扫描包装条码【" + ajax.value.PSN + "】");
                //    $("txtGRN").val("");
                //    $("txtGRN").focus();
                //    return false;
                //}
                grn = entity.PSN == null ? entity.GRN : entity.PSN;  //如果包装箱PSN不为空则grn为包装箱号

                balanceQty = ajax.value.StockQty;

                //校验GRN是否已经盘点
                var ajaxCheck = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanCancelCheck(CheckListNo, grn, 2);
                if (ajaxCheck.value == 1) {
                    if (confirm("条码【" + grn + "】已经扫描，是否撤销扫描")) {
                        if (ajax.value.Flag != -1) {
                            //直接进行盘点撤销
                            var ajaxRollBack = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanRollback(CheckListNo, grn, userName, 2);
                            if (ajaxRollBack.error != null) {
                                alert(ajaxRollBack.error.Message);
                                return false;
                            }
                            //showOrderDelList()
                            //获取包装箱物料信息
                            var ajaxGrn = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetCheckOrderDetailInfoByPackageSN(grn, ProdWarehouseCheckId);
                            if (ajaxGrn.error != null) {
                                alert(ajaxGrn.error.Message);
                                return false;
                            }
                            var listGrn = ajaxGrn.value;
                            //更新盘点数量
                            var totalQty = 0;
                            if (listGrn && listGrn.length > 0) {
                                $.each(listGrn, function (i, o) {
                                    $('#infotab tr[grn="' + o.GRN + '"]').css("background-color", "#F8F8F8");
                                    var qty = o.FirstBy ? o.StockQty : o.BalanceQty;
                                    totalQty += qty;
                                    $("input[id='RepeatQty" + o.GRN + "']").val(qty);
                                });
                            }

                            showMsg(grn + "撤销成功", 1);
                            $("#txtGRN").val("");
                            $("#txtQty").val("");
                            $("#txtGRN").focus().select();
                            $("#txtQty").attr("disabled", true);
                        }
                        else {
                            //直接进行盘点撤销
                            var ajaxRollBack = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanRollback(CheckListNo, grn, userName, 2);
                            $('#infotab tr[grn="' + grn + '"]').css("background-color", "#F8F8F8");
                            $("#txtQty").val(balanceQty);
                            showMsg(grn + "撤销成功", 1);
                            $("#txtGRN").val("");
                            $("#txtQty").val("");
                            $("#txtGRN").focus().select();
                            $("#txtQty").attr("disabled", false);
                        }
                        CheckDifferenceList(CheckListNo);
                        return;
                    }
                }

                ////如果是包装箱
                //if (ajax.value.Flag != -1) {
                //    //直接进行盘点
                //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Scan(CheckListNo, grn, 0, userName, 2);
                //    if (ajax.error != null) {
                //        alert(ajax.error.Message);
                //        return false;
                //    }
                //    //获取包装箱物料信息
                //    ProdWarehouseCheckId = $("#orders option:selected").val();
                //    var ajaxGrn = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetCheckOrderDetailInfoByPackageSN(grn, ProdWarehouseCheckId);
                //    if (ajaxGrn.error != null) {
                //        alert(ajaxGrn.error.Message);
                //        return false;
                //    }
                //    var listGrn = ajaxGrn.value;
                //    var totalQty = 0;
                //    //更新盘点数量
                //    if (listGrn && listGrn.length > 0) {
                //        $.each(listGrn, function (i, o) {
                //            $('#infotab tr[id="' + o.GRN + '"]').css("background-color", "#7FFF00");
                //            var qty = o.FirstBy ? o.StockQty : o.BalanceQty;
                //            totalQty += qty;
                //            //$('#infotab tr[id="' + grn + '"]').find("td.qty").text(qty);
                //        });
                //        // $("#infotab").table("refresh");
                //    }
                //    $("#txtQty").val(totalQty);
                //    $("#txtQty").attr("disabled", true);
                //    showMsg(grn + "扫描成功", 1);
                //    $("#txtQty").focus().select();
                //    CheckDifferenceList(CheckListNo);
                //} else {


                    data = [];
                    for (var i = 0; i < ajax.value.length; i++) {
                        if (ajax.value[i].RealBarCode == null || ajax.value[i].RealBarCode == undefined || $.trim(ajax.value[i].RealBarCode) == "") {
                            ajax.value[i].RealBarCode = curLocation || ajax.value[i].BarCode;
                        }
                        data.push(ajax.value[i]);
                    }

                    table.reload("demo", { data: data });
                    layer.closeAll();
                    $(".layui-layer-shade").remove();
                    $("#scanErrorMsg").hide();
                    layer.open({
                        title: false,
                        type: 1,
                        btn: ['确认', '取消'],
                        content: $('#showInfo'), //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                        yes: function (index, layero) {
                            var list = table.getData("demo");
                            if (list != null) {
                                //校验盘点数量必输(允许显式输入0表示盘无)
                                for (var i = 0; i < list.length; i++) {
                                    if (list[i].UsekQty == null || list[i].UsekQty == undefined || $.trim(list[i].UsekQty) == "") {
                                        showMsg("GRN[" + list[i].GRN + "]未输入复盘数量，请填写后再确认", 0);
                                        return false;
                                    }
                                }
                                //实际库位与系统库位不一致时，先自动移库
                                for (var i = 0; i < list.length; i++) {
                                    var realBarCode = $.trim(list[i].RealBarCode);
                                    var sysBarCode = $.trim(list[i].BarCode);
                                    if (realBarCode != "" && sysBarCode != "" && realBarCode != sysBarCode) {
                                        var ajaxMove = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.MoveMaterial(realBarCode, list[i].GRN, CheckListNo);
                                        if (ajaxMove.error != null) {
                                            $("#scanErrorMsg").text(ajaxMove.error.Message).show();
                                            return false;
                                        }
                                        var moveMsg = ajaxMove.value == null || ajaxMove.value == undefined || $.trim(ajaxMove.value) == "" ? "已移库到库位【" + realBarCode + "】" : ajaxMove.value;
                                        showMsg(list[i].GRN + moveMsg, 1);
                                    }
                                }
                                let postData = [];
                                for (var i = 0; i < list.length; i++) {
                                    var obj = new Object();
                                    obj.GRN = list[i].GRN;
                                    if (list[i].UsekQty == null || list[i].UsekQty == undefined || $.trim(list[i].UsekQty) == "" || list[i].UsekQty <= 0) {
                                        obj.UsekQty = 0;
                                    } else {
                                        obj.UsekQty = Number(list[i].UsekQty);
                                    }
                                    postData.push(obj);
                                }
                                //直接进行盘点
                                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanBatch(CheckListNo, postData, 2);
                                if (ajax.error != null) {
                                    $("#scanErrorMsg").text(ajax.error.Message).show();
                                    return false;
                                }

                                showMsg(grn + "扫描成功", 1);
                                hasScanned = true;
                                $("#grn").val("");
                                $("#txtsum").val("");
                                $("#grn").focus().select();
                              
                                CheckDifferenceListNew(CheckListNo);
                                $("#txtGRN").val("").select();
                                $("#showInfo").css("display", "none")
                                layer.close(index); //如果设定了yes回调，需进行手工关闭
                            }

                        },

                        cancel: function (index, layero) {
                            layer.close(index)
                            $("#showInfo").css("display", "none")
                            return false;
                        }
                    });





                    //ProdWarehouseCheckId = $("#orders option:selected").val();
                    //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetCheckOrderDetailInfo(grn, ProdWarehouseCheckId);
                    //if (ajax.value == null) {
                    //    showMsg("GRN错误或不在盘点单中");
                    //    $("#txtGRN").val("").focus();
                    //    return false;
                    //}
                    //var entity = ajax.value;
                    //$("#txtQty").val(entity.FirstBy ? entity.StockQty : entity.BalanceQty);
                    //$("#txtQty").attr("disabled", false);
                    //$("#txtQty").focus().select();
                /*}*/
            }
            function EntertxtQty() {
                $("#msg").html("");
                var grn = $("#txtGRN").val();
                if (grn == '') {
                    confirmDialogFocus("请扫描GRN", function () {
                        $("#grn").focus();
                        return false;
                    })
                }
                var qty = $.trim($("#txtQty").val());
                if (qty == "") {
                    showMsg("请输入复盘数量", 0);
                    $(this).val("").focus();
                    return false;
                }
                if (!isGreaterThanOrEqualZero(qty)) {
                    showMsg("复盘数量[" + qty + "]格式不正确", 0);
                    $(this).val("").focus();
                    return false;
                }
                Check();
            }

            $("#txtGRN").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    EntertxtGRN();
                }
            });
            //复盘数量
            $("#txtQty").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    EntertxtQty();
                }
            });

            function Check() {
                if (CheckListNo == "" || CheckListNo == null || typeof (CheckListNo) == 'undefined') {
                    confirmDialog("请选择盘点单");
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Scan(CheckListNo, $.trim($("#txtGRN").val()), parseFloat($.trim($("#txtQty").val())), userName, 2);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    return false;
                }
                //扫描成功
                var grn = $.trim($("#txtGRN").val());
                //$('#infotab tr[id="' + grn + '"]').remove();// 移除扫描的GRN
                //$('#infotab tr[id="' + grn + '"]').find("td.qty").text($.trim($("#txtQty").val()));
                $('#infotab tr[id="' + grn + '"]').css("background-color", "#7FFF00");
                //$("#infotab").table("refresh");

                $("#msg").html(grn + "扫描成功").css("color", "#0000FF");
                hasScanned = true;
                $("#txtGRN").val("");
                $("#txtQty").val("");
                $("#txtGRN").focus().select();
                CheckDifferenceList(CheckListNo);
            }
            //盘点单change事件
            $("#orders").on("change", function () {
                CheckListNo = $("#orders option:selected").html();
                var data = $.grep(noList, function (e) {
                    return e.CheckOrder == CheckListNo;
                });
                if (data && data.length > 0) {
                    $("#Remark").val(data[0].Remark);
                }

                CheckDifferenceList(CheckListNo);
                Locationselect();
            });
            function CheckDifferenceList(CheckListNo) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.CheckDifferenceList(CheckListNo);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                }
                var htmlstr = "";
                var list = ajax.value;
                CheckDifferenceListss = list;
                $("#infotab tbody").html('');
                /* CheckDifferenceListss = list;
                 $("#infotab tbody").html('');
                 for (var i = 0; i < list.length; i++) {
                     var value = list[i].StockQty - list[i].BalanceQty;
                     htmlstr += "<tr><td>" + list[i].GRN + "</td>"
                             + "<td>" + list[i].BalanceQty + "</td>"
                             + "<td>" + list[i].StockQty + "</td>"
                             //+ "<td>" + list[i].NowQty + "</td>"
                             + (value >= 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                             + "<td><input type='text' name='qty' class='TextBox' disabled='disabled' value='" + list[i].NowQty + "'/></td>"
                             + "</tr>";
                 }*/
                //显示全部明细: 已盘(RepeatBy非空)高亮——重新进入页面可见已盘记录
                if (list.length > 0) {
                    $("#msg").html("");
                    for (var i = 0; i < (list.length >= 100 ? 100 : list.length) ; i++) {
                        var value = list[i].StockQty - list[i].BalanceQty;
                        var RepeatBy = list[i].RepeatBy;
                        var FirstBy = list[i].FirstBy;
                        var repeatQty = "";
                        var backGroundColor = "";
                        repeatQty = list[i].NowQty;
                        if (RepeatBy != "") {
                            backGroundColor = " style='background:#7FFF00'";
                        }

                        //获取盘点单明细信
                        htmlstr = "<tr  id =" + list[i].GRN + " grn='" + list[i].GRN + "'" + backGroundColor + "><td>" + list[i].Warehouse + "</td>"
                            + "<td>" + list[i].BarCode + "</td>"
                            + "<td>" + (list[i].RealBarCode || list[i].BarCode) + "</td>"
                            + "<td>" + list[i].GRN + "</td>"
                            + "<td>" + list[i].ItemCode + "</td>"
                            + "<td>" + list[i].BalanceQty + "</td>"
                            //+ (list[i].FirstBy == "" ? "<td></td>" : "<td>" + list[i].StockQty + "</td>")
                            + "<td>" + list[i].StockQty + "</td>"
                            + "<td class='RepeatQty'>" + repeatQty + "</td>"
                            + (value == 0 ? "<td >" + value + "</td>" : value > 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                            //  + (value >= 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                            + "<td>" + list[i].ItemName + "</td>"
                            + "<td>" + list[i].ItemSpec + "</td>"
                            + "</tr>";
                        $("#infotab tbody").append(htmlstr);
                    }
                } else {
                    $("#msg").html("该单号无需盘点").css("color", "#0000FF");
                }
                //$("#infotab tbody").html(htmlstr);
                //$("#infotab").table("refresh");
            }

            function CheckDifferenceListNew(CheckListNo) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.CheckDifferenceList(CheckListNo);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                }
                var htmlstr = "";
                var list = ajax.value;
                $("#infotab tbody").html('');

                if (list.length > 0) {
                    $("#msg").html("");
                    for (var i = 0; i < (list.length >= 100 ? 100 : list.length); i++) {
                        var value = list[i].StockQty - list[i].BalanceQty;
                        var RepeatBy = list[i].RepeatBy;
                        var FirstBy = list[i].FirstBy;
                        var repeatQty = "";
                        var backGroundColor = "";
                        repeatQty = list[i].NowQty;
                        if (RepeatBy != "") {
                            backGroundColor = " style='background:#7FFF00'";
                        }

                        //获取盘点单明细信
                        htmlstr = "<tr  id =" + list[i].GRN + " grn='" + list[i].GRN + "'" + backGroundColor + "><td>" + list[i].Warehouse + "</td>"
                            + "<td>" + list[i].BarCode + "</td>"
                            + "<td>" + (list[i].RealBarCode || list[i].BarCode) + "</td>"
                            + "<td>" + list[i].GRN + "</td>"
                            + "<td>" + list[i].ItemCode + "</td>"
                            + "<td>" + list[i].BalanceQty + "</td>"
                            //+ (list[i].FirstBy == "" ? "<td></td>" : "<td>" + list[i].StockQty + "</td>")
                            + "<td>" + list[i].StockQty + "</td>"
                            + "<td class='RepeatQty'>" + repeatQty + "</td>"
                            + (value == 0 ? "<td >" + value + "</td>" : value > 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                            //  + (value >= 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                            + "<td>" + list[i].ItemName + "</td>"
                            + "<td>" + list[i].ItemSpec + "</td>"
                            + "</tr>";
                        $("#infotab tbody").append(htmlstr);
                    }
                } else {
                    $("#msg").html("该单号无需盘点").css("color", "#0000FF");
                }
                //$("#infotab tbody").html(htmlstr);
                //$("#infotab").table("refresh");
            }
            //仓库下拉
            function Warehouseselect() {
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
            };
            //盘点单下拉
            function Orderselect() {
                $("#orders").html(' <option></option>');
                $.ajax({
                    type: "POST",
                    url: "../Handler/WarehouseCheck.ashx?api=GetWarehouseCheckListInfo",
                    async: false,
                    dataType: "json",
                    data: { "warehouseid": -1, "flag": 2 },
                    success: function (data) {
                        noList = data;
                        $.each(data, function (a, b) {
                            ProdWarehouseCheckId = b.ProdWarehouseCheckId;
                            var iddd = b.CheckType + "_" + b.StatusDesc + "_" + b.BeginDate + "_" + b.Remark;
                            $("#orders").append("<option value=" + b.ProdWarehouseCheckId + ">" + b.CheckOrder + "</option>");
                        });
                    },
                    error: function (err) {
                        return;
                    }
                });
                $("#orders").selectmenu('refresh', true);
                $(".type").val('');
                $(".status").val('');
                $(".datetime").val('');
                $(".remark").val('');
            };
            //库位下拉（支持手动输入和扫码）
            function Locationselect() {
                // 清空datalist选项
                $("#cposcodeList").html('');
                var locationMap = {};
                $.each(CheckDifferenceListss, function (i, e) {
                    if (e.BarCode && !locationMap[e.BarCode]) {
                        locationMap[e.BarCode] = true;
                        $("#cposcodeList").append("<option value='" + e.BarCode + "'>");
                    }
                });
                curLocation = "";
                $("#cposcode").val("");
            }
            //当前库位change事件（下拉选择或手动输入后触发）
            $(document).on("change", "#cposcode", function () {
                curLocation = $(this).val().trim();
                if (curLocation) {
                    showMsg("当前库位:" + curLocation, 1);
                    $("#txtGRN").focus();
                }
            });
            //认可初盘结果：将初盘数量复制到复盘数量
            function AcceptFirstResult() {
                if ($("#infotab tr").length <= 1) {
                    confirmDialog("暂无盘点数据");
                    return false;
                }
                confirmDialog("确认认可初盘结果？将把所有初盘数量复制到复盘数量", function () {
                    $("#infotab tr:gt(0)").each(function () {
                        var firstQty = $(this).find("td").eq(6).text(); //初盘数量列(StockQty)
                        $(this).find(".RepeatQty").text(firstQty);     //复盘数量列
                    });
                    showMsg("已认可初盘结果，复盘数量已更新", 1);
                });
            }
            //完成复盘
            var CheckListDetail = [];
            function Finish() {
                if (CheckListNo == "" || CheckListNo == null) {
                    confirmDialog("请选择盘点单");
                    return false;
                }
                CheckListDetail = [];
                var Remark = $("#Remark").val();
                confirmDialog("是否完成复盘?", function () {

                    for (var i = 0; i < $("#infotab tr").length - 1; i++) {
                        var grn = $($("#infotab tr:gt(0)")[i]).attr("id");
                        var stockQty = $($("#infotab tr:gt(0)")[i]).find(".RepeatQty").text();
                        if (stockQty == "") {
                            stockQty = 0;
                        }
                        CheckListDetail.push({ "GRN": grn, "NowQty": parseFloat(stockQty) });
                    }


                    var entity = {};
                    entity.CheckOrder = CheckListNo;
                    entity.UpdateBy = userName;
                    entity.Flag = 1; //复盘
                    entity.Remark = Remark;
                    entity.TbDtl = JSON.stringify(CheckListDetail);
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.SaveCheckOrder(JSON.stringify(entity));
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        return false;
                    }
                    confirmDialog("盘点完成");
                    window.location.reload();
                });
            }
            //仓库 盘点单联动
            $("#warehouse").on('change', function () { Orderselect(); })

            //验证是否为数字（小数部分支持6位小数）
            function isGreaterThanOrEqualZero(val) {
                var reg = /^[0-9]+(.[0-9]{1,6})?$/;
                if (!reg.test(val)) {
                    return false;
                }
                return true;
            }

            //显示消息 type 1:成功 0：失败
            function showMsg(msg, type) {
                $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
            }

            //未点复盘完成退出时提醒
            function BackFromScan() {
                if (hasScanned) {
                    if (!confirm("没有点击复盘完成，是否要退出此界面？")) return false;
                    hasScanned = false;
                }
                history.back();
                return false;
            }
            function GoHomeFromScan() {
                if (hasScanned) {
                    if (!confirm("没有点击复盘完成，是否要退出此界面？")) return false;
                    hasScanned = false;
                }
                window.location.href = "Index.aspx";
            }
        </script>
    </form>
</body>
