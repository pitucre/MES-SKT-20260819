<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.MaskGroup.MaskGroupList" ViewStateMode="Disabled" CodeBehind="MaskGroupList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.MaskGroup%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div>
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" Width="100%">
        <Columns>
            <asp:BoundField DataField="MaskGroup" HeaderText="<%$ Resources:lang,MaskGroup %>"
                HeaderStyle-Width="200px" SortExpression="MaskGroup" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description %>"/>            
        </Columns>
    </asp:GridView>
    </div>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaskGroup.BLL.MaskGroup"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
     <script language="javascript" type="text/javascript">
        isMultiple = false;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        
        //增加 
        function Add() {
            dialog({ title: "<%= Resources.Pages.MaskGroupAdd %>", src: "MaskGroupEdit.aspx?name=MaskGroupAdd&ID=-1", width: 760, height: 420, resizeable: true, onClosed: 'Refresh' });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.MaskGroupEdit %>", src: "MaskGroupEdit.aspx?name=MaskGroupEdit&ID=" + idStr, width: 760, height: 420, resizeable: true, onClosed: 'Refresh' });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        function UpdateList(namestr) {
            $("#<%=this.txtName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "复制掩码组", src: "MaskGroupEdit.aspx?name=MaskGroupEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random(), width: 760, height: 420, resizeable: true, onClosed: 'Refresh' });
        }
    </script>
</asp:Content>
