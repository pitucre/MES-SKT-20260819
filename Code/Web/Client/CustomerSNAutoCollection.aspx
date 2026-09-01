<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="CustomerSNAutoCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.CustomerSNAutoCollection" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle" style="float:left;">
                            <%=Resources.lang.AC_OBA_ScanSN %></span><div id="divCurrentWeight" style="padding: 18px 0px 0px; font-size: 14px; margin-left: 40px; float:left;display:none;">当前重量：<span id="lblCurrentWeight" style="font-weight: bold;">0</span> 称重状态：<span id="lblCurrentState" style="font-weight: bold;"></span></div> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                          <input type="checkbox" id="chkRePrint" title="如果您的标签需要重打，点击选择此复选框" value="0" />
                            重印&nbsp;&nbsp;
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
                                <%=Resources.lang.CollectionDetailTable %>
                            </div>
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
                    <%--<td valign="top" style="width:50%">
                        
                    </td>--%>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>
  
    
    <script language="javascript" type="text/javascript">
                
        var resourceId = $("#hdnCurrResourceId").val(); //资源Id
        var stationId = $("#hdnCurrStationId").val(); //工位Id

        $(document).ready(function () {           
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('CustomerSNAutoCollection');

                    $("#txtSN").select();
                },
                10
            );             
        });

        function afterScan() {
            if ($("#txtSN").val() != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
               
                var scanSN = $.trim($("#txtSN").val()); //扫描Sn

                if (!stationId > 0) {
                    alert("请先在操作菜单列表进行切换工位操作！");
                    return;
                }
               
                 
                //过站操作
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxJoin.CollectAutoCustomerSN(scanSN, stationId, resourceId);
                if (ajax.error != null) {
                    updateCollectionList(scanSN, 'NG');
                    showAreaMessge(ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }
                else if (ajax.json == undefined) {
                    showAreaMessge(scanSN + '：' + "未接收到系统返回信息，请检查是否登录已超时或网络中断！", "messageRed");
                    $("#txtSN").val("");
                    $("#txtSN").focus();
                    return false;
                }

                var isPrint = ajax.value[1]=="True"?true:false;
                var customerSN = ajax.value[0];
                if ($("#chkRePrint").prop("checked")) {
                    isPrint = true;
                }
                
                updateCollectionList(scanSN, 'OK');
                showAreaMessge('产品条码[' + scanSN + ']与客户条码[' + customerSN + ']绑定成功！', "messageGreen");
                //根据SN刷新侧边栏动态信息
                refreshProInfoBySN(scanSN);
                //自动打印 updata huangliang 2017-11-20
                if (isPrint) {
                    AutoPrint(stationId, scanSN);
                }                
            }
            $("#txtSN").val("");
        }
         
    </script>
</asp:Content>
