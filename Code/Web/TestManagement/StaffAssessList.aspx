<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
     CodeBehind="StaffAssessList.aspx.cs" Inherits="SKT.LeanMES.Web.TestManagement.StaffAssessList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">员工姓名</td>
            <td class="Field2">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">编号</td>
            <td class="Field2">
                <asp:TextBox ID="txtEmployeeNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="员工姓名" />
            <asp:BoundField DataField="EmployeeNo" HeaderText="编号" />
            <asp:BoundField DataField="DepartName" HeaderText="部门" />
            <asp:BoundField DataField="QtyAet" HeaderText="考核季度" />
            <asp:BoundField DataField="AetGrade" HeaderText="考核等级" />
            <asp:BoundField DataField="Phone" HeaderText="电话" />
            <asp:BoundField DataField="Email" HeaderText="邮箱" />
            <asp:BoundField DataField="CreateBy" HeaderText="审核人" />
            <asp:BoundField DataField="CreateDateTimene" HeaderText="审核时间" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.TestManagement.BLL.StaffAssess" 
        SelectCountMethod="GetCount" SelectMethod="GetAll" >
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/TestManagement/StaffAssessEdit.aspx?name=Account_UserAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Account_UserAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/TestManagement/StaffAssessEdit.aspx?name=Account_UserEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_UserEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
   </script>
</asp:Content>



