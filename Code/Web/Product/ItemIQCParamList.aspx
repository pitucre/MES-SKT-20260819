<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="ItemIQCParamList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemIQCParamList" Title="ItemIQCParam List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1"><%= Resources.lang.ItemsName%></td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemsName %>" />
            <asp:BoundField DataField="ItemRev" HeaderText="<%$ Resources:lang, Revision %>" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang, ItemStatus %>" />
            <asp:BoundField DataField="ItemType" HeaderText="<%$ Resources:lang, ItemType %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Product.BLL.Item" SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        //参数配置
        function IQCParamConfig() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemIQCParamEdit.aspx?name=Product_ItemIQCParamEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_ItemIQCParamEdit %>", src: openWinUrl, width: 520, height: 390 });
        }
        
        //查看已配置参数
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemIQCParamView.aspx?name=Product_ItemIQCParamView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_ItemIQCParamView %>", src: openWinUrl, width: 520, height: 390 });
        }

        function Edit() {
            IQCParamConfig();
        }

        function UpdateList(paramName) {
            $("#txtItemName").val(paramName)
            document.forms[0].submit();
        } 

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

