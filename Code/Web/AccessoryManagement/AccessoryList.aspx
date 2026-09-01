<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="AccessoryList.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryList" Title="Accessory List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">辅料条码</td>
            <td class="Field3">
                <asp:TextBox ID="txtAccessoryNO2" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3"><%= Resources.lang.AccessoryCodoe %></td>
            <td class="Field3">
                <asp:TextBox ID="txtAccCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">状态</td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="dllStatus">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="1">在库</asp:ListItem>
                    <asp:ListItem Value="2">解冻</asp:ListItem>
                    <asp:ListItem Value="7">搅拌</asp:ListItem>
                    <asp:ListItem Value="4">使用中</asp:ListItem>
                    <asp:ListItem Value="6">报废</asp:ListItem>
                    <asp:ListItem Value="8">用完</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SerialNumber"  HeaderText="辅料条码" />
            <asp:BoundField DataField="AccessoryCodoe" HeaderText="<%$ Resources:lang, AccessoryCodoe %>" />
            <asp:BoundField DataField="AccessoryName" HeaderText="<%$ Resources:lang, AccessoryName %>" />
            <asp:BoundField DataField="AccessoryTypeName" HeaderText="<%$ Resources:lang, AccessoryTypeName %>" />
            <asp:BoundField DataField="Lot" HeaderText="<%$ Resources:lang, LotCode %>" />
            <asp:BoundField DataField="StatusName" HeaderText="<%$ Resources:lang, Status %>" />
            <asp:BoundField DataField="UserTime" HeaderText="使用时长(H)" />
            <asp:BoundField DataField="ProdDateTime" HeaderText="<%$ Resources:lang, ProdDateTime %>"  DataFormatString="{0:yyyy-MM-dd}"/>
            <asp:BoundField DataField="StartThawTime" HeaderText="解冻开始时间" />
            <asp:BoundField DataField="StartStirTime" HeaderText="搅拌开始时间"/>
            <asp:BoundField DataField="UnsealTime" HeaderText="上料时间" />
            <asp:BoundField DataField="ReturnTime" HeaderText="退回时间" />
            <asp:BoundField DataField="LoseTime" HeaderText="<%$ Resources:lang, LoseTime %>" />
            <asp:BoundField DataField="SupplierCode" HeaderText="<%$ Resources:lang, SupplierCode %>" />
            <asp:BoundField DataField="SupplierName" HeaderText="供应商名称" />
           <%-- <asp:BoundField DataField="InStockQty" HeaderText="<%$ Resources:lang, InStockQty %>" />--%>
            <asp:TemplateField HeaderText="<%$ Resources:lang, InStockQty %>" SortExpression="InStockQty" >
                <ItemTemplate>
                    <%#Eval("InStockQty","{0:G0}").ToString()%>
                </ItemTemplate>
            </asp:TemplateField>
            <%--<asp:BoundField DataField="CurrentQty" HeaderText="<%$ Resources:lang, CurrentQty %>" />--%>
            <%--<asp:BoundField DataField="StartThawTime" HeaderText="<%$ Resources:lang, StartThawTime %>" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <%--<asp:BoundField DataField="UnsealTime" HeaderText="<%$ Resources:lang, UnsealTime %>" />--%>
             <asp:BoundField DataField="CreateTime" HeaderText="创建时间"  DataFormatString="{0:yyyy-MM-dd}"/>

            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />            
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间"  DataFormatString="{0:yyyy-MM-dd}"/>

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.AccessoryManagement.BLL.Accessory" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdFIFO" runat="server" Value="-1" ClientIDMode="Static"/>

    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>

    <script type="text/javascript">
        var UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        isMultiple = false;
        var openWinUrl = "";
        var msg = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var labelItemId = -1; //打印产品


        $(function () {
            gridCellsChangeNo = true;
            $("#ckbMultipleSelected").parent().css("display", "none");

            /*setTimeout(function () {
                bindPrinters();
            }, 100);*/

        });
        function Register() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryEdit.aspx?name=AccessoryRegister&ID=-1";
            dialog({ title: "<%=Resources.Pages.AccessoryAdd %>", src: openWinUrl, width: 700, height: 400 });
        }
        function RegisterGrn() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryRegister.aspx?name=AccessoryRegisterGrn";
            dialog({ title: "<%=Resources.Pages.AccessoryRegisterGrn %>", src: openWinUrl, width: 800, height: 400 });
        }

        function Edit() {
            //失效时间
            var trObj = $('input[name="chkSelect"]:checked').parent().parent()
            var dates = trObj.find("td:eq(" + GetGridCellsChangNo(13) + ")").html();

            var Status = trObj.find("td:eq(" + GetGridCellsChangNo(6)+ ")").html();
            if (Status == '报废') {
                alert("辅料已报废");
                return false;
            }
            if (Status != '在库') {
                alert("辅料条码非【在库】状态，不允许编辑！");
                return false;
            }

            var myDate = new Date();
            //获取当前年
            var year = myDate.getFullYear();
            //获取当前月
            var month = myDate.getMonth() + 1;
            //获取当前日
            var date = myDate.getDate();
            var h = myDate.getHours();       //获取当前小时数(0-23)
            var m = myDate.getMinutes();     //获取当前分钟数(0-59)
            var s = myDate.getSeconds();

            var now = year + '-' + p(month) + "-" + p(date) + " " + p(h) + ':' + p(m) + ":" + p(s);
            if ((new Date(now.replace(/-/g, "\/"))) > (new Date(dates.replace(/-/g, "\/")))) {
                alert("辅料已过期");
                return false;
            }
            

            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryEdit.aspx?name=AccessoryEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.AccessoryEdit %>", src: openWinUrl, width: 700, height: 400 });
        }
        function p(s) {
            return s < 10 ? '0' + s : s;
        }
     
        //报废
        function Delete() {
            var SN = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(" + GetGridCellsChangNo(1) + ")").html();
            if (SN == "" || SN == null) {
                alert("请选择记录");
                return false;
            }
            //var idStr = getDeletingRecordIdString();
            if (confirm("是否进行报废操作")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(SN, 6, UserName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                mes = "";
                msg = SN + " 条码，报废成功!"
                alert(msg);
                document.forms[0].submit();
                //window.location.reload();
            }
        }

        //删除 add by peter on 2021-2-3
        function Delete2() {

            var Status = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(" + GetGridCellsChangNo(6) + ")").html();
            if (Status != '在库') {
                alert("只有在库的辅料条码才可以删除！");
                return false;
            }
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }


        //解冻
        function Thaw() {

            var SN = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(" + GetGridCellsChangNo(1) + ")").html();
            if (SN == "" || SN == null) {
                alert("请选择记录");
                return false;
            }
            if (confirm("是否进行解冻作")) {

                //权限管控，若无权限则需遵循FIFO原则
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.CheckGrnAccessoryPrepare(SN);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                else {
                    var list = ajax.value[0];
                    if (list.Flage == 0) {
                        if ($("#hdFIFO").val() !== "1") {//没有取消FIFO的权限
                            alert("请遵循先进先出或优先使用退回的辅料原则，请先使用GRN为'" + list.SerialNumber + "'的辅料");
                            return false;
                        }
                        if (!confirm("您没有遵循先进先出或优先使用退回的辅料原则，该物料有更早的GRN为'" + list.SerialNumber + "'的辅料，是否确认操作？")) {
                            return false;
                        }
                    }
                }

                //解冻时校验
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryThawValidate(SN);
                if (ajax.value != null && ajax.value != "") {
                    if (confirm(ajax.value)) {
                        //确认报废
                        ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(SN, 6, UserName);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return false;
                        }
                        alert("报废成功");
                        document.forms[0].submit();
                        return false;
                    }
                    return false;
                }
                // 2为解冻
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(SN, 2, UserName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                mes = "";
                msg = SN + " 条码，解冻成功!"
                alert(msg);
                document.forms[0].submit();
                //window.location.reload();
            }
        }
        //搅拌
        function Stir() {
            var SN = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(" + GetGridCellsChangNo(1) + ")").html();
            if (SN == "" || SN == null) {
                alert("请选择记录");
                return false;
            }
            if (confirm("是否进行搅拌操作")) {
                //搅拌时校验
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryThawValidate(SN);
                if (ajax.value != null && ajax.value != "") {
                    if (confirm(ajax.value)) {
                        //确认报废
                        ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(SN, 6, UserName);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return false;
                        }
                        alert("报废成功");
                        document.forms[0].submit();
                        return false;
                    }
                    return false;
                }
                //搅拌
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(SN, 7, UserName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                mes = "";
                msg = SN + " 条码，搅拌成功!"
                alert(msg);
                document.forms[0].submit();
            }
        }
        //发料不需要，功能暂不用
        function SendMaterial() {
            var SN = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(" + GetGridCellsChangNo(1) + ")").html();
            if (SN == "" || SN == null) {
                alert("请选择记录");
                return false;
            }
            if (confirm("是否进行发料操作")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(SN, 3, UserName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                mes = "";
                msg = SN + " 条码，发料成功!"
                alert(msg);
                document.forms[0].submit();
                //window.location.reload();
            }
        }
        //退回
        function Return() {
            var SN = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(" + GetGridCellsChangNo(1) + ")").html();
            if (SN == "" || SN == null) {
                alert("请选择记录");
                return false;
            }
            if (confirm("是否进行退回操作")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryOperation(SN, 5, UserName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                mes = "";
                msg = SN + " 条码，退回成功!"
                alert(msg);
                document.forms[0].submit();
                //window.location.reload();
            }
        }

        function Print() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryPrintEdit.aspx?name=AccessoryPrint&ID=-1";
            dialog({ title: "<%=Resources.Pages.AccessoryPrint %>", src: openWinUrl, width: 700, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }


        //重打印 add by peter on 2021-2-3
        function RepairPrint() {

            var SN = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(" + GetGridCellsChangNo(1) + ")").html();
            if (SN == "" || SN == null) {
                alert("请选择记录");
                return false;
            }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryRePrint.aspx?name=AccessoryRePrint&SerialNumber=" + SN;
            dialog({ title: mesLang("重打印辅料条码"), src: openWinUrl, width: 450, height: 210 });

            //根据辅料代码获取物料Id
            //var accessoryListId = getOneRecordId();
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.GetInfo(accessoryListId);
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}
            //var info = ajax.value;
            //if (info != null) {
            //    labelItemId = info.ItemId;
            //}

            //$("#lblMessage").html("正在排队打印，请稍候！");
            //setTimeout(function () {
            //    try {

            //        //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            //        SNInfo = {};
            //        SNInfo.SNList = [];
            //        SNInfo.SNList.push(SN);
            //        if (SNInfo.SNList.length == 0) return false;
            //        //根据打印方式决定 调用ZPL还是Lab打印
            //        usePrinGRNMethod();
            //    }
            //    catch (e) {
            //        $("#lblMessage").html(e);
            //    }
            //}, 30);
        }


          /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelStationId = -1;    //工位Id
        var labelType = -17;          //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 6;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        //获取物料条码文档模板基础信息
        function getGRNDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                var entity = ajax.value;
                if (entity == null) {
                    alert("未找到打印模板信息");
                    return false;
                }
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //获取打印机名称值
                //printName = $("#selPrintersList").val();
                printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }

        //获取包装箱条码文档模板基础信息
        function getCartonDocumentInfo() {
            labelType = -4; //包装类型
            labelSequence = 3;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //获取打印机名称值
                //printName = $("#selPrintersList").val();
                printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }

        //根据打印方式决定 调用ZPL还是Lab打印
        function usePrinGRNMethod() {
            getGRNDocumentInfo();
            mesLabLabelPrint(1);
        }

        function usePrintCartonMethod() {
            getCartonDocumentInfo();
            mesLabLabelPrint(2);
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint(printType) {
            lableArr = SNInfo.SNList;

            var labelStr = "";
            var printdata = [];
            for (var i = 0; i < lableArr.length;) {
                //连片数
                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    //每次重置一下
                    labelStr = "";
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            //根据联板数，拼接SN字符串。 
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }
                i = i + lableTypeQty; //连片的递增
                //获取标签模板中的标签值 集合
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                if (ajaxLabContent.error == null) {
                    try {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }

                    } catch (e) {
                        printdata = [];
                        alert(e);
                        $("#lblMessage").html(e);
                        return false;
                    }
                }
                else {
                    printdata = [];
                    alert(ajaxLabContent.error.Message);
                    $("#lblMessage").html(ajaxLabContent.error.Message);
                    return false;
                }
            }
            if (printdata.length == 0)
                return;
            try {
                sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
                ibs = 3;
                setTimeout(function () {
                    $("#lblMessage").html('条码打印完成!');               
                }, 300);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
            
        }
    </script>
</asp:Content>

