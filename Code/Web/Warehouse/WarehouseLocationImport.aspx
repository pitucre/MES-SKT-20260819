<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="WarehouseLocationImport.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLocationImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">上传路径<em>*</em>
            </td>
            <td class="Field2" style="text-align: left">
                <asp:FileUpload ID="fuPickList" runat="server" onchange="uploadFile(this.value)" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
                <input class="SearchButton" id="btnSave" type="button" value="保 存" onclick="Save()" />
                <span id="spmessinfo" style="font-weight: bold; font-size: 18px;"></span>
            </td>
        </tr>
    </table>
    <div style="height: 5px"></div>
    <table class="ListTable" width="100%" id="tbOfflineList">
        <tr class="ListTableHeader">
            <th width="3%">序号</th>
            <th>仓库编码</th>
            <th>储位编码</th>
            <th>货位编码</th>
            <th>储位名称</th>
            <th>货位名称</th>
            <th>货位类型</th>
            <th>备注</th>
            <th>是否存放产品唯一</th>
            <th>入库顺序</th>
            <th>AGV地标码</th>
            <th>是否周转箱存放货位</th>
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
                logList += '<td>' + entity[i].CWhCode + '</td>';
                logList += '<td>' + entity[i].CStoreCode + '</td>';
                logList += '<td>' + entity[i].CPosCode + '</td>';
                logList += '<td>' + entity[i].CStoreName + '</td>';
                logList += '<td>' + entity[i].CPosName + '</td>';
                logList += '<td>' + entity[i].LocationType + '</td>';
                logList += '<td>' + entity[i].Remark + '</td>';
                logList += '<td>' + entity[i].ProductIsOnly + '</td>';
                logList += '<td>' + entity[i].InOrder + '</td>';
                logList += '<td>' + entity[i].AGVLandmarkCode + '</td>';
                logList += '<td>' + entity[i].IsUniPakPos + '</td>';
                logList += '<td><img title="删除" src="../Content/images/delete.gif" onclick=Delet(this,"' + entity[i].WarehouseLocationId + '")></img></td>';
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
            var CWhCode = "";
            var CStoreCode = "";
            var CPosCode = "";
            var CStoreName = "";
            var CPosName = "";
            var Remark = "";
            var ProductIsOnly = "";
            var LocationType = "";
            $("#tbOfflineList tr:gt(0)").each(function () {
                CWhCode = $(this).find("td").eq(1).text();
                CStoreCode = $(this).find("td").eq(2).text();
                CPosCode = $(this).find("td").eq(3).text();
                CStoreName = $(this).find("td").eq(4).text();
                CPosName = $(this).find("td").eq(5).text();
                LocationType = $(this).find("td").eq(6).text();
                Remark = $(this).find("td").eq(7).text();
                ProductIsOnly = $(this).find("td").eq(8).text() == "0" ? 0 : 1;
                InOrder = $(this).find("td").eq(9).text();
                AGVLandmarkCode = $(this).find("td").eq(10).text();
                IsUniPakPos = $(this).find("td").eq(11).text() == "0" ? 0 : 1;
                entityList.push({
                    "CWhCode": CWhCode, "CStoreCode": CStoreCode,
                    "CPosCode": CPosCode, "CStoreName": CStoreName,
                    "CPosName": CPosName, "LocationType": LocationType,
                    "Remark": Remark, "ProductIsOnly": ProductIsOnly,
                    "ShiftCode": "", "InOrder": InOrder,
                    "AGVLandmarkCode": AGVLandmarkCode, "IsUniPakPos": IsUniPakPos
                });
            });

            var entity = {};
            entity.WareLocationList = JSON.stringify(entityList);
            entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspSaveImportWareLoction", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            alert("导入成功！");
            parent.window.UpdateList();
        }
    </script>
</asp:Content>
