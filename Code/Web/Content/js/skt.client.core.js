/***************************************************************
*  Desc: 客户端页面js操作核心库     
*  CreateDate: 2015-05-19
*  CreateBy: Starry
*  Version: 1.0.0.0

*  ModifyDate: xxxx-xx-xx
*  ModifyBy: xxxxx
*  Version: 1.0.0.0
****************************************************************/




/******************************【全局变量定义区域】---begin----*/
/*条码*/
var SN;

/*产品ID*/
var itemId;

/*路由ID*/
var routerId;

/*操作工位ID*/
var operationId;

/*资源ID*/
var resId;

/*Unit ID*/
var unitId;

/*容器ID*/
var conDataID;

/*扫描是否序列号*/
var isSN;

/*后续Activity是否处于可执行状态*/
var allActivityContinue;

/*进入时间*/
var enterTime;

/*定义在Client页的全局参数(这里可直接使用)
webroot       ： 系统根路径
userId     ： 用户ID
userName   :  用户名称
lang       :  语言模式(中：zh-cn  英：en-us)
currentTime： 记录了进入时的时间
*/
/**************************************************---end------*/






/******************************【客户端初始化执行】---begin----*/

$(function () {
    /*客户端初始化及打开后自适应大小*/
    setTimeout(function () {
        self.moveTo(0, 0)
        self.resizeTo(screen.availWidth, screen.availHeight);
        self.focus();
    }, 10);

    $(window).resize(function () {
        setScannerWidth();
        $("#template-container").css("height", $(window).height() - 180);
    });
     pageInits();
    /*------------------------*/

    /*禁用Enter键表单自动提交*/
    $(document).bind("keydown", function (event) {
        var target, code, tag;
        if (!event) {
            event = window.event;
            target = event.srcElement;
            code = event.keyCode;
            if (code == 13) {
                tag = target.tagName;
                if (tag == "TEXTAREA") { return true; }
                else { return false; }
            }
        }
        else {
            target = event.target;
            code = event.keyCode;
            if (code == 13) {
                tag = target.tagName;
                if (tag == "INPUT") { return false; }
                else { return true; }
            }
        }
    });
    /*------------------------*/
});

/***************************************************--end------*/






/******************************【客户端页面相关】-------begin--*/

/*页面初始化一些事件*/
function pageInits() {
    setScannerWidth();
    timerTick();
    $("#template-container").css("height", $(window).height() - 180);
    paramsInit();
     
    setTimeout(function () {
        loadTemplate();
    }, 100);

    $("#topbar-set").hover(function () {
        $("#topbar-set-menu").toggle();
    });
}

/*页面全局参数初始化*/
function paramsInit() {
    SN = '';
    itemId = -1;
    routerId = -1;
    operationId = $("#hndOperationId").val();
    resId = $("#hndResourceId").val();
    unitId = -1;
    conDataID = -1;
    isSN = 0;
    allActivityContinue = true;
    enterTime = '';
}

/*加载Menu菜单按钮*/
function loadButtons(buttons) {
    var strButtons = "";
    for (var i = 0; i < buttons.length; i++) {
        strButtons += "<li class='set-menu-item' style='margin-left:28px;'><span onclick='try{" + buttons[i].Handler + "}catch(ex){}'>" + buttons[i].Text + "</span></li>";
    }
    /*if (buttons.length > 0) {
    strButtons += "<li style=' margin-top:5px; height:1px; background:#cccccc; margin-left:24px; margin-top:3px; margin-bottom:5px;'></li>";
    }*/
    strButtons += "<li class='set-menu-item' style=''><span><img src='../Content/images/icon/lgout.png'  style='float:left; vertical-align:middle;'/></span><span  style='margin-left:12px;' onclick='logout();'>" + getResource("lang", "CommonExit") + "</span></li>";
    $("#r-menu-item").html(strButtons);
    /*loadButtonsTraceType();*/
}

/*加载Menu菜单中的追溯子菜单*/
function loadButtonsTraceType() {
    var liObj = $("#r-menu-item").find("li");
    $(liObj[1]).after("<li style=' margin-top:5px; height:1px; background:#cccccc; margin-left:24px; margin-top:3px; margin-bottom:5px;'></li>");
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.GetTraceTypeListByStationID(operationId);
    if (ajax.error == null) {
        var entityAry = ajax.value;
        for (var i = 0; i < entityAry.length; i++) {
            if (lang == "zh-cn") {
                $(liObj[1]).after("<li class=\"set-menu-item\" style=\"margin-left:28px;\"><span onclick=\"OpenTracForm(" + entityAry[i].TraceFormTypeId + ",\'" + entityAry[i].TypeCName + "\')\">" + entityAry[i].TypeCName + "</span></li>");
            }
            else {
                $(liObj[1]).after("<li class=\"set-menu-item\" style=\"margin-left:28px;\"><span onclick=\"OpenTracForm(" + entityAry[i].TraceFormTypeId + ",\'" + entityAry[i].TypeEName + "\')\">" + entityAry[i].TypeEName + "</span></li>");
            }
        }
        if (entityAry.length > 0) { $(liObj[1]).after("<li style=' margin-top:5px; height:1px; background:#cccccc; margin-left:24px; margin-top:3px; margin-bottom:5px;'></li>"); }
    } else {
        alert(ajax.error.Message);
    }
}

