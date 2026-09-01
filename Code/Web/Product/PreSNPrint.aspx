<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="PreSNPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PreSNPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired%>
        </div>
        <tr>
            <td class="Label1">条码规则类型<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlSNType" runat="server" IsRequired='1' ClientIDMode="Static">
                    <asp:ListItem Value="">--请选择--</asp:ListItem>
                    <asp:ListItem Value="0">SMT包装箱</asp:ListItem>
                    <asp:ListItem Value="-22">中箱条码</asp:ListItem>
                    <asp:ListItem Value="-4">包装条码</asp:ListItem>
                    <asp:ListItem Value="-5">栈板条码</asp:ListItem>
                    <asp:ListItem Value="-16">客户条码</asp:ListItem>

                </asp:DropDownList>
            </td>
        </tr>
        <tr id="trOrder">
            <td class="Label1">工单<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ReadOnly="true" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox><input type="button" runat="server" id="btnSelectOrder"
                        class="ButtonBox" value="..." title="选择工单" onclick="selectOrder();" />
                <asp:HiddenField ID="hdnProdOrderId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr id="trItem" style="display: none;">
            <td class="Label1">产品编号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                        onclick="selectItemCode();" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr id="trPrintQty">
            <td class="Label1">可打印数量&nbsp;&nbsp;&nbsp;
            </td>
            <td class="Field1">
                <span id="lblCanPrintQty">0</span>
            </td>
        </tr>
         <tr>
            <td class="Label1">打印机名称<em>*</em>
            </td>
            <td class="Field1">
                <select id="selPrintersList" style="width: 250px;">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
        <tr>
            <td class="Label1">本次打印数量<em>*</em>
            </td>
            <td class="Field1">
                <input id="txtPrintQty" class="NumericBox50" maxlength="5" isrequired='1' style="width: 50px;" />
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
        var flag = -1;
        var blPrintQty = 0;

        $().ready(function () {
            $("#txtPrintQty").keyup(function () {
                getIntVal(this);
            });

            $("#ddlSNType").change(function () {
                if ($("#ddlSNType").val() == "") {
                    $("#lblCanPrintQty").text(0);
                    return false;
                }
                else if ($("#ddlSNType").val() == "0") {
                    $("#trOrder,#trPrintQty").hide();
                    $("#trItem").show();
                    $("#txtOrderNo").val("");
                    $("#hdnProdOrderId").val("-1");
                    $("#txtOrderNo").attr("IsRequired", "0");
                    $("#txtItemCode").attr("IsRequired", "1");
                }
                else {
                    $("#trOrder,#trPrintQty").show();
                    $("#trItem").hide();
                    $("#txtOrderNo").attr("IsRequired", "1");
                    $("#txtItemCode").attr("IsRequired", "0");
                }
                if ($("#hdnProdOrderId").val() > 0) {
                    getCanPrintQty();
                }
            });

            bindPrinters('selPrintersList');
        });
        /*
        *选择工单
        */
        function selectOrder() {
            if ($("#ddlSNType").val() == "") {
                alert("请先选择条码规则类型！");
                $("#ddlSNType").focus();
                return false;
            }
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        /*
        *选择物料
        */
        function selectItemCode() {
            if ($("#ddlSNType").val() == "") {
                alert("请先选择条码规则类型！");
                $("#ddlSNType").focus();
                return false;
            }
            flag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        /*
        *获取选择窗值
        */
        function getChooseValue(list) {
            if (flag == 1) {

                //获取用户信息
                $("#txtOrderNo").val(list[0][1]);
                $("#hdnProdOrderId").val(list[0][0]);

                getCanPrintQty();
            }
            else if (flag == 2) {
                $("#txtItemCode").val(list[0][2]);
                $("#lblItemName").html(list[0][1]);
                $("#hdnItemId").val(list[0][0]);
                labelItemId = list[0][0];
                labelProdOrderId = -1;
            }

            setTimeout(function () {
                $("#txtPrintQty").focus();
            }, 100);
        }


        /*
        *获取可以打印的数量
        */
        function getCanPrintQty() {
            var psnTypeId = $("#ddlSNType").val();
            var prodOrderId = $("#hdnProdOrderId").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreSNPrint.GetPrintQty(psnTypeId, prodOrderId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            blPrintQty = ajax.value[0];
            labelItemId = ajax.value[1];

            $("#lblCanPrintQty").text(blPrintQty);
        }

        /*
        *保存并打印
        */
        function Save() {

            if (!confirm("是否确定打印当前所输入的数量条码？")) {
                return false;
            }

            $("#lblMessage").html("正在打印条码，请不要关闭窗口耐心等稍...");

            var printQty = parseInt($("#txtPrintQty").val());
            var psnTypeId = $("#ddlSNType").val();
            labelProdOrderId = $("#hdnProdOrderId").val();
            blPrintQty = parseFloat($("#lblCanPrintQty").text());
            if (psnTypeId != 0 && printQty > parseInt(blPrintQty)) {
                alert("本次打印数量不可大于可打印数量！");
                $("#txtPrintQty").select()
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreSNPrint.RelesePSN(psnTypeId, labelProdOrderId, labelItemId, printQty);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            $("#lblCanPrintQty").text(blPrintQty - printQty);

            //获取标签信息
            SNInfo = ajax.value;

            /*begin print sn*/
            $("#lblPt").html("<span style='color:green; font-weight:bold;'>释放条码成功！</span><br/>正在排队打印，" + SNInfo.length + "个条码等待打印");
            setTimeout(function () {
                try {
                    print();
                }
                catch (e) {
                    alert(e);
                    $("#lblMessage").html(e);
                }
            }, 30);

            blPrintQty = 0;
        }


        function print() {
            var psnTypeId = $("#ddlSNType").val();
            labelType = psnTypeId;

            switch (labelType) {
                case "0":
                    labelType = -4;
                    labelSequence = 3;
                    break;
                case "-4":
                    labelSequence = 3;
                    break;
                case "-5":
                    labelSequence = 4;
                    break;
                case "-16":
                    labelSequence = 5;
                    break;
                case "-22":
                    labelSequence = 7;
                    break;
                default:
                    labelType = -4;
                    labelSequence = 3;
            }
            if (getDocumentInfo()) {
                mesLabLabelPrint(SNInfo);
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
        var printCount = 1;        //打印份数：默认一次

        var templateGroup = 1;//新打印连板数

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
                templateGroup = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintTemplateGroup(labelDocumentId).value;
                lableTypeQty = entity.PlateQty;
                printName = $("#selPrintersList").val();//entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
                printCount = entity.Print_Qty;
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
