<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="SupplierDeliveryEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SuplyMaterial.SupplierDeliveryEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label Tips" align="left" colspan="6">
                <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" /><span>请选择对应的采购订单。</span>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                采购单号<em>*</em>
            </td>
            <td class="Field2">
                <%--<input type="hidden" value="" id="hdnBuyNO" />
                <input type="text" id="txtBuyNO" class="TextBox" />
                <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectPoOrder()" />--%>
                <asp:Label ID="lblPO" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                供应商名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblVendorName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            采购单明细
        </div>
    </div>
    <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px">
        <tr class="ListTableHeader">
            <th style="width: 5%">
                行号
            </th>
            <th style="width: 14%">
                物料编码
            </th>
            <th style="width: 14%">
                物料名称
            </th>
             <th style="width: 19%">
                物料规格
            </th>
            <th style="width: 7%">
                物料数量
            </th>
            <th style="width: 7%">
                已交数量
            </th>
            <th style="width: 7%">
                未交数量
            </th>
            <th style="width: 10%">
                交货日期
            </th>
            <th style="width: 10%">
                确认交期<em>*</em>
            </th>
          
            <th style="width: 10%">
                交货人
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="9" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <script type="text/javascript">
        var supplierDeliveryId = '<%=Request.QueryString["ID"]%>';
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var OrderList = []; //采购单细项列表
        $(function () {
            showOrderDelList();
        });
        
        //显示送货单明细
        function showOrderDelList() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.SupplierDeliveryEdit(supplierDeliveryId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = $.parseJSON(ajax.value).data;           
            //采购单细项列表
            OrderList = [];
            $.grep(data, function (e, i) {
                OrderList.push(e);
            });
            GetOrderDelList();
            //console.log(OrderList)
        }
        var ConfirmDateTime = "";
        function GetOrderDelList() {
            if (OrderList != null && OrderList.length > 0) {

                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#trNewInfo").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel
                for (var i = 0; i < OrderList.length; i++) {

                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = i + 1;
                    cel.innerHTML += "<input type='hidden' id='RowID" + i + "' value='" + OrderList[i].AutoID + "'/>";

                    cel = row.insertCell(1);
                    cel.innerHTML = OrderList[i].ItemCode;
                    cel.id = 'tdInvCode' + i;

                    cel = row.insertCell(2);
                    cel.innerHTML = OrderList[i].ItemName;
                    cel.id = 'tdInvName' + i;

                    cel = row.insertCell(3);
                    cel.innerHTML = OrderList[i].ItemSpec;
                    cel.id = 'tdInvSpec' + i;

                    cel = row.insertCell(4);
                    cel.innerHTML = OrderList[i].PBuyQty;


                    cel = row.insertCell(5);
                    cel.innerHTML = OrderList[i].ReceiveQty;

                    OrderList[i].UnpaidQty = parseFloat(OrderList[i].PBuyQty) - parseFloat(OrderList[i].ReceiveQty);

                    cel = row.insertCell(6);
                    cel.innerHTML = OrderList[i].UnpaidQty;

                    cel = row.insertCell(7);
                   // cel.innerHTML = OrderList[i].PlanDateTime == "9999-12-31" ? "" : OrderList[i].PlanDateTime;
                    //OrderList[i].PlanDateTime = OrderList[i].PlanDateTime.substring(0,10);
                    cel.innerHTML = "<input type='text' style='min-width:85px;width: 65%' id='data" + i + "' disabled=\"disabled\" class='TextBox' readonly='readonly'  value='" + OrderList[i].PlanDateTime + "' " +
                        "/>";
                
                    cel = row.insertCell(8);
                    //如果确认交期为空 则默认与交货日期相同
                    ConfirmDateTime = (OrderList[i].ConfirmDateTime == undefined ? "" : OrderList[i].ConfirmDateTime);
                    cel.innerHTML = "<input type='text' style='min-width:85px;width: 65%' id='dataConfirm" + i + "' class='DateTimeBox' readonly='readonly' value='" + (ConfirmDateTime == "" ? (OrderList[i].PlanDateTime == "9999-12-31" ? "" : OrderList[i].PlanDateTime) : ConfirmDateTime) + "' IsRequired='1'" +
                        " onchange='ChangeConfirmData(" + i + " ,this)'/>";


                    cel = row.insertCell(9);
                    cel.innerHTML = "<input type='text' MaxLength='20' style='width: 90%;text-align:left;' id='man" + i + "' class='NumericBox50' value='" + OrderList[i].DeliveryMan + "' IsRequired='1'" +
                        " onchange='ChangeName(" + i + " ,this)'/>";
                }
            }
            else {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#tbBuyOrderDetail tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="10" align="center"><font color="red">暂无数据</font></td></tr>');
            }
            
            $(".DateTimeBox").datepicker({
                showOn: "button",
                buttonImageOnly: true,
                showHms: _isHms,
                minDate: 0,
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
                }
            });
        }

        function ChangeData(i, obj) {
            OrderList[i].PlanDateTime = $(obj).val();
        }

        function ChangeConfirmData(i, obj) {
            OrderList[i].ConfirmDateTime = $(obj).val();
        }
        function ChangeName(i, obj) {
            OrderList[i].DeliveryMan = $(obj).val();
        }

        //保存
        function Save() {
            var code = $("#hdnBuyNO").val();
            if (code == "") {
                alert("采购单号不能为空!");
                return false;
            }

            $("#tbBuyOrderDetail tr:not(:first)").each(function (index, element) {
                OrderList[index].PlanDateTime = $(this).children("td:eq(7)").find('input').val();
                OrderList[index].ConfirmDateTime = $(this).children("td:eq(8)").find('input').val();
            });

            var entity = {};
            entity.SupplierDelivery = supplierDeliveryId;
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            entity.tbDtl = JSON.stringify(OrderList);
           
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.SaveSupplierDelivery(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            window.parent.openTab(this, "供应商交期维护列表", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/SuplyMaterial/SupplierDeliveryList.aspx?name=SupplierDeliveryList", Date.parse(new Date()), "<%=SKT.LeanMES.Web.WebHelper.ImageRoot %>icon/eqpttype.png");
//            parent.window.Refresh();
        }

        //清空列表
        function clearTableInfo() {
            $("#tbBuyOrderDetail tr:not(:first)").each(function () {
                $(this).remove();
            });
            var rightStr1 = "<tr id='trLast' class='ListTableOddRow'><td colspan='8' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr1).appendTo($("#tbBuyOrderDetail"));

            $("#<%=this.lblVendorName.ClientID %>").text(""); //供应商名称
            $("#txtBuyNO").val("");
            $("#hdnBuyNO").val("");
        }

    </script>
</asp:Content>

