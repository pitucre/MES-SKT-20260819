<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="SerialNumberTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.SerialNumberTypeList"
    Title="SerialNumberType List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.SerialNumberRuleType %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSerialNumberType" runat="server" CssClass="TextBox"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SerialNumberType" HeaderText="<%$ Resources:lang, SerialNumberRuleType %>" HeaderStyle-Width="180px" SortExpression="SerialNumberType"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="SerialNumberDesc" HeaderText="<%$ Resources:lang, Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SerialNumber.BLL.SerialNumberType"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberTypeEdit.aspx?name=SerialNumber_SerialNumberTypeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberTypeAdd %>", src: openWinUrl, width: 500, height: 260 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberTypeEdit.aspx?name=SerialNumber_SerialNumberTypeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberTypeEdit %>", src: openWinUrl, width: 500, height: 260 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
//        function View() {
//            var idStr = getOneRecordId();
//            if (idStr == "") return false;
//            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberTypeView.aspx?name=SerialNumber_SerialNumberTypeView&ID=" + idStr;
//            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberTypeView %>", src: openWinUrl, width: 650, height: 400 });
//        }

        function UpdateList(namestr) {
            $("#<%=this.txtSerialNumberType.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
