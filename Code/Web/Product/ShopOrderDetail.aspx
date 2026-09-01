<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="ShopOrderDetail.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ShopOrderDetail" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <div id="lblMessage" style="background: yellow; padding: 3px; border: 1px solid rgb(255, 236, 139); border-image: none; color: red; display: none;"></div>
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">工单号
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtShopOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">条码
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">镭雕状态
            </td>
            <td class="Field4">
                <asp:DropDownList ID="ddlIsLaserCarving" runat="server" AutoPostBack="false">
                    <asp:ListItem Value="-1" Text="请选择" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="1" Text="是"></asp:ListItem>
                    <asp:ListItem Value="2" Text="分配"></asp:ListItem>
                    <asp:ListItem Value="0" Text="否"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label4">当前工序
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(8)" value="..." />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="OrderNO" HeaderText="工单号" />
            <asp:BoundField DataField="SerialNumber" HeaderText="条码" />
            <asp:BoundField DataField="PassResult" HeaderText="过站结果" />
            <asp:BoundField DataField="BatchQty" HeaderText="条码数量" />
            <asp:BoundField DataField="CreateTime" HeaderText="条码生成时间" />
            <asp:BoundField DataField="LaserCarvingStatus" HeaderText="镭雕状态" />
            <asp:BoundField DataField="Station" HeaderText="当前工序" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Order.BLL.ShopOrder"
        SelectMethod="GetShopOrderDetail" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdnItemSNTemplate" runat="server" Value="" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var flag = -1;
        var modifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

        $(document).ready(function () {
            $("div.noInstallPrintPlugin").remove();
        });
        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValue(list) {
            if (flag == 8) {
                $("#txtStation").val(list[0][1]);
                flag = -1;
            }
        }
        function printItemSn() {

            var idsStr = getRecordIdString();
            if (!idsStr) return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ShopOrderDetailRePrint.aspx?name=ShopOrderDetailRePrint&ids=" + idsStr;
            dialog({ title: "<%=Resources.Pages.PreSNRePrint %>", src: openWinUrl, width: 450, height: 200 });

        }

        //恢复
        function Recovery() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            var entity = { UIDs: idStr, ModifyBy: modifyBy };

            if (confirm("确认要恢复吗？")) {
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspLaserCarvingRecovery", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("恢复成功！");
                document.forms[0].submit();
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
        var labelType = -2;          //标签类型  (1产品，2GRN, 3单号......)
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
                    printName = entity.PrinterName;
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


        function mesLabLabelPrint(list) {
            if (list.length == 0) {
                ibs = 3;
                setTimeout(function () {
                    $("#lblMessage").html('');
                    $("#lblMessage").hide();
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

            $("#lblMessage").html("发送条码【" + list.join() + "】打印指令到打印机,请勿关闭窗口！<br/> 当前剩余打印数量【" + newlist.length + "】");
            $("#lblMessage").show();
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
