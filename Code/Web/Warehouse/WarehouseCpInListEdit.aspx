<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCpInListEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCpInListEdit"
    Title="Edit WarehouseCpInListEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr id="configname">
            <td class="Label2">
                库位
            </td>
            <td class="Field2" style="min-width: 250px">
                <asp:TextBox ID="txtReuestOrder" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false"></asp:TextBox>
                <input id="button2" class="ButtonBox" type="button" onclick="onChoosePage()" value="..." />
            </td>
        </tr>
        <tr>
            <td>

            </td>
          <td colspan="4">
              <input type="button" onclick="InStock()" value="入库" style="text-align:center;margin-left:40px;min-width:100px">
          </td>
        </tr>
    </table>
    <script type="text/javascript">
                var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var check = '<%=Request.QueryString["ID"]%>';//sn列表
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.GetConfigType("2");
        var entity = ajax.value;
                //选择库位
        function onChoosePage() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=117&Multiple=false&CallBackFunc=getChooseValue&rnd=" + Math.random(), width: 700, height: 380
            });
        }
        function getChooseValue(list) {
            barcode = list[0][3];
            requestOrder = list[0][1]; //领料单号
            requestId = list[0][0];
            $("#ContentPlaceHolder1_EditContent_txtReuestOrder").val(list[0][3]);
        }

        function InStock() {
            if (entity == 0) {
                alert("请在PDA端进行入库操作！");
                return false;
            }
            if ($("#ContentPlaceHolder1_EditContent_txtReuestOrder").val() == "") {
                alert("请选择库位");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.InStock(check, barcode, userName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                alert("入库成功");
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
