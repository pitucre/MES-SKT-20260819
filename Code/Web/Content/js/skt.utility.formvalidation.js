/****************************************************************************
*  Author: Alen Liu
*  Create Datetime: 2014-01-10
*  Desc: 表单验证
*  Version: 1.0.0
*  Email: shzalen@163.com
****************************************************************************/

/* 
用途：检查输入字符串是否为空或者全部都是空格 
输入：str 
返回：如果全是空返回true,否则返回false 
*/
function isNull(str) {
    if (str == "") return true;
    var regu = "^[ ]+$";
    var re = new RegExp(regu);
    return re.test(str);
}

/* 
 *  用途：检查输入字符串是否是正整数格式 
 *  输入：s 字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isNumber(s) {
    var regu = "^[0-9]+$";
    var re = new RegExp(regu);
    if (s.search(re) != -1) {
        return true;
    } else {
        return false;
    }
}

/* 
 *  用途：检查输入字符串是否是带小数的数字格式,可以是负数 
 *  输入：s：字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isDecimal(str) {
    if (isNumber(str)) return true;
    var re = /^[-]{0,1}(\d+)[\.]+(\d+)$/;
    if (re.test(str)) {
        if (RegExp.$1 == 0 && RegExp.$2 == 0) return false;
        return true;
    } else {
        return false;
    }
}

/* 
 *  用途：检查输入对象的值是否符合端口号格式 
 *  输入：str 输入的字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isPort(str) {
    return (isNumber(str) && str < 65536);
}

/* 
 *  用途：检查输入字符串是否符合金额格式,格式定义为带小数的正数，小数点后最多三位 
 *  输入：s：字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isMoney(s) {
    var regu = "^[0-9]+[\.][0-9]{0,3}$";
    var re = new RegExp(regu);
    if (re.test(s)) {
        return true;
    } else {
        return false;
    }
}

/* 
 *  用途：检查输入字符串是否只由英文字母和数字和下划线组成 
 *  输入：s：字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isNumberOr_Letter(s) {
    var regu = "^[0-9a-zA-Z\_]+$";
    var re = new RegExp(regu);
    if (re.test(s)) {
        return true;
    } else {
        return false;
    }
}

/* 
 *  用途：检查输入字符串是否只由英文字母和数字组成 
 *  输入：s：字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isNumberOrLetter(s) {
    var regu = "^[0-9a-zA-Z]+$";
    var re = new RegExp(regu);
    if (re.test(s)) {
        return true;
    } else {
        return false;
    }
}

/* 
 *  用途：检查输入字符串是否只由汉字、字母、数字组成 
 *  输入：value：字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isChinaOrNumbOrLett(s) {
    var regu = "^[0-9a-zA-Z\u4e00-\u9fa5]+$";
    var re = new RegExp(regu);
    if (re.test(s)) {
        return true;
    } else {
        return false;
    }
}

/* 
 *  用途：判断是否是日期 
 *  输入：date：日期；fmt：日期格式 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isDate(date, fmt) {
    if (fmt == null) fmt = "yyyy-MM-dd";
    var yIndex = fmt.indexOf("yyyy");
    if (yIndex == -1) return false;
    var year = date.substring(yIndex, yIndex + 4);
    var mIndex = fmt.indexOf("MM");
    if (mIndex == -1) return false;
    var month = date.substring(mIndex, mIndex + 2);
    var dIndex = fmt.indexOf("dd");
    if (dIndex == -1) return false;
    var day = date.substring(dIndex, dIndex + 2);
    if (!isNumber(year) || year > "2100" || year < "1900") return false;
    if (!isNumber(month) || month > "12" || month < "01") return false;
    if (day > getMaxDay(year, month) || day < "01") return false;
    return true;
}

/* 
*  用途：获取指定年指定月的天数 
*  输入：year 年， month 月
*  返回：指定年指定月的天数
*/
function getMaxDay(year, month) {
    if (month == 4 || month == 6 || month == 9 || month == 11)
        return "30";
    if (month == 2)
        if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
            return "29";
        else
            return "28";
    return "31";
}

