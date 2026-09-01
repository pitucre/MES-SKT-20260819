function confirmDialog(text, callback) {
    var popupDialogId = 'popupDialog';
    playSound();
    if (callback == null) {
      
        $('<div data-role="popup" id="' + popupDialogId + '" data-confirmed="no" data-transition="pop" data-overlay-theme="a" data-theme="a" data-dismissible="false" style="max-width:500px;width:290px;text-align:center;">'
+ '<div data-role="header" data-theme="a" style="text-align:center;padding-top: 14px;">'
+ '<h1>提示</h1>'
+ '</div>'
+ '<div role="main" class="ui-content" style="text-align:center">'
+ '<h3 class="ui-title">' + text + '</h3>'
+ '<div style="text-align:center;">'
+ '<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline data-corners="false" optionConfirm" data-rel="back" style="width:30%">确定</a>'
+ '</div>'
+ '</div>'
+ '</div>').appendTo($.mobile.pageContainer);//解决页面缩小的问题  chenglong.zhu 2017/3/20
    }
    else {
        $('<div data-role="popup" id="' + popupDialogId + '" data-confirmed="no" data-transition="pop" data-overlay-theme="a" data-theme="a" data-dismissible="false" style="max-width:500px;width:290px;text-align:center;">'
+ '<div data-role="header" data-theme="a"  style="text-align:center;padding-top: 14px;">'
+ '<h1>确认提示</h1>'
+ '</div>'
+ '<div role="main" class="ui-content" style="text-align:center;">'
+ '<h3 class="ui-title">' + text + '</h3>'
+ '<div style="text-align:center;">'
+ '<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline  optionConfirm" data-corners="false" data-rel="back" style="width:30%">是</a>'
+ '<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline  optionCancel" data-corners="false" data-rel="back" data-transition="flow" style="width:30%">否</a>'
+ '</div>'
+ '</div>'
+ '</div>').appendTo($.mobile.pageContainer);//解决页面缩小的问题
    }
    var popupDialogObj = $('#' + popupDialogId);
    popupDialogObj.trigger('create').trigger('refresh');
    popupDialogObj.popup({
        afterclose: function (event, ui) {
            popupDialogObj.find(".optionConfirm").first().off('click');
            var isConfirmed = popupDialogObj.attr('data-confirmed') === 'yes' ? true : false;
            $(event.target).remove();
            if (isConfirmed && callback) {
                callback();
            }
        }
    });
    popupDialogObj.popup('open');
    popupDialogObj.find(".optionConfirm").first().on('click', function () {
        popupDialogObj.attr('data-confirmed', 'yes');
    });
}
/***************chenglong.zhu 2017/3/9*************************/
/* 解决弹窗之后的聚焦问题*/
function confirmDialogFocus(text, callback) {
    playSound();
    var popupDialogId = 'popupDialogFocus';
    $('<div data-role="popup" id="' + popupDialogId + '" data-confirmed="no" data-transition="pop" data-overlay-theme="a" data-theme="a" data-dismissible="false" style="max-width:500px;width:290px;">'
+ '<div data-role="header" data-theme="a" style="text-align:center">'
+ '<h1>提示</h1>'
+ '</div>'
+ '<div role="main" class="ui-content" style="text-align:center;padding-top: 14px;">'
+ '<h3 class="ui-title">' + text + '</h3>'
+ '<div style="text-align:center;">'
+ '<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline  optionConfirm" data-corners="false" data-rel="back" style="width:30%">确定</a>'
+ '</div>'
+ '</div>'
+ '</div>').appendTo($.mobile.pageContainer);//解决页面缩小的问题

    var popupDialogObj = $('#' + popupDialogId);
    popupDialogObj.trigger('create');
    popupDialogObj.popup({
        afterclose: function (event, ui) {
            popupDialogObj.find(".optionConfirm").first().off('click');
            var isConfirmed = popupDialogObj.attr('data-confirmed') === 'yes' ? true : false;
            $(event.target).remove();
            if (isConfirmed && callback) {
                callback();
            }
        }
    });
    popupDialogObj.popup('open');
    popupDialogObj.find(".optionConfirm").first().on('click', function () {
        popupDialogObj.attr('data-confirmed', 'yes');
    });
}

function logout() {
    confirmDialog('确定要退出吗？', function () {
        $.ajax({
            type: 'post',
            url: "../Handler/MobileAppLogin.ashx?Action=Logout&rnd=" + Math.random(),
            async: true,
            success: function (data) {
                if (data == "") {
                    location.href = "Login.aspx";
                }
            },
            datatype: 'text',
            error: function (xhr, status, error) {
                if (error.indexOf("errMsgContent") != -1) {
                    confirmDialog($(".errMsgContent", error).html(), null);
                }
                else {
                    confirmDialog(error, null);
                }
            }
        });
    });
}

