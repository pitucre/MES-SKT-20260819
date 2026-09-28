<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="ShopOrderLabelReprintList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ShopOrderLabelReprintList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <div id="lblMessage" style="background: yellow; padding: 3px; border: 1px solid rgb(255, 236, 139); border-image: none; color: red; display: none;"></div>
    <%--查询模块（与报表“多打标签统计表”一致）--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">打印日期
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtCreateTimeFr" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                ---
                <asp:TextBox ID="txtCreateTimeTo" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">工单号
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtOrderNO" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">产品编码
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label4">客户编码
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtCPN" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label4">SN
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td colspan="6"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <%--列表数据源：udfvw_printSN_more（报表“多打标签统计表”所用视图）--%>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="CreateTime" HeaderText="打印日期" />
            <asp:BoundField DataField="OrderNO" HeaderText="工单号" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="CPN" HeaderText="客户编码" />
            <asp:BoundField DataField="SN" HeaderText="SN" />
            <asp:BoundField DataField="BatchQty" HeaderText="标签数量" />
            <asp:BoundField DataField="status2" HeaderText="入库状况" />
            <asp:BoundField DataField="Station" HeaderText="当前工序" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        //支持多选：勾选多行后可批量补打
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(document).ready(function () {
            $("div.noInstallPrintPlugin").remove();
        });

        //补打标签：选中行的复选框值 = 视图 udfvw_printSN_more 的 SN
        //补打窗口 ShopOrderDetailRePrint.aspx 按 UID 取数，这里先把 SN 换算成 UID（视图保持不动）
        function printItemSn() {
            var sns = getRecordIdString();
            if (!sns) return;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.GetUIDListBySN(sns);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var uids = ajax.value;
            if (!uids || uids.length == 0) {
                alert("选中的条码在序列号表中找不到对应 UID，无法补打。");
                return;
            }
            var selectedQty = sns.split(",").length;
            if (uids.length < selectedQty && !confirm("选中 " + selectedQty + " 个条码，其中 " + uids.length + " 个可补打，是否继续？")) {
                return;
            }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ShopOrderDetailRePrint.aspx?name=ShopOrderDetailRePrint&ids=" + uids.join(",");
            dialog({ title: "<%=Resources.Pages.PreSNRePrint %>", src: openWinUrl, width: 450, height: 200 });
        }
    </script>
</asp:Content>
