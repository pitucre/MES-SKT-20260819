$(function () {
    $(".tb li").click(function () {
        $(this).parent().children("li").removeClass("current");
        $(this).parent().parent().children("div").removeClass("tb_c");
        $(this).addClass("current");
        $(this).parent().parent().children("div:eq(" + $(this).index() + ")").addClass("tb_c");
    });
    /*Add By Alen 修复当选项卡是JS动态构成时无法点击的问题*/
    var jqVersion = $.fn.jquery;
    //alert(jqVersion);
    //jqVersion = parseFloat(jqVersion.substring(0, 3));

    //Modify By Alen 2017-05-24 将版本按.分割进行比较
    //    jqVersion = jqVersion.substring(0, jqVersion.lastIndexOf("."));
    //    jqVersion = parseFloat(jqVersion, 10)

    var _version = jqVersion.split(".");
    if (parseInt(_version[0]) < 2 && parseInt(_version[1]) <= 7) {//jqVersion <= 1.7
        $(".tb li").live("click", function () {
            $(this).parent().children("li").removeClass("current");
            $(this).parent().parent().children("div").removeClass("tb_c");
            $(this).addClass("current");
            $(this).parent().parent().children("div:eq(" + $(this).index() + ")").addClass("tb_c");
        });
    }
    else {
        $(".tb li").on("click", function () {
            $(this).parent().children("li").removeClass("current");
            $(this).parent().parent().children("div").removeClass("tb_c");
            $(this).addClass("current");
            $(this).parent().parent().children("div:eq(" + $(this).index() + ")").addClass("tb_c");
        });
    }

    $(".vtb li").click(function () {
        $(this).parent().children("li").removeClass("current");
        $(this).parent().parent().children("div").removeClass("vtb_c");
        $(this).addClass("current");
        $(this).parent().parent().children("div:eq(" + $(this).index() + ")").addClass("vtb_c");
    });

    /*选项卡在底部-模板编辑页面特殊选项卡*/
    $(".tb_onbtm li").click(function () {
        $(this).parent().children("li").removeClass("current");
        $(this).parent().parent().children("div").removeClass("tb_onbtm_c");
        $(this).addClass("current");
        $(this).parent().parent().children("div:eq(" + $(this).index() + ")").addClass("tb_onbtm_c");
    });
});