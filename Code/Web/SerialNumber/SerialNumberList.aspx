<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="SerialNumberList.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.SerialNumberList" Title="SerialNumber List Page" ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server" ViewStateMode="Enabled">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.SerialNumberType %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlNextType" runat="server">
                </asp:DropDownList>
            </td>
            <%--<td class="Label3">
                <%= Resources.lang.Item %>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlApply" runat="server">
                    <asp:ListItem Text="<%$ Resources:lang, Choose %>" Value=""></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang, Item %>" Value="Item"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang, ItemGroup %>" Value="Item Group"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:lang, PackingCases %>" Value="Container"></asp:ListItem>
                </asp:DropDownList> 
            </td>
        </tr>
        <tr>--%>
            <td class="Label2">
                <%= Resources.lang.TypeValue %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtValue" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="Next_Number_Type" HeaderText="<%$ Resources:lang,NextNumberType %>" SortExpression="Next_Number_Type" />
            <asp:BoundField DataField="Type_Value" HeaderText="<%$ Resources:lang,TypeValue %>" SortExpression="Type_Value" />
            <asp:BoundField DataField="Revision" HeaderText="<%$ Resources:lang,Revision %>" SortExpression="Revision" />
            <asp:BoundField DataField="Prefix" HeaderText="<%$ Resources:lang,SerialNumberPrefix %>" SortExpression="Prefix" />
            <asp:BoundField DataField="Suffix" HeaderText="<%$ Resources:lang,SerialNumberSuffix %>" SortExpression="Suffix" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SerialNumber.BLL.SerialNumber"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberEdit.aspx?name=SerialNumber_SerialNumberAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberAdd %>", src: openWinUrl, width: 760, height: 520 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberEdit.aspx?name=SerialNumber_SerialNumberEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberEdit %>", src: openWinUrl, width: 760, height: 520 });
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberCopy.aspx?name=SerialNumber_SerialNumberCopy&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberCopy %>", src: openWinUrl, width: 760, height: 520 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(strValue) {
            $("#<%=this.txtValue.ClientID %>").val(strValue);
            document.forms[0].submit();
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberView.aspx?name=SerialNumber_SerialNumberView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberView %>", src: openWinUrl, width: 760, height: 420 });
        }
    </script>
</asp:Content>

