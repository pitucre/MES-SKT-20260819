if (userId != -1) {
    setInterval(function () {
        ajaxPull();
    }, 240000);
}

$(function () {
    if (userId != -1) {
        ajaxPull();
    }
});


function ajaxPull() {
    $.ajax({
        type: 'get',
        url: _webRoot + "/Handler/Account.ashx?type=checkTimeout&userid=" + userId + "&rnd=" + Math.random(),
        datatype: 'text',
        success: function (data) {
            var result = data;
            var showMsg = "登录用户已经超时!";
            if (result == '401') {
                location.href = _webRoot + '/Index.aspx?msg=' + showMsg;
            }
        }
    });
}


function checkNowIP() {
    $.ajax({
        type: 'get',
        url: _webRoot + "/Handler/Account.ashx?type=checkNowId&userid=" + userId + "&rnd=" + Math.random(),
        datatype: 'text',
        success: function (data) {
            var result = data;
            var showMsg = "您的账号已经在另外一台电脑登陆,您被迫下线,请知悉!";
            if (result == '402') {
                location.href = _webRoot + '/Index.aspx?msg=' + showMsg;
            }
        }
    });
}
