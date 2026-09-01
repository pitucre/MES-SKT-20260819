<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="OfflineSNInput.aspx.cs" Inherits="SKT.LeanMES.Web.Client.OfflineSNInput" %>

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
                                部件条码采集列表
                            </div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 100px;">序号
                                        </th>
                                        <th style="width: 150px;">条码类型
                                        </th>
                                        <th style="width: 100px;">数量
                                        </th>
                                        <th style="width: 250px;">部件条码
                                        </th>
                                        <th>已扫描条码
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlistOffline">
                                    <tr>
                                        <td colspan="5" class="ListTableOddRow">暂无条码数据
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        var totalCount = 0; //需组装总量        
        var assyArr = [];
        var scanSN;
        var routeId = -1;
        var prodOrderId = -1;
        var resourceId = -1;
        var stationId = -1;
        var fistScanSN = "";

        $(document).ready(function () {
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('OfflineSNInput');
                },
                10
            );

            //投入过站必须选择工单后才可以进行扫描动作
            $("#txtSN").attr("disabled", "disabled");
            SelectProOrder();
        });

        function afterScan() {
            if ($("#txtSN").val() != "") {               
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
                //1.获取当前基本信息              
                resourceId = $("#hdnCurrResourceId").val(); //资源Id
                stationId = $("#hdnCurrStationId").val(); //工位Id
                scanSN = $.trim($("#txtSN").val()); //扫描Sn

                if (!stationId > 0) {
                    alert("请先在操作菜单列表进行切换工位操作！");
                    return;
                }
                
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.GetInputOfflineSNConfig(scanSN, stationId, resourceId, prodOrderId);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ":" + ajax.error.Message, "messageRed");
                    assyArr = [];
                    totalCount = 0;
                    $("#collectionlistOffline").html("<tr><td colspan='5' class='ListTableOddRow'>暂无条码数据</td></tr>");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    setTimeout(function () {
                        $("#txtSN").val("").focus();
                    }, 100);
                    return false;
                }
                
                var isPassStation = 0;
                assyArr = [];
                if (ajax.value != null && ajax.value.length > 0) {
                    isPassStation = ajax.value[0].IsPassStation;
                    if (isPassStation) {
                        showAreaMessge(scanSN + ":过站成功！，请扫描下一个SN条码！", "messageGreen");
                        setTimeout(function () {
                            $("#txtSN").val("").focus();
                        }, 100);
                        return;
                    }
                    showAreaMessge(scanSN + ":验证通过，请扫描部件条码！", "messageGreen");
                    $("#txtSN").val("");

                    fistScanSN = scanSN;                    

                    loadOfflineSNInfo(ajax);
                }
                else {
                    $("#txtSN").val('').focus();
                    showAreaMessge(scanSN+":未找到当前工序需要采集的部件条码信息！", "messageRed");
                    $("#collectionlistOffline").html("<tr><td colspan='5' class='ListTableOddRow'>暂无条码数据</td></tr>");
                }
            }
        }

        /**
        *加载需采集的部件条码类型
        **/
        function loadOfflineSNInfo(list) {
            var offlineSNArr = [];
            offlineSNArr = list.value;
            if (offlineSNArr != null && offlineSNArr.length > 0) {
                totalCount = 0;
                var control = $("#collectionlistOffline");
                control.empty();
                var regularExpression = "";
                var partItemId = -1;
                var partStationId = -1;
                var offlineSNConfigId = -1;
                var html = '';
                var partType = '';

                for (var i = 0; i < offlineSNArr.length; i++) {
                    entity = offlineSNArr[i];
                    totalCount = totalCount + parseInt(entity.AssemblyQty)
                    regularExpression = (entity.RegularExpression);
                    partItemId = entity.PartItemId;
                    partStationId = entity.StationId;
                    offlineSNConfigId = entity.OfflineSNConfigId;
                    partType = entity.PartType;
                    html = '<tr class="';
                    if (i % 2 == 0) {
                        html += 'ListTableOddRow';
                    } else {
                        html += 'ListTableEvenRow';
                    }
                    html += '">';
                    html += ''
              + '<td align="center" valign="middle">' + (i + 1) + '</td>'
              + '<td align="center" valign="middle">' + entity.MaskGroup + '</td>'
              + '<td align="center" valign="middle">' + entity.AssemblyQty + '</td>'
              + '<td align="center" valign="middle"><input type="text" name="txtOfflineSN"  style="height:22px; width:95%;" onkeydown="checkOfflineSN(this);" /><input type="hidden" name="hidRegExp" value=' + regularExpression + '><input type="hidden" name="hidPartItemId" value=' + partItemId + '> <input type="hidden" name="hidPartStationId" value=' + partStationId + '> <input type="hidden" name="hidOfflineSNConfigId" value=' + offlineSNConfigId + '> <input type="hidden" name="hidPartType" value=' + partType + '></td>'
              + '<td align="center" valign="middle" ><span style="line-height:20px;" name="lblOfflineSN"></span></td>'
              + '</tr>';
                    control.append(html);
                }

                if (offlineSNArr.length > 0) {
                    $("#collectionlistOffline").find("input[name=txtOfflineSN]").eq(0).focus();
                }
            }            
        }

        /**
        *检测所扫描的部件条码
        **/
        function checkOfflineSN(obj) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey === 13) {
                var assemblyQty = 0; //需组装的部件条码数量
                var assySN = $.trim(obj.value);
                var isValid = true;
                if (assySN == "") {
                    return false;
                }

                assemblyQty = $.trim($(obj).parent().prev().html());
                var partType = ($(obj).parent().find("input[name=hidPartType]").val());

                if (partType == 'DEFT' || partType == 'DEFAULT') {
                    var regular = ($(obj).parent().find("input[name=hidRegExp]").val());
                    if (regular != undefined && regular != "") {
                        var regularArr = regular.split(';');
                        var reg;
                        if (regularArr != undefined && regularArr.length > 0) {
                            for (var i = 0; i < regularArr.length; i++) {
                                if (regularArr[i] != "") {
                                    reg = new RegExp(regularArr[i]);
                                    if (!reg.test(assySN)) {
                                        showAreaMessge(assySN + ":不符合部件条码规则！请重新扫描SN条码！", "messageRed");
                                        //$(obj).val("");
                                        Empty();//清空部件条码采集列表
                                        isValid = false;
                                        return false;
                                    }
                                    else {
                                        isValid = true;
                                    }
                                }
                            }
                        }
                    }
                    else {
                        showAreaMessge(assySN + ":未找到有效的掩码规则！请重新扫描SN条码！", "messageRed");
                        Empty();//清空部件条码采集列表
                        return false;
                    }
                }

                if (!isValid) {
                    return false;
                }
                else {
                    var partItemId = ($(obj).parent().find("input[name=hidPartItemId]").val());
                    var offlineSNObj = $(obj).parent().next().find("span[name=lblOfflineSN]");
                    var partStationId = ($(obj).parent().find("input[name=hidPartStationId]").val());
                    var offlineSNConfigId = ($(obj).parent().find("input[name=hidOfflineSNConfigId]").val());
                    var offlineSN = offlineSNObj.html();
                    var offlineSNQty = (offlineSN.split("<br>").length); //已扫描的部件条码数量                     
                    var preQty = (parseInt(assemblyQty) - parseInt(offlineSNQty)); //剩余需组装数量
                    var isExist = false;
                    var entity = {};
                    $("span[name=lblAssySN]").each(function (i, assyObj) {
                        if (assyObj.innerText == assySN) {
                            showAreaMessge(assySN + ":部件条码已存在列表中,请勿重复扫描！请重新扫描SN条码！", "messageRed");
                            //$(obj).val("");
                            Empty();//清空部件条码采集列表
                            isExist = true;
                            return false;
                        }
                    });

                    if (isExist) {
                        return false;
                    }
                    //检测当前部件条码是否已经被组装
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.CheckInputOfflineSN(assySN, stationId, resourceId, prodOrderId, partType, fistScanSN);
                    if (ajax.error != null) {
                        showAreaMessge(assySN + ":" + ajax.error.Message + " 请重新扫描SN条码！", "messageRed");
                        //$(obj).select();
                        Empty();//清空部件条码采集列表
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, assySN, ajax.error.Message);
                        return false;
                    }

                    if (preQty == 0) {
                        $(obj).parent().parent().next().find("input").eq(0).focus();
                        $(obj).attr("disabled", "disabled");
                    }

                    if (offlineSN != "") {
                        offlineSNObj.html(offlineSN + "<span name='lblAssySN'>" + obj.value + "</span><span style='cursor:pointer; margin-left:4px;color:red;' onclick='delOfflineSN(this)'><img src='../Content/images/icon/close.gif' alt='X' /><br></span>");
                    }
                    else {
                        offlineSNObj.html("<span name='lblAssySN'>" + obj.value + "</span><span  style='cursor:pointer; margin-left:4px;color:red;' onclick='delOfflineSN(this)'><img src='../Content/images/icon/close.gif' alt='X' /><br></span>");
                    }
                    $(obj).val("");


                    entity.PartItemId = partItemId;
                    entity.PartSN = assySN;
                    entity.StationId = partStationId;
                    entity.OfflineSNConfigId = offlineSNConfigId;
                    assyArr.push(entity);
                                       
                    if (assyArr.length == totalCount) {
                        var partSNStr = "";

                        for (var k = 0; k < totalCount; k++) {
                            partSNStr += assyArr[k].PartSN + "/";
                        }

                        partSNStr = (partSNStr.substr(0, partSNStr.length - 1));
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.OfflineSNDetailEdit(scanSN, stationId, resourceId, assyArr);
                        if (ajax.error != null) {
                            showAreaMessge(assySN + ":" + ajax.error.Message, "messageRed");
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
                        showAreaMessge(scanSN + ":部件条码[" + partSNStr + "]组装完成！", "messageGreen");
                        $("#txtSN").val('').focus();
                        assyArr = [];
                        totalCount = 0;
                        fistScanSN = "";
                        $("#collectionlistOffline").html("<tr><td colspan='5' class='ListTableOddRow'>暂无条码数据</td></tr>");
                    }
                }
            }
        }

        /**
        *处理删除部件条码
        **/
        function delOfflineSN(obj) {
            $(obj).parent().parent().prev().find("input[type=text]").removeAttr("disabled").focus();
            assyArr.splice($.inArray($(obj).prev().text(), assyArr), 1);
            $(obj).prev().remove();
            $(obj).remove();
        }

        /**
       *选择工单
       */
        function SelectProOrder() {
            chooseFlag = 1;
            //var searchCondition = "1=1"; // "Status=1"; 
            var searchCondition = "";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&CallBackFunc=getProOrderValue&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /**
        *返回值
        */
        function getProOrderValue(list) {

            if (chooseFlag == 1) {
                //---选择工单后动作：1、路由获取；2、相关动态信息获取；3、根据当前工序及路由获取前后工序信息并回显
                $("#hdnCurrProOrderId").val(list[0][0]);
                prodOrderId = list[0][0];
                //1、获取路由
                var routeId = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetRouteIdByProOrderId(list[0][0]);
                if (routeId.error != null) {
                    alert(routeId.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", routeId.error.Message);
                    return false;
                }
                var routeId = routeId.value;

                if (routeId === "-1") {
                    //获取路由失败
                    alert("Error:" + "<%=Resources.Messages.CreateSN_Router_Invalid %>");
                    return false;
                } else {

                    //获取路由成功
                    $("#hdnCurrRouteId").val(routeId);
                    $("#txtSN").removeAttr("disabled");
                }
                //2、相关动态信息获取
                refreshProInfoByProOrderId(list[0][0]);

                //3、根据当前工序及路由获取前后工序信息并回显
                stationRefresh();

                //end、重新绘制窗口
                setContentHeight();
                setLeftMenuHeight();
                setActiveInfoHeight();


            }
            chooseFlag = 0;
            //焦点
            setTimeout(
                function () {
                    $("#txtSN").focus();
                },
                10
            );
        }

        //扫描出错时，清空部件条码采集列表
        function Empty() {
            fistScanSN = "";
            scanSN = "";
            totalCount = 0;
            assyArr = [];
            $("#collectionlistOffline").html("<tr><td colspan='5' class='ListTableOddRow'>暂无条码数据</td></tr>");
            $("#txtSN").val("").focus();
        }

    </script>
</asp:Content>
