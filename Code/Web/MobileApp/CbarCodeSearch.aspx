<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CbarCodeSearch.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.CbarCodeSearch" %>

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
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <title>库位查询</title>
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
                            <label for="warehouse">库位条码</label>
                        </td>
                        <td colspan="2">
                            <input class="warehouse" data-corners="false" type="text" data-mini="true" value="" androidscan="true" id="txtCbarCode" />
                        </td>
                       <%-- <td>
                            <a href="#fpanelWarsehouse" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" onclick="showWarsehouse()">选择库位条码</a>
                        </td>--%>
                    </tr>
                    <tr>
                    <td>
                        <label for="Print">
                            打印机</label>
                    </td>
                    <td>
                        <select id="PDAselPrintersList" data-mini="true" class="perparelist">
                        </select>
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
                                <th>GRN条码</th>
                                <th>物料编码</th>
                                 <th>客户编码</th>
                                 <th>数量</th>
                                 <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
            </div>
            <!--筛选库位条码-->
            <div data-role="panel" id="fpanelWarsehouse" data-display="overlay">
                <a href="#" id="btnFilterWarsehouse" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选库位条码</a>
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

            //获取打印机名称
            $(document).ready(function () {
                bindPrinters('PDAselPrintersList', function () {
                    if ($("#PDAselPrintersList").val()) {
                        $("#PDAselPrintersList-button span").text($("#PDAselPrintersList").find("option:selected").text());
                    }
                });
            });

            $("#txtCbarCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
            $("#txtCbarCode").focus();
            $(".ui-body-c").css("background", "#fff");

            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");

            $("#txtCbarCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Query();
                }
            });

            
        });


        //筛选库位条码
        $("#btnFilterWarsehouse").on("click", function () {
            val = $.trim($("#fpanelWarsehouse input[data-type='search']").first().val());
            debugger
            searchWarsehouse(val);
        });


        function searchWarsehouse(cbarCode) {
            $("#listviewsWarsehouse").html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.GetWarehouse(cbarCode);
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                $("#txtCbarCode").val("").focus();
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
            $("#txtCbarCode").val(entity.CWhCode);
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
            var warsehousecode = $.trim($("#txtCbarCode").val());
            if (!warsehousecode) {
                setMsg("请选择库位条码！", "red");
                $("#txtCbarCode").focus()
                return;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.GetMaterialByCbarCode(warsehousecode);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                $("#txtItemCode").select()
                return;
            }
            var entity = ajax.value;
            if (entity != null && entity.length == 0) {
                setMsg("未能获取此库位条码下物料！", "red");
                $("#txtItemCode").select()
                return;
            }
            var hl = "";
            for (var i = 0; i < entity.length; i++) {
                hl += "<tr>"
                hl += "<td>" + entity[i].SerialNumber + "</td>";
                hl += "<td>" + entity[i].ItemCode + "</td>";
                hl += "<td>" + entity[i].Remark + "</td>"; 
                hl += "<td class='truncate'>" + entity[i].BalanceQty + "</td>";
                hl += "<td class='truncate'><input type='button'style='cursor: pointer;' onclick='Print(\"" + entity[i].SerialNumber + "\")' value='补打'/></td>";
            }
            $("#datatab tbody").html(hl);
            $("#txtCbarCode").val("").focus();
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


        function Print(grn) {
            if (grn == "" || grn == null ) {
                return;
            }
            var grnArray = grn.split(",");
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.ItemList = [];
            for (var i = 0; i < grnArray.length; i++) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grnArray[i]);

                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                if (ajax.value == null || ajax.value.SerialNumber == null) {
                    $("#msg").html("无效的GRN或者该GRN对应的Item不存在！").css("color", "red");
                    return false;
                }



                try {
                    labelItemId = ajax.value.PartId;
                    //是否供应商打印调用不同的模板
                    var IsSupper = ajax.value.IsSuplySerialNumber;

                    //如果工单号不为空则调用批次产品条码
                    if (ajax.value.SupplierOrderNumber != "" || labelType == -36) {
                        labelType = -36
                    }
                    else if (IsSupper) {
                        labelType = -24; //调用供应商模板
                    }
                    else {
                        labelType = -3;
                    }
                    //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                    getDocumentInfo();

                    //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                    SNInfo.SNList.push(grnArray[i]);
                    SNInfo.ItemList.push(ajax.value.PartId);
                }
                catch (e) {
                    $("#msg").html(e).css("color", "red");
                }

            }

            if (!$("#PrintOld").prop('checked')) {
                var grnTemp = $("#GRN").val();
                var grnIndex = $.inArray(grnTemp, SNInfo.SNList);
                if (grnIndex != -1) {
                    SNInfo.SNList.splice(grnIndex, 1);
                }
            }

            PrintLabContent();
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型 (-2：SN，-3：GRN)
        var labelSequence = 2;      //标签序号 (1产品，2GRN, 3单号......)
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        //根据打印方式决定 调用ZPL还是Lab打印
        function getDocumentInfo() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                //获取打印机名称值
                printName = $("#PDAselPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                $("#msg").html(ajax.error.Message).css("color", "red");
                return false;
            }
        }

        var printCount = 1;


        var labelJsonData = "";
        function PrintLabContent() {
            try {
                var printdata = [];
                printCount = 1;
                lableArr = SNInfo.SNList;
                labItemList = SNInfo.ItemList;

                labelJsonData = "[";
                for (var i = 0; i < lableArr.length; i++) {
                    var labelStr = lableArr[i];
                    var lablabItem = labItemList[i];
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, lablabItem, -1);

                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }
                    }
                }
                if (printdata.length == 0)
                    return;
                debugger
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            } catch (e) {
                $("#msg").html(e).css("color", "red");
                return false;
            }
        }
    </script>
</body>
</html>


