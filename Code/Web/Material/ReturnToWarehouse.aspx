<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="ReturnToWarehouse.aspx.cs" Inherits="SKT.LeanMES.Web.Material.ReturnToWarehouse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label1">退料单<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" isrequired='1' id="txtROrder" class="TextBox" style="width: 250px; height: 25px;" clientidmode="Static" /><input id="button2"
                    class="ButtonBox" type="button" onclick="getReturnOrders()" value="..." title="选择退货单" style="height: 27px;" />
                <asp:HiddenField ID="hfReturnOrderId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">仓库
            </td>
            <td class="Field1">
                <label id="txtWarehourse"></label>
            </td>
        </tr>
        <tr>
            <td class="Label1">不扫描,直接入指定仓库
            </td>
            <td class="Field1">
                <input type="checkbox" value="-1" id="chkMatchWholeWord" onclick="CheckAll();" />
            </td>
        </tr>
        <tr>
            <td class="Label1">库位条码
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtBarCode" class="TextBox" style="width: 250px;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">GRN/包装箱
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">退料数量
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRNQty" class="TextBox" style="width: 250px;" />
            </td>
        </tr>

    </table>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            退料单明细  
        </div>
        <div style="position: absolute; right: 200px; top: 5px; width: 50px; height: 20px; line-height: 18px;">
            已扫描
        </div>
        <div style="position: absolute; right: 100px; top: 5px; width: 100px; height: 15px; line-height: 18px; background-color: gray;">
        </div>
    </div>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px; overflow: scroll;"
        class="ListTable">
        <tr class="ListTableHeader">
            <th>行号
            </th>
            <th>GRN</th>
            <th>物料编码
            </th>
            <th>物料名称
            </th>
            <th>库位条码</th>
            <th>需退数量
            </th>
            <th>已退数量
            </th>
        </tr>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var returnOrder = "";
        $(function () {
            setTimeout(function () { $("#txtROrder").focus(); }, 100);
        });

        function getReturnOrders() {
            var searchSearch = " Status = 1 ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=204&PageCondition="
                     + escape(searchSearch) + "&CallBackFunc=getReturnOrdersCb&Multiple=false&rnd=" + Math.random(), width: 650, height: 300
            });
        }

        function getReturnOrdersCb(list) {
            $("#txtROrder").val(list[0][0]);
            $("#txtWarehourse").html(list[0][3]);
            if (list[0][0] === '-1') return false;
            returnOrder = list[0][1];
            if ($('#chkMatchWholeWord').is(":checked")) {
                showApplyOrderDetail(2);
            }
            else {
                showApplyOrderDetail(1);
            }
        }

        //工单绑定回车事件
        $("#txtROrder").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                returnOrder = $.trim($("#txtROrder").val());
                if ($('#chkMatchWholeWord').is(":checked")) {
                    showApplyOrderDetail(2);
                }
                else {
                    showApplyOrderDetail(1);
                }
            }
        });
        //库位条码回车
        $("#txtBarCode").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                var BarCode = $.trim($("#txtBarCode").val());
                if (BarCode == "") {
                    $("#txtGRN").focus();
                } else {
                    var entity = {};
                    entity.ReturnNo = returnOrder;
                    entity.BarCode = BarCode;
                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckRetrunMaterialBarCode", JSON.stringify(entity));
                    if (ajax.error == null) {
                        $("#txtGRN").focus();
                    }
                    else {
                        alert(ajax.error.Message);
                        $("#txtBarCode").val("").focus();
                    }
                }
            }
        });
        //GRN，数量回车事件
        var GRN = "";
        var grnQty = 0;
        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                GRN = $.trim($("#txtGRN").val());
                if (GRN != "") {
                    //找到GRN对应的退料数量
                    var GrnReturnQty = "";
                    GrnReturnQty = $('#tblExpand tr[grn="' + GRN + '"]').find("td").eq(5).text(); //退料数量
                    if (GrnReturnQty == "") {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetMaInfo(GRN,2);
                        if (ajax.value == null) {
                            alert("GRN不存在或状态非【在产线】!");
                            $("txtGRN").val("");
                            $("txtGRN").focus();
                            return false;
                        }
                        $("#txtGRNQty").val(ajax.value.StockQty);
                    } else {
                        $("#txtGRNQty").val(GrnReturnQty);
                    }

                    setTimeout(function () {
                        $("#txtGRNQty").focus();
                        $("#txtGRNQty").select();
                    }, 100);
                } else {
                    alert("请输入GRN!");
                    $("#txtGRN").focus();
                    return false;
                }
            }
        });

        //GRN数量回车
        $("#txtGRNQty").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                grnQty = $.trim($("#txtGRNQty").val());
                if (grnQty == "") {
                    alert("请输入GRN退料数量!");
                    return false;
                } else {
                    if (isPositiveNum(this, 1)) {
                        var cBarCode = $.trim($("#txtBarCode").val());
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckConfrimGRN(returnOrder, GRN, grnQty, cBarCode);
                        if (ajax.error != null) {
                            var message = ajax.error.Message.substring(0, 2);
                            var showMessage = ajax.error.Message.substring(2, ajax.error.Message.length);
                            if (showMessage.indexOf("自动解除包装箱") != -1) {
                                alert(showMessage+"点【确定】，会扫入未解除包装箱的GRN");
                            }
                            else {
                                alert(showMessage);
                                if (message == "#1") {
                                    $("#txtBarCode").val("");
                                    setTimeout(function () { $("#txtBarCode").focus(); }, 100);
                                }
                                else {
                                    $("#txtGRN").val("");
                                    setTimeout(function () { $("#txtGRN").focus(); }, 100);
                                }
                                return false;
                            }
 
                        }
                        else {


                            //如果是GRN      GRN
                            //如果是包装箱    包装箱  转 GRN
                            var result = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetGRNIsBoxIsGRN(GRN);
                            if (result.error != null) {
                                alert(result.error.Message);
                                return false;
                            }
                            if (null != result) {
                                var datalist = result.value;
                                if (datalist.length <= 0) {
                                    alert("查无GRN");
                                    return false;
                                }
                                else if (datalist.length == 1) {
                                    //变颜色
                                    $('#tblExpand tr[grn="' + GRN + '"]').css("backgroundColor", "gray");
                                    $("input[id='comfirmQty" + GRN + "']").val(grnQty);
                                    $('#tblExpand tr[grn="' + GRN + '"]').find("td").eq(4).text(cBarCode);
                                    $("#tblExpand").append($('#tblExpand tr[grn="' + GRN + '"]'));
                                    //重新排序
                                    $("#tblExpand tr").each(function (i) {
                                        $(this).find("td").eq(0).text(i)
                                    });
                                }
                                else {
                                    for (var i = 0; i < datalist.length; i++) {
                                        //变颜色
                                        $('#tblExpand tr[grn="' + datalist[i].SerialNumber + '"]').css("backgroundColor", "gray");
                                        $("input[id='comfirmQty" + datalist[i].SerialNumber + "']").val(datalist[i].BalanceQty);
                                        $('#tblExpand tr[grn="' + GRN + '"]').find("td").eq(4).text(cBarCode);
                                        $("#tblExpand").append($('#tblExpand tr[grn="' + datalist[i].SerialNumber + '"]'));
                                    }
                                    //重新排序
                                    $("#tblExpand tr").each(function (i) {
                                        $(this).find("td").eq(0).text(i)
                                    });
                                }
                            }









                            clearGRNInfo();
                        }
                    }
                }
            }
        });

        function clearGRNInfo() {
            $("#txtGRN").val("");
            $("#txtGRNQty").val("");
            $("#txtBarCode").val("");
            setTimeout(function () { $("#txtBarCode").focus(); }, 100)

        }

        function CheckAll() {
            if (returnOrder == "") {
                alert("请选择要退料的工单!");
                return false;
            }
            else {
                if ($('#chkMatchWholeWord').is(":checked")) {
                    showApplyOrderDetail(2);
                }
                else {
                    showApplyOrderDetail(1);
                }
            }
        }

        //根据退料单显示明细
        function showApplyOrderDetail(searchType) {
            //每次加载删除除了第一行的数据
            $("#tblExpand tr:gt(0)").remove();
            var grnList = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetAllReturnGRN(returnOrder);
            if (grnList.error != null) {
                alert(grnList.error.Message);
                clearInfo();
                return false;
            } else {
                var addHtmlStr = "";
                if (grnList.value.length > 0) {
                    $("#txtWarehourse").html(grnList.value[0].CWhName);
                }
                //$("#txtWarehourse").html(grnList.value[0].CWhName);
                for (var i = 0; i < grnList.value.length; i++) {
                    var entity = grnList.value[i];
                    //push数据：
                    if (i % 2 == 0) {
                        if (entity.ReceiveQty != 0) {
                            addHtmlStr += "<tr  grn='" + entity.SerialNumber + "' class='ListTableEvenRow' style='background-color:gray;' >";
                        } else {
                            addHtmlStr += "<tr  grn='" + entity.SerialNumber + "' class='ListTableEvenRow' >";
                        }
                    }
                    else {
                        if (entity.ReceiveQty != 0) {
                            addHtmlStr += "<tr grn ='" + entity.SerialNumber + "' class='ListTableOddRow' style='background-color:gray;' >";
                        }
                        else {
                            addHtmlStr += "<tr grn ='" + entity.SerialNumber + "' class='ListTableOddRow'  >";
                        }
                    }

                    addHtmlStr += "<td>" + (i + 1) + "</td>"
                              + "<td>" + entity.SerialNumber + "</td>"
                              + "<td>" + entity.ItemCode + "</td>"
                              + "<td>" + entity.ItemName + "</td>"
                              + "<td>" + entity.CBarCode + "</td>"
                              + "<td>" + parseFloat(entity.BalanceQty) + "</td>"
                    if (searchType == 1) {
                        if (entity.ReceiveQty != 0) {
                            addHtmlStr += "<td><input  type ='text' id='comfirmQty" + entity.SerialNumber + "' onchange = isPositiveNum(this," + i + ") value ='" + parseFloat(entity.ReceiveQty) + "' /></td>"
                        }
                        else {
                            addHtmlStr += "<td><input  type ='text' id='comfirmQty" + entity.SerialNumber + "' onchange = isPositiveNum(this," + i + ") value ='' /></td>"
                        }
                    }
                    else {
                        if (entity.ReceiveQty != 0) {
                            addHtmlStr += "<td><input  type ='text' id='comfirmQty" + entity.SerialNumber + "' onchange = isPositiveNum(this," + i + ") value ='" + parseFloat(entity.ReceiveQty) + "' /></td>"
                        }
                        else {
                            addHtmlStr += "<td><input  type ='text' id='comfirmQty" + entity.SerialNumber + "' onchange = isPositiveNum(this," + i + ") value ='" + parseFloat(entity.BalanceQty) + "' /></td>"
                        }
                    }

                    + "</tr>";
                }
                $("#tblExpand").append(addHtmlStr);
                if (searchType == 2) {
                    $("#tblExpand tbody tr").each(function () {
                        $(this).css("backgroundColor", "gray");
                    });
                }
                //定格在库位条码
                setTimeout(function () { $("#txtBarCode").focus(); }, 100);
            }
        }

        function isPositiveNum(obj, i) {//是否为正整数
            var s = $(obj).val();
            var re = /^[+-]?(0|([1-9]\d*))(\.\d+)?$/g;
            if (!re.test(s)) {
                alert("请输入正确数字格式！");
                $(obj).val("");
                setTimeout(function () { $(obj).select().focus(); }, 100);
                return false;
            } else {
                return true;
            }
        }

        //保存清点数据
        function Save() {
            if (!confirm('仓库确认退料完成?')) {
                return false;
            }
            var GRNDetail = [];
            //遍历表中，清点的数据
            $("#tblExpand tr:gt(0)").each(function () {
                var grn = $(this).find("td").eq(1).text(); //GRN
                var grnQty = $("input[id='comfirmQty" + grn + "']").val();
                if (grnQty != "") {
                    GRNDetail.push({ "GRN": grn, "ReturnQty": grnQty });
                }
            });

            var entity = {};
            entity.ProdOrderNo = returnOrder;
            entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.TbDtl = JSON.stringify(GRNDetail);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveConfrimMaterial(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            clearInfo();
            $("#tblExpand tr:gt(0)").remove();
            $("#txtWarehourse").html("");
        }
        //清空数据
        function clearInfo() {
            returnOrder = "";
            $("#txtROrder").val("");
            setTimeout(function () { $("#txtROrder").focus(); }, 100);
        }
    </script>
</asp:Content>