/*加载页面UI模板*/
function loadTemplate() {
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.GetTmplContentByOpeTypeId($("#hdnOpeTypeId").val(), operationId);
    if (ajax.error != null) {
        alert(ajax.error.Message);
        $("#template-container").html("<span class='Tips'>对不起！UI加载出错！</span>")
        return false;
    }
    $("#template-container").html(ajax.value);
}

/*设置页面时间展示*/
function setDateTime() {
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

    $("#timer").html(year.toString() + '/' + month.toString() + '/' + date.toString() + "  " + hour.toString() + ":" + min.toString() + ":" + sec.toString() + "  " + week_English(day, 2));
};

/*页面时间每秒钟变换*/
function timerTick() {
    setDateTime();
    setInterval(function () {
        setDateTime();
    }, 1000);
}

/*设置扫描区域内容样式*/
function setScannerWidth() {
    var h = $(window).height();
    $("#r-menu-content").height(h - 175);
    $("#r-menu-content iframe").height(h - 180);
    $("#r_menu").height(h - 56);
    $("#r_menu").width(190);
    $("#l_content").height(h - 50);
}

/*页面下方图表是否显示*/
function showChart(show) {
    if (show) {
        $("#chart-content").slideDown(400);
        $("#ifrmChart").attr("src", "chart.aspx?rnd=" + Math.random());
    }
    else {
        $("#ifrmChart").attr("src", "");
        $("#chart-content").slideUp(400);
    }
}

/*页面下方展示各种返回的信息文本*/
function setMessage(str, _status) {

    /*******************************************
    * add by zhibin.chen  2015-11-25 当工位错误的时候，获取正确的工位展示给用户。
    *******************************************/
    if (str.indexOf("扫描工位错误") >= 0 || str.indexOf("Scan operation error") >= 0 ) {
        var ajaxNextOpe = SKT.LeanMES.Web.AjaxServices.AjaxClient.GetNextOperation(SN);
        if (ajaxNextOpe.error == null) {
            var nextOpe = ajaxNextOpe.value.replace("<br/>","、");
            _status = "下一工位：" + nextOpe;
        }
        else {
            _status = "下一工位获取失败！请通过生产追溯查询流程信息！";
        }
    }

    //给出条码提示
    var snPrompt = str.indexOf(SN) >= 0 ? "" : "：&nbsp;[" + SN + "]";
    /****************/

    var dtn = new Date().Format("yyyy-MM-dd HH:mm:ss");
    $("#info-text div").removeClass("divhover");
    $("#info-text").append("<div class='divhover'>[" + dtn + "]&nbsp;&nbsp;<b>" + str + "</b>" + snPrompt + "&nbsp;&nbsp;&nbsp;&nbsp;" + ((_status == undefined) ? "" : _status) + "</div>");
    if (_status != undefined) {
        if (_status.toUpperCase() == "PASS") {
            $("#info-text div:last").css("color", "green");
        }
    }
    $("#info-text").scrollTop($("#info-text div:last-child").offset().top - $("#info-text").offset().top + $("#info-text").scrollTop());
    if (str.toUpperCase() != "PASS" && str.toUpperCase() != "FAIL") {
        alert(str);
    }
}

/*Menu菜单之---产品履历*/
function InfoCenter() {
    var w = $(window.parent).width() - 150;
    var h = $(window.parent).height() - 150;
    dialog({ title: getResource("Pages", "InfoCenter"), src: webroot + "/Manufacture/BasicInfo.aspx?name=Manufacture_BasicInfo&rnd=" + Math.random(), width: w, height: h });
}

/*Menu菜单之---修改密码*/
function ChangePwd() {
    if (userId == -1) {
        alert(getResource("Messages", "AdminCannotChangePassword"));
        return false;
    }
    dialog({ title: getResource("Pages", "UserChangePwd"), src: webroot + "/User/UserChangePwd.aspx?name=Account_ChangePwd&ID=-1&rnd=" + Math.random(), width: 450, height: 300 });
}

/*Menu菜单之---帮助*/
function Help() {
    window.open("../Help/Help.htm");
}

/*Menu菜单之---退出系统*/
function logout() {
    if (confirm(getResource("Messages", "ComfirmToQuit"))) {
        window.location = webroot + "/Logout.aspx";
    }
}

