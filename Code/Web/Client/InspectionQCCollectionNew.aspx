<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="InspectionQCCollectionNew.aspx.cs" Inherits="SKT.LeanMES.Web.Client.InspectionQCCollectionNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        #layermsg { position: absolute; left: 50%; top: 50%; width: 500px; height: 200px; margin-left: -250px; margin-top: -100px; display: none; z-index: 999; background-color: White; }

        #layerImport { position: absolute; left: 50%; top: 50%; width: 900px; height: 500px; margin-left: -450px; margin-top: -250px; display: none; z-index: 999; background-color: White; border: 1px solid #ccc; padding: 2px; }

        #layerImportEdit { position: absolute; left: 50%; top: 50%; width: 450px; height: 250px; margin-left: -450px; margin-top: -250px; display: none; z-index: 999; background-color: White; border: 1px solid #ccc; padding: 2px; }

        #layer { background-color: #F1F3F8; left: 0; opacity: 0.9; position: absolute; top: 0; z-index: 3; filter: alpha(opacity=90); -moz-opacity: 0.9; -khtml-opacity: 0.9; display: none; z-index: 100; }

        #divClose { color: #fff; width: 15px; background: red; text-align: center; cursor: pointer; position: absolute; right: 10px; top: 10px; }
    </style>    
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js?v=20211209"></script>
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">请扫描SN/包装箱/栈板条码</span> &nbsp;&nbsp;&nbsp;&nbsp;<div
                            id="messageBox">
                        </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <input type="text" id="txtSNNew" class="scan-center-sn" style="height: 35px; line-height: 35px;" />
                    </td>
                    <td align="center">
                        <input type="button" value=" 锁 定 " id="btnLock" onclick="inspectionLock(0)" />
                        <input type="button" value=" Pass " id="btnPass" onclick="pass(0)" />
                        <input type="button" value=" Reject " id="btnReject" onclick="reject()" />
                        <input type="button" value=" 强制通过 " id="btnPersonPass" onclick="pass(2)" />
                        <input type="button" value=" 提前录入 " id="btnPreImport" onclick="preImport()" />
                        <input type="button" value=" 切 入 " id="btnImport" onclick="importItem()" />
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
            <div style="font-size: 14px; border: 1px solid #D3D3D3; line-height: 30px; margin: 0px 0px 5px 0px;">
                &nbsp;批号：<span id="lblLotNo" style="font-weight: bold;"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产品编码：<span
                    id="lblItemCode" style="font-weight: bold;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;已送检数量：<span
                        id="lblInspectionQty" style="font-weight: bold;"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：<span
                            id="lblStatus" style="font-weight: bold;"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前检验SN：<span
                                id="lblSN" style="font-weight: bold;"></span>
            </div>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" id="inspectionMemberTb"
                style="display: none;">
                <tr>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table cellpadding="0" cellspacing="0" border="0" class="ListTable" id="inspectionMemberItemTb">
                            <thead>
                                <tr class="ListTableHeader">
                                    <th style="width: 70px;"></th>
                                    <th>检验水平
                                    </th>
                                    <th>AQL
                                    </th>
                                    <th>应抽数量
                                    </th>
                                    <th>已抽数量
                                    </th>
                                    <th>判断标准
                                    </th>
                                    <th>已抽不良
                                    </th>
                                    <th>检验模板名称
                                    </th>
                                    <th style="width: 249px">检验项名称
                                    </th>
                                    <th>录入方式
                                    </th>
                                    <th style="width: 150px">判定标准
                                    </th>
                                    <th style="width: 50px">单位
                                    </th>
                                    <th>检验方法
                                    </th>
                                    <th>结果
                                    </th>
                                </tr>
                            </thead>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td valign="bottom">
                        <div style="font-size: 14px;">
                            &nbsp;包装信息：
                        </div>
                    </td>
                    <td id="Fashion" align="center" style="font-size: 14px;"></td>
                    <td align="left">
                        <div style="font-size: 14px;">
                            扫描序号：<input type="text" id="txtLotSN" class="scan-center-sn" style="width: 50%; height: 30px; line-height: 30px;" />
                        </div>
                        <div id="divLotSNMsg" style="color: green; font-weight: bold; margin-top: 3px;"></div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; vertical-align: top;">
                        <div style="height: 200px; overflow: auto;">
                            <table id="packSNTb" cellpadding="0" cellspacing="0" border="0" class="ListTable"
                                style="min-width: 200px;">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th>包装箱/栈板条码
                                        </th>
                                        <th style="width: 60px;">数量
                                        </th>
                                        <th style="width: 30px;"></th>
                                    </tr>
                                </thead>
                                <tr class="ListTableOddRow">
                                    <td align="center" colspan="3">暂无数据
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td style="vertical-align: top;" align="right" colspan="2">
                        <div style="height: 200px; overflow: auto;">
                            <table class="ListTable" id="inspectionMemberItemSNTb" style="width: 99%;">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th>序号
                                        </th>
                                        <th>检验项
                                        </th>
                                        <th>扫描序号
                                        </th>
                                        <th>客户号码
                                        </th>
                                        <th>判定标准
                                        </th>
                                        <th>检验值
                                        </th>
                                        <th width="60px;">结果
                                        </th>
                                        <th>不良代码
                                        </th>
                                        <th width="140px;">采集日期
                                        </th>
                                        <th width="60px;">操作
                                        </th>
                                    </tr>
                                    <tr class="ListTableOddRow">
                                        <td align="center" colspan="10">暂无数据
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="layer">
    </div>
    <div id="layermsg">
        <div id='divClose' title='关闭'>
            X
        </div>
        <div style="width: 500px; height: 200px;">
            <table class="EditeContentTable" id="Table1" style="width: 100%;">
                <tr style="height: 30px;">
                    <td colspan="2"></td>
                </tr>
                <tr style="height: 160px;">
                    <td class="Label1">回流工序
                    </td>
                    <td class="Field1">
                        <select id="ddlStation">
                        </select>

                    </td>
                </tr>
                <tr style="height: 40px;">
                    <td class="Label1"></td>
                    <td class="Field1">&nbsp;&nbsp;<input type="button" value=" 确 定 " id="btnComfirm" onclick="rejectConfirm()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
                        type="button" id="btnCancle" value=" 取 消 " />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="layerImport">
        <div id='divClose' title='关闭'>
            X
        </div>
        <div style="width: 900px; height: 600px;">
            <table class="EditeContentTable" id="Table2" style="width: 100%;">
                <tr>
                    <td class="Label3">产品代码
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtItemName" runat="server" Enabled="false" ClientIDMode="Static"
                            Width="64%" Height="26px">
                        </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(1);" />
                        <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                    <td class="Label3">导入类型
                    </td>
                    <td class="Field3">
                        <select id="sltImport">
                            <option value="0">未导入</option>
                            <option value="1">已导入</option>
                        </select>
                        &nbsp;<input type="button" value=" 查 询 " onclick="loadpreImport()" />
                    </td>
                </tr>
                <tr>
                    <td class="Field3" colspan="3">&nbsp;&nbsp;序&nbsp;号&nbsp;<input type="text" id="txtPreImport" class="scan-center-sn" style="height: 26px; line-height: 26px; width: 300px;" />&nbsp;&nbsp;<input type="button" value=" 输 入 " onclick="afterScanPreImport()" />
                        <span style="display:none;">&nbsp;&nbsp;&nbsp;&nbsp;总数量：<span id="lblTotalQty"></span> &nbsp;, 不良数量：<span id="lblNGQty"></span></span>
                    </td>
                    <td class="Field3" id="PreFashion" align="center" style="font-size: 14px;"></td>
                </tr>
            </table>
            <div style="margin-top: 3px; overflow: auto; width: 900px; height: 225px;">
                <table cellpadding="0" cellspacing="0" border="0" class="ListTable" id="inspectionTemplateImportTb">
                    <tr class="ListTableHeader">
                        <th style="width: 70px;"></th>
                        <th>检验模板名称
                        </th>
                        <th style="width: 249px">检验项名称
                        </th>
                        <th>录入方式
                        </th>
                        <th style="width: 150px">判定标准
                        </th>
                        <th style="width: 50px">单位
                        </th>
                        <th>检验方法
                        </th>
                        <th>是否检验
                        </th>
                    </tr>
                    <tr class="ListTableOddRow">
                        <td align="center" colspan="9">暂无数据</td>
                    </tr>
                </table>
            </div>
            <div style="margin-top: 3px; overflow: auto; width: 900px; height: 225px;">
                <table cellpadding="0" cellspacing="0" border="0" class="ListTable" id="inspecImportTb">
                    <tr class="ListTableHeader">
                        <th>产品代码
                        </th>
                        <th>序号
                        </th>
                        <th>检验项
                        </th>
                        <th>客户号码
                        </th>
                        <th>结果
                        </th>
                        <th>不良代码
                        </th>
                        <th>扫描人员
                        </th>
                        <th>扫描日期
                        </th>
                        <th>导入日期
                        </th>
                    </tr>
                    <tr class="ListTableOddRow">
                        <td align="center" colspan="9">暂无数据</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div id="layerImportEdit">
        <div style="margin-top: 3px; overflow: auto; width: 450px; height: 110px;">
            <table cellpadding="0" cellspacing="0" border="0" class="ListTable" id="inspecImportTbEdit">
            </table>
        </div>
    </div>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/js/skt.common.js"></script>
    <script language="javascript" type="text/javascript">
        var inspectionLotId = 0;
        var inspectionLotMemberId = 0;
        var isNCCode = 0;
        var sn = "";//扫描SN
        var ContainerSN = "";//包装SN
        var ContainerSNCount = 0;//包装SN数
        var Presn = "";//提前录入SN
        var resourceId;
        var stationId
        var ncCodeArr = [];
        var packingDataArr = [];
        var inspectionMemberSNArr = [];
        var type = 0;//类型 0：非提前录入UI  1：提前录入UI
        var ncCodes = "";//不良代码，多个用逗号隔开
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"

        $(document).ready(function () {
            //权限加载
            loadPermissions();
            setTimeout(
                function () {
                    //扫描框获取焦点
                    $("#txtSNNew").focus();
                },
                10
            );
            //添加强制大写选择框处理
            $("#txtSNNew").css("text-transform", "uppercase");
            $("#cbxforceuppercase").click(function () {
                if (this.checked) {
                    $("#txtSNNew").css("text-transform", "uppercase");
                    $("#txtSNNew").val($.trim($("#txtSNNew").val()).toUpperCase());
                }
                else {
                    $("#txtSNNew").css("text-transform", "none");
                }
            });
            $("#txtSNNew").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    afterScan();
                }
                if (curKey == 46) {
                    $("#txtSNNew").val("");
                }
            });


            //1.获取当前基本信息

            resourceId = $("#hdnCurrResourceId").val(); //资源Id
            stationId = $("#hdnCurrStationId").val(); //工位Id
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('InspectionQCNEW_ProCollectionUI');
                },
                10
            );

            //扫描框回车事件
            $("#txtLotSN").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;

                    if (curKey == 13) {
                        type = 0;//非提前录入
                        var val = $.trim($(this).val());
                        if (val == "") {
                            alert("请输入SN");
                            $(this).focus();
                            return;
                        }
                        $("#lblSN").html($("#txtLotSN").val());//记录当前检验SN

                        //校验是否有录入结果或者选择OK/NG
                        if ($("#Fashion input[type='radio']").val() != null) {
                            if ($("#cbNG:checked").val() != null && ncCodes == "") {
                                alert("请选择不良代码");
                                $(this).select();
                                return;
                            }
                        } else {
                            var value = $.trim($("#txtvalue").val());
                            if (value == "") {
                                alert("检验值不能为空");
                                $("#txtvalue").focus();
                                return;
                            }
                            if (!count() && ncCodes == "") {
                                alert("请选择不良代码");
                                $("#txtvalue").focus();
                                return;
                            }
                        } 

                        $("#txtLotSN").attr("disabled", "disabled");

                        //校验SN
                        SaveSnInspectionInfo(ncCodes);

                        $("#txtLotSN").removeAttr("disabled");

                        //return false;
                        //afterScanLotSN();
                        //return false;
                    }
                    if (curKey == 46) {
                        $("#txtLotSN").val("");
                    }
                });

            //扫描框回车事件
            $("#txtPreImport").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    afterScanPreImport();
                }
                if (curKey == 46) {
                    $("#txtPreImport").val("").focus();
                }
            });

            /*提前录入操作*/
            //动态绑定radio点击事件
            $(document).on("click", "#PreFashion input[type='radio']", function () {
                afterScanPreImport_NEW();
            });
            //检验值输入
            $(document).on("keydown", "#txtprevalue", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    afterScanPreImport_NEW();
                    //return false;
                }
            });

            /*正常操作录入*/
            //动态绑定radio点击事件
            $(document).on("click", "#Fashion input[type='radio']", function () {
                afterScanLotSN();
            });
            //检验值输入
            $(document).on("keydown", "#txtvalue", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    afterScanLotSN();
                    //return false;
                }
            });
        });

        function afterScan() {

            if ($("#txtSNNew").val() != "") {
                //**开始对投入SN进行验证
                if ($("#cbxforceuppercase").prop("checked")) {
                    $("#txtSNNew").val($.trim($("#txtSNNew").val()).toUpperCase());
                }

                /*如果SN条码有包装成箱，扫描单个SN条码系统需要带出整箱明细  add snake.lu 2023年12月2日14:06:22*/
                var info = { ScanSN: $.trim($("#txtSNNew").val()) };
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetSNToPackInfo", JSON.stringify(info));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtSNNew").val("");
                    $("#txtSNNew").focus();
                    return false;
                }
                var list = JSON.parse(ajax.value);
                var listOrder = list.data;
                var mySN = listOrder[0].SN;

                var scanSN = mySN;

                //扫描SN检查是否存在包装SN与检验批次的关系，有则带出
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionInfoByPackSN2(inspectionLotId, scanSN, stationId, resourceId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtSNNew").val("");
                    $("#txtSNNew").focus();
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    return false;
                }
                var entity = ajax.value;
                inspectionLotId = entity.InspectionLotId;

                if (entity.PackingDataList != null) {
                    for (var i = 0; i < entity.PackingDataList.length; i++) {
                        var exsit = false;
                        for (var j = 0; j < packingDataArr.length; j++) {
                            if (entity.PackingDataList[i].SerialNumber == packingDataArr[j].SerialNumber) {
                                exsit = true;
                                break;
                            }
                        }
                        if (!exsit) packingDataArr.push(entity.PackingDataList[i]);
                    }
                }

                if ($.trim(entity.InspectionLotNo) != "") {
                    $("#btnLock").attr("disabled", "disabled");
                    //加载AQL规则,OQC检验项
                    inspectionLock(0);
                }
                $("#lblLotNo").text(entity.InspectionLotNo);
                $("#lblItemCode").text(entity.ItemCode);
                $("#lblInspectionQty").text(entity.LotQty);
                $("#lblStatus").text(entity.State);
                //查询包装SN信息

                var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetPackSNByInspectionLotId(inspectionLotId, 1);
                if (ajaxPack.error != null) {
                    alert(ajaxPack.error.Message);
                    $("#txtSNNew").val("");
                    $("#txtSNNew").focus();
                    SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                    return false;
                }
                $("#packSNTb  tr:not(:first)").remove();
                loadPackInfo(ajaxPack.value, $.trim(entity.InspectionLotNo));
            }
            $("#txtSNNew").val("");
        }

        function loadPackInfo(list, lotNo) {
            var row, cell;
            var setTable = document.getElementById("packSNTb");
            if (list == null || list == undefined) {
                return;
            }
            if (list[0].SN != null && list[0].SN != "") {
                refreshProInfoBySN(list[0].SN);
            }
            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = entity.PackSN;

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.Quantity;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = lotNo == "" ? "<img name='imgPackSN' src='../Content/images/icon/close.gif' onclick=delPackSN('" + entity.PackSN + "','" + entity.Quantity + "') style='cursor:pointer;' title='点击将会删除采集的栈板/包装箱' alt='X' />" : "";


            }
        }

        /**
       *  未锁定前可以删除已扫描的包装箱、栈板信息
       **/
        function delPackSN(packsn, packqty) {
            if (confirm("确认删除当前扫描的包装箱/栈板条码[" + packsn + "]?")) {
                $("#packSNTb tr td").each(function (i, obj) {
                    if (obj.innerHTML == packsn) {
                        $(obj).parent().remove();
                        var inspectionQty = parseFloat($("#lblInspectionQty").text());
                        $("#lblInspectionQty").text(inspectionQty - parseFloat(packqty));
                    }
                });
                var delLotId = false;//是否删除已扫描的抽检批次ID

                if ($("#packSNTb tr").length == 1) {
                    delLotId = true;
                    $("#lblItemCode,#lblInspectionQty,#lblStatus,#lblSN").text("");
                    clearTable("packSNTb", 3);
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.DelPackSN(packsn, inspectionLotId, delLotId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#txtSNNew").val("");
                    $("#txtSNNew").focus();
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    return false;
                }

                if (delLotId == true) {
                    inspectionLotId = 0;
                }
            }
        }


        /**
        *  加载AQL规则,OQC检验项
        **/
        function inspectionLock(flag) {
            if (inspectionLotId <= 0) {
                alert("请扫描包装/栈板条码！");
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                return false;
            }
            var qcType = 5; //检验类型： 1、IQC  2、IPQC 3、PQC  4、FQC 5、OQC
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionMemberByLotId(inspectionLotId, 2, qcType);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            loadInspectionMemberInfo(ajaxPack.value);

            if (flag == 0) {//首次加载
                inspectionLotMemberId = ($("#inspectionMemberItemTb tr:eq(1) td:eq(0) input[type=checkbox]").val());
                $("#inspectionMemberItemTb tr:eq(1) td:eq(0) input[type=checkbox]").prop("checked", "checked");
                $("#inspectionMemberItemTb tr:eq(1)").css("background-color", "yellow");
                inspectionMemberCheck($("input[name='InspectionMemberId']:checked").get(0));
                //getInspectionMemberSNInfo();
            }
            else {
                $("#inspectionMemberItemTb tr  td input[type=checkbox]").each(function (i, obj) {
                    if (inspectionLotMemberId == $(obj).val()) {
                        i = i + 1;
                        $("#inspectionMemberItemTb tr:eq(" + i + ") td:eq(0) input[type=checkbox]").prop("checked", "checked");
                        $("#inspectionMemberItemTb tr:eq(" + i + ")").css("background-color", "yellow");
                    }
                });
            }

            getInspectionLotInfo();

            if (flag == 0) {
                $("img[name=imgPackSN]").hide();
            }

            $("#txtSNNew").attr("disabled", "disabled");
            $("#txtLotSN").val("").focus();
            $("#inspectionMemberTb").show();

        }
        /**
        *  OQC检验项详情
        **/
        function loadInspectionMemberInfo(list) {
            var row, cell;
            var setTable = document.getElementById("inspectionMemberItemTb");
            if (list == null || list == undefined) {
                return;
            }
            $("#inspectionMemberItemTb  tr:not(:first)").remove();
            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);
                $(row).click(function () {
                    $(this).find("td:eq(0) input").click();
                });
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = "<input type='checkbox' id='" + entity.Reserve + "' style='height:15px;width:15px;' onclick='inspectionMemberCheck(this)' name='InspectionMemberId' value='" + entity.InspectionLotMemberId + "' />";
                //cell.innerHTML = "<input type='checkbox' style='height:15px;width:15px;' onclick='inspectionMemberCheck(this)' name='InspectionMemberId' value='" + entity.InspectionLotMemberId + "' />";

                //cell = row.insertCell(1);
                //cell.align = "center";
                //cell.innerHTML = entity.AQLSampleName;

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.AQLLevel;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = entity.AQLRule;

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = entity.InspectionQty;

                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = entity.ActualQty;

                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = entity.Judgment;

                cell = row.insertCell(6);
                cell.align = "center";
                cell.innerHTML = entity.NCCodeQty;

                //cell = row.insertCell(8);
                //cell.align = "center";
                //cell.innerHTML = entity.Result;

                //检验配置项

                cell = row.insertCell(7);
                cell.align = "center";
                cell.innerHTML = entity.InspectionTemplateName;

                cell = row.insertCell(8);
                cell.align = "center";
                cell.innerHTML = entity.InspectionName;

                cell = row.insertCell(9);
                cell.align = "center";
                cell.innerHTML = (entity.InspectionMethodId == 1 ? "固定值" : "指定值");

                cell = row.insertCell(10);
                cell.align = "center";
                cell.innerHTML = entity.InspectionMethodValue;

                cell = row.insertCell(11);
                cell.align = "center";
                cell.innerHTML = entity.UnitName;

                cell = row.insertCell(12);
                cell.align = "center";
                cell.innerHTML = entity.CheckFashion;

                cell = row.insertCell(13);
                cell.align = "center";
                cell.innerHTML = entity.Result;

                //cell = row.insertCell(14);
                //cell.align = "center";
                //cell.innerHTML = entity.InspectionMethodId == 1 ? "": "<input type='text' style='height: 24px;width:100px' />";
            }
        }
        /**
        *  OQC检验项详情By 提前录入 NEW
        **/
        function loadInspectionMemberInfoPre(list) {
            var row, cell;
            var setTable = document.getElementById("inspectionTemplateImportTb");
            if (list == null || list == undefined) {
                return;
            }
            $("#inspectionTemplateImportTb  tr:not(:first)").remove();
            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);

                $(row).click(function () {
                    $(this).find("td:eq(0) input").click();
                });
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = "<input type='checkbox' id='" + entity.InspectionItemId + "' style='height:15px;width:15px;' onclick='inspectionMemberCheckPre(this)' name='InspectionMemberId' value='" + entity.InspectionItemId + "' />";

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.InspectionTemplateName;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = entity.InspectionName;

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = (entity.InspectionMethodId == 1 ? "固定值" : "指定值");

                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = entity.InspectionMethodValue;

                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = entity.UnitName;

                cell = row.insertCell(6);
                cell.align = "center";
                cell.innerHTML = entity.CheckFashion;

                cell = row.insertCell(7);
                cell.align = "center";
                cell.innerHTML = entity.IsScan == 1 ? "已检验" : "未检验";

            }
            //默认选择第一条
            $("#inspectionTemplateImportTb  tr:eq(1)").css("background-color", "yellow").find("input[type='checkbox']").click();
        }
        /**
        *  【提前录入】点击检验项复选框查询SN
        **/
        function inspectionMemberCheckPre(obj) {
            var checkObj = $(obj);
            $("#inspectionTemplateImportTb tr td input[type=checkbox]").prop("checked", false);
            $("#inspectionTemplateImportTb tr:not(first)").css("background-color", "");
            checkObj.prop("checked", true);

            checkObj.parent().parent().css("background-color", "yellow");
            inspectionLotMemberId = checkObj.val();
            sn = "";
            isNCCode = 0;
            PreLoadFashion(Presn);
            //根据检验项获取提前录入的SN信息
            loadpreImport();
        }
        /**
        *  点击检验项复选框查询SN
        **/
        function inspectionMemberCheck(obj) {
            var checkObj = $(obj);
            $("#inspectionMemberItemTb tr td input[type=checkbox]").prop("checked", false);
            $("#inspectionMemberItemTb tr:not(first)").css("background-color", "");
            checkObj.prop("checked", true);

            //$("#txtLotSN").select().focus();
            checkObj.parent().parent().css("background-color", "yellow");
            inspectionLotMemberId = checkObj.val();
            sn = "";
            isNCCode = 0;
            LoadFashion();
            //$("#Fashion").html('');
            getInspectionMemberSNInfo();
            //$("#txtLotSN").focus();
        }

        /**
        *  加载SN信息
        **/
        function getInspectionMemberSNInfo() {
            ncCodes = "";
            //查询检验项下SN信息
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionLotSNInfo(inspectionLotMemberId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            loadInspectionMemberSNInfo(ajaxPack.value);
        }

        /**
        *  加载SN信息
        **/
        function loadInspectionMemberSNInfo(list) {
            var row, cell;
            var setTable = document.getElementById("inspectionMemberItemSNTb");
            $("#inspectionMemberItemSNTb  tr:not(:first)").remove();
            if (list == null || list == undefined) {
                row = setTable.insertRow(setTable.rows.length);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = "10";
                cell.innerHTML = "暂无数据"
                return;
            }

            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }
                if (entity.Result == "Reject") {
                    row.style.backgroundColor = "red";
                }

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = i + 1;

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.AQLSampleName

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = entity.SN;

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = entity.CustomerSN;

                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = entity.InspectionMethodValue;

                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = entity.Value;

                cell = row.insertCell(6);
                cell.align = "center";
                cell.innerHTML = entity.Result;

                cell = row.insertCell(7);
                cell.align = "center";
                cell.innerHTML = entity.NCCodes;

                cell = row.insertCell(8);
                cell.align = "center";
                cell.innerHTML = entity.CreateDateTime;

                cell = row.insertCell(9);
                cell.align = "center";
                cell.innerHTML = "<a href=\"#\" style='text-decoration:none;' onclick=\"DelInspectionMemberSN(" + inspectionLotMemberId + ",'" + entity.SN + "')\" >删除</a>";
            }
        }

        /**
        *删除已抽检的SN信息
        **/
        function DelInspectionMemberSN(lotMemberId, sn) {
            if (!confirm("是否确认删除条码[" + sn + "]的抽检信息？")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.DelInspectionLotMemberSN(lotMemberId, sn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            getInspectionMemberSNInfo();
            inspectionLock(1);
        }

        /**
        * 正常录入加载SN检验方式
        **/
        function LoadFashion() {
            $("#Fashion").html("");
            var nchtml = "&nbsp;&nbsp;<span id='ncCodeInfo' style='margin-left:30px; display:none'>不良代码：<label id='lblNcCode'></label></span>";
            var _obj = $("#inspectionMemberItemTb tr input[type='checkbox']:checked").parent().parent();
            var _InspectionMethodId = $(_obj).find("td:eq(9)").text();
            var h = "";
            if (_InspectionMethodId == "固定值") {
                h += "请输入结果 ：<label><input id='cbALLOK' type='radio'  title='结果OK通过所有检验项所有序号，当存在结果为NG不能使用ALL-OK' name='OkNgRa' value='ALLOK' checked='checked' />ALL-OK</label>&nbsp;&nbsp;"
                //+ "<label><input id='cbNG' type='radio' name='OkNgRa' value='NG'/>NG</label>";
                    + "<label><input id='cbNG' type='radio' name='OkNgRa' value='NG'/>NG</label>&nbsp;&nbsp;<label><input id='cbOK' type='radio' name='OkNgRa' value='OK'/>OK</label>";
                h += nchtml;
                $("#Fashion").html(h);
                $("#txtLotSN").focus();
            } else {
                h += "请输入结果并回车 ：<input type='text' id='txtvalue' style='height: 24px;width:100px' />";
                h += nchtml;
                $("#Fashion").html(h);
                $("#txtvalue").focus();
            }

        }
        /**
        * 提前录入加载SN检验方式
        **/
        function PreLoadFashion(sn) {
            //2.根据第一条检验项设置 是固定值输入还是指定值输入
            $("#PreFashion").html("");
            var _obj = $("#inspectionTemplateImportTb tr input[type='checkbox']:checked").parent().parent();
            var _InspectionMethodId = $(_obj).find("td:eq(3)").text();
            var h = "";
            if (_InspectionMethodId == "固定值") {
                h += "请输入结果 ：<label><input id='cbALLOK' type='radio'  title='结果OK通过所有检验项所有序号，当存在结果为NG不能使用ALL-OK' name='OkNgRaPre' value='ALLOK' checked='checked' />ALL-OK</label>&nbsp;&nbsp;"
                //+ "<label><input id='cbNG' type='radio' name='OkNgRaPre' value='NG'/>NG</label>";
                    + "<label><input id='cbNG' type='radio' name='OkNgRaPre' value='NG'/>NG</label>&nbsp;&nbsp;<label><input id='cbOK' type='radio' name='OkNgRaPre' value='OK'/>OK</label>";
                $("#PreFashion").html(h);
            } else {
                h += "请输入结果并回车 ：<input type='text' id='txtprevalue' style='height: 24px;width:100px' />";
                $("#PreFashion").html(h);
            }
            $("#txtprevalue").focus();

        }


        //var inspectionValue = "";//检验指定值时，录入的值

        /**
        *  SN扫描信息
        *  根据用户选择或者输入值 对SN进行判定
        **/
        function afterScanLotSN() {
            //if ($.trim($("#txtLotSN").val()) == "") {
            //    return;
            //}
            ncCodes = "";//重新选择了‘OK/NG’单选按钮或者输入了检验值后，设置不良代码为空

            var isNc = false;
            if ($("input[type='radio']").val() != null) {
                if ($("#cbNG:checked").val() != null) {
                    isNc = true;
                }
            } else {
                value = $.trim($("#txtvalue").val());
                if (value == "") {
                    alert("检验值不能为空");
                    $("#txtvalue").focus();
                    return false;
                }
                if (!count()) {
                    isNc = true;
                }
            }

            //弹出不良代码选择框
            if (isNc) {
                var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Client/InspectionNCCollection.aspx?name=InspectionNCCollection&stationId=" + stationId + "";
                dialog({ title: "不良代码", src: openWinUrl, width: 600, height: 400 });
                $("#ncCodeInfo").show();
            } else {
                //SaveSnInspectionInfo('');
                $("#ncCodeInfo").hide();
                $("#lblNcCode").html("");
                $("#txtLotSN").focus();
            }

            ////var currentSN = $.trim($("#txtLotSN").val());
            //var currentSN = $.trim($("#lblSN").html());
            //var ncArrStr = "";
            //var Value = "";
            //if ($("input[type='radio']").val() != null) {
            //    if ($("#cbNG:checked").val() != null) {
            //        ncArrStr = $("#inspectionMemberItemTb tr input[type='checkbox']:checked").parent().parent().find("input[type='checkbox']").attr('id');
            //    }
            //} else {
            //    Value = $.trim($("#txtvalue").val());
            //    if (Value == "") { alert("检验值不能为空"); return false; }
            //    if (!count()) {
            //        ncArrStr = $("#inspectionMemberItemTb tr input[type='checkbox']:checked").parent().parent().find("input[type='checkbox']").attr('id');
            //    }
            //}

            //var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotSNInfo(inspectionLotId, inspectionLotMemberId, currentSN, stationId, resourceId, ncArrStr, Value);
            //if (ajaxPack.error != null) {
            //    alert(ajaxPack.error.Message);
            //    $("#txtLotSN").val("").focus();
            //    $("#Fashion").html('');
            //    return false;
            //}
            //ncCodeArr = [];
            //getInspectionMemberSNInfo();
            //inspectionLock(1);
            //$("#Fashion").html("");

            //if ($("input[name='InspectionMemberId']:checked").parent().parent().next().length == 0) {
            //    //如果是最后一个检验项 光标跳转到SN文本框
            //    $("#txtPreImport").select().focus();
            //    $("input[name='InspectionMemberId']:eq(0)").click();
            //} else {
            //    //自动跳到下一个检验项
            //    $("input[name='InspectionMemberId']:checked").parent().parent().next().find('input[type="checkbox"]').click();
            //}
            //setTimeout(function () {
            //    $("#txtLotSN").val("").focus();
            //}, 1);
        }

        //QC页面回调函数
        function qcPageCallBack(arrNCCode) {
            if (arrNCCode == null || arrNCCode.length <= 0) {
                alert("未获取到不良代码");
                return;
            }
            //获取不良代码
            for (var i = 0; i < arrNCCode.length; i++) {
                ncCodes += i == 0 ? arrNCCode[i] : "," + arrNCCode[i];
            }
            closeDialog();
            if (type == 0) {
                //非提前录入
                //SaveSnInspectionInfo(ncCodes);
                $("#txtLotSN").focus();
                $("#lblNcCode").html(ncCodes);
            } else {
                //提前录入UI中的不良代码
                SaveSnInspectionInfoPre(1, ncCodes);
            }
        }

        //保存SN检验信息
        function SaveSnInspectionInfo(codes) {

            var value = "";
            var isall = false;
            value = $("input:radio[name='OkNgRa']:checked").val();
            if (value == "ALLOK")//全通过的时候
            {
                value = "OK";
                isall = true;
                //inspectionLotId---批次ID
                //全通过逻辑
                if (!ValidateSNOrSaveInspectionResultBatch(codes, 1)) {
                    return;
                }
            }
            else
            {
                //校验并保存
                if (!ValidateSNOrSaveInspectionResult(codes, 1)) {
                    return;
                }
            }
         

            ncCodeArr = [];
            getInspectionMemberSNInfo();
            inspectionLock(1);
            //默认选中第一个未检验
            var isFirst = false;
            $("#inspectionMemberItemTb tr:not(.ListTableHeader)").each(function (i, obj) {
                var inspectionStatus = $(obj).find("td:eq(13)").text();
                if (!inspectionStatus && !isFirst) {
                    $(obj).find("td:eq(0) input").click();
                    isFirst = true;
                }
            });
            if (!isFirst) {
                //如果都已经检验
                $("#txtLotSN").select().focus();
                $("input[name='InspectionMemberId']:eq(0)").click();
            }
        }

        //校验SN 或者 保存SN检验结果（flag:0 校验 1：保存及校验）
        function ValidateSNOrSaveInspectionResult(codes, flag) {
            var value = "";
            if (flag == 1) {
                if ($("input:radio[name='OkNgRa']:checked").length == 0) {
                    value = $.trim($("#txtvalue").val());
                } else {
                    value = $("input:radio[name='OkNgRa']:checked").val();
                }
            }
            if (value == "ALLOK")//全通过的时候
            {
                value = "OK";
            }
            var currentSN = $.trim($("#lblSN").html());
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotSNInfo(inspectionLotId, inspectionLotMemberId, currentSN, stationId, resourceId, codes, value, flag);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtLotSN").val("").focus();
                //$("#Fashion").html('');
                return false;
            }
            return true;
        }

        //全通过 OK 检验全通过 校验SN 或者 保存SN检验结果（flag:0 校验 1：保存及校验）
        function ValidateSNOrSaveInspectionResultBatch(codes, flag) {
            var value = "";
            if (flag == 1) {
                if ($("input:radio[name='OkNgRa']:checked").length == 0) {
                    value = $.trim($("#txtvalue").val());
                } else {
                    value = $("input:radio[name='OkNgRa']:checked").val();
                }
            }
            if (value == "ALLOK")//全通过的时候
            {
                value = "OK";
            }
            var currentSN = $.trim($("#lblSN").html());

            var inspectionLotMemberIds = [];
            $("#inspectionMemberItemTb tr input[type='checkbox']").parent().parent().each(function (i, obj) {
                if ($(obj).find("td:eq(9)").text() == "固定值") {
                    inspectionLotMemberIds.push($(obj).find("td:eq(0) input").val());
                }
            });

            //cs
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotSNInfoBatch(inspectionLotId, inspectionLotMemberIds.join(), currentSN, stationId, resourceId, codes, value, flag);

            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtLotSN").val("").focus();
                //$("#Fashion").html('');
                return false;
            }
            return true;
        }

        /**
        *  获取送检单信息
        **/
        function getInspectionLotInfo() {
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionInfoByLotId(inspectionLotId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            if (ajaxPack != null) {
                var entity = ajaxPack.value;
                $("#lblLotNo").text(entity.InspectionLotNo);
                $("#lblItemCode").text(entity.ItemCode);
                $("#lblInspectionQty").text(entity.LotQty);
                $("#lblStatus").text(entity.State);
            }
        }

        /**
        *通过检验
        **/
        function pass(passType) {
            var msg = passType == 0 ? "Pass" : "强制通过";
            if (confirm("是否确定进行[" + msg + "]操作?")) {
                if (inspectionLotId <= 0) {
                    alert("请扫描包装/栈板条码！");
                    $("#txtSNNew").val("");
                    $("#txtSNNew").focus();
                    return false;
                }
                var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotPass(inspectionLotId, passType, stationId, resourceId);
                if (ajaxPack.error != null) {
                    alert(ajaxPack.error.Message);
                    $("#txtLotSN").val("");
                    $("#txtLotSN").focus();
                    SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                    return false;
                }
                alert(msg + "操作成功！");
                sn = "";
                inspectionLotId = 0;
                inspectionLotMemberId = 0;
                $("#btnLock").attr("disabled", false);
                $("#inspectionMemberTb").hide();
                clearTable("inspectionMemberItemTb", 9);
                clearTable("packSNTb", 3);
                clearTable("inspectionMemberItemSNTb", 9);
                $("#txtSNNew").removeAttr("disabled");
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                $("#lblLotNo").text("");
                $("#lblItemCode").text("");
                $("#lblInspectionQty").text("");
                $("#lblStatus").text("");
                $("#lblSN").text("");
            }
        }

        /**
        *检验拒收
        **/
        function reject() {

            if (inspectionLotId <= 0) {
                alert("请扫描包装/栈板条码！");
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                return false;
            }
            else if ($("#lblLotNo").text() == "") {
                alert("未找到送检批次信息！");
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                return false;
            }
            if ($("#lblLotNo").text() != "") {
                loadRouter();
            }
            showPage("layermsg");
            return;
        }

        /**
        *显示相关功能窗口
        **/
        function showPage(pageContent) {
            var bodyheight = $("body").height();
            var bodywidth = $("body").width();

            $("#" + pageContent).show();
            $("#btnCancle,#divClose").bind("click", function () { $("#layer,#" + pageContent).hide(); });
            $("#layer").css({
                height: bodyheight,
                width: bodywidth,
                display: "block"
            });
        }

        /**
        *加载Reject操作时的路由工序信息
        **/
        function loadRouter() {
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionLotRouter(inspectionLotId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            $("#ddlStation").find("option").remove();
            var list = ajaxPack.value;
            if (list != null && list.length > 0) {
                $("#ddlStation").append("<option value='-1'>--请选择--</option>");
                for (var i = 0; i < list.length; i++) {
                    $("#ddlStation").append("<option value=" + list[i].StationId + ">" + list[i].Station + "</option>");
                }
            }
            else {
                $("#ddlStation").append("<option value='-1'>--请选择--</option>");
            }
        }

        /**
        *确定Reject操作
        **/
        function rejectConfirm() {
            var returnStationId = $("#ddlStation").val();
            if (returnStationId == -1) {
                alert("请选择回流工序！");
                $("#ddlStation").focus();
                return false;
            }
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotReject(inspectionLotId, stationId, returnStationId, resourceId);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }

            alert("Reject操作成功！");
            sn = "";
            inspectionLotId = 0;
            inspectionLotMemberId = 0;
            $("#btnLock").attr("disabled", false);
            $("#inspectionMemberTb").hide();
            clearTable("inspectionMemberItemTb", 9);
            clearTable("packSNTb", 3);
            clearTable("inspectionMemberItemSNTb", 9);
            $("#layermsg,#layer").hide();
            $("#txtSNNew").removeAttr("disabled");
            $("#txtSNNew").val("");
            $("#txtSNNew").focus();
            $("#lblLotNo").text("");
            $("#lblItemCode").text("");
            $("#lblInspectionQty").text("");
            $("#lblStatus").text("");
            $("#lblSN").text("");
        }

        ///提前录入 切入
        function afterScanPreImport_NEW() {
            var importSN = $.trim($("#txtPreImport").val());//SN
            //var aqlSampleId = $("#inspectionTemplateImportTb tr input:checked").val();  //检验项编码
            //var aqlSampleName = $("#inspectionTemplateImportTb tr input:checked").parent().parent().find("td:eq(2)").text();  //检验项名称
            if (importSN == "") {
                alert("请扫描序号条码！");
                $("#txtPreImport").focus();
                return false;
            }
            var value = "";//输入值
            var Result = 0;//输入结果
            if ($("input[type='radio']").val() != null) {
                if ($("#cbNG:checked").val() != null) {
                    //ncArrStr = $("#inspectionMemberItemTb tr input[type='checkbox']:checked").parent().parent().find("input[type='checkbox']").attr('id');
                    Result = 1;
                }
            } else {
                value = $.trim($("#txtprevalue").val());
                if (value == "") { alert("检验值不能为空"); return false; }
                if (!count()) {
                    //ncArrStr = $("#inspectionMemberItemTb tr input[type='checkbox']:checked").parent().parent().find("input[type='checkbox']").attr('id');
                    Result = 1;
                }
            }

            if (Result == 1) {
                var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Client/InspectionNCCollection.aspx?name=InspectionNCCollection&stationId=" + stationId + "";
                dialog({ title: "不良代码", src: openWinUrl, width: 600, height: 400 });
            } else {
                SaveSnInspectionInfoPre(Result, "");
            }
        }


        //保存提前录入页面检验SN信息
        function SaveSnInspectionInfoPre(Result, codes) {
            var importSN = $.trim($("#txtPreImport").val());//SN
            var aqlSampleId = $("#inspectionTemplateImportTb tr input:checked").val();  //检验项编码
            var aqlSampleName = $("#inspectionTemplateImportTb tr input:checked").parent().parent().find("td:eq(2)").text();  //检验项名称

            var value = "";
            if ($("input:radio[name='OkNgRaPre']:checked").length == 0) {
                value = $.trim($("#txtprevalue").val());
            } else {
                value = $("input:radio[name='OkNgRaPre']:checked").val();
            }
            var ajaxPack;
            var isAllOK = false;
            if (value == "ALLOK")//全通过时
            {
                isAllOK = true;
                value = "OK";
                var aqlSampleIds = [];
                var aqlSampleNames = [];
                $("#inspectionTemplateImportTb tr:not(.ListTableHeader)").each(function (i, obj) {
                    if ($(obj).find("td:eq(3)").text() == "固定值") {
                        aqlSampleIds.push($(obj).find("td:eq(0) input").val());
                        aqlSampleNames.push($(obj).find("td:eq(2)").text());
                    }
                });
                ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotRecordsPreBatch(importSN, aqlSampleIds.join(","), aqlSampleNames.join(","), value, Result, codes);
            }
            else {  //单个检验时
                ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotRecordsPre(importSN, aqlSampleId, aqlSampleName, value, Result, codes);
            }
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            loadpreImport();
            ncCodes = "";
            //修改为已校验
            if (isAllOK) {
                $("#inspectionTemplateImportTb tr:not(.ListTableHeader)").each(function (i, obj) {
                    if ($(obj).find("td:eq(3)").text() == "固定值") {
                        $(obj).find("td:eq(7)").html("已检验");
                    }
                });
            }
            else {
                $("input[name='InspectionMemberId']:checked").parent().parent().find("td:eq(7)").html("已检验");
            }
            //默认选中第一个未检验得指定值
            var isFirst = false;
            $("#inspectionTemplateImportTb tr:not(.ListTableHeader)").each(function (i, obj) {
                var inspectionStatus = $(obj).find("td:eq(7)").text();
                var inspectionMethod = $(obj).find("td:eq(3)").text();
                if (inspectionStatus != "已检验") {
                    if (!isFirst) {
                        $(obj).find("td:eq(0) input").click();
                        isFirst = true;
                    }
                }
            });
            if (!isFirst) {
                //如果都已经检验
                $("#txtPreImport").select().focus();
                $("input[name='InspectionMemberId']:eq(0)").click();
            }
        }

        /**
        *提前录入扫描
        **/
        function afterScanPreImport() {
            type = 1;//提前录入
            Presn = $.trim($("#txtPreImport").val());
            if (Presn == "") {
                alert("请输入SN");
                $("#txtPreImport").focus();
                return false;
            }
            //1.根据SN获取QC检验内容
            var list = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionMemberBySN(Presn, userName, 5);
            if (list.error != null) {
                alert(list.error.Message);
                SaveUserUILog("一般", stationId, resourceId, "", list.error.Message);
                $("#txtPreImport").focus();
                return false;
            }
            if (list.value == null) {
                alert("请维护检验模板");
                $("#txtPreImport").focus();
                return false;
            }
            loadInspectionMemberInfoPre(list.value);
            PreLoadFashion(Presn);

            //var importSN = $.trim($("#txtPreImport").val());
            //var aqlSampleId = $("input[name='checkItem']:checked").val();  //获取被选中Radio的Value值
            //var aqlSampleName = $.trim($("input[name='checkItem']:checked").next("span").text());  //获取被选中Radio的Value值
            //if (importSN == "") {
            //    alert("请扫描序号条码！");
            //    $("#txtPreImport").focus();
            //    return false;
            //}
            //var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectInspectionLotRecords(importSN, aqlSampleId, aqlSampleName);
            //if (ajaxPack.error != null) {
            //    if (isNCCode == 1 && ajaxPack.error.Message == "NCCODE") {
            //        //记录送检产品NG信息
            //        var ajaxNcCode = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectPreInspectionLotNCCodeInfo(sn, importSN, stationId, resourceId);
            //        if (ajaxNcCode.error != null) {
            //            SaveUserUILog("一般", stationId, resourceId, "", ajaxNcCode.error.Message);
            //            alert(ajaxNcCode.error.Message);
            //        }
            //        loadpreImport();
            //    }
            //    else {
            //        alert(ajaxPack.error.Message);
            //    }
            //    $("#txtPreImport").val("");
            //    $("#txtPreImport").focus();
            //    return false;
            //}
            //loadpreImport();
            //isNCCode = 1;
            //sn = importSN;
            //$("#txtPreImport").val("");
            //$("#txtPreImport").focus();
        }

        /**
        *提前录入
        **/
        function preImport() {
            if (inspectionLotId > 0) {
                alert("请先完成当前批次送检，再进行提前录入操作！");
                return;
            }
            isNCCode = 0;
            sn = "";
            $("#inspectionTemplateImportTb  tr:not(:first)").remove();
            $("#txtPreImport").val("").focus();
            $("#txtItemName").val("");
            $("#hdnItemId").val("-1");
            $("#PreFashion").html("");
            $("#sltImport option[value='0']").prop("selected", true);
            loadpreImport();
            showPage("layerImport");
        }
        /**
        *  加载SN信息
        **/
        function loadpreImport() {
            var importType = $("#sltImport").val();
            //var aqlSampleId = $("input[name='checkItem']:checked").val();
            var aqlSampleId = $("#inspectionTemplateImportTb tr input:checked").val();  //检验项编码
            var itemId = $("#hdnItemId").val();
            var PreSN = $("#txtPreImport").val();

            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionLotRecords(importType, aqlSampleId, itemId, PreSN);
            if (ajaxPack.error != null) {
                alert(ajaxPack.error.Message);
                $("#txtPreImport").val("");
                $("#txtPreImport").focus();
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                return false;
            }
            var list = (ajaxPack.value);
            var row, cell;
            var setTable = document.getElementById("inspecImportTb");
            $("#inspecImportTb  tr:not(:first)").remove();
            if (list == null || list == undefined) {
                row = setTable.insertRow(setTable.rows.length);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = "10";
                cell.innerHTML = "暂无数据"
                $("#lblTotalQty").text(0);
                $("#lblNGQty").text(0);
                return;
            }

            $("#lblTotalQty").text(list[0].TotalQty);
            $("#lblNGQty").text(list[0].NGQty);

            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                row = setTable.insertRow(setTable.rows.length);
                if (i % 2 == 0) {
                    row.className = 'ListTableOddRow';
                }
                else {
                    row.className = 'ListTableEvenRow';
                }
                //row.onclick = ShowEditPage;

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = entity.ItemCode

                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = entity.SN;

                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = entity.AQLSampleName;

                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = entity.CustomerSN;

                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = entity.Result;

                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = entity.NCCode.substring(0, entity.NCCode.length - 1);;

                cell = row.insertCell(6);
                cell.align = "center";
                cell.innerHTML = entity.CreateBy;

                cell = row.insertCell(7);
                cell.align = "center";
                cell.innerHTML = entity.CreateDateTime;

                cell = row.insertCell(8);
                cell.align = "center";
                cell.innerHTML = entity.ImportDateTime;
            }
        }

        function openChoosePage(flags) {
            var condition = "";

            flag = flags;
            dialog({
                title: "选择窗口",
                src: "../Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&SearchCondition=" +
                    condition +
                    "&CallBackFunc=getItemChoose" +
                    "&rnd=" +
                    Math.random(),
                width: 700,
                height: 400
            });
        }

        function getItemChoose(list) {
            $("#txtItemName").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
        }
        /**
        *切入
        **/
        function importItem() {
            if (inspectionLotId <= 0) {
                alert("请扫描包装/栈板条码！");
                $("#txtSNNew").val("");
                $("#txtSNNew").focus();
                return false;
            }
            var ajaxPack = SKT.LeanMES.Web.AjaxServices.AjaxQC.ImportInspectionLotRecords(inspectionLotId);
            if (ajaxPack.error != null) {
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPack.error.Message);
                alert(ajaxPack.error.Message);

                return false;
            }
            inspectionLock(0);
            getInspectionMemberSNInfo();
        }

        /**
        *清空表信息
        **/
        function clearTable(name, colSpan) {
            var row, cell;
            var setTable = document.getElementById(name);
            $("#" + name + "  tr:not(:first)").remove();
            row = setTable.insertRow(setTable.rows.length);
            row.className = 'ListTableOddRow';
            cell = row.insertCell(0);
            cell.align = "center";
            cell.colSpan = colSpan;
            cell.innerHTML = "暂无数据"
        }

        /*JS检查用户是否具有某一权限*/
        function IsHasPermission(userId_int, popedom_int) {
            return SKT.LeanMES.Web.AjaxServices.AjaxClientController.IsPermission(userId_int, popedom_int).value;
        }
        //计算SN检验结果
        function count() {
            //var InspectionMethodValue = $("#inspectionMemberItemTb tr input[type='checkbox']:checked").parent().parent().find("td:eq(10)").text();
            //正常录入值
            var tempValue = $("#inspectionMemberItemTb tr input:checked").parent().parent().find("td:eq(10)").text();
            //提前录入值
            var tempValePre = $("#inspectionTemplateImportTb tr input:checked").parent().parent().find("td:eq(4)").text();
            var InspectionMethodValue = tempValue == "" ? tempValePre : tempValue;
            var data = $.trim($("#txtvalue").val()) == "" ? $.trim($("#txtprevalue").val()) : $.trim($("#txtvalue").val());
            if (data == "") {
                alert("请输入检验值,并回车");
                $("#txtvalue").focus();
                return false;
            }
            var Result = false;
            if (InspectionMethodValue.indexOf("(") != -1) {
                //散列值
                var arr = InspectionMethodValue.replace('(', '').replace(')', '').split(',');
                if ($.inArray(data, arr) == -1) {
                    Result = false;
                } else {
                    Result = true;
                }
            } else if (InspectionMethodValue.indexOf("[") != -1) {
                ////范围
                //var arr = InspectionMethodValue.replace('[', '').replace(']', '').split('~');
                //if (parseFloat(data) >= parseFloat(arr[0]) && parseFloat(data) <= parseFloat(arr[1])) {
                //    Result = true;
                //} else {
                //    Result = false;
                //}
                //范围
                var MethodValue = InspectionMethodValue;
                if (MethodValue.substring(0, 1) == "[") {
                    MethodValue = MethodValue.substring(1, MethodValue.length - 1);
                }
                var standardValue = parseFloat(MethodValue.substring(0, MethodValue.indexOf("["))); //标准值
                var arr = MethodValue.substring(MethodValue.indexOf("[") + 1, MethodValue.indexOf("]")).replace('[', '').replace(']', '').split('~');
                var upper = parseFloat(arr[0]);//上限
                var lower = parseFloat(arr[1]);//下限
                if (parseFloat(data) >= parseFloat(lower + standardValue) && parseFloat(data) <= parseFloat(upper + standardValue)) {
                    Result = true;
                } else {
                    Result = false;
                }
            } else {
                if (InspectionMethodValue.indexOf("±") != -1) {
                    var value = InspectionMethodValue.replace("±");
                    if (data >= arr[0] && data <= arr[1]) {
                        Result = true;
                    } else {
                        Result = false;
                    }
                } else {
                    if (eval(data + InspectionMethodValue)) {
                        Result = true;
                    } else {
                        Result = false;
                    }
                }
            }
            return Result;
        }

        function loadPermissions() {
            var forceRejectPermission = IsHasPermission(userId, 80013901);      //强制通过
            var advanceEntryPermission = IsHasPermission(userId, 80013902);     //提前录入
            var cutInPermission = IsHasPermission(userId, 80013903);            //切入
            if (!forceRejectPermission) {
                $("#btnPersonPass").hide();
            }
            if (!advanceEntryPermission) {
                $("#btnPreImport").hide();
            }
            if (!cutInPermission) {
                $("#btnImport").hide();
            }
        }
    </script>
</asp:Content>
