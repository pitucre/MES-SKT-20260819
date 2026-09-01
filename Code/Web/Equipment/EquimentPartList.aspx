<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="EquimentPartList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquimentPartList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
 <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"><%= Resources.lang.PartCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtPartCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.myPartName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtPartName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label2"><%= Resources.lang.EquipmentCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquimentCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.EquipmentName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquimentName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="PartCode" HeaderText="<%$ Resources:lang, PartCode %>" />
            <asp:BoundField DataField="PartName" HeaderText="<%$ Resources:lang, myPartName %>" />
           <%-- <asp:BoundField DataField="EquimentCode" HeaderText="<%$ Resources:lang, EquipmentCode %>" />
            <asp:BoundField DataField="EquimentName" HeaderText="<%$ Resources:lang, EquipmentName %>" /> --%>
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$ Resources:lang, EquipmentCode %>" />
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$ Resources:lang, EquipmentName %>" /> 
                <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateTime %>" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Equipment.BLL.Part" SelectMethod="GetAllPartEquNew" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentPartView.aspx?name=EquimentPartView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.PartView %>", src: openWinUrl, width: 600, height: 280 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>