<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceHistory.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MaintenanceHistory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/jquery.mobile.datepicker.css">
    <link rel="stylesheet" href="css/jquery.mobile.datepicker.theme.css">
    <link rel="Stylesheet" href="css/bootstrap.min.css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>维修履历</title>
    <style type="text/css">
        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }

        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }

        .ui-title { line-height: 30px; }

        a.link-disable { background-color: #c3c3c3; border-color: #999; }
        .ui-table th, .ui-table td { line-height: 1.5em; text-align: left; padding: 5px 5px 0 0; vertical-align: top; }
        .truncate {
            max-width: 50px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap; 
        }
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false;">
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 3px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">维修履历</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label for="orderno">设备/模具编码</label>
                        </td>
                        <td colspan="2">
                            <input class="orderno" data-corners="false" type="text" data-mini="true" value="" androidScan="true"  id="txtEquipmentCode" />
                        </td>
                        <td>
                            <a data-corners="false" id="btnQuery" data-role="button" data-fullscreen="true" data-theme="a">查询</a>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="width: 100%; text-align: center; font-size: 15px; font-weight: bold;">
                </div>
                <div id="testtab" style="margin-top: 3px; position: relative">
                    <table data-role="table" id="datatab" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>故障描述</th>
                                <th>故障分析</th>
                                <th>维修内容</th>
                                <th>报修人</th>
                                <th>报修时间</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
            </div>
        </div>
    </form>
    <script type="text/javascript" src="js/jqPaginator.js"></script>
    <script type="text/javascript" src="js/jquery.nicescroll.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#txtEquipmentCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
            $("#txtEquipmentCode").focus();

            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");

            $("#txtEquipmentCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Query();
                }
            });

            $('table').on('click', 'td.truncate', function () {
                var text = $(this).text();
                showDetailed(text);
            });

            $("#btnQuery").on("click", function () {
                Query();
            });
        });

        function Query() {
            setMsg("正在查询", "red");
            var code = $.trim($("#txtEquipmentCode").val());
            if (!code) {
                setMsg("请输入设备/模具编码！", "red");
                $("#txtEquipmentCode").focus()
                return;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetMaintenanceHistory(code);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                $("#txtEquipmentCode").select()
                return;
            }
            var entity = ajax.value;
            if (entity != null && entity.length == 0) {
                setMsg("未能获取此设备/模具编码维修履历！", "red");
                $("#txtEquipmentCode").select()
                return;
            }
            var hl = "";
            for (var i = 0; i < entity.length; i++) {
                hl += "<tr>"
                hl += "<td>" + entity[i].AnormalDesc + "</td>";
                hl += "<td class='truncate'>" + entity[i].FaultAnalysis + "</td>";
                hl += "<td class='truncate'>" + entity[i].RepairContent + "</td>";
                hl += "<td>" + entity[i].CreateName + "</td>";
                hl += "<td>" + entity[i].CreateDateTime.toLocaleString() + "</td>";
            }
            $("#datatab tbody").html(hl);

            setMsg("", "red");
        }

        // 控制Msg的显示
        function setMsg(s, r) {
            $("#msg").html(s);
            $("#msg").css("color", r);
        }

        function showDetailed(text) {
            var text = text;
            var popupDialogId = 'popupDialog';
            playSound();
            $('<div data-role="popup" id="' + popupDialogId + '" data-confirmed="no" data-transition="pop" data-overlay-theme="a" data-theme="a" data-dismissible="false" style="max-width:500px;width:290px;text-align:center;">'
                + '<div role="main" class="ui-content" style="text-align:center;">'
                + '<h3 class="ui-title">' + text + '</h3>'
                + '<div style="text-align:center;">'
                + '<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline data-corners="false" optionConfirm" data-rel="back" style="width:30%">关闭</a>'
                + '</div>'
                + '</div>'
                + '</div>').appendTo($.mobile.pageContainer);
            var popupDialogObj = $('#' + popupDialogId);
            popupDialogObj.trigger('create').trigger('refresh');
            popupDialogObj.popup({
                afterclose: function (event, ui) {
                    popupDialogObj.find(".optionConfirm").first().off('click');
                    var isConfirmed = popupDialogObj.attr('data-confirmed') === 'yes' ? true : false;
                    $(event.target).remove();
                }
            });
            popupDialogObj.popup('open');
            popupDialogObj.find(".optionConfirm").first().on('click', function () {
                popupDialogObj.attr('data-confirmed', 'yes');
            });
        }
    </script>
</body>
</html>


