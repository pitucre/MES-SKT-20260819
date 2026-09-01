<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="CommonProCollectionCheckRepair.aspx.cs" Inherits="SKT.LeanMES.Web.Client.CommonProCollectionCheckRepair" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style type="text/css">
        table {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px !important;
            color: #1d1007;
        }

        .ui-title {
            line-height: 30px;
        }

        .td1 {
            text-align: right;
            font-size: 14px;
            font-weight: bold;
            width: 6%;
            line-height: 32px;
        }

        .td2 {
            text-align: left;
            font-size: 14px;
            color: blue;
            width: 8%;
        }

        .td3 {
            text-align: left;
            font-size: 14px;
            color: red;
            width: 20%;
            line-height: 32px;
        }

        input[type=radio] {
            cursor: pointer
        }

        .heightColor {
            background-color: antiquewhite;
        }
    </style>
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle" style="float: left;">
                            <%=Resources.lang.AC_OBA_ScanSN %></span><div id="divCurrentWeight" style="padding: 18px 0px 0px; font-size: 14px; margin-left: 40px; float: left; display: none;">当前重量：<span id="lblCurrentWeight" style="font-weight: bold;">0</span> 称重状态：<span id="lblCurrentState" style="font-weight: bold;"></span></div>
                        &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                        </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" style="width: 90%" />
                        <input type="button" value="提 交" onclick="SumSend()" style="height: 40px; background-repeat: round; width: 100px; font-size: 18px;" />

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
                <tr>
                    <td colspan="2" style="text-align: center; color: #3e9c3e"><span id="printMessage"></span></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td class="td1">条码编码：</td>
                    <td id="lblItemCode" class="td2"></td>
                    <td class="td1 BoxSN" style="display: none">包装箱号：</td>
                    <td id="lblBoxSN" style="display: none" class="td2 BoxSN"></td>
                    <td class="td1">条码数量：</td>
                    <td id="lblQty" style="text-align: left; font-size: 14px; color: blue; width: 3%"></td>
                    <td class="td1">不合格描述：</td>
                    <td id="lblNcDesc" class="td3"></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td id="Fashion" align="center" style="font-size: 14px;"></td>
                    <td align="left" colspan="5">
                        <div style="font-size: 14px;">
                            扫描不良条码：<input type="text" id="txtLotSN" class="scan-center-sn" style="width: 50%; height: 30px; line-height: 30px;" />
                        </div>
                        <div id="divLotSNMsg" style="color: green; font-weight: bold; margin-top: 3px;"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table width="99%" class="ListTable">
                            <thead>
                                <tr class="ListTableHeader">
                                    <th>SN</th>
                                    <th>数量</th>
                                    <th>判定 <a href="#" style="color: blue; cursor: pointer;" onclick="BacthCheck(1)">批量合格</a> <a href="#" onclick="BacthCheck(0)" style="color: red; cursor: pointer;">批量不合格</a></th>
                                    <th>不良数</th>
                                </tr>
                            </thead>
                            <tbody id="scanIfo">
                                <tr class="ListTableOddRow">
                                    <td colspan="4" align="center" valign="middle">暂无数据</td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" width="99%">
                <tr>
                    <td class="td1">AGV托运：</td>
                    <td class="td2">
                        <input type="radio" name="IsTy" value="1" />是    
               <input type="radio" name="IsTy" value="0" checked="checked" />否</td>
                    <td class="td1">托运类型：</td>
                    <td class="td2">
                        <input type="radio" name="IsTcType" value="1" checked="checked" />台车   
               <input type="radio" name="IsTcType" value="2" />托盘</td>
                    <td class="td1">运送区域：</td>
                    <td class="td2">
                        <input type="radio" name="IsYsQy" value="1" checked="checked" />立体仓   
               <input type="radio" name="IsYsQy" value="3" />暂存区 
               <input type="radio" name="IsYsQy" value="2" />待检区 </td>
                </tr>
                <tr>
                    <td class="td1">起点位置：</td>
                    <td class="td2">
                        <input id="txtStatrAgv" style="line-height: 28px; width: 90%; font-size: 14px;" /></td>
                    <td class="td1">目标点位：</td>
                    <td class="td2">
                        <input id="txtAgvEnd" readonly="readonly" style="line-height: 28px; width: 90%; font-size: 14px;" /></td>
                    <td class="td1"></td>
                    <td class="td2"></td>
                </tr>
            </table>
        </div>

        <!--数据分析统计展示及操作区-->
        <%--   <div id="datastatistic" class="data-statistic">
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
                   
                </tr>
            </table>
        </div>--%>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>

    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.ElectronicEquipment.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        $(document).ready(function () {
            //初始化称重插件
            /*  initElectronic();*/
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('Common_ProCollectionUI_CheckRepair');
                    $("#txtSN").select();
                },
                10
            );

            $('input[name="checkResult"]').change(function () {
                if ($(this).val() == 0) {
                    $("input[name='IsYsQy'][value='2']").attr('checked', 'true');
                } else {
                    $("input[name='IsYsQy'][value='1']").attr('checked', 'true');
                }
            });


            //货架扫描绑定事件
            $("#txtStatrAgv").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {

                    var grn = $.trim($("#txtStatrAgv").val());
                    if (grn == "") {
                        showAreaMessge("请扫描起点地标码!", "messageRed");
                        $("#txtStatrAgv").val("").focus().select();
                        return false;
                    }
                    var AgvCheckType = $('input[name="IsTcType"]:checked').val();
                    var AgvTransportType = $('input[name="IsYsQy"]:checked').val();
                    var entity = {};
                    entity.AgvCheckType = AgvCheckType;
                    entity.AgvTransportType = AgvTransportType;
                    entity.AGVCode = grn;
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckAvgCpInStockStart", JSON.stringify(entity));
                    if (ajax.error != null) {
                        showAreaMessge(ajax.error.Message, "messageRed");
                        $("#txtStatrAgv").val("").focus().select();
                        return false;
                    }
                    if (JSON.parse(ajax.value).data[0].AGVLandMarkCode != '') {
                        $("#txtAgvEnd").val(JSON.parse(ajax.value).data[0].AGVLandMarkCode);
                    }
                }
            });

            $("#txtLotSN").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var ncSN = $(this).val();
                    $("#scanIfo tr").removeClass("heightColor");
                    $("#scanIfo tr").each(function (i) {
                        var sn = $(this).find("td:eq(0)").text();
                        if (sn == ncSN) {
                            $("input[name='IsCheckResult" + i + "'][value='0']").attr('checked', 'true');
                            $(this).find("td:eq(3)").find('input').focus().select();
                            $(this).addClass("heightColor");
                        }
                    });

                }
            });
            isByPass = 1;
        });

        function BacthCheck(type) {
            $("#scanIfo tr").each(function (i) {
                $("input[name='IsCheckResult" + i + "'][value='" + type + "']").attr('checked', 'true');
            });
        }

        function loadScanInfo(list) {
            var html = "";
            $("#scanIfo").html("");
            for (var i = 0; i < list.length; i++) {
                html += "<tr class='" + (i % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow") + "'><td align=\"center\"  valign=\"middle\">" + list[i].SN + "</td><td align=\"center\"  valign=\"middle\">" + list[i].BatchQty + "</td><td align=\"center\"  valign=\"middle\"> <input type=\"radio\" name=\"IsCheckResult" + i + "\" value=\"1\" />合格 ";
                html += "<input type = \"radio\" name = \"IsCheckResult" + i + "\" value = \"0\"  /> 不合格</td><td align=\"center\"  valign=\"middle\"><input style=\"line-height:28px;width:90%; font-size:14px;\"/></td></tr>";
            }
            $("#scanIfo").append(html);
        }


        function afterScan() {
            if ($("#txtSN").val() != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
                }
                //1.获取当前基本信息                 
                var resourceId = $("#hdnCurrResourceId").val(); //资源Id
                var stationId = $("#hdnCurrStationId").val(); //工位Id
                var scanSN = $.trim($("#txtSN").val()); //扫描Sn

                if (!stationId > 0) {
                    alert("请先在操作菜单列表进行切换工位操作！");
                    return;
                }
                //2.开始对当前sn进行校验及执行activity**********待确定流程
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.CheckRepairSN(scanSN, stationId, resourceId);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }

                debugger;
                //带出条码编码与数量 
                var entity = {};
                entity.SerialNumber = scanSN;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetCollectionCheckRepairBySN", JSON.stringify(entity));
                if (ajax.error != null) {

                    $("#txtSN").val("").focus();
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }
                var jsonValue = JSON.parse(ajax.value);
                var list = jsonValue.data;
                if (list.length > 0) {
                    if (list[0].BoxSN != '') {
                        $(".BoxSN").show();
                        $("#lblBoxSN").html(list[0].BoxSN);
                    } else {
                        $(".BoxSN").hide();
                    }
                    $("#lblItemCode").html(list[0].ItemCode);
                    $("#lblQty").html(list[0].SNqty);
                    $("#lblNcDesc").html(list[0].NcDesc);
                }
                loadScanInfo(jsonValue.data1);
                $("#txtSN").val("");
                ////称重检验
                //checkWeight(scanSN, 1, function (isOK) {
                //    if (!isOK)
                //        return false;

                //    //过站操作
                //    ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.UnitComplete(scanSN, stationId, resourceId, true);
                //    if (ajax.error != null) {
                //        updateCollectionList(scanSN, 'NG');
                //        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                //        $("#txtSN").val("").focus();
                //        //写入日志
                //        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                //        return false;
                //    }
                //    else if (ajax.json == undefined) {
                //        showAreaMessge(scanSN + '：' + "未接收到系统返回信息，请检查是否登录已超时或网络中断！", "messageRed");
                //        $("#txtSN").val("");
                //        $("#txtSN").focus();
                //        return false;
                //    }
                //    updateCollectionList($("#txtSN").val(), 'OK');
                //    setMessageBox($("#txtSN").val() + ':通过', "messageGreen");
                //    showAreaMessge($("#txtSN").val() + ':通过 ！' + (prodWeight > 0 ? "当前产品重量为：" + prodWeight + " " + units : ""), 'messageGreen');
                //    //根据SN刷新侧边栏动态信息
                //    refreshProInfoBySN(scanSN);
                //    //自动打印 updata huangliang 2017-11-20
                //    if (AutoPrint(stationId, scanSN, true)) {
                //        $("#printMessage").text("条码【" + scanSN + "】打印成功");
                //    }

                //    $("#txtSN").val("");
                //});
            }
        }


        function SumSend() {
            $("#scanIfo tr").removeClass("heightColor");
            var isOk = true;
            var CheckXML = "<Root>"
            $("#scanIfo tr").each(function (i) {
                var sn = $(this).find("td:eq(0)").text();
                var bachQty = $(this).find("td:eq(1)").text();
                var isCheckResult = $(this).find("td:eq(2)").find('input[name="IsCheckResult' + i + '"]:checked').val();
                if (isCheckResult == undefined) {
                    showAreaMessge("请判定SN[" + sn + "]", "messageRed");
                    $(this).addClass("heightColor");
                    isOk = false;
                    return false;
                }
                var ncQty = $.trim($(this).find("td:eq(3)").find('input').val());
                ncQty = ncQty == "" ? 0 : ncQty;


                if (isCheckResult == 0) {
                    if (!checkNumber(ncQty)) {
                        showAreaMessge("不良数请输入正确数字！", "messageRed");
                        $(this).addClass("heightColor");
                        $(this).find("td:eq(3)").find('input').focus().select();
                        isOk = false;
                        return false;
                    }
                    if (ncQty == "") {
                        showAreaMessge("请输入SN[" + sn + "]不良数！", "messageRed");
                        $(this).addClass("heightColor");
                        $(this).find("td:eq(3)").find('input').focus().select();
                        isOk = false;
                        return false;
                    }
                    if (bachQty < ncQty || ncQty <= 0) {
                        showAreaMessge("SN[" + sn + "]不良数不能大于批次数或小于等于0！", "messageRed");
                        $(this).addClass("heightColor");
                        isOk = false;
                        return false;
                    }
                } else {
                    ncQty = 0;
                }
                CheckXML += "<Repair SN='" + sn + "' CheckResult='" + isCheckResult + "' NcQty='" + ncQty + "'></Repair>"

            });
            CheckXML += "</Root>"
            if (isOk) {
                var scanSN = $("#lblItemCode").html();
                if (scanSN == "") {
                    showAreaMessge("请扫描条码！", "messageRed");
                    return false;
                }
                var resourceId = $("#hdnCurrResourceId").val(); //资源Id
                var stationId = $("#hdnCurrStationId").val(); //工位Id
                if (!stationId > 0) {
                    alert("请先在操作菜单列表进行切换工位操作！");
                    return;
                }

                //2.开始对当前sn进行校验及执行activity**********待确定流程
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.CheckRepairSN(scanSN, stationId, resourceId);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }
                var entity = {};
                entity.OpenId = stationId;
                entity.ResId = resourceId;
                entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
                entity.CheckXML = CheckXML;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("usptCollectionCheckRepairPass", JSON.stringify(entity));
                if (ajax.error != null) {

                    $("#txtSN").val("").focus();
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                    return false;
                }

                var isTy = $('input[name="IsTy"]:checked').val();  //是否托运  
                if (isTy == 1) {

                    var txtStatrAgv = $.trim($("#txtStatrAgv").val());
                    if (txtStatrAgv == "") {
                        showAreaMessge("起点AGV地标码不能为空！", "messageRed");
                        $("#txtStatrAgv").val("").focus().select();
                        return false;
                    }
                    var txEndtAgv = $.trim($("#txtAgvEnd").val());
                    if (txEndtAgv == "") {
                        showAreaMessge("终点AGV地标码不能为空！", "messageRed");
                        $("#txtAgvEnd").val("").focus().select();
                        return false;
                    }
                    if (txtStatrAgv === txEndtAgv) {
                        showAreaMessge("起点终点不可相同！", "messageRed");
                        $("#txtAgvEnd").val("").focus().select();
                        return false;
                    }

                    var AgvCheckType = $('input[name="IsTcType"]:checked').val();
                    var AgvTransportType = $('input[name="IsYsQy"]:checked').val();
                    if (AgvTransportType == 1) {
                        AgvTransportType = "立体库";
                    } else if (AgvTransportType == 3) {
                        AgvTransportType = "暂存区";
                    } else if (AgvTransportType == 2) {
                        AgvTransportType = "待检区";
                    }

                    var uniqueCode = AgvCheckType == 1 ? "X" : "T" + generateUniqueCode();
                    let req =
                    {
                        "msgType": "creatTask",
                        "taskEnd": txEndtAgv,
                        "taskID": uniqueCode,
                        "taskStart": txtStatrAgv
                    }
                    let reqUrl = 'http://172.16.15.216:9123/agvs'
                    //发送agv指令，然后保存数据到数据库
                    let listStr = "";
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.SendAgv(req, reqUrl, listStr, "不良品维修检验", AgvCheckType == 1 ? "台车" : "托盘", AgvTransportType);
                    if (ajax.error != null) {
                        showAreaMessge('AGV任务号：' + uniqueCode + ':发送失败：' + ajax.error.Message, "messageRed");
                        return false;
                    }
                    showAreaMessge('AGV任务号：' + uniqueCode + ':发送成功！', 'messageGreen');
                }

                clear();
                refreshProInfoBySN(scanSN);
                showAreaMessge(scanSN + ':通过 ！', 'messageGreen');
            }

        }

        function checkNumber(theObj) {
            var reg = /^[0-9]+.?[0-9]*$/;
            if (reg.test(theObj)) {
                return true;
            }
            return false;
        }

        function clear() {
            $("#lblItemCode").html("");
            $("#lblQty").html("");
            $("#lblNcDesc").html("");
            $("#lblBoxSN").html("");
            $("#scanIfo").html('<tr class="ListTableOddRow"><td colspan="4" align="center" valign="middle">暂无数据</td></tr>');

        }

        function generateUniqueCode() {
            // 获取当前时间戳
            const timestamp = Date.now().toString();
            // 生成一个随机数
            const randomNumber = Math.random().toString().slice(2, 10);
            // 返回时间戳和随机数的组合
            return timestamp + randomNumber;
        }

    </script>
</asp:Content>
