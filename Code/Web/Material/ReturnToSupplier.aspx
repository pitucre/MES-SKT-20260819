<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="ReturnToSupplier.aspx.cs"
    Inherits="SKT.LeanMES.Web.Material.ReturnToSupplier" %>

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
            <td class="Label1">退货单<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" readonly="readonly" value="" id="txtROrder" class="TextBox" style="width: 250px; height: 25px;" clientidmode="Static" /><input id="button2"
                    class="ButtonBox" type="button" onclick="getReturnOrders()" value="..." title="选择退货单" style="height: 27px;" />
                <asp:HiddenField ID="hfReturnOrderId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">物料条码/包装箱条码
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px;" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="float: left; width: 55%">
        <table class="ListTable" width="100%" id="tbRtvItem" style="line-height: 28px">
            <tr class="ListTableHeader">
                <th style="width: 10%">采购单
                </th>
                <th style="width: 15%">物料编码
                </th>
                <th style="width: 20%">物料名称
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
                <th style="width: 10%"></th>
            </tr>
            <tr id="trNoGrn" class="ListTableOddRow">
                <td colspan="4" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>

    </div>
    <script type="text/javascript">

        var arrReturnItem = [];//存放准备退料的Item
        var qtyLimit = -1;//数量验证，是否超过申请退料数量
        $(function () {
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey === 13) {
                    if ($("#txtROrder").val() === "") {
                        alert("请选择退料单");
                        return false;
                    }
                    //验证是否重复扫描
                    if (checkGrnExist($.trim($("#txtGRN").val())) === true) return false;
                    //检查是否可退
                    var grnResult = checkGrn($.trim($("#txtGRN").val())) || false;    
                    if (grnResult) {
                        //验证包装箱是否重复扫描 dl.liang 20230828 见具体方法
                        if(checkBoxGrnExistList(grnResult)){
                              alert("当前扫描的【"+$.trim($("#txtGRN").val())+"】条码已扫描，请勿重复扫描！");
                              return false;
                            }
                        showGrnList(grnResult);
                        //更新已扫描数量
                        updateReQty();
                    } else {
                        //alert('未能获取此GRN关联信息');
                    }
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                }
            });

        });

        function getReturnOrders() {
            dialog({ title: "选择退料单", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=118&CallBackFunc=getReturnOrdersCb&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
    }

    function getReturnOrdersCb(list) {
        $("#hfReturnOrderId").val(list[0][0]);
        $("#txtROrder").val(list[0][1]);
        if (list[0][0] === '-1') return false;
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetInfoRTV(list[0][0]);
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
            var RtvDtlID = dataList[i].RtvDtlID || '0';
            var itemCode = dataList[i].ItemCode || '';
            var itemName = dataList[i].ItemName || '';
            var quantity = dataList[i].Quantity || '0';
            var reQty = dataList[i].ReQty || '0';
            var po = dataList[i].SourceBillNo || '';
            html += "<tr class='ListTableOddRow ItemRow'>";
            html += "<td class='RtvDtlID' style='display:none;'>" + RtvDtlID + "</td>";
            html += "<td class=' '>" + po + "</td>";
            html += "<td class=' ROItem'>" + itemCode + "</td>";
            html += "<td>" + itemName + "</td>";
            html += "<td class=' Qty'>" + quantity + "</td>";
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

    //扫描GRN，检查GRN
    function checkGrn(grn) {
        var returnId = $("#hfReturnOrderId").val();
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckGrnReturn(returnId, grn);
        if (ajax.value === '') return false;
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
        var grnResult = JSON.parse(ajax.value);
        return grnResult;
    }

    //显示GRN扫描记录表
    function showGrnList(grnObj) {
        if (grnObj.length <= 0) return false;
        for (var i=0; i < grnObj.length; i++) {
            if (!grnObj[i]) return false;
            var balanceQty = grnObj[i].BalanceQty;
            var itemCode = grnObj[i].ItemCode;
            var SerialNumber = grnObj[i].SerialNumber;
            var Porder = grnObj[i].POorder;
            var autoId = grnObj[i].AutoId;
            var r = "<tr class='ListTableOddRow GrnRow'>";
            r += "<td class='GrnData'>" + SerialNumber + "</td>";
            r += "<td class='GrnType' data-porder='" + Porder + "' data-autoid='" + autoId + "' >" + itemCode + "</td>";
            r += "<td class='QtyData'>" + balanceQty + "</td>";
            r += "<td style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"delGrnRec(this)\"><%= Buttons.COM_Delete %></td>";
        r += "</tr>";

        $("#trNoGrn").remove();
        if ($("#tbGrnLog tr").length === 1) {
            $("#tbGrnLog tr:eq(0)").after(r);
        }
        else {
            $("#tbGrnLog tr:eq(1)").before(r);
        }
    }
}

//删除已扫描的GRN
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

//确认退料
function Save() {
    var arrGrn = [];
    $(".GrnData").each(function () {
        arrGrn.push($(this).html());
    })
    if (arrGrn.length === 0) {
        alert('请扫描要退的GRN');
        return false;
    }
    if (qtyLimit >-1) {
        alert("当前扫描第" + qtyLimit + "行数量超出申请退货数量，请进行修改");
        return false;
    }
    if (!confirm('是否确认退料?')) {
        return false;
    }
    var reTurnDetails = [];
    $(".RtvDtlID").each(function () {
        var detail = {};
        detail.RtvDtlID = $(this).text();
        detail.ReQty = $(this).siblings(".reQty").text();
        reTurnDetails.push(detail);

    })

    var strGrns = arrGrn.join(",");
    var returnId = $("#hfReturnOrderId").val();
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveRTV(returnId, strGrns, reTurnDetails);
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

}

//退料数量变更，数量验证，超出变红
function updateReQty() {
    //console.log(arrReturnItem);
    var itemLen = arrReturnItem.length;//Item种类
    var str = JSON.stringify(arrReturnItem);
    var newEntity = JSON.parse(str);   //复制一个ItemObj
    $(".GrnType").each(function (a, b) {
        var grnQty = $(this).next().html();

        var _itemCode = $(this).html();
        var _porder = $(this).data("porder");
        var _autoId = $(this).data("autoid");

        for (var i = 0; i < itemLen; i++) {
            if (_porder === newEntity[i].SourceBillNo && _itemCode == newEntity[i].ItemCode && _autoId == newEntity[i].SourceEntryID) {
                newEntity[i].ReQty += grnQty * 1
            }
        }
    })

    //用新实体更新Item table
    showRoDetail(newEntity);
    //数量验证
    qtyLimit = -1;
    $(".reQty").each(function (i,v) {
        var qty = $(this).prev().html() || 0;
        if ($(this).html() * 1 > qty * 1) {
            $(this).addClass("Bg-Red");
            qtyLimit = i+1;
        } else {
            //qtyLimit = true;
            $(this).removeClass("Bg-Red");
        }
    });
}

function checkGrnExist(grn) {
    var exist = false;
    $(".GrnData").each(function () {
        if ($(this).html() === grn) {
            $(this).addClass("Bg-Red");
            alert("["+grn+"]GRN已扫描!");
            exist = true;
        } else {
            $(this).removeClass("Bg-Red");
        }
    });
    return exist;
}

function checkBoxGrnExistList(grnObj) {
   var exist = false;
   if (grnObj.length <= 0) return false;
   var arrGrn = [];
    $(".GrnData").each(function () {
          arrGrn.push($(this).html());
    })
   for (var i=0; i < grnObj.length; i++) {
     var SerialNumber = grnObj[i].SerialNumber;
     if(arrGrn.includes(SerialNumber)) {
         exist = true
         }
   }
   return exist;
}

    </script>

</asp:Content>


