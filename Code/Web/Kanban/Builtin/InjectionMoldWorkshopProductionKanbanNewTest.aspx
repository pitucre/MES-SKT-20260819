<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InjectionMoldWorkshopProductionKanbanNewTest.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.InjectionMoldWorkshopProductionKanbanNewTest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>注塑车间设备看板</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="../../Content/js/jquery-3.1.0.min.js"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/chalk.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <link href="../../Content/plugin/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Content/plugin/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

    <link href="../../Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet"
        type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/js/jPlugin-dialog-2.0.js?v=160624"
        type="text/javascript"></script>

    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            margin: 0px;
            padding: 0px;
            border: 0px;
            font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif;
            color: #fff;
            background-color: #041622;
            font-size: 20px;
            /*overflow: hidden;*/
        }

        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat 15px center;
            background-size: 95%;
            background-color: #0D213A;
        }

        .logo_skt {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center center;
            background-size: 93%;
            background-color: #0D213A;
        }

        #_left_top_title {
            height: 100%;
            font-size: 1.5em;
            text-align: center;
        }

        #_left_top_welcome {
            height: 100%;
            font-size: 1.7em;
            color: Red;
        }

        /*#dateAndWeek {
            width: 13%;
            height: 100%;
            font-size: 1.0em;
            text-align: center;
        }*/
        #dateAndWeek {
            word-wrap: break-word;
            word-break: break-all;
            white-space: pre-wrap !important;
            display: inline-block;
            color: #fff;
            padding-right: 20px;
            text-align: center;
        }

        table {
            width: 100%;
            height: 100%;
            border-collapse: collapse;
            border-spacing: 0px;
            padding: 0px;
            margin: 0px;
        }

            table td, table th {
                padding: 0px;
            }

        #_layout {
            position: absolute;
        }

        #_layout_right_table td {
            font-size: 1em;
            text-align: center;
            /*border-top: 1px solid #263C54;
            border-right: 1px solid #263C54;
            border-bottom: 1px solid #263C54;*/
        }

        #data_thead th, #data_tbody td, #data_tfoot td {
            text-align: center;
            font-size: 0.8em;
            /*width: 7%;*/
            border-top: 1px solid #263C54;
            /*border-left: 1px solid #c5c5c5;*/
            border-bottom: 1px solid #263C54;
        }

        #data_thead th {
            border-bottom: 0px;
            /*background: #F2F2F2;
            background-image: linear-gradient(to bottom, #f8f8f8 0%, #ececec 100%);*/
        }

        #data_tbody td, #data_tfoot td {
            border-bottom: 0px;
            /*background-color: #fff;*/
        }

        #data_tfoot td {
            border-bottom: 1px solid #263C54;
            /*background-color: #F2F2F2;*/
        }

        .gauge {
            height: 50%;
            width: 33%;
        }

        table {
            table-layout: fixed;
            font-size: 10px;
        }

        ul, li {
            margin: 0px;
            padding: 0px;
            list-style: none;
            text-align: center; /*border: 1px solid #38FFFF;*/
        }

        .cell {
            display: table-cell;
            width: 100%;
            height: 100%;
            vertical-align: middle;
        }

        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat center;
            background-size: 94%; /*background-color: #0D213A;*/
        }

        .logo_cus2 {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center;
            background-size: 90%;
        }

        td {
            white-space: nowrap; /*文本不会换行，文本会在在同一行上继续，直到遇到 <br> 标签为止。*/
            /*overflow: hidden;*/ /*隐藏多余的内容*/
        }

        .itemTable {
            width: 100%;
            cursor: pointer;
        }

            .itemTable tr {
                height: 25px;
            }

            .itemTable img {
                width: 118px;
                height: 50px;
            }

        .table {
            margin-bottom: 18px;
        }

        .table_box {
            width: 11.1%;
        }

        .scroll {
            overflow: hidden;
        }

        .displayNone {
            display: none;
        }

        @media screen and (max-width:1440px) {
            .itemTable {
                /*width: 118px;*/
            }

                .itemTable tr {
                    height: 16px;
                }

            .table {
                margin-bottom: 6px;
            }

            .itemTable img {
                width: 112px;
                height: 42px;
            }
        }

        @media screen and (min-width:1441px) and (max-width:1599px) {
            .itemTable {
                /*width: 130px;*/
            }

                .itemTable tr {
                    height: 20px;
                }

            .table {
                margin-bottom: 8px;
            }

            .itemTable img {
                width: 114px;
                height: 46px;
            }
        }

        @media screen and (max-height:779px ) {
            .itemTable {
                /*width: 118px;*/
            }

                .itemTable tr {
                    height: 16px;
                }

            .table {
                margin-bottom: 6px;
            }

            .itemTable img {
                width: 112px;
                height: 42px;
            }
        }
    </style>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $(function () {
            setInterval(function () {
                debugger;
                var paramObj = {
                    UserName: userName
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspCheckUserIsOnline", JSON.stringify(paramObj));
                if (!!ajax.error) {
                    var msg = !!ajax.error.Message ? ajax.error.Message : ajax.error;
                    alert(msg)
                    return false;
                } else {
                    if (ajax.value.length === 0) {
                        alert("登录用户已经超时!");
                    }
                }
            }, 3 * 60 * 1000);
        })
    </script>

    <script type="text/javascript">
        /*
        _S1,_S2是滚动内容区域外的两个DIV的ID
        如
        <div id="_S1">
        <div id="_S2">
        _W为滚动内容的宽度
        _H为滚动内容的高度
        _T为滚动后每次停留言时间
        */
        var isScroll = false;
        function _InitScroll(_S1, _S2, _W, _H, _T) {
            if (isScroll) { return false; }
            marqueesHeight = _H;
            stopScroll = false;
            scrollElem = document.getElementById(_S1);
            scrollTable = document.getElementById('data_tbody');
            if (scrollTable.offsetHeight < marqueesHeight) {
                return;
            }
            with (scrollElem) {
                style.width = _W;
                style.height = marqueesHeight;
                style.overflow = 'hidden';
                noWrap = true;
            }
            scrollElem.onmouseover = new Function('stopScroll = true');
            scrollElem.onmouseout = new Function('stopScroll = false');
            preTop = 0;
            //currentTop = 0;
            //stopTime = 0;
            var leftElem = document.getElementById(_S2);
            var childElems = $(scrollElem).children();
            if (childElems.length > 1) {
                $(childElems[0]).nextAll().remove();
            }
            scrollElem.appendChild(leftElem.cloneNode(true));
            pauseTime = _T;
            //setTimeout('init_srolltext()', 1000);
            init_srolltext();
        }

        function init_srolltext() {
            scrollElem.scrollTop = 0;
            scrollIntervalId = setInterval('scrollUp()', 50);
        }

        function scrollUp() {
            if (stopScroll) {
                return;
            }
            preTop = scrollElem.scrollTop;
            scrollElem.scrollTop += 1;
            if (preTop == scrollElem.scrollTop) {
                scrollElem.scrollTop = 0;
                scrollElem.scrollTop += 1;
            }
        }
    </script>
    <script type="text/javascript">
        //var timeInterval = 1000 * 60 * 3;
        var timeInterval = 1000 * 10 * 1;//翻粤 秒数
        var times = 100 * 60 * 2;
        var int;

        $(window).resize(function () {
            ResizeAll();
        });

        function ResizeAll() {

            //某些浏览器不兼容div自适应高度
            $(".gauge").height($(window).height() * 0.9 * 0.27);

            var _contentHeight = $(window).height() * 0.9 * 0.4;

            $("#_layout_left_data_div_tbody").css("height", "auto");

            $(".rows").height(_contentHeight * 0.16)

            if ($(".rows").length * _contentHeight * 0.16 > _contentHeight) {
                $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);
                _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 150, 1000 * 6);
                isScroll = true;
            }
        }
    </script>
    <script type="text/javascript">
        var _close = "<%=Resources.Common.Close %>";
        var _resizewin = "<%=Resources.lang.ResizeWin %>";
        var _dialogwin = "<%=Resources.lang.PopWin %>";
        var _help = "<%=Resources.Common.Help %>";
        var _dataLoading = "<%=Resources.Messages.DataLoading %>";

        var getDeviceTable
        var count = 0
        var startindex = 0
        var endindex = 0
        var productcount = 0
        var productstartindex = 0
        var productendindex = 0



        function initEcharts_Static() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson("uspInjectionMoldWorkshopProductionKanbanNewTest");

            var data = JSON.parse(ajax.value);

            var orderDetia5 = [];
            var arr = [];

            debugger
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson("uspTOP5InjectionMoldWorkshopProductionKanbanNewTest");
            var data1 = JSON.parse(ajax.value);
            for (var i = 0; i < data1.length; i++) {
                orderDetia5.push(data1[i]["状态名称"]);
                arr.push({ name: data1[i]["状态名称"], value: (parseFloat(data1[i]["总运行时间"]) / 1000).toFixed(2) });
            }

            EchartsT(data[0]["Availability"], d, orderDetia5, arr);

            if (data.length <= 0) {
                alert("没有数据");
                return false;
            }
            $("#Number").text(data[0]["AllOnlineEquipment"]);
            $("#Status0QTY").text(data[0]["RunEquipment"]);
            $("#Status1QTY").text(data[0]["NotRunEquipment"]);
            $("#EndStatus1QTY").text(data[0]["EndRunEquipment"]);
            
            var Axisdata = []
            var Series0 = []
            var Series1 = []
            var Series2 = []

            var dataList = {
                Echarts: {
                    Axis: [100],
                    Series: [30, 28, 0, 2]
                },
                List: data
                //List: [{
                //    StatusID:1,
                //    OrderId: 100,
                //    OrderNo: "W20240328001",
                //    EquipmentId: 10001,
                //    EquipmentNo: "EQ2403280940",
                //    LineMachineRelation: "",
                //    CurrentTime: "2024-03-28 9:40:34.217",
                //    ClassTime: "2024-03-28 9:40:34.217",
                //    YCTime: "2024-03-28 9:40:37.217",
                //    WDDTime: "2024-03-29 9:40:38.217",
                //    LineName: "注塑线一",
                //    KZDW: "生产中",
                //    ItemName: "顶盖",
                //    ItemCode: "FS-051-00100-9",
                //    Output: "146",
                //    DeviceTonnage:"100"
                //}, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SC-63蜗杆",
                //        ItemCode: "FS-051-0035-8",
                //        Output: "133",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 0,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "0",
                //        DeviceTonnage: "0"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SC-63蜗杆",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "132",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SC-63蜗杆",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "156",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线三",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "98",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "96",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "75",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 0,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "0",
                //        DeviceTonnage: "0"
                //    }, {
                //        StatusID: 0,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线二",
                //        KZDW: "生产中",
                //        ItemName: "SC-63蜗杆",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "0",
                //        DeviceTonnage: "0"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "178",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "139",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "157",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "SH-08CC成品",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 0,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "0",
                //        DeviceTonnage: "0"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线三",
                //        KZDW: "生产中",
                //        ItemName: "SV-33轴承",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "192",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "SH-0863成品",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "230",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "SC-63蜗杆",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "204",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 0,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SV-32轴承",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "0",
                //        DeviceTonnage: "0"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SV-31轴承",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "76",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SH-0896成品",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SC-63蜗杆",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "83",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SC-718轴",
                //        ItemCode: "FS-051-00100-6",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线三",
                //        KZDW: "生产中",
                //        ItemName: "SC-718轴",
                //        ItemCode: "GS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "支架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SH-09CG成品",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SCB-70联塑器",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SCB-70联塑器",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //    LineName: "注塑线三",
                //        KZDW: "生产中",
                //    ItemName: "SCB-70联塑器",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SCB-70联塑器",
                //        ItemCode: "YS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //    ItemName: "SCB-70灯架",
                //        ItemCode: "FS-051-00100-8",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //    LineName: "注塑线三",
                //        KZDW: "生产中",
                //        ItemName: "SCB-70灯体",
                //        ItemCode: "FS-051-00100-6",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }, {
                //        StatusID: 0,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "SCB-70黄光校车灯",
                //        ItemCode: "LS-051-00100-5",
                //        Output: "0",
                //        DeviceTonnage: "0"
                //    }, {
                //        StatusID: 1,
                //        OrderId: 100,
                //        OrderNo: "W20240328001",
                //        EquipmentId: 10001,
                //        EquipmentNo: "EQ2403280940",
                //        LineMachineRelation: "",
                //        CurrentTime: "2024-03-28 9:40:34.217",
                //        ClassTime: "2024-03-28 9:40:34.217",
                //        YCTime: "2024-03-28 9:40:34.217",
                //        WDDTime: "2024-03-28 9:40:34.217",
                //        LineName: "注塑线一",
                //        KZDW: "生产中",
                //        ItemName: "SCB-70黄光校车灯SCB",
                //        ItemCode: "GS-051-00100-18",
                //        Output: "146",
                //        DeviceTonnage: "100"
                //    }]
            };

            startindex = endindex
            productstartindex = productendindex
            if (dataList.Echarts.Axis.length < endindex + 36) {
                endindex = dataList.Echarts.Axis.length
            }
            else {
                endindex = endindex + 36
            }

            if (dataList.List.length < productendindex + 36) {
                productendindex = dataList.List.length
            }
            else {
                productendindex = productendindex + 36
            }

            var tableDataList = []
            for (var i = productstartindex; i < productendindex; i++) {
                tableDataList.push(dataList.List[i])
            }


            $("#tableData").html("");

            var tableDataNum = 36;
            var html = "<div  id='DingWei1' class='row' style='margin-left:-10px;margin-right:10px;height:50%;'>";
            for (var i = 0; i < tableDataNum; i++) {
                if (workshopId == "2") {
                    if (i == 18) html += "</div><div id='DingWei3' class='row' style='margin-left:-10px;margin-right:10px;height:50%;'>";
                    //else if (i == 36) html += "</div><div id='DingWei2' class='row displayNone' style='margin-left:-10px;margin-right:10px;height:50%;'>";
                    //else if (i == 48) html += "</div><div id='DingWei4' class='row displayNone' style='margin-left:-10px;margin-right:10px;height:50%;'>";
                }
                if (i >= tableDataList.length) {

                    html += "<div class='col-md-2'>"

                    html += "</div>"
                } else {
                    var statusId = Number(tableDataList[i].StatusID);
                    //var radstr = tableDataList[i].StatusID == 1 ? "#2E8B57" : "#FF6C00"
                    switch (statusId) {
                        case 0:
                        case 3:
                        case 4:
                        case 5:
                        case 7:
                        case 8:
                        case 9:
                        case 10:
                        case 11:
                        case 12:
                            radstr = "#FF6C00;color:black;"; //异常    //"#F79F81"; // 停机维修
                            // radstr = "#9400D3";  //停机换模
                            break;
                        case 1:
                            radstr = "#2E8B57;";  //正常生产
                            break;
                        case 2:
                            radstr = "#808080";  //通讯中断
                            break;
                        //case 3:
                        //    radstr = "#9400D3";  //停机换模
                        //    break;
                        //case 4:
                        //    radstr = "#778899";  //停机试模
                        //    break;
                        //case 5:
                        //    radstr = "red";      //设备关机
                        //    break;
                        case 6:
                            radstr = "#B7AEAE;";//"#5A5AF7"      //无生产计划  无订单
                            break;
                    }
                    html += "<div style=' float: left;height:50%;font-weight:bold' class='table_box'>"
                    //html += "<table onclick=\"showTable('" + tableDataList[i].OrderId + "','" + tableDataList[i].OrderNo + "','" + tableDataList[i].EquipmentId + "','" + tableDataList[i].EquipmentNo + "','" + tableDataList[i].LineMachineRelation + "')\" onmousemove=\"ShowAlt('" + tableDataList[i].CurrentTime + "','" + tableDataList[i].ClassTime + "','" + tableDataList[i].YCTime + "','" + tableDataList[i].WDDTime + "', $(this))\" onmouseout='HideAlts($(this))' class='itemTable' border='3' cellspacing='1' style='border-collapse:collapse;background-color:" + radstr + "'><tbody>"
                    html += "<table class='itemTable' border='3' cellspacing='1' style='border-collapse:collapse;background-color:" + radstr + "'><tbody>"
                    html += "<tr><td colspan ='4' style='overflow: hidden;'><img src='../../Content/images/20240328095151.png'  /></td><td id='Machine' colspan ='2' style='text-align:center'>" + tableDataList[i].LineName + "<br />" + tableDataList[i].KZDW + "<br />" + tableDataList[i].ManagementStatus + "</td></tr>"
                    html += "<tr><td colspan ='2' style='text-align: center;'>产品名称</td><td colspan ='4'>&nbsp;" + tableDataList[i].ItemName + "</td></tr>"
                    html += "<tr><td colspan ='2' style='text-align: center'>产品编码</td><td colspan ='4' style='transform: scale(.8);transform-origin: left; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.80);'>&nbsp;" + tableDataList[i].ItemCode + "</td></tr>"
                    html += "<tr><td colspan ='3' style='text-align: center;'>时间稼动率</td><td colspan ='3'>&nbsp;&nbsp;" + tableDataList[i].Output + "</td></tr>"
                    html += "<tr><td colspan ='2' style='text-align: center'>OEE</td><td colspan ='4'>&nbsp;" + tableDataList[i].DeviceTonnage + "</td></tr></tbody></table>"
                    html += "</div>"
                }

            }
            html += "</div>"
            html += "<div id='showAlts' style='display:none;font-size:18px;padding:16px;float: left;width:766px;height:346px;font-weight:bold;z-index:100;position:fixed;top:320px;left:470px;background:rgba(0,0,0,0.6);'>";
            html += "<p><span style='color:#95CA13;'>当前时间：</span><span id='CurrentTime'> </span></p>"
            html += "<p><span style='color:#95CA13;'>开班时间：</span><span id='ClassTime'> </span></p>"
            html += "<p><span style='color:#95CA13;'>异常时间：</span><span id='YCTime'> </span>"
            /*html += ", 无订单：<span id='WDDTime'></span>min</p> "*/
            html += "<p style='color:#FF6C00;padding-top:10px;'>运行时间 = 当前时间 - 开班时间 - 异常时间</p>"
            html += "<p style='font-size:16px;color:#FFC90E;padding-top:20px;'>  <sapn style='padding-left:260px'> 当前时间 - 开班时间 - 异常时间 </span><br />"
            html += "<strong style='font-size:18px;'>开机率 = ----------------------------------------------------------------------  * 100%</strong><br />"
            html += "<sapn style='padding-left:90px'>当前时间 - 开班时间 - 固定保养时间(0.5小时/班) - 无订单时间 - 试模时间 </span> </p>"
            html += "</div>"
            $("#tableData").html(html)

            if (productendindex == dataList.List.length) {
                productstartindex = productendindex = 0
            }

            if (endindex == dataList.Echarts.Axis.length) {
                startindex = endindex = 0
            }
        }

        function showTable(OrderId, OrderNo, EquipmentId, EquipmentNo, LineMachineRelation) {
            var w = $(window).width() - 150;
            var h = $(window).height() - 100;
            var openWinUrl = "../../Client/LnjectionMolding.aspx?OrderId=" + OrderId + "&OrderNo=" + OrderNo + "&EquipmentId=" + EquipmentId + "&EquipmentNo=" + EquipmentNo + "&LineMachineRelation=" + LineMachineRelation + "&win=1"
            dialog({ title: "机台信息", src: openWinUrl, width: w, height: h });
        }

        function ShowAlt(CurrentTime, ClassTime, YCTime, WDDTime, obj) {

            var hei = $("#_layout_left_table").outerHeight();
            //所以机台的宽度和高度
            var dataWidth = $("#tableData").outerWidth();
            var dataHeight = $("#tableData").outerHeight();
            //一个机台的宽度和高度
            var width = $(obj).outerWidth();
            var height = $(obj).outerHeight();

            var h = hei - dataHeight;//机台上面的高度

            var top = $(obj).offset().top;
            var left = $(obj).offset().left;
            if (top > (dataHeight / 2 + h - 50)) { //凭直觉减50
                top = top - height * 2;
            } else {
                top = top + height;
            }
            if (left > (dataWidth / 2)) {
                left = left - width * 2;
            } else {
                left = left + width;
            }
            $("#showAlts").css({ "display": "block", "top": top, "left": left });
            $("#CurrentTime").html(CurrentTime);
            $("#ClassTime").html(ClassTime);
            $("#YCTime").html(YCTime);
            $("#WDDTime").html(WDDTime);

            //window.clearInterval(int);
        }


        function HideAlts(obj) {
            $("#showAlts").css("display", "none");
            //int = setInterval('DingWei()', times);
        }

        function DingWei() {
            $("#DingWei1").toggleClass("displayNone");
            $("#DingWei3").toggleClass("displayNone");
            $("#DingWei2").toggleClass("displayNone");
            $("#DingWei4").toggleClass("displayNone");

            //如果不写清除，它会跑的越快，并没有依照times的时间进行间隔执行
            //window.clearInterval(int);
            //int = setInterval('DingWei()', times);
            clearTimeout(int);
            var int = setTimeout("DingWei()", times);
        }

        function EchartsT(val, d, orderDetia5, arr) {
            var myChart = echarts.init(document.getElementById('echarts_uph'));
            var option = {
                tooltip: {
                    formatter: '{a} <br/>{b} : {c}%'
                },
                series: [
                    {
                        name: '时间稼动率',
                        startAngle: 180,
                        endAngle: 0,
                        type: 'gauge',
                        radius: '90%',
                        center: ["50%", "70%"],
                        min: 0,
                        max: 100,
                        splitNumber: 4,
                        axisLine: {            // 坐标轴线
                            lineStyle: {       // 属性lineStyle控制线条样式
                                color: [[0.2, '#1EB950'], [0.8, '#F79F81'], [1, 'red']],
                                width: 10,
                                shadowColor: '#fff', //默认透明
                                shadowBlur: 2
                            }
                        },
                        axisLabel: {
                            show: true,
                            formatter: function (value) {
                                return parseInt(value) + "%";
                            }
                        },
                        detail: {
                            //formatter: "机台使用率 {value}%",
                            formatter: "时间稼动率 {value}%",
                            offsetCenter: [0, '20%'],
                            textStyle: {
                                color: '#3CA2B0',
                                fontSize: 15
                            }
                        },
                        data: [{ value: val }]
                    }
                ]
            };
            myChart.setOption(option);

            var myChart1 = echarts.init(document.getElementById('echarts_uph2'));
            //<span class="cell" style="font-size: 20px; color: #38FFFF; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">联机数量：0</span>
            var option1 = {
                title: {
                    text: '机台状态汇总',
                    left: 'center',
                    textStyle: {
                        color: '#38FFFF'
                    },
                },
                series: [
                    {
                        name: '机台汇总状态',
                        type: 'pie',
                        radius: '60%',
                        center: ['50%', '60%'],
                        itemStyle: {
                            normal: {
                                color: function (p) {
                                    //var colorList = ['#1EB950', '#F79F81', '#FFA500', '#9400D3', '#778899', '#C12E34', '#5A5AF7'];
                                    var colorList = ['#1EB950', '#FF6C00', '#B7AEAE'];
                                    var index = p.dataIndex;
                                    return colorList[index];
                                }
                            }
                        },
                        data: d,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            myChart1.setOption(option1);


            var echart5 = echarts.init(document.getElementById("echarts_top5nc"));
            option5 = {
                title: {
                    text: 'Top5异常(min)',
                    textStyle: {
                        fontSize: 22,
                        color: '#FFFFFF',          // 主标题文字颜色

                    },
                    left: '10'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true,
                    show: false,
                },
                legend: {
                    x: 'center',
                    y: 'bottom',
                    padding: [0, 0, 20, 0],
                    textStyle: {
                        fontSize: 15,
                        color: '#58B2D4'
                    },
                    data: orderDetia5
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: orderDetia5,
                        axisLabel: {
                            textStyle: {
                                color: '#4EC9CE',//坐标值得具体的颜色
                                fontSize: 12, //x轴值说明字体大小，
                            },
                            /*Add By Alen 2018-02-05 看板柱状图标签换行显示，默认每行8个字符*/
                            interval: 0,
                            formatter: function (params) {
                                var newParamsName = "";// 最终拼接成的字符串
                                var paramsNameNumber = params.length;// 实际标签的个数
                                var provideNumber = 2;// 每行能显示的字的个数
                                var rowNumber = Math.ceil(paramsNameNumber / provideNumber);// 换行的话，需要显示几行，向上取整
                                /**
                                 * 判断标签的个数是否大于规定的个数， 如果大于，则进行换行处理 如果不大于，即等于或小于，就返回原标签
                                 */
                                // 条件等同于rowNumber>1
                                if (paramsNameNumber > provideNumber) {
                                    /** 循环每一行,p表示行 */
                                    for (var p = 0; p < rowNumber; p++) {
                                        var tempStr = "";// 表示每一次截取的字符串
                                        var start = p * provideNumber;// 开始截取的位置
                                        var end = start + provideNumber;// 结束截取的位置
                                        // 此处特殊处理最后一行的索引值
                                        if (p == rowNumber - 1) {
                                            // 最后一次不换行
                                            tempStr = params.substring(start, paramsNameNumber);
                                        } else {
                                            // 每一次拼接字符串并换行
                                            tempStr = params.substring(start, end) + "\n";
                                        }
                                        newParamsName += tempStr;// 最终拼成的字符串
                                    }

                                } else {
                                    // 将旧标签的值赋给新标签
                                    newParamsName = params;
                                }
                                //将最终的字符串返回
                                return newParamsName
                                /*Alen End*/
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#4EC9CE',
                            }
                        },
                        splitLine: {
                            show: false
                        }
                    }],
                yAxis: [
                    {
                        type: 'value',
                        axisLabel: {
                            textStyle: {
                                color: '#4EC9CE',//坐标值得具体的颜色
                                fontSize: 16,
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color: '#4EC9CE',
                            }
                        },
                        splitLine: {
                            lineStyle: {
                                color: '#45576F',
                            }
                        }
                    }],
                series: [
                    {
                        type: 'bar',  //bar柱状图  line曲线图 pie饼图
                        //radius: ['30%', '45%'],
                        //center: ['50%', '50%'],
                        //roseType: 'radius',
                        label: {
                            normal: {
                                show: true,
                                color: "#fff",//58B2D3
                                fontSize: 14, //柱体内的字体大小
                                fontWeight: 'bold',
                                //formatter: "{b}：{d}%"
                            },
                            emphasis: {
                                show: true,
                                fontSize: 16,//鼠标悬浮上去之后柱体内的字体大小
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: '#fff',
                            }
                        },
                        lableLine: {
                            normal: {
                                show: true,
                            },
                            emphasis: {
                                show: true
                            }
                        },
                        itemStyle: {
                            normal: {
                                color: function (p) {
                                    var colorList = ['#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#32E0E7', '#826A4F', '#51DE8A', '#25851D', '#ADC7B8',];
                                    var index = p.dataIndex;
                                    return colorList[index];
                                }
                            }
                        },
                        data: arr
                    }
                ]
            };

            echart5.setOption(option5);

        }

        (function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }
        })(jQuery);

    </script>
    <script type="text/javascript">
        var workshopId, welcomeMsg, workshopName
        var dataList = []
        var i = 20 * 60;
        $(document).ready(function () {

            countDown();//刷新界面

            setInterval(function () { ajaxPull(); }, 600000);/*开启后每10分钟轮询一次. 复制于界面LnjectionMolding 2022-03-03*/

            /*设置title*/
            workshopId = getQueryString("workshopId");
            workshopName = getQueryString("workshopName");
            welcomeMsg = "";

            /* $("#_left_top_title").html(workshopName+ "设备看板");*/
            $("#_left_top_title").html("注塑车间设备看板")
            ResizeAll();

            getWelcome();
            getDateTime();
            initProductionData();

            //if (workshopId == "2") {
            //    DingWei();
            //}

        });

        var GetwelcomeMsg = $.getUrlParam('welcomeMsg');

        function getWelcome() {

            //if (welcomeMsg == "") {
            welcomeMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(14, -1, 2).value;
            //}
            //$("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
            $("#_welcome_text").html(welcomeMsg);//看板全局欢迎词
            $("#_left_top_welcome_text").html(GetwelcomeMsg);//看板欢迎词

            clearTimeout(gwTimeout);
            var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 1);
        }
        var dtTimeout;
        function getDateTime() {
            $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
            if (!!dtTimeout) {
                clearTimeout(dtTimeout);
            }
            dtTimeout = setTimeout("getDateTime()", 1000);
        }

        function initProductionData() {

            $("#data_tbody tbody").html("");
            //initEcharts();
            initEcharts_Static();

            return false;

        }

        /**
        *获取URL参数值
        **/
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

        function ajaxPull() {
            $.ajax({
                type: 'get',
                url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/ajax.html?rnd=" + Math.random(),
                async: true,
                success: function (data) {

                },
                complete: function (XMLHttpRequest, str) {

                },
                datatype: 'text',
                error: function (xhr, status, error) {

                }
            });
        }

        function countDown() {
            i = i - 1;
            if (i == 0) {
                location.reload(true);
            }
            setTimeout('countDown()', 1000);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server" style="overflow: scroll;">
        <table id="_layout" style="height: 93.5%">
            <%--style="height: 93.5%"--%>
            <tr style="height: 100%;">
                <td style="height: 100%;">
                    <table id="_layout_left_table" border="3" cellspacing="2">
                        <tr style="height: 12%;">
                            <td style="height: 12%; vertical-align: top;">
                                <table style="background-color: #0D213A;">
                                    <tr>
                                        <td>
                                            <span class="logo_cus cell" style="margin-left: 15px; width: 245px; display: block; float: left;"></span>
                                        </td>
                                        <td colspan="3" text-align="">
                                            <div class="table" style="float: left; margin-left: 30%">
                                                <span class="cell" id="_left_top_title" style="font-size: 33px; color: #38FFFF; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">-</span>
                                            </div>

                                        </td>
                                        <td>
                                            <div class="table" style="float: left; margin-top: 5%; width: 225px">
                                                <span class="cell" style="font-size: 18px; color: #38FFFF; font-weight: bold;" id="dateAndWeek"></span>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 5%;">
                            <td style="height: 50px; vertical-align: top;">
                                <table style="background-color: #0D213A; height: 50px">
                                    <tr>
                                        <td style="width: 12%">
                                            <div class="table" style="float: left; margin-left: 10%; margin-top: 2%">
                                                <span class="cell" style="font-size: 20px; color: #38FFFF; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">联机数量：<span id="Number"></span></span>
                                            </div>
                                        </td>
                                        <td colspan="3">
                                            <div class="table" style="float: left; height: 40px; width: 80%; margin-left: 15px; margin-top: 10px">
                                                <table border="1" cellspacing="0">
                                                    <tr>
                                                        <td style="background: #1EB950; font-size: 22px; font-weight: bold;" colspan="3" align="center">生产中</td>
                                                        <td align="center" style="background: #BDD7EE; font-size: 22px; font-weight: bold;" id="Status0QTY"></td>
                                                        <%--
                                                        <td style="background: red" colspan="3" align="center">停机维修</td>--%>
                                                        <td style="background: #FF6C00; color: black; font-size: 22px; font-weight: bold;" colspan="3" align="center">非生产中</td>
                                                        <td align="center" style="background: #BDD7EE; font-size: 22px; font-weight: bold;" id="Status1QTY"></td>
                                                        <td style="background: #808080; color: black; font-size: 22px; font-weight: bold;" colspan="3" align="center">通讯中断</td>
                                                        <td align="center" style="background: #BDD7EE; font-size: 22px; font-weight: bold;" id="EndStatus1QTY"></td>
                                                        <%--
                                                        <td style="background: #FFA500" colspan="3" align="center">停机待料</td>
                                                        <td align="center" style="background: #BDD7EE" id="Status2QTY">3</td>
                                                        <td style="background: #9400D3" colspan="3" align="center">停机换模</td>
                                                        <td align="center" style="background: #BDD7EE" id="Status3QTY">4</td>
                                                        <td style="background: #5A5AF7" colspan="3" align="center">停机试模</td>
                                                        <td align="center" style="background: #BDD7EE" id="Status4QTY">5</td>
                                                        <td style="background: #C12E34" colspan="3" align="center">设备关机</td>
                                                        <td align="center" style="background: #BDD7EE" id="Status5QTY">6</td>
                                                        <td style="background: #B7AEAE; font-size: 22px; font-weight: bold;" colspan="3" align="center">无订单</td>
                                                        <td align="center" style="background: #BDD7EE; font-size: 22px; font-weight: bold;" id="Status6QTY">2</td>--%>
                                                    </tr>
                                                </table>
                                            </div>

                                        </td>
                                        <td>
                                            <div class="table" style="float: right; margin-right: -20%; margin-top: 2%">
                                                <span class="cell" style="font-size: 20px; color: #38FFFF; text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;">车间负责人:  <span id="UserName">张浩浩</span></span>
                                            </div>

                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 83%;">
                            <td style="height: 78%;">
                                <table style="border-right: 1px solid #e3e3e3;">
                                    <tr style="height: 82%;">
                                        <td style="width: 85%; vertical-align: top; background-color: #0e223B; border-right: 1px solid #e3e3e3;">
                                            <div id="tableData" style="width: 100%; height: 100%; padding-left: 20px; padding-top: 5px;">
                                            </div>
                                        </td>
                                        <td style="width: 15%;">
                                            <table style="border-top: 1px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                <tr style="border-bottom: 1px solid #e3e3e3;">
                                                    <td style="height: 50%; width: 100%; border-right: 5px solid #041622;">
                                                        <div id="echarts_uph" style="height: 100%; padding-bottom: 10px;">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 50%; width: 100%; border-right: 5px solid #041622; display: none;">
                                                        <div id="echarts_uph2" style="height: 100%; padding-bottom: 10px;">
                                                        </div>
                                                    </td>
                                                    <td style="height: 50%; width: 100%;">
                                                        <div id="echarts_top5nc" style="height: 100%; padding-bottom: 10px;">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div style="height: 6.5%">
            <%-- style="display:none;"--%>
            <ul style="position: absolute; bottom: 5px; height: 40px; width: 100%;">
                <li style="height: 100%;">
                    <div class="table">
                        <%--style="border-top: 1px solid #000000;"--%>
                        <table style="width: 100%;" cellpadding="5" cellspacing="5" border="0">
                            <tr>
                                <td id="_left_top_welcome">
                                    <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                        scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                        <div id="_left_top_welcome_text" style="padding-top: -6px; padding-bottom: 20px; font-size: 30px; color: red; font-weight: bold;">
                                            热烈欢迎各位领导莅临参观指导
                                        </div>
                                    </marquee>
                                </td>
                            </tr>
                        </table>
                    </div>
                </li>
            </ul>
        </div>
    </form>
</body>
</html>
