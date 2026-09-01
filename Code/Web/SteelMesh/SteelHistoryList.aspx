<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SteelHistoryList.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelHistoryList" MasterPageFile="~/Masters/ListMaster.master"  %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                 钢网刮刀编号
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtEquipmentCode" CssClass="TextBox"  runat="server"></asp:TextBox>
            </td>
            <td class="Label3">
                钢网刮刀状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server" > 
                    <asp:ListItem Text="请选择" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="已上线" Value="1"></asp:ListItem>
                    <asp:ListItem Text="已下线" Value="0"></asp:ListItem>
                    <asp:ListItem Text="已清洗" Value="2"></asp:ListItem>
                </asp:DropDownList>
            </td>            
            <td class="Label3">
                工单号
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtWorkOrder" CssClass="TextBox"  runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                 上线开始时间
            </td>
            <td class="Field3">
                <input type="text" id="tbBeginTime" runat="server" class="DateTimeBox"/>
            </td>
            <td class="Label3">
                下线结束时间
            </td>
            <td class="Field3">
                <input type="text" id="tbEndTime" runat="server" class="DateTimeBox"/>
            </td>
            <td class="Label3"></td>
            <td class="Field3"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="EquipmentName" HeaderText="治具名称"  ItemStyle-Width="10%"/>
            <asp:BoundField DataField="EquipmentCode" HeaderText="治具编号"  ItemStyle-Width="8%"/>
            <asp:BoundField DataField="EquipmentType" HeaderText="设备类型"  ItemStyle-Width="5%"/>
            <asp:BoundField DataField="OrderNO" HeaderText="工单"  ItemStyle-Width="8%"/>
            <asp:BoundField DataField="Qty_to_Build" HeaderText="工单数量"  ItemStyle-Width="5%"/>
            <asp:BoundField DataField="Status" HeaderText="钢网刮刀状态"  ItemStyle-Width="6%"/>
            <asp:BoundField DataField="UPLineUser" HeaderText="上线人"  ItemStyle-Width="8%"/>
            <asp:BoundField DataField="UPLineTime" HeaderText="上线时间"  ItemStyle-Width="10%" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"/>            
            <asp:BoundField DataField="DownLineUser" HeaderText="下线人"  ItemStyle-Width="8%"/>
            <asp:BoundField DataField="DownLineTime" HeaderText="下线时间"  ItemStyle-Width="10%" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"/>
            <asp:BoundField DataField="ClearUser" HeaderText="清洗人"  ItemStyle-Width="8%"/>
            <asp:BoundField DataField="ClearTime" HeaderText="清洗时间"  ItemStyle-Width="10%" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"/>
            <asp:BoundField DataField="Tension" HeaderText="张力"  ItemStyle-Width="5%"/>
            <asp:BoundField DataField="CheckResult" HeaderText="外观检查"  ItemStyle-Width="5%"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SteelMesh.BLL.SteelHistory"
        SelectMethod="GetSteelHistory" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""  />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");

        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
