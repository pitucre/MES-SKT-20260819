var EShelf = function (options) {
    var _options = {
        plugin: null,
        userName: "",           //当前操作的用户名
        userId: "",             //当前操作的用户ID
        pluginName: "",         //电子货架实现的插件（对应不同厂家）
        webRoot: "",            //部署站点的根目录
        errorTryCount: 2,       //错误重试次数
        title: "",              //业务标题

        colorCodes: [
            { code: 1, desc: "红色", color: "#FF0000" },
            { code: 2, desc: "绿色", color: "#00FF00" },
            { code: 3, desc: "黄色", color: "#FFFF00" },
            { code: 4, desc: "蓝色", color: "#0000FF" },
            { code: 5, desc: "暗红", color: "#8B0000" },
            { code: 6, desc: "青色", color: "#00FFFF" },
            { code: 7, desc: "白色", color: "#FFFFFF" },
            { code: 8, desc: "橙色", color: "#FFA500" },
            { code: 9, desc: "紫色", color: "#800080" },
        ],

        init: function () {
            debugger
            if (_options.pluginName == "SYT") {
                _options.plugin = new EShelf_Plugin_SYT({
                    userId: _options.userId,
                    clientId: "PDA",
                    webRoot: _options.webRoot,
                });
            }
            else if (_options.pluginName == "MAES") {
                _options.plugin = new EShelf_Plugin_MAES({
                    userId: _options.userId,
                    webRoot: _options.webRoot,
                });
            }
            else if (_options.pluginName == "RW") {
                _options.plugin = new EShelf_RW({
                    userId: _options.userId,
                    webRoot: _options.webRoot,
                });
            }
        },
    };
    //绑定配置
    $.extend(_options, options);
    //初始化
    _options.init();

    //01.点亮指定储位灯
    this.LightUpCellLed = function (cellId, ledColor, isBlink) {
        var result = null;
        //错误重试
        for (var i = 0; i <= _options.errorTryCount; i++) {
            result = _options.plugin.LightUpCellLed(cellId, ledColor, isBlink);
            if (result.success) {
                break;
            }
            else {
                continue;
            }
        }
        //记录日志
        var content = "业务标题:" + _options.title + "\r\n调用方法:LightUpCellLed\r\n请求参数:"
            + JSON.stringify({ cellId: cellId, ledColor: ledColor, isBlink: isBlink }) + "\r\n响应结果:"
            + JSON.stringify(result);
        if (result.success) {
            this.Log(content, 1);
        }
        else {
            this.Log(content, 2);
        }
        return result;
    }

    //02.批量点亮指定储位灯
    this.LightUpCellLedList = function (cells) {
        var result = null;
        //错误重试
        for (var i = 0; i <= _options.errorTryCount; i++) {
            result = _options.plugin.LightUpCellLedList(cells);
            if (result.success) {
                break;
            }
            else {
                continue;
            }
        }
        //记录日志
        var content = "业务标题:" + _options.title + "\r\n调用方法:LightUpCellLed\r\n请求参数:"
            + JSON.stringify(cells) + "\r\n响应结果:"
            + JSON.stringify(result);
        if (result.success) {
            this.Log(content, 1);
        }
        else {
            this.Log(content, 2);
        }
        return result;
    }

    //03.转换颜色代码(默认为绿色)
    this.ConvertToColorCode = function (colorDesc) {
        var colorCode = 2;
        $.each(_options.colorCodes, function (i, o) {
            if (o.desc == colorDesc) {
                colorCode = o.code;
                return false;
            }
        });
        return colorCode;
    }

    //04.转换颜色编码(默认为绿色)
    this.ConvertToColor = function (colorDesc) {
        var color = "#00FF00";
        $.each(_options.colorCodes, function (i, o) {
            if (o.desc == colorDesc) {
                color = o.color;
                return false;
            }
        });
        return color;
    }

    //05.日志记录
    this.Log = function (content, logType) {
        if (_options.webRoot) {
            $.ajax({
                type: "POST",
                url: _options.webRoot + "/Handler/EShelf.ashx?cmd=Log",
                data: {
                    LogType: logType,
                    LogContent: content
                },
                contentType: "application/x-www-form-urlencoded",
                async: false,
                success: function (msg) {
                    if (msg) {
                        console.error(msg);
                    }
                },
                error: function (xhr, status, error) {
                    console.error(error);
                }
            });
        }
    }
}
//实益通
var EShelf_Plugin_SYT = function (options) {
    var _options = {
        userId: "",
        clientId: "",

        guid: function () {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        },

        ajaxRequest: function (url, type, data) {
            var result = null;
            $.ajax({
                type: type,
                url: url,
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.code == "0") {
                        result = {
                            success: true,
                            data: null,
                            error: null,
                        }
                    }
                    else {
                        result = {
                            success: false,
                            data: null,
                            error: data.message + "[电子货架]",
                        }
                    }
                },
                error: function (xhr, status, error) {
                    result = {
                        success: false,
                        data: null,
                        error: error + "[电子货架]",
                    }
                }
            });
            return result;
        },
    };
    $.extend(_options, options);

    this.LightUpCellLed = function (cellId, ledColor, isBlink) {
        var data = {
            cellId: cellId,
            ledColor: ledColor,
            isBlink: isBlink,
            userId: _options.userId,
            clientId: _options.clientId,
            sessionId: _options.guid(),
        };
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=SYT_LightUpCellLed";
        return _options.ajaxRequest(url,"POST",data);
    }

    this.LightUpCellLedList = function (cells) {
        var data = {
            cells: cells,
            userId: _options.userId,
            clientId: _options.clientId,
            sessionId: _options.guid(),
        };
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=SYT_LightUpCellLedList";
        return _options.ajaxRequest(url, "POST", data);
    }
}
//MAES
var EShelf_Plugin_MAES = function (options) {
    var _options = {
        time: 0,
        webRoot:"",
        userId:"",
        colorMap: [
            { standardCode: 1, code: "01", },
            { standardCode: 2, code: "02", },
            { standardCode: 3, code: "04", },
            { standardCode: 4, code: "03", },
            { standardCode: 5, code: "08", },
            { standardCode: 6, code: "06", },
            { standardCode: 7, code: "02", },
            { standardCode: 8, code: "07", },
            { standardCode: 9, code: "05", },
        ],

        ajaxRequest: function (url, type, data) {
            var result = null;
            $.ajax({
                type: type,
                url: url,
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.Status) {
                        result = {
                            success: true,
                            data: null,
                            error: null,
                        }
                    }
                    else {
                        result = {
                            success: false,
                            data: null,
                            error: data.ReturnMsg + "[电子货架]",
                        }
                    }
                },
                error: function (xhr, status, error) {
                    result = {
                        success: false,
                        data: null,
                        error: error + "[电子货架]",
                    }
                }
            });
            return result;
        },
        toCode: function (standardCode) {
            var code = '2';
            $.each(_options.colorMap, function (i, o) {
                if (o.standardCode == standardCode) {
                    code = o.code;
                    return false;
                }
            });
            return code;
        }
    };
    $.extend(_options, options);

    this.LightUpCellLed = function (cellId, ledColor, isBlink) {
        var data = {
            T1: [{
                Code: _options.userId,
                Command: ledColor == 0 ? "Close" : "",
                Pro: isBlink ? "1" : "0",
                Time: _options.time,
            }],
            T2: [{
                Ce: cellId,
                Co: _options.toCode(ledColor)
            }],
        };
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=MAES_Request";
        return _options.ajaxRequest(url, "POST", data);
    }

    this.LightUpCellLedList = function (cells) {
        var result = null;
        //区分闪烁和不闪烁
        var data1 = {
            T1: [{
                Code: _options.userId,
                Command: cells[0].ledColor == 0 ? 'Close' : '',
                Pro: '1',
                Time: _options.time,
            }],
            T2: [],
        };
        var data2 = {
            T1: [{
                Code: _options.userId,
                Command: cells[0].ledColor == 0 ? 'Close' : '',
                Pro: '0',
                Time: _options.time,
            }],
            T2: [],
        };
        $.each(cells, function (i, o) {
            if (o.isBlink) {
                data1.T2.push({
                    Ce: o.cellId,
                    Co: _options.toCode(o.ledColor)
                });
            }
            else {
                data2.T2.push({
                    Ce: o.cellId,
                    Co: _options.toCode(o.ledColor)
                });
            }
        });
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=MAES_Request";
        if (data1.T2.length > 0) {
            result = _options.ajaxRequest(url, "POST", data1);
            if (!result.success) return result;
        }
        if (data2.T2.length > 0) {
            result = _options.ajaxRequest(url, "POST", data2);
            if (!result.success) return result;
        }
        return result;
    }
}



