<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="ProdOrderReleaseBatch.aspx.cs" Inherits="SKT.LeanMES.Web.Client.ProdOrderReleaseBatch"
    ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div style="text-align: center; margin-top: auto; color: Green;">
        <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse;">
            <tr class="ListTableHeader">
                <th scope="col" colspan="2" align="left">工单信息
                </th>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%=Resources.lang.OrderNumber %>
                </td>
                <td align="left">
                    <input type="text" id="txtFormNo" class="TextBox" readonly="readonly" runat="server" /><input type="button" id="btnFormNo"
                    class="ButtonBox" value="..." title="Select" onclick="selectFormNo(1);" />
                    <asp:HiddenField ID="hdnWoId" runat="server" Value="" ClientIDMode="Static" />
                    <asp:HiddenField ID="hdItemID" runat="server" Value="" ClientIDMode="Static" />
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%=Resources.lang.ItemCode %>
                </td>
                <td align="left">
                    <asp:Label ID="lbItemCode" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%=Resources.lang.CanbeReleaseQuantity %>
                </td>
                <td align="left">
                    <asp:Label ID="lbCanReleaseQty" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%=Resources.lang.ReleaseQuantity %>
                </td>
                <td align="left">
                    <input id="txtReleaseQty" class="NumericBox50" style="width: 50px;" /><em>*</em>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    每批次数量
                </td>
                <td align="left">
                    <input id="txtBatchQty" class="NumericBox50" style="width: 50px;" /><em>*</em>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    是否打印条码
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlisPrint" runat="server" AutoPostBack="false" ClientIDMode="Static">
                            <asp:ListItem Selected="True" Value="1">是</asp:ListItem>
                            <asp:ListItem Value="0">否</asp:ListItem>
                        </asp:DropDownList>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    打印机名称
                </td>
                <td align="left">
                    <select id="selPrintersList" style=" width: 250px; ">
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
        <input type="button" id="btnRelease" style="width: 82px; cursor: pointer;" value="<%= Resources.Buttons.Btn_Release %>" />
        <input type="button" id="btnPrint" style="width: 82px; cursor: pointer; display: none;"
            value="<%= Resources.Buttons.COM_Print %>" />
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
        
        $(function () {
            Inity();
            InityPrint();
            bindPrinters('selPrintersList');
        });

        function Inity() {
            
            $("#btnPrint").attr("disabled", true);
            /*释放工单*/
            $("#btnRelease").click(function () {
                var OrderNo = $("#<%=this.txtFormNo.ClientID %>").val();
                if (OrderNo == "") {
                    alert("请先选择工单！");
                    return false;
                }
                ERRORQTY = 0;
                printName = $("#selPrintersList").val();
                /*check Release Qty is ok*/
                var canReleaseQty = $("#<%=lbCanReleaseQty.ClientID %>").text();
                if (isNull($("#txtReleaseQty").val())) { alert("请输入工单要释放的数量！"); return false; }
                if (!isNumber($("#txtReleaseQty").val())) { alert("释放数量只能为整型数字！"); return false; }
                if (parseInt($("#txtReleaseQty").val()) <= 0) { alert("释放数量必须大于0！"); return false; }
                if (isNull($("#txtBatchQty").val())) { alert("请输入每批次数量！"); return false; }
                if (parseInt($("#txtBatchQty").val()) <= 0) { alert("每批次数量必须大于0！"); return false; }
                if (canReleaseQty < parseInt($("#txtReleaseQty").val())) { alert("本次释放数量不能大于工单可释放数量！"); return false; }

                if (!confirm("是否确定当前工单要释放所输入的数量？")) {
                    return false;
                }
                $(this).attr("disabled", true);
                $("#lblMessage").html("正在释放工单，请不要关闭窗口耐心等稍...");
                var orderId = $("#<%=this.hdnWoId.ClientID %>").val();
                setTimeout(function () {
                    /*check twice*/
                    if (checkIsReady(orderId)) {
                        /*begin release*/
                        var itemids = $("#<%=this.hdItemID.ClientID %>").val();
                        var ReleaseQty = $("#txtReleaseQty").val();
                        var BatchQty = $("#txtBatchQty").val();

                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.ReleaseBatchSO(parseInt(ReleaseQty),parseFloat(BatchQty),orderId, itemids);
                        if (ajax.error != null) {
                            $("#lblMessage").html(ajax.error.Message);
                            $("#btnRelease").removeAttr("disabled");
                            return false;
                        }
                        var Isprint=$("#<%=this.ddlisPrint.ClientID %>").val();
                        if (Isprint == "1") {
                            labelItemId = itemids;
                            labelProdOrderId = orderId;
                            getDocumentInfo();
                            //获取标签信息
                            SNInfo = ajax.value;

                            /*begin print sn*/
                            $("#lblPt").html("<span style='color:green; font-weight:bold;'>释放工单成功！</span><br/>正在排队打印，" + SNInfo.SNList.length + "个条码等待打印");

                            setTimeout(function () {
                                try {
                                    for (var i = 0; i < printCount; i++) {
                                        mesLabLabelPrint(SNInfo.SNList);
                                    }
                                }
                                catch (e) {
                                    alert(e);
                                    $("#lblMessage").html(e);
                                }
                            }, 30);

                        }
                        else
                        {
                            $("#lblPt").html("<span style='color:green; font-weight:bold;'>释放工单成功！</span>");
                            ibs = 3 * printCount;
                            setInterval(function () { $("#lblPt").html(ibs + "秒后关闭窗口！"); ibs-- }, 1000)
                            setTimeout(function () {
                                document.forms[0].submit();
                            }, 3000);
                            return;
                        }

                    }
                    $("#lblMessage").html("");
                }, 30);
            });
        }

        function refushWindow(orderNo) {
            parent.window.UpdateList(orderNo);
        }

        function InityPrint() {
            var $target = $("input");
            $target.bind('keydown', function (e) {
                var key = e.which;
                if (key == 13) {
                    e.preventDefault();
                    var nxtIdx = $target.index(this) + 1;
                    if ($target.eq(nxtIdx - 1).attr("id") == "txtDateCode") {
                        Save();
                    }
                    else if ($target.eq(nxtIdx - 1).attr("type") == "button") {
                        $target.eq(nxtIdx - 1).click();
                        $target.eq(nxtIdx).focus();
                    }
                    else {
                        $target.eq(nxtIdx).focus();
                    }
                }
            });
        }

        /*2.工单列表*/
        function selectFormNo(flage) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 650, height: 420 });
        }

        //绑定选择类型值
        function getChooseValue(list) {
            $("#<%=this.txtFormNo.ClientID %>").val(list[0][1]);
            if (list[0][0] != "-1") {
                $("#<%=this.hdnWoId.ClientID %>").val(list[0][0]);
            }
            var info = { OrderNo: $("#<%=this.txtFormNo.ClientID %>").val() };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetBatchOrderInfo", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#<%=lbCanReleaseQty.ClientID %>").text(listOrder[0].NotReleasedQty);
            $("#<%=lbItemCode.ClientID %>").text(listOrder[0].ItemCode);
            $("#<%=this.hdItemID.ClientID %>").val(listOrder[0].ItemID);
            $("#txtBatchQty").val(listOrder[0].LotSize);
        }

        function checkIsReady(soid) {
            var isOk = true;
            //Prod_OrderCheckCanbeRelease
            var cmd = "rZXWNP4ukgVO3uHFZBSOJlURS/N55aqxVESsGjM1VVOmrB+7jajPcQ==";
            var params = [], param = {};
            //@ProOrderId
            param.ParamName = "v/FhV7W2V48XbAg4jDlkkyDPkKyMwVcP";
            //INT
            param.ParamType = "1o/d3CICk7c=";
            param.ParamValue = soid;
            param.ParamSize = 0;
            params.push(param);

            var result = SKT.LeanMES.Web.Controls.PageSQLService.ExecuteNonQuery(cmd, params);
            if (result.error != null) {
                alert(result.error.Message);
                isOk = false;
            }
            return isOk;
        }

        /*是否为空*/
        function isNull(str) {
            if (str == "") return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }

        /*是否是数字*/
        function isNumber(s) {
            var regu = "^[0-9]+$";
            var re = new RegExp(regu);
            if (s.search(re) != -1) {
                return true;
            } else {
                return false;
            }
        }

        function showResult(msg) {
            alert(msg);
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
                setInterval(function () { $("#lblPt").html("打印条码完成！"); ibs-- }, 1000)
                setTimeout(function () {
                    document.forms[0].submit();
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
