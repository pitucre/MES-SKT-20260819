/****************************************************************************
*  @file 生产采集框架主功能模板JS
*  @author Larry.Lin 2016/07/26
*  @version 1.0.0
*  
*
*
*  @modify 
*  @description  
****************************************************************************/


//侧边栏宽度
var LEFTMENU_WIDTH = "250px";

//采集明细表显示个数
var COLLECTIONLIST_COUNT = 5;

//窗口大小
var wHeight = 500;

//记录侧边栏隐藏/展开状态。
var isCollapse = false;


$(document).ready(function () {
    setTimeout(
        function () {
            //扫描框获取焦点
            $("#txtSN").focus();
        },
        10
    );

    //初始化明细表
    initCollectionList();

    //当窗口大小变化时，改变相应内容区间的大小
    $(window).resize(
        function () {
            setContentHeight();
            setLeftMenuHeight();
            setActiveInfoHeight();
        }
    );

    setContentHeight();
    setLeftMenuHeight();
    setActiveInfoHeight();

    //关闭或者隐藏左边菜单栏
    $("#slider").click(
        function () {
            showLeftMenu();
        }
    );
    //扫描框回车事件
    $("#txtSN").keydown(
        function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;

            if (curKey == 13) {
                afterScan();
                //return false;
            }
            if (curKey == 46) {
                $("#txtSN").val("");
            }
        }
    );

    //时间设置
    //timerTick();
    pageInits();


});

/**
*set the height of the content
*/
function setContentHeight() {
    wHeight = $(window).height();
    var hHeight = $("#toolbar").height();
    $("#content").height(wHeight - hHeight - 32);
}

/**
*set the height of the left menu
*/
function setLeftMenuHeight() {
    wHeight = $(window).height();
    var hHeight = $("#toolbar").height();
    $("#leftmenu").height(wHeight - hHeight - 32);
}

/**
*set the height of the active Info
*/
function setActiveInfoHeight() {
    var wHeight = $(window).height();
    if ($("#activeinfo").position() != null) {
        var activeinfotop = $("#activeinfo").position().top;
        $("#activeinfoarea").height(wHeight - activeinfotop - 60);
    }
}


