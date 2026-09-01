<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.master"
    AutoEventWireup="true" CodeBehind="NCDataRepair.aspx.cs" Inherits="SKT.LeanMES.Web.Client.NCDataRepair" %>

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
                    <td valign="top" style="width: 100%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %></div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 100px;">
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
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
             <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <script type="text/javascript">

        $(document).ready(function () {
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('NC_RepairUI');
                },
                10
            );
        });

        /**
        *扫描触发事件
        */
        function afterScan() {
            if ($("#txtSN").val() != "") {
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
                //执行维修相关操作
                repair();
            }
            $("#txtSN").val("");
            $("#txtSN").focus();
        }

        /**
        *验证条码信息：
        *条码验证通过弹出维修窗口
        **/
        function repair() {
            //1.获取当前的一些工序信息             
            var resourceId = $("#hdnCurrResourceId").val();
            var stationId = $("#hdnCurrStationId").val();
            var scanSN = $.trim($("#txtSN").val()); //扫描Sn
            
            //验证主条码信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.CheckRepairSN(scanSN, stationId, resourceId);
            if (ajax.error != null) {
                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            var mainSN = ajax.value;
            updateCollectionList(mainSN, 'OK');
            showAreaMessge(mainSN + ':验证通过, 开始维修！', "messageGreen");
            refreshProInfoBySN(mainSN);

            //打开维修窗口               
            dialog({ title: "不良维修", src: webroot + "/Client/NCDataRepairDetail.aspx?name=NC_RepairUI&sn=" + escape(mainSN) + "&stationid=" + stationId + "&resourceid=" + resourceId + "&rnd=" + Math.random(), width: 1024, height: 600 });

            $("#txtSN").val("").focus();
        }
    </script>
</asp:Content>
