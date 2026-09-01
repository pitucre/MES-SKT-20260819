<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="MaterialCombine.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MaterialCombine" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js?v=2" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <title>物料合并</title>
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
    <form id="form1" runat="server" onsubmit="return false;">
        <div data-role="page" id="pageone">
            <div data-role="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">物料合并</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <table width="100%">
                    <tr>
                        <td>
                            <label>主合并GRN</label></td>
                        <td>
                            <input androidScan="true" id="txtGRN" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>数量</label>
                        </td>
                        <td><span id="Qty"></span></td>
                    </tr>
                    <tr>
                        <td>
                            <label>待合并GRN</label></td>
                        <td>
                            <input id="txtWaitGRN" androidScan="true"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>是否打印条码</label></td>
                        <td>
                            <input id="PrintOld" type="checkbox" value="PrintOld" /></td>
                    </tr>
                    <tr>
                        <td>
                            <label>打印机</label>
                        </td>
                        <td colspan="3">
                            <select id="selPrintersList">
                            </select>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center"></div>
                <span id="showWaitGRN" style="color: green"></span>
                <div data-role="content" style="overflow: scroll;">
                    <table data-role="table" id="infotab" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>待合并GRN
                                </th>
                                <th>数量
                                </th>
                                <th>产品编码
                                </th>
                                <th>操作</th>
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
                            <input type="button" id="Savebtn" data-theme="a" value="物料合并" /></li>
                    </ul>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            var MaxGRN = "";//主合并GRN
            var waitGRN = "";

            var labelDocumentId = -1    //Label文档Id
            var tempatePath = "";       //Lab模板文件路径
            var labelItemId = -1;       //物料ID
            var labelJsonData = "";    //标签Lab方式的 数据Json格式字符串
            var orderNo = "";

            //定义参数：
            var enterGrn = "";
          
            //获取打印机名称
            $(document).ready(function () {
                bindPrinters('selPrintersList', function () {
                    if ($("#selPrintersList").val()) {
                        $("#selPrintersList-button span").text($("#selPrintersList").find("option:selected").text());
                    }
                });
            });

            $(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                $("#txtWaitGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") });
                //扫描GRN
                $("#txtGRN").on('keydown', function () {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        MaxGRN = $.trim($("#txtGRN").val());
                        checkMaterialSN(MaxGRN);
                        return false;
                    }
                });
              
                //扫描待合并物料GRN
                $("#txtWaitGRN").on('keydown', function () {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        waitGRN = $.trim($("#txtWaitGRN").val());
                        comBineMaterial(waitGRN);
                        return false;
                    }
                });

               
                $("#Savebtn").on("click", function () {
                    SaveCombine();
                });
            });


            //检查主GRN
            function checkMaterialSN(checkGRN) {
                if (checkGRN == "") {
                    $("#msg").html("主合并GRN不能为空!");
                    $("#msg").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                //校验物料
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckMaterialCombine(checkGRN);
                if (ajax.error != null) {
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }


                $("#msg").html("");
                var list = ajax.value;

                if (list.length == 0)
                {
                    $("#msg").html("当前的物料【" + checkGRN + "】查询关联的单据信息为空不能进行合并校验，请检查!");
                    $("#msg").css("color", "red");
                    return false;
                }
                if (!orderNo) {
                    orderNo = list[0].POorder;
                }
                else if (orderNo != list[0].POorder) {
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    $("#msg").html("当前的物料【" + checkGRN + "】采购单【" + list[0].POorder + "】与已扫描的物料采购单【" + orderNo + "】不一致!");
                    $("#msg").css("color", "red");
                    return false;
                }

                //显示当前主合并GRN的可用数量
                $("#Qty").html(list[0].BalanceQty);
                $("#txtWaitGRN").val("").focus();
            }


            //合并物料
            var materialSN = ""; //已扫描GRN集合
            function comBineMaterial(waitGRN) {
              
                if (materialSN.indexOf(waitGRN) >= 0) {
                    $("#msg").html("该条码已经扫描!");
                    $("#msg").css("color", "red");
                    $("#txtWaitGRN").val("").focus();
                    return false;
                }
                //执行检验逻辑
                var entity = {};
                entity.MaterialGRN = MaxGRN;
                entity.WaitGRN = waitGRN;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspCheckCombineGRN", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#txtWaitGRN").val("").focus();
                    $("#txtWaitGRN").select();
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                $("#msg").html("");
                /**显示待合并GRN**/
                materialSN += waitGRN + ','
                $("#txtWaitGRN").val("").focus();
                $("#msg").html("");
                //显示待GRN信息：
                var list = $.parseJSON(ajax.value).data;
                GetSubGrn(waitGRN, list);
            }
            //显示待合并GRN信息
            function GetSubGrn(txtGRN, list) {
                
                var tqty = 0;
                var tbl = "";
                for (var i = 0; i < list.length; i++) {
                    tbl += "<tr >"
                    tbl += "<td>" + list[i].SerialNumber + "</td>";
                    tbl += "<td>" + parseFloat(list[i].BalanceQty) + "</td>";
                    tbl += "<td>" + list[i].ItemCode + "</td>";
                   
                    tbl += "<td><img  src='../Content/images/delete.gif' onclick=deleteGRN('" + list[i].SerialNumber + "',this)  /></td>";
                    tbl += "</tr>";
                }
                tbl += "</table>";
                $("#infotab tbody").append(tbl);
                var tabCount = $("#infotab tr").length - 1;
                $("#showWaitGRN").html("当前待合并GRN为:" + tabCount + "个");
                $("#infotab").table("refresh");
            }

            //删除GRN信息：
            function deleteGRN(GRN, obj) {
                $(obj).parent().parent().remove();//移除该行数据：
                materialSN = materialSN.replace(GRN, "");
                var tabCount = $("#infotab tr").length - 1;
                $("#showWaitGRN").html("当前待合并GRN为:" + tabCount + "个");
                $("#txtWaitGRN").val("").focus();
            }
            //物料合并
            function SaveCombine() {
                if (MaxGRN == "") {
                    $("#msg").html("主合并GRN不能为空!");
                    $("#msg").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
              
                if (materialSN == "") {
                    $("#msg").html("待合并GRN列表不能为空");
                    $("#msg").css("color", "red");
                    return false;
                }

                var entity = {};
                entity.GRN = MaxGRN;
                entity.waitCombineSN = materialSN;
                entity.userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspSaveCombineMaterial", JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    $("#msg").html(MaxGRN + "合并成功!");
                    $("#msg").css("color", "green");
                    if ($("#PrintOld").prop('checked')) {
                        if (!$("#selPrintersList").val()) {
                            setMsg("请选择打印机", "red");
                            return false;
                        }


                        //选择打的话，执行打印：
                        var list = $.parseJSON(ajax.value).data;
                        labelItemId = list[0].PartId;
                        var IsSupper = list[0].isSuplySerialNumber;
                        //如果工单号不为空则调用批次产品条码
                        if (list[0].SupplierOrderNumber != "" ) {
                            labelType = -36
                        }
                        else if (IsSupper) {
                            labelType = -24; //调用供应商模板
                        }
                        else {
                            labelType = -3;
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, 2);
                        if (ajax.error == null) {
                            var entity = ajax.value;
                            labelDocumentId = entity.LabelDocumentId; //Label文档Id
                            tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                        }
                        else {
                            $("#msg").html(ajax.error.Message).css("color", "red");
                            return false;
                        }
                        sendPrintContent(JSON.stringify(GRNlabel(labelDocumentId, MaxGRN, labelItemId)), $("#selPrintersList").val(), 1, labelDocumentId);
                    }
                    //清空数据：
                    MaxGRN = "";
                    waitGRN = "";
                    materialSN = "";
                    $("#Qty").html("");
                    $("#txtGRN").val("").focus();
                    $("#txtWaitGRN").val("");
                    $("#showWaitGRN").html("");
                    $("#infotab tbody").html("");
                }
            }

            function GRNlabel(labelDocumentId, grn, labelItemId) {
                var printdata = [];
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, grn, -1, -1, -1, labelItemId, -1);
                if (ajaxLabContent.error == null) {
                    try {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent:  [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }
                    } catch (e) {
                        printdata = [];
                        $("#msg").html(e).css("color", "red");
                    }
                }
                else {
                    $("#msg").html(ajaxLabContent.error.Message).css("color", "red");
                }
                return printdata;
            }
        </script>
    </form>
</body>
</html>
