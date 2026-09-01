<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormChange.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.FormChange" %>

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

    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />


    <script src="js/Common.js?v=2" type="text/javascript"></script>

    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <title>形态转换</title>
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
                        <label id="lbltitle" style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">形态转换单</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"  data-transition="none" data-ajax="false">返回</a> 
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
                        <td colspan="2">
                            <input id="Number" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="cBarCode">转换后库位</label>
                        </td>
                        <td>
                            <input id="cBarCode" />
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
                            <input id="PrintNew" type="checkbox" value="PrintNew" /></td>
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
                                <th>料品
                                </th>
                                <th>品名
                                </th>
                                <th>规格
                                </th>
                                <th>实发/应发
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
                        <li><a data-corners="false" id="Save" data-role="button" data-fullscreen="true" data-theme="a">确认备料</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="mypanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-theme="c" data-filter="true" data-filter-reveal="true" data-filter-placeholder="输入形态转换单号。。。" data-inset="true">
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

            //形态转换单号查询
            $("#FormChangeNo").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Numberarr = [];
                    ArrGRN = [];
                    SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.InitFormChangeCurrentQty($("#FormChangeNo").val());
                    PDAGetFormChangeList($("#FormChangeNo").val());
                    // $("#msg").html('形态转换单扫描成功').css("color", "green");
                    $("#Number").focus();

                }
            });
            //条码扫描事件
            $("#Number").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Scan();
                    $("#Number").focus();
                }
            });
            //库位扫描事件
            $("#cBarCode").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    ScanCBarcode();
                    $("#cBarCode").focus();
                }
            });
            //筛选
            $("#btnFilter").on("click", function () {



                $("#listviews").html("");
                var $ul = $(this),
                    value = $.trim($("input[data-type='search']:eq(0)").val());


                $("#listviews").html("");
                var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetFormChangeInfo(value);

                if (data.error != null) {
                    $("#msg").html(data.error.Message).css("color", "red");
                    return false;
                }
                var ulhtml = "";
                entity = data.value;
                for (var i = 0; i < entity.length; i++) {
                    if (ulhtml.indexOf(entity[i].FormChangeNo) == -1) {
                        ulhtml += "<li><a id='" + entity[i].FormChangeNo + "' onclick='CheckDNlist(this)'>" + entity[i].FormChangeNo + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            });

            $("#Save").on("click", function () { Save(); });
        });


        /*扫描条码*/
        var Scan = function () {
            $("#msg").html('');
            if ($("#FormChangeNo").val() == '' || $("#FormChangeNo").val() == null) {
                confirmDialog('请选择形态转换单！');
                return false;
            }

            var sn = $.trim($("#Number").val());
            if (sn == "") {
                showMsg("请扫描条码", 0);
                $("#Number").val("").focus();
                return false;
            }

            // 检查该GRN是否已扫描
            if (ArrGRN.includes(sn)) {
                $("#msg").html('该GRN已扫描').css('color', '#ff0000');
                return false;
            }

            var entity =
            {
                FormChangeNo: $.trim($("#FormChangeNo").val()),
                SerialNumber: sn,
                ScanType: ScanType,
                ModifyBy: userName,
            };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFinishFormChangeScan", JSON.stringify(entity));//uspFinishProductOutStorageScan
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                $("#Number").val("").focus();
                return false;
            }

            // 将ID添加到已查询数组中
            ArrGRN.push(sn);

            $("#msg").html('扫描成功').css('color', "#00FF00")

            //刷新形态转换单料详情信息
            PDAGetFormChangeList($("#FormChangeNo").val());
            $("#msg").html('扫描成功').css('color', '#2ecc71');
            $("#Number").val("").focus();
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
                return false;
            } else {
                $("#msg").html('库位扫描成功').css('color', "#00FF00")
            }
        };

        //确认进行转换
        function Save() {
            var Grns = ArrGRN.join(',');//扫描的GRN用逗号分隔，放在一起
            var entity =
            {
                FormChangeNo: $.trim($("#FormChangeNo").val()),
                cBarCode: $.trim($("#cBarCode").val()),
                GRNs: Grns,
                ModifyBy: userName,
            };

            // alert(JSON.stringify(entity));

            //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveFormChange", JSON.stringify(entity));//uspFinishProductOutStorageScan
            //if (ajax.error != null) {
            //    showMsg(ajax.error.Message, 0);
            //    return false;
            //}


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.SaveFormChangeCheck(JSON.stringify(entity));
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                return false;
            }


            $("#msg").html('形态转换成功').css('color', "#00FF00")

            $("#FormChangeNo").val("");
            $("#cBarCode").val("");
            $("#DNInfotab tbody").html('');
            var grns = ajax.value;

            //var grns = getGrnStrings(m);


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
            //var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderList($(data).attr("id"));
            //if (data.error != null) {
            //    $("#msg").html(data.error.Message).css("color", "red");
            //    return false;
            //}

            //$("#cusname").text(data.value[0].CusName);
            //$("#address").text(data.value[0].Address);
            //var Status = "";
            //switch (data.value[0].Status) {
            //    case 1:
            //        Status = '装箱中';
            //        break
            //    case 2:
            //        Status = '装箱完成';
            //        break
            //}
            //$("#status").text(Status);
            //$("input[data-type='search']").val('');
            //$("#listviews").html('');
            //$("#mypanel").panel("close");
            //Numberarr = [];
            //PDAGetFormChangeList($("#FormChangeNo").val());
            //$("#Number").focus();

            Numberarr = [];
            ArrGRN = [];
            SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.InitFormChangeCurrentQty($("#FormChangeNo").val());
            PDAGetFormChangeList($("#FormChangeNo").val());
            // $("#msg").html('形态转换单扫描成功').css("color", "green");
            $("#Number").focus();

        }



        //获取形态转换单
        var PDAGetFormChangeList = function (code) {
            var data1 = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetFormChangeInfo(code);
            if (data1.error != null) {
                $("#msg").html(data1.error.Message).css("color", "red");
                return false;
            }

            $("#msg").html('');

            if (data1.value.length <= 0) {
                $("#msg").html('形态转换单不存在!').css('color', '#ff0000');
                return false;
            } else {
                var Status = "";
                switch (data1.value[0].Status) {
                    case 0:
                        Status = '待转换';
                        break
                    case 1:
                        Status = '转换完成';
                        $("#msg").html('该形态转换单已完成!').css('color', '#ff0000');
                        return false;
                        break
                }
            }


            $("#status").text(Status);

            var data = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetFormChangeDtlInfo(code);
            if (data.error != null) {
                $("#msg").html(data.error.Message).css("color", "red");
                return false;
            }
            var m = data.value;
            $("#DNInfotab tbody").html('');
            var htmlstr = "";
            var falg = false;
            if (Numberarr.length < 1) {
                falg = true;
            }
            for (var i = 0; i < m.length; i++) {
                if (falg) {
                    Numberarr.push(m[i].CurrentQty);
                }
                if (Numberarr[i] != m[i].CurrentQty) {
                    htmlstr += "<tr style='background-color:#7FFF00'><td>" + m[i].RowNo + "</td><td>" + m[i].MaterialCode + "</td><td>" + m[i].MaterialName + "</td><td>" + m[i].SpecificationModel + "</td><td><span>" + m[i].CurrentQty + "</span>/<span>" + m[i].Quantity + "</span></td></tr>";
                    Numberarr[i] = m[i].CurrentQty;
                } else {
                    htmlstr += "<tr><td>" + m[i].RowNo + "</td><td>" + m[i].MaterialCode + "</td><td>" + m[i].MaterialName + "</td><td>" + m[i].SpecificationModel + "</td><td><span>" + m[i].CurrentQty + "</span>/<span>" + m[i].Quantity + "</span></td></tr>"
                }
            }
            $("#msg").html('形态转换单扫描成功').css("color", "green");
            $("#DNInfotab tbody").append(htmlstr);
            $("#DNInfotab").table("refresh");

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
