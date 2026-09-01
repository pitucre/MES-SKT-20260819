<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentLineRelationList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentLineRelationList" Title="EquipmentLineRelation List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentLineType %></td>
            <td class="Field2">
                <input type="text" id="txtMachineType" class="TextBox" style="width:250px" runat="server"/>
            </td>
            <td class="Label2"><%= Resources.lang.EquipmentLineDisplayName %></td>
            <td class="Field2">
                <input type="text" id="txtName" class="TextBox" style="width:250px" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="EquipmentLineType" HeaderText="<%$ Resources:lang, EquipmentLineType %>" />
            <asp:BoundField DataField="EquipmentLineDisplayName" HeaderText="<%$ Resources:lang, EquipmentLineDisplayName %>" />
<%--            <asp:BoundField DataField="LineId" HeaderText="<%$ Resources:lang,Line %>" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="UpdateBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="UpdateDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Equipment.BLL.EquipmentLineRelation" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");


        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentLineRelationEdit.aspx?name=EquipmentLineRelationAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.EquipmentLineRelationAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentLineRelationEdit.aspx?name=EquipmentLineRelationEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.EquipmentLineRelationEdit %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Delete() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            /*Add By Alen 2018-01-30 增加删除线别设备类型时的确认判断*/
            if (confirm("确定要删除选中的记录吗？")) {
                hdnOperate.val("delete");
                hdnIdString.val(idStr);
                document.forms[0].submit();
            }
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
