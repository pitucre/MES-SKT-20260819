<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="OfflineSerialNumberList.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.OfflineSerialNumberList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">产品编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtMainItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">部件编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtPartItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">工序</td>
            <td class="Field3">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="MainItemCode" HeaderText="产品编码" />
             <asp:BoundField DataField="PartName" HeaderText="部件名称" />
            <asp:BoundField DataField="PartItemCode" HeaderText="部件编码" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="AssemblyQty" HeaderText="数量" />
            <%--<asp:BoundField DataField="PartType" HeaderText="部件类别" />--%>           
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"  ItemStyle-Width="80px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.SerialNumber.BLL.OfflineSNConfig" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/OfflineSerialNumberEdit.aspx?name=SerialNumber_OfflineSerialNumberAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.SerialNumber_OfflineSerialNumberAdd %>", src: openWinUrl, width: 750, height: 550 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/OfflineSerialNumberEdit.aspx?name=SerialNumber_OfflineSerialNumberEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_OfflineSerialNumberEdit %>", src: openWinUrl, width: 750, height: 550 });
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

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/OfflineSerialNumberEdit.aspx?name=SerialNumber_OfflineSerialNumberCopy&Action=Copy&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_OfflineSerialNumberCopy %>", src: openWinUrl, width: 750, height: 420 });
        }
    </script>
</asp:Content>
