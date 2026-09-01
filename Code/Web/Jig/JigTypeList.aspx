<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="JigTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Jig.JigTypeList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"><%= Resources.lang.FeederTypeName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtJigTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.JigTypeCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtJigTypeCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="TypeName" HeaderText="<%$ Resources:lang, FeederTypeName %>" />
            <asp:BoundField DataField="TypeCode" HeaderText="<%$ Resources:lang, JigTypeCode %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Jig.BLL.JigType" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigTypeEdit.aspx?name=JigTypeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.JigTypeAdd %>", src: openWinUrl, width: 750, height: 360 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigTypeEdit.aspx?name=JigTypeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.JigTypeEdit %>", src: openWinUrl, width: 450, height: 260 });
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigTypeView.aspx?name=JigTypeView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.JigTypeView %>", src: openWinUrl, width: 450, height: 260 });
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

