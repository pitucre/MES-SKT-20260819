<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="OSPType.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.OSPType" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">工序段类型
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOSPTypeName" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="OSPTypeName" HeaderText="工序段类型" ItemStyle-Width="150px" />
            <asp:BoundField DataField="OSPTypeTime" HeaderText="工序段时间（分）" ItemStyle-Width="100px" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" ItemStyle-Width="100px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" ItemStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
            <asp:BoundField DataField="IsSystem" HeaderText="系统内置" ItemStyle-Width="80px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.OSP"
        SelectMethod="GetOSPType" SelectCountMethod="GetCount">
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
             openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Hold/OSPTypeEdit.aspx?name=OSPTypeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.OSPTypeAdd%>", src: openWinUrl, width: 650, height: 400 });
         }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Hold/OSPTypeEdit.aspx?name=OSPTypeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.OSPTypeEdit%>", src: openWinUrl, width: 650, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
