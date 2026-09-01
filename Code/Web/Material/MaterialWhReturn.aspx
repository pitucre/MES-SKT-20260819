<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialWhReturn.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialWhReturn" %>

<%@ Import Namespace="Resources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <style>
        .Bg-Red {
            background: red;
            font-weight: bolder;
        }
    </style>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>

        <tr>
            <td class="Label2">退料单<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" readonly="readonly" value="" id="txtROrder" class="TextBox" style="width: 250px; height: 25px;" clientidmode="Static" /><input id="button2"
                    class="ButtonBox" type="button" onclick="getReturnOrders()" value="..." title="选择退货单" style="height: 27px;" />
                <label id="lblDepName" style="display: none"></label>
            </td>
            <td class="Label2">仓库
            </td>
            <td class="Field2">
                <label id="txtWarehourse" class="text" />
            </td>
        </tr>
        <tr>
            <td class="Label2">库位条码<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" value="" id="txtWareCode" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;"/>
            </td>
            <td class="Label2">物料条码<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>

    </table>
    <div class="clear5">
    </div>

    <div style="float: left; width: 55%">
        <table class="ListTable" width="100%" id="tbRtvItem" style="line-height: 28px">
            <tr class="ListTableHeader">
                <th style="width: 15%">物料编码
                </th>
                <th style="width: 20%">物料名称
                </th>
                <th style="width: 10%">生产工单
                </th>
                <th style="width: 10%">申请数量
                </th>
                <th style="width: 10%">已退数量
                </th>
            </tr>
            <tr id="trNoInfo" class="ListTableOddRow">
                <td colspan="5" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>

    <div style="float: right; width: 40%">
        <table class="ListTable" width="100%" id="tbGrnLog" style="line-height: 28px">
            <tr class="ListTableHeader">
                <th style="width: 30%">GRN
                </th>
                <th style="width: 45%">物料编码
                </th>
                <th style="width: 10%">数量
                </th>
                <th style="width: 10%">操作</th>
            </tr>
            <tr id="trNoGrn" class="ListTableOddRow">
                <td colspan="4" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>

    <script type="text/javascript">

        $("form").submit(function (e) {
            if (e && e.preventDefault) {
                e.preventDefault();
            }
            else {
                window.event.returnValue = false;
            }
            return false;
        })
        var qtyLimit = true;//数量验证，是否超过申请退料数量
        var arrReturnItem = [];//存放准备退料的Item
        var arrGrn = []; //扫描的GRN数组
        var curUser = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

        $(function () {
            $("#txtWareCode").focus();
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey === 13) {
                    if ($("#txtROrder").val() === "") {
                        alert("请选择退料单");
                        return false;
                    }
                    //校验货位产品唯一
                    var wareCode = $.trim($("#txtWareCode").val());
                    if (wareCode && !verifyProductOnly(wareCode)) return false;

                    //验证是否重复扫描
                    if (checkGrnExist($.trim($("#txtGRN").val())) === true) return false;
                    //检查是否可退
                    var grnResult = checkGrn($.trim($("#txtGRN").val())) || false;
                    if (grnResult) {
                        if (showGrnList(grnResult, 0)) {
                            //更新已扫描数量
                            updateReQty();
                        }
                    } else {
                        //alert('未能获取此GRN关联信息');
                    }
                    

                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                }
            });
            /*扫描库位条码*/
            $("#txtWareCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($("#txtWareCode").val() === '') {
                        alert('库位不能为空！');
                        return false;
                    }
                    if (!checkWhCodeExist($("#txtWareCode").val())) {
                        $("#txtWareCode").focus();
                        $("#txtWareCode").select();
                        alert('不存在此库位');
                        return false;
                    }
                    //校验货位产品唯一
                    var wareCode = $.trim($("#txtWareCode").val());
                    if (wareCode && !verifyProductOnly(wareCode)) return false;

                    $("#txtGRN").focus();
                }
            });

            /*退料数量*/
            $("#txtQty").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    //Save();
                }
            });
            //$("#btnReturn").bind("click", function () {
            //    Save();
            //});
        });

        function GetQuantityByGRN(grn) {
            $("#txtGRN").focus();
            $("#txtGRN").select();
            if (grn === "") return false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetInfoByGrnReturn(grn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtGRN").val("");
                return false;
            }
            else {
                var dataList = JSON.parse(ajax.value);
                $("#txtQty").val(dataList.data[0].ReQty);
                $("#lblDepName").html(dataList.data[0].DepName);
                if (dataList.data[0].MaterialReturnNo === '') {
                    alert("此GRN不能进行当前操作");
                    return false;
                };
                //插入扫描记录
                enterToTab(dataList);
            }
        }

        function Save() {
            var arrGrn = [];
            $(".GrnData").each(function () {
                arrGrn.push($(this).html() + ":" + $(this).next().next().next().find("input.reBillID").val());
            })
            if (arrGrn.length === 0) {
                alert('请扫描要退的GRN');
                return false;
            }

            if ($("#txtWareCode").val()==='') {
                alert('库位不能为空！');
                return false;
            }
            if (!checkBarCode()) {
                return;
            }

            //校验货位产品唯一
            if (!verifyProductOnly($("#txtWareCode").val())) return false;

            $(".reQty").each(function () {
                var qty = $(this).prev().html() || 0;
                if ($(this).html() * 1 > qty * 1) {
                    qtyLimit = false;
                }
            });
            if (qtyLimit === false) {
                alert("当前扫描数量超出申请退货数量，请进行修改");
                return false;
            }

            if (!confirm('是否确认退料?')) {
                return false;
            }
            var strGrns = arrGrn.join(",");
            var returnNo = $("#txtROrder").val();
            var cBarcode = $("#txtWareCode").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveRTW(returnNo, strGrns, cBarcode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("退料成功");
            $(".ItemRow").remove();
            $(".GrnRow").remove();
            $("#tbGrnLog").append('<tr id="trNoGrn" class="ListTableOddRow"><td colspan="4" style="text-align: center;">暂无数据</td></tr>');
            $("#tbRtvItem").append('<tr id="trNoInfo" class="ListTableOddRow"><td colspan="5" style="text-align: center;">暂无数据</td></tr>');
            $("#txtROrder").val('');
            $("#txtGRN").val('');
            $("#lblDepName").html('');
            $("#txtWareCode").val('');

        }

        function enterToTab(dataList) {
            /******显示退料列表*******/
            var curGrn = $("#txtGRN").val() || '';
            $("#trNewInfo").remove();
            var dataLen = dataList.data.length;
            var r = '';
            for (var i = 0; i < dataLen; i++) {
                var list = dataList.data[i];
                r += "<tr class='ListTableOddRow GrnRow'>";
                r += "<td class='RNoData'>" + list.MaterialReturnNo + "</td>";
                r += "<td class='GrnData " + curGrn + "'>" + list.SerialNumber + "</td>";
                r += "<td>" + list.ItemName + "</td>";
                r += "<td>" + list.ItemSpec + "</td>";
                r += "<td class='QtyData'>" + list.ReQty + "</td>";
                r += "<td class=''>" + list.CreateBy + "</td>";
                r += "<td>" + list.ModifyDate + "</td>";
                if (dataLen > 0) {
                    if (list.SerialNumber === curGrn) {
                        r += "<td style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"delGrnRec(this,'" + curGrn + "')\"><%= Buttons.COM_Delete %></td>";
                    } else {
                        r += "<td></td>"
                    }
                } else {
                    r += "<td style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"delGrnRec(this)\"><%= Buttons.COM_Delete %></td>";
                }
                r += "</tr>";
            }

            if ($("#tblRecHistory tr").length === 1) {
                $("#tblRecHistory tr:eq(0)").after(r);
            }
            else {
                $("#tblRecHistory tr:eq(1)").before(r);
            }

            //更GRN数组
            setGrnArr();
        }

        function setGrnArr() {
            arrGrn = [];
            $(".GrnData").each(function () {
                arrGrn.push($(this).html());
            });
        }

        function delGrnRec(obj) {
            var table = document.getElementById("tbGrnLog");
            table.deleteRow(obj.parentElement.rowIndex);
            if ($("#tbGrnLog tr").length === 1) {
                $("#tbGrnLog tr:eq(0)").after('<tr id="trNoGrn" class="ListTableOddRow">' +
                    '<td colspan="4" style="text-align: center;">暂无数据</td>' +
                    '</tr>');
            }
            //更新数量
            updateReQty();
        }

        function checkGrnExist(grn) {
            var exist = false;
            $(".GrnData").each(function () {
                if ($(this).html() === grn) {
                    $(this).addClass("Bg-Red");
                    exist = true;
                } else {
                    $(this).removeClass("Bg-Red");
                }
            });
            return exist;
        }

        function checkWhCodeExist(barcode) {
            var exist = false;
            if (barcode.trim() === '') return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(barcode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            if (en.BarCode) {
                exist = true;
            }
            var chrName = $.trim($("#txtWarehourse").html()).replace("&nbsp;","");
            $("#txtWarehourse").html(en.CWhName);
            return exist;
        }

         function getReturnOrders() {
             var searchSearch = " Status = 0 ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=204&PageCondition=" + escape(searchSearch) +"&CallBackFunc=setReturnOrder&Multiple=false&rnd=" + Math.random(), width: 650, height: 450 });
         }

        function setReturnOrder(list) {
            $("#txtROrder").val(list[0][0]);
            $("#txtWarehourse").text(list[0][3]);
            $("#lblDepName").html(list[0][2]);
            if (list[0][0] === '-1') return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetInfoRTW(list[0][0]);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                var dataList = JSON.parse(ajax.value);
                arrReturnItem = dataList;
                showRoDetail(dataList);
            }
        }

        //显示退料单明细信息表格
        function showRoDetail(dataList) {
            if (!dataList[0]) return false;
            var html = '';
            var listNum = dataList.length || 0;
            for (var i = 0; i < listNum; i++) {
                var itemCode = dataList[i].ItemCode || '';
                var itemName = dataList[i].ItemName || '';
                var quantity = dataList[i].ReturnQty || '0';
                var reQty = dataList[i].ReceiveQty || '0';
                var prodOrder = dataList[i].PoCode || '';
                var reBillID = dataList[i].ERPReBillID || '0';
                html += "<tr class='ListTableOddRow ItemRow'>";
                html += "<td class='ROItem'>" + itemCode + "</td>";
                html += "<td>" + itemName + "</td>";
                html += "<td>" + prodOrder + "<input class='ERPReBillID' type='text' style='display:none' value='" + reBillID + "'></input></td>";
                html += "<td class='Qty'>" + quantity + "</td>";
                html += "<td class='reQty'>" + reQty + "</td>";
                html += "</tr>";
            }
            $("#trNoInfo").remove();
            $(".ItemRow").remove();
            if ($("#tbRtvItem tr").length === 1) {
                $("#tbRtvItem tr:eq(0)").after(html);
            }
            else {
                $("#tbRtvItem tr:eq(1)").before(html);
            }
        }

        //退料数量变更，数量验证，超出变红
        function updateReQty() {
            //console.log(arrReturnItem);
            var itemLen = arrReturnItem.length;//Item种类
            var str = JSON.stringify(arrReturnItem);
            var newEntity = JSON.parse(str);   //复制一个ItemObj
            $(".GrnType").each(function () {
                var grnQty = $(this).next().html();
                var _itemCode = $(this).html();
                var reBillID = $(this).next().next().find("input.reBillID").val();
                for (var i = 0; i < itemLen; i++) {
                    if (_itemCode === newEntity[i].ItemCode && newEntity[i].ERPReBillID == reBillID) {//增加行号
                        newEntity[i].ReceiveQty += grnQty * 1
                    }
                }
            });

            //用新实体更新Item table
            showRoDetail(newEntity);

            //数量验证
            $(".reQty").each(function () {
                var qty = $(this).prev().html() || 0;
                if ($(this).html() * 1 > qty * 1) {
                    $(this).addClass("Bg-Red");
                    qtyLimit = false;
                } else {
                    qtyLimit = true;
                    $(this).removeClass("Bg-Red");
                }
            });
        }

        //扫描GRN，检查GRN
        function checkGrn(grn) {
            var returnOrder = $("#txtROrder").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckGrnRTW(returnOrder, grn);
            if (ajax.value === '') return false;
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var grnResult = JSON.parse(ajax.value);
            return grnResult;
        }

        var grnList = [];
        //显示GRN扫描记录表 //inReBillID选择了具体行的退货单明细的行号
        function showGrnList(grnObj, inReBillID) {
            //console.log(grnObj)
            if (!grnObj[0]) return false;
            grnList = grnObj;
            var balanceQty = grnObj[0].BalanceQty;
            var itemCode = grnObj[0].ItemCode;
            var SerialNumber = grnObj[0].SerialNumber;

            //如果物料品号对应的退料的品号只有一个，则直接更新数量等
            var reBillID = 0;
            var rtvItemtr = $("#tbRtvItem tr");
            var num = rtvItemtr.length;
            var billIDs = [];
            for (i = 0; i < num; i++) {
                var poItemCode = $(rtvItemtr[i]).find("td.ROItem").text();
                var poQty = $(rtvItemtr[i]).find("td.Qty").text();
                var reQty = $(rtvItemtr[i]).find("td.reQty").text();
                var ERPReBillID = $(rtvItemtr[i]).find("td input.ERPReBillID").val();                
                if (poItemCode == itemCode && (inReBillID == 0 || inReBillID == ERPReBillID)) {
                    billIDs.push(ERPReBillID);
                    if (poQty - reQty == balanceQty && balanceQty != 0) {
                        reBillID = ERPReBillID;
                        break;
                    }
                }
            }
            //如果有两个物料同时数量又没有和grn一样的，则让他们选择
            if (billIDs.length > 1) {
                var returnNo = $("#txtROrder").val();
                var SearchCondition = " ReturnOrderNo='" + returnNo + "' and ItemCode='" + itemCode + "'";
                dialog({ title: "选择退料明细", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=207&CallBackFunc=setReturnNo&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 450 });

                return false;
            }
            reBillID = billIDs[0];
            var r = "<tr class='ListTableOddRow GrnRow'>";
            r += "<td class='GrnData'>" + SerialNumber + "</td>";
            r += "<td class='GrnType'>" + itemCode + "</td>";
            r += "<td class='QtyData'>" + balanceQty + "</td>";
            r += "<td style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"delGrnRec(this)\"><%= Buttons.COM_Delete %><input class='reBillID'  type='text' style='display:none' value='" + reBillID + "'></input></td>";
            r += "</tr>";

            $("#trNoGrn").remove();
            if ($("#tbGrnLog tr").length === 1) {
                $("#tbGrnLog tr:eq(0)").after(r);
            }
            else {
                $("#tbGrnLog tr:eq(1)").before(r);
            }
            return true;
        }

        function setReturnNo(list) {
            var reBillNO = list[0][1];
            var returnOrderNO = list[0][2];
            var ItemCode = list[0][3];

            showGrnList(grnList, reBillNO);
            //更新已扫描数量
            updateReQty();
        }

        //验证库位
        function checkBarCode() {
            var wh = $.trim($("#txtWareCode").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(wh);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            if (!en.BarCode) {
                alert("库位条码不存在!");
                $("#txtWareCode").val("");
                $("#txtWareCode").focus();
                $("#txtWareCode").select();
                return false;
            }
            return true;
        }
        //校验货位产品唯一
        function verifyProductOnly(cBarCode) {
            var listReturnOrderDetail = arrReturnItem;
            if (listReturnOrderDetail && listReturnOrderDetail.length > 0) {
                var array = []; //去重
                for (var i = 0; i < listReturnOrderDetail.length; i++) {
                    if (array.indexOf(listReturnOrderDetail[i].ItemCode) === -1) {
                        array.push(listReturnOrderDetail[i].ItemCode);
                    }
                }
                if (array.length == 1) {
                    var result = isItemCanPlacedInWarehouseLocation("", array[0], cBarCode);
                    if (result == -1) {
                        return false;
                    }
                    if (result == 0) {
                        alert("当前库位不支持存放多种产品，请扫描其他库位！");
                        $("#txtWareCode").val("").focus();
                        return false;
                    }
                }
                else {
                    var isProductOnly = isItemCanPlacedInWarehouseLocation("", "", cBarCode);
                    if (isProductOnly == -1) {
                        return false;
                    }
                    if (isProductOnly == 1) {
                        alert("当前库位不支持存放多种产品，请扫描其他库位！");
                        $("#txtWareCode").val("").focus();
                        return false;
                    }
                }
            }
            return true;
        }

        //判断产品是否能放入当前库位
        function isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
            if (ajax.error != null) {
                alert(ajax.error.Message, 0);
                return -1;
            }
            return ajax.value ? 1 : 0;
        }
    </script>
</asp:Content>
