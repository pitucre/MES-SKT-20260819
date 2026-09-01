    <%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="BatchSendRepair.aspx.cs" Inherits="SKT.LeanMES.Web.Client.BatchSendRepair" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    工单<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox><input type="button" id="btnSelectOrder" class="ButtonBox" value="..." title="Select"
                        onclick="openChoosePage(44);" />
                    <asp:HiddenField ID="hdnOrderId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td class="Label2">
                    线体<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtLineName" runat="server"></asp:TextBox><input type="button" id="btnSelectLine" class="ButtonBox" value="..." title="Select"
                        onclick="openChoosePage(21);" />
                    <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    工序<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtStationName" runat="server"></asp:TextBox><input type="button" id="btnSelectStation" class="ButtonBox" value="..." title="Select"
                        onclick="openChoosePage(8);" />
                    <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td align="center" colspan="3">
                    <input type="button" id="btnSavePrint" style="width: 82px; cursor: pointer;" value=" 送修打印 " onclick="SavePrint();" />
                <input type="button" id="btnRepeatPrint" style="width: 82px; cursor: pointer;" value=" 补打 " onclick="RepeatPrint();" />
                </td>
            </tr>
            <tr>
                <td align="right" class="Label2">
                    打印机名称
                </td>
                <td align="left" colspan="3">
                    <select id="selPrintersList" style=" width: 250px; ">
                    </select>
                    <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
                </td>
            </tr>
        </table>
        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <div class="ListTableTitle">
        不良列表&nbsp;
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="OrderNo" HeaderText="工单" />
            <asp:BoundField DataField="LineName" HeaderText="线体" />
            <asp:BoundField DataField="StationName" HeaderText="工序" />
            <asp:BoundField DataField="NCCode" HeaderText="不良现象" />
            <asp:TemplateField HeaderText="数量" SortExpression="NGQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("NGQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="SendRepairSN" HeaderText="已打批次条码" />
        </Columns>
    </asp:GridView>
   <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Plan.BLL.LinePlan"
        SelectMethod="GetBatchSNNcDataInfoAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnHasCopy" runat="server" Value="-1" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var bomName = "";
        var flag = -1;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

        $(function () {
            bindPrinters('selPrintersList');
        });

        //送修打印
        function SavePrint() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;

            var info = { ID: idStr, UserName: userName };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspBatchSendRepairSave", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            var mySNArr = listOrder[0].SNArr;
            labelItemId = listOrder[0].ItemID;
            labelProdOrderId = listOrder[0].ProdOrderID;
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
            var idStr = getRecordIdString();
            if (idStr == "") return false;

            var info = { ID: idStr, UserName: userName };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspBatchSendRepairRepeatPrint", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            var mySNArr = listOrder[0].SNArr;
            labelItemId = listOrder[0].ItemID;
            labelProdOrderId = listOrder[0].ProdOrderID;
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

        function openChoosePage(flags) {
            var condition = "";
            var myOrderNo = $("#<%=this.txtOrderNo.ClientID %>").val();
            /*如果是选择工序，并且已经选好工单号，则根据工单路由过滤工序*/
            if (flags == 8 && myOrderNo!="") {
                var info = { OrderNo: myOrderNo };
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetOrderRouterStationInfo", JSON.stringify(info));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var list = JSON.parse(ajax.value);
                var listOrder = list.data;
                var myStationIDStr = listOrder[0].StationID;
                condition = " StationId in(SELECT strvalue FROM dbo.Fn_convertstringtotablestring3('" + myStationIDStr +"',','))";
            }
            flag = flags;
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 650,
                height: 350
            });
        }

        function getChooseValue(list) {
            //工单
            if (flag == 44) {
                $("#<%=this.txtOrderNo.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnOrderId.ClientID %>").val(list[0][0]);
            }
            //线别
            if (flag == 21) {
                $("#<%=this.txtLineName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnLineId.ClientID %>").val(list[0][0]);
            }
            //工序
            if (flag == 8) {
                $("#<%=this.txtStationName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
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
                    return;
                }
            } else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return;
            }
            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, null,<%=ConfigurationManager.AppSettings["PrintType"]%>);

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
