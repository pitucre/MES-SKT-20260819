<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="UserAttendanceList.aspx.cs" Inherits="SKT.LeanMES.Web.UserAttendance.UserAttendanceList" Title="UserAttendance List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1"><%= Resources.lang.KeywordCheck%></td>
            <td class="Field1">
                <asp:TextBox ID="txtUserAttendanceNO2" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="用户" />
            <asp:BoundField DataField="Date" HeaderText="日期" DataFormatString="{0:yyyy-MM-dd}"/>
            <asp:BoundField DataField="Category" HeaderText="部门中心类别" />
            <asp:BoundField DataField="Department" HeaderText="部门" />
            <asp:BoundField DataField="Duty" HeaderText="职务" />
            <asp:BoundField DataField="EntryDate" HeaderText="入职日期" DataFormatString="{0:yyyy-MM-dd}"/>
            <asp:BoundField DataField="BecomeName" HeaderText="是否转正" />
            <asp:BoundField DataField="Shift" HeaderText="班次" />
            <asp:BoundField DataField="WorkDay" HeaderText="上班天数" />
            <asp:BoundField DataField="WorkTime" HeaderText="上班时间" />
            <asp:BoundField DataField="UsualTime" HeaderText="平常时间" />
            <asp:BoundField DataField="UsualOverTime" HeaderText="平常加班" />
            <asp:BoundField DataField="WeekendOverTime" HeaderText="周末加班" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateDateTime%>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$Resources:lang,CreateBy%>" />
            <asp:BoundField DataField="Remark" HeaderText="<%$Resources:lang,Remark%>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.UserAttendance.BLL.UserAttendance" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/UserAttendance/UserAttendanceEdit.aspx?name=Product_AllowanceAdd&ID=-1";
            dialog({ title: mesLang("添加"), src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/UserAttendance/UserAttendanceEdit.aspx?name=Product_AllowanceEdit&ID=" + idStr;
            dialog({ title: mesLang("修改"), src: openWinUrl, width: 600, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function openDialog() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/UserAttendance/UserAttendanceImport.aspx?name=UserAttendanceImport&ID=-1";
            dialog({ title: mesLang("导入数据"), src: openWinUrl, width: 400, height: 100 });
        }

        function Download() {
            return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"月出勤维护模板.xlsx" %>');
        }
        function downLoadField(fieldPath) {
            window.open(fieldPath);
            return null;
        }
        function Refresh() {
            document.forms[0].submit();
        }
        function UpdateList(namestr) {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

