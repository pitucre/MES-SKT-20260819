<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="OutStorageCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.OutStorageCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div style="marign: 0 auto; text-align: center; padding: 15px 0px 10px 0px; font-size: 14px; background-color:#F7F7F7;">
            <div style="border: 1px solid #ccc; height: 30px; line-height: 30px; margin-left: 5px; margin-bottom:5px;
                width: 350px; float: left;border-radius:4px;">
                <input type="radio" name="rdoOutType" value="1" checked="true" />
                按卡板出库&nbsp;&nbsp;&nbsp;<input type="radio" name="rdoOutType" value="2" />
                按卡通箱出库&nbsp;&nbsp;&nbsp;<input type="radio" name="rdoOutType" value="3" />
                按产品出库</div>
            <div style=" float:right; margin-right:50px;">
                <b>走货单号码：</b></span>
                <input id='txtSoCode' type='text' class="ui-textbox" /><input type="button" id="Button1"
                    class="ButtonBox" value="..." title="走货单号码" onclick="SelectSoCode();" />
            </div>
            <div style="clear:both"></div>
        </div>
        <table class="ListTable" id="moldDataCollect" style="margin-bottom: 10px;">
            <tbody>
                <tr class="ListTableHeader" style="height: 30px;">
                    <th align="center" style="width: 80px;">
                        序号
                    </th>
                    <th align="center" style="width: 140px;">
                        产品编码
                    </th>
                    <th align="center">
                        产品描述
                    </th>
                    <th align="center" style="width:120px;">
                        计划走货数量
                    </th>
                    <th align="center" style="width:120px;">
                        已走货数量
                    </th>
                    <th align="center" style="width: 190px;">
                        产品条码/卡通箱条码/卡板条码<em></em>
                    </th>
                    <th align="center" style="width:120px;">
                        已扫描数量
                    </th>
                </tr>
                <tr class="ListTableOddRow T" id="noMoldDataCollect" style="display: ;">
                    <td style="text-align: center;" colspan="7">
                        暂无数据
                    </td>
                </tr>
            </tbody>
        </table>
        <table class="EditeContentTable" id="tbDataCollect" width="100%">
            <tbody>
                <tr>
                    <td class="Label1">
                        货柜车牌号码:
                    </td>
                    <td class="Field1">
                        <input class="ui-textbox" id="txtCarNum" type="text" style="width: 170px;" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        走货备注:
                    </td>
                    <td class="Field1">
                        <input class="ui-textbox" id="txtRemark" type="text" style="width: 170px;" />
                    </td>
                </tr>
                <tr style="display:none">
                    <td class="Label1">
                        走货照片/视频:
                    </td>
                    <td class="Field1" colspan="3">
                        <input type="file" id="uploadify" name="uploadify" />
                        <div id="fileQueue">
                        </div>
                        <label id="lblProgramUrl">
                        </label>
                        <input type="hidden" id="hidFileUrl" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                    </td>
                    <td colspan="3" class="Field1">
                        &nbsp;<input type="button" id="btnOutStorage" value="出 库" onclick="OutStorage()"
                            style="width: 90px; height: 25px;">
                    </td>
                </tr>
            </tbody>
        </table>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info" style="display: none;">
            <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        var resourceId = $("#hdnCurrResourceId").val();
        var stationId = $("#hdnCurrStationId").val();
        var soFlag = 0;

        $(document).ready(function () {
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('OutStorage_ProCollectionUI');
                },
                10
            );

                $("#txtSoCode").keydown(function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;

                    if (curKey == 13) {
                        GetSoOrderInfo($.trim(this.value));
                        GetCarInfo($.trim(this.value))
                        //return false;
                    }
                    if (curKey == 46) {
                        $("#txtSoCode").val("");
                    }
                });
        });

        function Reset() {
            $("input[type=text]").val("");
            $("select").val("-1");
            $("label").text("");
        }

        function GetSoOrderInfo(soCode) {
            var list = SKT.LeanMES.Web.AjaxServices.AjaxStorage.GetAllSoOrderInfo(soCode);

            if (list.error != null) {
                alert(list.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", list.error.Message);
                soFlag = 0;
                $("#noMoldDataCollect").show();
                $(".ListTableOddRow:gt(0)").remove();
                return false;
            }
            else {
                var row, cell;
                var entityAry = list.value;
                var entity = {};
                var flage = "";
                var setTable = document.getElementById("moldDataCollect");
                if (entityAry.length > 0) {
                    soFlag = 1;
                    $("#noMoldDataCollect").hide();
                    $(".ListTableOddRow:gt(0)").remove();

                    /***动态创建表***/
                    for (var i = 0; i < entityAry.length; i++) {
                        entity = entityAry[i];
                        row = setTable.insertRow(setTable.rows.length);
                        row.className = "ListTableOddRow";

                        cell = row.insertCell(0);
                        cell.align = "center";
                        cell.innerHTML = i + 1;

                        cell = row.insertCell(1);
                        cell.align = "center";
                        cell.innerHTML = entity.ItemCode;

                        cell = row.insertCell(2);
                        cell.align = "left";
                        cell.innerHTML = entity.Description;

                        cell = row.insertCell(3);
                        cell.align = "center";
                        var lblTurnQty = "<label id='lblTurnQty" + entity.ItemId + "' >" + entity.TurnQty + "</label>";
                        cell.innerHTML = lblTurnQty;

                        cell = row.insertCell(4);
                        cell.align = "center";
                        var qty = parseInt(entity.TurnQty) - parseInt(entity.OutQty)
                        var lblOutQty = "<label id='lblOutQty" + entity.ItemId + "' >" + entity.OutQty + "</label><label style='display:none;' id='lblBalanceQty" + entity.ItemId + "' >" + qty + "</label>";
                        cell.innerHTML = lblOutQty;

                        cell = row.insertCell(5);
                        cell.align = "center";
                        var scanStr = "<input type='text' name='scanSN' id='" + entity.ItemId + "'  style='width:170px;'  class='ui-textbox'/>";
                        cell.innerHTML = scanStr;

                        cell = row.insertCell(6);
                        cell.align = "center";
                        var scanNumStr = "<label id='lblScanNum" + entity.ItemId + "' >0</label>";
                        cell.innerHTML = scanNumStr;
                    }

                    $("input[name=scanSN]").keydown(function (e) {
                        var curKey = 0, e = e || window.event;
                        curKey = e.keyCode || e.which || e.charCode;

                        if (curKey == 13) {
                            ScanSN(this.id);
                        }
                        if (curKey == 46) {
                            $("#txtSoCode").val("");
                        }
                    });
                }
                else {
                    $(".ListTableOddRow:gt(0)").remove();
                    $("#noMoldDataCollect").show();
                    $("#txtCarNum").val("");
                    $("#ddlFtpId").val("-1");
                    $("#hidFileUrl").val("");
                    $("#txtRemark").val("");
                }
            }
        }
        var chooseFlag = 0;
        //选择工单
        function SelectSoCode() {
            chooseFlag = 1;
            dialog({ title: '走货单列表', src: "../Framework/ChoosePage.aspx?PageId=111&&CallBackFunc=SetSoCode&Multiple=false&rnd=" + Math.random(), width: 400, height: 300 });
        }

        function SetSoCode(list) {
            if (chooseFlag == 1) {
                $("#txtSoCode").val(list[0][2]);
                GetSoOrderInfo(list[0][2]);
                GetCarInfo(list[0][2]);
            }
            chooseFlag = 0;
        }

        function ScanSN(id) {
            var sn = $.trim($("#" + id).val());
            var scanType = $('input[name="rdoOutType"]:checked ').val();
            var balanceQty = $.trim($("#lblBalanceQty" + id).text());

            var soCode = $.trim($("#txtSoCode").val());
            if (sn == "") {
                return;
            }
            if (balanceQty <= 0) {
                alert('已超出计划出库数量!');
                return;
            }

            var ajaxResult = SKT.LeanMES.Web.AjaxServices.AjaxStorage.ProductOutStorage(sn, scanType, id, parseInt(balanceQty), soCode, stationId, resourceId);
            if (ajaxResult.error != null) {
                alert(ajaxResult.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, sn, ajaxResult.error.Message);
                $("#" + id).val("");
                return false;
            }
            else {
                //返回数量

                var count = parseInt(ajaxResult.value);
                //计划数量
                var trunQty = parseInt($("#lblTurnQty" + id).text());
                //出库数量
                var outQty = parseInt($("#lblOutQty" + id).text());
                //扫描数量
                var scanNum = parseInt($("#lblScanNum" + id).text());

                $("#lblOutQty" + id).text(outQty + count);
                $("#lblScanNum" + id).text(scanNum + count);
                $("#lblBalanceQty" + id).text(trunQty - outQty - count)

                $("#" + id).val("");
            }

        }

        function GetCarInfo(soCode) {
            var list = SKT.LeanMES.Web.AjaxServices.AjaxStorage.GetOutStorageCarInfo(soCode);

            if (list.error != null) {
                alert(list.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", list.error.Message);
                return false;
            }

            if (list.value != null) {
                $("#txtCarNum").val(list.value.CarNum);
                $("#hidFileUrl").val(list.value.FileUrl);
                $("#lblProgramUrl").text(list.value.FileUrl);
                $("#txtRemark").val(list.value.Remark);
            }
        }

        function OutStorage() {
            var soCode = $.trim($("#txtSoCode").val());
            var carNum = $.trim($("#txtCarNum").val());
            var fileUrl = $.trim($("#hidFileUrl").val());
            var remark = $.trim($("#txtRemark").val());
            if (soCode == "") {
                alert('请选择走货单号码!');
                $("#txtSoCode").focus();
                return;
            }
            if (soFlag == 0) {
                alert('请选择走货单号码!');
                $("#txtSoCode").focus();
                return;
            }

            var entity = {};
            entity.SOCode = soCode;
            entity.CarNum = carNum;
            entity.FileUrl = fileUrl;
            entity.Remark = remark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStorage.OutStorageCarEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            else {
                alert('出库成功！');
            }
        }
    </script>
</asp:Content>
