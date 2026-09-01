<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="ResourceTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceTypeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.ResTypeName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtResTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ResTypeName" HeaderText="<%$Resources:lang,ResTypeName %>"
                HeaderStyle-Width="260px" SortExpression="ResTypeName" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ResTypeDesc" HeaderText="<%$Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Resource.BLL.ResourceType"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceTypeEdit.aspx?name=Resource_ResourceTypeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Resource_ResourceTypeAdd %>", src: openWinUrl, width: 445, height: 280 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceTypeEdit.aspx?name=Resource_ResourceTypeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Resource_ResourceTypeEdit %>", src: openWinUrl, width: 445, height: 280 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceTypeView.aspx?name=Resource_ResourceTypeView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Resource_ResourceTypeView %>", src: openWinUrl, width: 445, height: 280 });
        }

        function UpdateList(namestr) {
            $("#<%=this.txtResTypeName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        /*复制*/
        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceTypeEdit.aspx?name=Resource_ResourceTypeEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "<%=Resources.Buttons.COM_Copy %><%=Resources.lang.ResTypeName %>", src: openWinUrl, width: 445, height: 280 });
        }
    </script>
</asp:Content>
