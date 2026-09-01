<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckDIPLoadingMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.CheckDIPLoadingMaterial" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>DIP物料核对</title>
    <style type="text/css">
        .ui-title {
            line-height: 30px;
        }

        .clear {
            clear: both;
            height: 5px;
        }

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

        #Orderlistview li {
            padding: 0.7em 0.5em;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" id="pageone">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">DIP物料核对</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <label for="fOrderNo">选择工单</label>
                    <a href="#" data-transition="none" data-role="button" data-mini="true" onclick="schooseOrder();" data-ajax="false"
                                    id="sshowOrderNo" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>

                    <label for="fRes">
                                    工序</label>
                    <a data-transition="none" data-role="button" data-mini="true" onclick="schooseStation();" data-ajax="false"
                                    id="sshowStation" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>
                    <label for="fRes">
                                    资源</label>
                     <a data-transition="none" data-role="button" data-mini="true" onclick="schooseResource();" data-ajax="false"
                                    id="sshowRes" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>
                    
                    <div class="clear">
                    </div>

                    <label for="txtGRN">GRN</label>
                    <input type="text" id="txtGRN" />
                    <div class="clear">
                    </div>
                </div>
                <div id="msg" style="text-align: center"></div>
                <div>
                    <table id="Infotab" data-role="table" data-mode="columntoggle" class="ui-responsive table-stroke" style="width: 100%;TABLE-LAYOUT: fixed;">
                        <thead>
                            <tr>
                                <th>品号
                                </th>
                                <th>品名
                                </th>
                                <th>GRN
                                </th>
                                <th>操作
                                </th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>

            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtnhl" data-theme="a" onclick="setHL();" value="上料核对" />
                        </li>
                        <li>
                            <%--<input type="button" id="Savebtncl" data-theme="g" onclick="setCL();" value="抽料" />--%>
                            <input type="button" id="Savebtndhl" data-theme="g" onclick="setDHL();" value="续料核对" />
                        </li>
                        <li>
                            <%--<input type="button" id="Savebtn" data-theme="f" value="重新续料核对" />--%>
                            <input type="button" id="Savebtnxjhl" data-theme="f" onclick="setXJHL();" value="巡检核对" />
                        </li>
                    </ul>
                </div>
            </div>

            <div data-role="panel" id="sOrderPanel" style="background: #f9f9f9">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="content">
                    <ul data-role="listview" id="slistview" data-inset="true" data-filter="true" data-filter-placeholder="搜索"
                    data-theme="c" class="listview" style="font-size:11px;">
                    </ul>
                </div>
            </div>
            <%--<div data-role="panel" id="OrderPanel" style="background: #f9f9f9;">
                <div data-role="content" style="padding: 10px 0px;">
                    <ul data-role="listview" id="Orderlistview" data-inset="true" data-filter="true" data-filter-placeholder="搜索"
                        data-theme="c" class="listview" style="font-size: 11px;">
                    </ul>
                </div>
            </div>--%>
            <div data-role="panel" id="MachinePanel" style="background: #f9f9f9">
                <div data-role="content">
                    <ul data-role="listview" id="Machinelistview" data-filter="true" data-filter-placeholder="搜索"
                        data-theme="c" class="listview">
                    </ul>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".ui-body-c").css("background", "#fff");
                $("body>[data-role='listview']").listview();
                $(".ui-select").css({ "margin": 0 });
                $("#txtMachineLot").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
                $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
                $('a[href="#Infotab-popup"]').hide();//.css("display", "none");  

                $("#btnFilter").click(function () {
                    $("#slistview").html("");
                    value = $.trim($("#sOrderPanel input[data-type='search']:eq(0)").val());
                    ShowOrder(value);
                });


            });

            //选择工单(状态为已完成)
            function schooseOrder() {
                $("#sOrderPanel").panel("open");
            }

            function ShowOrder(value) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.GetOrderList(value);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    //写入日志
                    SaveUserUILog(orderNo, ajax.error.Message);
                    return false;
                }
                var htmlstr = "";
                var data = ajax.value;
                $('#slistview').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].OrderID + "' onclick=sOrderList('" + data[i].OrderID + "','" + data[i].OrderNo + "')>" + data[i].OrderNo + "</li>";
                }
                $("#slistview").append(htmlstr);
                $('#slistview').listview('refresh');
            }

            var ItemId = -1;
            var orderNo = "";
            var EquipmentId = -1;
            var List = [];
            var lstPosition = [];
            var tempPosition = [];//抽检
            var isTempPosition = false;//抽检数据是否已完成
            var Position = "";
            var isHL = false;//是否全核料
            var isCL = false;//是否抽料
            var isDHL = false;//是否待核料
            var isXJHL = false;//是否巡检核料

            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var prodOrderId = -1; //选择的工单
            var orderNo = "";
            var sltStationId = -1;
            var sltResId = -1;
            var pickListId = 0; //手插 工单线别 ID

            function sOrderList(ID, OrderNo) {
                $("#sshowOrderNo,#showOrderNo").html(OrderNo);
                prodOrderId = ID;
                sltResId = -1;
                sltStationId = -1;
                $("input[data-type='search']").val('');
                $("#sOrderPanel").panel("close");
                schooseStation();
                $("#lblHandList").html("");
                $("#lblItemCode").html("");
                $("#lblItemName").html("");
                $("#showRes,#sshowRes,#showStation,#sshowStation").html("请选择");
            }

            /**
            *加载扣料工序
            */
            function schooseStation() {
                if (prodOrderId < 0) {
                    confirmDialog("请先选择工单！");
                    schooseOrder();
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.GetPickListStation(prodOrderId);
                if (ajax.error != null) {
                    showAreaMessge(ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog(orderNo, ajax.error.Message);
                    return false;
                }
                var list = (ajax.value);
                if (list.keys.length == 0) {
                    confirmDialog("未找到工单[" + $("#sshowOrderNo").text() + "]关联路由的扣料工序，请先配置扣料工序！");
                    return false;
                }
                var htmlstr = "";
                $('#slistview').html('');
                for (var i = 0 ; i < list.keys.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + list.keys[i] + "' onclick=sStationList('" + list.keys[i] + "')>" + list.values[i] + "</li>";
                }
                $("#slistview").append(htmlstr);
                $('#slistview').listview('refresh');
                $("#sOrderPanel").panel("open");
            }
            function sStationList(ID) {
                sltStationId = ID;
                $("#showStation,#sshowStation").html($("#" + ID).html());
                $("input[data-type='search']").val('');
                $("#sOrderPanel").panel("close");
                $("#sshowRes").html("请选择");
                sltResId = -1;
                schooseResource();
            }

            //资源
            function schooseResource() {
                if ($("#sshowOrderNo").html() == "请选择") {
                    confirmDialog("请先选择工单！");
                    schooseOrder();
                    return false;
                }
                if ($("#sshowStation").html() == "请选择") {
                    confirmDialog("请先选择工序！");
                    schooseStation();
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetResourcesByOprId(sltStationId, userName);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    //写入日志
                    SaveUserUILog(orderNo, ajax.error.Message);
                    return false;
                }

                $("#sOrderPanel").panel("open");

                var htmlstr = "";
                var data = ajax.value;
                $('#slistview').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='" + data[i].ResourceId + "' onclick=sResList('" + data[i].ResourceId + "')>" + data[i].ResName + "</li>";
                }
                $("#slistview").append(htmlstr);
                $('#slistview').listview('refresh');
            }
            function sResList(ID) {
                sltResId = ID;
                $("#showRes,#sshowRes").html($("#" + ID).html());
                $("input[data-type='search']").val('');
                $("#sOrderPanel").panel("close");
                setPickListInfo();
                Search();
            }

            /**
            *设置上料清单信息
            */
            function setPickListInfo() {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickListClient.GetPickListResource(prodOrderId, sltStationId, sltResId);
                if (ajax.error != null) {
                    confirmDialog(ajax.error.Message);
                    //写入日志
                    SaveUserUILog(orderNo, ajax.error.Message);
                    return false;
                }
                var entity = ajax.value;
                if (entity != null && entity.PickListId == 0) {
                    confirmDialog("未找到工单料站表信息！");
                    return false;
                }
                else {
                    pickListId = entity.PickListId;
                }
                return true;
            }

            /**************************查询页面*********************************************/

            function Search() {
                var ismy = "否";
                if (isXJHL) {
                    ismy = "是";
                }
                var myentity = {};
                myentity.PickListId = pickListId;
                myentity.ProdOrderId = prodOrderId;
                myentity.StationId = sltStationId;
                myentity.ResourceId = sltResId;
                myentity.IsXJHL = ismy;
                var myajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetPickListDIPLoadingMaterial", JSON.stringify(myentity));
                if (myajax.error != null) {
                    $("#msg").html(myajax.error.Message).css("color", "red");
                    return false;
                }
                var data = JSON.parse(myajax.value).data;
                $("#Infotab tbody").html("");
                var htmlstr = "";
                lstPosition = [];
                if (isDHL) {//待核料
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].FirstOrContinue != "2") { continue; }
                        htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].ItemCode + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ItemName + "</td><td style='WORD-WRAP: break-word;'>" + data[i].GRN + "</td>"
                        if (data[i].GRN != "") {
                            if (data[i].FirstOrContinue)
                                htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].GRN + "',this)  /></td>";
                            var model = {};
                            model.GRN = data[i].GRN;
                            model.ItemCode = data[i].ItemCode;
                            model.ItemName = data[i].ItemName;
                            model.FirstOrContinue = data[i].FirstOrContinue;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    }
                } else {
                    for (var i = 0; i < data.length; i++) {
                        //if (data[i].FirstOrContinue == "2") { continue; }
                        htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].ItemCode + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ItemName + "</td><td style='WORD-WRAP: break-word;'>" + data[i].GRN + "</td>"
                        if (data[i].GRN != "") {
                            htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].GRN + "',this)  /></td>";
                            var model = {};
                            model.GRN = data[i].GRN;
                            model.ItemCode = data[i].ItemCode;
                            model.ItemName = data[i].ItemName;
                            model.FirstOrContinue = data[i].FirstOrContinue;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    }
                }

                $("#Infotab tbody").html(htmlstr);
                $("#Infotab").table("refresh");
                $("#txtGRN").focus();
            }

            $("#txtGRN").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (isHL || isDHL) {
                    if (curKey == 13) {
                        if (lstPosition.length == 0) {
                            $("#msg").html("没有找到核料数据！").css("color", "red");
                            return false;
                        }
                        $("#msg").html("");
                        if ($.trim($("#txtGRN").val()) != "") {
                            var GRN = $.trim($("#txtGRN").val());
                            var checkGrn = lstPosition.find(item => item.GRN == GRN);
                            if (checkGrn == null) {
                                $("#msg").html("请确认GRN是否已上料或在上料清单中！").css("color", "red");
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                return false;
                            }
                            Save();//每个自动核对
                        } else {
                            $("#msg").html("GRN不能为空！").css("color", "red");
                            $("#txtGRN").focus();
                            return false;
                        }
                    }
                }
                else if (isXJHL) {
                    if (curKey == 13) {
                        if (lstPosition.length == 0) {
                            $("#msg").html("没有找到核料数据！").css("color", "red");
                            return false;
                        }
                        $("#msg").html("");
                        if ($.trim($("#txtGRN").val()) != "") {
                            var GRN = $.trim($("#txtGRN").val());
                            var checkGrn = lstPosition.find(item => item.GRN == GRN);
                            if (checkGrn == null) {
                                $("#msg").html("请确认GRN是否已上料或在上料清单中！").css("color", "red");
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                return false;
                            }
                            Save();//每个自动核对
                        }else {
                            $("#msg").html("GRN不能为空！").css("color", "red");
                            $("#txtGRN").focus();
                            return false;
                        }
                    }
                }
                else {
                    $("#msg").html("必须选择全核料、续料核对或巡检核料！").css("color", "red");
                    return false;
                }
            });

            //删除
            function deleteGRN(GRN, obj) {
                var index = -1;
                $.grep(List, function (o, j) {
                    if (o.GRN == GRN) {
                        index = j;
                    }
                });
                List.splice(index, 1);
                $(obj).parent().parent().remove();
            }

            //全核料
            function setHL() {
                isHL = true;
                isCL = false;
                isDHL = false;
                isXJHL = false;//是否巡检核料
                isTempPosition = false;
                Search();
                if (lstPosition == undefined || lstPosition.length == 0) {
                    $("#msg").html("请先选择工单或工单没数据!").css("color", "red");
                    return false;
                }
                $("#msg").html("已选全核料!").css("color", "red");
                tempPosition = [];//清空抽料数据
                //Search();

                $("#Infotab tbody").html("");
                var htmlstr = "";
                var data = lstPosition;
                lstPosition = [];

                for (var i = 0; i < data.length; i++) {
                   // if (data[i].FirstOrContinue != "2") {
                    htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].ItemCode + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ItemName + "</td><td style='WORD-WRAP: break-word;'>" + data[i].GRN + "</td>"
                    if (data[i].GRN != "") {
                            htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].GRN + "',this)  /></td>";
                            var model = {};
                            model.GRN = data[i].GRN;
                            model.ItemCode = data[i].ItemCode;
                            model.ItemName = data[i].ItemName;
                            model.FirstOrContinue = data[i].FirstOrContinue;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    //}
                }

                if (lstPosition.length > 0) {
                   
                } else {
                    $("#msg").html("没有核料数据!").css("color", "red");
                    return false;
                };
                $("#Infotab tbody").html(htmlstr);
                $("#Infotab").table("refresh");
                $("#txtGRN").focus();
            }

            //巡检核料
            function setXJHL() {
                isHL = false;
                isCL = false;
                isDHL = false;
                isXJHL = true;//是否巡检核料
                isTempPosition = false;
                $("#txtMachineLot").val("");
                Search();
                if (lstPosition == undefined || lstPosition.length == 0) {
                    $("#msg").html("请先选择工单或工单没数据!").css("color", "red");
                    return false;
                }
                $("#msg").html("已选巡检核料!").css("color", "red");
                tempPosition = [];//清空抽料数据

                $("#Infotab tbody").html("");
                var htmlstr = "";
                var data = lstPosition;
                //lstPosition = [];

                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].ItemCode + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ItemName + "</td><td style='WORD-WRAP: break-word;'>" + data[i].GRN + "</td>"
                    if (data[i].GRN != "") {
                        htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].GRN + "',this)  /></td>";
                    } else {
                        htmlstr += "<td></td>";
                    }
                }

                if (lstPosition.length > 0) {
                    
                } else {
                    $("#msg").html("没有核料数据!").css("color", "red");
                    return false;
                };
                $("#Infotab tbody").html(htmlstr);
                $("#Infotab").table("refresh");
                $("#txtGRN").focus();
            }

            function setDHL() {
                //isCL = true;
                isHL = false;
                isDHL = true;
                isXJHL = false;//是否巡检核料
                $("#txtMachineLot").val("");
                Search();
                if (lstPosition == undefined || lstPosition.length == 0) {
                    $("#msg").html("请先选择工单或工单没数据!").css("color", "red");
                    return false;
                }
               // if (isDHL) { return false; }
                $("#msg").html("已选待核料!").css("color", "red");

                $("#Infotab tbody").html("");
                var htmlstr = "";
                var data = lstPosition;
                lstPosition = [];

                for (var i = 0; i < data.length; i++) {
                    if (data[i].FirstOrContinue == "2") {
                        htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].ItemCode + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ItemName + "</td><td style='WORD-WRAP: break-word;'>" + data[i].GRN + "</td>"
                        if (data[i].GRN != "") {
                            htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].GRN + "',this)  /></td>";
                            var model = {};
                            model.GRN = data[i].GRN;
                            model.ItemCode = data[i].ItemCode;
                            model.ItemName = data[i].ItemName;
                            model.FirstOrContinue = data[i].FirstOrContinue;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    }
                }

                if (lstPosition.length > 0) {

                } else {
                    $("#msg").html("没有待核料数据!").css("color", "red");
                    return false;
                };
                $("#Infotab tbody").html(htmlstr);
                $("#Infotab").table("refresh");
                $("#txtGRN").focus();
               
            } 


            function encode(str) {
                var encode = encodeURI(str);
                // 对编码的字符串转化base64
                var base64 = btoa(encode);
                return base64;
            }
            //保存数据
            function Save() {
                // confirmDialog("是否确认核对？", function () {
                var CheckType = "";
                if (isHL) {
                    CheckType = "上料核对";
                }
                if (isDHL) {
                    CheckType = "续料核对";
                }
                if (isXJHL) {
                    CheckType = "巡检核对";
                }
                var GRN = $.trim($("#txtGRN").val());
                var entity = {};
                entity.PickListId = pickListId;
                entity.ProdOrderId = prodOrderId;
                entity.StationId = sltStationId;
                entity.ResourceId = sltResId;
                entity.GRN = GRN;
                entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                entity.CheckType = CheckType;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveDIPLoadingMaterialCheck", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                $("#msg").html("核对成功！").css("color", "green");
                // ClearInfo();
                //重新加载产线、机台对应的未核对上来信息。
                if (isXJHL) {
                    var list = JSON.parse(ajax.value);
                    var listOrder = list.data;
                    if (listOrder[0].IsOK == "巡检完成") {
                        $("#msg").html("本轮巡检完成，巡检批次号：" + listOrder[0].BatchNo).css("color", "green");
                        Search();
                    }
                    else {
                        Search();
                    }
                }
                else {
                    Search();
                }
                List = [];
                $("#txtGRN").val("");
                if ($("#Infotab tbody").html() == "") {
                    Search();
                }
                $("#txtGRN").focus();

            }

        </script>
    </form>
</body>
</html>
