<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialApplyDetailView.aspx.cs" MasterPageFile="~/Masters/ListMaster.master"
    Inherits="SKT.LeanMES.Web.Material.MaterialApplyDetailView" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">领料单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtApplyNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">工单/投料单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtMOCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">仓库名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">领料部门
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtDepName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">物料编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">单据来源
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlSrcType" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="MES">MES</asp:ListItem>
                    <asp:ListItem Value="ERP">ERP</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">类型
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">其他添加</asp:ListItem>
                    <asp:ListItem Value="1">工单领料</asp:ListItem>
                    <asp:ListItem Value="2">委外领料</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlState" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">未备料</asp:ListItem>
                    <asp:ListItem Value="4">备料中</asp:ListItem>
                    <asp:ListItem Value="1">已备料</asp:ListItem>
                    <asp:ListItem Value="2">已接收</asp:ListItem>
                    <asp:ListItem Value="3">已退料</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">使用日期
            </td>
            <td class="Field3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
                <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px; cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
        </tr>
        <%--        <tr>
            <td class="Label3">
                使用日期
            </td>
            <td class="Field3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
        </tr>--%>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all">
        <Columns>
            <asp:BoundField DataField="ApplyTypeDesc" HeaderText="类型" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="SrcOrderType" HeaderText="单据来源" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ApplyNo" HeaderText="领料单号" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="MOCode" HeaderText="工单号" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="DepCode" HeaderText="领料部门编码" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="DepName" HeaderText="领料部门名称" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="ItemSpec" HeaderText="物料规格" HeaderStyle-Width="320px" />
            <asp:BoundField DataField="WhCode" HeaderText="仓库编码" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="WhName" HeaderText="仓库名称" HeaderStyle-Width="80px" />
            <asp:TemplateField HeaderText="申请数量" SortExpression="ApplyQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("ApplyQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="已发数量" SortExpression="StockQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("StockQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="剩余数量" SortExpression="LeftQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("LeftQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
      
            <asp:BoundField DataField="UseDateTime" HeaderText="使用日期" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="StatueDesc" HeaderText="状态" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="接收人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="接收时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.Apply"
        SelectMethod="GetApplyDetailView" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <script type="text/javascript">
        function Save2Excel() {
            var hdnOperate = $("#hdnOperate");
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        $(function(){
            gridCellsChangeNo=true;
        })
    </script>

</asp:Content>
