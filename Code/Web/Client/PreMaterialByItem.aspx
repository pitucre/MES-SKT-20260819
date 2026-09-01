<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ProdPreMaterial.Master"
    CodeBehind="PreMaterialByOrder.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PreMaterialByOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--前置加工上料验证by工单-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">请扫描GRN条码</span> &nbsp;&nbsp;&nbsp;&nbsp;<div
                            id="messageBox">
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
            <table style="width: 100%">
                <tr>
                    <td>
                        <span class="scan-center-lable">物料编码</span>
                    </td>
                    <td>
                        <span class="scan-center-title" id="itemCode"></span>
                    </td>
                    <td>
                        <span class="scan-center-lable">物料数量</span>
                    </td>
                    <td>
                        <span class="scan-center-title" id="grnQty"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="scan-center-lable">物料描述</span>
                    </td>
                    <td colspan="3">
                        <span class="scan-center-title" id="itemDesc"></span>
                    </td>
                </tr>
            </table>
        </div>
        <!--打印新GRN-->
        <div id="datastatistic" class="data-statistic">
            <span class="scan-center-title">打印新GRN</span>
            <table style="width: 100%">
                <tr>
                    <td>
                        <span class="scan-center-lable">包装数量</span>
                    </td>
                    <td>
                        <input type="text" id="txtCartonQty" class="scan-center-input" isnumber="1" />
                    </td>
                    <td>
                        <span class="scan-center-lable">打印数量</span>
                    </td>
                    <td>
                        <input type="text" id="txtGrnQty" class="scan-center-input" isnumber="1" />
                    </td>
                    <td>
                        <span class="scan-center-lable">标签份数</span>
                    </td>
                    <td>
                        <input type="text" id="txtPrintQty" class="scan-center-input" isnumber="1" value="1" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="scan-center-lable">备注</span>
                    </td>
                    <td colspan="5">
                        <textarea type="text" id="txtItemDesc" class="scan-center-input" style="width: 95%;
                            height: 40px;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <input type="button" value="打印" style="width: 100px; font-size: 15px; font-weight: bolder;"
                            onclick="PrintMaterialSN();" />
                    </td>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
             <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var scanGRN = ""; //当前扫描的GRN
        var printerDemo = null;
        var zplStr = "";
        var labelItemId = -1; //产品itemId
        var stationId = -1;
        var resourceId = -1;
        var grnArr = "";

        $(document).ready(function () {
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('Pre_MaterialByItem');
                },
                10
            );
        });

        function afterScan() {
            if ($("#txtSN").val() != "") {
                scanGRN = $("#txtSN").val();
                //**开始对扫描的物料GRN条码进行检验
                if (preCheckOrderId == -1 && preCheckItemId == -1) {
                    alert("请在操作菜单内选择料号!");
                    return false;
                }
                else if (preCheckOrderId == -1) {
                    //进行工单验证
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreCheckMaterial.GetGRNIteminfo(2, preCheckOrderId, scanGRN);
                    if (ajax.error != null) {
                        showAreaMessge(ajax.error.Message, "messageRed");
                        clearInput("txtSN");
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, scanGRN, ajax.error.Message);
                        return false;
                    }
                    var entity = ajax.value;
                    labelItemId = entity.ModelID;
                    alert(labelItemId);
                    $("#itemCode").html(entity.ItemCode);
                    $("#itemDesc").html(entity.ItemDesc);
                    $("#grnQty").html(entity.GrnQty);
                    showAreaMessge(scanGRN + '验证通过', "messageGreen");
                }
            }
        }

        //打印物料标签
        function PrintMaterialSN() {
            var cartonQty = $("#txtCartonQty").val();
            var printQty = $("#txtGrnQty").val();
            var labCount = $("#txtPrintQty").val();
            if (scanGRN == "") {
                alert("请扫描正确的GRN");
                return false;
            } else if (cartonQty == "") {
                alert("请输入正确的包装数量");
                return false;
            } else if (printQty == "") {
                alert("请输入正确的打印数量");
                return false;
            }
            if (SubmitValidation()) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreCheckMaterial.GetPrintPreMaterial("Item", stationId, resourceId, preCheckOrderId,
                scanGRN, parseFloat(cartonQty), parseInt(printQty), userName);
                if (ajax.error != null) {
                    showAreaMessge(ajax.error.Message, "messageRed");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, scanGRN, ajax.error.Message);
                    return false;
                }
                else {
                    showAreaMessge(scanGRN + '打印成功', "messageGreen");
                    grnArr = ajax.value;
                    printPreCheck();
                }
            }
        }

        //调用打印方法
        function printPreCheck() {

            //获取打印方式：
            getDocumentInfo();
            PrintLabContent();
        }

        var printCount = 1;
     

        function PrintLabContent() {
            var printdata = [];
            try {
                printCount = parseInt($("#txtPrintQty").val());
                labelJsonData = "[";
                for (var i = 0; i < grnArr.length; i++) {
                    var labelStr = grnArr[i].LotNo;
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, preCheckOrderId);
                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, "", ajaxLabContent.error.Message);
                    }
                }
                if (printdata.length == 0)
                    return;
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            }
            catch (e) {
                alert(e.message);
                return false;
            }
            showAreaMessge('打印成功', "scanLabelGreen");
            clearInput("txtGrnQty");
            clearInput("txtCartonQty");
        }

        var labelDocumentId = -1;
        var lableTypeQty = -1;
        var printName = "";
        var labelPrintWayId = -1;
        var tempatePath = "";
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, -3, 2);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);

            }
            else {
                showAreaMessge(ajax.error.Message, "messageRed");
                return false;
            }
        }

        //补打
        var openWinUrl = "";
        function GRNPrint() {
            openWinUrl = webroot + "/Material/ReprintGRN.aspx?name=Material_ReprintGRN";
            dialog({ title: "补打", src: openWinUrl, width: 650, height: 400 });
        }

        //拆分
        function GRNSplit() {
            openWinUrl = webroot + "/Material/MaterialSplit.aspx?name=Material_MaterialSplit";
            dialog({ title: "拆分", src: openWinUrl, width: 750, height: 600 });
        }

        //报废
        function GRNScrap() {
            openWinUrl = webroot + "/Material/MaterialScrap.aspx?name=Material_Scrap";
            dialog({ title: "报废", src: openWinUrl, width: 650, height: 600 });
        }

        function clearInput(inputName) {
            $("#" + inputName + "").val("");
            $("#" + inputName + "").select();
            $("#" + inputName + "").focus();
        }
    </script>
</asp:Content>
