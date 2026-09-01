<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reinspection.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.Reinspection" %>

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
    <title>过期物料送检</title>
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
    <form id="form1" runat="server">
        <div data-role="page" class="receivepage" id="receivepage">
            <div data-role="header" data-position="fixed" style="position: fixed">
                <h5 style="padding: 4px; margin: 0px;">
             <%--       <div>
                        <img src="images/icon/fdbind_white.png" />
                    </div>
                    <div>
                        重检单送检
                    </div>--%>
                    
                     <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">过期物料送检</label>
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
                                重检单</label>
                        </td>
                        <td>
                            <input id="txtListNo" />
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-position-to="window" data-mini="true" data-role="button">选择单据</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                GRN</label>
                        </td>
                        <td colspan="2">
                            <input id="txtGRN" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                扫描数量</label>
                        </td>
                        <td>
                            <span id="qty">0</span>/<span id="count">0</span>
                        </td>
                    </tr>
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <div style="margin-top: 5px">
                    <strong>GRN信息</strong>
                    <table data-role="table" id="materialtb" data-mode="columntoggle" class="ui-responsive table-stroke"
                        style="width: 100%">
                        <thead>
                            <tr>
                                <th>GRN
                                </th>
                                <th>物料编码
                                </th>
                                <th>库位编码
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-role="footer" data-position="fixed" style="position: fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="Save" id="Save" data-role="button" data-fullscreen="true"
                            data-theme="a">确认送检</a></li>
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">
                <a href="#" id="btnFilter" data-rel="popup" data-position-to="window" data-mini="true"
                    data-role="button">筛选单据</a>
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入。。。 "
                        data-theme="c" class="listview">
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var materialId = ""; //物料id集合
            var stationId;
            var GrnList = [];
            $(document).ready(function () {
                $(".ui-body-c").css("background", "#fff");
                $("body>[data-role='listview']").listview();
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $("#txtListNo").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                $("#txtGRN").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC") }).focus();
                //保存
                $("#Save").on("click", function () {
                    var a = parseInt($("#qty").html());
                    var b = parseInt($("#count").html());
                    if (a != b || GrnList.length != b) {
                        $("#msg").html("请先完成扫描,剩余数量[" + (b - a) + "]个").css("color", "red");
                        $("#txtGRN").select().focus();
                        return false;
                    }
                    var data = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.ReinspectionSj($("#txtListNo").val(), userName);
                    if (data.error != null) {
                        $("#msg").html(data.error.Message).css("color", "red");
                        return false;
                    }
                    $("#msg").html("送检成功");
                    window.location.reload();
                });
                //重检单
                $("#txtListNo").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        tabShow($("#txtListNo").val());
                    }
                });
                //扫描sn
                $("#txtGRN").on("keydown", function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        //通过GSN条码带出对应整个单据的数据
                        var data = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.GetReinspectionListByGSNPDA($("#txtGRN").val());
                        if (data.error != null) {
                            $("#msg").html(data.error.Message).css("color", "red");
                            return false;
                        }
                        $("#materialtb tbody").html("");

                        if (data.value.length == 0) {
                            $("#msg").html("未找到对应的单据！").css("color", "red");
                            $("#txtListNo").val("");
                            $("#txtGRN").select().focus();
                            return false;
                        }

                        var data = data.value;
                        var h = "";
                        $("#count").html(data.length);
                        for (var i = 0; i < data.length; i++) {
                            h += "<tr><td>" + data[i].SerialNumber + "</td>";
                            h += "<td>" + data[i].ItemCode + "</td>";
                            h += "<td>" + data[i].CBarCode + "</td>";
                            h += "</tr>";
                        }
                        $("#materialtb tbody").append(h);
                        $("#materialtb").table("refresh");
                        //获取单据
                        $("#txtListNo").val(data[0].ReinspectionNo)

                        $("#msg").html("");
                        var Grn = $("#txtGRN").val();
                        var mark = true;
                        for (var i = 0; i < $("#materialtb tbody tr").length; i++) {
                            var td = $($("#materialtb tbody tr")[i]).find("td").html();
                            if (td == Grn) {
                                if ($.inArray(Grn, GrnList) == -1) {
                                    GrnList.push(Grn);
                                    $("#qty").html(parseInt($("#qty").html()) + 1);
                                } else {
                                    $("#msg").html("已扫描").css("color","red");
                                }
                                $($("#materialtb tbody tr")[i]).css("background-color", "#7FFF00");
                                $($("#materialtb tbody tr:last")[i]).after($($("#materialtb tbody tr")[i]));
                                $($("#materialtb tbody tr:last")[i]).fadeOut(500).fadeIn(500);
                                //$($("#materialtb tbody tr")[i]).fadeOut().fadeIn();
                                //$("#arrivaltable").append($($("#materialtb tbody tr")[i]));//置顶
                                $("#arrivaltable").table("refresh");
                                mark = false;
                                $("#txtGRN").select().focus();
                                return;//跳出
                            }
                            $("#txtGRN").select().focus();
                        }
                        if (mark) {
                            $("#msg").html("GRN错误或不在重检单中").css("color", "red");
                            $("#txtGRN").select().focus();
                            return false;
                        }
                        $("#txtGRN").select().focus();
                    }
                });

            });
            $("#btnFilter").on("click", function () {
                $("#listviews").html("");
                value = $.trim($("input[data-type='search']:eq(0)").val());
                
                var data = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.GetAllReinspection(value);
                if (data.error != null) {
                    $("#msg").html(data.error.Message).css("color", "red");
                    return false;
                }
                var ulhtml = "";
                //entity = $.parseJSON(data.value);
                for (var i = 0; i < data.value.length; i++) {
                    if (ulhtml.indexOf(data.value[i].ReinspectionNo) == -1) {
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + data.value[i].ReinspectionNo + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            });

            //根据字符串模糊查询采购单
            $("#listviews").on("filterablebeforefilter", function (e, data) {
                //var $ul = $(this)
                //$input = $(data.input)
                //value = $input.val();
                //if (value && value.length > 2) {
                //    $("#listviews").html("");
                    
                //    //$("#listviews").trigger("updatelayout");
                //}
            });
            function SetPOCode(code) {
                $("#txtListNo").val($(code).html());
                $("input[data-type='search']").val('');
                $("#listviews").html('');
                $("#fpanel").panel("close");
                tabShow($("#txtListNo").val());
            };
            function tabShow(No) {
                var data = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.GetReinspectionListByPDA(No);
                if (data.error != null) {
                    $("#msg").html(data.error.Message).css("color", "red");
                    return false;
                }
                
                $("#materialtb tbody").html("");
                //var data = JSON.parse(data.value);
                //by liwen 20200806
                var data = data.value;
                if (data.length == 0) {
                    $("#msg").html(No + "不是待送检状态!").css("color", "red");
                    return false;
                }
                var h = "";
                $("#count").html(data.length);
                for (var i = 0; i < data.length; i++) {
                    h += "<tr><td>" + data[i].SerialNumber + "</td>";
                    h += "<td>" + data[i].ItemCode + "</td>";
                    h += "<td>" + data[i].CBarCode + "</td>";
                    h += "</tr>";
                }
                $("#materialtb tbody").append(h);
                $("#materialtb").table("refresh");
            }
            function rtrim(str) { //删除右边的_
                return str.replace(/_$/g, "");
            }
        </script>
    </form>
</body>
</html>
