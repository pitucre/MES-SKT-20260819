///<reference path="jquery.min.js" />
/****************************************************************************
*  Author: Alen Liu
*  Create Datetime: 2014-01-10
*  Desc: 通用功能js
*  Version: 1.0.0
*  Email: shzalen@163.com
****************************************************************************/


// 打开一个 websocket

/*
*  用途：打开一个 websocket
*  输入：打开回传方法，接收回传方法，关闭回传方法
*  返回：json对象
*/
function StartWebSocket(onopenFn, onmessageFn, oncloseFn) {
    var ws = null;
    if ("WebSocket" in window) {
        console.log("您的浏览器支持 WebSocket!");
        try
        {
            ws = new WebSocket("ws://127.0.0.1:666");
            ws.onopen = function () {
                console.log("WebSocket打开成功");
                console.log("正在获取打印机");
                onopenFn()
            };
            ws.onmessage = function (evt) {
                console.log("数据已接收" + evt.data);
                onmessageFn(evt);
            };
            ws.onclose = function () {
                // 关闭 websocket
                console.log("连接已关闭...");
                oncloseFn();
                ws = null;
            };
        }
        catch(e)
        {
            return null;
        }
    }
    else {
        // 浏览器不支持 WebSocket
        console.log("您的浏览器不支持 WebSocket!");
    }
    return ws;
}

/*
*  用途：将字符串转为Json对象
*  输入：字符串
*  返回：json对象
*/
function strJson2Object(jsonStr) {
    return eval('(' + jsonStr + ')');
}


/*
*  用途：选项卡
*  输入：obj 选项卡ID，tabId 选项卡编号
*  返回：json对象
*/
function selectTab(obj, tabId) {
    $(".infoTabItem-selected").removeClass("infoTabItem-selected");
    $(obj).addClass("infoTabItem-selected");

    $(".infoTabContent-selected").removeClass("infoTabContent-selected");
    $("#infoTabContent-" + tabId).addClass("infoTabContent-selected");
}

/*
*  用途：打开等待提示对话框,每个页面均可调用
*  输入：无
*  返回：无
*/
function showWaiting() {
    dialog({ title: "系统提示", width: 180, height: 100, resizeable: false, content: "<div style=\"text-align:center;margin-top:auto;color:Green;\"><img src=\"../Content/theme/Metro/images/bigloading.gif\" /><br/><br/>正在处理,请稍候......</div>" });
    $("#dialog-close").hide();
}

/*
*  用途：关闭等待提示对话框,每个页面均可调用
*  输入：无
*  返回：无
*/
function closeWaiting() {
    closeDialog();
}

/*
*  用途：格式化输入字符串
*  输入: "hello{0}".format('world')；返回'hello world'
*  返回：格式化后的字符串
*/
String.prototype.format = function () {
    var args = arguments;
    return this.replace(/\{(\d+)\}/g, function (s, i) {
        return args[i];
    });
}

/*
*  用途：替换%XXX%
*  输入：str 要替换的字符串
*  返回：返回%%所包含的对象数组
*/
function reg(str) {
    if (str == "") {
        return "";
    }
    else if (str.indexOf("%") == -1) {
        return str;
    }
    else {
        return str.match(/%.*?%/img).join("=").replace(/%/g, "").replace(/%/g, "").split("=");
    }
}


/*
*  用途：回车时阻止IE冒泡事件
*  输入：无
*  返回：无
*/
function stopDefault(e) {
    /*如果提供了事件对象，则这是一个非IE浏览器   */
    if (e && e.preventDefault) {
        /*阻止默认浏览器动作(W3C)  */
        e.preventDefault();
    } else {
        /*IE中阻止函数器默认动作的方式   */
        window.event.returnValue = false;
    }
    return false;
}

/*
*  用途：处理回车事件要执行的方法
*  输入：无
*  返回：无
*  用法：$("#xxxx").enterKey("function name");
*/
(function ($) {
    $.fn.enterKey = function (opt) {
        $(this).focus();
        $(this).keypress(function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                if ($.trim($(this).val()) != "") {
                    eval(opt + "()");
                }
                return false;
            }
        });
    };
})(jQuery)

/*
*  用途：信息提示
*  输入：无
*  返回：无
*  用法：在需要使用信息提示的元素加上tooltips样式类
*/
/*$(function () {
$(".tooltips").tooltip({ track: true });
});*/

/*html编码*/
function htmlencode(s) {
    var div = document.createElement('div');
    div.appendChild(document.createTextNode(s));
    return div.innerHTML;
}
/*html解码*/
function htmldecode(s) {
    var div = document.createElement('div');
    div.innerHTML = s;
    return div.innerText || div.textContent;
}

