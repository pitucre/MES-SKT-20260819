<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SteelMeshInspectionDtl.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshInspectionDtl" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
     <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                  检验项目代码
                </td>
                <td class="Field2">
                <asp:TextBox ID="txtSMIPCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label2">
                  检验项目名称
                </td>
                <td class="Field2">
                 <asp:TextBox ID="txtSMIPName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
            </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="治具编号" HeaderStyle-Width="150px"/>  
            <asp:BoundField DataField="EquipmentName" HeaderText="治具名称"  HeaderStyle-Width="130px"/> 
            <asp:BoundField DataField="SMIPCode" HeaderText="检验项目代码"  HeaderStyle-Width="180px"/>  
            <asp:BoundField DataField="SMIPName" HeaderText="检验项目名称"  HeaderStyle-Width="180px"/> 
            <asp:BoundField DataField="SMIPEntryMode" HeaderText="录入方式" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIPCriterion" HeaderText="判定标准" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIPUnit" HeaderText="单位" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIDResult" HeaderText="检验结果" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIDUserName" HeaderText="检验人" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIDDateTime" HeaderText="检验时间" HeaderStyle-Width="80px"/> 
            <asp:BoundField DataField="SMIDAddUserName" HeaderText="创建人"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="SMIDAddDateTime" HeaderText="创建时间"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="SMIDUpdateUserName" HeaderText="更新人" HeaderStyle-Width="100px"/>  
            <asp:BoundField DataField="SMIDUpdateDateTime" HeaderText="更新时间" HeaderStyle-Width="180px"/> 
            <asp:BoundField DataField="SMIDRem" HeaderText="备注" HeaderStyle-Width="300px"/> 
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SteelMesh.BLL.SteelMeshInspectionLogic"
        SelectMethod="GetAllSteelMeshInspectionDtl" SelectCountMethod="GetSteelMeshInspectionDtlCount">
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

