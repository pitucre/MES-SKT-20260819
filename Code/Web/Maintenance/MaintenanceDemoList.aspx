<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="MaintenanceDemoList.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceDemoList" Title="MaintenanceDemo List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"><%= Resources.lang.MaintenanceDemoNO %></td>
            <td class="Field2">
                <asp:TextBox ID="txtMaintenanceDemoNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.MaintenanceDemoName %></td>
            <td class="Field2">
                <asp:TextBox ID="txtMaintenanceDemoName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="DemoCode" HeaderText="<%$ Resources:lang, MaintenanceDemoNO%>" />
            <asp:BoundField DataField="DemoName" HeaderText="<%$ Resources:lang, MaintenanceDemoName %>" />
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang, Description %>" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
                        <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"  ItemStyle-Width="135px"  />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>"  DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"  ItemStyle-Width="135px"   />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Maintenance.BLL.MaintenanceDemo" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceDemoEdit.aspx?name=Maintenance_MaintenanceDemoAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.MaintenanceDemoAdd %>", src: openWinUrl, width: 780, height: 500});
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceDemoEdit.aspx?name=Maintenance_MaintenanceDemoEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.MaintenanceDemoEdit %>", src: openWinUrl, width: 780, height: 500 });
        }
        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceDemoView.aspx?name=Maintenance_MaintenanceDemoView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_MaintenancePlanView %>", src: openWinUrl, width: 780, height: 500 });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

