<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GRNRePrint.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.GRNRePrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />

    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />

    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js?v=2" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <title>GRN补打</title>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }
        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }
        .ui-title { line-height: 30px; }
        .clear { clear: both; height: 2px; }
        .ui-title { line-height: 30px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="page" id="pageOne">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">GRN补打</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <!--打印插件未安装的提示区域-->
                    <div id="noprtplg" class="Tips">
                    </div>
                    <!--打印状态的信息提示区域-->
                    <div id="lblMessage" class="Tips" style="text-align: center">
                    </div>
                    <table style="width: 100%; z-index: 2">
                        <tr class="clear5">
                        </tr>
                        <tr>
                            <td>
                                <label><%=Resources.lang.GRN %></label>
                            </td>
                            <td>
                                <input type="text" id="txtGRN" class="TextBox" style="height: 25px; width: 250px; text-transform: uppercase; font-size: 16px; font-weight: bold;" />
                            </td>
                            <td>
                                <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择单据</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>打印机名称</label>
                            </td>
                            <td colspan="2">
                                <select id="selPrintersList">
                                </select>
                                <a href="#" onclick="bindPrinters();">重新加载打印机列表</a>
                            </td>
                        </tr>
                    </table>
                    <div class="clear5">
                    </div>
                    <div id="info" style="text-align: center; color: Green; font-weight: bold; text-transform: uppercase;">
                    </div>
                </div>
            </div>
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#" data-transition="none" onclick="Print();"><%--style="background-color: Gray"--%>
                        打印</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>
    </form>
    <script src="js/jqPaginator.js"></script>
    <script type="text/javascript">
        var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";

        var labelDocumentId = -1    //Label文档Id
        var tempatePath = "";       //Lab模板文件路径
        var labelItemId = -1;       //物料ID
        var labelJsonData = "";    //标签Lab方式的 数据Json格式字符串

        //获取打印机名称
        $(document).ready(function () {
            bindPrinters('selPrintersList', function () {
                if ($("#selPrintersList").val()) {
                    $("#selPrintersList-button span").text($("#selPrintersList").find("option:selected").text());
                }
            });

        });
        $(function () {
            $(".ui-body-c").css("background", "#fff");
            $("body").focus();
            $("#txtGRN").focus();
            var _grn = '<%=Request.QueryString["GRN"] %>';
            if (_grn != "") {
                $("#txtGRN").val(_grn);
                $("#txtGRN").focus();
                $("#txtGRN").select();
            }

            /*扫描条码*/
            $("#txtGRN").keypress(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Print();
                    return false;
                }
            });

            //筛选
            $("#btnFilter").on("click", function () {
                debugger
                $("#listviews").html("");
                var $ul = $(this),
                    value = $.trim($("input[data-type='search']:eq(0)").val());

                var entity1 = {};
                entity1.paras = value;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetGRN", JSON.stringify(entity1));
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetListStatuePlus(value);
                if (ajax.error != null) {
                    $("#showGrn").html(ajax.error.Message);
                    $("#showGrn").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }

                var entity = $.parseJSON(ajax.value);
                if (entity.error != null) {
                    confirmDialogFocus(entity.error, function () {
                        $("#txtGRN").focus();
                    });
                };
                var ulhtml = "";
                for (var i = 0; i < entity.length; i++) {
                    if (ulhtml.indexOf(entity[i].SerialNumber) == -1) {
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' title=\"" + entity[i].SerialNumber + "\"><a onclick='SetGRN(this)' style='font-size:80%;'>" + entity[i].SerialNumber + "</a></li>";
                    }
                }
                $("#listviews").html(ulhtml);
                $("#listviews").listview("refresh");
            });
        });
        function SetGRN(Code) {
            var requestGRN = $(Code).html();
            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#fpanel").panel("close");
            $("#txtGRN").val(requestGRN).focus();
        }
        function Print() {
            var grn = $("#txtGRN").val();
            if ($.trim(grn) == "") {
                alert("<%=Resources.Messages.NeedScanGRN %>");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            debugger
            var grnArray = grn.split(",");
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.ItemList = [];
            for (var i = 0; i < grnArray.length; i++) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grnArray[i]);

                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#info").html(ajax.error.Message);
                    $("#info").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                if (ajax.value == null || ajax.value.SerialNumber == null) {
                    $("#info").html("无效的GRN或者该GRN对应的Item不存在！");
                    $("#info").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }

                try {
                    labelItemId = ajax.value.PartId;
                    ////是否供应商打印调用不同的模板
                    //var IsSupper = ajax.value.IsSuplySerialNumber;
                    //if (IsSupper) {
                    //    labelType = -24; //调用供应商模板
                    //}
                    //else {
                    //    labelType = -3;
                    //}

                }
                catch (e) {
                    alert(e)
                    $("#lblMessage").html(e);
                }

            }

            if (!$("#selPrintersList").val()) {
                setMsg("请选择打印机", "red");
                return false;
            }
            //选择打的话，执行打印：
            //var list = $.parseJSON(ajax.value).data;
            labelItemId = labelItemId
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, -3, 2);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
            sendPrintContent(JSON.stringify(GRNlabel(labelDocumentId, grn, labelItemId)), $("#selPrintersList").val(), 1, labelDocumentId);
            $("#txtGRN").val("").focus();
        }
        function GRNlabel(labelDocumentId, grn, labelItemId) {
            var printdata = [];
            var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, grn, -1, -1, -1, labelItemId, -1);
            if (ajaxLabContent.error == null) {
                try {
                    var list = ajaxLabContent.value;
                    if (list.length > 0) {
                        var page = { LabelContent: [] };
                        for (var k = 0; k < list.length; k++) {
                            page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                        }
                        printdata.push(page);
                    }
                } catch (e) {
                    printdata = [];
                    $("#msg").html(e).css("color", "red");
                }
            }
            else {
                $("#msg").html(ajaxLabContent.error.Message).css("color", "red");
            }
            return printdata;
        }

    </script>

</body>
</html>
