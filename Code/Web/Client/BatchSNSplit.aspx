<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="BatchSNSplit.aspx.cs" Inherits="SKT.LeanMES.Web.Client.BatchSNSplit"
    ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div>
        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label2">批次条码<em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtBatchSN" class="scan-center-sn" style="width: 85%;" />
                </td>
            </tr>
            <tr>
                <td class="Label2">批次数量 
                </td>
                <td class="Field2">
                    <label id="labBatchQty"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">拆分数量 <em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtSplitQty" class="ui-textbox" style="width: 85%;" IsRequired='1' onkeyup="this.value=this.value.replace(/[^\d]/g,'')"
                        onafterpaste="this.value=this.value.replace(/[^\d]/g,'')" />
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label2">打印机名称
                </td>
                <td align="left">
                    <select id="selPrintersList" style="width: 250px;">
                    </select>
                    <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div style="text-align: center">
        <!--工作释放操作状态的信息提示区域-->
        <div id="lblMessage" class="Tips">
        </div>
    </div>
    <div style="text-align: center">
        <input type="button" id="btnSavePrint" style="width: 82px; cursor: pointer;" value=" 拆分并打印 " onclick="SavePrint();" />
        <input type="button" id="btnRepeatPrint" style="width: 82px; cursor: pointer;" value=" 补打 " onclick="RepeatPrint();" />
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">

        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        var mystationId = '<%=Request.QueryString["stationid"]%>';
        var myresourceId = '<%=Request.QueryString["resoureid"]%>';

        $(function () {
            bindPrinters('selPrintersList');
        });

        //扫描框回车事件
        $("#txtBatchSN").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    LoadSN();
                }
                if (curKey == 46) {
                    $("#txtBatchSN_WG").val("");
                }
            }
        );

        function LoadSN() {
            var scanSN = $("#txtBatchSN").val();
            var info = { ScanSN: scanSN };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspBatchSNSplitCheckSN", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtBatchSN").val("").focus();
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#labBatchQty").text(listOrder[0].BatchQty);
            labelItemId = listOrder[0].ItemID;
            labelProdOrderId = listOrder[0].ProdOrderID;
        }

        function SavePrint() {
            if ($("#txtSplitQty").val() == "") {
                alert("请输入拆分数量！");
                return false;
            }
            var scanSN = $("#txtBatchSN").val();
            var info = { ScanSN: scanSN };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspBatchSNSplitCheckSN", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtBatchSN").val("").focus();
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#labBatchQty").text(listOrder[0].BatchQty);
            labelItemId = listOrder[0].ItemID;
            labelProdOrderId = listOrder[0].ProdOrderID;

            var myBatchQty = parseFloat($("#labBatchQty").text());
            var mySplitQty = parseFloat($("#txtSplitQty").val());

            if (isNaN(mySplitQty) || mySplitQty <= 0) {
                alert("请输入正确的拆分数量！");
                return false;
            }

            if (mySplitQty >= myBatchQty) {
                alert("拆分数量不能大于或等于批次数量！");
                return false;
            }
            var info = { ScanSN: scanSN, StationID: mystationId, ResourceID: myresourceId, SplitQty: mySplitQty, UserName: userName };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspBatchSNSplitSave", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtBatchSN").val("").focus();
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            var mySNArr = listOrder[0].SNArr;
            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            getDocumentInfo()
            try {
                //将SN信息添加到SNInfo的SNInfo.SNList集合中
                SNInfo = {};
                SNInfo.SNList = mySNArr.split(',');
                mesLabLabelPrint(SNInfo.SNList);
            }
            catch (e) {
                $("#lblMessage").html(e);
                $("#lblMessage").show();
            }
        }
        //补打
        function RepeatPrint() {
            var scanSN = $("#txtBatchSN").val();
            var info = { ScanSN: scanSN };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspBatchSNSplitCheckSN", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtBatchSN").val("").focus();
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#labBatchQty").text(listOrder[0].BatchQty);
            labelItemId = listOrder[0].ItemID;
            labelProdOrderId = listOrder[0].ProdOrderID;
            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            getDocumentInfo()
            try {
                //将SN信息添加到SNInfo的SNInfo.SNList集合中
                SNInfo = {};
                SNInfo.SNList = scanSN.split(',');
                mesLabLabelPrint(SNInfo.SNList);
            }
            catch (e) {
                $("#lblMessage").html(e);
                $("#lblMessage").show();
            }
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '<%=Request.QueryString["ItemID"] %>';    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -36;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单-36:批次产品条码)
        var labelSequence = 1;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径
        var printCount = 1;        //打印份数：默认一次
        var templateGroup = 1;//新打印连板数
        //获取文档模板基础信息
        function getDocumentInfo() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                templateGroup = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintTemplateGroup(labelDocumentId).value;
                lableTypeQty = entity.PlateQty;
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                printCount = entity.Print_Qty;

            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }

            //初始化打印插件
            //InityPrintingPlugin();
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint(list) {
            if (list.length == 0) {
                ibs = 3 * printCount;
                setInterval(function () { $("#lblMessage").html("打印条码完成！"); ibs-- }, 1000)
                //setTimeout(function () {
                //    document.forms[0].submit();
                //}, 3000);
                LoadSN();
                $("#txtSplitQty").val("")
                return;
            }
            var sendQty = <%=ConfigurationManager.AppSettings["PrintSendQty"]%>;

            while (sendQty % templateGroup != 0) {
                sendQty++;
            }
            //从list中取出 sendQty 作为打印的数量，并且list截取掉sendQty
            var newlist = list.splice(sendQty);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfo(labelDocumentId, list, -1, -1, -1, labelItemId, labelProdOrderId);
            if (ajax.error == null) {
                if (ajax.value.length == 0) {
                    alert("没有找到该产品关联的模板信息");
                    return;
                }
            } else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return;
            }
            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, function (success, ws) {
                if (!success) {
                    if (ws && ws.readyState != 1)
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    return;
                }
                recordPrint(list);
                mesLabLabelPrint(newlist);
            },<%=ConfigurationManager.AppSettings["PrintType"]%>);

        }

        function recordPrint(list) {
            setTimeout(function () {
                for (var r = 0; r < list.length; r++) {
                    var printRecodeEntity = {};
                    printRecodeEntity.RecordId = -1;
                    printRecodeEntity.ActionType = 1;
                    printRecodeEntity.PrintType = -2;
                    printRecodeEntity.PrintKey = list[r];
                    printRecodeEntity.StationId = -1;
                    printRecodeEntity.ResourceId = -1;
                    var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
                    if (ajaxPrintRecodes.error != null) {
                        alert(ajaxPrintRecodes.error.Message);
                        $("#lblMessage").html(ajaxPrintRecodes.error.Message);
                        return false;
                    }
                }
            }, 10);
        }
        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/
    </script>
</asp:Content>
