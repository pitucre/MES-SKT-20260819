<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="ItemContainerList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.ItemContainerList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">产品编码
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtItemCode" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" SortExpression="ItemName" />
            <asp:BoundField DataField="Remark" HeaderText="备注" SortExpression="Remark" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="UpdateBy" HeaderText="修改人"
                SortExpression="UpdateBy" />
            <asp:BoundField DataField="UpdateDateTime" HeaderText="修改时间"
                SortExpression="UpdateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialConfig.BLL.ItemContainer"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/ItemContainerEdit.aspx?name=ItemContainerAdd&ID=-1";
            dialog({ title: "新增包装多层配置", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/ItemContainerEdit.aspx?name=ItemContainerEdit&ID=" + idStr;
            dialog({ title: "编辑包装多层配置", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            var entity = {};
            entity.ContainerIdStr = idStr;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspDeleteItemContainer", JSON.stringify(entity));
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function UpdateList(supplierCode) {
            $("#<%=this.txtItemCode.ClientID %>").val(supplierCode);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
