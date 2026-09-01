<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="StationList.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationList"
    Title="Station List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                工序
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                认证项
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtcertification" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ShortLetter" HeaderText="工序编码" HeaderStyle-Width="80px" SortExpression="Station" />
            <asp:BoundField DataField="Station" HeaderText="工序" HeaderStyle-Width="180px" SortExpression="Station" />
            <asp:BoundField DataField="OpeType" HeaderText="工序类型" HeaderStyle-Width="150px" SortExpression="OpeType" />
            <asp:BoundField DataField="StatusStr" HeaderText="状态" HeaderStyle-Width="80px" SortExpression="StatusStr" />
            <asp:BoundField DataField="ResTypeName" HeaderText="资源类型" HeaderStyle-Width="120px"
                SortExpression="ResTypeName" />
            <asp:BoundField DataField="ResName" HeaderText="默认资源" HeaderStyle-Width="180px" SortExpression="ResName" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="certification" HeaderText="认证项" />
            <asp:BoundField DataField="StationDesc" HeaderText="描述" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Station.BLL.Station"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationEdit.aspx?name=Station_StationAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Station_StationAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationEdit.aspx?name=Station_StationEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Station_StationEdit %>", src: openWinUrl, width: 750, height: 400 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationView.aspx?name=Station_StationView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Station_StationView %>", src: openWinUrl, width: 750, height: 400 });
        }

        function UpdateList(namestr) {
            $("#<%=this.txtStation.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationEdit.aspx?name=Station_StationEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "<%=Resources.Pages.Station_StationEdit %>", src: openWinUrl, width: 750, height: 400 });
        }
    </script>
</asp:Content>
