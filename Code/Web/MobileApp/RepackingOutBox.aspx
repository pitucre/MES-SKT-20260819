<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RepackingOutBox.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.RepackingOutBox" %>

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
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
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

        /*.print-list {
            display: none;
        }*/

        /*table,table tr th, table tr td { border:1px solid #c1c1c1; }
        table { line-height: 25px; text-align: center; border-collapse: collapse;}*/
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <label style="font-size: 17px !important; font-weight: bold; color: #fff">重新包装-外箱</label>
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
                        <label for="printLabel">打印外箱标签</label>
                        <input type="checkbox" id="printLabel" data-theme="c" data-corners="false" />
                    </div>
                </div>
                <div style="clear: both"></div>
                <div class="ui-field-contain">
                    <label for="txtOutBoxNo">输入外箱号码：</label>
                    <input type="text" id="txtOutBoxNo" />
                </div>
                <div class="ui-field-contain">
                    <label for="txtItemNo">产品号码：</label>
                    <input type="text" id="txtItemNo" />
                </div>
                <div class="ui-field-contain">
                    <label>产品数量：<span id="itemQty"></span></label>
                </div>
                <table id="itemList" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke ui-table ui-table-columntoggle" style="width: 100%; margin-top: 20px;">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>产品号码</th>
                            <th>工单</th>
                            <th>产品编码</th>
                            <th>产品名称</th>
                            <%--<th>产品规格</th>--%>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var noData = "<tr><td colspan=\"5\" style=\"text-align: center;\">暂无数据</td></tr>";
            var itemNoArr = [];//扫描的SN集合
            var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            $(function () {

                $("#txtOutBoxNo,#txtItemNo").blur(function () { $(this).css("background-color", "#fff") }).focus(function () { $(this).css("background-color", "#ffffcc") });
                $("#txtOutBoxNo").focus();

                //表格默认显示暂无数据
                $("#itemList tbody").html(noData);

                //外箱号码回车事件
                $("#txtOutBoxNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        itemNoArr = [];
                        var boxNo = $.trim($(this).val());
                        if (boxNo == "") {
                            confirmDialogFocus("外箱号码不能为空", function () {
                                $("#txtOutBoxNo").select();
                            });
                            return;
                        }
                        //获取数据
                        var entity = {};
                        entity.ContainerSN = boxNo;
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetItemInfoByBoxNo(entity);
                        if (ajax.error != null) {
                            confirmDialogFocus(ajax.error.Message);
                            return;
                        } else {
                            var dt = ajax.value.Rows;

                            //绑定产品列表
                            var html = "";
                            for (var i = 0; i < dt.length; i++) {
                                html += "<tr><td>" + (i + 1) + "</td>"
                                    + "<td class=\"item-no\">" + dt[i].SerialNumber + "</td>"
                                    + "<td>" + dt[i].OrderNO + "</td>"
                                    + "<td>" + dt[i].ItemCode + "</td>"
                                    + "<td>" + dt[i].ItemName + "</td>"
                                    //+ "<td>" + dt[i].ItemSpec + "</td>
                                    + "</tr>";
                            }
                            $("#itemQty").html(dt.length);
                            $("#itemList tbody").html(html);
                        }
                        $("#txtItemNo").val("").focus();
                    }
                });

                //产品号码回车事件
                $("#txtItemNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        var boxNo = $.trim($("#txtOutBoxNo").val());
                        if (boxNo == "") {
                            confirmDialogFocus("外箱号码不能为空", function () {
                                $("#txtOutBoxNo").select();
                            });
                            return;
                        }
                        var itemNo = $.trim($(this).val());
                        if (itemNo == "") {
                            confirmDialogFocus("产品号码不能为空", function () {
                                $("#txtItemNo").select();
                            });
                            return;
                        }

                        //检查列表中是否已经存在此产品号码
                        var isExists = false;
                        $("#itemList td.item-no").each(function () {
                            if ($(this).html() == itemNo) {
                                isExists = true;
                                return false;
                            }
                        });
                        if (isExists) {
                            confirmDialogFocus("列表中已存在此产品号码", function () {
                                $("#txtItemNo").select();
                            });
                            return;
                        }

                        //绑定包装箱与产品号码关系
                        var entity = {};
                        entity.ContainerSN = boxNo;
                        entity.SerialNumber = itemNo;
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.RepackingOutBox(entity, 0);
                        if (ajax.error != null) {
                            confirmDialogFocus(ajax.error.Message);
                            return;
                        }
                        //增加至列表
                        var item = ajax.value.Rows[0];
                        //获取产品数量
                        var itemQty = parseInt($("#itemQty").html());
                        //绑定产品列表
                        $("#itemQty").html((itemQty + 1));
                        var listCount = $("#itemList tbody tr").length;

                        var html = "<tr><td>" + (listCount + 1) + "</td>"
                                    + "<td class=\"item-no\">" + item.SerialNumber + "</td>"
                                    + "<td>" + item.OrderNO + "</td>"
                                    + "<td>" + item.ItemCode + "</td>"
                                    + "<td>" + item.ItemName + "</td>"
                                    //+ "<td>" + dt[i].ItemSpec + "</td>
                                    + "</tr>";
                        $("#itemList tbody").append(html);
                        $(this).val("");
                        itemNoArr.push(itemNo);
                    }
                });

                //保存事件
                $("#Save").on("click", function () {
                    var boxNo = $.trim($("#txtOutBoxNo").val());
                    if (boxNo == "") {
                        confirmDialogFocus("外箱号码不能为空", function () {
                            $("#txtOutBoxNo").select();
                        });
                        return;
                    }
                    if (itemNoArr == null || itemNoArr.length <= 0) {
                        confirmDialogFocus("请扫描产品号码", function () {
                            $("#txtItemNo").select();
                        });
                        return;
                    }
                    //var itemNo = $.trim($("#txtItemNo").val());
                    //if (itemNo == "") {
                    //    confirmDialogFocus("产品号码不能为空", function () {
                    //        $("#txtItemNo").select();
                    //    });
                    //    return;
                    //}

                    //绑定包装箱与产品号码关系
                    var itemNos = itemNoArr.join();//产品号码，用逗号隔开
                    var entity = {};
                    entity.ContainerSN = boxNo;
                    entity.SerialNumber = itemNos;//itemNo;
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.RepackingOutBox(entity,1);
                    if (ajax.error != null) {
                        confirmDialogFocus(ajax.error.Message);
                        return;
                    }
                    labelItemId = ajax.value.Rows[0].ItemId;//打印时需要用到

                    //如果选择了打印,进行打印
                    if ($("#printLabel").is(":checked")) {
                        try {
                            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                            if (getDocumentInfo()) {
                                SNInfo = [];
                                SNInfo.push(boxNo);

                                mesLabLabelPrint(SNInfo);
                            }
                        }
                        catch (e) {
                            alert("打印失败：" + e);
                        }
                    }
                    confirmDialog("保存成功");
                    //清空数据
                    Clear();
                });
            });


            //清空界面数据
            function Clear() {
                itemNoArr = [];
                labelItemId = -1;
                $("#printLabel").prop("checked", false).checkboxradio("refresh");
                $("#txtOutBoxNo").val("");
                $("#txtItemNo").val("");
                $("#itemQty").html("");
                $("#itemList tbody").html(noData);
            }

            /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

            var ibs;                    //秒
            var labelDocumentId = -1    //Label文档Id
            var lableTypeQty = 1;       //连板数量
            var printName = "";         //打印机名称
            var labelItemId = -1;    //ItemId
            var labelProdOrderId = -1;
            var labelStationId = -1;    //工位Id
            var labelType = -4;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
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


            //codesoft打印  Lab模板方式
            function mesLabLabelPrint(list) {
                var printdata = [];
                for (var i = 0; i < list.length; i++) {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, list[i], -1, -1, -1, labelItemId, labelProdOrderId);
                    if (ajax.error == null) {
                        var page = { LabelContent: [] };
                        for (var h = 0; h < ajax.value.length; h++) {
                            page.LabelContent.push({ name: ajax.value[h].LabelName, value: ajax.value[h].LabelValue });
                        }
                        printdata.push(page);
                    }
                    else {
                        alert(ajax.error.Message);
                        return false;
                    }
                }
                if (printdata.length == 0) {
                    alert("没有打印数据");
                    return;
                }
                if (typeof (android) != "undefined" && android && android.getPrinter) {
                    var bluetoothprinter = JSON.parse(android.getPrinter());
                    for (var i = 0; i < bluetoothprinter.length; i++) {
                        if (bluetoothprinter[i].name == printName) {
                            sendPrintContent(JSON.stringify(printdata), bluetoothprinter[i].mac, 1, labelDocumentId);
                            return;
                        }
                    }
                }
                sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
            }

            /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/

        </script>
    </form>
</body>
</html>