/**
*展示或者隐藏侧边栏
*
*@param{boolean}isShow 展开或是隐藏侧边栏 
*/
function showLeftMenu(isShow) {
    if (isShow == undefined || isShow == null) {
        isCollapse = !isCollapse;
    }
    else {
        isCollapse = isShow;
    }
    if (isCollapse) {
        $("#leftmenu").hide();
        $("#leftmenu").parent().css("width", "0px");
        $("#sliderimg").attr("alt", "展开侧边栏");
        $("#sliderimg").attr("title", "展开侧边栏");
    } else {
        $("#leftmenu").show();
        $("#leftmenu").parent().css("width", LEFTMENU_WIDTH);
        $("#sliderimg").attr("alt", "隐藏侧边栏");
        $("#sliderimg").attr("title", "隐藏侧边栏");
    }
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
*更新采集明细表
*
*@param{string}sn 当前serialnumber
*@param{string}status 当前serialnumber经检验后参数;如果是OK，样式为绿色背景，如果是NG，样式为红色背景
*/
function updateCollectionList(sn, status, isClick) {
    var bgStyle = "collection-list-ok";
    if (status === 'NG') {
        bgStyle = "collection-list-ng";
    }
    var html = ''
        + '<tr class="ListTableOddRow">'
        + '<td align="center" valign="middle" ><a href="javascript:void(0)" style="color:#000" >' + collectionIndex[0] + '</a></td>'
        + '<td align="center" valign="middle"><a href="javascript:void(0)" class="' + bgStyle + '" >' + sn + '</a></td>'
        + '<td align="center" valign="middle"><a href="javascript:void(0)" class="' + bgStyle + '" >' + status + '</a></td>'
        + '</tr>';
    if (isClick == 1) {
        html = ''
            + '<tr class="ListTableOddRow">'
            + '<td align="center" valign="middle"><a href="javascript:void(0)" style="color:#000" >' + collectionIndex[0] + '</a></td>'
            + '<td align="center" valign="middle"><a href="javascript:void(0)" onclick="updateAssembleDetail(this.innerHTML,1);" class="' + bgStyle + '" >' + sn + '</a></td>'
            + '<td align="center" valign="middle"><a href="javascript:void(0)" class="' + bgStyle + '" >' + status + '</a></td>'
            + '</tr>';
    }
    //tbody用于更新采集明细
    var control = $("#collectionlist");
    //if (control.find('tr').length == COLLECTIONLIST_COUNT) {
    //    control.find('tr:last').remove();
    //}
    control.find('tr:last').remove();
    var i = 1;
    control.find('tr').each(
        function () {
            if (i % 2) {
                $(this).addClass('ListTableEvenRow');
                $(this).removeClass("ListTableOddRow");
            } else {
                $(this).removeClass('ListTableEvenRow');
                $(this).addClass("ListTableOddRow");
            }
            if ($(this).find('a:last').text() === 'NG') {
                var snControl = $(this).find('a').eq(1);
                snControl.addClass('collection-list-ng');
                snControl.removeClass('collection-list-ok');
                var statusControl = $(this).find('a').eq(2);
                statusControl.addClass('collection-list-ng');
                statusControl.removeClass('collection-list-ok');
            } else if ($(this).find('a:last').text() === 'OK') {
                var snControl = $(this).find('a').eq(1);
                snControl.addClass('collection-list-ok');
                snControl.removeClass('collection-list-ng');
                var statusControl = $(this).find('a').eq(2);
                statusControl.addClass('collection-list-ok');
                statusControl.removeClass('collection-list-ng');
            }
            $(this).find('a:first').text(collectionIndex[i]);
            i++;
        }
    );
    control.prepend(html);
}

/**
*初始化明细表
*/
function initCollectionList() {
    var control = $("#collectionlist");
    var html = '';
    control.html("");
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

var testScanItem = 0;
var totalCapicity = 20;
var packingSN = '';
/**
*更新包装明细信息
*/
function updatePackingDetail(sn) {
    if (testScanItem == totalCapicity) {
        testScanItem = 1;
        packingSN = sn;
    } else {
        testScanItem++;
        packingSN = packingSN + ',' + sn;
    }
    var childnodes = "";
    var packingSNList = packingSN.split(",");
    childnodes = '[';
    for (var i = 0; i < packingSNList.length; i++) {
        if (packingSNList[i].length == 0) {
            continue;
        }
        childnodes = childnodes + '{"id":"1' + i + '","text":"' + packingSNList[i] + '"}' + ',';
    }
    if (childnodes.length > 0) {
        childnodes = childnodes.substring(0, childnodes.length - 1);
    }
    childnodes = childnodes + ']';
    childnodes = jQuery.parseJSON(childnodes);
    var data = [
        {
            id: '1',
            text: 'TESTBOXNO001(' + testScanItem + ' of ' + totalCapicity + ')',
            hasChildren: true,
            isexpand: true,
            ChildNodes: childnodes
        }
    ];


    $('#packingTree').treeview({
        data: data,
        emptyiconpath: '../Content/plugin/treeview/images/s.gif'
    });
}

//临时方法，用于显示实时信息
function updateActiveInfoArea(information) {
    $("#activeinfoarea").val(information + '\n' + $("#activeinfoarea").val());
}

/*
* 设置消息提示框样式
*/
function showAreaMessge(information, styleClass) {
    var currentTime = getDateTime();
    var messageBox = $("#activeinfoarea");
    var rows = 50;

    var flag = "";

    //if (styleClass == "messageRed") {
    //    playSound();
    //}

    var playSoundFlag = false;
    if (styleClass == "messageRed" || (typeof (playSoundPassFlag) != "undefined" && playSoundPassFlag == "1")) {
        playSoundFlag = true;
    }

    if (styleClass == "messageRed") {
        flag = "NG";
    } else {
        flag = "OK";
    }
    if (playSoundFlag) {
        playSound(flag);
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
function playSound(flag) {
    $('embed').remove();

    var soundName = "";
    if (flag == "OK") {
        soundName = "Pass";
    } else {
        soundName = "warn";
    }

    var player = "";
    if (isIE()) {
        //IE内核浏览器         
        player = '<embed id="player" src="../Content/sound/' + soundName + '.mp3" autostart="true" hidden="true" loop="false"></embed>';

    } else {
        //非IE内核浏览器  
        player = '<audio  id="player" autoplay ><source src="../Content/sound/' + soundName + '.mp3" ></audio>';
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

/**
*加载Menu菜单按钮，以及常用功能菜单
*@param{List<Button>} buttons 加载需显示的buttong
*@param{string} currentUser 当前用户
*
*
*/
function loadButtons(buttons, currentUser) {
    var strButtons = "";
    var strShortCut = "";
    //login user info
    strButtons += "<li class='set-menu-item' style='margin-left:28px;Color:Blue;'><span>" + getResource("lang", "CurrentUser") + ":" + currentUser + "</span></li>";
    strButtons += "<li style=' margin-top:5px; height:1px; background:#cccccc; margin-left:24px; margin-top:3px; margin-bottom:5px;'></li>";
    strButtons += '<li class="set-menu-item" ><span><img src="../Content/images/icon/homepage.png"  style="float:left; vertical-align:middle;"/></span><span style="margin-left:12px;" onclick="try{goToConsole()}catch(ex){}">' + getResource("lang", "ControlPanel") + '</span></li>';
    strButtons += '<li class="set-menu-item" ><span><img src="../Content/images/icon/homepage.png"  style="float:left; vertical-align:middle;"/></span><span style="margin-left:12px;" onclick="try{goToMachineConsole()}catch(ex){}">' + getResource("lang", "MachinePanel") + '</span></li>';
    strButtons += "<li style=' margin-top:5px; height:1px; background:#cccccc; margin-left:24px; margin-top:3px; margin-bottom:5px;'></li>";
    for (var i = 0; i < buttons.length; i++) {
        if (buttons[i].InToolbar) {
            strButtons += "<li class='set-menu-item' style='margin-left:28px;'><span onclick='try{" + buttons[i].Handler + "}catch(ex){}'>" + getResource("Buttons", buttons[i].Text) + "</span></li>";
        } else {
            strShortCut += "<li class='dds-panel-shortcut-li'><span onclick='try{" + buttons[i].Handler + "}catch(ex){}'>" + getResource("Buttons", buttons[i].Text) + "</span></li>";
        }
    }
    if (buttons.length > 0) {
        strButtons += "<li style=' margin-top:5px; height:1px; background:#cccccc; margin-left:24px; margin-top:3px; margin-bottom:5px;'></li>";
    }
    strButtons += "<li class='set-menu-item' style=''><span><img src='../Content/images/icon/lgout.png'  style='float:left; vertical-align:middle;'/></span><span  style='margin-left:12px;' onclick='logout();'>" + getResource("lang", "CommonExit") + "</span></li>";

    $("#r-menu-item").html(strButtons);

    //strShortCut += '<li class="dds-panel-shortcut-li"><span onclick="try{ProductionAbnormal()}catch(ex){}">异常录入</span></li>';
    //strShortCut += '<li class="dds-panel-shortcut-li"><span onclick="try{ProdOrderReleaseBatch()}catch(ex){}">释放批次条码</span></li>';
    strShortCut += '<li class="dds-panel-shortcut-li"><span onclick="try{BatchSNSplit()}catch(ex){}">批次拆分</span></li>';
    strShortCut += '<li class="dds-panel-shortcut-li"><span onclick="try{BatchSNCombine()}catch(ex){}">批次合并</span></li>';
    strShortCut += '<li class="dds-panel-shortcut-li"><span onclick="try{BatchSendRepair()}catch(ex){}">批次送修</span></li>';
    $("#shortcut-item").html(strShortCut);
    /*loadButtonsTraceType();*/
}

/*返回控制面板*/
function goToConsole() {
    location.href = "../Framework/Console.aspx";
}


/*返回注塑机台*/
function goToMachineConsole() {
    location.href = "../Client/MachinedInjectionMolding.aspx";
}

/*页面初始化一些事件*/
function pageInits() {
    //setScannerWidth();
    timerTick();
    //$("#template-container").css("height", $(window).height() - 180);
    //paramsInit();

    //setTimeout(function () {
    //    loadTemplate();
    //}, 100);

    //添加强制大写选择框处理
    $("#txtSN").css("text-transform", "uppercase");

    $("#cbxforceuppercase").click(function () {
        if (this.checked) {
            $("#txtSN").css("text-transform", "uppercase");
            $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
        }
        else {
            $("#txtSN").css("text-transform", "none");
        }
    });

    $("#topbar-set").hover(function () {
        $("#topbar-set-menu").toggle();
    });

    //上下工序显示图层
    $("#laststationfirst").hover(
        function () {
            $("#laststationitems").toggle();
        }
    );
    $("#nextstationfirst").hover(
        function () {
            $("#nextstationitems").toggle();
        }
    );
}

/*
*获取当前工序和产线，并且据此获取上下工序相关信息，并在回显。
*/
function stationRefresh() {
    //获取request传参
    //alert($("#topbarproductionline").text());
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetLastNextStation($("#hdnCurrStationId").val(), $("#hdnCurrRouteId").val());
    if (ajax.error != null) {
        alert(ajax.error.Message);
        return false;
    }
    $("#laststationfirst").html(ajax.value[0]);
    $("#nextstationfirst").html(ajax.value[1]);
}

/*
*根据sn获取前后工序信息并回显
*/
function stationRefreshBySN(serialNumber) {
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetLastNextStationBySN($("#hdnCurrStationId").val(), serialNumber);
    if (ajax.error != null) {
        alert(ajax.error.Message);
        return false;
    }
    $("#laststationfirst").html(ajax.value[0]);
    $("#nextstationfirst").html(ajax.value[1]);
}


/******************************【通用目录功能区域】-------begin-------*/

/**
*JS获取系统定义的资源文本
*/
function getResource(resClass, resKey) {
    return SKT.LeanMES.Web.AjaxServices.AjaxClient.GetResourceString(resClass, resKey).value;
}

/**
*Menu菜单之---修改密码
*/
function ChangePwd() {
    //    if (userId == -1) {
    //        alert(getResource("Messages", "AdminCannotChangePassword"));
    //        return false;
    //    }
    dialog({ title: getResource("Pages", "UserChangePwd"), src: webroot + "/User/UserChangePwd.aspx?name=Account_ChangePwd&ID=-1&rnd=" + Math.random(), width: 450, height: 300 });
}

/**
*Menu菜单之---帮助
*/
function Help() {
    window.open("../Help/Help.htm");
}

/**
*Menu菜单之---退出系统
*/
function logout() {
    if (confirm(getResource("Messages", "ComfirmToQuit"))) {
        window.location = webroot + "/Logout.aspx";
    }
}

/**
*Menu菜单之---切换站位
*/
function SwitchStation() {
    dialog({ title: getResource("Buttons", "Switch_Station"), src: webroot + "/Client/SwitchStation.aspx?name=Switch_Station&rnd=" + Math.random(), width: 550, height: 400 });
}

/**
*Menu菜单之---手工叫料 BirongLiang@2016-11-17
*/
function ManualMaterial() {
    var curStationId = $("#hdnCurrStationId").val();
    var curLine = escape($("#hdCurProLine").val());
    var resId = escape($("#hdnCurrResourceId").val());
    if (curStationId === "") {
        alert("获取工序失败，请重新登录");
        return false;
    }
    dialog({
        title: "手工叫料", src: webroot + "/Client/ManualMaterial.aspx?name=ManualMaterial" +
            "&sid=" + curStationId + "&line=" + curLine + "&resId=" + resId +
            "&rnd=" + Math.random()
        , width: 800, height: 450
    });

}

/**
*Menu菜单之---手工关箱
*/
var boxFlag = false;
var isScanOffline = false;
function CloseContainerByUser() {
    if (boxFlag) {  //需要中箱标识
        if (boxSN != "") {
            if (confirm('确认关闭包装中箱' + boxSN + "?")) {
                if (isScanOffline) {  //离线手工关箱          
                    HandCloseCatainer();
                    return false;
                } else {  //在线手工关箱
                    HandCloseOnLineBox();
                    return false;
                }
            }
            else {
                return false;
            }
        }
    }
    if ($.trim(packSN) == "") {
        alert("未发现包装容器!");
        return false;
    }
    var containStr = "";
    if (lableType == -4) {
        containStr = "包装箱";
    } else if (lableType == -22) {
        containStr = "中箱";
    } else {
        containStr = "栈板";
    }
    if (confirm("确认要关闭" + containStr + "[" + packSN + "] ？")) {
        if (closeContainer()) {
            showAreaMessge("已手动关闭" + containStr + "[" + packSN + "]", "messageGreen");
            //关闭完成后，重新加载左边菜单数据：根据SN刷新侧边栏动态信息
            refreshProInfoBySN(scanSN);
            var nextSeq = $("#sltBoxSeq option:selected").next().val();
            if (nextSeq != "") {
                $("#sltBoxSeq option:selected").remove();
                $("#sltBoxSeq").val(nextSeq);
            }
            packSN = ""; //清除包装箱号     
            boxSN = "";
            isScanOffline = 0;
        }
    }
    else {
        return false;
    }
}

/*
*手动关闭包装箱
*/
function closeContainer() { //关闭容器(包装箱,栈板)    
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.ClosePackPalletContainer(packSN, stationId, resourceId);
    if (ajax.error != null) {
        alert(ajax.error.Message);
        return false;;
    }
    //打印包装箱条码
    checkPackPrint();
    return true;
}
/**
*Menu菜单之---老化架移除
*/
function AgeingRackUnBind() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: getResource("Buttons", "AgeingRackProUnBind"), src: webroot + "/Client/AgeingRackProUnBind.aspx?name=AgeingRackProUnBind&stationid=" + stationid + "&resourceid=" + resourceid + "&rnd=" + Math.random(), width: 550, height: 400 });
}
/**
*Menu菜单之---解包装
*/
function PackProUnBind() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: getResource("Buttons", "Pack_ProUnBind"), src: webroot + "/Client/PackingProUnBind.aspx?name=Pack_ProUnBind&stationid=" + stationid + "&resourceid=" + resourceid + "&ContainerType=" + lableType + "&rnd=" + Math.random(), width: 550, height: 400 });
}

