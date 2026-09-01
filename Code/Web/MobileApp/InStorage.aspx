<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InStorage.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.InStorage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>上架入库</title>
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

        img {
            -webkit-filter: grayscale(100%);
            -moz-filter: grayscale(100%);
            -ms-filter: grayscale(100%);
            -o-filter: grayscale(100%);
            filter: grayscale(100%);
            filter: gray;
        }    .ui-title {
            line-height: 30px;
            
        }
    </style>
</head>
<body>
<form id="form1" runat="server" onsubmit="return false;">
    <sdpui>
        <div data-role="page" id="pageone">
            <div data-role="header" data-position="fixed" >
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">上架入库</label>
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
                            <label>层码或货位</label>
                        </td>
                        <td>
                            <input type="text" value="" id="txtReuestOrder" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>物料GRN<em>*</em></label>
                        </td>
                        <td><input type="text" id="txtGRN" /></td>
                    </tr>
                </table>
                <div id="skt_msg" style="text-align: center"></div>
                <div>
                    <table data-role="table" id="datatab" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>检验单
                                </th>
                                <th>物料编码
                                </th>
                                <th>合格数量
                                </th>
                                <th>入库数量
                                </th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed"  data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" value="保存" onclick="Save()" class="skt_btmic" />
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <sdpscript>
        <script type="text/javascript">
        var cbarcode = "";
        $(function () {
            $(".ui-table-columntoggle-btn").hide();
            $(".skt_btmic").siblings().css("padding", "5px");
            $("#txtReuestOrder").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($("#txtReuestOrder").val() == "") {
                        setMsg("请扫描货架层码或者货位编码", "red");
                        return;
                    }
                    setMsg("", "");
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.InStorageScanCposcode($("#txtReuestOrder").val());
                    if (ajax.error != null) {
                        $("#txtReuestOrder").val("");
                        setMsg(ajax.error.Message, "red");
                        return;
                    }
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                }
            }).focus();
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($("#txtGRN").val() == "") {
                        setMsg("请扫描物料GRN", "red");
                        return;
                    }
                    setMsg("", "");
                    if ($("#txtReuestOrder").val() == "") {
                        $("#txtReuestOrder").focus();
                        $("#txtGRN").val("");
                        setMsg("请扫描货架层码或者货位编码", "red");
                        return;
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.InStorageScanGRN($("#txtReuestOrder").val(), $("#txtGRN").val(), cbarcode);
                    if (ajax.error != null) {
                        setMsg(ajax.error.Message, "red");
                        return;
                    }
                    cbarcode = ajax.value.cbarcode;
                    var exists = false;
                    $("#datatab tbody tr[name='data']").each(function () {
                        if (!exists) {
                            var tds = $(this).children();
                            if (tds[0].innerText == ajax.value.order && tds[1].innerText == ajax.value.itemcode) {
                                tds[2].innerText = ajax.value.qualifiedqty;
                                tds[3].innerText = ajax.value.storageqty;
                                exists = true;
                            }
                        }
                    });
                    if (!exists)
                        $("#datatab tbody").append("<tr name='data'><td>" + ajax.value.order + "</td><td>" + ajax.value.itemcode + "</td><td>" + ajax.value.qualifiedqty + "</td><td>" + ajax.value.storageqty + "</td></tr>");

                    setMsg("操作成功", "red");
                    $("#txtGRN").val("");
                }
            });
        });
        function Save() {
            var array = [];
            $("#datatab tbody tr[name='data']").each(function () {
                var tds = $(this).children();
                if (parseFloat(tds[3].innerText) >= parseFloat(tds[2].innerText)) {
                    array.push(tds[0].innerText);
                }
            });
            setMsg("", "");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.SaveInStorage($("#txtReuestOrder").val(), cbarcode, array);
            if (ajax.error != null) {
                setMsg(ajax.error.Message, "red");
                return;
            }
            $("#datatab tbody tr[name='data']").remove();
            $("#txtReuestOrder").val("");
            $("#txtGRN").val("");
        }
        //控制Msg的显示
        function setMsg(s, r) {
            $("#skt_msg").html(s);
            $("#skt_msg").css("color", r);
        }
    </script>
        </sdpscript>
    </sdpui>
</form>
</body>
</html>