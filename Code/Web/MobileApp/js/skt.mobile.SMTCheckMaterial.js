var isCheckFeed = true; //是否启动飞达验证
$(function () {
    $(".ui-body-c").css("background", "#fff");
    $("body>[data-role='listview']").listview();
    $(".ui-select").css({ "margin": 0 });
    //获取是否扫描飞达配置
    $.post("../Handler/SMTLoadingMaterial.ashx?type=GetIsScanFeedConfig", { "Id": 903 }, function (data) {
        if (data == "否") {
            isCheckFeed = false;
            $("#txtFeedSN").parent().parent().hide();
            setTimeout(function () { $("#txtGRN").focus(); }, 10);

        }
    });
    chooseOrder();
});
$(document).bind("mobileinit", function () {
    $.mobile.ajaxEnabled = false;
});

var userId = '<% =SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>';
var userName = '<% =SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
var loadinglistId = -99;//上料清单id
var loadinglistName = "";
var orderNo = "";//工单号
var EquipmentId = "";//机台号
var itemId;
var SequenceNo;
var LineId;
var smtStatus;
var slotList = [];//插槽列表 总
var slotListTmp = [];//插槽列表 分区域
var slotMap = new Object();//区域插槽列表
var areaList = [];//区域列表
var ScanNum = 0;
var TotalNum = 0;
var Surplus = 0;
$("#txtMachineLot").on("keydown", function (e) {
    var curKey = 0, e = e || window.event;
    curKey = e.keyCode || e.which || e.charCode;
    setTimeout(function () {

        if (curKey == 13) {
            $("#msg").html("");
            $("#lblMItemCode").html("");
            $("#lblQty").html("");
            $("#lblMItemName").html("");
            if ($("#txtMachineLot").val() != "") {
                Check($.trim($("#txtMachineLot").val()), "", "");

                //$.post("../Handler/SMTLoadingMaterial.ashx?type=SearchGRN", { "loadinglistId": loadinglistId, "slot": $("#txtMachineLot").val() }, function (data) {
                //    data = JSON.parse(data);
                //    if (data.error != null) {
                //        confirmDialogFocus(data.error.Message);
                //        //写入日志
                //        SaveUserUILog(orderNo, data.error.Message);
                //        return false;
                //    }
                //    $("#showCheck").removeAttr("style");
                //    $("#lblMItemCode").html(data.ItemCode);
                //    //$("#lblQty").html(data.BalanceQty);
                //    $("#lblMItemName").html(data.ItemName);
                //});
                if (isCheckFeed) {
                    $("#txtFeedSN").focus();
                } else {
                    $("#txtGRN").focus();
                }
            } else {
                //confirmDialogFocus("Slot不能为空", function () { $("#txtMachineLot").focus(); })
                confirmDialogFocus("插槽号不能为空！", function () { $("#txtMachineLot").focus(); })
                //setTimeout('alert($("#txtMachineLot").val())',100);
            }
            return false;
        }

    }, 100)
    event.stopPropagation();
});
$("#txtFeedSN").on("keydown", function (e) {
    var curKey = 0, e = e || window.event;
    curKey = e.keyCode || e.which || e.charCode;
    setTimeout(function () {

        if (curKey == 13) {
            $("#msg").html("");
            //$("#lblMItemCode").html("");
            //$("#lblQty").html("");
            //$("#lblMItemName").html("");
            if ($("#txtFeedSN").val() != "") {
                //是否离线备料
                if (IsOffLine == "true") {
                    LoadingCheck();
                } else {
                    Check($.trim($("#txtMachineLot").val()), $("#txtFeedSN").val(), "");
                    $("#txtGRN").focus();
                }
            } else {
                confirmDialogFocus("Feeder不能为空", function () { $("#txtFeedSN").focus(); })
            }
        }
    }, 100);
    event.stopPropagation();
});
$("#txtGRN").on("keydown", function (e) {
    var curKey = 0, e = e || window.event;
    curKey = e.keyCode || e.which || e.charCode;
    setTimeout(function () {

        if (curKey == 13) {
            if ($("#txtGRN").val() == "") {
                confirmDialogFocus("GRN不能为空!!!", function () { $("#txtGRN").focus(); })
                return false;
            } else {
                LoadingCheck();
            }
        }
    }, 100);
    event.stopPropagation();
});
$("#txtOldGRN").on("keydown", function (e) {
    var curKey = 0, e = e || window.event;
    curKey = e.keyCode || e.which || e.charCode;
    if (curKey == 13) {
        $("#lblNewQty").html("");
        $("#lblNewItemCode").html("");
        $("#lblAddItemCode").html("");
        $.post("../Handler/SMTLoadingMaterial.ashx?type=SearchContinued", { "grn": $("#txtOldGRN").val(), "checkType": 1 }, function (data) {
            try {
                var result = JSON.parse(data);
            } catch (e) {
                confirmDialogFocus(data, function () {
                    $("#txtOldGRN").focus();
                });
                return false;
            }
            $("#lblAddItemCode").html(result.ItemCode);
            $("#txtNewGRN").focus();
        }).error(function () {
            $("#txtOldGRN").focus();
        });

    }
});
$("#txtNewGRN").on("keydown", function (e) {
    var curKey = 0, e = e || window.event;
    curKey = e.keyCode || e.which || e.charCode;
    if (curKey == 13) {
        $.post("../Handler/SMTLoadingMaterial.ashx?type=SearchContinued", { "grn": $("#txtNewGRN").val(), "checkType": 2 }, function (data) {
            try {
                var result = JSON.parse(data);
            } catch (e) {
                confirmDialogFocus(data, function () {
                    $("#txtOldGRN").focus();
                });
                return false;
            }
            $("#lblNewQty").html(result.BalanceQty);
            $("#lblNewItemCode").html(result.ItemCode);
            Continued();
        });
    }
});

