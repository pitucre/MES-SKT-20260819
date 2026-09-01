<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="SerialNumberPrefixSufList.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.SerialNumberPrefixSufList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
               规则名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSerialNumberValue" runat="server" CssClass="TextBox"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="Value" HeaderText="规则名称" HeaderStyle-Width="180px" SortExpression="Value" />
            <asp:BoundField DataField="Code" HeaderText="规则内容" HeaderStyle-Width="180px" SortExpression="Code" />
            <asp:BoundField DataField="FNType" HeaderText="规则类型" HeaderStyle-Width="180px" SortExpression="FNType" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang, Description %>" />
            <%--<asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" HeaderStyle-Width="180px" SortExpression="CreateDateTime" />--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SerialNumber.BLL.SerialNumberPerfixSuf"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberPrefixSufEdit.aspx?name=SerialNumber_PrefixSufAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.SerialNumber_PrefixSufAdd %>", src: openWinUrl, width: 500, height: 260 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberPrefixSufEdit.aspx?name=SerialNumber_PrefixSufEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_PrefixSufEdit %>", src: openWinUrl, width: 500, height: 260 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
 
        function UpdateList(namestr) {
            $("#<%=this.txtSerialNumberValue.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
