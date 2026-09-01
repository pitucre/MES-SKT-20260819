<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AccessoryUseTable.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryUseTable" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
          <table class="EditeContentTable" width="100%">
               <tr>
                <td class="Label2">
                 线别
                </td>
                <td class="Field2">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label2">
                 工单号
                </td>
                <td class="Field2">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
             </tr>
               <tr>
                <td class="Label2">
                 辅料GRN
                </td>
                <td class="Field2">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label2">
                 辅料料号
                </td>
                <td class="Field2">
                <asp:TextBox ID="txtAccessoryCodoe" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
             </tr>
            <tr>
                <td class="Label2">
                 记录时间
               </td>
               <td class="Field2" colspan="3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
                  <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
               </td>
             </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
     <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="LineName" HeaderText="线别"  HeaderStyle-Width="150px"/> 
            <asp:BoundField DataField="Station" HeaderText="工序"  HeaderStyle-Width="150px"/> 
            <asp:BoundField DataField="OrderNo" HeaderText="工单号"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="SerialNumber" HeaderText="辅料GRN"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="AccessoryCodoe" HeaderText="辅料料号"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="AccessoryName" HeaderText="辅料名称"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="StatusName" HeaderText="辅料状态"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间"  HeaderStyle-Width="150px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.AccessoryManagement.BLL.Accessory"
        SelectMethod="GetUseAll" SelectCountMethod="GetUseCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
     <div style="display:none"><asp:Button ID="Button1" runat="server"  /></div>
    <div style="display:none"><asp:Button ID="btnExport" runat="server" OnClick="btnExport_Click"  /></div>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(".DateTimeBox").datepicker({
                showOn: "both",
                buttonImageOnly: true,
                buttonText: "<%=Resources.lang.ChooseDate %>"
            });
        });
        function Export()
        {
            $("#<%=this.btnExport.ClientID%>").click();
        }
    </script>
</asp:Content>
