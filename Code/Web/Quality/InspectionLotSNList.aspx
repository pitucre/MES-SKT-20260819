<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="InspectionLotSNList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionLotSNList" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">

    <asp:GridView ID="GridView1" runat="server"  DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="QcLotNo" HeaderText="批次号" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
               <asp:BoundField DataField="SN" HeaderText="序列号" />
            <asp:BoundField DataField="CustomerSN" HeaderText="客户号码" />
         
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionLot"
        SelectMethod="GetQcSNAll" SelectCountMethod="GetCount">
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
        function Export() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
