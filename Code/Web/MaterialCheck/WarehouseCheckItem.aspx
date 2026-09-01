<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="WarehouseCheckItem.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckItem" %>

<%@ MasterType VirtualPath="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td style="text-align: center;">
                <span runat="server" style="font-size: 18px;">盘点单物料编码明细</span>
            </td>
            <td>
                <asp:Button runat="server" ID="btnImportExcel" Text="导出EXCEL"  CssClass="button" OnClick="btnImportExcel_Click" />
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
        var OrderList = [];
        var checkOrder = '<%=Request.QueryString["OrderName"]%>';

        $(function () {
            //添加盘点单明细列表
            CheckDifferenceList(checkOrder);
        });


        //根据单号查询对应的GRN明细
        function CheckDifferenceList(CheckListNo) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.CheckOrderImportToExcel(CheckListNo, 1);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            var data = $.parseJSON(ajax.value).data;
            $.grep(data, function (e, i) {
                OrderList.push(e);
            });
            var htmlstr = "<table width='100% ' class='ListTable' id='tbBuyOrderDetail'><thead><tr class='ListTableHeader'>"
                + "<th>" + mesLang("序号") + "</th><th>" + mesLang("盘点单") + "</th><th>" + mesLang("盘点单名称") + "</th><th>" + mesLang("创建时间") + "</th><th>" + mesLang("审核时间") + "</th><th>" + mesLang("物料编码") + "</th>"
                + " <th>" + mesLang("物料名称") + "</th><th>" + mesLang("物料规格") + "</th><th>" + mesLang("客户料号") + "</th><th>" + mesLang("ABC等级") + "</th><th>" + mesLang("供应商编码") + "</th><th>" + mesLang("仓库") + "</th><th>" + mesLang("库位条码") + "</th><th>" + mesLang("账面数量") + "</th><th>" + mesLang("初盘数量") + "</th><th>" + mesLang("初盘人") + "</th><th>" + mesLang("初盘时间") + "</th>"
                + " <th>" + mesLang("复盘数量") + "</th><th>" + mesLang("复盘人") + "</th><th>" + mesLang("复盘时间") + "</th><th>" + mesLang("盈亏") + "</th><th>" + mesLang("平帐数量") + "</th>"
                + " <th>" + mesLang("平帐人") + "</th><th>" + mesLang("平帐时间") + "</th><th>" + mesLang("备注") + "</th></tr></thead>";
            for (var i = 0; i < OrderList.length; i++) {

                if (i % 2 == 0) {
                    htmlstr += "<tr class='ListTableEvenRow' >";
                }
                else {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }

                htmlstr += "<td>" + (i + 1) + "</td>"
                       + "<td>" + OrderList[i].CheckOrder + "</td>"
                       + "<td>" + OrderList[i].CheckOrderName + "</td>"
                       + "<td>" + OrderList[i].CreateTime + "</td>"
                       + "<td>" + OrderList[i].CheckTime + "</td>"
                       + "<td>" + OrderList[i].ItemCode + "</td>"
                       + "<td>" + OrderList[i].ItemName + "</td>"
                    + "<td>" + OrderList[i].ItemSpec + "</td>"
                    + "<td>" + OrderList[i].ItemCPN + "</td>"
                       + "<td>" + OrderList[i].ABCClass + "</td>"
                       + "<td>" + OrderList[i].VendorCode + "</td>"
                       + "<td>" + OrderList[i].Warehouse + "</td>"
                       + "<td>" + OrderList[i].BarCode + "</td>"
                       + "<td>" + OrderList[i].BalanceQty + "</td>"
                       + (OrderList[i].FirstBy == "" ? "<td></td>" : "<td>" + OrderList[i].StockQty + "</td>")
                     //  + "<td>" + OrderList[i].StockQty + "</td>"
                       + "<td>" + OrderList[i].FirstBy + "</td>"
                       + "<td>" + OrderList[i].FirstTime + "</td>"
                       + (OrderList[i].RepeatBy == "" ? "<td></td>" : "<td>" + OrderList[i].NowQty + "</td>")
                    //   + "<td>" + OrderList[i].NowQty + "</td>"
                       + "<td>" + OrderList[i].RepeatBy + "</td>"
                       + "<td>" + OrderList[i].RepeatTime + "</td>"
                       + "<td>" + OrderList[i].RemainQty + "</td>"
                       + "<td>" + OrderList[i].ChangeQty + "</td>"
                       + "<td>" + OrderList[i].ChangeBy + "</td>"
                       + "<td>" + OrderList[i].ChangeTime + "</td>"
                       + "<td>" + OrderList[i].Remark + "</td>"

                + "</tr>";
            }
            $("#infotab").html(htmlstr + "</table>");
            /*多语初始化*/
            initPageLang();
        }
    </script>
</asp:Content>

