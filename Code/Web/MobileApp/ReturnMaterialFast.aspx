<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnMaterialFast.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.ReturnMaterialFast" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" href="css/bootstrap.min.css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">

    <title>生产便捷退料</title>
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
    </style>
</head>
<body>
    <form runat="server" onsubmit="return false;">
        <div data-role="page" data-url="setpage" class="bindpage" id="bindpage">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">生产便捷退料</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>

            </div>
            <div data-role="content">
                <table style="width: 100%" id="Table1">
                    <tr>
                        <td>
                            <label for="warehouse">
                                仓库:</label>
                        </td>
                        <td>
                            <select name="warehouse" data-mini="true" id="warehouse" class="warehouse">
                                <option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtGRN">
                                GRN:</label>
                        </td>
                        <td>
                            <input class="txtGRN" id="txtGRN" type="text" data-mini="true"
                                value="" data-theme="e" />
                        </td>
                    </tr>
                </table>
                <table id="infotab" data-role='table' data-mode='columntoggle' class='ui-responsive table-stroke' style='width: 100%'>
                    <thead>
                        <tr>
                            <th>GRN</th>
                            <th>物料编码</th>
                            <th>数量</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="scanIfo">
                    </tbody>
                </table>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="f">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" onclick="returnMaterial()" data-theme="f" value="确认退料" /></li>
                    </ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var grnArr = [];
            var scanArr = [];

            $().ready(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");

                //仓库下拉
                $.ajax({
                    type: "POST",
                    url: "../Handler/WarehouseCheck.ashx?api=GetWarehouseInfo",
                    async: false,
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (a, b) {
                            $("#warehouse").append("<option value='" + b.CWhCode + "'>" + b.CWhName + "</option>");
                        });
                    },
                    error: function (err) {
                        return;
                    }
                });
                $("#warehouse").select("refresh");

                //仓库 盘点单联动
                $("#warehouse").on('change', function () { $("#txtGRN").select(); })


                //货架扫描绑定事件
                $("#txtGRN").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        var grn = $.trim($("#txtGRN").val());
                        if (grn == "") {
                            return false;
                        }
                        if (grnArr.filter(function (o) { return o== grn}).length>0) {
                            confirmDialogFocus("GRN已扫描！", function () { $("#txtGRN").select(); });
                            return false;
                        }
                        checkGrn(grn);

                    }
                });
            });

            function checkGrn(grn) {
                var entity = {};
                entity.GRN = grn; //调拨单ID

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckReturnGRN", JSON.stringify(entity));
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message, function () { $("#txtGRN").select(); });
                    return false;
                }
                grnArr.push(grn);
                scanArr.push(JSON.parse(ajax.value).data[0]);
                loadScanInfo();
                $("#txtGRN").val("").select();

            }
            function loadScanInfo() {
                var html = "";
                for (var i = 0; i < scanArr.length; i++) {
                    var entity = scanArr[i];

                    html += "<tr><td>" + entity.GRN + "</td><td>" + entity.ItemCode + "</td><td>" + entity.Qty + "</td><td style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"delGrnRec('" + entity.GRN + "')\">删除</td></tr>";
                }

                $("#scanIfo").html(html);
                 
            }

            function delGrnRec(grn) {
                $.each(scanArr, function (i, o) {
                    if (o.GRN == grn) {
                        scanArr.splice(i, 1);
                        grnArr.splice(grnArr.indexOf(grn), grnArr.indexOf(grn) + 1);
                        return false;
                    }
                });
                loadScanInfo();
            }

            function returnMaterial() {

                var warehouseId = $("#warehouse option:selected").val();

                if (warehouseId == "") {
                    confirmDialogFocus("请选择仓库！", function () { $("#warehouse").focus(); });
                }

                if (!confirm("确认扫描已完成并退料？")) {
                    return false;
                }

                var entity = {};
                entity.WarehouseId = warehouseId;
                entity.GRNStr = grnArr.join(",");
                entity.UserName = userName;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspReturnMaterialFast", JSON.stringify(entity));
                    if (ajax.error != null) {
                        confirmDialogFocus(ajax.error.Message, function () { $("#txtGRN").focus(); });
                        return false;
                    }
                    scanArr = [];
                    grnArr = [];
                    confirmDialogFocus("退料成功！", function () {
                        $("#scanIfo").html("");
                        $("#txtGRN").select();
                    });
                    
            }
            


        </script>

    </form>
</body>
</html>
