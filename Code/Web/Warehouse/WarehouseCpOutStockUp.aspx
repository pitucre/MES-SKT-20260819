<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="WarehouseCpOutStockUp.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCpOutStockUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.DN %>
            </td>
            <td class="Field2">
                <input type="hidden" value="" id="hdnDN" />
                <input type="text" id="txtDN" class="TextBox" disabled="disabled" />
                <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectSalOrder()" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td colspan="4">
                <input type="button" onclick="Save()" value="下载" style="text-align: center; margin-left: 40px; min-width: 100px">
            </td>
        </tr>
    </table>
    <table>
    </table>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        function selectSalOrder() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=119&Multiple=false&rnd=" + Math.random(), width: 550, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtDN").val(list[0][0]);
            
        }
        var Save = function () {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.SaveDN($("#txtDN").val(), userName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                alert('下载成功！');
                window.parent.closeDialog();
            }           
        };

    </script>
</asp:Content>
