var LABEL_CONTENT = "";
var JC_PAPERTYPE = 1;  //默认间隙纸

function sendPrintContent(labContent, printer, printCount, labelId, callback, printtype, hidDiolog) {
    if (!labContent || labContent.length <= 2) {
        layer.open({ content: "没有打印的数据" });
        return;
    }
    //labContent = labContent.replace(/[\r]/g, "\\r").replace(/[\n]/g, "\\n");
    var approot = "";
    if (typeof (_root) != "undefined" && _root)
        approot = _root;
    var bluetoothmac = printer.split(',')[0];
    //蓝牙打印机
    var isBluetoothPrint = /^(\w{2}:){5}\w{2}$/.test(bluetoothmac);
    if (isBluetoothPrint && !(typeof (android) != "undefined" && android && android.print)) {
        layer.open({ content: "不支持蓝牙打印" });
        return;
    }
    $.ajax({
        type: "POST",
        url: approot + "/Labels/Design.aspx",
        cache: false,
        async: false,
        data: { LabelId: labelId, Data: labContent, Count: printCount, action: (isBluetoothPrint ? "getBluetoothPrintImgs" : "setdata") },
        success: function (result) {
            result = JSON.parse(result);
            if (!result.success) {
                alert(result.msg);
                return;
            }
            if (isBluetoothPrint) {
                var approot = "";
                if (typeof (_root) != "undefined" && _root)
                    approot = _root;
                var url = window.location.protocol + "//" + window.location.host + approot + "/Handler/PrintUpdate.ashx";
                var bluetoothname = printer.split(',')[1].toUpperCase();
                if (bluetoothname.indexOf('ZR') > -1) {
                    //斑马打印
                    android.zeBraPrint(result.data, url, bluetoothmac);
                } else if (bluetoothname.indexOf('IDATA') > -1) {
                    //盈达打印
                    android.iDataPrint(result.data, url, bluetoothmac);
                } else if (bluetoothname.indexOf('RP') > -1) {
                     //霍尼韦尔打印
                    android.HoneywellPrint(result.data, url, bluetoothmac);
                } else if (bluetoothname.indexOf('PS') > -1) {
                    /***********************************************************
                        功能：TSC打印机
                        方法：android.print(imgs,url,mac,speed,density,quantity)
                        imgs：生成的PDF图片文件集合“,”拼接的名字符串
                        url：图片下载的API地址
                        mac：打印机的MAC地址
                        speed:打印速度，默认4
                        density：打印浓度，默认12
                        quantity：打印份数，默认1
                    ***********************************************************/
                    android.TSCPrint(result.data, url, bluetoothmac, 4, 12, 1);
                } else {
                    //android.print(result.data, url, bluetoothmac, result.width, result.height);

                    /***********************************************************
                        功能：精臣打印机图片打印
                        方法：android.print(imgs,url,mac,width,height,quantity,printMultiple,density,paperType,printMode)
                        参数说明
                        imgs：生成的PDF图片文件集合“,”拼接的名字符串
                        url：图片下载的API地址
                        mac：打印机的MAC地址
                        width：图片宽度
                        height:图片高度
                        quantity：打印份数，默认1
                        printMultiple:倍率，//除B32/Z401/T8的printMultiple（倍率）为11.81，其他的为8
                        density：打印浓度，范围值如下：
                            D11、D101、D110 1~3 默认2
                            B3S、B203、B1、B16 1~5 默认3
                            B18 1~3 默认2
                            B50、B11、B50W、B32、Z401 1~15 默认8
                        paperType：纸张类型，范围值如下：
                            0x01:间隙纸;
                            0x02:黑标纸;
                            0x03:连续纸;
                            0x04:定孔纸;
                            0x05:透明纸;
                        printMode:打印模式 1：热敏打印模式，2：热转印模式，默认1
                    ***********************************************************/
                    android.print(result.data, url, bluetoothmac, result.width, result.height, 1, 8, 3, JC_PAPERTYPE, 1);
                }
            } else {
                sendPrintByDataId(result.data, printer, printCount, labelId, callback, printtype, hidDiolog);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("获取标签设置出错");
        }
    });
}


function sendPrintByDataId(dataId, printer, printCount, labelId, callback, printtype, hidDiolog) {
    printer = printer.split(',');
    var printname, ip, port;
    if (printer.length == 1) {
        ip = "127.0.0.1";
        if (typeof (_port) != "undefined" && _port)
            port = _port;
    } else {
        ip = printer[1];
        port = printer[2];
    }
    if (!port)
        port = "53817";
    printname = printer[0];
    var approot = "";
    if (typeof (_root) != "undefined" && _root)
        approot = _root;
    if (printtype == undefined || printtype == null)
        printtype = 0;
    var entity = {
        DataId: dataId,
        Domain: window.location.protocol + "//" + window.location.host,
        Url: approot + "/Handler/PrintUpdate.ashx",
        TempId: labelId,
        PrintName: printname,
        Type: printtype,//0:默认,1:adobe ,2:zpl
        Version: "8.5.3",
        MesVersion: "1"//区分打印服务端系统版本，1：MES_8.5 2：MOM_9.0
    };
    var str = JSON.stringify(entity);
    var loading_id = layer.load(1, { shade: [0.5, '#000'] });
    $.initWebSocket({
        Ip: ip,
        Port: port,
        Method: "Print2",
        Data: str,
        onMessage: function (ws, msg) {
            layer.close(loading_id);
            var data = JSON.parse(msg.data);
            if (!data.Success) {
                layer.open({ content: data.Error });
                return;
            }
            if (callback) {
                callback(true, ws, msg);
                return;
            }
            if (data.Result) {
                layer.open({ title: "打印机脱机", content: "如需预览请复制以下地址到浏览器地址栏并回车。<textarea style='width:100%;height:100%;border:none;overflow:hidden;color:red;'>" + data.Result + "</textarea>" });
                return;
            }
            if (!hidDiolog) {                
                layer.open({ content: "打印完成" });
            }
            
        },
        onClose: function (ws, msg) {
            layer.close(loading_id);
            if (ws && ws.readyState != 1) {
                if (callback) {
                    callback(false, ws, msg);
                    return;
                }
                layer.open({ content: "连接尚未建立请确认服务是否开启" });
            }
        }
    });
}
//绑定打印机列表
function bindPrinters(id,callback) {
    var loading_id = layer.load(1, { shade: [0.5, '#000'] });
    var macaddress = null;
    var port = "";
    if (typeof (_port) != "undefined" && _port)
        port = _port;
    if (!port)
        port = "53817";

    var getprint = function () {
        $.initWebSocket({
            Ip: "127.0.0.1",
            Port: port,
            Method: "GetPrinter",
            onMessage: function (ws, msg) {
                var data = JSON.parse(msg.data);
                if (!data.Success) {
                    layer.close(loading_id);
                    layer.open({ content: data.Error });
                    return;
                }
                //本地打印机+服务端打印机一起
                unionBindPrinters(id, port, macaddress, data.Result);
                layer.close(loading_id);
                if (callback)
                    callback();
            },
            onClose: function (ws, msg) {
                unionBindPrinters(id, port);
                layer.close(loading_id);
                if (callback)
                    callback();
            }
        });
    }
    $.initWebSocket({
        Ip: "127.0.0.1",
        Port: port,
        Method: "GetMacAddress",
        onMessage: function (ws, msg) {
            var data = JSON.parse(msg.data);
            if (!data.Success) {
                layer.close(loading_id);
                layer.open({ content: data.Error });
                return;
            }
            macaddress = data.Result;
            getprint();
        },
        onClose: function (ws, msg) {
            unionBindPrinters(id, port);
            layer.close(loading_id);
            if (callback)
                callback();
        }
    });
}
//本地和服务端打印机一起绑定
function unionBindPrinters(id, port, mac, printer) {
    var entity = {};
    if (printer)
        entity = JSON.parse(JSON.stringify(printer));
    var approot = "";
    if (typeof (_root) != "undefined" && _root)
        approot = _root;
    //获取服务端打印机
    $.ajax({
        type: "POST",
        url: approot + "/Labels/Design.aspx",
        cache: false,
        async: false,
        data: { action: "getprinter" },
        success: function (data) {
            data = JSON.parse(data);
            if (data.success == false) {
                layer.open({ content: data.msg });
                return;
            }
            //移除服务端和本地相同mac地址下的打印机，因为，服务端和本地可能是同一台电脑
            var array = [];
            for (var i = 0; i < data.data.length; i++) {
                if (mac && data.data[i].ComputerMAC == mac)
                    continue;
                array.push(data.data[i]);
            }
            //检查是否有重名
            var same = false;
            for (var i = 0; i < array.length; i++) {
                if (entity[array[i].Name] != undefined) {
                    same = true;
                    break;
                }
                entity[array[i].Name] = "";
            }
            //拼接本地和服务端的打印机
            var str = "";
            if (typeof (android) != "undefined" && android && android.getPrinter) {
                var bluetoothprinter = JSON.parse(android.getPrinter());
                for (var i = 0; i < bluetoothprinter.length; i++) {
                    str += "<option value='" + bluetoothprinter[i].mac + "," + bluetoothprinter[i].name + "'>(蓝牙)" + bluetoothprinter[i].name + "</option>";
                }
            }
            if (printer) {
                for (var field in printer) {
                    str += "<option value='" + field + ",127.0.0.1," + port + "'>(本地)" + field + "</option>";
                }
            }
            for (var i = 0; i < array.length; i++) {
                str += "<option value='" + array[i].Name + "," + array[i].WSIP + "," + array[i].WSPort + "'>" + (same ? "(" + array[i].WSIP + ")" : "") + array[i].Name + "</option>";
            }
            $("#" + id).html(str);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.open({ content: "获取打印机出错" });
        }
    });
}


