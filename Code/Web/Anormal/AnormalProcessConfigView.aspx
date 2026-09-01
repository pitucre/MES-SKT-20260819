<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="AnormalProcessConfigView.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalProcessConfigView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>

            <td class="Label1">线别</td>
            <td class="Field1">
                <asp:Label runat="server" ID="LineName" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">异常类型</td>
            <td class="Field1">
                <asp:Label runat="server" ID="AnormalGroupName" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">异常处理人</td>
            <td class="Field1">
                <asp:Label runat="server" ID="ProcessByName" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">异常完结人</td>
            <td class="Field1">
                <asp:Label runat="server" ID="CompleteByName" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var anormalProcessConfigId = "<%=Request.QueryString["AnormalProcessConfigId"]%>";

        $(document).ready(function () {

            //获取数据
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAnormal.GetAnormalProcessConfig({ AnormalProcessConfigId: anormalProcessConfigId });
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if (entity) {
                $("#LineName").text(entity.LineName);
                $("#AnormalGroupName").text(entity.AnormalGroupName);
                $("#ProcessByName").text(entity.ProcessByName);
                $("#CompleteByName").text(entity.CompleteByName);
            }
        });

    </script>
</asp:Content>

