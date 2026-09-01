<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialStorageWriteLocation.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialStorageWriteLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                检验单单号
            </td>
            <td class="Field1">
                <asp:Label ID="txtBatchNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                全部入库
            </td>
            <td class="Field1">
                <input type="checkbox" id="checkAll" onclick="onCheck();" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                入库数量
            </td>
            <td class="Field1">
                <input id="txtPAQty" type="text" class="TextBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                请输入库位
            </td>
            <td class="Field1">
                <input id="txtWarehouse" type="text" class="TextBox"   />
            </td>
        </tr>
        <tr>
            <td class="Field1" colspan="2" style="text-align: center;">
                <input id="Button3" type="button" value="保存入库" onclick="changeBarCode();" />
            </td>
        </tr>
    </table>
    <div style="width: 100%; color: Red; text-align: center" id="Message">
    </div>
    <div class="clear5">
    </div>
    <div style="display: none">
        <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
            width: 100%; overflow: auto; border-collapse: collapse;" id="tbPackLevel">
            <tr class="ListTableHeader">
                <th scope="col" align="center">
                    入库数量
                </th>
                <th scope="col" align="center">
                    入库库位
                </th>
                <th scope="col" align="center">
                    扫描时间
                </th>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        var InsId = '<%=Request.QueryString["ID"] %>';
        var tab = document.getElementById("tbPackLevel");
        var StorageQty = 0; //需要入库的数量
        var ToQty = 0; //已扫描数量
        var List = [];
        $(document).ready(function () {
            $("#txtWarehouse").focus();
            $('#checkAll').attr("checked", "checked");
            getIQCStorageQty(); //获取    IQC检验单号和入库数量

            //input 事件焦点设定
            $('input').click(function () {
                this.blur();
                this.focus();
            });
        });
        //全部入库选择框改变事件
        function onCheck() {
            if ($("#checkAll").is(':checked')) {
                $("#txtPAQty").val(StorageQty);
                $('#txtPAQty').attr("readonly", "readonly"); //将input元素设置为readonly
            }
            else {
                $("#txtPAQty").removeAttr("readonly"); //去除input元素的readonly属性
            }
        }
        //获取    IQC检验单号和入库数量
        function getIQCStorageQty() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIQCStorageQty(InsId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            var en = $.parseJSON(ajax.value);

            if (en.data[0].InspectionNo != "") {
                $("#<%=this.txtBatchNo.ClientID %>").text(en.data[0].InspectionNo);
            }
            if (en.data[0].StorageQty != "") {
                $("#txtPAQty").val(en.data[0].StorageQty);
                StorageQty = en.data[0].StorageQty;
            }
        }

        //库位条码改变事件
        function changeBarCode() {
            var txtWarehouse = $("#txtWarehouse").val();
            if (txtWarehouse == "") {
                alert("请输入库位条码");
                $("#txtWarehouse").val("");
                $("#txtWarehouse").focus();
                return;
            }

            if (isNaN($("#txtPAQty").val())) {
                alert("入库数量格式填写错误");
                $("#txtPAQty").val(0);
                $("#txtPAQty").focus();
                return;
            }

            //检验库位条码是否正确
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(txtWarehouse);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var en = $.parseJSON(ajax.value);
            if (!en.BarCode) {
                alert("库位条码不存在");
                $("#txtWarehouse").focus();
                $("#txtWarehouse").val("");
                return;
            }
            ToQty = $("#txtPAQty").val();
            var entity = {};
            entity.InspectionId = InsId;
            entity.StorageQty = ToQty;
            entity.CBarCode = $("#txtWarehouse").val();
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveIQCGRNStorageQty(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("入库成功");
            parent.window.refresh();
        }

        function Save() {
            if (!window.confirm("确定保存？")) {
                return "";
            }
            var cBarCode = $("#")

            var entity = {};
            entity.InspectionId = InsId;
            entity.StorageQty = ToQty;
            entity.cBarCode = $("#txtWarehouse").val();
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveIQCGRNStorageQty(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功");
            parent.window.refresh();
        }

        //清除已扫描的GRN
        function clearGRN() {
            if (!window.confirm("确定清除？")) {
                return "";
            }
            $("#tbPackLevel  tr:not(:first)").each(function (index) {
                tab.deleteRow(1);
            });
            List = [];
            ToQty = 0;
            $("#txtPAQty").val(StorageQty.toString());
            $("#Message").html("清除成功");
        }
    </script>
</asp:Content>
