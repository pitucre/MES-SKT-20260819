/****************************************************************************
*  Author: Alen Liu
*  Create Datetime: 2014-01-10
*  Desc: 日期js文件
*  Version: 1.0.0
*  Email: shzalen@163.com
****************************************************************************/

/*
 *  用途：格式化日期
 *  输入：objDate 字符串
 *  返回：yyyy-MM-dd
 */
function formatDateControlValue(objDate) {
    var dateStr = objDate.value;
    var reg, isValid = false;
    var sep = "-";

    reg = /^\d{8}$/;
    if (reg.test(dateStr)) {
        dateStr = dateStr.substr(0, 4) + "/" + dateStr.substr(4, 2) + "/" + dateStr.substr(6, 2);
        isValid = true;
    }
    else {
        reg = /^\d{4}-\d{1,2}-\d{1,2}$/;
        if (reg.test(dateStr)) {
            dateStr = dateStr.replace(/-/g, "/");
            isValid = true;
        }
        else {
            reg = /^\d{4}\/\d{1,2}\/\d{1,2}$/;
            if (reg.test(dateStr)) {
                sep = "/";
                isValid = true;
            }
        }
    }

    if (isValid) {
        var date = new Date();
        date.setTime(Date.parse(dateStr));
        objDate.value = date.getFullYear() + sep + ((100 + (date.getMonth() + 1)) + "").substr(1, 2) + sep + ((100 + date.getDate()) + "").substr(1, 2);
    }

    return isValid;
}

/*
 *  用途：格式化时间
 *  输入：objTime 字符串
 *  返回：HH:mm
 */
function formatTimeControlValue(objTime) {
    var timeStr = objTime.value;
    var reg = /^\d{4}$/;
    if (reg.test(timeStr)) {
        timeStr = timeStr.substr(0, 2) + ":" + timeStr.substr(2, 2);
        objTime.value = timeStr;
    }

    reg = /^[0-3]?[0-9]:[0-5]?[0-9]$/;
    return reg.test(timeStr);
}

/*
 *  用途：格式化为短日期格式字符
 *  输入：strDate 日期格式
 *  返回：如果日期是“9999-12-31”则返回空，否则返回短日期格式字符串
 */
function dateToShortDateString(strDate) {
    if (strDate.trim() == "") return "";

    if (strDate.indexOf("9999") != -1) return "";

    if (strDate.indexOf(" ") != -1) {
        strDate = strDate.substring(0, strDate.indexOf(" "));
    }

    var arrDate;
    if (strDate.indexOf("-") != -1) {
        arrDate = strDate.split("-");
        strDate = arrDate[0] + "-" + (parseInt(arrDate[1]) < 10 ? "0" : "") + parseInt(arrDate[1]) + "-" + (parseInt(arrDate[2]) < 10 ? "0" : "") + parseInt(arrDate[2])
    }
    else if (strDate.indexOf("/") != -1) {
        arrDate = strDate.split("/");
        strDate = arrDate[0] + "/" + (parseInt(arrDate[1]) < 10 ? "0" : "") + parseInt(arrDate[1]) + "/" + (parseInt(arrDate[2]) < 10 ? "0" : "") + parseInt(arrDate[2])
    }

    return strDate;
}

/*
*  用途：将日期转化为中文格式
*  输入：strDate 日期格式
*  返回：返回中文格式的日期
*/
function dateToChineseDateString(strDate) {
    if (strDate.trim() == "") return "";

    if (strDate.indexOf("-") == -1) {
        if (strDate.length > 6) {
            strDate = strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
        }
        else {
            strDate = strDate.substr(0, 4) + "-" + strDate.substr(4, 2);
        }
    }

    var arrDate = strDate.split("-");

    var dateStr;
    if (arrDate.length > 2) {
        dateStr = arrDate[0] + "年" + arrDate[1] + "月" + arrDate[2] + "日";
    }
    else {
        dateStr = arrDate[0] + "年" + arrDate[1] + "月";
    }

    return dateStr;
}

