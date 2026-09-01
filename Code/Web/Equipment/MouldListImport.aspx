<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MouldListImport.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldListImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">上传路径<em>*</em>
            </td>
            <td class="Field2" style="text-align: left">
                <asp:FileUpload ID="fuPickList" runat="server" onchange="uploadFile(this.value)" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
               <%-- <input class="SearchButton" id="btnSave" type="button" value="保 存" onclick="Save()" />--%>
                <span id="spmessinfo" style="font-weight: bold; font-size: 18px;"></span>
            </td>
        </tr>
    </table>
    <div style="height: 5px"></div>
    <table class="ListTable" width="100%" id="tbOfflineList">
        <tr class="ListTableHeader">
            <th width="3%">序号</th>
            <th>模具编码</th>
            <th>模具名称</th>
            <th>客户名称</th>
            <th>供应商</th>
            <th>当前位置</th>
            <th>公司</th>
            <th>入厂日期</th>
            <th>MODEL</th>
            <th>标准使用寿命</th>
            <th>累计使用寿命</th>
            <th>机台吨位</th>
            <th>模具吨位</th>
            <th>尺寸</th>
            <th>模具形式</th>
            <th>模穴数</th>
            <th>模具＃次</th>
            <th>厂家模具编码</th>
            <th>厂家模具名称</th>
            <th>操作</th>
        </tr>
    </table>
    <%--   </div>--%>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        var entityList = [];
        function uploadFile(filePath) {
            var index = layer.load(2, { shade: false });
            $("#spmessinfo").text("正在加载中...");
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);
                    __doPostBack(str, '');
                } else {
                    return false;
                }
            }
        }

        function countNumber() {
            var strInfo = JSON.stringify(entityList);
        }

        function Delet(obj, SignId) {
            var tab = document.getElementById("tbOfflineList");
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            //重新加载
            countNumber();
        }

        function ShowOfflineGRN(entity) {
            var index = layer.load(2, { shade: false });
            $("#spmessinfo").text("正在加载中...");
            setTimeout(function () {
                load(entity);
            }, 500);
        }

        function load(entity) {
            var logList = '';
            var _css = 'ListTableOddRow';
            $("#tbOfflineList tr:gt(0)").remove();


            for (var i = 0; i < entity.length; i++) {
                if (i % 2 == 0) _css = 'ListTableEvenRow';
                else _css = 'ListTableOddRow';

                logList += '<tr class="' + _css + '" id=' + (i + 1) + '>';
                logList += '<td>' + (i + 1).toString() + '</td>';
                logList += '<td class="EquipmentCode">' + entity[i].EquipmentCode + '</td>';
                logList += '<td class="EquipmentName">' + entity[i].EquipmentName + '</td>';
                logList += '<td class="CustomName">' + entity[i].CustomName + '</td>';
                logList += '<td class="SupplierName">' + entity[i].SupplierName + '</td>';
                logList += '<td class="WarehouseLocation">' + entity[i].WarehouseLocation + '</td>';
                logList += '<td class="Company">' + entity[i].Company + '</td>';
                logList += '<td class="FactoryDate">' + entity[i].FactoryDate + '</td>';
                logList += '<td class="Model">' + entity[i].Model + '</td>';
                logList += '<td class="UseCount">' + entity[i].UseCount + '</td>';
                logList += '<td class="StandarLive">' + entity[i].StandarLive + '</td>';
                logList += '<td class="MachineTonnage">' + entity[i].MachineTonnage + '</td>';
                logList += '<td class="MoldTonnage">' + entity[i].MoldTonnage + '</td>';
                logList += '<td class="Size">' + entity[i].Size + '</td>';
                logList += '<td class="Matrix">' + entity[i].Matrix + '</td>';
                logList += '<td class="Cavity">' + entity[i].Cavity + '</td>';
                logList += '<td class="MoldTimes">' + entity[i].MoldTimes + '</td>';
                logList += '<td class="FactoryMouldCode">' + entity[i].FactoryMouldCode + '</td>';
                logList += '<td class="FactoryMouldName">' + entity[i].FactoryMouldName + '</td>';
                logList += '<td><img title="删除" src="../Content/images/delete.gif" onclick=Delet(this,"' + entity[i].Id + '")></img></td>';
                logList += '</tr>';

            }
            $("#tbOfflineList").append(logList);
            $("#spmessinfo").text("加载完毕...");
            layer.closeAll();
            setTimeout(function () {
                $("#spmessinfo").text("");
            }, 4000);
        }

        function Save() {
            var EquipmentCode = "";
            var EquipmentName = "";
            var CustomName = "";
            var SupplierName = "";
            var WarehouseLocation = "";
            var Company = "";
            var FactoryDate = "";
            var Model = "";
            var UseCount = "";
            var StandarLive = "";
            var MachineTonnage = "";
            var MoldTonnage = "";
            var Size = "";
            var Matrix = "";
            var Cavity = "";
            var MoldTimes = "";
            $("#tbOfflineList tr:gt(0)").each(function () {
                EquipmentCode = $(this).find(".EquipmentCode").text();
                EquipmentName = $(this).find(".EquipmentName").text();
                CustomName = $(this).find(".CustomName").text();
                SupplierName = $(this).find(".SupplierName").text();
                WarehouseLocation = $(this).find(".WarehouseLocation").text();
                Company = $(this).find(".Company").text();
                FactoryDate = $(this).find(".FactoryDate").text();
                Model = $(this).find(".Model").text();
                UseCount = $(this).find(".UseCount").text();
                StandarLive = $(this).find(".StandarLive").text();
                MachineTonnage = $(this).find(".MachineTonnage").text();
                MoldTonnage = $(this).find(".MoldTonnage").text();
                Size = $(this).find(".Size").text();
                Matrix = $(this).find(".Matrix").text();
                Cavity = $(this).find(".Cavity").text();
                MoldTimes = $(this).find(".MoldTimes").text();
                FactoryMouldCode = $(this).find(".FactoryMouldCode").text();
                FactoryMouldName = $(this).find(".FactoryMouldName").text();
                entityList.push({
                    "EquipmentCode": EquipmentCode,
                    "EquipmentName": EquipmentName,
                    "CustomName": CustomName,
                    "SupplierName": SupplierName,
                    "WarehouseLocation": WarehouseLocation,
                    "Company": Company,
                    "FactoryDate": FactoryDate,
                    "Model": Model,
                    "UseCount": UseCount,
                    "StandarLive": StandarLive,
                    "MachineTonnage": MachineTonnage,
                    "MoldTonnage": MoldTonnage,
                    "Size": Size,
                    "Matrix": Matrix,
                    "Cavity": Cavity,
                    "MoldTimes": MoldTimes,
                    "FactoryMouldCode": FactoryMouldCode,
                    "FactoryMouldName": FactoryMouldName
                });
            });


            if (entityList.length > 0) {
                var entity = {};
                entity.EquipmentMoudle = JSON.stringify(entityList);
                entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspSaveImportEquipmentMoudle", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message)
                    return false;
                }
                alert("导入成功！");
                parent.window.UpdateList("");
            } else {
                alert("请选择模板导入数据！");
            }
        }
    </script>
</asp:Content>
