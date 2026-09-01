<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialReceiptEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Material.MaterialReceiptEdit" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div id="divData" style="height: 330px; overflow: auto; width: 100%; text-align: center;">
    </div>
    <div class="clear5">
    </div>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
    <script type="text/javascript">
        var uID = '<%= Request.QueryString["ID"] %>';

        $(document).ready(function () {
            if (uID != null && uID != -1) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialGRN(uID);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }
            if (ajax.value.length != 0) {
                var strHtml = "";
                strHtml += "<table style='width:100%;height:auto;' id='leftTab' class='ListTable'>";
                strHtml += "<tr class='ListTableHeader'>"
                                          + "<th>GRN</th>"
                                          + "<th>物料编码</th>"
                                          + "<th>最小包装数量</th>"
                                          + "<th>供应商</th>"
                                          + "<th>采购订单</th>"
                                          + "</tr>";
                var list = ajax.value;
                var i = 0;
                var strclass = "";
                for (var i = 0; i < list.length; i++) {
                    if (i % 2 == 0) {
                        strclass = "ListTableOddRow";
                    }
                    else {
                        strclass = "ListTableEvenRow";
                    }
                    strHtml += "<tr class='" + strclass + "'>";
                    strHtml += "<td>" + list[i].SerialNumber + "</td>";
                    strHtml += "<td>" + list[i].ItemCode + "</td>";
                    strHtml += "<td>" + list[i].BalanceQty + "</td>";
                    strHtml += "<td>" + list[i].VendorCode + "</td>";
                    strHtml += "<td>" + list[i].FBillNo + "</td>";
                    strHtml += "</tr>";
                }
                strHtml += "<table>";
                $("#divData").html(strHtml);
            }
            else {
                strHtml += "<table width='100%' class='ListTable'><tr class='ListTableEmptyDataRow'><td>该物料还没有生成任何GRN</td></tr></table>";
                $("#divData").html(strHtml);
            }
        })

    </script>
</asp:Content>