/*
*  用途：根据给定的格式，格式化日期
*  输入：strDate 日期格式，
         dateType 格式类型   1：  2014年01月15日,
                            10： 2014.01.15,
                            11： 2014/01/15,
                            12： 2014-01-15,
                            20： 15.01.2014,
                            21： 15/01/2014,
                            22： 15-01-2014,
                            24： 15.January,2014,
                            25： «15»January,2014,
                            26： 15.Jan,2014,
                            27： 15.JAN,2014
*  返回：返回给定格式的日期格式
*/
function date_Format(strDate, dateType) {
    if (strDate.trim() == "") return "";

    if (strDate.indexOf("-") == -1) {
        strDate = strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
    }
    if (strDate.indexOf(" ") != -1) {
        strDate = strDate.substring(0, strDate.indexOf(" "));
    }

    var arrDate;
    if (strDate.indexOf("-") != -1)
        arrDate = strDate.split("-");
    else if (strDate.indexOf("/") != -1)
        arrDate = strDate.split("/");

    switch (dateType) {
        case 1:
            strDate = arrDate[0] + "年" + arrDate[1] + "月" + arrDate[2] + "日";
            break;
        case 10:
            strDate = arrDate[0] + "." + arrDate[1] + "." + arrDate[2];
            break;
        case 11:
            strDate = arrDate[0] + "/" + arrDate[1] + "/" + arrDate[2];
            break;
        case 12:
            strDate = arrDate[0] + "-" + arrDate[1] + "-" + arrDate[2];
            break;

        case 20:
            strDate = arrDate[2] + "." + arrDate[1] + "." + arrDate[0]; //29.05.2010
            break;
        case 21:
            strDate = arrDate[2] + "/" + arrDate[1] + "/" + arrDate[0]; //29/05/2010
            break;
        case 22:
            strDate = arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]; //29-05-2010
            break;
        case 24:
            strDate = arrDate[2] + "." + month_English(arrDate[1], 1) + "," + arrDate[0]; //29.March,2010
            break;
        case 25:
            strDate = "«" + arrDate[2] + "»" + month_English(arrDate[1], 1) + "," + arrDate[0]; //«29»March,2010
            break;
        case 26:
            strDate = arrDate[2] + "." + month_English(arrDate[1], 2) + "," + arrDate[0]; //29.Mar,2010
            break;
        case 27:
            strDate = arrDate[2] + "." + month_English(arrDate[1], 3) + "," + arrDate[0]; //29.MAR,2010
            break;
    }

    return strDate;
}

/*
*  用途：将数字月转成英文月，可给定转成大小写
*  输入：strMonth 数字月，
*  返回：返回给定格式的英文月
*/
function month_English(strMonth, longFormat) {
    switch (parseInt(strMonth)) {
        case 1:
            strMonth = longFormat == 1 ? "January" : (longFormat == 2 ? "Jan" : "JAN");
            break;
        case 2:
            strMonth = longFormat == 1 ? "February" : (longFormat == 2 ? "Feb" : "FEB");
            break;
        case 3:
            strMonth = longFormat == 1 ? "March" : (longFormat == 2 ? "Mar" : "MAR");
            break;
        case 4:
            strMonth = longFormat == 1 ? "April" : (longFormat == 2 ? "Apr" : "APR");
            break;
        case 5:
            strMonth = longFormat == 1 ? "May" : (longFormat == 2 ? "May" : "MAY");
            break;
        case 6:
            strMonth = longFormat == 1 ? "June" : (longFormat == 2 ? "Jun" : "JUN");
            break;
        case 7:
            strMonth = longFormat == 1 ? "July" : (longFormat == 2 ? "Jul" : "JUL");
            break;
        case 8:
            strMonth = longFormat == 1 ? "August" : (longFormat == 2 ? "Aug" : "AUG");
            break;
        case 9:
            strMonth = longFormat == 1 ? "September" : (longFormat == 2 ? "Sep" : "SEP");
            break;
        case 10:
            strMonth = longFormat == 1 ? "October" : (longFormat == 2 ? "Oct" : "OCT");
            break;
        case 11:
            strMonth = longFormat == 1 ? "November" : (longFormat == 2 ? "Nov" : "NOV");
            break;
        case 12:
            strMonth = longFormat == 1 ? "December" : (longFormat == 2 ? "Dec" : "DEC");
            break;
    }

    return strMonth;
}

