<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDAProdSNUnpacking.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.PDAProdSNUnpacking" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
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
    <title>拆箱包装</title>
    <style type="text/css">
        .clear {
            clear: both;
            height: 2px;
        }

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
        .clear {
            clear: both;
            height: 2px;
        }

        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        table {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px !important;
            color: #1d1007;
        }    .ui-title {
            line-height: 30px;
            
        }
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                       
                    </div>
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">拆箱包装</label>                        
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                data-transition="none" data-ajax="false">返回</a><a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" id="content1">
                    <table  style="width: 100%">
                        <tr>
                            <td>
                                <label >包装箱号</label>
                            </td>
                            <td>
                                <input type="text" name="fGRN" id="txtPackNo" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label >产品条码</label>
                            </td>
                            <td>
                                <input type="text" name="fGRN" id="txtSCANSN" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label >拆箱数量</label>
                            </td>
                            <td>
                                <input type="text" name="fGRN" id="txtUnPackQty" />
                            </td>
                        </tr>
                       <%-- <tr>
                        <td>
                            <label for="Print">
                                打印机</label>
                        </td>
                        <td>
                            <select id="PDAselPrintersList" data-mini="true" class="perparelist">
                            </select>
                        </td>
                    </tr>--%>
                        <tr>
                            <td colspan="2">
                                <label id="labPackUnQty">拆箱数量</label>
                            </td>
                        </tr>
                    </table>
                    <div style="text-align: center; font-size: 14px" id="rmsg" class="msg">
                    </div>
                    <table data-role="table" id="NCInfo" data-mode="columntoggle" class="ui-responsive table-stroke"  style="width: 100%">
                        <thead>
                            <tr>
                                <th>产品条码
                                </th>
                                <th>产品编码
                                </th>
                                <th>数量
                                </th>
                            </tr>
                        </thead>
                        <tr id="trNCInfo" class="ListTableOddRow">
                            <td colspan="3" style="text-align: center;">暂无数据
                            </td>
                        </tr>
                    </table>
            </div>
             <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-transition="none" onclick="Clear()">重新扫描</a></li>
                        <li><a href="#" data-transition="none" onclick="Save()">确认</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";

            $(function () {
                //获取打印机名称
                //$(document).ready(function () {
                //    bindPrinters('PDAselPrintersList', function () {
                //        if ($("#PDAselPrintersList").val()) {
                //            $("#PDAselPrintersList-button span").text($("#PDAselPrintersList").find("option:selected").text());
                //        }
                //    });
                //});
                $(".ui-body-c").css("background", "#fff");
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $("#txtPackNo").val("").focus();
            });
            
            //扫描包装箱号
            var PackArrInfo = [];       //包装箱信息（工单ID，工序资源ID等）
            var PackSNStr = "";         //包装箱内的SN条码，单件逗号隔开，批次只有一个条码
            var IsBatch = "";           //单件还是批次
            var PackQty = 0;           //包装箱总数量
            $("#txtPackNo").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var txtPackNo = $.trim($("#txtPackNo").val());
                    if (txtPackNo == "") {
                        RshowAreaMessge("请扫描包装箱号", "messageRed");
                        $("#txtPackNo").val("").focus();
                        return false;
                    }
                    var info = { PackNo: txtPackNo };
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetSNPackInfo", JSON.stringify(info));
                    if (ajax.error != null) {
                        RshowAreaMessge(ajax.error.Message, "messageRed");
                        $("#txtPackNo").val("");
                        $("#txtPackNo").focus();
                        return false;
                    }
                    var list = JSON.parse(ajax.value);
                    var listOrder = list.data;
                    PackSNStr = listOrder[0].SNArr;
                    IsBatch = listOrder[0].IsBatch;
                    PackQty = listOrder[0].PackQty;
                    $("#labPackUnQty").text("拆箱数量：0/" + listOrder[0].PackQty);

                    if (IsBatch == "批次") {
                        $("#txtSCANSN").val("").focus();
                        //$("#txtUnPackQty").val("");
                        //$("#txtUnPackQty").focus();
                    }
                    if (IsBatch == "单件") {
                        $("#txtSCANSN").val("").focus();
                        $("#txtUnPackQty").val("1");
                    }
                    RshowAreaMessge("包装箱条码扫描成功", "messageGreen");
                    ALLSNArr = [];
                    $("#NCInfo  tr:not(:first)").html("");
                }
            });
          
            $("#txtSCANSN").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    afterScan();
                }
            });

            $("#txtUnPackQty").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if (IsBatch == "批次") {
                        var UnPackQty = $("#txtUnPackQty").val();
                        if (parseFloat(UnPackQty) >= parseFloat(PackQty)) {
                            RshowAreaMessge("拆箱数量不能大于等于包装箱总数量", "messageRed");
                            $("#txtSCANSN").val(PackSNStr);
                            $("#txtUnPackQty").val("").focus();
                            return false;
                        }
                        if ($("#txtSCANSN").val()=="") {
                            $("#txtSCANSN").val(PackSNStr);
                        }
                        var mySN = $("#txtSCANSN").val();
                        var info = { SN: mySN };
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetSNInfo", JSON.stringify(info));
                        if (ajax.error != null) {
                            RshowAreaMessge(ajax.error.Message, "messageRed");
                            $("#txtSCANSN").val("");
                            $("#txtSCANSN").focus();
                            return false;
                        }
                        var list = JSON.parse(ajax.value);
                        var listOrder = list.data;
                        //批次包装箱，每次扫描拆箱数量，重置SN数组
                        ALLSNArr = [];
                        var SNArr = {};
                        SNArr.SN = mySN;
                        SNArr.ItemCode = listOrder[0].ItemCode;
                        SNArr.BatchQty = listOrder[0].BatchQty;
                        ALLSNArr.push(SNArr);
                        RshowAreaMessge("SN:" + mySN + "扫描成功", "messageGreen");
                        $("#NCInfo  tr:not(:first)").html("");
                        for (var i = 0; i < ALLSNArr.length; i++) {
                            SNaddDetail(ALLSNArr[i], i);
                        }
                        SNArr = {};
                        $("#labPackUnQty").text("拆箱数量：" + UnPackQty + "/" + PackQty);
                    }
                    if (IsBatch=="单件") {
                        RshowAreaMessge("当前包装箱号为单件包装箱，请扫描产品条码", "messageRed");
                        $("#txtSCANSN").val("").focus();
                        $("#txtUnPackQty").val("1");
                        return false;
                    }
                }
            });

            var ALLSNArr = [];
            var myNCtab = document.getElementById("NCInfo");
            function afterScan() {
                if ($("#txtPackNo").val() == "" || PackSNStr=="") {
                    RshowAreaMessge("请先扫描包装箱号", "messageRed");
                    return false;
                }
                if (IsBatch == "批次") {
                    RshowAreaMessge("当前包装箱号为批次包装箱，不需要扫描产品条码", "messageRed");
                    $("#txtSCANSN").val(PackSNStr);
                    $("#txtUnPackQty").val("").focus();
                    return false;
                }
                var mySN = $("#txtSCANSN").val();
                //if (PackSNStr.indexOf(mySN) == -1) {
                //    RshowAreaMessge("条码不属于当前包装箱，请扫描包装箱内的产品条码", "messageRed");
                //    $("#txtSCANSN").val("").focus();
                //    $("#txtUnPackQty").val("1");
                //    return false;
                //}
                //判断当前不良是否已经扫描
                for (var j = 0; j < ALLSNArr.length; j++) {
                    if (ALLSNArr[j].SN == mySN) {
                        RshowAreaMessge("该产品条码已扫描，请不要重复扫描！", "messageRed");
                        $("#txtSCANSN").val("").focus();
                        return false;
                    }
                }
                var info = { SN: mySN, PackNo: $("#txtPackNo").val() };
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetSNInfo", JSON.stringify(info));
                if (ajax.error != null) {
                    RshowAreaMessge(ajax.error.Message, "messageRed");
                    $("#txtSCANSN").val("");
                    $("#txtSCANSN").focus();
                    return false;
                }
                var list = JSON.parse(ajax.value);
                var listOrder = list.data;
                var SNArr = {};
                SNArr.SN = mySN;
                SNArr.ItemCode = listOrder[0].ItemCode;
                SNArr.BatchQty = listOrder[0].BatchQty;
                ALLSNArr.push(SNArr);
                RshowAreaMessge("SN:" + mySN + "扫描成功", "messageGreen");
                $("#NCInfo  tr:not(:first)").html("");
                for (var i = 0; i < ALLSNArr.length; i++) {
                    SNaddDetail(ALLSNArr[i], i);
                }
                $("#txtSCANSN").val("");
                $("#txtSCANSN").focus();
                $("#labPackUnQty").text("拆箱数量：" + ALLSNArr.length + "/" + PackQty);
                SNArr = {};
            }

            var OldPackNo = "";
            var NewPackNo = "";
            var lableItemId = -1;
            var prodOrderId = -1;
            var stationId = -1;

            function Save() {
                if ($("#txtPackNo").val() == "" || PackSNStr == "") {
                    RshowAreaMessge("请先扫描包装箱号", "messageRed");
                    return false;
                }
                if (IsBatch=="单件") {
                    if (ALLSNArr.length<1) {
                        RshowAreaMessge("未扫描产品条码，请先扫描产品条码！", "messageRed");
                        $("#txtSCANSN").val("").focus();
                        $("#txtUnPackQty").val("1");
                        return false;
                    }
                }
                if (IsBatch == "批次") {
                    if ($("#txtUnPackQty").val() == "" || isNaN($("#txtUnPackQty").val())) {
                        RshowAreaMessge("请输入正确的拆箱数量", "messageRed");
                        $("#txtSCANSN").val(PackSNStr);
                        $("#txtUnPackQty").val("").focus();
                        return false;
                    }                    
                }
                var AllSN = "";
                if (IsBatch == "批次") {
                    AllSN = PackSNStr;
                }
                else {
                    for (var i = 0; i < ALLSNArr.length; i++) {
                        AllSN += ALLSNArr[i].SN + ",";
                    }
                }
                var info = { SN: AllSN, PackNo: $("#txtPackNo").val(), UnPackQty: $("#txtUnPackQty").val(), IsBatch: IsBatch, UserID: userId };
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspPDAProdSNUnpackingSave", JSON.stringify(info));
                if (ajax.error != null) {
                    RshowAreaMessge(ajax.error.Message, "messageRed");
                    return false;
                }
                var list = JSON.parse(ajax.value);
                var listOrder = list.data;
                OldPackNo = listOrder[0].OldPackNo;
                NewPackNo = listOrder[0].NewPackNo;
                lableItemId = listOrder[0].ItemId;
                prodOrderId = listOrder[0].ProdOrderId;
                stationId = listOrder[0].stationid;
                RshowAreaMessge("包装箱：" + OldPackNo + "拆箱成功，新箱号：" + NewPackNo + "，正在打印...", "messageGreen");
                getDocumentInfo(OldPackNo);
                getDocumentInfo(NewPackNo);
                RshowAreaMessge("包装箱：" + OldPackNo + "拆箱成功，新箱号：" + NewPackNo + "，打印成功", "messageGreen");
                //定时执行，5秒后执行show()
                window.setTimeout(function () {
                    document.forms[0].submit();
                }, 1500);
            }

            function SNaddDetail(entity, i) {
                if (entity == null) {
                    return;
                }
                i += 1;
                $("#trNcInfo").remove();
                var row, cell;
                rowNewIdx = myNCtab.rows.length;
                row = myNCtab.insertRow(rowNewIdx);
                row.className = "ListTableOddRow";

                cell = row.insertCell(0);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = entity.SN;

                cell = row.insertCell(1);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = entity.ItemCode;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = parseFloat(entity.BatchQty);

            }

            /*
            *写入用户操作日志
            */
            function SaveUserUILog(OederNo, LogContent) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.SaveUserUILog("一般", -1, -1, OederNo, LogContent);
                if (ajax.error != null) {
                    return false;
                }
            }

            //显示消息
            function RshowAreaMessge(msg, type) {
                $("#rmsg").html(msg).css("color", type == "messageGreen" ? "#99FF33" : "#ff0000");
            }

            function Clear() {
                $("#NCInfo  tr:not(:first)").html("");
                $("#txtcBarCode").val("").select().focus();
                $("#txtSCANSN").val("");
                ALLSNArr = [];
            }
            /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/
            var ibs;                    //秒
            var labelDocumentId = -1    //Label文档Id
            var lableTypeQty = 1;       //连板数量
            var printName = "";         //打印机名称
            var labelItemId = -1;    //ItemId
            var labelStationId = -1;    //工位Id
            var labelType = -4;          //标签类型 (-2：SN，-3：GRN)
            var labelSequence = 0;      //标签序号 (1产品，2GRN, 3单号......)
            var labelPrintWayId = 0;   //打印方式 78=Lab  79=ZPL
            var printQty = 0;       //打印份数
            var lableArr = null;        //标签信息的SN序列号集合对象
            var SNInfo;                 //当前释放标签的信息集合对象
            var templatePath = "";  //Label标签模板路径

            //根据打印方式决定 调用ZPL还是Lab打印
            function getDocumentInfo(labelStr) {

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPackLabelDocumentInfo(labelStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var printList = ajax.value;

                if (printList == null) {
                    alert("未找到打印模板信息！");
                    return false;
                }
                for (var i = 0; i < printList.length; i++) {
                    var entity = printList[i];
                    labelDocumentId = entity.LabelDocumentId;
                    lableTypeQty = entity.PlateQty;
                    printName = $("#PDAselPrintersList").val();
                    printQty = entity.Print_Qty;
                    printWay = entity.PrintWayId;
                    templatePath = entity.TemplatePath.replace("\\", "\\\\");
                    //   lableItemId = entity.ItemId;
                    if (!printQty > 0) {
                        printQty = 1;
                    }
                    for (var j = 0; j < printQty; j++) {
                        mesLabLabelPrint(labelStr);
                    }
                }
            }

            /**
            *codesoft打印  Lab模板方式
            **/
            function mesLabLabelPrint(labelStr) {
                var printdata = [];
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, stationId, -1, -1, lableItemId, prodOrderId);
                if (ajaxLabContent.error != null) {
                    alert(ajaxLabContent.error.Message);
                    return false;
                }
                else {
                    //接收打印的ZPL标签  
                    try {
                        var list = ajaxLabContent.value;

                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                            if (printdata.length == 0)
                                return;
                            sendPrintContent(JSON.stringify(printdata), printName, printQty, labelDocumentId);
                        }
                    }
                    catch (e) {
                        alert(e);
                        return false;
                    }
                }
            }

            /**
            *插入打印记录
            **/
            function recordPrintNew(sn) {
                var printRecodeEntity = {};
                printRecodeEntity.RecordId = -1;
                printRecodeEntity.ActionType = 1;
                printRecodeEntity.PrintType = lableType;
                printRecodeEntity.PrintKey = sn;
                printRecodeEntity.StationId = stationId;
                printRecodeEntity.ResourceId = resourceId;
                var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
                if (ajaxPrintRecodes.error != null) {
                    alert(ajaxPrintRecodes.error.Message);
                    return false;
                }
            }

        </script>
    </form>
</body>
