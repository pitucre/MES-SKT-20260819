<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransferOutNoBill.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.TransferOutNoBill" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <title>无单调拨出库</title>
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

        .Bg-Red {
            background: red;
            font-weight: bolder;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/Acc_w.png" />
                    </div>
                    <div>
                        无单调拨出库
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" id="content1">
                <table style="width: 100%">
                    <tr id="grntr1">
                        <td>
                            <label>调入库位条码</label>
                        </td>
                        <td>
                            <input type="text" id="txtGoalPos" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>调入仓库</label></td>
                        <td>
                            <label id="lblInWarehouse"></label>
                        </td>
                    </tr>
                    <tr id="grntr2">
                        <td>
                            <label>扫描GRN条码</label>
                        </td>
                        <td>
                            <input type="text" id="txtGRN" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <table data-role="table" id="tbGrnLog" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%">
                    <thead>
                        <tr>
                            <th>GRN条码
                            </th>
                            <th>物料编码
                            </th>
                            <th>库位条码
                            </th>
                            <th>可调数量
                            </th>
                            <th></th>
                        </tr>
                    </thead>
                    <tr id="trNoGrn" class="ListTableOddRow">
                        <td colspan="5" style="text-align: center;">暂无数据
                        </td>
                    </tr>
                </table>

            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtn" data-theme="f" value="确认调拨" /></li>
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var inWarehouseId = -1;
            var inWhName = "";
            var inWhCode = "";
            var List = [];   //物料列表
            $(function () {
                $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
            });

            /*扫描库位条码*/
            $("#txtGoalPos").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    //验证库位条码是否正确
                    if (!checkPosCode()) {
                        $("#txtGoalPos").val("");
                        $("#txtGoalPos").focus();
                        $("#txtGoalPos").select();
                        return false;
                    }
                    $("#txtGRN").focus();
                    $("#msg").html("【" + $("#txtGoalPos").val() + "】调入库位条码扫描成功！");
                    $("#msg").css("color", "green");
                }
            });

            //验证库位条码
            function checkPosCode() {
                var posCode = $.trim($("#txtGoalPos").val());
                if (posCode == "") {
                    confirmDialog("请扫描库位！");
                    $("#txtGoalPos").focus();
                    return false;
                }
                var entity = {};
                entity.PosCode = posCode;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetWarehouseInfoByPosCode", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var result = $.parseJSON(ajax.value).data;
                if (!result || result.length == 0) {
                    $("#msg").html("不存在库位条码【" + posCode + "】！").css("color", "red");
                    $("#txtGoalPos").focus();
                    $("#txtGoalPos").select();
                    return false;
                }
                //显示库位相关的仓库
                $("#lblInWarehouse").text(result[0].CWhName);
                inWarehouseId = result[0].WarehouseId;
                inWhName = result[0].CWhName;
                inWhCode = result[0].CWhCode;
                return true;
            }

            //扫描GRN
            $("#txtGRN").on("keydown", function (e) {
                var c = curkey = 0, e = e || window.event;
                curkey = e.keyCode || e.which || e.charCode;
                if (curkey == 13) {
                    $("#msg").html("").removeClass("Bg-Red");
                    var GRN = $.trim($("#txtGRN").val());
                    var posCode = $.trim($("#txtGoalPos").val());

                    //验证库位条码是否正确
                    if (!checkPosCode()) {
                        $("#txtGoalPos").val("");
                        $("#txtGoalPos").focus();
                        $("#txtGoalPos").select();
                        return false;
                    }

                    //校验GRN
                    if (GRN == "") {
                        confirmDialog("GRN不能为空！");
                        return false;
                    }
                    //验证是否重复扫描
                    if (checkGrnExist($.trim($("#txtGRN").val())) === true) return false;
                    //检查是否可调拨
                    var grnResult = checkGrn($.trim($("#txtGRN").val())) || false;
                    if (grnResult) {
                        showGrnList(grnResult);
                        $("#txtGRN").val('');
                        $("#trNoGrn").remove();
                    } else {
                    }
                    $("#txtGRN").focus();
                }
            });
            //确认调拨
            $("#Savebtn").on("click", function () {
                Save();
            });

            //检查GRN
            function checkGrn(grn) {
                //验证条码
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetItemIdByMaterialGRN($("#txtGRN").val().trim());
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message);
                    closeWaiting();
                    return false;
                }
                if (ajax.value === '') return false;
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message);
                    return false;
                }


                ///获取GRN信息
                var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.ShowTransfOutInfo($("#txtGRN").val().trim());
                if (ajax2.error != null) {
                    $("#txtGRN").focus();
                    return false;
                }

                if (ajax2.value === '') return false;
                if (ajax2.error != null) {
                    confirmDialogFocus(ajax2.error.Message);
                    return false;
                }

                if (ajax2.value[0].WareHouseName == inWhName) {
                    $("#msg").html("【" + ajax2.value[0].SerialNumber + "】的不能调入物料所在仓库【" + ajax2.value[0].WareHouseName + "】！");
                    $("#msg").css("color", "red");
                    return false;
                }

                //校验库位的产品唯一
                if (!verifyProductOnly($.trim($("#txtGoalPos").val()), ajax2.value[0].ItemCode)) return false;


                var model = {};
                model.SerialNumber = ajax2.value[0].SerialNumber; //刷的条码
                model.PartId = ajax2.value[0].ItemID; //物料ID 
                model.InWarehouseId = inWarehouseId; //调入仓别ID   
                model.OutWarehouseId = ajax2.value[0].OutWarehouseId; //调出仓别ID
                model.InBWhPos = $.trim($("#txtGoalPos").val());
                model.OutBWhPos = ajax2.value[0].Code; //调出货位
                model.ItemCode = ajax2.value[0].ItemCode;

                List.push(model);

                var grnResult = ajax2.value;
                return grnResult;
            }

            //显示GRN扫描记录表
            function showGrnList(grnObj) {

                if (!grnObj || grnObj.length == 0) return false;
                var serialNumber = grnObj[0].SerialNumber;
                var itemCode = grnObj[0].ItemCode;
                var cBarCode = grnObj[0].Code;
                var balanceQty = grnObj[0].AdjustNumber;

                var r = "<tr class='ListTableOddRow GrnRow'>";
                r += "<td class='SerialNumberData'>" + serialNumber + "</td>";
                r += "<td class='ItemCodeData'>" + itemCode + "</td>";
                r += "<td class='CBarCodeData'>" + cBarCode + "</td>";
                r += "<td class='BalanceQtyData'>" + balanceQty + "</td>";
                r += "<td style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"delGrnRec(this)\">删除</td>";
                r += "</tr>";

                $("#trNoGrn").remove();
                if ($("#tbGrnLog tr").length === 1) {
                    $("#tbGrnLog tr:eq(0)").after(r);
                }
                else {
                    $("#tbGrnLog tr:eq(1)").before(r);
                }
            }

            //删除已扫描的GRN
            function delGrnRec(obj) {
                var table = document.getElementById("tbGrnLog");
                table.deleteRow(obj.parentElement.rowIndex);
                var index = -1;
                for (var i = 0; i < List.length; i++) {
                    if (obj.parentElement.innerText.indexOf(List[i].SerialNumber) == 0) {
                        List.splice(i, 1);
                    }
                }
                if ($("#tbGrnLog tr").length === 1) {
                    $("#tbGrnLog tr:eq(0)").after('<tr id="trNoGrn" class="ListTableOddRow">' +
                        '<td colspan="5" style="text-align: center;">暂无数据</td>' +
                        '</tr>');
                }
            }
            function checkGrnExist(grn) {
                var exist = false;
                $(".SerialNumberData").each(function () {
                    if ($(this).html() === grn) {
                        $(this).addClass("Bg-Red");
                        $("#msg").html("GRN已扫描").css("color", "red");
                        exist = true;
                    } else {
                        $(this).removeClass("Bg-Red");
                    }
                });
                return exist;
            }
            //确认调拨
            function Save() {
                var arrGrn = [];
                $(".SerialNumberData").each(function () {
                    arrGrn.push($(this).html());
                })
                if (arrGrn.length === 0) {
                    confirmDialogFocus('请扫描要调拨的GRN', function () {
                        $("#txtGRN").focus();
                    });
                    return false;
                }
                //校验库位的产品唯一
                var isOK = true;
                $.each(List, function (i, o) {
                    if (!verifyProductOnly(o.InBWhPos, o.ItemCode)) {
                        isOK = false;
                        return false;
                    }
                });
                if (!isOK) return false;

                if (!confirm('是否确认调拨?')) {
                    return false;
                }

                var entity = {};
                entity.UserName = userName; 
                entity.TransferOutDtl = JSON.stringify(List);//明细数据
                entity.OpSource = 2;
                setTimeout(function () {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.SaveTransferOut(JSON.stringify(entity));
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        closeWaiting();
                        return false;
                    }
                    confirmDialog("调拨成功");
                    ClearInfo();

                }, 50);

                $(".ItemRow").remove();
                $(".GrnRow").remove();
                $("#tbGrnLog").append('<tr id="trNoGrn" class="ListTableOddRow"><td colspan="5" style="text-align: center;">暂无数据</td></tr>');
                $("#txtGoalPos").val('');
                $("#txtGRN").val('');
                $("#msg").html("");
            }

            //清空数据
            function ClearInfo() {
                inWarehouseId = -1;
                inWhName = "";
                inWhCode = "";
                List = [];   //物料列表
            }

            //校验货位产品唯一
            function verifyProductOnly(cBarCode, itemCode) {
                var array = [];
                var list = List;
                //当前正在扫描的GRN的物料编码(无该参数则校验已扫描的GRN)
                if (itemCode) {
                    array.push(itemCode);
                }
                //去重复
                if (list && list.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        //相同的库位（多个库位条码调拨时处理）
                        if (list[i].InBWhPos == cBarCode) {
                            if (array.indexOf(list[i].ItemCode) === -1) {
                                array.push(list[i].ItemCode)
                            }
                        }
                    }
                }
                //校验
                if (array.length > 0) {
                    if (array.length == 1) {
                        var result = isItemCanPlacedInWarehouseLocation("", array[0], cBarCode);
                        if (result == -1) {
                            return false;
                        }
                        if (result == 0) {
                            alert("当前库位不支持存放多种产品，请扫描其他库位！");
                            $("#txtPosCode").val("").focus();
                            return false;
                        }
                    }
                    else {
                        var isProductOnly = isItemCanPlacedInWarehouseLocation("", "", cBarCode);
                        if (isProductOnly == -1) {
                            return false;
                        }
                        if (isProductOnly == 1) {
                            alert("当前库位不支持存放多种产品，请扫描其他库位！");
                            $("#txtPosCode").val("").focus();
                            return false;
                        }
                    }
                }
                return true;
            }

            //判断产品是否能放入当前库位
            function isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
                if (ajax.error != null) {
                    alert(ajax.error.Message, 0);
                    return -1;
                }
                return ajax.value ? 1 : 0;
            }
        </script>
    </form>
</body>
</html>
