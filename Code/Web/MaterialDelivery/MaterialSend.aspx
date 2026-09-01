<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialSend.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.MaterialSend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%=Resources.lang.LineName%><em>*</em>
            </td>
            <td class="Field2">
                <input type="text" value="" id="txtLine" class="TextBox" disabled="disabled"/>
                <input type="button" id="btnLine" class="ButtonBox" value="..." onclick="SelectLine();"  />
                <asp:HiddenField ID="hdfLine" Value="0" runat="server" />
            </td>
            <td class="Label2">
                <%=Resources.lang.PickCode%><em>*</em>
            </td>
            <td class="Field2">
                <input type="text" value="" id="txtPick" class="TextBox" disabled="disabled"/>
                <input type="button" id="btnPick" class="ButtonBox" value="..." onclick="SelectPick();"/>
                <asp:HiddenField ID="hdfPick" Value="-1" runat="server" />
            </td>
        </tr>

        <tr>
            <td class="Label2">
                GRN条码<em>*</em>
            </td>
            <td class="Field1" colspan="3">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width:97%; height: 25px;
                    font-size: 13.5px;text-transform: uppercase;" />
                <input type="button" id="btnSave" class="ButtonBox" value="..." title="" style="height: 27px;"
                    onclick="CheckGRN();" />
            </td>
        </tr>
    </table>

    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div class="clear5">
    </div>

<!--分拣单明细-->
<div style="float:left;width:29%;height:auto; overflow:auto">
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            分拣单：<span id="spanPickNO"></span>
        </div>
    </div>
    <table class="ListTable" width="100%" id="tbPickDetail">
        <tr class="ListTableHeader">
            <th style="width:60%">
                物料编号
            </th>
            <th style="width:20%">
                需求数量
            </th>
            <th style="width:20%">
                发出数量
            </th>
        </tr>
    </table>
</div>

<!--已发物料-->
<div style="float:right;width:69%;height:auto; overflow:auto">
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            已扫物料
        </div>
    </div>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <tr class="ListTableHeader">
            <th>
                物料GRN
            </th>
        </tr>
    </table>
</div>

<div class="clear5">
</div>

    <script type="text/javascript">
        var temp = 0;
        var pickId = -1;
        var lineId = -1;
        var sending = 0; // 1 发料中
        var sendDetailXml = ""; //发料明细
        var sumRequestQty = 0;  //总需求数量
        var sumSendQty = 0;     //总发料数量
        var isSended = false; // 已发料
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";

        $(function () {
            /*扫描GRN包装箱/GRN条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    CheckGRN();
                }
            });
        });

        //检查所扫GRN是否满足条件
        function CheckGRN() {
            var grn = $.trim($("#txtGRN").val());
            if (grn == "") {
                $("#msg").html("请扫描GRN!");
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                return false;
            }

            if (lineId <= 0) {
                $("#msg").html("请选择产线!");
                $("#msg").css("color", "red");
                return false;
            }

            if (pickId <= 0) {
                $("#msg").html("请选择分捡单!");
                $("#msg").css("color", "red");
                return false;
            }


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery.CheckGRN(grn, lineId, pickId);
            if (ajax.error != null) {
                $("#txtGRN").val('').focus();
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }

            TSGRN(ajax.value[0], ajax.value[1], grn);
        }

        function Save() {
            if (isSended) {
                alert("该分拣单已发料！");
                return false;
            }

            if (sumRequestQty > sumSendQty) {
                $("#msg").html("该分拣单的所需物料，没有发料完成！");
                $("#msg").css("color", "red");
                return false;
            }

            sendDetailXml = "<SendDetail>" + sendDetailXml + "</SendDetail>";

            $("#msg").html("正在发料，请稍后...");
            $("#msg").css("color", "");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery.SendMaterial(sendDetailXml, lineId, pickId, userName);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }
            else {

                sending = 0;
                isSended = true;
                $("#msg").html("发料成功!");
                $("#msg").css("color", "green");
                    
            }
        }

        /*选择产线*/
        function SelectLine() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 400, height: 300 });
        }

        /*选择分捡单*/
        function SelectPick() {
            if (sending == 1 && !confirm("当前存在未保存的发料信息。如果改变分拣单，未保存的发料信息将被清除！是否要改变？")) {
                return false;
            }

            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=53&Multiple=false&rnd=" + Math.random(), width: 400, height: 300 });
        }

        function getChooseValue(list) {
            if (temp == 1) {
                $("#txtLine").val(list[0][1]);
                $("#<%=this.hdfLine.ClientID %>").val(list[0][0]);
                lineId = list[0][0];
                $("#txtGRN").focus();     
            }
            else if (temp == 2) {
                $("#txtPick").val(list[0][1]);
                $("#<%=this.hdfPick.ClientID %>").val(list[0][0]);
                $("#spanPickNO").html(list[0][1]);
                pickId = list[0][0];
                $("#txtGRN").focus();

                setTimeout("selectPickAfter()", 100);
            }
        }

        //分拣单选择之后，获取分拣单明细。
        function selectPickAfter() {

            $("#tbPickDetail tr:gt(0)").remove();
            $("#tblRecHistory tr:gt(0)").remove();
            isSended = false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery.GetPickDetailList(pickId);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }

            var list = ajax.value;
            if (list == null || list.length == 0) {
                return false;
            }

            var html = "";

            for (var i = 0; i < list.length; i++) {

                html += "<tr class='ListTableOddRow'>";
                html += "<td >" + list[i].ItemCode + "<input type='hidden' name='hdnPickItemId' value='" + list[i].ItemId + "'/>" + "<input type='hidden' name='hdnPickDetailId' value='" + list[i].PickSubId + "'/></td>";
                html += "<td >" + list[i].Quantity + "</td>";
                html += "<td >0</td>";
                html += "</tr>";

                sumRequestQty += list[i].Quantity;
            }


            $("#tbPickDetail").append(html);


        }

        //暂存发料GRN  页面更新分拣单发料信息。
        function TSGRN(itemid, qty, grn) {

            $("[name='hdnPickItemId']").each(function (i, e) {
                if ($(e).val() == itemid) {
                    if (parseFloat($(e).parent().next().text()) <= parseFloat(qty)) {
                        $("#msg").html("此物料的发料数量已经达到需求数量！无需再发！");
                        $("#msg").css("color", "red");
                        return false;
                    } else {

                        $(e).parent().next().next().text(parseFloat($(e).parent().next().next().text()) + parseFloat(qty));
                        sumSendQty += qty;
                        sending = 1;
                        sendDetailXml += "<Data>";
                        sendDetailXml += "<DetailId>" + $(e).next().val() + "</DetailId>";
                        sendDetailXml += "<ItemId>" + itemid + "</ItemId>";
                        sendDetailXml += "<Qty>" + qty + "</Qty>";
                        sendDetailXml += "<GRN>" + grn + "</GRN>";
                        sendDetailXml += "</Data>";
                        $("#tblRecHistory").append("<tr class='ListTableOddRow'><td>" + grn + "</td></tr>");
                        return false;
                    }
                }
            })



        }
    </script>
</asp:Content>
