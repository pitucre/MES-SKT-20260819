<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Labels.LabelFieldList" CodeBehind="LabelFieldList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.LabelField %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLabelField" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="FieldDfName" HeaderText="<%$ Resources:lang, LabelFieldName %>"
                HeaderStyle-Width="180px" SortExpression="FieldDfName" />
            <asp:BoundField DataField="Definition" HeaderText="<%$ Resources:lang, LabelFieldDefinition %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px" SortExpression="CreateBy"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="CreateDateTime"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy %>"
                SortExpression="ModifyBy" />
              <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>"
                SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/> 
            <asp:BoundField DataField="FieldDfDesc" HeaderText="<%$ Resources:lang, FieldDesc %>" SortExpression="FieldDfDesc"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Labels.BLL.LabelField"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelFieldEdit.aspx?name=Labels_LabelFieldAdd&ID=-1";
            dialog({ title: "<%= Resources.Pages.Labels_LabelFieldAdd %>", src: openWinUrl, width: 750, height: 420 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelFieldEdit.aspx?name=Labels_LabelFieldEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.Pages.Labels_LabelFieldEdit %>", src: openWinUrl, width: 750, height: 420 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelFieldView.aspx?name=Labels_LabelFieldView&ID=" + idStr;
            dialog({ title: "<%= Resources.Pages.Labels_LabelFieldView %>", src: openWinUrl, width: 750, height: 420 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(itemName) {
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelFieldEdit.aspx?name=Labels_LabelFieldCopy&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "复制标签字段", src: openWinUrl, width: 750, height: 420 });
        }
    </script>
</asp:Content>
