<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCpInListList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCpInListList"
    Title="WarehouseCpInList List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <style type="text/css">
        .DateTimeBox {
            width: 148px !important;
        }
    </style>
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%= Resources.lang.WorkOrderNo%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="textWorkOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.InStockNo%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="textInStockNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.WarehouseCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="textWarehouseCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.ItemCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="textItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.InStockBy%> 
            </td>
            <td class="Field3">
                <asp:TextBox ID="textInStockBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.InComingTime%>
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtStrDate" runat="server" CssClass="DateTimeBox" autocomplete="off"></asp:TextBox>
                -
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="DateTimeBox" autocomplete="off"></asp:TextBox>
                <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
        </tr>
        <tr>
            <td class="Label3">ERP单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="textERPNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
               <td class="Label3">产品（客户）条码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <%--        <tr>
            <td class="Label3">
                <%= Resources.lang.WorkOrderNo%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="textWorkOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
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
        </tr>--%>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="InStockNo" HeaderText="<%$ Resources:lang, InStockNo %>" SortExpression="InStockNo" ItemStyle-CssClass="InStockNo" />
            <asp:BoundField DataField="WorkOrderNo" HeaderText="<%$ Resources:lang, WorkOrderNo %>" SortExpression="WorkOrderNo" ItemStyle-CssClass="WorkOrderNo" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" SortExpression="ItemCode"/>
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" SortExpression="ItemName"/>
            <asp:BoundField DataField="CPN" HeaderText="客户料号" SortExpression="CPN"/>
            <asp:BoundField DataField="CWhCode" HeaderText="<%$ Resources:lang, WarehouseCode %>" SortExpression="CWhCode"/>
            <asp:BoundField DataField="CWhName" HeaderText="<%$ Resources:lang, WarehouseName %>" SortExpression="CWhName"/>
            <asp:BoundField DataField="InQty" HeaderText="入库数量" SortExpression="InQty"/>
            <asp:BoundField DataField="cBarCode" HeaderText="入库库位" SortExpression="cBarCode"/>
            <asp:BoundField DataField="CreateBy" HeaderText="入库人" SortExpression="CreateBy"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="入库时间" SortExpression="CreateDateTime"/>
            <asp:BoundField DataField="ErpStatus" HeaderText="ERP单号" />
            <%--<asp:BoundField DataField="ErpStatus" HeaderText="<%$ Resources:lang, ErpStatus %>" />--%>
            <%--            <asp:BoundField DataField="BarCode" HeaderText="<%$ Resources:lang, WarehouseBarCode %>" />
            <asp:BoundField DataField="PalletCode" HeaderText="<%$ Resources:lang, PalletCode %>" />
            <asp:BoundField DataField="ContainerCode" HeaderText="<%$ Resources:lang, ContainerCode %>" />
            <asp:BoundField DataField="SNId" HeaderText="<%$ Resources:lang, SN %>" />--%>
            <%--            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang, Status %>" />--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseCpInList"
        SelectMethod="Search" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var barcode = "";
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        _isHms = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInList.GetConfigType("2");
        var entity = ajax.value;
        function View() {
            var idStr = getOneRecordId(); //多选
            if (idStr == "") return false;

            var inStockNo = getTextByClass("InStockNo");
            var workOrderNo = getTextByClass("WorkOrderNo");

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseCpInListListDtl.aspx?name=WarehouseCpInListListDtl&OrderNo=" + workOrderNo + "&InstockNo=" + inStockNo;
            dialog({ title: mesLang("成品入库信息"), src: openWinUrl, width: window.screen.width-500, height: window.screen.height-350 });
        }

        //根据样式名获取文本
        function getTextByClass(cls) {
            return $.trim($("#<%=this.GridView1.ClientID%> tbody input[name=\"chkSelect\"]:checked").parent().siblings("." + cls).text());
        }

        function Refresh() {
            document.forms[0].submit();
        }
        function rtrim(str) { //删除右边的_
            return str.replace(/_$/g, "");
        }
        //导出Excel
        function saveExcel() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            hdnIdString.val(idStr);

            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
            hdnIdString.val("");
        }

        function clearDataTime() {
            $(".DateTimeBox").val("");
        }

        //导出
        function Import() {
            $("#hdnOperate").val("exportExcel");
            document.forms[0].submit();
            $("#hdnOperate").val("");
        }
    </script>
</asp:Content>
