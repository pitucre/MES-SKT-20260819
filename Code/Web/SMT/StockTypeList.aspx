<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StockTypeList.aspx.cs"
    Inherits="SKT.LeanMES.Web.SMT.StockTypeList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.StockTypeName %>
            </td>
            <td class="Field1">
                <input type="text" id="txtTurnoverTypeName" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="StockTypeCode" HeaderText="<%$ Resources:lang, StockTypeCode %>"
                HeaderStyle-Width="90px" SortExpression="StockTypeCode"/>
            <asp:BoundField DataField="StockTypeName" HeaderText="<%$ Resources:lang, StockTypeName %>"
                 SortExpression="StockTypeName"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>

            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Turnover.BLL.StockCarType"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/StockTypeEdit.aspx?name=StockTypeAdd&Id=-1";
            dialog({ title: "<%= Resources.Pages.StockTypeAdd %>", src: openWinUrl, width: 430, height: 327 });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/StockTypeEdit.aspx?name=StockTypeEdit&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.StockTypeEdit %>", src: openWinUrl, width: 430, height: 327 });
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
