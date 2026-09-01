/****************************************************************************
*  Author: Alen Liu
*  Create Datetime: 2014-01-10
*  Desc: 列表js功能
*  Version: 1.0.0
*  Email: shzalen@163.com
****************************************************************************/

var isChkClk = false;
var isDblClick = false;
var needAlertForGetRecordId = true;
var selectedRecordId = -1;
var selectedRowCount = 0;


/*鼠标经过时*/
$(function () {
    $(".ListTableOddRow,.ListTableEvenRow,.ListTableSelectedRow").hover(
        function () {
            oldBg = $(this).attr("class");
            $(this).removeClass(oldBg);
            $(this).addClass("ListTableHoverRow");
        },
        function () {
            /*debug: 修正当本行被选中时鼠标移开后行颜色不能恢复的问题*/
            $(this).removeClass("ListTableHoverRow");
            try {
                if ($(this).find("input[type=\"checkbox\"]:checked").length > 0) {
                    this.className = "ListTableSelectedRow";
                } else {
                    this.className = ((this.rowIndex % 2 == 1) ? "ListTableOddRow" : "ListTableEvenRow");
                }
                /*
                var ckb = this.cells[0].children[0]
                if (!ckb.checked) {
                    this.className = ((this.rowIndex % 2 == 1) ? "ListTableOddRow" : "ListTableEvenRow");
                }
                else {
                    this.className = "ListTableSelectedRow";
                }
                */
            } catch (ex) { }
        });
});

function onMi(obj) {
    oldBg = $(obj).attr("class");
    $(obj).removeClass(oldBg);
    $(obj).addClass("ListTableHoverRow");
}

function onMo(obj) {
    $(obj).removeClass("ListTableHoverRow");
    var ckb = obj.cells[0].children[0]
    if (!ckb.checked) {
        obj.className = ((obj.rowIndex % 2 == 1) ? "ListTableOddRow" : "ListTableEvenRow");
    }
    else {
        obj.className = "ListTableSelectedRow";
    }
}

function mi(obj) {
    //currentRowIndex = row.rowIndex;
    oldBg = $(obj).attr("class");
    $(obj).removeClass(oldBg);
    $(obj).addClass("ListTableHoverRow");
}

function mo(obj) {
    $(obj).removeClass("ListTableHoverRow");
    var ckb = obj.cells[0].children[0]
    if (!ckb.checked) {
        obj.className = ((obj.rowIndex % 2 == 1) ? "ListTableOddRow" : "ListTableEvenRow");
    }
    else {
        obj.className = "ListTableSelectedRow";
    }
}


/*单击选择框事件*/
function chkClk(chk) {
    try {
        isChkClk = true;
        operateRow(chk.parentElement.parentElement);
    }
    catch (ex) {
    }
}

/*单击行事件*/
function clk(row) {
    if (isChkClk) {
        isChkClk = false;
        return;
    }
    if (isDblClick) {
        isDblClick = false;
        return;
    }

    var chk = row.cells[0].children[0];
    if (isMultiple)
        chk.checked = !chk.checked;
    else
        chk.checked = !chk.checked;
    operateRow(row);
}

/*双击行事件*/
function dblClk(row) {
    isDblClick = true;
    var chk = row.cells[0].children[0];
    if (isMultiple) {
        checkAll(false);
        if (chk.checked) {
            selectedRowCount--;
        }
    }

    chk.checked = true;
    operateRow(row);
    /*  Modify By: Alen Liu 
        Modify Date: 2016-06-16
        Description: 为了更好控制权限，将原来的双击行打开编辑页面改为打开查看页面*/
    if (typeof (View) == "function") {
        View(true);
    }
}

/*全选*/
function checkAll(checked) {
    if (isMultiple) {
        if (checked) {
            $(".ListTable :checkbox").attr("checked", true);
            $(".ListTable tr:not(:first) :checkbox").parent().parent().addClass("ListTableSelectedRow");
        }
        else {
            $(".ListTable :checkbox").attr("checked", false);
            var $row = $(".ListTable :checkbox").parent().parent();
            for (var i = 1; i < $row.length; i++) {
                $($row[i]).removeClass("ListTableSelectedRow");
                $($row[i]).addClass(($row[i].rowIndex % 2 == 1) ? "ListTableOddRow" : "ListTableEvenRow");
            }
        }
    }
}

/*清除所选记录*/
function clearCheck(gridView) {
    if (selectedRowIndex != -1) {
        gridView.rows[selectedRowIndex].cells[0].children[0].checked = false;
        operateRow(gridView.rows[selectedRowIndex]);
        selectedRecordId = -1;
        selectedRowIndex = -1;
    }
}

/*得到选中记录的值*/
function getSelectedValues() {
    var selValues = "";
    var checkboxs = document.getElementsByName("chkSelect");
    var checkboxCount = checkboxs.length;

    for (var i = 0; i < checkboxCount; i++) {
        if (checkboxs[i].checked) {
            if (selValues != "") {
                selValues += ",";
            }

            selValues += checkboxs[i].value;
        }
    }

    return selValues;
}

