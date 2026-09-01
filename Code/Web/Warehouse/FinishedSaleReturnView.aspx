<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="FinishedSaleReturnView.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.FinishedSaleReturnView" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">

    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SaleReturnNo" HeaderText="销退单号" SortExpression="SaleReturnNo" />
            <asp:BoundField DataField="SaleReturnRowId" HeaderText="销退单行号" SortExpression="SaleReturnRowId" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" SortExpression="ItemCode"/>
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" SortExpression="ItemName"/>
            <asp:BoundField DataField="BarCode" HeaderText="条码" SortExpression="BarCode" />
            <asp:BoundField DataField="Qty" HeaderText="数量" SortExpression="Qty" ItemStyle-CssClass="number"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SaleReturn.BLL.SaleReturn"
        SelectMethod="GetSaleReturnScanAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        isMultiple = false;

        $(function () {
            var tbObj = $(".ListTable");
            var length = tbObj.find("tr:not(.ListTableEmptyDataRow)").length;
            if (length == 0) {
                tbObj.hide();
            }
            tbObj.find("tr th:nth-child(1)").hide();
            tbObj.find("tr td:nth-child(1)").hide();
        })

        function Export() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
