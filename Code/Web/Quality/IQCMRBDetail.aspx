<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="IQCMRBDetail.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.IQCMRBDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table id="tbGrn" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; position: relative; border-collapse: collapse; margin-top: 5px;" class="ListTable">
        <thead>
            <tr class="ListTableHeader">
                <th style="width: 5%;">行号
                </th>
                <th style="width: 10%;">检验单号
                </th>
                <th style="width: 10%;">IQC检验单号
                </th>
                <th style="width: 15%;">GRN
                </th>
                <th style="width: 15%;">物料编码
                </th>
                <th style="width: 15%;">物料名称
                </th>
                <th style="width: 15%;">物料规格
                </th>
                <th style="width: 5%;">数量
                </th>
                <th>供应商</th>
                <th>检验状态</th>
            </tr>
        </thead>
        <tbody>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="9" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript">
        var iqcId = '<%=Request.QueryString["InspectionId"]%>';

        $(function () {
            showGRN(iqcId);
        });

        function showGRN(iqcId) {
            var entity = 
            { 
                InspectionId : iqcId 
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetMRBGRNList(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value;
            if(!data || data.length <= 0){
                return;
            }
            var hl = "";
            for (var i = 0; i < data.length; i++) {
                if (i % 2 == 0) {
                    if (data[i].IsOK == "合格") {
                        hl += "<tr class='ListTableOddRow'>";
                    } else {
                        hl += "<tr class='ListTableOddRow' style=\"color:red\">";
                    } 
                } else {
                    if (data[i].IsOK == "合格") {
                        hl += "<tr class='ListTableEvenRow'>";
                    } else {
                        hl += "<tr class='ListTableEvenRow' style=\"color:red\">";
                    }
                }
                hl += "<td>" + (i + 1) + "</td>"
                        + "<td>" + data[i].MRBNo + "</td>"
                        + "<td>" + data[i].InspectionNo + "</td>"
                        + "<td>" + data[i].GRN + "</td>"
                        + "<td>" + data[i].ItemCode + "</td>"
                        + "<td>" + data[i].ItemName + "</td>"
                        + "<td>" + data[i].ItemSpec + "</td>"
                        + "<td>" + data[i].BalanceQty + "</td>"
                        + "<td>" + data[i].VendorName + "</td>"
                        + "<td>" + data[i].IsOK + "</td>"
                        + "</tr>"
            }
            $("#tbGrn tbody").html(hl);
        }

    </script>
</asp:Content>
