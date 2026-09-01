<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="OffLineLabelConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.OffLineLabelConfigList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                供应商编码
            </td>
            <td class="Field2">
                 <asp:TextBox runat="server" ID="txtSupplier" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="VendorCode" HeaderText="供应商编码" SortExpression ="VendorCode" />
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" SortExpression ="VendorName" />
            <asp:BoundField DataField="Delimiter" HeaderText="分隔符" SortExpression="Delimiter" />             
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />

            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>"
                SortExpression="ModifyBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>"
                SortExpression="ModifyTime" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialConfig.BLL.MaterialSupplierConfig"
        SelectMethod="GetOffLineLabelConfigList" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/OffLineLabelConfigEdit.aspx?name=OffLineLabelConfigAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.OffLineLabelConfigAdd %>", src: openWinUrl, width: 750, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/OffLineLabelConfigEdit.aspx?name=OffLineLabelConfigEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.OffLineLabelConfigEdit %>", src: openWinUrl, width: 750, height: 500 });
        }
        function EditDetail() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/OffLineLabelConfigDetailList.aspx?name=OffLineLabelConfigDetailList&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.OffLineLabelConfigDetailList %>", src: openWinUrl, width: 750, height: 500 });
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

        function UpdateList(supplierCode) {
            $("#<%=this.txtSupplier.ClientID %>").val(supplierCode);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
