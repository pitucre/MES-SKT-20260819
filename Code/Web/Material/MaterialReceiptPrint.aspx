<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialReceiptPrint.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.MaterialReceiptPrint" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.ReveivedNO%>
            </td>
            <td class="Field3">
                <input type="text" id="txtSerialNumber" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.OrderFormNO%>
            </td>
            <td class="Field3">
                <input type="text" id="txtFBillNO" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.VendorCode%>
            </td>
            <td class="Field3">
                <input type="text" id="txtVendorCode" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <div class="clear5">
    </div>
    <div id="print">
        <div style="font-size: 22px; text-align: center; font-family: 微软雅黑; font-weight: bold;">
            深圳可立克科技股份有限公司外购入库单
        </div>
        <table class="EditeContentTable" width="100%" style="border: 0;">
            <tr>
                <td class="Label4">
                    编号
                </td>
                <td class="Field4">
                    <label runat="server" id="labSerialNumber">
                    </label>
                </td>
                <td class="Label4">
                    <%=Resources.lang.OrderFormNO%>
                </td>
                <td class="Field4">
                    <label runat="server" id="labFBillNO">
                    </label>
                </td>
                <td class="Label4">
                    供应商代码:
                </td>
                <td class="Field4">
                    <label runat="server" id="labVendorCode">
                    </label>
                </td>
            </tr>
            <tr>
                <td class="Label4">
                    订单币别:
                </td>
                <td class="Field4">
                    <label runat="server" id="labOrderCurrency">
                    </label>
                </td>
                <td class="Label4">
                    供应商：
                </td>
                <td class="Field4">
                    <label runat="server" id="labVendorName">
                    </label>
                </td>
                <td class="Label4">
                    日期:
                </td>
                <td class="Field4">
                    <label runat="server" id="labReceiveDateTime">
                    </label>
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1"
            OnRowDataBound="GridView1_RowDataBound">
            <Columns>
                <asp:BoundField DataField="SerialNumber" HeaderText="收货单编号" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编码" />
                <asp:BoundField DataField="ItemModel" HeaderText="规格型号" />
                <asp:BoundField DataField="Unit" HeaderText="单位" />
                <asp:BoundField DataField="FQty" HeaderText="应收" DataFormatString="{0:N}" />
                <asp:BoundField DataField="BalanceQty" HeaderText="实收" DataFormatString="{0:N}" />
                <asp:BoundField DataField="FBillNO" HeaderText="采购单号" />
                <asp:BoundField DataField="LotCode" HeaderText="<%$ Resources:lang,LotCode %>" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
            SelectMethod="GetAllMaterialReceipt" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(document).ready(function () {
            $(".ListTable tr:first").find("th:eq(0)").hide();
            $("#NoSearchConditions").hide();
        });

        /*用于弹出窗口返回值更新列表*/
        function UpdateList(DepartmentName) {
            $("#<%=this.txtFBillNO.ClientID %>").val(DepartmentName);
            document.forms[0].submit();
        }
        function updatelist() {
            $("#<%=this.txtFBillNO.ClientID %>").val();
            document.forms[0].submit();
        }
        var str = "";
        function Print() {
            if ($("#<%=this.txtSerialNumber.ClientID %>").val() == "") {
                str += "请输入收货单号\n";
            }
            if ($("#<%=this.txtFBillNO.ClientID %>").val() == "") {
                str += "请输入采购订单\n";
            }
            if ($("#<%=this.txtVendorCode.ClientID %>").val() == "") {
                str += "请输入供应商代码\n";
            }
            if (str != "") {
                alert(str);
                return false;
            }
            $("#print").jqprint();
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
