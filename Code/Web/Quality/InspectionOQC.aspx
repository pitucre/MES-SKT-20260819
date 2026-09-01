<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="InspectionOQC.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionOQC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label Tips" align="left" colspan="6">
                <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" />请选择对应的出货单号。
            </td>
        </tr>
        <tr>
            <td class="Label2">
                出货单号<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtBuyNO" class="TextBox" />
                <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectOrder()" />
            </td>
            <td class="Label2">
                单据类型
            </td>
            <td class="Field2">
                <asp:Label ID="lblOrderType" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                单据日期
            </td>
            <td class="Field2">
                <asp:Label ID="lblDate" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                客户编码
            </td>
            <td class="Field2">
                <asp:Label ID="lblCusCode" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label Tips" align="left" colspan="6">
                <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" />请扫描产品序列号或送检批次号。
            </td>
        </tr>
        <tr>
            <td class="Label2">
               产品序列号<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" value="" id="txtSN" class="TextBox" style="width: 250px; height: 25px;
                    font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
            <td class="Label2">
               送检批次号<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" value="" id="txtBatch" class="TextBox" style="width: 250px; height: 25px;
                    font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>
        <tr>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            出货单明细
        </div>
    </div>
    <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px">
        <tr class="ListTableHeader">
            <th style="width: 10%">
                行号
            </th>
            <th style="width: 20%">
                产品编码
            </th>
            <th style="width: 30%">
                产品名称
            </th>
            <th style="width: 10%">
                批号
            </th>
            <th style="width: 10%">
                数量
            </th>
            <th style="width: 10%">
                抽检数量
            </th>
            <th style="width: 10%">
                扫描数量
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="7" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            已扫描SN列表
        </div>
    </div>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <tr class="ListTableHeader">
            <th>
                产品序列号
            </th>
            <th>
                产品编码
            </th>
            <th>
                产品名称
            </th>
            <th>
                送检批号
            </th>
            <th>
                创建时间
            </th>
        </tr>
        <tr id="trLast" class="ListTableOddRow">
            <td colspan="5" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div id="tblInfo">
    </div>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var deliverOrder = ""; //出货单
        var OrderList = []; //出货单细项列表
        var SnList = []; //SN列表
        $(function () {
            $("#txtBuyNO").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    if ($.trim($("#txtBuyNO").val()) != "") {
                        //回车只显示GRN信息   
                        deliverOrder = $.trim($("#txtBuyNO").val());
                        showOrderDelList(-1, deliverOrder);
                    }
                    return false;
                }
            });

            /*扫描产品序列号*/
            $("#txtSN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtSN").val()) != "") {
                        showSNList($.trim($("#txtSN").val()), "");
                        return false;
                    } else {
                        alert("请扫描产品序列号！");
                        $("#txtSN").focus();
                        $("#txtSN").select();
                        return false;
                    }
                }
            });
            /*扫描送检批号*/
            $("#txtBatch").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtBatch").val()) != "") {
                        showSNList("", $.trim($("#txtBatch").val()))
                        return false;
                    } else {
                        alert("请扫描送检批号！");
                        $("#txtBatch").focus();
                        $("#txtBatch").select();
                        return false;
                    }
                }
            });
        });

        //选中出货单列表
        function selectOrder() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=87&CallBackFunc=setBuyValue&Multiple=false&rnd=" + Math.random(), width: 550, height: 368
            });
        }

        function setBuyValue(list) {
            $("#txtBuyNO").val(list[0][1]);
            $("#<%=this.lblOrderType.ClientID %>").text(list[0][2]); //单据类型
            $("#<%=this.lblDate.ClientID %>").text(list[0][3]); //单据日期
            $("#<%=this.lblCusCode.ClientID %>").text(list[0][4]); //客户编码
            showOrderDelList(list[0][0], "");
        }

        //显示出货单明细
        function showOrderDelList(id, code) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetInspectionOQC(id, code);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            $("#msg").html("");
            $("#msg").css("color", "");

            var entity = $.parseJSON(ajax.value).data;
            GetOrderDelList(entity);
        }

        function GetOrderDelList(entity) {
            if (entity != null && entity.length > 0) {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#trNewInfo").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel

                $("#txtBuyNO").val(entity[0].Code);
                $("#<%=this.lblOrderType.ClientID %>").text(entity[0].RdType); //单据类型
                $("#<%=this.lblDate.ClientID %>").text(entity[0].Date); //单据日期
                $("#<%=this.lblCusCode.ClientID %>").text(entity[0].CusCode); //客户编码

                for (var i = 0; i < entity.length; i++) {
                    OrderList.push(entity[i]);
                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = i + 1;
                    cel.innerHTML += "<input type='hidden' id='RowID" + i + "' value='" + entity[i].AutoID + "'/>";

                    cel = row.insertCell(1);
                    cel.innerHTML = entity[i].ItemCode;

                    cel = row.insertCell(2);
                    cel.innerHTML = entity[i].ItemName;

                    cel = row.insertCell(3);
                    cel.innerHTML = entity[i].Batch;

                    cel = row.insertCell(4);
                    cel.innerHTML = entity[i].Qty;

                    cel = row.insertCell(5);
                    cel.innerHTML = entity[i].InspectionQty;

                    cel = row.insertCell(6);
                    cel.innerHTML = entity[i].FinishQty;
                }
            }
            else {
                clearTableInfo();
                $("#msg").html("出货单号不存在或已经备货");
                $("#msg").css("color", "red");
            }
        }

        //扫描产品序列号或送检批号
        function showSNList(txtSn, txtBatch) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetInspectionOQCSN(txtSn, txtBatch);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtSN").val("");
                $("#txtBatch").val("");
                return false;
            }
            $("#msg").html("");
            $("#msg").css("color", "");

            var en = $.parseJSON(ajax.value).data;

            //添加
            var index = -1;
            $.grep(SnList, function (o, j) {
                if (o.SerialNumber === SerialNumber) {
                    index = j;
                }
            });
            if (index === -1) {
                GetSNInfo(en);
                SnList.push(en);
            }
            $("#txtSN").val("");
            $("#txtBatch").val("");
        }

        /*通过SN获取物料信息*/
        function GetSNInfo(en) {
            if (en != null && en.length > 0) {
                $("#msg").html("");
                $("#msg").css("color", "");

                var strHtml = "";
                strHtml += "<tr class='ListTableOddRow'>";
                strHtml += "<td>" + en[0].SerialNumber + "</td>";
                strHtml += "<td>" + en[0].ItemCode + "</td>"
                        + "<td>" + en[0].ItemName + "</td>"
                        + "<td>" + en[0].InspectionNo + "</td>"
                        + "<td>" + en[0].CreateTime + "</td>";
                strHtml += "</tr>";

                $("#tblRecHistory tr:not(:first)").each(function () {
                    $(this).remove();
                });
                if ($("#tblRecHistory tr").length == 1) {
                    $("#tblRecHistory tr:eq(0)").after(strHtml)
                }
                else {
                    $("#tblRecHistory tr:eq(1)").before(strHtml)
                }
            }
            else {
                $("#tblRecHistory tr:gt(0)").remove();
                $("#tblRecHistory tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="5" align="center"><font color="red">暂无数据</font></td></tr>');
            }
        }

        //抽检完成
        function Save() {
            var deliverCode = $("#hdnBuyNO").val();
            if (deliverCode == "") {
                alert("出货单号不能为空!");
                return false;
            }

            if (confirm('确定收料?')) {
                //更新送货单收货数量
                var DeliverDtlId = "";
                var ReceiveQty = ""; //收货数量
                $("#tbBuyOrderDetail tr:not(:first)").each(function () {
                    DeliverDtlId += $(this).children("td:eq(0)").find('input').val() + ",";
                    ReceiveQty += $(this).children("td:eq(4)").find('input').val() + ",";
                });

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive.SaveReceiveMaterial(deliverCode, $("#level").val(), DeliverDtlId, ReceiveQty);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }

                $("#msg").html("收料成功!");
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
            var rightStr = "<tr id='trLast' class='ListTableOddRow'><td colspan='5' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr).appendTo($("#tblRecHistory"));
            $("#tbBuyOrderDetail tr:not(:first)").each(function () {
                $(this).remove();
            });
            var rightStr1 = "<tr id='trLast' class='ListTableOddRow'><td colspan='7' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr1).appendTo($("#tbBuyOrderDetail"));
            OrderList = [];
            SnList = [];
            $("#txtBuyNO").val("");
            $("#<%=this.lblOrderType.ClientID %>").text(""); //单据类型
            $("#<%=this.lblDate.ClientID %>").text(""); //单据日期
            $("#<%=this.lblCusCode.ClientID %>").text(""); //客户编码
        }
    </script>
</asp:Content>
