<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommonHelperDataDistribution.aspx.cs" MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.DataDistribution.CommonHelperDataDistribution" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label5" runat="server" Text="下发事业部"></asp:Label>
            </td>
        </tr>
        <tr style="height: 300px; padding: 2px;" valign="top">
            <td class="Field" align="center" style="width: 99%; vertical-align: top;">
                <div id="loadingmessages1" class="Tips">
                    数据加载中...</div>
                <iframe name="DataDistributionSYBSelectList" id="DataDistributionSYBSelectList" frameborder="0" style="width: 99%;
                    height: 300px;" src=""></iframe>
            </td>
        </tr>
    </table>
    <table style="border-collapse: inherit;" width="100%">
            <tr>
                <td align="center" style="text-align:center">
                    <input type="button" onclick="ParentDataDistributionOperate()" value="确认数据下发" class="button"/>
                </td>
            </tr>
       </table>
    <script type="text/javascript">
        var name = '<%= Request.QueryString["name"] %>';
        var pra = '<%= Request.QueryString["pra"] %>';
        $(function () {
            var iframe1 = document.getElementById("DataDistributionSYBSelectList");
            iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/DataDistribution/DataDistributionSYBSelect.aspx?name=' + name + '&pra=' + pra;
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
        });

        function loadingcompleted() {
            $("#loadingmessages1").html("");
        }
        function ParentDataDistributionOperate() {
            var childWindow = $("#DataDistributionSYBSelectList")[0].contentWindow;
            childWindow.DataDistributionOperate();
        }
    </script>
</asp:Content>