/**
*Menu菜单之---包装标签补打
*/
function PackSNPrint(flag) {
    if (flag == undefined || flag == null) {
        flag = 3;
    }
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: getResource("Buttons", "Pack_SNPrint"), src: webroot + "/Client/PackingSNPrint.aspx?stationid=" + stationid + "&resourceid=" + resourceid + "&name=Pack_SNPrint&printType=" + flag + "&rnd=" + Math.random(), width: 550, height: 400 });
}

/**
*Menu菜单之---解包装
*/
function PalletProUnBind() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: getResource("Buttons", "Pallet_ProUnBind"), src: webroot + "/Client/PackingProUnBind.aspx?name=Pack_ProUnBind&stationid=" + stationid + "&resourceid=" + resourceid + "&ContainerType=2&rnd=" + Math.random(), width: 550, height: 400 });
}

/**
*Menu菜单之---SMT解包装
*/
function STMUNPack() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: getResource("Buttons", "STM_UNPack"), src: webroot + "/Client/SMTPackUnBind.aspx?name=STM_UNPack&stationid=" + stationid + "&resourceid=" + resourceid + "&rnd=" + Math.random(), width: 550, height: 400 });
}


/**
*Menu菜单之---包装称重设定
*/
function PackWeight() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: getResource("Buttons", "Pack_Weight"), src: webroot + "/Client/ElectronicCallSet.aspx?name=Pack_Weight&stationid=" + stationid + "&resourceid=" + resourceid + "&rnd=" + Math.random(), width: 765, height: 350 });
}

