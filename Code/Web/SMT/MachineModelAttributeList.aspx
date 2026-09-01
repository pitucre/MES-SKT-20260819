<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MachineModelAttributeList" Title="MODEL_ATTRIBUTE List Page"
    CodeBehind="MachineModelAttributeList.aspx.cs" %>

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
            <asp:BoundField DataField="MachineModelName" HeaderText="<%$ Resources:lang,MachineModelName %>"
                SortExpression="ModelName" />
            <asp:BoundField DataField="TablePosition" HeaderText="设备分区数量" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="MachineTableTypeName" HeaderText="<%$ Resources:lang,MachineTableType %>"
                HeaderStyle-Width="80px" SortExpression="MachineTableTypeName" />
            <asp:BoundField DataField="StartSlotPosition" HeaderText="<%$ Resources:lang,StartSlotPosition %>"
                HeaderStyle-Width="80px" />
            <asp:BoundField DataField="EndSlotPosition" HeaderText="<%$ Resources:lang,EndSlotPosition %>"
                HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang,Status %>" HeaderStyle-Width="60px"
                SortExpression="Status" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.MachineModelAttribute"
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
            dialog({ title: "<%= Resources.lang.MachineModelAttributeAdd %>", src: "MachineModelAttributeEdit.aspx?name=MachineModelAttributeAdd&ID=-1", width: 620, height: 480, resizeable: true });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.lang.MachineModelAttributeEdit %>", src: "MachineModelAttributeEdit.aspx?name=MachineModelAttributeEdit&ID=" + idStr, width: 620, height: 480, resizeable: true });
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

        //编辑
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "查看设备属性", src: "MachineModelAttributeView.aspx?name=MachineModelAttributeView&ID=" + idStr, width: 620, height: 480, resizeable: true });
        }
    </script>
</asp:Content>
