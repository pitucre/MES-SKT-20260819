<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="PreSNRePrint.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PreSNRePrint" %>

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
        var snrId = '<%=Request.QueryString["id"]%>';
        var snInfoTemp='<%=Request.QueryString["snInfo"]%>';

        $().ready(function () {          
            bindPrinters('selPrintersList');
        });

        function RePrint() {
            var idstr = snrId;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreSNPrint.GetPrepSNReprintInfo(idstr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            SNInfo =snInfoTemp.split(',');

            labelItemId = ajax.value[0];
            labelType = ajax.value[1];
            labelSequence = ajax.value[2];
          
            debugger;
            if (getDocumentInfo()) {
                //mesLabLabelPrint(SNInfo);
                setTimeout(function () {
                    $("div.noinstallprintplugin").remove();
                }, 2000);
                //写系统操作日志
                for(var i = 0; i < SNInfo.length; i++) {
                    var opresult= createOperationLog("补打","生产管理|条码打印","条码列表",SNInfo[i],"补打【"+ SNInfo[i] + "】");
                    if(!opresult) return false;
                }
            }
        }

        //写入系统操作日志
        function createOperationLog(logtype, modulename, pagename, oederno, logcontent) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxErrorLog.CreateOperationLog(logtype, modulename, pagename, oederno, logcontent);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return true;
        }
        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelProdOrderId = -1;
        var labelStationId = -1;    //工位Id
        var labelType = -2;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
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
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo2(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                
                var printList = ajax.value;

                //var entity = ajax.value;
                if (printList == null) {
                    alert("未找到模板信息！");
                    return false;
                }

                for (var i = 0; i < printList.length; i++) {
                    var entity = printList[i];
                    labelDocumentId = entity.LabelDocumentId;
                    templateGroup = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintTemplateGroup(labelDocumentId).value;
                    lableTypeQty = entity.PlateQty;
                    printName = $("#selPrintersList").val();//entity.PrinterName;
                    debugger;
                    labelPrintWayId = entity.PrintWayId;
                    tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                    printCount = entity.Print_Qty;

                    mesLabLabelPrint(SNInfo);
                }
               
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }

            return true;
        }

        function mesLabLabelPrint(list) {
            if (list.length == 0) {
                ibs = 3 * printCount;
                setInterval(function () { $("#lblPt").html("打印条码完成," + ibs + "秒后关闭窗口！"); ibs-- }, 1000)
                setTimeout(function () {
                    parent.form1.submit();
                }, 3000);
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
                    $("#lblPt").html("没有找到该产品关联的模板信息");
                    return;
                }
            } else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return;
            }

            $("#lblPt").html("发送条码【" + list.join() + "】打印指令到打印机,请勿关闭窗口！<br/> 当前剩余打印数量【" + newlist.length + "】");
            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, function (success, ws) {
                if (!success) {
                    debugger;
                    if (ws && ws.readyState != 1)
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    return;
                }
                mesLabLabelPrint(newlist);
            },<%=ConfigurationManager.AppSettings["PrintType"]%>);
        }

        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/
    </script>
</asp:Content>
