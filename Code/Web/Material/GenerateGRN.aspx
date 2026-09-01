<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="GenerateGRN.aspx.cs" Inherits="SKT.LeanMES.Web.Material.GenerateGRN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>

    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%=Resources.lang.VendorCode %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <input type="hidden" value="" id="hdnVendorCode" />
                <input type="text" id="txtVendorCode" class="TextBox" disabled="disabled" /><input
                    type="button" id="btnSelectVendorCode" class="ButtonBox" value="..." onclick="selectVendor()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.MaterialName %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <input type="hidden" value="-1" id="hdnItemId" />
                <input type="text" id="txtItemName" class="TextBox" disabled="disabled" value="" /><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.AC_OBA_LotSize %><span class="tooltips" title="<%=Resources.lang.BatchPrintGrnQty %>"></span><em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtGRNQty" class="NumericBox" value="1" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" />
            </td>
            <td class="Label2">
                <%=Resources.lang.MinPackageQty%><em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtQty" class="NumericBox" value="0" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.LotSize %>
            </td>
            <td class="Field2">
                <input type="text" id="txtLotCode" class="TextBox" />
            </td>
            <td class="Label2">
                <%=Resources.lang.ProduceDate %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtProdDate" class="DateTimeBox" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
    </table>

    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips"  style="text-align: center">
    </div>

    <!--打印插件的容器-->
    <div id="printerHolder">
        <!--lab-->
        <object classid="clsid:8542E25D-C6AE-47A9-8986-40ADBC2EAF7D" id="labelPrintingPluginLab" width="0"
        height="0" >
        </object>

        <!--zpl-->
        <object classid="clsid:F843DB2A-40AF-4D16-B695-F87A2DD566C2" id="labelPrintingPluginZPL" width="0"
        height="0" >
        </object>
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>   
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script> 
    <script type="text/javascript">

        var FLAG = -1;
        var IS_VENDOR = (FLAG == -1) ? false : true;
        var VENDOR_CODE = "";
        var hdnItemId = -1;

        $(function () {
            $(".DateTimeBox").datepicker({
                showOn: "both",
                buttonImageOnly: true,
                buttonText: "<%=Resources.lang.ChooseDate %>"
            });
        });

        $(document).ready(function () {

            $("#txtVendorCode").focus();
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

            InityPrintingPlugin();

        });

        $(function () {
            if (IS_VENDOR) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetVendorCode();
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                VENDOR_CODE = ajax.value;
                var vdc = "";
                if (VENDOR_CODE.indexOf("|1") >= 0) {
                    vdc = VENDOR_CODE.replace("|1", "");
                }
                else {
                    vdc = VENDOR_CODE;
                }
                $("#hdnVendorCode").val(vdc);
                $("#txtVendorCode").val(vdc);
                $("#txtVendorCode").attr("disabled", "disabled");
                $("#btnSelectVendorCode").attr("disabled", "disabled");

            }
        });

        function selectItem() {
            if (IS_VENDOR) {
                if (VENDOR_CODE.toUpperCase().indexOf("K") == 0) {
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=40&Multiple=false&CallBackFunc=setCustomerItem&rnd=" + Math.random(), width: 500, height: 200 });
                }
                else {
                    if (VENDOR_CODE.indexOf("|1") >= 0) {
                        alert("<%=Resources.Messages.NoVendorItem %>");
                        return false;
                    }
                    var searchSettings = "po_vend='" + VENDOR_CODE + "'";
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=59&PageCondition=" + escape(searchSettings) + "&Multiple=false&rnd=" + Math.random(), width: 500, height: 200 });
                }
            }
            else {
                var v = $("#hdnVendorCode").val();
                if (v == "") {
                    alert("<%=Resources.Messages.SelectVendorCode %>");
                    $("#btnSelectVendorCode").focus();
                    return false;
                }
                if (v.toUpperCase().indexOf("K") == 0) {
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=40&Multiple=false&CallBackFunc=setCustomerItem&rnd=" + Math.random(), width: 500, height: 200 });
                }
                else {
                    var SearchCondition = "po_vend='" + v + "'";
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=59&PageCondition=" + escape(SearchCondition) + "&Multiple=false&rnd=" + Math.random(), width: 500, height: 200 });
                }
            }
        }
        //选择供应商
        function selectVendor() {
            var SearchCondition = "userid=" + "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserId%>";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=61&Multiple=false&PageCondition=" + escape(SearchCondition) + "&CallBackFunc=setVendorCode&rnd=" + Math.random(), width: 500, height: 200 });
        }

        function getChooseValue(list) {
            $("#txtItemName").val(list[0][1]);
            $("#hdnItemId").val(list[0][0]);
            $("#txtGRNQty").focus();
            $("#txtItemName").attr("disabled", "disabled");
        }

        function setVendorCode(list) {
            $("#hdnVendorCode").val(list[0][1]);
            $("#txtVendorCode").val(list[0][1]);
            $("#txtVendorCode").attr("disabled", "disabled");
            $("#txtItemName").val("");
            $("#hdnItemId").val("");
        }

        function setCustomerItem(list) {
            $("#txtItemName").val(list[0][1]);
            $("#hdnItemId").val(list[0][0]);
            $("#txtGRNQty").focus();
            $("#txtItemName").attr("disabled", "disabled");
        }

        var txtDateCode;
        function Save() {
            hdnItemId = $("#hdnItemId").val();
            labelItemId = hdnItemId;
            var txtGRNQty = $("#txtGRNQty").val();
            var txtQty = $("#txtQty").val();
            var txtLotCode = $("#txtLotCode").val();            
            var txtVendorCode = $("#hdnVendorCode").val();
            var errStr = "";
            txtDateCode = $("#txtProdDate").val();
            if (txtVendorCode == "") {
                errStr += "<%=Resources.Messages.SelectVendorCode %>\n";
            }           
            if (hdnItemId == -1) {
                errStr += "<%=Resources.Messages.SelectMaterial %>\n";
            }
            if (txtGRNQty == "" || txtGRNQty == "0" || parseFloat(txtQty) <= 0 || txtQty == "") {
                errStr += "<%=Resources.Messages.GRNQtyIsInvalid %>\n";
            }
            var maxlabelcount = '<%=maxLabelCount %>';
            if (parseInt(txtGRNQty) > maxlabelcount) {
                errStr += "<%=Resources.Messages.GenGrnQtyMoreThan %>".format(maxlabelcount) + "\n";
            }
            /*生产日期必须输入 add by watson 2015-03-31*/
            if (txtDateCode == "") {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>\n";
            }
            var cDate = txtDateCode;            
            var reg = new RegExp("-", "g"); /*创建正则表达式*/
            cDate = cDate.replace(reg, "/");
            var iDate = new Date(cDate);
            var toDay = new Date();
            if (Date.parse(iDate) - Date.parse(toDay) > 0) {
                errStr += "<%=Resources.Messages.DateError %>\n";
            }

            if (errStr != "") {
                alert(errStr);
                return false;
            }

            if (!window.confirm("<%=Resources.Messages.ConfirmPrintTheseGRNs %>")) {
                return false;
            }
            $("#lblMessage").html("正在生成GRN，请稍后...");
            setTimeout(function () {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateGRN(hdnItemId, txtGRNQty, txtQty, txtLotCode, txtDateCode, txtVendorCode);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#lblMessage").html(ajax.error.Message);
                    return false;
                }
                var arr = ajax.value;
                if (arr != null) {
                    $("#lblMessage").html("<%=Resources.Messages.GenGrnFinishAndPrintInProcess %>");
                    setTimeout(function () {
                        try {
                            printGRN(arr, txtQty);
                        }
                        catch (e) {
                            alert(e);
                            $("#lblMessage").html(e);
                        }
                    }, 30);
                }
            }, 30);
        }

        var grnArr;
        var itemInfo;
        var vendorSort;       
        var __txtQty = 0;        
        var __txtLeft = 0;
        function printGRN(arr, txtQty) {

            if (arr == null) {
                return false;
            }
            arr[0] = arr[0].substring(0, arr[0].lastIndexOf(","));
            grnArr = arr[0].split(",");
            itemInfo = arr[1].split(",");
            vendorSort = arr[2].split(",");

            
            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            getDocumentInfo();

            //将GRN信息添加到SNInfo的SNInfo.SNList集合中
            SNInfo = {};
            SNInfo.SNList = grnArr;
            SNInfo.ItemInfo = itemInfo;
            SNInfo.VendorSort = vendorSort;

            //根据打印方式决定 调用ZPL还是Lab打印
            usePrinMethod();
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
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径

        /*打印机插件未引用成功的消息内容*/
        NoPrinterPlugin = "<%=Resources.Messages.NoPrinterPlugin %>";
        var NoPrinterPluginLab = "Lab打印插件加载失败！请先安装打印插件！";
        var NoPrinterPluginZPL = "ZPL打印插件加载失败！请先安装打印插件！";
        //打印插件对象
        var labelPrintingPlugin;

        function InityPrintingPlugin() {
            //检查指定插件是否被引用成功
            if (labelPrintWayId == 78) {
                if (document.all.labelPrintingPluginLab.object == null) {
                    $("#noprtplg").html(NoPrinterPluginLab);
                    return false;
                }
                else {
                    $("#noprtplg").html("");
                    //指定插件 赋值给JS打印插件对象  
                    labelPrintingPlugin = document.getElementById("labelPrintingPluginLab");
                    return true;
                }
            } else if (labelPrintWayId == 79) {
                if (document.all.labelPrintingPluginZPL.object == null) {
                    $("#noprtplg").html(NoPrinterPluginZPL);
                    return false;
                }
                else {
                    $("#noprtplg").html("");
                    //指定插件 赋值给JS打印插件对象  
                    labelPrintingPlugin = document.getElementById("labelPrintingPluginZPL");
                    return true;
                }
            }
            else if (document.all.labelPrintingPluginZPL.object == null || document.all.labelPrintingPluginLab.object == null) {
                $("#noprtplg").html(NoPrinterPlugin);
                return false;
            }

        }

        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }

            //初始化打印插件
            InityPrintingPlugin();
        }

        //根据打印方式决定 调用ZPL还是Lab打印
        function usePrinMethod() {
            //根据文档使用的打印方式，决定调用Lab模板方式，还是指令方式。
            if (labelPrintWayId == 78) {
                //codesoft打印  Lab模板方式
                mesLabLabelPrint();
            }
            else if (labelPrintWayId == 79) {
                //指令方式
                mesZPLPrintLabel();
            }
        }

        //codesoft打印  Lab模板方式
        function mesLabLabelPrint() {

            //从已释放的标签信息集合中，获取SN序列号集合。
            lableArr = SNInfo.SNList;

            for (var i = 0; i < lableArr.length; ) {


                //lableArr[i]
                //找到doucumentId打印文档id
                var labelStr = "";

                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            //根据联板数，拼接SN字符串。 
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }

                i = i + lableTypeQty;

                //每发送一次打印指令 初始化标签内容变量。
                labelContent = "";

                //获取标签模板中的标签值 集合
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);

                if (ajaxLabContent.error == null) {
                    //接收打印的ZPL标签  
                    try {
                        var list = ajaxLabContent.value;

                        if (list.length > 0) {

                            for (var h = 0; h < list.length; h++) {
                                labelContent += '{name:"' + list[h].LabelName + '",value:"' + list[h].LabelValue + '"}' + ",";
                            }

                            labelContent = labelContent.substring(0, labelContent.length - 1);
                            labelJsonData = "[{LabelContent:[" + labelContent + "]}]";

                            labelPrintingPlugin.PrintLabel(tempatePath, labelJsonData);

                            //条码打印记录
                            var labelSNArr;
                            if (lableTypeQty == 1) { //单板
                                labelSNArr = labelStr.split(",")[0];
                                recordPrint(labelSNArr);
                            } else { //连板
                                labelSNArr = labelStr.split(",");
                                for (var k = 0; k < labelSNArr.length - 1; k++) {
                                    recordPrint(labelSNArr[k]);
                                }
                            }
                        }
                    } catch (e) {
                        alert(e);
                        $("#lblMessage").html(e);
                        return false;
                    }
                }
                else {
                    alert(ajaxLabContent.error.Message);
                    $("#lblMessage").html(ajaxLabContent.error.Message);
                    return false;
                }
            }

            ibs = 3;
            setInterval(function () { $("#lblMessage").html("打印条码完成," + ibs + "秒后关闭窗口！"); ibs-- }, 1000)
            setTimeout(function () {
                parent.form1.submit(); ;
            }, 3000);
        }

        //指令方式
        function mesZPLPrintLabel() {

            lableArr = SNInfo.SNList;
            for (var i = 0; i < lableArr.length; ) {

                //lableArr[i]
                //找到doucumentId打印文档id
                var labelStr = "";
                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }

                i = i + lableTypeQty;

                //获取此标签的zpl指令
                var ajaxZplContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnZplContent(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                if (ajaxZplContent.error == null) {
                    zplStr = ajaxZplContent.value;
                    try {

                        labelPrintingPlugin.DoPrint(zplStr, printName);


                        //条码打印记录
                        var labelSNArr;
                        if (lableTypeQty == 1) { //单板
                            labelSNArr = labelStr.split(",")[0];
                            recordPrint(labelSNArr);
                        } else { //连板
                            labelSNArr = labelStr.split(",");
                            for (var k = 0; k < labelSNArr.length - 1; k++) {
                                recordPrint(labelSNArr[k]);
                            }
                        }
                    } catch (e) {
                        alert(e);
                        $("#lblMessage").html(e);
                        return false;
                    }
                } else {
                    alert(ajaxZplContent.error.Message);
                    $("#lblMessage").html(ajaxZplContent.error.Message);
                    return false;
                }
            }
            ibs = 3;
            setInterval(function () { $("#lblMessage").html("打印条码完成," + ibs + "秒后关闭窗口！"); ibs-- }, 1000)
            setTimeout(function () {
                parent.form1.submit(); ;
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
</asp:Content>
