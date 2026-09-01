<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckSMTLoadingMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.CheckSMTLoadingMaterial" %>

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
    <title>SMT物料核对</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">SMT物料核对</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <label for="showOrderNo">
                        排程工单
                    </label>
                    <a href="#" data-transition="none" data-role="button" data-mini="true" onclick="chooseOrder();" data-ajax="false"
                        id="showOrderNo" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>

                    <label for="showRes" class="Field">
                        机台
                    </label>
                    <a data-transition="none" data-role="button" data-mini="true" onclick="chooseMachine();" data-ajax="false"
                        id="showMachie" data-theme="c">请选择</a>
                    <div class="clear">
                    </div>
                    <label for="txtMachineLot">
                        区域
                    </label>
                     <select data-corners="false" id="arealist"></select>
                    <div class="clear">
                    </div>
                    <label for="txtMachineLot">站位</label>
                    <input type="text" id="txtMachineLot" />
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
                                <th>站位
                                </th>
                                <th>品号
                                </th>
                                <th>元件说明
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

            <div data-role="panel" id="OrderPanel" style="background: #f9f9f9">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="content">
                    <ul data-role="listview" id="Orderlistview" data-inset="true" data-filter="true" data-filter-placeholder="搜索"
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
                    $("#Orderlistview").html("");
                    value = $.trim($("#OrderPanel input[data-type='search']:eq(0)").val());
                    ShowOrder(value);
                });


            });

            //选择工单(状态为已完成)
            function chooseOrder() {
                $("#OrderPanel").panel("open");
            }

            function ShowOrder(value) {
                $.post("../Handler/SMTLoadingMaterial.ashx?type=GetIPQCSMTOrderList&PlanOrderNo=" + value, function (data) {
                    var htmlstr = "";
                    var data = JSON.parse(data);
                    $('#Orderlistview').html('');
                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='"
                             + data[i].ItemId + "|" + data[i].ItemCode + "|" + data[i].State + "|" + data[i].LineId + "|" + data[i].ItemName + "|" + data[i].LineName + "| " + data[i].TableDesc + "|" + data[i].StatusDesc
                        + "' onclick=OrderList(this)>" + data[i].PlanOrderNo + "</li>";
                    }
                    $("#Orderlistview").append(htmlstr);
                    $('#Orderlistview').listview('refresh');
                });
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
            function OrderList(ID) {
                $("#msg").html("");
                ClearInfo();
                $("#showMachie").html("请选择");
                $("#showOrderNo").html($(ID).html());

                var dataArr = $(ID).attr("id").split("|");
                orderNo = $(ID).html();
                ItemId = dataArr[0];
                $("input[data-type='search']").val('');
                $("#OrderPanel").panel("close");
                chooseMachine();
            }

            //选择机台
            function chooseMachine() {
                $("#MachinePanel").panel("open");
                if ($("#showOrderNo").html() == "") {
                    confirmDialog("工单不能为空");
                    return false;
                }
                $.post("../Handler/SMTLoadingMaterial.ashx?type=GetMachineList", { "OrderNo": orderNo }, function (data) {
                    var htmlstr = "";
                    var data = JSON.parse(data);
                    $('#Machinelistview').html('');
                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' machineid ='" + data[i].EquipmentId + "' id='"
                            + data[i].EquipmentCode + "|" + data[i].EquipmentName + "|" + data[i].SequenceNo + "|" + data[i].IsLoading + "|" + data[i].IsOffLine + "|" +
                            data[i].IsScanPos + "|" + data[i].EquipmentId + "|" + "' onclick=MachineList(this)>" + data[i].EquipmentName + "</li>";
                    }
                    $("#Machinelistview").append(htmlstr);
                    $('#Machinelistview').listview('refresh');
                });
            }

            function MachineList(ID) {
                $("#msg").html("");
                EquipmentId = -1;
                List = [];
                $("#txtMachineLot").val("");
                $("#txtGRN").val("");
                $("#msg").html("");
                $("#Infotab tbody").html("");
                $("#Infotab").table("refresh");

                $("#showMachie").html($(ID).html());
                $("#Infotab tbody").html("");
                var dataArr = $(ID).attr("id").split("|");
                EquipmentId = dataArr[6];
                $("input[data-type='search']").val('');
                $("#MachinePanel").panel("close");
                //var entity = {};
                //entity.FBillNo = $("#showOrderNo").html();
                //entity.EquipmentId = EquipmentId;
                //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFindSMTPosition", JSON.stringify(entity));
                //if (ajax.error != null) {
                //    $("#msg").html(ajax.error.Message).css("color", "red");
                //    return false;
                //}
                //var result = JSON.parse(ajax.value).data[0];
                //Position = result.Position;
                //$("#txtMachineLot").val(Position);
                tempPosition = [];
                isTempPosition = false;
                isHL = false;//是否全核料
                isCL = false;//是否抽料
                isDHL = false;//是否待核料
                isXJHL = false;//是否巡检核料
                Search2();
            }

            /**************************查询页面*********************************************/

            //选择区域
            $("#arealist").on("change", function () {
                if (isXJHL) {
                    SearchXJ();
                }
                else {
                    Search();
                }
            });

            //查询
            function Search2() {
                $("#arealist").html("");
                $("#arealist").selectmenu('refresh', true);
                var ismy = "否";
                if (isXJHL) {
                    ismy = "是";
                }
                var entity = {};
                entity.FBillNo = $("#showOrderNo").html();
                entity.EquipmentId = EquipmentId;
                entity.Area = "";
                entity.IsXJHL = ismy;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspIPQC_SMTLoadingMaterialList", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    return false;
                }
                var mydata = JSON.parse(ajax.value).data;
                var arealiststr = "";
                var areaList = [];
                var areaStr = "";
                if (mydata.length==0) {
                    $("#msg").html("排产工单暂无上料记录！").css("color", "red");
                    return false;
                }
                for (var i = 0; i < mydata.length; i++) {
                    areaStr = mydata[i].Area;
                    //区域列表
                    if ($.inArray(areaStr, areaList) == -1) {
                        areaList.push(areaStr);
                    }
                }
                for (var i = 0; i < areaList.length; i++) {
                    arealiststr += "<option value='" + areaList[i] + "'>" + areaList[i] + "</option>";
                }
                $("#arealist").append(arealiststr);
                $("#arealist").selectmenu('refresh', true);
                if (isXJHL) {
                    SearchXJ();
                }
                else {
                    Search();
                }
            }

            function Search() {
                
                var AreaValue = $("#arealist option:selected").val();
                var ismy = "否";
                if (isXJHL) {
                    ismy = "是";
                }
                var myentity = {};
                myentity.FBillNo = $("#showOrderNo").html();
                myentity.EquipmentId = EquipmentId;
                myentity.Area = AreaValue;
                myentity.IsXJHL = ismy;
                var myajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspIPQC_SMTLoadingMaterialList", JSON.stringify(myentity));
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
                        htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].Position + "</td><td style='WORD-WRAP: break-word;'>" + data[i].PartNumber + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ElementDescription + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].SerialNumber == null ? "" : data[i].SerialNumber) + "</td>"
                        if (data[i].SerialNumber != "") {
                            if (data[i].FirstOrContinue)
                                htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].SerialNumber + "',this)  /></td>";
                            var model = {};
                            model.grn = data[i].SerialNumber;
                            model.position = data[i].Position;
                            model.EquipmentName = data[i].EquipmentName;
                            model.Area = data[i].Area;
                            model.FeederSN = data[i].FeederSN;
                            model.BalanceQty = parseInt(data[i].BalanceQty);
                            model.SerialNumber = data[i].SerialNumber;
                            model.FirstOrContinue = data[i].FirstOrContinue;
                            model.PartNumber = data[i].PartNumber;
                            model.ElementDescription = data[i].ElementDescription;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    }
                } else {
                    for (var i = 0; i < data.length; i++) {
                        //if (data[i].FirstOrContinue == "2") { continue; }
                        htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].Position + "</td><td style='WORD-WRAP: break-word;'>" + data[i].PartNumber + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ElementDescription + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].SerialNumber == null ? "" : data[i].SerialNumber) + "</td>"
                        if (data[i].SerialNumber != "") {
                            htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].SerialNumber + "',this)  /></td>";
                            var model = {};
                            model.grn = data[i].SerialNumber;
                            model.position = data[i].Position;
                            model.EquipmentName = data[i].EquipmentName;
                            model.Area = data[i].Area;
                            model.FeederSN = data[i].FeederSN;
                            model.BalanceQty = parseInt(data[i].BalanceQty);
                            model.SerialNumber = data[i].SerialNumber;
                            model.FirstOrContinue = data[i].FirstOrContinue;
                            model.PartNumber = data[i].PartNumber;
                            model.ElementDescription = data[i].ElementDescription;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    }
                }

                if (lstPosition.length > 0) {
                    $("#txtMachineLot").val(lstPosition[0].position);
                }
                $("#Infotab tbody").html(htmlstr);
                $("#Infotab").table("refresh");
                $("#txtGRN").focus();
            }

            
            function SearchOld() {
                $.post("../Handler/SMTLoadingMaterial.ashx?type=GetSMTLoadingMaterial", { "FBillNo": $("#showOrderNo").html(), "EquipmentId": EquipmentId }, function (data) {
                    data = JSON.parse(data);
                    if (data.length == 0) {
                        $("#msg").html("没有找到核料数据！").css("color", "red");
                        return false;
                    }
                    $("#Infotab tbody").html("");
                    var htmlstr = "";
                    lstPosition = [];

                    for (var i = 0; i < data.length; i++) {
                        htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].EquipmentLineDisplayName + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].Area == null ? "" : data[i].Area) + "</td><td style='WORD-WRAP: break-word;'>" + data[i].TableSlotSN + "</td><td style='WORD-WRAP: break-word;'>" + data[i].FeedStr + "</td><td style='WORD-WRAP: break-word;'>" + data[i].BalanceQty + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].GrnStr == null ? "" : data[i].GrnStr) + "</td>"
                        if (data[i].GrnStr != "") {
                            htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].GrnStr + "',this)  /></td>";
                            var model = {};
                            model.grn = data[i].GrnStr;
                            model.position = data[i].TableSlotSN;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    }

                    if (lstPosition.length > 0) {
                        $("#txtMachineLot").val(lstPosition[0].position);
                    }
                    $("#Infotab tbody").html(htmlstr);
                    $("#Infotab").table("refresh");
                    $("#txtGRN").focus();
                });
            }

            //扫描料站
            $("#txtMachineLot").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html("");
                    if ($("#showOrderNo").html() == "" || $("#showOrderNo").html() == "请选择") {
                        confirmDialog("工单不能为空");
                        return false;
                    }
                    if ($("#showMachie").html() == "" || $("#showMachie").html() == "请选择") {
                        confirmDialog("机台不能为空");
                        return false;
                    }

                    if ($.trim($("#txtMachineLot").val()) == "") {
                        $("#msg").html("站位不能为空！").css("color", "red");
                        $("#txtMachineLot").focus();
                        return false;
                    }

                    if ($("#txtMachineLot").val() != "") {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxIPQC.IPQCSMTCheck($("#showOrderNo").html(), EquipmentId, $.trim($("#txtMachineLot").val()), $.trim($("#txtGRN").val()), 0);
                        if (ajax.error != null) {
                            $("#msg").html(ajax.error.Message).css("color", "red");
                            return false;
                        } else {
                            $("#txtGRN").focus();
                        }
                    } else {
                        $("#msg").html("站位不能为空！").css("color", "red");
                        return false;
                    }
                }
            });

            
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
                            var grn = $.trim($("#txtGRN").val());
                            var checkGrn = lstPosition.find(item => item.grn == grn);
                            if (checkGrn == null) {
                                $("#msg").html("GRN不在上料该站位的上料清单中！").css("color", "red");
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                return false;
                            }
                            for (var item of lstPosition) {
                                if (item.grn == grn) {
                                    $("#txtMachineLot").val(item.position);
                                    lstPosition.splice(0, 1);
                                    break;
                                } else {
                                    $("#msg").html("没有按照顺序核对物料！").css("color", "red");
                                    $("#txtGRN").val("");
                                    $("#txtGRN").focus();
                                    return false;
                                }
                            }
                        };
                        if ($.trim($("#txtMachineLot").val()) == "") {
                            $("#msg").html("站位不能为空！").css("color", "red");
                            $("#txtMachineLot").focus();
                            return false;
                        }
                        if ($.trim($("#txtGRN").val()) != "") {
                            //if(CheckExistGrn($.trim($("#txtGRN").val()))){
                            //    $("#msg").html("已扫描GRN: "+$("#txtGRN").val()).css("color", "red");
                            //    $("#txtGRN").val("");
                            //    $("#txtGRN").focus();
                            //    return false;
                            //}
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxIPQC.IPQCSMTCheck($("#showOrderNo").html(), EquipmentId, $.trim($("#txtMachineLot").val()), $.trim($("#txtGRN").val()), 1);
                            if (ajax.error != null) {
                                $("#msg").html(ajax.error.Message).css("color", "red");
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                return false;
                            }
                            var entity = ajax.value;
                            var model = {};
                            model.EquipmentName = entity.EquipmentLineDisplayName; //机台
                            model.Area = entity.Area; //区域
                            model.Position = entity.TableSlotSN; //站位/料站
                            model.FeederSN = entity.FeedStr; //飞达
                            model.BalanceQty = entity.BalanceQty; //数量
                            model.SerialNumber = entity.GrnStr; //GRN
                            List.push(model);
                            //$("#txtMachineLot").val(model.Position);
                            Save();//每个自动核对
                            //GetDetailInfo(model);
                            //$("#txtGRN").val("");
                            //$("#txtMachineLot").val("").focus();
                            //$("#txtMachineLot").val(Position);
                            if (lstPosition.length > 0) {
                                $("#txtMachineLot").val(lstPosition[0].position);
                            } else {
                                $("#txtMachineLot").val("");
                            }


                        } else {
                            $("#msg").html("GRN不能为空！").css("color", "red");
                            $("#txtGRN").focus();
                            return false;
                        }
                    }
                }
                else if (isCL) {
                    if (curKey == 13) {
                        $("#msg").html("");
                        var grn = "";
                        var index = 0;
                        if ($.trim($("#txtGRN").val()) != "") {
                            grn = $.trim($("#txtGRN").val());
                        };
                        if (isTempPosition) {
                            $("#msg").html("已完成抽检 ！").css("color", "red");
                            isTempPosition
                            return false;
                        };
                        //第一次进入时加载抽检数据
                        if (!tempPosition.length > 0 && isTempPosition == false) {
                            tempPosition = lstPosition;

                            for (var item of tempPosition) {
                                if (item.grn == grn) {
                                    break;
                                } else {
                                    //判断输入的Grn是否存在
                                    tempPosition.find(function (value) {
                                        if (value.grn === grn) {
                                            index++;
                                        }
                                    })
                                }
                            };
                            tempPosition.splice(0, index);
                        }
                        for (var item of tempPosition) {
                            if (item.grn == grn) {
                                $("#txtMachineLot").val(item.position);
                                tempPosition.splice(0, 1);
                                break;
                            } else {
                                $("#msg").html("没有按照抽样顺序核对物料！").css("color", "red");
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                return false;
                            }
                        }
                        if ($.trim($("#txtMachineLot").val()) == "") {
                            $("#msg").html("站位不能为空！").css("color", "red");
                            $("#txtMachineLot").focus();
                            return false;
                        }
                        if ($.trim($("#txtGRN").val()) != "") {
                            //if(CheckExistGrn($.trim($("#txtGRN").val()))){
                            //    $("#msg").html("已扫描GRN: "+$("#txtGRN").val()).css("color", "red");
                            //    $("#txtGRN").val("");
                            //    $("#txtGRN").focus();
                            //    return false;
                            //}
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxIPQC.IPQCSMTCheck($("#showOrderNo").html(), EquipmentId, $.trim($("#txtMachineLot").val()), $.trim($("#txtGRN").val()), 1);
                            if (ajax.error != null) {
                                $("#msg").html(ajax.error.Message).css("color", "red");
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                return false;
                            }
                            var entity = ajax.value;
                            var model = {};
                            model.EquipmentName = entity.EquipmentLineDisplayName; //机台
                            model.Area = entity.Area; //区域
                            model.Position = entity.TableSlotSN; //站位/料站
                            model.FeederSN = entity.FeedStr; //飞达
                            model.BalanceQty = entity.BalanceQty; //数量
                            model.SerialNumber = entity.GrnStr; //GRN
                            List.push(model);
                            //$("#txtMachineLot").val(model.Position);
                            Save();//每个自动核对
                            //GetDetailInfo(model);
                            //$("#txtGRN").val("");
                            //$("#txtMachineLot").val("").focus();
                            //$("#txtMachineLot").val(Position);

                            if (tempPosition.length > 0) {
                                $("#txtMachineLot").val(tempPosition[0].position);
                            } else {
                                $("#txtMachineLot").val("");
                                isTempPosition = true;//已经完成
                            }
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
                            var grn = $.trim($("#txtGRN").val());
                            var checkGrn = lstPosition.find(item => item.grn == grn);
                            if (checkGrn == null) {
                                $("#msg").html("GRN不在上料该站位的上料清单中！").css("color", "red");
                                $("#txtGRN").val("");
                                $("#txtGRN").focus();
                                return false;
                            }
                            for (var item of lstPosition) {
                                if (item.grn == grn) {
                                    $("#txtMachineLot").val(item.position);
                                    lstPosition.splice(0, 1);
                                    var model = {};
                                    model.EquipmentName = item.EquipmentName; //机台
                                    model.Area = item.Area; //区域
                                    model.Position = item.Position; //站位/料站
                                    model.FeederSN = item.FeederSN; //飞达
                                    model.BalanceQty = item.BalanceQty; //数量
                                    model.SerialNumber = item.SerialNumber; //GRN
                                    List.push(model);
                                    Save();//每个自动核对
                                    if (lstPosition.length > 0) {
                                        $("#txtMachineLot").val(lstPosition[0].position);
                                    } else {
                                        $("#txtMachineLot").val("");
                                    }
                                    break;
                                } else {
                                    $("#msg").html("没有按照顺序核对物料！").css("color", "red");
                                    $("#txtGRN").val("");
                                    $("#txtGRN").focus();
                                    return false;
                                }
                            }
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

            //显示
            function GetDetailInfo(Info) {
                var htmlstr = "";
                htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].Position + "</td><td style='WORD-WRAP: break-word;'>" + data[i].PartNumber + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ElementDescription + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].SerialNumber == null ? "" : data[i].SerialNumber) + "</td>"
                if (Info.SerialNumber != "") {
                    htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + Info.SerialNumber + "',this)  /></td>";
                } else {
                    htmlstr += "<td></td>";
                }
                htmlstr += "</tr>";
                $("#Infotab tbody").append(htmlstr);
            }

            //删除
            function deleteGRN(grn, obj) {
                var index = -1;
                $.grep(List, function (o, j) {
                    if (o.SerialNumber == grn) {
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
                $("#txtMachineLot").val("");
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
                    htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].position + "</td><td style='WORD-WRAP: break-word;'>" + data[i].PartNumber + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ElementDescription + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].SerialNumber == null ? "" : data[i].SerialNumber) + "</td>"
                        if (data[i].SerialNumber != "") {
                            htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].SerialNumber + "',this)  /></td>";
                            var model = {};
                            model.grn = data[i].SerialNumber;
                            model.position = data[i].position;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    //}
                }

                if (lstPosition.length > 0) {
                    $("#txtMachineLot").val(lstPosition[0].position);
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
                Search2();
                if (lstPosition == undefined || lstPosition.length == 0) {
                    $("#msg").html("请先选择工单或工单没数据!").css("color", "red");
                    return false;
                }
                $("#msg").html("已选巡检核料!").css("color", "red");
                tempPosition = [];//清空抽料数据
                //Search();

                $("#Infotab tbody").html("");
                var htmlstr = "";
                var data = lstPosition;
                //lstPosition = [];

                for (var i = 0; i < data.length; i++) {
                    // if (data[i].FirstOrContinue != "2") {
                    htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].position + "</td><td style='WORD-WRAP: break-word;'>" + data[i].PartNumber + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ElementDescription + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].SerialNumber == null ? "" : data[i].SerialNumber) + "</td>"
                    if (data[i].SerialNumber != "") {
                        htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].SerialNumber + "',this)  /></td>";
                    } else {
                        htmlstr += "<td></td>";
                    }
                    //}
                }

                if (lstPosition.length > 0) {
                    $("#txtMachineLot").val(lstPosition[0].position);
                } else {
                    $("#msg").html("没有核料数据!").css("color", "red");
                    return false;
                };
                $("#Infotab tbody").html(htmlstr);
                $("#Infotab").table("refresh");
                $("#txtGRN").focus();
            }

            function SearchXJ() {
                var AreaValue = $("#arealist option:selected").val();
                if (AreaValue == "" || AreaValue==undefined) {
                    AreaValue = "";
                }
                var myentity = {};
                myentity.FBillNo = $("#showOrderNo").html();
                myentity.EquipmentId = EquipmentId;
                myentity.Area = AreaValue;
                var myajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspIPQC_SMTLoadingMaterialList_XJ", JSON.stringify(myentity));
                if (myajax.error != null) {
                    $("#msg").html(myajax.error.Message).css("color", "red");
                    return false;
                }
                var data = JSON.parse(myajax.value).data;
                $("#Infotab tbody").html("");
                var htmlstr = "";
                lstPosition = [];
                if (isXJHL) {//待核料
                    for (var i = 0; i < data.length; i++) {
                        //if (data[i].FirstOrContinue == "2") { continue; }
                        htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].Position + "</td><td style='WORD-WRAP: break-word;'>" + data[i].PartNumber + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ElementDescription + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].SerialNumber == null ? "" : data[i].SerialNumber) + "</td>"
                        if (data[i].SerialNumber != "") {
                            htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].SerialNumber + "',this)  /></td>";
                            var model = {};
                            model.grn = data[i].SerialNumber;
                            model.position = data[i].Position;
                            model.EquipmentName = data[i].EquipmentName;
                            model.Area = data[i].Area;
                            model.FeederSN = data[i].FeederSN;
                            model.BalanceQty = parseInt(data[i].BalanceQty);
                            model.SerialNumber = data[i].SerialNumber;
                            model.FirstOrContinue = data[i].FirstOrContinue;
                            model.PartNumber = data[i].PartNumber;
                            model.ElementDescription = data[i].ElementDescription;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    }
                }

                if (lstPosition.length > 0) {
                    $("#txtMachineLot").val(lstPosition[0].position);
                }
                $("#Infotab tbody").html(htmlstr);
                $("#Infotab").table("refresh");
                $("#txtGRN").focus();
            }

            //抽料
            function setCL() {
                isCL = true;
                isHL = false;
                isTempPosition = false;
                $("#msg").html("已选待核料!");
                tempPosition = [];//清空抽料数据
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
                        htmlstr += "<tr><td style='WORD-WRAP: break-word;'>" + data[i].position + "</td><td style='WORD-WRAP: break-word;'>" + data[i].PartNumber + "</td><td style='WORD-WRAP: break-word;'>" + data[i].ElementDescription + "</td><td style='WORD-WRAP: break-word;'>" + (data[i].SerialNumber == null ? "" : data[i].SerialNumber) + "</td>"
                        if (data[i].SerialNumber != "") {
                            htmlstr += "<td style='WORD-WRAP: break-word;'><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].SerialNumber + "',this)  /></td>";
                            var model = {};
                            model.grn = data[i].SerialNumber;
                            model.position = data[i].position;
                            lstPosition.push(model);
                        } else {
                            htmlstr += "<td></td>";
                        }
                    }
                }

                if (lstPosition.length > 0) {
                    $("#txtMachineLot").val(lstPosition[0].position);
                } else {
                    $("#msg").html("没有待核料数据!").css("color", "red");
                    return false;
                };
                $("#Infotab tbody").html(htmlstr);
                $("#Infotab").table("refresh");
                $("#txtGRN").focus();
               
            } 
            $("#Savebtn").on("click", function () {
                //Save
                ReturnSMT();
            });

            function ReturnSMT() {
                confirmDialog("是否重新核对?", function () {
                    var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                    var cmd = "UPDATE Prod_SMTLoadingMaterialCheck SET IsQcCheck=0,QCBY='',QCTime='',ModifyBy='" + userName + "',ModifyDateTime=GETDATE() WHERE FBillNo='" + orderNo + "'";
                    var ajax = SKT.AjaxCommon.DBService.ExecuteNonQuery(btoa(cmd), []);
                    if (ajax.error != null) {
                        $("#msg").html(ajax.error.Message).css("color", "red");
                        return false;
                    }
                    $("#msg").html("重新核对！").css("color", "green");
                    List = [];
                    tempPosition = [];
                    isTempPosition = false;
                    isHL = false;//是否全核料
                    isCL = false;//是否抽料
                    isDHL = false;
                    isXJHL = false;//是否巡检核料
                    $("#txtGRN").val("");
                    $("#txtMachineLot").val("");
                    Search();
                    //if ($("#Infotab tbody").html() == "") {
                    //    ClearInfo();
                    //}
                    $("#txtGRN").focus();
                });
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
                var entity = {};
                entity.FBillNo = orderNo;
                entity.EquipmentId = EquipmentId;
                entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                entity.CheckType = CheckType;
                //if (JSON.stringify(List)=="[]") {
                //    $("#msg").html("请扫描GRN").css("color", "red");
                //    return false;
                //}
                entity.SMTLoadingMaterialCheck = JSON.stringify(List);
                entity.TempColumns = "SMTLoadingMaterialCheck";
                var ajax = SKT.AjaxCommon.DBService.ExcuteSpcByTemp("uspSaveSMTLoadingMaterialCheck", JSON.stringify(entity));
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
                        Search2();
                    }
                    else {
                        SearchXJ();
                    }
                }
                else {
                    Search();
                }
                List = [];
                //$("#txtMachineLot").val("");
                $("#txtGRN").val("");
                if ($("#Infotab tbody").html() == "") {
                    Search2();
                }
                $("#txtGRN").focus();
                //});
            }

            //清空数据
            function ClearInfo() {
                ItemId = -1;
                orderNo = "";
                EquipmentId = -1;
                List = [];
                $("#showOrderNo").html("请选择");
                $("#showMachie").html("请选择");
                $("#txtMachineLot").val("");
                $("#txtGRN").val("");
                $("#Infotab tbody").html("");
                $("#Infotab").table("refresh");
            }

            //判断是否已扫描
            function CheckExistGrn(grn) {
                var flag = false;
                $.grep(List, function (o, j) {
                    if (o.SerialNumber == grn) {
                        flag = true;
                    }
                });
                return flag;
            }
        </script>
    </form>
</body>
</html>
