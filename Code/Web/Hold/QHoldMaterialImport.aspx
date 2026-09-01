<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="QHoldMaterialImport.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.QHoldMaterialImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">物料编码号：
            </td>
            <td class="Field1">
                <input type="text" id="txtMaterialCode" class="TextBox" />
                <input type="button" class="ButtonBox" value="..." onclick="chooseMaterial()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">供应商：
            </td>
            <td class="Field1">
                <input type="text" id="txtVendorCode" class="TextBox" />
                <input type="button" class="ButtonBox" value="..." onclick="chooseVendorCode()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">DateCode(周数)：
            </td>
            <td class="Field1">
                <input type="text" id="txtDateCode" class="TextBox" />
                <input type="button" class="ButtonBox" value="..." onclick="chooseDateCode()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">批次号：
            </td>
            <td class="Field1">
                <input type="text" id="txtLotCode" class="TextBox" />
                <input type="button" class="ButtonBox" value="..." onclick="chooseLotCode()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <em>*</em>原因说明：
            </td>
            <td class="Field1">
                <input type="text" id="txtCauseDescription" class="TextArea TextBox" />
            </td>
        </tr>
        <tr>

            <td class="Label2">目标路径
            </td>
            <td class="Field2" colspan="3">
                <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" onchange="uploadFile(this.value)" />
                <asp:Button ID="btnUpload" runat="server" OnClick="Upload_Click" ClientIDMode="Static" Style="display: none;" />
                <input class="SearchButton" id="btnSave" type="button" value="查 询" onclick="QueryGRN()" />
                <input class="SearchButton" id="btnEmpty" type="button" value="清 除" onclick="Empty()" />
                OK数量：<span style="color:green;font-weight:bold;font-size:18px;" id="spOK">0</span>  NG数量：<span id="spNG" style="color:red;font-weight:bold;font-size:18px;">0</span>
            </td>
        </tr>
    </table>
    <table class="ListTable" width="100%" id="tbGRNList">
        <tr class="ListTableHeader">
            <th width="3%">序号</th>
            <th>物料条码</th>
            <th>原因说明</th>
            <th>状态</th>
            <th>错误信息</th>
            <th>操作</th>
        </tr>
    </table>
    <script type="text/javascript">
        var bomName = "";
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"
        var entityList = null;
        //保存数据
        function Save() {
            if (parseInt($("#spNG").text()) > 0) {
                alert("导入列表存在NG信息不能保存！");
                return false;
            }
            if (parseInt($("#spOK").text())<= 0) {
                alert("导入列表没有数据！");
                return false;
            }
            if ($("#txtCauseDescription").val() == "") {
                alert("请输入原因说明！");
                return false;
            }
            var List = [];
            var ShowList = [];
            for (var i = 0; i < entityList.length; i++) {
                var entityInfo = {};
                var Showentity = {};
                entityInfo.SerialNumber = entityList[i].SerialNumber;
                if (entityList[i].Cause == null) {
                    entityInfo.Cause = $("#txtCauseDescription").val();
                } else {
                    entityInfo.Cause = entityList[i].Cause;
                }
                List.push(entityInfo);

                Showentity.ObjectName = "物料";
                Showentity.ObjectCode = entityList[i].SerialNumber;
                Showentity.OperatePerson = userName;
                Showentity.OperateDateTime = getDate();
                ShowList.push(Showentity);
            }
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.SaveImportGRN(List);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            alert("保存成功");
            parent.window.load(ShowList);
            window.close();
        }

        function getDate() {
            var date = new Date();
            var seperator1 = "/";
            var seperator2 = ":";
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                    + " " + date.getHours() + seperator2 + date.getMinutes()
                    + seperator2 + date.getSeconds();
            return currentdate;
        }

        //下载模板
        function Download() {
            var filePath = '<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"QHold模板.xlsx" %>';
            return window.open(filePath);
        }
        //清空输入框
        function Empty() {
            $("#txtMaterialCode").val("");
            $("#txtVendorCode").val("");
            $("#txtDateCode").val("");
            $("#txtLotCode").val("");
            $("#txtCauseDescription").val("");
            $("#tbGRNList tr:gt(0)").remove();
        }
        //读取EXCEL数据
        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }
        //加载EXCEL数据至页面
        function LoadExcelInfo(entity) {
            var logList = '';
            var _css = 'ListTableOddRow';
            $("#tbGRNList tr:gt(0)").remove();
            entityList = entity;
            for (var i = 0; i < entity.length; i++) {
                if (i % 2 == 0) _css = 'ListTableEvenRow';
                else _css = 'ListTableOddRow';

                if (entity[i].States == "NG") {
                    logList += '<tr class="' + _css + '" bgcolor="red" style="background-color:red">';
                } else {
                    logList += '<tr class="' + _css + '">';
                }
                logList += '<td>' + (i + 1).toString() + '</td>';
                logList += '<td>' + entity[i].SerialNumber + '</td>';
                logList += '<td>' + entity[i].Cause + '</td>';
                logList += '<td>' + entity[i].States + '</td>';
                logList += '<td>' + entity[i].ErrorMessage + '</td>';
                logList += '<td><img title="删除" src="../Content/images/delete.gif" onclick=Delet(this,"' + entity[i].SignId + '")></img></td>';
                logList += '</tr>';

            }
            countNumber();
            $("#tbGRNList").append(logList);
        }
        //查询按钮事件查询数据
        function QueryGRN() {
            var itemcode = $("#txtMaterialCode").val();
            var datecode = $("#txtDateCode").val();
            var lotcode = $("#txtLotCode").val();
            var vendorcode = $("#txtVendorCode").val();
            if (itemcode == "") {
                alert("请选择物料编号！");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetQueryGRN(itemcode, datecode, lotcode, vendorcode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var logList = '';
            var _css = 'tbGRNList';
            $("#tbGRNList tr:gt(0)").remove();
            var entity = ajax.value;
            entityList = entity;
            if (entity != null && entity.length > 0) {
                for (var i = 0; i < entity.length; i++) {
                    if (i % 2 == 0) _css = 'ListTableEvenRow';
                    else _css = 'ListTableOddRow';

                    if (entity[i].States == "NG") {
                        logList += '<tr class="' + _css + '" bgcolor="red" style="background-color:red">';
                    } else {
                        logList += '<tr class="' + _css + '">';
                    }
                    logList += '<td>' + (i + 1).toString() + '</td>';
                    logList += '<td>' + entity[i].SerialNumber + '</td>';
                    logList += '<td>' + $("#txtCauseDescription").val() + '</td>';
                    logList += '<td>' + entity[i].States + '</td>';
                    logList += '<td>' + entity[i].ErrorMessage + '</td>';
                    logList += '<td><img title="删除" src="../Content/images/delete.gif" onclick=Delet(this,"' + entity[i].SignId + '")></img></td>';
                    logList += '</tr>';

                }
                countNumber();
                $("#tbGRNList").append(logList);
            }

        }

        //删除表格数据
        function Delet(obj, SignId) {
            var tab = document.getElementById("tbGRNList");
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            for (var i = 0; i < entityList.length; i++) {
                if (entityList[i].SignId == SignId) {
                    //删除json内容
                    entityList.splice(i, 1);
                    break;
                }
            }
            //重新加载
            countNumber();
        }
        //计算OK和NG的数量
        function countNumber() {
            var strInfo = JSON.stringify(entityList);
            var OKlength = strInfo.split('"OK"').length - 1;
            var NGlength = strInfo.split('"NG"').length - 1;
            $("#spOK").text(OKlength);
            $("#spNG").text(NGlength);
        }

        function chooseMaterial() {
            chooseFlag = 1;
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            chooseFlag = -9;
        }
        function chooseDateCode() {
            chooseFlag = 5;
            var itemcode = $("#txtMaterialCode").val();
            if (itemcode == '') {
                alert("请先选择物料");
                return false;
            }
            pageCondition = "ItemCode='" + itemcode + "'";

            if ($("#txtVendorCode").val() != '') {
                pageCondition += " and VendorCode='" + $("#txtVendorCode").val() + "'";
            }
            if ($("#txtLotCode").val() != "") {
                pageCondition += " and LotCode='" + $("#txtLotCode").val() + "'";
            }
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + 601 + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 370 });
        }
        function chooseVendorCode() {
            chooseFlag = 7;
            var itemcode = $("#txtMaterialCode").val();
            if (itemcode == '') {
                alert("请先选择物料");
                return false;
            }
            pageCondition = "ItemCode='" + itemcode + "'";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + 606 + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function chooseLotCode() {
            chooseFlag = 6;
            //pageCondition = "Status = 1";
            var itemcode = $("#txtMaterialCode").val();
            if (itemcode == '') {
                alert("请先选择物料");
                return false;
            }
            pageCondition = "ItemCode='" + itemcode + "'";
            if ($("#txtVendorCode").val() != '') {
                pageCondition += " and VendorCode='" + $("#txtVendorCode").val() + "'";
            }
            if ($("#txtDateCode").val() != "") {
                pageCondition += " and DateCode='" + $("#txtDateCode").val() + "'";
            }
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + 602 + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValue(list) {
            switch (chooseFlag) {
                case -9: $("#txtMaterialCode").val(list[0][2]);
                    break;
                case 5: $("#txtDateCode").val(list[0][0] == '-1' ? '' : list[0][0]);
                    break;
                case 6:
                    $("#txtLotCode").val(list[0][0] == '-1' ? '' : list[0][0]);
                    break;
                case 7:
                    $("#txtVendorCode").val(list[0][0] == '-1' ? '' : list[0][0]);
                    break;
                default:;
                    break;
            }
            chooseFlag = 0;
        }
    </script>
</asp:Content>