//选择工单
function chooseOrder() {
    $("#OrderPanel").panel().panel("open");
    $.post("../Handler/SMTLoadingMaterial.ashx?type=GetOrderList", function (data) {
        var htmlstr = "";
        var data = JSON.parse(data);
        $('#Orderlistview').html('');
        for (var i = 0; i < data.length; i++) {
            htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' id='"
                 + data[i].ItemId + "|" + data[i].ItemCode + "|" + data[i].State + "|" + data[i].LineId + "|" + data[i].ItemName + "|" + data[i].LineName + "| " + data[i].TableDesc + "|" + data[i].StatusDesc
            + "' onclick=OrderList(this)>" + data[i].PlanOrderNo + "</li>";
        }
        $("#Orderlistview").append(htmlstr);
        $('#Orderlistview').listview().listview('refresh');
    });
}
function OrderList(ID) {
    $("#showMachie").html("请选择");
    $("#showOrderNo").html($(ID).html());
    var dataArr = $(ID).attr("id").split("|");
    orderNo = $(ID).html();
    ItemId = dataArr[0];
    ItemCode = dataArr[1];
    smtStatus = dataArr[2];
    LineId = dataArr[3];
    ItemName = dataArr[4];
    $("#fline").html(dataArr[5]);
    $("#fmf").html(dataArr[6]);
    $("#fstatus").html(dataArr[7]);
    if (dataArr[2] == 2) {
        $("#pull").html("工单暂停");
    } else {
        $("#pull").html("工单开始");
    }
    $("input[data-type='search']").val('');
    $("#OrderPanel").panel("close");
    chooseMachine();
}
//选择机台
function chooseMachine() {
    $("#MachinePanel").panel().panel("open");
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
        $('#Machinelistview').listview().listview('refresh');
    });
}
function MachineList(ID) {
    //清理
    $("#qty").html("");
    $("#txtMachineLot").val("");
    $("#showCheck").css("display", "none");
    $("#showMachie").html($(ID).html());
    $("#Infotab tbody").html("");
    var dataArr = $(ID).attr("id").split("|");

    SequenceNo = dataArr[2];
    IsLoading = dataArr[3];

    IsOffLine = dataArr[4];
    IsScanPos = dataArr[5];


    EquipmentId = dataArr[6];
    //loadinglistid
    $.post("../Handler/SMTLoadingMaterial.ashx?type=GetLoadingListIds",
        { "orderNo": orderNo, "LineId": LineId, "SequenceNo": SequenceNo, "ItemId": ItemId, "MachineId": EquipmentId }, function (data) {
            data = JSON.parse(data);
            if (data.error != null) {
                confirmDialogFocus(data.error);
                //写入日志
                SaveUserUILog(orderNo, data.error.Message);
                return false;
            }

            //loadinglistId = data[0];
            loadinglistName = data[1];
            //slotList = data[2].split('^');
            slotList = data.split('^');
            $("#arealist").html("");
            $("#arealist").selectmenu().selectmenu('refresh', true);
        })
        .success(function () {
            $("#setUpLines").removeAttr("style");
            //if (loadinglistName == null || loadinglistName == "") {
            //    confirmDialog("没有查询到对应的上料清单信息");
            //    return false;
            //}

            $("#lblHandList").html(loadinglistName);
            $("#lblItemCode").html(ItemCode);
            $("#lblItemName").html(ItemName);
        });
    $("input[data-type='search']").val('');
    $("#MachinePanel").panel("close");
}

