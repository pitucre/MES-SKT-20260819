<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="UrgentMaterialList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.UrgentMaterialList" Title="UrgentMaterial List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">产品编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">采购单</td>
            <td class="Field2">
                <asp:TextBox ID="txtPOCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">有效时间</td>
            <td class="Field2">
                <asp:TextBox CssClass="DateTimeBox" ID="txtStarDateTime" Width="140px" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtEndDateTime" Width="140px" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="POCode" HeaderText="<%$ Resources:lang, OrderFormNO %>" />
            <asp:BoundField DataField="StarDateTime" HeaderText="有效开始时间" />
            <asp:BoundField DataField="EndDateTime" HeaderText="有效截止时间" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" />
            <asp:BoundField DataField="UpdateBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="UpdateDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Material.BLL.UrgentMaterial" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        _isHms = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/UrgentMaterialEdit.aspx?name=UrgentMaterialListAdd&ID=-1";
            dialog({ title: mesLang("新增急料"), src: openWinUrl, width: 700, height: 420 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/UrgentMaterialEdit.aspx?name=UrgentMaterialListEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑急料"), src: openWinUrl, width: 700, height: 420 });
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

        //下载Excel模板
        function Download() {
            return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"急料模板.xlsx" %>');
        }
        function downLoadField(fieldPath) {
            window.open(fieldPath);
            return null;
        }

        //导入Excel
        function ImportToExcel() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/UrgentMaterialImport.aspx?name=UrgentMaterialListAdd&ID=-1";
            dialog({ title: mesLang("导入急料信息"), src: openWinUrl, width: 750, height: 460 });
        }
    </script>
</asp:Content>

