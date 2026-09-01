<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="WarehouseCheckGRN.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckGRN" %>

<%@ MasterType VirtualPath="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td style="text-align: center;">
                <span runat="server" style="font-size: 18px;">盘点单明细GRN</span>
            </td>
            <td>
                <asp:Button runat="server" ID="btnImportExcel" CssClass="button" Text="导出EXCEL" OnClick="btnImportExcel_Click" Height="18px" />
            </td>
        </tr>
    </table>
    <div class="EditeContentTable" id="infotab" width="100%">
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script language="javascript" type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var checkOrder = '<%=Request.QueryString["OrderName"]%>';

        $(function () {
            CheckDifferenceList(checkOrder);
        });


        //根据单号查询对应的GRN明细
        function CheckDifferenceList(CheckListNo) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.CheckDifferenceList(CheckListNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            var htmlstr = "<table width='100% ' class='ListTable' id='tbBuyOrderDetail'><thead><tr class='ListTableHeader'>"
                + "<th>" + mesLang("序号") + "</th><th>" + mesLang("盘点单") + "</th><th>" + mesLang("盘点单名称") + "</th><th>" + mesLang("创建时间") + "</th><th>" + mesLang("审核时间") + "</th><th>GRN</th><th>" + mesLang("物料编码") + "</th>"
                + " <th>" + mesLang("物料名称") + "</th><th>" + mesLang("物料规格") + "</th><th>" + mesLang("ABC等级") + "</th><th>" + mesLang("供应商编码") + "</th><th>" + mesLang("仓库") + "</th><th>" + mesLang("库位条码") + "</th><th>" + mesLang("账面数量") + "</th><th>" + mesLang("初盘数量") + "</th><th>" + mesLang("初盘人") + "</th><th>" + mesLang("初盘时间") + "</th>"
                + " <th>" + mesLang("复盘数量") + "</th><th>" + mesLang("复盘人") + "</th><th>" + mesLang("复盘时间") + "</th><th>" + mesLang("盈亏") + "</th><th>" + mesLang("平帐数量") + "</th>"
                + " <th>" + mesLang("平帐人") + "</th><th>" + mesLang("平帐时间") + "</th><th>" + mesLang("备注") + "</th></tr></thead>";
            var list = ajax.value;
            for (var i = 0; i < list.length; i++) {
                //1.
                var value = ""; //盈亏数量
                var firstQty = list[i].StockQty;
                var ReatQty = list[i].NowQty;
                var changeQty = list[i].ChangeQty;
                if (ReatQty != 0) {
                    value = (changeQty - ReatQty).toFixed(6);
                } else {
                    if (firstQty != 0) {
                        value = (changeQty - firstQty).toFixed(6);
                    }
                    else {
                        //做了处理            
                        value = (changeQty - list[i].BalanceQty).toFixed(6);
                    }
                }
                if (i % 2 == 0) {
                    htmlstr += "<tr class='ListTableEvenRow' >";
                }
                else {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }

                //
                var itemName = list[i].ItemName;
                var itemSpc = list[i].ItemSpec;
                if (list[i].ItemName == null || list[i].ItemName == "null") {
                    itemName = "";
                }
                if (list[i].ItemSpec == null || list[i].ItemSpec == "null") {
                    itemSpc = "";
                }
                htmlstr += "<td>" + (i + 1) + "</td>"
                       + "<td>" + list[i].CheckOrder + "</td>"
                       + "<td>" + list[i].CheckOrderName + "</td>"
                       + "<td>" + list[i].CreateTime + "</td>"
                       + "<td>" + list[i].CheckTime + "</td>"
                       + "<td>" + list[i].GRN + "</td>"
                       + "<td>" + list[i].ItemCode + "</td>"
                       + "<td>" + itemName + "</td>"
                       + "<td>" + itemSpc + "</td>"
                       + "<td>" + list[i].ABCCLass + "</td>"
                       + "<td>" + list[i].VendorCode + "</td>"
                       + "<td>" + list[i].Warehouse + "</td>"
                       + "<td>" + list[i].BarCode + "</td>"
                       + "<td>" + list[i].BalanceQty + "</td>"
                       + (list[i].FirstBy == "" ? "<td></td>" : "<td>" + list[i].StockQty + "</td>")
                      // + "<td>" + list[i].StockQty + "</td>"
                       + "<td>" + list[i].FirstBy + "</td>"
                       + "<td>" + list[i].FirstTime + "</td>"
                       + (list[i].RepeatBy == "" ? "<td></td>" : "<td>" + list[i].NowQty + "</td>")
                     //  + "<td>" + list[i].NowQty + "</td>"
                       + "<td>" + list[i].RepeatBy + "</td>"
                       + "<td>" + list[i].RepeatTime + "</td>"
                       + "<td>" + value + "</td>"
                       + "<td>" + list[i].ChangeQty + "</td>"
                       + "<td>" + list[i].ChangeBy + "</td>"
                       + "<td>" + list[i].ChangeTime + "</td>"
                       + "<td>" + list[i].Remark + "</td>"

                + "</tr>";
            }
            $("#infotab").html(htmlstr + "</table>");
            /*多语初始化*/
            initPageLang();
        }
    </script>
</asp:Content>
