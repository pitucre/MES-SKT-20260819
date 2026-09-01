<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="ShopOrderPrintRecordList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ShopOrderPrintRecordList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%= Resources.lang.PrintKey %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPrintKey" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.OrderNumber%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.ItemCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
              <tr>
            <td class="Label3">
                <%= Resources.lang.CustomerOrder%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                打印时间（开始）
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTimeFr" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <td class="Label3">
                打印时间（结束）
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTimeTo" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="PrintKey" HeaderText="<%$ Resources:lang, PrintKey %>" SortExpression="PrintKey"/>
            <asp:BoundField DataField="SerialNumberType" HeaderText="<%$ Resources:lang, PrintType %>" SortExpression="SerialNumberType" />
            <asp:BoundField DataField="ActionType" HeaderText="<%$ Resources:lang, ActionType %>" SortExpression="ActionType"/>
            <asp:BoundField DataField="Station" HeaderText="<%$ Resources:lang, Station %>" SortExpression="Station"/>
            <asp:BoundField DataField="Resource" HeaderText="<%$ Resources:lang, Resource %>"/>
            <asp:BoundField DataField="PrintUser" HeaderText="<%$ Resources:lang, PrintUser %>" SortExpression="PrintUser"/>
            <asp:BoundField DataField="PrintTime" HeaderText="<%$ Resources:lang, PrintTime %>" SortExpression="PrintTime"/>
            <asp:BoundField DataField="OrderNO" HeaderText="<%$ Resources:lang, OrderNO %>" SortExpression="OrderNO"/>
            <asp:BoundField DataField="OrderType" HeaderText="<%$ Resources:lang, OrderType %>" SortExpression="OrderType"/>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" SortExpression="ItemCode"/>
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" SortExpression="ItemName"/>
            <asp:BoundField DataField="CustomerOrder" HeaderText="<%$ Resources:lang, CustomerOrder %>" SortExpression="CustomerOrder"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SerialNumber.BLL.PrintRecord"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        function Edit() {
            View();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ShopOrderPrintRecordView.aspx?name=ShopOrderPrintRecord_View&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.ShopOrderPrintRecord_View %>", src: openWinUrl, width: 460, height: 240 });
        }
    </script>
</asp:Content>
