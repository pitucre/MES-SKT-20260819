<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="AccessoryAndItemRelation.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryAndItemRelation" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">产品编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtAccessoryItemRelationNO2" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">产品描述</td>
            <td class="Field2">
                <asp:TextBox ID="txtItemSpec" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">辅料编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtAccCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">辅料名称</td>
            <td class="Field2">
                <asp:TextBox ID="txtAccName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="MachineTypeId" HeaderText="产品描述" />
            <asp:BoundField DataField="AccessoryCode" HeaderText="<%$ Resources:lang, AccessoryCode %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, AccessoryName %>" />
            <asp:BoundField DataField="ItemSpec" HeaderText="辅料规格" />
            <asp:BoundField DataField="Value" HeaderText="<%$ Resources:lang, Value %>"  DataFormatString="{0:G0}"/>
            <asp:BoundField DataField="UnitName" HeaderText="<%$ Resources:lang, PartUnit %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang, CreateTime %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.AccessoryManagement.BLL.AccessoryItemRelation" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryAndItemRelationEdit.aspx?name=AccessoryAndItemRelationAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.AccessoryAndItemRelationAdd %>", src: openWinUrl, width: 850, height: 600 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var itemcode = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(1)").html();
            var desc = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(2)").html();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryAndItemRelationEdit.aspx?name=AccessoryAndItemRelationEdit&ID=" + idStr + "&itemcode=" + itemcode + "&desc=" + desc;
            dialog({ title: "<%=Resources.Pages.AccessoryAndItemRelationEdit %>", src: openWinUrl, width: 850, height: 600 });
        }
        function Import() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryAndItemRelationImport.aspx?name=AccessoryAndItemRelationImport";
            dialog({ title: "导入产品辅料", src: openWinUrl, width:650 , height: 400 });
        }
        function UpdateList() {
            document.forms[0].submit();
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

