//jQuery.noConflict();
(function () {
    (function ($) {
        return $.fn.fixedHeader = function (options) {
            return this.each(function () {
                var $head, $parent, headTop, isFixed, o, ww;
                processScroll = function () {
                    var headTop, i, isFixed, scrollTop, t, scrollLeft, searchTop;
                    if (!o.is(':visible')) {
                        return;
                    }
                    i = void 0;
                    searchTop = 0;

                    if ($("#searchField") != null && $("#searchField") != undefined) {
                        var searchFieldHeight = $("#searchField").css("height");
                        if ("undefined" != typeof (searchFieldHeight) && null != searchFieldHeight) {
                            searchTop = parseInt(searchFieldHeight.replace("px", ""));
                        }
                    }
                    scrollTop = $parent.scrollTop() + searchTop;
                    scrollLeft = $parent.scrollLeft();

                    $("#footerTR").css("margin-left", "-" + scrollLeft + "px");

                    t = $head.length && $head.offset().top;
                    if (!isFixed && headTop !== t) {
                        headTop = t;
                    }
                    if (scrollTop >= headTop && !isFixed) {
                        isFixed = 1;
                    } else {
                        if (scrollTop <= headTop && isFixed) {
                            isFixed = 0;
                        }
                    }

                    if (options && options.afterScroll && typeof (options.afterScroll) == "function") {
                        options.afterScroll(o);
                    }

                    if (isFixed) {
                        return $('tr.header-copy', o).show();
                    } else {
                        return $('tr.header-copy', o).hide();
                    }


                };
                o = $(this);
                $parent = $("#gridviewcontainer");//$($(this).parent());

                if ($parent == undefined) {
                    $parent = $("#divListContainer");//$($(this).parent());
                }

                $head = $('tr.ListTableHeader', o);
                isFixed = 0;
                headTop = ($head.length) && ($head.offset().top);
                //$parent.bind('scroll', processScroll);

                $head.clone().attr("id", "footerTR").addClass('header-copy header-fixed').appendTo(o);
                ww = [];
                $("#footerTR th").each(function () {
                    $(this).css("max-width", ($(this).attr("width") + "px"));
                });
                o.find('tr:first > th').each(function (i, h) {
                    return ww.push($(h).width());
                });

                $.each(ww, function (i, w) {
                    if (!window.ActiveXObject && !("ActiveXObject" in window)) {
                        w = w + 1;
                    }
                    return o.find('#footerTR > th:eq(' + i + ') ').css({ width: w });
                });
                o.find('tr.header-copy').css({
                    width: o.width(),
                    top: headTop - 2,
                    height: 26,
                });
                return processScroll();
            });
        };
    }(jQuery));
}.call(this));


var tabSize = tabSize || {};
tabSize.init = function (id) {
    var table = document.getElementById(id);
    var header = table.rows[0];
    if (header == undefined) {
        return;
    }
    var i,
        self,
        tableX = header.clientWidth,
        length = header.cells.length;

    for (i = 0; i < length; i++) {
        header.cells[i].onmousedown = function () {
            self = this;
            if (event.offsetX > self.offsetWidth - 10) {
                self.mouseDown = true;
                self.oldX = event.x;
                self.oldWidth = self.offsetWidth;
            }
        };
        header.cells[i].onmousemove = function () {

            if (event.offsetX > this.offsetWidth - 10) {
                this.style.cursor = 'col-resize';
            } else {
                this.style.cursor = 'default';
            }
            if (self == undefined) {
                self = this;
            }
            if (self.mouseDown != null && self.mouseDown == true) {
                self.style.cursor = 'default';
                if (self.oldWidth + (event.x - self.oldX) > 0) {
                    self.width = self.oldWidth + (event.x - self.oldX);
                }
                self.style.width = self.width + 'px';
                table.style.width = tableX + (event.x - self.oldX) + 'px';
                self.style.cursor = 'col-resize';

                setTimeout(function () {
                    $(table).find("tr:first th").each(function (i, obj) {
                        if (!window.ActiveXObject && !("ActiveXObject" in window)) {
                            $("#footerTR th:eq(" + i + ")").width($(obj).width() + 1);
                        }
                        else {
                            $("#footerTR th:eq(" + i + ")").width($(obj).width());
                        }

                    });
                    $("#footerTR").width($(table).width());
                }, 100);
            }
        };

        table.onmouseup = function () {
            if (self == undefined) {
                self = this;
            }
            self.mouseDown = false;
            self.style.cursor = 'default';
            tableX = header.clientWidth;

        };
    }
};