/**
*Menu菜单之---包装称重设定
*/
function ContainerWeight() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: getResource("Buttons", "Container_Weight"), src: webroot + "/Client/PackContainerWeight.aspx?name=Container_Weight&stationid=" + stationid + "&resourceid=" + resourceid + "&rnd=" + Math.random(), width: 580, height: 380 });
}

/**
*Menu菜单之---强制称重过站
*/
function ByPassWeight(sn, weight, weightMsg) {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: "称重过站", src: webroot + "/Client/ElectronicByPass.aspx?name=ElectronicByPass&sn=" + escape(sn) + "&weight=" + weight + "&weightmsg=" + escape(weightMsg) + "&stationid=" + stationid + "&resourceid=" + resourceid + "&rnd=" + Math.random(), width: 590, height: 300 });
}

/**
*Menu菜单之---组装打散
*/
function AssembleProUnBind() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: getResource("Buttons", "Assemble_ProUnBind"), src: webroot + "/Client/AssembleProUnBind.aspx?name=Assemble_ProUnBind&stationid=" + stationid + "&resourceid=" + resourceid + "&rnd=" + Math.random(), width: 550, height: 400 });
}

/**
*Menu菜单之---产品标签补打
*/
function ReprintSN() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: "标签补打", src: webroot + "/Client/ReprintSN.aspx?name=ReprintSN&stationid=" + stationid + "&resourceid=" + resourceid + "&rnd=" + Math.random(), width: 680, height: 500 });
}

