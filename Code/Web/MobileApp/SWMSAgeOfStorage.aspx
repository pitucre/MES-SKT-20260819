<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SWMSAgeOfStorage.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.SWMSAgeOfStorage" %>

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
    <title>物料库龄</title>
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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">物料库龄</label>
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
                        <td colspan="3">
                             <input class="orderno" data-corners="false" type="text" data-mini="true"
                                value="" id="txtItemCode" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="orderno">
                                超过库龄(天):</label>
                        </td>
                        <td colspan="2">
                            <input type="text" class="material" id="txtDays" style="width: 4rem; display: inline-block;" />
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
                                <th style="width:6rem;">库龄时长
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
        var cbarcode = "";
        var eshelf = new EShelf({
            userId: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>",
            userName: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>",
            pluginName: "<%= System.Configuration.ConfigurationManager.AppSettings["EShelfManufacturer"] %>",
            webRoot: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>",
            title: "PDA-物料库龄",
        });
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
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.TaskColorDesc(1);
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
            $("#txtGRN").focus();
            $("#txtItemCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var itemCode = $.trim($("#txtItemCode").val());
                    if (itemCode == null || itemCode == "") {
                        setMsg("物料编码不能为空！", "red");
                        return;
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetItemInfo(itemCode);
                    if (ajax.error != null) {
                        confirmDialog(ajax.error.Message);
                        return;
                    }
                    if (ajax.value == null)
                    {
                        setMsg("[" + itemCode + "]物料编码不存在！", "red");
                        $("#txtItemCode").val(""), focus();
                        return;
                    }
                    $("#txtDays").focus();
                }
            }).focus();

            $("#txtDays").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtItemCode").val()) == null || $.trim($("#txtItemCode").val()) == "") {
                        setMsg("物料编码不能为空！", "red");
                        return;
                    }
                    if ($.trim($("#txtDays").val()) == null || $.trim($("#txtDays").val()) == "") {
                        setMsg("超过库龄(天)不能为空！", "red");
                        return;
                    }
                    Query();
                }
            });


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
                    if (code==null) {
                        setMsg(grn + "不在列表", "red");
                        return;
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.AgeOfStorageScanGRN_New(grn, code);
                    if (ajax.error != null) {
                        setMsg(ajax.error.Message, "red");
                        return;
                    }
                    //灭灯
                    if (isEnaleEShelf) {
                        setLightDownList([code]);
                    }
                    setMsg(grn+"已下架", "red");
                    tr.remove();
                    //如果全部下架清空物料信息
                    if ($("#datatab tr[name='data']").length == 0) {
                        $("#txtDays").val("");
                        $("#txtItemCode").val("").focus();
                    }

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
            if (array.length == 0)
            {
                setMsg("物料Grn列表不能为空！", "red");
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
            $("#txtDays").val("");
            
            $(".ui-footer").show();
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
            var day = $.trim($("#txtDays").val());
            if (!day) {
                $("#txtDays").focus().select();
                setMsg("请输入天数", "red");
                return;
            }
            if (!/^\d+$/.test(day)) {
                $("#txtDays").focus().select();
                setMsg("请输入正确的天数", "red");
                return;
            }
            if (parseInt(day) <= 0) {
                $("#txtDays").focus().select();
                setMsg("天数应大于0", "red");
                return;
            }
            var array = [];
            $("#datatab tr[name='data']").each(function () {
                array.push($(this).children()[2].innerText);
            });
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.QueryAgeOfStorage_New(code, parseInt(day), array);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            if (ajax.value == null || ajax.value.length == 0)
                setMsg("查询无记录", "red");
            else
                setMsg("", "");
            var str = "";
            for (var i = 0; i < ajax.value.length; i++) {
                str += "<tr name='data'><td>" + ajax.value[i].SerialNumber + "</td><td>" + ajax.value[i].ItemCode + "</td><td>" + ajax.value[i].cbarcode + "</td><td>" + ajax.value[i].StorageDays + "</td><tr/>";
            }
            $("#datatab tr[name='data']").remove();
            $("#datatab").append(str);
            
            if (isEnaleEShelf) {
                //灭灯
                if (array && array.length > 0) {
                    setLightDownList(array);
                }
                //亮灯
                if (ajax.value && ajax.value.length > 0) {
                    var listNoBlinkBarcode = [];
                    $.each(ajax.value, function (i, o) {
                        listNoBlinkBarcode.push(o.cbarcode);
                    });
                    setLightUpList(null, listNoBlinkBarcode);
                }
            }
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
