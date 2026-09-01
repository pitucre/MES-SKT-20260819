(function ($, window, layer, undefined) {
    $.extend({
        initWebSocket: function (options) {
            try {
                if (!options.Ip) {
                    layer.open({ content: "参数Ip不能为空！" });
                    return;
                }
                if (!options.Port) {
                    layer.open({ content: "参数Port不能为空！" });
                    return;
                }
                if (options.Data == null || options.Data == undefined)
                    options.Data = "";
                if (typeof options.Data != "string") {
                    layer.open({ content: "发送的消息类型只能是字符！" });
                    return;
                }
                if (!options.Method) {
                    layer.open({ content: "参数Method不能为空！" });
                    return;
                }
                if (options.Method.length > 30) {
                    layer.open({ content: "参数Method长度不能大于30！" });
                    return;
                }
                var socket = new WebSocket("ws://" + options.Ip + ":" + options.Port + "/");
                socket.onopen = function (msg) {
                    var result = true;
                    if (options.onOpen)
                        result = options.onOpen(socket, msg);
                    if (!result)
                        return;

                    var interval = 120,//单次发送时间间隔
                    sendLen = 5000,//单次发送字符长度
                    length = options.Data.length,//剩余消息文本还没发完的长度。
                    sendLenStr = options.Data.length.toString();//总长度字符长，这个要告诉服务端总长度。

                    while (options.Method.length < 30) { options.Method = " " + options.Method; }//前三十位代表操作方法
                    while (sendLenStr.length < 10) { sendLenStr = "0" + sendLenStr; }//方法后10位代表长度

                    sendLenStr = options.Method + sendLenStr;
                    var array = [];
                    if (options.Data) {
                        while (length > 0) {
                            if (options.Data.length >= sendLen) {
                                array.push(sendLenStr + options.Data.substring(0, sendLen));
                                options.Data = options.Data.substring(sendLen);
                                length -= sendLen;
                            } else if (options.Data.length > 0) {
                                array.push(sendLenStr + options.Data);
                                options.Data = "";
                                length = 0;
                            }
                            sendLenStr = "";
                        }
                    } else {
                        array.push(sendLenStr);
                    }
                    if (array.length == 0)
                        return;
                    var index = 0;
                    var set = setInterval(function () {
                        if (index < array.length) {
                            socket.send(array[index]);
                            index++;
                            if (options.onSend)
                                options.onSend(index, array.length);
                        }
                        else
                            clearInterval(set);
                    }, interval);
                };
                socket.onmessage = function (msg) {
                    //返回消息后，服务端会主动关闭连接，不需要客户端关闭，因为客户端关闭太慢了。
                    //这个时候就不需要通知 onClose了，因为流程结束了，要重新请求服务端，则重新连接。
                    options.onClose = null;
                    if (options.onMessage)
                        options.onMessage(socket, msg);
                };
                socket.onclose = function (msg) {
                    if (options.onClose)
                        options.onClose(socket, msg);
                };
            }
            catch (ex) {
                layer.open({ content: "WS异常：" + ex.message });
            }
        }
    })
})(jQuery, window, layer, undefined);