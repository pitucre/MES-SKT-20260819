<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
    CodeBehind="SparePartsItemRelationList.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.SparePartsItemRelationList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"><%=Resources.lang.ItemCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
                 <td class="Label2"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="EqCode" HeaderText="<%$ Resources:lang, ToolCode %>" />
            <asp:BoundField DataField="PartName" HeaderText="<%$ Resources:lang, ToolName %>" />
            <asp:BoundField DataField="PartCategory" HeaderText="工具类别" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Sparepart.BLL.Sparepart" SelectMethod="GetPartsItemRelation" SelectCountMethod="GetCount">
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
          
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/SparePartsItemRelationEdit.aspx?name=EquipmentItemRelationListAdd&ID=-1&EqCode=''";
            <%--openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentItemRelationEdits.aspx?name=EquipmentItemRelationListAdd&ID=-1";--%>//类似BOM的添加模式
            dialog({ title: "新增工具与产品关系", src: openWinUrl, width: 1050, height: 500});
        }

        function Save() {

         
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 3>2 改为 EqCode
            var eqCode = getOneRecordCellTextByFiled("EqCode");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/SparePartsItemRelationEdit.aspx?name=EquipmentItemRelationListEdit&ID=" + idStr + "&EqCode=" + eqCode;
            dialog({ title: "修改工具与产品关系", src: openWinUrl, width:1050, height: 500 });
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