var EShelf_RW = function (options) {
    debugger
    var _options = {
        time: 0,
        webRoot: "",
        userId: "",
        userName: "",
        colorMap: [
            { code: 3, desc: "蓝色", color: "#FFFF00" },
            { code: 4, desc: "黄色", color: "#0000FF" },
            { code: 5, desc: "紫色", color: "#8B0000" },
            { code: 6, desc: "青色", color: "#00FFFF" },
            { code: 7, desc: "白色", color: "#FFFFFF" }
        ],

        ajaxRequest: function (url, type, data) {
            var result = null;
            $.ajax({
                type: type,
                url: url,
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.status && data.status==0) {
                        result = {
                            success: true,
                            data: data.data,
                            error: null,
                        }
                    }
                    else {
                        result = {
                            success: false,
                            data: null,
                            error: data.msg + "[电子货架]",
                        }
                    }
                },
                error: function (xhr, status, error) {
                    result = {
                        success: false,
                        data: null,
                        error: msg + "[电子货架]",
                    }
                }
            });
            return result;
        },
        toCode: function (standardCode) {
            var code = '2';
            $.each(_options.colorMap, function (i, o) {
                if (o.standardCode == standardCode) {
                    code = o.code;
                    return false;
                }
            });
            return code;
        }
    };
    $.extend(_options, options);

    //上架
    this.MaterialIn = function (grn, shelfID) {
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=RW_MaterialIn&Grn=" + grn + "&shelfID=" + shelfID + "&userName=" + _options.userName;
        return _options.ajaxRequest(url, "POST");
    }
    //取料
    this.MaterialTake = function (color, grns) {
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=RW_MaterialTake&issue_color=" + color + "&grns=" + grns + "&userName=" + _options.userName;
        return _options.ajaxRequest(url, "POST");
    }
    //取消取料
    this.MaterialTakeCancel = function (grns) {
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=RW_MaterialTakeCancel" + "&grns=" + grns + "&userName=" + _options.userName;
        return _options.ajaxRequest(url, "POST");
    }
    //警报解除
    this.CancelWarning = function (shelfID) {
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=RW_CancelWarning" + "&shelf_id=" + shelfID + "&userName=" + _options.userName;
        return _options.ajaxRequest(url, "POST");
    }
    console.log(this)
    //同步料架库位
    this.WareHouseLocationSync = function (shelfID,whCode) {
        var url = _options.webRoot + "/Handler/EShelf.ashx?cmd=RW_WareHouseLocationSync" + "&shelfID=" + shelfID + "&whCode=" + whCode + "&userName=" + _options.userName;
        return _options.ajaxRequest(url, "POST");
    }
}