//选择工单
function schooseOrder() {
    $("#SOrderPanel").panel().panel("open");
    $.post("../Handler/SMTLoadingMaterial.ashx?type=GetOrderList", function (data) {
        var htmlstr = "";
        var data = JSON.parse(data);
        $('#SOrderlistview').html('');
        for (var i = 0; i < data.length; i++) {
            htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' onclick=SOrderList('" + data[i].PlanOrderNo + "')>" + data[i].PlanOrderNo + "</li>";
        }
        $("#SOrderlistview").append(htmlstr);
        $('#SOrderlistview').listview().listview('refresh');
    });
}

//上料验证
function LoadingCheck() {
    if ($("#txtMachineLot").val() == "") {
        confirmDialogFocus("插槽不能为空", function () {
            $("#txtMachineLot").val("").focus();
        });
        return false;
    }
    slotHead = 1;//获取某个区域的上料数量
    if (IsScanPos == "true") {
        slotHead = 0;//总的上料数量
    }
    var grn = $.trim($("#txtGRN").val());
    //if (IsOffLine == "true") {
    //    grn = "-1";
    //}
    if ($("#loadingtab tr:eq(3):hidden").is(":hidden")) {
        grn = "-1";
    }
    var selectArea = $("#arealist").val();
    var AreaValue = $("#arealist").prev().text();

    if (AreaValue == "") {
        confirmDialogFocus("区域不能为空", function () {
            $("#arealist").focus();
        });
        return false;
    }

    $.post("../Handler/SMTLoadingMaterial.ashx?type=LoadingMaterial",
        //JIT { "orderNo": orderNo, "loadinglistId": loadinglistId, "slot": $.trim($("#txtMachineLot").val()), "feeder": $.trim($("#txtFeedSN").val()), "grn": grn, "userId": userId, "slotHead": slotHead }, function (data) {
        { "orderNo": orderNo, "machineId": EquipmentId, "slot": $.trim($("#txtMachineLot").val()), "feeder": $.trim($("#txtFeedSN").val()), "grn": grn, "userId": userId, "slotHead": slotHead, "area": AreaValue }, function (data) {
            var lastLot = $.trim($("#txtMachineLot").val());
            data = JSON.parse(data);
            if (data.error != null) {
                confirmDialogFocus(data.error, function () {
                    var str = data.error.substring(0, 2);
                    if (str == "1#") {
                        $("#txtMachineLot").val("").focus();
                    } else if (str == "2#") {
                        $("#txtFeedSN").val("").focus();
                    } else if (str == "3#") {
                        $("#txtGRN").val("").focus();
                    }
                });
                //写入日志
                SaveUserUILog(orderNo, data.error.Message);
                return false;
            }
            ScanNum = data;
            if (smtStatus == 0 || smtStatus == 5) {
                $("#fstatus").html("上料验证");
                $("#pull").html("工单开始");
                smtStatus = 1;
            }
            //是否离线备料
            if (IsOffLine == "false") {
                $("#showCheck").removeAttr("style");
                $.post("../Handler/SMTLoadingMaterial.ashx?type=SearchGRN", { "loadinglistId": loadinglistId, "grn": $.trim($("#txtGRN").val()) }, function (data) {
                    data = JSON.parse(data);
                    $("#lblMItemCode").html(data.ItemCode);
                    $("#lblQty").html(data.BalanceQty);
                    $("#lblMItemName").html(data.ItemName);
                });
            }
            if (IsScanPos == "false") {
                $("#qty").html(ScanNum + "/" + (TotalNum));
                $("#txtMachineLot").val(slotListTmp[flag]);
                //slotListTmp.splice($.inArray(slotListTmp[flag], slotListTmp), 1);
                flag++;
                $("#loadingtab tr:eq(2) input").focus();
                $("#loadingtab :input:gt(1)").val('');
            }
            else {
                //
                $("#qty").html(ScanNum + "/" + TotalNum);
                $("#loadingtab tr:eq(1) input").focus();
                $("#loadingtab :input").val('');
            }

            var arr = $("#qty").html().split('/');
            slotList.forEach(function (obj, i) { if (obj.indexOf(lastLot) > -1) { slotList.splice(i, 1); } });

            if (slotList.length == 0) {//为点击清楚上料记录做处理
                slotList = [""];
            }
            if (parseInt(arr[0]) >= parseInt(arr[1])) {

                $("#arealist option[value='" + AreaValue + "']").remove();
                $("#arealist").selectmenu().selectmenu('refresh', true).change();
                $("#msg").html("验证成功，已上料完成！").css("color", "#7FFF00");
                showWaitGRN(orderNo, EquipmentId);
            }
            else {
                $("#msg").html("验证成功").css("color", "#7FFF00");
                //显示明细信息
                showWaitGRN(orderNo, EquipmentId);
            }
        }).error(function () {
            confirmDialog("验证失败");
            return false;
        });
}
function Check(slot, feeder, grn) {
    setTimeout(function () {
        if (slot == "") {
            confirmDialogFocus("插槽不能为空", function () {
                $("#txtFeedSN").val("");
                $("#txtGRN").val("");
                if (IsScanPos != 'false') {
                    $("#txtMachineLot").val("").focus();
                }
            });
            return false;
        }
        slotHead = 1;//获取某个区域的上料数量
        if (IsScanPos == "true") {
            slotHead = 0;//总的上料数量
        }
        var grn = $.trim($("#txtGRN").val());
        var AreaValue = $("#arealist").prev().text();

        $.post("../Handler/SMTLoadingMaterial.ashx?type=LoadingMaterial",
            //{ "orderNo": orderNo, "loadinglistId": loadinglistId, "slot": slot, "feeder": feeder, "grn": grn, "userId": userId, "slotHead": slotHead }, function (data) {
            { "orderNo": orderNo, "machineId": EquipmentId, "slot": $.trim($("#txtMachineLot").val()), "feeder": $.trim($("#txtFeedSN").val()), "grn": grn, "userId": userId, "slotHead": slotHead, "area": AreaValue }, function (data) {
                data = JSON.parse(data);
                if (data.error != null) {
                    confirmDialogFocus(data.error, function () {
                        var str = data.error.substring(0, 2);
                        if (str == "1#") {
                            if (IsScanPos != 'false') {
                                $("#txtMachineLot").val("").focus();
                            }
                        } else if (str == "2#") {
                            $("#txtFeedSN").val("").focus();
                        } else if (str == "3#") {
                            $("#txtGRN").val("").focus();
                        }
                    });
                    //写入日志
                    SaveUserUILog(orderNo, data.error.Message);
                    return false;
                }
                ScanNum = data;
                if (isCheckFeed) {
                    $("#txtFeedSN").focus();
                } else {
                    $("#txtGRN").val("").focus();
                }
            }).error(function () {
                confirmDialog("验证失败");
                return false;
            });
    }, 100);
    if (isCheckFeed) {
        $("#txtFeedSN").focus();
    } else {
        $("#txtGRN").val("").focus();
    }
}
//清除上料清单记录
function Clean() {
    $("#msg").html("");
    //if (loadinglistId == null || loadinglistId == "") {
    //    confirmDialog("请选择上料清单");
    //    return false;
    //}
    confirmDialog("是否清除上料记录", function () {
        $.post("../Handler/SMTLoadingMaterial.ashx?type=Clean", { "orderNo": orderNo, "EquipmentId": EquipmentId, "UserId": userId }, function (data) {
            if (data != "") {
                confirmDialog(data);
                //写入日志
                SaveUserUILog(orderNo, data);
                return false;
            }
            $("#txtMachineLot").val("");
            $("#txtFeedSN").val("");
            $("#txtGRN").val("");
            $("#lblMItemCode").html("");
            $("#lblQty").html("");
            $("#lblMItemName").html("");
            var machineObj = $("#MachinePanel ul li[machineid='" + EquipmentId + "']");
            slotList = [];
            MachineList(machineObj);
            pageTwopageshow();//刷新区域下拉、插槽input
            //显示明细信息
            showWaitGRN(orderNo, EquipmentId);
            //$("#txtMachineLot").val("");
            //$("#txtFeedSN").val("");
            //$("#txtGRN").val("");
            //slotListTmp = sumslotTemp[0];//这里要使用sumslotTemp的list 没有被删除
            //flag = 1;
            //$("#txtMachineLot").val(slotList[0]);
            //$("#qty").html("");
            //$("#qty").html("0/" + sumslotTemp[slotList[0].substring(0, 1)].length);//初始化选择数量
            //$("#arealist").selectmenu('refresh', true);
            ////confirmDialog("清除成功！");
        });
    });
}