/**
*Menu菜单之---客户标签补打
*/
function ReprintCustomerSN() {
    var stationid = getQueryString("stationid");
    var resourceid = getQueryString("resourceid");
    dialog({ title: "标签补打", src: webroot + "/Client/ReprintCustomerSN.aspx?name=ReprintCustomerSN&stationid=" + stationid + "&resourceid=" + resourceid + "&rnd=" + Math.random(), width: 680, height: 500 });
}

var chooseFlage = -1; //选择的列表标识
var preCheckOrderId = -1; //前置加工选择的工单
var preCheckItemId = -1; //前置加工选择的产品
/*选择工单*/
function ChooseOrder() {
    chooseFlage = 44;
    dialog({
        title: "选择工单",
        src: webroot + "/Framework/ChoosePage.aspx?PageId=" + chooseFlage + "&rnd=" + Math.random(),
        width: 600,
        height: 300
    });
}

/*选择产品*/
function ChooseItem() {
    chooseFlage = 1;
    dialog({
        title: "选择产品",
        src: webroot + "/Framework/ChoosePage.aspx?PageId=" + chooseFlage + "&rnd=" + Math.random(),
        width: 600,
        height: 300
    });
}
function getChooseValue(list) {
    if (chooseFlage == 1) {
        preCheckItemId = list[0][0]; //获取选择的料号
        preCheckOrderId = -1;
        //refreshItemInfoByItemId(preCheckItemId);
    } else if (chooseFlage == 44) {
        preCheckOrderId = list[0][0];
        $("#hdnCurrProOrderId").val(preCheckOrderId);
        preCheckItemId = -1;
        refreshProInfoByProOrderId(preCheckOrderId);
    }
}
/**
*Menu菜单之---生产异常
*/
function ProductionAbnormal() {
    alert("生产异常");
}

/**
*Menu菜单之---释放批次条码
*/
function ProdOrderReleaseBatch() {
    var curStationId = $("#hdnCurrStationId").val();
    var curLine = escape($("#hdCurProLine").val());
    var resId = escape($("#hdnCurrResourceId").val());
    if (curStationId === "") {
        alert("获取工序失败，请重新登录");
        return false;
    }
    dialog({
        title: "释放批次条码", src: webroot + "/Client/ProdOrderReleaseBatch.aspx?name=ProdOrderReleaseBatch" +
            "&sid=" + curStationId + "&line=" + curLine + "&resId=" + resId +
            "&rnd=" + Math.random()
        , width: 680, height: 350
    });
}


