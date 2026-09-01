<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="MaterialSupplierConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.MaterialSupplierConfigList" %>

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
             <td class="Label2">
                物料编码
            </td>
            <td class="Field2">
                 <asp:TextBox runat="server" ID="txtItemCode" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="VendorName" HeaderText="供应商" SortExpression ="VendorName" />
            <asp:BoundField DataField="VendorCode" HeaderText="供应商编码" SortExpression ="VendorCode" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" SortExpression="ItemName" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" SortExpression="ItemCode" />
            <asp:BoundField DataField="PrintType" HeaderText="打印方式" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="ModifyBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDate" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="ModifyDate" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialConfig.BLL.MaterialSupplierConfig"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/MaterialSupplierConfigEdit.aspx?name=MaterialSupplierConfigAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.MaterialSupplierConfigAdd %>", src: openWinUrl, width: 700, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/MaterialSupplierConfigEdit.aspx?name=MaterialSupplierConfigEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.MaterialSupplierConfigEdit %>", src: openWinUrl, width: 700, height: 400 });
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
