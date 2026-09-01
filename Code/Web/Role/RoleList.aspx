<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="RoleList.aspx.cs" Inherits="SKT.LeanMES.Web.Role.RoleList" Title="Role List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">角色名</td>
            <td class="Field1">
                <asp:TextBox ID="txtRoleName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="RoleName" HeaderText="角色名" SortExpression="RoleName"/>
            <asp:BoundField DataField="Description" HeaderText="描述" />           
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.Common.Account.BLL.Role" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Role/RoleEdit.aspx?name=Account_RoleAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Account_RoleAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Role/RoleEdit.aspx?name=Account_RoleEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_RoleEdit %>", src: openWinUrl, width: 750, height: 400 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Role/RoleView.aspx?name=Account_RoleView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_RoleView %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function AssignPermissionToRole() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Popedom/AssignPopedom.aspx?name=Account_AssignPopedom&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_AssignPopedom %>", src: openWinUrl, width:800, height: 560 });
        }


        function AssignPermissionCopy()
        {
              var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Role/RolePopedomCopy.aspx?name=Account_AssignPopedomCopy&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_AssignPopedom %>", src: openWinUrl, width:800, height: 560 });
        }
        function AssignUserToRole() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 RoleName
            var roleName = getOneRecordCellTextByFiled("RoleName");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Role/UsersInRole.aspx?name=Account_UsersInRole&ID=" + idStr + "&RoleName=" + encodeURI(roleName.replace(/\'/g,"‘"));
            dialog({ title: "<%=Resources.Pages.Supplier_AssignUser %>", src: openWinUrl, width: 750, height: 420 });
        }
    </script>
    <script src="../Content/js/skt.utility.httphelper.js" type="text/javascript"></script>
</asp:Content>

