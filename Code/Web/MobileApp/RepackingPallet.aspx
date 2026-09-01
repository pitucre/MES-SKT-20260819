<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RepackingPallet.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.RepackingPallet" %>

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
    <title>重新包装-栈板</title>
    <style type="text/css">
        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        table {
            font-size: 12px !important;
        }

        .operate > div {
            float: left;
        }

        .chk-print label.ui-btn {
            border: 0px;
            margin-top: 10px;
        }

        .ui-table-columntoggle-btn {
            display: none !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <label style="font-size: 17px !important; font-weight: bold; color: #fff">重新包装-栈板</label>
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
                    <div class="chk-print">
                        <%--<label for="printLabel">打印栈板标签</label>
                        <input type="checkbox" id="printLabel" data-theme="c" data-corners="false" />--%>
                        <label for="AutoBarCode">自动生成栈板条码</label>
                        <input type="checkbox" id="AutoBarCode" data-theme="c" data-corners="false" onclick="checkboxOnclick(this)" />
                    </div>
                </div>
                <div style="clear: both"></div>
                <div class="ui-field-contain">
                    <label for="txtPalletNo">输入栈板号码：</label>
                    <input type="text" id="txtPalletNo" />
                </div>
                <div class="ui-field-contain">
                    <label>产品编码：<span id="itemCode"></span></label>
                    <label>产品名称：<span id="itemName"></span></label>
                    <label>产品规格：<span id="itemSpec"></span></label>
                </div>
                <div class="ui-field-contain">
                    <label for="txtOutBoxNo">外箱号码：</label>
                    <input type="text" id="txtOutBoxNo" />
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
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var noData = "<tr class=\"no-data\"><td colspan=\"3\" style=\"text-align: center;\">暂无数据</td></tr>";
            var outBoxNoArr = [];//扫描的外箱号码集合
            var isAuto = '否';

            $(function () {
                $("#txtPalletNo,#txtOutBoxNo").blur(function () { $(this).css("background-color", "#fff") }).focus(function () { $(this).css("background-color", "#ffffcc") });
                $("#txtPalletNo").focus();

                //表格默认显示暂无数据
                $("#outBoxList tbody").html(noData);

                //栈板号码回车事件
                $("#txtPalletNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        outBoxNoArr = [];
                        var palletNo = $.trim($(this).val());
                        if (palletNo == "") {
                            confirmDialogFocus("栈板号码不能为空", function () {
                                $("#txtPalletNo").select();
                            });
                            return;
                        }
                        //获取数据
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetRepackingPalletInfo(palletNo);
                        if (ajax.error != null) {
                            confirmDialogFocus(ajax.error.Message);
                            return;
                        } else {
                            var ds = ajax.value.Tables;
                            //绑定产品信息
                            var item = ds[0].Rows[0];
                            $("#itemCode").html(item.ItemName);
                            $("#itemName").html(item.ItemCode);
                            $("#itemSpec").html(item.ItemSpec);

                            //绑定外箱数量
                            var box = ds[1].Rows[0];
                            $("#outBoxQty").html(box.Qty);

                            //绑定外箱列表
                            var list = ds[2].Rows;
                            var itemCount = 0;
                            var html = "";
                            for (var i = 0; i < list.length; i++) {
                                html += "<tr><td>" + (i + 1) + "</td><td class=\"box-no\">" + list[i].ContainerSN + "</td><td>" + list[i].Qty + "</td></tr>";
                                itemCount += parseInt(list[i].Qty);
                            }
                            $("#itemQty").html(itemCount);
                            $("#outBoxList tbody").html(html);
                        }
                        $("#txtOutBoxNo").val("").focus();
                    }
                });

                //外箱号码回车事件
                $("#txtOutBoxNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        var palletNo = $.trim($("#txtPalletNo").val());
                        //不是自动生成栈板条码才校验栈板条码是否为空
                        if (isAuto == "否") {
                            if (palletNo == "") {
                                confirmDialogFocus("栈板号码不能为空", function () {
                                    $("#txtPalletNo").select();
                                });
                                return;
                            }
                        }
                        var boxNo = $.trim($(this).val());
                        if (boxNo == "") {
                            confirmDialogFocus("外箱号码不能为空", function () {
                                $("#txtOutBoxNo").select();
                            });
                            return;
                        }
                        if (isAuto == "是" && palletNo == "") {
                            //自动生成栈板号
                            var model = {};
                            model.BoxSN = boxNo;
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.RepackingPalletGeneratePalletNo(model);
                            if (ajax.error != null) {
                                confirmDialogFocus(ajax.error.Message);
                                return;
                            }
                            palletNo = ajax.value;
                            $("#txtPalletNo").val(palletNo);
                        }

                        //检查列表中是否已经存在此外箱箱号
                        var isExists = false;
                        $("#outBoxList td.box-no").each(function () {
                            if ($(this).html() == boxNo) {
                                isExists = true;
                                return false;
                            }
                        });
                        if (isExists) {
                            confirmDialogFocus("列表中已存在此外箱号码", function () {
                                $("#txtOutBoxNo").select();
                            });
                            return;
                        }
                        $("#outBoxList tbody tr.no-data").remove();
                        //绑定栈板与包装箱关系
                        var entity = {};
                        entity.ContainerSN = palletNo;
                        entity.SerialNumber = boxNo;
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.RepackingPallet(entity, 0);
                        if (ajax.error != null) {
                            confirmDialogFocus(ajax.error.Message);
                            return;
                        }
                        //增加至列表

                        //获取外箱数量
                        var outBoxQty = parseInt($("#outBoxQty").html());
                        //获取产品数量
                        var itemQty = parseInt($("#itemQty").html());
                        //绑定外箱列表
                        var list = ajax.value.Rows;
                        var boxQty = parseInt(list[0].Qty);
                        var itemCount = itemQty + boxQty;
                        $("#itemQty").html(itemCount);
                        $("#outBoxQty").html(outBoxQty + 1);
                        var listCount = $("#outBoxList tbody tr").length;
                        $("#outBoxList tbody").append("<tr><td>" + (listCount + 1) + "</td><td class=\"box-no\">" + boxNo + "</td><td>" + list[0].Qty + "</td></tr>");
                        $(this).val("");
                        outBoxNoArr.push(boxNo);
                    }
                });

                //保存事件
                $("#Save").on("click", function () {
                    var palletNo = $.trim($("#txtPalletNo").val());
                    if (palletNo == "") {
                        confirmDialogFocus("栈板号码不能为空", function () {
                            $("#txtPalletNo").select();
                        });
                        return;
                    }
                    if (outBoxNoArr == null || outBoxNoArr.length <= 0) {
                        confirmDialogFocus("请扫描外箱号码", function () {
                            $("#txtOutBoxNo").select();
                        });
                        return;
                    }
                    //var boxNo = $.trim($("#txtOutBoxNo").val());
                    //if (boxNo == "") {
                    //    confirmDialogFocus("外箱号码不能为空", function () {
                    //        $("#txtOutBoxNo").select();
                    //    });
                    //    return;
                    //}
                    //绑定栈板与包装箱关系
                    var outBoxNos = outBoxNoArr.join();//产品号码，用逗号隔开
                    var entity = {};
                    entity.ContainerSN = palletNo;
                    entity.SerialNumber = outBoxNos;
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.RepackingPallet(entity, 1);
                    if (ajax.error != null) {
                        confirmDialogFocus(ajax.error.Message);
                        return;
                    }
                    labelItemId = ajax.value.Rows[0].ItemId;//打印时需要用到

                    //如果选择了打印,进行打印
                    //if ($("#printLabel").is(":checked")) {
                    //    try {
                    //        //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                    //        if (getDocumentInfo()) {
                    //            SNInfo = [];
                    //            SNInfo.push(palletNo);

                    //            //根据打印方式决定 调用ZPL还是Lab打印
                    //            usePrinMethod();
                    //        }
                    //    }
                    //    catch (e) {
                    //        alert("打印失败：" + e);
                    //    }
                    //}
                    confirmDialog("保存成功");
                    //清空数据
                    Clear();
                });
            });

            //清空界面数据
            function Clear() {
                outBoxNoArr = [];
                labelItemId = -1;
                $("#AutoBarCode").prop("checked", false).checkboxradio("refresh");
                $("#txtPalletNo").val("");
                $("#itemCode").html("");
                $("#itemName").html("");
                $("#itemSpec").html("");
                $("#outBoxQty").html("");
                $("#itemQty").html("");
                $("#txtOutBoxNo").val("");
                $("#txtPalletNo").val("");
                $("#outBoxList tbody").html(noData);
            }

            //是否自动生成栈板条码
            function checkboxOnclick(checkbox) {
                //是
                if (checkbox.checked == true) {
                    //禁止栈板号码输入框
                    $("#txtPalletNo").attr("disabled", true);
                    $("#txtOutBoxNo").focus();
                    isAuto = '是';
                } else {
                    $("#txtPalletNo").attr("disabled", false);
                    $("#txtPalletNo").focus();
                    isAuto = '否';
                }
            }

            /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

            var ibs;                    //秒
            var labelDocumentId = -1    //Label文档Id
            var lableTypeQty = 1;       //连板数量
            var printName = "";         //打印机名称
            var labelItemId = -1;    //ItemId
            var labelProdOrderId = -1;
            var labelStationId = -1;    //工位Id
            var labelType = -5;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
            var labelSequence = 1;      //标签序号
            var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

            var lableArr = null;        //标签信息的SN序列号集合对象
            var SNInfo;                 //当前释放标签的信息集合对象
            var labelContent = "";      //标签ZPL指令内容
            var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
            var tempatePath = "";       //Lab模板文件路径
            var printCount = 1;        //打印份数：默认一次



            //获取文档模板基础信息
            function getDocumentInfo() {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
                if (ajax.error == null) {
                    var entity = ajax.value;
                    if (entity == null) {
                        alert("未找到打印模板信息");
                        return false;
                    }
                    labelDocumentId = entity.LabelDocumentId;
                    lableTypeQty = entity.PlateQty;
                    printName = entity.PrinterName;
                    labelPrintWayId = entity.PrintWayId;
                    tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                    printCount = entity.Print_Qty;
                }
                else {
                    alert(ajax.error.Message);
                    return false;
                }
                return true;
            }

            //根据打印方式决定 调用ZPL还是Lab打印
            function usePrinMethod() {
                //根据文档使用的打印方式，决定调用Lab模板方式，还是指令方式。
                if (labelPrintWayId == 78) {
                    //codesoft打印  Lab模板方式
                    mesLabLabelPrint();
                }
                else if (labelPrintWayId == 79) {
                    //指令方式
                    mesZPLPrintLabel();
                }
            }

            //codesoft打印  Lab模板方式
            function mesLabLabelPrint() {
                //从已释放的标签信息集合中，获取SN序列号集合。
                lableArr = SNInfo;

                for (var i = 0; i < lableArr.length;) {

                    //lableArr[i]
                    //找到doucumentId打印文档id
                    var labelStr = "";

                    if (lableTypeQty == 1) {
                        labelStr = lableArr[i];
                    }
                    else {
                        for (var j = 0; j < lableTypeQty; j++) {
                            if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                            }
                            else {
                                //根据联板数，拼接SN字符串。 
                                labelStr += lableArr[i + j] + ",";
                            }
                        }
                    }

                    i = i + lableTypeQty;

                    //每发送一次打印指令 初始化标签内容变量。
                    labelContent = "";

                    //获取标签模板中的标签值 集合
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);

                    if (ajaxLabContent.error == null) {
                        //接收打印的ZPL标签  
                        try {
                            var list = ajaxLabContent.value;

                            if (list.length > 0) {

                                for (var h = 0; h < list.length; h++) {
                                    labelContent += '{name:"' + list[h].LabelName + '",value:"' + list[h].LabelValue + '"}' + ",";
                                }

                                labelContent = labelContent.substring(0, labelContent.length - 1);
                                labelJsonData = "[{LabelContent:[" + labelContent + "]}]";

                                printLabel(tempatePath, labelJsonData, printName, "lab");
                                //条码打印记录
                            }
                        } catch (e) {
                            alert(e);
                            return false;
                        }
                    }
                    else {
                        alert(ajaxLabContent.error.Message);
                        return false;
                    }
                }
                //alert('打印成功');
            }

            //指令方式
            function mesZPLPrintLabel() {
                lableArr = SNInfo;
                for (var i = 0; i < lableArr.length;) {

                    //lableArr[i]
                    //找到doucumentId打印文档id
                    var labelStr = "";
                    if (lableTypeQty == 1) {
                        labelStr = lableArr[i];
                    }
                    else {
                        for (var j = 0; j < lableTypeQty; j++) {
                            if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                            }
                            else {
                                labelStr += lableArr[i + j] + ",";
                            }
                        }
                    }

                    i = i + lableTypeQty;

                    //获取此标签的zpl指令
                    var ajaxZplContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnZplContent(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);
                    if (ajaxZplContent.error == null) {
                        zplStr = ajaxZplContent.value;
                        try {
                            printLabel("", zplStr, printName, "zpl");
                        } catch (e) {
                            alert(e);
                            return false;
                        }
                    } else {
                        alert(ajaxZplContent.error.Message);
                        return false;
                    }
                }
            }

            /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/

        </script>
    </form>
</body>
</html>
