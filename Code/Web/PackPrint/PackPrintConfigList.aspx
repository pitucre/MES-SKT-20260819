<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="PackPrintConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.PackPrint.PackPrintConfigList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                产品名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemType" HeaderText="<%$ Resources:lang, ItemType %>" />
            <asp:BoundField DataField="Site" HeaderText="<%$ Resources:lang, Site %>" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemsName %>" />
            <asp:BoundField DataField="ItemRev" HeaderText="<%$ Resources:lang, Revision %>" />
            <asp:BoundField DataField="LotSize" HeaderText="<%$ Resources:lang, LotSize %>" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang, ItemStatus %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.Item"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        isMultiple = true;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        $(document).ready(function () {
            $("#ckbMultipleSelected").parent().hide();
        })

        //出货清单配置 
        function ShipmentListConfig() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "出货清单配置", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/PackPrint/ShipmentListConfig.aspx?name=PackPrint_ShipmentListConfig&ID=" + idStr, width:1000, height: 400, resizeable: true });
        }

        //现票品配置
        function ProductLabelConfig() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "现票品打印配置", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/PackPrint/ProductLabelConfig.aspx?listtype=1&name=PackPrint_ProductLabelConfig&ID=" + idStr, width: 650, height: 400, resizeable: true });
        }

        //物料内容配置
        function MaterialLabelConfig() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "作业内容标识配置", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/PackPrint/ProductLabelConfig.aspx?listtype=2&name=PackPrint_MaterialLabelConfig&ID=" + idStr, width: 650, height: 400, resizeable: true });
        }

        //供应商配置表
        function SupplierLabelConfig() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "供应商配置表", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/PackPrint/ProductLabelConfig.aspx?listtype=5&name=PackPrint_SupplierLabelConfig&ID=" + idStr, width: 650, height: 400, resizeable: true });
        }
    </script>
</asp:Content>
