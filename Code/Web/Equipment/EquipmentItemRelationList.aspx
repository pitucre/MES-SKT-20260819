<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentItemRelationList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentItemRelationList" Title="EquipmentItemRelation List Page" %>
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
            <asp:BoundField DataField="ItemSpec" HeaderText="<%$ Resources:lang, PartStandard %>" />
            <asp:BoundField DataField="EqCode" HeaderText="<%$ Resources:lang, EquipmentCode %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"/>
<%--            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"/>--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Equipment.BLL.EquipmentItemRelation" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
          
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentItemRelationEdit.aspx?name=EquipmentItemRelationListAdd&ID=-1&EqCode=''";
            <%--openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentItemRelationEdits.aspx?name=EquipmentItemRelationListAdd&ID=-1";--%>//类似BOM的添加模式
            dialog({ title: "<%=Resources.Pages.EquipmentItemRelationListAdd %>", src: openWinUrl, width: 1050, height: 500});
        }

        function Save() {

         
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 3 改为 EqCode
            var eqCode = getOneRecordCellTextByFiled("EqCode");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentItemRelationEdit.aspx?name=EquipmentItemRelationListEdit&ID=" + idStr + "&EqCode=" + eqCode;
            dialog({ title: "<%=Resources.Pages.EquipmentItemRelationListAddEdit %>", src: openWinUrl, width:1050, height: 500 });
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

