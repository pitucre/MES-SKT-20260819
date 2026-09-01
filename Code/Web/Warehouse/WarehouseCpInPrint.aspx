<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="WarehouseCpInPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCpInPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%=Resources.lang.ProductionWorkOrder%><em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtPoNumber" class="TextBox" disabled="disabled" isrequired='1' /><input
                    type="button" id="btnSelectPo" class="ButtonBox" value="..." onclick="selectPoNumber()" />
                <input type="hidden" value="-1" id="hdnOrderId" />
                <input type="hidden" value="-1" id="hdnItemId" />
            </td>
            <td class="Label2">
                <%=Resources.lang.ProduceDate %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtProdDate" ReadOnly="true" class="DateTimeBox1" runat="server" ClientIDMode="Static" IsRequired="1" />

            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.MaterialCode %>
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="hdnMaterialCode" />
                <asp:Label runat="server" ID="lblMaterialCode"></asp:Label>
            </td>
            <td class="Label2"><%=Resources.lang.MaterialName %>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblMaterialName"></asp:Label>
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
            <td class="Label2">打印数量<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtGRNQty" isrequired='1' class="NumericBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" />
                <input type="hidden" value="" id="hdfGRNQty" />
            </td>
            <td class="Label2">最小包装数量<em>*</em>
            </td>
            <td class="Field2">
                <%--最小包装数量--%>
                <input type="text" id="txtQty" isrequired='1' class="NumericBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" />
                <input type="hidden" value="" id="hdfQty" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.LotSize %>
            </td>
            <td class="Field2">
                <input class="TextBox" id="lblLotCode" />
            </td>
            <td class="Label2">班组<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtClass" isrequired='1' class="TextBox" disabled="disabled" /><input
                    type="button" id="btnClass" class="ButtonBox" value="..." onclick="selectClass()" />
                <input type="hidden" value="-1" id="hdnClass" />
            </td>
        </tr>
        <tr>
            <td class="Label2">设备号<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtEquipment" isrequired='1' class="TextBox" disabled="disabled" /><input
                    type="button" id="btnEquipment" class="ButtonBox" value="..." onclick="selectEquipment()" />
            </td>
            <td class="Label2">模具<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtEquipmentMoudle" isrequired='1' class="TextBox" disabled="disabled" /><input
                    type="button" id="btnEquipmentMoudle" class="ButtonBox" value="..." onclick="selectEquipmentMoudle()" />
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
    <table id="tblExpand" cellspacing="0" cellpadding="5" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">

            <th scope="col" style="width: 3%;">序号
            </th>
            <%-- choosepage选择框 --%>
            <th scope="col" style="width: 15%;">工序
            </th>
            <%-- choosepage选择框 --%>
            <th scope="col" style="width: 15%;">资源
            </th>
            <%-- 日期时间选择框 --%>
            <th scope="col" style="width: 20%;">过站时间
            </th>
            <%-- 数字框 --%>
            <th scope="col" style="width: 10%;">数量
            </th>
            <%-- choosepage选择框 --%>
            <th scope="col" style="width: 15%;">员工
            </th>
            <%-- <th scope="col" onclick="AddPurOrderDtl();" id='btnAdd' style="color: #0066CC; cursor: pointer; width: 100px;">+新增
            </th>--%>
            <th scope="col" id='btnAdd' style="color: #0066CC; cursor: pointer; width: 100px;"></th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="10" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
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
        var itemAllQty = 0;
        var alreadyQty = 0; //已经打印数量
        var bigCartonQty = 0; //外包装最小包装数量
        var username = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
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
            $("#activeinfoarea").css("height", $(window).height() - 423 + "px");
        });

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
            $('#txtQty').on("change", function () {
                $("#tblExpand tr:not(.ListTableHeader)").each(function () {
                    $(this).find('input').eq(3).val($('#txtQty').val());
                });
            });

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
        //选择生产订单号
        function selectPoNumber() {
            var SearchCondition = "  Status in(0,1) and Planned_Start_Time  BETWEEN FORMAT(DATEADD(DAY, -1, GETDATE()), 'yyyy-MM-dd')   and FORMAT(DATEADD(DAY, 1, GETDATE()), 'yyyy-MM-dd')";//" Status = 3 ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=607&Multiple=false&PageCondition="
                    + escape(SearchCondition) + "&CallBackFunc=setPONumber&rnd=" + Math.random(), width: 812, height: 450
            });
        }

        function setPONumber(list) {
            //清空数据
            Empty(1);
            $("#txtPoNumber").val(list[0][1]);
            //选择工单带出物料
            $("#hdnOrderId").val(list[0][0]);
            $("#<%=this.lblMaterialCode.ClientID %>").text(list[0][2]);
            $("#<%=this.lblMaterialName.ClientID %>").text(list[0][5]);
            $("#<%=this.lblPOQty.ClientID %>").text(list[0][3]);

            //$("#txtClass").val("")

            //$("#txtEquipment").val("");


            //241030
            //工单带出日期、班组、设备号
           <%-- var strDate = list[0][1].substring(1, 7);
            $("#<%=this.txtProdDate.ClientID %>").val("20" + strDate.substr(0, 2) + "-" + strDate.substr(2, 2) + "-" +  strDate.substr(4, 2)); 

            //txtClass
            if (text(list[0][1]).length >= 7) {
                if (text(list[0][1]).substr(7, 8) == "A")
                    $("#txtClass").val("A班");
                else if (text(list[0][1]).substr(7, 8) == "B")
                    $("#txtClass").val("B班");
                
            }
            //txtEquipment
            if (text(list[0][1]).length >= 10) {
                
                $("#txtEquipment").val("1" + text(list[0][1]).substr(8, 2));                 

             }
            --%>

            $("#hdnItemId").val(list[0][6]);
            GetQty($("#txtPoNumber").val());
            setStationList(list[0][0]);
        }
        //吴锋文 2025-08-19 获取工单关联工序
        function setStationList(orderid) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.GetProdOrderStationCollection(orderid);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            LoadExpandTableDataEx(ajax.value);
        }
        function LoadExpandTableDataEx(data) {

            $("#tblExpand tr:gt(0)").remove(); // 清空表格数据
            for (var i = 0; i < data.length; i++) {
                AddExpandRowEx(data[i], i + 1,data.length);
            }
        }
        function selectClass() {
            var SearchCondition = "1=1 ";

            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=837&Multiple=false&PageCondition="
                    + escape(SearchCondition) + "&CallBackFunc=setClass&rnd=" + Math.random(), width: 712, height: 400
            });
        }

        function setClass(list) {
            $("#hdnClass").val(list[0][0])
            $("#txtClass").val(list[0][1])
        }

        function selectEquipment() {
            var SearchCondition = " EquipmentName LIKE '%注塑机%' ";

            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&PageCondition="
                    + escape(SearchCondition) + "&CallBackFunc=setEquipment&rnd=" + Math.random(), width: 712, height: 400
            });
        }

        function setEquipment(list) {
            $("#txtEquipment").val(list[0][1]);
        }

        function selectEquipmentMoudle() {
            var SearchCondition = " EquipmentTypeId=-4 ";

            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&PageCondition="
                    + escape(SearchCondition) + "&CallBackFunc=setEquipmentMoudle&rnd=" + Math.random(), width: 712, height: 400
            });
        }

        function setEquipmentMoudle(list) {
            $("#txtEquipmentMoudle").val(list[0][1]);
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

        //清空所有的数据
        function Empty(flag) {
            if (flag == 1) {
                $("#txtPoNumber").val("");
                $("#hdnVendorCode").val("");
                $("#<%=this.lblMaterialCode.ClientID %>").text("");
                $("#<%=this.lblMaterialName.ClientID %>").text("");
            }
            $("#txtItemName").val("");
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

            $("#hdnClass").val("-1")
            $("#txtClass").val("")

            $("#txtEquipment").val("");

            $("#txtEquipmentMoudle").val("");

            if (flag == 4) {
                //获取批次号
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetLotCode();
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $("#lblLotCode").val(ajax.value);

            }
        }

        //获取订单数量跟已打数量
        function GetQty(POCode) {
            //获取订单数量
            //获取已打条码数量
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.GetPrintQty(POCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alreadyQty = ajax.value;
            $("#<%=this.lblPrintQty.ClientID %>").text(alreadyQty);
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
            //if (parseInt(PoQty) == parseInt(PrintQty)) {
            //    alert("该采购订单下该物料的数量已经打完！")
            //    return false;
            //}
            if (parseFloat(txtGRNQty) < parseFloat(txtQty)) {
                alert("最小包装数不能大于本次送货总数！");
                $("#txtQty").val(0);
                return false;
            }
        }


        function Save() {
            var POorder = $("#txtPoNumber").val(); //工单号
            labelItemId = $("#hdnItemId").val();

            var txtQty = $("#txtQty").val().replace(/,/g, ""); //最小包装数量
            var txtGRNQty = $("#txtGRNQty").val().replace(/,/g, ""); //打印条码数量

            var alreadyQty = $("#<%=this.lblPrintQty.ClientID %>").text();//已打印数量

            var txtLotCode = $("#lblLotCode").val();

            var errStr = "";
            var txtDateCode = $("#txtProdDate").val();
            var remark = $("#txtRemark").val();

            var OrderId = $("#hdnOrderId").val();
            var ClassId = $("#hdnClass").val();
            var EquipmentCode = $("#txtEquipment").val();
            var EquipmentMoudle = $("#txtEquipmentMoudle").val();

            if (POorder == "") {
                alert("工单号不能为空！");
                return;
            }

            if (txtLotCode == "") {
                alert("批次号不能为空！");
                return;
            }
            if (parseFloat(txtGRNQty) < parseFloat(txtQty)) {
                alert("最小包装数不能大于总数！");
                $("#txtQty").val(0);
                return false;
            }

            if (parseFloat(txtGRNQty) + parseFloat(alreadyQty) > parseFloat($("#<%=this.lblPOQty.ClientID %>").text())) {
                alert("已打印数量不可超过工单数量！");
                $("#txtGRNQty").val(0);
                return false;
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

            if (!window.confirm("确认打印？")) {
                return false;
            }

            showAreaMessge("生产工单" + $("#txtPoNumber").val() + ",物料编码:" + $("#<%=this.lblMaterialName.ClientID %>").text() + "开始生成SN，请稍候...", "messageGreen");
            var stationdtl = [];
            $("#tblExpand tr:not(.ListTableHeader)").each(function () {
                var itm = {};
                itm.process = $(this).find('input').eq(0).attr('id');
                itm.resource = $(this).find('input').eq(1).attr('id');
                itm.passTime = $(this).find('input').eq(2).val();
                itm.qty = $(this).find('input').eq(3).val();
                itm.employee = $(this).find('input').eq(4).val();
                itm.lineid = $(this).find('td').eq(0).attr('id');
                stationdtl.push(itm);
            });
            setTimeout(function () {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.ReleaseBatchSOCPIn(parseInt(txtGRNQty), parseFloat(txtQty), parseInt(OrderId), parseInt(labelItemId), txtLotCode,
                    parseInt(ClassId), EquipmentCode, EquipmentMoudle, txtDateCode, remark, JSON.stringify(stationdtl));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    showAreaMessge(ajax.error.Message, "messageRed");
                    return false;
                }
                var arr = ajax.value;
                if (arr != null) {
                    setTimeout(function () {
                        try {
                            printGRN(arr.SNList);

                        }
                        catch (e) {
                            alert(e);
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
            SNInfo = {};
            SNInfo.SNList = arr;


            //根据打印方式决定 调用ZPL还是Lab打印
            usePrinGRNMethod();

            //打印完成刷新页面
            setTimeout(function () {
                //document.forms[0].submit();
                showAreaMessge("生产工单" + $("#txtPoNumber").val() + ",物料编码:" + $("#<%=this.lblMaterialName.ClientID %>").text() + "打印完成", "messageGreen"); //messageRed,messageGreen
                Empty(4);
            }, 1000);
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelStationId = -1;    //工位Id
        var labelType = -36;          //标签类型 产品条码
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
                return true;
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }

        //根据打印方式决定 调用ZPL还是Lab打印
        function usePrinGRNMethod() {
            if (getGRNDocumentInfo()) {
                mesLabLabelPrint();
            }

        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint() {
            //从已释放的标签信息集合中，获取SN序列号集合。
            var ShowInfo = "";
            lableArr = SNInfo.SNList;
            ShowInfo = "条码生成,打印成功";

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


        // 1. 初始化表格（清空并显示“暂无数据”）
        function InitExpandTable() {
            $("#tblExpand tr:gt(0)").remove(); // 保留表头
            $("#tblExpand").append(
                '<tr id="trNewInfo" class="ListTableOddRow">' +
                '<td colspan="10" style="text-align: center;">暂无数据</td></tr>'
            );
        }

        // 2. 加载虚拟JSON数据
        function LoadExpandTableData() {
            var data = [
                { process: "注塑", resource: "注塑机A", passTime: "2025-08-11 08:00", qty: 100, employee: "张三" },
                { process: "装配", resource: "装配线1", passTime: "2025-08-11 09:00", qty: 80, employee: "李四" }
            ];
            $("#tblExpand tr:gt(0)").remove(); // 清空表格数据
            for (var i = 0; i < data.length; i++) {
                AddExpandRow(data[i], i + 1, data.length);
            }
        }

        // 3. 增加行
        function AddExpandRow(rowData, index) {

            $("#trNewInfo").remove(); // 移除“暂无数据”行
            var tab = document.getElementById("tblExpand");
            var rowNewIdx = tab.rows.length;
            var row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            // 序号
            var cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = index || rowNewIdx;
            // 工序
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="text" class="TextBox" value="' + (rowData?.process || '') + '" />';
            // 资源
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="text" class="TextBox" value="' + (rowData?.resource || '') + '" />';
            // 过站时间
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="text" class="TextBox" value="' + (rowData?.passTime || '') + '" />';
            // 数量
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="number" class="TextBox" value="' + (rowData?.qty || '') + '" />';
            // 员工
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="text" class="TextBox" value="' + (rowData?.employee || '') + '" />';
            // 操作（删除）
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<span style="cursor:pointer;color:#0000ff;" onclick="DeleteExpandRow(this)">删除</span>';
        }
        function AddExpandRowEx(rowData, index, len) {
            var myDate = new Date();

            // 获取当前时间
            var myDate = new Date();
            // 第一条数据用当前时间
            var dateNow = myDate;
            if (index!=len) {
                // 随机减少分钟数，范围120~180
                var minStep = 120;
                var maxStep = 180;
                var step = Math.floor(Math.random() * (maxStep - minStep + 1)) + minStep;
                var totalStep = step * (len-index);
                dateNow = new Date(myDate.getTime() - totalStep * 60 * 1000);
            }
            // 格式化日期时间（yyyy-MM-dd HH:mm:ss）
            function pad(n) { return n < 10 ? '0' + n : n; }
            var dateStr = dateNow.getFullYear() + "-" +
                pad(dateNow.getMonth() + 1) + "-" +
                pad(dateNow.getDate()) + " " +
                pad(dateNow.getHours()) + ":" +
                pad(dateNow.getMinutes()) + ":" +
                pad(dateNow.getSeconds());

            $("#trNewInfo").remove(); // 移除“暂无数据”行
            var tab = document.getElementById("tblExpand");
            var rowNewIdx = tab.rows.length;
            var row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            // 序号
            var cell = row.insertCell(0);
            cell.id = (rowData?.LineId || '');
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = index || rowNewIdx;
            // 工序
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="text" class="TextBox" value="' + (rowData?.Station || '') + '" id="' + (rowData?.StationId || '') + '" />';
            // 资源
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="text" class="TextBox" value="' + (rowData?.ResName || '') + '" id="' + (rowData?.ResId || '') + '" />';
            // 过站时间
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="text" class="DateTimeBox" value="' + dateStr + '" style="width:70%" IsRequired="1"/>';
            // 数量
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="number" class="TextBox" value="' + $("#txtQty").val + '" />';
            // 员工
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input type="text" class="TextBox" value="' + username + '" />';
            // 操作（删除）
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<span style="cursor:pointer;color:#0000ff;" onclick="DeleteExpandRow(this)">删除</span>';
            $(".DateTimeBox").datepicker({
                showOn: "button",
                buttonImageOnly: true,
                showHms: true,
                buttonText: "<%=Resources.Common.ChooseDate %>",
                onSelect: function () {
                    if (true) {
                        var objme = $(this);
                        if (typeof (objme.attr("_isHms")) == "undefined") {
                            if (objme.val().length > 10) {
                                objme.css("width", "140px");
                            }
                        } else { objme.val(objme.val().substring(0, 10)); }
                    }
                },
                gotoCurrent: true,
                changeMonth: true,
                changeYear: true
            });
        }

        // 4. 删除行
        function DeleteExpandRow(obj) {
            var row = obj.parentElement.parentElement;
            row.parentNode.removeChild(row);
            // 如果没有数据，显示“暂无数据”
            if ($("#tblExpand tr").length <= 1) {
                InitExpandTable();
            }
        }

        // 绑定新增按钮
        function AddPurOrderDtl() {
            AddExpandRowEx({}, $("#tblExpand tr").length, $("#tblExpand tr").length);
        }

        // 页面加载时初始化
        $(function () {
            InitExpandTable();
            // 示例：自动加载虚拟数据
            //LoadExpandTableData();
        });


    </script>
</asp:Content>
