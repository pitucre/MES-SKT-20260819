<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="StandardOfflineImportGRN.aspx.cs" Inherits="SKT.LeanMES.Web.Material.StandardOfflineImportGRN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                上传路径<em>*</em>
            </td>
            <td class="Field2" style="text-align: left">
                <asp:FileUpload ID="fuPickList" runat="server"   onchange="uploadFile(this.value)"/>
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
                <input class="SearchButton" id="btnSave" type="button" value="保 存" onclick="Save()" />
                <span id="spmessinfo" style="font-weight:bold;font-size:18px;"></span>
            </td>
            <td class="Field2" colspan="2">
                OK数量：<span style="color:green;font-weight:bold;font-size:18px;" id="spOK">0</span>  NG数量：<span id="spNG" style="color:red;font-weight:bold;font-size:18px;">0</span>
            </td>
        </tr>
    </table>
    <div style="height:5px"></div>
    <%--<div id=""test" style="overflow:scroll;height:400px">--%>
    <table class="ListTable" width="100%" id="tbOfflineList">
        <tr class="ListTableHeader">
            <th width="3%">序号</th>
            <th>GRN</th>
            <th>数量</th>
            <th>采购单号</th>
            <th>供应商编号</th>
            <th>供应商名称</th>
            <th>物料编码</th>
            <th>明细ID</th>
            <th>批次号</th>
            <th>生产日期</th>
            <th>DateCode(周数)</th>
            <th>MPN</th>
            <th>状态</th>
            <th>错误信息</th>
            <th>操作</th>
        </tr>
    </table>
<%--   </div>--%>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        var entityList = null;
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
            var OKlength = strInfo.split('"OK"').length - 1;
            var NGlength = strInfo.split('"NG"').length - 1;
            $("#spOK").text(OKlength);
            $("#spNG").text(NGlength);
        }

        function Delet(obj, SignId) {
            var tab = document.getElementById("tbOfflineList");
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

        function ShowOfflineGRN(entity) {
            var index = layer.load(2, { shade: false });
            $("#spmessinfo").text("正在加载中...");
            setTimeout(function () {
                load(entity);
            }, 500);
        }

        function load(entity) {
            entityList = entity;
            var logList = '';
            var _css = 'ListTableOddRow';
            $("#tbOfflineList tr:gt(0)").remove();

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
                logList += '<td>' + entity[i].Qty + '</td>';
                logList += '<td>' + entity[i].PoCode + '</td>';
                logList += '<td>' + entity[i].VendorCode + '</td>';
                logList += '<td>' + entity[i].VendorName + '</td>';
                logList += '<td>' + entity[i].ItemCode + '</td>';
                logList += '<td>' + entity[i].RowId + '</td>';
                logList += '<td>' + entity[i].LotCode + '</td>';
                logList += '<td>' + entity[i].DateCode + '</td>';
                logList += '<td>' + entity[i].WeekCode + '</td>';
                logList += '<td>' + entity[i].MPN + '</td>';
                logList += '<td>' + entity[i].States + '</td>';
                logList += '<td>' + entity[i].ErrorMessage + '</td>';
                logList += '<td><img title="删除" src="../Content/images/delete.gif" onclick=Delet(this,"' + entity[i].SignId + '")></img></td>';
                logList += '</tr>';

            }
            $("#tbOfflineList").append(logList);
            countNumber();
            $("#spmessinfo").text("加载完毕...");
            layer.closeAll();
            setTimeout(function () {
                $("#spmessinfo").text("");
            }, 4000);
        }

        function Save() {
            if (parseInt($("#spNG").text()) > 0) {
                alert("导入列表存在NG信息不能保存！");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveImportGRN(entityList);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            alert("导入成功！");
            document.forms[0].submit();
        }
    </script>
</asp:Content>
