<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MachineModelFamilyList" Title="MODEL_FAMILY List Page"
    CodeBehind="MachineModelFamilyList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.ModelFamilyName%>
            </td>
            <td class="Field1">
                <input type="text" id="txtModelFamilyName" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="ModelFamilyName" HeaderText="<%$ Resources:lang,ModelFamilyName %>"
                HeaderStyle-Width="120px" SortExpression="ModelFamilyName" />
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.MachineModelFamily"
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
            dialog({ title: "<%= Resources.lang.MachineModelFamilyAdd %>", src: "MachineModelFamilyEdit.aspx?name=MachineModelFamilyAdd&ID=-1", width: 700, height: 350, resizeable: true });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.lang.MachineModelFamilyEdit %>", src: "MachineModelFamilyEdit.aspx?name=MachineModelFamilyEdit&ID=" + idStr, width: 700, height: 350, resizeable: true });
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
            $("#<%=this.txtModelFamilyName.ClientID %>").val(ModelName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
