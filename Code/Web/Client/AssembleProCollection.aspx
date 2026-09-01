<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="AssembleProCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.AssembleProCollection" %>

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
                                    <span class="scan-center-title" style="width: 95px; display: block;">
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
                                    <span class="scan-center-title" style="width: 95px; display: block;">
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
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td valign="top" style="width: 50%">
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
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td style="width: 40%" align="left">
                                            <input type="hidden" id="hdnCurrSerialNumber" value="" />
                                            <input type="hidden" id="hdnCurrAssyData" value="" />
                                            <input type="hidden" id="hdnIsAssScan" value="0" />
                                            &nbsp;<input type="button" id="btnRefreshSN" value=" 刷新重扫条码 " onclick="refreshSN()"
                                                style="margin-right: 20px; display: none;" title="刷新重扫条码" />
                                        </td>
                                        <td style="width: 80px; font-size: 12px !important;" align="center">
                                            装配明细表
                                        </td>
                                        <td align="right" style="width: 40%">
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="data-statistic-relinfo" style="text-align: left; padding-left: 5px; margin-top: 5px;">
                                <div>
                                    <span class="data-statistic-relinfo-basal" id="dsreflinfobasal">SN：</span> <span
                                        id="dsrbInfo" class="data-statistic-relinfo-basal"></span>
                                </div>
                                <div>
                                    <div id="packingTree" class="collectionTree">
                                    </div>
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
    <script language="javascript" type="text/javascript">
        var IsMainSN = true; //是否是主序列号,是则执行主序列号相关流程，否则执行组件相关业务流程
        var isScan = true; //是否可进行部件组装
        var stationId;
        var resourceId

        $(document).ready(function () {
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('Assemble_ProCollectionUI');
                },
                10
            );
        });

        /**
        *扫描触发事件
        */
        function afterScan() {
            if ($.trim($("#txtSN").val()) != "") {
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
                if (IsMainSN) {
                    //执行主序列号相关业务流程
                    mainProcess();
                } else {
                    if (!isScan) {
                        showAreaMessge($("#hdnCurrSerialNumber").val() + ':' + "未找到与该组装工序关联的装配明细!", "messageRed");
                        $("#txtSN").val("");
                        $("#txtSN").focus();
                        return false;
                    }
                    //执行主序列号相关业务流程
                    assyDataProcess();
                }
            }
            $("#txtSN").val("");
            $("#txtSN").focus();
        }

        /*
        *执行主序列号相关业务流程
        */
        function mainProcess() {
            $("#hdnCurrSerialNumber").val("");
            //1.获取当前的一些工序信息
            resourceId = $("#hdnCurrResourceId").val();
            stationId = $("#hdnCurrStationId").val();

            var scanSN = $.trim($("#txtSN").val()); //扫描Sn

            //验证主条码信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId);
            if (ajax.error != null) {
                updateCollectionList(scanSN, 'NG', 1);
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }

            updateCollectionList($("#txtSN").val(), 'OK', 1);
            showAreaMessge($("#txtSN").val() + ':验证通过！请扫描部件条码！', "messageGreen");
            //setMessageBox($("#txtSN").val() + '验证通过', 'messageGreen');
            updateAssembleDetail(scanSN); //加载装配列表
            IsMainSN = false;
            $("#hdnCurrSerialNumber").val(scanSN);
            refreshProInfoBySN(scanSN);
            //自动打印 updata huangliang 2017-11-20
            AutoPrint(stationId, scanSN);

            $("#txtSN").val("").focus();
        }

        /*
        *执行组装相关业务流程
        */
        function assyDataProcess() {
            //**开始对投入SN进行验证
            //1.获取当前的一些工序信息

            resourceId = $("#hdnCurrResourceId").val();
            stationId = $("#hdnCurrStationId").val();
            var scanSN = $.trim($("#txtSN").val()); //扫描Sn

            var bindedSN = $("#hdnCurrSerialNumber").val(); //被绑定对象

            //如果没有绑定的sn，则返回错误提示，要求用户重新扫描SN
            if (bindedSN.length == 0) {
                alert("请先扫描主序列号！");
                $("#txtSN").val("");
                $("#txtSN").focus();
                return;
            }
            //2.开始对当前sn进行校验及执行activity
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.AssyDataActivity(scanSN, bindedSN, stationId, resourceId);
            if (ajax.error != null) {
                if (ajax.error.Message == "OFFLINESN") {
                    //验证失败
                    //验证离线条码
                    if (checkOfflineSN(scanSN)) {
                        updateCollectionList($("#txtSN").val(), 'NG', 1);
                        showAreaMessge($("#txtSN").val() + ':未找到条码信息！' , "messageRed");
                    }
                }
                else {
                    updateCollectionList($("#txtSN").val(), 'NG', 1);
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");

                }
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            $("#hdnIsAssScan").val(1);
            updateCollectionList($("#txtSN").val(), 'OK', 1);
            showAreaMessge($("#txtSN").val() + ':部件装配成功', "messageGreen");
            isClick = 0;
            //判断是否需要加载数据采集窗口
            showDetail(scanSN);

            //刷新装配列表
            updateAssembleDetail(bindedSN);
            $('#hdnCurrAssyData').val(scanSN);
            $("#txtSN").val("").focus();
        }

        /**
        *更新装配明细信息
        */
        function updateAssembleDetail(sn, isClick) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.GetAssembleList(sn, $("#hdnCurrStationId").val());
            if (ajax.error != null) {
                alert(ajax.error.Messsage);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, sn, ajax.error.Message);
                return false;
            }

            ajax = ajax.value;

            var childnodes = ajax[0];
            childnodes = jQuery.parseJSON(childnodes);
            $.each(childnodes, function () {
                this.ChildNodes = jQuery.parseJSON(this.ChildNodes);
            });

            if (childnodes.length == 0) {
                if (IsMainSN) {
                    showAreaMessge(sn + ':' + "未找到与该组装工序关联的装配明细!", "messageRed");
                    isScan = false;
                    return false;
                }
                showDetail(sn);
                $('#btnRefreshSN').show();
                return false;
            }
            var data = [
                {
                    id: '1',
                    text: ajax[2],
                    hasChildren: true,
                    isexpand: true,
                    ChildNodes: childnodes
                }
            ];


            $('#packingTree').treeview({
                data: data,
                onnodeclick: function (e) { treeNodeClick(e); },
                emptyiconpath: '../Content/plugin/treeview/images/s.gif'
            });

            $('#dsreflinfobasal').text("SN:" + sn);
            if (isClick != 1) {
                $('#labscancentertitle').text(ajax[1]);
            }
            $('#btnRefreshSN').show();
            setTimeout(function () {
                $(".bbit-tree-node-anchor span").each(function () {
                    if ($.trim(this.innerHTML) == $("#hdnCurrAssyData").val()) {
                        $(this).css("font-weight", "bolder");
                    }
                });
            }, 100);

            // 如果产品装配完成
            if ($.trim(ajax[1]) == "" && isClick != 1) {
                //如果首次扫描主件就已完成装配 ，则为批量返工时没有进行组装打散。直接进行SN过站操作,离线条码组装时也会使用此功能过站
                if ($("#hdnIsAssScan").val() == "0") {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.UnitComplete(sn,stationId,resourceId, true);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, sn, ajax.error.Message);
                        return false;
                    }
                }
                refreshSN(1);
                refreshProInfoBySN(sn);
                showAreaMessge(sn + ':装配成功！', "messageGreen");
                setMessageBox(sn + '装配成功', 'messageGreen');
            }
        }

        /*
        *树形节点单击事件
        */
        function treeNodeClick(e) {
            //这里需要判断用户选中的是扫描的序列号还是产品code--这边定义0开头的都属于扫描的sn
            if (e.id.substring(0, 1) === '0') {
                //$('#hdnCurrAssyData').val(e.text);
                showDetail(e.text);
                //这里暂时不考虑当用户选中该assydata后，扫描提示的一个信息显示改变问题

            }
        }

        /*
        *刷新界面，以扫描新的sn：用于当前组装进行到一半时，切换新条码的扫描动作
        */
        function refreshSN(flag) {
            if (flag != 1) {
                $('#packingTree').html("");
                $('#btnRefreshSN').hide();
                $("#activeinfoarea").val("");
                $('#dsreflinfobasal').text("SN:");
            }            
            $('#labscancentertitle').text('<%=Resources.lang.AC_OBA_ScanSN %>');    
            $("#txtSN").focus();            
            $("#hdnIsAssScan").val(0);
            IsMainSN = true;
        }

        /*
        *判断是否需要加载数据采集窗口
        */
        function isShowDetail(assySN) {
            var isShow = false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.GetAssyDataDetailInfo(assySN, "");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, assySN, ajax.error.Message);
                return false;
            }
            if (ajax.value != null && ajax.value.length > 0) {
                isShow = true;
            }
            return isShow;
        }

        /*
        *弹框让用户扫描数据类型字段
        */
        function showDetail(assySN) {
            var mainSN = $("#hdnCurrSerialNumber").val();
            if (isShowDetail(assySN) && mainSN != "") {
                dialog({ title: '组件相关数据采集', src: webroot + "/Client/CollectAssyMatInfo.aspx?SN=" + assySN + "&MainSN=" + mainSN + "&rnd=" + Math.random(), width: 450, height: 300 });
            }
        }

        function closeDetail() {
            closeDialog();
            $("#txtSN").focus();
        }

        function checkOfflineSN(offlineSN) {

            //1、验证SN是否为在线条码
            var ajax_SNInfo = SKT.LeanMES.Web.AjaxServices.AjaxClientController.GetUnitInfo(offlineSN);
            if (ajax_SNInfo.error != null) {
                alert(ajax_SNInfo.error.Message);
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, offlineSN, ajax_SNInfo.error.Message);
                return false;
            }
            if (ajax_SNInfo.value != null && ajax_SNInfo.value.UnitId > 0) {
                //为在线条码
                return true;
            }

            //2、验证条码是否已经被其他的组件绑定
            //检测当前离线条码是否已经被组装
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.CheckOfflineSNIsAssy(offlineSN);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, offlineSN, ajax.error.Message);
                return false;
            }
            if (ajax.value == true) {
                showAreaMessge(offlineSN + ":离线条码部件已被组装在主件上！", "messageRed");
                $("#txtSN").val("");
                $("#txtSN").focus();
                updateCollectionList(offlineSN, 'NG', 1);
                return false;
            }
            //3、带出相关的组装离线条码规则
            var mainSN = $("#hdnCurrSerialNumber").val();
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.GetOfflineSNConfig(mainSN, stationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtSN").val("");
                $("#txtSN").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, mainSN, ajax.error.Message);
                return false;
            }
            var list = {};
            list = ajax.value

            if (list == null || list.length == 0) {
                return true;
            }
            else {
                var isValid = true;
                for (var i = 0; i < list.length; i++) {
                    if (list[i].RegularExpression != "") {
                        var regularArr = list[i].RegularExpression.split(';');
                        var reg;
                        if (regularArr != undefined && regularArr.length > 0) {
                            for (var j = 0; j < regularArr.length; j++) {
                                if (regularArr[j] != "") {
                                    reg = new RegExp(regularArr[j]);
                                    if (!reg.test(offlineSN)) {
                                        isValid = false;
                                    }
                                    else {
                                        isValid = true;
                                        break;
                                    }
                                }
                            }
                            if (isValid) {
                                var entity = {};
                                entity.PartItemId = list[i].PartItemId;
                                entity.PartSN = offlineSN;
                                entity.StationId = list[i].StationId;
                                entity.OfflineSNConfigId = list[i].OfflineSNConfigId;

                                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.OfflineSNDetailEditAssy(mainSN, stationId, resourceId, entity);
                                if (ajax.error != null) {
                                    alert(ajax.error.Message);
                                    //写入日志
                                    SaveUserUILog("一般", stationId, resourceId, mainSN, ajax.error.Message);
                                    return false;
                                }
                                isClick = 0;
                                $("#hdnIsAssScan").val(0);
                                showAreaMessge(offlineSN + ":离线条码部件组装成功！", "messageGreen");
                                updateCollectionList(offlineSN, 'OK', 1);
                                //刷新装配列表
                                updateAssembleDetail(mainSN);
                                $('#hdnCurrAssyData').val(offlineSN);
                                return false;
                            }
                        }

                    }
                }

                if (!isValid) {
                    showAreaMessge(offlineSN + ":不符合离线条码规则或当前部件已满足主件所需数量！", "messageRed");
                    updateCollectionList(offlineSN, 'NG', 1);
                    return false;
                }
                return true;
            }
        }   
    </script>
</asp:Content>
