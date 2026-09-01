<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="StationTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationTypeList"
    Title="StationType List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.StationType%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStationType" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="StationType" HeaderText="<%$ Resources:lang, StationType %>"
                HeaderStyle-Width="280px" SortExpression="StationType" />
            <%--<asp:BoundField DataField="TempName" HeaderText="UI模板" HeaderStyle-Width="180px"
                SortExpression="TempId" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="190px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="StationDesc" HeaderText="<%$ Resources:lang, Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Station.BLL.StationType"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationTypeEdit.aspx?name=Station_StationTypeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Station_StationTypeAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationTypeEdit.aspx?name=Station_StationTypeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Station_StationTypeEdit %>", src: openWinUrl, width: 650, height: 400 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationTypeView.aspx?name=Station_StationTypeView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Station_StationTypeView %>", src: openWinUrl, width: 650, height: 400 });
        }

        function UpdateList(namestr) {
            $("#<%=this.txtStationType.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationTypeEdit.aspx?name=Station_StationTypeEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "<%=Resources.Buttons.COM_Copy %><%=Resources.lang.StationType %>", src: openWinUrl, width: 650, height: 400 });
        }
    </script>
</asp:Content>
