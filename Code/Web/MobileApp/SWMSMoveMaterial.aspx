<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SWMSMoveMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.SWMSMoveMaterial" %>


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
    <title>物料移库</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">物料移库</label>
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
                                层码或货位:</label>
                        </td>
                        <td colspan="2">
                             <input class="orderno" data-corners="false" type="text" data-mini="true"  value="" id="txtReuestOrder" />
                        </td>
                        <td>
                            <a data-corners="false" id="skt_btR" data-role="button" data-fullscreen="true" data-theme="a">...</a>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="orderno">
                                物料GRN:</label>
                        </td>
                        <td colspan="2">
                            <input type="text" class="material" id="txtGRN"  />
                        </td>
                        <td>
                            <a data-corners="false" id="skt_btGRN" data-role="button" data-fullscreen="true" data-theme="a">...</a>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="width: 100%; text-align: center;font-size:15px;font-weight:bold;">
                </div>
                
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a data-corners="false" id="Save" data-role="button" data-fullscreen="true" data-theme="a">保存</a></li>
                    </ul>
                </div>
            </div>

        </div>
    </form>
    <script type="text/javascript" src="js/jqPaginator.js"></script>
    <script type="text/javascript" src="js/jquery.nicescroll.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.EShelf.js" type="text/javascript"></script>
    <script type="text/javascript">
        var cbarcode = "";
        var eshelf = new EShelf({
            userId: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>",
            userName: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>",
            pluginName: "<%= System.Configuration.ConfigurationManager.AppSettings["EShelfManufacturer"] %>",
            webRoot: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>",
            title: "PDA-物料移库",
        });
        var curCellId = "";             //当前亮灯的货位
        var isEnaleEShelf = "<%= System.Configuration.ConfigurationManager.AppSettings["EnaleEShelf"] %>" == "1";      //是否启用电子货架
        var isEnableLightUp = true;     //电子货架对接:是否启用硬件亮灯对接
        var colorCode = 2;              //入库上架的默认颜色：绿色
        $(function () {
            //是否启用
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfigByConfigType("26");
            if (ajax.error != null) {
                confirmDialog(ajax.error.Message);
                return;
            }
            else {
                var entity = ajax.value;
                if (entity && entity.ConfigResult == "1") {
                    isEnableLightUp = false;
                }
            }
            //获取亮灯颜色
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.TaskColorDesc(5);
            if (ajax.error != null) {
                confirmDialog(ajax.error.Message);
                return;
            }
            else {
                if (ajax.value) {
                    colorCode = eshelf.ConvertToColorCode(ajax.value);
                }
            }
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#txtReuestOrder").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#skt_btR").trigger("click");
                }
            }).focus();
            $("#skt_btR").click(function () {
                if ($.trim($("#txtReuestOrder").val()) == "") {
                    setMsg("请扫描货架层码或者货位编码", "red");
                    return;
                }
                setMsg("", "");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.InStorageScanCposcode($.trim($("#txtReuestOrder").val()));
                if (ajax.error != null) {
                    $("#txtReuestOrder").val("");
                    setMsg(ajax.error.Message, "red");
                    return;
                }
                $("#txtGRN").focus();
                $("#txtGRN").select();
                setMsg("层码或货位扫描成功！", "green");
            });
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#skt_btGRN").trigger("click");
                }
            });
            $("#skt_btGRN").click(function () {
                if ($.trim($("#txtGRN").val()) == "") {
                    setMsg("请扫描物料GRN", "red");
                    return;
                }
                setMsg("", "");
                if ($.trim($("#txtReuestOrder").val()) == "") {
                    $("#txtReuestOrder").focus();
                    $("#txtGRN").val("");
                    setMsg("请扫描货架层码或者货位编码", "red");
                    return;
                }
                //01.备料的库位灯灭灯
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.GetCbarcode($.trim($("#txtGRN").val()));
                if (ajax.error != null) {
                    setMsg(ajax.error.Message, "red");
                    return;
                }
                if (ajax.value) {
                    setLinghtDown(ajax.value);
                }
                //02.物料GRN移库
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.MoveMaterialScanGRN_New($.trim($("#txtReuestOrder").val()), $.trim($("#txtGRN").val()), cbarcode);
                if (ajax.error != null) {
                    setMsg(ajax.error.Message, "red");
                    return;
                }
                //灭灯
                if (cbarcode) {
                    setLinghtDown(cbarcode);
                }
                //备料移库亮灯
                if (ajax.value[0] == 0) {
                    setLightUp(ajax.value[1]);
                }
                setMsg($.trim($("#txtGRN").val()) + "移库成功", "green");
                $("#txtGRN").val("");
                cbarcode = ajax.value[1];
            });
        });
        $("#Save").on("click", function () { Save(); });
        function Save() {
            setMsg("", "");
            if ($.trim($("#txtReuestOrder").val()) == "") {
                $("#txtReuestOrder").focus();
                $("#txtGRN").val("");
                setMsg("请扫描货架层码或者货位编码", "red");
                return;
            }
            //灭灯
            setLinghtDown(cbarcode);
            cbarcode = "";
            $("#txtReuestOrder").val("");
            $("#txtGRN").val("");
            setMsg("保存成功！", "green");
        }
        //控制Msg的显示
        function setMsg(s, r) {
            $("#msg").html(s);
            $("#msg").css("color", r);
        }

        //设置硬件亮灯
        function setLightUp(barcode) {
            //是否启用电子货架
            if (!isEnaleEShelf) return true;
            //没有可用库位
            if (!barcode) {
                return true;
            }
            //货位亮灯
            var result = eshelf.LightUpCellLed(barcode, colorCode, false);
            if (!result.success) {
                //setMsg(result.error, "red");
                return false;
            }
            return true;
        }
        //设置硬件灭灯
        function setLinghtDown(barcode) {
            //是否启用电子货架
            if (!isEnaleEShelf) return true;
            //没有可用库位
            if (!barcode) {
                return true;
            }
            var result = eshelf.LightUpCellLed(barcode, 0, false);
            if (!result.success) {
                //setMsg(result.error, "red");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>

