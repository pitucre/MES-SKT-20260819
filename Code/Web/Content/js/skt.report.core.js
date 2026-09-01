/****************************************************************************
*  Author: Starry Cheng
*  Create Datetime: 2014-01-10
*  Desc: 报表通用功能JS
*  Version: 1.0.0
*  Email: shzalen@163.com
****************************************************************************/

/*Get Chart DataSource*/
function getChartDataSource(options) {
    var defaults = {
        source: "",
        dataAction: "PROC",
        paramters: "[]",
        conditions: "",
        sortname: "",
        orderby: ""
    };
    var defaults = $.extend(defaults, options);
    var dataSource;
    var param = [];
    param.push({ name: "dataAction", value: defaults.dataAction });
    param.push({ name: "paramters", value: defaults.paramters });
    if (defaults.dataAction == "TABLE") {
        param.push({ name: "conditions", value: defaults.conditions });
        param.push({ name: "page", value: "1" });
        param.push({ name: "pagesize", value: "100000" });
        param.push({ name: "sortname", value: defaults.sortname });
        param.push({ name: "sortorder", value: defaults.orderby });
    }
    $.ajax
	 ({
	     type: "post",
	     url: "../Handler/ReportingServer.ashx?gridviewname=" + defaults.source+"&rnd="+Math.random(),
	     data: param,
	     dataType: 'json',
	     async: false,
	     success: function (data) {
	         dataSource = data;
	     },
	     error: function (XMLHttpRequest, textStatus, errorThrown) {
	         alert('Get Data Error.');
	     }
	 });
	 return dataSource == null ? { Rows: []} : dataSource;
}

/*Get Resource*/
function getResource(resClass, resKey) {
    return SKT.LeanMES.Web.AjaxServices.AjaxReport.GetResourceString(resClass, resKey).value;
}

/*Check Permission*/
function IsHasPermission(userId_int, popedom_int) {
    return SKT.LeanMES.Web.AjaxServices.AjaxReport.IsPermission(userId_int, popedom_int).value;
}
//采用正则表达式获取URL地址栏参数
function GetQueryString(name) {

    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");

    var r = window.location.search.substr(1).match(reg);

    if (r != null) return unescape(r[2]); return null;

}

/*根据选择器获取表格的Json数据字符串
* selector :jQuery选择器
* headClass:标题行的样式名称(默认为常用表格样式：l-grid-header)
*/
function GetTableJsonData(selector,headClass) {
    var $table = $(selector).first();
    if ($table.length > 0 && $table.find("tr").length > 0) {
        //处理标题头
        headClass = headClass || "l-grid-header";
        var titles = [];
        var $heads = $table.find("tr." + headClass + " td");
        if ($heads.length == 0)
        {
            $heads = $table.find("tr." + headClass + " th");
        }
        $.each($heads, function (i, o) {
            titles.push($(o).text());
        });
        //处理内容
        var data = "[";
        var $rows = $table.find("tr:not(." + headClass + ")");
        if ($rows.length == 0) {
            return "";
        }
        $.each($rows, function (i, o) {
            var $cells = $(o).find("td");
            var row = "{";
            $.each($cells, function (j, o) {
                row = row + "\"" + titles[j] + "\":\"" + $(o).text() + "\",";
            });
            if ($cells.length > 0) {
                row = row.slice(0, row.length - 1);
            }
            row = row + "}";
            data = data + row + ",";
        });
        if ($rows.length > 0) {
            data = data.slice(0, data.length - 1);
        }
        data = data + "]";

        return data;
    }
    return "";
}