<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LineWarehouseReceive.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.LineWarehouseReceive" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <title>线边仓接收</title>
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
                        <img src="images/icon/steelnetclean_white.png" />                        
                    </div>
                    <div>
                        线边仓接收
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
                            <label for="orderno">
                                备料单号:</label>
                            <input class="orderno" id="PrepareMaterialNo" data-corners="false" type="text" data-mini="true"
                                value="" />
                        </td>
                        <td>
                            <a href="#fpanel" id="chooseBill" data-rel="popup" data-position-to="window" data-role="button" style="margin-top: 22px">选择单据</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label for="suppliername">
                                GRN:</label>
                            <input  id="txtGrn" />
                        </td>
                    </tr>                     
                </table>
                <div id="msg" style="text-align: center;">
                </div>
                <div>
                        <strong>GRN明细</strong>&nbsp;&nbsp;<span style="color:Red;" id="spHint">0-0</span>
                    </div>
                <table id="arrivaltable" data-role='table' data-mode='columntoggle' class='ui-responsive table-stroke' style='width: 100%'>
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
            <div data-role="footer" data-position="fixed" style="position: fixed">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="Save" data-corners="false" id="Save" onclick="Save()" data-role="button" data-fullscreen="true"
                            data-theme="f">线边仓接收</a></li>                         
                    </ul>
                </div>
            </div>
            <div data-role="panel" id="fpanel" data-display="overlay">
                <div data-role="main" data-theme="a" class="ui-content">
                    <ul data-role="listview" id="listviews" data-inset="false" data-filter="true" data-filter-placeholder="输入..."
                        data-theme="c" class="listview"/>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            $(function () {
                //隐藏columntoggle列表按钮
                $(".ui-table-columntoggle-btn").css("display", "none");
                $(".ui-body-c").css("background", "#fff");
                $("#txtGrn").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() }).focus();                

                $("#chooseBill").on("click", function () {
                    if (!$("#fpanel").hasClass("ui-panel-open")) {
                        GetPrepareMaterial();
                    }
                });

            });
            
            $("#txtGrn").on("keydown", function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html("");
                    Save();
                }
            });
           
           $("#PrepareMaterialNo").on("keydown", function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html("");
                    GetInfo();
                }
            });
            function Save() {
                if ($.trim($("#txtGrn").val()) == "") {
                    confirmDialogFocus("请扫描GRN!", function () {
                        $("#txtGrn").val("").select();
                    });
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.StockListMaterialReceive($.trim($("#txtGrn").val()), $.trim($("#PrepareMaterialNo").val()), "线边仓");
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

            
        //根据字符串模糊查询采购单
        $("#listviews").on("filterablebeforefilter", function (e, data) {
            var $ul = $(this)
            $input = $(data.input)
            value = $input.val();
            if (value && value.length > 2) {
                GetPrepareMaterial(value);
            }
        });
        
        function GetPrepareMaterial(value) {
            $("#listviews").html("");
            $.post("../Handler/WareHouseInOperation.ashx?api=GetPrepareMaterial&PrepareMaterialNo=" + value, { "GetType": "线边仓" }, function (ajax) {

                var entity = $.parseJSON(ajax);
                if (entity.error != null) {
                    confirmDialogFocus(entity.error, function () {
                        $("#orderno").focus();
                    });
                };
                var ulhtml = "";
                for (var i = 0; i < entity.length; i++) {
                    if (ulhtml.indexOf(entity[i].POCode) == -1) {
                        ulhtml += "<li class='ui-btn ui-btn-icon-right ui-icon-carat-r'><a onclick='SetPOCode(this)'>" + entity[i].PrepareMaterialNo + "</a></li>";
                    }
                }
                $("#listviews").append(ulhtml);
                $("#listviews").listview("refresh");
            });
        }

         function SetPOCode(Code) {
            var code = $(Code).html();
            $("#PrepareMaterialNo").val(code);
            $("input[data-type='search']").val('');
            $("#listviews").html('');
            $("#fpanel").panel("close");
            GetInfo();
            $("#txtGrn").focus();
         }

         //获取信息 显示table
         function GetInfo() {
             $.post("../Handler/WareHouseInOperation.ashx?api=PrepareMaterialGrn", { "PrepareMaterialNo": $("#PrepareMaterialNo").val(), "GetType": "线边仓" }, function (ajax) {
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
            $("#spHint").html(GetMaterialGrnNumber()-entity.length+'-'+GetMaterialGrnNumber());
         }
             function GetMaterialGrnNumber() {
                 var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.GetMaterialGrnNumber($.trim($("#PrepareMaterialNo").val()), 0);
                if (ajax.error != null) {
                    return false;
                }
                return ajax.value;
            }
        </script>
    </form>
</body>
</html>