
//窗口大小
var wHeight = 500;

$(document).ready(function () {    
    //当窗口大小变化时，改变相应内容区间的大小
    $(window).resize(
        function () {
            setContentHeight();
        }
    );

    setContentHeight();
});

/**
*set the height of the content
*/
function setContentHeight() {
    wHeight = $(window).height();
    $("#content").height(wHeight - 10);
}

/**
*   获取URL参数值
**/
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return "";
}

var collectionIndex = ['1', '2', '3', '4', '5'];

/**
*初始化明细表
*/
function initCollectionList() {
    var control = $("#collectionlist");
    var html = '';
    for (var i = 0; i < 5; i++) {
        html = '<tr class="';
        if (i % 2 == 0) {
            html += 'ListTableOddRow';
        } else {
            html += 'ListTableEvenRow';
        }
        html += '">';
        html += ''
              + '<td align="center" valign="middle"><a href="javascript:void(0)" style="color:#000">' + collectionIndex[i] + '</a><div></td>'
              + '<td align="center" valign="middle"></td>'
              + '<td align="center" valign="middle"></td>'
              + '</tr>';
        control.append(html);
    }
}

/*
* 设置消息提示框样式
*/
function showAreaMessge(information, styleClass) {
    var currentTime = getDateTime();
    var messageBox = $("#activeinfoarea");
    var rows = 50;
    if (styleClass == "messageRed") {
        playSound();
    }

    messageBox.find("span").eq(rows - 2).nextAll().remove(); //显示50条扫描记录        
    var html = "<span  class=" + styleClass + ">" + "[" + currentTime + "] " + information + "</span>" + '<br/>' + messageBox.html();
    messageBox.empty();
    messageBox.append(html);
}

function isIE() { //ie?
    if (!!window.ActiveXObject || "ActiveXObject" in window)
        return true;
    else
        return false;
}

/**
*   播放警报音
**/
function playSound() {
    $('embed').remove();

    var player = "";
    if (isIE()) {
        //IE内核浏览器         
        player = '<embed id="player" src="../Content/sound/warn.mp3" autostart="true" hidden="true" loop="false"></embed>';

    } else {
        //非IE内核浏览器  
        player = '<audio  id="player" autoplay ><source src="../Content/sound/warn.mp3" ></audio>';
    }

    $("body").append(player);
}

/**
*设置页面时间展示
*/
function setDateTime() {

    var now = new Date();
    var day = now.getDay();
    $("#timer").html(getDateTime() + "  " + week_Chinese(day));
};

/**
*获取当前时间
*/
function getDateTime() {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var date = now.getDate();
    var hour = now.getHours();
    var min = now.getMinutes();
    var sec = now.getSeconds();
    var day = now.getDay();

    month = (month < 10) ? '0' + month.toString() : month.toString();
    date = (date < 10) ? '0' + date.toString() : date.toString();
    hour = (hour < 10) ? '0' + hour.toString() : hour.toString();
    min = (min < 10) ? '0' + min.toString() : min.toString();
    sec = (sec < 10) ? '0' + sec.toString() : sec.toString();
    return year.toString() + '年' + month.toString() + '月' + date.toString() + "日  " + hour.toString() + ":" + min.toString() + ":" + sec.toString();
}

/**
*页面时间每秒钟变换
*/
function timerTick() {
    setDateTime();
    setInterval(
        function () {
            setDateTime();
        },
        1000
    );
}

