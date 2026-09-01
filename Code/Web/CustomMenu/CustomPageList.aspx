<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="CustomPageList.aspx.cs" Inherits="SKT.LeanMES.Web.CustomMenu.CustomPageList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server" ViewStateMode="Enabled">
<%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                界面名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPageEName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">一级菜单名称</td>
            <td class="Field2">
               <asp:DropDownList ID="ddlModule" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="PageCName" HeaderText="二级菜单名称(中文)" HeaderStyle-Width="180px" SortExpression="PageCName"/>
            <asp:BoundField DataField="PageEName" HeaderText="二级菜单名称(英文)" HeaderStyle-Width="180px" SortExpression="PageEName"/>
            <asp:BoundField DataField="ModuleCName" HeaderText="一级菜单名称" HeaderStyle-Width="180px" SortExpression="ModuleCName"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.CustomMenu.BLL.CustomMenu"
        SelectMethod="GetCustomPage" SelectCountMethod="GetCount">
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
        var w = $(window).width() - 150;
        var h = $(window).height() - 70;
        
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CustomMenu/CustomPageEdit.aspx?name=Template_TemplateAdd&ID=-1";
            dialog({ title: "添加二级菜单", src: openWinUrl, width: w, height: h });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            var wins = $(window.parent);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CustomMenu/CustomPageEdit.aspx?name=Template_TemplateEdit&ID=" + idStr;
            dialog({ title: "编辑二级菜单", src: openWinUrl, width: w, height: h });
        }

        <%--function View() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Report/ReportTemplateView.aspx?name=Template_TemplateView&ID=" + idStr;
            dialog({ title: "查看自定义界面", src: openWinUrl, width: w, height: h });
        }--%>

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") { return false; }

            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(templName) {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
