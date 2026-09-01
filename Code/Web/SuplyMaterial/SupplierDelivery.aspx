<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="SupplierDelivery.aspx.cs" Inherits="SKT.LeanMES.Web.SuplyMaterial.SupplierDelivery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" align="left" colspan="6">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2">
                采购单号<em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="hdnBuyNO" />
                <input type="text" id="txtBuyNO" class="TextBox" style="width: 50%;" disabled="disabled" /><input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectPoOrder()" />
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
    <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px;">
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
             <th style="width: 20%">
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
            <th style="width: 8%">
                交货日期<%--<input type="checkbox"
                    id="IsAllData"  onclick="IsCheckData(this)" /><em>*</em>--%>
            </th>
              <th style="width: 10%">
                确认交期<%--<input type="checkbox"
                    id="IsAllData"  onclick="IsCheckData(this)" />--%><em>*</em>
            </th>
            <th style="width: 10%">
                交货人
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="10" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.material.js"
        type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var supplierId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType %>";
        var poOrder = ""; //采购单
        var OrderList = []; //采购单细项列表
        $(function () {
            if (IsSupplierPeriod == 2) { //不需要
                $("input").attr("disabled", true);
                alert("供应商不需要交期维护,请知悉!");
            }
            else {
                //alert("请选择采购订单!");
            }
            $("#txtBuyNO").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    if ($.trim($("#txtBuyNO").val()) != "") {
                        poOrder = $.trim($("#txtBuyNO").val());
                        $("#hdnBuyNO").val(poOrder);
                        showOrderDelList(poOrder, "-1");
                    }
                    return false;
                }
            });
            //通过用户名 获取 中文名称
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.GetNameByUser(userName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = $.parseJSON(ajax.value).data;
            if (data.length > 0 && data.CName != "") {
                userName = data[0].CName;
            }
    
        });

        //选中采购单列表
        function selectPoOrder() {
            var SearchCondition = "";
            if (supplierId != -1) {
                SearchCondition = "SupplierId =" + supplierId + " AND IsPeriod = 0 ";
                dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                    src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=106&CallBackFunc=setBuyValue&Multiple=false&PageCondition="
                        + escape(SearchCondition) + "&rnd=" + Math.random(), width: 720, height: 368
                });
            }
            else {
                SearchCondition = " IsPeriod = 0 ";
                dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                    src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=106&CallBackFunc=setBuyValue&Multiple=false&PageCondition="
                       + escape(SearchCondition) + "&rnd=" + Math.random(), width: 720, height: 368
                });
            }
        }

        function setBuyValue(list) {
            $("#txtBuyNO").val(list[0][1]);
            $("#hdnBuyNO").val(list[0][1]);
            $("#<%=this.lblVendorName.ClientID %>").text(list[0][3]); //供应商名称
            poOrder = list[0][1];
            showOrderDelList();
        }

        //显示送货单明细
        function showOrderDelList() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.GetSupplierDeliveryItem(poOrder);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = $.parseJSON(ajax.value).data;
            //添加送货项列表
            OrderList = [];
            $.grep(data, function (e, i) {
                OrderList.push(e);
            });
            GetOrderDelList();
        }

        var ConfirmDateTime = "";
        function GetOrderDelList() {
            if (OrderList != null && OrderList.length > 0) {

                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#trNewInfo").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel
                var mydate = new Date();
                var year = mydate.getFullYear();
                var mon = mydate.getMonth() + 1;
                var day = mydate.getDate();
                //var nowdata = mydate.getFullYear().toString() + parseInt(mydate.getMonth() + 1).toString() + mydate.getDate().toString();
                var nowdata = year + "-" + (mon < 10 ? "0" + mon : mon) + "-" + (day < 10 ? "0" + day : day);
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
                    cel.innerHTML = parseFloat(OrderList[i].PBuyQty);

                   

                    cel = row.insertCell(5);
                    cel.innerHTML = parseFloat(OrderList[i].ReceiveQty);

                    OrderList[i].UnpaidQty = parseFloat(OrderList[i].PBuyQty) - parseFloat(OrderList[i].ReceiveQty);

                    cel = row.insertCell(6);
                    cel.innerHTML = OrderList[i].UnpaidQty;

                    cel = row.insertCell(7);
                 //   cel.innerHTML = OrderList[i].PlanDateTime == "9999-12-31" ? "" : OrderList[i].PlanDateTime;
                 //   cel.innerHTML = "<input type='text' style='width: 60%' id='data" + i + "' class='TextBox' readonly='readonly' value='" + (OrderList[i].PlanDateTime == "9999-12-31" ? "" : OrderList[i].PlanDateTime) + "' IsRequired='1'" +
                 //" onchange='ChangeData(" + i + " ,this)'/>";
                    cel.innerHTML = "<input type='text' style='min-width:85px;width: 65%' id='data" + i + "' disabled=\"disabled\" class='TextBox' readonly='readonly' value='" + (OrderList[i].PlanDateTime == "9999-12-31" ? "" : OrderList[i].PlanDateTime) + "' " + "/>";

                    cel = row.insertCell(8);
                     ConfirmDateTime = (OrderList[i].ConfirmDateTime == undefined ? "" : OrderList[i].ConfirmDateTime);
                    //OrderList[i].PlanDateTime = OrderList[i].PlanDateTime.substring(0,10);
                     cel.innerHTML = "<input type='text' style='min-width:85px;width: 65%' id='dataConfirm" + i + "' class='DateTimeBox' readonly='readonly' value='" + (ConfirmDateTime == "" ? (OrderList[i].PlanDateTime == "9999-12-31" ? "" : OrderList[i].PlanDateTime) : ConfirmDateTime) + "' IsRequired='1'" +
                        " onchange='ChangeConfirmData(" + i + " ,this)'/>";

                    cel = row.insertCell(9);
                    cel.innerHTML = "<input type='text' style='width: 90%;text-align:left;' id='man" + i + "' class='NumericBox50' value='" + userName + "' IsRequired='1'" +
                        " onchange='ChangeName(" + i + " ,this)' />";

                    OrderList[i].PlanDateTime = $("#data" + i).val();
                    OrderList[i].DeliveryMan = $("#man" + i).val();
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
            var value = $(obj).val();
            var length = value.length;
            if (length > 20) {
                alert("交货人字符长度不能超过20位!");
                $(obj).val("");
                return false; 
            }
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


     
            var newOrderList = OrderList;
            for (var i = 0; i < newOrderList.length; i++)
            {
                newOrderList[i].ItemSpec = "";
            }

            var re = /^[0-9]*[0-9][0-9]*$/;
            if (newOrderList.length > 0) {
                if (re.test(newOrderList[0].PBuyQty)) {
                    newOrderList[0].PBuyQty = newOrderList[0].PBuyQty.toFixed(1);
                }
                if (re.test(OrderList[0].UnpaidQty)) {
                    newOrderList[0].UnpaidQty = newOrderList[0].UnpaidQty.toFixed(1);
                }
            }
            
            var entity = {};
            entity.SupplierDelivery = -1;
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            entity.tbDtl = JSON.stringify(newOrderList);

         
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.SaveSupplierDelivery(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            clearTableInfo();
        }

        //清空列表
        function clearTableInfo() {
            $("#tbBuyOrderDetail tr:not(:first)").each(function () {
                $(this).remove();
            });
            var rightStr1 = "<tr id='trLast' class='ListTableOddRow'><td colspan='10' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr1).appendTo($("#tbBuyOrderDetail"));

            $("#<%=this.lblVendorName.ClientID %>").text(""); //供应商名称
            $("#txtBuyNO").val("");
            $("#hdnBuyNO").val("");
        }
        //是否当做到货日期
        function IsCheckData(obj) {
            var chooseData = "";         
            var result = $("#IsAllData").is(":checked");
            var tableCount = OrderList.length;
            if (result) { //选中
                //其他不被选中
                for (var i = 0; i < tableCount; i++) {
                    chooseData = $("#dataConfirm" + i + "").val();
                    if (chooseData != "") {
                        i = tableCount;
                    }
                }
            } else {
                for (var i = 0; i < tableCount; i++) {
                    $("#dataConfirm" + i + "").val("");
                    OrderList[i].ConfirmDateTime = "";
                }
            }
            if (chooseData != "") {
                for (var i = 0; i < tableCount; i++) {
                    $("#dataConfirm" + i + "").val(chooseData);
                    OrderList[i].ConfirmDateTime = chooseData;
                }
            }
        }
    </script>
</asp:Content>