/*过滤系统内置特殊符号(^)*/
function FilterSpecialChar(val) {
    if (typeof (val) != "undefined") {
        return val.replace(/\^/g, "");
    }
    return "";
}

/*打开ChoosePage通用方法(仅供模板调用)*/
var _currentChoosePageTxt = null;
var _currentChoosePageId = -1;
function openChoosePage_Sys(pageId, txtId) {
    var url = _root + "/Framework/ChoosePage.aspx?PageId=" + pageId + "&Multiple=false&CallBackFunc=getChoosePageVal_Sys&rnd=" + Math.random();
    dialog({ title: "选择窗口", src: url, width: 600, height: 400 });
    _currentChoosePageTxt = txtId;
}

/*获取ChoosePage值通用方法(仅供模板调用)*/
function getChoosePageVal_Sys(list) {
    if (_currentChoosePageId != 28) {
        $("#" + _currentChoosePageTxt).val(list[0][1] + "|" + list[0][0]);
    } else {/*流程单号特例,唯一,便于统计*/
        $("#" + _currentChoosePageTxt).val(list[0][1]);
    }
    $("#hdn" + _currentChoosePageTxt).val(list[0][0]);
}

/*获取模板字段,以及字段值的字符串通用方法(仅供模板调用)
返回数组：第一个值是列名串联字符串
第二个值是列值串联字符串
*/
function getTmplFields_Sys() {
    var _colVal = ["", ""];
    var _ctrls = $("input[ctrl_TmplType_Flags]");
    var _colString = "", _colValString = "";
    for (var i = 0; i < _ctrls.length; i++) {
        _colString += (_colString == "" ? "" : ",") + $(_ctrls[i]).attr("ctrl_TmplType_Flags");
        _colValString += (_colValString == "" ? "" : "^") + FilterSpecialChar($(_ctrls[i]).val());
    }
    _colVal[0] = _colString;
    _colVal[1] = _colValString;

    return _colVal;
}


String.prototype.trim = function () {

    return this.replace(/(^\s*)|(\s*$)/g, '');
}

//Ajax日期格式化
String.prototype.todate = function () {
    var regDate;
    if ($.trim(this.toString()) == "") {
        regDate = "9999/12/31 0:00:00";
    }
    else {
        regDate = this.replace(/-/ig, '/');
    }
    var dateTime = new Date(regDate);
    return dateTime;
};

/*
用途：处理Ajax执行的错误 
输入：err，Ajax错误： ajax.error
返回：如果有错误且错误信息为timeout，则跳转到超时页面，否则弹出错误信息；
如果没有错误返回true 
*/
function handleAjaxError(err) {
    if (err != null) {
        if (err.Message == "timeout") {
            alert("您登录已超时。");
            location.href = "../Framework/Expired.aspx?expiredPath=" + encodeURIComponent(location.href);
            return false;
        }
        alert(err.Message);
        return false;
    }
    else {
        return true;
    }
}

function styleErrorControl(ctl) {
    ctl.focus();
    ctl.select();
}

/**
*   获取URL参数值
**/
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}

/**
*   限制输入数字为整形
**/
function getIntVal(obj) {
    var c = $(obj);
    if (/[^\d]/.test(c.val())) {//替换非数字字符  
        var temp_amount = c.val().replace(/[^\d]/g, '');
        $(obj).val(temp_amount);
    }
}

/**
*   限制输入为数字和小数点
**/
function getDecimalVal(obj) {
    //得到第一个字符是否为负号
    var t = obj.value.charAt(0);
    //先把非数字的都替换掉，除了数字和. 
    obj.value = obj.value.replace(/[^\d\.]/g, '');
    //必须保证第一个为数字而不是. 
    obj.value = obj.value.replace(/^\./g, '');
    //保证只有出现一个.而没有多个. 
    obj.value = obj.value.replace(/\.{2,}/g, '.');
    //保证.只出现一次，而不能出现两次以上 
    obj.value = obj.value.replace('.', '$#$').replace(/\./g, '').replace('$#$', '.');
    //如果第一位是负号，则允许添加
    //  if (t == '-') {
    //      obj.value = '-' + obj.value;
    //  }
}

//防止用户按backSpace键调页问题
window.onload = function () {
    document.getElementsByTagName("body")[0].onkeydown = function () {

        //获取事件对象
        var elem = event.relatedTarget || event.srcElement || event.target || event.currentTarget;

        if (event.keyCode == 8) {//判断按键为backSpace键

            //获取按键按下时光标做指向的element
            var elem = event.srcElement || event.currentTarget;

            //判断是否需要阻止按下键盘的事件默认传递
            var name = elem.nodeName;
            //console.dir(elem)  BirongLiang 2017-2-12 fix for Kanban TextEditor
            if (elem.className.trim() === 'edui-body-container') {
                return;
            }
            if (name != 'INPUT' && name != 'TEXTAREA') {
                return _stopIt(event);
            }
            var type_e = elem.type.toUpperCase();
            if (name == 'INPUT' && (type_e != 'TEXT' && type_e != 'TEXTAREA' && type_e != 'PASSWORD' && type_e != 'FILE')) {
                return _stopIt(event);
            }
            if (name == 'INPUT' && (elem.readOnly == true || elem.disabled == true)) {
                return _stopIt(event);
            }
        }
    }
}
function _stopIt(e) {
    if (e.returnValue) {
        e.returnValue = false;
    }
    if (e.preventDefault) {
        e.preventDefault();
    }

    return false;
}

