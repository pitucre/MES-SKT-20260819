<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="GRNPackList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.GRNPackList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                包装箱条码
            </td>
            <td class="Field2">
                <input type="text" id="txtSN" class="TextBox" runat="server" />
            </td>
            <td class="Label2">
                物料条码
            </td>
            <td class="Field2">
                <input type="text" id="txtGRNSN" class="TextBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                包装箱状态
            </td>
            <td class="Field2">
                   <asp:DropDownList ID="selCartonStatus" runat="server">
                    <asp:ListItem Text="全部" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="打开" Value="1"></asp:ListItem>
                    <asp:ListItem Text="关闭" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                供应商
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtVendorCode" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" value="..." id="btnVencode" class="ButtonBox" title="选择供应商" onclick="chooseVendor()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                打印机名称
            </td>
            <td class="Field2">
                <select id="selPrintersList" style=" width: 250px; ">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
             <td class="Label2">
                采购单号
            </td>
            <td class="Field2">
                <input type="text" id="txtPOCode" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server"  OnRowDataBound="GridView1_OnRowDataBound" >
        <Columns>
            <asp:BoundField DataField="FBillNO" HeaderText="<%$Resources:lang,POCode %>" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$Resources:lang,MaterialCode %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$Resources:lang,MaterialName %>" />
            <asp:BoundField DataField="VendorCode" HeaderText="<%$Resources:lang,Supplier %>" />
            <asp:BoundField DataField="PkdLoc" HeaderText="<%$Resources:lang,CartonStatus %>"  HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="GRNStr" HeaderText="<%$Resources:lang,ContainerSN %>" />
          <%--  <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CartonCreateDateTime %>"
                DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />--%>
            <asp:BoundField DataField="SerialNumber" HeaderText="<%$Resources:lang,GRN %>" />
            <asp:TemplateField HeaderText="<%$Resources:lang,MinPackageQty %>" SortExpression="Quantity"  HeaderStyle-Width="120px">
                <ItemTemplate>
                    <%#Eval("Quantity","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
  
            <asp:BoundField DataField="CreateBy" HeaderText="包装人"  HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="PackTime" HeaderText="包装时间"  HeaderStyle-Width="140px"/>
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetAllGRNCarton" SelectCountMethod="GetPackedGRNCartonCount">
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
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(document).ready(function () {
            bindPrinters('selPrintersList');
        });

  
        //解包装
        function UnBindPacking() {
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 6 改为 GRNStr
            var cartonSn = getOneRecordCellTextByFiled("GRNStr");
            if (cartonSn == "") {
                return false;
            }
            if (!confirm("<%=Resources.Messages.ConfirmToUnpack %>")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.UnPack(cartonSn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.UnpackSuccessful %>");
            UpdateList(cartonSn);
        }

        //移除
        function Remove() {

            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 6 改为 GRNStr
            var cartonSn = getOneRecordCellTextByFiled("GRNStr");
            if (cartonSn == "") {
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetCartonStatus(cartonSn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var cartonStauts = ajax.value;
            if (cartonStauts == 0) {
                alert("<%=Resources.Messages.UnpackFirstly %>");
                return false;
            }
            dialog({ title: "<%=Resources.Pages.Material_RemoveGRN %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/RemoveGRN.aspx?name=Material_RemoveGRN&SN=" + escape(cartonSn) + "&rnd=" + Math.random(), width: 450, height: 400 });

        }

        //完成包装
        function PackEnd() {
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 6 改为 GRNStr
            var cartonSn = getOneRecordCellTextByFiled("GRNStr");
            if (cartonSn == "") {
                return false;
            }
            if (confirm("<%=Resources.Messages.ConfirmToCloseTheCarton %>")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ClosePack(cartonSn);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert(" <%=Resources.Messages.CartonBeClosedSuccessful %>" + cartonSn);
                refresh();
                printCartonLabel(cartonSn);
            }
        }

        /*删除*/
        function Delete() {
            var id = getOneRecordId();
            if (id == "") {
                return false;
            }
            if (!confirm("<%=Resources.Messages.ConfirmToDeleteCarton %>")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.DeleteCarton(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.DeleteCartonSuccessful %>");
            document.forms[0].submit();
        }
        //打印包装箱
        function printCartonLabel(grn) {
            //获取包装箱物料信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            labelItemId = entity.PartId

            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            getDocumentInfo();

            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.SNList.push(grn);
            if (SNInfo.SNList.length == 0) return false;

            mesLabLabelPrint();
        }


        //可批量重打印
        function RepairPrint() {
            //验证相同的物料才可以批量重打印
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 3 改为 ItemName
            var ItemName = getOneRecordCellTextByFiled("ItemCode");
            var r = getRepeatData(ItemName);
            if (r != "") {
                alert(r);
                $(".ListTable :checkbox").attr("checked", false);
                return false;
            }
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 6 改为 GRNStr
            var cartonSn = getOneRecordCellTextByFiled("GRNStr");
            if (cartonSn == "") {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(cartonSn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            labelItemId = entity.PartId;

            $("#lblMessage").html("正在排队打印，请稍候！");
            setTimeout(function () {
                try {

                    //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                    getDocumentInfo();
                    var snStr = "";
                    SNInfo = {};
                    SNInfo.SNList = [];
                    if (!isMultiple) {
                        //xiang.yan 2024-4-28  列取值由索引改为列明
                        // 6 改为 GRNStr
                        snStr = getOneRecordCellTextByFiled("GRNStr");
                        SNInfo.SNList.push(snStr);
                    } else {
                        snStr = getRecordCellTextsByFiled("GRNStr");
                        SNInfo.SNList = snStr.split(",");
                        //$("input[name='chkSelect']:checked").each(function () {
                        //    snStr = $(this)[0].parentElement.parentElement.cells[6].innerText;
                        //    SNInfo.SNList.push(snStr);
                        //});
                    }
                    if (SNInfo.SNList.length == 0) return false;
                    //根据打印方式决定 调用ZPL还是Lab打印
                    mesLabLabelPrint();
                    if (snStr != "")
                        creatservicelog("补打包装箱", "物料管理|包装箱列表", "重打印", snStr, "重打印包装箱【" + snStr+ "】");
                }
                catch (e) {
                    $("#lblMessage").html(e);
                    creatservicelog("补打包装箱", "物料管理|包装箱列表", "重打印", "打印异常", "重打印包装箱异常：【" + e + "】");
                }
            }, 30);

        }

        //验证相同的物料才可以批量重打印
        function getRepeatData(input) {
            var strResult = "";
            var ary = input.split(",");
            for (var i = 0; i < ary.length; i++) {
                var a = ary[0];
                var c = ary[i];
                if (c != a) {
                    strResult = "相同的物料才可以批量重打印!";
                }
            }
            return strResult;
        }

        /*刷新页面*/
        function refresh() {
            document.forms[0].submit();
        }

        /*用于弹出窗口返回值更新列表*/
        function UpdateList(Sn) {
            $("#<%=this.txtSN.ClientID %>").val(Sn);
            document.forms[0].submit();
        }

        function chooseVendor() {
            dialog({ title: "选择供应商", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&CallBackFunc=setVendor&rnd=" + Math.random(), width: 650, height: 400 });
        }

        function setVendor(list) {
            $("#<%=this.txtVendorCode.ClientID %>").val(list[0][1]);
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -14;          //标签类型 -2、产品 -3、GRN -4、包装箱 -5、卡板
        var labelSequence = 8;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径


        //获取文档模板基础信息
        function getDocumentInfo() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //printName = entity.PrinterName;           //打印机名称
                //获取打印机名称值
                printName = $("#selPrintersList").val();

                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint() {
            //从已释放的标签信息集合中，获取SN序列号集合。
            lableArr = SNInfo.SNList;
            var labelStr = "";
            var printdata = [];
            for (var i = 0; i < lableArr.length; ) {
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
                        alert(e);
                        printdata = [];
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
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
          
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
    </script>
    <script src="../Content/js/skt.utility.rowspan.min.js" type="text/javascript"></script>
</asp:Content>
