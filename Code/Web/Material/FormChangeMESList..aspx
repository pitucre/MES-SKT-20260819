<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="FormChangeMESList..aspx.cs" Inherits="SKT.LeanMES.Web.Material.FormChangeMESList"
    Title="FormChangeMES List Page" %>

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
                <%= Resources.lang.MaterialCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtMaterialCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">转换单号
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
                <%= Resources.lang.InStockBy%> 
            </td>
            <td class="Field3">
                <asp:TextBox ID="textInStockBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                ERP单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtERPNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.InComingTime%>
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtStrDate" runat="server" CssClass="DateTimeBox" autocomplete="off"></asp:TextBox>
                -
             <asp:TextBox ID="txtEndDate" runat="server" CssClass="DateTimeBox" autocomplete="off"></asp:TextBox>
                <img title="点击清除日期" id="timeClear" style="margin-bottom: -5px; cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="FromChangeByMESNo" HeaderText="转换单号" />
            <asp:BoundField DataField="StauesName" HeaderText="状态" />
            <asp:BoundField DataField="PreConversionMaterial" HeaderText="转换前料号" />
            <asp:BoundField DataField="ConvertedMaterial" HeaderText="转换后料号" />
            <asp:BoundField DataField="CWhCode" HeaderText="<%$ Resources:lang, WarehouseCode %>" SortExpression="CWhCode" />
            <asp:BoundField DataField="CWhName" HeaderText="<%$ Resources:lang, WarehouseName %>" SortExpression="CWhName" />
            <asp:BoundField DataField="ConvertedQty" HeaderText="入库数量" SortExpression="InQty" />
            <asp:BoundField DataField="cBarCode" HeaderText="入库库位" SortExpression="cBarCode" />
            <asp:BoundField DataField="CreateBy" HeaderText="入库人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="入库时间" SortExpression="CreateDateTime" />
            <asp:BoundField DataField="ERPNo" HeaderText="ERP单号" SortExpression="ERPNo" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProductionCollection.Client.FormChangeByMES"
        SelectMethod="GetAllFormChangeMESList" SelectCountMethod="GetCount">
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
            dialog({ title: mesLang("成品入库信息"), src: openWinUrl, width: window.screen.width - 500, height: window.screen.height - 350 });
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
        function ImportToExcel() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
            hdnIdString.val("");
        }

        function clearDataTime() {
            $(".DateTimeBox").val("");
        }
    </script>
</asp:Content>
