if (typeof (SktMesUIManagers) == "undefined") {
    SktMesUIManagers = {}
} (function ($) {
    $.fn.SktMesGetGridManager = function () {
        return SktMesUIManagers[this[0].id + "_Grid"]
    };
    $.SktMesDefaults = $.SktMesDefaults || {};
    $.SktMesDefaults.Grid = {
        title: null,
        width: "auto",
        columnWidth: 120,
        resizable: true,
        dataSource: false,
        usePager: true,
        rownumbers:true,
        page: 1,
        total: 1,
        pageSize: 10,
        pageSizeOptions: [10, 20, 30, 40, 50],
        parms: [],
        columns: [],
        minColToggle: 1,
        dataType: "server",
        dataAction: "PROC",
        paramters: "[]",
        selectFields:"",
        conditions: "1=1",
        showTableToggleBtn: false,
        switchPageSizeApplyComboBox: true,
        allowAdjustColWidth: true,
        checkbox: false,
        allowHideColumn: true,
        enabledEdit: false,
        isScroll: true,
        onDragCol: null,
        onToggleCol: null,
        onChangeSort: null,
        onSuccess: null,
        onDblClickRow: null,
        onSelectRow: null,
        onUnSelectRow: null,
        onBeforeCheckRow: null,
        onCheckRow: null,
        onBeforeCheckAllRow: null,
        onCheckAllRow: null,
        onBeforeShowData: null,
        onAfterShowData: null,
        onError: null,
        onSubmit: null,
        dateFormat: "yyyy-MM-dd",
        InWindow: true,
        statusName: "__status",
        method: "post",
        fixedCellHeight: true,
        heightDiff: 0,
        cssClass: null,
        root: "Rows",
        record: "Total",
        pageParmName: "page",
        pagesizeParmName: "pagesize",
        sortnameParmName: "sortname",
        sortorderParmName: "sortorder",
        onReload: null,
        onToFirst: null,
        onToPrev: null,
        onToNext: null,
        onToLast: null,
        allowUnSelectRow: false,
        dblClickToEdit: false,
        alternatingRow: true,
        mouseoverRowCssClass: "l-grid-row-over",
        enabledSort: true,
        rowAttrRender: null,
        renderDate: function (a) {
            var b;
            if (!a) {
                return null
            }
            if (typeof a == "object") {
                return a
            }
            if (a.indexOf("Date") > -1) {
                b = eval("new " + a.replace("/", "", "g").replace("/", "", "g"))
              
            } else {
                /*IE 不支持 yyyy-mm-dd 格式 转换为 yyyy/mm/dd */
                a = a.replace(/-/ig, "/");
                b = eval('new Date("' + a + '");')
            }
            return b
        }
    };
    $.SktMesDefaults.GridString = {
        errorMessage: "发生错误",
        pageStatMessage: "显示记录从{from}到{to}，总数 {total} 条",
        pageTextMessage: "Page",
        loadingMessage: "加载中...",
        findTextMessage: "查找",
        noRecordMessage: "没有符合条件的记录存在",
        isContinueByDataChanged: "数据已经改变,如果继续将丢失数据,是否继续?"
    };
    $.SktMesAddGrid = function (t, p) {
        if (t.usedGrid) {
            return
        }
        $(t).hasClass("l-panel") || $(t).addClass("l-panel");
        var u = [];
        u.push("        <div class='l-panel-header'><span class='l-panel-header-text'></span></div>");
        u.push("                    <div class='l-grid-loading'></div>");
        u.push("                    <div class='l-grid-editor'></div>");
        u.push("        <div class='l-panel-bwarp'>");
        u.push("            <div class='l-panel-body'>");
        u.push("                <div class='l-grid'>");
        u.push("                    <div class='l-grid-dragging-line'></div>");
        u.push("                    <div class='l-grid-popup'><table cellpadding='0' cellspacing='0'><tbody></tbody></table></div>");
        u.push("                    <div class='l-grid-header'>");
        u.push("                        <div class='l-grid-header-inner'><table class='l-grid-header-table' cellpadding='0' cellspacing='0'><tbody><tr></tr></tbody></table></div>");
        u.push("                    </div>");
        u.push("                    <div class='l-grid-body l-scroll'>");
        u.push("                    </div>");
        u.push("                 </div>");
        u.push("              </div>");
        u.push("         </div>");
        u.push("         <div class='l-panel-bar'>");
        u.push("            <div class='l-panel-bbar-inner'>");
        u.push("            <div class='l-bar-group l-bar-selectpagesize'></div>");
        u.push("                <div class='l-bar-separator'></div>");
        u.push("                <div class='l-bar-group'>");
        u.push("                    <div class='l-bar-button l-bar-btnfirst'><span></span></div>");
        u.push("                    <div class='l-bar-button l-bar-btnprev'><span></span></div>");
        u.push("                </div>");
        u.push("                <div class='l-bar-separator'></div>");
        u.push("                <div class='l-bar-group'><span class='pcontrol'> <input type='text' size='4' value='1' /> / <span></span></span></div>");
        u.push("                <div class='l-bar-separator'></div>");
        u.push("                <div class='l-bar-group'>");
        u.push("                     <div class='l-bar-button l-bar-btnnext'><span></span></div>");
        u.push("                    <div class='l-bar-button l-bar-btnlast'><span></span></div>");
        u.push("                </div>");
        u.push("                <div class='l-bar-separator'></div>");
        u.push("                <div class='l-bar-group'>");
        u.push("                     <div class='l-bar-button l-bar-btnload'><span></span></div>");
        u.push("                </div>");
        u.push("                <div class='l-bar-separator'></div>");
        u.push("                <div class='l-bar-group l-bar-right'><span class='l-bar-text'></span></div>");
        u.push("                <div class='l-clear'></div>");
        u.push("            </div>");
        u.push("         </div>");
        $(t).html(u.join(""));
        var g = {
            loadData: function (d) {
                if (!p.newPage) {
                    p.newPage = 1
                }
                if (p.dataAction == "TABLE") {
                    if (!p.sortOrder) {
                        p.sortOrder = "asc"
                    }
                }
                var f = [];
                f.push({
                    name: "dataAction",
                    value: p.dataAction
                });
                f.push({
                    name: "paramters",
                    value: p.paramters
                });
                f.push({
                    name: "conditions",
                    value: p.conditions
                });
                f.push({name:"selectFields",value:p.selectFields});
                if (p.parms && p.parms.length) {
                    $(p.parms).each(function () {
                        f.push({
                            name: this.name,
                            value: this.value
                        })
                    })
                }
                if (p.dataAction == "TABLE" || p.isProcPage==true) {
                    if (p.usePager) {
                        f.push({
                            name: p.pageParmName,
                            value: p.newPage
                        });
                        f.push({
                            name: p.pagesizeParmName,
                            value: p.pageSize
                        })
                    }
                    if(p.isProcPage){
                        f.push({
                            name:"isProcPage",
                            value:p.isProcPage
                        });
                    }                    
                    if (p.sortName) {
                        f.push({
                            name: p.sortnameParmName,
                            value: p.sortName
                        });
                        f.push({
                            name: p.sortorderParmName,
                            value: p.sortOrder
                        })
                    }
                }
                g.gridloading.show();
                $(".l-bar-btnload span", g.toolbar).addClass("l-disabled");
                this.loading = true;
                if (p.dataType == "local") {
                    if (!g.data) {
                        g.data = $.extend({}, p.data)
                    }
                    if (p.usePager) {
                        g.currentData = g.getCurrentPageData(g.data)
                    } else {
                        g.currentData = $.extend({}, g.data)
                    }
                    g.showData(g.currentData)
                } else {
                    if (p.dataAction == "PROC" && g.data && !d && p.isProcPage !=true) {
                        g.currentData = g.getCurrentPageData(g.data);
                        g.showData(g.currentData)
                    } else {                       
                        $.ajax({
                            type: p.method,
                            url: "../Handler/ReportingServer.ashx?gridviewname=" + p.dataSource,
                            data: f,
                            dataType: "json",
                            success: function (a) {
                                g.data = $.extend({}, a);
                                if (p.dataAction == "TABLE" || p.isProcPage==true) {                                 
                                    g.currentData = g.data;
                                    //g.currentData = g.getCurrentPageData(g.data);
                                    g.showData(g.currentData)
                                } else {
                                    g.currentData = g.getCurrentPageData(g.data);
                                    g.showData(g.currentData)
                                }
                            },
                            error: function (a, b, c) {
                                g.gridloading.hide();
                                $(".l-bar-btnload span", g.toolbar).removeClass("l-disabled");
                                try {
                                    if (p.onError) {
                                        p.onError(a, b, c)
                                    }
                                } catch (e) { }
                            }
                        })
                    }
                }
            },
            setOptions: function (a) {
                $.extend(p, a)
            },
            showData: function (j) {
                if (p.onBeforeShowData && p.onBeforeShowData(t, j) == false) {
                    return false
                }
                g.isDataChanged = false;
                $(".l-bar-btnloading:first", this.toolbar).removeClass("l-bar-btnloading");
                g.gridloading.hide();
                $(".l-bar-btnload:first span", g.toolbar).removeClass("l-disabled");
                this.loading = false;
                if (p.usePager) {
                    p.total = j[p.record];
                    p.page = p.newPage;
                    p.pageCount = Math.ceil(p.total / p.pageSize);
                    this.buildPager()
                }
                g.gridbody.html("");
                var k = ['<div class="l-grid-body-inner"><table class="l-grid-body-table" cellpadding=0 cellspacing=0><tbody>'];
                var l = j[p.root].length;
                $(j[p.root]).each(function (i, h) {
                    if (!h) {
                        return
                    }
                    if (!p.usePager && i == l - 1 && !g.isTotalSummary()) {
                        k.push('<tr class="l-grid-row l-grid-row-last')
                    } else {
                        k.push('<tr class="l-grid-row')
                    }
                    if (i % 2 == 1 && p.alternatingRow) {
                        k.push(" l-grid-row-alt")
                    }
                    k.push('" ');
                    if (p.rowAttrRender) {
                        k.push(p.rowAttrRender(h, i))
                    }
                    k.push(' rowindex="' + i + '">');
                    $(g.headers).each(function (a, b) {
                        if (this.ischeckbox) {
                            k.push('<td class="l-grid-row-cell l-grid-row-cell-checkbox" style="width:' + this.width + 'px"><div class="l-grid-row-cell-inner"><span class="l-grid-row-cell-btn-checkbox"></span></div></td>');
                            return
                        } else {
                            if (this.isdetail) {
                                k.push('<td class="l-grid-row-cell l-grid-row-cell-detail" style="width:' + this.width + 'px"><div class="l-grid-row-cell-inner"><span class="l-grid-row-cell-detailbtn"></span></div></td>');
                                return
                            }
                        }
                        var c = p.columns[this.columnindex];
                        var d = this.width;
                        if (!this.islast) {
                            k.push('<td class="l-grid-row-cell" columnindex="' + this.columnindex + '" ')
                        } else {
                            k.push('<td class="l-grid-row-cell l-grid-row-cell-last" columnindex="' + this.columnindex + '" ')
                        }
                        if (this.columnname) {
                            k.push('columnname="' + this.columnname + '"')
                        }
                        k.push(' style = "');
                        k.push("width:" + d + 'px" ');
                        if (p.fixedCellHeight) {
                            k.push('><div class="l-grid-row-cell-inner l-grid-row-cell-inner-fixedheight" ')
                        } else {
                            k.push('><div class="l-grid-row-cell-inner" ')
                        }
                        k.push(' style = "width:' + parseInt(d) + "px; ");
                        if (c && c.align) {
                            k.push("text-align:" + c.align + ";")
                        }
                        var e = "";
                        if (c && c.render) {
                            e = c.render(h, i, h[this.columnname])
                        } else {
                            if (this.columnname) {
                                if (c.type && c.type == "date") {
                                    var f = p.renderDate(h[this.columnname]);
                                    h[this.columnname] = f;
                                    if (f != null) {
                                        if (c.format) {
                                            e = g.getFormatDate(f, c.format)
                                        } else {
                                            e = g.getFormatDate(f, p.dateFormat)
                                        }
                                    }
                                } else {
                                    e = h[this.columnname]
                                }
                            }
                        }
                        e = (typeof (e) == "undefined" ? "" : e);
                        k.push('">' + e + "</div></td>")
                    });
                    k.push("</tr>")
                });
                k.push("</tbody></table></div>");
                g.gridbody.html(k.join(""));
                g.bulidTotalSummary();
                $("> div:first", g.gridbody).width(g.gridtablewidth);
                g.onResize();
                $("tbody:first > .l-grid-row", g.gridbody).hover(function (e) {
                    if (!p.mouseoverRowCssClass) {
                        $(this).addClass(p.mouseoverRowCssClass)
                    }
                }, function () {
                    if (!p.mouseoverRowCssClass) {
                        $(this).removeClass(p.mouseoverRowCssClass)
                    }
                }).click(function (e) {
                    if (p.checkbox) {
                        var a = $(this);
                        var b = a.attr("rowindex");
                        var c = a.hasClass("l-checked");
                        if (p.onBeforeCheckRow) {
                            if (p.onBeforeCheckRow(!c, g.getRowByRowIndex(b), a, b) == false) {
                                return false
                            }
                        }
                        if (c) {
                            a.removeClass("l-checked")
                        } else {
                            a.addClass("l-checked")
                        }
                        p.onCheckRow && p.onCheckRow(!c, g.getRowByRowIndex(b), a, b);
                        return
                    }
                    var b = $(this).attr("rowindex");
                    if ($(this).hasClass("l-selected")) {
                        if (!p.allowUnSelectRow) {
                            $(this).addClass("l-selected-again");
                            return
                        }
                        $(this).removeClass("l-selected l-selected-again");
                        if (p.onUnSelectRow) {
                            p.onUnSelectRow(g.getRowByRowIndex(b), this, b)
                        }
                    } else {
                        $(this).siblings(".l-selected").each(function () {
                            if (p.allowUnSelectRow || $(this).hasClass("l-selected-again")) {
                                g.endEdit()
                            }
                            $(this).removeClass("l-selected l-selected-again")
                        });
                        $(this).addClass("l-selected");
                        if (p.onSelectRow) {
                            p.onSelectRow(g.getRowByRowIndex(b), this, b)
                        }
                    }
                }).dblclick(function () {
                    var a = $(this).attr("rowindex");
                    if (p.onDblClickRow) {
                        p.onDblClickRow(this, a, g.getRowByRowIndex(a))
                    }
                });
                if (p.onAfterShowData) {
                    p.onAfterShowData(t, j)
                }
                //遍历报表界面table，如果是小数点的后面几位是0，则去掉0（若条码为数字，则在td上加上样式名：.not-number）
                //$("table.l-grid-body-table tbody tr td:not(.not-number) div.l-grid-row-cell-inner").each(function () {
                //    var txt = $.trim($(this).html());
                //    if (txt != "" && /^(\-|\+)?\d+(\.\d+)?$/.test(txt)) {
                //        //$(this).text(parseFloat(txt));
                //        $(this).text(txt.replace(/(?<=\.\d*)0+$|\.0*$/, ""));
                //    }
                //});
            },
            applyEditor: function (c) {
                if (c.href || c.type) {
                    return true
                }
                var d;
                if ($(c).hasClass("l-grid-row-cell")) {
                    d = c
                } else {
                    if ($(c).parent().hasClass("l-grid-row-cell")) {
                        d = $(c).parent()[0]
                    }
                }
                if (!d) {
                    return
                }
                var f = $(d).parent();
                var h = $(f).attr("rowindex");
                var i = $(d).attr("columnindex");
                var j = $(d).attr("columnname");
                var k = p.columns[i];
                var l = $(d).offset().left - g.body.offset().left;
                var m = $(d).offset().top - $(t).offset().top + 2;
                var n = g.getRowByRowIndex(h);
                var o = n[j];
                g.grideditor.css({
                    left: l,
                    top: m,
                    width: $(d).css("width"),
                    height: $(d).css("height")
                }).html("");
                g.grideditor.editingCell = null;
                if (k.editor && k.editor.type == "date") {
                    var q = $("<input type='text'/>");
                    g.grideditor.append(q);
                    q.val(o);
                    q.SktMesDateEditor({
                        width: $(d).width(),
                        onChangeDate: function (a) {
                            g.grideditor.editingValue = a;
                            $(d).addClass("l-grid-row-cell-edited");
                            $(c).html(a);
                            g.updateData(d, a)
                        }
                    });
                    g.grideditor.editingCell = d;
                    g.grideditor.show()
                } else {
                    if (k.editor && k.editor.type == "select") {
                        var q = $("<input type='text'/>");
                        g.grideditor.append(q);
                        q.val(o);
                        var r = {
                            width: $(d).width(),
                            data: k.editor.data,
                            isMultiSelect: false,
                            onSelected: function (a, b) {
                                g.grideditor.editingValue = a;
                                $(d).addClass("l-grid-row-cell-edited");
                                if (k.editor.valueColumnName && j) {
                                    g.currentData[p.root][h][j] = b
                                }
                                g.updateData(d, a);
                                if (k.editor.render) {
                                    $(c).html(k.editor.render(g.currentData[p.root][h]))
                                } else {
                                    $(c).html(b)
                                }
                            }
                        };
                        if (k.editor.dataValueField) {
                            r.valueField = k.editor.dataValueField
                        }
                        if (k.editor.dataDisplayField) {
                            r.displayField = r.textField = k.editor.dataDisplayField
                        }
                        if (k.editor.valueColumnName) {
                            r.initValue = g.currentData[p.root][h][k.editor.valueColumnName]
                        } else {
                            if (j) {
                                r.initText = g.currentData[p.root][h][j]
                            }
                        }
                        q.SktMesComboBox(r);
                        g.grideditor.editingCell = d;
                        g.grideditor.show()
                    } else {
                        if (k.editor && k.editor.type == "int") {
                            var q = $("<input type='text'/>");
                            g.grideditor.append(q);
                            q.attr({
                                style: "border:#6E90BE"
                            }).val(o);
                            q.SktMesSpinner({
                                width: $(d).width(),
                                height: $(d).height(),
                                type: "int",
                                onChangeValue: function (a) {
                                    g.grideditor.editingValue = a;
                                    $(d).addClass("l-grid-row-cell-edited");
                                    $(c).html(a);
                                    g.updateData(d, a)
                                }
                            });
                            g.grideditor.editingCell = d;
                            g.grideditor.show()
                        } else {
                            if (k.editor && (k.editor.type == "string" || k.editor.type == "text")) {
                                var q = $("<input type='text' class='l-text-editing'/>");
                                g.grideditor.append(q);
                                q.val(o);
                                q.SktMesTextBox({
                                    width: $(d).width(),
                                    height: $(d).height(),
                                    onChangeValue: function (a) {
                                        g.grideditor.editingValue = a;
                                        $(d).addClass("l-grid-row-cell-edited");
                                        g.updateData(d, a);
                                        if (k.render) {
                                            $(c).html(k.render(g.currentData[p.root][h], h, g.currentData[p.root][h][j]))
                                        } else {
                                            $(c).html(a)
                                        }
                                    }
                                }).bind("keydown", function (e) {
                                    var a = e.which;
                                    if (a == 13) {
                                        q.trigger("change");
                                        g.endEdit()
                                    }
                                });
                                q.parent().addClass("l-text-editing");
                                g.grideditor.editingCell = d;
                                g.grideditor.show()
                            } else {
                                if (k.editor && (k.editor.type == "chk" || k.editor.type == "checkbox")) {
                                    var s = $("<input type='checkbox'/>");
                                    g.grideditor.append(s);
                                    s[0].checked = o == 1 ? true : false;
                                    s.SktMesCheckBox();
                                    s.change(function () {
                                        g.updateData(d, this.checked ? 1 : 0);
                                        if (k.render) {
                                            $(c).html(k.render(g.currentData[p.root][h], h, g.currentData[p.root][h][j]))
                                        } else {
                                            $(c).html(this.checked ? "Y" : "N")
                                        }
                                    });
                                    g.grideditor.editingCell = d;
                                    g.grideditor.show()
                                }
                            }
                        }
                    }
                }
            },
            endEdit: function () {
                var a = g.grideditor.editingCell;
                var b = g.grideditor.editingValue;
                g.grideditor.html("").hide();
                if (p.onAfterEdit) {
                    p.onAfterEdit(b, a)
                }
            },
            getFormatDate: function (a, b) {
                if (a == "NaN") {
                    return null
                }
                
                var c = b;
                var o = {
                    "M+": a.getMonth() + 1,
                    "d+": a.getDate(),
                    "h+": a.getHours(),
                    "H+": a.getHours(),
                    "m+": a.getMinutes(),
                    "s+": a.getSeconds(),
                    "q+": Math.floor((a.getMonth() + 3) / 3),
                    S: a.getMilliseconds()
                };
                if (/(y+)/.test(c)) {
                    c = c.replace(RegExp.$1, (a.getFullYear() + "").substr(4 - RegExp.$1.length))
                }
                for (var k in o) {
                    if (new RegExp("(" + k + ")").test(c)) {
                        c = c.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length))
                    }
                }
                return c
            },
            deleteSelectedRow: function () {
                var a = $(".l-selected", g.gridbody);
                g.deleteRow(a)
            },
            deleteRow: function (a) {
                g.popup.hide();
                g.endEdit();
                var b = a.attr("rowindex");
                $(a).remove();
                g.deleteData(b);
                g.isDataChanged = true
            },
            deleteData: function (a) {
                g.currentData[p.root][a][p.statusName] = "delete"
            },
            updateData: function (a, b) {
                var c = $(a).attr("columnindex");
                var d = p.columns[c];
                var e = d.name;
                var f = $(a).parents(".l-grid-row:eq(0)");
                var h = f.attr("rowindex");
                if (d.type && d.type == "int") {
                    g.currentData[p.root][h][e] = parseInt(b)
                } else {
                    if (d && d.editor && d.editor.type == "select") {
                        g.currentData[p.root][h][d.editor.valueColumnName ? d.editor.valueColumnName : e] = b
                    } else {
                        g.currentData[p.root][h][e] = b
                    }
                }
                if (g.currentData[p.root][h][p.statusName] == undefined) {
                    g.currentData[p.root][h][p.statusName] = "update"
                }
                g.isDataChanged = true
            },
            addRow: function () {
                var h = g.currentData[p.root].length;
                g.currentData[p.root][h] = {};
                var i = g.currentData[p.root][h];
                if (!p.usePager && !g.isTotalSummary()) {
                    $("tbody:first > .l-grid-row:last", g.gridbody).removeClass("l-grid-row-last")
                }
                var j = $("<tr class='l-grid-row' rowindex='" + h + "'></tr>");
                $("tbody:first", g.gridbody).append(j);
                if (!p.usePager && !g.isTotalSummary()) {
                    j.addClass("l-grid-row-last")
                }
                var k = $("tr > .l-grid-hd-cell", g.gridheader).length;
                $("tr > .l-grid-hd-cell", g.gridheader).each(function (a, b) {
                    var c = $(b).attr("columnname");
                    var d = $(b).attr("columnindex");
                    var e = p.columns[d];
                    var f = $("<td class='l-grid-row-cell' columnindex='" + d + "'><div class='l-grid-row-cell-inner'></div></td>");
                    if (k == a + 1) {
                        f.addClass("l-grid-row-cell-last")
                    }
                    if (c) {
                        i[c] = "";
                        if (e.type && e.type == "int") {
                            i[c] = 0
                        }
                        f.attr({
                            columnname: c
                        })
                    }
                    $(".l-grid-row-cell-inner", f).html(i[c]);
                    j.append(f);
                    f.css("width", $(b).css("width"));
                    if (e.align) {
                        $(".l-grid-row-cell-inner", f).css({
                            textAlign: e.align
                        })
                    }
                    if ($(b).is(":visible") == false) {
                        f.hide()
                    }
                });
                i[p.statusName] = "add";
                j.click(function (e) {
                    $(this).siblings(".l-selected").removeClass("l-selected");
                    $(this).addClass("l-selected")
                }).hover(function () {
                    $(this).addClass("l-grid-row-over")
                }, function () {
                    $(this).removeClass("l-grid-row-over")
                });
                g.isDataChanged = true
            },
            getData: function () {
                if (g.currentData == null) {
                    return null
                }
                return g.currentData[p.root]
            },
            getCurrentPageData: function (a) {
                var b = {
                    Rows: new Array(),
                    Total: 0
                };
                try {
                    b[p.record] = a[p.root].length;
                    if (!p.newPage) {
                        p.newPage = 1
                    }
                    for (i = (p.newPage - 1) * p.pageSize; i < a[p.root].length && i < p.newPage * p.pageSize; i++) {
                        var c = $.extend({}, a[p.root][i]);
                        b[p.root].push(c)
                    }
                } catch (ex) { }
                return b
            },
            getColumn: function (a) {
                for (i = 0; i < p.columns.length; i++) {
                    if (p.columns[i].name == a) {
                        return p.columns[i]
                    }
                }
                return null
            },
            getColumnType: function (a) {
                for (i = 0; i < p.columns.length; i++) {
                    if (p.columns[i].name == a) {
                        if (p.columns[i].type) {
                            return p.columns[i].type
                        }
                        return "string"
                    }
                }
                return null
            },
            compareData: function (a, b, c, d) {
                switch (d) {
                    case "int":
                        return parseInt(a[c]) < parseInt(b[c]) ? -1 : parseInt(a[c]) > parseInt(b[c]) ? 1 : 0;
                    case "float":
                        return parseFloat(a[c]) < parseFloat(b[c]) ? -1 : parseFloat(a[c]) > parseFloat(b[c]) ? 1 : 0;
                    case "string":
                        return a[c].localeCompare(b[c]);
                    case "date":
                        return a[c] < b[c] ? -1 : a[c] > b[c] ? 1 : 0
                }
                return a[c].localeCompare(b[c])
            },
            isTotalSummary: function () {
                for (var i = 0; i < p.columns.length; i++) {
                    if (p.columns[i].totalSummary) {
                        return true
                    }
                }
                return false
            },
            bulidTotalSummary: function () {
                if (!g.isTotalSummary()) {
                    return false
                }
                if (!g.currentData || g.currentData[p.root].length == 0) {
                    return false
                }
                if (g.gridbody.totalsummary) {
                    g.gridbody.totalsummary.remove()
                }
                g.gridbody.totalsummary = $("<tr class='l-grid-totalsummary'></tr>");
                if (!p.usePager) {
                    g.gridbody.totalsummary.addClass("l-grid-totalsummary-nobottom")
                }
                $("tbody:first", g.gridbody).append(g.gridbody.totalsummary);
                $(g.headers).each(function () {
                    var b = $("<td class='l-grid-totalsummary-cell'><div class='l-grid-totalsummary-cell-inner'></div></td>");
                    g.gridbody.totalsummary.append(b);
                    b.css("width", this.width);
                    if (this.islast) {
                        b.addClass("l-grid-totalsummary-cell-last")
                    }
                    columnname = this.columnname;
                    columnindex = this.columnindex;
                    if (columnname) {
                        $("div:first", b).attr({
                            columnname: columnname
                        })
                    }
                    if (!columnindex) {
                        return
                    }
                    b.attr({
                        columnindex: columnindex
                    });
                    var c = p.columns[columnindex];
                    if (c.align) {
                        $(".l-grid-totalsummary-cell-inner", b).css({
                            textAlign: c.align
                        })
                    }
                    if (c.totalSummary) {
                        var d = function (a) {
                            for (var i = 0; i < l.length; i++) {
                                if (l[i].toLowerCase() == a.toLowerCase()) {
                                    return true
                                }
                            }
                            return false
                        };
                        var e = 0,
							count = 0,
							avg = 0;
                        var f = parseFloat(g.currentData[p.root][0][c.name]);
                        var h = parseFloat(g.currentData[p.root][0][c.name]);
                        for (var i = 0; i < g.currentData[p.root].length; i++) {
                            var j = parseFloat(g.currentData[p.root][i][c.name]);
                            e += j;
                            count += 1;
                            if (j > f) {
                                f = j
                            }
                            if (j < h) {
                                h = j
                            }
                        }
                        avg = e * 1 / g.currentData[p.root].length;
                        if (c.totalSummary.render) {
                            var k = c.totalSummary.render({
                                sum: e,
                                count: count,
                                avg: avg,
                                min: h,
                                max: f
                            }, c, b);
                            $(".l-grid-totalsummary-cell-inner:first", b).append(k)
                        } else {
                            if (c.totalSummary.type) {
                                var l = c.totalSummary.type.split(",");
                                if (d("sum")) {
                                    $(".l-grid-totalsummary-cell-inner:first", b).append("<div>Sum=" + e.toFixed(2) + "</div>")
                                }
                                if (d("count")) {
                                    $(".l-grid-totalsummary-cell-inner:first", b).append("<div>Count=" + count + "</div>")
                                }
                                if (d("max")) {
                                    $(".l-grid-totalsummary-cell-inner:first", b).append("<div>Max=" + f.toFixed(2) + "</div>")
                                }
                                if (d("min")) {
                                    $(".l-grid-totalsummary-cell-inner:first", b).append("<div>Min=" + h.toFixed(2) + "</div>")
                                }
                                if (d("avg")) {
                                    $(".l-grid-totalsummary-cell-inner:first", b).append("<div>Avg=" + avg.toFixed(2) + "</div>")
                                }
                            }
                        }
                        if (c.totalSummary.align) {
                            $(".l-grid-totalsummary-cell-inner:first", b).css("textAlign", c.totalSummary.align)
                        }
                    }
                })
            },
            changeSort: function (c, d) {
                try {
                    if (this.loading) {
                        return true
                    }
                    if (p.dataAction == "PROC" && p.isProcPage !=true) {
                        var e = g.getColumnType(c);
                        if (!g.sortedData) {
                            g.sortedData = $.extend({}, g.data)
                        }
                        if (p.sortName == c) {
                            g.sortedData[p.root].reverse()
                        } else {
                            g.sortedData[p.root].sort(function (a, b) {
                                return g.compareData(a, b, c, e)
                            })
                        }
                        if (p.usePager) {
                            g.currentData = g.getCurrentPageData(g.sortedData)
                        } else {
                            g.currentData = g.sortedData
                        }
                        g.showData(g.currentData)
                    }
                    p.sortName = c;
                    p.sortOrder = d;
                    if (p.dataAction == "TABLE" || p.isProcPage==true) {
                        g.loadData()
                    }
                } catch (ex) { }
            },
            changePage: function (a) {
                if (this.loading) {
                    return true
                }
                if (g.isDataChanged && !confirm(p.isContinueByDataChanged)) {
                    return false
                }
                switch (a) {
                    case "first":
                        if (p.page == 1) {
                            return
                        }
                        p.newPage = 1;
                        break;
                    case "prev":
                        if (p.page == 1) {
                            return
                        }
                        if (p.page > 1) {
                            p.newPage = parseInt(p.page) - 1
                        }
                        break;
                    case "next":
                        if (p.page >= p.pageCount) {
                            return
                        }
                        p.newPage = parseInt(p.page) + 1;
                        break;
                    case "last":
                        if (p.page >= p.pageCount) {
                            return
                        }
                        p.newPage = p.pageCount;
                        break;
                    case "input":
                        var b = parseInt($(".pcontrol input", this.toolbar).val());
                        if (isNaN(b)) {
                            b = 1
                        }
                        if (b < 1) {
                            b = 1
                        } else {
                            if (b > p.pageCount) {
                                b = p.pageCount
                            }
                        }
                        $(".pcontrol input", this.toolbar).val(b);
                        p.newPage = b;
                        break
                }
                if (p.newPage == p.page) {
                    return false
                }
                if (p.newPage == 1) {
                    $(".l-bar-btnfirst span", g.toolbar).addClass("l-disabled");
                    $(".l-bar-btnprev span", g.toolbar).addClass("l-disabled")
                } else {
                    $(".l-bar-btnfirst span", g.toolbar).removeClass("l-disabled");
                    $(".l-bar-btnprev span", g.toolbar).removeClass("l-disabled")
                }
                if (p.newPage == p.pageCount) {
                    $(".l-bar-btnlast span", g.toolbar).addClass("l-disabled");
                    $(".l-bar-btnnext span", g.toolbar).addClass("l-disabled")
                } else {
                    $(".l-bar-btnlast span", g.toolbar).removeClass("l-disabled");
                    $(".l-bar-btnnext span", g.toolbar).removeClass("l-disabled")
                }
                if (p.onChangePage) {
                    p.onChangePage(p.newPage)
                }
                if (p.dataAction == "TABLE" ||  p.isProcPage==true) {
                    this.loadData()
                } else {
                    g.currentData = g.getCurrentPageData(g.data);
                    g.showData(g.currentData)
                }
            },
            buildPager: function () {
                $(".pcontrol input", this.toolbar).val(p.page);
                $(".pcontrol span", this.toolbar).html(p.pageCount);
                var a = parseInt((p.page - 1) * p.pageSize) + 1;
                var b = parseInt(a) + parseInt(p.pageSize) - 1;
                if (p.total < b) {
                    b = p.total
                }
                var c = p.pageStatMessage;
                c = c.replace(/{from}/, a);
                c = c.replace(/{to}/, b);
                c = c.replace(/{total}/, p.total);
                $(".l-bar-text", this.toolbar).html(c);
                if (p.page == 1) {
                    $(".l-bar-btnfirst span", g.toolbar).addClass("l-disabled");
                    $(".l-bar-btnprev span", g.toolbar).addClass("l-disabled")
                } else {
                    $(".l-bar-btnfirst span", g.toolbar).removeClass("l-disabled");
                    $(".l-bar-btnprev span", g.toolbar).removeClass("l-disabled")
                }
                if (p.page == p.pageCount) {
                    $(".l-bar-btnlast span", g.toolbar).addClass("l-disabled");
                    $(".l-bar-btnnext span", g.toolbar).addClass("l-disabled")
                } else {
                    $(".l-bar-btnlast span", g.toolbar).removeClass("l-disabled");
                    $(".l-bar-btnnext span", g.toolbar).removeClass("l-disabled")
                }
            },
            getCheckedRows: function () {
                var c = $("tbody:first > .l-checked", g.gridbody);
                var d = [];
                $("tbody:first > .l-checked", g.gridbody).each(function (i, a) {
                    var b = $(a).attr("rowindex");
                    d.push(g.getRowByRowIndex(parseInt(b)))
                });
                return d
            },
            getSelectedRow: function () {
                var a = $("tbody:first > .l-selected", g.gridbody);
                var b = a.attr("rowindex");
                return g.getRowByRowIndex(parseInt(b))
            },
            getRowByRowIndex: function (a) {
                if (g.currentData == null) {
                    return null
                }
                return g.currentData[p.root][a]
            },
            onResize: function () {
                if (p.height && p.height != "auto") {
                    var a = $(window).height();
                    var h = 0;
                    var b = null;
                    if (typeof (p.height) == "string" && p.height.indexOf("%") > 0) {
                        var c = $(t).parent();
                        if (p.InWindow || c[0].tagName.toLowerCase() == "body") {
                            b = a;
                            b -= parseInt($("body").css("paddingTop"));
                            b -= parseInt($("body").css("paddingBottom"))
                        } else {
                            b = c.height()
                        }
                        h = b * parseFloat(p.height) * 0.01;
                        if (p.InWindow || c[0].tagName.toLowerCase() == "body") {
                            h -= ($(t).offset().top - parseInt($("body").css("paddingTop")))
                        }
                    } else {
                        h = parseInt(p.height)
                    }
                    h += p.heightDiff;
                    g.windowHeight = a;
                    g.setHeight(h)
                }
            },
            setHeight: function (h) {
                if (p.title) {
                    h -= 24
                }
                if (p.usePager) {
                    h -= 32
                }
                h -= 22;
                h > 0 && g.gridbody.height(h)
            },
            dragStart: function (a, e, b) {
                if (a == "colresize") {
                    var c = g.headers[g.toDragHeaderIndex].columnindex;
                    var d = g.headers[g.toDragHeaderIndex].width;
                    if (c == undefined) {
                        return
                    }
                    g.colresize = {
                        startX: e.pageX,
                        width: d,
                        columnindex: c
                    };
                    $("body").css("cursor", "e-resize");
                    g.draggingline.css({
                        height: g.body.height(),
                        left: e.pageX - $(t).offset().left + parseInt(g.body[0].scrollLeft),
                        top: 0
                    }).show();
                    $("body").bind("selectstart", function () {
                        return false
                    })
                }
                $.fn.SktMesNoSelect && $("body").SktMesNoSelect()
            },
            dragMove: function (e) {
                if (g.colresize) {
                    var a = e.pageX - g.colresize.startX;
                    var b = g.colresize.width + a;
                    g.colresize.newwidth = b;
                    $("body").css("cursor", "e-resize");
                    g.draggingline.css({
                        left: e.pageX - $(t).offset().left + parseInt(g.body[0].scrollLeft)
                    });
                    $("body").unbind("selectstart")
                }
            },
            dragEnd: function (e) {
                if (g.colresize) {
                    if (g.colresize.newwidth == undefined) {
                        $("body").css("cursor", "default");
                        return false
                    }
                    var a = 50;
                    var b = g.colresize.columnindex;
                    var c = p.columns[b];
                    if (c && c.minWidth) {
                        a = c.minWidth
                    }
                    var d = g.colresize.newwidth;
                    d = d < a ? a : d;
                    var f = d - g.colresize.width;
                    g.headers[g.toDragHeaderIndex].width += f;
                    g.gridtablewidth += f;
                    $("div:first", g.gridheader).width(g.gridtablewidth + 40);
                    $("div:first", g.gridbody).width(g.gridtablewidth);
                    //modify by yz.xiong  2021-07-07 修改长度时单元格内的div也一起修改
                    $(".l-grid-hd-cell[columnindex=" + b + "]", this.gridheader).css("width", d);
                    $(".l-grid-hd-cell[columnindex=" + b + "] div:first", this.gridheader).css("width", d);
                    $("tbody:first > .l-grid-row > td[columnindex=" + b + "],tbody:first > .l-grid-totalsummary > td[columnindex=" + b + "]", this.gridbody).each(function () {
                        $(this).css("width", d);
                        $("div:first", this).css("width", d)
                    });
                    g.onResize();
                    g.draggingline.hide();
                    g.colresize = false
                }
                $("body").css("cursor", "default");
                $.fn.SktMesNoSelect && $("body").SktMesNoSelect(false)
            },
            onClick: function (e) {
                var a = (e.target || e.srcElement);
                var b = a.tagName.toLowerCase();
                if (g.grideditor.editingCell) {
                    if (b == "html" || b == "body" || $(a).hasClass("l-grid-body") || $(a).hasClass("l-grid-row")) {
                        g.endEdit()
                    }
                }
                if (p.allowHideColumn) {
                    if (b == "html" || b == "body" || $(a).hasClass("l-grid-body") || $(a).hasClass("l-grid-row") || $(a).hasClass("l-grid-row-cell-inner") || $(a).hasClass("l-grid-header")) {
                        g.popup.hide()
                    }
                }
            },
            toggleCol: function (a, b) {
                var c = $(".l-grid-hd-cell[columnindex='" + a + "']", this.gridheader);
                if (!c) {
                    return
                }
                if (b) {
                    c.show();
                    $(".l-grid-row-cell[columnindex='" + a + "']", this.gridbody).show()
                } else {
                    c.hide();
                    $(".l-grid-row-cell[columnindex='" + a + "']", this.gridbody).hide()
                }
            }
        };
        g.header = $(".l-panel-header:first", t);
        g.body = $(".l-panel-body:first", t);
        g.toolbar = $(".l-panel-bar:first", t);
        g.popup = $(".l-grid-popup:first", t);
        g.grideditor = $(".l-grid-editor:first", t);
        g.gridloading = $(".l-grid-loading:first", t);
        g.draggingline = $(".l-grid-dragging-line", t);
        g.gridheader = $(".l-grid-header:first", t);
        g.gridbody = $(".l-grid-body:first", t);
        g.currentData = null;
        p.cssClass && $(t).addClass(p.cssClass);
        if (p.title) {
            $(".l-panel-header-text", g.header).html(p.title)
        } else {
            g.header.hide()
        }
        g.headers = [];
        g.gridtablewidth = 0;
        if (p.checkbox) {
            var v = $("<td class='l-grid-hd-cell l-grid-hd-cell-checkbox'><div class='l-grid-hd-cell-inner'><div class='l-grid-hd-cell-text l-grid-hd-cell-btn-checkbox'></div></td>");
            v.css({
                width: 27
            });
            $("tr:first", g.gridheader).append(v);
            g.headers.push({
                width: 27,
                ischeckbox: true
            });
            g.gridtablewidth += 28
        }
        if (p.detail && p.detail.onShowDetail) {
            var w = $("<td class='l-grid-hd-cell l-grid-hd-cell-detail'><div class='l-grid-hd-cell-inner'><div class='l-grid-hd-cell-text'></div></td>");
            w.css({
                width: 29
            });
            $("tr:first", g.gridheader).append(w);
            g.headers.push({
                width: 29,
                isdetail: true
            });
            g.gridtablewidth += 30
        }
        $(p.columns).each(function (i, a) {
            var b = $("<td class='l-grid-hd-cell' columnindex='" + i + "'><div class='l-grid-hd-cell-inner'><span class='l-grid-hd-cell-text'> </span></div></td>");
            if (i == p.columns.length - 1) {
                b.addClass("l-grid-hd-cell-last")
            }
            if (a.name) {
                b.attr({
                    columnname: a.name
                })
            }
            if (a.isSort != undefined) {
                b.attr({
                    isSort: a.isSort
                })
            }
            if (a.isAllowHide != undefined) {
                b.attr({
                    isAllowHide: a.isAllowHide
                })
            }
            var c = "";
            if (a.display && a.display != "") {
                c = a.display
            } else {
                if (a.headerRender) {
                    c = a.headerRender(a)
                } else {
                    c = "&nbsp;"
                }
            }
            $(".l-grid-hd-cell-text", b).html(c);
            $("tr:first", g.gridheader).append(b);
            var d = a.width;
            if (a.minWidth) {
                if (a.width && a.width > a.minWidth) {
                    d = a.width
                } else {
                    d = a.minWidth
                }
            } else {
                if (a.width) {
                    d = a.width
                } else {
                    if (p.columnWidth) {
                        d = p.columnWidth
                    }
                }
            }
            g.gridtablewidth += d + 1;
            b.width(d);
            //出现滚动条时，最后列加上默认滚动条的大小40px（处理谷歌和IE横向滚动条兼容问题）
            if (i == p.columns.length - 1 && g.gridtablewidth > g.gridbody.width()) {
                b.find(".l-grid-hd-cell-inner").width(d + 40);
            }
            else {
                b.find(".l-grid-hd-cell-inner").width(d);
            }
            
            g.headers.push({
                width: d,
                columnname: a.name,
                columnindex: i,
                islast: i == p.columns.length - 1,
                isdetail: false
            })
        });
        $("div:first", g.gridheader).width(g.gridtablewidth + 40);
        $("tr:first .l-grid-hd-cell", g.gridheader).each(function (i, a) {
            if ($(this).hasClass("l-grid-hd-cell-detail")) {
                return
            }
            var b = $(this).attr("isAllowHide");
            if (b != undefined && b.toLowerCase() == "false") {
                return
            }
            var c = 'checked="checked"';
            var d = $(this).attr("columnindex");
            var e = $(this).attr("columnname");
            if (!d || !e) {
                return
            }
            var f = $(".l-grid-hd-cell-text", this).html();
            if (this.style.display == "none") {
                c = ""
            }
            $("tbody", g.popup).append('<tr><td class="l-column-left"><input type="checkbox" ' + c + ' class="l-checkbox" columnindex="' + d + '"/></td><td class="l-column-right">' + f + "</td></tr>")
        });
        $.fn.SktMesCheckBox && $("input:checkbox", g.popup).SktMesCheckBox({
            onBeforeClick: function (a) {
                if (!a.checked) {
                    return true
                }
                if ($("input:checked", g.popup).length <= p.minColToggle) {
                    return false
                }
                return true
            }
        });
        $(".l-grid-hd-cell", g.gridheader).bind("contextmenu", function (e) {
            if (g.colresize) {
                return true
            }
            if (!p.allowHideColumn) {
                return true
            }
            var a = $(this).attr("columnindex");
            if (a == undefined) {
                return true
            }
            var b = (e.pageX - g.body.offset().left + parseInt(g.body[0].scrollLeft));
            if (a == p.columns.length - 1) {
                b -= 80
            }
            g.popup.css({
                left: b,
                top: g.gridheader.height() + 1
            });
            g.popup.toggle();
            return false
        });
        if (p.isScroll == false) {
            p.height = "auto"
        }
        if (p.height == "auto") {
            g.gridbody.height("auto")
        }
        if (p.width) {
            $(t).width(p.width)
        }
        g.onResize();
        g.loadData();
        if (p.usePager) {
            var x = "";
            var y = -1;
            $(p.pageSizeOptions).each(function (i, a) {
                var b = "";
                if (p.pageSize == a) {
                    y = i
                }
                x += "<option value='" + a + "' " + b + " >" + a + "</option>"
            });
            $(".l-bar-selectpagesize", g.toolbar).append("<select name='rp'>" + x + "</select>");
            if (y != -1) {
                $(".l-bar-selectpagesize select", g.toolbar)[0].selectedIndex = y
            }
            if (p.switchPageSizeApplyComboBox && $.fn.SktMesComboBox) {
                $(".l-bar-selectpagesize select", g.toolbar).SktMesComboBox({
                    onBeforeSelect: function () {
                        if (g.isDataChanged && !confirm(p.isContinueByDataChanged)) {
                            return false
                        }
                        return true
                    },
                    width: 45
                })
            }
        } else {
            g.toolbar.hide()
        }
        g.gridloading.html(p.loadingMessage);
        g.header.click(function () {
            g.popup.hide();
            g.endEdit()
        });
        $(".l-grid-hd-cell", g.gridheader).hover(function () { }, function () { }).mousedown(function (e) {
            if (g.colresize) {
                return false
            }
        });
        $(".l-grid-hd-cell-text", g.gridheader).click(function (e) {
            var a = (e.target || e.srcElement);
            var b = $(this).parent().parent();
            if (!b.attr("columnname")) {
                return
            }
            if (g.colresize) {
                return false
            }
            if (!p.enabledSort) {
                return
            }
            if (b.attr("isSort") != undefined && b.attr("isSort").toLowerCase() == "false") {
                return
            }
            if (g.isDataChanged && !confirm(p.isContinueByDataChanged)) {
                return false
            }
            var c = $(".l-grid-hd-cell-sort", b);
            var d = $(b).attr("columnname");
            if (c.length > 0) {
                if (c.hasClass("l-grid-hd-cell-sort-asc")) {
                    c.removeClass("l-grid-hd-cell-sort-asc").addClass("l-grid-hd-cell-sort-desc");
                    b.removeClass("l-grid-hd-cell-asc").addClass("l-grid-hd-cell-desc");
                    g.changeSort(d, "desc")
                } else {
                    if (c.hasClass("l-grid-hd-cell-sort-desc")) {
                        c.removeClass("l-grid-hd-cell-sort-desc").addClass("l-grid-hd-cell-sort-asc");
                        b.removeClass("l-grid-hd-cell-desc").addClass("l-grid-hd-cell-asc");
                        g.changeSort(d, "asc")
                    }
                }
            } else {
                b.removeClass("l-grid-hd-cell-desc").addClass("l-grid-hd-cell-asc");
                $(this).after("<span class='l-grid-hd-cell-sort l-grid-hd-cell-sort-asc'>&nbsp;&nbsp;</span>");
                g.changeSort(d, "asc")
            }
            $(".l-grid-hd-cell-sort", b.siblings()).remove();
            return false
        });
        g.gridheader.click(function () {
            g.endEdit()
        });
        if (p.allowAdjustColWidth) {
            g.gridheader.mousemove(function (e) {
                if (g.colresize) {
                    return
                }
                var a = e.pageX - $(t).offset().left;
                var b = 0;
                for (var i = 0; i < g.headers.length; i++) {
                    if (g.headers[i].width) {
                        b += g.headers[i].width + 1
                    }
                    if (g.headers[i].isdetail || g.headers[i].ischeckbox) {
                        continue
                    }
                    if (a >= b - 2 - g.gridbody[0].scrollLeft && a <= b + 2 - g.gridbody[0].scrollLeft) {
                        $("body").css({
                            cursor: "e-resize"
                        });
                        g.toDragHeaderIndex = i;
                        return
                    }
                }
                $("body").css({
                    cursor: "default"
                });
                g.toDragHeaderIndex = null
            }).mouseout(function (e) {
                if (g.colresize) {
                    return
                }
                $("body").css({
                    cursor: "default"
                })
            }).mousedown(function (e) {
                if (g.colresize) {
                    return
                }
                if (g.toDragHeaderIndex == null) {
                    return
                }
                g.dragStart("colresize", e, g.toDragHeaderIndex)
            })
        }
        if (p.allowHideColumn) {
            $("tr", g.popup).hover(function () {
                $(this).addClass("l-popup-row-over")
            }, function () {
                $(this).removeClass("l-popup-row-over")
            });
            var z = function () {
                if ($("input:checked", g.popup).length + 1 <= p.minColToggle) {
                    return false
                }
                g.toggleCol($(this).attr("columnindex"), this.checked)
            };
            if ($.fn.SktMesCheckBox) {
                $(":checkbox", g.popup).change(z)
            } else {
                $(":checkbox", g.popup).click(z)
            }
        }
        g.gridbody.scroll(function () {
            var a = g.gridbody.scrollLeft();
            if (a == undefined) {
                return
            }
            g.gridheader[0].scrollLeft = a
        });
        $(t).click(function (e) {
            var a = (e.target || e.srcElement);
            if (a.tagName.toLowerCase() == "span" && $(a).hasClass("l-grid-row-cell-detailbtn")) {
                var b = $(a).parent().parent().parent();
                if (b.parent().parent()[0] != $("table:first", g.gridbody)[0]) {
                    return
                }
                var c = parseInt($(b).attr("rowindex"));
                var d = g.currentData[p.root][c];
                if ($(a).hasClass("l-open")) {
                    b.next(".l-grid-detailpanel").remove();
                    $(a).removeClass("l-open")
                } else {
                    var f = $("<tr class='l-grid-detailpanel'><td><div class='l-grid-detailpanel-inner' style='display:none'></div></td></tr>");
                    var h = $("div:first", f);
                    h.width(g.gridtablewidth - 1);
                    h.parent().attr("colSpan", g.headers.length).width(g.gridtablewidth - 1);
                    b.after(f);
                    if (p.detail.onShowDetail) {
                        p.detail.onShowDetail(d, h[0]);
                        h.show()
                    } else {
                        if (p.detail.render) {
                            h.append(p.detail.render());
                            h.show()
                        }
                    }
                    $(a).addClass("l-open")
                }
                return
            }
            if (a.tagName.toLowerCase() == "div" && $(a).hasClass("l-grid-hd-cell-btn-checkbox")) {
                var b = $(a).parent().parent().parent();
                var i = b.hasClass("l-checked");
                if (p.onBeforeCheckAllRow) {
                    if (p.onBeforeCheckAllRow(!i, t) == false) {
                        return false
                    }
                }
                if (i) {
                    b.removeClass("l-checked");
                    $("tbody:first > tr", g.gridbody).removeClass("l-checked")
                } else {
                    b.addClass("l-checked");
                    $("tbody:first > tr", g.gridbody).addClass("l-checked")
                }
                p.onCheckAllRow && p.onCheckAllRow(!i, t)
            }
            if (a.tagName.toLowerCase() == "div" || $(a).hasClass("l-grid-row-cell-inner") || $(a).hasClass("l-grid-row-cell")) {
                if (p.enabledEdit && !p.dblClickToEdit) {
                    var b = null;
                    if ($(a).hasClass("l-grid-row-cell")) {
                        b = $(a).parent()
                    } else {
                        b = $(a).parent().parent()
                    }
                    if (p.allowUnSelectRow || b.hasClass("l-selected-again")) {
                        g.applyEditor(a)
                    }
                }
            }
        });
        $("select", g.toolbar).change(function () {
            if (g.isDataChanged && !confirm(p.isContinueByDataChanged)) {
                return false
            }
            p.newPage = 1;
            p.pageSize = this.value;
            g.loadData()
        });
        $(".pcontrol input", g.toolbar).keydown(function (e) {
            if (e.keyCode == 13) {
                g.changePage("input")
            }
        });
        $(".l-bar-button", g.toolbar).hover(function () {
            $(this).addClass("l-bar-button-over")
        }, function () {
            $(this).removeClass("l-bar-button-over")
        }).click(function () {
            if ($(this).hasClass("l-bar-btnfirst")) {
                if (p.onToFirst && p.onToFirst(t) == false) {
                    return false
                }
                g.changePage("first")
            } else {
                if ($(this).hasClass("l-bar-btnprev")) {
                    if (p.onToPrev && p.onToPrev(t) == false) {
                        return false
                    }
                    g.changePage("prev")
                } else {
                    if ($(this).hasClass("l-bar-btnnext")) {
                        if (p.onToNext && p.onToNext(t) == false) {
                            return false
                        }
                        g.changePage("next")
                    } else {
                        if ($(this).hasClass("l-bar-btnlast")) {
                            if (p.onToLast && p.onToLast(t) == false) {
                                return false
                            }
                            g.changePage("last")
                        } else {
                            if ($(this).hasClass("l-bar-btnload")) {
                                if ($("span", this).hasClass("l-disabled")) {
                                    return false
                                }
                                if (p.onReload && p.onReload(t) == false) {
                                    return false
                                }
                                if (g.isDataChanged && !confirm(p.isContinueByDataChanged)) {
                                    return false
                                }
                                g.loadData()
                            }
                        }
                    }
                }
            }
        });
        g.toolbar.click(function () {
            g.popup.hide();
            g.endEdit()
        });
        $(document).mousemove(function (e) {
            g.dragMove(e)
        }).mouseup(function (e) {
            g.dragEnd()
        }).hover(function () { }, function () {
            g.dragEnd()
        }).click(function (e) {
            g.onClick(e)
        });
        if (t.id == undefined) {
            t.id = "SktMesUI_" + new Date().getTime()
        }
        SktMesUIManagers[t.id + "_Grid"] = g;
        t.usedGrid = true;
        $(window).resize(function () {
            g.onResize()
        })
    };
    $.SktMesGridSetParms = function (p, a) {
        p = $.extend({}, $.SktMesDefaults.Grid, $.SktMesDefaults.GridString, p || {});       
        if (p.dataSource && p.data) {
            p.dataType = "local"
        } else {
            if (p.dataSource && !p.data) {
                p.dataType = "server"
            } else {
                if (!p.dataSource && p.data) {
                    p.dataType = "local"
                } else {
                    if (!p.dataSource && !p.data) {
                        p.dataType = "local";
                        p.data = []
                    }
                }
            }
        }
        if (p.dataType == "local") {
            p.dataAction = "PROC"
        }
        if (a) {
            p = $.extend(p, a)
        }
        return p
    };
    $.fn.SktMesGrid = function (p) {
        var a = {};
        p = p || {};
        p = $.SktMesGridSetParms(p, a);
        this.each(function () {
            $.SktMesAddGrid(this, p)
        });
        if (this.length == 0) {
            return null
        }
        if (this.length == 1) {
            return $(this[0]).SktMesGetGridManager()
        }
        var b = [];
        this.each(function () {
            b.push($(this).SktMesGetGridManager())
        });
        return b
    }
})(jQuery);