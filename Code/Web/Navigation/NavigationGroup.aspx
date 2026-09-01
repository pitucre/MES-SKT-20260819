<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
     CodeBehind="NavigationGroup.aspx.cs" Inherits="SKT.LeanMES.Web.Navigation.NavigationGroup" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                导航组名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="Sequence" HeaderText="导航组序号" SortExpression="Sequence"  />
            <asp:BoundField DataField="Icon" HeaderText="导航组图标" SortExpression="Icon"  />
            <asp:BoundField DataField="NavigationgpName" HeaderText="导航组名称" SortExpression="NavigationgpName" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Navigation.BLL.Navigation"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Navigation/NavigationGroupEdit.aspx?name=NavigationGroupAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.NavigationGroupAdd %>", src: openWinUrl, width: 600, height: 400});
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Navigation/NavigationGroupEdit.aspx?name=NavigationGroupEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.NavigationGroupEdit %>", src: openWinUrl, width: 600, height: 400 });
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

        function UpdateList(Name) {
            $("#<%=this.txtName.ClientID %>").val(Name);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