/*
 *  用途：返回数字星期对应的英文
 *  输入：strWeek 数字星期，longFormat：1 - 英文星期全称， 2 - 英文星期缩写
 *  返回：英文星期
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

/*
 *  用途：时间格式转整型, 12:00 -> 1200
 *  输入：timestr 时间字符串，带 “：”
 *  返回：去掉":"的数字
 */
function timeToInt(timestr) {
    if (timestr.indexOf(":") < 0) {
        return 0;
    }
    return timestr.replace(":", "");
}

/*
*  用途：整型转成时间格式, 1200 -> 12：00
*  输入：timeint 大于3位的数字
*  返回：用“:”隔开的时间字符
*/
function intToTime(timeint) {
    if (timeint.toString().length < 3) {
        return "";
    }
    timeint = timeint.replace(":", "");
     
    if (timeint.toString().length == 3) {
        return "0" + timeint.toString().substring(0, 1) + ":" + timeint.toString().substring(1, 3);
    }
    return timeint.toString().substring(0, 2) + ":" + timeint.toString().substring(2, 4);
}

/*
*  用途：整型转成日期格式, 20150421 -> 2015-04-21
*  输入：dateint 大于7位的数字
*  返回：用“-”隔开的时间字符
*/
function intToDate(dateint) {
    dateint = dateint.replace("-", "").replace("-", "");
    if (dateint == null) {
        return "";
    }
    if ($.trim(dateint) == "") {
        return "";
    }
    if (dateint.toString().length < 8) {
        return "";
    }
    if (dateint.toString().length > 8) {
        return dateint.toString().substring(0, 4) + "-" + dateint.toString().substring(4, 6) + "-" + dateint.toString().substring(6, 8);
    }
    return dateint.toString().substring(0, 4) + "-" + dateint.toString().substring(4, 6) + "-" + dateint.toString().substring(6, 8);
}


/*
 *  用途：返回格式化的日期
 *  输入：theDate 日期
 *  返回：2015-10-10
 */
function getNowFormatDate(theDate) {
    var day = theDate;
    var Year = 0;
    var Month = 0;
    var Day = 0;
    var CurrentDate = "";
    // 初始化时间 
    Year = day.getFullYear(); // ie火狐下都可以 
    Month = day.getMonth() + 1;
    Day = day.getDate();
    CurrentDate += Year + "-";
    if (Month >= 10) {
        CurrentDate += Month + "-";
    } else {
        CurrentDate += "0" + Month + "-";
    }
    if (Day >= 10) {
        CurrentDate += Day;
    } else {
        CurrentDate += "0" + Day;
    }
    return CurrentDate;
}

/*
 *  用途：这个方法将取得某年(year)第几周(weeks)的星期几(weekDay)的日期
 *  输入：year 年， weeks 周， weekDay 星期
 *  返回：2015-10-10
 */
function getXDate(year, weeks, weekDay) {
    // 用指定的年构造一个日期对象，并将日期设置成这个年的1月1日 
    // 因为计算机中的月份是从0开始的,所以有如下的构造方法 
    var date = new Date(year, "0", "1");
    // 取得这个日期对象 date 的长整形时间 time 
    var time = date.getTime();
    // 将这个长整形时间加上第N周的时间偏移 
    // 因为第一周就是当前周,所以有:weeks-1,以此类推 
    // 7*24*3600000 是一星期的时间毫秒数,(JS中的日期精确到毫秒) 
    time += (weeks - 1) * 7 * 24 * 3600000;
    // 为日期对象 date 重新设置成时间 time 
    date.setTime(time);
    return getNextDate(date, weekDay);
}

/*
 *  用途：这个方法将取得 某日期(nowDate) 所在周的星期几(weekDay)的日期 
 *  输入：nowDate 某日期， weekDay 星期
 *  返回：2015-10-10
 */
function getNextDate(nowDate, weekDay) {
    // 0是星期日,1是星期一,... 
    weekDay %= 7;
    var day = nowDate.getDay();
    var time = nowDate.getTime();
    var sub = weekDay - day;
    if (sub <= 0) {
        sub += 7;
    }
    time += sub * 24 * 3600000;
    nowDate.setTime(time);
    return nowDate;
}

