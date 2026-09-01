<%@ Page Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true"
    CodeBehind="AgeingBadCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.AgeingBadCollection" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                        <input type="text" id="txtBC" class="scan-center-sn" />
                    </td>
                </tr>
                <%--                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle"><%=Resources.lang.AC_OBA_ScanSN %></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox"></div>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="textSN" class="scan-center-sn" />
                    </td>
                </tr>--%>
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
            <input id="Start" style="float: right" type="button" class="Button" value="强制结束老化" onclick="AgeEnd()" />
        </div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td valign="top" style="width: 100%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header"><%=Resources.lang.CollectionDetailTable %></div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 50px;"><%=Resources.lang.Sequence%></th>
                                        <%--                                        <th style="width: 300px;"><%=Resources.lang.ItemCode %></th>--%>
                                        <th style="width: 300px;"><%=Resources.lang.SerialNumber %></th>
                                        <th style="width: 100px;"><%=Resources.lang.OperaterResult %></th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlist1" style="color:white">
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
        var resourceId = $("#hdnCurrResourceId").val();
        var stationId = $("#hdnCurrStationId").val();
        var Flag = 0;
        var forceEndPopedom = "80012801";
        Number = 0;
        $(function () {
            $("#txtBC").focus();
            setTimeout(
                  function () {
                      //加载按钮
                      loadClientButton('Common_ProCollectionUI');
                  }, 10);
        });
        //不良代码扫描
        $("#txtBC").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                //判断是否是NCCode，如果是  跳到textSN  ，如果不是  执行 产品或者老化架的老化结束逻辑
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.IsNCCode($("#txtBC").val());
                if (data.error != null) {
                    //updateActiveInfoArea(getDateTime() + data.error.Message);
                    showAreaMessge(data.error.Message, "messageRed");
                    setMessageBox(data.error.Message, "messageRed");
                    $("#txtBC").select();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, $("#txtBC").val(), data.error.Message);
                    return false;
                }
                if (Flag == 1) {
                    NCCodeScan(NCCode, $("#txtBC").val());
                    Flag = 0;
                    NCCode = "";
                    $("#txtBC").val("").focus();
                    return false;
                }
                Flag = data.value;

                if (Flag == 1) {//不良代码
                    NCCode = $("#txtBC").val();
                    showAreaMessge($("#txtBC").val() + ":不良代码扫描成功", "messageGreen");
                    setMessageBox($("#txtBC").val() + ":不良代码扫描成功", "messageGreen");
                    $("#txtBC").val("").focus();
                    return false;
                } else if (Flag == 3) {//SN
                    //SN Check
                    var SN = $("#txtBC").val();
                    /*Modify By Alen 2018-01-30 增加老化结束UI的上下站位信息显示*/
                    stationRefreshBySN(SN);
                    
                    //zhiman.yuan 2017-8-16 修改通用过站验证
                    var data = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(SN, resourceId, stationId, false);
                    if (data.error != null) {
                        showAreaMessge(SN + ":" + data.error.Message, "messageRed");
                        setMessageBox(SN + ":" + data.error.Message, "messageRed");
                        $("#txtBC").select();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                        return false;
                    }
                }
                /*
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.GetGetAgeingEndBySN($("#txtBC").val());
                
                var sn = JSON.parse(data.value).SN;
                if ( typeof(sn) != 'undefined') {
                    refreshProInfoBySN(sn);//获取上下工序信息
                }
                */
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.AgeingEnd($("#txtBC").val(), stationId, resourceId, routeId, prodOrderId, "", userId, "1");
                if (data.error != null) {
                    //updateActiveInfoArea(getDateTime() + data.error.Message);
                    showAreaMessge($("#txtBC").val() + ":" + data.error.Message, "messageRed");
                    setMessageBox($("#txtBC").val() + ":" + data.error.Message, "messageRed");
                    $("#txtBC").select();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, $("#txtBC").val(), data.error.Message);
                    return false;
                }
                //updateActiveInfoArea(getDateTime() + "[" + $("#txtBC").val() + "]老化结束成功");
                showAreaMessge($("#txtBC").val() + ":老化结束成功", "messageGreen");
                setMessageBox($("#txtBC").val() + ":老化结束成功", "messageGreen");
                Show($("#txtBC").val(), "green");
                $("#txtBC").val("").focus();
            }
        });
        //采集不良
        function NCCodeScan(NC,SN) {
            //SN Check
            //zhiman.yuan 2017-8-16 修改通用过站验证
            var data = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(SN, resourceId, stationId, false);
            if (data.error != null) {
                showAreaMessge(SN + ":" + data.error.Message, "messageRed");
                setMessageBox(SN + ":" + data.error.Message, "messageRed");
                $("#txtBC").select();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                return false;
            }
            var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.NCCodecollect(SN, stationId, resourceId, routeId, prodOrderId, NC, userId);
            if (data.error != null) {
                //updateActiveInfoArea(getDateTime() + data.error.Message);
                showAreaMessge(data.error.Message, "messageRed");
                setMessageBox(data.error.Message, "messageRed");
                $("#txtBC").select();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                return false;
            }
            //updateActiveInfoArea(getDateTime() + "[" + $("#txtBC").val() + "]不良代码[" + $("#textSN").val() + "]采集完成");
            showAreaMessge(SN + ":不良代码采集完成", "messageGreen");
            setMessageBox(SN + ":不良代码采集完成", "messageGreen");
            Show(SN, "red");
            refreshProInfoBySN(SN);//获取上下工序信息
            $("#textSN").val("").focus();
        }

        //强制结束老化
        function AgeEnd() {
            //判断权限
            if (!IsHasPermission(userId, forceEndPopedom)) {
                alert("没有[强制结束老化]的操作权限！");
                return false;
            }
            if (confirm("是否强制结束老化")) {
                if ($.trim($("#txtBC").val()) == "") {
                    alert("请扫描SN或老化架");
                    $("#txtBC").focus();
                    return false;
                }
                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.GetGetAgeingEndBySN($("#txtBC").val());
                
                var sn = JSON.parse(data.value).SN;
                if (typeof (sn) != 'undefined') {
                    refreshProInfoBySN(sn);//获取上下工序信息
                }

                var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.AgeingEnd($("#txtBC").val(), stationId, resourceId, routeId, prodOrderId, "", userId, "2");
                if (data.error != null) {
                    //updateActiveInfoArea(getDateTime() + data.error.Messag);
                    showAreaMessge($("#txtBC").val() + ":" + data.error.Message, "messageRed");
                    setMessageBox($("#txtBC").val() + ":" + data.error.Message, "messageRed");
                    $("#txtBC").select();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, $("#txtBC").val(), data.error.Message);
                    return false;
                }
                alert("强制老化成功");
                Show($("#txtBC").val(), "green");
                //updateActiveInfoArea(getDateTime() + "强制老化成功");
                showAreaMessge($("#txtBC").val() + ":强制老化成功", "messageGreen");
                setMessageBox($("#txtBC").val() + ":强制老化成功", "messageGreen");
                $("#txtBC").val("").focus();
            }
        }
        function Show(sn, colors) {
            Number = $("#collectionlist1 tr").length + 1;
            $("#txtsum").html(Number);
            var Status = colors == "red" ? "NG" : "OK";
            if (Number == 1) {
                $("#collectionlist1").append("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td>" + Number + "</td><td>" + sn + "</td><td>" + Status + "</td></tr>");
            } else {
                if (Number % 2 == 0) {
                    $("#collectionlist1 tr:eq(0)").before("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td>" + Number + "</td><td>" + sn + "</td><td>" + Status + "</td></tr>");
                } else {
                    $("#collectionlist1 tr:eq(0)").before("<tr class='ListTableOddRow' style='background-color:" + colors + "'><td>" + Number + "</td><td>" + sn + "</td><td>" + Status + "</td></tr>");
                }
            }
        }

        /***初始化列表**/
        //function initCollectionList1() {
        //    var control = $("#collectionlist");
        //    control.html("");
        //    var html = '';
        //    for (var i = 0; i < 5; i++) {
        //        html = '<tr class="';
        //        if (i % 2 == 0) {
        //            html += 'ListTableOddRow';
        //        } else {
        //            html += 'ListTableEvenRow';
        //        }
        //        html += '">';
        //        html += ''
        //              + '<td align="center" valign="middle"><a href="javascript:void(0)" style="color:#000">' + collectionIndex[i] + '</a><div></td>'
        //              + '<td align="center" valign="middle"></td>'
        //              + '<td align="center" valign="middle"></td>'
        //              + '<td align="center" valign="middle"></td>'
        //              + '</tr>';
        //        control.append(html);
        //    }
        //}
    </script>
</asp:Content>
