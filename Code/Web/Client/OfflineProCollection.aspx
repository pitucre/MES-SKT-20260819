<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="OfflineProCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.OfflineProCollection" %>
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
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked />
                        <%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" />&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %></div>
                            <table width="100%" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 10%">
                                            <%=Resources.lang.Sequence%>
                                        </th>
                                        <th style="width: 80%">
                                            <%=Resources.lang.SerialNumber %>
                                        </th>
                                        <th style="width: 10%">
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
                                不良明细表
                            </div>
                            <div class="data-statistic-relinfo">
                                <div id="packingTree">
                                    <table width="100%" class="ListTable" id="nccodeList">
                                        <tr id="NCCodeDetailHeader" class="ListTableHeader">
                                            <th width="20%" style="text-align: center">
                                                不良代码
                                            </th>
                                            <th width="70%" style="text-align: center;">
                                                不良描述
                                            </th>
                                            <th width="10%">
                                                操作
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
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.nccodecollection.js"
        type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var SN = "";
        var ncCodeArr = [];

        $(document).ready(function () {
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('OfflineProCollection');
                },
                10
            );
        });

        /**
        *扫描触发事件
        */
        function afterScan() {
            if ($.trim($("#txtSN").val()) != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }

                //1.查看是否有RouteId及工单Id
                routeId = $("#hdnCurrRouteId").val();
                proOrderId = $("#hdnCurrProOrderId").val();
                resourceId = $("#hdnCurrResourceId").val();
                stationId = $("#hdnCurrStationId").val();
                scanSN = $.trim($("#txtSN").val()); //扫描Sn

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.GetNCCodeInfo(scanSN, stationId);
                if (ajax.error != null) {
                    updateCollectionList(scanSN, 'NG');
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    $("#txtSN").val("").focus();
                    return false;
                }
                //查询当前扫描的SN是否为不良代码，为不良代码则加入数组
                if (ajax.value[0] != "") { //当前扫码的SN为不良代码

                    //判断当前不良是否已经扫描
                    for (var j = 0; j < ncCodeArr.length; j++) {
                        if (ncCodeArr[j].NCCode == scanSN) {
                            alert("不良[" + scanSN + "]已扫描！");
                            $("#txtSN").val("").focus();
                            return false;
                        }
                    }
                    var nccodeObj = {};
                    nccodeObj.NCCode = scanSN;
                    nccodeObj.NCDesc = ajax.value[1];
                    //验证不良代码是否重复扫描
                    ncCodeArr.push(nccodeObj);
                    loadingNCTable(ncCodeArr);
                    $("#txtSN").val("").focus();
                    return false;

                }

                var ncArrStr = "";
                for (var j = 0; j < ncCodeArr.length; j++) {
                    ncArrStr += (ncCodeArr[j].NCCode + "^");
                }

                //离线采集数据
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.OfflineProCollect(scanSN, ncArrStr, resourceId, stationId);
                if (ajax.error != null) {
                    updateCollectionList(scanSN, 'NG');
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    $("#txtSN").val("").focus();
                    return false;
                }
                else {
                    updateCollectionList(scanSN, 'OK');
                    showAreaMessge(scanSN + ':通过', "messageGreen");
                }
                ncCodeArr = [];
                scanSN = "";
                loadingNCTable(ncCodeArr);
            }
            $("#txtSN").val("").focus();
        }

        /**
        *加载不良列表信息
        **/
        function loadingNCTable(list) {
            var row, cell;
            var setTable = document.getElementById("nccodeList");

            $("#nccodeList tr:gt(0)").remove();

            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = list[i].NCCode;

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = list[i].NCDesc;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = "<img src='../Content/images/icon/close.gif' onclick=cancelNCCode(" + i + ") style='cursor:pointer;' title='点击将会删除采集的不良' alt='X' />";
            }
        }

        /**
        *取消不良信息
        **/
        function cancelNCCode(i) {
            ncCodeArr.splice(i, 1);
            loadingNCTable(ncCodeArr);
            $("#txtSN").val("").focus();
        }           
    </script>
</asp:Content>
