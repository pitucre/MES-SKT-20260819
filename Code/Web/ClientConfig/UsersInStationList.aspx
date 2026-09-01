<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="UsersInStationList.aspx.cs" Inherits="SKT.LeanMES.Web.ClientConfig.UsersInStationList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
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
                <%= Resources.lang.Station %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStationName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="UserName" HeaderText="用户名" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="LineName" HeaderText="线别名称" />
            <asp:BoundField DataField="ResName" HeaderText="资源名称" />
            <%-- <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ClientConfig.BLL.UsersInStation"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/UsersInStationEdit.aspx?name=Client_UsersStationAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Client_UsersStationAdd %>", src: openWinUrl, width:750, height: 400 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/UsersInStationView.aspx?name=Client_UsersStationView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Client_UsersStationEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/UsersInStationEdit.aspx?name=Client_UsersStationEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Client_UsersStationEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh(namestr) {
            $("#<%=this.txtUserName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
