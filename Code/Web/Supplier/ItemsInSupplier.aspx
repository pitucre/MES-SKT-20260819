<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ItemsInSupplier.aspx.cs" Inherits="SKT.LeanMES.Web.Supplier.ItemsInSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                供应商
            </td>
            <td class="Field1">
                <asp:Label ID="lblRoleName" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label5" runat="server" Text="物料"></asp:Label>
            </td>
            <td class="Label" style="width: 10%; text-align: center;">
            </td>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label6" runat="server" Text="供应商的物料"></asp:Label>
            </td>
        </tr>
        <tr style="height: 300px; padding: 2px;" valign="top">
            <td class="Field" align="center" style="width: 45%; vertical-align: top;">
                <div id="loadingmessages1" class="Tips">
                    数据加载中...</div>
                <iframe name="frmItemChooseList" id="frmItemChooseList" frameborder="0" style="width: 99%;
                    height: 300px;" src=""></iframe>
            </td>
            <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                <input type="button" id="btnLeftChoose" runat="server" value=" >> " class="SearchButton"
                    onclick="btnChooseOnClick(0);" />
                <br />
                <br />
                <br />
                <br />
                <input type="button" id="btnRightChoose" runat="server" value=" << " class="SearchButton"
                    onclick="btnChooseOnClick(1);" />
            </td>
            <td class="Field" align="center" style="width: 45%; vertical-align: top;">
                <div id="loadingmessages2" class="Tips">
                    数据加载中...</div>
                <iframe name="frmSuplierItemList" id="frmSuplierItemList" frameborder="0" style="width: 99%;
                    height: 300px;" src=""></iframe>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var SupplierId = '<%= Request.QueryString["ID"] %>';
        $(function () {
            var iframe1 = document.getElementById("frmItemChooseList");
            iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Supplier/ItemChooseList.aspx?ID=<%= Request.QueryString["ID"] %>';
            if (iframe1.attachEvent) {
                iframe1.attachEvent("onload", function () {
                    $("#loadingmessages1").html("");
                });
            }
            else {
                iframe1.onload = function () {
                    $("#loadingmessages1").html("");
                };
            }
            var iframe2 = document.getElementById("frmSuplierItemList");
            iframe2.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Supplier/SupplierItemsList.aspx?ID=<%= Request.QueryString["ID"] %>';
            if (iframe2.attachEvent) {
                iframe2.attachEvent("onload", function () {
                    $("#loadingmessages2").html("");
                });
            }
            else {
                iframe2.onload = function () {
                    $("#loadingmessages2").html("");
                };
            }
        });
        function loadingcompleted() {
            $("#loadingmessages1").html("");
        }
        function btnChooseOnClick(index) {
            if (SupplierId == null || SupplierId == "") {
                alert("获取供应商失败");
                return false;
            }
            var UserIdString;
            var UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            if (index == 0) {
                UserIdString = document.frames[0].window.getSelectedValues();
            }
            else {
                UserIdString = document.frames[1].window.getSelectedValues();
            }
            if (UserIdString == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return false;
            }
            /*分配用户给供应商*/
            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxItemsInSupplier.AssignItemsToSuplier(SupplierId, UserIdString, UserName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
            }
            else {/*从供应商中删除用户*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxItemsInSupplier.RemoveItemsFromSuplierint(SupplierId, UserIdString, UserName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
            }
            document.frames[0].window.document.forms[0].submit();
            document.frames[1].window.document.forms[0].submit();
        }
    </script>
</asp:Content>