/**
*Menu菜单之---批次拆分
*/
function BatchSNSplit() {
    var curStationId = $("#hdnCurrStationId").val();
    var curLine = escape($("#hdCurProLine").val());
    var resId = escape($("#hdnCurrResourceId").val());
    if (curStationId === "") {
        alert("获取工序失败，请重新登录");
        return false;
    }
    dialog({
        title: "批次拆分", src: webroot + "/Client/BatchSNSplit.aspx?name=BatchSNSplit" +
            "&stationid=" + curStationId + "&line=" + curLine + "&resoureid=" + resId +
            "&rnd=" + Math.random()
        , width: 680, height: 350
    });
}
/**
*Menu菜单之---批次合并
*/
function BatchSNCombine() {
    var curStationId = $("#hdnCurrStationId").val();
    var curLine = escape($("#hdCurProLine").val());
    var resId = escape($("#hdnCurrResourceId").val());
    if (curStationId === "") {
        alert("获取工序失败，请重新登录");
        return false;
    }
    dialog({
        title: "批次合并", src: webroot + "/Client/BatchSNCombine.aspx?name=BatchSNCombine" +
            "&stationid=" + curStationId + "&line=" + curLine + "&resoureid=" + resId +
            "&rnd=" + Math.random()
        , width: 680, height: 350
    });
}
/**
*Menu菜单之---批次送修
*/
function BatchSendRepair() {
    var curStationId = $("#hdnCurrStationId").val();
    var curLine = escape($("#hdCurProLine").val());
    var resId = escape($("#hdnCurrResourceId").val());
    if (curStationId === "") {
        alert("获取工序失败，请重新登录");
        return false;
    }
    dialog({
        title: "批次送修", src: webroot + "/Client/BatchSendRepair.aspx?name=BatchSendRepair" +
            "&stationid=" + curStationId + "&line=" + curLine + "&resoureid=" + resId +
            "&rnd=" + Math.random()
        , width: 850, height: 600
    });
}

/**
*Menu菜单之---不良接收
*/
function NCDataReceive() {
    var curStationId = $("#hdnCurrStationId").val();
    var curLine = escape($("#hdCurProLine").val());
    var resId = escape($("#hdnCurrResourceId").val());
    if (curStationId === "") {
        alert("获取工序失败，请重新登录");
        return false;
    }
    dialog({
        title: "不良接收", src: webroot + "/Client/NCDataReceive.aspx?name=NCDataReceive" +
            "&sid=" + curStationId + "&line=" + curLine + "&resId=" + resId +
            "&rnd=" + Math.random()
        , width: 680, height: 350
    });
}


/**
*Menu菜单之---不良登记 
*/
function CommonDefectiveProductLabel() {
    var curStationId = $("#hdnCurrStationId").val();
    var curLine = escape($("#hdCurProLine").val());
    var resId = escape($("#hdnCurrResourceId").val());
    if (curStationId === "") {
        alert("获取工序失败，请重新登录");
        return false;
    }
    dialog({
        title: "不良登记", src: webroot + "/Client/CommonDefectiveProductLabel.aspx?name=CommonDefectiveProductLabel" +
            "&sid=" + curStationId + "&line=" + curLine + "&resId=" + resId +
            "&rnd=" + Math.random()
        , width: 800, height: 450
    });

}


/******************************【通用目录功能区域】】-------End----*/

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
/**************************【包装栈板功能区域】--Start*********************/
//add by Beck Ye 2016.09.18
function getPackingPalletDetail(sn, containerType) {
    if (sn == "") {
        return;
    }
    //将明细刷新掉.
    //$("#tdPackNo").html(SN);
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPackIngPalletDetailByContainerSN(sn, containerType);
    if (ajax.error == null) {
        $("#packingList  tr:not(:first)").remove();

        if (ajax.value.Rows.length > 0) {
            loadTable(ajax.value);
            return true;
        }
        return false;
    }
    else {
        alert(ajax.error.Message);
        return false;
    }
}

function loadTable(list) {
    var row, cell;
    var setTable = document.getElementById("packingList");

    /***动态创建表***/
    for (var i = 0; i < list.Rows.length; i++) {
        entity = list[i];
        if (i == 0) {
            PackSN = list.Rows[i].ContainerSN;
            packStatusId = list.Rows[i].StatusId;
        }
        row = setTable.insertRow(setTable.rows.length);
        if (i % 2 == 0) {
            row.className = 'ListTableOddRow';
        }
        else {
            row.className = 'ListTableEvenRow';
        }

        cell = row.insertCell(0);
        cell.align = "center";
        cell.style.display = "none";
        cell.innerHTML = list.Rows[i].CCDataId;

        cell = row.insertCell(1);
        cell.align = "center";
        cell.innerHTML = list.Rows[i].ContainerSN;

        cell = row.insertCell(2);
        cell.align = "center";
        cell.innerHTML = list.Rows[i].SerialNumber;
    }
}

