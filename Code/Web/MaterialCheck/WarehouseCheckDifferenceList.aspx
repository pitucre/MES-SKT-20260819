<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="WarehouseCheckDifferenceList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckDifferenceList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td id="header" colspan="3" class="Label2" style="text-align: center; font-weight: 700; font-size: 14px"></td>
        </tr>
        <tr>
            <td class="Field2" colspan="3">
                <div id="listtab"  runat="server">

                </div>
            </td>
        </tr>
        </table>
    <script type="text/javascript">
        var checkNo = '<%=Request.QueryString["checkNo"]%>';
        var checkNo1 = getQueryString("");
        $("#header").html(checkNo + '盘点差异记录');
        //$(document).ready(function () {
        //    var ajax = SKT.LeanMES.Web.AjaxService.AjaxWarehouseCheck.CheckDifferenceList(checkNo);
        //    if (ajax.eror != null) {
        //        alert(ajax.error.Message)
        //        return false;
        //    }
        //    $("#listtab tbody").html('');
        //    var data = ajax.value;
        //    var htmlstr = "";
        //    for (var i = 0; i < data.length; i++) {
        //        if (i % 2 == 0) {
        //            htmlstr += "<tr class='ListTableEvenRow'>"
        //        } else {
        //            htmlstr += "<tr class='ListTableOddRow'>"
        //        }
        //        htmlstr += "<td>" + data[i].GRN + "</td>"
        //                + "<td>" + data[i].StockQty + "</td>"
        //                + "<td>" + data[i].NowQty + "</td>"
        //                + "<td>" + data[i].UpdateBy + "</td>"
        //                + "<td>" + data[i].UpdateTime + "</td>"
        //                + "</tr>";
        //    }
        //    $("#listtab tbody").html(htmlstr);
        //});
    </script>
</asp:Content>
