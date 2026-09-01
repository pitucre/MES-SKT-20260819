<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialIQCReturnForm.aspx.cs" MasterPageFile="~/Masters/ViewMaster.master" 
    Inherits="SKT.LeanMES.Web.Material.MaterialIQCReturnForm" %>


<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" align="left" colspan="6">
                <span>请选择或扫描对应的IQC检验单</span>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                IQC检验单号
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="hdnBuyNO" />
                <input type="text" id="txtBuyNO" class="TextBox" style="width: 90%" />
                <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectBuyOrder()" />
            </td>
            <td class="Label2">
                供应商名称
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="htnVender" />
                <asp:Label ID="lblVendorCode" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                退货单说明
            </td>
            <td class="Field2">
                <input type="text" id="txtRemark" class="TextBox" style="width: 90%" />
            </td>
            <td class="Label2">
                当前不良仓
            </td>
            <td class="Field2" colspan="3">
                <asp:Label runat="server" ID="lbNgWarehouse" ClientIDMode="Static"></asp:Label>
                <asp:HiddenField ID="hdNgWarehouse" runat="server" ClientIDMode="Static"/>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            退货物料明细
        </div>
        <%--<span style="float: right">
            <img src="../Content/images/delete.gif" alt="清空送货项" style="margin-left: 20px; cursor: pointer;
                float: right; padding-right: 20px;" onclick="Clear()" /></span>--%>
    </div>
    <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px">
        <tr class="ListTableHeader">
            <th style="width: 40px;">
                行号
            </th>
            <th style="width: 100px;">
                采购单号
            </th>
            <th style="width: 110px;">
                物料编码
            </th>
            <th>
                物料名称
            </th>
            <th style="width: 80px;">
                供应商代码
            </th>
            <th style="width: 200px;">
                供应商名称
            </th>
            <th style="width: 60px;">
                收货数量
            </th>
            <th style="width: 60px;">
                合格数量
            </th>
            <th style="width: 60px;">
                应退货数量
            </th>
            <th style="width: 50px;">
                移除
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="10" style="text-align: center;">
                <span>暂无数据</span>
            </td>
        </tr>
    </table>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            退货GRN条码明细
        </div>
    </div>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <tr class="ListTableHeader">
            <th style="width: 40px;">
                行号
            </th>
            <th style="width: 130px;">
                GRN条码
            </th>
            <th style="width: 120px;">
                物料编码
            </th>
            <th>
                物料名称
            </th>
            <th style="width: 130px;">
                批次号
            </th>
            <th style="width: 100px;">
                GRN条码数量
            </th>
            <th style="width: 100px;">
                应退货数量
            </th>
        </tr>
        <tr id="trLast" class="ListTableOddRow">
            <td colspan="8" style="text-align: center;">
                <span>暂无数据</span>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div id="tblInfo">
    </div>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var OrderList = []; //采购单送货细项列表
        var GRNList = []; //送货GRN细项列表
        var Vender = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType %>";
        function enterToTab()
        { }

        $(function () {
            $("#txtBuyNO").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    if ($.trim($("#txtBuyNO").val()) != "") {
                        //回车只显示GRN信息   
                        buyOrder = $.trim($("#txtBuyNO").val());
                        showBuyOrderList(buyOrder);
                    }
                    return false;
                }
            });
        });

        //选中退货IQC
        function selectBuyOrder() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=201&CallBackFunc=setBuyValue&Multiple=false&rnd=" + Math.random(), width: 850, height: 368
            });
        }

        function setBuyValue(list) {
            debugger;
            $("#txtBuyNO").val(list[0][1]);
            $("#hdnBuyNO").val(list[0][1]);

            if (!checkmrbend(list[0][1])) {
                return;
            } else {
                $("#msg").html("");
            }
            showBuyOrderList(list[0][1]);
        }

        function checkmrbend(idStr) {
            debugger;
            var isResult = true;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.CheckMRBEnd(idStr);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                //alert(ajax.error.Message);
                isResult = false;
            }
            return isResult;
        }

        //显示采购单数量
        function showBuyOrderList(IQCNo) {
            $("#msg").html("");
            OrderList = [];
            GRNList = [];
            $("#hdnBuyNO").val("");
            //显示供应商
            //var ajax = SKT.AjaxCommon.DBService.GetList("uspGetIqcReturnInfo", "{InspectNo:\"" + IQCNo + "\"}");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIqcReturnInfo(IQCNo);
            if (ajax.error != null) {
                Clear();
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            $("#hdnBuyNO").val(IQCNo);
            OrderList = $.parseJSON(ajax.value).data;
            GRNList = $.parseJSON(ajax.value).data1;
            
            ShowOrderList();
            ShowGRNList();
        }

        //删除送货项
        function del(i) {
            //获取改物料GRN列表
            var arr = $.grep(GRNList, function (e, j) {
                return e.POCode == OrderList[i].POCode && e.ItemCode == OrderList[i].ItemCode && e.RowID == OrderList[i].RowID;
            }, true);
            GRNList = arr;

            OrderList.splice(i, 1);
            ShowOrderList();
            if (OrderList.length == 0) {
                Clear();
            }
            ShowGRNList();
        }

        //显示送货单细项
        function ShowOrderList() {
            if (OrderList != null && OrderList.length > 0) {
                $("#<%=this.lblVendorCode.ClientID %>").text(OrderList[0].VendorCode + "  " + OrderList[0].VendorName);
                $("#txtRemark").val(OrderList[0].Auditing);
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel;
                for (var i = 0; i < OrderList.length; i++) {
                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = i + 1;
                    cel.innerHTML += "<input type='hidden' id='RowID" + i + "' value='" + OrderList[i].RowID + "'/>";

                    cel = row.insertCell(1);
                    cel.innerHTML = OrderList[i].POCode;
                    cel.id = 'tdPoCode' + i;

                    cel = row.insertCell(2);
                    cel.innerHTML = OrderList[i].ItemCode;
                    cel.id = 'tdInvCode' + i;

                    cel = row.insertCell(3);
                    cel.innerHTML = OrderList[i].ItemName;
                    cel.id = 'tdInvName' + i;

                    cel = row.insertCell(4);
                    cel.innerHTML = OrderList[i].VendorCode;

                    cel = row.insertCell(5);
                    cel.innerHTML = OrderList[i].VendorName;

                    cel = row.insertCell(6);
                    //cel.innerHTML = parseFloat(OrderList[i].ReceiveQty) + parseFloat(OrderList[i].NgQty);
                    cel.innerHTML = parseFloat(OrderList[i].ReceiveQty);

                    cel = row.insertCell(7);
                    //cel.innerHTML = OrderList[i].ReceiveQty;
                    cel.innerHTML = parseFloat(OrderList[i].OkQty);

                    cel = row.insertCell(8);
                    cel.innerHTML = parseFloat(OrderList[i].NgQty);

                    cel = row.insertCell(9);
                    cel.innerHTML = "<a href='javascript:void(0);' onclick=\"Clear()\"><font color=\"red\">移除</font></a>";
                }
            }
            else {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#tbBuyOrderDetail tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="10" align="center"><font color="red">暂无数据</font></td></tr>');
            }
        }

        //显示GRN细项
        function ShowGRNList() {
            if (OrderList != null && OrderList.length > 0) {
                $("#tblRecHistory tr:gt(0)").remove();
                var tableList = document.getElementById("tblRecHistory");
                var row, cel;
                for (var i = 0; i < GRNList.length; i++) {
                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = i + 1;

                    cel = row.insertCell(1);
                    cel.innerHTML = GRNList[i].GRN;

                    cel = row.insertCell(2);
                    cel.innerHTML = GRNList[i].ItemCode;

                    cel = row.insertCell(3);
                    cel.innerHTML = GRNList[i].ItemName;

                    cel = row.insertCell(4);
                    cel.innerHTML = GRNList[i].LotCode;

                    cel = row.insertCell(5);
                    cel.innerHTML =parseFloat(GRNList[i].TotalQty);

                    cel = row.insertCell(6);
                    cel.innerHTML = parseFloat(GRNList[i].NgQty);
                }
            }
            else {
                $("#tblRecHistory tr:gt(0)").remove();
                $("#tblRecHistory tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="8" align="center"><font color="red">暂无数据</font></td></tr>');
            }
        }

        //生成退货单
        function Save() {
            if (OrderList.length == 0) {
                alert("请添加送货项!");
                return false;
            }
            var entity = {};
            entity.ReturnFormId = -1;
            entity.InspectionNo = $("#hdnBuyNO").val();
            entity.Remark = $("#txtRemark").val(); 
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            //var ajax = SKT.AjaxCommon.DBService.Edit("upsIQCreturnSave", JSON.stringify(entity));
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveIqcReturn(JSON.stringify(entity));
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            alert("生成退货单成功");

            var enPrint = {};
            enPrint.InspectionNo = $("#hdnBuyNO").val();
            enPrint.UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName%>';
            Clear();
            //window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/PDFFilePrint.aspx?strJson=" + JSON.stringify(enPrint) 
             //   + "&SPC=uspGetIqcReturnpPrint&XML=IQCReturnForm.xml&rnd=" + Math.random());
        }

        function Clear() {
            OrderList = [];
            GRNList = [];
            ShowOrderList();
            ShowGRNList();
            $("#htnVender").val("");
            $("#txtBuyNO").val("");
            $("#hdnBuyNO").val("");
            $("#<%=this.lblVendorCode.ClientID %>").text("");
            $("#msg").html("");
        }

    </script>
</asp:Content>