//显示未上料信息根据工单和机台过滤
function showWaitGRN(searchOrder, machineId) {
    $("#waitMaterialTab tr:gt(0)").html("");
    var AreaValue = $("#arealist").prev().text();
    $.post("../Handler/SMTLoadingMaterial.ashx?type=ShowMaterialGRN", { "orderNo": searchOrder, "machineId": machineId, "area": AreaValue }, function (data) {
        var result = $.parseJSON(data).data;
        Surplus = result.length;
        for (var i = 0; i < result.length; i++) {
            $("#waitMaterialTab").append("<tr><td>" + result[i].EquipmentName + "</td><td>" + result[i].Position + "</td><td>" + result[i].FeederType + "</td><td>" + result[i].SerialNumber + "</td></tr>");
        }
    });
}

//续料
function Continued() {
    $.post("../Handler/SMTLoadingMaterial.ashx?type=Continued",
        { "orderNo": orderNo, "loadinglistId": loadinglistId, "oldGRN": $.trim($("#txtOldGRN").val()), "newGRN": $.trim($("#txtNewGRN").val()), "userId": userId }, function (data) {
            if (data != "") {
                confirmDialog(data);
                //写入日志
                SaveUserUILog(orderNo, data);
                return false;
            }
            confirmDialogFocus("续料成功", function () {
                $("#txtNewGRN").val("").focus();
                $("#txtOldGRN").val("").focus();
            });
        });
}
//卸料
function UnLoad() {
    if (orderNo == "") {
        confirmDialog("请选择工单");
        return false;
    }
    if ($("#pull").html() == "工单暂停") {
        confirmDialog("请执行工单暂停操作！");
        return false;
    }
    $.post("../Handler/SMTLoadingMaterial.ashx?type=UnLoad",
    { "orderNo": orderNo, "userName": userName }, function (data) {
        if (data != "") {
            confirmDialog(data);
            //写入日志
            SaveUserUILog(orderNo, data);
            return false;
        }
        confirmDialog("卸料成功");
        smtStatus = 5;
        $("#fstatus").html("卸料");
        $("#Infotab tbody").html("");
    });
}
//工单开始、工单暂停
function HandOpenOrStop(num) {
    if (orderNo == "") {
        confirmDialog("请选择工单");
        return false;
    }
    if (loadinglistId == 0 || loadinglistId == -1) {
        confirmDialog("请选择机台");
        return false;
    }
    if (smtStatus == 0) {
        confirmDialog("未上料验证,不能操作");
        return false;
    }
    if (smtStatus == 4) {
        confirmDialog("已完成，不能操作");
        return false;
    }
    if (smtStatus == 5) {
        confirmDialog("已卸料,不能进行此操作");
        return false;
    }
    //$("#Pull").html() == "开拉" ? flage = 1 : flage = 2;
    $.post("../Handler/SMTLoadingMaterial.ashx?type=Pull", { "orderNo": orderNo, "loadinglistId": 0, "userName": userName }, function (data) {
        if (data != "") {
            confirmDialog(data);
            //写入日志
            SaveUserUILog(orderNo, data);
            return false;
        }

        var showMsg = "";
        if ($("#pull").html() == "工单开始") {
            showMsg = "工单开拉";
        }
        else {
            showMsg = $("#pull").html();
        }
        confirmDialogFocus($("#pull").html() + "成功！", function () {
            if (smtStatus == 1) {
                $("#fstatus").html("投产中");
                $("#pull").html("工单暂停");
                smtStatus = 2;
            } else if (smtStatus == 2) {
                $("#fstatus").html("已暂停");
                $("#pull").html("工单开始");
                smtStatus = 3;
            } else if (smtStatus == 3) {
                $("#fstatus").html("投产中");
                $("#pull").html("工单暂停");
                smtStatus = 2;
            }
        });
        //if (num == 1) {
        //    confirmDialog("开始成功");
        //    $("#pull").html("工单暂停");
        //    $("#fstatus").html("投产中");
        //    smtStatus = 2;
        //    clean();
        //    $("#showCheck").css("display", "none");
        //    $.mobile.changePage("#pageOne", { transition: 'none' });
        //} else {
        //    confirmDialogFocus($("#pull").html() + "成功！", function () {
        //        $("#pull").html() == "工单开始" ? $("#fstatus").html("投产中") : $("#fstatus").html("已暂停");
        //        $("#pull").html() == "工单开始" ? $("#pull").html("工单暂停") : $("#pull").html("工单开始");
        //        if (smtStatus == 2) {
        //            smtStatus: 3;
        //        } else if (smtStatus == 3) {
        //                smtStatus: 2;
        //        }
        //    });
        //}
        //flage = 3 - flage == 1 ? $("#pull").html("开拉") : $("#pull").html("停拉");
    });
}

