<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="AccessoryMaterialPrint.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryMaterialPrint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">供应商名称<em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="-1" id="hdnVenID" />
                <input type="hidden" value="" id="hdnVendorCode" />
                <input type="text" value="" id="txtVendorName" disabled="disabled" isrequired="1" />
                <input type="button" value="..." class="ButtonBox" onclick="chooseVendor()" />
            </td>
            <td class="Label2">
                物料编码<em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="-1" id="hdnItemId" />
                <input type="hidden" value="-1" id="hdnItemCode" />
                <input type="text" id="txtItemName" class="TextBox" isrequired='1' disabled="disabled" value="" /><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
            </td>
        </tr>
        <tr>
            <td class="Label2" id="tdLotCode">
                <%=Resources.lang.LotSize %><em>*</em>
            </td>
            <td class="Field2">
                <input class="TextBox" id="lblLotCode" IsRequired='1'/>
            </td>
            <td class="Label2">
               <%=Resources.lang.ProduceDate %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtProdDate" class="" IsRequired='1' disabled="disabled"   runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">供应商编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSCode" class="" IsRequired='1'   runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2"><%=Resources.lang.Accessorie_QUANTITY %><em>*</em>
            </td>
            <td class="Field2">
                <input class="TextBox" id="textNumber" isnumber='1' IsRequired='1'/>
            </td>
        </tr>
        <tr>
            <td class="Label2">采购订单<em>*</em>
            </td>
            <td class="Field2">
                <input class="TextBox" id="txtPOrder"  IsRequired='1'/>
            </td>
            <td class="Label2">流水号<em>*</em>
            </td>
            <td class="Field2">
                <input class="TextBox" id="txtlNumber" isnumber='1' IsRequired='1'/>
            </td>
        </tr>
        <tr>
            <td class="Label2">失效日期<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtstopTime" class="" IsRequired='1' disabled="disabled"  runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">打印数量
            </td>
            <td class="Field2"> 
                 <input class="TextBox" id="printQuantity" IsNumber='1' onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')" />&nbsp;&nbsp;<input type="button" id="Lookbtn" value="锁定" onclick="LookForPrintQuantity()" class="SearchButton" title="锁定">
            </td>
        </tr>
        <tr>
            <td class="Label2">锡膏条码<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <input class="TextBox" id="txtHWMaterialCode"  style="width:41%;height:38px;font-size:18px;"/>
            </td>
        </tr>
        <tr>
            <td class="Label2">打印机名称
            </td>
            <td class="Field2" colspan="3">
                <select id="selPrintersList">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
               <%-- <a href="#" onclick="bindPrinters();">重新加载打印机列表</a>--%>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" ClientIDMode="Static"
                    TextMode="MultiLine" Width="41%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
        <div id="lblPt" class="Tips">
        </div>
    </div>
    <div id="activeinfo" class="active-info">
        <div id="activeinfoarea" class="active-info-area">
        </div>
    </div>
    <style type="text/css">
        .active-info
        {
            padding-right: 10px;
            padding-top: 5px;
            padding-left: 1px;
        }

        .active-info-area
        {
            color: Red;
            background-color: #ebebe4;
            width: 100%;
            outline: none;
            border: 1px solid #d3d3d3;
            overflow:auto;
            font-size:12px;
            font-weight:normal;
            line-height:16px;
            padding:3px;
            height:410px;
        }
    </style>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "";
        var DataTimeString = "";
        userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName%>';//中文名
        DataTimeString = '<%=DateTime.Now.ToString("MM.dd")%>'//当前日期
        var labelItemId = -1; //打印产品
        var factoryCode = "";
        var itemAllQty = 0;
        var alreadyQty = 0; //已经打印数量
        var bigCartonQty = 0; //外包装最小包装数量
        var selItemCode = '';
        //修复IQC打印时，GRN没有绑定IQC单号的BUG   BirongLiang 2017-4-13
        var selIqcOrder = '';
        $("#printQuantity").val("1");//默认为1
        $(function () {
            ////setTimeout(function () {
            ////    bindPrinters();
            ////}, 100);
            //获取批次号
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetLotCode();
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}
            //$("#lblLotCode").val(ajax.value);
            //$("#lblLotCode").focus(function () { this.select() });
            BindDatepicker();
            $("#activeinfoarea").css("height", $(window).height() - 295 + "px");
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

            //条码回车
            $("#txtHWMaterialCode").keydown(function (e) {
                var eventflag = 0;
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    nullInfo();
                    var HwCode = $("#txtHWMaterialCode").val();//华为物料条码
                    if (HwCode == "") {
                        alert("锡膏条码不能为空，请扫描！");
                        $("#txtHWMaterialCode").val("");
                        return false;
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialPrintInfo(HwCode);
                    if (ajax.error != null) {
                        nullInfo();
                        alert(ajax.error.Message);
                        $("#txtHWMaterialCode").val("");
                        return false;
                    }
                    else {
                        var data = ajax.value;
                        if (data.msg != "") {
                            nullInfo();
                            alert(data.msg);
                            $("#txtHWMaterialCode").val("");
                            return false;
                        }
                        $("#txtItemName").val(data.ItemName);
                        $("#hdnItemId").val(data.ItemID);
                        $("#hdnItemCode").val(data.ItemCode);
                        $("#lblLotCode").val(data.LotCode);
                        $("#txtSCode").val(data.Scode); 
                        $("#txtProdDate").val(data.ProdDate); 
                        $("#textNumber").val(data.QTY);
                        $("#txtPOrder").val(data.OrderNO);
                        $("#txtlNumber").val(data.LNumber);
                        $("#txtstopTime").val(data.StopTime);
                    }         
                }
            });

            $(".DateTimeBox1").datepicker({ minDate: 0, maxDate: "+1M +10D" });
            //Modify by zhiman.yuan 2017-3-7 默认生产日期。
            $("#txtProdDate").val(GetDateStr(0));
            $("#txtstopTime").val(GetDateStr(0));
            //$("#textDateCode").val((((new Date(GetDateStr(0))) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1);
            SetVendorCode();
        });
        //清空信息
        function nullInfo() {
            $("#txtItemName").val("");
            $("#hdnItemId").val("-1");
            $("#lblLotCode").val("")
            $("#txtSCode").val("");
            $("#txtProdDate").val("");
            $("#textNumber").val("");
            $("#txtPOrder").val("");
            $("#txtlNumber").val("");
            $("#txtstopTime").val("");
        }
        //2020.03.10  默认供应商信息
        function SetVendorCode() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CustomerSupplierInfoBySupplierCode("00000000");//默认供应商
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //showAreaMessge(ajax.error.Message, "messageRed"); //messageRed,messageGreen
                return false;
            }
            else {
                var data = ajax.value;
                $("#hdnVenID").val(data.SupplierId);
                $("#txtVendorName").val(data.VendorName);
                $("#hdnVendorCode").val(data.VendorCode);
                $("#txtVendorName").attr("disabled", "disabled");
            }
        }
        //2017-10-17 胡芳 根据选择时间设置DateCode(周数)
        function BindDatepicker() {
            $(".DateTimeBox1").datepicker({
                showOn: "button",
                buttonImageOnly: true,
                showHms: _isHms,
                buttonText: "<%=Resources.Common.ChooseDate %>",
                onSelect: function () {
                    if (_isHms) {
                        var objme = $(this);
                        if (typeof (objme.attr("_isHms")) == "undefined") {
                            if (objme.val().length > 10) {
                                objme.css("width", "140px");
                            }
                        } else { objme.val(objme.val().substring(0, 10)); }
                    }
                    var time1 = $(".DateTimeBox1").val();
                    var weekofyear = (((new Date(time1)) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1;
                    $("#textDateCode").val(weekofyear);
                },
                gotoCurrent: true,
                changeMonth: true,
                changeYear: true
            });
        }
        //选择采购单号
        var printChoosePageId = 101;
       //选中供应商
        function chooseVendor() {
           dialog({
               title: "<%=Resources.Common.ChooseWindow %>",
               src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=setVendor&Multiple=false&rnd=" + Math.random(), width: 680, height: 350
            });
        }
        function setVendor(list) {
            $("#hdnVenID").val(list[0][0]);
            $("#txtVendorName").val(list[0][2]);
            $("#hdnVendorCode").val(list[0][1]);
            $("#txtVendorName").attr("disabled", "disabled");
        }

        //选择产品
        function selectItem() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtItemName").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
            $("#txtItemName").attr("disabled", "disabled");
        }

        //清空所有的数据
        function Empty(flag) {
            $("#txtItemName").val("");
            $("#hdnItemId").val(-1);
            $("#hdnRowId").val(-1);
            $("#hdfGRNQty").val("");
            $("#hdfQty").val("");
            $("#textNumber").val("");
            $("#txtEffectiveDate").val("");
            $("#txtRemark").val("");
            $("#txtHWMaterialCode").val("");
        }
        function Save() {
            var POorder = $("#txtPOrder").val();    //采购单号
            labelItemId = $("#hdnItemId").val();
            var txtNumber = $("#textNumber").val().replace(",", "");//数量
            var txtGRNQty = txtNumber; //打印条码数量，送货总数
            var txtQty = txtNumber; //最小包装数量
            var txtLotCode = $("#lblLotCode").val();//批次号
            var txtVendorCode = $("#hdnVendorCode").val();//供应商编码
            var errStr = "";
            var txtDateCode = $("#txtProdDate").val();//生产日期
            var remark = $("#txtRemark").val();//备注
            var textDateCode = $("#txtProdDate").val();//周数
            var textMPN = POorder;//MPN
            var HwCode = $("#txtHWMaterialCode").val();//锡膏条码

            var txtSCode = $("#txtSCode").val();
            var txtlNumber = $("#txtlNumber").val();
            var txtstopTime = $("#txtstopTime").val();

            if (txtQty * 1 > txtGRNQty * 1) {
                alert('最小包装数不能大于本次送货总数');
                return false;
            }
            if (txtLotCode == "") {
                alert("批次号不能为空！");
                return;
            }
            if (txtVendorCode == "") {
                errStr += "<%=Resources.Messages.SelectVendorCode %>\n";
            }
            if (labelItemId == -1) {
                errStr += "<%=Resources.Messages.SelectMaterial %>\n";
            }
            if (txtGRNQty == "" || txtGRNQty == "0" || parseFloat(txtQty) <= 0 || txtQty == "") {
                errStr += "<%=Resources.Messages.GRNQtyIsInvalid %>\n";
            }
            if (txtDateCode == "") {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>\n";
            }
            if (txtstopTime == "") {
                errStr += "失效日期不能为空";
            }
            if (HwCode == "") {
                errStr += "锡膏条码不能为空！\n";
            }
            if (textDateCode == "") {
                errStr += "DateCode(<%=Resources.lang.WeekNumber %>)不能为空！\n";
            }
            var cDate = txtDateCode;
            var reg = new RegExp("-", "g"); /*创建正则表达式*/
            cDate = cDate.replace(reg, "/");
            var iDate = new Date(cDate);
            var toDay = new Date();
            if (Date.parse(iDate) - Date.parse(toDay) > 0) {
                errStr += "生产日期需要小于今天日期\n";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            if ($.trim($("#printQuantity").val()) == '' || $.trim($("#printQuantity").val()) == '0') {
                alert("请输入打印份数，且至少为1！");
                $("#lblMessage").html('请输入打印份数，且至少为1！');
                return;
            }
            if (!window.confirm("<%=Resources.Messages.ConfirmPrintTheseGRNs %>")) {
                return false;
            }

            var pQuantity = parseInt($.trim($("#printQuantity").val()));

            var isSupplyPrint = 0; //1:由供应商打印  0：不是由供应商打印
            //$("#lblMessage").html("正在生成GRN，请稍候...");
            showAreaMessge("供应商：" + $("#txtSCode").val() + ",物料名称:【" + $("#txtItemName").val() + "】物料编码:【" + $("#hdnItemCode").val() + "】开始生成GRN，请稍候...", "messageGreen"); //messageRed,messageGreen
            setTimeout(function () {
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateSupplierMaterial(parseInt(labelItemId), parseInt(txtGRNQty),
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateSupplierMaterialCustomer(parseInt(labelItemId), parseInt(txtGRNQty),parseFloat(txtQty), txtLotCode, txtDateCode, txtVendorCode, POorder, remark, textDateCode, textMPN);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.AccessrySupplierMaterialGenerateCount(parseInt(labelItemId), parseInt(txtGRNQty), parseFloat(txtQty), txtLotCode, txtDateCode, txtVendorCode, POorder, remark, textDateCode, textMPN, HwCode, txtSCode, txtlNumber, txtstopTime, pQuantity);//辅料转码

                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    showAreaMessge(ajax.error.Message, "messageRed"); //messageRed,messageGreen
                    return false;
                }
                var arr = ajax.value;
                if (arr != null) {
                    
                    setTimeout(function () {
                        try {
                            printGRN(arr);
                            SetprintQuantity();//默认1

                        }
                        catch (e) {
                            alert(e);
                            showAreaMessge(e, "messageRed"); //messageRed,messageGreen
                        }
                    }, 100);
                }
            }, 100);
        }


        //默认1
        function SetprintQuantity() {
            $("#printQuantity").val("1");//默认为1
            $("#printQuantity").attr("disabled", true);
        }


        function LookForPrintQuantity() {
            if ($.trim($("#printQuantity").val()) == '' || $.trim($("#printQuantity").val()) == '0') {
                $("#lblMessage").html('请输入打印份数，且至少为1！');
                return;
            }
            if ($("#printQuantity").prop("disabled") == true) {
                $("#printQuantity").attr("disabled", false);
            } else {
                $("#printQuantity").attr("disabled", true);
            }

        }

        function printGRN(arr) {
            if (arr == null) {
                return false;
            }
            arr[0] = arr[0].substring(0, arr[0].lastIndexOf(","));
            arr[1] = arr[1].substring(0, arr[1].lastIndexOf(","));
            grnArr = arr[0].split(","); //物料条码
            //将GRN信息添加到SNInfo的SNInfo.SNList集合中
            SNInfo = {};
            SNInfo.SNList = grnArr;
            //根据打印方式决定 调用ZPL还是Lab打印
            usePrinGRNMethod();
            //打印完成刷新页面
            setTimeout(function () {
                //document.forms[0].submit();
                showAreaMessge("供应商编码:" + $("#txtSCode").val() + ",物料名称:【" + $("#txtItemName").val() + "】物料编码:【" + $("#hdnItemCode").val() + "】打印完成", "messageGreen"); //messageRed,messageGreen
                Empty(2);
                nullInfo();
                $("#textDateCode").val("");
                $("#txtHWMaterialCode").val("");
                $("#lblLotCode").val("");
                $("#txtProdDate").val(GetDateStr(0));
                //$("#textDateCode").val((((new Date(GetDateStr(0))) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1);
            }, 1000);
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 2;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径

        //获取物料条码文档模板基础信息
        function getGRNDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //获取打印机名称值
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                //$("#lblMessage").html(ajax.error.Message);
                showAreaMessge(ajax.error.Message, "messageRed"); //messageRed,messageGreen
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
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                //$("#lblMessage").html(ajax.error.Message);
                showAreaMessge(ajax.error.Message, "messageRed"); //messageRed,messageGreen
                return false;
            }
        }

        //根据打印方式决定 调用ZPL还是Lab打印
        function usePrinGRNMethod() {
            getGRNDocumentInfo();
            //78：codeSoft打印 79:zpl方式打印
            if (labelPrintWayId == 78) {
                //codesoft打印  Lab模板方式
                mesLabLabelPrint(1);
            } else if (labelPrintWayId == 79) {
                //zpl打印
                mesZPLLabelPrint(1);
            }
        }

        function usePrintCartonMethod() {
            getCartonDocumentInfo();
            //78：codeSoft打印 79:zpl方式打印
            if (labelPrintWayId == 78) {
                //codesoft打印  Lab模板方式
                mesLabLabelPrint(2);
            } else if (labelPrintWayId == 79) {
                //zpl打印
                mesZPLLabelPrint(2);
            }
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint(printType) {
            //从已释放的标签信息集合中，获取SN序列号集合。
            if (printType == 1) {  //物料条码
                lableArr = SNInfo.SNList;
            }
            else if (printType == 2) {
                lableArr = SNInfo.CartonList;
            }
            var labelStr = "";
            //单个实体
            var labelContent = "";
            labelJsonData = "[";
            /*循环GRN*/
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
                showAreaMessge(lableArr[i] + '条码生成,打印成功', "messageGreen"); //messageRed,messageGreen
                i = i + lableTypeQty; //连片的递增
                //获取标签模板中的标签值 集合
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                if (ajaxLabContent.error == null) {
                    try {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            for (var k = 0; k < list.length; k++) {
                                if (list[k].LabelName == "VendorCode") {
                                    labelContent += "{name:'" + list[k].LabelName + "',value:'" + $("#txtSCode").val() + "'}" + ",";
                                }
                                if (list[k].LabelName == "UserName") {
                                    labelContent += "{name:'" + list[k].LabelName + "',value:'" + userName + "'}" + ",";
                                }
                                else if (list[k].LabelName == "PrintDate") {
                                    labelContent += "{name:'" + list[k].LabelName + "',value:'" + DataTimeString + "'}" + ",";
                                }
                                else if (list[k].LabelName == "BalanceQty") {
                                    labelContent += "{name:'" + list[k].LabelName + "',value:'" + parseInt(list[k].LabelValue) + "'}" + ",";
                                }
                                else {
                                    labelContent += "{name:'" + list[k].LabelName + "',value:'" + list[k].LabelValue + "'}" + ",";
                                }
                            }
                            labelContent = labelContent.substring(0, labelContent.length - 1);
                            labelJsonData += "{LabelContent:[" + labelContent + "]}" + ","; //串多个实体
                            labelContent = "";
                        }

                    } catch (e) {
                        alert(e);
                        //$("#lblMessage").html(e);
                        showAreaMessge(e, "messageRed"); //messageRed,messageGreen
                        return false;
                    }
                }
                else {
                    alert(ajaxLabContent.error.Message);
                    //$("#lblMessage").html(ajaxLabContent.error.Message);
                    showAreaMessge(ajaxLabContent.error.Message, "messageRed"); //messageRed,messageGreen
                    return false;
                }
            }
            /*循环GRN结束*/
            labelJsonData = labelJsonData.substring(0, labelJsonData.length - 1);
            labelJsonData += "]";
            try {
                printMultipleLabel(tempatePath, labelJsonData, printName, 1, "lab");
            } catch (e) {
                alert(e);
                //$("#lblMessage").html(e);
                showAreaMessge(e, "messageRed"); //messageRed,messageGreen
                return false;
            }
            ibs = 3;
            setTimeout(function () {
                //$("#lblMessage").html('条码打印完成!');
            }, 300);
        }



        //ZPL打印
        function mesZPLLabelPrint(PrintType) {
            //从已释放的标签信息集合中，获取SN序列号集合。
            if (PrintType == 1) {  //物料条码
                lableArr = SNInfo.SNList;
            }
            else if (PrintType == 2) {
                lableArr = SNInfo.CartonList;
            }
            /*循环GRN*/
            for (var i = 0; i < lableArr.length;) {
                var labelStr = "";
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
                var ajaxZplContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnZplContent(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                if (ajaxZplContent.error == null) {
                    zplStr = ajaxZplContent.value;
                    try {
                        printMultipleLabel(tempatePath, zplStr, printName, 1, "zpl");
                    } catch (e) {
                        alert(e.message);
                        return false;
                    }
                }
                else {
                    alert(ajaxZplContent.error.Message);
                    //$("#lblMessage").html(ajaxLabContent.error.Message);
                    showAreaMessge(ajaxLabContent.error.Message, "messageRed"); //messageRed,messageGreen
                    return false;
                }
            }
            ibs = 3;
            setTimeout(function () {
                //$("#lblMessage").html('条码打印完成!');
            }, 300);
        }

        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/

        ////function bindPrinters() {
        ////    try {
        ////        var printLabel = getLocalPrintersList();
        ////        var list = printLabel.split(";");
        ////        var selPrintersList = "";
        ////        for (var i = 0; i < list.length; i++) {
        ////            selPrintersList += "<option value='" + list[i] + "'>" + list[i] + "</option>";
        ////        }
        ////        $("#selPrintersList").html(selPrintersList);
        ////    }
        ////    catch (e) {
        ////        alert(e.message);
        ////    }
        ////}

        function toThousands(s) {
            if (/[^0-9\.]/.test(s)) return "不是数值类型";
            s = s.replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
            return s;
        }
        //生产虚拟采购订单
        function SaveVirtualPo() {
            var VenID = $("#hdnVenID").val();
            var VendorName = $("#txtVendorName").val();
            var VendorCode = $("#hdnVendorCode").val();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/GenerateVirtualPo.aspx?name=GenerateVirtualPo&VenID=" + VenID + "&VendorName=" + VendorName + "&VendorCode=" + VendorCode;
            dialog({ title: "生产虚拟采购订单", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth-100) });
        }

        //#region 设置消息提示框样式
        /*
        * 设置消息提示框样式
        */
        function showAreaMessge(information, styleClass) {
            var currentTime = getDateTime();
            var messageBox = $("#activeinfoarea");
            var rows = 100;

            messageBox.find("span").eq(rows - 2).nextAll().remove(); //显示50条扫描记录        
            var html = "<span  style='font-size:13px;font-weight:normal;' class=" + styleClass + ">" + "[" + currentTime + "] " + information + "</span>" + '<br/>' + messageBox.html();
            messageBox.empty();
            messageBox.append(html);
        }
        /**
        *获取当前时间
        */
        function getDateTime() {
            var now = new Date();
            var year = now.getFullYear();
            var month = now.getMonth() + 1;
            var date = now.getDate();
            var hour = now.getHours();
            var min = now.getMinutes();
            var sec = now.getSeconds();
            var day = now.getDay();

            month = (month < 10) ? '0' + month.toString() : month.toString();
            date = (date < 10) ? '0' + date.toString() : date.toString();
            hour = (hour < 10) ? '0' + hour.toString() : hour.toString();
            min = (min < 10) ? '0' + min.toString() : min.toString();
            sec = (sec < 10) ? '0' + sec.toString() : sec.toString();
            return year.toString() + '年' + month.toString() + '月' + date.toString() + "日  " + hour.toString() + ":" + min.toString() + ":" + sec.toString();
        }

        function isIE() { //ie?
            if (!!window.ActiveXObject || "ActiveXObject" in window)
                return true;
            else
                return false;
        }
        //#endregion
    </script>
</asp:Content>
