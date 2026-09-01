<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="GenerateGRNSuply.aspx.cs" Inherits="SKT.LeanMES.Web.Material.GenerateGRNSuply" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%=Resources.lang.PONO%><em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtPoNumber" class="TextBox" disabled="disabled" isrequired='1' /><input
                    type="button" id="btnSelectPo" class="ButtonBox" value="..." onclick="selectPoNumber()" />
            </td>
            <td class="Label2">
                <%=Resources.lang.MaterialCode%><em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="-1" id="hdnItemId" />
                <input type="hidden" value="-1" id="hdnRowId" />
                <input type="text" id="txtItemName" class="TextBox" disabled="disabled" value="" isrequired='1' /><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.VendorName %>
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="hdnVendorCode" />
                <asp:Label runat="server" ID="lblVendorName"></asp:Label>
            </td>
            <td class="Label2">供应商代码
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblVendorCode"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">本次送货总数<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtGRNQty" isrequired='1' class="NumericBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" onchange="VerifyPrintQty();" />
                <input type="hidden" value="" id="hdfGRNQty" />
            </td>
            <td class="Label2">
                <%=Resources.lang.MinPackageQty%><em>*</em>
            </td>
            <td class="Field2">
                <%--最小包装数量--%>
                <input type="text" id="txtQty" isrequired='1' class="NumericBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" onchange="VerifyQty();" />
                <input type="hidden" value="" id="hdfQty" />
            </td>
        </tr>
        <tr>
            <td class="Label2">订单总数量
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPOQty"></asp:Label>
            </td>
            <td class="Label2">已打数量
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPrintQty"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.ProduceDate %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtProdDate" ReadOnly="true" class="DateTimeBox1" runat="server" ClientIDMode="Static" IsRequired="1" />

            </td>
            <td class="Label2">
                <%=Resources.lang.LotSize %>
            </td>
            <td class="Field2">
                <%--<asp:Label runat="server" ID="lblLotCode"></asp:Label>--%>
                <input class="TextBox" id="lblLotCode" />
            </td>
        </tr>
        <tr>
            <td class="Label2">DateCode(周数)
            </td>
            <td class="Field2">
                <input class="TextBox" id="textDateCode" isnumber='1' maxvalue='60' type="number" min="1" onblur="if(value <0 ){value = '1'}" />
            </td>
            <td class="Label2">MPN
            </td>
            <td class="Field2">
                <input class="TextBox" id="textMPN" />
            </td>
        </tr>
        <tr>
            <td class="Label2" style="display: none">外包装包装个数<em>*</em>
            </td>
            <td class="Field2" style="display: none">
                <input type="text" id="txtBigCartonQty" value="0" class="NumericBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" onchange="VerifyPrintQty();" />
            </td>

        </tr>
        <tr>
            <td class="Label2">产品规格
            </td>
            <td class="Field2" colspan="3">
                <asp:Label runat="server" ID="lblSpec"></asp:Label>
            </td>

        </tr>
        <tr>
            <td class="Label2">打印机名称
            </td>
            <td class="Field2" colspan="3">
                <select id="selPrintersList" style="width: 250px;">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" ClientIDMode="Static"
                    Width="41%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
        <div id="lblPt" class="Tips">
        </div>
    </div>
    <div id="activeinfo" class="active-info">
        <div id="activeinfoarea" class="active-info-area"></div>
        <%--<textarea id="activeinfoarea" class="active-info-area" readonly>
        </textarea>--%>
    </div>
    <style type="text/css">
        .active-info {
            padding-right: 10px;
            padding-top: 5px;
            padding-left: 1px;
        }

        .active-info-area {
            color: Red;
            background-color: #ebebe4;
            width: 100%;
            outline: none;
            border: 1px solid #d3d3d3;
            overflow: auto;
            font-size: 12px;
            font-weight: normal;
            line-height: 16px;
            padding: 3px;
            height: 410px;
        }

        .messageRed {
            display: inline-block;
            text-align: left;
            color: Red;
            font-weight: normal;
            font-size: 14px;
        }

        .messageGreen {
            display: inline-block;
            text-align: left;
            color: Green;
            font-weight: normal;
            font-size: 14px;
        }
    </style>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var labelItemId = -1; //打印产品
        var factoryCode = "";
        var itemAllQty = 0;
        var alreadyQty = 0; //已经打印数量
        var bigCartonQty = 0; //外包装最小包装数量

        $(function () {

            //获取批次号
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetLotCode();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            $("#lblLotCode").val(ajax.value);
            $("#lblLotCode").focus(function () { this.select() });
            BindDatepicker();
            showIsSuppler();
            $("#activeinfoarea").css("height", $(window).height() - 423 + "px");
        });

        var IsSupplierPeriod = 2;//供应商是否交期维护：1：需要 2：不需要 默认不需要
        function showIsSuppler() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(6);
            if (ajax.error == null) {
                var entity = $.parseJSON(ajax.value).data[0];
                IsSupplierPeriod = entity.ChoosePageId;
            }
        }

        $(document).ready(function () {
            bindPrinters('selPrintersList');
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
            $(".DateTimeBox1").datepicker({ minDate: 0, maxDate: "+1M +10D" });

            //Modify by zhiman.yuan 2017-3-7 默认生产日期。
            $("#txtProdDate").val(GetDateStr(0));
            $("#textDateCode").val(Math.abs((((new Date(GetDateStr(0))) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1));
            //$(".ui-datepicker-trigger").attr("disabled", "disabled");

        });
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
                    $("#textDateCode").val(Math.abs(weekofyear));
                },
                gotoCurrent: true,
                changeMonth: true,
                changeYear: true
            });
        }
        //选择采购订单号
        function selectPoNumber() {
            var SearchCondition = "";
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserId%>";
            var UserType = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserType%>";

            //只要是系统用户可以看到所有供应商的
            if (UserType != "-1") {
                if (IsSupplierPeriod == 2) { //不需要交期维护
                    SearchCondition = "SupplierId =" + UserType;
                }
                else { //需要交期维护
                    SearchCondition = "SupplierId =" + UserType + " AND IsPeriod = 1";
                }
            }
            else {
                if (IsSupplierPeriod == 1) { //需要交期维护
                    SearchCondition = " IsPeriod = 1";
                }
                else {
                    SearchCondition = " POID>CAST(0 AS BIGINT) ";
                }
            }
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=101&Multiple=false&PageCondition="
                 + escape(SearchCondition) + "&CallBackFunc=setPONumber&rnd=" + Math.random(), width: 712, height: 400
            });
        }

        function setPONumber(list) {
            //清空数据
            Empty(1);
            $("#txtPoNumber").val(list[0][1]);
            //选择采购订单带出供应商
            $("#hdnVendorCode").val(list[0][2]);
            $("#<%=this.lblVendorCode.ClientID %>").text(list[0][2]);
            $("#<%=this.lblVendorName.ClientID %>").text(list[0][3]);
            factoryCode = list[0][4];

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetAllItemByVendor(list[0][1]);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var items = ajax.value;
            if (items.length > 0) {
                var item = items[0];
                $("#txtItemName").val(item.ItemCode);
                $("#hdnItemId").val(item.ItemID);
                $("#<%=this.lblSpec.ClientID %>").text(item.ItemSpec);
                $("#txtGRNQty").focus();
                $("#txtItemName").attr("disabled", "disabled");
                $("#<%=this.lblPOQty.ClientID %>").text(item.BuyQty);
                $("#hdnRowId").val(item.RowId);
                var qty = item.MinPackQty == "" ? 0 : parseInt(item.MinPackQty)
                $("#txtQty").val(qty); //最小包装数量
                //获取订单数量跟已打数量
                itemAllQty = item.BuyQty;
                if (list[0][1] != "") {
                    GetQty($("#txtPoNumber").val(), item.ItemCode, item.RowId);
                }
            }
            else {
                //清空数据
                Empty(2);
            }
        }
        function GetPoNumberItemCode(PoNumber) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetAllItemByVendor(PoNumber);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var items = ajax.value;
            if (items.length > 0) {
                var item = items[0];
                $("#txtItemName").val(item.ItemCode);
                $("#hdnItemId").val(item.ItemID);
                $("#<%=this.lblSpec.ClientID %>").text(item.ItemSpec);
                $("#txtGRNQty").focus();
                $("#txtItemName").attr("disabled", "disabled");
                $("#<%=this.lblPOQty.ClientID %>").text(item.BuyQty);
                $("#hdnRowId").val(item.RowId);
                var qty = item.MinPackQty == "" ? 0 : parseInt(item.MinPackQty)
                $("#txtQty").val(qty); //最小包装数量
                //获取订单数量跟已打数量
                itemAllQty = item.BuyQty;
                if (PoNumber != "") {
                    GetQty($("#txtPoNumber").val(), item.ItemCode, item.RowId);
                }
            }
            else {
                //清空数据
                Empty(2);
            }
        }
        //选择产品
        function selectItem() {
            //清空数据
            Empty(2);
            var POorder = $("#txtPoNumber").val(); //采购订单号
            if (POorder == "") {
                alert("请选择采购单号！");
                $("#btnSelectPo").focus();
                return false;
            }
            var SearchCondition = " POorder='" + POorder + "'";
            //SearchCondition += " AND PStatus=1";//剔除 状态为‘已收料’的物料--chenglong.zhu 2017-4-13
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=72&PageCondition=" + escape(SearchCondition) + "&Multiple=false&rnd=" + Math.random(), width: 612, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtItemName").val(list[0][1]);
            $("#hdnItemId").val(list[0][0]);
            $("#<%=this.lblSpec.ClientID %>").text(list[0][6]);
            $("#txtGRNQty").focus();
            $("#txtItemName").attr("disabled", "disabled");
            $("#<%=this.lblPOQty.ClientID %>").text(list[0][3]);
            $("#hdnRowId").val(list[0][4]);
            var qty = list[0][5] == "" ? 0 : parseInt(list[0][5])
            $("#txtQty").val(qty); //最小包装数量
            //获取订单数量跟已打数量
            itemAllQty = list[0][3];
            if (list[0][1] != "") {
                GetQty($("#txtPoNumber").val(), list[0][1], list[0][4]);
            }
        }

        //清空所有的数据
        function Empty(flag) {
            var PoNumber = $("#txtPoNumber").val();
            debugger
            var rowId = $("#hdnRowId").val();
            if (flag == 1) {
                $("#txtPoNumber").val("");
                $("#hdnVendorCode").val("");
                $("#<%=this.lblVendorName.ClientID %>").text("");
                $("#<%=this.lblVendorCode.ClientID %>").text("");
            }
            $("#txtItemName").val("");
            $("#hdnItemId").val(-1);
            $("#hdnRowId").val(-1);
            $("#<%=this.lblSpec.ClientID %>").text("");
            $("#hdfGRNQty").val("");
            $("#txtGRNQty").val("");
            $("#hdfQty").val("");
            $("#txtQty").val("");
            $("#<%=this.lblPOQty.ClientID %>").text("");
            $("#<%=this.lblPrintQty.ClientID %>").text("");
            //$("#txtProdDate").val("");
            $("#txtEffectiveDate").val("");
            $("#txtRemark").val("");
            //清空一些后续增加修改的字段
            //$("#lblLotCode").val("");
            $("#textDateCode").val();
            $("#textMPN").val("");
            debugger
            if (flag == 4) {
                //获取批次号
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetLotCode();
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $("#lblLotCode").val(ajax.value);
                /*GetPoNumberItemCode(PoNumber);*/
                GetPoNumberItemCode2(PoNumber, rowId);

            }
        }

        //获取订单数量跟已打数量
        function GetQty(POCode, ItemCode, RowID) {
            //获取订单数量
            //获取已打条码数量
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetPrintQty(POCode, ItemCode, RowID);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alreadyQty = ajax.value;
            $("#<%=this.lblPrintQty.ClientID %>").text(alreadyQty);
            $("#txtGRNQty").val(itemAllQty - alreadyQty);
        }



        //验证打印条码数量
        function VerifyPrintQty() {
            var txtGRNQty = $("#txtGRNQty").val(); //打印条码数量
            //千位符处理
            $("#hdfGRNQty").val(txtGRNQty);
            $("#txtGRNQty").val(toThousands(txtGRNQty));
            var txtQty = $("#txtQty").val();      //最小包装数量
            var PoQty = $("#<%=this.lblPOQty.ClientID %>").text();        //该PO单下该物料的总数量
            var PrintQty = $("#<%=this.lblPrintQty.ClientID %>").text();  //已打印的最小包装数量
            if (parseInt(PoQty) == parseInt(PrintQty)) {
                alert("该采购订单下该物料的数量已经打完！")
                return false;
            }
        }

        //验证最小包装数量
        function VerifyQty() {
            var txtGRNQty = $("#hdfGRNQty").val(); //打印条码数量
            var txtQty = $("#txtQty").val();      //最小包装数量
            $("#hdfQty").val(txtQty);
            $("#txtQty").val(toThousands(txtQty));
            var PoQty = $("#<%=this.lblPOQty.ClientID %>").text();        //该PO单下该物料的总数量
            var PrintQty = $("#<%=this.lblPrintQty.ClientID %>").text();  //已打印的最小包装数量
            if (parseInt(PoQty) == parseInt(PrintQty)) {
                alert("该采购订单下该物料的数量已经打完！")
                return false;
            }
            if (parseFloat(txtGRNQty) < parseFloat(txtQty)) {
                alert("最小包装数不能大于本次送货总数！");
                $("#txtQty").val(0);
                return false;
            }
        }


        function Save() {
            var POorder = $("#txtPoNumber").val();    //采购单号
            labelItemId = $("#hdnItemId").val();
            //var txtGRNQty = $("#txtGRNQty").val(); //打印条码数量
            //var txtQty = $("#txtQty").val(); //最小包装数量
            var txtQty = $("#txtQty").val().replace(/,/g, ""); //最小包装数量
            var txtGRNQty = $("#txtGRNQty").val().replace(/,/g, ""); //打印条码数量，送货总数
            bigCartonQty = $("#txtBigCartonQty").val(); //最外包装数量
            var txtLotCode = $("#lblLotCode").val();
            <%--var txtLotCode = $("#<%=this.lblLotCode.ClientID %>").text();--%>
            var txtVendorCode = $("#hdnVendorCode").val();
            var errStr = "";
            var txtDateCode = $("#txtProdDate").val();
            var remark = $("#txtRemark").val();
            var rowId = $("#hdnRowId").val();

            var textDateCode = $("#textDateCode").val();//DateCode
            var textMPN = $("#textMPN").val();//MPN
            if (POorder == "") {
                alert("采购单号不能为空！");
                return;
            }

            if (txtLotCode == "") {
                alert("批次号不能为空！");
                return;
            }
            if (parseFloat(txtGRNQty) < parseFloat(txtQty)) {
                alert("最小包装数不能大于本次送货总数！");
                $("#txtQty").val(0);
                return false;
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

            if (!window.confirm("<%=Resources.Messages.ConfirmPrintTheseGRNs %>")) {
                return false;
            }
            var isSupplyPrint = 1; //1:由供应商打印  0：不是由供应商打印
            //$("#lblMessage").html("正在生成GRN，请稍候...");
            showAreaMessge("PO单" + $("#txtPoNumber").val() + ",物料编码:" + $("#txtItemName").val() + "开始生成GRN，请稍候...", "messageGreen"); //messageRed,messageGreen

            setTimeout(function () {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateGRN(parseInt(labelItemId), parseFloat(txtGRNQty),
                parseFloat(txtQty), parseFloat(bigCartonQty), parseFloat(itemAllQty), parseFloat(alreadyQty), txtLotCode, txtDateCode, txtVendorCode, POorder, factoryCode, remark, parseInt(rowId), Boolean(isSupplyPrint), textDateCode, textMPN);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //$("#lblMessage").html(ajax.error.Message);
                    //$("#lblMessage").css("color", "red");
                    showAreaMessge(ajax.error.Message, "messageRed");
                    return false;
                }
                var arr = ajax.value;
                if (arr != null) {
                    //$("#lblMessage").html("<%=Resources.Messages.GenGrnFinishAndPrintInProcess %>");
                    setTimeout(function () {
                        try {
                            printGRN(arr);

                        }
                        catch (e) {
                            alert(e);
                            //$("#lblMessage").html(e);
                            showAreaMessge(e, "messageRed");
                        }
                    }, 100);
                }
            }, 100);
        }


        var cartonArr = "";
        function printGRN(arr) {
            if (arr == null) {
                return false;
            }
            arr[0] = arr[0].substring(0, arr[0].lastIndexOf(","));
            arr[1] = arr[1].substring(0, arr[1].lastIndexOf(","));
            grnArr = arr[0].split(","); //物料条码
            cartonArr = arr[1].split(",");  //包装条码
            //将GRN信息添加到SNInfo的SNInfo.SNList集合中
            SNInfo = {};
            SNInfo.SNList = grnArr;
            SNInfo.CartonList = cartonArr;

            //判断配置 供应商是否启用物料条码规则
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfigByID(1089);
            if (ajax.error == null) {
                var entity = ajax.value;
                if (entity.ConfigResult == "1") {
                    labelType = -3;           //标签类型 -3：物料条码标签类型
                }
                else {
                    labelType = -24;          //标签类型 -24：供应商条码标签类型
                }
            }
            //判断配置 供应商是否启用物料条码规则

            //根据打印方式决定 调用ZPL还是Lab打印
            usePrinGRNMethod();
            if (bigCartonQty != 0) {
                usePrintCartonMethod();
            }
            //打印完成刷新页面
            setTimeout(function () {
                //document.forms[0].submit();
                showAreaMessge("PO单" + $("#txtPoNumber").val() + ",物料编码:" + $("#txtItemName").val() + "打印完成", "messageGreen"); //messageRed,messageGreen
                Empty(4);
            }, 1000);
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelStationId = -1;    //工位Id
        var labelType = -24;          //标签类型  (1.GRN 2.包装)-24:供应商标签类型
        var labelSequence = 2;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        //获取物料条码文档模板基础信息
        function getGRNDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                templateid = entity.TemplateID;
                lableTypeQty = entity.PlateQty;           //连板数量
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
        var templateid = null;
        //获取包装箱条码文档模板基础信息
        function getCartonDocumentInfo() {
            labelType = -4; //包装类型
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                templateid = entity.TemplateID;
                lableTypeQty = entity.PlateQty;           //连板数量
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
        function mesLabLabelPrint(PrintType) {
            //从已释放的标签信息集合中，获取SN序列号集合。
            var ShowInfo = "";
            if (PrintType == 1) {  //物料条码
                lableArr = SNInfo.SNList;
                ShowInfo = "条码生成,打印成功";
            }
            else if (PrintType == 2) {
                lableArr = SNInfo.CartonList;
                ShowInfo = "包装箱生成,打印成功";
            }
            var labelStr = "";
            var printdata = [];
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
                showAreaMessge(lableArr[i] + ShowInfo, "messageGreen");
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
            /*循环GRN结束*/
            try {
                sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
                $("#lblMessage").html("");
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
        }

        function toThousands(s) {
            if (/[^0-9\.]/.test(s)) return "不是数值类型";
            s = s.replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
            return s;
        }

        function GetPoNumberItemCode2(PoNumber, rowId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetAllItemByPoCode(PoNumber, rowId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var items = ajax.value;
            if (items.length > 0) {
                var item = items[0];
                $("#txtItemName").val(item.ItemCode);
                $("#hdnItemId").val(item.ItemID);
                $("#<%=this.lblSpec.ClientID %>").text(item.ItemSpec);
                $("#txtGRNQty").focus();
                $("#txtItemName").attr("disabled", "disabled");
                $("#<%=this.lblPOQty.ClientID %>").text(item.BuyQty);
                $("#hdnRowId").val(item.RowId);
                var qty = item.MinPackQty == "" ? 0 : parseInt(item.MinPackQty)
                $("#txtQty").val(qty); //最小包装数量
                //获取订单数量跟已打数量
                itemAllQty = item.BuyQty;
                if (PoNumber != "") {
                    GetQty($("#txtPoNumber").val(), item.ItemCode, item.RowId);
                }
            }
            else {                
                //清空数据
                Empty(2);
                GetPoNumberItemCode(PoNumber);
            }
        }
        //#region 设置消息提示框样式
        /*
        * 设置消息提示框样式
        */
        function showAreaMessge(information, styleClass) {
            debugger;
            var currentTime = getDateTime();
            var messageBox = $("#activeinfoarea");
            var rows = 100;

            messageBox.find("span").eq(rows - 2).nextAll().remove(); //显示50条扫描记录        
            var html = "<span  class=" + styleClass + ">" + "[" + currentTime + "] " + information + "</span>" + '<br/>' + messageBox.html();
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
