<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SWMSCheckMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.SWMSCheckMaterial" %>


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
    <title>物料盘点</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">物料盘点</label>
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
                                物料编码:</label>
                        </td>
                        <td colspan="2">
                            <input type="text" class="material"  value="" id="txtItemCode" />
                        </td>
                        <td>
                            <a data-corners="false" id="SelectData" data-role="button" data-fullscreen="true" data-theme="a">查询</a>
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
                                <th>物料编码</th>
                                <th>类别</th>
                                <th style="width: 5rem;">数量</th>
                                <th style="width: 7rem;">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                 <div style="margin-top:80px;">
                  <table style="width: 100%">
                    <tr>
                        <td>
                            <label for="orderno">
                                物料GRN:</label>
                        </td>
                        <td colspan="3">
                              <input type="text" id="txtGRN" value="" />
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label for="orderno">
                                系统数量:</label>
                        </td>
                        <td colspan="3" id="tdQty">
                             
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="orderno">
                                盘点数量:</label>
                        </td>
                        <td colspan="3">
                              <input type="text" id="txtCheckQty" value="" />
                        </td>
                    </tr>
                </table>
                 </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a data-corners="false" id="Save" data-role="button" data-fullscreen="true" data-theme="a">确定</a></li>
                    </ul>
                </div>
            </div>

        </div>
    </form>
    <script type="text/javascript" src="js/jqPaginator.js"></script>
    <script type="text/javascript" src="js/jquery.nicescroll.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.EShelf.js" type="text/javascript"></script>
    <script type="text/javascript">
        var item_id;
        var eshelf = new EShelf({
            userId: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>",
            userName: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>",
            pluginName: "<%= System.Configuration.ConfigurationManager.AppSettings["EShelfManufacturer"] %>",
            webRoot: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>",
            title: "PDA-物料盘点",
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
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.TaskColorDesc(3);
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

            $("#txtItemCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtItemCode").val()) == null || $.trim($("#txtItemCode").val()) == "") {
                        setMsg("物料编码不能为空！", "red");
                        return;
                    }
                    Query();
                }
            }).focus();
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if (item_id==null) {
                        setMsg("请先选择物料点击盘点", "red");
                        return;
                    }
                    $("#tdQty").text("");
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.CheckMaterialScanGRN(item_id, $.trim($("#txtGRN").val()));
                    if (ajax.error != null) {
                        setMsg(ajax.error.Message, "red");
                        return;
                    }
                    $("#tdQty").text(ajax.value);
                    $("#txtCheckQty").focus();
                    setMsg("", "");
                }
            });
            $("#txtCheckQty").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if (item_id == null) {
                        setMsg("请先选择物料点击盘点", "red");
                        return;
                    }
                    if ($.trim($("#txtGRN").val()) == null || $.trim($("#txtGRN").val()) == "") {
                        setMsg("物料GRN不能为空！", "red");
                        return;
                    }
                    if ($.trim($("#txtCheckQty").val()) == null || $.trim($("#txtCheckQty").val()) == "") {
                        setMsg("盘点数量不能为空！", "red");
                        return;
                    }
                    Confirm();
                }
            });
        });
        $("#SelectData").on("click", function () { Query(); });
        $("#Save").on("click", function () { Confirm(); });
        function Confirm() {
            if (item_id == null) {
                setMsg("请先选择物料点击盘点", "red");
                return;
            }
            var grn = $.trim($("#txtGRN").val());
            if (!grn) {
                setMsg("请先扫描GRN", "red");
                $("#txtGRN").focus();
                return;
            }
            var qty = $.trim($("#txtCheckQty").val());
            if (qty=="") {
                setMsg("请先输入盘点数量", "red");
                $("#txtCheckQty").focus();
                return;
            }
            if (isNaN(qty)) {
                setMsg("请输入正确的盘点数量", "red");
                $("#txtCheckQty").focus();
                $("#txtCheckQty").select();
                return;
            }
            if (parseFloat(qty)<0) {
                setMsg("盘点数量不能为负", "red");
                $("#txtCheckQty").focus();
                $("#txtCheckQty").select();
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.CheckMaterialConfirm_New(item_id, grn, parseFloat(qty));
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            //灭灯
            if (isEnaleEShelf && ajax.value) {
                setLightDownList([ajax.value]);
            }
            setMsg($("#txtGRN").val() + "盘点数量为" + $("#txtCheckQty").val(), "green");
            $("#txtGRN").val("");
            $("#txtCheckQty").val("");
            $("#tdQty").text("");
        }
        function Query() {
            if (item_id != null) {
                setMsg("请先完成上一个物料的盘点", "red");
                return;
            }
            setMsg("正在查询", "red");
            var code = $.trim($("#txtItemCode").val());
            if (!code) {
                $("#txtItemCode").focus().select();
                setMsg("请输入物料编码", "red");
                return;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.QueryCheckMaterial(code);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            if (ajax.value == null || ajax.value.length==0)
                setMsg("查询无记录", "red");
            else
                setMsg("", "");
            var str = "";
            for (var i = 0; i < ajax.value.length; i++) {
                str += "<tr style='height: 2rem;' name='data'><td>" + ajax.value[i].ItemCode + "</td><td>" + ajax.value[i].Type + "</td><td>" + ajax.value[i].BalanceQty
                    + "</td><td style='text-align:center;'><input type='button' value='盘点' onclick='check(" + ajax.value[i].ItemID + ")' class='smallbtn' />&nbsp;&nbsp;<input type='button' onclick='finish(" + ajax.value[i].ItemID + ")' value='完成' class='smallbtn' /></td><tr/>";
            }
            $("#datatab tr[name='data']").remove();
            $("#datatab").append(str);
            $("#txtGRN").focus();
        }
        function check(itemid) {
            if (item_id!=null) {
                if (item_id == itemid) {
                    setMsg("正在进行盘点请勿重复点击", "red");
                } else {
                    setMsg("请先完成上一个物料的盘点", "red");
                }
                return;
            }
            item_id = itemid;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.CheckMaterial_New(itemid, 0);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            //亮灯
            if (isEnaleEShelf) {
                if (ajax.value && ajax.value.length > 0) {
                    setLightUpList(null, ajax.value);
                }
            }
            setMsg("货位灯已亮请扫描GRN", "red");
            $("#txtGRN").focus();
        }
        function finish(itemid) {
            if (item_id == null) {
                setMsg("请先选择物料点击盘点", "red");
                return;
            }
            if (item_id != itemid) {
                setMsg("请先完成上一个物料的盘点", "red");
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.CheckMaterial(itemid,1);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            //灭灯
            if (isEnaleEShelf) {
                if (ajax.value && ajax.value.length > 0) {
                    setLightDownList(ajax.value);
                }
            }
            item_id = null;
            $("#txtGRN").val("");
            $("#txtCheckQty").val("");
            $("#tdQty").text("");
            setMsg("物料盘点已完成", "red");
        }
        //控制Msg的显示
        function setMsg(s, r) {
            $("#msg").html(s);
            $("#msg").css("color", r);
        }

        //批量设置硬件亮灯
        function setLightUpList(listBlinkBarcode, listNoBlinkBarcode) {
            var cells = [];
            if (listBlinkBarcode) {
                $.each(listBlinkBarcode, function (i, o) {
                    cells.push({
                        cellId: o,
                        ledColor: colorCode,
                        isBlink: true,
                    });
                });
            }
            if (listNoBlinkBarcode) {
                $.each(listNoBlinkBarcode, function (i, o) {
                    cells.push({
                        cellId: o,
                        ledColor: colorCode,
                        isBlink: false,
                    });
                });
            }
            if (cells.length == 0) {
                return true;
            }
            var result = eshelf.LightUpCellLedList(cells);
            if (!result.success) {
                //setMsg(result.error, "red");
                return false;
            }
            return true;
        }

        //批量设置硬件灭灯
        function setLightDownList(listBarcode) {
            var cells = [];
            if (listBarcode) {
                $.each(listBarcode, function (i, o) {
                    cells.push({
                        cellId: o,
                        ledColor: 0,
                        isBlink: false,
                    });
                });
            }
            if (cells.length == 0) {
                return true;
            }
            var result = eshelf.LightUpCellLedList(cells);
            if (!result.success) {
                //setMsg(result.error, "red");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>

