<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurnoverTypeList.aspx.cs"
    Inherits="SKT.LeanMES.Web.Turnover.TurnoverTypeList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.TurnoverTypeName%>
            </td>
            <td class="Field1">
                <input type="text" id="txtTurnoverTypeName" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="TurnoverTypeCode" HeaderText="<%$ Resources:lang,TurnoverTypeCode %>"
                HeaderStyle-Width="120px" SortExpression="TurnoverTypeCode" />
            <asp:BoundField DataField="TurnoverTypeName" HeaderText="<%$ Resources:lang,TurnoverTypeName %>"
                SortExpression="TurnoverTypeName" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Turnover.BLL.TurnoverType"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverTypeEdit.aspx?name=Turnover_TurnoverTypeAdd&Id=-1";
            dialog({ title: "<%= Resources.Pages.Turnover_TurnoverTypeAdd %>", src: openWinUrl, width: 475, height: 325 });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverTypeEdit.aspx?name=Turnover_TurnoverTypeEdit&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Turnover_TurnoverTypeEdit %>", src: openWinUrl, width: 475, height: 325 });
        }

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverTypeView.aspx?name=Turnover_TurnoverTypeView&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Turnover_TurnoverTypeView %>", src: openWinUrl, width: 475, height: 325 });
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

        function UpdateList(turnoverTypeName) {
            $("#<%=this.txtTurnoverTypeName.ClientID %>").val(turnoverTypeName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
