<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="StockListAddReplaceItemStandard.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.StockListAddReplaceItemStandard" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">排产工单
            </td>
            <td class="Field1">
                <asp:Label ID="lblPlanOrder" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">主料
            </td>
            <td class="Field1">
                <asp:Label ID="lblMainItemCode" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">站位
            </td>
            <td class="Field1">
                <asp:Label ID="lblPosition" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">替代料<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" ReadOnly="true" CssClass="TextBox" IsRequired="1" ClientIDMode="Static">
                </asp:TextBox><input type="button" id="Button1" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnItemCode" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var planOrderNo = '<%=Request.QueryString["PlanOrderNo"]%>';
        var mainItemCode = '<%=Request.QueryString["MainItemCode"]%>';
        var position = '<%=Request.QueryString["Position"]%>';
        var stockListId = '<%=Request.QueryString["ID"]%>';
        $().ready(function () {
            $("#lblPlanOrder").text(planOrderNo);
            $("#lblMainItemCode").text(mainItemCode);
            $("#lblPosition").text(position);
        });

        function openChoosePage(flags) {
            var condition = " FBILLNO= '" + planOrderNo + "'";
            flag = flags;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false" +//&SearchCondition=" +
                //condition +
                "&rnd=" +
                Math.random(),
                width: 680,
                height: 300
            });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#txtItemName").val(list[0][1]);
                $("#hdnItemId").val(list[0][0]);
                $("#hdnItemCode").val(list[0][2]);
                var str = "";
                $(".ttt").parent().remove();
                str += "<tr><td class=\"Label1 ttt\">替代料编码</td><td class=\"Field1\">" + list[0][2] + "</td></tr>";
                str += "<tr><td class=\"Label1 ttt\">替代料规格</td><td class=\"Field1\">" + list[0][3] + "</td></tr>";
                if (list[0][0] != "-1")
                    $(str).appendTo("table");
            }
        }

        function Save() {
            var itemCode = $("#hdnItemCode").val();
            var location = $("#lblPosition").text();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.AddStockListReplaceMaterial(stockListId, itemCode, location);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }

    </script>
</asp:Content>
