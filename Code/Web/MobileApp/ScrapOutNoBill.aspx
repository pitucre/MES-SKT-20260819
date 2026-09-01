<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScrapOutNoBill.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.ScrapOutNoBill" %>

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
    <title>无单报废出库</title>
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
                        无单报废出库
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" id="content1">
                <table style="width: 100%">
                    <tr id="grntr2">
                        <td>
                            <label>扫描GRN条码</label>
                        </td>
                        <td>
                            <input type="text" id="txtGRN" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                            <div style="display: none">
                                <input type="text" id="txtPosCode" class="TextBox" style="width: 100%; font-size: 16px; font-weight: bold; text-transform: uppercase; display: none;" />
                            </div>
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

                    <tr id="tr1" class="ListTableOddRow">
                        <td colspan="5" style="text-align: center;">暂无数据
                        </td>
                    </tr>

                </table>

            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" id="Savebtn" data-theme="f" value="确认报废" /></li>
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var inWarehouseId = -1;
            var inWhouseName = "";
            var inBarCode = "";
            var outWhouseName = "";
            var outBarCode = "";
            var List = [];   //物料列表
            $(document).ready(function () {
                $("#content1").find("a").css("display", "none");
            });
            //扫描GRN
            $("#txtGRN").on("keydown", function (e) {
                var c = curkey = 0, e = e || window.event;
                curkey = e.keyCode || e.which || e.charCode;
                var GRN = $.trim($("#txtGRN").val());
                if (curkey == 13) {
                    $("#msg").html("").removeClass("Bg-Red");
                    if (GRN == "") {
                        confirmDialog("GRN不能为空！");
                        return false;
                    }
                    //验证是否重复扫描
                    if (checkGrnExist($.trim($("#txtGRN").val())) === true) return false;
                    //检查是否可报废
                    var grnResult = checkGrn($.trim($("#txtGRN").val())) || false;
                    if (grnResult) {
                        showGrnList(grnResult);
                        $("#txtGRN").val('');
                        $("#tr1").remove();
                    } else {
                    }
                    $("#txtGRN").focus();
                }
            });
            //确认报废
            $("#Savebtn").on("click", function () {
                Save();
            });

            //检查GRN
            function checkGrn(grn) {
                //验证条码
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetItemIdByMaterialGRN($("#txtGRN").val().trim());
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message);
                    return false;
                }
                if (ajax.value === '') return false;
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message);
                    return false;
                }

                var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxScrapNoBillOut.ShowScrapNoBillOutInfo($("#txtGRN").val().trim());
                if (ajax2.error != null) {
                    $("#txtGRN").focus();
                    return false;
                }

                if (ajax2.value === '') return false;
                if (ajax2.error != null) {
                    confirmDialogFocus(ajax2.error.Message);
                    return false;
                }

                if (ajax2.value[0].WareHouseName == inWhouseName && ajax2.value[0].Code == inBarCode) {
                    $("#msg").html("【" + ajax2.value[0].SerialNumber + "】的库位条码【" + ajax2.value[0].Code + "】与调入的库位条码【" + inBarCode + "】一致,不能报废！");
                    $("#msg").css("color", "red");
                    return false;
                }
                if (List.length > 0) {
                    if (List.indexOf(ajax2.value[0].Code) == -1) {
                        $("#msg").html("【" + ajax2.value[0].SerialNumber + "】的库位条码【" + ajax2.value[0].Code + "】与明细的库位条码不一致,不能报废！");
                        $("#msg").css("color", "red");
                        return false;
                    }
                }
                var model = {};
                model.SerialNumber = ajax2.value[0].SerialNumber; //刷的条码
                model.PartId = ajax2.value[0].ItemID; //物料ID 
                model.WarehouseId = ajax2.value[0].WarehouseId; //仓别ID
                model.BWhPos = ajax2.value[0].Code; //调出货位

                List.push(model);

                var grnResult = ajax2.value;
                return grnResult;
            }

            //显示GRN扫描记录表
            function showGrnList(grnObj) {

                //console.log(grnObj)
                if (!grnObj[0]) return false;
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
                        $("#msg").html("【" + grn + "】GRN已扫描").css("color", "red");
                        exist = true;
                    } else {
                        $(this).removeClass("Bg-Red");
                    }
                });
                return exist;
            }
            //确认报废
            function Save() {
                var arrGrn = [];
                $(".SerialNumberData").each(function () {
                    arrGrn.push($(this).html());
                })
                if (arrGrn.length === 0) {
                    confirmDialogFocus('请扫描要报废的GRN', function () {
                        $("#txtGRN").focus();
                    });
                    return false;
                }
                if (!confirm('是否确认报废?')) {
                    return false;
                }

                var entity = {};
                entity.UserName = userName;
                entity.ScrapNoBillOutDtl = JSON.stringify(List);//明细数据
                setTimeout(function () {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapNoBillOut.SaveScrapNoBillOut(JSON.stringify(entity));
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        return false;
                    }
                    confirmDialog("报废成功");
                    window.location.reload();
                    //$(".ListTableOddRow GrnRow").remove();
                    //$("#tbGrnLog").append('<tr id="trNoGrn" class="ListTableOddRow"><td colspan="5" style="text-align: center;">暂无数据</td></tr>');
                    //$("#txtGRN").val('');
                    //$("#msg").html("");

                }, 50);

               
            }
        </script>
    </form>
</body>
</html>
