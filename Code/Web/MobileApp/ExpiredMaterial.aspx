<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExpiredMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.ExpiredMaterial" %>

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
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">超期物料</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content">
                <div class="skt_IMt">
                    <table width="100%" class="EditeContentTable">
                        <tr>
                            <td>物料编码<em>*</em>
                            </td>
                            <td>
                                <input type="text" value="" id="txtItemCode" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="skt_msg" style="text-align: center"></div>
                <div>
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
                                <th>超期天数
                                </th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
                <div class="skt_IMt">
                   <table width="100%" class="EditeContentTable">
                        <tr>
                            <td style="width:25.5%">下架物料GRN
                            </td>
                            <td>
                                <input type="text" id="txtGRN" value="" style="width: 8rem;" />
                            </td>
                        </tr>
                   </table>    
               </div>
            </div>
            
            <div data-role="footer" data-position="fixed"  data-theme="a">
                
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li>
                            <input type="button" value="完成" onclick="Finish()" class="skt_btmic" />
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <sdpscript>
        <script type="text/javascript">
            $(function () {
                $(".ui-table-columntoggle-btn").hide();
                $(".skt_btmic").siblings().css("padding", "5px");
                $("#txtGRN").keydown(function () {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        var grn = $("#txtGRN").val();
                        var code = null;
                        var tr = null;
                        $("#datatab tbody tr[name='data']").each(function () {
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
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.AgeOfStorageScanGRN(grn, code);
                        if (ajax.error != null) {
                            setMsg(ajax.error.Message, "red");
                            return;
                        }
                        setMsg(grn + "已下架", "red");
                        tr.remove();
                    }
                }).focus();

                $("#txtItemCode").keydown(function () {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        setMsg("正在查询", "red");
                        var code = $("#txtItemCode").val();
                        if (!code) {
                            $("#txtItemCode").focus().select();
                            setMsg("请输入物料编码", "red");
                            return;
                        }
                        var array = [];
                        $("#datatab tbody tr[name='data']").each(function () {
                            array.push($(this).children()[2].innerText);
                        });
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.QueryExpiredMaterial(code, array);
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
                            str += "<tr name='data'><td>" + ajax.value[i].SerialNumber + "</td><td>" + ajax.value[i].ItemCode + "</td><td>" + ajax.value[i].cBarCode + "</td><td>" + ajax.value[i].Overdue + "</td><tr/>";
                        }
                        $("#datatab tbody tr[name='data']").remove();
                        $("#datatab tbody").append(str);
                    }
                }).focus();
            });
            function Finish() {
                setMsg("", "");
                var array = [];
                $("#datatab tbody tr[name='data']").each(function () {
                    array.push($(this).children()[2].innerText);
                });
                if (array.length == 0) {
                    return;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSWMS.QueryExpiredMaterial(null, array);
                if (ajax.error != null) {
                    setMsg(ajax.error.Message, "red");
                    return;
                }
                $("#datatab tbody tr[name='data']").remove();
                $("#txtItemCode").val("");
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