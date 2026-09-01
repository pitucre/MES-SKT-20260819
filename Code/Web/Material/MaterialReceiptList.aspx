<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialReceiptList.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.MaterialReceiptList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">
                <%=Resources.lang.ReveivedNO%>
            </td>
            <td class="Field4">
                <input type="text" id="txtReveivedNO" class="TextBox" runat="server" />
            </td>
            <td class="Label4">
                <%=Resources.lang.OrderFormNO%>
            </td>
            <td class="Field4">
                <input type="text" id="txtFBillNO" class="TextBox" runat="server" />
            </td>
            <td class="Label4">
                <%=Resources.lang.VendorCode%>
            </td>
            <td class="Field4">
                <input type="text" id="txtVendorCode" class="TextBox" runat="server" />
            </td>
            <td class="Label4">
                <%=Resources.lang.Time%>
            </td>
            <td class="Field4">
              <input type="text" id="txtDateTime" class="DateTimeBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent" >
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="SerialNumber" HeaderText="收货单编号" />
            <asp:BoundField DataField="FBillNO" HeaderText="采购单号" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" />
            <asp:BoundField DataField="ItemModel" HeaderText="规格型号" />
            <asp:BoundField DataField="Unit" HeaderText="单位" />
            <asp:BoundField DataField="FQty" HeaderText="应收" DataFormatString="{0:N}" />
            <asp:BoundField DataField="BalanceQty" HeaderText="实收" DataFormatString="{0:N}" />
            <asp:BoundField DataField="LotCode" HeaderText="<%$ Resources:lang,LotCode %>" />
            <asp:BoundField DataField="ReceiveDateTime" HeaderText="收料时间" DataFormatString="{0:yyyy-MM-dd}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetAllMaterialReceipt" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");


        /*用于弹出窗口返回值更新列表*/
        function UpdateList(DepartmentName) {
            $("#<%=this.txtFBillNO.ClientID %>").val(DepartmentName);
            document.forms[0].submit();
        }
        function updatelist() {
            $("#<%=this.txtFBillNO.ClientID %>").val();
            document.forms[0].submit();
        }

        function Print() {
            dialog({ title: "打印收货单", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialReceiptPrint.aspx?rnd=" + Math.random(), width: 800, height: 600 });
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "查看详细", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialReceiptEdit.aspx?name=MaterialReceiptEdit&ID=" + idStr + "&rnd=" + Math.random(), width: 570, height: 350 });
        }
    </script>
        <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/jqPrint/jquery.jqprint-0.3.js"
        type="text/javascript"></script>
</asp:Content>