/*Menu菜单之---打开追溯菜单*/
function OpenTracForm(frmTypeid, menuNames) {
    dialog({ title: menuNames, src: webroot + "/TraceForm/TraceFormShow.aspx?ID=" + frmTypeid + "&rnd=" + Math.random(), width: 600, height: 300 });
}

/*Menu菜单之---工艺参数*/
function OpenProParams() {
    dialog({ title: getResource("Pages", "Product_StationParamView"), src: webroot + "/Product/StationParamView.aspx?ID=" + itemId + "&StationId=" + operationId + "&rnd=" + Math.random(), width: 650, height: 400 });
}


//add by zhibin.chen 2015-09-15 格力博 项目在每个工位，增加一个产线停止和恢复的功能。
/*Menu菜单之---产线开始DownTime*/
function StartDownTime() {
//    if (!IsHasPermission(userId, popedom_int)) {
//        alert("对不起！你没有权限！")
//        return false;
//    }

    var html = "<table width='100%' class='EditContentTable' style='margin-top:25px;'><tr>"
    html += "<td class='Label1' style='width:30%'>扫描异常代码：</td>";
    html += "<td class='Field1' style='width:70%'><input type='text' class='TextBox' id='glbTxtAbnormal' onkeydown='winParent.GLBtxtAbnormalEnter(window,event)'  style='width:97%;height:30px;'></td>";
    html += "</tr></table>";

    var btns = [
           { icon: "delete", text: getResource("Buttons", "StopLine"), click: "winParent.GLBstopLine(window)" },
           { icon: "return", text: getResource("lang", "AC_Cancel"), click: "winParent.cancelGLBstopLine(window)" }
        ];
    modalDialog({ title: "异常扫描", html: html, width: 330, height: 130, onload: "setGLBtxtAbnormalFocus(window)", buttons: btns });
}

function setGLBtxtAbnormalFocus(win) {
    var $GLBtxtAbnormal = $(win.document.getElementById("glbTxtAbnormal"));
    $GLBtxtAbnormal.focus();
}

function cancelGLBstopLine(win) {
    win.closeModalDialog();
}

function GLBtxtAbnormalEnter(win, e) {
    var e = e || win.event;
    if (e.keyCode == 13) {
        GLBstopLine(win);
    }
}

function GLBstopLine(win) {
    var $GLBtxtAbnormal = $(win.document.getElementById("glbTxtAbnormal"));
    var txtAbnormal = $GLBtxtAbnormal.val();

    if (txtAbnormal == "") {
        alert("请扫描异常代码！");
        $GLBtxtAbnormal.focus();
        return false;
    }

    var cmd = "kabJRCJ+QnJlAD5zoiCwlg8yhGWPc4tBhnyXAYSRPEI=";

    var params = [], param = {};
    param.ParamName = "tyJMv9vNlmAPzFvOBKtbnr7z1YInHjHg";
    param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";
    param.ParamValue = txtAbnormal;
    param.ParamSize = 50;
    params.push(param);

    param = {};
    param.ParamName = "Hi0SFi1ZPXD1LgwAQ3qyJg==";
    param.ParamType = "1o/d3CICk7c=";
    param.ParamValue = operationId;
    param.ParamSize = 0;
    params.push(param);

    param = {};
    param.ParamName = "XvlXF6OBnMqCmv4U7TrLaQ==";
    param.ParamType = "1o/d3CICk7c=";
    param.ParamValue = resId;
    param.ParamSize = 0;
    params.push(param);

    param = {};
    param.ParamName = "vFD7LklreSx8wyxjjABTgA==";
    param.ParamType = "1o/d3CICk7c=";
    param.ParamValue = userId;
    param.ParamSize = 0;
    params.push(param);

    param = {};
    param.ParamName = "/enEfXkCEyqJ+f5XB2ucgQ==";
    param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";
    param.ParamValue = userName;
    param.ParamSize = 20;
    params.push(param);

    param = {};
    param.ParamName = "es8deqrDqExcexip1Nt0wIU6byRl2O1x";
    param.ParamType = "1o/d3CICk7c=";
    param.ParamValue = 1;
    param.ParamSize = 0;
    params.push(param);

    var resultAjax = SKT.AjaxCommon.DBService.ExecuteNonQuery(cmd, params);
    if (resultAjax.error == null) {
        alert("产线停止操作成功！");
        win.closeModalDialog();
    } else {
        alert(resultAjax.error.Message);
        $GLBtxtAbnormal.focus();
        return false;
    } 
}