/*返回数字星期对应的英文
输入：strWeek 数字星期，longFormat：1 - 英文星期全称， 2 - 英文星期缩写
返回：英文星期
*/
function week_English(strWeek, longFormat) {
    switch (parseInt(strWeek) + 1) {
        case 1:
            strWeek = longFormat == 1 ? "Sunday" : (longFormat == 2 ? "Sun" : "SUN");
            break;
        case 2:
            strWeek = longFormat == 1 ? "Monday" : (longFormat == 2 ? "Mon" : "MON");
            break;
        case 3:
            strWeek = longFormat == 1 ? "Tuesday" : (longFormat == 2 ? "Tue" : "TUE");
            break;
        case 4:
            strWeek = longFormat == 1 ? "Wednesday" : (longFormat == 2 ? "Wed" : "WED");
            break;
        case 5:
            strWeek = longFormat == 1 ? "Thursday" : (longFormat == 2 ? "Thu" : "THU");
            break;
        case 6:
            strWeek = longFormat == 1 ? "Friday" : (longFormat == 2 ? "Fri" : "FRI");
            break;
        case 7:
            strWeek = longFormat == 1 ? "Saturday" : (longFormat == 2 ? "Sat" : "SAT");
            break;
    }
    return strWeek;
}

/*返回数字星期对应的中文
输入：strWeek 数字星期
返回：中文星期
*/
function week_Chinese(strWeek) {
    switch (parseInt(strWeek) + 1) {
        case 1:
            strWeek = "星期日";
            break;
        case 2:
            strWeek = "星期一";
            break;
        case 3:
            strWeek = "星期二";
            break;
        case 4:
            strWeek = "星期三";
            break;
        case 5:
            strWeek = "星期四";
            break;
        case 6:
            strWeek = "星期五";
            break;
        case 7:
            strWeek = "星期六";
            break;
    }
    return strWeek;
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
*回车时阻止IE冒泡事件
*
*@param{Object} e 事件
*/
function stopDefault(e) {
    if (e && e.preventDefault) {
        //W3C
        e.preventDefault();
    } else {
        //IE
        window.event.returnValue = false;
    }
    return false;
}

//当扫描过于频繁间隔低于两秒以下时，该id用于取消timeout任务
var currentTimeoutId = null;
/**
*弹出消息框
*
*@param{string} message 消息内容
*@param{string} styleClass 显示样式
*/
function setMessageBox(message, styleClass) {
    if (currentTimeoutId != null || currentTimeoutId != undefined) {
        clearTimeout(currentTimeoutId);
    }
    var messageBox = $("#messageBox");
    messageBox.html(message);
    messageBox.attr("class", styleClass);
    messageBox.fadeIn();
    currentTimeoutId = setTimeout(closeMessageBox, 2000);
}

/**
*隐藏消息框
*/
function closeMessageBox() {
    var messageBox = $("#messageBox");
    messageBox.fadeOut();
}


/******************************【通用目录功能区域】-------begin-------*/

/**
*JS获取系统定义的资源文本
*/
function getResource(resClass, resKey) {
    return SKT.LeanMES.Web.AjaxServices.AjaxClient.GetResourceString(resClass, resKey).value;
}

/******************************【通用功能区域】-------begin----*/

/**
*过滤Request.QueryString获取的值，如果为空，则返回默认值以替代
*如果truncateLength>0,则会对RequestQueryString进行字符串长度截取处理
*
*@param{string} rqs 要处理的Requset.QueryString值
*@param{string} defaultValue rqs为空时的默认替代值
*@param{int} truncateLength 大于0时为需截取的字符串长度
*
*@return{string} 返回处理过后的值 
*/
function filterRequestQueryString(rqs, defaultValue, truncateLength) {
    if (rqs === undefined || rqs === null) {
        return defaultValue;
    }
    if (truncateLength > 0) {
        return truncateCharacter(rqs, truncateLength);
    }
    return rqs;
}


/**
*根据length判断以截取字符长度
*
*@param{string} source 需要判断是否需要截取的字符串
*@param{int} length 截取超过该长度的字符串
*
*@return{string} 返回判断处理过的字符串
*/
function truncateCharacter(source, length) {
    if (source.length > length) {
        source = source.substring(0, length) + '...';
    }
    return source;
}

/*JS获取系统定义的资源文本*/
function getResource(resClass, resKey) {
    return SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetResourceString(resClass, resKey).value;
}

/******************************【通用功能区域】-------End----*/

