<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AccessoryChambrierenRecord.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryChambrierenRecord" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
          <table class="EditeContentTable" width="100%">
               <tr>
                <td class="Label3">
                 辅料物料条码
                </td>
                <td class="Field3">
                <asp:TextBox ID="txtACRSerialNumber" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label3">
                 辅料物料料号
                </td>
                <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label3">
                 开始解冻时间
                </td>
               <td class="Field3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
                  <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
               </td>
                
             </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
     <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" style="table-layout:fixed;word-wrap:break-word;word-break:break-all" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ACRSerialNumber" HeaderText="辅料物料条码"  HeaderStyle-Width="150px"/> 
            <asp:BoundField DataField="ItemCode" HeaderText="辅料物料料号"  HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="ItemName" HeaderText="辅料物料名称"  HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="ACRStartTime" HeaderText="开始解冻时间"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="ACRStopTime" HeaderText="结束解冻时间"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="ACRCountString" HeaderText="解冻次数"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="ACRStatusString" HeaderText="解冻状态"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="记录人"   HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="记录时间"  HeaderStyle-Width="150px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.AccessoryManagement.BLL.AccessoryChambrierenRecordLogic"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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
