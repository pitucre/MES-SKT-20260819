<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OfflinePrintGRN.aspx.cs" Inherits="SKT.LeanMES.Web.Material.OfflinePrintGRN"
    MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">打印单号<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtPoNumber" class="TextBox" disabled="disabled" isrequired='1' /><input
                    type="button" id="btnSelectPo" class="ButtonBox" value="..." onclick="selectPoNumber()" />

                <%-- 2017-09-09 ,wenshun ,到货单打印功能，创维专利，正式版本不需要,
                    <input type="text" id="txtShowPOCode" class="TextBox" disabled="disabled" isrequired='1' /><input
                    type="button" id="btnSelectPo" class="ButtonBox" value="..." onclick="selectPoNumber()" /><input type="text" id="txtPoNumber" class="TextBox" style="display:none" />--%>
            </td>
            <td class="Label2">
                <%=Resources.lang.MaterialCode%><em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="-1" id="hdnItemId" />
                <input type="hidden" value="-1" id="hdnRowId" />
                <input type="text" id="txtItemName" class="TextBox" isrequired='1' disabled="disabled" value="" /><input
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
        <%--        <tr>
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
                <input type="text" id="txtQty" isrequired='1' class="NumericBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" onchange="VerifyQty();" />
                <input type="hidden" value="" id="hdfQty" />
            </td>
        </tr>--%>
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

            <td class="Label2" id="tdLotCode">
                <%=Resources.lang.LotSize %><em>*</em>
            </td>
            <td class="Field2">
                <%--                <asp:Label runat="server" ID="lblLotCode"></asp:Label>--%>
                <input class="TextBox" id="lblLotCode" />
            </td>
            <td class="Label2">
                <%=Resources.lang.ProduceDate %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtProdDate" class="" IsRequired='1' disabled="disabled"
                    runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">DateCode(周数)
            </td>
            <td class="Field2">
                <input class="TextBox" id="textDateCode" isnumber='1' type="number" min="1" onblur="if(value <0 ){value = '1'}" />
            </td>
            <td class="Label2">MPN
            </td>
            <td class="Field2">
                <input class="TextBox" id="textMPN" />
            </td>
        </tr>
        <tr>

            <td class="Label2" style="display: none">外包装最小包装数量<em>*</em>
            </td>
            <td class="Field2" style="display: none">
                <input type="text" id="txtBigCartonQty" value="0" class="NumericBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" onchange="VerifyPrintQty();" />
            </td>
        </tr>
        <tr>
            <td class="Label2">请扫描条码:</td>
            <td class="Field2">
                <input type="text" value="" id="txtGRN" onchange="VerifyPrintQty();" style="width: 90%; height: 30px" />
                <%--<input type="button" value="查看GRN列表" onclick="Show()" />--%>
            </td>
            <td class="Label2">数量:</td>
            <td class="Field2">
                <input type="text" id="txtQty" runat="server" isnumber='1' />
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
    <div class="ListTableTitle">
        <div style="left: 10px; top: 5px; line-height: 18px;">
            <span>物料条码列表</span><span>      已扫描条码数量:</span><span id="Sum">0</span>
        </div>
    </div>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th>序号
                </th>
                <th>GRN
                </th>
                <th>数量
                </th>
                <th>操作
                </th>
            </tr>
        </thead>
        <tbody>
            <tr id="trLast" class="ListTableOddRow">
                <td colspan="6" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </tbody>
    </table>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
        <div id="lblPt" class="Tips">
        </div>
    </div>
  <%--  <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>--%>
    
    <script type="text/javascript">
        var arrGRN = [];//离线登记的GRN列表
        var qtyReg = /^[+-]?(0|([1-9]\d*))(\.\d+)?$/;//正整数校验正则
        var labelItemId = -1; //打印产品
        var factoryCode = "";
        var itemAllQty = 0;
        var alreadyQty = 0; //已经打印数量
        var bigCartonQty = 0; //外包装最小包装数量
        var selItemCode = '';
        //修复IQC打印时，GRN没有绑定IQC单号的BUG   BirongLiang 2017-4-13

        var printChoosePageId = 101;
        var selIqcOrder = '';
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
            $("#txtProdDate").datepicker({ minDate: 0, maxDate: "+1M +10D" });
            $("#txtProdDate").val(GetDateStr(0));
            $("#textDateCode").val(Math.abs((((new Date(GetDateStr(0))) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1));

            //GRN扫描事件
            $("#txtGRN").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var itemId = $.trim($("#hdnItemId").val());
                    if (itemId == "" || itemId == "-1") {
                        alert("请先选择物料编码");
                        $("#txtItemName").focus();
                        return;
                    }
                    var grn = $.trim($("#txtGRN").val().replace(":", "").replace("'", ""));
                    var qty = $.trim($("#<%=txtQty.ClientID %>").val());
                    if (grn == '') {
                        alert("请扫描GRN");
                        $("#txtGRN").focus();
                        return false;
                    }
                    if (existsGRN(grn)) {
                        alert("条码已扫描");
                        $("#txtGRN").val('').focus();
                        return false;
                    }
                    
                    //验证GRN是否存在
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.OfflineValidateGRN(grn);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        $("#txtGRN").val('').focus();
                        return false;
                    }
                    if (ajax.value != null && ajax.value != "") {
                        alert(ajax.value);
                        $("#txtGRN").val('').focus();
                        return false;
                    }

                    if (qty == "") {
                        alert("若扫描条码，请输入数量");
                        $("#<%=txtQty.ClientID %>").val('').focus();
                        return false;
                    }

                    //判断数量格式是否正确
                    if (!qtyReg.test(qty)) {
                        alert("数量格式不正确");
                        $("#<%=txtQty.ClientID %>").val('').focus();
                        return false;
                    }

                    var grnSum = getScanGRNCount();
                    var Sum = parseInt($("#ContentPlaceHolder1_viewcontent_lblPOQty").html());//单据总数量
                    var userSum = parseInt($("#ContentPlaceHolder1_viewcontent_lblPrintQty").html());//已打印数量
                    if (grnSum + parseInt(qty) > Sum - userSum) {
                        alert("扫描的GRN数量已经大于单据剩余数量！");
                        return false;
                    }

                    var objGRN = {};//单个扫码的GRN对象，包括数量
                    objGRN.GRN = grn;
                    objGRN.Qty = parseFloat(qty);
                    arrGRN.push(objGRN);
                    $("#txtGRN").val("").focus();
                    $("#<%=txtQty.ClientID %>").val("1");
                    Show();
                }
            });
        });

        //根据选择时间设置DateCode(周数)
        function BindDatepicker() {
            $("#txtProdDate").datepicker({
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
                    var time1 = $("#txtProdDate").val();
                    var weekofyear = (((new Date(time1)) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1;
                    $("#textDateCode").val(Math.abs(weekofyear));
                },
                gotoCurrent: true,
                changeMonth: true,
                changeYear: true
            });
        }

        //判断扫码的GRN是否存在于已扫GRN列表中
        function existsGRN(grn) {
            for (var i = 0; i < arrGRN.length; i++) {
                if (arrGRN[i].GRN == grn) {
                    return true;
                }
            }
            return false;
        }

        //获取扫描GRN的总数量
        function getScanGRNCount() {
            var count = 0;
            for (var i = 0; i < arrGRN.length; i++) {
                count = count*1 + arrGRN[i].Qty*1;
            }
            return count;
        }

        //选择采购单号
        function selectPoNumber() {
            var SearchCondition = "";
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserId%>";
            var UserType = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserType%>";

            //只要是系统用户可以看到所有供应商的
            if (UserType != "-1") {
                SearchCondition = "SupplierId =" + UserType;
            }
            
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + printChoosePageId + "&Multiple=false&PageCondition="
                 + escape(SearchCondition) + "&CallBackFunc=setPONumber&rnd=" + Math.random(), width: 850, height: 400
            });
        }
        //var showpoid = 0;
        function setPONumber(list) {
            if (printChoosePageId * 1 == 101) //选采购订单的物料打印,到货单的物料打印
            {
                //清空数据
                Empty(1);
                $("#txtPoNumber").val(list[0][1]);
                //选择采购订单带出供应商
                $("#hdnVendorCode").val(list[0][2]);
                $("#<%=this.lblVendorCode.ClientID %>").text(list[0][2]);
                $("#<%=this.lblVendorName.ClientID %>").text(list[0][3]);
                factoryCode = list[0][4];
            }
            if (printChoosePageId * 1 == 102) //选IQC单的物料打印
            {
                //清空数据
                Empty(1);
                Empty(2);
                window.selItemCode = list[0][5];
                $("#txtPoNumber").val(list[0][3]);
                $("#hdnVendorCode").val(list[0][6]);
                $("#<%=this.lblVendorCode.ClientID %>").text(list[0][6]);
                $("#<%=this.lblVendorName.ClientID %>").text(list[0][8]);
                factoryCode = list[0][7];
                selIqcOrder = list[0][1];
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetAllItemByVendor(list[0][1]);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var items = ajax.value;
            if (items.length === 1) {
                var item = items[0];
                $("#txtItemName").val(item.ItemCode);
                $("#hdnItemId").val(item.ItemID);
                $("#txtGRNQty").focus();
                $("#txtItemName").attr("disabled", "disabled");
                $("#<%=this.lblPOQty.ClientID %>").text(item.BuyQty);
                $("#hdnRowId").val(item.RowId);
                //var qty = item.MinPackQty == "" ? 0 : parseInt(item.MinPackQty)
                //$("#txtQty").val(qty); //最小包装数量
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

        //选择产品
        function selectItem() {
            //清空数据
            //Empty(2);
            //var pageId = "72";
            var POorder = $("#txtPoNumber").val(); //采购单号
            if (POorder == "") {
                alert("请选择采购单号！");
                $("#btnSelectPo").focus();
                return false;
            }
            var SearchCondition = " POorder='" + POorder + "'";
            if (window.selItemCode !== "") {
                SearchCondition += " AND ItemCode = '" + window.selItemCode + "' ";
            }

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=72&PageCondition=" + escape(SearchCondition) + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtItemName").val(list[0][1]);
            $("#hdnItemId").val(list[0][0]);
            $("#txtItemName").attr("disabled", "disabled");
            $("#<%=this.lblPOQty.ClientID %>").text(list[0][3]);
            $("#hdnRowId").val(list[0][4]);
            //var qty = list[0][0] == "-1" ? 0 : parseInt(list[0][5]);
            //$("#txtQty").val(qty); //最小包装数量
            //获取订单数量跟已打数量
            itemAllQty = list[0][3];

            if (list[0][0] != "-1") {
                GetQty($("#txtPoNumber").val(), list[0][1], list[0][4]);
            }
        }

        //清空所有的数据
        function Empty(flag) {
            if (flag == 1) {
                $("#txtPoNumber").val("");
                $("#hdnVendorCode").val("");
                $("#<%=this.lblVendorName.ClientID %>").text("");
            }
            $("#txtItemName").val("");
            $("#hdnItemId").val(-1);
            $("#hdnRowId").val(-1);
            $("#hdfGRNQty").val("");
            $("#hdfQty").val("");
            $("#<%=txtQty.ClientID %>").val("1");
            $("#<%=this.lblPOQty.ClientID %>").text("");
            $("#<%=this.lblPrintQty.ClientID %>").text("");
            //            $("#txtProdDate").val("");
            $("#txtEffectiveDate").val("");
            $("#txtRemark").val("");
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
            if (printChoosePageId * 1 !== 102) {
                $("#txtGRNQty").val(itemAllQty - alreadyQty);
            }
        }

        //验证打印条码数量
        function VerifyPrintQty() {
            <%--
            var PoQty = $("#<%=this.lblPOQty.ClientID %>").text();        //该PO单下该物料的总数量
            var PrintQty = $("#<%=this.lblPrintQty.ClientID %>").text();  //已打印的最小包装数量
            if (parseInt(PoQty) <= parseInt(PrintQty)) {
                alert("该采购订单下该物料的数量已经打完！")
                return false;
            }--%>
        }
        function Show() {
            var data = "";
            $("#tblRecHistory tbody").html("");
            if (arrGRN.length == 0) {
                alert("没有GRN信息,请进行扫描！");
                $("#txtGRN").focus();
                return false;
            }
            var scanHtml = bullderScanHtml();
            $("#tblRecHistory tbody").append(scanHtml);
            var grnSum = getScanGRNCount();
            $("#Sum").html(grnSum);

            //layer.open({
            //    type: 1,
            //    area: ['50%', '60%'],
            //    // offset: ['10px', '10px'],
            //    shadeClose: true, //点击遮罩关闭
            //    content: data
            //});
        }

        //将GRN数组拼接成HTML代码
        function bullderScanHtml() {
            var html = "";
            for (var i = 0; i < arrGRN.length; i++) {
                html += "<tr><td class='Field1' style='width:20%;text-align: center;'>" + (i + 1) + "</td><td class='Field1' style='width:30%;text-align: center;'>" + arrGRN[i].GRN + "</td>"
                    + "<td class='Field1' style='width:30%;text-align: center;'>" + arrGRN[i].Qty + "</td>"
                    + "<td class='Field1' style='width:20%;text-align: center;'><img title='删除' src='../Content/images/delete.gif' onclick=Delet('" + arrGRN[i].GRN + "')></img></td></tr>";
            }
            return html;
        }

        //删除GRN
        function Delet(grn) {
            var idx = -1;
            for (var i = 0; i < arrGRN.length; i++) {
                if (arrGRN[i].GRN == grn) {
                    idx = i;
                    break;
                }
            }
            if (idx > -1) {
                arrGRN.splice(idx, 1);
            }
            //重置列表
            var html = bullderScanHtml();
            $("#tblRecHistory tbody").html(html);
            var grnSum = getScanGRNCount();
            $("#Sum").html(grnSum);
        }

        function Save() {
            var POorder = $("#txtPoNumber").val();    //采购单号
            labelItemId = $("#hdnItemId").val();
            bigCartonQty = $("#txtBigCartonQty").val(); //最外包装数量
            var txtLotCode = $("#lblLotCode").val();
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
            if (txtVendorCode == "") {
                errStr += "<%=Resources.Messages.SelectVendorCode %>\n";
            }
            if (labelItemId == -1) {
                errStr += "<%=Resources.Messages.SelectMaterial %>\n";
            }
            if (txtDateCode == "") {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>\n";
            }
            if (arrGRN.length == 0) {
                alert("请扫描GRN信息");
                return false;
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

            if (!window.confirm("是否生成GRN")) {
                return false;
            }
            var isSupplyPrint = 0; //1:由供应商打印  0：不是由供应商打印
            $("#lblMessage").html("正在生成GRN，请稍候...");
            var grns = splitArrGrn();//拼接GRN
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.OfflineGenerateGRN(parseInt(labelItemId), parseInt(0),
                parseFloat(0), parseFloat(0), parseFloat(0), parseFloat(0), txtLotCode, txtDateCode, txtVendorCode, POorder, factoryCode, remark, parseInt(rowId), Boolean(isSupplyPrint), textDateCode, textMPN, grns, selIqcOrder);//, POInStockNo
            if (ajax.error != null) {
                $("#lblMessage").html(ajax.error.Message);
                $("#lblMessage").css("color", "red");
                return false;
            }
            $("#lblMessage").html("生成完成");
            //打印完成刷新页面
            setTimeout(function () {
                document.forms[0].submit();
            }, 1000);
        }

        //拼接GRN
        function splitArrGrn() {
            var grns = "";
            for (var i = 0; i < arrGRN.length; i++) {
                grns += (i == 0 ? "" : ",") + arrGRN[i].GRN + ":" + arrGRN[i].Qty;
            }
            return grns;
        }

        function toThousands(s) {
            if (/[^0-9\.]/.test(s)) return "不是数值类型";
            s = s.replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
            return s;
        }
    </script>
</asp:Content>
