<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProdDetailInfo.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.ProdDetailInfo" %>

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
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>生产查询</title>
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
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <img src="images/icon/steelnetsearch_white.png" />
                    </div>
                    <div>
                        生产查询
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" id="content1">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label>
                                序号</label>
                        </td>
                        <td>
                            <input id="txtSN" />
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <div style="position: absolute; height: 2px; background-color: Black; width: 100%;">
                </div>
                <div>
                    <div style="margin: 10px 5px;">
                        <b>信息</b>
                    </div>
                    <table data-role="table" id="infotb" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th width="25%">名称
                                </th>
                                <th>描述
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            $(function () {
                $("#txtSN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
            });

            $("#txtSN").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var sn = $.trim($("#txtSN").val());
                    if (sn == "") {
                        confirmDialogFocus("SN不能为空");
                        return false;
                    }
                    $("#infotb tbody").html("");
                    //获取数据
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetProdDetailInfo(sn);
                    if (ajax.error != null) {
                        confirmDialogFocus(ajax.error.Message);
                        return false;
                    } else {
                        var list = ajax.value.Rows;
                        var htmlCode = "";
                        var val = "";
                        for (var i = 0; i < list.length; i++) {
                            val = list[i].ColumnValue == null ? "" : list[i].ColumnValue;
                            htmlCode += "<tr><td>" + list[i].ColumnName + "</td><td>" + val + "</td></tr>";
                        }
                        $("#infotb tbody").html(htmlCode);
                        $("#infotb").table("refresh");
                    }
                    $("#txtSN").val("").focus();
                }
            });
        </script>
    </form>
</body>
</html>