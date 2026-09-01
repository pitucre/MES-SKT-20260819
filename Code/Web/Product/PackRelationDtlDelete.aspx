<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PackRelationDtlDelete.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PackRelationDtlDelete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        带<em>*</em>为必填项
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">工单号
            </td>
            <td class="Field2">
                <label id="lblOrderNo" runat="server"></label>
            </td>
            <td class="Label2">订单号
            </td>
            <td class="Field2">
                <label id="lblCustomerNo" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">数量
            </td>
            <td class="Field2">
                <label id="lblQty" runat="server"></label>
            </td>
            <td class="Label2">条码前缀
            </td>
            <td class="Field2">
                <label id="lblPrefix" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">条码后缀
            </td>
            <td class="Field2">
                <label id="lblSuffix" runat="server"></label>
            </td>
            <td class="Label2">流水号长度
            </td>
            <td class="Field2">
                <label id="lblLength" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">起始流水号
            </td>
            <td class="Field2">
                <label id="lblStartNo" runat="server"></label>
            </td>
            <td class="Label2">结束流水号
            </td>
            <td class="Field2">
                <label id="lblEndNo" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">起始客户号码<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="deleteStartNo" />
            </td>
            <td class="Label2">结束客户号码<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="deleteEndNo" disabled="disabled" />
            </td>
        </tr>
        <tr>
            <td class="Label2">删除号码个数
            </td>
            <td class="Field2" colspan="3">
                <label id="deleteQty"></label>
            </td>
        </tr>
        <tr>
            <td colspan="4" class="Field3" style="text-align: center;">
                <input id="btnDelete" type="button" value=" 删除 " onclick="Delete()">
            </td>
        </tr>
    </table>
    <div id="error-msg" style="color: #FF0000; text-align: center; padding: 5px 0px">
    </div>
    <asp:HiddenField ID="hidScopeId" runat="server" ClientIDMode="Static" Value="-1" />
    <script language="javascript" type="text/javascript">
        $(function () {
            //起始客户流水号回车、失去焦点事件
            $("#deleteStartNo").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    CalculateEndSN(true);
                    e.stopPropagation();
                }
                if (curKey == 46) {
                    $(this).val("").focus();
                }
            }).blur(function () {
                CalculateEndSN(true);
            });
        });

        //计算结束客户号码及删除个数
        function CalculateEndSN(confirm) {
            $("#deleteEndNo").val("");
            $("#deleteQty").html("");
            var prefix = $("#<%=this.lblPrefix.ClientID%>").text();        //条码前缀
            var suffix = $("#<%=this.lblSuffix.ClientID%>").text();        //条码后缀
            var deleteStartNo = $.trim($("#deleteStartNo").val());
            var serialLength = parseInt($("#<%=this.lblLength.ClientID%>").text());
            var serialStart = $("#<%=this.lblStartNo.ClientID%>").text();
            var serialEnd = $("#<%=this.lblEndNo.ClientID%>").text();
            var standardLen = prefix.length + suffix.length + serialLength;  //标准长度
            if (deleteStartNo == "") {
                $("#error-msg").html("请输入客户流水号");
                ResetStartNo(confirm);
                return false;
            }
            if (deleteStartNo.length != standardLen) {
                $("#error-msg").html("起始客户号码长度必须为" + standardLen);
                ResetStartNo(confirm);
                return false;
            }
            if (deleteStartNo.substring(0, prefix.length).toUpperCase() != prefix.toUpperCase()) {
                $("#error-msg").html("起始客户号码必须以" + prefix + '开头');
                ResetStartNo(confirm);
                return false;
            }
            if (deleteStartNo.substring(prefix.length + serialLength, standardLen).toUpperCase() != suffix.toUpperCase()) {
                $("#error-msg").html("起始客户号码必须以" + suffix + '结束');
                ResetStartNo(confirm);
                return false;
            }
            var reg = /^([0-9]*)$/;
            var serialNo = deleteStartNo.substring(prefix.length, prefix.length + serialLength);//移除前缀和后缀后的流水号
            if (!reg.test(serialNo)) {
                $("#error-msg").html("起始客户流水号移除前缀、后缀后的字符" + serialNo + "必须为数字");
                ResetStartNo(confirm);
                return false;
            }
            if (parseInt(serialNo) < parseInt(serialStart)) {
                $("#error-msg").html("起始客户流水号移除前缀、后缀后的字符" + serialNo + "必须不能小于起始流水号" + serialStart + "");
                ResetStartNo(confirm);
                return false;
            }
            if (parseInt(serialNo) > parseInt(serialEnd)) {
                $("#error-msg").html("起始客户流水号移除前缀、后缀后的字符" + serialNo + "必须不能大于结束流水号" + serialEnd + "");
                ResetStartNo(confirm);
                return false;
            }
            $("#error-msg").html("");
            $("#deleteEndNo").val(prefix + serialEnd + suffix);
            $("#deleteQty").html(parseInt(serialEnd) - parseInt(serialNo) + 1);
            return true;
        }

        //重新文本框
        function ResetStartNo(confirm) {
            if (confirm) {
                $("#deleteStartNo").val("").focus();
            }
        }

        //删除
        function Delete() {
            if ($("#deleteEndNo").val() == "") {
                return false;
            }
            //检验起始客户流水号
            if (!CalculateEndSN(false)) {
                return;
            }
            var prefix = $("#<%=this.lblPrefix.ClientID%>").text();        //条码前缀
            var suffix = $("#<%=this.lblSuffix.ClientID%>").text();        //条码后缀
            var deleteStartNo = $.trim($("#deleteStartNo").val());
            var serialLength = parseInt($("#<%=this.lblLength.ClientID%>").text());
            var serialStart = $("#<%=this.lblStartNo.ClientID%>").text();
            var serialEnd = $("#<%=this.lblEndNo.ClientID%>").text();
            var serialNo = deleteStartNo.substring(prefix.length, prefix.length + serialLength);//移除前缀和后缀后的流水号

            if (confirm("本次将删除" + prefix + serialNo + suffix + "~" + prefix + serialEnd + suffix + "条码，共" + (parseInt(serialEnd) - parseInt(serialNo) + 1) + "个，确认要删除吗？")) {
                var entity = {};
                entity.ScopeId = $("#hidScopeId").val();
                entity.SerialBegin = serialNo; //deleteStartNo;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.DeletePackRelation(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#deleteStartNo").select().focus();
                    return false;
                }
                alert("删除成功");
                parent.window.Refresh();
            }

            <%--var deleteStartNo = $.trim($("#deleteStartNo").val());
            var serialLength = $("#<%=this.lblLength.ClientID%>").text();
            var serialStart = $("#<%=this.lblStartNo.ClientID%>").text();
            var serialEnd = $("#<%=this.lblEndNo.ClientID%>").text();

            if (!deleteStartNo) {
                alert("请输入要删除的起始客户号码");
                $("#deleteStartNo").val("").focus();
                return;
            }
            var reg = /^([0-9]*)$/;
            if (!reg.test(deleteStartNo)) {
                alert("起始客户号码必须输数字格式");
                $("#deleteStartNo").val("").focus();
                return;
            }
            if (deleteStartNo.length != serialLength) {
                alert("起始客户号码长度必须为" + serialLength);
                $("#deleteStartNo").val("").focus();
                return;
            }
            if (parseInt(deleteStartNo) < parseInt(serialStart)) {
                alert("起始客户号码必须大于" + serialStart);
                $("#deleteStartNo").val("").focus();
                return;
            }
            if (parseInt(deleteStartNo) > parseInt(serialEnd)) {
                alert("起始客户号码必须小于等于" + serialEnd);
                $("#deleteStartNo").val("").focus();
                return;
            }
            if (confirm("本次将删除" + deleteStartNo + "~" + serialEnd + "范围条码，确认要删除吗？")) {
                var entity = {};
                entity.ScopeId = $("#hidScopeId").val();
                entity.SerialBegin = deleteStartNo;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.DeletePackRelation(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#deleteStartNo").val("").focus();
                    return false;
                }
                alert("删除成功");
                parent.window.Refresh();
            }--%>
        }
    </script>
</asp:Content>
