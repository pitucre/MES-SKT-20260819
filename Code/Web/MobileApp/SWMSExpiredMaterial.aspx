<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SWMSExpiredMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.SWMSExpiredMaterial" %>

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
    <title>超期物料</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">超期物料</label>
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
                             <input class="orderno" data-corners="false" type="text" data-mini="true"
                                value="" id="txtItemCode" />
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
                                <th>GRN
                                </th>
                                <th>物料编码
                                </th>
                                <th>货位
                                </th>
                                <th style="width:6rem;">超期天数
                                </th>
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
                                下架物料GRN:</label>
                        </td>
                        <td colspan="3">
                              <input type="text" id="txtGRN" value=""/>
                        </td>
                    </tr>
                </table>
                 </div>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a data-corners="false" id="Save" data-role="button" data-fullscreen="true" data-theme="a">完成</a></li>
                    </ul>
                </div>
            </div>

        </div>
    </form>
    <script type="text/javascript" src="js/jqPaginator.js"></script>
    <script type="text/javascript" src="js/jquery.nicescroll.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.EShelf.js" type="text/javascript"></script>
    <script type="text/javascript">
        var eshelf = new EShelf({
            userId: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>",
            userName: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>",
            pluginName: "<%= System.Configuration.ConfigurationManager.AppSettings["EShelfManufacturer"] %>",
            webRoot: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>",
            title: "PDA-超期物料",
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
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.TaskColorDesc(2);
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
                    var grn = $.trim($("#txtGRN").val());
                    var code = null;
                    var tr = null;
                    $("#datatab tr[name='data']").each(function () {
                        if (tr == null && $(this).children()[0].innerText == grn) {
                            code = $(this).children()[2].innerText;
                            tr = $(this);
                        }
                    });
                    $("#txtGRN").val("");
                    if (code == null) {
                        setMsg(grn + "不在列表", "red");
                        return;
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.AgeOfStorageScanGRN_New(grn, code);
                    if (ajax.error != null) {
                        setMsg(ajax.error.Message, "red");
                        return;
                    }
                    //灭灯
                    if (isEnaleEShelf && code) {
                        setLightDownList([code]);
                    }
                    setMsg(grn + "已下架", "red");
                    tr.remove();
                }
            });
        });
        $("#SelectData").on("click", function () { Query(); });
        $("#Save").on("click", function () { Finish(); });
        function Finish() {
            setMsg("", "");
            var array = [];
            $("#datatab tr[name='data']").each(function () {
                array.push($(this).children()[2].innerText);
            });
            if (array.length == 0) {
                setMsg("物料列表不能为空！", "red");
                return;
            }
            //灭灯
            if (isEnaleEShelf) {
                if (array && array.length > 0) {
                    setLightDownList(array);
                }
            }
            $("#datatab tr[name='data']").remove();
            $("#txtItemCode").val("");
            setMsg("操作成功！", "green");
        }
        function Query() {
            setMsg("正在查询", "red");
            var code = $.trim($("#txtItemCode").val());
            if (!code) {
                $("#txtItemCode").focus().select();
                setMsg("请输入物料编码", "red");
                return;
            }
            var array = [];
            $("#datatab tr[name='data']").each(function () {
                array.push($(this).children()[2].innerText);
            });
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.QueryExpiredMaterial_New(code, array);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            if (isEnaleEShelf) {
                //灭灯
                if (array && array.length > 0) {
                    setLightDownList(array);
                }
                //亮灯
                if (ajax.value && ajax.value.length > 0) {
                    var listNoBlinkBarcode = [];
                    $.each(ajax.value, function (i, o) {
                        listNoBlinkBarcode.push(o.cBarCode);
                    });
                    setLightUpList(null, listNoBlinkBarcode);
                }
            }
            if (ajax.value == null || ajax.value.length == 0)
                setMsg("查询无记录", "red");
            else
                setMsg("", "");
            var str = "";
            for (var i = 0; i < ajax.value.length; i++) {
                str += "<tr name='data'><td>" + ajax.value[i].SerialNumber + "</td><td>" + ajax.value[i].ItemCode + "</td><td>" + ajax.value[i].cBarCode + "</td><td>" + ajax.value[i].Overdue + "</td><tr/>";
            }
            $("#datatab tr[name='data']").remove();
            $("#datatab").append(str);
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
