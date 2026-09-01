<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CPExpiredDateList.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.CPExpiredDateList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">产品编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">产品名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemName" runat="server" class="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">仓库编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtWarehouse" runat="server" class="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
        </tr>
        <tr>
            <td class="Label3">工单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNo" runat="server" class="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">库位条码</td>
            <td class="Field3">
                <asp:TextBox ID="txtCBarCode" runat="server" class="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
            </td>
            <td class="Field3">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="OrderNO" HeaderText="工单号" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="BalanceQty" HeaderText="重检数量"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CWhCode" HeaderText="仓库编码"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CBarCode" HeaderText="库位条码"  HeaderStyle-Width="120px" />
            <asp:BoundField DataField="DateCode" HeaderText="入库日期" HeaderStyle-Width="80px"  />
            <asp:BoundField DataField="ExpiredDate" HeaderText="过期时间" HeaderStyle-Width="80px"  />
            <asp:BoundField DataField="SurplusExpiredDate" HeaderText="已过期(天)"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CheckNumber" HeaderText="重检次数" HeaderStyle-Width="50px"  />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.Reinspection"
        SelectMethod="GetAllByListCP" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<input type="hidden" id="hdnOperate" name="hdnOperate" value="" />--%>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var hdnOperate = $("#hdnOperate");
        $(function () {
            isMultiple = true;
        });
            //重检
        function Add() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 4 改为 BalanceQty
            var CheckQty = getOneRecordCellTextByFiled("BalanceQty");
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/CPExpireDateEdit.aspx?type=insert&CheckQty=" + CheckQty + "&GRN=" + idStr;
            dialog({ title: mesLang("超期复检"), src: openWinUrl, width: 400, height: 250 });

        }
        function refresh() {
            document.forms[0].submit();
        }
        function ImportToExcel() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
