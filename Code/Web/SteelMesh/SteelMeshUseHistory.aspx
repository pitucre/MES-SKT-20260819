<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SteelMeshUseHistory.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshUseHistory" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
     <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">
                  设备编号
                </td>
                <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                 <td class="Label3">
                  工单号
                </td>
                <td class="Field3">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label3">
                  设备名称
                </td>
                <td class="Field3">
                 <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label3">
                  操作类型
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlTxnCode" runat="server" > 
                        <asp:ListItem Text="请选择" Value="-1"></asp:ListItem>
                        <asp:ListItem Text="新增" Value="新增"></asp:ListItem>
                        <asp:ListItem Text="修改" Value="修改"></asp:ListItem>
                        <asp:ListItem Text="检验" Value="检验"></asp:ListItem>
                        <asp:ListItem Text="入库" Value="入库"></asp:ListItem>
                        <asp:ListItem Text="出库" Value="出库"></asp:ListItem>
                        <asp:ListItem Text="上线" Value="上线"></asp:ListItem>
                        <asp:ListItem Text="下线" Value="下线"></asp:ListItem>
                        <asp:ListItem Text="清洗" Value="清洗"></asp:ListItem>
                        <asp:ListItem Text="报废" Value="报废"></asp:ListItem>
                        <asp:ListItem Text="删除" Value="删除"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                 <td class="Label3">
                  上级设备类型
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlParentEquipmentType" runat="server" > 
                        <asp:ListItem Text="请选择" Value=""></asp:ListItem>
                        <asp:ListItem Text="钢网" Value="钢网"></asp:ListItem>
                        <asp:ListItem Text="刮刀" Value="刮刀"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label3">
                 操作时间
               </td>
               <td class="Field3" >
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
                  <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
               </td>
            </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称"  HeaderStyle-Width="130px"/> 
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备编号" HeaderStyle-Width="150px"/>  
            <asp:BoundField DataField="EquipmentTypeNameone" HeaderText="设备类型"  HeaderStyle-Width="100px"/>  
            <asp:BoundField DataField="EquipmentTypeNametwo" HeaderText="上级设备类型" HeaderStyle-Width="80px"/>  
            <asp:BoundField DataField="TxnCode" HeaderText="操作类型" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="Status" HeaderText="操作前状态" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="Status_TO" HeaderText="操作后状态" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="OrderNO" HeaderText="工单号"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="Qty_to_Build" HeaderText="工单数量"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="Operator" HeaderText="操作用户" HeaderStyle-Width="100px"/>  
            <asp:BoundField DataField="OperatorTime" HeaderText="操作时间" HeaderStyle-Width="180px"/> 
            <asp:BoundField DataField="Tension" HeaderText="张力"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="CheckResult" HeaderText="外观检查结果"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="Remark" HeaderText="备注" HeaderStyle-Width="300px"/> 
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SteelMesh.BLL.SteelMeshUseHistory"
        SelectMethod="GetAllSteelMeshUseHistory" SelectCountMethod="GetSteelMeshUseHistoryCount">
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
        function Import()
        {
            $("#<%=this.btnExport.ClientID%>").click();
        }
    </script>
</asp:Content>

