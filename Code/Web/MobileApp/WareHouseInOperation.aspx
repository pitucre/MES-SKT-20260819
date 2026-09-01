<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WareHouseInOperation.aspx.cs"
    Inherits="SKT.LeanMES.Web.MobileApp.WareHouseInOperation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>仓库收料</title>
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
        a.link-disable { background-color: #c3c3c3; border-color: #999; }

        #slider2 { display: none; }
        .button-label { position: relative; display: inline-block; width: 80px; height: 25px; background-color: #ccc; box-shadow: #ccc 0px 0px 0px 2px; border-radius: 30px; overflow: hidden; }
        .circle { position: absolute; top: 0; left: 0; width: 30px; height: 25px; border-radius: 50%; background-color: #fff; }
        .button-label .text { line-height: 25px; font-size: 13px; text-shadow: 0 0 2px #ddd; }
        .on { color: #fff; display: none; text-indent: 10px; }
        .off { color: #fff; display: inline-block; text-indent: 50px; }
        .button-label .circle { left: 0; transition: all 0.3s; }
        #slider2:checked + label.button-label .circle { left: 50px; }
        #slider2:checked + label.button-label .on { display: inline-block; }
        #slider2:checked + label.button-label .off { display: none; }
        #slider2:checked + label.button-label { background-color: #51ccee; }
        .popedomBtn {
            display: none;
        }
    </style>
</head>
<body>
    <%--仓库收料--%>
    <form runat="server">
        <div data-role="page" data-url="setpage" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <%--       <div>
                        <img src="images/icon/wh_white.png" />
                        
                    </div>
                    <div>
                        仓库收料
                    </div>--%>
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">仓库收料</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table style="width: 100%; z-index: 2">
                    <tr>
                        <td>
                            <label style="background:#fff;color:#1d1007;border-color:#fff"><input name="receivingMethod" type="radio" checked="checked" value="105"  />送货单 </label> 
                        </td>
                        <td>
                            <label style="background:#fff;color:#1d1007;border-color:#fff"><input name="receivingMethod" type="radio" value="103" />采购单 </label> 
                        </td>
                    </tr>
                     <tr class="popedomBtn">
                        <td>
                            <label>不扫描物料条码,直接收料：</label>
                        </td>
                        <td colspan="3">
                            <!-- 注意：label的for属性 要与其对应的input的id相对应，div包裹的内容需一行显示！-->
                            <div class="slider2-wrapper" data-role="none"><input type="checkbox" id="slider2" name="switch" data-role="none"><label for="slider2" class="button-label" data-role="none"><span class="circle" data-role="none"></span><span class="text off" data-role="none">关</span><span class="text on" data-role="none">开</span></label></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="orderno">
                                来源单号:</label>
                            <input class="orderno" id="orderno" data-corners="false" type="text" data-mini="true"  androidScan="true"
                                value="" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" style="margin-top: 22px" onclick="selectOrder()">选择单据</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label for="suppliername">
                                供应商名称:</label>
                            <input class="suppliername" id="suppliername" data-corners="false" type="text" data-mini="true"
                                value="" readonly="readonly" />
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                        <td>
                            <label for="sn">
                                暂存库位:</label>
                        </td>
                        <td colspan="2">
                            <input class="WarehouseBarCode" id="WarehouseBarCode" data-corners="false" type="text" data-mini="true" value=""   androidScan="true"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="sn">
                                物料/包装箱条码:</label>
                        </td>
                        <td colspan="2">
                            <input class="status" id="sn" data-corners="false" type="text" data-mini="true" value="" androidScan="true" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="">
                </div>

                <div style="margin-top: 3px">
                    <div>
                        <strong>到货单明细 </strong>
                    </div>
                    <table data-role="table" id="arrivaltable" <%--data-mode="reflow"--%> data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>物料编码
                                </th>
                                <th>物料名称
                                </th>
                                <th>收货数量
                                </th>

                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="StartCheck" onclick="OnCancel()" data-corners="false" data-role="button"
                            data-fullscreen="true" data-theme="a">重新扫描</a>
                        </li>
                        <li><a class="StartCheck" onclick="Save()" data-corners="false" data-role="button"
                            data-fullscreen="true" data-theme="a">收料</a></li>
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
    
    <script type="text/javascript">
        receiveChoosePageId = $("input[name='receivingMethod']:checked").val();
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        var refreshGRNDetail = "";
        var IsScanGRN = 0;
        var configTypeId = -1;  //配置类型 1：物料条码打印 2：仓库收料 3：是否备料确认 4：发料是否交接 5：入库是否交接 6：供应商是否交期维护
        var flag = 1;
        var yxj = $("#switch option:selected").val();
        ($("#zhijie").is(':checked') == true) ? IsScanGRN = 1 : IsScanGRN = 0; //alert(zhijie)//0:扫描物料条码  1：不扫描物料条码
        var orderno = $("#orderno").val();
        var QtyArr = [];

        /*JS检查用户是否具有某一权限*/
        function IsHasPermission(userId_int, popedom_int) {
            return SKT.LeanMES.Web.AjaxServices.AjaxClient.IsPermission(userId_int, popedom_int).value;
        }

        $(document).ready(function () {

            if (IsHasPermission(userId, 11480016)) {
                $(".popedomBtn").show();
            }

            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $(".ui-body-c").css("background", "#fff");
            $("#orderno").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
            $("#sn").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC"); });
            //获取物料仓库收料信息
            //$.post("../Handler/WareHouseInOperation.ashx?api=AjaxMaterialConfig", {}, function (ajax) {
            //    entity = $.parseJSON(ajax).data[0];
            //    configTypeId = entity.ConfigTypeId;
            //});
            ///modified by zhi.li 20180623
            configTypeId = receiveChoosePageId == "105" ? 3 : 1;
            //初始化加载扫描情况
            IsScanGRN = $("#slider2").prop("checked") == true ? 1 : 0;


            $("input[name='receivingMethod']").on("click", function () {
                receiveChoosePageId = $("input[name='receivingMethod']:checked").val();
                configTypeId = receiveChoosePageId == "105" ? 3 : 1;
            });

            //不扫描收料
            $("#slider2").on("change", function (e) {
                var checked = $(this).prop("checked");
                if (checked) {
                    IsScanGRN = 1; //不需要扫描物料条码
                    $("#sn").attr("disabled", true);
                    
                } else {
                    QtyArr = [];
                    IsScanGRN = 0; 
                    $("#sn").attr("disabled", false);
                }
              
                //重新刷新数量
                GetInfo();
                return false;
            });


            //聚焦来源单据 ，绑定扫描事件
            $("#orderno").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html('');
                    $("#arrivaltable tbody").html('');
                    QtyArr = [];
                    if ($(this).val() == "") {
                        $("#msg").html("单号不能为空!").css({ "color": "red", "text-align": "center" });
                        $(this).focus();
                        return false;
                    }
                    //显示table
                    GetInfo();
                    $("#WarehouseBarCode").val('').focus();
                }
            });
            //聚焦物料条码 ，绑定扫描事件
            $("#sn").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html('');
                    if ($(this).val() == "") {
                        $("#msg").html("条码不能为空!").css({ "color": "red", "text-align": "center" });
                        $(this).focus();
                        return false;
                    }
                    try {
                        //检验物料条码， 收料
                        if (checkScanGRN($(this).val())) {
                            $("#msg").html("[" + $(this).val() + "]扫描成功").css({ "color": "#2ecc71", "text-align": "center" });
                            $("#sn").val('');
                            $("#sn").focus();
                        }
                        else {
                            $("#sn").val('');
                            $("#sn").focus();
                        }
                        $("#sn").select();
                    } catch (e) {
                        $("#msg").html(e).css({ "color": "red", "text-align": "center" });
                        $("#sn").val('');
                        $("#sn").focus().select();
                        return false;
                    }
                }
            });
            //聚焦物料条码 ，绑定扫描事件
            $("#WarehouseBarCode").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html('');
                    if ($(this).val() == "") {
                        $("#msg").html("库位条码不能为空!").css({ "color": "red", "text-align": "center" });
                        $(this).focus();
                        return false;
                    }
                    try {
                        checkbarcode();
                        //$("#sn").focus().select();
                        //$("#sn").select();
                    } catch (e) {
                        $("#msg").html(e).css({ "color": "red", "text-align": "center" });
                        $("#sn").focus().select();
                        return false;
                    }
                }
            });
            //add by weixia on 2018.8.27筛选新的方法
            $("#btnFilter").on("click", function () {
                $("#listviews").html("");
                receiveChoosePageId = $("input[name='receivingMethod']:checked").val();
                var $ul = $(this),
                value = $.trim($("input[data-type='search']:eq(0)").val());

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetShowOrder(receiveChoosePageId, value);
                if (ajax.error != null) {
                    $("#showGrn").html(ajax.error.Message);
                    $("#showGrn").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }

                var entity = ajax.value;
                if (entity.error != null) {
                    confirmDialogFocus(entity.error, function () {
                        $("#orderno").focus();
                    });
                };
                var ulhtml = "";
                for (var i = 0; i < entity.length; i++) {
                    if (ulhtml.indexOf(entity[i].POCode) == -1) {
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' title=\"" + entity[i].POCode + "\"><a onclick='SetPOCode(this)'>" + entity[i].POCode + "</a></li>";
                    }
                }
                $("#listviews").html(ulhtml);
                $("#listviews").listview("refresh");
            });
        });

        function checkbarcode() {
            //验证库位
            $.post("../Handler/InStock.ashx?api=GetBarCode", { "station": $.trim($("#WarehouseBarCode").val()) }, function (ajax) {
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message, function () {
                        $("#station").val('').focus();
                    });
                    return false;
                }
                var en = $.parseJSON(ajax);
                if (!en.BarCode) {
                    $("#msg").html("库位【" + $("#WarehouseBarCode").val() + "】不存在!").css({ "color": "red", "text-align": "center" });
                    $("#WarehouseBarCode").val("");
                    $("#WarehouseBarCode").focus();
                    return false;
                }
                else {
                  
                    $("#msg").html("库位扫描成功").css({ "color": "red", "text-align": "center" });
                    $("#sn").focus();
                    return true;
                }
            });
        }

        /*通过GRN获取物料信息*/
        function GetGRNInfo(list) {
            if (list != null && list.length > 0) {
                if (list == null || list.length == 0) {
                    return false;
                }
                var strHtml = "";
                for (var i = 0; i < list.length; i++) {
                    var isScanGRN = list[i].IsGRNScan;  //0表示没有扫描 1表示扫描
                    if (isScanGRN == 0) {
                        continue;
                    }
                    else {
                        strHtml += "<tr class='ListTableOddRow'>";
                    }
                    strHtml += "<td>" + list[i].GRN + "</td>";
                    strHtml += "<td>" + list[i].ItemCode + "</td>"
                        + "<td>" + list[i].ItemName + "</td>"
                        + "<td>" + list[i].LotCode + "</td>"
                        + "<td>" + list[i].BalanceQty + "</td>"
                        + "<td>" + userName + "</td>";
                    strHtml += "</tr>";
                }
                $("#smtable tr:gt(0)").remove();
                $("#smtable tbody").append(strHtml);
                $("#smtable").table("refresh");
            }
            else {
                $("#smtable tr:gt(0)").remove();
                $("#smtable tbody").append('<tr class="ListTableOddRow"><td colspan="10" style="text-align: center;"><font color="red">暂无数据</font></td></tr>');
                $("#smtable").table("refresh");
            }
        }
        //验证物料条码/包装条码
        function checkScanGRN(scanGRN) {
            //来源单号
            deliverOrder = $.trim($("#orderno").val());
            if (deliverOrder == "") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetReceiveOrderBySN(scanGRN, receiveChoosePageId);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css({ "color": "red", "text-align": "center" });
                    return false;
                }
                var en = $.parseJSON(ajax.value).data;
                if (en[0].ReceiveOrder != "") {
                    deliverOrder = en[0].ReceiveOrder;
                    
                } 
            }
            if (deliverOrder == "") {
                $("#msg").html("扫描获取单据数据为空，请先切换单据类型或者选择单据后再扫描").css({ "color": "red", "text-align": "center" });
                return false;
            }

            var poDetailId = -1;
            $("#zhijie").find(":checkbox:checked").each(function () {
                poDetailId = $(this).val();
            });
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetGRNInfoByReceive(configTypeId, scanGRN, deliverOrder, poDetailId);

            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message).css({ "color": "red", "text-align": "center" });
                return false;
                $("#orderno").val("")
            } else {
                //成功显示table
                $("#orderno").val(deliverOrder);
                GetInfo(deliverOrder, "-1");
                return true;
            }
        }

        //验证物料条码/包装条码
        function OnCancel() {
            if ($("#orderno").val() == "") {
                $("#msg").html("单号不能为空!").css({ "color": "red", "text-align": "center" });
                $("#orderno").focus();
                return false;
            }
            confirmDialog('确定重新扫描?', function () {
                //恢复不扫描物料条码,直接收料为原始状态
                QtyArr = [];
                IsScanGRN = 0;
                $("#sn").attr("disabled", false);
                $("#slider2").attr("checked", false);


                //来源单号
                var mydeliverOrder = $.trim($("#orderno").val());
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.OnCancelGRN(mydeliverOrder);

                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css({ "color": "red", "text-align": "center" });
                    return false;

                } else {
                    $("#msg").html("已扫描条码清空完成！").css({ "color": "green", "text-align": "center" });
                    GetInfo();
                    return true;
                }
            });
        }

        //获取信息 显示table
        function GetInfo() {
            receiveChoosePageId = $("input[name='receivingMethod']:checked").val();
            configTypeId = receiveChoosePageId == "105" ? 3 : 1;///modified by zhi.li 20180623
            $.post("../Handler/WareHouseInOperation.ashx?api=GetMaterialDeliverDtl", { "orderno": $("#orderno").val(), "configTypeId": configTypeId, "IsScanGRN": Boolean(IsScanGRN) }, function (ajax) {
                receiveChoosePageId
                var ajax1 = $.parseJSON(ajax);
                if (ajax1.error != null) {
                    confirmDialogFocus(ajax1.error, function () {
                        $("#arrivaltable tr:gt(0)").remove();
                        $("#suppliername").val("");
                        $("#orderno").focus();
                    });
                    return false;
                }
                var entity = $.parseJSON(ajax).data;
                var entityGRN = $.parseJSON(ajax).data1;

                OrderList = [];
                //添加送货项列表
                $.grep(entity, function (e, i) {
                    OrderList.push(e);
                });
                if (refreshGRNDetail == "RefreshGRN") {
                    //GetGRNInfo(entityGRN);
                }
                else {

                    GetOrderDelList(entity);
                    //GetGRNInfo(entityGRN);
                }
            });
        }
        //table生成
        function GetOrderDelList(entity) {
           
            if (entity != null && entity.length > 0) {
                if ($("#arrivaltable tbody tr") > 0) {
                    $("#arrivaltable tbody tr").removeAttr("style");
                }
                //当扫描GRN条码的时候，查出送货单和供应商信息
                //$("#suppliercode").val(entity[0].VendorCode); //供应商编码
                $("#suppliername").val(entity[0].VendorName); //供应商名称
                //初始化
                if (QtyArr.length == 0) {
                    for (var j = 0; j < entity.length; j++) {
                        QtyArr[j] = entity[j].ReceiveQty;
                    }
                }
                $("#arrivaltable tr:gt(0)").remove();
                var htmlstr = "";
                var mark = -1;
                for (var i = 0; i < entity.length; i++) {
                    var Rvalues;
                    if (QtyArr.length > 0 && QtyArr[i] != entity[i].ReceiveQty) {
                        mark = i;
                    } 
                    htmlstr += "<tr>";
                    htmlstr += "<td>" + entity[i].ItemCode + " </td>";
                    htmlstr += "<td title=" + entity[i].ItemName + ">" + entity[i].ItemName + " </td>";

                    if (entity[i].ReceiveQty == "") {
                        //GRN已经被删除的情况下
                        Rvalues = 0;

                        entity[i].ReceiveQty = 0;
                    }
                    var temphtml = "";

                    var AScanQty = parseFloat(entity[i].ReceiveQty) + parseFloat(entity[i].AScanQty);
                    Rvalues = AScanQty + "/" +parseFloat(entity[i].SentQty);
                    htmlstr += "<td>" + Rvalues + " </td></tr>"//收货数量
                }
                //重新赋值
                if (QtyArr.length > 0) {
                    for (var j = 0; j < entity.length; j++) {
                        QtyArr[j] = entity[j].ReceiveQty;
                    }
                }
                $("#arrivaltable tbody").append(htmlstr);
                $("#arrivaltable").table("refresh");
                
                if (IsScanGRN == 1) {
                    //数量相等tab行高亮
                    $("#arrivaltable tbody tr").css("background-color", "#7FFF00");
                    $("#arrivaltable").table("refresh");
                    $(document).scrollTop(230);
                }
                else {
                    if (QtyArr.length > 0 && mark > -1) {
                        $("#arrivaltable tbody tr").removeAttr("style");//移除高亮
                        var $tr = $("#arrivaltable tbody tr").eq(mark);
                        $tr.fadeOut(500).fadeIn(500);
                        $("#arrivaltable").prepend($tr);//置顶
                        $tr.css("background-color", "#7FFF00");
                        $("#arrivaltable").table("refresh");
                        $(document).scrollTop(230);
                    }
                }
            }
            else {
                $("#arrivaltable tbody").html('');
                $("#arrivaltable tbody").after('<tr class="ListTableOddRow"><td colspan="10" style="text-align: center";><font color="red">暂无数据</font></td></tr>');
                $("#arrivaltable").table("refresh");
                $("#msg").html("暂无数据！");
                $("#msg").css({ "color": "red", "text-align": "center" });
                $("#orderno").val('').focus();
            }
            $("input[name='SentQty']").focus(function () { $(this).select() });
        }

        function selectDeliverOrder() {
            receiveChoosePageId = $("input[name='receivingMethod']:checked").val();
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + receiveChoosePageId + "&CallBackFunc=setBuyValue&Multiple=false&rnd=" + Math.random(), width: 650, height: 380
            });
        }
        //确认收料
        function Save() {
            var deliverCode = $.trim($("#orderno").val());
            var WarehouseBarCode = $.trim($("#WarehouseBarCode").val());
            if (deliverCode == "") {
                $("#msg").html("到货单号不能为空!").css({ "color": "red", "text-align": "center" });
                $("#orderno").val('').select();
                return false;
            }
            if (typeof (OrderList) == "undefined") {
                $("#msg").html("请扫描GRN");
                $("#msg").css({ "color": "red", "text-align": "center" });
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetMaterialDeliverDtl(deliverCode, "-1", configTypeId, Boolean(IsScanGRN));
            var entitys = JSON.parse(ajax.value).data;
           
            confirmDialog('确定收料?', function () {

                var re = /^[0-9]*[0-9][0-9]*$/;
                if (re.test(entitys[0].ReceiveQty)) {
                    entitys[0].ReceiveQty = entitys[0].ReceiveQty.toFixed(6);
                }
                if (re.test(entitys[0].SentQty)) {
                    entitys[0].SentQty = entitys[0].SentQty.toFixed(6);
                }

                var entity = {};
                entity.ReceiveType = configTypeId;
                entity.IsScanGRN = Boolean(IsScanGRN);
                entity.PoCode = deliverCode;
                entity.UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
                entity.UrgentLevel = 1;
                entity.POTabDtl = JSON.stringify(entitys);
                entity.remark1 = WarehouseBarCode;  //库位条码

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.SaveReceiveMaterial(JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css({ "color": "red", "text-align": "center" });
                    return false;
                }
                $("#msg").html("收料成功!");
                $("#msg").css({ "color": "#2ecc71", "text-align": "center" });
                $("#station").val('');
                $("sn").val('');
                setTimeout(location.reload(), "2000");

            });
        }

        //根据字符串模糊查询采购单
        function selectOrder() {
            $("#listviews").listview("refresh");
            receiveChoosePageId = $("input[name='receivingMethod']:checked").val();// $("#receivingMethod").val();
            $("#listviews").on("filterablebeforefilter", function (e, data) {
                var $ul = $(this)
                $input = $(data.input)
                value = $input.val()     
                //$.post("../Handler/WareHouseInOperation.ashx?api=GetOrderList", { "Id": receiveChoosePageId,"OrderNo":value }, function (ajax) {
                //    $("#listviews").html("");
                //    var entity = $.parseJSON(ajax);
                //    if (entity.error != null) {
                //        confirmDialogFocus(entity.error, function () {
                //            $("#orderno").focus();
                //        });
                //    };
                //    var ulhtml = "";
                //    for (var i = 0; i < entity.length; i++) {
                //        if (ulhtml.indexOf(entity[i].POCode) == -1) {
                //            ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].POCode + "</a></li>";
                //        }
                //    }
                //    $("#listviews").append(ulhtml);
                //    $("#listviews").listview("refresh");
                //});
              
            });
        }

        function SetPOCode(Code) {
            var code = $(Code).html();
            $("#orderno").val(code);
            GetInfo();
            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#listviews").listview("refresh");
            $("#fpanel").panel("close");
            $("#WarehouseBarCode").focus();
           
        }
        //送货数量修改
        function ChangeQty(i, e) {
            var qty = $("#SentQty" + i).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(qty)) {
                alert("请输入正整数！");
                $("#SentQty" + i).val('');
                return false;
            }
            if (qty <= 0) {
                alert("收货数量要大于0！");
                return false;
            }
            if (qty > (OrderList[i].SentQty - OrderList[i].AScanQty)) {
                alert("实际收货数量数量不能大于剩余可收货数量!");
                $("#SentQty" + i).val('');
                return;
            }
            OrderList[i].ReceiveQty = qty;
        }
        function isPositiveNum(obj) {//是否为正整数
            var s = $(obj).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(s)) {
                confirmDialog("请输入正整数！");
                $(obj).val(0);
                $(obj).focus();
                return;
            }
            if (s <= 0) {
                confirmDialog("收货数量要大于0！");
                $(obj).val(0);
                $(obj).focus();
                return false;
            }
        }
    </script>
</body>
</html>
