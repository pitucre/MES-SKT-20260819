<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="CommonProCollectionBatch.aspx.cs" Inherits="SKT.LeanMES.Web.Client.CommonProCollectionBatch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
       #dialogUpdateAudit{display:none;}

       .button1 {
 -webkit-transition-duration: 0.4s;
 transition-duration: 0.4s;
 padding: 16px 32px;
 text-align: center;
 background-color: white;
 color: black;
 border: 2px solid #4CAF50;
 border-radius:5px;
 }
 .button1:hover {
 background-color: #4CAF50;
 color: white;
 }

</style> 
    <div class="client-center">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <th style="width: 40%"></th>
                <th style="width: 40%"></th>
                <th style="width: 20%"></th>
            </tr>
            <tr>
                <td style="vertical-align: top">
                    <div class="dds-panel">
                        <div class="leftmenu-new-header">
                            批次接收
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="EditeContentTable">
                            <tr>
                                <td class="Label2">
                                    批次条码<em style="color: Red;">*</em>
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtBatchSN_JS" class="ui-textbox" style="width: 95%;" />
                                </td>
                                
                            </tr>
                            <tr>
                                <td class="Label2">
                                    接收人<em style="color: Red;">*</em>
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtReceiveUser_JS" class="ui-textbox" style="width:90%;"  disabled="disabled" />
                                    <asp:HiddenField ID="hdnReceiveUser_JS" runat="server" Value="-1" ClientIDMode="Static" />
                                    <input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(1);" />
                                </td>
                            </tr>
                            <tr>
                                <td class="Label2">
                                    接收数量<em style="color: Red;">*</em>
                                </td>
                                <td class="Field1">
                                     <input type="text" id="txtReceiveQty_JS" class="ui-textbox" style="width: 95%;" disabled="disabled" />
                                </td>
                            </tr>
                            <tr>
                                <td class="Label2">备注
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtRemark_JS" class="ui-textbox" style="width: 95%;" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center" style="height:50px;">
                                    <div  class="button1"  onclick="Receive();" style="width:80px;"> 保 存 </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td style="vertical-align: top">
                    <div class="dds-panel">
                        <div class="leftmenu-new-header">
                            批次完工
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="EditeContentTable">
                            <tr>
                                <td class="Label2">
                                    批次条码<em style="color: Red;">*</em>
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtBatchSN_WG" class="ui-textbox" style="width: 95%;" />
                                </td>
                                
                            </tr>
                            <tr>
                                <td class="Label2">
                                    操作人<em style="color: Red;">*</em>
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtReceiveUser_WG" class="ui-textbox" style="width: 90%;" disabled="disabled"  />
                                    <asp:HiddenField ID="hdnReceiveUser_WG" runat="server" Value="-1" ClientIDMode="Static" />
                                    <input type="button" id="Button1" runat="server" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(2);" />
                                </td>
                            </tr>
                            <tr>
                                <td class="Label2">
                                    完工数量<em style="color: Red;">*</em>
                                </td>
                                <td class="Field1">
                                     <input type="text" id="txtReceiveQty_WG" class="ui-textbox" style="width: 95%;" />
                                </td>
                            </tr>
                            <tr>
                                <td class="Label2">备注
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtRemark_WG" class="ui-textbox" style="width: 95%;" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center" style="height:50px;">
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <div  class="button1"  onclick="NcDataSave();"> 不 良 录 入 </div>
                                            </td>
                                            <td>
                                                <div  class="button1"  onclick="ScrapSave();"> 报 废 录 入 </div>
                                            </td>
                                            <td>
                                                <div  class="button1"  onclick="BatchOKSave();">保 存 </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                 <td style="vertical-align: top">
                    <div class="dds-panel">
                        <div class="leftmenu-new-header">
                            工艺信息
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="EditeContentTable">
                            <tr>
                                <td class="Field1" colspan="2">
                                    <input type="button" value=" 在线查看图纸 " onclick="Print()" />
                                </td>
                            </tr>
                            <tr>
                                <td class="Label1">
                                    工艺说明
                                </td>
                                <td class="Field1" style="height:96px;">
                                    <label id="labProcessDescription">送到公司的还让她额防守打法晚上问@￥#DSGSD深粉色发小大V水电费v</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Label1">
                                    工模具编码
                                </td>
                                <td class="Field1">
                                     <label id="labMoldNO">M12354SNFK_001</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Label1">
                                    质量控制关键点
                                </td>
                                <td class="Field1">
                                    <label id="labQCImportant">弯角90度，哈撒给</label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>
    <div id="dialogUpdateAudit" title="报废录入">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    批次SN<em style="color: Red;">*</em>
                </td>
                <td  class="Field2">
                    <input type="text" id="txtBatchSN_Scrap" class="ui-textbox" style="width: 85%;" />
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    报废数量<em style="color: Red;">*</em>
                </td>
                <td  class="Field2">
                    <input type="text" id="txtScrapQty" class="ui-textbox" style="width: 85%;" />
                </td>
            </tr>
            <tr>
                <td class="Label2">备注</td>
                <td class="Field2">
                    <asp:TextBox ID="txtRemark_Scrap" runat="server" CssClass="TextArea" TextMode="MultiLine"
                        MaxLength="50" Width="85%" ClientIDMode="Static" Height="100"></asp:TextBox>
                </td> 
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <input id="btnSavedialogUpdateAudit" type="button" onclick="SavedialogScrap()" value=" 提 交 " />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </div>
     <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.ElectronicEquipment.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        $(document).ready(function () {
            //初始化称重插件
            initElectronic();
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('Common_ProCollectionUI_Batch');

                    $("#txtBatchSN_JS").select();
                },
                10
            );

            isByPass = 1;
            $("#txtReceiveUser_JS").val(employeeCName);
            $("#hdnReceiveUser_JS").val(userName);

            $("#txtReceiveUser_WG").val(employeeCName);
            $("#hdnReceiveUser_WG").val(userName);

        });

        //扫描框回车事件
        $("#txtBatchSN_JS").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    var scanSN = $("#txtBatchSN_JS").val();
                    //1.获取当前基本信息                 
                    var resourceId = $("#hdnCurrResourceId").val(); //资源Id
                    var stationId = $("#hdnCurrStationId").val(); //工位Id

                    //2.开始对当前sn进行校验及执行activity**********待确定流程
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId, false);
                    if (ajax.error != null) {
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtBatchSN_JS").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }


                    var info = { ScanSN: scanSN, StationID: stationId };
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchCheckSN_JS", JSON.stringify(info));
                    if (ajax.error != null) {
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtBatchSN_JS").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    var list = JSON.parse(ajax.value);
                    var listOrder = list.data;
                    $("#txtReceiveQty_JS").val(listOrder[0].BatchQty);
                    $("#labProcessDescription").text(listOrder[0].ProcessDescription);
                    $("#labMoldNO").text(listOrder[0].MoldNO);
                    $("#labQCImportant").text(listOrder[0].QCImportant);
                    showAreaMessge($("#txtBatchSN_JS").val() + ':扫描成功 ！', 'messageGreen');
                }
                if (curKey == 46) {
                    $("#txtBatchSN_JS").val("");
                }
            }
        );

        //扫描框回车事件
        $("#txtBatchSN_WG").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    var scanSN = $("#txtBatchSN_WG").val();
                    //1.获取当前基本信息                 
                    var resourceId = $("#hdnCurrResourceId").val(); //资源Id
                    var stationId = $("#hdnCurrStationId").val(); //工位Id

                    //2.开始对当前sn进行校验及执行activity**********待确定流程
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId, false);
                    if (ajax.error != null) {
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtBatchSN_WG").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }


                    var info = { ScanSN: scanSN, StationID: stationId };
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchCheckSN_WG", JSON.stringify(info));
                    if (ajax.error != null) {
                        showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                        $("#txtBatchSN_WG").val("").focus();
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        return false;
                    }
                    var list = JSON.parse(ajax.value);
                    var listOrder = list.data;
                    $("#txtReceiveQty_WG").val(listOrder[0].BatchQty);
                    $("#labProcessDescription").text(listOrder[0].ProcessDescription);
                    $("#labMoldNO").text(listOrder[0].MoldNO);
                    $("#labQCImportant").text(listOrder[0].QCImportant);
                    showAreaMessge($("#txtBatchSN_WG").val() + ':扫描成功 ！', 'messageGreen');
                }
                if (curKey == 46) {
                    $("#txtBatchSN_WG").val("");
                }
            }
        );

        //扫描框回车事件
        $("#txtBatchSN_Scrap").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    $("#txtScrapQty").val("").focus();
                }
            }
        );

        //批次完工
        function BatchOKSave() {
            var scanSN = $("#txtBatchSN_WG").val();
            //1.获取当前基本信息                 
            var resourceId = $("#hdnCurrResourceId").val(); //资源Id
            var stationId = $("#hdnCurrStationId").val(); //工位Id
            var username = $("#hdnReceiveUser_WG").val();

            //2.开始对当前sn进行校验及执行activity**********待确定流程
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId, false);
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtBatchSN_WG").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }


            var info = { ScanSN: scanSN, StationID: stationId };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchCheckSN_WG", JSON.stringify(info));
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtBatchSN_WG").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }

            var FinishQty = $("#txtReceiveQty_WG").val();
            var Remark = $("#txtRemark_WG").val();

            var info = { ScanSN: scanSN, StationID: stationId, ResourceID: resourceId, FinishQty: FinishQty, Remark: Remark,UserName: username };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchFinishSave", JSON.stringify(info));
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtBatchSN_WG").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#txtReceiveQty_WG").val(listOrder[0].BatchQty);
            $("#labProcessDescription").text(listOrder[0].ProcessDescription);
            $("#labMoldNO").text(listOrder[0].MoldNO);
            $("#labQCImportant").text(listOrder[0].QCImportant);
            showAreaMessge($("#txtBatchSN_WG").val() + ':报工完成 ！', 'messageGreen');
            var BatchSNScanInfo = listOrder[0].BatchSNScanInfo;
            var UnitHistory = listOrder[0].UnitHistory;
            if (listOrder[0].IsPass == 1) {
                //过站操作
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.UnitComplete(scanSN, stationId, resourceId, true);
                if (ajax.error != null) {
                    showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtBatchSN_WG").val("").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);

                    //报错回滚 批次SN完工
                    var info2 = { ScanSN: scanSN, StationID: stationId, ResourceID: resourceId, UserName: username, BatchSNScanInfo: BatchSNScanInfo, UnitHistory: UnitHistory };
                    var ajax2 = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchFinishSaveReturn", JSON.stringify(info2));
                    if (ajax2.error != null) {
                        showAreaMessge(scanSN + ':' + ajax2.error.Message, "messageRed");
                        $("#txtBatchSN_WG").val("").focus();
                        //写入日志
                        return false;
                    }

                    return false;
                }
                else if (ajax.json == undefined) {
                    showAreaMessge(scanSN + '：' + "未接收到系统返回信息，请检查是否登录已超时或网络中断！", "messageRed");
                    $("#txtBatchSN_WG").val("");
                    $("#txtBatchSN_WG").focus();
                    return false;
                }
                showAreaMessge($("#txtBatchSN_WG").val() + ':通过 ！', 'messageGreen');
                //根据SN刷新侧边栏动态信息
                refreshProInfoBySN(scanSN);
            }
            $("#txtBatchSN_WG").val("");
            $("#txtReceiveQty_WG").val("");
            $("#txtRemark_WG").val("");
        }

        //批次接收
        function Receive() {
            var scanSN = $("#txtBatchSN_JS").val();
            //1.获取当前基本信息       
            
            var resourceId = $("#hdnCurrResourceId").val(); //资源Id
            var stationId = $("#hdnCurrStationId").val(); //工位Id
            var username = $("#hdnReceiveUser_JS").val();
            if (username == "" || username == -1) {
                showAreaMessge("请选择接收人", "messageRed");
                return false;
            }
            //接收确认在校验一次
            //2.开始对当前sn进行校验及执行activity**********待确定流程
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId, false);
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtBatchSN_JS").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }


            var info = { ScanSN: scanSN, StationID: stationId };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchCheckSN_JS", JSON.stringify(info));
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtBatchSN_JS").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }

            var info = { ScanSN: scanSN, StationID: stationId, ResourceID: resourceId, UserName: username };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchReceive", JSON.stringify(info));
            if (ajax.error != null) {
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtBatchSN_JS").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                return false;
            }
            showAreaMessge($("#txtBatchSN_JS").val() + ':接收成功 ！', 'messageGreen');
            $("#txtBatchSN_JS").val("").focus();
            $("#txtReceiveUser_JS").val("");
            $("#hdnReceiveUser_JS").val("");
            $("#txtReceiveQty_JS").val("");
            $("#txtRemark_JS").val(""); 
        }

        //报废录入
        function SavedialogScrap() {
            var scanSN = $("#txtBatchSN_Scrap").val();
            var ScrapQty = $("#txtScrapQty").val();
            var Remark = $("#<%=this.txtRemark_Scrap.ClientID %>").val();
            //1.获取当前基本信息       
            var resourceId = $("#hdnCurrResourceId").val(); //资源Id
            var stationId = $("#hdnCurrStationId").val(); //工位Id
            var prodline = $("#hdCurProLine").val();
            if (scanSN == "") {
                alert("请扫描批次SN！");
                return;
            }
            if (ScrapQty == "") {
                alert("请填写报废数量！");
                return;
            }
            var info = { ScanSN: scanSN, ScrapQty: ScrapQty, StationID: stationId, ResourceID: resourceId, LineName: prodline, Remark: Remark, UserName: userName };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchScrapSave", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('报废录入成功 ！');
            $("#txtBatchSN_Scrap").val("").focus();
            $("#txtScrapQty").val("");
            $("#<%=this.txtRemark_Scrap.ClientID %>").val("");
            $("#dialogUpdateAudit").dialog("close");
        }
        //报废录入
        function ScrapSave() {
            $("#txtBatchSN_Scrap").val("").focus();
            $("#txtScrapQty").val("");
            $("#<%=this.txtRemark_Scrap.ClientID %>").val("");
            $("#dialogUpdateAudit").dialog({
                resizable: false,
                height: 320,
                width: 500,
                modal: true
            });
        }
        //不良录入
        function NcDataSave() {
            var scanSN = $("#txtBatchSN_JS").val();
            //1.获取当前基本信息       
            var resourceId = $("#hdnCurrResourceId").val(); //资源Id
            var stationId = $("#hdnCurrStationId").val(); //工位Id
            var prodline = $("#hdCurProLine").val();
            dialog({ title: '不良登记', src: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>' + "/Client/BatchSNNcDataSave.aspx?SN=" + scanSN + "&stationId=" + stationId + "&resourceId=" + resourceId + "&prodline=" + prodline +"&rnd=" + Math.random(), width: 750, height: 450 });
        }

        var flag = 0;
        function openChoosePage(flags) {
           // var condition = " 1=1 ";
            var condition = "";

            flag = flags;
            dialog({
                title: "选择人员",
                src: "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&CallBackFunc=getChangeOrderValue&Multiple=false&SearchCondition=" + condition +
                    "&rnd=" +
                    Math.random(),
                width: 680,
                height: 300
            });
        }

        function getChangeOrderValue(list) {
            //批次接收-接收人
            if (flag == 1) {
                $("#txtReceiveUser_JS").val(list[0][3]);
                $("#hdnReceiveUser_JS").val(list[0][2]);
            } 
            //批次完工-操作人
            if (flag == 2) {
                $("#txtReceiveUser_WG").val(list[0][3]);
                $("#hdnReceiveUser_WG").val(list[0][2]);
            } 
        }


    </script>
</asp:Content>
