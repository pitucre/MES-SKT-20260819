/****************************************************************************
*  Author: Alen Liu
*  Create Datetime: 2014-01-10
*  Desc: 框架主功能模板JS
*  Version: 1.0.0
*  Email: shzalen@163.com
*
*
*  Modify Datetime: 2014-11-28
*  Current Version: 1.0.21
*  Desc:  修复选项卡错位，修复选项卡内容错位，修复选项卡移动距离不正确
****************************************************************************/

$(document).ready(function () {
    /*resize the window's size*/
    setTimeout(function () {
        try {
            self.moveTo(0, 0)
            self.resizeTo(screen.availWidth, screen.availHeight);
            self.focus();
        }
        catch (ex) {

        }
    }, 10);

    setTimeout(function () {
        setContentHeight();
        setLeftMenuHeight();
        setFramecenterHeight();
    }, 20);
});

$(function () {
    /*change the content size when the window is resize*/
    $(window).resize(function () {
        setContentHeight();
        setLeftMenuHeight();
        setFramecenterHeight();
        showLeftRightMove();
    });

    /*show or hide left menu*/
    $("#slider").click(function () {
        showLeftMenu();
    });

    /*expand or close left menu item*/
    $(".leftmenu-group-item").click(function () {
        /*$(".leftmenu-group-item").parent().children("ul").slideUp();*/
        var ul = $(this).parent().children("ul");
        if (ul.attr("class") == null || ul.attr("class").indexOf("Expand") == -1) {
            $(".leftmenu-group-item").parent().children("ul").slideUp(300);
            $(".leftmenu-group-item").parent().children("ul").removeClass("Expand");
            ul.stop(false, true).slideDown(300);
            ul.addClass("Expand");
            $(".leftmenu-group-item-toggle-selected").removeClass("leftmenu-group-item-toggle-selected");
            $(this).children(".leftmenu-group-item-toggle").addClass("leftmenu-group-item-toggle-selected")
        }
        else {
            ul.stop(false, true).slideUp(300);
            ul.removeClass("Expand");
            $(".leftmenu-group-item-toggle-selected").removeClass("leftmenu-group-item-toggle-selected");
            /*$(this).children(".leftmenu-group-item-toggle").addClass("leftmenu-group-item-toggle-selected")*/
        }

    });
});

/*set the height of the content*/
function setContentHeight() {
    wHeight = $(window).height();
    var hHeight = $("#header").height();
    $("#content").height(wHeight - hHeight - 32);
}

/*set the height of left menu*/
function setLeftMenuHeight() {
    wHeight = $(window).height();
    var hHeight = $("#header").height();
    $("#leftmenu-new-content").height(wHeight - hHeight - 61);
}

/*show or hide left menu*/
var isCollapse = false;
function showLeftMenu(isShow) {
    if (isShow == undefined || isShow == null) {
        isCollapse = !isCollapse;
    }
    else {
        isCollapse = isShow;
    }

    if (isCollapse) {
        $("#leftmenu-new").hide();
        $("#leftmenu-new").parent().css("width", "0px");
    }
    else {
        $("#leftmenu-new").show();
        $("#leftmenu-new").parent().css("width", _leftMenuWidth);
    }
}

/*set the height of content iframe*/
function setFramecenterHeight() {
    var cHeight = $("#content").height();
    $("#framecenter").height(cHeight - 29);
    $(".ifmcenter").height(cHeight - 29);
}

/*show or hide loading bg div*/
function showShadow(iShow) {
    if (iShow) {
        $("#shadowdiv").css({ "height": $(window).height(), "width": $(window).width() });
        $("#shadowdiv").show();
        $("body").css("overflow", "hidden");
    }
    else {
        $("#shadowdiv").hide();
        $("body").css("overflow", "auto");
    }
}