//工单完成
function Fish() {
    if (smtStatus != 5) {
        confirmDialog("该状态不能完成");
        return false;
    }
    $.post("../Handler/SMTLoadingMaterial.ashx?type=SmtFinished", { "orderNo": orderNo }, function (data) {
        if (data != "") {
            confirmDialog(data);
            //写入日志
            SaveUserUILog(orderNo, data);
            return false;
        }
    });
    confirmDialog("工单完成!");
    window.location.reload();
}

//下一步
function setUpLine() {
    if (orderNo == "") {
        confirmDialog("请选择工单！");
        return false;
    }
    if ($("#showMachie").html() == "") {
        confirmDialog("请选择机台！");
        return false;
    }
    if (smtStatus > 1 && smtStatus < 5) {
        confirmDialog("当前状态不能上料");
        return false;
    }
    //if (loadinglistId == 0 || loadinglistId == -1) {
    //    confirmDialog("上料清单不存在");
    //    return false;
    //}
    $.mobile.changePage("#pageTwo", { transition: 'none' });
    //显示明细信息
    //showWaitGRN(orderNo, EquipmentId);
    //$(".ui-table-columntoggle-btn").css("display", "none");
}
//选择区域
$("#arealist").on("change", function () {
    Area = $("#arealist option:selected").val();
    if (Area == undefined) {
        return false;
    }
    slotListTmp = slotMap[Area];
    flag = 1;

    $("#qty").html("");
    //获取已扫描的个数
    $.post("../Handler/SMTLoadingMaterial.ashx?type=Search", { "orderNo": orderNo, "SearchType": 1 }, function (data) {

        data = JSON.parse(data);
        var value = 0;

        for (var i = 0; i < data.length; i++) {
            if (data[i].EquipmentLineDisplayName == $("#showMachie").html() && Area == data[i].Area) {
                value++;
            }
        }

        //移除已上料的插槽
        for (var i = 0; i < data.length; i++) {
            if (data[i].Area == Area) {
                if ($.inArray(data[i].TableSlotSN, slotListTmp) != -1) {
                    slotListTmp.splice($.inArray(data[i].TableSlotSN, slotListTmp), 1)
                }
            }
        }
        if (IsScanPos == "true") {
            $("#txtMachineLot").val("");
        } else {
            $("#txtMachineLot").val(slotListTmp[0]);
        }

        TotalNum = (value + slotListTmp.length);
        $("#qty").html(value + "/" + TotalNum);//初始化选择数量
        if (isCheckFeed) {
            $("#txtFeedSN").val("").focus();
        }
        else {

            if (IsScanPos == "true") {
                $("#txtMachineLot").val("").focus();
            } else {
                $("#txtGRN").val("").focus();
            }
        }

        //显示明细信息
        showWaitGRN(orderNo, EquipmentId);
    });
});


