
var isInitLang = false;

//获取多语言值
function mesLang(key) {
    if (languages[key]) {
        return languages[key];
    }
    else {
        collectLanguage(key);
    }
    return key;
}

function collectLanguage(key) {
    //采集多语言：包含中文且不是hmtl标签
    if (/[\u4E00-\u9FA5]/g.test(key) && !(/[<].*[>]/g.test(key))) {
        var data = { key: key };
        $.post(_root + "/Handler/Language.ashx?cmd=CollectLanguage", data, function (res) {
            if (res) {
                console.error(res);
            }
        });
    }
}

function SetEnLang_Html(item, attr) {
    var key = attr ? $(item).attr(attr) : $(item).html();
    //如果为空不做处理
    if (!key || !$.trim(key)) {
        return;
    }
    var oldValue = key;
    //去掉前后空格
    key = $.trim(key);  
    //去掉特殊符号
    var specialTexts = [/[\r\n]/g, /[\t]/g, /<[ ]*em[ ]*>\*<\/[ ]*em[ ]*>/gi, /(^:)|(:$)/g, /(^：)|(：$)/g];
    $.each(specialTexts,function (i,o) {
        key = key.replace(o, "");
    });
    if (languages[key]) {
        if (attr) {
            if (attr == "value") {
                $(item).val(oldValue.replace(key, languages[key]));
            }
            else if ($(item).attr(attr) != undefined) {
                key == $.trim($(item).attr(attr));
                $(item).attr(attr, oldValue.replace(key, languages[key]))
            }
        }
        else {
            $(item).html(oldValue.replace(key, languages[key]));
        }
    }
    else {
        collectLanguage(key);
    }
}

function initPageLang()
{
    if (isInitLang)
    {
        return;
    }
 
    var lang = $("#hfMESLang").val();
    if (lang != "zh-cn") {
        $("body").find("meslang,mesLang,.mesLang,.Label1,.Label2,.Label3,.Label4,.Label5,.Label6,.ListTableHeader a,tr th,tr ht a,.leftmenu-group-item-text,a,.btn-text,.Label2 span,#titleUL li,span.title,#lbTopMenuHeader"
            + "span.imgText,.wrap_tb ul li,label,#showChkBox span,.topmenutext,.divHeader,.divHeader mesLang,.Label span,.ListTableTitle div,.Tips,td.Label,option,span,.leftmenu-new-header,.dds-panel-prodinfo-name,.scan-center-title").each(function (i, item) {
                SetEnLang_Html(item);
                SetEnLang_Html(item, "title");
            });
        
        /*智能报表查询*/
        $(".BaseInfo-Group .title,.basicInfo tr td").each(function (i, item) {
            SetEnLang_Html(item);
        });

        /*标题处理*/
        $("#favorityLink div,input").each(function (i, item) {
            SetEnLang_Html(item, "title");
        });

        /*value值处理*/
        $("input[type=button],input[type=submit],input[type=file]").each(function (i, item) {
            SetEnLang_Html(item, "value");
        });
        isInitLang = true;
       //$("#module_list #equement .mesLang").css("width", "230px").html("TPM")
    }
}
function initMenuLang(id) {
    var lang = $("#hfMESLang").val();
    if (lang != "zh-cn") {
        $("#" + id).find("mesLang,.mesLang").each(function (i, item) {
            SetEnLang_Html(item);
        });
        $("#lbTopMenuHeader,.leftmenu-group-link-text").each(function (i, item) {
            SetEnLang_Html(item);
        });

        $("#leftmenu-new").find("li").each(function (i, item) {
            SetEnLang_Html(item, "title");
        });
        $("#lbTopMenuHeader").each(function (i, item) {
            $(item).attr("title", $(item).html());
        });

    }
}

function GetMESLange(value) {
    var lang = $("#hfMESLang").val();
    if (lang != "zh-cn") {
        value = value.replace(/[\r\n]/g, "").replace(/[ ]/g, "");
        if (typeof (languages[value]) == "undefined") {
            return value;
        }
        else {
            return languages[value];
        }
    }
    return value;
}