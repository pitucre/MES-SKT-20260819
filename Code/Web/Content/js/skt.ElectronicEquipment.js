var Plugin;
var isWeight = false;
var isCheckStationConfig = true;
var resourceId = $("#hdnCurrResourceId").val();
var stationId = $("#hdnCurrStationId").val();
var setStr = "";
var prodWeight = 0;
var isOpen = false;
var units = "";
var weightInterval = null;
var isByPass = 0;

function initElectronic(isAuto) {
    //验证工位
    if (stationId == "") {
        return;
    }
    //加载工位配置是否称重
    loadElectronic();
    //读取参数
    setStr = store.get("ElectronicWeightSet" + resourceId)
    //创建插件并打开连接
    if (isWeight) {
        Plugin = createWeighPlugin();
        Open();
    }
    //开启自动称重(默认为开启)
    isAuto = (isAuto == undefined) ? true : isAuto;
    if (isAuto) {
        if (isWeight) {
            weightInterval = setInterval(function () {
                if (Plugin != undefined && isOpen == true) {
                    GetWeight();
                }
            }, 500);
        }
    }
}

function loadElectronic() {
    if (isCheckStationConfig) {
        //检查当前工序是否有配置需要称重
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CheckIsOperate("", 1, stationId);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }
        isWeight = ajax.value;
    }
    else {
        isWeight = true;
    }
};

window.onbeforeunload = function () {
    try {
        if (isWeight) {
            Close();
        }
    } catch (e) {
        console.log(e);
    }
}

function Close() {
    Plugin.CloseElectronic(function (success, data, error) {
        if (!success) {
            console.log(error);
        }
    });
}

function Open(callback) {
    if (Plugin != undefined && (setStr == null || setStr == "")) {
        showAreaMessge("未找到当前工位设置的电子秤参数信息，请先维护！", "messageRed");
        return;
    }
    Plugin.SetElectronic(setStr, function (success, data, error) {
        if (!success) {
            isOpen = false;
            console.log(error);
            return;
        }
        isOpen = true;
        $("#divCurrentWeight").show();
        if (callback)
            callback();
    });
}

function GetWeight(callback) {
    Plugin.Get(function (success, data, error) {
        if (!success) {
            console.log(error);
            return;
        }
        var currentWeightStr = data;
        var resultWeightStr = parseFloat(data || 0);
        var setStr = store.get("ElectronicWeightSet" + resourceId);
        var unit = "";
        if (setStr != null && setStr != "") {
            var entity = {};
            entity = JSON.parse(setStr);
            unit = entity.Units;
            units = unit
        }
        $("#lblCurrentWeight").text(resultWeightStr + unit);

        if (resultWeightStr > 0) {
            $("#lblCurrentState").css("color", "green").text("稳定");
        }
        else {
            if (currentWeightStr == 0) {
                $("#lblCurrentState").css("color", "red").text("未称重");
            }
            else {
                $("#lblCurrentState").css("color", "red").text("不稳定");
            }
        }
        prodWeight = resultWeightStr;
        if (callback)
            callback();
    });
}

function checkWeight(scanSN, weightType, callback) {//称重类型：1为通用过站称重SN、2为包装称重SN（包装称重SN重量不足时不能强制过站）
    if (isWeight) {//需要称重操作
        GetWeight(function () {
            var resultWeightStr = prodWeight;
            //验证重量范围
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainerWeight.CheckSNWeight(scanSN, parseFloat(resultWeightStr), stationId, resourceId, weightType);
            if (ajax.error != null) {
                updateCollectionList(scanSN, 'NG');

                if (isByPass == 1) {
                    var errorMsg = ajax.error.Message;
                    showAreaMessge(scanSN + ':' + errorMsg, "messageRed");
                    //弹出窗口，有权限的人可以强制过站操作。
                    ByPassWeight(scanSN, resultWeightStr, errorMsg);
                    callback(false);
                    return;
                }
                else {
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                }

                $("#txtSN").select();
                callback(false);
            }
            else {
                callback(true);
            }
        });
    }
    else {
        callback(true);
    }
}

function snFocus() {
    setTimeout(function () {
        window.parent.document.getElementById("txtSN").select();
    }, 100);

}

function createWeighPlugin() {
    return {
        Get: function (callback) {
            invokeServiceMethod("GetWeight", "", callback);
        },
        CloseElectronic: function (callback) {
            invokeServiceMethod("CloseElectronic", "", callback);
        },
        SetElectronic: function (data, callback) {
            invokeServiceMethod("SetElectronic", data, callback);
        },
        GetPortNames: function (callback) {
            invokeServiceMethod("GetPortNames", "", callback);
        },
        GetComStr: function (data, callback) {
            invokeServiceMethod("GetComStr", data, callback);
        },
    };
}

function invokeServiceMethod(method, data, callback) {
    $.initWebSocket({
        Ip: "127.0.0.1",
        Port: "53817",
        Method: method,
        Data: data,
        onMessage: function (ws, msg) {
            var data = JSON.parse(msg.data);
            if (!data.Success) {
                if (callback)
                    callback(false, null, data.Error);
            }
            else {
                if (callback)
                    callback(true, data.Result, null);
            }
        },
        onClose: function (ws, msg) {
            if (ws && ws.readyState != 1) {
                if (callback)
                    callback(false, null, "连接尚未建立,请确认SKT-LEANMES服务是否开启");
            }
        }
    });
}
