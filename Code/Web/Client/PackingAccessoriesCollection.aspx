<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="PackingAccessoriesCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PackingAccessoriesCollection" %>

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
                            <%=Resources.lang.AC_OBA_ScanSN %></span> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right" style="padding-right: 20px; width:100px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" />
                    </td>
                </tr>
                <tr>
                   <%-- <td align="left">
                       
                    </td>--%>
                    <td align="left" colspan="2"> 
                        <table style="float:left;">
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
                        <table  style="float:right;">
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
                                包装附件采集列表
                            </div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 100px;">序号
                                        </th>
                                        <th style="width: 150px;">附件名称
                                        </th>
                                        <th style="width: 100px;">数量
                                        </th>
                                        <th style="width: 250px;">附件条码
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
            <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        var totalCount = 0; //需组装总量        
        var assyArr = [];
        var scanSN;
        var stationId;
        var resourceId;
        $(document).ready(function () {
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('OfflineSNCollection');
                },
                10
            );
            //1.获取当前基本信息              
            resourceId = $("#hdnCurrResourceId").val(); //资源Id
            stationId = $("#hdnCurrStationId").val(); //工位Id
            if (!stationId > 0) {
                alert("请先在操作菜单列表进行切换工位操作！");
                return;
            }
        });

        function afterScan() {
            if ($("#txtSN").val() != "") {               
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }

                scanSN = $.trim($("#txtSN").val()); //扫描Sn

                //验证主条码流程信息

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ":" + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    $("#txtSN").val("").focus();
                    return false;
                }
                assyArr = [];
                showAreaMessge(scanSN + ':通过', "messageGreen");

                //根据SN刷新侧边栏动态信息
                refreshProInfoBySN(scanSN);

                ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPackingAccessoriesConfig(scanSN, stationId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }
                $("#txtSN").val("");
                loadOfflineSNInfo(ajax);
                setActiveInfoHeight();
            }
        }

        /**
        *加载需采集的离线条码类型
        **/
        function loadOfflineSNInfo(list) {
            var accessoriesArr = [];
            accessoriesArr = list.value;
            if (accessoriesArr != null && accessoriesArr.length > 0) {
                var control = $("#collectionlistOffline");
                control.empty();
                var regularExpression = "";
                var itemId = -1;
                var partStationId = -1;
                var packingAccessoriesConfigId = -1;
                var html = '';

                for (var i = 0; i < accessoriesArr.length; i++) {
                    entity = accessoriesArr[i];
                    totalCount = totalCount + parseInt(entity.AccessoriesQty)
                    regularExpression = (entity.RegularExpression);
                    itemId = entity.ItemId;
                    partStationId = entity.StationId;
                    packingAccessoriesConfigId = entity.PackingAccessoriesConfigId;
                    CheckType = entity.CheckType;
                    MaskId = entity.MaskId;
                    html = '<tr class="';
                    if (i % 2 == 0) {
                        html += 'ListTableOddRow';
                    } else {
                        html += 'ListTableEvenRow';
                    }
                    html += '">';
                    html += ''
              + '<td align="center" valign="middle">' + (i + 1) + '</td>'
              + '<td align="center" valign="middle">' + entity.AccessoriesName + '</td>'
              + '<td align="center" valign="middle">' + entity.AccessoriesQty + '</td>'
              + '<td align="center" valign="middle"><input type="text" name="txtOfflineSN"  style="height:22px; width:95%;" onkeydown="checkOfflineSN(this);" /><input type="hidden" name="hidRegExp" value=' + regularExpression + '><input type="hidden" name="hidPartItemId" value=' + itemId + '> <input type="hidden" name="hidPartStationId" value=' + partStationId + '> <input type="hidden" name="hidOfflineSNConfigId" value=' + packingAccessoriesConfigId + '><input type="hidden" name="hidCheckType" value=' + CheckType + '><input type="hidden" name="hidMaskId" value=' + MaskId + '> </td>'
              + '<td align="center" valign="middle" ><span style="line-height:20px;" name="lblOfflineSN"></span></td>'
              + '</tr>';
                    control.append(html);
                }

                if (accessoriesArr.length > 0) {
                    $("#collectionlistOffline").find("input[name=txtOfflineSN]").eq(0).focus();
                }
            }
            else {
                $("#txtSN").val('').focus();
                showAreaMessge("未找到与当前工序相关的离线条码类型！", "messageRed");
                $("#collectionlistOffline").html("<tr><td colspan='5' class='ListTableOddRow'></td></tr>");
            }
        }

        /**
        *检测所扫描的离线条码
        **/
        function checkOfflineSN(obj) {            
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey === 13) {
                var assemblyQty = 0; //需组装的离线条码数量
                var assySN = $.trim(obj.value);
                var isValid;
                if (assySN == "") {
                    return false;
                }

                assemblyQty = $.trim($(obj).parent().prev().html());
                var checkType = ($(obj).parent().find("input[name=hidCheckType]").val());
                if (checkType == 1) {
                    var regular = ($(obj).parent().find("input[name=hidRegExp]").val());
                    if (regular != undefined && regular != "") {
                        var regularArr = regular.split(';');
                        var reg;
                        if (regularArr != undefined && regularArr.length > 0) {
                            for (var i = 0; i < regularArr.length; i++) {
                                if (regularArr[i] != "") {
                                    reg = new RegExp(regularArr[i]);
                                    if (!reg.test(assySN)) {
                                        showAreaMessge(assySN + ":不符合离线条码规则！", "messageRed");
                                        $(obj).val("");
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
                        showAreaMessge(assySN + ":未找到有效的掩码规则！", "messageRed");
                        return false;
                    }
                } else if (checkType == 2) {
                    var itemId = ($(obj).parent().find("input[name=hidPartItemId]").val());
                    var maskId = ($(obj).parent().find("input[name=hidMaskId]").val());

                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetofflineCheck(scanSN, assySN, itemId, checkType, maskId);
                    if (ajax.error != null) {
                        setMessageBox(ajax.error.Message, "messageRed");
                        showAreaMessge(ajax.error.Message, "messageRed");
                        $(obj).select();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        isValid = false;
                        return false;
                    } else {
                        isValid = true;
                    }
                } else if (checkType == 3) {

                    var maskId = ($(obj).parent().find("input[name=hidMaskId]").val());

                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPartsOfflineSNCheck(scanSN, assySN, maskId);
                    if (ajax.error != null) {
                        setMessageBox(ajax.error.Message, "messageRed");
                        showAreaMessge(ajax.error.Message, "messageRed");
                        $(obj).select();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        isValid = false;
                        return false;
                    } else {
                        isValid = true;
                    }
                }

                if (!isValid) {
                    return false;
                }
                else {
                    var partItemId = ($(obj).parent().find("input[name=hidPartItemId]").val());
                    var offlineSNObj = $(obj).parent().next().find("span[name=lblOfflineSN]");
                    var partStationId = ($(obj).parent().find("input[name=hidPartStationId]").val());
                    var packingAccessoriesConfigId = ($(obj).parent().find("input[name=hidOfflineSNConfigId]").val());
                    var offlineSN = offlineSNObj.html();
                    var offlineSNQty = (offlineSN.split("<br>").length); //已扫描的离线条码数量                     
                    var preQty = (parseInt(assemblyQty) - parseInt(offlineSNQty)); //剩余需组装数量
                    var isExist = false;
                    var entity = {};
                    //$("span[name=lblAssySN]").each(function (i, assyObj) {
                    //    if (assyObj.innerText == assySN) {
                    //        showAreaMessge(assySN + ":包装附件条码已存在列表中,请勿重复扫描！", "messageRed");
                    //        $(obj).val("");
                    //        isExist = true;
                    //        return false;
                    //    }
                    //});

                    if (isExist) {
                        return false;
                    }
                    //检测当前离线条码是否已经被组装
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CheckIsCollectAccessoriesSN(assySN);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, assySN, ajax.error.Message);
                        return false;
                    }
                    if (ajax.value == true) {
                        showAreaMessge(assySN + ":包装附件条码已被采集到其他产品！", "messageRed");
                        $(obj).val("");
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


                    entity.ItemId = partItemId;
                    entity.AccessoriesSN = assySN;
                    entity.StationId = partStationId;
                    entity.PackingAccessoriesConfigId = packingAccessoriesConfigId;
                    assyArr.push(entity);

                    if (assyArr.length == totalCount) {
                        var partSNStr = "";

                        for (var k = 0; k < totalCount; k++) {
                            partSNStr += assyArr[k].AccessoriesSN + "/";
                        }

                        partSNStr = (partSNStr.substr(0, partSNStr.length - 1));

                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.PackingAccessoriesDetailEdit(scanSN, stationId, resourceId, assyArr);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            //写入日志
                            SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                            return false;
                        }
                        showAreaMessge(scanSN + ":包装附件条码[" + partSNStr + "]采集完成！", "messageGreen");
                        $("#txtSN").val('').focus();
                        assyArr = [];
                        totalCount = 0;
                        $("#collectionlistOffline").html("<tr><td colspan='5' class='ListTableOddRow'>暂无条码数据</td></tr>");
                        setActiveInfoHeight();
                        //根据SN刷新侧边栏动态信息
                        refreshProInfoBySN(scanSN);
                    }
                }
            }
        }

        /**
        *处理删除离线条码
        **/
        function delOfflineSN(obj) {
            $(obj).parent().parent().prev().find("input[type=text]").removeAttr("disabled").focus();
            assyArr.splice($.inArray($(obj).prev().text(), assyArr), 1);
            $(obj).prev().remove();
            $(obj).remove();
        }
    </script>
</asp:Content>
