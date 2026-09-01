<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MachineModelList" Title="MODEL List Page" CodeBehind="MachineModelList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.MachineModelName%>
            </td>
            <td class="Field1">
                <input type="text" id="txtModelName" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="ModelName" HeaderText="<%$ Resources:lang,MachineModelName %>" SortExpression="ModelName" />
            <asp:BoundField DataField="ModelFamilyName" HeaderText="<%$ Resources:lang,MachineModelFamilyName %>" SortExpression="ModelFamilyName" />
            <asp:BoundField DataField="MachineType" HeaderText="<%$ Resources:lang,MachineType %>" SortExpression="MachineType" />
            <asp:BoundField DataField="Vendor" HeaderText="<%$ Resources:lang,Vendor %>" 
                SortExpression="Vendor" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang,Status %>" 
                SortExpression="Status" />
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.MachineModel"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        //增加 
        function Add() {
            dialog({ title: "<%= Resources.lang.MachineModelAdd %>", src: "MachineModelEdit.aspx?name=MachineModelAdd&ID=-1", width: 680, height: 400, resizeable: true });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.lang.MachineModelEdit %>", src: "MachineModelEdit.aspx?name=MachineModelEdit&ID=" + idStr, width: 680, height: 400, resizeable: true });
        }
        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(ModelName) {
            $("#<%=this.txtModelName.ClientID %>").val(ModelName);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.lang.MachineModelEdit %>", src: "MachineModelEdit.aspx?name=MachineModelEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random(), width: 680, height: 400, resizeable: true });
        }
    </script>
</asp:Content>
