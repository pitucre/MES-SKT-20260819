<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
    CodeBehind="NavigationItem.aspx.cs" Inherits="SKT.LeanMES.Web.Navigation.NavigationItem" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                导航项名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtNavigationName" CssClass="TextBox" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Sequence" HeaderText="导航项序号" SortExpression="Sequence" />
            <asp:BoundField DataField="NavigationgpName" HeaderText="导航组名称" SortExpression="NavigationgpName" />
            <asp:BoundField DataField="NavigationName" HeaderText="导航项名称" SortExpression="NavigationName" />           
            <asp:BoundField DataField="Url" HeaderText="Url" SortExpression="Url" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Navigation.BLL.Navigationitem"
        SelectMethod="GetAll" SelectCountMethod="GetCount"  >
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Navigation/NavigationItemEdit.aspx?name=NavigationItemAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.NavigationItemAdd %>", src: openWinUrl, width: 600, height: 400 });
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Navigation/NavigationItemEdit.aspx? name=NavigationItemEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.NavigationItemEdit %>", src: openWinUrl, width: 600, height: 400 });
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

        function UpdateList(NavigationName) {
            $("#<%=this.txtNavigationName.ClientID%>").val(NavigationName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>