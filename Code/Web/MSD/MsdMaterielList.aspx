<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MsdMaterielList.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdMaterielList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                产品编码
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="False" >
        <Columns>
     
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" SortExpression="ItemName" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码"  SortExpression="ItemCode" />
            <asp:BoundField DataField="MsdLevel" HeaderText="MSD等级" SortExpression="MSL" />
          
            <asp:BoundField DataField="BakeCount" HeaderText="烘烤次数" SortExpression="BakeCount" />
            <asp:BoundField DataField="FloorLife" HeaderText="暴露时长（h）" SortExpression="FloorLife" />
            <asp:BoundField DataField="Remark" HeaderText="备注" SortExpression="Remark" />
          
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MSD.BLL.MsdMateriel"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdMaterielEdit.aspx?name=Production_MsdContainerAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Production_MsdContainerAdd %>", src: openWinUrl, width: 600, height: 400, resizeable: false });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdMaterielEdit.aspx?name=Production_MsdContainerEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.MSD_MsdMaterieEdit %>", src: openWinUrl, width: 600, height: 400, resizeable: false });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList() {
            document.forms[0].submit();
        }    
    </script>
</asp:Content>