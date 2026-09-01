<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="StationParamList.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationParamList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.Station %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStationParamName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="Station" HeaderText="工序名称"  SortExpression="Station" HeaderStyle-Width="180px"/>    
            <asp:BoundField DataField="OpeType" HeaderText="工序类型"  SortExpression="StationType" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="StatusStr" HeaderText="状态" SortExpression="StatusStr"  HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="ResTypeName" HeaderText="资源类型"  SortExpression="ResTypeName" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ResName" HeaderText="资源名称" SortExpression="ResName" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px" SortExpression="CreateBy"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="CreateDateTime" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="StationDesc" HeaderText="备注" SortExpression="StationDesc" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Station.BLL.Station" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationParamAdd.aspx?name=Station_StationParamAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Station_StationParamAdd %>", src: openWinUrl, width: 800, height: 400 });
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 Station
            // 2 改为 OpeType
            var stationName = getOneRecordCellTextByFiled("Station");
            var stationTypeName = getOneRecordCellTextByFiled("OpeType");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationParamAdd.aspx?name=Station_StationParamEdit&ID=" + idStr + "&StationName=" + encodeURIComponent(stationName) + "&StationTypeName=" + encodeURIComponent(stationTypeName);
            dialog({ title: "<%=Resources.Pages.Station_StationParamEdit %>", src: openWinUrl, width: 800, height: 400 });
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 Station
            // 2 改为 OpeType
            var stationName = getOneRecordCellTextByFiled("Station");
            var stationTypeName = getOneRecordCellTextByFiled("OpeType");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationParamView.aspx?name=Station_StationParamView&ID=" + idStr + "&StationName=" + encodeURIComponent(stationName) + "&StationTypeName=" + encodeURIComponent(stationTypeName);
            dialog({ title: "<%=Resources.Pages.Station_StationParamView %>", src: openWinUrl, width: 650, height: 400 });
        }
        function UpdateList(paramName) {
            $("#txtStationParamName").val(paramName);
            document.forms[0].submit();
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
