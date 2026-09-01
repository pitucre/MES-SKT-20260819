<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SteelMeshInspection.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshInspection" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
     <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                  设备编号
                </td>
                <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label2">
                  设备名称
                </td>
                <td class="Field2">
                 <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                  状态
                </td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlSMIInspectionStatus" runat="server" > 
                        <asp:ListItem Text="请选择" Value="-1"></asp:ListItem>
                        <asp:ListItem Text="未检" Value="0"></asp:ListItem>
                        <asp:ListItem Text="检验中" Value="1"></asp:ListItem>
                        <asp:ListItem Text="合格" Value="2"></asp:ListItem>
                        <asp:ListItem Text="不合格" Value="-2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">
                 创建时间
               </td>
               <td class="Field2" >
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
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备编号" HeaderStyle-Width="150px"/>  
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称"  HeaderStyle-Width="130px"/> 
            <asp:BoundField DataField="SMIStartInspectionDateTime" HeaderText="开始检验时间"  HeaderStyle-Width="180px"/>  
            <asp:BoundField DataField="SMIStopInspectionDateTime" HeaderText="结束检验时间"  HeaderStyle-Width="180px"/> 
            <asp:BoundField DataField="SMIInspectionStatusString" HeaderText="状态" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIInspectionUserName" HeaderText="检验人" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIInspectionDateTime" HeaderText="检验时间" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIIAddUserName" HeaderText="创建人"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="SMIIAddDateTime" HeaderText="创建时间"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="SMIIUpdateUserName" HeaderText="更新人" HeaderStyle-Width="100px"/>  
            <asp:BoundField DataField="SMIIUpdateDateTime" HeaderText="更新时间" HeaderStyle-Width="180px"/> 
            <asp:BoundField DataField="SMIInspectionRem" HeaderText="备注" HeaderStyle-Width="300px"/> 

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SteelMesh.BLL.SteelMeshInspectionLogic"
        SelectMethod="GetAllSteelMeshInspection" SelectCountMethod="GetSteelMeshInspectionCount">
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
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshInspectionDtl.aspx?name=SteelMeshInspectionDtl&ID=" + idStr;
            dialog({ title: mesLang("查看"), src: openWinUrl, width: 800, height: 480 });
        }
    </script>
</asp:Content>