/* 
 *  用途：字符1是否以字符串2结束 
 *  输入：str1：字符串；str2：被包含的字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isLastMatch(str1, str2) {
    var index = str1.lastIndexOf(str2);
    if (str1.length == index + str2.length) return true;
    return false;
}


/* 
 *  用途：字符1是否以字符串2开始 
 *  输入：str1：字符串；str2：被包含的字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isFirstMatch(str1, str2) {
    var index = str1.indexOf(str2);
    if (index == 0) return true;
    return false;
}

/* 
 *  用途：字符1是包含字符串2 
 *  输入：str1：字符串；str2：被包含的字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function isMatch(str1, str2) {
    var index = str1.indexOf(str2);
    if (index == -1) return false;
    return true;
}

/* 
 *  用途：检查输入的起止日期是否正确，规则为两个日期的格式正确，且结束如期>=起始日期 
 *  输入：startDate：起始日期，endDate：结束如期，字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function checkTwoDate(startDate, endDate) {
    if (!isDate(startDate,null)) {
        if (typeof (InvalidateStartDate) == "undefined") {
            alert("起始日期不正确!");
        }
        else {
            alert(InvalidateStartDate);
        }
        return false;
    } else if (!isDate(endDate,null)) {
        if (typeof (InvalidateEndDate) == "undefined") {
            alert("终止日期不正确!");
        }
        else {
            alert(InvalidateEndDate);
        }
        return false;
    } else if (startDate > endDate) {
        if (typeof (StartDateIsGreaterThanEndDate) == "undefined") {
            alert("起始日期不能大于终止日期!");
        } else {
            alert(StartDateIsGreaterThanEndDate);
        }
        return false;
    }
    return true;
}

/* 
 *  用途：检查输入的Email信箱格式是否正确 
 *  输入：strEmail：字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function checkEmail(strEmail) {
    //var emailReg = /^[_a-z0-9]+@([_a-z0-9]+\.)+[a-z0-9]{2,3}$/; 
    var emailReg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
    if (emailReg.test(strEmail)) {
        return true;
    } else {
        alert("您输入的Email地址格式不正确！");
        return false;
    }
}

/* 
 *  用途：检查输入的电话号码格式是否正确 
 *  输入：strPhone：字符串 
 *  返回：如果通过验证返回true,否则返回false 
 */
function checkPhone(strPhone) {
    re1 = /^1\d{10}$/;
    re2 = /^0\d{2,3}-?\d{7,8}$/;
    if (!re1.test(strPhone) && !re2.test(strPhone)) {
        alert("您输入的电话号码不正确,如果是座机需加上区号(如0755)!");
        return false;
    } else {
        return true;
    }
}


/*
 *  用途：检查字符串长度是否正确
 *  输入：s 字符串, l 长度，lessthan: true 小于，false 大于
 *  返回：如果验证通过返回true，验证失败返回false
 */
function checkStrLen(s, l, lessthan) {
    if (isNull(s)) return false;
    if (lessthan) {
        if (s.length < l) {
            return true;
        }
        else {
            return false;
        }
    }
    else {
        if (s.length > l) {
            return true;
        }
        else {
            return false;
        }
    }
}


/*
 *  用途：检查时间格式
 *  输入：s 字符串
 *  返回：如果时间格式为 HH:mm,则返回true，否则返回false
 */
function checkTime(s) {
    var reg = /^[0-2][0-9]:[0-5][0-9]/g;
    if (s.length != 5) {
        return false;
    }
    return reg.test(s);
}

/* 
*  用途：检查输入的邮编格式是否正确 
*  输入：strPostal：字符串 
*  返回：如果通过验证返回true,否则返回false 
*/
function checkPostal(strPostal) {   
    var postalReg = /^[1-9][0-9]{5}$/;
    if (postalReg.test(strPostal)) {
        return true;
    } else {
        alert("您输入的邮编格式不正确！");
        return false;
    }
}


