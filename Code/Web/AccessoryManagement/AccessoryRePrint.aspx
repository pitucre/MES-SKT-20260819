<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="AccessoryRePrint.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryRePrint" %>

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
            <td class="Label1">
                辅料条码<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtSerialNumber" class="TextBox" style="height: 25px; width: 250px; text-transform: uppercase; font-size: 16px; font-weight: bold;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">打印机名称
            </td>
            <td class="Field2" colspan="1">
                <select id="selPrintersList" style=" width: 250px; ">
                </select>
            </td>
        </tr>
         <tr>
            <td class="Label1">
            </td>
            <td class="Field2" colspan="1">
              <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
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
        var _serialNumber = '<%=Request.QueryString["SerialNumber"] %>';
        $(function () {
            $("#txtSerialNumber").focus();
            if (_serialNumber != "") {
                $("#txtSerialNumber").val(_serialNumber);
                $("#txtSerialNumber").focus();
                $("#txtSerialNumber").select();
            }
            bindPrinters('selPrintersList');
            /*扫描条码*/
            $("#txtSerialNumber").keypress(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Print();
                    return false;
                }
            });
        });

        function Print() {
            var serialNumber = $("#txtSerialNumber").val();
            if ($.trim(serialNumber) == "") {
                alert("请输入要打印的辅料条码");
                $("#txtSerialNumber").val("").focus();
                return false;
            }
            var arr = serialNumber.split(",");
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.ItemList = [];
            for (var i = 0; i < arr.length; i++) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.GetAccessoryInfo({ SerialNumber: arr[i] });

                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#info").html(ajax.error.Message);
                    $("#info").css("color", "red");
                    $("#txtSerialNumber").val("").focus();
                    return false;
                }
                if (ajax.value == null || ajax.value.SerialNumber == null) {
                    $("#info").html("辅料条码["+ arr[i] +"]不存在！");
                    $("#info").css("color", "red");
                    $("#txtSerialNumber").val("").focus();
                    return false;
                }

                try {
                    labelItemId = ajax.value.ItemId;

                    //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                    getDocumentInfo();

                    //将SerialNumber信息添加到SNInfo的SNInfo.SNList集合中
                    SNInfo.SNList.push(arr[i]);
                    SNInfo.ItemList.push(ajax.value.ItemId);
                }
                catch (e) {
                    alert(e)
                    $("#lblMessage").html(e);
                }
            }
            PrintLabContent();
        }




        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -17;          //标签类型 (-2：SN，-3：SerialNumber)
        var labelSequence = 6;      //标签序号 (1产品，2GRN, 3单号......)
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        //根据打印方式决定 调用ZPL还是Lab打印
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                //获取打印机名称值
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                alert(ajax.error.Message);
                return false;
            }
        }

        var printCount = 1;
        function PrintLabContent() {
            try {
                printCount = 1;
                lableArr = SNInfo.SNList;
                labItemList = SNInfo.ItemList;
                var printdata = [];
                for (var i = 0; i < lableArr.length; i++) {
                    var labelStr = lableArr[i];
                    var lablabItem = labItemList[i];
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, lablabItem, -1);
                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        var page = { LabelContent: [] };
                        for (var j = 0; j < list.length; j++) {
                            page.LabelContent.push({ name: list[j].LabelName, value: list[j].LabelValue });
                        }
                        printdata.push(page);
                    } 
                }
                if (printdata.length == 0)
                    return;
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
        }
    </script>
</asp:Content>
