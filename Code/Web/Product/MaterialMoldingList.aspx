<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialMoldingList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.MaterialMoldingList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                产品编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>"
                HeaderStyle-Width="180px" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemsName %>"
                SortExpression="ItemName" />
            <asp:BoundField DataField="CreateByName" HeaderText="创建人"
                SortExpression="CreateByName" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang,CreateTime %>"
                SortExpression="CreateTime" />
            <asp:BoundField DataField="ModifyByName" HeaderText="修改人"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" HeaderStyle-Width="120" />
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Molding.BLL.MaterialMolding"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/MaterialMoldingEdit.aspx?name=MaterialMoldingEdit&ID=0";
            dialog({ title: mesLang("新增前加工物料"), src: openWinUrl, width: 900, height: 520 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $("#hdnOperate").val("Delete");
            $("#hdnIdString").val(idStr);
            document.forms[0].submit();
        }

        function Edit() {
            var id = getOneRecordId();
            if (id == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/MaterialMoldingEdit.aspx?name=MaterialMoldingEdit&ID=" + id;
            dialog({ title: mesLang("编辑前加工物料"), src: openWinUrl, width: 900, height: 520 });
        }

        function UpdateList(strName) {
            $("#<%=this.txtItemCode.ClientID %>").val(strName);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/MaterialMoldingEdit.aspx?name=MaterialMoldingEdit&ID=" + idStr + "&Action=Copy";
            dialog({ title: mesLang("复制前加工料"), src: openWinUrl, width: 900, height: 520 });

        }
    </script>
</asp:Content>
