<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="PackingAccessoriesList.aspx.cs" Inherits="SKT.LeanMES.Web.Container.PackingAccessoriesList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">产品编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
             <td class="Label3">附件名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtAccessoriesName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">工序</td>
            <td class="Field3">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
           
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="AccessoriesName" HeaderText="附件名称" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="AccessoriesQty" HeaderText="附件数量"  ItemStyle-Width="70px"/>
            <asp:BoundField DataField="MaskGroup" HeaderText="掩码组名" />
            <asp:BoundField DataField="Sequence" HeaderText="扫描顺序" ItemStyle-Width="70px"/>
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" ItemStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" /> 
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" ItemStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" /> 
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Container.BLL.PackingAccessories" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/PackingAccessoriesEdit.aspx?name=PackingAccessoriesAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.PackingAccessoriesAdd %>", src: openWinUrl, width: 750, height: 420 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/PackingAccessoriesEdit.aspx?name=PackingAccessoriesEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.PackingAccessoriesEdit %>", src: openWinUrl, width: 750, height: 420 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/PackingAccessoriesEdit.aspx?name=PackingAccessoriesEdit&Action=Copy&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.PackingAccessoriesCopy %>", src: openWinUrl, width: 750, height: 420 });
        }
    </script>
</asp:Content>
