<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.SMT.FeederGroupList" 
Title="FeederGroup List Page" Codebehind="FeederGroupList.aspx.cs" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
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
     
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="ModelName" HeaderText="<%$ Resources:lang,MachineModelName %>" HeaderStyle-Width="120px" SortExpression="ModelName"/>
            <asp:BoundField DataField="minSize"   HeaderText="<%$ Resources:lang,minSize %>"  SortExpression="minSize"/>
            <asp:BoundField DataField="maxSize" HeaderText="<%$ Resources:lang,maxSize %>"  SortExpression="maxSize"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.FeederGroup"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value=""/>
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        //增加 
        function Add() {
            dialog({ title: "<%= Resources.Pages.FeederGroupAdd %>", src: "FeederGroupEdit.aspx?name=FeederGroupAdd&ID=-1", width: 596, height: 424, resizeable: true });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.FeederGroupEdit %>", src: "FeederGroupEdit.aspx?name=FeederGroupEdit&ID=" + idStr, width: 596, height: 424, resizeable: true });
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
    </script>

</asp:Content>