/*close tabs*/
function closeTab(obj) {
    try {
        var $this = $(obj).parent().parent().parent().parent().parent();
        var tabId = $this.attr("id");

        if (tabId == "tab-1") {
            alert(text_DefautTabNotAllowDelete);
            return false;
        }

        $this.remove();
        $("#" + tabId.replace("-", "")).remove();

        if ($("#tabs div").length < 2) {
            $("#tab-1").addClass("tabs-selected");
            $(".menugrouphover").removeClass("menugrouphover");
            selecteTab($("#tab-1 table tr td:eq(1)"));
        }
        else {
            if ($this.attr("class").indexOf("tabs-selected") > -1) {/*$this.attr("class") == "tabs-selected"*/
                $("#tabs div:eq(" + ($("#tabs div").length - 1) + ")").addClass("tabs-selected");
                $(".tab-left-selected").addClass("tab-left");
                $(".tab-body-selected").addClass("tab-body");
                $(".tab-right-selected").addClass("tab-right");
                $(".tab-left-selected").removeClass("tab-left-selected");
                $(".tab-body-selected").removeClass("tab-body-selected");
                $(".tab-right-selected").removeClass("tab-right-selected");

                selecteTab($("#tabs div:eq(" + ($("#tabs div").length - 1) + ") table tr td:eq(1)"));
            }
        }
        $(".tabs-close").hide();
        $(".tabs-selected .tabs-close").show();
        if (isCollapse) {
            $("#leftmenu-new").show();
            $("#leftmenu-new").parent().css("width", _leftMenuWidth);
            isCollapse = false;
        }
    }
    catch (e) { }
}

/*select tabs*/
function selecteTab(obj) {
    var $this = $(obj).parent().parent().parent().parent();

    $(".tabs-close").hide();
    $(obj).parent().children("td").eq(2).children("span").show();
    var tabId = $this.attr("id");
    $(".tabs-selected").removeClass("tabs-selected");
    $this.addClass("tabs-selected");
    $(".tab-left-selected").addClass("tab-left");
    $(".tab-body-selected").addClass("tab-body");
    $(".tab-right-selected").addClass("tab-right");
    $(".tab-left-selected").removeClass("tab-left-selected");
    $(".tab-body-selected").removeClass("tab-body-selected");
    $(".tab-right-selected").removeClass("tab-right-selected");
    $(obj).addClass("tab-body-selected");
    $(obj).removeClass("tab-body");
    $(obj).prev().removeClass("tab-left");
    $(obj).prev().addClass("tab-left-selected");
    $(obj).next().removeClass("tab-right");
    $(obj).next().addClass("tab-right-selected");
    $(".tabs-items-selected").removeClass("tabs-items-selected");
    $("#" + tabId.replace("-", "")).addClass("tabs-items-selected");

    var curTabId = $this.attr("id");
    if (curTabId != "tab-1") {
        curTabId = curTabId.substring(4, curTabId.length);
        $(".menugrouphover").removeClass("menugrouphover");
        $("#" + curTabId).addClass("menugrouphover");

        if ($("#" + curTabId).parent().parent().children("ul").attr("class") == null || $("#" + curTabId).parent().parent().children("ul").attr("class").indexOf("Expand") == -1) {
            $(".Expand").slideUp(100);
            $(".Expand").removeClass("Expand");
            $("#" + curTabId).parent().parent().children("ul").stop(false, true).slideDown(100);
            $("#" + curTabId).parent().parent().children("ul").addClass("Expand");
            $(".leftmenu-group-item-toggle-selected").removeClass("leftmenu-group-item-toggle-selected");
            $("#" + curTabId).parent().parent().children("span").children("span:eq(2)").addClass("leftmenu-group-item-toggle-selected");
        }
        if ($("#" + curTabId) != null && $("#" + curTabId).html() != null) {
            var curSubId = $("#" + curTabId).parent().parent().parent().attr("id").replace("menugroup", "");
            var curSubText = $("#sub-" + curSubId).children("span:first").html();
            $(".iselected").removeClass("iselected");
            $("#sub-" + curSubId).addClass("iselected");
            $(".menugroup").hide();
            $("#leftmenu-new-content #menugroup" + curSubId.toString()).show();
            $("#lbTopMenuHeader").text(curSubText);
        }
    }
}

