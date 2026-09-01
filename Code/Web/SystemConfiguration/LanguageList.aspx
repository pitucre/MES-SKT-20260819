<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
    CodeBehind="LanguageList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.LanguageList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">多语言标识</td>
            <td class="Field2">
                <asp:TextBox ID="txtLanguageKey" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">未翻译</td>
            <td class="Field2">
                <asp:CheckBox ID="cbUnTranslateCN" runat="server" /><span>中文</span>
                <asp:CheckBox ID="cbUnTranslateEN" runat="server" /><span>英文</span>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" RowStyle-VerticalAlign="Middle">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="LanguageKey"  HeaderText="多语言标识" />
            <asp:BoundField DataField="CN" HeaderText="中文" />
            <asp:BoundField DataField="EN" HeaderText="英文" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="80" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" HeaderStyle-Width="150" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="80" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" HeaderStyle-Width="150" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Language.BLL.Language" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/LanguageEdit.aspx?name=System_LanguageAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.System_LanguageAdd %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/LanguageEdit.aspx?name=System_LanguageEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.System_LanguageEdit %>", src: openWinUrl, width: 600, height: 350 });
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
