<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master"
    AutoEventWireup="true" CodeBehind="InspectionLotMemberList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionLotMemberList" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                批次号
            </td>
            <td class="Field3">
                <span id="lblLotNo" runat="server"></span>
            </td>
            <td class="Label3">
                状态
            </td>
            <td class="Field3">
                <span id="lblState" runat="server"></span>
            </td>
            <td class="Label3">
                批量
            </td>
            <td class="Field3">
                <span id="lblLotQty" runat="server"></span>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                产品编码
            </td>
            <td class="Field3">
                <span id="lblItemCode" runat="server"></span>
            </td>
            <td class="Label3">
                结果
            </td>
            <td class="Field3">
                <span id="lblResult" runat="server"></span>
            </td>
            <td class="Label3">
                检查时间
            </td>
            <td class="Field3">
                <span id="lblCheckDateTime" runat="server"></span>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="InspectionName" HeaderText="检验项" />
            <asp:BoundField DataField="AQLRule" HeaderText="AQL" />
            <asp:BoundField DataField="InspectionQty" HeaderText="应抽数量" />
            <asp:BoundField DataField="AcQty" HeaderText="AC" />
            <asp:BoundField DataField="ReQty" HeaderText="RE" />
            <asp:BoundField DataField="ActualQty" HeaderText="已抽数量" />
            <asp:BoundField DataField="NCCodeQty" HeaderText="不良数量" />
            <asp:BoundField DataField="InspectionTemplateName" HeaderText="检验模板名称" />
            <asp:BoundField DataField="InspectionMethodName" HeaderText="录入方式" />
            <asp:BoundField DataField="InspectionMethodValue" HeaderText="判定标准" />
            <asp:BoundField DataField="UnitName" HeaderText="单位" />
            <asp:BoundField DataField="CheckFashion" HeaderText="检验方法" />
            <asp:BoundField DataField="Result" HeaderText="结果" />
            <asp:BoundField DataField="CreateBy" HeaderText="检查人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="检查时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionLot"
        SelectMethod="GetAllMemberInfo" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script language="javascript" type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");


        function View() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionLotMemberSNList.aspx?name=QC_InspectionLotMemberSNList&ID=" + idStr;
            dialog({ title: "检验产品详情", src: openWinUrl, width: 750, height: 400 });
        }
      
    </script>
</asp:Content>