/**************************【包装栈板功能区域】--End*********************/


/**************************条码自动打印 Start huangliang 2017-11-14*********************/
/******update by weixia on 2018.5.21 增加份数打印***********/
/********************************************标签打印 ************************************************/
var ibs;                    //秒
var labelDocumentId = -1    //Label文档Id
var lableTypeQty = 1;       //连板数量
var printName = "";         //打印机名称
var labelItemId = -1;    //ItemId
var labelProdOrderId = -1;
var labelStationId = -1;    //工位Id
var labelType = -2;          //标签类型(默认产品条码)

//var labelSequence = 1;      //标签序号 

var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL
var lableArr = null;        //标签信息的SN序列号集合对象
var SNInfo;                 //当前释放标签的信息集合对象
var labelContent = "";      //标签ZPL指令内容
var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
var tempatePath = "";       //Lab模板文件路径
var printCount = 1;        //打印份数：默认一次
var isCheckRouter = true;

//获取文档模板基础信息
function AutoPrint(stationId, scanSN, hidDiolog) {
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintDocumentList(stationId, scanSN, isCheckRouter, labelType);
    if (ajax.error != null) {
        //alert(ajax.error.Message);
        return false;
    }
    var arrAutoPrint = ajax.value;

    if (arrAutoPrint == null || arrAutoPrint.length == 0) {
        //alert("未找到打印模板信息！");
        return false;
    }
    var sn = "";
    var i = 0;
    labelDocumentId = arrAutoPrint[i].LabelDocumentId; //Label文档Id
    lableTypeQty = arrAutoPrint[i].PlateQty;           //连板数量
    printName = arrAutoPrint[i].PrinterName;           //打印机名称
    labelPrintWayId = arrAutoPrint[i].PrintWayId;      //打印方式 78=Lab  79=ZPL
    tempatePath = arrAutoPrint[i].TemplatePath.replace("\\", "\\\\");
    labelItemId = arrAutoPrint[i].ItemId;
    labelProdOrderId = arrAutoPrint[i].ProdOrderId;
    labelType = arrAutoPrint[i].TypeId;
    printCount = arrAutoPrint[i].Print_Qty;
    //处理需要打印的SN
    sn = arrAutoPrint[i].SN == "" ? scanSN : arrAutoPrint[i].SN;
    SNInfo = {};
    SNInfo.SNList = [];
    SNInfo.SNList.push(sn);
    //保存打印记录
    recordPrint(sn, stationId);
    //存在多模板的时候交替打印 modify by xiongyz 2023-08-19
    if (arrAutoPrint.length > 1) {
        //回调函数
        var callback = function (success, ws, msg) {
            if (!success) {
                if (ws && ws.readyState != 1)
                    layer.open({ content: "连接尚未建立请确认服务是否开启" });
                return;
            }
            //最后一个
            if (i == arrAutoPrint.length - 1) {
                var data = JSON.parse(msg.data);
                if (data.Result) {
                    layer.open({ title: "打印机脱机", content: "如需预览请复制以下地址到浏览器地址栏并回车。<textarea style='width:100%;height:100%;border:none;overflow:hidden;color:red;'>" + data.Result + "</textarea>" });
                }
                return;
            }
            //打印下一个
            i++;
            labelDocumentId = arrAutoPrint[i].LabelDocumentId; //Label文档Id
            lableTypeQty = arrAutoPrint[i].PlateQty;           //连板数量
            printName = arrAutoPrint[i].PrinterName;           //打印机名称
            labelPrintWayId = arrAutoPrint[i].PrintWayId;      //打印方式 78=Lab  79=ZPL
            tempatePath = arrAutoPrint[i].TemplatePath.replace("\\", "\\\\");
            labelItemId = arrAutoPrint[i].ItemId;
            labelProdOrderId = arrAutoPrint[i].ProdOrderId;
            labelType = arrAutoPrint[i].TypeId;
            printCount = arrAutoPrint[i].Print_Qty;
            mesLabLabelPrintAuto(hidDiolog, callback);
        }
        //打印第一个
        mesLabLabelPrintAuto(hidDiolog, callback);
    }
    else {

        mesLabLabelPrintAuto(hidDiolog);
    }
}

