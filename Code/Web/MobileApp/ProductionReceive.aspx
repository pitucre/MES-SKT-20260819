<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductionReceive.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.ProductionReceive" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>生产接收</title>
    <style type="text/css">
        .clear {
            clear: both;
            height: 2px;
        }

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
    <div data-role="page" id="pageOne">
        <div data-role="header" id="header" data-position="fixed">
            <h5 style="padding: 4px; margin: 0px;">
                <div>
                    <img src="images/icon/steelnetclean_white.png" />                    
                </div>
                <div>
                    生产接收
                </div>
            </h5>
            <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            <div data-role="navbar">
                <ul>
                    <li><a href="#" data-theme="c">生产接收</a></li>                
                    <li><a href="#Search" data-transition="none" data-theme="c" >查询</a></li>
                </ul>
            </div>
        </div>
        <div data-role="content">
            <div data-role="fieldcontain">
                 <label for="suppliername">
                                    GRN:</label>
                                <input id="txtGrn" />            
                <div class="clear">
                </div>              
                <div id="msg" style="text-align: center;">
                </div>
                <div>
                    <strong>GRN明细</strong>&nbsp;&nbsp;<span style="color: Red;" id="spHint">0-0</span>
                </div>

                <table id="arrivaltable" data-role='table' data-mode='' class='ui-responsive table-stroke' style='width: 100%;padding-top:100px;'>
                        <thead>
                            <tr>
                                <th>GRN</th>
                                <th>数量</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>  
            </div>
        </div>
        <div data-role="footer" data-position="fixed" style="position: fixed">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Save" onclick="Save()" data-role="button" data-fullscreen="true"
                            data-theme="f">生产接收</a></li>                         
                    </ul>
                </div>
            </div>
    </div>
    
    <div data-role="page" id="Search">
        <div data-role="header" data-position="fixed">
            <h5 style="padding: 4px; margin: 0px;">
                <div>
                  <img src="images/icon/smt_white.png" />                    
                </div>
                <div>
                    生产接收
                </div>
            </h5>
            <a data-iconpos="left" data-rel="back" data-transition="none" data-role="button"
                data-ajax="false" data-icon="back">返回</a><a href="Index.aspx" class="ui-btn-right"
                    data-icon="home" data-transition="none" data-ajax="false">主页</a>

            <div data-role="navbar" data-theme="c">
                <ul>
                    <li><a href="#pageOne" data-transition="none" data-theme="c">生产接收</a></li>                                 
                    <li><a href="#Search" data-transition="none" data-theme="c">查询</a></li>
                </ul>
            </div>
        </div>
        <div data-role="content">
            <div>
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label for="showOrderNo">
                                工单</label>
                        </td>
                        <td>
                            <a href="#" data-transition="none" data-role="button" onclick="schooseMOCode();" data-ajax="false"
                                id="ShowMOCode" data-theme="c">请选择</a>
                            <div class="clear">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="showOrderNo">
                                领料单：</label>
                        </td>
                        <td>
                            <a href="#" data-transition="none" data-role="button" onclick="schooseApplyNo();" data-ajax="false"
                                id="ShowApplyNo" data-theme="c">请选择</a>
                            <div class="clear">
                            </div>
                        </td>
                    </tr>
               <%--     <tr>
                        <td>
                            <label for="showOrderNo">
                                备料单</label>
                        </td>
                        <td>
                            <a href="#" data-transition="none" data-role="button" onclick="schoosePrepareMaterialNo();" data-ajax="false"
                                id="ShowPrepareMaterialNo" data-theme="c">请选择</a>
                            <div class="clear">
                            </div>
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <label for="showOrderNo">
                                GRN：</label>
                        </td>
                        <td>
                          <input id="txtSN" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="showOrderNo">
                                状态</label></td>
                        <td>
                            <select id="ddlStatue" data-transition="none">                              
                                 <option value="-3">请选择</option>                            
                                <option value="-1">全部</option>
                                 <option value="18">待线边仓接收</option>
                                 <option value="1">在线边仓</option> 
                                 <option value="2">在产线</option> 
                            </select>
                            <div class="clear">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
               <div id="msg2" style="text-align: center;">
                    </div>
            <table id="table" data-role="table" data-mode="" class="ui-responsive table-stroke" style="width: 100%">
                <thead>
                    <tr>
                        <th>GRN</th>
                        <th>数量</th>                                
                        <th>物料编码</th>
                        <%--<th>工单</th>--%>
                        <th>领料单号</th>
                        <%--<th>备料单号</th>--%>
                        <th>状态</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
          <div data-role="panel" id="SMOCodePanel" style="background: #f9f9f9">
            <div data-role="content">
                <ul data-role="listview" id="SMOCodeView" data-inset="true" data-filter="true" data-filter-placeholder="搜索"
                    data-theme="c" class="listview" >
                </ul>
            </div>
        </div>
          <div data-role="panel" id="SApplyNoPanel" style="background: #f9f9f9">
            <div data-role="content">
                <ul data-role="listview" id="SApplyNoView" data-inset="true" data-filter="true" data-filter-placeholder="搜索"
                    data-theme="c" class="listview">
                </ul>
            </div>
        </div>
          <div data-role="panel" id="SPrepareMaterialNoPanel" style="background: #f9f9f9">
            <div data-role="content">
                <ul data-role="listview" id="SPrepareMaterialNoView" data-inset="true" data-filter="true" data-filter-placeholder="搜索"
                    data-theme="c" class="listview">
                </ul>
            </div>
        </div>
    </div>
    </form>    
    <script type="text/javascript">
        var MOCode = "";
        var ApplyNo = "";
        var PrepareMaterialNo = "";
       
        $(document).on("pageshow", "#Search", function (event) {
            $(".ui-body-c").css("background", "#fff");
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#SshowOrderNo").html($("#showOrderNo").html());
        });

        //线边仓接收GRN查询栏BEGIN---------------------------------------------------------

        //获取工单
        function schooseMOCode() {
            var typeStr = "工单";
            $("#SMOCodePanel").panel("open");
            $.post("../Handler/WareHouseInOperation.ashx?api=GetOrderDetails", { "MOCode": "", "ApplyNo": "", "Type": typeStr }, function (data) {
                var htmlstr = "";
                var data = JSON.parse(data);
                $('#SMOCodeView').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' onclick=SOrderList('" + data[i] + "','" + 'ShowMOCode' + "','" + 'SMOCodePanel' + "')>" + data[i] + "</li>";
                }
                $("#SMOCodeView").append(htmlstr);
                $('#SMOCodeView').listview('refresh');
            });
        }

        //获取领料单
        function schooseApplyNo() {
            $("#SApplyNoPanel").panel("open");
       //     MOCode = $("#ShowMOCode").html();
          
            var typeStr = "领料单";
            $.post("../Handler/WareHouseInOperation.ashx?api=GetOrderDetails", { "MOCode": MOCode, "ApplyNo": "", "Type": typeStr }, function (data) {
                var htmlstr = "";
                var data = JSON.parse(data);
                $('#SApplyNoView').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' onclick=SOrderList('" + data[i] + "','" + 'ShowApplyNo' + "','" + 'SApplyNoPanel' + "')>" + data[i] + "</li>";
                }
                $("#SApplyNoView").append(htmlstr);
                $('#SApplyNoView').listview('refresh');
            });
        }

        //获取备料单
        function schoosePrepareMaterialNo() {
            $("#SPrepareMaterialNoPanel").panel("open");
        //    MOCode = $("#ShowMOCode").html();
        //    ApplyNo = $("#ShowApplyNo").html();

            var typeStr = "备料单";
            $.post("../Handler/WareHouseInOperation.ashx?api=GetOrderDetails", { "MOCode": MOCode, "ApplyNo": ApplyNo, "Type": typeStr }, function (data) {
                var htmlstr = "";
                var data = JSON.parse(data);
                $('#SPrepareMaterialNoView').html('');
                for (var i = 0; i < data.length; i++) {
                    htmlstr += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r' onclick=SOrderList('"+data[i].trim()+"','" + 'ShowPrepareMaterialNo' + "','" + 'SPrepareMaterialNoPanel'+ "')>" + data[i] + "</li>";
                }
                $("#SPrepareMaterialNoView").append(htmlstr);
                $('#SPrepareMaterialNoView').listview('refresh');
            });
        }
       
        //Value(当前查询的单据)，displayArea（选中单据显示的区域框），panelID（选择单据的搜索框）
        function SOrderList(value, displayArea, panelID) {           
            $("#classType").html();
            $("#" + displayArea).html(value);
            $("input[data-type='search']").val('');
            $("#" + panelID).panel("close");
            if (panelID == "SMOCodePanel") {
                MOCode = value;
            } else if (panelID == "SApplyNoPanel") {
                ApplyNo = value;
            } 
        }

        //function Search() {        
        //    var MOCodeValue = MOCode;
        //    var ApplyNoValue = ApplyNo;
        //    var PrepareMaterialNoValue = PrepareMaterialNo;
        //    var GRN =$("#txtSN").val().trim();
        //    var Statue = $("#ddlStatue").val();
        //    Load(MOCodeValue, ApplyNoValue, PrepareMaterialNoValue, GRN, Statue);
        //}

        function Load(MOCodeValue, ApplyNoValue, GRN, Statue) {

            if (MOCodeValue == "" && ApplyNoValue == ""  && GRN == "") {
                return;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetPrepareMaterialGrnDel(MOCodeValue, ApplyNoValue, GRN, Statue);
            if (ajax.error != null) {
                $("#msg2").html(ajax.error.Message).css("color", "red");          
                return false;
            }
            if (ajax.value != null && ajax.value.length > 0) {
                if ($("#table tbody tr") > 0) {
                    $("#table tbody tr").removeAttr("style");
                }
                $("#table tbody").html("");
                var htmlstr = "";
                for (var i = 0; i < ajax.value.length; i++) {
                    htmlstr += "<tr>";
                    htmlstr += "<td>" + ajax.value[i].SerialNumber + " </td>";
                    htmlstr += "<td>" + ajax.value[i].BalanceQty + " </td>";
                    htmlstr += "<td>" + ajax.value[i].ItemCode + " </td>";
                    //htmlstr += "<td>" + ajax.value[i].MOCode + " </td>";
                    htmlstr += "<td>" + ajax.value[i].ApplyNo + " </td>";
                   // htmlstr += "<td>" + ajax.value[i].PrepareMaterialNo + " </td>";
                    htmlstr += "<td>" + ajax.value[i].StatueDesc + " </td></tr>";
                }
                $("#table tbody").append(htmlstr);
                $("#table").table("refresh");

            }
            else {
                $("#table tbody").html('');
                $("#table tbody").append('<tr class="ListTableOddRow"><td colspan="6" style="text-align: center";><font color="red">暂无数据</font></td></tr>');
                $("#table").table("refresh");            
            }        
        }

        //根据GRN扫描带出备料单所有GRN
        $("#txtSN").on("keydown", function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#msg").html("");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetPrepareMaterialNo($.trim($("#txtSN").val()));
                if (ajax.error!=null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#txtGrn").select();
                    return false;
                }
                $("#ShowMOCode").html("请选择");
                MOCode = "";
                //$("#ShowApplyNo").html("请选择");
                //ApplyNo = "";
                $("#txtSN").val("");

                var value = ajax.value.trim();
                if (value == "") {
                    $("#table tbody").html('');
                    $("#table tbody").append('<tr class="ListTableOddRow"><td colspan="6" style="text-align: center";><font color="red">暂无数据</font></td></tr>');
                    $("#table").table("refresh");
                    $("#txtSN").val("").select();
                    return;
                }
                $("#ShowApplyNo").html(value);
                ApplyNo = value;
                Load(MOCode, ApplyNo, "", ($("#ddlStatue").val() == "-3" ? "-1" : $("#ddlStatue").val()));
            }
        });

        $("#ddlStatue").on("change", function () {
            var statue = $("#ddlStatue").val();
            if (statue == "-3") {
                alert("请选择状态！");
                return false;
            }
            Load(MOCode, ApplyNo,"", statue);
        })

        //线边仓接收BEGIN------------------------------------------------------------------

            $("#txtGrn").on("keydown", function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html("");
                    Save();
                }
            });

            function Save() {
                if ($.trim($("#txtGrn").val()) == "") {
                    confirmDialogFocus("请扫描GRN!", function () {
                        $("#txtGrn").val("").select();
                    });
                    return false;
                }
                var c = "产线";            

              //产线接收
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.StockListMaterialReceives($.trim($("#txtGrn").val()), "", c);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#txtGrn").select();
                    return false;
                } else {
                    $("#msg").html($.trim($("#txtGrn").val()) + " 接收成功").css("color", "green");
                    GetInfo();
                    $("#txtGrn").val("").select();
                }
            }

            //获取信息 显示table
            function GetInfo() {

                var PrepareMaterialNoStr = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetPrepareMaterialNo($.trim($("#txtGrn").val()), 0);
                if (PrepareMaterialNoStr.error != null) {
                    alert(PrepareMaterialNoStr.error);
                    return false;
                }
                var PrepareMaterialNo = PrepareMaterialNoStr.value;
                $.post("../Handler/WareHouseInOperation.ashx?api=PrepareMaterialGrn", { "PrepareMaterialNo": PrepareMaterialNo, "GetType": "产线" }, function (ajax) {
                    var ajax1 = $.parseJSON(ajax);
                    if (ajax1.error != null) {
                        confirmDialogFocus(ajax1.error, function () {
                            $("#PrepareMaterialNo").focus();
                        });
                        return false;
                    }
                    var entity = $.parseJSON(ajax);
                    MaterialGrn = [];
                    //添加送货项列表
                    $.grep(entity, function (e, i) {
                        MaterialGrn.push(e);
                    });
                    GetOrderDelList(entity);
                });
            }

            //table生成
            function GetOrderDelList(entity) {
                if (entity != null && entity.length > 0) {
                    if ($("#arrivaltable tbody tr") > 0) {
                        $("#arrivaltable tbody tr").removeAttr("style");
                    }
                    $("#arrivaltable tbody").html("");
                    var htmlstr = "";
                    var mark = 0;
                    for (var i = 0; i < entity.length; i++) {
                        htmlstr += "<tr>";
                        htmlstr += "<td>" + entity[i].SerialNumber + " </td>";
                        htmlstr += "<td>" + entity[i].BalanceQty + " </td></tr>"//收货数量
                    }
                    $("#arrivaltable tbody").append(htmlstr);
                    $("#arrivaltable").table("refresh");

                }
                else {
                    $("#arrivaltable tbody").html('');
                    $("#arrivaltable tbody").append('<tr class="ListTableOddRow"><td colspan="2" style="text-align: center";><font color="red">暂无数据</font></td></tr>');
                    $("#arrivaltable").table("refresh");
                    $("#orderno").val('').focus();
                }
                $("#spHint").html(GetMaterialGrnNumber() - entity.length + '-' + GetMaterialGrnNumber());
            }

            function GetMaterialGrnNumber() {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetMaterialGrnNumber($.trim($("#PrepareMaterialNo").val()), 0);
                if (ajax.error != null) {
                    return false;
                }
                return ajax.value;
            }

        
    </script>
</body>