//add by zhibin.chen 2015-09-15 格力博 项目在每个工位，增加一个产线停止和恢复的功能。
/*Menu菜单之---产线停止DownTime*/
function StopDownTime() {
//    if (!IsHasPermission(userId, popedom_int)) {
//        alert("对不起！你没有权限！")
//        return false;
//    }

    var cmd = "kabJRCJ+QnJlAD5zoiCwlg8yhGWPc4tBhnyXAYSRPEI=";

    var params = [], param = {};
    param.ParamName = "tyJMv9vNlmAPzFvOBKtbnr7z1YInHjHg";
    param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";
    param.ParamValue = "";
    param.ParamSize = 50;
    params.push(param);

    param = {};
    param.ParamName = "a/bgQeBa1sq/4XOEijhyrg==";
    param.ParamType = "1o/d3CICk7c=";
    param.ParamValue = operationId;
    param.ParamSize = 0;
    params.push(param);

    param = {};
    param.ParamName = "BhR3mFazHElYsdD1vtrvAw==";
    param.ParamType = "1o/d3CICk7c=";
    param.ParamValue = resId;
    param.ParamSize = 0;
    params.push(param);

    param = {};
    param.ParamName = "tITDyhhGG7A9w8aaNaagfg==";
    param.ParamType = "1o/d3CICk7c=";
    param.ParamValue = userId;
    param.ParamSize = 0;
    params.push(param);

    param = {};
    param.ParamName = "/enEfXkCEyqJ+f5XB2ucgQ==";
    param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";
    param.ParamValue = userName;
    param.ParamSize = 20;
    params.push(param);

    param = {};
    param.ParamName = "es8deqrDqExcexip1Nt0wIU6byRl2O1x";
    param.ParamType = "1o/d3CICk7c=";
    param.ParamValue = 2;
    param.ParamSize = 0;
    params.push(param);

    var resultAjax = SKT.AjaxCommon.DBService.ExecuteNonQuery(cmd, params);
    if (resultAjax.error == null) {
        alert("产线恢复操作成功！");
        return true;
    } else {
        alert(resultAjax.error.Message);
        return false;
    } 
}

//add by zhibin.chen 2016-01-11 怡化查看ESOP
/*Menu菜单之---ESOP Start*/
function ViewEsop() {
    dialog({ title: "查看ESOP", src: webroot + "/ESOP/ESOPFileView.aspx?operationId=" + operationId + "&rnd=" + Math.random(), width: 1000, height: 700 });
}
/*Menu菜单之---ESOP End*/

/***************************************************-----end---*/






/******************************【通用功能区域】-------begin----*/


/*JS获取系统定义的资源文本*/
function getResource(resClass, resKey) {
    return SKT.LeanMES.Web.AjaxServices.AjaxClient.GetResourceString(resClass, resKey).value;
}

/*JS检查用户是否具有某一权限*/
function IsHasPermission(userId_int, popedom_int) {
    return SKT.LeanMES.Web.AjaxServices.AjaxClient.IsPermission(userId_int, popedom_int).value;
}

/*JS对字符串用指定的正则表达式验证*/
function validateByRegExp(regString, valString) {
    var REG = new RegExp(regString, 'g');
    return REG.test(valString);
}

/*JS获取全局唯一标识符GUID*/
function getGUID() {
    var S4 = function () {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    };
    return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
}

/*弹出线程阻塞式窗口*/
function modalDialog(options) {
    var defaults = {
        title: "SKT LeanMES Dialog",
        width: 980,
        height: 580,
        buttons: "activeRow",
        html: "Empty Document.",
        onload: ""
    }
    options = $.extend(defaults, options);

    var url = "../Content/plugin/modalDialog/modalDialog.html?rnd=" + Math.random();
    var features = "status:0;resizable:0;scroll:0;dialogWidth:" + options.width + "px;dialogHeight:" + options.height + "px;help:0;edge:sunken;";

    window.showModalDialog(url, [options.html, window, options.onload, options.title, options.height, options.buttons], features);
}

/*JS日期类型格式化*/
/*date format sample: 
var time1 = new Date().Format("yyyy-MM-dd");
var time2 = new Date().Format("yyyy-MM-dd HH:mm:ss");
*/
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "H+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S": this.getMilliseconds()
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

/*回车时阻止IE冒泡事件*/
function stopDefault(e) {
    if (e && e.preventDefault) {
        e.preventDefault();
    } else {
        window.event.returnValue = false;
    }
    return false;
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

/***************************************************--end------*/






/******************************【路由逻辑区域】-------begin-----*/

/*Override eval function*/
var POD = {};
POD.Eval = function (code) {
    if (!!(window.attachEvent && !window.opera)) { execScript(code); }
    else { window.eval(code); }
}

/*Execute Activity*/
/*routerId : router id*/
/*operationId: operation id*/
function ExecActivity(routerId, operationId) {
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.OutputExecuteActivity(routerId, operationId);
    if (ajax.value != "") {
        POD.Eval(ajax.value);
        ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.OutputActivityFunction(routerId, operationId);
        POD.Eval(ajax.value);
    }
}

/***************************************************--end------*/




















