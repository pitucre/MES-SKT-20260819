<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="MsdBakeCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.MsdBakeCollection" %>

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
                            <%=Resources.lang.AC_ScanGRN%></span> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
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
            </table>
            <div style="float: left;">
                &nbsp;<b>烤箱条码</b>：<input type="text" id="txtBakeCode" style="height: 25px; width: 120px;" />
                &nbsp;<b>温度(℃)</b>：<input type="text" id="txtBakeTemp" style="height: 25px; width: 70px;"
                    maxlength="8" onkeyup="getDecimalVal(this)" /></div>
            <div style="float: right;">
                <input type="button" value=" 重置烤箱 " onclick="resetBake()" />
            </div>
        </div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td valign="top" style="width: 100%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                采集历史</div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable" id="tbMSDHistory">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 50px;">
                                            <%=Resources.lang.Sequence%>
                                        </th>
                                        <th style="width: 100px;">
                                            <%=Resources.lang.SerialNumber %>
                                        </th>
                                        <th style="width: 80px;">
                                            资源
                                        </th>
                                        <th style="width: 80px;">
                                            工序
                                        </th>
                                        <th style="width: 100px;">
                                            容器SN
                                        </th>
                                        <th style="width: 80px;">
                                            操作员
                                        </th>
                                        <th style="width: 140px;">
                                            采集时间
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="">
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
    <script language="javascript" type="text/javascript">
        var resourceId = $("#hdnCurrResourceId").val();
        var stationId = $("#hdnCurrStationId").val();
        var grn = "";
        $(document).ready(function () {
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('MsdUnPack_ProCollectionUI');
                },
                10
            );

            getMsdOperateHistory(grn);
            //扫描框回车事件
            $("#txtBakeCode").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;

                    if (curKey == 13) {
                        var bakeTemp = $.trim($("#txtBakeTemp").val());
                        if (bakeTemp == "" && $.trim(this.value) != "") {
                            $("#txtBakeTemp").focus();
                            return false;
                        }
                        else if (bakeTemp != "" && $.trim(this.value) != "") {
                            if ($.trim($("#txtSN").val()) == "") {
                                $("#txtSN").focus();
                            }
                            else {
                                afterScan();
                            }
                        }
                    }
                }
            );

            $("#txtBakeTemp").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13 && $.trim(this.value) != "") {
                    if ($.trim($("#txtSN").val()) == "") {
                        $("#txtSN").focus();
                    }
                    else{
                        afterScan();
                    }
                }
            });

            $("#txtSN").bind("focus", function () {
                if ($.trim($("#txtBakeCode").val()) == "") {
                    $("#txtBakeCode").focus(); 
                } 
             });
        });

        function afterScan() {
            if ($("#cbxforceuppercase").prop("checked")) {
                $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
            }  
            grn = $.trim($("#txtSN").val());

            var bakeCode = $.trim($("#txtBakeCode").val());
            var bakeTemp = $.trim($("#txtBakeTemp").val());
            if (bakeCode == "") {
                alert("请扫描烤箱条码！");
                $("#txtBakeCode").focus();
                return false;
            }
            else if (bakeTemp == "") {
                alert("请输入烤箱温度！");
                $("#txtBakeTemp").focus();
                return false;
            }

            if (grn != "") {
                //refreshMSDProInfo(grn);
                //验证GRN，记录入炉信息
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMSD.MSDBake(grn,bakeCode,parseFloat(bakeTemp), stationId, resourceId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //$("#txtSN").val("");
                    $("#txtSN").focus();
                    showAreaMessge(grn + ':' + ajax.error.Message, "messageRed");
                    setMessageBox(grn + ':' + ajax.error.Message, 'messageRed');
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, grn, ajax.error.Message);
                    return false;
                } else {
                    showAreaMessge(grn + ':入烘烤箱成功！', "messageGreen");
                    setMessageBox(grn + ':入烘烤箱成功！', 'messageGreen');
                    //根据SN刷新侧边栏动态信息
                    refreshMSDProInfo(grn);
                    getMsdOperateHistory(grn);
                }
            }
            $("#txtSN").val("");
        }

        /*
        **重置页面文本信息
        */
        function resetBake() {
            $("#txtBakeCode").val("");
            $("#txtBakeTemp").val("");
            $("#txtSN").val("");
            $("#txtBakeCode").focus();
        }

        function snFocus() {
            setTimeout(function () {
                $("#txtSN").focus();
            }, 100);
        }
       
    </script>
</asp:Content>