/*
 *  用途：判断某一周的日期是否在同一年
 *  输入：_year 某年， _week 某周
 *  返回：true/false
 */
function isInOneYear(_year, _week) {
    if (_year == null || _year == '' || _week == null || _week == '') {
        return true;
    }
    var theYear = getXDate(_year, _week, 7).getFullYear();
    if (theYear != _year) {
        return false;
    }
    return true;
}

/*
*  用途：获取某年某周的起始和结束日期
*  输入：_year 某年， _week 某周
*  返回：某年某周的起始和结束日期
*/
function getDateRange(_year, _week) {
    var beginDate;
    var endDate;
    if (_year == null || _year == '' || _week == null || _week == '') {
        return "";
    }
    beginDate = getXDate(_year, _week, 1);
    endDate = getXDate(_year, (_week - 0 + 1), 7);
    return getNowFormatDate(beginDate) + " 至 " + getNowFormatDate(endDate);
}


/*
*  add  zhibin.chen  2015-05-04
*  用途：获取当前的日期时间字符串格式
*  返回：2015-05-04 13:00:00
*/
function getCurrentDateTime() {
    var date = new Date();
    var y = date.getYear().toString();
    var m = (date.getMonth() + 1).toString();
    var d = date.getDate().toString();
    var h = date.getHours().toString();
    var mt = date.getMinutes().toString();
    var s = date.getSeconds().toString();

    return y + '-' + m + '-' + d + ' ' + h + ':' + mt + ':' + s;
}

/*
*  add  jacky.cheng  2015-05-16
*  用途：获取当前的日期时间完整字符串中文格式
*  返回：2015年05月16日 15:00:00 星期六
*/
function getAllDateTime() {
    var str = "";
    var day = new Date();
    var year = day.getFullYear();
    var month = day.getMonth() + 1;
    var date = day.getDate();
    var hour = day.getHours();
    var minute = day.getMinutes();
    var second = day.getSeconds();
    month = month < 10 ? "0" + month : month;
    date = date < 10 ? "0" + date : date;
    hour = hour < 10 ? "0" + hour : hour;
    minute = minute < 10 ? "0" + minute : minute;
    second = second < 10 ? "0" + second : second;
    switch (day.getDay()) {
        case 0:
            str = " 星期日";
            break;
        case 1:
            str = " 星期一";
            break;
        case 2:
            str = " 星期二";
            break;
        case 3:
            str = " 星期三";
            break;
        case 4:
            str = " 星期四";
            break;
        case 5:
            str = " 星期五";
            break;
        case 6:
            str = " 星期六";
            break;
    }
    return year + "年" + month + "月" + date + "日" + " " + hour + ":" + minute + ":" + second + str;
}

/*
document.write("前天："+GetDateStr(-2)); 
document.write("<br />昨天："+GetDateStr(-1)); 
document.write("<br />今天："+GetDateStr(0)); 
document.write("<br />明天："+GetDateStr(1)); 
document.write("<br />后天："+GetDateStr(2)); 
document.write("<br />大后天："+GetDateStr(3)); 
*/
function GetDateStr(AddDayCount) {
    var dd = new Date();
    dd.setDate(dd.getDate() + AddDayCount); //获取AddDayCount天后的日期
    var y = dd.getFullYear();
    var m = dd.getMonth() + 1; //获取当前月份的日期 
    var d = dd.getDate();
    m = m < 10 ? "0" + m : m;
    d = d < 10 ? "0" + d : d;
    return y + "-" + m + "-" + d;
}

//在String对象中扩展一个toDate方法
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

//通用的日期格式化
function commonFormatDate(date, format) {
    if (!date) return "";
    if (!format) format = "yyyy-MM-dd HH:mm:ss";
    if (typeof (date) === "string") date = new Date(date);

    var o = {
        "M+": date.getMonth() + 1, //month
        "d+": date.getDate(), //day
        "H+": date.getHours(), //hour
        "m+": date.getMinutes(), //minute
        "s+": date.getSeconds(), //second
        "q+": Math.floor((date.getMonth() + 3) / 3), //quarter
        "S": date.getMilliseconds() //millisecond
    }

    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
    }

    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}