/*top menu click*/
function showMenu(obj, menuId, menuName) {
    $(".iselected").removeClass("iselected");
    $(obj).addClass("iselected");
    $(".menugroup").hide();
    $("#leftmenu-new-content #menugroup" + menuId.toString()).show();
    $("#lbTopMenuHeader").text(menuName);
    selecteTab($("#tab-1 table tr td:eq(1)"));
}




/*left menu item click*/
function openLeftMenu(obj, tabtitle, url, tabId) {
    //tabId = tabId.replace(/\+/g, "-").replace(/\!/g, "-").
    //              replace(/\~/g, "-").replace(/\@/g, "-").
    //              replace(/\#/g, "-").replace(/\$/g, "-").
    //              replace(/\%/g, "-").replace(/\^/g, "-").
    //              replace(/\&/g, "-").replace(/\*/g, "-").
    //              replace(/\(/g, "-").replace(/\)/g, "-").
    //              replace(/\（/g, "-").replace(/\）/g, "-").
    //              replace(/\_/g, "-").replace(/\=/g, "-");

    openTab(obj, tabtitle, url, tabId, "../Content/theme/Metro/images/application1.png");
}

/*open tab*/
function openTab(obj, tabtitle, url, tabId, tabIcon) {
    
    if (tabtitle == undefined || tabtitle == "") {
        tabtitle = "Tab";
    }
    if (obj != undefined && obj != null) {
        $(".menugrouphover").removeClass("menugrouphover");
        $(obj).addClass("menugrouphover");
    }
    if (multipwin) {
        if ($("#tab-" + tabId).attr("id") != undefined) {
            selecteTab($("#tab-" + tabId + " table tr td:eq(1)"));
            $(".framecss-loading").hide();
            return false;
        }
        var tab_id = $("#tabs div").length + 1;

        
        var tabs_header = "";
        tabs_header += "<div id=\"tab-" + tabId + "\" title=\"" + mesLang(tabtitle) + "\" class=\"tabs-selected\">";
        tabs_header += "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">";
        tabs_header += "<tr>";
        tabs_header += "<td class=\"tab-left-selected\"></td>";
        tabs_header += "<td class=\"tab-body-selected\" onclick=\"selecteTab(this)\">";
        if (tabtitle.length > 15) {
            tabtitle = tabtitle.substring(0, 15) + "...";
        }
        tabs_header += "<span class=\"tabs-text\" ><img src=\"" + tabIcon + "\" width=\"16\" height=\"16\" style=\" float:left;\"/>" + mesLang(tabtitle) + "</span>";
        tabs_header += "</td>";
        tabs_header += "<td class=\"tab-right-selected\" align=\"center\" valign=\"top\"><span class=\"tabs-close\" onclick=\"closeTab(this)\" title=\"" + _closeCurrentTab + "\"></span></td>";
        tabs_header += "</tr>";
        tabs_header += "</table>";
        tabs_header += "</div>";

        var tabs_items = "<div id=\"tab" + tabId + "\" class=\"tabs-items-selected\">";
        tabs_items += "<div class=\"framecss-loading\" id=\"framecss-loading\"><span style=\"  color: #21adf7; width:100%;  margin-left: auto; margin-right: auto;  line-height: 25px;\">" + _dataLoading + "<br /><img src=\"" + _webRoot + "/Content/plugin/dialog/skin/default/images/loadinga.gif\" /></span></div>";
        tabs_items += "<iframe width=\"100%\" frameborder=\"0\" class=\"ifmcenter\" height=\"" + ($("#content").height() - 29) + "\" scrolling=\"auto\" id=\"ifmcenter" + tabId + "\" src=\"\"></iframe>";
        tabs_items += "</div>";

        $(".tab-left-selected").addClass("tab-left");
        $(".tab-body-selected").addClass("tab-body");
        $(".tab-right-selected").addClass("tab-right");

        $(".tabs-selected").removeClass("tabs-selected");
        $(".tab-left-selected").removeClass("tab-left-selected");
        $(".tab-body-selected").removeClass("tab-body-selected");
        $(".tab-right-selected").removeClass("tab-right-selected");

        $(".tabs-items-selected").removeClass("tabs-items-selected");

        $(tabs_header).appendTo($("#tabs"));


        $(tabs_items).appendTo($("#tabs-items"));

        $("#tab" + tabId + " .framecss-loading").show();

        var ifmcenters = $("#ifmcenter" + tabId);
        ifmcenters.bind("load", function () {
            $("#tab" + tabId + " .framecss-loading").hide();
        });
        $("#ifmcenter" + tabId).attr("src", url);

        $(".tabs-close").hide();
        $(".tabs-selected .tabs-close").show();
        showLRMove();
    }
    else {
        $("#ifmcenter").attr("src", url);
        $("#tabshome").html(tabtitle);
    }
}

