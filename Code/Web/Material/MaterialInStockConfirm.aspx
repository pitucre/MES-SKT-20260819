<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialInStockConfirm.aspx.cs"
    MasterPageFile="~/Masters/ViewMaster.master" Inherits="SKT.LeanMES.Web.Material.MaterialInStockConfirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label Tips" align="left" colspan="6">
                <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" />
                <label id="showMsg" class="infoTips">
                    <span>请选择对应的IQC检验单!</span>
                </label>
            </td>
        </tr>
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2">
                IQC检验单号<em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="hdnIQCNo" />
                <input type="text" id="txtIQCNo" class="TextBox" /><input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectIQCOrder()" />
            </td>
            <td class="Label2">
                优先级
            </td>
            <td class="Field2">
                <asp:Label ID="lblUrgentLevel" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                物料编码
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemCode" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                交接数量
            </td>
            <td class="Field2">
                <asp:Label ID="lblCheckQty" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Field2" colspan="4" style="text-align: center;">
                <input id="Button2" type="button" value="交接确认" onclick="if (SubmitValidation()){SaveCondfirm();}" />
            </td>
        </tr>
    </table>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            IQC检验单明细
        </div>
    </div>
    <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px">
        <tr class="ListTableHeader">
            <th style="width: 10%">
                行号
            </th>
            <th style="width: 20%">
                IQC检验单号
            </th>
            <th style="width: 20%">
                物料编码
            </th>
            <th style="width: 30%">
                物料名称
            </th>
            <th style="width: 10%">
                处理结果
            </th>
            <th style="width: 10%">
                合格
            </th>
            <th style="width: 10%">
                优先级
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="7" style="text-align: center;">
                <span>暂无数据</span>
            </td>
        </tr>
    </table>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            已扫描物料条码列表
        </div>
    </div>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <tr class="ListTableHeader">
            <th>
                物料条码
            </th>
            <th>
                物料编码
            </th>
            <th>
                物料名称
            </th>
            <th>
                批次号
            </th>
            <th>
                数量
            </th>
        </tr>
        <tr id="trLast" class="ListTableOddRow">
            <td colspan="5" style="text-align: center;">
                <span>暂无数据</span>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div id="tblInfo">
    </div>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.material.js?v=12"
        type="text/javascript"></script>
    <script type="text/javascript">

        var chooseIQCId = -1; //选中的IQC检验单
        var List = [];
        $(function () {

            //是否进行IQC检验 IsStorageConfirm   是否进行IQC交接确认IsIQCHandoverConfirm
            if (IsStorageConfirm == 2) { //入库不需要交期确认
                $("input").attr("disabled", true);
                $("#showMsg").html("不需要交接确认,请知悉!");
            }
            else {
                if (IsIQCHandoverConfirm == 2) {
                    $("input").attr("disabled", true);
                    $("#showMsg").html("不需要交接确认,请知悉!");
                } else
                {
                    $("#showMsg").html(mesLang("请选择对应的IQC检验单!)"));
                }
            }

            //IQC检验单号回车事件
            $("#txtIQCNo").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    var val = $.trim($(this).val());
                    if (val != "") {
                        showIQCAndIQCDetail(true);
                    }
                    return false;
                }
            });
        });
        $("#ddlIQCStatus").bind("change", function () {
            var chooseIqcResult = $(this).val();
            if (chooseIqcResult == 4) { //挑选
                $("#showChooseSome").show();
                getGrnBackInfo();
            }
            else {
                $("#showChooseSome").hide();
            }
        });

        function selectIQCOrder() {
            //var searchCondition = " ManageResult <> 0  ";
            //BirongLiang 2016-12-26
            var searchCondition = "Status =2 and isnull(VerifyBy,'') <> '' and ( InspectionResult =1 OR  (ManageResult <> 2 AND MRBStatus= 3))";//Status =2已检验，VerifyBy <> '' 是检验已审核 (ManageResult <> 2 AND MRBStatus= 3)MRB处理通过且已审核
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=77&CallBackFunc=setBuyValue&Multiple=false&PageCondition=" + escape(searchCondition) + "&rnd=" + Math.random(), width: 720, height: 380
            });
        }

        function setBuyValue(list) {
            chooseIQCId = list[0][0];
            if (list[0][0].trim() === '-1') return false;
            $("#txtIQCNo").val(list[0][1]);
            $("#hdnIQCNo").val(list[0][1]);
            $("#lblUrgentLevel").text(list[0][2]);
            $("#lblCheckQty").text(parseFloat(list[0][10]));
            $("#lblItemCode").text(list[0][5]);
            //显示单据明细和物料条码明细
            showIQCAndIQCDetail(false);
        }

        function showIQCAndIQCDetail(isEnter) {
            var insepctionNo = $("#txtIQCNo").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetShowIQCConfirmDetail(insepctionNo);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            $("#msg").html("");
            $("#msg").css("color", "");
            var entity = $.parseJSON(ajax.value).data;
            if (isEnter) {
                $("#txtIQCNo").val(entity[0].InspectionNo);
                $("#hdnIQCNo").val(entity[0].InspectionNo);
                $("#lblUrgentLevel").text(entity[0].UrgentName);
                $("#lblCheckQty").text(parseFloat(entity[0].QualifiedQty));
                $("#lblItemCode").text(entity[0].ItemCode);
            }
            var entityGRN = $.parseJSON(ajax.value).data1;
            //显示IQC订单明细信息
            GetOrderDelList(entity);
            //显示IQC物料信息
            GetGRNInfo(entityGRN);
        }

        //显示IQC订单明细
        function GetOrderDelList(entity) {
            if (entity != null && entity.length > 0) {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#trNewInfo").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel

                for (var i = 0; i < entity.length; i++) {

                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = i + 1;

                    cel = row.insertCell(1);
                    cel.innerHTML = entity[i].InspectionNo;

                    cel = row.insertCell(2);
                    cel.innerHTML = entity[i].ItemCode;

                    cel = row.insertCell(3);
                    cel.innerHTML = entity[i].ItemName;

                    cel = row.insertCell(4);
                    cel.innerHTML = entity[i].CheckType;

                    cel = row.insertCell(5);
                    cel.innerHTML = parseFloat(entity[i].QualifiedQty);

                    cel = row.insertCell(6);
                    cel.innerHTML = entity[i].UrgentName;
                }
            }
            else {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#tbBuyOrderDetail tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="10" align="center"><font color="red">暂无数据</font></td></tr>');
            }
        }

        /*通过GRN获取物料信息*/
        function GetGRNInfo(list) {
            if (list != null && list.length > 0) {
                $("#msg").html("");
                $("#msg").css("color", "");

                if (list == null || list.length == 0) {
                    return false;
                }
                $("#trLast").remove();
                var strHtml = "";
                for (var i = 0; i < list.length; i++) {
                    strHtml += "<tr class='ListTableOddRow'>";
                    strHtml += "<td>" + list[i].SerialNumber + "</td>";
                    strHtml += "<td>" + list[i].ItemCode + "</td>"
                        + "<td>" + list[i].ItemName + "</td>"
                        + "<td>" + list[i].LotCode + "</td>"
                        + "<td>" + parseFloat(list[i].BalanceQty) + "</td>";
                    strHtml += "</tr>";


                }
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
                $("#tblRecHistory tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="10" align="center"><font color="red">暂无数据</font></td></tr>');
            }
        }


        //保存交接数据
        function SaveCondfirm() {
            var insepctionNo = $("#txtIQCNo").val();
            if (insepctionNo == "") {
                alert("请选择IQC检验单!");
                return false;
            }
            if (confirm('确定交接？')) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveIQCConfirmDetail(insepctionNo);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                $("#msg").html("");
                $("#msg").css("color", "");
                alert("交接确认成功!");
                clearTableInfo();
            }
        }

        //清空列表
        function clearTableInfo() {
            $("#tblRecHistory tr:not(:first)").each(function () {
                $(this).remove();
            });
            $("#tblInfo").html("");
            var rightStr = "<tr id='trLast' class='ListTableOddRow'><td colspan='10' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr).appendTo($("#tblRecHistory"));
            $("#tbBuyOrderDetail tr:not(:first)").each(function () {
                $(this).remove();
            });
            var rightStr1 = "<tr id='trLast' class='ListTableOddRow'><td colspan='10' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr1).appendTo($("#tbBuyOrderDetail"));

            $("#txtIQCNo").val("");
            $("#hdnIQCNo").val("");
            $("#lblUrgentLevel").html("");
            $("#lblItemCode").html("");
            $("#lblCheckQty").html("");
        }
    </script>
</asp:Content>
