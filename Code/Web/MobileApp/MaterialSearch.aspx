<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialSearch.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MaterialSearch" %>

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
    <title>库存查询</title>
    <style type="text/css">
        body, label {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 13px !important;
            color: #1d1007;
        }

        table {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px !important;
            color: #1d1007;
        }

        .ui-title {
            line-height: 30px;
        }

        a.link-disable {
            background-color: #c3c3c3;
            border-color: #999;
        }

        .ui-table th, .ui-table td {
            line-height: 1.5em;
            text-align: left;
            padding: 5px 5px 0 0;
            vertical-align: top;
        }

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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">库存查询</label>
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
                            <label for="warehouse">仓库</label>
                        </td>
                        <td colspan="2">
                            <input class="warehouse" data-corners="false" type="text" data-mini="true" value="" androidscan="true" id="txtWarehouse" />
                        </td>
                        <td>
                            <a href="#fpanelWarsehouse" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="showWarsehouse()">选择仓库</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                          <select id="sltQuery" >
                              <option value="1">物料编码</option>
                              <option value="2">客户编码</option>
                           </select>
                        </td>
                        <td colspan="2">
                            <input class="itemcode" data-corners="false" type="text" data-mini="true" value="" androidscan="true" id="txtItemCode" />
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
                                <th>物料编码</th>
                                 <th>客户编码</th>
                                <th>库位</th>
                                <th>数量</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
            </div>
            <!--筛选仓库-->
            <div data-role="panel" id="fpanelWarsehouse" data-display="overlay">
                <a href="#" id="btnFilterWarsehouse" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选仓库</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviewsWarsehouse" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview">
                </div>
            </div>

        </div>
    </form>
    <script type="text/javascript" src="js/jqPaginator.js"></script>
    <script type="text/javascript" src="js/jquery.nicescroll.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#txtWarehouse").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
            $("#txtWarehouse").focus();
            $(".ui-body-c").css("background", "#fff");

            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");

            $("#txtWarehouse").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#txtItemCode").focus();
                }
            });

            //$('table').on('click', 'td.truncate', function () {
            //    var text = $(this).text();
            //    showDetailed(text);
            //});

            $("#btnQuery").on("click", function () {
                Query();
            });
        });


        //筛选仓库
        $("#btnFilterWarsehouse").on("click", function () {
            val = $.trim($("#fpanelWarsehouse input[data-type='search']").first().val());
            debugger
            searchWarsehouse(val);
        });


        function searchWarsehouse(equipmentCode) {
            $("#listviewsWarsehouse").html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.GetWarehouse(equipmentCode);
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                $("#txtWarehouse").val("").focus();
                return false;
            }
            var list = ajax.value;

            var ulhtml = "";
            for (var i = 0; i < list.length; i++) {
                ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='getWarsehouse(" + (JSON.stringify(list[i])) + ")'>" + list[i].CWhName + "</a></li>";
            }
            $("#listviewsWarsehouse").html(ulhtml);
            $("#listviewsWarsehouse").listview("refresh");
        }


        function getWarsehouse(entity) {
            $("#txtWarehouse").val(entity.CWhCode);
            $("input[data-type='search']").val('');
            $("#listviewsWarsehouse").html('');
            $("#fpanelWarsehouse").panel("close");
        }

        function showWarsehouse() {
            //初始化设备编码数据
            searchWarsehouse("");
            $("#listviewsWarsehouse").listview("refresh");
        }


        function Query() {
            debugger
            setMsg("正在查询", "red");
            var warsehousecode = $.trim($("#txtWarehouse").val());
            if (!warsehousecode) {
                setMsg("请选择仓库！", "red");
                $("#txtWarehouse").focus()
                return;
            }

        
            var itemcode = "";
            var cpn = "";
            var sltQuery = $("#sltQuery").val();
            if (sltQuery == 1) {
                itemcode = $.trim($("#txtItemCode").val());
                if (!itemcode) {
                    setMsg("请输入物料编码！", "red");
                    $("#txtItemCode").focus()
                    return;
                }
            } else {
                cpn = $.trim($("#txtItemCode").val());
                if (!cpn) {
                    setMsg("请输入客户编码！", "red");
                    $("#txtItemCode").focus()
                    return;
                }
            }


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.GetWarseHouseQty(warsehousecode, itemcode, cpn);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                $("#txtItemCode").select()
                return;
            }
            var entity = ajax.value;
            if (entity != null && entity.length == 0) {
                setMsg("未能获取此仓库下物料！", "red");
                $("#txtItemCode").select()
                return;
            }
            var hl = "";
            for (var i = 0; i < entity.length; i++) {
                hl += "<tr>"
                hl += "<td>" + entity[i].ItemCode + "</td>";
                hl += "<td>" + entity[i].Remark + "</td>"; 
                hl += "<td class='truncate'>" + entity[i].CBarCode + "</td>";
                hl += "<td class='truncate'>" + entity[i].BalanceQty + "</td>";
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


