<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True" CodeBehind="StationParamList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationParamList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1"><%= Resources.lang.ItemsName%></td>
            <td class="Field1">
                <asp:TextBox ID="txtStationParamName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemsName %>" />
            <asp:BoundField DataField="ItemModel" HeaderText="产品规格" />
            <asp:BoundField DataField="ItemRev" HeaderText="<%$ Resources:lang, Revision %>" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang, ItemStatus %>" />
            <asp:BoundField DataField="ItemType" HeaderText="<%$ Resources:lang, ItemType %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy %>" 
                SortExpression="CreateBy" />
              <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>" 
                SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>  
             <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy %>" 
                SortExpression="ModifyBy" />
              <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" 
                SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>   
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
        function Add() {
             
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/StationParamEdit.aspx?name=Product_StationParamAdd&ID=0";
            dialog({ title: "<%=Resources.Pages.StationParamEdit %>", src: openWinUrl, width: 800, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/StationParamEdit.aspx?name=Product_StationParamEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.StationParamEdit %>", src: openWinUrl, width: 800, height: 500 });
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/StationParamView.aspx?name=Product_StationParamView&ID=" + idStr + "&StationId=-1";
            dialog({ title: "<%=Resources.Pages.Product_StationParamView %>", src: openWinUrl, width: 650, height: 500 });
        }
        function UpdateList(paramName) {
            $("#txtStationParamName").val(paramName)
            document.forms[0].submit();
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

