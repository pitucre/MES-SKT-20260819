/****************************************************************************
*  Author: Alen Liu
*  Create Datetime: 2014-01-10
*  Desc: 弹窗选择页面功能js
*  Version: 1.0.0
*  Email: shzalen@163.com
****************************************************************************/

function splitText(s, isnum) {
    if (s == null) return new Array();
    s = s.replace(/ /g, "");
    if (s == "") return new Array();
    var ss = s.split(",");
    if (isnum) {
        var ns = new Array();
        for (var i = 0; i < ss.length; i++) {
            ns[i] = parseInt(ss[i], 10)
        }
        return ns
    }
    return ss
}

function mergeSqlText(findText, ss, searchCode) {
    var s = "";
    findText = findText.replace(/'/g, "''");
    findText = "%" + findText + "%";
    for (var i = 0; i < ss.length; i++) {
        if (ss[i].toUpperCase() == searchCode.toUpperCase() || ss[i].toUpperCase() == "[" + searchCode.toUpperCase() + "]") {
            s += ss[i] + " LIKE '" + findText + "'"
        }
    }
    s += "";
    return s
}

function searchText() {
    debugger
    var findText = $.trim($("#txtFindText").val());
    if (findText == "") {
        document.location.href = "ChoosePage.aspx?PageId=" + pageId + "&Multiple=" + (isMultiple ? "true" : "false") + (pageCondition ? "&SearchCondition=" + encodeURIComponent(pageCondition) + "&PageCondition=" + encodeURIComponent(pageCondition) : "") + "&CallBackFunc=" + callBackFunc + "&rnd=" + Math.random();
    } else {
        var ss = splitText(hdnSearchFields, false);
        if (ss.length == 0) {
            document.location.href = "ChoosePage.aspx?PageId=" + pageId + "&Multiple=" + (isMultiple ? "true" : "false") + (pageCondition ? "&SearchCondition=" + encodeURIComponent(AES_CBC_ENCRYPT(pageCondition)) + "&PageCondition=" + encodeURIComponent(AES_CBC_ENCRYPT(pageCondition)) : "") + "&CallBackFunc=" + callBackFunc + "&rnd=" + Math.random();
        } else {
            var searchCode = $("#ddlSearch").val();
            var s = mergeSqlText(findText, ss, searchCode);
            //s += pageCondition ? " AND " + pageCondition : "";

            document.location.href = "ChoosePage.aspx?PageId=" + pageId + "&Multiple=" + (isMultiple ? "true" : "false") + "&SearchCondition=" + encodeURIComponent(AES_CBC_ENCRYPT(s)) + (pageCondition ? "&PageCondition=" + encodeURIComponent(pageCondition) : "") + "&CallBackFunc=" + callBackFunc + "&rnd=" + Math.random();
        }
    }
}

function ok(flag) {
    var list;
    if (flag == 0) {
        list = chooseMultiple();
    } else if (flag == 1) {
        list = chooseEmpty();
    }

    if (list == null) {
        return;
    }
    chooseValue(list);
}

if (callBackFunc == undefined) {
    callBackFunc = "";
}

function onFindText() {
    var keyCode = (navigator.appName == "Netscape") ? event.which : event.keyCode;
    if (keyCode == 0xD) {
        event.cancelBubble = true;
        event.returnValue = false;
        searchText();
    }
}
function chooseSingle(row) {
    var list = new Array();
    var ns = splitText(hdnReturnFields, true);
    list[0] = new Array();
    list[0][0] = row.cells[0].children[0].value;
    for (var i = 0; i < ns.length; i++) {
        list[0][i + 1] = row.cells[ns[i]].innerText;
    }
    return list;
}

function chooseMultiple() {
    var list = new Array();
    var ns = splitText(hdnReturnFields, true);
    var index = 0;
    var row;

    for (var idx = 1; idx <= rowCount; idx++) {
        row = lstTable[idx];
        if (row.cells[0].children[0].checked) {
            list[index] = new Array();
            list[index][0] = row.cells[0].children[0].value;
            for (var i = 0; i < ns.length; i++) {
                list[index][i + 1] = row.cells[ns[i]].innerText;
            }
            index++;
        }
    }

    if (list.length == 0) {
        alert(RequireOperateRecord);
        return null;
    }

    return list;
}

function chooseEmpty() {
    var list = new Array();
    var listAry = new Array();
    listAry[0] = "-1";
    for (var i = 1; i < 10; i++) {
        listAry[i] = "";
    }
    list[0] = listAry;
    return list;
}


function chooseValue(list) {
    if (callBackFunc != "") {
        eval("window.parent." + callBackFunc + "(" + AjaxPro.toJSON(list) + ")");
    } else {
        window.parent.getChooseValue(list);
    }
    try {
        window.parent.closeDialog();
        window.parent.document.focus();
    } catch (ex) { }
}