<%@ Page Title="" Language="C#"
    MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="AgeingCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.AgeingCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
        table.collectionlist1 tbody { display: block; height: 300px; overflow-y: scroll; }
        table.collectionlist1 thead, table.collectionlist1 tbody tr { display: table; width: 100%; table-layout: fixed; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle"><%=Resources.lang.AC_OBA_ScanSN %></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox"></div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle"><%=Resources.lang.AC_OBA_ScanAgeingRack %></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox"></div>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtRack" class="scan-center-sn" />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title"><%=Resources.lang.LastStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="laststationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="right">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title"><%=Resources.lang.NextStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="nextstationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div class="data-statistic" style="width: 98%">
            <%--<span style="margin-left: 10px">已扫描数量:</span><strong style="font-size: 15px" id="txtsum">0</strong>--%>
            <input id="Start" style="float: right" type="button" class="Button" value="老化开始" onclick="AgeStart()" />
        </div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td valign="top" style="width: 100%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header"><%=Resources.lang.CollectionDetailTable %></div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable collectionlist1">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 15%;"><%=Resources.lang.Sequence%></th>
                                        <th style="width: 35%;"><%=Resources.lang.ItemCode %></th>
                                        <th style="width: 35%;"><%=Resources.lang.SerialNumber %></th>
                                        <th style="width: 15%;"><%=Resources.lang.OperaterResult %></th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlist1" style="color: white;">
                                </tbody>
                            </table>
                        </div>
                    </td>
                    <%--<td valign="top" style="width:50%">
                        
                    </td>--%>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script language="javascript" type="text/javascript">
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        var routeId = $("#hdnCurrRouteId").val();
        var prodOrderId = $("#hdnCurrProOrderId").val();

        var resourceId = $("#hdnCurrResourceId").val();//有
        var stationId = $("#hdnCurrStationId").val();//有
        $("input[disabled]").css({ 'border': 'solid 1px #a5a1a1', 'color': '#bfb9b9', 'background': 'url("Images/btn_bg_common-disable.png") repeat-x' });
        Number = 0;
        $(function () {
            setTimeout(
                    function () {
                        //加载按钮
                        loadClientButton('AgeingCollection');
                    }, 10);
        });

        function afterScan() {
            if ($("#cbxforceuppercase").prop("checked")) {
                $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
            }
            SN = $("#txtSN").val();


            //判断是否已经扫描
            var len = $("#collectionlist1 td.sn[sn=\"" + SN.toUpperCase() + "\"]").length;
            if (len > 0) {
                showAreaMessge("SN[" + SN + "]已扫描", "messageRed");
                setMessageBox("SN[" + SN + "]已扫描", "messageRed");
                $("#txtSN").val("").focus();
                //写入日志
                return false;
            }


            //检查是否在未老化的老化架中，如果在查出数据
            var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.GetAgeingRackBySN(SN);
            if (data.error != null) {
                //updateActiveInfoArea(getDateTime() + data.error.Message);
                showAreaMessge(SN + ':' + data.error.Message, "messageRed");
                setMessageBox(SN + ":" + data.error.Message, "messageRed");
                $("#txtSN").select();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                return false;
            }
            var ageRack = data.value;
            if (ageRack != "") {
               $("#txtRack").val(ageRack);
                AgeingRackInfo(ageRack);
                $("#txtSN").val("").focus();
              
            }

            if ($("#txtRack").val() != "")
            {
                
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.CheckTurnoverData($("#txtRack").val(), SN);
                if (data.error != null) {
                    //updateActiveInfoArea(getDateTime() + data.error.Message);
                    showAreaMessge(SN + ':' + data.error.Message, "messageRed");
                    setMessageBox(SN + ":" + data.error.Message, "messageRed");
                    $("#txtSN").select();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                    return false;
                }
               
                //老化架最大装载数量判断
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.RckCheckMax($("#txtRack").val());
                if (data.error != null) {
                    //updateActiveInfoArea(getDateTime() + data.error.Message);
                    showAreaMessge(SN + ':' + data.error.Message, "messageRed");
                    setMessageBox(SN + ":" + data.error.Message, "messageRed");
                    $("#txtSN").select();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                    return false;
                }
              
            }
            //SN Check
            stationRefreshBySN(SN);

            //zhiman.yuan 2017-8-16 修改通用过站验证
            var data = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(SN, resourceId, stationId, false);
            if (data.error != null) {
                showAreaMessge(SN + ":" + data.error.Message, "messageRed");
                setMessageBox(SN + ":" + data.error.Message, "messageRed");
                $("#txtSN").select();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                return false;
            }
            //根据sn,获取老化信息
            var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.GetAgeingType(SN);
            if (data.error != null) {
                // updateActiveInfoArea(getDateTime() + data.error.Message);
                showAreaMessge(data.error.Message, "messageRed");
                setMessageBox(data.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                return false;
            }
            AgeingType = data.value.AgeingType;
            ItemCode = data.value.ItemCode;

            if (AgeingType == 0) {
                $("#Start").attr("disabled", "disabled");
                $("input[disabled]").css({ 'border': 'solid 1px #a5a1a1', 'color': '#bfb9b9', 'background': 'url("Images/btn_bg_common-disable.png") repeat-x' });
                //$("#txtRack").attr("disabled", "disabled");
                //记录老化信息  
                Ageing();
            } else if (AgeingType == 1 && $.trim($("#txtRack").val()) != "") {
                Ageing();
                //$("#txtRack").attr("disabled", null);
                $("#Start").attr("disabled", null).removeAttr("style").css("float", "right");
            } else {
                //$("#txtRack").attr("disabled", null);
                $("#Start").attr("disabled", null).removeAttr("style").css("float", "right");
                $("#txtRack").val("").focus();
            }
            refreshProInfoBySN(SN);//获取上下工序信息
        }
        //老化架扫描
        $("#txtRack").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                
                SN = $("#txtSN").val();
                Rack = $("#txtRack").val();
                if (SN != "") {
                    var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.CheckTurnoverData(Rack, SN);
                    if (data.error != null) {
                        //updateActiveInfoArea(getDateTime() + data.error.Message);
                        showAreaMessge(SN + ':' + data.error.Message, "messageRed");
                        setMessageBox(SN + ":" + data.error.Message, "messageRed");
                        $("#txtSN").select();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                        return false;
                    }

                    var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.IsTurnover($("#txtRack").val());
                    if (data.error != null) {
                        //updateActiveInfoArea(getDateTime() + data.error.Message);
                        showAreaMessge(data.error.Message, "messageRed");
                        setMessageBox(data.error.Message, "messageRed");
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, "", data.error.Message);
                        return false;
                    }
                    var result = data.value;
                    ItemCode = result.ItemCode;
                    //if ($("#txtsum").val() <= 0) {
                    var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.StartAgeing($("#txtSN").val(), stationId, resourceId, routeId, prodOrderId, Rack, userId);
                    if (data.error != null) {
                        //updateActiveInfoArea(getDateTime() + data.error.Message);
                        showAreaMessge($("#txtSN").val() + ":" + data.error.Message, "messageRed");
                        setMessageBox($("#txtSN").val() + ":" + data.error.Message, "messageRed");
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, $("#txtSN").val(), data.error.Message);
                        return false;
                    }
                    //}
                    showAreaMessge(SN + ":扫描成功", "messageGreen");
                    setMessageBox(SN + ":扫描成功", "messageGreen");
                    $("#Start").attr("disabled", null).removeAttr("style").css("float", "right");
                }
                AgeingRackInfo(Rack);
               
                $("#txtSN").val("").focus();
            }
        });

        //laohua
        function Ageing() {
            $("#Start").attr("disable", "disable");
            //记录老化信息
            Rack = $("#txtRack").val();
            var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.StartAgeing($("#txtSN").val(), stationId, resourceId, routeId, prodOrderId, Rack, userId);
            if (data.error != null) {
                //updateActiveInfoArea(getDateTime() + data.error.Message);
                showAreaMessge($("#txtSN").val() + ":" + data.error.Message, "messageRed");
                setMessageBox($("#txtSN").val() + ":" + data.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, $("#txtSN").val(), data.error.Message);
                return false;
            }
            Show(ItemCode, SN, "green");
            showAreaMessge(SN + ":扫描成功", "messageGreen");
            setMessageBox(SN + ":扫描成功", "messageGreen");
            $("#txtSN").val("").focus();
        }
        //老化架开始老化
        function AgeStart() {
            var rack = $("#txtRack").val();
            if (rack == "") {
                alert("请扫描老化架");
                return false;
            }
            var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.IsTurnover(rack);
            if (data.error != null) {
                //updateActiveInfoArea(getDateTime() + data.error.Message);
                showAreaMessge(data.error.Message, "messageRed");
                setMessageBox(data.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", data.error.Message);
                return false;
            }
            var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.RackStart(rack, userId);
            if (data.error != null) {
                //updateActiveInfoArea(getDateTime() + data.error.Message);
                showAreaMessge(data.error.Message, "messageRed");
                setMessageBox(data.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", data.error.Message);
                return false;
            }
            refreshProInfoBySN(SN);
            $("#collectionlist1").html("");
            $("#txtSN").val("").focus();
            $("#txtRack").val("");
            //updateActiveInfoArea(getDateTime() + "[" + SN + "]！");
            showAreaMessge(rack + "老化架:老化开始", "messageGreen");
            setMessageBox(rack + "老化架:老化开始", "messageGreen");
        }

        //根据老化架带出所有SN信息
        function AgeingRackInfo(Rack) {
           

            var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.IsTurnover(Rack);
            if (data.error != null) {
                //updateActiveInfoArea(getDateTime() + data.error.Message);
                showAreaMessge(data.error.Message, "messageRed");
                setMessageBox(data.error.Message, "messageRed");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", data.error.Message);
       
                return false;
            }
            ;
            $("#collectionlist1").html("");
            var result = data.value;
            ItemCode = result.ItemCode;
            for (var i = 0; i < result.length; i++) {
                Number = ($("#collectionlist1 tr").length + 1);
                if (Number == 1) {
                    $("#collectionlist1").append("<tr class='ListTableOddRow' style='background-color:green'><td style=\"width:15%;\">" + Number + "</td><td style=\"width:35%;\">" + result[i].ItemCode + "</td><td style=\"width:35%;\" class=\"sn\" sn=\"" + result[i].SN.toUpperCase() + "\">" + result[i].SN + "</td><td style=\"width:15%;\">OK</td></tr>");
                } else {
                    if (Number % 2 == 0) {
                        $("#collectionlist1 tr:eq(0)").before("<tr class='ListTableOddRow' style='background-color:green'><td style=\"width:15%;\">" + Number + "</td><td style=\"width:35%;\">" + result[i].ItemCode + "</td><td style=\"width:35%;\" class=\"sn\" sn=\"" + result[i].SN.toUpperCase() + "\">" + result[i].SN + "</td><td style=\"width:15%;\">OK</td></tr>");
                    } else {
                        $("#collectionlist1 tr:eq(0)").before("<tr class='ListTableEvenRow' style='background-color:green'><td style=\"width:15%;\">" + Number + "</td><td style=\"width:35%;\">" + result[i].ItemCode + "</td><td style=\"width:35%;\" class=\"sn\" sn=\"" + result[i].SN.toUpperCase() + "\">" + result[i].SN + "</td><td style=\"width:15%;\">OK</td></tr>");
                    }
                }
            }
        }
        function Show(itemcode, sn, colors) {
            var Number = $("#collectionlist1 tr").length + 1;
            $("#txtsum").html(Number);
            var Status = colors == "red" ? "NG" : "OK";
            if (Number == 1) {
                $("#collectionlist1").append("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td style=\"width:15%;\">" + Number + "</td><td style=\"width:35%;\">" + itemcode + "</td><td style=\"width:35%;\" class=\"sn\" sn=\"" + sn.toUpperCase() + "\">" + sn + "</td><td style=\"width:15%;\">" + Status + "</td></tr>");
            } else {
                if (Number % 2 == 0) {
                    $("#collectionlist1 tr:eq(0)").before("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td style=\"width:15%;\">" + Number + "</td><td style=\"width:35%;\">" + itemcode + "</td><td style=\"width:35%;\" class=\"sn\" sn=\"" + sn.toUpperCase() + "\">" + sn + "</td><td style=\"width:15%;\">" + Status + "</td></tr>");
                } else {
                    $("#collectionlist1 tr:eq(0)").before("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td style=\"width:15%;\">" + Number + "</td><td style=\"width:35%;\">" + itemcode + "</td><td style=\"width:35%;\" class=\"sn\" sn=\"" + sn.toUpperCase() + "\">" + sn + "</td><td style=\"width:15%;\">" + Status + "</td></tr>");
                }
            }
        }
    </script>
</asp:Content>
