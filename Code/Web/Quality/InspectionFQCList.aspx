<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="InspectionFQCList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionFQCList" Title="InspectionFQC List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">检验单号</td>
            <td class="Field1">
                <asp:TextBox ID="txtInspectionFQCNO2" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="InspectionFQCNo" HeaderText="FQC检验单号" />
            <asp:BoundField DataField="ItemId" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="SealantDate" HeaderText="封胶时间" />
            <asp:BoundField DataField="StationFactQty" HeaderText="送检批数量" />
            <asp:BoundField DataField="FinishTime" HeaderText="关批时间" />
            <asp:BoundField DataField="Statue" HeaderText="状态" />
            <asp:BoundField DataField="Result" HeaderText="检验结果" />
            <asp:BoundField DataField="CheckDate" HeaderText="检验日期" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
            <asp:BoundField DataField="InspectionUser" HeaderText="检验员" />
            <asp:BoundField DataField="Auditing" HeaderText="审核" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Quality.BLL.InspectionFQC" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionFQCEdit.aspx?name=InspectionFQCView&TypeId=2&InspectionTypeId=1&ID=" + idStr;
            dialog({ title: "", src: openWinUrl, width: 1200, height: 600 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionFQCEdit.aspx?name=InspectionFQCEdit&ID=" + idStr;
            dialog({ title: "", src: openWinUrl, width: 1200, height: 600 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //导出PDF
        function PdfFile() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            hdnOperate.val("PdfFile");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            hdnOperate.val("");
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

