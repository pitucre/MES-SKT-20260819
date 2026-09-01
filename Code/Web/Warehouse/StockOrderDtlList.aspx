<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="StockOrderDtlList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.StockOrderDtlList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SalOrderNo" HeaderText="销售单号" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ItemName" HeaderText="成品名称" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CustomerOrder" HeaderText="订单号" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="SalorderItem" HeaderText="项次" HeaderStyle-Width="120px"/>
            <%--<asp:BoundField DataField="PlanQty" HeaderText="计划出货量" DataFormatString="{0:F}" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CurrentQty" HeaderText="当前备货量" DataFormatString="{0:F}" HeaderStyle-Width="80px"/>--%>
            <asp:TemplateField HeaderText="计划出货量" SortExpression="PlanQty" HeaderStyle-Width="120px">
                <ItemTemplate>
                    <%#Convert.ToDouble(Eval("PlanQty").ToString())%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="当前备货量" SortExpression="CurrentQty" HeaderStyle-Width="120px">
                <ItemTemplate>
                    <%#Convert.ToDouble(Eval("CurrentQty").ToString())%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CarNo" HeaderText="车牌号" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="ContainerNo" HeaderText="货柜号" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="SealNo" HeaderText="封条号" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="Remark" HeaderText="备注" HeaderStyle-Width="120px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock"
        SelectMethod="GetStockOrderDtlAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var SalOrderID = '<%=Request.QueryString["ID"]%>';

        $(function () {
            $("#searchField_content").remove();
        })
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/StockOrderDtlEdit.aspx?name=StockOrderDtlListAdd&ID=-1&SalOrderID=" + SalOrderID;
            dialog({ title: "新增备货单细项", src: openWinUrl, width: 690, height: 300 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/StockOrderDtlEdit.aspx?name=StockOrderDtlListEdit&ID=" + idStr + "&SalOrderID=" + SalOrderID;
            dialog({ title: "编辑备货单细项", src: openWinUrl, width: 690, height: 300 });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function UpdateList() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
