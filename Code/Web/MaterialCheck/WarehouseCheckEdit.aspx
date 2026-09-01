<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="WarehouseCheckEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckEdit" %>


<%@ MasterType VirtualPath="~/Masters/ViewMaster.master" %>
<asp:Content ID="Content3" ContentPlaceHolderID="viewcontent" runat="Server">
    <style>
        #divProductSummaryInfo {
            font-size: 14px;
        }
    </style>
    <div>
        <%--查询模块--%>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">盘点处理方式</td>
                <td class="Field2">
                    <asp:DropDownList runat="server" ID="ddlChangeHandle" ClientIDMode="Static">
                        <asp:ListItem Value="1">盘亏，数量为0处理</asp:ListItem>
                        <asp:ListItem Value="2">正常，盘点后数量为系统数量处理</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    <%= Resources.lang.WarehouseCheckList %>
                </td>
                <td class="Field2">
                    <input type="hidden" value="" id="hdnDN" />
                    <input type="text" id="txtCheckNo" class="TextBox" disabled="disabled" style="width: 370px" />
                    <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectCheckOrder()" />
                </td>
            </tr>
            <tr>
                <td class="Label2">备注</td>
                <td class="Field2">
                    <textarea style="width: 370px" class="TextArea" id="txtRemark"></textarea>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div>
        <div class="divHeader">差异清单</div>
        <div class="EditeContentTable" id="infotab" width="100%">
        </div>
    </div>
    <div class="clear5">
    </div>
    <div id="msg" style="text-align: center; font-size: 14px">
    </div>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var handleStyle = 1;//盘点处理方式
        var CheckListNo = "";//盘点单
        var OrderDetailList = []; //盘点单明细
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

        $(function () {
            $("#ddlChangeHandle").change(function () {
                handleStyle = $("#ddlChangeHandle").find(":selected").val();
                if (CheckListNo != "") {
                    CheckDifferenceList(CheckListNo);
                }
            });
        });

        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#txtQty").focus();
            }
        });
        $("#txtQty").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                if ($("#txtGRN").val() == '') {
                    alert("请扫描GRN");
                    return false;
                    $("#txtGRN").focus();
                }
                isPositiveNum(this);
                //SavePlus();
            }
        });
        function SavePlus() {
            if (CheckListNo == '' || typeof (CheckListNo) == 'undefined') {
                alert("请选择盘点单");
                return false;
            }
            var Remark = $("#txtRemark").val();
            if (confirm("是否完成平帐?")) {
                for (var i = 0; i < $("#infotab tbody tr").length; i++) {
                    var stockQty = $($("#infotab tr:gt(0)")[i]).find("input").val();
                    OrderDetailList[i].NowQty = stockQty;
                }
                var entity = {};
                entity.CheckOrder = CheckListNo;
                entity.UpdateBy = userName + "||" + handleStyle; //平帐时 通过更新人截取
                entity.Flag = 2; //平帐
                entity.Remark = Remark;
                entity.TbDtl = JSON.stringify(OrderDetailList);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.SaveCheckOrder(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("平帐完成");
                window.location.reload();
            }
        }
        function selectCheckOrder() {
            var searchCondition = " CheckOrderStatus in (4)"; // 复盘完成可以平帐
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=200&PageCondition= " + searchCondition + "&Multiple=false&CallBackFunc=setCheckCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setCheckCode(list) {
            $("#txtCheckNo").val(list[0][1] + "|" + list[0][2]);
            CheckListNo = list[0][1];
            OrderDetailList = [];
            CheckDifferenceList(CheckListNo);
            $("#txtGRN").focus();
        }
        function CheckDifferenceList(CheckListNo) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.CheckDifferenceList(CheckListNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            $("#infotab").html("");
            var htmlstr = "<table width='100% ' class='ContentTabl'><thead><tr class='ListTableHeader'>"
                + "<th>行号</th><th>GRN</th><th>物料编码</th><th>物料名称</th><th>物料规格</th>"
                + " <th>仓库</th><th>库位条码</th><th>账面数量</th><th>初盘数量</th><th>初盘人</th><th>初盘时间</th>"
                 + " <th>复盘数量</th><th>复盘人</th><th>复盘时间</th><th>盈亏</th><th>平帐数量</th>"
                              + "</tr></thead>";
            var list = ajax.value;
            //排序
            list = list.sort(function (a, b) {
                return (a.NowQty - a.StockQty) - (b.NowQty - b.StockQty);
            });
            var j = 0;
            for (var i = 0; i < list.length; i++) {
                /* if (list[i].PZBy != null || (list[i].BalanceQty - list[i].NowQty) == 0) {
                     continue;
                 }*/

                //获取平帐数量
                var value = 0; //盈亏数量
                var grnResultQty = 0; //平帐数量
                var firstQty = list[i].StockQty; //初盘数量
                var repeatQty = list[i].NowQty;//复盘数量
                handleStyle = $("#ddlChangeHandle").find(":selected").val();
                if (firstQty == 0 && repeatQty == 0) {
                    if (handleStyle == 1) { //盘亏处理
                        grnResultQty = 0
                        value = grnResultQty - list[i].BalanceQty;
                    } else {
                        grnResultQty = list[i].BalanceQty;
                        value = grnResultQty - list[i].BalanceQty;
                    }
                } else {
                    if (repeatQty == 0) {
                        grnResultQty = firstQty;
                        value = grnResultQty - list[i].BalanceQty;
                    } else {
                        grnResultQty = repeatQty;
                        value = grnResultQty - list[i].BalanceQty;
                    }
                }
                //获取盘点单明细信息
                OrderDetailList.push({ "GRN": list[i].GRN, "NowQty": grnResultQty });

                j = j + 1;
                //盈亏处理  1:盘亏 2：正常

                if (i % 2 == 0) {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td>" + j + "</td>"
                        + "<td>" + list[i].GRN + "</td>"
                        + "<td>" + list[i].ItemCode + "</td>"
                        + "<td>" + list[i].ItemName + "</td>"
                        + "<td>" + list[i].ItemSpec + "</td>"
                        + "<td>" + list[i].Warehouse + "</td>"
                        + "<td>" + list[i].BarCode + "</td>"
                        + "<td>" + list[i].BalanceQty + "</td>"
                        + (list[i].FirstBy == "" ? "<td></td>" : "<td>" + list[i].StockQty + "</td>")
                      //  + "<td>" + list[i].StockQty + "</td>"
                        + "<td>" + list[i].FirstBy + "</td>"
                        + "<td>" + list[i].FirstTime + "</td>"
                        + (list[i].RepeatBy == "" ? "<td></td>" : "<td>" + list[i].NowQty + "</td>")
                       // + "<td>" + list[i].NowQty + "</td>"
                        + (list[i].RepeatBy == "" ? "<td></td>" : "<td>" + list[i].RepeatBy + "</td>")
                        + (list[i].RepeatTime == "" ? "<td></td>" : "<td>" + list[i].RepeatTime + "</td>")
                + (value == 0 ? "<td >" + value + "</td>" : value > 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                + "<td><input type='text' id='ChangeQty" + list[i].GRN + "' value='" + grnResultQty + "' onchange = isPositiveNum(this) /></td>"
                + "</tr>";
            }
            $("#infotab").html(htmlstr + "</table>");
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
        }
    </script>
</asp:Content>