/*left right move*/
function showLRMove() {
    var divwidth = 0;
    try {
        $("#tabs div").each(function () {
            divwidth += $(this).width() + 5;
        });

        if (divwidth >= $(".tabs-container").width() - 20) {
            $(".vleft-bg,.vright-bg").show();
            $("#vleft,#vright").show();
            var l = $("#tabs div").length - 1;
            var moveLeft = parseInt($("#tabs div").eq(parseInt(l)).width());
            moveLeft = divwidth - $(".tabs-container").width() + 20;
            $("#tabs").animate({ left: -moveLeft + "px" }, 300);

            $("#tabs").width(divwidth + 20);
        }
    }
    catch (e) { }
}

/*show or hide tabs move arrows*/
function showLeftRightMove() {
    var divwidth = 0;
    $("#tabs div").each(function () {
        divwidth += $(this).width();
    });

    if (divwidth >= $(".tabs-container").width() - 20) {
        $(".vleft-bg,.vright-bg").show();
        $("#vleft,#vright").show();
        var l = $("#tabs div").length - 1;
        var moveLeft = parseInt($("#tabs div").eq(parseInt(l)).width());
        moveLeft = divwidth - $(".tabs-container").width() + 20; //-moveLeft + parseInt($("#tabs").css("left").replace("px", ""));
        $("#tabs").css({ left: -moveLeft + "px" });
    }
    else {
        $(".vleft-bg,.vright-bg").hide();
        $("#vleft,#vright").hide();
        $("#tabs").css("left", "20px");
    }
}

$(function () {
    var i = 0;
    /*move left*/
    $("#vright").click(function () {
        i = $("#tabs div").length;
        if (!$("#tabs").is(":animated")) {
            if (i == 1) {
                $("#tabs").stop();
            } else {
                if (parseInt($("#tabs").css("left").replace("px", "")) + parseInt($("#tabs").width()) >= parseInt($(".tabs-container").width()) - 50) {
                    $("#tabs").animate({ left: "-=" + 80 + "px" }, 300);
                }
            }
            i--;
        }
    });

    /*move right*/
    $("#vleft").click(function () {
        i = $("#tabs div").length;
        if (!$("#tabs").is(":animated")) {
            if (i == 1) {
                $("#tabs").stop();
            } else {
                var moveright = 80;
                if (-parseInt($("#tabs").css("left").replace("px", "")) <= 80) {
                    moveright = -parseInt($("#tabs").css("left").replace("px", "")) + 20;
                }
                $("#tabs").animate({ left: "+=" + moveright + "px" }, 300);
                i++;
            }
        }
    });
});


/*get current tab*/
function getCurrentTab() {
    return $(".tab-body-selected .tabs-text");
}

function hideFrameCssLoading() {
    $(".framecss-loading").hide();
}

