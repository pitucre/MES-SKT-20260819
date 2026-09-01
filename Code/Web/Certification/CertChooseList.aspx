<%@ Page Language="C#" MasterPageFile="~/Masters/ChooseListMaster.master" AutoEventWireup="true"
 CodeBehind="CertChooseList.aspx.cs" Inherits="SKT.LeanMES.Web.Certification.CertChooseList" %>
 <%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                认证名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtCert" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="Certification" HeaderText="认证名称" />
            <asp:BoundField DataField="Description" HeaderText="<%$Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Certification.BLL.Certification"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="search"/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value=""/>
    <script type="text/javascript">
        var isMultiple = true;
    </script>
</asp:Content>




