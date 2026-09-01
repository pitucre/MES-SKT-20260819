<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ShopOrderDetailRePrint.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ShopOrderDetailRePrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired%>
        </div>

        <tr>
            <td class="Label1">打印机名称<em>*</em>
            </td>
            <td class="Field1">
                <select id="selPrintersList" style="width: 250px;">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center">
        <!--工作释放操作状态的信息提示区域-->
        <div id="lblMessage" class="Tips">
        </div>
    </div>
    <div class="clear5">
    </div>
    <!--打印状态的信息提示区域-->
    <div id="lblPt" class="Tips" style="text-align: center">
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        var ids = '<%=Request.QueryString["ids"]%>';
        var snInfoTemp="";

        $().ready(function () {          
            bindPrinters('selPrintersList');

            //获取SN信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.GetListSNByIds(ids);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            snInfoTemp = ajax.value.join(",");
        });

        function RePrint() {
            try {
                //获取uid字符串，根据uid字符串找到对应的产品id。(检查这些UID，对应的ItemId是否一致。)
                var idStr = ids;
                if (idStr == "") return false;
                debugger;
                var ajaxItem = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetItemIdByUIDstr(idStr);
                if (ajaxItem.error == null) {
                    labelItemId = ajaxItem.value[0];
                    labelProdOrderId = ajaxItem.value[1];
                    /*判断是否是批次SN，如果是批次SN，用批次模板 1-单件，2-批次*/
                    if (ajaxItem.value[2] == 2) {
                        labelType = -36;
                    }
                }
                else {
                    alert(ajaxItem.error.Message);
                    return false;
                }

            } catch (ex) { alert(ex); }

            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            getDocumentInfo()
            try {                   
                //将SN信息添加到SNInfo的SNInfo.SNList集合中
                SNInfo = {};
                SNInfo.SNList = snInfoTemp.split(',');                    
                mesLabLabelPrint(SNInfo.SNList);
                if (snInfoTemp != "")
                    creatservicelog("补打工单条码", "工单维护|工单条码", "补打", snInfoTemp, "补打工单条码【" + snInfoTemp+ "】");


                setTimeout(function () {
                    $("div.noInstallPrintPlugin").remove();
                }, 2000);
            }
            catch (e) {
                $("#lblMessage").html(e);
                $("#lblMessage").show();
                creatservicelog("补打工单条码", "工单维护|工单条码", "补打", "打印异常", "补打工单条码异常：【" + e + "】");
            }
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '<%=Request.QueryString["ItemID"] %>';    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';    //ItemId
        var labelStationId = -1;    //工位Id
        var labelType = -36;          //标签类型  (1产品，2GRN, 3单号......)
        var labelSequence = 1;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径

        var templateGroup = 1;//新打印连板数
        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                if (entity != null) {
                    labelDocumentId = entity.LabelDocumentId;
                    templateGroup = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintTemplateGroup(labelDocumentId).value;
                    lableTypeQty = entity.PlateQty;
                    printName = $("#selPrintersList").val();
                    labelPrintWayId = entity.PrintWayId;
                    tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                }
                else {
                    alert("获取打印文档模板失败，请确认当前工单条码对应的产品有设置好对应的打印文档模板。");
                }
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                $("#lblMessage").show();
                return false;
            }
        }


        function mesLabLabelPrint(list, isPopPdf) {
            if (list.length == 0) {
                //不弹出PDF则提示关闭
                if(!isPopPdf){
                    ibs = 3 * printCount;
                    setInterval(function () { $("#lblPt").html("打印条码完成," + ibs + "秒后关闭窗口！"); ibs-- }, 1000)
                    setTimeout(function () {
                        parent.form1.submit();
                    }, 3000);
                }
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
                    $("#lblMessage").html("没有找到该产品关联的模板信息");
                    $("#lblMessage").show();
                    return;
                }
            } else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                $("#lblMessage").show();
                return;
            }

            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, function (success, ws, msg) {
                if (!success) {
                    if (ws && ws.readyState != 1)
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    return;
                }
                //最后一个PDF的时候提示
                var isPop = false;
                if (newlist.length == 0){
                    var data = JSON.parse(msg.data);
                    if (data.Result) {
                        layer.open({ title: "打印机脱机", content: "如需预览请复制以下地址到浏览器地址栏并回车。<textarea style='width:100%;height:100%;border:none;overflow:hidden;color:red;'>" + data.Result + "</textarea>" });
                        isPop =true;
                    }
                }
                recordPrint(list);
                mesLabLabelPrint(newlist, isPop);
            },<%=ConfigurationManager.AppSettings["PrintType"]%>);

        }
        function recordPrint(list) {
            setTimeout(function () {
                for (var r = 0; r < list.length; r++) {
                    var printRecodeEntity = {};
                    printRecodeEntity.RecordId = -1;
                    printRecodeEntity.ActionType = 2;
                    printRecodeEntity.PrintType = -2;
                    printRecodeEntity.PrintKey = list[r];
                    printRecodeEntity.StationId = -1;
                    printRecodeEntity.ResourceId = -1;
                    var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
                    if (ajaxPrintRecodes.error != null) {
                        alert(ajaxPrintRecodes.error.Message);
                        $("#lblMessage").html(ajaxPrintRecodes.error.Message);
                        $("#lblMessage").show();
                        return false;
                    }
                }
            }, 10);

        }
        /*
        *写入系统操作日志
        */
        function creatservicelog(logtype, modulename, pagename, oederno, logcontent) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxErrorLog.CreateOperationLog(logtype, modulename, pagename, oederno, logcontent);
            if (ajax.error != null) {
                return false;
            }
        }

        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/
    </script>
</asp:Content>