/**
*判断浏览器类型
**/
function checkBrowser() {
    var userAgent = navigator.userAgent,
                rMsie = /(msie\s|trident.*rv:)([\w.]+)/,
                rFirefox = /(firefox)\/([\w.]+)/,
                rOpera = /(opera).+version\/([\w.]+)/,
                rChrome = /(chrome)\/([\w.]+)/,
                rSafari = /version\/([\w.]+).*(safari)/;
    var browser;
    var version;
    var ua = userAgent.toLowerCase();
    var match = rMsie.exec(ua);

    if (match != null) {
        return { browser: "IE", version: match[2] || "0" };
    }
    var match = rFirefox.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rOpera.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rChrome.exec(ua);
    if (match != null) {
        return { browser: match[1] || "", version: match[2] || "0" };
    }
    var match = rSafari.exec(ua);
    if (match != null) {
        return { browser: match[2] || "", version: match[1] || "0" };
    }
    if (match != null) {
        return { browser: "", version: "0" };
    }
}

//字符格式化方法
String.format = function () {
    var s = arguments[0];
    for (var i = 0; i < arguments.length - 1; i++) {
        var reg = new RegExp("\\{" + i + "\\}", "gm");
        s = s.replace(reg, arguments[i + 1]);
    }
    return s;
}

//获url参数
String.getUrlParam = function (p) {
    var reg = new RegExp(String.format("(^|&){0}=([^&]*)(&|$)", p));
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return decodeURIComponent(r[2]);
    }
    return null;
}


//导出HTML数据。add by Hanson.Lei on 2016.12.12
function expToExcel(text) {
    $("#exportexcelframe").remove();
    $(document.body).append("<iframe id='exportexcelframe' src='about:blank' style='width: 0px; height: 0px;'></iframe>");
    $("#exportexcelframe").html("");
    $("#exportexcelframe").append("<form id='exportexcelform' name='exportexcelform' method='post' target='_self' action='" + "http://" + window.location.host + _root + "/Framework/ExportToExcel.aspx?v=" + new Date().getTime() + "'><input type='hidden' name='ExpToExcelContext' value='" + escape(text) + "'/></form>");

    //浏览器兼容
    var $form = $(window.frames["exportexcelframe"].document).find("#exportexcelform");
    if ($form == null || $form.length == 0) { $form = $("#exportexcelframe").find("#exportexcelform"); }
    $form.submit();
}

/**
 * JS导出HTML表格到excel
 */
var idTmr; 
function exportExcel(tableid) {//整个表格拷贝到EXCEL中
    if (checkBrowser().browser == 'IE') {
        var curTbl = document.getElementById(tableid);
        var oXL = new ActiveXObject("Excel.Application");

        //创建AX对象excel
        var oWB = oXL.Workbooks.Add();
        //获取workbook对象
        var xlsheet = oWB.Worksheets(1);
        //激活当前sheet
        var sel = document.body.createTextRange();
        sel.moveToElementText(curTbl);
        //把表格中的内容移到TextRange中
        sel.select();
        //全选TextRange中内容
        sel.execCommand("Copy");
        //复制TextRange中内容 
        xlsheet.Paste();
        //粘贴到活动的EXCEL中      
        oXL.Visible = true;
        //设置excel可见属性

        try {
            var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");
        } catch (e) {
            print("Nested catch caught " + e);
        } finally {
            oWB.SaveAs(fname);

            oWB.Close(savechanges = false);
            //xls.visible = false;
            oXL.Quit();
            oXL = null;
            //结束excel进程，退出完成
            //window.setInterval("Cleanup();",1);
            idTmr = window.setInterval("Cleanup();", 1);

        }
    }
    else {
        tableToExcel(tableid)
    }
}

function Cleanup() {
    window.clearInterval(idTmr);    
}

var tableToExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,',
    template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><meta http-equiv="Content-Type" charset=utf-8"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
      base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) },
      format = function (s, c) {
          return s.replace(/{(\w+)}/g,
          function (m, p) { return c[p]; })
      }
    return function (table, name) {
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
        window.location.href = uri + base64(format(template, ctx))
    }
})()

