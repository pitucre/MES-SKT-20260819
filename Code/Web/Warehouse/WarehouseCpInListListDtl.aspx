<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="WarehouseCpInListListDtl.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCpInListListDtl" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">QcLotNo
            </td>
            <td class="Field3">
                <asp:TextBox ID="textQcLotNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.PalletCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="TextBox_PalletCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.ContainerCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="TextBox_ContainerCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SN%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="textSN" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">客户SN
            </td>
            <td class="Field3">
                <asp:TextBox ID="textCustomerSN" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.InStockStatus%>
            </td>
            <td class="Field3" colspan="3">
                <asp:DropDownList runat="server" ID="ddlStatus" ClientIDMode="Static">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">已入库</asp:ListItem>
                    <asp:ListItem Value="1">已扫描</asp:ListItem>
                    <asp:ListItem Value="2">待检验</asp:ListItem>
                    <asp:ListItem Value="3">待入库</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <input id="test1" runat="server" style="display: none" />
            </td>
        </tr>
    </table>--%>
       <table class="EditeContentTable" width="100%" style="min-height:50px">
        <tr>
            <td class="Label3">入库单号
            </td>
            <td class="Field3">
                <span id="InstockNo"></span>
            </td>
        </tr>
    </table>  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
 
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <%--            <asp:BoundField DataField="WorkOrderNo" HeaderText="<%$ Resources:lang, WorkOrderNo %>" />--%>
            <%--<asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />--%>
            <%--            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />--%>
            <asp:BoundField DataField="BarCode" HeaderText="<%$ Resources:lang, WarehouseBarCode %>" />
            <asp:BoundField DataField="PalletCode" HeaderText="<%$ Resources:lang, PalletCode %>" />
            <asp:BoundField DataField="ContainerCode" HeaderText="<%$ Resources:lang, ContainerCode %>" />
            <asp:BoundField DataField="SNId" HeaderText="<%$ Resources:lang, SN %>" />
            <asp:TemplateField HeaderText="条码数量" SortExpression="BatchQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("BatchQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("BatchQty","{0:G}").ToString():Eval("BatchQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CustomerSN" HeaderText="客户SN" />
            <asp:BoundField DataField="QcLotNo" HeaderText="检验批次号" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang, Status %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseCpInList"
        SelectMethod="SearchDtl" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        (function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }
        })(jQuery);

        $(function () {
            $("#InstockNo").html($.getUrlParam('InstockNo'))
            //$('#searchField_content').hide();
            $('#ckbMultipleSelected').hide();
            $('#updownSearchContainer1').hide();
            $('#updownSearchContainer').hide();
            $('#ckbMultipleSelected').parent().parent().hide();
            $('input[type="checkbox"]').parent().hide();
        });
    </script>
</asp:Content>
