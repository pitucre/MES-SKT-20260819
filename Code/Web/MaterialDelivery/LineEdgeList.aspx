<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="LineEdgeList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.LineEdgeList" %>
    <%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.EdgeName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtEdgeName" runat="server" CssClass="TextBox"></asp:TextBox> 
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="EdgeName" HeaderText="<%$ Resources:lang, EdgeName %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialDelivery.BLL.EdgeLine"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/LineEdgeEdit.aspx?name=LineEdgeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.LineEdgeAdd %>", src: openWinUrl, width: 550, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/LineEdgeEdit.aspx?name=LineEdgeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.LineEdgeEdit %>", src: openWinUrl, width: 550, height: 400 });
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
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/LineEdgeView.aspx?name=LineEdgeView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SteelMeshView %>", src: openWinUrl, width: 550, height: 400 });
        }
    </script>
</asp:Content>
