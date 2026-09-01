<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="WarehouseCheckReportDtl.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckReportDtl" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="CheckOrder" HeaderText="盘点单" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" />
            <asp:BoundField DataField="ItemSpec" HeaderText="物料规格" />
            <asp:BoundField DataField="GrnCount" HeaderText="应盘GRN数量" />
            <asp:BoundField DataField="RealtGrnCount" HeaderText="实盘GRN数量" />
            <asp:BoundField DataField="GrnSum" HeaderText="应盘总数" />
            <asp:BoundField DataField="RealtGrnSum" HeaderText="实盘总数" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.WarehouseCheck"
        SelectMethod="GetTwoList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        $(function () {
            //$("tr").unbind("onclick").bind("click", function () {
            //    orderNo = $(this).find("td").eq(1);
            //    itemCode = $(this).find("td").eq(2);
            //    shouwTab();
            //});
            $('#searchField_content').hide();
            $('#ckbMultipleSelected').hide();
            $('#updownSearchContainer1').hide();
            $('#updownSearchContainer').hide();
            $('#ckbMultipleSelected').parent().parent().hide();

            $(".ListTable tr:gt(0)").each(function () {
                var td1 = $(this).children("td:eq(1)");
                orderNo = $(this).children("td:eq(1)").html();
                itemCode = $(this).children("td:eq(2)").html();
                td1.html("<a href='#' onclick=\"clk1('" + orderNo + "," + itemCode + "')\">" + td1.html() + "</>");
            })
        });

        function clk1(str) {
            orderNo = str.split(',')[0];
            itemCode = str.split(',')[1];
            shouwTab();
            $("#dialogWin").width();
            $("#dialogWin").height();
        }

        function shouwTab() {

            var data = "<div>";
            data += "<table class='ListTable ListTableHeader'>"
            data += "<tbody>"
            data += "<tr><th>仓库</th><th>盘点清单</th><th>物料编码</th><th>产品规格</th><th>物料级别</th><th>储位编码</th><th>客户编码</th><th>GRN</th><th>账面数量</th>"
            data += "<th>初盘数量</th><th>复盘数量</th><th>差异数量</th><th>初盘人</th><th>初盘时间</th>"
            data += "<th>复盘人</th><th>复盘时间</th><th>平账人</th><th>平账时间</th><th>备注</th></tr>"
            $.post("../Handler/WarehouseCheck.ashx?api=GetGrnInfoList", { "orderNo": orderNo, "itemCode": itemCode }, function (ajax) {
                if (ajax == "") {
                    alert("没有GRN数据");
                    return false;
                }
                ajax = JSON.parse(ajax);
                for (var i = 0; i < ajax.length; i++) {
                    data += "<tr class='ListTableEvenRow'><td>" + ajax[i].CWhName + "</td><td>" + ajax[i].CheckOrder + "</td><td>" + ajax[i].ItemCode + "</td>"
                    data += "<td>" + ajax[i].ItemSpec + "</td><td>" + ajax[i].MaterialLevel + "</td><td>" + ajax[i].cBarCode + "</td>"
                    data += "<td>" + ajax[i].SupplierCode + "</td><td>" + ajax[i].SN + "</td><td>" + ajax[i].BalanceQty + "</td>"
                    data += "<td>" + ajax[i].StockQty + "</td><td>" + ajax[i].NowQty + "</td><td>" + ajax[i].DiffQty + "</td>"
                    data += "<td>" + ajax[i].CreateBy + "</td><td>" + data_string(ajax[i].CreateTime) + "</td><td>" + ajax[i].UpdateBy + "</td>"
                    data += "<td>" + data_string(ajax[i].UpdateTime) + "</td><td>" + (ajax[i].Default2 == null ? "" : ajax[i].Default2) + "</td><td>" + (ajax[i].Default3 == null ? "" : ajax[i].Default3) + "</td>"
                    data += "<td>" + ajax[i].Remark + "</td></tr>";
                }

                data += "</tbody></table></div>";
                layer.open({
                    type: 1,
                    area: ['95%', '95%'],
                    offset: ['10px', '10px'],
                    shadeClose: true, //点击遮罩关闭
                    content: data
                });
            });
        }
        function data_string(str) {
            var d = eval('new ' + str.substr(1, str.length - 2));
            var ar_date = [d.getFullYear(), d.getMonth() + 1, d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds()];
            for (var i = 0; i < ar_date.length; i++) ar_date[i] = dFormat(ar_date[i]);
            return ar_date.slice(0, 3).join('-') + ' ' + ar_date.slice(3).join(':');

            function dFormat(i) { return i < 10 ? "0" + i.toString() : i; }
        }
    </script>
</asp:Content>