//转utf-8（解决中文乱码问题）
function utf16to8(str) {
    var out, i, len, c;  
    out = "";  
    len = str.length;  
    for(i = 0; i < len; i++) {  
        c = str.charCodeAt(i);  
        if ((c >= 0x0001) && (c <= 0x007F)) {  
            out += str.charAt(i);  
        } else if (c > 0x07FF) {  
            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));  
            out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));  
            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));  
        } else {  
            out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));  
            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));  
        }  
    }  
    return out;  
}

//数学运算符转换编码
function mathSymbolToCode(str)
{
    if(!str){
        return str;
    }

    if(str.indexOf("≥")!=-1){
        str = str.replace("≥", ">=");
    }
   else if (str.indexOf("≤") != -1) {
        str = str.replace("≤", "<=");
    }
   else if (str.indexOf("=") != -1) {
        str = str.replace("=", "==");
    }
    return str;
}
//编码转换数学运算符
function codeToMathSymbol(str) {
    if (!str) {
        return str;
    }
    if (str.indexOf(">=") != -1) {
        str = str.replace(">=", "≥");
    }
    if (str.indexOf("<=") != -1) {
        str = str.replace("<=", "≤");
    }
    if (str.indexOf("==") != -1) {
        str = str.replace("==", "=");
    }
    return str;
}


//where 扩展
Array.prototype.where = function (callback) {
    if (typeof this != "object" || this.constructor != Array || !callback) return null;

    return $.map(this, function (c) { if (callback(c) == true) return c; });
};

//对象转xml
var XmlHelper = function () {
    var _arrayTypes = {}
    var _self = this;
    var _obj = {}
    /*
    *转换对象为xml
    *@obj 目标对象
    *@rootname 节点名称
    *@arraytypes 配置数组字段子元素的节点名称
    */
    this.parseToXML = function (obj, rootname, arraytypes) {
        if (arraytypes) {
            _arrayTypes = arraytypes;
        }
        _obj = obj;
        var xml = "";
        if (typeof obj !== "undefined") {
            if (Array.isArray(obj)) {
                xml += parseArrayToXML(obj, rootname);
            } else if (typeof obj === "object") {
                xml += parseObjectToXML(obj, rootname);
            } else {
                xml += parseGeneralTypeToXML(obj, rootname);
            }
        }
        return xml;
    }
    var parseObjectToXML = function (obj, rootname) {
        if (typeof rootname === "undefined" || !isNaN(Number(rootname))) {
            rootname = "Object";
        }
        var xml = "<" + rootname + ">";
        if (obj) {
            for (var field in obj) {
                var value = obj[field];
                if (typeof value !== "undefined") {
                    if (Array.isArray(value)) {
                        xml += parseArrayToXML(value, field);
                    } else if (typeof value === "object") {
                        xml += _self.parseToXML(value, field);
                    } else {
                        xml += parseGeneralTypeToXML(value, field);
                    }
                }
            }
        }
        xml += "</" + rootname + ">";
        return xml;
    }
    var parseArrayToXML = function (array, rootname) {
        if (typeof rootname === "undefined" || !isNaN(Number(rootname))) {
            rootname = "Array";
        }
        var xml = "<" + rootname + ">";
        if (array) {
            var itemrootname = _arrayTypes[rootname];
            array.forEach(function (item) {
                xml += _self.parseToXML(item, itemrootname);
            });
        }
        xml += "</" + rootname + ">";
        return xml;
    }
    var parseGeneralTypeToXML = function (value, rootname) {
        if (typeof rootname === "undefined" || !isNaN(Number(rootname))) {
            rootname = typeof value;
        }
        var xml = "<" + rootname + ">" + value + "</" + rootname + ">";
        return xml;
    }
}

/*
用途：处理文件下载防止浏览器直接打开 
输入：url:完整下载地址，filename:文件名 
*/
function fileDownload(url, filename) {
    // 发送http请求，将文件链接转换成文件流
    fileAjax(url, function (xhr) {
        downloadFile(xhr.response, filename);
    }, {
        responseType: 'blob'
    });
}

//模拟发送http请求
function fileAjax(url, callback, options) {
    var xhr = new XMLHttpRequest();
    xhr.open('get', url, true);
    if (options.responseType) {
        xhr.responseType = options.responseType;
    }
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            callback(xhr);
        }
    }
    xhr.send();
}
//下载文件
function downloadFile(content, filename) {
    window.URL = window.URL || window.webkitURL;
    var a = document.createElement('a');
    var blob = new Blob([content]);
    // 通过二进制文件创建url
    var url = window.URL.createObjectURL(blob);
    a.href = url;
    a.download = filename;
    a.click();
    // 销毁创建的url
    window.URL.revokeObjectURL(url);
}