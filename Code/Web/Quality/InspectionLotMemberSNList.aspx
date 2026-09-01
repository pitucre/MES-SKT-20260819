<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="InspectionLotMemberSNList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionLotMemberSNList" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">检验项
            </td>
            <td class="Field3">
                <span id="lblLotNoMember" runat="server"></span>
            </td>
            <td class="Label3">应抽数量
            </td>
            <td class="Field3">
                <span id="lblLotMemberQty" runat="server"></span>
            </td>
            <td class="Label3">已抽数量
            </td>
            <td class="Field3">
                <span id="lblLotMemberAcQty" runat="server"></span>
            </td>
        </tr>
        <tr>
            <td class="Label3">不良数量
            </td>
            <td class="Field3">
                <span id="lblLotMemberNcQty" runat="server"></span>
            </td>
            <td class="Label3">AC / RE 
            </td>
            <td class="Field3">
                <span id="lblAcRe" runat="server"></span>
            </td>
            <td class="Label3">结果
            </td>
            <td class="Field3">
                <span id="lblResult" runat="server"></span>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">

    <asp:GridView ID="GridView1" runat="server"  DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SN" HeaderText="序列号" />
            <asp:BoundField DataField="CustomerSN" HeaderText="客户号码" />
            <asp:BoundField DataField="InspectionMethodValue" HeaderText="判定标准" />
            <asp:BoundField DataField="Value" HeaderText="检验值" />
            <asp:BoundField DataField="NCCodes" HeaderText="不良代码" />
            <asp:BoundField DataField="Result" HeaderText="结果" />
            <asp:BoundField DataField="CreateBy" HeaderText="检查人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="检查时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionLot"
        SelectMethod="GetAllMemberSNInfo" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script>

        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(function () {
            //var tbObj = $(".ListTable");
            //var length = tbObj.find("tr:not(.ListTableEmptyDataRow)").length;
            //if (length > 0) {
            //    tbObj.find("tr th:nth-child(1)").hide();
            //    tbObj.find("tr td:nth-child(1)").hide();
            //}
        });

        //导出
        function Export() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
