<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WorkShopList.aspx.cs" Inherits="SKT.LeanMES.Web.WorkShop.WorkShopList"
    Title="WorkShop List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WorkShopName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWorkShopName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WorkShopCode %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWorkShopCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="WorkShopName" HeaderText="<%$ Resources:lang, WorkShopName %>" />
            <%-- <asp:BoundField DataField="WorkShopCode" HeaderText="<%$ Resources:lang, WorkShopCode %>" />--%>
            <asp:BoundField DataField="FactoryName" HeaderText="<%$ Resources:lang, FactoryName %>" />
            <asp:BoundField DataField="ShiftName" HeaderText="<%$ Resources:lang, ShiftName %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName=" SKT.LeanMES.WorkShop.BLL.WorkShop"
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/WorkShop/WorkShopEdit.aspx?name=WorkShopAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.WorkShopAdd %>", src: openWinUrl, width: 700, height: 420 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/WorkShop/WorkShopEdit.aspx?name=WorkShopEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WorkShopEdit %>", src: openWinUrl, width: 700, height: 420 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/WorkShop/WorkShopView.aspx?name=WorkShopView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.WorkShopWiew %>", src: openWinUrl, width: 450, height: 320 });
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
