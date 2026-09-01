<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialReceive.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialReceive" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <style>
        .popedomBtn {
            display: none;
        }
    </style>
    <table width="100%" class="EditeContentTable">
        <%--        <tr>
            <td class="Label Tips" align="left" colspan="6">
                <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" />请选择对应的到货订单。
            </td>
        </tr>--%>
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%-- 来源单号<em>*</em>--%>
                <asp:DropDownList runat="server" ID="ddlFromOrder" ClientIDMode="Static" onchange="selonchange()">
                   
                    <%--<asp:ListItem Value="104">到货单</asp:ListItem>--%>
                    <asp:ListItem Value="105">送货单</asp:ListItem>
                     <asp:ListItem Value="103">采购单号</asp:ListItem>
                </asp:DropDownList>
                <em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="hdnBuyNO" />
                <input type="text" id="txtBuyNO" class="TextBox" maxlength='50' /><input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectDeliverOrder()" />
            </td>
            <td class="Label2">供应商编码
            </td>
            <td class="Field2">
                <asp:Label ID="lblVendorCode" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2 popedomBtn">
                <input type="checkbox" id="chkScanGRN" value="1" onclick="NotScanGRN();" />
            </td>
            <td class="Field2 popedomBtn"><span>不扫描物料条码,直接收料</span>
            </td>
            <%--<td class="Label2">优先级<em>*</em>
            </td>
            <td class="Field2">
                <select id="level">
                    <option value="1">一般</option>
                    <option value="2">紧急</option>
                </select>
            </td>--%>
            <td class="Label2">供应商名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblVendorName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <%--        <tr>
            <td class="Label Tips" align="left" colspan="6" style="height: 30px">
                <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" />您可以扫描物料条码或包装箱条码来收料。
            </td>
        </tr>--%>
        <tr>
            <td class="Label2">
                库位条码
            </td>
            <td class="Field2">
                <input class="WarehouseBarCode" id="WarehouseBarCode" type="text"  value="" style=" height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
            <td class="Label2">
                <%=Resources.lang.ScanGrnCartonOrGrn%><em>*</em>
            </td>
            <td class="Field2">
                <input type="text" value="" id="txtGRN" class="TextBox" style="height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>
    </table>
    <div style="text-align: center; margin-top: 5px;" class="Tips" id="msg">
    </div>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            到货单明细
        </div>
    </div>
    <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px; margin-bottom: 5px;">
        <tr class="ListTableHeader" style="background-color: Yellow">
            <th style="width: 5%">选择
            </th>
            <th style="width: 5%">行号
            </th>
            <th style="width: 20%">物料编码
            </th>
            <th style="width: 30%">物料名称
            </th>
            <th style="width: 10%">到货数量
            </th>
            <th style="width: 10%">已收数量
            </th>
            <th style="width: 10%">实收数量<em>*</em>
            </th>
            <th>操作
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="10" style="text-align: center;"><span>暂无数据</span>
            </td>
        </tr>
    </table>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            物料条码列表
        </div>
        <span style="height: 15px; width: 50px; margin-left: 100px; display: inline-block; background-color: #99FF33"></span><span>已扫描条码</span>
    </div>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <tr class="ListTableHeader">
            <th>物料条码
            </th>
            <th>物料编码
            </th>
            <th>物料名称
            </th>
            <th>批次号
            </th>
            <th>数量
            </th>
        </tr>
        <tr id="trLast" class="ListTableOddRow">
            <td colspan="6" style="text-align: center;"><span>暂无数据</span>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div id="tblInfo">
    </div>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.material.js"
        type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        var deliverOrder = ""; //送货单
        var OrderList = []; //送货单细项列表
        var IsScanGRN = 0; //0:扫描物料条码  1：不扫描物料条码
        var CheckItemCode = '';//被选中的物料默认为''
        var orderTypeId = -1;
        var receiveChoosePageId = -1;

        /*JS检查用户是否具有某一权限*/
        function IsHasPermission(userId_int, popedom_int) {
            return SKT.LeanMES.Web.AjaxServices.AjaxClient.IsPermission(userId_int, popedom_int).value;
        }

        $(function () {
            receiveChoosePageId = $("#ddlFromOrder").val();
            if (IsHasPermission(userId, 11480016)) {
                $(".popedomBtn").show();
            }

            $("#txtBuyNO").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    if ($.trim($("#txtBuyNO").val()) != "") {
                        //回车只显示GRN信息   
                        deliverOrder = $.trim($("#txtBuyNO").val());
                        refreshGRNDetail = "";
                        showOrderDelList(deliverOrder, "-1");
                    }
                    return false;
                }
            });
            /*扫描库位条码*/
            $("#WarehouseBarCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#msg").html('');
                    if ($(this).val() == "") {
                        $("#msg").html("库位条码不能为空!").css({ "color": "red", "text-align": "center" });
                        $(this).focus();
                        return false;
                    }
                    try {
                        checkbarcode();
                        //$("#sn").focus().select();
                        //$("#sn").select();
                    } catch (e) {
                        $("#msg").html(e).css({ "color": "red", "text-align": "center" });
                        $("#txtGRN").focus().select();
                        return false;
                    }
                }
            });
            /*扫描条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtGRN").val()) != "") {
                        var txtGRN = $.trim($("#txtGRN").val());
                        refreshGRNDetail = "";
                        checkScanGRN(txtGRN);
                    } else {
                        alert("请扫描GRN或者包装箱号！");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                }
            });
        });

        function getConfigType() {
            var orderType = $("#ddlFromOrder").val();
            if (orderType == '103') orderTypeId = 1;    //采购单
            if (orderType == '104') orderTypeId = 2;    //到货单
            if (orderType == '105') orderTypeId = 3;    //送货单
            return orderTypeId;
        }
        function selonchange(){
            receiveChoosePageId = $("#ddlFromOrder").val();
        }


        function checkbarcode() {
            //验证库位
            $.post("../Handler/InStock.ashx?api=GetBarCode", { "station": $.trim($("#WarehouseBarCode").val()) }, function (ajax) {
                if (ajax.error != null) {
                    confirmDialogFocus(ajax.error.Message, function () {
                        $("#station").val('').focus();
                    });
                    return false;
                }
                var en = $.parseJSON(ajax);
                if (!en.BarCode) {
                    $("#msg").html("库位【" + $("#WarehouseBarCode").val() + "】不存在!").css({ "color": "red", "text-align": "center" });
                    $("#WarehouseBarCode").val("");
                    $("#WarehouseBarCode").focus();
                    return false;
                }
                else {

                    $("#msg").html("库位扫描成功").css({ "color": "green", "text-align": "center" });
                    $("#txtGRN").focus();
                    return true;
                }
            });
        }






        //验证物料条码/包装条码
        function checkScanGRN(scanGRN) {
            deliverOrder = $.trim($("#txtBuyNO").val());
            if (deliverOrder == "") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetReceiveOrderBySN(scanGRN, receiveChoosePageId);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message).css({ "color": "red", "text-align": "center" });
                    return false;
                }
                var en = $.parseJSON(ajax.value).data;
                if (en[0].ReceiveOrder != "") {
                    deliverOrder = en[0].ReceiveOrder;
                    $("#txtBuyNO").val(deliverOrder);
                    $("#hdnBuyNO").val(deliverOrder);
                }
            }
            if (deliverOrder == "") {
                $("#msg").html("扫描获取单据数据为空，请先切换单据类型或者选择单据后再扫描").css({ "color": "red", "text-align": "center" });
                return false;
            }

            var poDetailId = -1;
            $("#tbBuyOrderDetail").find(":checkbox:checked").each(function () {
                poDetailId = $(this).val();
            });
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetGRNInfoByReceive(getConfigType(), scanGRN, deliverOrder, poDetailId);
            if (ajax.error != null && ($.trim(ajax.error.Message) == "该物料条码已经扫描完成!" || $.trim(ajax.error.Message) == "该包装条码已经扫描完成!")) {
                if (confirm(ajax.error.Message + " 是否清除?")) {
                    OrderSingleDelClick();
                    return true;
                } else {
                    //获取信息
                    showOrderDelList(deliverOrder, "-1");
                    var entity = $.parseJSON(ajax.value).data;
                    if (entity != null && entity.length > 0) {
                        for (var i = 0; i < entity.length; i++) {
                            $("#tblRecHistory tr").each(function () {//循环table的每行（tr）
                                var tdArr = $(this).children();
                                var grn = tdArr.eq(0).text();  //物料条码
                                if (grn == entity[i].SerialNumber) {//去掉首尾空格并匹配td的内容
                                    $(this).css("background", "#99FF33");
                                    return false;
                                }
                            });
                        }
                    }
                }
                return false;
            } else if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            else {
                //获取信息
                showOrderDelList(deliverOrder, "-1");
                var entity = $.parseJSON(ajax.value).data;
                if (entity != null && entity.length > 0) {
                    for (var i = 0; i < entity.length; i++) {
                        $("#tblRecHistory tr").each(function () {//循环table的每行（tr）
                            var tdArr = $(this).children();
                            var grn = tdArr.eq(0).text();  //物料条码
                            if (grn == entity[i].SerialNumber) {//去掉首尾空格并匹配td的内容
                                $(this).css("background", "#99FF33");
                                return false;
                            }
                        });
                    }
                }
            }
        }

        //选中到货单列表
        function selectDeliverOrder() {
            var curSelOrderType = $("#ddlFromOrder").val();
            var SearchCondition = "";
            //if (curSelOrderType=="103") {
            //    SearchCondition = " POCode NOT IN(SELECT mya.POCode FROM ERP_PurOrderDtl mya WHERE mya.PStatus=2) ";
            //}
            
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + curSelOrderType + "&CallBackFunc=setBuyValue&Multiple=false&PageCondition=" + escape(SearchCondition) + "&rnd=" + Math.random(), width: 650, height: 380
            });
        }

        function setBuyValue(list) {
            $("#txtBuyNO").val(list[0][1]);
            $("#hdnBuyNO").val(list[0][1]);
            $("#<%=this.lblVendorCode.ClientID %>").text(list[0][2]); //供应商编码
            $("#<%=this.lblVendorName.ClientID %>").text(list[0][3]); //供应商名称
            showOrderDelList(list[0][1], "-1");
            refreshGRNDetail = "";
        }

        //显示送货单明细
        function showOrderDelList(deliverOrder, grnCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.GetMaterialDeliverDtl(deliverOrder, grnCode, getConfigType(), Boolean(IsScanGRN));
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            $("#msg").html("");
            $("#msg").css("color", "");

            var entity = $.parseJSON(ajax.value).data;
            var entityGRN = $.parseJSON(ajax.value).data1;

            OrderList = [];
            //添加送货项列表
            $.grep(entity, function (e, i) {
                OrderList.push(e);
            });
            if (refreshGRNDetail == "RefreshGRN") {
                GetGRNInfo(entityGRN);
            }
            else {
                GetOrderDelList(entity);
                GetGRNInfo(entityGRN);
            }


        }
        function GetOrderDelList(entity) {
            if (entity != null && entity.length > 0) {
                //当扫描GRN条码的时候，查出送货单和供应商信息
                $("#txtBuyNO").val(entity[0].DeliverNo);
                $("#hdnBuyNO").val(entity[0].DeliverNo);
                $("#<%=this.lblVendorCode.ClientID %>").text(entity[0].VendorCode); //供应商编码
                $("#<%=this.lblVendorName.ClientID %>").text(entity[0].VendorName); //供应商名称

                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#trNewInfo").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel

                for (var i = 0; i < entity.length; i++) {

                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    cel = row.insertCell(0);
                    cel.innerHTML += "<input type='checkbox' id='checkBox" + i + "' value='" + entity[i].DeliverDtlId + "' onclick='OrderDetailClick(this," + entity[i].DeliverDtlId + "," + i + ")' />";

                    cel = row.insertCell(1);
                    cel.innerHTML = i + 1;
                    cel.innerHTML += "<input type='hidden' id='RowID" + i + "' value='" + entity[i].DeliverDtlId + "'/>";

                    cel = row.insertCell(2);
                    cel.innerHTML = entity[i].ItemCode;
                    cel.id = 'tdInvCode' + i;

                    cel = row.insertCell(3);
                    cel.innerHTML = entity[i].ItemName;
                    cel.id = 'tdInvName' + i;

                    cel = row.insertCell(4);
                    cel.innerHTML = parseFloat(entity[i].SentQty);

                    cel = row.insertCell(5);
                    cel.innerHTML = parseFloat(entity[i].AScanQty);

                    if (entity[i].ReceiveQty == "") {
                        //GRN已经被删除的情况下
                        entity[i].ReceiveQty = 0;
                    }
                    cel = row.insertCell(6);
                    if (entity[i].HaveGRN == "1") {
                        cel.innerHTML = "<input type='text' style='width: 80%' id='SentQty" + i + "' value='"
                        + parseFloat(entity[i].ReceiveQty) + "' class='NumericBox50' disabled='disabled' IsNumber='1' IsRequired='1' " +
                        " onchange='isPositiveNum(this)'/>";
                    }
                    else {
                        cel.innerHTML = "<input type='text' style='width: 80%' id='SentQty" + i + "' value='"
                        + entity[i].ReceiveQty + "' class='NumericBox50' IsRequired='1' " +
                        " onchange='ChangeQty(" + i + " , " + JSON.stringify(OrderList[i]) + ")'/>";
                    }

                    cel = row.insertCell(7);
                    cel.innerHTML += "<input type='button' id='budel" + i + "' value='清除' onclick='OrderDelClick(this," + entity[i].DeliverDtlId + "," + i + ")' />";
                }
            }
            else {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#tbBuyOrderDetail tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="10" align="center"><font color="red">暂无数据</font></td></tr>');
            }
        }



        /*通过GRN获取物料信息*/
        function GetGRNInfo(list) {
            if (list != null && list.length > 0) {
                $("#msg").html("");
                $("#msg").css("color", "");

                if (list == null || list.length == 0) {
                    return false;
                }
                $("#txtGRN").val("");
                $("#trLast").remove();

                var strHtml = "";
                for (var i = 0; i < list.length; i++) {
                    var isScanGRN = list[i].IsGRNScan;  //0表示没有扫描 1表示扫描
                    if (isScanGRN == 0) {
                        strHtml += "<tr class='ListTableOddRow'>";
                    }
                    else {
                        strHtml += "<tr class='ListTableOddRow' style='background-color:#99FF33'>";
                    }
                    strHtml += "<td>" + list[i].GRN + "</td>";
                    strHtml += "<td>" + list[i].ItemCode + "</td>"
                        + "<td>" + list[i].ItemName + "</td>"
                        + "<td>" + list[i].LotCode + "</td>"
                        + "<td>" + parseFloat(list[i].BalanceQty) + "</td>"
                    strHtml += "</tr>";


                }
                $("#tblRecHistory tr:not(:first)").each(function () {
                    $(this).remove();
                });
                if ($("#tblRecHistory tr").length == 1) {
                    $("#tblRecHistory tr:eq(0)").after(strHtml)
                }
                else {
                    $("#tblRecHistory tr:eq(1)").before(strHtml)
                }
                //$("#tblInfo").html("<img src=\"../Content/images/icon/comment.png\" style=\"vertical-align:middle;\" alt=\"\"/>当前共有收料记录            <b>" + ($("#tblRecHistory tr").length - 1).toString() + "</b> 条");
            }
            else {
                $("#tblRecHistory tr:gt(0)").remove();
                $("#tblRecHistory tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="10" align="center"><font color="red">暂无数据</font></td></tr>');
            }
        }

        //确认收料
        function Save() {         
            var deliverCode = $("#hdnBuyNO").val();
            if (deliverCode == "") {
                alert("采购订单不能为空!");
                return false;
            }

            if (confirm('确定收料?')) {
                var entity = {};
                entity.ReceiveType = getConfigType();
                entity.IsScanGRN = Boolean(IsScanGRN);
                entity.PoCode = deliverCode;
                entity.UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
                entity.UrgentLevel = -1;//$("#level").val();

                //在不扫描条码的情况下，判断是否选择单条物料，如果选择单条物料，只对该物料进行收料 zhuchenglong 2017-10-27
                //if ($("#chkScanGRN").is(":checked")) {
                //    //debugger;
                //    //选择的物料
                //    var SN = $("#tbBuyOrderDetail input:checked").attr("id");
                //    if (SN) {
                //        SN = SN.replace('checkBox', '')
                //        var tempOrderList=[];
                //        tempOrderList[0] = OrderList[SN];
                //        OrderList = tempOrderList;
                //    }

                //}
                var re = /^[0-9]*[0-9][0-9]*$/;
                if (re.test(OrderList[0].ReceiveQty)) {
                    OrderList[0].ReceiveQty = OrderList[0].ReceiveQty.toFixed(6);
                }
                if (re.test(OrderList[0].SentQty)) {
                    OrderList[0].SentQty = OrderList[0].SentQty.toFixed(6);
                }
                entity.POTabDtl = JSON.stringify(OrderList);
                entity.InspectionId = -1;
                entity.remark1 = $("#WarehouseBarCode").val();  //库位条码

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.SaveReceiveMaterial(JSON.stringify(entity));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }

                $("#msg").html("收料成功!");
                $("#msg").css("color", "green");
                clearTableInfo();
                var iqcId = ajax.value;

                if (iqcId != null) {
                    var iqcIdArr = iqcId.split(",");
                    for (var i = 0; i < iqcIdArr.length; i++) {
                        if (iqcIdArr[i] == "") {
                            continue;
                        }
                        window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/IQCReceiveFormPrint.aspx?name=IQCRecivePdfPrint&ID=" + iqcIdArr[i]);
                    }
                }             
            }
        }

        //退货确认
        function Return() {
            var deliverCode = $("#hdnBuyNO").val();
            if (deliverCode == "") {
                alert("送货单号不能为空!");
                return false;
            }
            if (confirm('确定退货?')) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.MaterialReturn(deliverCode);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                $("#msg").html("退货成功!");
                $("#msg").css("color", "green");
                clearTableInfo();
            }
        }
        //清空列表
        function clearTableInfo() {
            $("#tblRecHistory tr:not(:first)").each(function () {
                $(this).remove();
            });
            $("#tblInfo").html("");
            var rightStr = "<tr id='trLast' class='ListTableOddRow'><td colspan='10' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr).appendTo($("#tblRecHistory"));
            $("#tbBuyOrderDetail tr:not(:first)").each(function () {
                $(this).remove();
            });
            var rightStr1 = "<tr id='trLast' class='ListTableOddRow'><td colspan='10' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr1).appendTo($("#tbBuyOrderDetail"));

            $("#txtBuyNO").val("");
            $("#hdnBuyNO").val("");
            $("#<%=this.lblVendorCode.ClientID %>").text("");
            $("#<%=this.lblVendorName.ClientID %>").text("");
        }
        //清除
        function OrderDelClick(obj, orderDetailId, i) {
            var POCode = $("#hdnBuyNO").val();
            if (POCode == "") {
                alert("单号不能为空!");
                return false;
            }
            if (confirm('确定清除?')) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.MaterialGRNDel(getConfigType(),POCode, orderDetailId,"");
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                $("#msg").html("清除成功!");
                $("#msg").css("color", "green");
                showOrderDelList(POCode, "-1");
            }
        }
        //单个GRN清除
        function OrderSingleDelClick() {
            var POCode = $("#hdnBuyNO").val();
            if (POCode == "") {
                alert("单号不能为空!");
                return false;
            }
            var GRN = $.trim($("#txtGRN").val());
            if (!GRN) {
                alert("条码不能为空!");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.MaterialGRNDel(getConfigType(), POCode, -1, GRN);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            $("#msg").html("清除成功!");
            $("#msg").css("color", "green");
            showOrderDelList(POCode, "-1");
        }


        //复选框行时间
        var refreshGRNDetail = "";
        function OrderDetailClick(obj, orderDetailId, i) {
            var grnCode = orderDetailId.toString();
            $("#checkBox" + i + "").is(":checked");
            var result = $("#checkBox" + i + "").is(":checked");
            //其他都不被选中
            if (result) { //选中
                //其他不被选中
                $("#tbBuyOrderDetail").find(":checkbox:checked").each(function () {
                    $(this).prop("checked", false);
                });
                $("#checkBox" + i + "").prop("checked", true);
                refreshGRNDetail = "RefreshGRN";
                deliverOrder = $.trim($("#txtBuyNO").val());
                showOrderDelList(deliverOrder, grnCode, getConfigType());
            }
        }

        //不扫描条码事件
        function NotScanGRN() {
            var selectResult = $("#chkScanGRN").is(":checked");
            if (selectResult) {
                IsScanGRN = 1; //不需要扫描物料条码
                $("#txtGRN").attr("disabled", true);
            } else {
                IsScanGRN = 0; //需要扫描物料条码
                $("#txtGRN").attr("disabled", false);
            }
            refreshGRNDetail = "";
            deliverOrder = $.trim($("#txtBuyNO").val());
            showOrderDelList(deliverOrder, "-1");
        }

        //送货数量修改
        function ChangeQty(i, e) {
            var qty = $("#SentQty" + i).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(qty)) {
                alert("请输入正整数！");
                $("#SentQty" + i).val('');
                return false;
            }
            if (qty <= 0) {
                alert("收货数量要大于0！");
                return false;
            }
            if (qty > (OrderList[i].SentQty - OrderList[i].AScanQty)) {
                alert("实际收货数量数量不能大于剩余可收货数量!");
                $("#SentQty" + i).val('');
                return;
            }
            OrderList[i].ReceiveQty = qty;
        }

        function isPositiveNum(obj) {//是否为正整数
            var s = $(obj).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(s)) {
                alert("请输入正整数！");
                $(obj).val(0);
                $(obj).focus();
                return;
            }
            if (s <= 0) {
                alert("收货数量要大于0！");
                $(obj).val(0);
                $(obj).focus();
                return false;
            }
        }
    </script>
</asp:Content>