/*得到选中行的第一行行索引*/
function getSelectedRowIndex() {
    var checkboxs = document.getElementsByName("chkSelect");
    var checkboxCount = checkboxs.length;

    for (var i = 0; i < checkboxCount; i++) {
        if (checkboxs[i].checked) {
            selectedRowIndex = i + 1;

            break;
        }
    }
}

/*设置是否多选*/
function setMultiple(b) {
    isMultiple = b;
    if (gridView.rows.length > 1) {
        if (!isMultiple) {
            document.getElementById("chkAll").disabled = true;
        }
        else {
            document.getElementById("chkAll").disabled = false;
        }
    }
}

/*行操作事件*/
function operateRow(row) {

    var chk = row.cells[0].children[0];
    if (chk.checked) {
        row.className = "ListTableSelectedRow";
        selectedRecordId = chk.value;
        selectedRowIndex = row.rowIndex;
        if (!isMultiple) {
            var lstTable = row.parentElement;
            /*
            修复通过Table.insertRow()新增表格且表中有checkbox选择列时，因无表尾导致从最后一行选择时自动多选的问题
            */
            var rowlen = lstTable.rows.length;
            if (lstTable.rows[lstTable.rows.length - 1].id != "footerTR") {
                rowlen = lstTable.rows.length + 1;
            }
            for (var idx = 1; idx < rowlen; idx++) {
                if (idx != row.rowIndex && lstTable.rows[idx - 1].cells[0].children[0].checked == true) {

                    lstTable.rows[idx - 1].cells[0].children[0].checked = false;

                    lstTable.rows[idx - 1].className = ((lstTable.rows[idx - 1].rowIndex % 2 == 1) ? "ListTableOddRow" : "ListTableEvenRow");
                }
            }
            selectedRowCount = 1;
        }
        else {
            selectedRowCount++;
        }
    }
    else {
        if (selectedRowCount > 0)
            selectedRowCount--;

        row.className = ((row.rowIndex % 2 == 1) ? "ListTableOddRow" : "ListTableEvenRow");
        selectedRecordId = -1;
        selectedRowIndex = -1;
        var checkboxs = document.getElementsByName("chkSelect");
        var checkboxCount = checkboxs.length;

        for (var i = 0; i < checkboxCount; i++) {
            if (checkboxs[i].checked) {
                selectedRecordId = checkboxs[i].value;
                selectedRowIndex = checkboxs[i].parentElement.parentElement.rowIndex;
                break;
            }
        }
    }
}


/*得到一条选中的记录的值 Checkbox的值 */
function getOneRecordId() {
    var idStr;

    if (isMultiple == true) {
        idStr = getSelectedValues();

        if (idStr.indexOf(",") != -1) {
            alert(RequireOnlyOneRecord);
            return "";
        }
    }
    else {
        if (selectedRecordId == -1)
            idStr = "";
        else
            idStr = selectedRecordId;
    }
    if (idStr == "" && needAlertForGetRecordId) {
        alert(RequireOperateRecord);
        return "";
    }

    return idStr;
}
/*得到一条选中的记录的值 Checkbox的值,不需要弹出框提示必选中一条记录,2015-04-28 by sam */
function getOneRecordIdOnly() {
    var idStr;

    if (isMultiple == true) {
        idStr = getSelectedValues();

        if (idStr.indexOf(",") != -1) {
            alert(RequireOnlyOneRecord);
            return "a";
        }
    }
    else {
        if (selectedRecordId == -1)
            idStr = "";
        else
            idStr = selectedRecordId;
    }
    if (idStr == "" && needAlertForGetRecordId) {
        //alert(RequireOperateRecord);
        return "";
    }

    return idStr;
}

/*得到选中的多行记录的值*/
function getRecordIdString() {
    var idStr;
    if (isMultiple == true) {
        idStr = getSelectedValues();
    }
    else {
        if (selectedRecordId == -1)
            idStr = "";
        else
            idStr = selectedRecordId;
    }
    if (idStr == "" && needAlertForGetRecordId) {
        alert(RequireOperateRecord);
        return "";
    }

    return idStr;
}

function getDeletingRecordIdString() {
    var idStr = getRecordIdString();

    if (idStr != "") {
        if (!window.confirm(ConfirmDelete)) {
            return "";
        }
    }

    return idStr;
}

//获取操作行的某一列值
function getCellValue(gridView, cellIndex) {
    var cellText = "";
    cellText = gridView[currentRowIndex].cells[cellIndex].innerText;
    return cellText
}

