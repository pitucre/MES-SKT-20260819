<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="StorageCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.StorageCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style>
em
{
    color:Red;
    margin-left:2px;
}
</style>
    <div class="client-center">
        <!--采集信息入口-->
        <div style="marign: 0 auto; text-align: center; padding: 15px 0px 15px 0px; font-size: 14px; ">
            <span style="border: 1px solid #ccc; height: 30px; line-height: 30px; margin-left: 5px; margin-bottom:5px;
                width: 350px;  border-radius:4px; padding:5px 10px 5px 10px;;"><input type="radio" name="rdoOutType" value="1" checked="true" />
            按卡板入库&nbsp;&nbsp;&nbsp;<input type="radio" name="rdoOutType" value="2" />
            按卡通箱入库&nbsp;&nbsp;&nbsp;<input type="radio" name="rdoOutType" value="3" />
            按产品入库</span>
        </div>
        <table id="tabTmplContent" class="EditeContentTable" style="width: 100%; margin-bottom: 10px;">
            <tr>
                <td class="Label1" align="right">
                    库位条码<em>*</em>
                </td>
                <td class="Field1">
                    <input type="text" id="txtBarCode" name="BarCode" class="ui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="Label1" align="right">
                    包装条码<em>*</em>
                </td>
                <td class="Field1">
                    <input type="text" id="txtTurnOver" name="TurnoverNO" class="ui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="Label1" align="right">
                    入库总数&nbsp;&nbsp;
                </td>
                <td class="Field1">
                    <label id="totalQuntity" style="font-size: 16px">
                        0</label>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; <span
                            class="Label1">&nbsp;入库单号&nbsp;</span> <span id="InStorageNumber" style="font-size: 16px">
                            </span>
                </td>
            </tr>
            <tr>
                <td class="Field1" colspan="2" style="text-align: center;">
                    <img id="Img1" src="../Content/images/CleareData.png" onclick="clearContent();" alt=""
                        title="重载" style="cursor: pointer;" />
                    <img id="RevierSave" src="../Content/images/saveData.png" onclick="saveToStorage();"
                        alt="" title="保存" style="cursor: pointer;" />
                </td>
            </tr>
        </table>
        <!--数据分析统计展示及操作区-->
        <table class="ListTable" id="tabTurnOverList">
            <tr class="ListTableHeader" style="height:30px;">
                <th scope="col">
                    工单
                </th>
                <th scope="col">
                    产品编号
                </th>
                <th scope="col">
                    产品名称
                </th>
                <th scope="col">
                    包装条码
                </th>
                <th scope="col">
                    包装数量
                </th>
                <th scope="col">
                    库位条码
                </th>
                <th scope="col">
                    操作
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="7" style="text-align: center;">
                    暂无数据
                </td>
            </tr>
        </table>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info" style="display: none;">
            <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <input type="hidden" id="hdnStorageID" value="-1" />
    <script language="javascript" type="text/javascript">
        var resourceId = $("#hdnCurrResourceId").val();
        var stationId = $("#hdnCurrStationId").val();

        $(document).ready(function () {
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('Storage_ProCollectionUI');
                },
                10
            );

            /*库位条码验证*/
            $("#txtBarCode").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    CheckSBarCode();
                }
            });

            $("#txtTurnOver").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {


                    if ($.trim($(this).val()) == "") {
                        this.focus();
                        return;
                    }
                    
                    /*检测包装箱*/
                    if (CheckTurnOver() == false) {
                        return false;
                    }
                    
                    /*检测库位*/
                    if (CheckSBarCode() == false) {
                        return false;
                    }

                    /*检测当前产线是否有未关闭的入库单*/
                    CheckStorageList();

                    /*插入入库表*/
                    PutInStorage();

                    /*刷新table*/
                    showTable();

                }
            });
        });

        /*检测库位*/
        function CheckSBarCode() {
            var cBarCode = $("#txtBarCode").val().replace(/(^\s*)|(\s*$)/g, "");
            if (cBarCode == "") {
                alert("库位码不能为空！");
                $("#txtBarCode").focus();
                return false;
            }
            var ajaxClientSave = SKT.LeanMES.Web.AjaxServices.AjaxStorage.CheckScrapInStorage(cBarCode);
            if (ajaxClientSave.error != null) {
                alert(ajaxClientSave.error.Message, "Error:");
                $("#txtBarCode").val("");
                $("#txtBarCode").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxClientSave.error.Message);
                return false;
            }
            $("#txtTurnOver").focus();
            return true;
        }

        /*检测包装箱*/
        function CheckTurnOver() {
            var Code = $("#txtTurnOver").val();
            var ajaxClientSave = SKT.LeanMES.Web.AjaxServices.AjaxStorage.CheckContainerSN(Code);
            if (ajaxClientSave.error != null) {
                alert(ajaxClientSave.error.Message);
                $("#txtTurnOver").val("");
                $("#txtTurnOver").focus();
                $("#txtTurnOver").focus("");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxClientSave.error.Message);
                return false;
            }
           
            if (ajaxClientSave.value == 1) {
                alert("此条码不存在!");
                $("#txtTurnOver").val("");
                return false;
            }
            else if (ajaxClientSave.value == 2) {

                if (parseInt($("#hdnStorageID").val()) == -1) {

                    parseInt($("#hdnStorageID").val(GetStorageID(Code)));                    
                    showTable();
                    $("#txtTurnOver").val("");
                    $("#txtBarCode").focus("");
                    return false;
                }
                else {
                    if (GetStorageID(Code) == $("#hdnStorageID").val()) {
                        alert("已扫描！");
                    }
                    else {
                        alert("此条码不属于本批扫描，如需扫描请按重载！");
                    }
                    $("#txtTurnOver").val("");
                    // $("#txtBarCode").val("");
                    $("#txtTurnOver").focus();
                    return false;
                }

            }
            else if (ajaxClientSave.value == 3) {
                alert("条码已入库！");
                $("#txtTurnOver").val("");
                $("#txtTurnOver").focus();
                return false;
            }
            else if (ajaxClientSave.value == 4) {
                alert("空箱(周转工具)不能入库！");
                $("#txtTurnOver").val("");
                $("#txtTurnOver").focus();
                return false;
            }

            return true;
        }

        /* 通过SN获取库存表ID（SN 可为栈板、包装箱、产品SN）*/
        function GetStorageID(Code) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStorage.GetStorageID(Code);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return -1;
            }
            return ajax.value;
        }

        /*检测当前产线是否有未关闭的入库单*/
        function CheckStorageList() {
            var storageId = parseInt($("#hdnStorageID").val());
            
            //不存在扫描包装条码
            if (storageId == -1) {
                var ajaxClient = SKT.LeanMES.Web.AjaxServices.AjaxStorage.CheckStorageOrder(resourceId);
                if (ajaxClient.error != null) {
                    alert(ajaxClient.error.Message);
                    $("#txtTurnOver").val("");
                    $("#txtTurnOver").focus();
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajaxClient.error.Message);
                    return false;
                }
                if (parseInt(ajaxClient.value) > 0) {
                    storageId = ajaxClient.value == "-1" ? -1 : ajaxClient.value;
                    $("#hdnStorageID").val(storageId);
                    showTable();
                    if (confirm('是否需要将当前产品添加至该入库单！')) {
                        return true;
                    } else {
                        $("#hdnStorageID").val("-1");
                    }
                }
            }
        }

        /*插入入库表*/
        function PutInStorage() {
            var BarCode = $.trim($("#txtBarCode").val());
            var SerialNumber = $.trim($("#txtTurnOver").val());
            var StorageID = $("#hdnStorageID").val();
            var scanType = $('input[name="rdoOutType"]:checked ').val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStorage.PutInStorage(StorageID, SerialNumber, BarCode, scanType, resourceId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtTurnOver").val("");
                $("#txtTurnOver").focus();
                $("#InStorageNumber").html("");
                $("#totalQuntity").html("0");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, SerialNumber, ajax.error.Message);
                return false;
            }

            if (StorageID == -1) {
                var StorageID = GetStorageID(SerialNumber);
                $("#hdnStorageID").val(StorageID);
            }

            $("#txtTurnOver").val("");
            $("#txtTurnOver").focus();
        }

        /*加载显示包装信息*/
        function showTable() {
            clearTable();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStorage.GetStorageMember(parseInt($("#hdnStorageID").val()));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtTurnOver").val("");
                $("#txtBarCode").val("");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }

            if (ajax.value.length <= 0) {                
                return false;
            }

            $("#trNewInfo").empty().remove();
            var trHtml = "";
            var entity = ajax.value;
            var totalQuqnlity = 0;
            for (var i = 0; i < entity.length; i++) {
                trHtml = "<td align='center' class='turnOverNumber'>" + entity[i].OrderNo + "</td><td  align='center'>" + entity[i].ItemCode + "</td><td>" + entity[i].ItemName
            + "</td><td  align='center'>" + entity[i].SerialNumber + "</td><td  align='center' class='turnOverQty'>" + entity[i].StorageQty + "</td><td  align='center' class='turnOverBarCode'>"
             + entity[i].BarCode + "</td><td align='center' > <a href=\"javascript:void(0)\"  onclick=\"deleteItems(" + entity[i].StorageMemberID + ")\" > 删除</a></td>";
                $("#tabTurnOverList").append('<tr class="ListTableOddRow">' + trHtml + '</tr>');
                totalQuqnlity += entity[i].StorageQty
            }

            $("#InStorageNumber").html(ajax.value[0].StorageNumber);

            calculateTotalQuntity();
        }

        function calculateTotalQuntity() {
            var obj = $(".turnOverQty");
            var totalQuqnlity = 0;
            for (var i = 0; i < obj.length; i++) {
                totalQuqnlity += parseInt($(obj[i]).html());
            }
            $("#totalQuntity").html(totalQuqnlity);
        }

        //清空表数据
        function clearTable() {
            $("#tabTurnOverList tr:not(:first)").each(function () {
                $(this).remove();
            });
            var rightStr = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='7' style='text-align:center;'>暂无数据</td></tr>";
            $(rightStr).appendTo($("#tabTurnOverList"));
        }

        function clearContent() {
            $("#InStorageNumber").html("");
            $("#totalQuntity").html("0");
            $("#hdnStorageID").val('-1');
            clearTable();
            $("#txtTurnOver").val("");
            $("#txtBarCode").val("");
            $("#txtBarCode").focus();
        }

        /*删除行*/
        function deleteItems(storageMemberID) {
            if (confirm('是否删除当前入库扫描信息？')) {
                var ajaxResult = SKT.LeanMES.Web.AjaxServices.AjaxStorage.PutInStorageDelete(storageMemberID);
                if (ajaxResult.error != null) {
                    alert(ajaxResult.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajaxResult.error.Message);
                }
                /*重新加载表格*/
                showTable();
                calculateTotalQuntity();
            }
        }

        //保存良品入库信息
        function saveToStorage() {
            var StorageID = $("#hdnStorageID").val();
            if (StorageID == '-1') {
                alert("请扫描货位与产品！");
                return false;
            }

            var ajaxResult = SKT.LeanMES.Web.AjaxServices.AjaxStorage.SaveToStorage(StorageID, resourceId, stationId);

            if (ajaxResult.error != null) {
                alert(ajaxResult.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxResult.error.Message);
                return;
            }
            alert("成品入库成功!");
            clearContent();

        }
    </script>
</asp:Content>
