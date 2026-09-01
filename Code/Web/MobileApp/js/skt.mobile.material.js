/****************************************************************************
*  Author: WeiXia
*  Create Datetime: 2016-8-9
*  Desc: 返回结果
*  Plugin Version: 
****************************************************************************/
function AjaxRequestByUrl(url) {
    var d;
    $.ajax({
        type: "POST",
        url: url,
        async: false,
        success: function (data) {
            d = data;
        },
        error: function (err) {
            //报错
        }
    });
    return d;
}
