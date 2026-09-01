function checkUserOnline() {
    $.ajax({
        type: 'post',
        url: "../Handler/MobileAppLogin.ashx?Action=CheckOnline&rnd=" + Math.random(),
        async: true,
        beforeSend: function () {
        },
        success: function (data) {
            if (data != "") {
                location.href = "Login.aspx";
            }
        },
        complete: function (XMLHttpRequest, str) {
            if (status == 'timeout') {//超时,status还有success,error等值的情况
                this.abort();
                confirmDialog("超时", function () { location.href = "Login.aspx"; });
            }
        },
        datatype: 'text',
        error: function (xhr, status, error) {
            if (error.indexOf("errMsgContent") != -1) {
                confirmDialog($(".errMsgContent", error).html(), null);
            }
            else {
                confirmDialog(erro, null);
            }
        }
    });
}