/*修改密码*/
function changePwd() {
    var pwd = $.trim($("#pwd").val());
    var pwd1 = $.trim($("#pwd1").val());
    var pwd2 = $.trim($("#pwd2").val());
    if (pwd == "") {
        confirmDialog("请输入旧密码", null);
        return false;
    }
    if (pwd1 == "") {
        confirmDialog("请输入新密码", null);
        return false;
    }
    if (pwd2 != pwd1) {
        confirmDialog("两次新密码输入不一致", null);
        return false;
    }
    $.ajax({
        type: 'post',
        url: "../Handler/MobileAppLogin.ashx?Action=ChangePwd&rnd=" + Math.random(),
        async: true,
        data: { Pwd: pwd, Pwd1: pwd1 },
        beforeSend: function () {
            $("#changepwd #message").html("<img src='../Content/images/gif/loading.gif' style='vertical-align:middle; margin-right:5px;'/>正在提交数据，请稍后...");
        },
        success: function (data) {
            var errMsg = "";
            if (data == "") {
                confirmDialog("密码修改成功，您需要重新登录", function () {
                    location.href = "Login.aspx";
                });
            }
            else {
                if (data.indexOf("expiredBox") != -1) {
                    errMsg = $(".expiredBox table tr:eq(0) td:eq(1)", data).html().replace(new RegExp(/<br>/g), "\n").replace(new RegExp(/ /g), "");
                    confirmDialog(errMsg, null);
                }
                else if (data.indexOf("licenseInvalide") != -1) {
                    errMsg = $("#licenseInvalide", data).html();
                    confirmDialog(errMsg, null);
                }
                else {

                    confirmDialog(data, null);
                }
            }
        },
        complete: function (XMLHttpRequest, str) {
            $("#message").html("");
        },
        datatype: 'text',
        error: function (xhr, status, error) {
            if (xhr.status == 500) {
                var result = xhr.responseText;
                confirmDialog($("h2>i", result).html(), null);
            }
            else {
                if (error.indexOf("expiredBox") != -1) {
                    var errMsg = $(".expiredBox table tr:eq(0) td:eq(1)", error).html().replace(new RegExp(/<br>/g), "\n").replace(new RegExp(/ /g), "");
                    confirmDialog(errMsg, null);
                }
                else if (error.indexOf("licenseInvalide") != -1) {
                    errMsg = $("#licenseInvalide", error).html();
                    confirmDialog(errMsg, null);
                }
                else {
                    confirmDialog(error, null)
                }
            }
        }
    });
}

/*播放声音 zhuchenglong 2017/6/27 */
function playSound() {
    var borswer = window.navigator.userAgent.toLowerCase();
    var src = "../Content/sound/MobileAppNotify.wav";
    if (borswer.indexOf("ie") >= 0) {
        //IE内核浏览器
        //var strEmbed = '<embed name="embedPlay" src="http://www.gongqinglin.com/accessory/ding.wav" autostart="true" hidden="true" loop="false"></embed>';
        //var strEmbed = '<embed name="embedPlay" src="' + src + '" autostart="true" hidden="true" loop="false"></embed>';

        var strEmbed = "<embed id='embedPlay'  autostart='true' hidden='true' loop='false'>"
        strEmbed += "<source src='" + src + "' type='audio/mpeg'>";
        strEmbed += "</embed>";
        if ($("body").find("embed").length <= 0)
            $("body").append(strEmbed);
        //var embed = document.embedPlay;
        var embed = document.getElementById("embedPlay");
        //浏览器不支持 audion，则使用 embed 播放
        embed.volume = 100;
        //embed.play();这个不需要
    } else {
        //非IE内核浏览器
        //var strAudio = "<audio id='audioPlay' src='http://www.gongqinglin.com/accessory/ding.wav' hidden='true'>";

        //var strAudio = "<audio id='audioPlay' src='" + src + "' hidden='true'>";

        var strAudio = "<audio id='audioPlay' crossOrigin='anonymous' hidden='true'>"
        strAudio += "<source src='" + src + "' type='audio/mpeg'>";
        strAudio += "</audio>";
        if ($("body").find("audio").length <= 0)
            $("body").append(strAudio);
        var audio = document.getElementById("audioPlay");

        //浏览器支持 audion
        audio.play();
    }
}

function scanCallback(str) {
    if (scanCallbackNode)
    {
        scanCallbackNode.val(str);
        var event = jQuery.Event("keydown");
        event.keyCode = 13;
        if (!window.event)
            window.event = {};
        window.event.keyCode = 13;
        scanCallbackNode.trigger(event);
        window.event = {};
    }
}
var scanCallbackNode;
$(function () {
    if (typeof (android) != "undefined" && android && android.openCamera) {
        $("input[androidScan='true']").dblclick(function () {
            scanCallbackNode = $(this);
            android.openCamera();
        });
    }
});

//安卓拍照功能回调
var takePictureNode;
var compressedSize = 100; //不压缩的阈值，单位为K（小于等于0时表示不使用压缩算法）
$(function () {
    if (typeof (android) != "undefined" && android && android.takePicture) {
        $(".androidTakePicture").click(function () {
            takePictureNode = $(this);
            android.takePicture(compressedSize);
        });
    }
});
function takePictureCallBack(content, name) {
    if (takePictureNode) {
        let hander = window[takePictureNode.attr("onTakePicture")];
        if (hander) {
            var base64Data = "data:image/jpg;base64,"   //默认安卓拍照保存的是jpg图片，加上头文件
            hander(base64Data + content, name);
        }
    }
}
function base64toFile(dataurl, filename) { // 将base64格式转为file文件流
    filename = filename || "file";
    let arr = dataurl.split(',');
    let mime = arr[0].match(/:(.*?);/)[1];
    let suffix = mime.split('/')[1];
    let bstr = atob(arr[1]);
    let n = bstr.length;
    let u8arr = new Uint8Array(n);
    while (n--) {
        u8arr[n] = bstr.charCodeAt(n)
    }
 
    return new File([u8arr], `${filename}.${suffix}`, {
        type: mime
    });
}