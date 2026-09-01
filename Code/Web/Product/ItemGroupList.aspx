<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="ItemGroupList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemGroupList"
    Title="ItemGroup List Page" ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                产品类型名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemGroup" ClientIDMode="Static" runat="server" CssClass="TextBox"
                    patterrs="AutoComplete" source="ItemGroup" field="GroupName"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="GroupName" HeaderText="产品类型名称" HeaderStyle-Width="180px"
                SortExpression="GroupName" />
            <asp:BoundField DataField="GroupDesc" HeaderText="描述" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.ItemGroup"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemGroupEdit.aspx?name=Product_ItemGroupAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Product_ItemGroupAdd %>", src: openWinUrl, width: 515, height: 310 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemGroupEdit.aspx?name=Product_ItemGroupEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_ItemGroupEdit %>", src: openWinUrl, width: 515, height: 310 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemGroupView.aspx?name=Product_ItemGroupView&ID=" + idStr;
            dialog({ title: mesLang("查看产品"), src: openWinUrl, width: 515, height: 310 });
        }

        function UpdateList(namestr) {
            $("#txtItemGroup").val(namestr);
            document.forms[0].submit();
        }    </script>
</asp:Content>
