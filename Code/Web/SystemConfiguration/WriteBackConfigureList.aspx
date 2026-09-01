<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="WriteBackConfigureList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.WriteBackConfigureList" Title="WriteBackConfigure List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">回写编码</td>
            <td class="Field2">
                <asp:TextBox ID="WriteBackCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">回写名称</td>
            <td class="Field2">
                <asp:TextBox ID="WriteBackName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="WriteBackCode" HeaderText="回写编码" SortExpression="WriteBackCode" />
            <asp:BoundField DataField="WriteBackName" HeaderText="回写编码" SortExpression="WriteBackName" />
            <asp:BoundField DataField="WriteBackFlagName" HeaderText="是否开启回写" SortExpression="WriteBackFlagName" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.CommonDataSource.BLL.ERPWriteBackConfig" SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/WriteBackConfigureEdit.aspx?name=System_WriteBackConfigureEdit&ID=" + idStr;
            dialog({ title: "编辑", src: openWinUrl, width: 600, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

