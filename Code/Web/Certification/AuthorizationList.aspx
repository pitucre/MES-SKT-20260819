<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"  CodeBehind="AuthorizationList.aspx.cs" Inherits="SKT.LeanMES.Web.Certification.AuthorizationList" %>
 <%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                用户名
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
             <td class="Label2">
                工号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEmployeeNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>           
            <td class="Label2">
                姓名
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                审核状态
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlApprovalStatus" runat="server">
                   <asp:ListItem Text="<%$ Resources:lang,Audited %>" Value="1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang,Unaudited %>" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>            
            <td class="Label2">
                锁定状态
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlLockStatus" runat="server">
                    <asp:ListItem Text="<%$ Resources:lang,Normal %>" Value="0"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang,Locked %>" Value="1"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                创建时间
            </td>
            <td class="Field2" colspan="3">
                 <%=Resources.Common.From %><asp:TextBox ID="txtCreateDateTimeStart" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                 <%=Resources.Common.To %>
                <asp:TextBox ID="txtCreateDateTimeEnd" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="UserName" HeaderText="用户名" SortExpression="UserName"/>
            <asp:BoundField DataField="EmployeeCName" HeaderText="中文名" />
            <asp:BoundField DataField="EmployeeEName" HeaderText="英文名" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="EmployeeNo" HeaderText="工号" />
            <asp:BoundField DataField="DepartNo" HeaderText="部门编号" />
            <asp:BoundField DataField="DepartName" HeaderText="部门" />
            <%--<asp:BoundField DataField="IsApproved" HeaderText="审核状态" /> 标准版没有审批流--%>
            <asp:BoundField DataField="IsLockedOut" HeaderText="锁定状态" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"  />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.UserMembership.BLL.Users"
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

        $(function () {
            $(".DateTimeBox").change(function () {
                if ($(this).val() == null || $(this).val() == "") return false;
                $(this).val(intToDate($(this).val()));
            });
        });

        function Refresh() {
            document.forms[0].submit();
        }

        // 认证授权
        function AssignUserToCert() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Certification/AuthorizationEdit.aspx?name=Account_AuthorizationEdit&ID=" + idStr;
            dialog({ title: "授权用户岗位认证", src: openWinUrl, width: 900, height: 480 });
        }

        function Edit() {
            AssignUserToCert();
        }
    </script>
</asp:Content>

