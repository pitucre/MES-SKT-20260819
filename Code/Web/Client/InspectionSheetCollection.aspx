<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="InspectionSheetCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.InspectionSheetCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">
                            <%=Resources.lang.AC_OBA_ScanSN %></span> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
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
                    <td align="left" style="font-size: 14px;">
                        已扫描数量：<label id="lblInspectionQty" style="color: #4E5154; font-weight: bold;">0</label>
                    </td>
                    <td align="right">
                        <input type="button" id="btnInspection" value=" 生产送检批 " onclick="CreateInspectionSheet()" />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.LastStation %>：</span>
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
                                    <span class="scan-center-title">
                                        <%=Resources.lang.NextStation %>：</span>
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
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %></div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 50px;">
                                            <%=Resources.lang.Sequence%>
                                        </th>
                                        <th style="width: 300px;">
                                            <%=Resources.lang.SerialNumber %>
                                        </th>
                                        <th style="width: 100px;">
                                            <%=Resources.lang.Status %>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlist">
                                </tbody>
                            </table>
                        </div>
                    </td>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td style="font-size: 12px !important;" align="left">
                                            批次列表:
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="data-statistic-relinfo">
                                <div id="packingTree">
                                    <table width="100%" id="packingList" class="ListTable">
                                        <tr id="PackingDetailHeader" class="ListTableHeader"  >
                                            <th width="15%">
                                                序号
                                            </th>
                                            <th width="25%">
                                                批次号
                                            </th>
                                            <th width="20%">
                                                批次数量
                                            </th>
                                            <th>
                                                生成时间
                                            </th>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
           <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var inspectionQty = 0;
        var inspectionSN = "";
        var resourceId = -1;
        var stationId = -1;

        $(document).ready(function () {
            resourceId = $("#hdnCurrResourceId").val(); //资源Id
            stationId = $("#hdnCurrStationId").val(); //工位Id                   
            //取值          
            var hisInspectionSN = (store.get("Inspection"));
            if (hisInspectionSN != "" && hisInspectionSN != null) {
                inspectionQty = hisInspectionSN.split(',').length;
                $("#lblInspectionQty").html(inspectionQty);
            }
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('InspectionSheet_ProCollectionUI');
                },
                10
            );
        });

        /**
        *生产送检批
        **/
            function CreateInspectionSheet() {
                if (inspectionSN == "") {
                    alert("请先扫描SN条码！");
                    $("#txtSN").focus();
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.EditInspectionSheet(inspectionSN, stationId, resourceId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, inspectionSN, ajax.error.Message);
                    return false;
                }
                var inspectionArr = ajax.value;
                loadInspectionTable(inspectionArr);
                store.remove('Inspection');
                inspectionQty = 0;
                inspectionSN = "";
                $("#lblInspectionQty").html(0);
                $("#activeinfoarea").val("");

                showAreaMessge(inspectionArr[0] + ':送检单生成成功！', "messageGreen");
            }

            function loadInspectionTable(list) {
            var row, cell;
            var setTable = document.getElementById("packingList");
            row = setTable.insertRow(setTable.rows.length);

            if ((setTable.rows.length-1) % 2 == 0) {
                row.className = 'ListTableOddRow';
            }
            else {
                row.className = 'ListTableEvenRow';
            }
            cell = row.insertCell(0);
            cell.align = "center";            
            cell.innerHTML = setTable.rows.length-1;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = list[0];

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = $("#lblInspectionQty").html();

            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = list[1];
        }

        function afterScan() {
            if ($("#txtSN").val() != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
                //1.获取当前基本信息
                var routeId = $("#hdnCurrRouteId").val(); //路由Id
                var proOrderId = $("#hdnCurrProOrderId").val(); //工单Id                
                var scanSN = $.trim($("#txtSN").val()); //扫描Sn
                var bindedSN = ""; //被绑定对象
                var vaType = 1; //采集模块类型

                if (!stationId > 0) {
                    alert("请先在操作菜单列表进行切换工位操作！");
                    return;
                }

                //2.开始对当前sn进行校验及执行activity**********待确定流程
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, userId, resourceId, routeId, stationId, proOrderId, bindedSN);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtSN").val("");
                    $("#txtSN").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }
                ajax = ajax.value; //当前返回string,如果为空则验证成功，否则验证失败，并载着错误信息
                var validation = ajax;
                if (validation.length > 0) {
                    //验证失败
                    updateCollectionList($("#txtSN").val(), 'NG');
                    showAreaMessge($("#txtSN").val() + ':' + validation, "messageRed");
                    setMessageBox($("#txtSN").val() + ':' + validation, 'messageRed');
                } else {

                    //查询SN是否已经扫描过
                    var scanSNArr =  store.get("Inspection");
                    if (scanSNArr != "" && scanSNArr != null) {
                        if (scanSNArr.indexOf(scanSN) > -1) {
                            alert(scanSN + ":该条码已扫码！");
                            $("#txtSN").val("");
                            $("#txtSN").focus();
                            return false;
                        }
                        inspectionSN = scanSNArr+",";
                    }
                    inspectionQty++;
                    inspectionSN += scanSN + ",";

                    $("#lblInspectionQty").html(inspectionQty);
                    inspectionSN = inspectionSN.substring(0, inspectionSN.length - 1);
                    store.set('Inspection', inspectionSN);
                   
                    updateCollectionList($("#txtSN").val(), 'OK');
                    showAreaMessge($("#txtSN").val() + ':通过', "messageGreen");
                    setMessageBox($("#txtSN").val() + ':通过', 'messageGreen');
                    //根据SN刷新侧边栏动态信息
                    refreshProInfoBySN(scanSN);
                }

            }
            $("#txtSN").val("");
        }

       
    </script>
</asp:Content>
