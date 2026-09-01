/********************************************标签打印 开始************************************************/
var labelStr = "";
var lableType = 0;           //打印类型(-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
var lableSequence = 0;       //序号

var labelDocumentId = 0;
var lableTypeQty = 0;  //联版打印数量 
var printParaQty = 0;   //打印标签个数
var printQty = 0;       //打印份数
var printName = "";     //打印机名称
var printWay = 0;       //文档打印方式 78、Label标签方式打印 79、ZPL方式打印
var templatePath = "";  //Label标签模板路径
var lableItemId = -1;  //产品

/**
*打印包装信息
**/
function print() {
    //条码打印记录
    var labelSNArr;
    if (lableTypeQty == 1) { //单板
        //labelSNArr = labelStr.split(",")[0];
        recordPrintNew(labelStr);
    } else { //连板
        labelSNArr = labelStr.split(",");
        for (var k = 0; k < labelSNArr.length - 1; k++) {
            recordPrintNew(labelSNArr[k]);
        }
    }
    //1、获取文档模板基础信息,打印标签
    getDocumentInfo();
}

/**
*获取文档模板基础信息
**/
function getDocumentInfo() {
    if (!labelStr) {
        alert("未指定打印条码！");
        return false;
    }
    //1、获取打印文档的信息（文档ID、联版数量、标签模板路径、打印机名称）
    //打印机名称用户自动选择 还是 默认 待确定？--暂定后台默认设置
    if (lableType == -4 || lableType == -5 || lableType == -22) {
        if (labelStr.split(",").length > 1) {
            alert("不支持包装箱批量打印！");
            return false;
        }
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPackLabelDocumentInfo(labelStr);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
    }
    else {
        var firstLabelStr = labelStr.split(",")[0];
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfoBySn(firstLabelStr, stationId, lableType, lableSequence);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
    }
    var printList = ajax.value;

    if (printList == null || printList.length == 0) {
        alert("未找到打印模板信息！");
        return false;
    }

    var i = 0;
    labelDocumentId = printList[i].LabelDocumentId;
    lableTypeQty = printList[i].PlateQty;
    printName = printList[i].PrinterName;
    printQty = printList[i].Print_Qty;
    printWay = printList[i].PrintWayId;
    templatePath = printList[i].TemplatePath.replace("\\", "\\\\");
    lableItemId = printList[i].ItemId;
    if (!printQty > 0) {
        printQty = 1;
    }
    //存在多模板的时候交替打印 modify by xiongyz 2023-08-19
    if (printList.length > 1) {
        var j = 0;
        var list = labelStr.split(",");
        //回调函数
        var callback = function (success, ws, msg) {
            if (!success) {
                if (ws && ws.readyState != 1)
                    layer.open({ content: "连接尚未建立请确认服务是否开启" });
                return;
            }
            //最后一个
            if (i == printList.length - 1 && j == list.length - 1) {
                var data = JSON.parse(msg.data);
                if (data.Result) {
                    layer.open({ title: "打印机脱机", content: "如需预览请复制以下地址到浏览器地址栏并回车。<textarea style='width:100%;height:100%;border:none;overflow:hidden;color:red;'>" + data.Result + "</textarea>" });
                }
                return;
            }
            //打印下一个
            if (i == printList.length - 1) {
                i = 0;
                j++;
            }
            else {
                i++;
            }
            labelDocumentId = printList[i].LabelDocumentId;
            lableTypeQty = printList[i].PlateQty;
            printName = printList[i].PrinterName;
            printQty = printList[i].Print_Qty;
            printWay = printList[i].PrintWayId;
            templatePath = printList[i].TemplatePath.replace("\\", "\\\\");
            lableItemId = printList[i].ItemId;
            if (!printQty > 0) {
                printQty = 1;
            }
            labelStr = list[j];
            mesLabLabelPrintNew(callback);
        }
        //打印第一个
        labelStr = list[0];
        mesLabLabelPrintNew(callback);
    }
    else {
        mesLabLabelPrintNew();
    }
}

/**
*codesoft打印  Lab模板方式
**/
function mesLabLabelPrintNew(callback) {
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

            //if (list.length > 0) {
                var page = { LabelContent: [] };
                for (var k = 0; k < list.length; k++) {
                    page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                }
                printdata.push(page);
                if (printdata.length == 0)
                    return;
                sendPrintContent(JSON.stringify(printdata), printName, printQty, labelDocumentId, callback);
            //}
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
/********************************************标签打印 结束************************************************/