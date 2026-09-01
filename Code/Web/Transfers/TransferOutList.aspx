<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransferOutList.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.TransferOutList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                调拨单号
            </td>
            <td class="Field2">
                <input type="text" id="txtTransferNumber" class="TextBox" runat="server" />
            </td>
            <td class="Label2">
                调拨时间
            </td>
            <td class="Field2">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="TransferOrder" HeaderText="调拨单号" SortExpression="TransferOrder" />
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码" SortExpression="SerialNumber" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName" />
            <asp:BoundField DataField="WareOutHouse" HeaderText="调出仓库" SortExpression="WareOutHouse" />
            <asp:BoundField DataField="WareInHouse" HeaderText="调入仓库" SortExpression="WareInHouse" />
            <asp:BoundField DataField="CreateBy" HeaderText="调拨人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="调拨时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"
                SortExpression="CreateDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.TransferOut"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        //隐藏多选
        $(document).ready(function () {
            $("#ckbMultipleSelected").parent().hide();
        })
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Transfers/TransferOutEdit.aspx?name=Material_TransferOutAdd&ID=-1";
            dialog({ title: mesLang("新增调拨申请单"), src: openWinUrl, width: 1000, height: 500 });
        }
        function Edit() {
            
        }
        /*刷新页面*/
        function UpdateList() {
            document.forms[0].submit();
        }
    </script>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
</asp:Content>
