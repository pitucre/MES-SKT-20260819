<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintSplitMaterial.aspx.cs" MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.PrintSplitMaterial" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server" ViewStateMode="Enabled">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips"  style="text-align: center">
    </div>

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                物料条码
            </td>
            <td class="Field2">
                <input type="text" id="txtSerialNumber" class="TextBox" runat="server" />
            </td>
            <td class="Label2">
                <%=Resources.lang.Status%>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlMaterialStatus"  >
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                产品名称
            </td>
            <td class="Field2">
                <input type="text" id="txtItemName" class="TextBox" runat="server" />
            </td>
            <td class="Label2">
                供应商
            </td>
            <td class="Field2">
                <input type="text" id="txtVendor" class="TextBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                分料时间
            </td>
            <td class="Field2">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
            </td>
            <td class="Label2">
                分料人
            </td>
            <td class="Field2">
                <input type="text" id="txtCreateBy" class="TextBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                打印机名称
            </td>
            <td class="Field2" colspan="3">
                <select id="selPrintersList" style="width: 250px;">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" 
         onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码" ItemStyle-Width="10%" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" ItemStyle-Width="10%"/>
            <asp:BoundField DataField="ItemDesc" HeaderText="产品描述" ItemStyle-Width="25%" />
            <asp:BoundField DataField="BalanceQty" HeaderText="数量"  ItemStyle-Width="10%"/>
            <asp:BoundField DataField="WOStatus" HeaderText="状态" ItemStyle-Width="10%" />
            <asp:BoundField DataField="CreateBy" HeaderText="分料人" ItemStyle-Width="8%" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="生成物料条码时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"
                SortExpression="CreateDateTime" ItemStyle-Width="27%" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetSplitMaterialInfo" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
       <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(function () {
            $(".DateTimeBox").datepicker({
                showOn: "both",
                buttonImageOnly: true,
                buttonText: "<%=Resources.lang.ChooseDate %>"
            });

            if ('<%=Request.Form["selStatus"] %>' != null && '<%=Request.Form["selStatus"] %>' != "") {
                $("#selStatus").val('<%=Request.Form["selStatus"] %>');
            }

            bindPrinters('selPrintersList');
        });

        //离线条码打印
        function Print() {
            var materialUnitIdStr = getRecordIdString();
            if (materialUnitIdStr == "") return;

            var ajaxPrint = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialInfo(materialUnitIdStr);
            if (ajaxPrint.error != null) {
                alert(ajaxPrint.error.Message)
                return false;
            }

            var list = ajaxPrint.value;

            if (list.length == 0) {
                alert("条码验证失败！");
                return false;
            }

            try {
                labelItemId = list[0].ItemId;

                //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                getDocumentInfo();

                //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                SNInfo = {};
                SNInfo.SNList = [];

                for (var i = 0; i < list.length; i++) {
                    SNInfo.SNList.push(list[i].SerialNumber);
                }

                mesLabLabelPrint();
            }
            catch (e) {
                alert(e)
                $("#lblMessage").html(e);
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
        var labelType = -3;          //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 2;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        /*打印机插件未引用成功的消息内容*/
      


     


        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                //printName = entity.PrinterName;
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }


        //codesoft打印  Lab模板方式
        var printCount = 1;
        function mesLabLabelPrint() {
            var printdata = [];
            try {
                printCount = 1;
                lableArr = SNInfo.SNList;
                for (var i = 0; i < lableArr.length; i++) {
                    var labelStr = lableArr[i];
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }
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
            ibs = 3;
            $("#lblMessage").html("打印条码完成！")
            setTimeout(function () {
                $("#lblMessage").html('');
            }, 3000);
        }


        function recordPrint(sn) {
            var printRecodeEntity = {};
            printRecodeEntity.RecordId = -1;
            printRecodeEntity.ActionType = 1;
            printRecodeEntity.PrintType = -3;
            printRecodeEntity.PrintKey = sn;
            printRecodeEntity.StationId = -1;
            printRecodeEntity.ResourceId = -1;
            var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
            if (ajaxPrintRecodes.error != null) {
                alert(ajaxPrintRecodes.error.Message);
                $("#lblMessage").html(ajaxPrintRecodes.error.Message);
                return false;
            }
        }
        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/
    </script>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
</asp:Content>

