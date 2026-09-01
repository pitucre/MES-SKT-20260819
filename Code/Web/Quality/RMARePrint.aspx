<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="RMARePrint.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.RMARePrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label3">打印机名称
            </td>
            <td class="Field2" colspan="1">
                <select id="selPrintersList" style="width: 200px">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList')">重新加载打印机列表</a>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div id="info" style="text-align: center; color: Green; font-weight: bold; text-transform: uppercase;">
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            bindPrinters('selPrintersList');
        });
        function Print() {
            var idStr = '<%=Request.QueryString["idStr"] %>';
            var ajax = SKT.LeanMES.Web.Quality.RMAReciveDetailList.CheckRePrintData(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            labelItemId = ajax.value;
            if (labelItemId == -1) {
                alert("获取产品数据失败！")
                return;
            }

            SNInfo = window.parent.GetSelectSN();

            if (getDocumentInfo()) {
                mesLabLabelPrint();
            }
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



        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                if (entity == null) {
                    alert("未找到模板信息！");
                    return false;
                }
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                // printName = entity.PrinterName;
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }

            return true;
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint() {
            try {
                var printdata = [];
                for (var i = 0; i < SNInfo.length; i++) {
                    var labelStr = SNInfo[i];
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);
                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        var page = { LabelContent: [] };
                        for (var j = 0; j < list.length; j++) {
                            page.LabelContent.push({ name: list[j].LabelName, value: list[j].LabelValue });
                        }
                        if (page.LabelContent.length > 0)
                            printdata.push(page);
                    }
                }
                if (printdata.length == 0)
                    return;
                sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }

        }


    </script>
</asp:Content>
