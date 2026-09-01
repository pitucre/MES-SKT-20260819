<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="WarningHistoryList.aspx.cs" Inherits="SKT.LeanMES.Web.Warning.WarningHistoryList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                工单
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                线别
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                预警名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarningName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                预警类型
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarningType" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="WarningName" HeaderText="<%$ Resources:lang, WarningName %>" SortExpression="WarningName"  />
            <asp:BoundField DataField="WarningType" HeaderText="<%$ Resources:lang, WarningType %>" SortExpression="WarningType"  />
            <asp:BoundField DataField="OrderNo" HeaderText="工单" SortExpression="OrderNo" />
            <asp:BoundField DataField="LineName" HeaderText="线别" SortExpression="LineName" />
            <asp:BoundField DataField="Ratio" HeaderText="良率" SortExpression="Ratio" />
            <asp:BoundField DataField="NcNum" HeaderText="不良现象" SortExpression="NcNum" />
            <asp:BoundField DataField="WeekType" HeaderText="周期类型" SortExpression="WeekType" />
            <asp:BoundField DataField="Status" HeaderText="状态" />
            <asp:BoundField DataField="CloseBy" HeaderText="关闭人" />
            <asp:BoundField DataField="CloseDateTime" HeaderText="关闭时间"  />
            <asp:BoundField DataField="CreateDateTime" HeaderText="预警时间"  />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Warning.BLL.WarningHistory" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function OneSolve() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningHistoryEdit.aspx?name=Quality_WarningHistory_OneDeal&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WarningEdit %>", src: openWinUrl, width: 600, height: 350 });
        }

        function TwoSolve() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningHistoryTwoEdit.aspx?name=Quality_WarningHistory_TwoDeal&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WarningEdit %>", src: openWinUrl, width: 600, height: 350 });
        }

        function ThreeSolve() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningHistoryThreeEdit.aspx?name=Quality_WarningHistory_ThreeDeal&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WarningEdit %>", src: openWinUrl, width: 600, height: 350 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningHistoryView.aspx?Name=Quality_WarningHistoryView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WarningView %>", src: openWinUrl, width: 650, height: 350 });
        }

        function UpdateList(strValue) {
            $("#<%=this.txtWarningName.ClientID %>").val(strValue);
            document.forms[0].submit();
        }
    </script>
</asp:Content>