$(document).on("pageshow", "#pageOne", function (event) {
    $(".ui-body-c").css("background", "#fff");
});
//进入上料页面之前,重置页面（4种验证模式）
$(document).on("pageshow", "#pageTwo", function (event) {
    $("#msg").html("");
    $("#txtMachineLot").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
    $("#txtFeedSN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
    $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
    //是否离线备料
    if (IsOffLine == "true") {

        $("#loadingtab tr:eq(3)").css("display", "none");
    } else {
        $("#loadingtab tr:eq(3)").css("display", "");
    }
    pageTwopageshow();
});
//刷新上料页面
function pageTwopageshow() {
    //是否需要扫描插槽
    if (slotList[0] == '') {
        confirmDialogFocus('该机台已上完料');
        return false;
    }

    var ySNum = 0;
    areaList = [];
    if (IsScanPos == "false") {

        $("#loadingtab tr:eq(0)").css("display", "");
        $("#loadingtab tr:eq(1) input").prop("readonly", "readonly");
        $("#txtFeedSN").focus();




    } else {
        $("#loadingtab tr:eq(0)").css("display", "");
        $("#loadingtab tr:eq(1) input").prop("readonly", false);
        $("#txtFeedSN").focus();


    }

    var AreaValue = slotList[0].substring(0, slotList[0].indexOf("$"));

    $.post("../Handler/SMTLoadingMaterial.ashx?type=GetScanNum", { "orderNo": orderNo, "EquipmentId": EquipmentId, "area": AreaValue }, function (data) {


        //组合数据
        slotMap = new Object();
        var areaStr = "";
        var soltStr = "";
        for (var i = 0; i < slotList.length; i++) {
            areaStr = slotList[i].substring(0, slotList[i].indexOf("$"));
            soltStr = slotList[i].substring(slotList[i].indexOf("$") + 1, slotList[i].length);
            if (i < 1) {
                slotMap[areaStr] = [soltStr];
                areaList.push(areaStr); //区域列表
            } else {
                if (slotMap[areaStr]) {
                    slotMap[areaStr].push(soltStr);
                } else {
                    slotMap[areaStr] = [soltStr];
                }
                //区域列表
                if ($.inArray(areaStr, areaList) == -1) {
                    areaList.push(areaStr);
                }
            }
        }
        $("#arealist").html("");

        sumslotTemp = $.extend(true, [], slotMap);

        //生成区域下拉
        var arealiststr = "";
        if (areaList.length <= 0) {
            confirmDialogFocus('该机台已上完料');
            //写入日志
            SaveUserUILog(orderNo, "该机台已上完料");
            return false;
        }

        for (var i = 0; i < areaList.length; i++) {
            arealiststr += "<option value='" + areaList[i] + "'>" + areaList[i] + "</option>";
        }
        $("#arealist").append(arealiststr);
        $("#arealist").selectmenu('refresh', true);
        //初始化插槽输入值
        slotListTmp = slotMap[areaList[0]];
        if (IsScanPos == "false") {
            $("#txtMachineLot").val(slotListTmp[0]);
            $("#txtGRN").val("").focus();
        } else {
            $("#txtMachineLot").val("").focus();
        }
        showWaitGRN(orderNo, EquipmentId);
        $(".ui-table-columntoggle-btn").css("display", "none");
        setTimeout(function () {
            flag = 1;
            TotalNum = (parseInt(Surplus) + parseInt(data));//(parseInt(slotListTmp.length) + parseInt(data));
            ySNum = data;

            $("#qty").html(ySNum + "/" + TotalNum); //初始化选择数量
        }, 100);


    });

    //else {
    //    $("#loadingtab tr:eq(0)").css("display", "none");
    //    $("#loadingtab tr:eq(1) input").prop("readonly", false).focus();

    //    //获取已扫描的个数
    //    $.post("../Handler/SMTLoadingMaterial.ashx?type=Search", { "orderNo": orderNo, "SearchType": 1 }, function (data) {
    //        data = JSON.parse(data);
    //        var value = 0;
    //        for (var i = 0; i < data.length; i++) {
    //            if (data[i].EquipmentLineDisplayName == $("#showMachie").html()) { value++; }
    //        }
    //        TotalNum = (value + slotList.length);
    //        $("#qty").html(value + "/" + TotalNum);//初始化选择数量
    //    });
    //}
}

//进入续料页面
$(document).on("pageshow", "#AddMaterial", function (event) {
    $(".ui-table-columntoggle-btn").css("display", "none");
    $("#txtOldGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() }).focus();
    $("#txtNewGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
    //显示续料预警列表
    $("#HAddMaterialTab").html('').append("<tr><td>区域</td><td>站位</td><td>物料编码</td><td>物料数量</td><td>可用时间(MIN)</td></tr>")
    $.post("../Handler/SMTLoadingMaterial.ashx?type=GetHAddMaterialTab", { "orderNo": orderNo, "machineId": EquipmentId }, function (data) {
        //$("#HAddMaterialTab")
        var result = $.parseJSON(data).data;
        for (var i = 0; i < result.length; i++) {
            $("#HAddMaterialTab").append("<tr><td>" + result[i].Position.substring(0, 1) + "</td><td>" + result[i].Position +
                "</td><td>" + result[i].ItemCode + "</td><td>" + result[i].BalanceQty + "</td><td>" + result[i].Times + "</td></tr>");
        }
    })
});
//查询页隐藏columntoggle列表按钮
$(document).on("pageshow", "#Search", function (event) {
    $(".ui-body-c").css("background", "#fff");
    $(".ui-table-columntoggle-btn").css("display", "none");
    $("#SshowOrderNo").html($("#showOrderNo").html());
    //$('#SshowOrderNo').textinput();
});
/**************************查询页面*********************************************/

function SOrderList(ID) {
    $("#classType").html();
    $("#SshowOrderNo").html(ID);
    $("input[data-type='search']").val('');
    $("#SOrderPanel").panel("close");
}
$("#classType").on("change", function () {
    if ($("#classType").val() == -1) {
        $("#Infotab tbody").html("");
        return false;
    }
    if ($("#SshowOrderNo").html() == "") {
        confirmDialog("请选择排程工单！");
        return false;
    }
    Search();
});
//查询
function Search() {
    $.post("../Handler/SMTLoadingMaterial.ashx?type=Search", { "orderNo": $("#SshowOrderNo").html(), "SearchType": $("#classType").val() }, function (data) {
        data = JSON.parse(data);
        $("#Infotab tbody").html("");
        var htmlstr = "";
        for (var i = 0; i < data.length; i++) {
            htmlstr += "<tr><td>" + data[i].EquipmentLineDisplayName + "</td><td>" + (data[i].Area == null ? "" : data[i].Area) + "</td><td>" + data[i].TableSlotSN + "</td><td>" + data[i].FeedStr + "</td><td>" + data[i].BalanceQty + "</td><td>" + (data[i].GrnStr == null ? "" : data[i].GrnStr) + "</td>"
            //+ "<td>" + (data[i].ItemCode == null ? "" : data[i].ItemCode) + "</td><td>" + (data[i].AlreadyQty == null ? 0 : data[i].AlreadyQty) + "</td></tr>";
            if (data[i].GrnStr != "") {
                htmlstr += "<td><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + data[i].GrnStr + "',this)  /></td>";
            } else {
                htmlstr += "<td></td>";
            }
        }
        $("#Infotab tbody").html(htmlstr);
        $("#Infotab").table("refresh");
    });
}

//执行删除方法
function deleteGRN(deleteGRN, obj) {
    confirmDialog('确定移除该GRN', function () {
        //删除GRN方法
        var orderNo = $("#SshowOrderNo").html();//排程工单
        $.post("../Handler/SMTLoadingMaterial.ashx?type=DeleteSMTMaterial", { "orderNo": orderNo, "deleteGRN": deleteGRN, "UserName": userName }, function (data) {
            if (data != "") {
                confirmDialog(data);
                $("#msg").html(data).css("color", "red");
                //重新加载：

            }
            else {
                $("#msg").html("");
                //移除该条记录：
                Search();
                //  $(obj).parent().remove();
            }
        });
    });
}

$(document).on("pageshow", function (event) {
    var _id = location.hash;
    if (_id == "") {
        $("#pageOne div ul li a").each(function () {
            if ($(this).attr("href") == "#pageOne") {
                $(this).addClass("ui-btn-active");
                return;
            }
        });
        return false;
    }
    $(_id + " div ul li a").each(function () {

        if ($(this).attr("href") == _id) {
            $(this).addClass("ui-btn-active");
            return;
        }
    })
});

/*
*写入用户操作日志
*/
function SaveUserUILog(OederNo, LogContent) {
    //try{
    //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.SaveUserUILog("一般", -1, -1, OederNo, LogContent);
    //    if (ajax.error != null) {
    //        return false;
    //    }
    //} catch (e) {
    //}
}