//获取选中行某一单元格中的文本
/*
a : 第几个单元格
*/
function getOneRecordCellText(a) {
    //如果表格列允许交换位置
    var b = "", c = $("input[name='chkSelect']:checked");
    return c.length == 0 ? alert(RequireOperateRecord) : c.length > 1 ? alert(RequireOnlyOneRecord) : b = $.trim(c[0].parentElement.parentElement.cells[GetGridCellsChangNo(a)].innerText), b;
}
//根据绑定得字段获取选中行单元格值(多选)
function getRecordCellTextsByFiled(filedName) {
    var cellValues = "";
    var checkboxs = $("input[name='chkSelect']:checked");
    //验证
    if (!filedName) {
        return "";
    }
    var checkboxCount = checkboxs.length;
    if (checkboxCount == 0) {
        alert(RequireOperateRecord);
        return "";
    }

    for (var i = 0; i < checkboxCount; i++) {
        if (cellValues != "") {
            cellValues += ",";
        }
        //获取单元格得值
        var parent = $(checkboxs[i]).parent();
        parent.siblings().each(function () {
            if ($(this).attr("field") == filedName || $(this).hasClass(filedName)) {
                cellValues += $(this).text();
                return false;
            }
        });
    }
    return cellValues;
}
//根据绑定得字段获取选中行单元格值(单选)
function getOneRecordCellTextByFiled(filedName) {
    var cellValue = "";
    var checkboxs = $("input[name='chkSelect']:checked");
    //验证
    if (!filedName) {
        return "";
    }
    var checkboxCount = checkboxs.length;
    if (checkboxCount == 0) {
        alert(RequireOperateRecord)
        return "";
    }
    else if (checkboxCount > 1) {
        alert(RequireOnlyOneRecord);
        return "";
    }
    //获取单元格得值
    var parent = $(checkboxs[0]).parent();
    parent.siblings().each(function () {
        if ($(this).attr("field") == filedName || $(this).hasClass(filedName)) {
            cellValue = $(this).text();
            return false;
        }
    });
    return cellValue;
}

//根据绑定得字段获取选中行单元格值(单选)
function getItemTemplatebyClass(filedName) {
    var cellValue = "";
    var checkboxs = $("input[name='chkSelect']:checked");
    //验证
    if (!filedName) {
        return "";
    }
    var checkboxCount = checkboxs.length;
    if (checkboxCount == 0) {
        alert(RequireOperateRecord)
        return "";
    }
    else if (checkboxCount > 1) {
        alert(RequireOnlyOneRecord);
        return "";
    }
    //获取选中行节点
    var parent = $(checkboxs[0]).parent();

    //跟据Class名称，获取内容
    filedName = '.' + filedName;
    return parent.parent().find(filedName).text();
}

function GetGridCellsChangNo(a) {
    var index = a;
    if (typeof (gridCellsChangeNo) != "undefined" && gridCellsChangeNo && typeof (gridOldFields) != "undefined" && gridOldFields) {
        var gridname;
        for (var field in gridOldFields) {
            gridname = field;
            break;
        }
        if (gridname && gridOldFields[gridname] && gridOldFields[gridname].length > 0) {
            var cellname = gridOldFields[gridname][a - (gridRecordIDField.toLowerCase() == "null" ? 0 : 1)];
            if (cellname) {
                for (var i = 0; i < gridCellsSet[gridname].length; i++) {
                    if (gridCellsSet[gridname][i].field == cellname) {
                        index = i + (gridRecordIDField.toLowerCase() == "null" ? 0 : 1);
                        break;
                    }
                }
            }
        }
    }
    return index;
}

//设置选中行某一单元格中的文本
/*
a : 第几个单元格
*/
function setOneRecordCellText(a, text) {
    var b = "", c = $("input[name='chkSelect']:checked");
    if (c.length == 0) {
        alert(RequireOperateRecord);
        return false;
    }
    if (c.length > 1) {
        alert(RequireOnlyOneRecord);
        return false;
    }
    c[0].parentElement.parentElement.cells[a].innerText = text;
}

//设置选中行某一单元格中的文本的样式
/*
a : 第几个单元格
*/
function setOneRecordCellStyle(a, style) {
    var b = "", c = $("input[name='chkSelect']:checked");
    if (c.length == 0) {
        alert(RequireOperateRecord);
        return false;
    }
    if (c.length > 1) {
        alert(RequireOnlyOneRecord);
        return false;
    }
    $(c[0].parentElement.parentElement.cells[a]).attr("style", style);
}

function getRecordCellTexts(a) {
    var cellValues = "", checkboxs = $("input[name='chkSelect']:checked");
    var checkboxCount = checkboxs.length;
    if (checkboxCount == 0) {
        alert(RequireOperateRecord);
    } else {
        for (var i = 0; i < checkboxCount; i++) {
            if (cellValues != "") {
                cellValues += ",";
            }
            cellValues += checkboxs[i].parentElement.parentElement.cells[GetGridCellsChangNo(a)].innerText;
        }
    }
    return cellValues;
}

//获取选中行某一单元格中的文本
/*
e : gridview
d : attr Name
*/
function getRowAttribute(e, d) {
    var c = "", b = $("input[name='chkSelect']:checked");
    if (b.length != 0) {
        var a = b[0].parentElement.parentElement.rowIndex;
        c = e.rows[a].attributes[d].value;
    }
    return c;
}