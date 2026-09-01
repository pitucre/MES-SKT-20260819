<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialDeliver.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialDeliver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.js" type="text/javascript"></script>
    <link href="../Content/plugin/DataTables-1.10.12/css/jquery.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.dataTables.js" type="text/javascript"></script>
    <link type="text/css" href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify.css"
        rel="Stylesheet" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js?v=1"></script>
    <style>
        #tblRec th {
            background-color: #ececec;
            padding: 3px;
            height: 22px;
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体,宋体;
            color: #183152;
        }

        #tblRec tr td {
            border: 1px solid rgb(211, 211, 211);
        }

        thead td {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
        }

        table.dataTable.no-footer {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
        }

        .popedomBtn {
            display: none;
        }
    </style>

    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" align="left" colspan="6">
                <%=Resources.Messages.WithAsteriskIsRequired %>            
            </td>
        </tr>
        <tr>
            <td class="Label2">采购订单<em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="hdnBuyNO" runat="server" clientidmode="Static" />
                <input type="text" id="txtBuyNO" class="TextBox" style="width: 90%" runat="server" clientidmode="Static" /><input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectBuyOrder()" />
            </td>
            <td class="Label2">供应商
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="htnVender" />
                <asp:Label ID="lblVendorCode" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <%--        <tr>
            <td class="Label Tips" align="left" colspan="6">
                <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" />您可以扫描GRN条码或GRN的包装箱条码来查找采购单。
            </td>
        </tr>--%>
        <tr class="popedomTr">
            <td class="Label2">
                <%=Resources.lang.ScanGrnCartonOrGrn%>
            </td>

            <td class="Field2">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 95%; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
            <td class="Label2 popedomBtn">自动添加送货物料明细
            </td>
            <td class="Field2 popedomBtn">
                <input id="cbShowALL" type="checkbox" class="text" onchange="cbClick()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">备注
            </td>
            <td class="Field1" align="left" colspan="5">
                <input type="text" value="" id="txtRemark" class="TextBox" style="width: 98%; height: 50px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>
    </table>
    <br />
    <div id="msg" style="text-align: center"></div>
    <br />
    <div class="clear5">
    </div>
    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="Div1">送货单明细</li>
            <li>送货物料明细</li>
            <li>报告文件上传</li>
        </ul>

        <div class="tb_c tb_content">
            <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px">
                <tr class="ListTableHeader">
                    <th style="width: 5%">行号
                    </th>
                    <th style="width: 20%">采购单
                    </th>
                    <th style="width: 20%">采购单行号
                    </th>
                    <th style="width: 15%">物料编码
                    </th>
                    <th style="width: 30%">物料名称
                    </th>
                    <th style="width: 10%">剩余采购量
                    </th>
                    <th style="width: 10%">送货数量<em>*</em>
                    </th>
                    <th style="width: 10%">备品数量
                    </th>
                    <th style="width: 10%">装箱明细
                    </th>
                    <th style="width: 7%">操作
                    </th>
                </tr>
                <tr id="trNewInfo" class="ListTableOddRow">
                    <td colspan="9" style="text-align: center;">暂无数据
                    </td>
                </tr>
            </table>
        </div>
        <div class="tb_content">
            <table id="tblRec" class="row-border stripe" width="100%">
            </table>
        </div>
        <div class="tb_content">
            <%--  <div class="ListTableTitle">
                <div style="left: 5px; line-height: 18px;">
                    出货报告上传
                </div>
            </div>--%>

            <table class="EditeContentTable" width="100%" style="height: 40px;">
                <tr>
                    <td width="30%">&nbsp;&nbsp;<span>报告类型</span><em>*</em>
                        <asp:DropDownList ID="ddlType" runat="server" ClientIDMode="Static" Width="80px">
                            <asp:ListItem Value="ShippingReport">出货报告</asp:ListItem>
                            <asp:ListItem Value="TestReport">实验报告</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <div style="padding-top: 10px;" id="divfileUpload">
                        </div>
                    </td>
                    <td>
                        <div id="fileQueue">
                        </div>
                    </td>
                </tr>
            </table>
            <%-- <div class="ListTableTitle">
                <div style="left: 5px; line-height: 18px;">
                    实验报告上传
                </div>
            </div>--%>
            <%--  <table class="EditeContentTable" width="100%" style="height: 40px;">
                <tr>
                    <td width="30%">&nbsp;&nbsp;上传实验文件<em>*</em>
                    </td>
                    <td>
                        <div style="padding-top: 10px;">
                            <input type="file" name="fileUpload2" id="fileUpload2" style="width: 73px;" />
                        </div>
                    </td>
                    <td>
                        <div id="fileQueue2">
                        </div>
                    </td>
                </tr>
            </table>--%>

            <table id="tblShippingReport" class="ListTable" width="100%" style="margin-top: -1px;">
                <thead>
                    <tr class="ListTableHeader">
                        <th style="text-align: center; width: 150px;">序号
                        </th>
                        <th style="text-align: center; width: 150px;">报告类型
                        </th>
                        <th style="text-align: center; width: 150px;">文件名称
                        </th>
                        <th style="width: 150px; text-align: center;">文件属性
                        </th>
                        <th style="width: 150px; text-align: center;">上传人
                        </th>
                        <th style="width: 150px; text-align: center;">上传时间
                        </th>
                        <th style="width: 150px; text-align: center;" colspan="2">操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

    </div>

    <div class="clear5">
    </div>
    <div id="tblInfo">
    </div>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.material.js"
        type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        var OrderList = []; //采购单送货细项列表
        var GRNList = []; //送货GRN细项列表
        var NewGRNList = []; //送货GRN新细项列表(用于验证数量)
        var Vender = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType %>";
        var txtBuyNO = "";
        var IsSupplierPeriod = 2;//供应商是否交期维护：1：需要 2：不需要 默认不需要
        var cbShowAll = false;

        var limitType = ".php,.jsp,.asp,.cerphp,.php,.PHP,.php3,.jsp,.JSP,.aspx";

        var limitType = -2;//限制送货单中采购单类型，委外单不能和采购通放在同一送货单
        //$("#cbShowALL").hide();

        /*JS检查用户是否具有某一权限*/
        function IsHasPermission(userId_int, popedom_int) {
            return SKT.LeanMES.Web.AjaxServices.AjaxClient.IsPermission(userId_int, popedom_int).value;
        }

        function enterToTab() { }

        $(function () {
            if (IsHasPermission(userId, 11400602)) {
                $(".popedomBtn").show();
            }

            showIsSuppler();
            showRecDtl(0);
            $("#txtBuyNO").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    if ($.trim($("#txtBuyNO").val()) != "") {
                        //回车只显示GRN信息   
                        buyOrder = $.trim($("#txtBuyNO").val());
                        //showBuyOrderList(buyOrder,"P","",2);
                        txtBuyNO = $.trim($("#txtBuyNO").val());
                        if (scanPoCode(buyOrder)) {
                            $("#txtGRN").focus();
                            $("#txtGRN").select();
                        }
                    }
                    return false;
                }
            });
            /*扫描条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtGRN").val()) != "") {
                        showBuyGrn($.trim($("#txtGRN").val()), "G", $("#htnVender").val());
                        $("#txtGRN").val("");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    } else {
                        alert("请扫描GRN！");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                }
            });
            $("#divfileUpload").html("");
            var html = '<input type="file" name="fileUpload" id="fileUpload" style="width: 73px;" />';
            $("#divfileUpload").html(html);
            UpLoad();
        });

        //移除条码
        function DeleteBuyGrn(buyOrder, type) {
            $("#msg").html("");
            var bExists = false;
            var pocodes = "";
            for (var i = 0; i < OrderList.length; i++) {
                if (pocodes.indexOf(OrderList[i].POCode + ",") < 0) {
                    pocodes = pocodes + OrderList[i].POCode + ",";
                }
            }
            var cbShowAll = document.getElementById("cbShowALL").checked;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.GetDeliverInfo(buyOrder, type, $("#htnVender").val(), pocodes, cbShowAll);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            var data = $.parseJSON(ajax.value).data;

            bExists = false;
            for (var i = 0; i < GRNList.length; i++) {
                if (data[0].GRN == GRNList[i].GRN) {
                    bExists = true;
                }
            }
            if (!bExists) {
                $("#msg").html("条码未扫描,不需要移除操作！");
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                return false;
            }

            var OrderListTemp = [];
            var index = -1;

            OrderListTemp.push({});
            //按PO和PoLineId合并data的数量到采购单
            for (i = 0; i < data.length; i++) {
                for (var k = 0; k < OrderList.length; k++) {
                    if (OrderList[k].POCode == data[i].POCode && OrderList[k].RowID == data[i].RowID) {
                        OrderList[k].SentQty = parseFloat((parseFloat(OrderList[k].SentQty) * 1 - parseFloat(data[i].BalanceQty) * 1).toFixed(6));
                        if (index == -1)
                            index = k;
                        break;
                    }
                }

            }
            if (index == -1) {
                //alert("物料条码所属物料行在当前送货单明细列表中不存在！");
                $("#msg").html("物料条码所属物料行在当前送货单明细列表中不存在！");
                $("#msg").css("color", "red");
                return false;
            }
            OrderListTemp = OrderList;

            var entity = OrderListTemp.splice(index, 1);
            OrderListTemp.splice(0, 0, entity[0]);

            OrderList = OrderListTemp;


            //移除GRN列表
            $.grep(data, function (e, i) {
                var arr = $.grep(GRNList, function (o, j) {
                    return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                });
                if (arr.length > 0) {
                    deleteByGrn(e.GRN);
                }
            });

            ShowOrderList();

            ShowGRNList();
        }



        //移除Grn项
        function deleteByGrn(grn) {
            var data = {};
            for (var i = 0; i < GRNList.length; i++) {
                if (GRNList[i].GRN == grn) {
                    data = GRNList[i];
                    GRNList.splice(i, 1);
                    break;
                }
            }
            ShowGRNList();
        }







        //选中采购单列表
        function selectBuyOrder() {
           // var SearchCondition = Vender == -1 ? "1=1" : ("SupplierId =" + Vender);
            var SearchCondition = Vender == -1 ? "" : ("SupplierId =" + Vender);
            //if (IsSupplierPeriod == 1) { //需要交期维护
            //    SearchCondition = SearchCondition + " AND IsPeriod = 1 ";
            //}
            //else {
            //    SearchCondition = SearchCondition + " AND IsPeriod = 0 ";
            //}
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=824&PageCondition=" + SearchCondition + "&CallBackFunc=setBuyValue&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function showIsSuppler() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(6);
            if (ajax.error == null) {
                var entity = $.parseJSON(ajax.value).data[0];
                IsSupplierPeriod = entity.ChoosePageId;
            }
        }

        //根据GRN查采购单
        function GetPOCode(grn) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitPoCode(grn);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var data = ajax.value;
            var count = 0;
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    buyOrder = $.trim(data[i].PoCode);
                    txtBuyNO = $.trim(data[i].PoCode);
                    scanPoCode(data[i].PoCode);
                    $("#txtBuyNO").val(data[i].PoCode);
                    $("#hdnBuyNO").val(data[i].PoCode);
                    count = count + 1;
                }
                if (count > 0) {
                    FileShow();
                    return true;
                }
                else {
                    $("#msg").html("条码无效或者查无采购单！");
                    $("#msg").css("color", "red");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                    return false;
                }
            }
            else {
                $("#msg").html("条码无效或者查无采购单！");
                $("#msg").css("color", "red");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
        }

        //点击全选
        function cbClick() {
            var po = $.trim($("#txtBuyNO").val());
            if (!po) {
                alert("请选择采购单！");
                $("#msg").html("请选择采购单！").css("color", "red");
                return false;
            }
            showBuyOrderList(po, "P", "", 1);
        }

        function setBuyValue(list) {

            if ($("#htnVender").val() != "" && $("#htnVender").val() != list[0][2]) {
                //alert("只能选择同一家供应商的采购单");
                if (window.confirm("选择采购单的供应商与当前采购单的供应商不相同,将会刷掉你之前操作的送货单内容，你确定要继续选择它？！")) {
                    Clear();
                }
                else {
                    return;
                }
            }
            var entity = {};
            entity.POCode = list[0][1];
            entity.UserName = userName;
            entity.POType = limitType;

            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetPoCodeInfo", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = JSON.parse(ajax.value).data;
            limitType = entity[0].POType;

            //OrderList = [];
            $("#txtBuyNO").val(list[0][1]);
            $("#hdnBuyNO").val(list[0][1]);
            $("#<%=this.lblVendorCode.ClientID %>").text(list[0][2] + "  " + list[0][3]);
            $("#htnVender").val(list[0][2]);
            //处理未选择
            if (!list[0][1]) return;

            showBuyOrderList(list[0][1], "P", "", 2);
            //获取文件信息
            FileShow();

        }

        function scanPoCode(pocode) {
            var entity = {};
            entity.POCode = pocode;
            entity.UserName = userName;
            entity.POType = limitType;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetPoCodeInfo", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entity = JSON.parse(ajax.value).data;

            if (entity.length == 0) {
                alert("未找到采购单[" + pocode + "]所需送货信息！");
                $("#txtBuyNO").select();
                return false;
            }

            if ($("#htnVender").val() != "" && $("#htnVender").val() != entity[0].VendorCode) {
                //alert("只能选择同一家供应商的采购单");
                if (window.confirm("选择采购单的供应商与当前采购单的供应商不相同,将会刷掉你之前操作的送货单内容，你确定要继续选择它？！")) {
                    Clear();
                    limitType = -2;
                }
                else {
                    return;
                }
            }
            limitType = entity[0].POType;

            //$("#txtBuyNO").val(list[0][1]);
            $("#hdnBuyNO").val(pocode);
            $("#<%=this.lblVendorCode.ClientID %>").text(entity[0].VendorCode + "  " + entity[0].VendorName);
            $("#htnVender").val(entity[0].VendorCode);
            showBuyOrderList(pocode, "P", "", 2);

            //获取文件信息
            FileShow();
            return true;

        }


        //验证数量
        function QtySum(Glist) {
            //GRN采购单：Glist[i].POCode
            //GRN数量：Glist[i].BalanceQty
            //物料：Glist[i].ItemCode
            var Olist = OrderList;
            //采购单:Olist[i].POCode
            //扫描数量：Olist[i].SentQty
            //总数量：Olist[i].BuyQty
            //物料：Olist[i].ItemCode
            var POCode = "";
            var ItemCode = "";
            var GRNQty = 0;

            var OSentQty = 0;
            var OBuyQty = 0;

            if (Glist.length > 0) {
                for (var i = 0; i < Glist.length; i++) {
                    POCode = Glist[i].POCode;
                    ItemCode = Glist[i].ItemCode;
                    GRNQty += parseFloat(Glist[i].BalanceQty);
                }
            }
            if (Olist.length > 0) {
                for (var i = 0; i < Olist.length; i++) {
                    if (Olist[i].ItemCode == ItemCode) {//Olist[i].POCode == POCode && 
                        OSentQty += parseFloat(Olist[i].SentQty);
                        OBuyQty += parseFloat(Olist[i].BuyQty);
                    }
                }
            }
            var allSUMQTY = parseFloat(GRNQty) + parseFloat(OSentQty);
            if (parseFloat(allSUMQTY) > parseFloat(OBuyQty)) {
                //$("#msg").html("采购单【" + POCode + "】物料【" + ItemCode + "】所扫描的条码数量【" + GRNQty + "】加上已经扫描数【" + OSentQty + "】【" + allSUMQTY + "】大于采购单物料所需要的数据【" + OBuyQty + "】");
                $("#msg").html("扫描的【" + $.trim($("#txtGRN").val()) + "】条码总数【" + GRNQty + "】不能大于送货需求总数" + OBuyQty + "！");
                $("#msg").css("color", "red");
                $("#txtGRN").focus().select();
                return false;
            }
            else {
                return true;
            }

        }


        //扫描条码显示记录
        function showBuyGrn(buyOrder, type) {
            $("#msg").html("");
            if (buyOrder == "" || OrderList.length <= 0) {
                alert("请选择采购单后再扫描条码！");
                $("#txtBuyNO").focus();
                return false;
            }
            var bExists = false;
            var tab = $("#tblRec tr");
            //修改该验证方式
            for (var i = 0; i < GRNList.length; i++) {
                if (buyOrder == GRNList[i].GRN) {
                    alert("条码在列表中存在,不需要重复扫描！");
                    $("#txtGRN").val("");
                    return false;
                }
            }
            var pocodes = "";
            for (var i = 0; i < OrderList.length; i++) {
                if (pocodes.indexOf(OrderList[i].POCode + ",") < 0) {
                    pocodes = pocodes + OrderList[i].POCode + ",";
                }
            }
            var cbShowAll = document.getElementById("cbShowALL").checked;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.GetDeliverInfo(buyOrder, type, $("#htnVender").val(), pocodes, cbShowAll);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                alert(ajax.error.Message);
                return false;
            }
            var data = $.parseJSON(ajax.value).data;

            for (var i = 0; i < GRNList.length; i++) {
                if (data[0].GRN == GRNList[i].GRN) {
                    alert("条码在列表中存在,不需要重复扫描！");
                    $("#txtGRN").val("");
                    return false;
                }
            }



            var OrderListTemp = [];
            var index = -1;

            OrderListTemp.push({});
            //按PO和PoLineId合并data的数量到采购单
            for (i = 0; i < data.length; i++) {
                for (var k = 0; k < OrderList.length; k++) {
                    if (OrderList[k].POCode == data[i].POCode && OrderList[k].RowID == data[i].RowID) {
                        if (index == -1)
                            index = k;
                        break;
                    }
                }

            }
            if (index == -1) {
                alert("物料条码所属物料行在当前送货单明细列表中不存在！");
                return false;
            }



            //判断数量
            NewGRNList = [];
            //添加GRN新列表
            $.grep(data, function (e, i) {
                var arr = $.grep(GRNList, function (o, j) {
                    return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                });
                if (arr.length == 0) {
                    NewGRNList.push(e);
                }
            });
            if (!QtySum(NewGRNList)) {
                NewGRNList = [];
                return;
            }
            NewGRNList = [];
            //判断数量



            var pocodestring = "";
            var grntype = 1;
            //按PO和PoLineId合并data的数量到采购单
            for (i = 0; i < data.length; i++) {
                for (var k = 0; k < OrderList.length; k++) {
                    if (OrderList[k].POCode == data[i].POCode && OrderList[k].RowID == data[i].RowID) {
                        pocodestring = data[i].POCode;
                        OrderList[k].SentQty = parseFloat((parseFloat(OrderList[k].SentQty) * 1 + parseFloat(data[i].BalanceQty) * 1).toFixed(6));
                    }
                }

            }




            OrderListTemp = OrderList;

            var entity = OrderListTemp.splice(index, 1);
            OrderListTemp.splice(0, 0, entity[0]);

            OrderList = OrderListTemp;

            if (data.length > 1) {
                grntype = 2;
            }
            //添加GRN列表
            $.grep(data, function (e, i) {
                var arr = $.grep(GRNList, function (o, j) {
                    return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                });
                if (arr.length == 0) {
                    GRNList.push(e);
                }
            });

            ShowOrderList();

            ShowGRNList();
            if (type == "G") {
                if (grntype == 2) {
                    $("#msg").html("采购单号【" + pocodestring + "】包装箱条码【" + buyOrder + "】扫描成功！");
                    $("#msg").css("color", "green");
                }
                else {
                    $("#msg").html("采购单号【" + pocodestring + "】物料条码【" + buyOrder + "】扫描成功！");
                    $("#msg").css("color", "green");
                }
            }

        }

        //显示采购单数量
        function showBuyOrderList(buyOrder, type, code, number) {
            $("#msg").html("");
            var cbShowAll = document.getElementById("cbShowALL").checked;
            var pocodes = "";
            for (var i = 0; i < OrderList.length; i++) {
                if (pocodes.indexOf(OrderList[i].POCode + ",") < 0) {
                    pocodes = pocodes + OrderList[i].POCode + ",";
                }
            }
            if (pocodes.indexOf(buyOrder) < 0) {
                pocodes = pocodes + buyOrder;
            }
            txtBuyNO = buyOrder;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.GetDeliverInfo(buyOrder, type, $("#htnVender").val(), pocodes, cbShowAll);
            if (ajax.error != null) {
                //处理自动添加送货物料明细
                if (cbShowAll) {
                    $("#cbShowALL").prop("checked", false);
                }
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                alert(ajax.error.Message);
                return false;
            }
            var data = $.parseJSON(ajax.value).data;
            var data1 = $.parseJSON(ajax.value).data1;

            var Copylist = [];
            $.extend(Copylist, OrderList);
            OrderList = [];

            var haveList = [];

            //添加送货项列表
            $.grep(data, function (e, i) {
                e.SpareQty = 0;//备品数量
                e.PackingDetail = "";
                OrderList.push(e);
                haveList.push(e);
            });
            //添加送货项列表
            $.grep(Copylist, function (e, i) {
                var arr = $.grep(OrderList, function (o, j) {
                    //return e.POCode == o.POCode && e.ItemCode == o.ItemCode;   BirongLiang 增加如下ROWID
                    return e.POCode === o.POCode && e.ItemCode === o.ItemCode && e.RowID === o.RowID;
                });

                if (arr.length == 0) {
                    OrderList.push(e);
                }
            });


            //重新计算
            if (document.getElementById("cbShowALL").checked == false && number == 2) {
                for (var i = 0; i < GRNList.length; i++) {
                    for (var k = 0; k < OrderList.length; k++) {
                        if (OrderList[k].POCode == GRNList[i].POCode && OrderList[k].RowID == GRNList[i].RowID) {
                            OrderList[k].SentQty = parseFloat((parseFloat(OrderList[k].SentQty) * 1 + parseFloat(GRNList[i].BalanceQty) * 1).toFixed(6));
                        }
                    }
                }
            }
            if (document.getElementById("cbShowALL").checked == false && number == 1) {
                GRNList = [];
            }

            ShowOrderList();

            //GRNList = [];
            if (document.getElementById("cbShowALL").checked) {

                //判断数量
                NewGRNList = [];
                //添加GRN新列表
                $.grep(data, function (e, i) {
                    var arr = $.grep(GRNList, function (o, j) {
                        return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                    });
                    if (arr.length == 0) {
                        NewGRNList.push(e);
                    }
                });
                if (!QtySum(NewGRNList)) {
                    NewGRNList = [];
                    return;
                }
                NewGRNList = [];
                //判断数量




                //添加GRN列表
                $.grep(data1, function (e, i) {
                    var arr = $.grep(GRNList, function (o, j) {
                        return e.MaterialUnitId == o.MaterialUnitId && e.GRN == o.GRN;
                    });
                    if (arr.length == 0) {
                        GRNList.push(e);
                    }
                });


            }

            ShowGRNList();
            if (type == "P") {
                if (haveList.length <= 0) {
                    $("#msg").html("采购单号【" + buyOrder + "】已全部送完货！");
                    $("#msg").css("color", "red");
                }
                else {
                    $("#msg").html("采购单号【" + buyOrder + "】扫描成功！");
                    $("#msg").css("color", "green");
                }
            }
        }

        //删除送货项
        function del(i) {
            var grns = "";
            //获取改物料GRN列表
            var arr = $.grep(GRNList, function (e, j) {
                grns = grns + e.GRN + ",";
                return e.POCode == OrderList[i].POCode && e.ItemCode == OrderList[i].ItemCode && e.RowID == OrderList[i].RowID;
            }, true);

            //增加验证采购订单行下物料的包装箱
            var pocode = OrderList[i].POCode;
            var rowid = OrderList[i].RowID;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.checkPOLineCanDel(pocode, rowid, grns);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                alert(ajax.error.Message);
                return false;
            }

            GRNList = arr;

            OrderList.splice(i, 1);
            ShowOrderList();
            if (OrderList.length == 0) {
                Clear();
            }
            ShowGRNList();
        }

        //删除Grn项
        function deleteGrn(obj) {
            var grn = $(obj).parent().parent().find("td:eq(1)").html();  //找到GRN,处理兼容问题
            var ygrn = grn;
            //根据物料条码查是否是包装箱，如果是返回包装箱条码，如果不是返回物料条码
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetSelectSerialNumberBySerialNumber(grn);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                alert(ajax.error.Message);
                return false;
            }
            grn = ajax.value.SerialNumber;
            if (ajax.value.PID != "-1") {
                if (confirm("此条码【" + ygrn + "】为包装箱里的物料条码，删除会把同一包装箱【" + grn + "】所有的物料条码都删除，确定删除？")) {
                    //移除
                    DeleteBuyGrn(grn, "G", $.trim($("#htnVender").val()));
                }
            }
            else {
                if (confirm("此条码【" + ygrn + "】为物料条码，确定删除？")) {
                    //移除
                    DeleteBuyGrn(grn, "G", $.trim($("#htnVender").val()));
                }
            }



            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.checkGrnCanRemove(grn);
            //if (ajax.error != null) {
            //    $("#msg").html(ajax.error.Message);
            //    $("#msg").css("color", "red");
            //    alert(ajax.error.Message);
            //    return false;
            //}

            //var data = {};
            //for (var i = 0; i < GRNList.length; i++) {
            //    if (GRNList[i].GRN == grn) {
            //        data = GRNList[i];
            //        GRNList.splice(i, 1);
            //        break;
            //    }
            //}

            ////按PO和PoLineId合并data的数量到采购单
            //for (var k = 0; k < OrderList.length; k++) {
            //    if (OrderList[k].POCode == data.POCode && OrderList[k].RowID == data.RowID) {
            //        OrderList[k].SentQty = parseInt(OrderList[k].SentQty) * 1 - parseInt(data.BalanceQty) * 1;
            //        break;
            //    }
            //}

            //ShowOrderList();

            //ShowGRNList();
        }

        //显示送货单细项
        function ShowOrderList() {
            if (OrderList != null && OrderList.length > 0) {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel;
                for (var i = 0; i < OrderList.length; i++) {
                    //强制转型 BirongLiang 2017-3-27
                    //OrderList[i].SentQty = Math.floor(OrderList[i].SentQty);
                    //OrderList[i].AScanQty = Math.floor(OrderList[i].AScanQty);
                    // 
                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = i + 1;
                    cel.innerHTML += "<input type='hidden' id='RowID" + i + "' value='" + OrderList[i].RowID + "' name='RowId' POCode=" + OrderList[i].POCode + "/>";

                    cel = row.insertCell(1);
                    cel.innerHTML = OrderList[i].POCode;
                    cel.id = 'tdPoCode' + i;

                    cel = row.insertCell(2);
                    cel.innerHTML = OrderList[i].RowID;
                    cel.id = 'tdRowID' + i;

                    cel = row.insertCell(3);
                    cel.innerHTML = OrderList[i].ItemCode;
                    cel.id = 'tdInvCode' + i;

                    cel = row.insertCell(4);
                    cel.innerHTML = OrderList[i].ItemName;
                    cel.id = 'tdInvName' + i;

                    cel = row.insertCell(5);
                    cel.innerHTML = parseFloat(OrderList[i].BuyQty).toString();

                    cel = row.insertCell(6);
                    if (OrderList[i].HaveGRN == 0) {
                        cel.innerHTML = "<input type='text' style='width: 80%' id='SentQty" + i + "' value='"
                            + OrderList[i].SentQty + "' class='NumericBox50' IsNumber='1'  IsRequired='1' " +
                            " onchange='ChangeQty(" + i + " , " + JSON.stringify(OrderList[i]) + ")'/>";
                    }
                    else {
                        cel.innerHTML = parseFloat(OrderList[i].SentQty).toString();;
                    }

                    cel = row.insertCell(7);
                    cel.innerHTML = "<input type='text' style='width: 80%' id='SpareQty" + i + "' value='0'" +
                        "class='NumericBox50' IsNumber='1'  IsRequired='1' " +
                        " onchange='ChangeSpareQty(" + i + " , " + JSON.stringify(OrderList[i]) + ")'/>";

                    cel = row.insertCell(8);
                    cel.innerHTML = "<input type='text' style='width: 80%' id='PackingDetail" + i + "' value=''" +
                        "class='TextBox'  " +
                        " onchange='ChangePackingDetail(" + i + " , " + JSON.stringify(OrderList[i]) + ")'/>";

                    cel = row.insertCell(9);
                    cel.innerHTML += "<a href='#' onclick='del(" + i + ")'>删除 </a>";

                }
            }
            else {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#tbBuyOrderDetail tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="9" align="center"><font color="red">暂无数据！</font></td></tr>');
            }
        }

        //送货数量修改
        function ChangeQty(i, e) {
            var qty = $.trim($("#SentQty" + i).val()) * 1; //BirongLiang @2017-3-27转成数字型
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(qty)) {
                alert("请输入正整数！");
                $("#SentQty" + i).val('');
                return false;
            }
            if (qty <= 0) {
                alert("送货数量要大于0！");
                return false;
            }
            if (qty > OrderList[i].BuyQty * 1) {
                alert("送货数量超过采购量！");
                $("#SentQty" + i).val('');
                return;
            }
            OrderList[i].SentQty = qty;
        }

        //改变备品数量
        function ChangeSpareQty(i, e) {
            var spareQty = $.trim($("#SpareQty" + i).val()) * 1;
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(spareQty)) {
                alert("请输入正整数！");
                $("#SpareQty" + i).val('');
                return false;
            }
            if (spareQty < 0) {
                alert("送货数量要大于0！");
                return false;
            }
            OrderList[i].SpareQty = spareQty;
        }

        //改变装箱明细
        function ChangePackingDetail(i, e) {
            var packingDetail = $("#PackingDetail" + i).val();
            OrderList[i].PackingDetail = packingDetail;
        }

        //显示GRN细项
        function ShowGRNList() {
            showRecDtl(1);
        }

        function showRecDtl(doclean) {
            var dataSet = []; //数据源
            if (doclean) { //清空，绑定表格
                $('#tblRec').DataTable().destroy();
                $('#tblRec').empty();
            }
            if (GRNList != null && GRNList.length > 0) {
                $("#htnVender").val(GRNList[0].VendorCode);
                for (var i = 0; i < GRNList.length; i++) {
                    var row = [];
                    row.push(GRNList[i].POCode);
                    row.push(GRNList[i].GRN);
                    row.push(GRNList[i].ItemCode);
                    row.push(GRNList[i].ItemName);
                    row.push(GRNList[i].LotCode);
                    row.push(parseFloat(GRNList[i].BalanceQty).toString());
                    dataSet.push(row);
                }
            } else {

            }
            $('#tblRec').DataTable({
                data: dataSet,
                paging: true,
                searching: true,
                scrollCollapse: true,
                deferRender: true,
                language: getJQTableLanguage(),   //多语言设定（默认英语）
                columns: [
                    { title: mesLang("采购单号") },
                    { title: mesLang("物料条码") },
                    { title: mesLang("物料编码") },
                    { title: mesLang("物料名称") },
                    { title: mesLang("批次号") },
                    { title: mesLang("数量") },
                    {
                        title: mesLang("操作"), "render": function (data, type, full, meta)
                        {
                            return '<a href="#" class="imgText" onclick="deleteGrn(this)" >' + mesLang("删除") + '</a>';
                        }
                    }
                ]
            });
        }

        //生成送货单
        function Save() {
            if (OrderList.length == 0) {
                alert("请添加送货单明细!");
                return false;
            }
            if (GRNList.length == 0) {
                alert("请添加送货物料明细!");
                return false;
            }
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (re.test(OrderList[0].BuyQty)) {
                OrderList[0].BuyQty = OrderList[0].BuyQty.toFixed(6);
            }
            if (re.test(OrderList[0].SentQty)) {
                OrderList[0].SentQty = OrderList[0].SentQty.toFixed(6);
            }

            if (re.test(OrderList[0].SpareQty)) {
                OrderList[0].SpareQty = OrderList[0].SpareQty.toFixed(6);
            }
            if (re.test(GRNList[0].BalanceQty)) {
                GRNList[0].BalanceQty = GRNList[0].BalanceQty.toFixed(6);
            }

            //addby zj 2019年9月5日 修改生成送货单报错报格式错误
            for (var i = 0; i < OrderList.length; i++) {

                if (OrderList[i].SentQty === '0.000' || OrderList[i].SentQty === '0.000000') {
                    OrderList[i].SentQty = '0';
                }
            }
            var entity = {};
            entity.DeliverId = -1;
            entity.VenderNo = $("#htnVender").val();
            entity.Remark = $.trim($("#txtRemark").val());
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            entity.tbDtl = JSON.stringify(OrderList);
            entity.tbGRNDtl = JSON.stringify(GRNList);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.SaveDeliver(JSON.stringify(entity));
            if (ajax.error != null) {
                //$("#Div1").html(ajax.error.Message);
                //$("#Div1").css("color","red");
                alert(ajax.error.Message);
                return false;
            }
            alert("生成送货单成功");
            Clear();
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialDeliFormPrint.aspx?name=Material_DeliveryFormPrint&ID=" + ajax.value);
        }

        function Clear() {
            OrderList = [];
            GRNList = [];
            ShowOrderList();
            ShowGRNList();
            $("#htnVender").val("");
            $("#txtGRN").val("");
            $("#<%=this.lblVendorCode.ClientID %>").text("");
            $("#txtBuyNO").val("");
            $("#hdnBuyNO").val("");
            $("#tblShippingReport tbody").html("");
            $("#msg").html("");

        }

        function isPositiveNum(obj) {//是否为正整数
            var s = $(obj).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(s)) {
                alert("请输入正整数！");
                $(obj).val(0);
                $(obj).focus();
            }
        }

        var getJQTableLanguage = function () {
            return {
                "lengthMenu": "每页 _MENU_ 条记录",
                "zeroRecords": "暂无数据",
                "info": "显示第 _PAGE_ 页,共 _PAGES_ 页",
                "infoEmpty": "",
                "search": "综合搜索:",
                "infoFiltered": "(从 _MAX_ 条记录中查询)",
                "paginate": {
                    "first": "首页",
                    "last": "尾页",
                    "next": "后一页",
                    "previous": "前一页"
                }
            };
        }

        function UpLoad() {
            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var fileSizeLimit = 10
            //出货报告上传  start 
            $("#fileUpload").uploadfile({
                uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
                fileSizeLimit: fileSizeLimit,
                buttonText: mesLang("点击上传文件"),
                formData: function () {
                    return {
                        'Action': $("#<%=this.ddlType.ClientID %>").val(), "txtBuyNO": txtBuyNO, "userName": username
                    };
                },
                //选择文件时执行             
                onUploadStart: function (file) {

                    var size = parseInt( file.size / 1024 / 1024);
                    if (size > fileSizeLimit) {
                        alert("当前上传的文件大小【" + size + "M】大于文件限制大小【" + fileSizeLimit + "M】！");
                        return false;
                    }
                    if ($.trim($("#txtBuyNO").val()) != "") {
                        txtBuyNO = $.trim($("#txtBuyNO").val());
                    }
                    if (txtBuyNO == "") {
                        alert("未选择需要上传报告的采购单！");
                        return false;
                    }

                    var extFileType = $("#tblShippingReport>tbody tr:first").find("td:eq(2)").find("input[name=hidFileType]").val();
                    var newFileType = file.name.substring(file.name.lastIndexOf(".") + 1);

                    if (extFileType != undefined && newFileType != extFileType.toLowerCase()) {
                        extFileType = extFileType.toLowerCase();

                        if (limitType.indexOf(extFileType) > -1) {
                            alert("上传文件类型错误，当前已上传类型为 " + extFileType + " !");
                            return false;
                        }

                        if ((extFileType == "mp4" || extFileType == "webm") && (newFileType == "mp4" || newFileType == "webm")) {
                            return;
                        }

                        if ((extFileType == "pdf" && (newFileType == "xls" || newFileType == "xlsx"))) {
                            return;
                        }
                        alert("上传文件类型不一致，当前已上传类型为 " + extFileType + " !");
                        return false;
                    }
                    return true;
                },
                //上传成功时执行
                onUploadSuccess: function (file, data) {
                    FileShow();
                }
            });
        }

        function FileShow() {
            $("#tblShippingReport tbody").html("");
            var poCode = $.trim($("#txtBuyNO").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPurOrder.GetReportFileInfo(poCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value;
            for (var i = 0; i < data.length; i++) {
                var rowType = data[i].RowType == "ShippingReport" ? "出货报告" : "实验报告";
                var clickInfo = "FileSave(this)";
                if (data[i].RowType != "ShippingReport") {
                    clickInfo = "FileTestSave(this)";
                }
                var $tr = $("<tr class='ListTableOddRow'>"
                    + "<td>" + (i + 1) + "</td>"
                    + "<td>" + rowType + "</td>"
                    + "<td>" + data[i].FileName + "</td>"
                    + "<td>" + data[i].FileType + "</td>"
                    + "<td>" + data[i].CreateBy + "</td>"
                    + "<td>" + data[i].CreateDateTime + "</td>"
                    + "<td><a href='#' onclick=" + clickInfo + ">下载</a></td>"
                    + "<td><a href='#' onclick=deleteFileFtp('" + data[i].FileID + "')>删除</a></td>"
                    + "</tr>");
                $("#tblShippingReport tbody").append($tr);
                $tr.data("FileSaveName", data[i].FileSaveName);
            }
        }

        function FileTestSave(el) {
            var fileName = $(el).parent().parent().data("FileSaveName");
            var path = GetFilePath("TestReport", fileName);

            window.open(path);
        }

        function FileSave(el) {
            var fileName = $(el).parent().parent().data("FileSaveName");
            var path = GetFilePath("ShippingReport", fileName);

            window.open(path);
        }
        //end 


        function deleteFileFtp(FileID) {
            if (confirm("此操作不可逆，确定删除？")) {
                var entity = {};
                entity.IdString = FileID; //文件ID
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspUpLoadFileDeleteByID", JSON.stringify(entity));
                if (ajax.error == null) {
                    alert("删除成功！");
                    FileShow();
                    //FileShow2()

                    $("#divfileUpload").html("");
                    var html = '<input type="file" name="fileUpload" id="fileUpload" style="width: 73px;" />';
                    $("#divfileUpload").html(html);
                    UpLoad();

                } else {
                    alert(ajax.error.Message);
                }
            }
        }


    </script>
</asp:Content>
