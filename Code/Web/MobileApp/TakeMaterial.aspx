<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TakeMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.TakeMaterial" %>

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
    <title>物料备料</title>
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
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false;">
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 3px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">物料备料</label>
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
                            <label for="orderno">
                                单据类型:</label>
                        </td>
                        <td colspan="3">
                            <select id="ddlType" name="ddlType">
                                <option value="0">工单</option>
                                <option value="1">领料单</option>
                                <option value="2">退料单</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="orderno">
                                单号:</label>
                        </td>
                        <td colspan="3">
                             <select id="ddlOrder" name="ddlOrder"></select>
                             <div id="divtxtOrder" style="display: none;"><input type="text" id="txtOrder"  /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="orderno">
                                物料编码:</label>
                        </td>
                        <td colspan="3">
                              <input type="text" id="txtItemCode" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td style="padding: 0 0.5rem;">
                              <a data-corners="false" id="btnGO" data-role="button" data-fullscreen="true">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;料</a>
                              
                        </td>
                        <td style="padding: 0 0.5rem;">
                            <a data-corners="false" id="btnNoGO" data-role="button" data-fullscreen="true">取消备料</a>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="width: 100%; text-align: center;font-size:15px;font-weight:bold;">
                </div>
                <div id="testtab" style="margin-top: 3px; position: relative">
                    <table data-role="table" id="datatab" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th style="width: 6rem;">物料编码</th>
                                <th style="width: 4.5rem;">需求量</th>
                                <th style="width: 4.5rem;">货位</th>
                                <th style="width: 4.5rem;">GRN</th>
                                <th style="width: 4.5rem;">数量</th>
                                <th style="width: 4.5rem;">状态</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript" src="js/jqPaginator.js"></script>
    <script type="text/javascript" src="js/jquery.nicescroll.js"></script>
<script type="text/javascript">

        $(function () {
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#ddlType").change(function () {
                setMsg("", "");
                if ($(this).val() == "0") {
                    $("#datatab tr[name='data']").remove();
                    $("#txtOrder").val("");
                    $("#txtItemCode").val("");
                    //根据工单绑定
                    $("#ddlOrder").parent().parent().show();
                    $("#txtOrder").hide();
                    $("#divtxtOrder").hide();
                    GetOrder();
                    $("#ddlOrder-button").find("span").html("-选择工单-");
                } else if ($(this).val() == "1") {
                    $("#datatab tr[name='data']").remove();
                    $("#txtOrder").val("");
                    $("#txtItemCode").val("");
                    $("#ddlOrder-button").find("span").html("-选择工单-");
                    //根据领料单绑定
                    //GetLoadReuestOrder();
                    $("#ddlOrder").parent().parent().hide();
                    $("#txtOrder").val("").show();
                    $("#divtxtOrder").show();
                } else if ($(this).val() == "2") {
                    $("#datatab tr[name='data']").remove();
                    $("#txtOrder").val("");
                    $("#txtItemCode").val("");
                    $("#ddlOrder-button").find("span").html("-选择工单-");
                    //退料单
                    //GetRecord();
                    $("#ddlOrder").parent().parent().hide();
                    $("#txtOrder").val("").show();
                    $("#divtxtOrder").show();
                }
            });
            GetOrder();

            $("#ddlOrder").change(function () {
                bindtable(0);
            });

            $("#txtOrder").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    bindtable(0);
                }
            });
            $("#txtItemCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    bindtable(0);
                }
            });
        });
        $("#btnGO").on("click", function () { bindtable(1); });
        $("#btnNoGO").on("click", function () { bindtable(2); });
        function GetRecord() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.GetRecord();
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return false;
            }
            var list = ajax.value;
            if (list.length == 0) {
                $("#ddlOrder").html("<option value='-1'>没有退料单号</option>");
                return false;
            }
            var oprType = "<option value='-1'>-选择退料单-</option>";
            for (var i = 0; i < list.length; i++) {
                oprType += "<option value='" + list[i] + "'>" + list[i] + "</option>";
            }
            $("#ddlOrder").html(oprType);
        }
        function GetOrder() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetLinePlanList("");
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                $("#ddlOrder").html("");
                return false;
            }
            var list = ajax.value;
            if (list.length == 0) {
                $("#ddlOrder").html("<option value='-1'>没有生产排程工单号</option>");
                $("#ddlOrder").html("");
                return false;
            }
            var oprType = "<option value='-1'>-选择工单-</option>";
            for (var i = 0; i < list.length; i++) {
                oprType += "<option value='" + list[i].PlanOrderNo + "'>" + list[i].PlanOrderNo + "</option>";
            }
            $("#ddlOrder").html(oprType);
        }
        function GetLoadReuestOrder() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.GetRequestOrder();
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            var list = ajax.value;
            if (list.length == 0) {
                $("#ddlOrder").html("<option value='-1'>没有对应的领料单</option>");
                return;
            }
            var oprType = "<option value='-1'>-选择领料单-</option>";
            for (var i = 0; i < list.length; i++) {
                oprType += "<option value='" + list[i] + "'>" + list[i] + "</option>";
            }
            $("#ddlOrder").html(oprType);
        }
        function bindtable(lockgrn) {
            var code = "";
            var type = $.trim($("#ddlType").val());
            if (type=="0") {
                code = $("#ddlOrder").val();
                if ($.trim($("#ddlOrder").val()) == "-1") {
                    setMsg("请选择单号", "red");
                    return;
                }
            } else{
                code = $.trim($("#txtOrder").val());
                if ($.trim($("#txtOrder").val()) == "") {
                    setMsg("请扫描单号", "red");
                    return;
                }
            } 
            var array = [];
            if (lockgrn == 2) {
                $("td[name='cbarcode']").each(function () {
                    array.push($(this).text());
                });
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.GetTakeGRNInfo(type, code, lockgrn, array, $("#txtItemCode").val());
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            if (lockgrn == 1) {
                setMsg("备料成功", "red");
            }
            else if (lockgrn == 2) {
                setMsg("取消成功", "red");
                return;
            }
            else {
                setMsg("", "");
            }
            var str = "";
            for (var i = 0; i < ajax.value.length; i++) {
                str += "<tr name='data'><td>" + ajax.value[i].ItemCode + "</td><td>" + ajax.value[i].NeedQty + "</td><td name='cbarcode'>" + ajax.value[i].cBarCode + "</td><td>" + ajax.value[i].SerialNumber + "</td><td>" + ajax.value[i].BalanceQty + "</td><td>" + ajax.value[i].LockCode + "</td><tr/>";
            }
            $("#datatab tr[name='data']").remove();
            $("#datatab").append(str);
        }
        //控制Msg的显示
        function setMsg(s, r) {
            $("#msg").html(s);
            $("#msg").css("color", r);
        }
    </script>
</body>
</html>