/*Add By Alen Liu 2016-07-07 刷新指定的选项卡*/
function refreshTab(tabId) {
    try {
        $("#framecenter #tab" + tabId, window.parent.document).children("iframe").attr("src", $("#framecenter #tab" + tabId, window.parent.document).children("iframe").attr("src"));
    }
    catch (e) { }
}

/*tabs's contextmenu*/
$(function () {
    var contextmenuhtml = "";
    contextmenuhtml += "<div class=\"contextMenu\" id=\"tabContextMenu\">";
    contextmenuhtml += "<ul>";
    contextmenuhtml += "<li id=\"closeCurrentTab\"> " + _closeCurrentTab + "</li>";
    contextmenuhtml += "<li id=\"closeOtherTab\"> " + _closeOtherTab + "</li>";
    contextmenuhtml += "<li id=\"closeAllTab\"> " + _closeAllTab + "</li>";
    contextmenuhtml += "<li id=\"refreshCurrentTab\"><span style='margin-left:-25px; margin-right:3px;'><img src='" + _webRoot + "/Content/images/icon/refresh.png'></span> " + _refreshTab + "</li>";
    contextmenuhtml += "</ul>";
    contextmenuhtml += "</div>";
    $("body").append(contextmenuhtml);
    $(".tabs div").live("mousedown", function () {
        $(this).contextMenu("tabContextMenu",
        {
            bindings:
            {
                "refreshCurrentTab": function (t) {

                    $("#" + t.id.replace("-", "")).children("iframe").attr("src", $("#" + t.id.replace("-", "")).children("iframe").attr("src"));
                },
                'closeCurrentTab': function (t) {
                    if (t.id != "tab-1") {
                        closeTab($("#" + t.id).children().children().children().children().children());
                    }

                },
                'closeOtherTab': function (t) {
                    $("#tabs div").each(function () {
                        if ($(this).attr("id") != "tab-1" && $(this).attr("id") != t.id) {
                            closeTab($(this).children().children().children().children().children())
                        }
                    });
                    var moveright = -parseInt($("#tabs").css("left").replace("px", "")) + 20;
                    if (!$("#tabs").is(":animated")) {
                        $("#tabs").stop(false, true).animate({ left: "+=" + moveright + "px" }, 300);
                    }
                    $(".vleft-bg,.vright-bg").hide();
                    $("#vleft,#vright").hide();
                },
                'closeAllTab': function (t) {
                    $("#tabs div").each(function () {
                        if ($(this).attr("id") != "tab-1") {
                            closeTab($(this).children().children().children().children().children())
                        }
                    });
                    var moveright = -parseInt($("#tabs").css("left").replace("px", "")) + 20;
                    if (!$("#tabs").is(":animated")) {
                        $("#tabs").stop(false, true).animate({ left: "+=" + moveright + "px" }, 300);
                    }
                    $(".vleft-bg,.vright-bg").hide();
                    $("#vleft,#vright").hide();
                }
            },
            shadow: true,
            menuStyle: {
                listStyle: 'none',
                padding: '2px 2px 2px 1px',
                margin: '1px',
                background: 'url(' + _webRoot + '/Content/theme/metro/images/contextmenu_bg.gif) repeat-y',
                border: '1px solid #dedfdf',
                //width: '150px',
                width: 'auto',
                minWidth: '96px',
                backgroundSize: '100% 100%',
            },
            itemStyle: {
                padding: '5px 2px 2px 30px',
                color: '#000',
                display: 'block',
                cursor: 'default',
                margin: '0px',
                //width: '150px',
                border: '0px solid #eeeeee',
                backgroundColor: 'transparent',
                height: '18px',
                 overflow: 'hidden',
                //textOverflow: 'ellipsis',
                whiteSpace: 'nowrap'

            },
            itemHoverStyle: {
                border: '0px solid #eeeeee',
                backgroundColor: '#e4e4e4',
                margin: '0px',
                height: '18px',
                //width: '120px',
                padding: '5px 2px 2px 30px',
                cursor: 'pointer'
            }
        });
    });
});