//批量打印工单条码
function AutoPrints(stationId, scanSn, scanList) {
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintDocumentList(stationId, scanSn, isCheckRouter, labelType);
    if (ajax.error != null) {
        //alert(ajax.error.Message);
        return false;
    }
    var arrAutoPrint = ajax.value;

    if (arrAutoPrint == null) {
        //alert("未找到打印模板信息！");
        return false;
    }
    var sn = "";
    for (var i = 0; i < arrAutoPrint.length; i++) {
        var entity = arrAutoPrint[i];
        labelDocumentId = entity.LabelDocumentId; //Label文档Id
        lableTypeQty = entity.PlateQty;           //连板数量
        printName = entity.PrinterName;           //打印机名称
        labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
        tempatePath = entity.TemplatePath.replace("\\", "\\\\");
        labelItemId = entity.ItemId;
        labelProdOrderId = entity.ProdOrderId;
        labelType = entity.TypeId;
        printCount = entity.Print_Qty;
        sn = entity.SN == "" ? scanSn : entity.SN;
        SNInfo = {};
        SNInfo.SNList = [];
        SNInfo.SNList.push(sn);
    }
    mesLabLabelPrint(scanList);
}

var templateGroup = 1;//新打印连板数
function mesLabLabelPrint(list) {
    if (typeof (list) == "undefined") {
        return;
    }
    if (!tmp && typeof (tmp) != "undefined" && tmp != 0) {
        return;
    }
    if (list.length == 0) {
        ibs = 3 * printCount;
        return;
    }
    var sendQty = 120;

    while (sendQty % templateGroup != 0) {
        sendQty++;
    }
    //从list中取出 sendQty 作为打印的数量，并且list截取掉sendQty
    var newlist = list.splice(sendQty);
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfo(labelDocumentId, list, -1, -1, -1, labelItemId, labelProdOrderId);
    if (ajax.error == null) {
        if (ajax.value.length == 0) {
            alert("没有找到该产品关联的模板信息");
            return;
        }
    } else {
        alert(ajax.error.Message);
        return;
    }
    sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, function (success, ws) {
        if (!success) {
            if (ws && ws.readyState != 1)
                layer.open({ content: "连接尚未建立请确认服务是否开启" });
            return;
        }
        recordPrint(list);
        mesLabLabelPrint(newlist);
    }, 2);

}

//codesoft打印  Lab模板方式
function mesLabLabelPrintAuto(hidDiolog, callback) {
    //从已释放的标签信息集合中，获取SN序列号集合。
    lableArr = SNInfo.SNList;
    var labelStr = "";
    var printdata = [];
    for (var i = 0; i < lableArr.length;) {
        //连片数
        if (lableTypeQty == 1) {
            labelStr = lableArr[i];
        }
        else {
            //每次重置一下
            labelStr = "";
            for (var j = 0; j < lableTypeQty; j++) {
                if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                }
                else {
                    //根据联板数，拼接SN字符串。 
                    labelStr += lableArr[i + j] + ",";
                }
            }
        }
        i = i + lableTypeQty; //连片的递增
        //获取标签模板中的标签值 集合
        var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);
        if (ajaxLabContent.error == null) {
            try {
                var list = ajaxLabContent.value;
                if (list.length > 0) {
                    var page = { LabelContent: [] };
                    for (var k = 0; k < list.length; k++) {
                        page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                    }
                    printdata.push(page);
                }
            } catch (e) {
                printdata = [];
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
        }
        else {
            printdata = [];
            alert(ajaxLabContent.error.Message);
            $("#lblMessage").html(ajaxLabContent.error.Message);
            return false;
        }
    }
    if (printdata.length == 0)
        return;
    try {
        sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId, callback, null, hidDiolog);
    } catch (e) {
        alert(e);
        $("#lblMessage").html(e);
        return false;
    }
}

/**
*插入打印记录
**/
function recordPrint(sn, stationId) {
    var printRecodeEntity = {};
    printRecodeEntity.RecordId = -1;
    printRecodeEntity.ActionType = 1;
    printRecodeEntity.PrintType = labelType;
    printRecodeEntity.PrintKey = sn;
    printRecodeEntity.StationId = stationId;
    printRecodeEntity.ResourceId = resourceId;
    var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxClientController.RecodePrint(printRecodeEntity);
    if (ajaxPrintRecodes.error != null) {
        alert(ajaxPrintRecodes.error.Message);
        return false;
    }
}
/**************************条码自动打印 End*********************/

/*
*写入用户操作日志
*/
function SaveUserUILog(LogType, StationId, ResourceId, OederNo, LogContent) {
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.SaveUserUILog(LogType, StationId, ResourceId, OederNo, LogContent);
    if (ajax.error != null) {
        return false;
    }
}

/*JS检查用户是否具有某一权限*/
function IsHasPermission(userId_int, popedom_int) {
    return SKT.LeanMES.Web.AjaxServices.AjaxClient.IsPermission(userId_int, popedom_int).value;
}
